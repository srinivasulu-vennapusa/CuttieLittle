
//  ShipmentReturnNew.m
//  OmniRetailer
//
//  Created by Technolabs on 12/7/17.
//
//

#import "ShipmentReturnNew.h"
#import "OmniHomePage.h"

@interface ShipmentReturnNew ()

@end

@implementation ShipmentReturnNew


//this properties are used for generating the sounds....
@synthesize soundFileURLRef,soundFileObject;
@synthesize selectIndex;

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
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    
    //creating the stockRequestView which will displayed completed Screen.......
    shipmentReturnView = [[UIView alloc] init];
    shipmentReturnView.backgroundColor = [UIColor blackColor];
    shipmentReturnView.layer.borderWidth = 1.0f;
    shipmentReturnView.layer.cornerRadius = 10.0f;
    shipmentReturnView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
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
    
    //creation of customTextField.......
    fromLocationTxt = [[CustomTextField alloc] init];
    fromLocationTxt.placeholder = NSLocalizedString(@"from_location",nil);
    fromLocationTxt.delegate = self;
    [fromLocationTxt awakeFromNib];
    fromLocationTxt.text = presentLocation;
    fromLocationTxt.userInteractionEnabled = NO;
    
    poReferenceTxt = [[CustomTextField alloc] init];
    poReferenceTxt.placeholder = NSLocalizedString(@"po_reference",nil);
    poReferenceTxt.delegate = self;
    [poReferenceTxt awakeFromNib];
    
    supplierShipmntRefTxt = [[CustomTextField alloc] init];
    supplierShipmntRefTxt.placeholder = NSLocalizedString(@"suppier_shipment_reference",nil);
    supplierShipmntRefTxt.delegate = self;
    [supplierShipmntRefTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [supplierShipmntRefTxt awakeFromNib];
    
    shippedOnTxt = [[CustomTextField alloc] init];
    shippedOnTxt.placeholder = NSLocalizedString(@"shipment_on",nil);
    shippedOnTxt.delegate = self;
    shippedOnTxt.userInteractionEnabled = NO;
    [shippedOnTxt awakeFromNib];
    
    shippedByTxt = [[CustomTextField alloc] init];
    shippedByTxt.placeholder = NSLocalizedString(@"shipped_by",nil);
    shippedByTxt.delegate = self;
    [shippedByTxt awakeFromNib];
    
    shipmentModeTxt = [[CustomTextField alloc] init];
    shipmentModeTxt.placeholder = NSLocalizedString(@"shipment_mode",nil);
    shipmentModeTxt.delegate = self;
    shipmentModeTxt.userInteractionEnabled = NO;
    [shipmentModeTxt awakeFromNib];
    
    shipmentCarrierTxt = [[CustomTextField alloc] init];
    shipmentCarrierTxt.placeholder = NSLocalizedString(@"shipment_carrier",nil);
    shipmentCarrierTxt.delegate = self;
    [shipmentCarrierTxt awakeFromNib];
    
    inVoiceNoTxt = [[CustomTextField alloc] init];
    inVoiceNoTxt.placeholder = NSLocalizedString(@"invoice_number",nil);
    inVoiceNoTxt.delegate = self;
    [inVoiceNoTxt awakeFromNib];
    
    reasonTxt = [[CustomTextField alloc] init];
    reasonTxt.placeholder = NSLocalizedString(@"reason",nil);
    reasonTxt.delegate = self;
    reasonTxt.userInteractionEnabled = NO;
    [reasonTxt awakeFromNib];
    
    // getting present time ..
    NSDate *time = [NSDate date];
    NSDateFormatter *hours = [[NSDateFormatter alloc] init];
    hours.dateFormat = @" HH:mm:ss";
    NSString* currentTime = [hours stringFromDate:time];
    
    
    returnTimeTxt = [[CustomTextField alloc] init];
    returnTimeTxt.placeholder = NSLocalizedString(@"return_time",nil);
    returnTimeTxt.delegate = self;
    returnTimeTxt.text = currentTime;
    returnTimeTxt.userInteractionEnabled = NO;
    [returnTimeTxt awakeFromNib];
    
    
    // getting present date  ..
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [f stringFromDate:today];
    
    
    returnDateTxt = [[CustomTextField alloc] init];
    returnDateTxt.placeholder = NSLocalizedString(@"returnDate",nil);
    returnDateTxt.delegate = self;
    returnDateTxt.text = currentdate;
    returnDateTxt.userInteractionEnabled = NO;
    [returnDateTxt awakeFromNib];
    
    returnedByTxt = [[CustomTextField alloc] init];
    returnedByTxt.placeholder = NSLocalizedString(@"returnedBy",nil);
    returnedByTxt.delegate = self;
    returnedByTxt.text = firstName;
    returnedByTxt.userInteractionEnabled = NO;
    [returnedByTxt awakeFromNib];
    
    toSupplierTxt = [[CustomTextField alloc] init];
    toSupplierTxt.placeholder = NSLocalizedString(@"to_supplier",nil);
    toSupplierTxt.delegate = self;
    toSupplierTxt.userInteractionEnabled = NO;
    [toSupplierTxt awakeFromNib];
    
    
    supplierAddressTxt = [[CustomTextField alloc] init];
    supplierAddressTxt.placeholder = NSLocalizedString(@"supplier_address",nil);
    supplierAddressTxt.delegate = self;
    [supplierAddressTxt awakeFromNib];
    
    streetLocalityTxt = [[CustomTextField alloc] init];
    streetLocalityTxt.placeholder = NSLocalizedString(@"street_locality",nil);
    streetLocalityTxt.delegate = self;
    [streetLocalityTxt awakeFromNib];
    
    contactNoTxt = [[CustomTextField alloc] init];
    contactNoTxt.placeholder = NSLocalizedString(@"mobile_number",nil);
    contactNoTxt.delegate = self;
    [contactNoTxt awakeFromNib];
    
    //Allocation of Search Items Text....
    
    searchItemsTxt = [[CustomTextField alloc] init];
    searchItemsTxt.placeholder = NSLocalizedString(@"Search_Sku_Here",nil);
    searchItemsTxt.delegate = self;
    searchItemsTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemsTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItemsTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItemsTxt.textColor = [UIColor blackColor];
    searchItemsTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemsTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [searchItemsTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //Allocation of UIButton..
    
    UIImage * dropDownImg  = [UIImage imageNamed:@"arrow_1.png"];
    UIImage * calendarImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * selectLoctn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectLoctn setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [selectLoctn addTarget:self action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    selectLoctn.hidden = YES;
    
    UIButton * selectReason = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectReason setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [selectReason addTarget:self action:@selector(populateReturnResaon:) forControlEvents:UIControlEventTouchDown];
    
    selectVendor = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectVendor setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [selectVendor addTarget:self action:@selector(populateVendorIds:) forControlEvents:UIControlEventTouchDown];
    
    UIButton * selectShipment = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectShipment setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [selectShipment addTarget:self action:@selector(populateShipmentModes:) forControlEvents:UIControlEventTouchDown];
    
    UIButton * selectReturnDate = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectReturnDate setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [selectReturnDate addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    UIButton * selectShippedDate = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectShippedDate setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [selectShippedDate addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    UIImage * productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
    selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of ShipmentReturn ScrollView...
    shipmentReturnScrollView = [[UIScrollView alloc]init];
    //shipmentReturnScrollView.backgroundColor = [UIColor lightGrayColor];
    
    /*creation of UILable's*/
    sNoLbl  = [[CustomLabel alloc] init];
    [sNoLbl awakeFromNib];
    
    skuIdLbl  = [[CustomLabel alloc] init];
    [skuIdLbl awakeFromNib];
    
    descLbl  = [[CustomLabel alloc] init];
    [descLbl awakeFromNib];
    
    eanLbl  = [[CustomLabel alloc] init];
    [eanLbl awakeFromNib];
    
    reasonForReturnLbl  = [[CustomLabel alloc] init];
    [reasonForReturnLbl awakeFromNib];
    
    uomLbl  = [[CustomLabel alloc] init];
    [uomLbl awakeFromNib];
    
    receivedQtyLbl  = [[CustomLabel alloc] init];
    [receivedQtyLbl awakeFromNib];
    
    priceLbl  = [[CustomLabel alloc] init];
    [priceLbl awakeFromNib];
    
    valueLbl  = [[CustomLabel alloc] init];
    [valueLbl awakeFromNib];
    
    returnQtyLbl  = [[CustomLabel alloc] init];
    [returnQtyLbl awakeFromNib];
    
    actionLbl  = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    //UITABLEVIEW'S FOR SEARCHING THE SKUIDS AND ADDING SKU BASED ITEM TO THE CART...
    
    //Allocation of skListTable...
    skListTable = [[UITableView alloc] init];
    
    //Allocation of locationTable..
    locationTable = [[UITableView alloc]init];
    
    //Allocation of shipmentModeTable
    returnReasonTable = [[UITableView alloc]init];
    
    //Allocation of shipmentModeTable
    vendorIdsTable = [[UITableView alloc]init];
    
    //Allocation of grnReceiptIdsTable
    
    grnReceiptIdsTable = [[UITableView alloc]init];
    
    //Allocation of shipmentModeTable
    shipmentModeTable = [[UITableView alloc]init];
    
    // Table for storing the items ..
    cartTable = [[UITableView alloc] init];
    cartTable.backgroundColor = [UIColor blackColor];
    cartTable.dataSource = self;
    cartTable.delegate = self;
    cartTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cartTable.userInteractionEnabled = TRUE;
    
    //Allocation of submitBtn
    submitBtn = [[UIButton alloc] init] ;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    submitBtn.tag = 4;
    
    //Allocation of cancelBtn
    cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.backgroundColor = [UIColor grayColor];
    //[cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // UILabels for Displaying Totals In Footer....
    
    receivedQtyValueLbl = [[UILabel alloc] init];
    receivedQtyValueLbl.layer.cornerRadius = 5;
    receivedQtyValueLbl.layer.masksToBounds = YES;
    receivedQtyValueLbl.backgroundColor = [UIColor blackColor];
    receivedQtyValueLbl.layer.borderWidth = 2.0f;
    receivedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    receivedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    receivedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalValueLbl = [[UILabel alloc] init];
    totalValueLbl.layer.cornerRadius = 5;
    totalValueLbl.layer.masksToBounds = YES;
    totalValueLbl.backgroundColor = [UIColor blackColor];
    totalValueLbl.layer.borderWidth = 2.0f;
    totalValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    totalValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    totalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    returnQtyValueLbl = [[UILabel alloc] init];
    returnQtyValueLbl.layer.cornerRadius = 5;
    returnQtyValueLbl.layer.masksToBounds = YES;
    returnQtyValueLbl.backgroundColor = [UIColor blackColor];
    returnQtyValueLbl.layer.borderWidth = 2.0f;
    returnQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    returnQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    returnQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    receivedQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    totalValueLbl.textAlignment       = NSTextAlignmentCenter;
    returnQtyValueLbl.textAlignment   = NSTextAlignmentCenter;
    
    receivedQtyValueLbl.text = @"0.00";
    totalValueLbl.text       = @"0.00";
    returnQtyValueLbl.text   = @"0.00";
    
    //creation of price view..
    priceListTable = [[UITableView alloc] init];
    priceListTable.backgroundColor = [UIColor blackColor];
    priceListTable.dataSource = self;
    priceListTable.delegate = self;
    priceListTable.layer.cornerRadius = 3;
    
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

    
    //populating text into the textFields,labels, placeholders && buttons titles....
    
    @try {
        
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        headerNameLbl.text = NSLocalizedString(@"new_shipment_return", nil);
        
        
        sNoLbl.text = NSLocalizedString(@"S_NO", nil);
        skuIdLbl.text = NSLocalizedString(@"sku_id", nil);
        descLbl.text = NSLocalizedString(@"item_desc", nil);
        eanLbl.text = NSLocalizedString(@"ean", nil);
        reasonForReturnLbl.text = NSLocalizedString(@"return_reason", nil);
        uomLbl.text = NSLocalizedString(@"uom", nil);
        receivedQtyLbl.text = NSLocalizedString(@"recved_qty", nil);
        priceLbl.text = NSLocalizedString(@"price", nil);
        valueLbl.text = NSLocalizedString(@"value", nil);
        returnQtyLbl.text = NSLocalizedString(@"return_qty", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        //priceList Labels...
        descLabl.text = NSLocalizedString(@"description", nil);
        mrpLbl.text = NSLocalizedString(@"mrp_rps", nil);
        priceLabl.text = NSLocalizedString(@"price", nil);
        
        [submitBtn setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
        
    } @catch (NSException *exception) {
        
    }
    
    if (currentOrientation==UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            float textFieldWidth  = 200;
            float textFieldHeight = 40;
            float horizontalGap   = 65;
            
            
            //setting frame for the main view....
            shipmentReturnView.frame = CGRectMake(2,70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            //setting frame for the headerNameLbl....
            headerNameLbl.frame = CGRectMake( 0, 0, shipmentReturnView.frame.size.width, 45);
            
            // Column 1...
            fromLocationTxt.frame = CGRectMake(10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, textFieldWidth, textFieldHeight);
            
            poReferenceTxt.frame  = CGRectMake(fromLocationTxt.frame.origin.x, fromLocationTxt.frame.origin.y + fromLocationTxt.frame.size.height + 10, textFieldWidth, textFieldHeight);
            
            supplierShipmntRefTxt.frame = CGRectMake(fromLocationTxt.frame.origin.x, poReferenceTxt.frame.origin.y+ poReferenceTxt.frame.size.height + 10 ,textFieldWidth, textFieldHeight);
            
            shippedOnTxt.frame = CGRectMake(fromLocationTxt.frame.origin.x, supplierShipmntRefTxt.frame.origin.y+ supplierShipmntRefTxt.frame.size.height + 10 ,textFieldWidth, textFieldHeight);
            
            // Column 2...
            shippedByTxt.frame       = CGRectMake(fromLocationTxt.frame.origin.x + fromLocationTxt.frame.size.width + horizontalGap, fromLocationTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            shipmentModeTxt.frame    = CGRectMake(shippedByTxt.frame.origin.x,poReferenceTxt.frame.origin.y,textFieldWidth ,textFieldHeight);
            
            shipmentCarrierTxt.frame = CGRectMake(shippedByTxt.frame.origin.x, supplierShipmntRefTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            inVoiceNoTxt.frame = CGRectMake(shippedByTxt.frame.origin.x, shippedOnTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            //Column 3...
            reasonTxt.frame     = CGRectMake(shippedByTxt.frame.origin.x + shippedByTxt.frame.size.width + horizontalGap, fromLocationTxt.frame.origin.y, textFieldWidth ,textFieldHeight);
            
            returnTimeTxt.frame = CGRectMake(reasonTxt.frame.origin.x, shipmentModeTxt.frame.origin.y, textFieldWidth - 20,textFieldHeight);
            
            returnDateTxt.frame = CGRectMake(reasonTxt.frame.origin.x, shipmentCarrierTxt.frame.origin.y, textFieldWidth - 20, textFieldHeight);
            
            returnedByTxt.frame = CGRectMake(reasonTxt.frame.origin.x, shippedOnTxt.frame.origin.y, textFieldWidth ,textFieldHeight);
            
            //Column 4...
            toSupplierTxt.frame = CGRectMake(reasonTxt.frame.origin.x + reasonTxt.frame.size.width + horizontalGap + 5, fromLocationTxt.frame.origin.y, textFieldWidth ,textFieldHeight);
            
            supplierAddressTxt.frame = CGRectMake(toSupplierTxt.frame.origin.x, returnTimeTxt.frame.origin.y, textFieldWidth,textFieldHeight);
            
            streetLocalityTxt.frame  = CGRectMake(toSupplierTxt.frame.origin.x, returnDateTxt.frame.origin.y, textFieldWidth,textFieldHeight);
            
            contactNoTxt.frame = CGRectMake(toSupplierTxt.frame.origin.x, returnedByTxt.frame.origin.y, textFieldWidth,textFieldHeight);
            
            
            //Changes made as per the freshword documentation...
            selectLoctn.frame = CGRectMake((fromLocationTxt.frame.origin.x+fromLocationTxt.frame.size.width-45), fromLocationTxt.frame.origin.y - 8,  55, 60);
            
            selectReason.frame = CGRectMake((reasonTxt.frame.origin.x+reasonTxt.frame.size.width-45), reasonTxt.frame.origin.y - 8,  55, 60);
            
            
            selectShipment.frame = CGRectMake((shipmentModeTxt.frame.origin.x+shipmentModeTxt.frame.size.width-45), shipmentModeTxt.frame.origin.y - 8,  55, 60);
            
            selectVendor.frame = CGRectMake((toSupplierTxt.frame.origin.x+toSupplierTxt.frame.size.width-45), toSupplierTxt.frame.origin.y - 8,  55, 60);
            
            
            selectReturnDate.frame = CGRectMake((returnDateTxt.frame.origin.x+returnDateTxt.frame.size.width-45), returnDateTxt.frame.origin.y+2, 40, 35);
            
            selectShippedDate.frame = CGRectMake((shippedOnTxt.frame.origin.x+shippedOnTxt.frame.size.width-45), shippedOnTxt.frame.origin.y+2, 40, 35);
            
            
            //Frame for the SearchItemsText...
            
            searchItemsTxt.frame = CGRectMake(fromLocationTxt.frame.origin.x, shippedOnTxt.frame.origin.y+shippedOnTxt.frame.size.height+15, toSupplierTxt.frame.origin.x+toSupplierTxt.frame.size.width-(fromLocationTxt.frame.origin.x+80), 40);
            
            //Frame for the category Selection...
            selectCategoriesBtn.frame = CGRectMake((searchItemsTxt.frame.origin.x+searchItemsTxt.frame.size.width + 5),searchItemsTxt.frame.origin.y,75,searchItemsTxt.frame.size.height);
            
            //Frame for the UIScroll View....
            
            //Frame for the StockReturnScrollView....
            shipmentReturnScrollView.frame = CGRectMake(searchItemsTxt.frame.origin.x,searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height +5,searchItemsTxt.frame.size.width+150,330);
            
            //Frame for the CustomLabels
            sNoLbl.frame = CGRectMake(0,0, 45, 35);
            
            skuIdLbl.frame = CGRectMake((sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 90, sNoLbl.frame.size.height);
            
            descLbl.frame = CGRectMake((skuIdLbl.frame.origin.x + skuIdLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 155, sNoLbl.frame.size.height);
            
            eanLbl.frame = CGRectMake((descLbl.frame.origin.x + descLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 110, sNoLbl.frame.size.height);
            
            reasonForReturnLbl.frame = CGRectMake((eanLbl.frame.origin.x + eanLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 130, sNoLbl.frame.size.height);
            
            uomLbl.frame = CGRectMake((reasonForReturnLbl.frame.origin.x + reasonForReturnLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 60, sNoLbl.frame.size.height);
            
            receivedQtyLbl.frame = CGRectMake((uomLbl.frame.origin.x + uomLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, sNoLbl.frame.size.height);
            
            priceLbl.frame = CGRectMake((receivedQtyLbl.frame.origin.x + receivedQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, sNoLbl.frame.size.height);
            
            valueLbl.frame = CGRectMake((priceLbl.frame.origin.x + priceLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, sNoLbl.frame.size.height);
            
            returnQtyLbl.frame = CGRectMake((valueLbl.frame.origin.x + valueLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 90, sNoLbl.frame.size.height);
            
            actionLbl.frame = CGRectMake((returnQtyLbl.frame.origin.x + returnQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 60, sNoLbl.frame.size.height);
            
            // frame for the UIButtons...
            submitBtn.frame = CGRectMake(searchItemsTxt.frame.origin.x,shipmentReturnView.frame.size.height-45,140,40);
            
            cancelBtn.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+20,submitBtn.frame.origin.y,140,40);
            
            receivedQtyValueLbl.frame = CGRectMake(receivedQtyLbl.frame.origin.x+7,cancelBtn.frame.origin.y, receivedQtyLbl.frame.size.width,receivedQtyLbl.frame.size.height);
            
            totalValueLbl.frame = CGRectMake(valueLbl.frame.origin.x+7,cancelBtn.frame.origin.y, valueLbl.frame.size.width,valueLbl.frame.size.height);
            
            returnQtyValueLbl.frame = CGRectMake(returnQtyLbl.frame.origin.x+7,cancelBtn.frame.origin.y, returnQtyLbl.frame.size.width,returnQtyLbl.frame.size.height);
            
            // frame for the cartTable...
            
            cartTable.frame = CGRectMake(0,sNoLbl.frame.origin.y+sNoLbl.frame.size.height+5,actionLbl.frame.origin.x+actionLbl.frame.size.width-(sNoLbl.frame.origin.x-80),shipmentReturnScrollView.frame.size.height-(sNoLbl.frame.origin.y+sNoLbl.frame.size.height));
            
            
            //frame for the Transparent view:
            
            transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            priceView.frame = CGRectMake(200, 400, 490,300);
            
            descLabl.frame = CGRectMake(0,5,180, 35);
            mrpLbl.frame = CGRectMake(descLabl.frame.origin.x+descLabl.frame.size.width+2,descLabl.frame.origin.y, 150, 35);
            priceLabl.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, descLabl.frame.origin.y, 150, 35);
            
            priceListTable.frame = CGRectMake(descLabl.frame.origin.x,descLabl.frame.origin.y+descLabl.frame.size.height+5, priceLabl.frame.origin.x+priceLabl.frame.size.width - (descLabl.frame.origin.x), priceView.frame.size.height - (descLabl.frame.origin.y + descLabl.frame.size.height+20));
            
            closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38, 40, 40);

        }
        
        else {
            
            // DO CODING FOR IPHONE....
        }
        
    }
    
    
    //ADDING SUB VIEWS TO THE SHIPMENTRETURN VIEW
    [shipmentReturnView addSubview:headerNameLbl];
    
    [shipmentReturnView addSubview:fromLocationTxt];
    [shipmentReturnView addSubview:poReferenceTxt];
    [shipmentReturnView addSubview:supplierShipmntRefTxt];
    [shipmentReturnView addSubview:shippedOnTxt];
    
    [shipmentReturnView addSubview:shippedByTxt];
    [shipmentReturnView addSubview:shipmentModeTxt];
    [shipmentReturnView addSubview:shipmentCarrierTxt];
    [shipmentReturnView addSubview:inVoiceNoTxt];
    
    [shipmentReturnView addSubview:reasonTxt];
    [shipmentReturnView addSubview:returnTimeTxt];
    [shipmentReturnView addSubview:returnDateTxt];
    [shipmentReturnView addSubview:returnedByTxt];
    
    [shipmentReturnView addSubview:toSupplierTxt];
    [shipmentReturnView addSubview:supplierAddressTxt];
    [shipmentReturnView addSubview:streetLocalityTxt];
    [shipmentReturnView addSubview:contactNoTxt];
    
    [shipmentReturnView addSubview:selectLoctn];
    [shipmentReturnView addSubview:selectReason];
    [shipmentReturnView addSubview:selectShipment];
    [shipmentReturnView addSubview:selectVendor];
    [shipmentReturnView addSubview:selectReturnDate];
    [shipmentReturnView addSubview:selectShippedDate];
    
    
    
    [shipmentReturnView addSubview:searchItemsTxt];
    [shipmentReturnView addSubview:selectCategoriesBtn];
    
    [shipmentReturnView addSubview:shipmentReturnScrollView];
    
    [shipmentReturnScrollView addSubview:sNoLbl];
    [shipmentReturnScrollView addSubview:skuIdLbl];
    [shipmentReturnScrollView addSubview:descLbl];
    [shipmentReturnScrollView addSubview:eanLbl];
    [shipmentReturnScrollView addSubview:reasonForReturnLbl];
    [shipmentReturnScrollView addSubview:uomLbl];
    [shipmentReturnScrollView addSubview:receivedQtyLbl];
    [shipmentReturnScrollView addSubview:priceLbl];
    [shipmentReturnScrollView addSubview:valueLbl];
    [shipmentReturnScrollView addSubview:returnQtyLbl];
    [shipmentReturnScrollView addSubview:actionLbl];
    [shipmentReturnScrollView addSubview: cartTable];
    
    [shipmentReturnView addSubview:submitBtn];
    [shipmentReturnView addSubview:cancelBtn];
    
    [shipmentReturnView addSubview: receivedQtyValueLbl];
    [shipmentReturnView addSubview: totalValueLbl];
    [shipmentReturnView addSubview: returnQtyValueLbl];
    
    //adding price list view for the Stock Return View...
    
    [priceView addSubview:descLabl];
    [priceView addSubview:mrpLbl];
    [priceView addSubview:priceLabl];
    
    [priceView addSubview:priceListTable];
    
    [transparentView addSubview:closeBtn];
    
    [transparentView addSubview:priceView];
    
    //Adding shipmentReturnView for the main view..
    [self.view addSubview:shipmentReturnView];
    
    [self.view addSubview:transparentView];
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
    
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    
    submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    cancelBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    
    //used for identification propous....
    selectReturnDate.tag = 2;
    selectShippedDate.tag = 4;
    
    
}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidLoad.......
 * @date         12/12/2017
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
    
    //calling super Method...
    [super viewDidAppear:YES];
    
    @try {
        if (rawMaterialDetails == nil)
            rawMaterialDetails = [NSMutableArray new];
        
    } @catch (NSException * exception) {
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        if(locationArr == nil)
            locationArr = [NSMutableArray new];
        
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
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @finally {
        
    }
}



/**
 * @description  here we are calling the getSuppliers of the  customer.......
 * @date         28/09/2016
 * @method       getSuppliers
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getSuppliers:(NSString*)supplierCodeStr {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        if(vendorIdsArray == nil)
            
            vendorIdsArray = [NSMutableArray new];
        
        NSMutableDictionary * vendorIdsDictionary = [[NSMutableDictionary alloc]init];
        
        [vendorIdsDictionary setValue:[RequestHeader getRequestHeader ] forKey:REQUEST_HEADER];
        
        [vendorIdsDictionary setValue:NEGATIVE_ONE forKey:PAGE_NO];
        
        if ((supplierShipmntRefTxt.text).length != 0  || (toSupplierTxt.text).length != 0 ) {
            
            [vendorIdsDictionary setValue:supplierCodeStr forKey:SUPPLIER_CODE];
        }
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:vendorIdsDictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.supplierServiceSvcDelegate = self;
        [webServiceController  getSupplierDetailsData:salesReportJsonString];
        
    }
    @catch (NSException * exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    
}

/**
 * @description  Forming the Request String
 * @date         11/12/2017
 * @method       getOutletGrnReceiptIds
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getOutletGrnReceiptIds:(NSString*)searchStr {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        if(grnReceiptIdsArray == nil ){
            
            grnReceiptIdsArray = [NSMutableArray new];
        }
        else if(grnReceiptIdsArray.count ){
            
            [grnReceiptIdsArray removeAllObjects];
        }
        
        NSMutableDictionary * grnReceiptIdsDic = [[NSMutableDictionary alloc] init];
        
        grnReceiptIdsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        grnReceiptIdsDic[START_INDEX] = NEGATIVE_ONE;
        grnReceiptIdsDic[SEARCH_CRITERIA] = searchStr;
        grnReceiptIdsDic[LOCATION] = presentLocation;
        
        grnReceiptIdsDic[ITEMS_REQUIRED] = [NSNumber numberWithBool:true];
        grnReceiptIdsDic[DEF_SUPPLIER_QTY] = [NSNumber numberWithBool:false];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:grnReceiptIdsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletGRNServiceDelegate = self;
        [webServiceController getOutletGrnReceiptIDs:salesReportJsonString];
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}






/**
 * @description  here we are calling the getPurchaseOrders of the  customer.......
 * @date         28/09/2016
 * @method       callingGetStockReceiptDetails
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGrnReceiptDetails:(NSString *)GRNReferenceNumber{
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        if(grnReceiptDetailsArray == nil)
            
            grnReceiptDetailsArray = [NSMutableArray new];
        
        NSMutableDictionary * receiptDetailsDic = [[NSMutableDictionary alloc] init];
        
        receiptDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        receiptDetailsDic[SEARCH_CRITERIA] = GRNReferenceNumber;
        receiptDetailsDic[START_INDEX] = @0;
        receiptDetailsDic[ITEMS_REQUIRED] = [NSNumber numberWithBool:true ];
        receiptDetailsDic[DEF_SUPPLIER_QTY] = [NSNumber numberWithBool:false ];
        receiptDetailsDic[kLocation] = presentLocation;

        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:receiptDetailsDic options:0 error:&err_];
        NSString * receiptDetailsStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController  * webServiceController = [WebServiceController new];
        webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
        [webServiceController   getWarehouseGoodsReceiptNoteWithDetails:receiptDetailsStr];
        
    } @catch (NSException *exception) {
        
        NSLog(@"-----exception while callign getGrnDetails-----%@",exception);
    }
    
}


/**
 * @description  here we are calling searchSku.......
 * @date         11/12/2017..
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
 * @description  this method is used to call skuList.......
 * @date         11/12/2017
 * @method       callRawMaterialDetails
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 *
 * @modified BY
 * @reason
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
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request",nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
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
            [categoriesTable reloadData];
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
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:locationWiseCategoryDictionary options: 0 error: &err];
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
            priceListDic[@"categoryList"] = catArr;
            priceListDic[@"requiredRecords"] = @"0";
            priceListDic[@"notForDownload"] = [NSNumber numberWithBool:true];
            priceListDic[@"latestCampaigns"] = [NSNumber numberWithBool:false];
            priceListDic[@"isEffectiveDateConsidered"] = [NSNumber numberWithBool:false];
            priceListDic[@"isApplyCampaigns"] = [NSNumber numberWithBool:false];
            priceListDic[@"boneyardSummaryFlag"] = [NSNumber numberWithBool:false];
            priceListDic[@"barcodeType"] = [NSNumber numberWithBool:false];
            priceListDic[@"zeroStockBilCheck"] = [NSNumber numberWithBool:false];
            priceListDic[@"zeroStockCheckAtOutletLevel"] = [NSNumber numberWithBool:false];
            
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
 * @description  Forming the Request String To Generate a shipment Return
 * @date         02/01/2018
 * @method       submitButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)submitButtonPressed:(UIButton *)sender {
    //Play Audio for button touch...
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        
        if ( rawMaterialDetails.count == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_add_items_to_the_cart",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
        }
        
        
        else if ( (fromLocationTxt.text).length == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_Location",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        
        else if ( (shippedOnTxt.text).length == 0) {
            
            UIButton * locDeliveryBtn  = [[UIButton alloc]init];
            locDeliveryBtn.tag = 4;
            
            [self showCalenderInPopUp:locDeliveryBtn];
        }
        
        else if ((shipmentModeTxt.text).length == 0)  {
            
            [self populateShipmentModes:sender];
            
        }
        
        else {
            
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            
            submitBtn.userInteractionEnabled = NO;
            //upto here on 02/05/2018....
            
            [HUD setHidden:NO];
            
            NSMutableDictionary * createShipmentReturnDic = [[NSMutableDictionary alloc] init];
            
            [createShipmentReturnDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
            [createShipmentReturnDic setValue:presentLocation forKey:kFromLocation];
            [createShipmentReturnDic setValue:supplierIdStr forKey:SUPPLIER_ID];
            [createShipmentReturnDic setValue:presentLocation forKey:SUPPLIER_LOCATION];
            [createShipmentReturnDic setValue:streetLocalityTxt.text forKey:SUPPLIER_DESCRIPTION];
            [createShipmentReturnDic setValue:supplierShipmntRefTxt.text forKey:SUPPLIER_SHIPMENT_REF];
            [createShipmentReturnDic setValue:shipmentModeTxt.text forKey:TRANSPORT_MODE];
            [createShipmentReturnDic setValue:reasonTxt.text forKey:RETURN_REASON];
            [createShipmentReturnDic setValue:EMPTY_STRING forKey:RETURN_COMMENTS];
            
            [createShipmentReturnDic setValue:poReferenceTxt.text forKey:Po_REF];
            [createShipmentReturnDic setValue:SUBMITTED forKey:STATUS];
            [createShipmentReturnDic setValue:firstName forKey:kUserName];
            [createShipmentReturnDic setValue:roleName forKey:USER_ROLE];
            [createShipmentReturnDic setValue:returnedByTxt.text forKey:kReturnBy];
            [createShipmentReturnDic setValue:shippedByTxt.text forKey:KShippedBy];
            [createShipmentReturnDic setValue:shipmentCarrierTxt.text forKey:kShipmentCarrier];
            [createShipmentReturnDic setValue:supplierAddressTxt.text forKey:SUPPLIER_ADDRESS];
            [createShipmentReturnDic setValue:EMPTY_STRING forKey:REMARKS];
            [createShipmentReturnDic setValue:EMPTY_STRING forKey:ACTION_REQUIRED];
            [createShipmentReturnDic setValue:toSupplierTxt.text forKey:SUPPLIER_NAME];
            [createShipmentReturnDic setValue:EMPTY_STRING forKey:PURCHASE_STOCK_RETURN_REF];
            [createShipmentReturnDic setValue:contactNoTxt.text forKey:SUPPLIER_CONTACT_NO];
            [createShipmentReturnDic setValue:inVoiceNoTxt.text forKey:INVOICE_NO];
            
            [createShipmentReturnDic setValue:@0.0f forKey:SHIPMENT_CHARGES];
            [createShipmentReturnDic setValue:@0.0f forKey:GOODS_VAL];
            [createShipmentReturnDic setValue:@0.0f forKey:TAX_VALUE];
            [createShipmentReturnDic setValue:@((totalValueLbl.text).floatValue) forKey:SUB_TOTAL];
            [createShipmentReturnDic setValue:@((totalValueLbl.text).floatValue) forKey:TOTAL];
            
            NSString * returnDateStr = returnDateTxt.text;
            NSString * shippedOnStr = shippedOnTxt.text;
            
            if(shippedOnStr.length > 1)
                
                shippedOnStr = [NSString stringWithFormat:@"%@%@", shippedOnTxt.text,@" 00:00:00"];
            
            if (returnDateStr.length >1) {
                
                returnDateStr = [NSString stringWithFormat:@"%@%@", returnDateTxt.text,@" 00:00:00"];

            }
            
            createShipmentReturnDic[RETURNDATE_STR] = returnDateStr;
            createShipmentReturnDic[kShippedOnStr] = shippedOnStr;
            
            //ADDING ITEM DETAILS OR CART DETAILS.....
            NSMutableArray * locArr = [NSMutableArray new];
            
            locArr = [rawMaterialDetails copy];
            
            createShipmentReturnDic[STOCK_RETURN_ITEMS] = locArr;
            
            NSError  * err;
            NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:createShipmentReturnDic options:0 error:&err];
            NSString * createShipmentReturnJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@--json Request String--",createShipmentReturnJsonString);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.shipmentReturnDelegate = self;
            [webServiceController createShipmentReturn:createShipmentReturnJsonString];
            
        }
        
    } @catch (NSException *exception) {
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        //upto here on 02/05/2018....
        
        [HUD setHidden:YES];

        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @finally {
        
    }
    
}


/**
 * @description  Navigating to the summary page.....
 * @date         2/01/2018
 * @method       cancelButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)cancelButtonPressed:(UIButton *)sender {
    
    //Play audio for button touch...
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self backAction];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


#pragma -mark start of handling service call reponses

/**
 * @description  here we are handling the resposne received from services.......
 * @date         11/12/2017(implemented on this flow)
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
        if (successDictionary != nil && (searchItemsTxt.tag == (searchItemsTxt.text).length) ) {
            
            
            //checking searchItemsFieldTag.......
            if (![successDictionary[PRODUCTS_LIST] isKindOfClass:[NSNull class]]  && [successDictionary.allKeys containsObject:PRODUCTS_LIST]) {
                
                for(NSDictionary * dic in [successDictionary valueForKey:PRODUCTS_LIST]){
                    
                    [skuListArray addObject:dic];
                }
            }
            
            if(skuListArray.count){
                float tableHeight = skuListArray.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = skuListArray.count * 33;
                
                if(skuListArray.count > 5)
                    tableHeight = (tableHeight/skuListArray.count) * 5;
                
                [self showPopUpForTables:skListTable  popUpWidth:searchItemsTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItemsTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp];
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
    
    @catch (NSException * exception) {
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        searchItemsTxt.tag = 0;
        [HUD setHidden:YES];
        
    }
    @finally {
        
        
    }
}

/**
 * @description  here we are handling the error resposne received from services.......
 * @date         11/12/2017(implemented on this flow)
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
        
        [skListTable reloadData];
        
    }
}




/**
 * @description  here we are handling the resposne received from services.......
 * @date         11/12/2017
 * @method       getSkuDetailsSuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY Srinivasulu on 17/01/2016
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
                    [priceListTable reloadData];
                    SystemSoundID    soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"popup_tune" withExtension: @"mp3"];
                    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                    
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                }
            }
            else  {
                
                BOOL skuStatus = FALSE;
                
                int i=0;
                NSMutableDictionary * dic;
                
                for ( i=0; i<rawMaterialDetails.count;i++) {
                    NSArray * itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        dic = rawMaterialDetails[i];
                        if ([[dic valueForKey:ITEM_ID] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            
                            rawMaterialDetails[i] = dic;
                            
                            skuStatus = TRUE;
                            
                            break;
                        }
                    }
                }
                
                if (!skuStatus) {
                    
                    NSArray * itemArray = [successDictionary valueForKey:kSkuLists];
                    
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        
                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_ID];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESC];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kPrice] defaultReturn:@""] floatValue]] forKey:kPrice];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_PRICE] defaultReturn:@""] floatValue]] forKey:ITEM_PRICE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@""] floatValue]] forKey:RECEIVED_QTY];
                        
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:ITEM_TOTAL_VALUE];
                        
                        //float itemTotalValue = [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"] floatValue];
                        //[itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalValue] forKey:ITEM_TOTAL_VALUE];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                       
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:RETURN_REASON];

                        [itemDetailsDic setValue:EMPTY_STRING forKey:REMARKS];
                        
                        
                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                    else
                        
                        rawMaterialDetails[i] = dic;
                }
            }
            
           // [self calculateTotal];
        }
    }
    
    @catch (NSException * exception) {
        NSLog(@"-------exception will reading.-------%@",exception);
    }
    @finally{
        [HUD setHidden:YES];
        [cartTable reloadData];
    }
}

/**
 * @description  in this method we will call the services....
 * @date         11/12/2017
 * @method       getSkuDetailsErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By
 * @reason
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
 * @date         11/12/2017
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
        for(NSDictionary * dic in [successDictionary valueForKey:LOCATIONS_DETAILS]){
            
            
            if (![[dic valueForKey:LOCATION_ID] isKindOfClass:[NSNull class]] && [[dic valueForKey:LOCATION_ID] caseInsensitiveCompare:presentLocation] != NSOrderedSame) {
                [locationArr addObject:[dic valueForKey:LOCATION_ID]];
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
 * @description  here we are handling the resposne received from services.......
 * @date         11/12/2017
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

-(void)getLocationErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
    }
    
}



/**
 * @description  here handling the service call of the getSuppliersSuccessResposne
 * @date         25/08/2016
 * @method       getSuppliersSuccesResponse
 * @author       Bhargav
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSuppliersSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        if ((supplierShipmntRefTxt.text).length != 0 || (toSupplierTxt.text).length != 0) {
            
            if ([successDictionary[SUPPLIER_MASTER]count]) {
                
                NSMutableDictionary * supplierDetailsDictionary = [[NSMutableDictionary alloc]init];
                
                supplierDetailsDictionary = [[successDictionary valueForKey:SUPPLIER_MASTER]copy];
                
                toSupplierTxt.text = [self checkGivenValueIsNullOrNil:[supplierDetailsDictionary  valueForKey:FIRM_NAME] defaultReturn:@""];
                
                streetLocalityTxt.text = [self checkGivenValueIsNullOrNil:[supplierDetailsDictionary  valueForKey:STREET_NAME] defaultReturn:@""];
                
                supplierAddressTxt.text = [self checkGivenValueIsNullOrNil:[supplierDetailsDictionary  valueForKey:PLOT_NO] defaultReturn:@""];

                contactNoTxt.text = [self checkGivenValueIsNullOrNil:[supplierDetailsDictionary  valueForKey:CUSTOMER_PHONE] defaultReturn:@""];
            }
            
            if ((supplierShipmntRefTxt.text).length !=0) {
                
                selectVendor.userInteractionEnabled = NO;
                poReferenceTxt.userInteractionEnabled = NO;
            }
            
            else
                selectVendor.userInteractionEnabled = YES;

        }
        
        else {
            
            if([successDictionary[SUPPLIERS] count]){
                
                for (NSDictionary * dic in successDictionary[SUPPLIERS]){
                    
                    NSMutableDictionary * tempDic = [NSMutableDictionary new];
                    
                    [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[SUPPLIER_CODE] defaultReturn:@""] forKey:SUPPLIER_CODE];
                    [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[FIRM_NAME] defaultReturn:@""] forKey:SUPPLIER_NAME];
                    
                    [vendorIdsArray addObject:tempDic];
                }
            }

            else {
                
                float y_axis = self.view.frame.size.height - 120;
                
                NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            }
            
        }
        
    } @catch (NSException *exception) {
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @finally {
        [HUD setHidden:YES];
        
    }
}

/**
 * @description  handling the getSuppliers errorResponse
 * @date         25/08/2016
 * @method       getSupplieirsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSuppliersErrorResponse:(NSString *)errorResponse{
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        NSLog(@"---- exception while handling the getSuppliers ErrorResponse----%@",exception);
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
    }
    
}

/**
 * @description  Handling the SuccessResponse
 * @date         11/12/20174
 * @method       getOutletGoodsReceiptIdsSuccessResposne
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getOutletGoodsReceiptIdsSuccessResposne:(NSDictionary *)successDictionary {
    @try {
        
        
        if (successDictionary.count) {
            
            for (NSDictionary * dic in [successDictionary valueForKey:GRN_REF_LIST]) {
                
                [grnReceiptIdsArray addObject:dic];
            }
            
            if (grnReceiptIdsArray.count > 0) {
                [self populateGrnReceiptIds];
            }
        }
        
    } @catch (NSException * exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  Handling the Error Response..
 * @date         11/12/2017
 * @method       getOutletGoodsReceiptIdsErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getOutletGoodsReceiptIdsErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [catPopOver dismissPopoverAnimated:YES];
        
    }
}


/**
 * @description  here handling the service call of the getAllStockReceipt
 * @date         12/10/2016
 * @method       getStockReceiptSuccessResponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getWarehouseGoodsReceipNoteWithDetailsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {

        NSArray * shipmentArr = [successDictionary valueForKey:GRN_LIST];
        
        for (NSDictionary * receiptDic in shipmentArr) {
            
            grnReceiptDetailsDic = [receiptDic copy];
            
            inVoiceNoTxt.text = [self checkGivenValueIsNullOrNil:[grnReceiptDetailsDic  valueForKey:INVOICE_REF_NUMBER] defaultReturn:@""];
            
            poReferenceTxt.text = [self checkGivenValueIsNullOrNil:[grnReceiptDetailsDic valueForKey:Po_REF] defaultReturn:@""];
            
            shippedByTxt.text = [self checkGivenValueIsNullOrNil:[grnReceiptDetailsDic valueForKey:kDeliveredBy] defaultReturn:@""];
            
            supplierIdStr = [[self checkGivenValueIsNullOrNil:[grnReceiptDetailsDic  valueForKey:SUPPLIER_ID] defaultReturn:@""]copy];
            
            shippedOnTxt.text  = [self checkGivenValueIsNullOrNil:[[grnReceiptDetailsDic valueForKey:DELIVERED_ON_STR] componentsSeparatedByString:@" "][0] defaultReturn:@""];
            
            NSArray * items = grnReceiptDetailsDic[ITEMS_LIST];
            
            for (int i = 0; i < items.count; i++) {
                NSDictionary * itemDic = items[i];
                
                NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc]init];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_SKU] defaultReturn:@"--"] forKey:ITEM_ID];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_DESC] defaultReturn:@""] forKey:ITEM_DESC];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];

                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
              
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];

                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                
                [itemDetailsDic setValue:EMPTY_STRING forKey:RETURN_REASON];
                [itemDetailsDic setValue:EMPTY_STRING forKey:kSubCategory];
                [itemDetailsDic setValue:EMPTY_STRING forKey:kComments];
                [itemDetailsDic setValue:EMPTY_STRING forKey:REMARKS];
                [itemDetailsDic setValue:EMPTY_STRING forKey:MAKE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];

                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];

                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];

                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:SUPPLY_PRICE] defaultReturn:@""] forKey:ITEM_PRICE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:SUPPLIED_QTY] defaultReturn:@""] forKey:RECEIVED_QTY];

                [rawMaterialDetails addObject:itemDetailsDic];
            }
            
            [self getSuppliers:[NSString stringWithFormat:@"%@",receiptDic[SUPPLIER_ID]]];
            
            [self calculateTotal];
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
    } @finally {
        [HUD setHidden:YES];
        [cartTable reloadData];

    }
    
}

/**
 * @description  handling the getAllStockReceipt errorResponse
 * @date         12/10/2016
 * @method       getSupplieirsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getWarehouseGoodsReceipNoteWithDetailsErrorResponse:(NSString *)errorResponse{
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [catPopOver dismissPopoverAnimated:YES];
    }
}


/**
 * @description  handling the success response received from server side....
 * @date         03/01/2018
 * @method       getCategoriesByLocationSuccessResponse:
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
            [categoriesTable reloadData];
            
        }
    }
}


/**
 * @description  handling the service call error resposne....
 * @date         03/01/2018
 * @method       getCategoriesByLocationErrorResponse:
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
                                
                                //[[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]]
                                //[existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                                
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
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESC];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kPrice] defaultReturn:@""] floatValue]] forKey:kPrice];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SALE_PRICE] defaultReturn:@""] floatValue]] forKey:SALE_PRICE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:COST] defaultReturn:@""] floatValue]] forKey:COST];
                            
                            //setting availiable qty....
                            //setting availiable qty....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@""] floatValue]] forKey:RECEIVED_QTY];
                            
                            //float itemTotalValue = [[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"] floatValue];
                            
                            //[itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalValue] forKey:ITEM_TOTAL_VALUE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:ITEM_TOTAL_VALUE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
                            
                            [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                            
                            [itemDetailsDic setValue:EMPTY_STRING forKey:kComments];
                            [itemDetailsDic setValue:EMPTY_STRING forKey:RETURN_REASON];
                            [itemDetailsDic setValue:EMPTY_STRING forKey:kReturnNoteRef];
                            [itemDetailsDic setValue:EMPTY_STRING forKey:REMARKS];
                            
                            
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
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESC];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kPrice] defaultReturn:@""] floatValue]] forKey:kPrice];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SALE_PRICE] defaultReturn:@""] floatValue]] forKey:SALE_PRICE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:COST] defaultReturn:@""] floatValue]] forKey:COST];
                        
                        //setting availiable qty....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@""] floatValue]] forKey:RECEIVED_QTY];
                        
//                        float itemTotalValue = [[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"] floatValue];
//
//                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalValue] forKey:ITEM_TOTAL_VALUE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                       
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:ITEM_TOTAL_VALUE];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:kComments];
                        [itemDetailsDic setValue:EMPTY_STRING forKey:RETURN_REASON];
                        [itemDetailsDic setValue:EMPTY_STRING forKey:kReturnNoteRef];
                        [itemDetailsDic setValue:EMPTY_STRING forKey:REMARKS];
                     
                        
                        
                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                }
            }
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItemsTxt.isEditing)
                y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,@"  Records Are added to the cart successfully"];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"CART_RECORDS" conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

            
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
        
        if(searchItemsTxt.isEditing)
            
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [categoriesPopOver dismissPopoverAnimated:YES];
    }
}


/**
 * @description  Handling the Success Response...
 * @date         04/01/2017
 * @method       CreateShipmentSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createShipmentReturnSuccessReponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis;

        y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString * mesg = [[successDictionary valueForKey:@"ResponseHeader"] valueForKey:RESPONSE_MESSAGE] ;
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


/**
 * @description  Handling the Shipment Return Error Response...
 * @date         04/01/2018
 * @method       CreateShipmentErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)createShipmentErrorResponse:(NSString *)errorResponse {
    
    @try {
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = NO;
        //upto here on 02/05/2018....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}



#pragma mark display pop-over methods..
/**
 * @description  Displaying popover for the locations.......
 * @date         11/12/2017
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
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((locationArr == nil) || (locationArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self getLocations:selectIndex businessActivity:RETAIL_OUTLET];
        }
        
        [HUD setHidden:YES];
        
        if(locationArr.count == 0){
            
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = locationArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationArr.count * 33;
        
        if(locationArr.count > 5)
            tableHeight = (tableHeight/locationArr.count) * 5;
        
        [self showPopUpForTables:locationTable  popUpWidth:(fromLocationTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:fromLocationTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  displaying popOver for the shipment Mode.......
 * @date         11/12/2017
 * @method       populateReturnResaon::
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

-(void)populateReturnResaon:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        returnReasonArray = [[NSMutableArray alloc]init];
        
        [returnReasonArray addObject:@"Incorrect Product"];
        [returnReasonArray addObject:@"Not Meet Customer's Expectations"];
        [returnReasonArray addObject:@"Company Shipped Wrong Product"];
        [returnReasonArray addObject:@"Wardrobing"];
        
        float tableHeight = returnReasonArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = returnReasonArray.count * 33;
        
        if(returnReasonArray.count>5)
            tableHeight = (tableHeight/returnReasonArray.count) * 5;
        
        [self showPopUpForTables:returnReasonTable  popUpWidth:(reasonTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:reasonTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}



/**
 * @description  here we are showing the all availiable outlerId.......
 * @date         21/09/2016
 * @method       showAllVendorId
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)populateVendorIds:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((vendorIdsArray == nil) || (vendorIdsArray.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self getSuppliers:nil];
            
            //return;
        }
        
        [HUD setHidden:YES];
        
        if(vendorIdsArray.count == 0){
            
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = vendorIdsArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = vendorIdsArray.count * 33;
        
        if(vendorIdsArray.count > 5)
            tableHeight = (tableHeight/vendorIdsArray.count) * 5;
        
        [self showPopUpForTables:vendorIdsTable  popUpWidth:(toSupplierTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:toSupplierTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  displaying popOver for the shipment Mode.......
 * @date         11/12/2017
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

-(void)populateShipmentModes:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        shipmentModesArray = [NSMutableArray new];
        [shipmentModesArray addObject:@"Rail"];
        [shipmentModesArray addObject:@"Flight"];
        [shipmentModesArray addObject:@"Express"];
        [shipmentModesArray addObject:@"Ordinary"];
        
        float tableHeight = shipmentModesArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = shipmentModesArray.count * 33;
        
        if(shipmentModesArray.count>5)
            tableHeight = (tableHeight/shipmentModesArray.count) * 5;
        
        [self showPopUpForTables:shipmentModeTable  popUpWidth:(shipmentModeTxt.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:shipmentModeTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}

-(void)populateGrnReceiptIds {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float tableHeight = grnReceiptIdsArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = grnReceiptIdsArray.count * 33;
        
        if(grnReceiptIdsArray.count>5)
            tableHeight = (tableHeight/grnReceiptIdsArray.count) * 5;
        
        [self showPopUpForTables:grnReceiptIdsTable  popUpWidth:(supplierShipmntRefTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:supplierShipmntRefTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        categoriesTable = [[UITableView alloc] init];
        categoriesTable.backgroundColor  = [UIColor blackColor];
        categoriesTable.layer.cornerRadius = 4.0;
        categoriesTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        categoriesTable.dataSource = self;
        categoriesTable.delegate = self;
        
        
        okButton = [[UIButton alloc] init] ;
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
        okButton.backgroundColor = [UIColor grayColor];
        okButton.layer.masksToBounds = YES;
        okButton.userInteractionEnabled = YES;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        okButton.layer.cornerRadius = 5.0f;
        [okButton addTarget:self action:@selector(multipleCategriesSelection:) forControlEvents:UIControlEventTouchDown];
        
        
        cancelButton = [[UIButton alloc] init] ;
        [cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor grayColor];
        cancelButton.layer.masksToBounds = YES;
        cancelButton.userInteractionEnabled = YES;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        cancelButton.layer.cornerRadius = 5.0f;
        [cancelButton addTarget:self action:@selector(dismissCategoryPopOver:) forControlEvents:UIControlEventTouchDown];
        
        [categoriesView addSubview:headerNameLbl];
        [categoriesView addSubview:selectAllLbl];
        [categoriesView addSubview:selectAllCheckBoxBtn];
        [categoriesView addSubview:categoriesTable];
        [categoriesView addSubview:okButton];
        [categoriesView addSubview:cancelButton];
        
        headerNameLbl.frame = CGRectMake(0,0,categoriesView.frame.size.width,50);
        
        selectAllCheckBoxBtn.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+10,30,30);
        
        selectAllLbl.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x+selectAllCheckBoxBtn.frame.size.width+10,selectAllCheckBoxBtn.frame.origin.y-5,95,40);
        
        categoriesTable.frame = CGRectMake(0,selectAllCheckBoxBtn.frame.origin.y+selectAllCheckBoxBtn.frame.size.height+10,categoriesView.frame.size.width,200);
        
        okButton.frame = CGRectMake(selectAllLbl.frame.origin.x,categoriesTable.frame.origin.y+categoriesTable.frame.size.height+5,100,40);
        cancelButton.frame = CGRectMake(okButton.frame.origin.x+okButton.frame.size.width+20,categoriesTable.frame.origin.y+categoriesTable.frame.size.height+5,100,40);
        
        categoriesPopover.view = categoriesView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            categoriesPopover.preferredContentSize =  CGSizeMake(categoriesView.frame.size.width, categoriesView.frame.size.height);
            
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:categoriesPopover];
            
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
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
 * @description  Here we are dismissing the popOver when cancelButton pressed...
 * @date         12/12/2017
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
            
            pickView.frame = CGRectMake(15, returnDateTxt.frame.origin.y+returnDateTxt.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:returnDateTxt.frame inView:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:shippedOnTxt.frame inView:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        
        if(sender.tag == 2){
            if((returnDateTxt.text).length)
                //                callServices = true;
                
                
                returnDateTxt.text = @"";
        }
        else{
            if((shippedOnTxt.text).length)
                //                callServices = true;
                
                shippedOnTxt.text = @"";
        }
        
        //
        //        if(callServices){
        //            [HUD setHidden:NO];
        //
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
        
        // getting present date & time ..
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        //        [f release];
        today = [f dateFromString:currentdate];
        
        //if( [today compare:selectedDateString] == NSOrderedAscending ){
        
        // [self displayAlertMessage:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        //  return;
        //}
        
        NSDate * existingDateString;
        
        if(sender.tag == 2) {
            if ((returnDateTxt.text).length != 0 && (![returnDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:returnDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:370 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    return;
                    
                }
            }
            
            returnDateTxt.text = dateString;
        }
        else {
            
            if ((shippedOnTxt.text).length != 0 && ( ![shippedOnTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:shippedOnTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:370 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            
            shippedOnTxt.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
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
        
        UIImage * checkBoxImg = [UIImage imageNamed:@"checkbox_off_background.png"];
        
        
        if([checkBoxArr containsObject:@"0"]){
            
            [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            selectAllCheckBoxBtn.tag = 2;
        }
        else{
            
            checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
            
            [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            selectAllCheckBoxBtn.tag = 4;
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
        [categoriesTable reloadData];
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
        
        [categoriesTable reloadData];
    }
}


#pragma mark Text Field Delegates...


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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    if (textField.frame.origin.x == returnReasonText.frame.origin.x || textField.frame.origin.x  == returnQtyTxt.frame.origin.x )
        
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
        
        if(textField == searchItemsTxt){
            
            offSetViewTo = 120;
        }
        
        else if (textField.frame.origin.x == returnReasonText.frame.origin.x || textField.frame.origin.x  == returnQtyTxt.frame.origin.x ) {
            
            [textField selectAll:nil];
            
            [UIMenuController sharedMenuController].menuVisible = NO;
            
            int count = (int)textField.tag;
            
            if(textField.tag > 7)
                
                count =  7;
            
            offSetViewTo = (textField.frame.origin.y + textField.frame.size.height) * count + cartTable.frame.origin.y + 50;
        }
        
        [self keyboardWillShow];
        
    } @catch (NSException *exception) {
        
    }
    
}

/**
 * @description
 * @date         03/01/2018
 * @method       textField shouldChangeCharactersInRange
 * @author       Bhargav.v
 * @param        NSRange
 * @param        NSString
 * @return
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
    
    if (textField == searchItemsTxt) {
        
        if((toSupplierTxt.text).length == 0 || [toSupplierTxt.text isEqualToString:@""]){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_the_supplier_first",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2 verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        else if ((textField.text).length >= 3) {
            
            @try {
                
                if (searchItemsTxt.tag == 0) {
                    
                    searchItemsTxt.tag = (textField.text).length;
                    
                    skuListArray = [[NSMutableArray alloc]init];
                    
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
    else if (textField == supplierShipmntRefTxt) {
        
        if ((textField.text).length>=3) {
            
            @try {
                
                grnReceiptIdsArray = [NSMutableArray new];
                
                [self getOutletGrnReceiptIds:supplierShipmntRefTxt.text];
                
            } @catch ( NSException * exception) {
                
            }
        }
    }
    else if(textField.frame.origin.x == returnQtyTxt.frame.origin.x) {
        
        reloadTableData = true;
        
        NSString * qtyKey = QUANTITY;
        
        NSMutableDictionary * temp = [rawMaterialDetails[textField.tag] mutableCopy];
        
        float price  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue];
        float quantity = (textField.text).floatValue;
        
        [temp setValue:[NSString stringWithFormat:@"%.2f",(price * quantity)] forKey:ITEM_TOTAL_VALUE];
        
        [temp setValue:textField.text  forKey:qtyKey];
        
        rawMaterialDetails[textField.tag] = temp;
    }
    
    else if(textField.frame.origin.x == returnReasonText.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary * dic =  [rawMaterialDetails[textField.tag] mutableCopy];
            
            [dic setValue:textField.text  forKey:RETURN_REASON];
            rawMaterialDetails[textField.tag] = dic;
        }
        @catch(NSException * exception) {
            
        }
    }
}

/**
 * @description  Delegate method called while returning the Begin Editing Method
 * @date         03/02/2018
 * @method       textFieldDidEndEditing
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    
    offSetViewTo = 0;
    
    if (textField.frame.origin.x == returnQtyTxt.frame.origin.x) {
        
        @try {
            
            NSString * qtyKey = QUANTITY;
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag] mutableCopy];
            
            float price  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue];
            float quantity = (textField.text).floatValue;
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",(price * quantity)] forKey:ITEM_TOTAL_VALUE];
            
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
    
    else if (textField.frame.origin.x == returnReasonText.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary * dic =  [rawMaterialDetails[textField.tag] mutableCopy];
            
            [dic setValue:textField.text  forKey:RETURN_REASON];
            rawMaterialDetails[textField.tag] = dic;
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
 * @date         03/01/2018
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


#pragma mark Table View Delegates.....

/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date         11/12/2017
 * @method       showCompleteStockRequestInfo: numberOfRowsInSection:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @modified BY
 * @reason
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == skListTable) {
        
        return skuListArray.count;
    }
    else if (tableView == cartTable) {
        
        [self calculateTotal];

        return rawMaterialDetails.count;
    }
    
    else if (tableView == locationTable){
        
        return locationArr.count;
    }
    else if (tableView == returnReasonTable){
        
        return returnReasonArray.count;
    }
    
    else if (tableView == vendorIdsTable){
        
        return vendorIdsArray.count;
    }
    
    else if (tableView == shipmentModeTable){
        
        return shipmentModesArray.count;
    }
    else if (tableView == grnReceiptIdsTable){
        
        return grnReceiptIdsArray.count;
    }
    else if (tableView == categoriesTable ) {
        
        return categoriesArr.count;
    }
    
    else if (tableView == priceListTable) {
       
        return priceArr.count;
    }
    
    else
        return false;
}

/**
 * @description  Setting the cell height Statically..
 * @date         11/12/2017
 * @method       heightForRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 *
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if( tableView == locationTable || tableView == returnReasonTable || tableView == vendorIdsTable || tableView == shipmentModeTable || tableView == skListTable || tableView == categoriesTable ||tableView == cartTable ||tableView == priceListTable){
            
            return  40;
        }
    }
    
    return 40;
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         11/12/2017
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 * @return       UITableViewCell
 * @modified BY
 * @reason
 * @return
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
            
            if (skuListArray.count > indexPath.row){
                NSDictionary * dic = skuListArray[indexPath.row];
                
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
    
    else if (tableView == cartTable) {
        
        @try {
            
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
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_1.frame = CGRectMake(sNoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(sNoLbl.frame.origin.x), 1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
            }
            
            UILabel * itemNoLbl;
            UILabel * itemIdLbl;
            UILabel * itemDescLbl;
            UILabel * itemEanLbl;
            UILabel * itemUomLbl;
            UILabel * itemReceivedQtyLbl;
            UILabel * itemPriceLbl;
            UILabel * itemValueLbl;
            
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
            
            returnReasonText = [[UITextField alloc] init];
            returnReasonText.borderStyle = UITextBorderStyleRoundedRect;
            returnReasonText.textColor = [UIColor blackColor];
            returnReasonText.layer.borderWidth = 1;
            returnReasonText.backgroundColor = [UIColor clearColor];
            returnReasonText.autocorrectionType = UITextAutocorrectionTypeNo;
            returnReasonText.clearButtonMode = UITextFieldViewModeWhileEditing;
            returnReasonText.returnKeyType = UIReturnKeyDone;
            returnReasonText.delegate = self;
            returnReasonText.textAlignment = NSTextAlignmentCenter;
            returnReasonText.tag = indexPath.row;
            returnReasonText.userInteractionEnabled = YES;
            
            [returnReasonText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            returnReasonText.placeholder = NSLocalizedString(@"reason",nil);
            returnReasonText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:returnReasonText.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
            
            
            itemUomLbl = [[UILabel alloc] init];
            itemUomLbl.backgroundColor = [UIColor clearColor];
            itemUomLbl.layer.borderWidth = 0;
            itemUomLbl.textAlignment = NSTextAlignmentCenter;
            itemUomLbl.numberOfLines = 1;
            itemUomLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemReceivedQtyLbl = [[UILabel alloc] init];
            itemReceivedQtyLbl.backgroundColor = [UIColor clearColor];
            itemReceivedQtyLbl.layer.borderWidth = 0;
            itemReceivedQtyLbl.textAlignment = NSTextAlignmentCenter;
            itemReceivedQtyLbl.numberOfLines = 1;
            itemReceivedQtyLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemPriceLbl = [[UILabel alloc] init];
            itemPriceLbl.backgroundColor = [UIColor clearColor];
            itemPriceLbl.layer.borderWidth = 0;
            itemPriceLbl.textAlignment = NSTextAlignmentCenter;
            itemPriceLbl.numberOfLines = 1;
            itemPriceLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemValueLbl = [[UILabel alloc] init];
            itemValueLbl.backgroundColor = [UIColor clearColor];
            itemValueLbl.layer.borderWidth = 0;
            itemValueLbl.textAlignment = NSTextAlignmentCenter;
            itemValueLbl.numberOfLines = 1;
            itemValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            returnQtyTxt = [[UITextField alloc] init];
            returnQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            returnQtyTxt.textColor = [UIColor blackColor];
            returnQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            returnQtyTxt.layer.borderWidth = 1;
            returnQtyTxt.backgroundColor = [UIColor clearColor];
            returnQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            returnQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            returnQtyTxt.returnKeyType = UIReturnKeyDone;
            returnQtyTxt.delegate = self;
            [returnQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            returnQtyTxt.textAlignment = NSTextAlignmentCenter;
            returnQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            returnQtyTxt.tag = indexPath.row;
            returnQtyTxt.userInteractionEnabled = YES;
            
            delRowBtn = [[UIButton alloc] init];
            [delRowBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delRowBtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delRowBtn.tag = indexPath.row;
            delRowBtn.backgroundColor = [UIColor clearColor];
            
            itemNoLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemIdLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemDescLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemEanLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemUomLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemReceivedQtyLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemPriceLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            returnReasonText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            returnQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            
            itemNoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            itemIdLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            itemDescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            itemEanLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            itemUomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            itemReceivedQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            itemPriceLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            itemValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            returnReasonText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            returnQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            //Adding Subview for the cell..
            
            [hlcell.contentView addSubview:itemNoLbl];
            [hlcell.contentView addSubview:itemIdLbl];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemEanLbl];
            [hlcell.contentView addSubview:itemUomLbl];
            [hlcell.contentView addSubview:itemReceivedQtyLbl];
            [hlcell.contentView addSubview:itemPriceLbl];
            [hlcell.contentView addSubview:itemValueLbl];
            
            [hlcell.contentView addSubview:returnReasonText];
            [hlcell.contentView addSubview:returnQtyTxt];
            
            [hlcell.contentView addSubview:delRowBtn];
            
            @try {
                
                NSDictionary * temp = rawMaterialDetails[indexPath.row];
                
                itemNoLbl.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1)];
                
                itemIdLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_ID] defaultReturn:@"--"];//ITEM_SKU
                
                itemDescLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_DESC] defaultReturn:@"--"];//ITEM_SKU
                
                if ([[temp valueForKey:EAN]isKindOfClass:[NSNull class]]|| (![[temp valueForKey:EAN]isEqualToString:@""])) {
                    
                    itemEanLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:EAN] defaultReturn:@""];
                }
                else
                    itemEanLbl.text = @"--";
                
                returnReasonText.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:RETURN_REASON] defaultReturn:@""];
                
                if ([[temp valueForKey:UOM]isKindOfClass:[NSNull class]]|| (![[temp valueForKey:SELL_UOM]isEqualToString:@""])) {
                    
                    itemUomLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:SELL_UOM] defaultReturn:@""];
                }
                else
                    itemUomLbl.text = @"--";
                
                itemReceivedQtyLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"]  floatValue]];
                
                itemPriceLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_PRICE] defaultReturn:@""] floatValue]];
                
                itemValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_TOTAL_VALUE] defaultReturn:@""] floatValue]];
                
                returnQtyTxt.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY] defaultReturn:@""]  floatValue]];
                
            } @catch (NSException *exception) {
                
            }
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                //changed by Srinivasulu on 14/04/2017.....
                
                itemNoLbl.frame = CGRectMake(sNoLbl.frame.origin.x, 0, sNoLbl.frame.size.width, hlcell.frame.size.height);
                
                itemIdLbl.frame = CGRectMake( skuIdLbl.frame.origin.x, 0, skuIdLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemDescLbl.frame = CGRectMake( descLbl.frame.origin.x, 0, descLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemEanLbl.frame = CGRectMake( eanLbl.frame.origin.x, 0, eanLbl.frame.size.width,  hlcell.frame.size.height);
                
                returnReasonText.frame = CGRectMake( reasonForReturnLbl.frame.origin.x, 2, reasonForReturnLbl.frame.size.width, 36);
                
                itemUomLbl.frame = CGRectMake( uomLbl.frame.origin.x, 0, uomLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemReceivedQtyLbl.frame = CGRectMake( receivedQtyLbl.frame.origin.x, 0, receivedQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemPriceLbl.frame = CGRectMake( priceLbl.frame.origin.x, 0, priceLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemValueLbl.frame = CGRectMake( valueLbl.frame.origin.x, 0, valueLbl.frame.size.width,  hlcell.frame.size.height);
                
                returnQtyTxt.frame = CGRectMake( returnQtyLbl.frame.origin.x, 2, returnQtyLbl.frame.size.width,  36);
                
                delRowBtn.frame = CGRectMake(returnQtyTxt.frame.origin.x + returnQtyTxt.frame.size.width+15,2,35,35);
                
                //setting font size....
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView: hlcell andSubViews:YES fontSize:16.0 cornerRadius:0.0];
                
            }
            
            else{
                
                //DO CODING FOR IPHONE...
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        } @catch (NSException * exception) {
            
        }
    }
    
    else if (tableView == locationTable) {
        
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
        
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:locationArr[indexPath.row]  defaultReturn:@""] ;
        
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        hlcell.textLabel.numberOfLines = 1;
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return hlcell;
    }
    
    else if (tableView == returnReasonTable) {
        
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
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:returnReasonArray[indexPath.row]  defaultReturn:@"--"];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        return hlcell;
    }
    
    if(tableView == vendorIdsTable) {
        
        //        tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
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
            
            hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:vendorIdsArray[indexPath.row][SUPPLIER_NAME] defaultReturn:@""];
            
            hlcell.textLabel.numberOfLines = 1;
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            return hlcell;
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == shipmentModeTable) {
        
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
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:shipmentModesArray[indexPath.row]  defaultReturn:@"--"];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        return hlcell;
    }
    
    else if (tableView == grnReceiptIdsTable) {
        
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
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:grnReceiptIdsArray[indexPath.row]  defaultReturn:@"--"];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        return hlcell;
    }
    
    
    else if (tableView == categoriesTable) {
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
    
    else if (tableView == priceListTable) {
        
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
            desc_Lbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
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
            
            desc_Lbl.text = [dic valueForKey:@"description"];
            mrpPrice.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:@"salePrice"] floatValue]];
            price.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:@"price"] floatValue]];
            
            
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
                    desc_Lbl.font = [UIFont fontWithName:@"Helvetica" size:22];
                    desc_Lbl.frame = CGRectMake(5, 0, 125, 56);
                    price.font = [UIFont fontWithName:@"Helvetica" size:18];
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
    
    if (tableView == skListTable) {
        
        //Changes Made Bhargav.v on 11/05/2018...
        //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
        //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
        
        NSDictionary * detailsDic = skuListArray[indexPath.row];
        
        NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[@"skuID"]];
        
        if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
            
            inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
        }
        
        [self callRawMaterialDetails:inputServiceStr];
        
        searchItemsTxt.text = @"";
        
        
    }
    else if (tableView == locationTable) {
        
        fromLocationTxt.text = locationArr[indexPath.row] ;
    }
    
    else if (tableView == returnReasonTable){
        
        reasonTxt.text = returnReasonArray[indexPath.row] ;
    }
    
    else if (tableView == vendorIdsTable){
        
        toSupplierTxt.text = [self checkGivenValueIsNullOrNil:vendorIdsArray[indexPath.row][SUPPLIER_NAME] defaultReturn:@"--"] ;
        
        supplierIdStr  = [[self checkGivenValueIsNullOrNil:vendorIdsArray[indexPath.row][SUPPLIER_CODE] defaultReturn:@""]copy];

        [self getSuppliers:supplierIdStr];
        
        
        
    }
    
    else if (tableView == shipmentModeTable){
        
        shipmentModeTxt.text = shipmentModesArray[indexPath.row] ;
    }
    
    else if (tableView == grnReceiptIdsTable) {
        @try {
            
            [HUD setHidden:NO];
            [self callingGrnReceiptDetails:grnReceiptIdsArray[indexPath.row]];
            
            supplierShipmntRefTxt.text = grnReceiptIdsArray[indexPath.row] ;
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    /// Code for priceTable
    else if (tableView == priceListTable)    {
        
        @try {
            transparentView.hidden = YES;
            
            NSDictionary * detailsDic = priceArr[indexPath.row];
            
            status = FALSE;
            
            int i= 0;
            NSMutableDictionary * dic;
            
            for ( i= 0; i<rawMaterialDetails.count;i++) {
                
                dic = rawMaterialDetails[i];
                if ([[dic valueForKey:ITEM_ID] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]]) {
                    
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                    
                    rawMaterialDetails[i] = dic;
                    
                    status = TRUE;
                    break;
                }
            }
            
            if (!status) {
                
                NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_ID];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESC];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:RETURN_REASON] defaultReturn:@""] forKey:RETURN_REASON];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:kPrice] defaultReturn:@""] floatValue]] forKey:kPrice];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_PRICE] defaultReturn:@""] floatValue]] forKey:ITEM_PRICE];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@""] floatValue]] forKey:RECEIVED_QTY];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                
                float itemTotalValue = [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"] floatValue];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalValue] forKey:ITEM_TOTAL_VALUE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                
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
            
            delRowBtn = sender;
            
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
    
    float receivedQty   = 0.0;
    float value         = 0.0;
    float returnedQty   = 0.0;
    
    for(NSDictionary * dic in rawMaterialDetails){
        
        receivedQty += [[self checkGivenValueIsNullOrNil:[dic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"]floatValue];
        
        value       += [[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_TOTAL_VALUE] defaultReturn:@"0.00"]floatValue];
        
        returnedQty += ([[dic valueForKey:AVL_QTY] floatValue] + [[dic valueForKey:QUANTITY] floatValue]);
    }
    
    receivedQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",receivedQty];
    totalValueLbl.text        = [NSString stringWithFormat:@"%@%.2f",@" ",value];
    returnQtyValueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@" ",returnedQty];
    
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
    
  if (alertView == delItemAlert) {
        
        if (buttonIndex == 0) {
            
            delItemAlert.tag = 4;
            
            
            [self delRow:delRowBtn];
            
        }
        else {
            
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
        }
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
                NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
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
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height >= height) ){
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


#pragma mark key Board Delegates...

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
 * @author       Bhargav.v
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
