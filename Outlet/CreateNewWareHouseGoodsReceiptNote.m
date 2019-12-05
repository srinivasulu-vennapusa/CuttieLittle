//
//  ViewController.m
//  OmniRetailer
//
//  Created by TLMac on 11/8/16.
//
//

#import "CreateNewWareHouseGoodsReceiptNote.h"
#import "OmniHomePage.h"
#import "Global.h"
#import "OmniRetailerViewController.h"


@interface CreateNewWareHouseGoodsReceiptNote ()

@end

@implementation CreateNewWareHouseGoodsReceiptNote

@synthesize soundFileURLRef,soundFileObject;
@synthesize goodsReceiptRefID,selectedString;

#pragma  - mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         18/10/2016
 * @method       ViewDidLoad
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)viewDidLoad {
       [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
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
    // Show the HUD
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = NSLocalizedString(@"please_wait..", nil);

    
    //Added By Bhargav.v on 12/06/2018...
    
    @try {
        
        if (scanner) {
            
            [scanner addObserver:self];
            [scanner setScannerAutoScan:YES];
        }
        else {
            
            OmniRetailerViewController * controller = [[OmniRetailerViewController alloc] init];
            [controller initializePowaPeripherals];
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@ scanner-%@ printer - %@ powa peripheral- %@",exception,scanner,printer,powaPOS);
    }
    
    
    //creating the purchaseOrderView which will displayed completed Screen.......
    purchaseOrderView = [[UIView alloc] init];
    purchaseOrderView.backgroundColor = [UIColor clearColor];
    purchaseOrderView.layer.borderWidth = 1.0f;
    purchaseOrderView.layer.cornerRadius = 10.0f;
    purchaseOrderView.layer.borderColor = [UIColor grayColor].CGColor;

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
    
    
    UILabel * powaStatusLbl = [[UILabel alloc] init];
    powaStatusLbl.text = @"Scanner Status";
    powaStatusLbl.textColor = [UIColor blackColor];
    powaStatusLbl.lineBreakMode = NSLineBreakByWordWrapping;
    powaStatusLbl.numberOfLines = 1;
    
    powaStatusLblVal = [[UILabel alloc] init];
    powaStatusLblVal.textColor = [UIColor blackColor];
    
    if (scanner) {
        
        powaStatusLblVal.textColor = [UIColor colorWithRed:0.0/255.0 green:102.0/255.0 blue:0.0/255.0 alpha:1.0];
        powaStatusLblVal.text = [NSString stringWithFormat:@"Connected"];
        
    }
    else {
        
        powaStatusLblVal.textColor = [UIColor redColor];
        powaStatusLblVal.text = [NSString stringWithFormat:@"Disconnected"];
    }

    
    /** creation of UITextField*/
    poRefNoTxt = [[CustomTextField alloc] init];
    poRefNoTxt.placeholder = NSLocalizedString(@"po_ref", nil);
    poRefNoTxt.delegate = self;
    [poRefNoTxt awakeFromNib];
    [poRefNoTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    dueDateTxt = [[CustomTextField alloc] init];
    dueDateTxt.placeholder = NSLocalizedString(@"due_date", nil);
    dueDateTxt.delegate = self;
    [dueDateTxt awakeFromNib];
    
    deliveredDateTxt = [[CustomTextField alloc] init];
    deliveredDateTxt.placeholder = NSLocalizedString(@"delivered_on", nil);
    deliveredDateTxt.delegate = self;
    [deliveredDateTxt awakeFromNib];
   
    vendorIdTxt = [[CustomTextField alloc] init];
    vendorIdTxt.placeholder = NSLocalizedString(@"supplier_id", nil);
    vendorIdTxt.delegate = self;
    [vendorIdTxt awakeFromNib];
    [vendorIdTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    supplierNameTxt = [[CustomTextField alloc] init];
    supplierNameTxt.placeholder = NSLocalizedString(@"supplier_name", nil);
    supplierNameTxt.delegate = self;
    [supplierNameTxt awakeFromNib];
    
    inspectedByTxt = [[CustomTextField alloc] init];
    inspectedByTxt.placeholder = NSLocalizedString(@"inspectced_by", nil);
    inspectedByTxt.delegate = self;
    [inspectedByTxt awakeFromNib];

    receivedByTxt = [[CustomTextField alloc] init];
    receivedByTxt.placeholder = NSLocalizedString(@"received_by", nil);
    receivedByTxt.delegate = self;
    [receivedByTxt awakeFromNib];
    
    deliveredByTxt = [[CustomTextField alloc] init];
    deliveredByTxt.placeholder = NSLocalizedString(@"delivered_by", nil);
    deliveredByTxt.delegate = self;
    [deliveredByTxt awakeFromNib];
    
    submitedByTxt = [[CustomTextField alloc] init];
    submitedByTxt.placeholder = NSLocalizedString(@"submitted_by", nil);
    submitedByTxt.text = firstName;
    submitedByTxt.delegate = self;
    //submitedByTxt.userInteractionEnabled = NO;
    [submitedByTxt awakeFromNib];
    
    approvedByTxt = [[CustomTextField alloc] init];
    approvedByTxt.placeholder = NSLocalizedString(@"approved_by", nil);
    approvedByTxt.delegate = self;
    [approvedByTxt awakeFromNib];
    
    //added by Srinivasulu on 09/02/2017....
    
    invoiceNumberTxt = [[CustomTextField alloc] init];
    invoiceNumberTxt.placeholder = NSLocalizedString(@"invoice_number", nil);
    invoiceNumberTxt.delegate = self;
    [invoiceNumberTxt awakeFromNib];
    
    indentRefNumberTxt = [[CustomTextField alloc] init];//-*-*-*-*
    indentRefNumberTxt.placeholder = NSLocalizedString(@"indent_ref", nil);
    indentRefNumberTxt.delegate = self;
    [indentRefNumberTxt awakeFromNib];
    
    locationTxt = [[CustomTextField alloc] init];
    locationTxt.placeholder = NSLocalizedString(@"location", nil);
    locationTxt.delegate = self;
    locationTxt.text = presentLocation;
    [locationTxt awakeFromNib];
    
    deliveredDateTxt.userInteractionEnabled = NO;
    supplierNameTxt.userInteractionEnabled = NO;
    inspectedByTxt.userInteractionEnabled = NO;
    receivedByTxt.userInteractionEnabled = NO;
    vendorIdTxt.userInteractionEnabled = NO;
    locationTxt.userInteractionEnabled = NO;
    dueDateTxt.userInteractionEnabled = NO;
    dueDateTxt.userInteractionEnabled = NO;
    
    UIImage *buttonImage = [UIImage imageNamed:@"arrow.png"];
    UIImage *buttonImage_ = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    //creating the UIButton which are used to show CustomerInfo popUp.......
    vendorIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [vendorIdBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [vendorIdBtn addTarget:self action:@selector(showAllVendorId:) forControlEvents:UIControlEventTouchDown];
    
    //used for displaying the calenderView.......
    dueDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dueDateBtn setBackgroundImage:buttonImage_  forState:UIControlStateNormal];
    [dueDateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    deliveryDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliveryDateBtn setBackgroundImage:buttonImage_  forState:UIControlStateNormal];
    [deliveryDateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    inspectdByBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [inspectdByBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [inspectdByBtn addTarget:self action:@selector(showListOfEmployees:) forControlEvents:UIControlEventTouchDown];
    
    receivedByBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [receivedByBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [receivedByBtn addTarget:self action:@selector(showListOfEmployees:) forControlEvents:UIControlEventTouchDown];
    
    //upto here on 09/02/2017....
    
    //Creation of SearchItemsTxt UITextField.......
    searchItemsTxt = [[CustomTextField alloc] init];
    searchItemsTxt.placeholder = NSLocalizedString(@"search_here", nil);
    searchItemsTxt.delegate = self;
    [searchItemsTxt awakeFromNib];
    searchItemsTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemsTxt.textColor = [UIColor blackColor];
    searchItemsTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemsTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [searchItemsTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImage * productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
    selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];

    //creating the purchaseOrderScrollView.......
    purchaseOrderScrollView = [[UIScrollView alloc] init];
    //purchaseOrderScrollView.backgroundColor = [UIColor lightGrayColor];

    //Creation of items TableHeader's.... //-*-*-*-*
    sNoLbl = [[CustomLabel alloc] init];
    [sNoLbl awakeFromNib];
    
    skuIdLbl = [[CustomLabel alloc] init];
    [skuIdLbl awakeFromNib];
    
    descriptionLbl = [[CustomLabel alloc] init];
    [descriptionLbl awakeFromNib];
    
    uomLbl = [[CustomLabel alloc] init];
    [uomLbl awakeFromNib];

    BatchNoLabel = [[CustomLabel alloc] init];
    [BatchNoLabel awakeFromNib];

    expDateLabel = [[CustomLabel alloc] init];
    [expDateLabel awakeFromNib];
    
    itemCodeLabel = [[CustomLabel alloc] init];
    [itemCodeLabel awakeFromNib];

    hsnCodeLabel = [[CustomLabel alloc] init];
    [hsnCodeLabel awakeFromNib];
    
    discountLabel = [[CustomLabel alloc] init];
    [discountLabel awakeFromNib];

    flatDiscountLbl = [[CustomLabel alloc] init];
    [flatDiscountLbl awakeFromNib];

    taxLabel = [[CustomLabel alloc] init];
    [taxLabel awakeFromNib];
    
    poQtyLbl = [[CustomLabel alloc] init];
    [poQtyLbl awakeFromNib];
    
    poPriceLbl = [[CustomLabel alloc] init];
    [poPriceLbl awakeFromNib];

    freeQtyLbl = [[CustomLabel alloc] init];
    [freeQtyLbl awakeFromNib];
    
    delveredQtyLbl = [[CustomLabel alloc] init];
    [delveredQtyLbl awakeFromNib];

    noOfUnitsLbl = [[CustomLabel alloc] init];
    [noOfUnitsLbl awakeFromNib];
    
    mrpLbl = [[CustomLabel alloc] init];
    [mrpLbl awakeFromNib];
    
    delveredPriceLbl = [[CustomLabel alloc] init];
    [delveredPriceLbl awakeFromNib];
    
    netCostLbl = [[CustomLabel alloc] init];
    [netCostLbl awakeFromNib];
    
    itemHandledByLbl = [[CustomLabel alloc] init];
    [itemHandledByLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];

    //vendorIdsTbl creation...
    vendorIdsTbl = [[UITableView alloc] init];
    
    //employeesListTbl creation.......
    employeesListTbl = [[UITableView alloc] init];

    //searchOrderItemTbl creation...
    searchOrderItemTbl = [[UITableView alloc] init];
    searchOrderItemTbl.delegate = self;
    searchOrderItemTbl.dataSource = self;
    searchOrderItemTbl.layer.borderWidth = 1.0;
    searchOrderItemTbl.layer.cornerRadius = 4.0;
    searchOrderItemTbl.layer.borderColor = [UIColor blackColor].CGColor;
    searchOrderItemTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    
    //purchaseOrderRefNoTbl creation...
    purchaseOrderRefNoTbl = [[UITableView alloc] init];
    purchaseOrderRefNoTbl.layer.borderWidth = 1.0;
    purchaseOrderRefNoTbl.layer.cornerRadius = 4.0;
    purchaseOrderRefNoTbl.layer.borderColor = [UIColor blackColor].CGColor;
    purchaseOrderRefNoTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    purchaseOrderRefNoTbl.dataSource = self;
    purchaseOrderRefNoTbl.delegate = self;
    
    /**creating UIButton*/
    UIButton * cancelBtn;
    
    submitBtn = [[UIButton alloc] init];
    [submitBtn addTarget:self action:@selector(submitGRNOrder:) forControlEvents:UIControlEventTouchDown];
    submitBtn.layer.cornerRadius = 3.0f;
    submitBtn.backgroundColor = [UIColor grayColor];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    saveBtn = [[UIButton alloc] init];
    [saveBtn addTarget:self action:@selector(submitGRNOrder:) forControlEvents:UIControlEventTouchDown];
    saveBtn.layer.cornerRadius = 3.0f;
    saveBtn.backgroundColor = [UIColor grayColor];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(cancelupdateGRNOrder:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.backgroundColor = [UIColor grayColor];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    //bottam display view related..
//    totalInventoryView = [[UIView alloc]init];
//    totalInventoryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
//    totalInventoryView.layer.borderWidth =3.0f;
//
//    taxView = [[UIView alloc]init];
//    taxView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
//    taxView.layer.borderWidth =3.0f;
    
    bottamDispalyView = [[UIView alloc] init];
    bottamDispalyView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    bottamDispalyView.layer.borderWidth =3.0f;

    
    UILabel * subTotalLbl;
    UILabel * itemLevelDiscountLbl;
    UILabel * taxLbl;

    UILabel * shipmentLbl;
    UILabel * totalDiscountLbl;
    UILabel * totalInvoiceDiscountLbl;
    
    UILabel * totalCostLbl;
    UILabel * totalInvoiceLbl;
    UILabel * totalInvoiceGrossLbl;

    UILabel * dummyLbl_1;
    UILabel * dummyLbl_2;
    dummyLbl_1 = [[UILabel alloc] init];
    dummyLbl_1.backgroundColor = [UIColor blackColor];
    dummyLbl_2 = [[UILabel alloc] init];
    dummyLbl_2.backgroundColor = [UIColor blackColor];
    
    
    subTotalLbl = [[UILabel alloc] init];
    subTotalLbl.layer.masksToBounds = YES;
    subTotalLbl.numberOfLines = 1;
    subTotalLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    subTotalLbl.textAlignment = NSTextAlignmentLeft;

    itemLevelDiscountLbl = [[UILabel alloc] init];
    itemLevelDiscountLbl.layer.masksToBounds = YES;
    itemLevelDiscountLbl.numberOfLines = 1;
    itemLevelDiscountLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    itemLevelDiscountLbl.textAlignment = NSTextAlignmentLeft;
    
    taxLbl = [[UILabel alloc] init];
    taxLbl.layer.masksToBounds = YES;
    taxLbl.numberOfLines = 1;
    taxLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    taxLbl.textAlignment = NSTextAlignmentLeft;

    shipmentLbl = [[UILabel alloc] init];
    shipmentLbl.layer.masksToBounds = YES;
    shipmentLbl.numberOfLines = 1;
    shipmentLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    shipmentLbl.textAlignment = NSTextAlignmentLeft;

    totalDiscountLbl = [[UILabel alloc] init];
    totalDiscountLbl.layer.masksToBounds = YES;
    totalDiscountLbl.numberOfLines = 1;
    totalDiscountLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalDiscountLbl.textAlignment = NSTextAlignmentLeft;

    totalInvoiceDiscountLbl = [[UILabel alloc] init];
    totalInvoiceDiscountLbl.layer.masksToBounds = YES;
    totalInvoiceDiscountLbl.numberOfLines = 1;
    totalInvoiceDiscountLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalInvoiceDiscountLbl.textAlignment = NSTextAlignmentLeft;
    
    totalCostLbl = [[UILabel alloc] init];
    totalCostLbl.layer.masksToBounds = YES;
    totalCostLbl.numberOfLines = 1;
    totalCostLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalCostLbl.textAlignment = NSTextAlignmentLeft;
    
    totalInvoiceLbl = [[UILabel alloc] init];
    totalInvoiceLbl.layer.masksToBounds = YES;
    totalInvoiceLbl.numberOfLines = 1;
    totalInvoiceLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalInvoiceLbl.textAlignment = NSTextAlignmentLeft;
    
    totalInvoiceGrossLbl = [[UILabel alloc] init];
    totalInvoiceGrossLbl.layer.masksToBounds = YES;
    totalInvoiceGrossLbl.numberOfLines = 1;
    totalInvoiceGrossLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalInvoiceGrossLbl.textAlignment = NSTextAlignmentLeft;

    //right side display part....
    subTotalValueLbl = [[UILabel alloc] init];
    subTotalValueLbl.layer.masksToBounds = YES;
    subTotalValueLbl.numberOfLines = 1;
    subTotalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    subTotalValueLbl.textAlignment = NSTextAlignmentRight;
    
    itemLevelDiscountValueLbl = [[UILabel alloc] init];
    itemLevelDiscountValueLbl.layer.masksToBounds = YES;
    itemLevelDiscountValueLbl.numberOfLines = 1;
    itemLevelDiscountValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    itemLevelDiscountValueLbl.textAlignment = NSTextAlignmentRight;
    
    taxValueLbl = [[UILabel alloc] init];
    taxValueLbl.layer.masksToBounds = YES;
    taxValueLbl.numberOfLines = 1;
    taxValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    taxValueLbl.textAlignment = NSTextAlignmentRight;

    shipmentValueTxt = [[UITextField alloc] init];
    shipmentValueTxt.borderStyle = UITextBorderStyleRoundedRect;
    shipmentValueTxt.keyboardType = UIKeyboardTypeNumberPad;
    shipmentValueTxt.layer.borderWidth = 1;
    shipmentValueTxt.backgroundColor = [UIColor blackColor];
    shipmentValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentValueTxt.returnKeyType = UIReturnKeyDone;
    shipmentValueTxt.delegate = self;
    [shipmentValueTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    shipmentValueTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    shipmentValueTxt.textAlignment = NSTextAlignmentRight;

    totalDiscountValueTxt = [[UITextField alloc] init];
    totalDiscountValueTxt.borderStyle = UITextBorderStyleRoundedRect;
    totalDiscountValueTxt.keyboardType = UIKeyboardTypeNumberPad;
    totalDiscountValueTxt.layer.borderWidth = 1;
    totalDiscountValueTxt.backgroundColor = [UIColor blackColor];
    totalDiscountValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    totalDiscountValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    totalDiscountValueTxt.returnKeyType = UIReturnKeyDone;
    totalDiscountValueTxt.delegate = self;
    totalDiscountValueTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalDiscountValueTxt.textAlignment = NSTextAlignmentRight;

    totalInvoiceDiscountValLbl = [[UILabel alloc] init];
    totalInvoiceDiscountValLbl.layer.masksToBounds = YES;
    totalInvoiceDiscountValLbl.numberOfLines = 1;
    totalInvoiceDiscountValLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalInvoiceDiscountValLbl.textAlignment = NSTextAlignmentRight;
    
    totalCostValueLbl = [[UILabel alloc] init];
    totalCostValueLbl.layer.masksToBounds = YES;
    totalCostValueLbl.numberOfLines = 1;
    totalCostValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalCostValueLbl.textAlignment = NSTextAlignmentRight;
    
    totalInvoiceValueTxt = [[UITextField alloc] init];
    totalInvoiceValueTxt.borderStyle = UITextBorderStyleRoundedRect;
    totalInvoiceValueTxt.keyboardType = UIKeyboardTypeNumberPad;
    totalInvoiceValueTxt.layer.borderWidth = 1;
    totalInvoiceValueTxt.backgroundColor = [UIColor blackColor];
    totalInvoiceValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    totalInvoiceValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    totalInvoiceValueTxt.returnKeyType = UIReturnKeyDone;
    totalInvoiceValueTxt.delegate = self;
    totalInvoiceValueTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalInvoiceValueTxt.textAlignment = NSTextAlignmentRight;

    totalInvoiceGrossValueLbl = [[UILabel alloc] init];
    totalInvoiceGrossValueLbl.layer.masksToBounds = YES;
    totalInvoiceGrossValueLbl.numberOfLines = 1;
    totalInvoiceGrossValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalInvoiceGrossValueLbl.textAlignment = NSTextAlignmentRight;

    //requestedItemsTbl creation...
    requestedItemsTbl = [[UITableView alloc] init];
    requestedItemsTbl.backgroundColor  = [UIColor clearColor];
    requestedItemsTbl.layer.cornerRadius = 4.0;
    requestedItemsTbl.bounces = TRUE;
    requestedItemsTbl.dataSource = self;
    requestedItemsTbl.delegate = self;
    requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
     //Added By Bhargav.v on 06/06/2018...
    
    //crete switch for search....
    isSearch = [[UISwitch alloc] init];
    [isSearch addTarget:self action:@selector(changeSwitchAction:) forControlEvents:UIControlEventValueChanged];
    isSearch.onTintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    isSearch.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [isSearch setOn:YES];
    //[isSearch setThumbTintColor:[UIColor purpleColor]];
    
    searchBarcodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD2 = [UIImage imageNamed:@"searchImage.png"];
    [searchBarcodeBtn setBackgroundImage:buttonImageDD2 forState:UIControlStateNormal];
    [searchBarcodeBtn addTarget:self
                         action:@selector(searchBarcode:) forControlEvents:UIControlEventTouchDown];
    searchBarcodeBtn.tag = 1;
    searchBarcodeBtn.hidden = YES;

    
    @try {
        
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        headerNameLbl.text = NSLocalizedString(@"goods_receipt_note", nil);
        
        //-*-*-*-*
        sNoLbl.text = NSLocalizedString(@"s_no", nil);
        skuIdLbl.text = NSLocalizedString(@"item_id", nil);
        descriptionLbl.text = NSLocalizedString(@"item_desc", nil);
        uomLbl.text = NSLocalizedString(@"uom", nil);

        BatchNoLabel.text = NSLocalizedString(@"batch", nil);
        expDateLabel.text = NSLocalizedString(@"exp_date", nil);
        itemCodeLabel.text = NSLocalizedString(@"item_code", nil);
        hsnCodeLabel.text  = NSLocalizedString(@"hsnCode",nil);
        discountLabel.text = NSLocalizedString(@"discount",nil);
        flatDiscountLbl.text  = NSLocalizedString(@"falt_disc",nil);
        taxLabel.text = NSLocalizedString(@"tax%",nil);

        poQtyLbl.text = NSLocalizedString(@"po_qty", nil);
        poPriceLbl.text = NSLocalizedString(@"po_price", nil);
        freeQtyLbl.text = NSLocalizedString(@"free_qty", nil);
        delveredQtyLbl.text = NSLocalizedString(@"divrd_qty", nil);
        noOfUnitsLbl.text = NSLocalizedString(@"no_of_units", nil);
        mrpLbl.text = NSLocalizedString(@"mrp", nil);
        delveredPriceLbl.text = NSLocalizedString(@"divrd_price", nil);
        netCostLbl.text = NSLocalizedString(@"net_cost", nil);
        itemHandledByLbl.text = NSLocalizedString(@"handled_by", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        [submitBtn setTitle:NSLocalizedString(@"submit", nil) forState:UIControlStateNormal];
        [saveBtn setTitle:NSLocalizedString(@"save", nil) forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];

        subTotalLbl.text = NSLocalizedString(@"sub_total", nil);
        itemLevelDiscountLbl.text = NSLocalizedString(@"item_discount", nil);
        taxLbl.text = NSLocalizedString(@"tax", nil);
        
        shipmentLbl.text = NSLocalizedString(@"shipment_cost", nil);
        totalDiscountLbl.text = NSLocalizedString(@"invoice_discount", nil);
        totalInvoiceDiscountLbl.text = NSLocalizedString(@"total_discount", nil);
        
        totalCostLbl.text = NSLocalizedString(@"total_value", nil);
        totalInvoiceLbl.text = NSLocalizedString(@"total_invoice_value", nil);
        totalInvoiceGrossLbl.text = NSLocalizedString(@"total_gross", nil);

        subTotalValueLbl.text = @"0.00";
        itemLevelDiscountValueLbl.text = @"0.00";
        taxValueLbl.text = @"0.00";
       
        shipmentValueTxt.text = @"0.00";
        totalDiscountValueTxt.text = @"0.00";
        totalInvoiceDiscountValLbl.text = @"0.00";
        
        totalCostValueLbl.text  = @"0.00";
        totalInvoiceValueTxt.text = @"0.00";
        totalInvoiceGrossValueLbl.text = @"0.00";
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
        }
        else {
            
            self.view.frame = CGRectMake(0, 0, [ UIScreen mainScreen ].bounds .size.width, [ UIScreen mainScreen ].bounds .size.height);
        }
        
        float textFieldWidth  = 190;
        float textFieldHeight = 40;
        float labelheight = 35;
        float verticalGap = 10;
        float horizontalGap = 80;
        
        purchaseOrderView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        headerNameLbl.frame = CGRectMake( 0, 0, purchaseOrderView.frame.size.width, 45);
        
        
        //Added By Bhargav.v on 11/06/2018/...
        //Assiginin the Frames for the powaStatus Label..
        powaStatusLbl.frame = CGRectMake(headerNameLbl.frame.size.width - 270,headerNameLbl.frame.origin.y + 5, 130,40);
        powaStatusLblVal.frame = CGRectMake(powaStatusLbl.frame.origin.x + powaStatusLbl.frame.size.width + 5, powaStatusLbl.frame.origin.y, powaStatusLbl.frame.size.width,powaStatusLbl.frame.size.height);

        //Column 1:
        poRefNoTxt.frame = CGRectMake(10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, textFieldWidth, textFieldHeight);
        
        deliveredDateTxt.frame = CGRectMake(poRefNoTxt.frame.origin.x, poRefNoTxt.frame.origin.y + poRefNoTxt.frame.size.height + verticalGap, textFieldWidth, textFieldHeight);
        
        dueDateTxt.frame = CGRectMake(poRefNoTxt.frame.origin.x, deliveredDateTxt.frame.origin.y + deliveredDateTxt.frame.size.height + verticalGap, textFieldWidth, textFieldHeight);
        
        invoiceNumberTxt.frame = CGRectMake(poRefNoTxt.frame.origin.x, dueDateTxt.frame.origin.y + dueDateTxt.frame.size.height + verticalGap, textFieldWidth, textFieldHeight);
        
//        //Column:2
//        
        vendorIdTxt.frame = CGRectMake( poRefNoTxt.frame.origin.x + poRefNoTxt.frame.size.width + horizontalGap, poRefNoTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        supplierNameTxt.frame = CGRectMake( vendorIdTxt.frame.origin.x, deliveredDateTxt.frame.origin.y, textFieldWidth, textFieldHeight);

        indentRefNumberTxt.frame = CGRectMake( vendorIdTxt.frame.origin.x, invoiceNumberTxt.frame.origin.y, textFieldWidth, textFieldHeight);
//        //Column:3
      
        inspectedByTxt.frame = CGRectMake(vendorIdTxt.frame.origin.x + vendorIdTxt.frame.size.width +horizontalGap, poRefNoTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        receivedByTxt.frame = CGRectMake(inspectedByTxt.frame.origin.x, deliveredDateTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        deliveredByTxt.frame = CGRectMake(inspectedByTxt.frame.origin.x, dueDateTxt.frame.origin.y, textFieldWidth, textFieldHeight);

//        //Column:4
        
        locationTxt.frame = CGRectMake(inspectedByTxt.frame.origin.x + inspectedByTxt.frame.size.width +horizontalGap, poRefNoTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        submitedByTxt.frame = CGRectMake(locationTxt.frame.origin.x, deliveredDateTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        approvedByTxt.frame = CGRectMake(locationTxt.frame.origin.x, dueDateTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        //Frame For The UIButtons...
        
        dueDateBtn.frame = CGRectMake((dueDateTxt.frame.origin.x+dueDateTxt.frame.size.width-45), dueDateTxt.frame.origin.y+2, 40, 35);
        
        deliveryDateBtn.frame = CGRectMake((deliveredDateTxt.frame.origin.x+deliveredDateTxt.frame.size.width-45), deliveredDateTxt.frame.origin.y+2, 40, 35);
        
        vendorIdBtn.frame = CGRectMake( (vendorIdTxt.frame.origin.x + vendorIdTxt.frame.size.width - 45), vendorIdTxt.frame.origin.y - 8,  55, 60);
        
        inspectdByBtn.frame = CGRectMake( (inspectedByTxt.frame.origin.x + inspectedByTxt.frame.size.width - 45), inspectedByTxt.frame.origin.y - 8,  55, 60);
        
        receivedByBtn.frame = CGRectMake( (receivedByTxt.frame.origin.x + receivedByTxt.frame.size.width - 45), receivedByTxt.frame.origin.y - 8,  55, 60);
        
        searchItemsTxt.frame = CGRectMake( poRefNoTxt.frame.origin.x, invoiceNumberTxt.frame.origin.y + invoiceNumberTxt.frame.size.height + 15, locationTxt.frame.origin.x + locationTxt.frame.size.width - (poRefNoTxt.frame.origin.x + 80), 40);
        
        selectCategoriesBtn.frame = CGRectMake( (searchItemsTxt.frame.origin.x + searchItemsTxt.frame.size.width + 5), searchItemsTxt.frame.origin.y, 75, searchItemsTxt.frame.size.height);
        
        //Frame For the Buttons on The Bottom used for Service Calls....
        
        submitBtn.frame = CGRectMake( searchItemsTxt.frame.origin.x, purchaseOrderView.frame.size.height - 45, 100, 40);
        
        saveBtn.frame = CGRectMake( submitBtn.frame.origin.x + submitBtn.frame.size.width + 10, submitBtn.frame.origin.y, submitBtn.frame.size.width, submitBtn.frame.size.height);
        
        cancelBtn.frame = CGRectMake( saveBtn.frame.origin.x + saveBtn.frame.size.width + 10,submitBtn.frame.origin.y, submitBtn.frame.size.width, submitBtn.frame.size.height);
        
        //Frame for the UIView...
        bottamDispalyView.frame = CGRectMake( cancelBtn.frame.origin.x + cancelBtn.frame.size.width + 5, submitBtn.frame.origin.y - 50, (locationTxt.frame.origin.x + locationTxt.frame.size.width) - (cancelBtn.frame.origin.x + cancelBtn.frame.size.width + 5), 50  + submitBtn.frame.size.height);
       
        purchaseOrderScrollView.frame = CGRectMake( searchItemsTxt.frame.origin.x, searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height + 5, locationTxt.frame.origin.x + locationTxt.frame.size.width - searchItemsTxt.frame.origin.x, bottamDispalyView.frame.origin.y - (searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height + 5));
 
        //Custom Labels Frame....//-*-*-*-*
        sNoLbl.frame = CGRectMake(0, 0, 40, labelheight);
        skuIdLbl.frame = CGRectMake(sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 130,labelheight);
        descriptionLbl.frame = CGRectMake(skuIdLbl.frame.origin.x + skuIdLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 130,labelheight);
        uomLbl.frame = CGRectMake(descriptionLbl.frame.origin.x + descriptionLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 50, labelheight);
        BatchNoLabel.frame = CGRectMake(uomLbl.frame.origin.x + uomLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 80, labelheight);
        expDateLabel.frame = CGRectMake(BatchNoLabel.frame.origin.x + BatchNoLabel.frame.size.width + 2, sNoLbl.frame.origin.y, 130, labelheight);
        itemCodeLabel.frame = CGRectMake(expDateLabel.frame.origin.x + expDateLabel.frame.size.width + 2, sNoLbl.frame.origin.y, 120, labelheight);
        hsnCodeLabel.frame  = CGRectMake(itemCodeLabel.frame.origin.x + itemCodeLabel.frame.size.width + 2, sNoLbl.frame.origin.y, 100, labelheight);
        discountLabel.frame = CGRectMake(hsnCodeLabel.frame.origin.x + hsnCodeLabel.frame.size.width + 2, sNoLbl.frame.origin.y, 80, labelheight);
        flatDiscountLbl.frame = CGRectMake(discountLabel.frame.origin.x + discountLabel.frame.size.width + 2, sNoLbl.frame.origin.y, 80, labelheight);
        taxLabel.frame = CGRectMake(flatDiscountLbl.frame.origin.x + flatDiscountLbl.frame.size.width + 2, flatDiscountLbl.frame.origin.y, 80, labelheight);
        poQtyLbl.frame = CGRectMake(taxLabel.frame.origin.x + taxLabel.frame.size.width + 2, sNoLbl.frame.origin.y, 70, labelheight);
        poPriceLbl.frame = CGRectMake(poQtyLbl.frame.origin.x + poQtyLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 80, labelheight);
        freeQtyLbl.frame = CGRectMake(poPriceLbl.frame.origin.x + poPriceLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 90, labelheight);
        delveredQtyLbl.frame = CGRectMake(freeQtyLbl.frame.origin.x + freeQtyLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 90, labelheight);
        noOfUnitsLbl.frame = CGRectMake(delveredQtyLbl.frame.origin.x + delveredQtyLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 100, labelheight);
        mrpLbl.frame = CGRectMake( noOfUnitsLbl.frame.origin.x + noOfUnitsLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 100, labelheight);
        delveredPriceLbl.frame = CGRectMake(mrpLbl.frame.origin.x + mrpLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 100, labelheight);
        netCostLbl.frame = CGRectMake(delveredPriceLbl.frame.origin.x + delveredPriceLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 80, labelheight);
        itemHandledByLbl.frame = CGRectMake(netCostLbl.frame.origin.x + netCostLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 110, labelheight);
        actionLbl.frame = CGRectMake(itemHandledByLbl.frame.origin.x + itemHandledByLbl.frame.size.width + 2, sNoLbl.frame.origin.y, 60, labelheight);

        requestedItemsTbl.frame = CGRectMake( 0, sNoLbl.frame.origin.y + sNoLbl.frame.size.height, actionLbl.frame.origin.x + actionLbl.frame.size.width, purchaseOrderScrollView.frame.size.height - (sNoLbl.frame.origin.y + sNoLbl.frame.size.height));
        
        purchaseOrderScrollView.contentSize = CGSizeMake( requestedItemsTbl.frame.size.width,  purchaseOrderScrollView.frame.size.height);

        //bottam view labels....
        float gapBetweenEachLabel = 6;
        float eachLabelWidth = (bottamDispalyView.frame.size.width - (gapBetweenEachLabel * 4))/6;
        float firstColumnWidth = eachLabelWidth - 10;
        float secondColumnWidth = eachLabelWidth - 10;
        float thirdColumnWidth = eachLabelWidth + 25;
        float fourColumnWidth = eachLabelWidth - 15;
        float fiveColumnWidth = eachLabelWidth + 25;
        float sixColumnWidth = eachLabelWidth - 15;

        subTotalLbl.frame = CGRectMake( gapBetweenEachLabel, 0, firstColumnWidth, 30);
        itemLevelDiscountLbl.frame = CGRectMake( subTotalLbl.frame.origin.x, subTotalLbl.frame.origin.y + subTotalLbl.frame.size.height, subTotalLbl.frame.size.width, subTotalLbl.frame.size.height);
        taxLbl.frame = CGRectMake( subTotalLbl.frame.origin.x, itemLevelDiscountLbl.frame.origin.y + itemLevelDiscountLbl.frame.size.height, subTotalLbl.frame.size.width, subTotalLbl.frame.size.height);
        
        subTotalValueLbl.frame = CGRectMake( subTotalLbl.frame.origin.x + subTotalLbl.frame.size.width, subTotalLbl.frame.origin.y, secondColumnWidth, subTotalLbl.frame.size.height);
        itemLevelDiscountValueLbl.frame = CGRectMake( subTotalValueLbl.frame.origin.x, itemLevelDiscountLbl.frame.origin.y, subTotalValueLbl.frame.size.width, subTotalLbl.frame.size.height);
        taxValueLbl.frame = CGRectMake( subTotalValueLbl.frame.origin.x, taxLbl.frame.origin.y, subTotalValueLbl.frame.size.width, subTotalLbl.frame.size.height);

        shipmentLbl.frame = CGRectMake( subTotalValueLbl.frame.origin.x + subTotalValueLbl.frame.size.width + gapBetweenEachLabel, subTotalLbl.frame.origin.y, thirdColumnWidth, subTotalLbl.frame.size.height);
        totalDiscountLbl.frame = CGRectMake( shipmentLbl.frame.origin.x, itemLevelDiscountLbl.frame.origin.y, shipmentLbl.frame.size.width, subTotalLbl.frame.size.height);
        totalInvoiceDiscountLbl.frame = CGRectMake( shipmentLbl.frame.origin.x, taxLbl.frame.origin.y, shipmentLbl.frame.size.width, subTotalLbl.frame.size.height);
        
        shipmentValueTxt.frame = CGRectMake( shipmentLbl.frame.origin.x + shipmentLbl.frame.size.width, subTotalLbl.frame.origin.y + 2, fourColumnWidth - 2, subTotalLbl.frame.size.height - 4);
        totalDiscountValueTxt.frame = CGRectMake( shipmentValueTxt.frame.origin.x, itemLevelDiscountLbl.frame.origin.y + 2, shipmentValueTxt.frame.size.width, subTotalLbl.frame.size.height - 4);
        totalInvoiceDiscountValLbl.frame = CGRectMake( shipmentValueTxt.frame.origin.x, taxLbl.frame.origin.y, shipmentValueTxt.frame.size.width, subTotalLbl.frame.size.height);
        
        totalCostLbl.frame = CGRectMake( shipmentValueTxt.frame.origin.x + shipmentValueTxt.frame.size.width + gapBetweenEachLabel, subTotalLbl.frame.origin.y, fiveColumnWidth, subTotalLbl.frame.size.height);
        totalInvoiceLbl.frame = CGRectMake( totalCostLbl.frame.origin.x, itemLevelDiscountLbl.frame.origin.y, totalCostLbl.frame.size.width, subTotalLbl.frame.size.height);
        totalInvoiceGrossLbl.frame = CGRectMake( totalCostLbl.frame.origin.x, taxLbl.frame.origin.y, totalCostLbl.frame.size.width, subTotalLbl.frame.size.height);

        totalCostValueLbl.frame = CGRectMake( totalCostLbl.frame.origin.x + totalCostLbl.frame.size.width, subTotalLbl.frame.origin.y, sixColumnWidth, subTotalLbl.frame.size.height);
        totalInvoiceValueTxt.frame = CGRectMake( totalCostValueLbl.frame.origin.x, itemLevelDiscountLbl.frame.origin.y + 2, totalCostValueLbl.frame.size.width, subTotalLbl.frame.size.height - 4);
        totalInvoiceGrossValueLbl.frame = CGRectMake( totalCostValueLbl.frame.origin.x, taxLbl.frame.origin.y, totalCostValueLbl.frame.size.width, subTotalLbl.frame.size.height);
        
        dummyLbl_1.frame = CGRectMake( subTotalValueLbl.frame.origin.x + subTotalValueLbl.frame.size.width + 1, subTotalValueLbl.frame.origin.y, shipmentLbl.frame.origin.x - (subTotalValueLbl.frame.origin.x + subTotalValueLbl.frame.size.width + 2), bottamDispalyView.frame.size.height);
        dummyLbl_2.frame = CGRectMake( shipmentValueTxt.frame.origin.x + shipmentValueTxt.frame.size.width + 1, dummyLbl_1.frame.origin.y, totalCostLbl.frame.origin.x - (shipmentValueTxt.frame.origin.x + shipmentValueTxt.frame.size.width + 2), bottamDispalyView.frame.size.height);
        
        // Added By Bhargav.v to implement the Scannner functionality...
        isSearch.frame = CGRectMake(searchItemsTxt.frame.size.width - 85, searchItemsTxt.frame.origin.y + 3.5, 25, 25);
        searchBarcodeBtn.frame = CGRectMake(isSearch.frame.origin.x + isSearch.frame.size.width + 10,isSearch.frame.origin.y + 2, 30, 30);
    }
    
    [purchaseOrderView addSubview:headerNameLbl];
    
    
    //Recently Added By Bhargav.v to display the Scanner Status....
    //Date: 08/06/2018....
    [purchaseOrderView addSubview:powaStatusLbl];
    [purchaseOrderView addSubview:powaStatusLblVal];
    //upto here
    
    [purchaseOrderView addSubview:poRefNoTxt];
    [purchaseOrderView addSubview:dueDateTxt];
    [purchaseOrderView addSubview:deliveredDateTxt];
    [purchaseOrderView addSubview:vendorIdTxt];
    [purchaseOrderView addSubview:supplierNameTxt];
    [purchaseOrderView addSubview:inspectedByTxt];
    [purchaseOrderView addSubview:receivedByTxt];
    [purchaseOrderView addSubview:deliveredByTxt];
    [purchaseOrderView addSubview:locationTxt];
    [purchaseOrderView addSubview:submitedByTxt];
    [purchaseOrderView addSubview:approvedByTxt];
    [purchaseOrderView addSubview:invoiceNumberTxt];
    [purchaseOrderView addSubview:indentRefNumberTxt];

    [purchaseOrderView addSubview:vendorIdBtn];
    [purchaseOrderView addSubview:dueDateBtn];
    [purchaseOrderView addSubview:deliveryDateBtn];
    
    [purchaseOrderView addSubview:inspectdByBtn];
    [purchaseOrderView addSubview:receivedByBtn];
    
    [purchaseOrderView addSubview:searchItemsTxt];
    
    //Added By Bhargav.v on 09/06/2018..
    [purchaseOrderView addSubview:isSearch];
    [purchaseOrderView addSubview:searchBarcodeBtn];
    //Upto here...
    
    [purchaseOrderView addSubview:selectCategoriesBtn];
    
    [purchaseOrderView addSubview:submitBtn];
    [purchaseOrderView addSubview:saveBtn];
    [purchaseOrderView addSubview:cancelBtn];
    
    [bottamDispalyView addSubview:subTotalLbl];
    [bottamDispalyView addSubview:subTotalValueLbl];
    
    [bottamDispalyView addSubview:itemLevelDiscountLbl];
    [bottamDispalyView addSubview:itemLevelDiscountValueLbl];
    
    [bottamDispalyView addSubview:taxLbl];
    [bottamDispalyView addSubview:taxValueLbl];
    
    [bottamDispalyView addSubview:shipmentLbl];
    [bottamDispalyView addSubview:shipmentValueTxt];
    
    [bottamDispalyView addSubview:totalDiscountLbl];
    [bottamDispalyView addSubview:totalDiscountValueTxt];
    
    [bottamDispalyView addSubview:totalInvoiceDiscountLbl];
    [bottamDispalyView addSubview:totalInvoiceDiscountValLbl];
    
    [bottamDispalyView addSubview:totalCostLbl];
    [bottamDispalyView addSubview:totalCostValueLbl];
    
    [bottamDispalyView addSubview:totalInvoiceLbl];
    [bottamDispalyView addSubview:totalInvoiceValueTxt];
    
    [bottamDispalyView addSubview:totalInvoiceGrossLbl];
    [bottamDispalyView addSubview:totalInvoiceGrossValueLbl];
    
    [bottamDispalyView addSubview:dummyLbl_1];
    [bottamDispalyView addSubview:dummyLbl_2];
    
    [purchaseOrderView addSubview:bottamDispalyView];

    [purchaseOrderView addSubview:purchaseOrderScrollView];
    
    //-*-*-*-*
    [purchaseOrderScrollView addSubview:sNoLbl];
    [purchaseOrderScrollView addSubview:skuIdLbl];
    [purchaseOrderScrollView addSubview:descriptionLbl];
    [purchaseOrderScrollView addSubview:uomLbl];
    [purchaseOrderScrollView addSubview:BatchNoLabel];
    [purchaseOrderScrollView addSubview:expDateLabel];
    [purchaseOrderScrollView addSubview:itemCodeLabel];
    [purchaseOrderScrollView addSubview:hsnCodeLabel];
    [purchaseOrderScrollView addSubview:discountLabel];
    [purchaseOrderScrollView addSubview:flatDiscountLbl];
    [purchaseOrderScrollView addSubview:taxLabel];
    [purchaseOrderScrollView addSubview:poQtyLbl];
    [purchaseOrderScrollView addSubview:poPriceLbl];
    [purchaseOrderScrollView addSubview:freeQtyLbl];
    [purchaseOrderScrollView addSubview:delveredQtyLbl];
    [purchaseOrderScrollView addSubview:noOfUnitsLbl];
    [purchaseOrderScrollView addSubview:mrpLbl];
    [purchaseOrderScrollView addSubview:delveredPriceLbl];
    [purchaseOrderScrollView addSubview:netCostLbl];
    [purchaseOrderScrollView addSubview:itemHandledByLbl];
    [purchaseOrderScrollView addSubview:actionLbl];
    
    [purchaseOrderScrollView addSubview:requestedItemsTbl];
    
    [self.view addSubview:purchaseOrderView];
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];

    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    
    submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    saveBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    cancelBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

    // For Identification purpose..
    dueDateBtn.tag = 2;
    deliveryDateBtn.tag = 4;
    
    inspectdByBtn.tag = 2;
    receivedByBtn.tag = 4;
    
    if ((inspectedByTxt.text).length == 0 || (inspectedByTxt.text).length ){
       
        inspectedByTxt.text = firstName;
        receivedByTxt.text  = firstName;
    }
    
    submitBtn.tag = 4;
    saveBtn.tag = 2;
    
    //Allocation of NSMutableArrays...
    isItemTrackingRequiredArray = [[NSMutableArray alloc] init];
    costPriceEditableArray = [[NSMutableArray alloc]init];

}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidLoad.......
 * @date         06/10/2016
 * @method       viewDidAppear
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)viewDidAppear:(BOOL)animated {
    
    @try {
        
        if(requestedItemsInfoArr == nil) {
            requestedItemsInfoArr = [NSMutableArray new];
            
            shipmentCost   = 0;
            totalDiscounts = 0;
            vendorRating   = 0;
            
            [self provideCustomerRatingfor:0];
            
            if ((goodsReceiptRefID != nil))
                [self callingGetStockReceiptDetails];
        }
        
        //added by Bhargav.v on 08/06/2018.......
        isItemScanned = false;
        //upto here on 19/01/2017....

    }
    @catch (NSException *exception) {
        NSLog(@"----exception in serviceCall of callingGetStockReqeusts------------%@",exception);
    } @finally {
        
    }
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidAppear.......
 * @date         06/10/2016
 * @method       viewWillAppear
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (void)viewWillAppear:(BOOL)animated {
    
    //calling the superClass method.......
    [super viewWillAppear:YES];
}

#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         06/10/2016
 * @method       didReceiveMemoryWarning
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark start of UITableViewDelegateMethods

/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         10/09/2016
 * @method       tableView: numberOfRowsInSectionL
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @verified By
 * @verified On
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         10/09/2016
 * @method       tableView: numberOfRowsInSectionL
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @verified By
 * @verified On
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == requestedItemsTbl){

        [self calculateTotal:false];
        return  requestedItemsInfoArr.count;
    }
    else if(tableView == vendorIdsTbl)
        return vendorIdArr.count;
    
    else if(tableView == searchOrderItemTbl)
        return searchDisplayItemsArr.count;
    
    else if(tableView == purchaseOrderRefNoTbl)
        return  purchaseOrderRefNoArr.count;
    
    else if(tableView == employeesListTbl){
        
        
        return  employeesListArr.count;
    }
    
    else
        return 0;
}

/**
 * @description  it is tableViewDelegate method it will execute and return height in Table.....
 * @date         21/09/2016
 * @method       tableView: hegintForRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == requestedItemsTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 40;
        }
        else {
            return 150.0;
        }
    }
    
    else if(tableView == vendorIdsTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 40;
        }
        else {
            return 150.0;
        }
    }
    
    else if(tableView == searchOrderItemTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 40;
        }
        else {
            return 150.0;
        }
    }
    
    else if(tableView == purchaseOrderRefNoTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 40;
        }
        else {
            return 150.0;
        }
    }
    
    else if(tableView == employeesListTbl){
        return  40;
    }
    
    else
        return 0;
}

/* @description  It is TableViewDelegate Method in this method cellDislay can be changed....
 * @date         21/09/2016
 * @method       tableView: willDisplayCell: forRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    @try {
        
        if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && version >= 8.0 )|| (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
            
            // Remove seperator inset....
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                cell.separatorInset = UIEdgeInsetsZero;
            }
            
            // Prevent the cell from inheriting the Table View's margin settings....
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                cell.preservesSuperviewLayoutMargins = NO;
            }
            
            // Explictly set cell's layout margins....
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                cell.layoutMargins = UIEdgeInsetsZero;
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}



/**
 * @description  it is tableViewDelegate method it will execute and return cell in Table.....
 * @date         21/09/2016
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @return       UITableViewCell
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == requestedItemsTbl) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews) {
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        CAGradientLayer *layer_8;
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            @try {
                
                layer_8 = [CAGradientLayer layer];
                layer_8.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_8.frame = CGRectMake( sNoLbl.frame.origin.x, hlcell.frame.size.height - 2, actionLbl.frame.origin.x + actionLbl.frame.size.width - sNoLbl.frame.origin.x, 1);
                
                [hlcell.contentView.layer addSublayer:layer_8];
                
            } @catch (NSException * exception) {
                
            }
        }
        
        @try {
            
            UILabel *itemNoLbl;
            UILabel *itemIdLbl;
            UILabel *itemDescLbl;
            UILabel *itemUomLbl;
            
            UILabel *poQty_Lbl;
            
            UILabel *poPrice_Lbl;
            
            UILabel *netCost_Lbl;
            
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
            
            batchNoText = [[UITextField alloc] init];
            batchNoText.borderStyle = UITextBorderStyleRoundedRect;
            batchNoText.keyboardType = UIKeyboardTypeNumberPad;
            batchNoText.layer.borderWidth = 1;
            batchNoText.backgroundColor = [UIColor clearColor];
            batchNoText.autocorrectionType = UITextAutocorrectionTypeNo;
            batchNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
            batchNoText.returnKeyType = UIReturnKeyDone;
            batchNoText.delegate = self;
            batchNoText.textAlignment = NSTextAlignmentCenter;
            batchNoText.keyboardType = UIKeyboardTypeNumberPad;
            batchNoText.tag = indexPath.row;
            batchNoText.placeholder = NSLocalizedString(@"batch",nil);
            batchNoText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:batchNoText.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
            
            expDateText = [[UITextField alloc] init];
            expDateText.borderStyle = UITextBorderStyleRoundedRect;
            expDateText.keyboardType = UIKeyboardTypeNumberPad;
            expDateText.layer.borderWidth = 1;
            expDateText.backgroundColor = [UIColor clearColor];
            expDateText.autocorrectionType = UITextAutocorrectionTypeNo;
            expDateText.clearButtonMode = UITextFieldViewModeWhileEditing;
            expDateText.returnKeyType = UIReturnKeyDone;
            expDateText.delegate = self;
            expDateText.textAlignment = NSTextAlignmentCenter;
            expDateText.keyboardType = UIKeyboardTypeNumberPad;
            expDateText.tag = indexPath.row;
            expDateText.placeholder = NSLocalizedString(@"exp_date",nil);
            expDateText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:expDateText.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
            
            itemCodeText = [[UITextField alloc] init];
            itemCodeText.borderStyle = UITextBorderStyleRoundedRect;
            itemCodeText.keyboardType = UIKeyboardTypeNumberPad;
            itemCodeText.layer.borderWidth = 1;
            itemCodeText.backgroundColor = [UIColor clearColor];
            itemCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
            itemCodeText.clearButtonMode = UITextFieldViewModeWhileEditing;
            itemCodeText.returnKeyType = UIReturnKeyDone;
            itemCodeText.delegate = self;
            itemCodeText.textAlignment = NSTextAlignmentCenter;
            itemCodeText.keyboardType = UIKeyboardTypeNumberPad;
            itemCodeText.tag = indexPath.row;
            itemCodeText.placeholder = NSLocalizedString(@"item_code",nil);
            itemCodeText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:itemCodeText.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];

            hsnCodeText = [[UITextField alloc] init];
            hsnCodeText.borderStyle = UITextBorderStyleRoundedRect;
            hsnCodeText.keyboardType = UIKeyboardTypeNumberPad;
            hsnCodeText.layer.borderWidth = 1;
            hsnCodeText.backgroundColor = [UIColor clearColor];
            hsnCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
            hsnCodeText.clearButtonMode = UITextFieldViewModeWhileEditing;
            hsnCodeText.returnKeyType = UIReturnKeyDone;
            hsnCodeText.delegate = self;
            hsnCodeText.textAlignment = NSTextAlignmentCenter;
            hsnCodeText.keyboardType = UIKeyboardTypeNumberPad;
            hsnCodeText.tag = indexPath.row;
            hsnCodeText.placeholder = NSLocalizedString(@"hsnCode",nil);
            hsnCodeText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:hsnCodeText.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];

            discountText = [[UITextField alloc] init];
            discountText.borderStyle = UITextBorderStyleRoundedRect;
            discountText.keyboardType = UIKeyboardTypeNumberPad;
            discountText.layer.borderWidth = 1;
            discountText.backgroundColor = [UIColor clearColor];
            discountText.autocorrectionType = UITextAutocorrectionTypeNo;
            discountText.clearButtonMode = UITextFieldViewModeWhileEditing;
            discountText.returnKeyType = UIReturnKeyDone;
            discountText.delegate = self;
            discountText.textAlignment = NSTextAlignmentCenter;
            discountText.keyboardType = UIKeyboardTypeNumberPad;
            discountText.tag = indexPath.row;
            
            flatDiscountTxt = [[UITextField alloc] init];
            flatDiscountTxt.borderStyle = UITextBorderStyleRoundedRect;
            flatDiscountTxt.keyboardType = UIKeyboardTypeNumberPad;
            flatDiscountTxt.layer.borderWidth = 1;
            flatDiscountTxt.backgroundColor = [UIColor clearColor];
            flatDiscountTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            flatDiscountTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            flatDiscountTxt.returnKeyType = UIReturnKeyDone;
            flatDiscountTxt.delegate = self;
            flatDiscountTxt.textAlignment = NSTextAlignmentCenter;
            flatDiscountTxt.keyboardType = UIKeyboardTypeNumberPad;
            flatDiscountTxt.tag = indexPath.row;
            
            taxValueTxt = [[UITextField alloc] init];
            taxValueTxt.borderStyle = UITextBorderStyleRoundedRect;
            taxValueTxt.keyboardType = UIKeyboardTypeNumberPad;
            taxValueTxt.layer.borderWidth = 1;
            taxValueTxt.backgroundColor = [UIColor clearColor];
            taxValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            taxValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            taxValueTxt.returnKeyType = UIReturnKeyDone;
            taxValueTxt.delegate = self;
            taxValueTxt.textAlignment = NSTextAlignmentCenter;
            taxValueTxt.keyboardType = UIKeyboardTypeNumberPad;
            taxValueTxt.tag = indexPath.row;

            poQty_Lbl = [[UILabel alloc] init];
            poQty_Lbl.backgroundColor = [UIColor clearColor];
            poQty_Lbl.layer.borderWidth = 0;
            poQty_Lbl.textAlignment = NSTextAlignmentCenter;
            poQty_Lbl.numberOfLines = 1;
            poQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            poPrice_Lbl = [[UILabel alloc] init];
            poPrice_Lbl.backgroundColor = [UIColor clearColor];
            poPrice_Lbl.layer.borderWidth = 0;
            poPrice_Lbl.textAlignment = NSTextAlignmentCenter;
            poPrice_Lbl.numberOfLines = 1;
            poPrice_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            freeQtyTxt = [[UITextField alloc] init];
            freeQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            freeQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            freeQtyTxt.layer.borderWidth = 1;
            freeQtyTxt.backgroundColor = [UIColor clearColor];
            freeQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            freeQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            freeQtyTxt.returnKeyType = UIReturnKeyDone;
            freeQtyTxt.delegate = self;
            freeQtyTxt.textAlignment = NSTextAlignmentCenter;
            freeQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            freeQtyTxt.tag = indexPath.row;
            freeQtyTxt.userInteractionEnabled = YES;
            
            divrdQtyTxt = [[UITextField alloc] init];
            divrdQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            divrdQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            divrdQtyTxt.layer.borderWidth = 1;
            divrdQtyTxt.backgroundColor = [UIColor clearColor];
            divrdQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            divrdQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            divrdQtyTxt.returnKeyType = UIReturnKeyDone;
            divrdQtyTxt.delegate = self;
            divrdQtyTxt.textAlignment = NSTextAlignmentCenter;
            divrdQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            divrdQtyTxt.tag = indexPath.row;
            divrdQtyTxt.userInteractionEnabled = YES;
            
            noOfUnitsTxt = [[UITextField alloc] init];
            noOfUnitsTxt.borderStyle = UITextBorderStyleRoundedRect;
            noOfUnitsTxt.keyboardType = UIKeyboardTypeNumberPad;
            noOfUnitsTxt.layer.borderWidth = 1;
            noOfUnitsTxt.backgroundColor = [UIColor clearColor];
            noOfUnitsTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            noOfUnitsTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            noOfUnitsTxt.returnKeyType = UIReturnKeyDone;
            noOfUnitsTxt.delegate = self;
            noOfUnitsTxt.textAlignment = NSTextAlignmentCenter;
            noOfUnitsTxt.keyboardType = UIKeyboardTypeNumberPad;
            noOfUnitsTxt.tag = indexPath.row;
            noOfUnitsTxt.userInteractionEnabled = YES;

            mrpValueTxt = [[UITextField alloc] init];
            mrpValueTxt.borderStyle = UITextBorderStyleRoundedRect;
            mrpValueTxt.keyboardType = UIKeyboardTypeNumberPad;
            mrpValueTxt.layer.borderWidth = 1;
            mrpValueTxt.backgroundColor = [UIColor clearColor];
            mrpValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            mrpValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            mrpValueTxt.returnKeyType = UIReturnKeyDone;
            mrpValueTxt.delegate = self;
            mrpValueTxt.textAlignment = NSTextAlignmentCenter;
            mrpValueTxt.keyboardType = UIKeyboardTypeNumberPad;
            mrpValueTxt.tag = indexPath.row;
            mrpValueTxt.userInteractionEnabled = YES;
            
            divrdPriceTxt = [[UITextField alloc] init];
            divrdPriceTxt.borderStyle = UITextBorderStyleRoundedRect;
            divrdPriceTxt.keyboardType = UIKeyboardTypeNumberPad;
            divrdPriceTxt.layer.borderWidth = 1;
            divrdPriceTxt.backgroundColor = [UIColor clearColor];
            divrdPriceTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            divrdPriceTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            divrdPriceTxt.returnKeyType = UIReturnKeyDone;
            divrdPriceTxt.delegate = self;
            divrdPriceTxt.textAlignment = NSTextAlignmentCenter;
           //[divrdPriceTxt awakeFromNib];
            divrdPriceTxt.keyboardType = UIKeyboardTypeNumberPad;
            divrdPriceTxt.tag = indexPath.row;
            divrdPriceTxt.userInteractionEnabled = YES;
            
            
            netCost_Lbl = [[UILabel alloc] init];
            netCost_Lbl.backgroundColor = [UIColor clearColor];
            netCost_Lbl.layer.borderWidth = 0;
            netCost_Lbl.textAlignment = NSTextAlignmentCenter;
            netCost_Lbl.numberOfLines = 1;
            netCost_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemHandledByTxt = [[UITextField alloc] init];
            itemHandledByTxt.borderStyle = UITextBorderStyleRoundedRect;
            itemHandledByTxt.keyboardType = UIKeyboardTypeNumberPad;
            itemHandledByTxt.layer.borderWidth = 1;
            itemHandledByTxt.backgroundColor = [UIColor clearColor];
            itemHandledByTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            itemHandledByTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            itemHandledByTxt.returnKeyType = UIReturnKeyDone;
            itemHandledByTxt.delegate = self;
            itemHandledByTxt.tag = indexPath.row;
            itemHandledByTxt.userInteractionEnabled = NO;

            itemHandledByTxt.placeholder = NSLocalizedString(@"handled_by",nil);
            itemHandledByTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:itemHandledByTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
            
            UIButton  * handledByBtn;
            UIImage   * buttonImage_;
           
            buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];
            
            handledByBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [handledByBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
            [handledByBtn addTarget:self action:@selector(showListOfHandledByEmployees:) forControlEvents:UIControlEventTouchDown];
            handledByBtn.tag = indexPath.row;
            
            delRowBtn = [[UIButton alloc] init];
            [delRowBtn addTarget:self action:@selector(deleteItemFromList:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *image = [UIImage imageNamed:@"delete.png"];
            delRowBtn.tag = indexPath.row;
            [delRowBtn setBackgroundImage:image    forState:UIControlStateNormal];
            
            [hlcell.contentView addSubview:itemNoLbl];
            [hlcell.contentView addSubview:itemIdLbl];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemUomLbl];
            [hlcell.contentView addSubview:batchNoText];
            [hlcell.contentView addSubview:expDateText];
            [hlcell.contentView addSubview:itemCodeText];
            [hlcell.contentView addSubview:hsnCodeText];
            [hlcell.contentView addSubview:discountText];
            [hlcell.contentView addSubview:flatDiscountTxt];
            [hlcell.contentView addSubview:taxValueTxt];
            [hlcell.contentView addSubview:poQty_Lbl];
            [hlcell.contentView addSubview:poPrice_Lbl];
            [hlcell.contentView addSubview:freeQtyTxt];
            [hlcell.contentView addSubview:divrdQtyTxt];
            [hlcell.contentView addSubview:noOfUnitsTxt];
            [hlcell.contentView addSubview:mrpValueTxt];
            [hlcell.contentView addSubview:divrdPriceTxt];
            [hlcell.contentView addSubview:netCost_Lbl];
            [hlcell.contentView addSubview:delRowBtn];
            [hlcell.contentView addSubview:itemHandledByTxt];
            [hlcell.contentView addSubview:handledByBtn];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                itemNoLbl.frame = CGRectMake( sNoLbl.frame.origin.x, 0, sNoLbl.frame.size.width, hlcell.frame.size.height);
                itemIdLbl.frame = CGRectMake( skuIdLbl.frame.origin.x, 0, skuIdLbl.frame.size.width,  hlcell.frame.size.height);
                itemDescLbl.frame = CGRectMake( descriptionLbl.frame.origin.x, 0, descriptionLbl.frame.size.width,  hlcell.frame.size.height);
                itemUomLbl.frame = CGRectMake( uomLbl.frame.origin.x, 0, uomLbl.frame.size.width,  hlcell.frame.size.height);
                batchNoText.frame = CGRectMake(BatchNoLabel.frame.origin.x, 2, BatchNoLabel.frame.size.width - 2 ,  36);
                expDateText.frame = CGRectMake(expDateLabel.frame.origin.x, 2, expDateLabel.frame.size.width - 2 ,  36);
                itemCodeText.frame= CGRectMake(itemCodeLabel.frame.origin.x, 2, itemCodeLabel.frame.size.width - 2,  36);
                hsnCodeText.frame = CGRectMake(hsnCodeLabel.frame.origin.x, 2, hsnCodeLabel.frame.size.width - 2,  36);
                discountText.frame= CGRectMake( discountLabel.frame.origin.x, 2, discountLabel.frame.size.width - 2,  36);
                flatDiscountTxt.frame= CGRectMake( flatDiscountLbl.frame.origin.x, 2, flatDiscountLbl.frame.size.width - 2,  36);
                taxValueTxt.frame = CGRectMake( taxLabel.frame.origin.x, 2, taxLabel.frame.size.width - 2,  36);
                poQty_Lbl.frame   = CGRectMake( poQtyLbl.frame.origin.x, 0, poQtyLbl.frame.size.width,  hlcell.frame.size.height);
                poPrice_Lbl.frame = CGRectMake( poPriceLbl.frame.origin.x, 0, poPriceLbl.frame.size.width,  hlcell.frame.size.height);
                freeQtyTxt.frame = CGRectMake( freeQtyLbl.frame.origin.x + 1, 2, freeQtyLbl.frame.size.width - 2 ,  36);
                divrdQtyTxt.frame = CGRectMake( delveredQtyLbl.frame.origin.x + 1, 2, delveredQtyLbl.frame.size.width - 2 ,  36);
                noOfUnitsTxt.frame = CGRectMake( noOfUnitsLbl.frame.origin.x + 1, 2, noOfUnitsLbl.frame.size.width - 2 ,  36);
                mrpValueTxt.frame = CGRectMake( mrpLbl.frame.origin.x + 1, 2, mrpLbl.frame.size.width - 2 ,  36);
                divrdPriceTxt.frame = CGRectMake( delveredPriceLbl.frame.origin.x + 1, 2, delveredPriceLbl.frame.size.width - 2 ,  36);
                netCost_Lbl.frame = CGRectMake( netCostLbl.frame.origin.x, 0, netCostLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemHandledByTxt.frame = CGRectMake( itemHandledByLbl.frame.origin.x , 2, itemHandledByLbl.frame.size.width,  36);
                
                handledByBtn.frame = CGRectMake((itemHandledByTxt.frame.origin.x + itemHandledByTxt.frame.size.width - 40), itemHandledByTxt.frame.origin.y - 5,45,50);

                delRowBtn.frame =  CGRectMake( itemHandledByLbl.frame.origin.x + itemHandledByLbl.frame.size.width + 12, 2, 38,  38);
            }
            else{
               
                // DO CODING FOR IPHONE......
            }
            
            
            itemNoLbl.textColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemIdLbl.textColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemDescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemUomLbl.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            batchNoText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            expDateText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemCodeText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            hsnCodeText.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            discountText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            flatDiscountTxt.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            taxValueTxt.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            poQty_Lbl.textColor        = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            poPrice_Lbl.textColor      = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            freeQtyTxt.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            divrdQtyTxt.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            noOfUnitsTxt.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            mrpValueTxt.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            divrdPriceTxt.textColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            netCost_Lbl.textColor      = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemHandledByTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            batchNoText.layer.borderColor  =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            expDateText.layer.borderColor  =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemCodeText.layer.borderColor =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            hsnCodeText.layer.borderColor  =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            discountText.layer.borderColor =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            flatDiscountTxt.layer.borderColor  =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            taxValueTxt.layer.borderColor  =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            freeQtyTxt.layer.borderColor  =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            divrdQtyTxt.layer.borderColor   =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            noOfUnitsTxt.layer.borderColor   =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            mrpValueTxt.layer.borderColor   =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            divrdPriceTxt.layer.borderColor =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemHandledByTxt.layer.borderColor =   [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            //populating the data into table.......
            @try {

                NSMutableDictionary * dic = requestedItemsInfoArr[indexPath.row];
                
                itemNoLbl.text = [NSString stringWithFormat:@"%i", (int)(indexPath.row + 1) ];
                
                itemIdLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU]  defaultReturn:@""];
                itemDescLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESC]  defaultReturn:@""];
                itemUomLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM]  defaultReturn:@""];
                batchNoText.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:BATCH_NUM]  defaultReturn:@""];
                expDateText.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:EXPIRY_DATE_STR] componentsSeparatedByString:@" "][0] defaultReturn:@""];
                itemCodeText.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SCAN_CODE]  defaultReturn:@""];
                hsnCodeText.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:HSN_CODE]  defaultReturn:@""];
                discountText.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:GRN_ITEM_DISCOUNT]  defaultReturn:@"0.00"] floatValue]];
                flatDiscountTxt.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:FLAT_DISCOUNT]  defaultReturn:@"0.00"] floatValue] ];
                taxValueTxt.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:TAX_RATE]  defaultReturn:@"0.00"] floatValue]];
                freeQtyTxt.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:FREE_QTY]  defaultReturn:@"0.00"] floatValue]];
                poQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:ORDER_QTY]  defaultReturn:@"0.00"] floatValue]];
                poPrice_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:ORDER_PRICE]  defaultReturn:@"0.00"] floatValue]];
                divrdQtyTxt.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:SUPPLIED_QTY]  defaultReturn:@"0.00"] floatValue]];
                noOfUnitsTxt.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:Pack_Size]  defaultReturn:@"0.00"] floatValue]];
                mrpValueTxt.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:MAX_RETAIL_PRICE]  defaultReturn:@"0.00"] floatValue]];
                divrdPriceTxt.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:SUPPLY_PRICE]  defaultReturn:@"0.00"] floatValue]];
                netCost_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:TOTAL_COST]  defaultReturn:@"0.00"] floatValue]];
                itemHandledByTxt.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:HANDLED_BY]  defaultReturn:@""];
                
                //not needed..
//                if(![[dic valueForKey:SUPPLIED_QTY] isKindOfClass:[NSNull class]] &&  [dic.allKeys containsObject:SUPPLIED_QTY]){
//                    divrdQtyTxt.text = [NSString stringWithFormat:@"%.2f", [[dic valueForKey:SUPPLIED_QTY] floatValue]];
//                }
//                else {
//                    dic[SUPPLIED_QTY] = @"1";
//                    divrdQtyTxt.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:SUPPLIED_QTY] floatValue]];
//                    requestedItemsInfoArr[indexPath.row] = dic;
//                }
//                if(![[dic valueForKey:SUPPLY_PRICE] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:SUPPLY_PRICE]){
//
//                    divrdPriceTxt.text = [NSString stringWithFormat:@"%.2f", [[dic valueForKey:SUPPLY_PRICE] floatValue]];
//                }
//                else {
//                    dic[SUPPLY_PRICE] = [dic valueForKey:ORDER_PRICE];
//                    divrdPriceTxt.text = [NSString stringWithFormat:@"%.2f", [[dic valueForKey:SUPPLY_PRICE] floatValue]];
//                    requestedItemsInfoArr[indexPath.row] = dic;
//                }
                
            } @catch (NSException *exception) {
                
            }
        }
        @catch (NSException *exception) {
            
        } @finally {
            
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView: hlcell andSubViews:YES fontSize:16.0 cornerRadius:0.0];

            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.backgroundColor = [UIColor clearColor];
            return hlcell;
        }
    }
    
    else if(tableView == vendorIdsTbl) {
        
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
            hlcell.textLabel.numberOfLines = 1;
            //FIRM_NAME ---- SUPPLIER_CODE
            
            hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:[vendorIdArr[indexPath.row] valueForKey:SUPPLIER_NAME]  defaultReturn:@"--"];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    
    else if(tableView == searchOrderItemTbl) {
        
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
            
            if (searchDisplayItemsArr.count > indexPath.row){
                
                NSDictionary * dic = searchDisplayItemsArr[indexPath.row];
                
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
    
    else if(tableView == purchaseOrderRefNoTbl){
        
        //tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
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
            
            if(purchaseOrderRefNoArr.count > indexPath.row)
            hlcell.textLabel.text = purchaseOrderRefNoArr[indexPath.row];
            
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];

        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    else if( tableView == employeesListTbl){
        
        //        tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
        static NSString *CellIdentifier = @"employeeCell";
        
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
            
            
            hlcell.textLabel.text = employeesListArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
    }

    else{
        return nil;
        
        
    }
    
}

/**
 * @description  it is tableViewDelegate method it will execute. When an cell is selected in Table.....
 * @date         21/09/2016
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //dismissing teh catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
    
    if(tableView == vendorIdsTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            if(requestedItemsInfoArr == nil)
                requestedItemsInfoArr = [NSMutableArray new];
            else if(requestedItemsInfoArr.count)
                [requestedItemsInfoArr removeAllObjects];
            
            [requestedItemsTbl reloadData];
            
            vendorIdsTbl.tag = indexPath.row;
            
            if(vendorIdDic == nil)
                vendorIdDic = [NSMutableDictionary new];
            else if(vendorIdDic.count)
                [vendorIdDic removeAllObjects];
            
            vendorIdDic = [vendorIdArr[indexPath.row] mutableCopy];
            
            //NSDictionary *dic  = [vendorIdArr objectAtIndex:indexPath.row];
            
            vendorIdTxt.text = [self checkGivenValueIsNullOrNil:[vendorIdDic valueForKey:SUPPLIER_CODE] defaultReturn:@"-"];
            supplierNameTxt.text = [self checkGivenValueIsNullOrNil:[vendorIdDic valueForKey:SUPPLIER_NAME] defaultReturn:@"-"];
            
            //if(![[vendorIdDic valueForKey:RATING] isKindOfClass: [NSNull class]] &&  [[vendorIdDic allKeys] containsObject:RATING])
            //[self   provideCustomerRatingfor:[[vendorIdDic valueForKey:RATING] integerValue]];
            
            [self  provideCustomerRatingfor:(int)[[self checkGivenValueIsNullOrNil:[vendorIdDic valueForKey:RATING] defaultReturn:@"0"] integerValue]];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if(tableView == searchOrderItemTbl){
        
        //Changes Made Bhargav.v on 11/05/2018...
        //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
        //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
        
        NSDictionary * detailsDic = searchDisplayItemsArr[indexPath.row];
        
        NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[@"skuID"]];
        
        if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
            
            inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
        }
        
        [self callRawMaterialDetails:inputServiceStr];
        
        searchItemsTxt.text = @"";
    }
    else if(tableView == purchaseOrderRefNoTbl){
        
        @try {
            
            [self callingPurchaseOrderDetailsForId:purchaseOrderRefNoArr[indexPath.row]];
            
        } @catch (NSException *exception) {
            
            NSLog(@"---- exception while populating data in didSelectRowForIndexPah ----%@",exception);
        }
        @finally{
        
        }
        
    }
    
    else if(tableView == employeesListTbl ){
    
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            if(employeesListTbl.tag == -1) {
                
                inspectedByTxt.text = [self checkGivenValueIsNullOrNil:employeesListArr[indexPath.row] defaultReturn:@""];
            }
            
            else if(employeesListTbl.tag == -2) {
                
                receivedByTxt.text = [self checkGivenValueIsNullOrNil:employeesListArr[indexPath.row] defaultReturn:@""];
            }
            
            else {
                
                itemHandledByTxt.text = employeesListArr[indexPath.row];
                
                NSMutableDictionary * changeDic = requestedItemsInfoArr[employeesListTbl.tag];
                
                changeDic[HANDLED_BY] = itemHandledByTxt.text;
                
                requestedItemsInfoArr[employeesListTbl.tag] = changeDic;
                
                [requestedItemsTbl reloadData];
                
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
}

#pragma -mark Start of TextFieldDelegates.......

/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date         10/09/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    @try {
        
        if(textField.frame.origin.x == batchNoText.frame.origin.x || textField.frame.origin.x == expDateText.frame.origin.x ||textField.frame.origin.x  == itemCodeText.frame.origin.x || textField.frame.origin.x  == hsnCodeText.frame.origin.x || textField.frame.origin.x == discountText.frame.origin.x || textField.frame.origin.x == flatDiscountTxt.frame.origin.x || textField.frame.origin.x == taxValueTxt.frame.origin.x || textField.frame.origin.x == divrdQtyTxt.frame.origin.x || textField.frame.origin.x == freeQtyTxt.frame.origin.x || textField.frame.origin.x == noOfUnitsTxt.frame.origin.x || textField.frame.origin.x == mrpValueTxt.frame.origin.x || textField.frame.origin.x == divrdPriceTxt.frame.origin.x)
            
            didTableDataEditing = false;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return  YES;
}


/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Srinivasulu
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
        
        if (textField == searchItemsTxt) {
            
            offSetViewTo = 120;
        }
        else if(textField.frame.origin.x == batchNoText.frame.origin.x || textField.frame.origin.x == expDateText.frame.origin.x ||textField.frame.origin.x  == itemCodeText.frame.origin.x || textField.frame.origin.x  == hsnCodeText.frame.origin.x || textField.frame.origin.x == discountText.frame.origin.x || textField.frame.origin.x == flatDiscountTxt.frame.origin.x || textField.frame.origin.x == taxValueTxt.frame.origin.x || textField.frame.origin.x == freeQtyTxt.frame.origin.x || textField.frame.origin.x == divrdQtyTxt.frame.origin.x ||  textField.frame.origin.x == noOfUnitsTxt.frame.origin.x || textField.frame.origin.x == mrpValueTxt.frame.origin.x || textField.frame.origin.x == divrdPriceTxt.frame.origin.x){
            
            didTableDataEditing = true;
            
            [textField selectAll:nil];
            [UIMenuController sharedMenuController].menuVisible = NO;
            
            int count = (int)textField.tag;
            
            if(textField.tag > 7)
                count = 7;
            
            offSetViewTo = (textField.frame.origin.y + textField.frame.size.height) * count + requestedItemsTbl.frame.origin.y + 60;
        }
        else if (textField == shipmentValueTxt  || textField == totalDiscountValueTxt || textField == totalInvoiceValueTxt) {
            
            [textField selectAll:nil];
            [UIMenuController sharedMenuController].menuVisible = NO;

            offSetViewTo = 390;
        }
        
        @try {
            
            [self keyboardWillShow];
            
        } @catch (NSException *exception) {
            NSLog(@"----exception in the createNewPurchaseOrder in textFieldDidBeginEditing:----");
            NSLog(@"------exception while moving the self.view------%@",exception);
            
        }
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the createNewPurchaseOrder in textFieldDidBeginEditing:----");
        NSLog(@"------exception while moving the self.view------%@",exception);
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         06/09/2016
 * @method       textField:  shouldChangeCharactersInRange:  replacementString:
 * @author       Srinivasulu
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    @try {
        BOOL isToCheckDecimals = false;
        
        if (textField.frame.origin.x == discountText.frame.origin.x || textField.frame.origin.x == flatDiscountTxt.frame.origin.x || textField.frame.origin.x == taxValueTxt.frame.origin.x || textField.frame.origin.x == freeQtyTxt.frame.origin.x || textField.frame.origin.x == divrdQtyTxt.frame.origin.x || textField.frame.origin.x == freeQtyTxt.frame.origin.x || textField.frame.origin.x == noOfUnitsTxt.frame.origin.x || textField == shipmentValueTxt  || textField == totalDiscountValueTxt || textField == totalInvoiceValueTxt){
            
            isToCheckDecimals = true;
            
            //need to change this logic....
            if ((textField.frame.origin.x == divrdQtyTxt.frame.origin.x)){
                if (isItemTrackingRequiredArray.count > 0 && [isItemTrackingRequiredArray[textField.tag] boolValue]) {
                    
                    float y_axis = 300;
                    NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"sorry", nil),@"\n",NSLocalizedString(@"qty_cannot_be_editable", nil)];
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:320 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
                    return NO;
                }
            }
            else if ((textField.frame.origin.x == divrdPriceTxt.frame.origin.x)){
                if (costPriceEditableArray.count > 0 && [costPriceEditableArray[textField.tag] boolValue]) {
                    
                    float  y_axis = 300;
                    NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"sorry", nil),@"\n",NSLocalizedString(@"price_edit_is_not_allowed", nil)];
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:320 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
                    return NO;
                }
            }
        }
        else
            return  YES;
        
        
        
        if(isToCheckDecimals){
            
            @try {
                NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                NSString *expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
                NSError *error = nil;
                NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
                return numberOfMatches != 0;
            } @catch (NSException *exception) {
                return  YES;
                
                NSLog(@"----exception in CreateNewWareHouseGoodsReceiptNote ----");
                NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            }
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the CreateNewWareHouseGoodsReceiptNote in shouldChangeCharactersInRange:----");
        NSLog(@"------exception while return the number of character's------%@",exception);
        return  YES;
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

-(void)textFieldDidChange:(UITextField *)textField {
    
    @try {
        
        if (textField == searchItemsTxt) {
            
            if((vendorIdTxt.text).length == 0 || [vendorIdTxt.text isEqualToString:@""]){
                
                float y_axis = self.view.frame.size.height - 120;
                
                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_the_supplier_first",nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2 verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
                
                return;
            }
            else if (isSearch.on) {
                
                if ((textField.text).length >= 3) {
                    
                    @try {
                        if (searchItemsTxt.tag == 0) {
                            
                            searchItemsTxt.tag = (textField.text).length;
                            searchDisplayItemsArr = [[NSMutableArray alloc] init];
                            
                            searchString = [textField.text copy];
                            
                            [self searchProductsWithData:textField.text];
                        }
                        else{
                            [HUD setHidden:YES];
                            [catPopOver dismissPopoverAnimated:YES];
                        }
                        
                    } @catch (NSException *exception) {
                        [HUD setHidden:NO];
                        searchItemsTxt.tag = 0;
                        [catPopOver dismissPopoverAnimated:YES];
                        
                        NSLog(@"----exception in the createNewPurchaseOrder in textFieldDidChange:----");
                        NSLog(@"---- exception while calling getSuppliers ServicesCall ----%@",exception);
                    }
                }
            }
            
            else{
                [HUD setHidden:YES];
                searchItemsTxt.tag = 0;
                [catPopOver dismissPopoverAnimated:YES];
            }
        }
        else if(textField == poRefNoTxt) {
            
            if ((textField.text).length >= 3) {
                
                @try {
                    if ( poRefNoTxt.tag == 0) {
                        poRefNoTxt.tag = (textField.text).length;
                        
                        [self callingGetPurchaseOrderRefIds];
                        
                    }
                    else
                    {
                        [HUD setHidden:YES];
                        poRefNoTxt.tag = 0;
                        [catPopOver dismissPopoverAnimated:YES];
                    }
                    
                } @catch (NSException *exception) {
                    [HUD setHidden:NO];
                    poRefNoTxt.tag = 0;
                    [catPopOver dismissPopoverAnimated:YES];
                    
                    NSLog(@"----exception in the createNewPurchaseOrder in textFieldDidChange:----");
                    NSLog(@"---- exception while calling getSuppliers ServicesCall ----%@",exception);
                }
            }
        }
        //itemLevel related modifications...
        else if(textField.frame.origin.x == batchNoText.frame.origin.x) {
            
            @try {
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                [dic setValue:textField.text  forKey:BATCH_NUM];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if(textField.frame.origin.x == expDateText.frame.origin.x) {
            
            @try {
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                NSString * expDateStr = [NSString stringWithFormat:@"%@%@", textField.text,@" 00:00:00"];
                
                [dic setValue:expDateStr forKey:EXPIRY_DATE_STR];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if(textField.frame.origin.x == itemCodeText.frame.origin.x) {
            
            @try {
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                [dic setValue:textField.text  forKey:ITEM_SCAN_CODE];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if(textField.frame.origin.x == hsnCodeText.frame.origin.x) {
            
            @try {
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                [dic setValue:textField.text  forKey:HSN_CODE];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if((textField.frame.origin.x == discountText.frame.origin.x)) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [self validateAndSaveTheDiscountAmount:dic newDiscountValue:textField.text discountType:Percentage];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if((textField.frame.origin.x == discountText.frame.origin.x)) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [self validateAndSaveTheDiscountAmount:dic newDiscountValue:textField.text discountType:@""];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if(textField.frame.origin.x == taxValueTxt.frame.origin.x) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [self changeTaxRate:dic newTaxRate:textField.text];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch (NSException *exception) {
                
            }
        }
        else if (textField.frame.origin.x == freeQtyTxt.frame.origin.x) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                float supplyQty = [[self checkGivenValueIsNullOrNil:[dic valueForKey:SUPPLIED_QTY] defaultReturn:@"0.00"] floatValue];
                
                if(supplyQty > [textField.text floatValue]){
                    
                    float y_axis = 300;
                    NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"sorry", nil),@"\n",NSLocalizedString(@"free_qty_should_not_exceed_delivered_qty", nil)];
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:320 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
                }
                else{
                    
                    [dic setValue:textField.text  forKey:SUPPLIED_QTY];
                    requestedItemsInfoArr[textField.tag] = dic;
                }
            } @catch (NSException *exception) {
                
            }
        }
        else if (textField.frame.origin.x == divrdQtyTxt.frame.origin.x) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [dic setValue:textField.text  forKey:SUPPLIED_QTY];
                requestedItemsInfoArr[textField.tag] = dic;
            } @catch (NSException *exception) {
                
            }
        }
        else if(textField.frame.origin.x == divrdPriceTxt.frame.origin.x) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [dic setValue:textField.text  forKey:SUPPLY_PRICE];
                requestedItemsInfoArr[textField.tag] = dic;
            } @catch (NSException *exception) {
                
            }
        }
        else if (textField == shipmentValueTxt) {
            
            shipmentCost = (shipmentValueTxt.text).floatValue;
        }
        else if (textField == totalDiscountValueTxt) {
            
            totalDiscounts = (totalDiscountValueTxt.text).floatValue;
        }
        else if(textField == vendorIdTxt) {
            
            @try {
                
                if ((textField.text).length >= 3) {
                    if ( vendorIdTxt.tag == 0) {
                        
                        @try {
                            vendorIdsTbl.tag = 0;
                            vendorIdTxt.tag = (textField.text).length;
                            [self getSuppliers:vendorIdTxt.text];
                            
                        } @catch (NSException *exception) {
                            
                        }
                    }
                }
                else{
                    
                    [HUD setHidden:YES];
                    vendorIdTxt.tag = 0;
                    [catPopOver dismissPopoverAnimated:YES];
                }
            } @catch (NSException *exception) {
                
                NSLog(@"-------exception while displaying the calling supplier's-----%@",exception);
            }
        }
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the createNewPurchaseOrder in textFieldDidChange:----");
        NSLog(@"------exception while changing the qunatity || service Call------%@",exception);
    } @finally {

    }
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing....
 * @date         29/05/2016
 * @method       textFieldDidEndEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    @try {
        [self keyboardWillHide];
        offSetViewTo = 0;
        
        if(textField.frame.origin.x == batchNoText.frame.origin.x) {
            
            @try {
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                [dic setValue:textField.text  forKey:BATCH_NUM];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if(textField.frame.origin.x == expDateText.frame.origin.x) {
            
            @try {
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                NSString * expDateStr = [NSString stringWithFormat:@"%@%@", textField.text,@" 00:00:00"];
                
                [dic setValue:expDateStr forKey:EXPIRY_DATE_STR];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if(textField.frame.origin.x == itemCodeText.frame.origin.x) {
            
            @try {
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                [dic setValue:textField.text  forKey:ITEM_SCAN_CODE];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if(textField.frame.origin.x == hsnCodeText.frame.origin.x) {
            
            @try {
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                [dic setValue:textField.text  forKey:HSN_CODE];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if((textField.frame.origin.x == discountText.frame.origin.x)) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [self validateAndSaveTheDiscountAmount:dic newDiscountValue:textField.text discountType:Percentage];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if((textField.frame.origin.x == discountText.frame.origin.x)) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [self validateAndSaveTheDiscountAmount:dic newDiscountValue:textField.text discountType:@""];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch(NSException * exception) {
                
            }
        }
        else if(textField.frame.origin.x == taxValueTxt.frame.origin.x) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [self changeTaxRate:dic newTaxRate:textField.text];
                requestedItemsInfoArr[textField.tag] = dic;
            }
            @catch (NSException *exception) {
                
            }
        }
        else if (textField.frame.origin.x == freeQtyTxt.frame.origin.x) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                float supplyQty = [[self checkGivenValueIsNullOrNil:[dic valueForKey:SUPPLIED_QTY] defaultReturn:@"0.00"] floatValue];
                
                if(supplyQty < [textField.text floatValue]){
                    
                    float y_axis = 300;
                    NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"sorry", nil),@"\n",NSLocalizedString(@"free_qty_should_not_exceed_delivered_qty", nil)];
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 550)/2  verticalAxis:y_axis  msgType:@"" conentWidth:550 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
                }
                else{
                    
                    [dic setValue:textField.text  forKey:SUPPLIED_QTY];
                    requestedItemsInfoArr[textField.tag] = dic;
                }
            } @catch (NSException *exception) {
                
            }
        }
        else if (textField.frame.origin.x == divrdQtyTxt.frame.origin.x) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [dic setValue:textField.text  forKey:SUPPLIED_QTY];
                requestedItemsInfoArr[textField.tag] = dic;
            } @catch (NSException *exception) {
                
            }
        }
        else if(textField.frame.origin.x == divrdPriceTxt.frame.origin.x) {
            
            @try {
                
                NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
                [dic setValue:textField.text  forKey:SUPPLY_PRICE];
                requestedItemsInfoArr[textField.tag] = dic;
            } @catch (NSException *exception) {
                
            }
        }
        else if(textField == shipmentValueTxt) {
            
            shipmentCost = (shipmentValueTxt.text).floatValue;
            [self calculateTotal:false];
        }
        else if(textField == totalDiscountValueTxt) {
            
            totalDiscounts = (totalDiscountValueTxt.text).floatValue;
            [self calculateTotal:false];
        }
        else if(textField == totalInvoiceValueTxt) {
            
            totalInvoiceValueTxt.text = [NSString stringWithFormat:@"%.2f",(totalInvoiceValueTxt.text).floatValue];
            [self calculateTotal:false];
        }
    } @catch (NSException * exception) {
        NSLog(@"----exception in the createNewPurchaseOrder in textFieldDidChange:----");
        NSLog(@"------exception while return the number of character's------%@",exception);
    }
    @finally{
        
        if(didTableDataEditing){
            [requestedItemsTbl reloadData];
        }
    }
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
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
#pragma -mark alert view delegates

/**
 * @description  it UIAlertView Delegate method which will be called when alertView is clicked.....
 * @date         16/09/2016
 * @method       alertView: didDismissWithButonIndex:
 * @author       Srinivasulu
 * @param        UIAlertView
 * @param        NSInteger
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        if(alertView == successAlert){
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                
                //Do not forget to import AnOldViewController.h
                if ([controller isKindOfClass:[OmniHomePage class]]) {
                    
                    [self.navigationController popToViewController:controller
                                                          animated:YES];
                    break;
                }
            }
        }
        
        //added  by Srinivasulu on 20/04/2017....
        else if(alertView == offlineModeAlert){
            
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
            
            [self changeOperationMode:buttonIndex];
            //[super alertView:alertView didDismissWithButtonIndex:buttonIndex_];
        }
        
        else if (alertView == uploadConfirmationAlert)
        {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            [self syncOfflinebillsToOnline:buttonIndex];
            
        }
        //upto here on 28/04/2017...
        
        else
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma -mark providing the rating to vendor.......

/**
 * @description  callin
 * @date         03/11/2016
 * @method       provideCustomerRatingfor
 * @author       Srinivasulu
 * @param        noOfStar
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

//-(void)provideCustomerRatingfor:(NSString *)category
-(void)provideCustomerRatingfor:(int )noOfStar {
    
    @try {
        [starRat removeFromSuperview];
        starRat = [[UIImageView alloc] init];
        starRat.backgroundColor = [UIColor clearColor];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
           
            //if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            starRat.frame = CGRectMake( supplierNameTxt.frame.origin.x, dueDateTxt.frame.origin.y, supplierNameTxt.frame.size.width, supplierNameTxt.frame.size.height);
            //}
        }
        [purchaseOrderView addSubview:starRat];
        
        starRat.userInteractionEnabled = YES;
        
        
        [self ratingView:noOfStar outOf:5.0 imageView:starRat];
        
        //if ([category isEqualToString:kPREMIUM])
        //{
        //[self ratingView:5.0 outOf:5.0 imageView:starRat];
        //}
        //else if ([category isEqualToString:kGENERIC])
        //{
        //[self ratingView:4.0 outOf:5.0 imageView:starRat];
        //}
        //else if ([category isEqualToString:kPLUS])
        //{
        //[self ratingView:3.0 outOf:5.0 imageView:starRat];
        //}
        //else if ([category isEqualToString:kBASIC])
        //{
        //[self ratingView:2.5 outOf:5.0 imageView:starRat];
        //}
        //else if ([category isEqualToString:kNORMAL])
        //{
        //[self ratingView:2.0 outOf:5.0 imageView:starRat];
        //}
        //else
        //{
        //[self ratingView:0.0 outOf:5.0 imageView:starRat];
        //}
        
    } @catch (NSException *exception) {
        
    }
    
}


/**
 * @description  displaying the customer rating by changing the GUI .......
 * @date         31/10/2016
 * @method       ratingView:  outOf:   imageView:
 * @author       Srinivasulu
 * @param        double
 * @param        NSUInteger
 * @param        UIImageView
 * @return
 * @verified ByprovideCustomerRatingfor
 * @verified On
 *
 */
-(void )ratingView:(double)ratingValue outOf:(NSUInteger)totalValue imageView:(UIImageView *)view {
    
    @try {
        
        NSUInteger xPos = view.frame.origin.x;
        
        xPos = 0;
        
        if (ratingValue >= 5) {
            
            ratingValue = 5;
        }
        double tempRatingValue = ratingValue;
        UIImageView *starImageView ;
        for (NSUInteger currentStar=0; currentStar<totalValue; currentStar++) { // Looping for each star(imageView) in the KDRatingView
            
            //starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, view.frame.origin.y, view.frame.size.width/totalValue, view.frame.size.height)];
            
            //changed by Srinivasulu on 31/10/2016.......
            //xPos = 0;
            
            float gapBetweenStars = 50;
            
            starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, 4, (view.frame.size.width - gapBetweenStars)/(totalValue), view.frame.size.height - 8)];
            
            //upto here.......
            
            if (tempRatingValue-1>=0) {
                tempRatingValue--;
                // place one complete star
                starImageView.image = [UIImage imageNamed:@"1_star"];
                
            } else {
                if ((tempRatingValue>=0)&&(tempRatingValue<0.25)) {
                    // place 0 star
                    starImageView.image = [UIImage imageNamed:@"grey_star@2x.png"];
                    
                } else if ((tempRatingValue>=0.25)&&(tempRatingValue<0.50)) {
                    // place 1/4 star
                    starImageView.image = [UIImage imageNamed:@"14_star"];
                    
                } else if ((tempRatingValue>=0.50)&&(tempRatingValue<0.75)) {
                    // place 1/2 star
                    starImageView.image = [UIImage imageNamed:@"12_star"];
                    
                } else if ((tempRatingValue>=0.75)&&(tempRatingValue<1.0)) {
                    // place 3/4 star
                    starImageView.image = [UIImage imageNamed:@"34_star"];
                }
                
                tempRatingValue=0;
            }
            
            // set tag starImageView which will allow to identify and differentiate it individually in calling class.
            // Add starImageView to view as a subView
            
            
            //[purchaseOrderView    addSubview:starImageView];
            
            //changed by Srinivasulu on 31/10/2016.......
            [view    addSubview:starImageView];
            
            //upto here.......
            
            //added by Srinivasulu on  02/02/2017.....
            view.userInteractionEnabled = YES;
            
            starImageView.userInteractionEnabled = YES;
            starImageView.tag = currentStar + 1;
            
            UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
            singleTap.numberOfTapsRequired = 1;
            [starImageView addGestureRecognizer:singleTap];
            
            //upto here on 02/02/2017...
            
            // calculate new xPos and yPos
            xPos = xPos + (starImageView.frame.size.width) + gapBetweenStars/ (totalValue  - 1);
        }
        
    } @catch (NSException *exception) {
        
    }
}

#pragma -mark method added on 02/02/2017...

/**
 * @description  giving rating based for user interation....
 * @date         02/02/2017
 * @method       singleTapping
 * @author       Srinivasulu
 * @param        UIGestureRecognizer
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)singleTapping:(UIGestureRecognizer *)recognizer {
    @try {
        NSLog(@"image clicked");
        NSLog(@"---------------%li",recognizer.view.tag);
        
        if(vendorIdDic != nil){
            [self provideCustomerRatingfor:(int)recognizer.view.tag];
            [vendorIdDic setValue:[NSString stringWithFormat:@"%li", recognizer.view.tag] forKey:RATING];
            
        }
        else{
            
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_the_supplier_first", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 120 msgType:@""  conentWidth:350 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

#pragma -mark calling Service.......

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

-(void)getSuppliers:(NSString *)supplierNameStr {
    // BOOL status = FALSE;
    
    @try {
        
        [HUD setHidden:NO];
        
        if(vendorIdArr == nil)
            vendorIdArr = [NSMutableArray new];
        else if(vendorIdArr.count){
            
            [vendorIdArr removeAllObjects];
        }
        
        
        NSArray *keys = @[REQUEST_HEADER,PAGE_NO,SEARCH_CRITERIA];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,supplierNameStr];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.supplierServiceSvcDelegate = self;
        [webServiceController getSupplierDetailsData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        [catPopOver dismissPopoverAnimated:YES];
        NSLog(@"---- exception while calling getSuppliers ServicesCall ----%@",exception);
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        
    }
    
}
/**
 * @description  calling the service to get skuId....
 * @date         07/09/2016
 * @method       searchProductsWithData:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)searchProductsWithData:(NSString *)reqSearchString {
    
    @try {
        
        if(HUD.hidden)
            [HUD setHidden:NO];
        [self.view bringSubviewToFront:HUD];
        
        
        NSString *vendorID = @"";
        NSLog(@"-----%li",(long)vendorIdsTbl.tag);
        
        //if(vendorIdsTbl.tag != 0 && ([vendorIdArr count] >= vendorIdsTbl.tag )){
        
        vendorID =  [self checkGivenValueIsNullOrNil:vendorIdArr[vendorIdsTbl.tag][SUPPLIER_CODE]];
        
        //}
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,SEARCH_CRITERIA,STORELOCATION,PRODUCT_CATEGORY,OUTLET_ALL,WAREHOUSE_ALL,IS_TOTAL_COUNT_REQUIRED,@"supplierCode"];
        
        NSArray * objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,reqSearchString,presentLocation,EMPTY_STRING,@NO,@NO,@NO,vendorID];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.searchProductDelegate = self;
        [webServiceController warehouseSearchProducts:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while  searchProductWithData serviceCall ----%@",exception);
    }
}

/**
 * @description  .......
 * @date         21/09/2016
 * @method       callRawMaterialDetails
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)callRawMaterialDetails:(NSString *)pluCodeStr {
    
    @try {
        [HUD show:YES];
        [HUD setHidden: NO];
        
        NSMutableDictionary * productDetailsDic =  [[NSMutableDictionary alloc] init];
        
        //setting the Object for the Request Header....
        productDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        //setting the Boolean Value  as false...
        productDetailsDic[ZERO_STOCK_CHECK_AT_OUTLET_LEVEL] = [NSNumber numberWithBool:false];
        productDetailsDic[kIsEffectiveDateConsidered] = [NSNumber numberWithBool:false];
        productDetailsDic[REQUIRED_SUPP_PRODUCTS] = [NSNumber numberWithBool:false];
        productDetailsDic[BONEYARD_SUMMARY_FLAG] = [NSNumber numberWithBool:false];
        productDetailsDic[kZeroStockBillCheck] = [NSNumber numberWithBool:false];
        productDetailsDic[kIsApplyCampaigns] = [NSNumber numberWithBool:false];
        productDetailsDic[LATEST_CAMPAIGNS] = [NSNumber numberWithBool:false];
        productDetailsDic[kNotForDownload] = [NSNumber numberWithBool:false];
        productDetailsDic[WAREHOUSE_ALL] = [NSNumber numberWithBool:false];
        productDetailsDic[OUTLET_ALL] = [NSNumber numberWithBool:false];
        productDetailsDic[STORELOCATION] = presentLocation;
        productDetailsDic[START_INDEX] = NEGATIVE_ONE;
        productDetailsDic[ITEM_SKU] = pluCodeStr;
        
        NSError  *  err;
        NSData   *  jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString *  skuDetailsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:skuDetailsJsonString];
        
    }
    @catch (NSException * exception) {
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}


#pragma -mark service calls for searching the purchaseOrder reference number....

/**
 * @description  here we are calling the getPurchaseOrders of the  customer.......
 * @date         28/09/2016
 * @method       callingGetPurchaseOrderRefIds
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGetPurchaseOrderRefIds {
    
    @try {
        [HUD setHidden:NO];
        
        if(purchaseOrderRefNoArr == nil)
        purchaseOrderRefNoArr = [NSMutableArray new];
        
        else if(purchaseOrderRefNoArr.count)
                [purchaseOrderRefNoArr removeAllObjects];
        
        NSMutableDictionary * purchaseOrderDic = [[NSMutableDictionary alloc] init];
        
        purchaseOrderDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        purchaseOrderDic[ITEMS_FLAG] = @YES;

        purchaseOrderDic[SEARCH_CRITERIA] = poRefNoTxt.text;

        purchaseOrderDic[STORELOCATION] = presentLocation;
        
        purchaseOrderDic[ORDER_END_DATE] = EMPTY_STRING;
        
        purchaseOrderDic[START_INDEX] = NEGATIVE_ONE;
        
        purchaseOrderDic[SUPPLIER_Id] = EMPTY_STRING;
        
        purchaseOrderDic[ITEM_NAME] = EMPTY_STRING;
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:purchaseOrderDic options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.purchaseOrderSvcDelegate = self;
        [webServiceController getAllPurchaseOrdersRefIds:normalStockString];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
        
    } @finally {
        
    }
}

/**
 * @description  calling getStockRequests service..........
 * @date         19/09/2016
 * @method       callingPurchaseOrderDetails
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingPurchaseOrderDetailsForId:(NSString *)orderRefID {
    
    @try {
        [HUD setHidden:NO];
        
        
        NSArray * loyaltyKeys = @[PO_Ref,REQUEST_HEADER];
        
        NSArray * loyaltyObjects = @[[NSString stringWithFormat:@"%@",orderRefID],[RequestHeader getRequestHeader]];
        NSDictionary * dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        
        NSError  * err_;
        NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.purchaseOrderSvcDelegate = self;
        [webServiceController getPurchaseOrderDetails:normalStockString];
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in service Call------%@",exception);
    } @finally {
        
    }
}

#pragma -mark calling Service.......

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
 */

-(void)callingGetStockReceiptDetails{
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];

        
        NSArray * loyaltyKeys = @[RECEIPT_NOTE_ID,REQUEST_HEADER,START_INDEX];
        
        NSArray * loyaltyObjects = @[goodsReceiptRefID,[RequestHeader getRequestHeader],NEGATIVE_ONE];
        NSDictionary * dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError  * err_;
        NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
        [webServiceController getAllWarehouseGoodsReceiptNotes:normalStockString];
        
    } @catch (NSException * exception) {
        
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
 */

- (void)getWarehouseGoodsReceipNoteSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        isDraft = true;
        
        goodsReceiptNoteInfoDic = [NSMutableDictionary new];
        
        NSLog(@"--%@",successDictionary);
        
        goodsReceiptNoteInfoDic =  [[successDictionary valueForKey:GRN_OBJ] mutableCopy];
        
        //populating to firstColumn.......
        if(![[goodsReceiptNoteInfoDic valueForKey:Po_REF] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:Po_REF])
            poRefNoTxt.text = [goodsReceiptNoteInfoDic valueForKey:Po_REF];
        else
            poRefNoTxt.text = @"";
    
        
        if(![[goodsReceiptNoteInfoDic valueForKey:DUE_DATE_STR] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:DUE_DATE_STR])
            dueDateTxt.text = [[goodsReceiptNoteInfoDic valueForKey:DUE_DATE_STR] componentsSeparatedByString:@" "][0];
        
        if(![[goodsReceiptNoteInfoDic valueForKey:DELIVERED_ON_STR] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:DELIVERED_ON_STR])
            deliveredDateTxt.text =    [[goodsReceiptNoteInfoDic valueForKey:DELIVERED_ON_STR] componentsSeparatedByString:@" "][0];
        
        if(![[goodsReceiptNoteInfoDic valueForKey:LOCATION] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:LOCATION])
            locationTxt.text = [goodsReceiptNoteInfoDic valueForKey:LOCATION];
        
        else
            
            locationTxt.text = @"";
        
        vendorIdsTbl.tag = 0;
        
        if(vendorIdDic  == nil)
            vendorIdDic = [NSMutableDictionary new];
        
        [vendorIdDic setValue:[self checkGivenValueIsNullOrNil:[goodsReceiptNoteInfoDic valueForKey:SUPPLIER_ID]  defaultReturn:@""] forKey:SUPPLIER_ID];
        
        [vendorIdDic setValue:[self checkGivenValueIsNullOrNil:[goodsReceiptNoteInfoDic valueForKey:SUPPLIER_NAME]  defaultReturn:@""] forKey:SUPPLIER_NAME];
        
        vendorIdTxt.text = [vendorIdDic valueForKey:SUPPLIER_ID];
        
        supplierNameTxt.text = [goodsReceiptNoteInfoDic valueForKey:SUPPLIER_NAME];
        
        if(![[goodsReceiptNoteInfoDic valueForKey:VENDOR_RATING] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:VENDOR_RATING]){
            [self provideCustomerRatingfor:[[goodsReceiptNoteInfoDic valueForKey:VENDOR_RATING] intValue]];
            [vendorIdDic setValue:[goodsReceiptNoteInfoDic valueForKey:VENDOR_RATING] forKey:RATING];
            
        }
        
        //populating to thirdColumn.......
        if(![[goodsReceiptNoteInfoDic valueForKey:inspected_By] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:inspected_By])
            inspectedByTxt.text = [goodsReceiptNoteInfoDic valueForKey:inspected_By];
        
        
        if(![[goodsReceiptNoteInfoDic valueForKey:RECEIVED_BY] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:RECEIVED_BY])
            receivedByTxt.text =  [goodsReceiptNoteInfoDic valueForKey:RECEIVED_BY];
        
        if(![[goodsReceiptNoteInfoDic valueForKey:kDeliveredBy] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:kDeliveredBy])
            deliveredByTxt.text = [goodsReceiptNoteInfoDic valueForKey:kDeliveredBy];
        
        //populating to thirdColumn.......
        if(![[goodsReceiptNoteInfoDic valueForKey:SUBMITTED_BY] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:SUBMITTED_BY])
            submitedByTxt.text = [goodsReceiptNoteInfoDic valueForKey:SUBMITTED_BY];
        
        if(![[goodsReceiptNoteInfoDic valueForKey:APPROVED_BY] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:APPROVED_BY])
            approvedByTxt.text = [goodsReceiptNoteInfoDic valueForKey:APPROVED_BY];
        
        //added by Srinivasulu on 09/02/2017....
        if(![[goodsReceiptNoteInfoDic valueForKey:INVOICE_REF_NUMBER] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:INVOICE_REF_NUMBER])
            invoiceNumberTxt.text = [goodsReceiptNoteInfoDic valueForKey:INVOICE_REF_NUMBER];
        
        //-*-*-*-*
        if(![[goodsReceiptNoteInfoDic valueForKey:INVOICE_REF_NUMBER] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:INVOICE_REF_NUMBER])
            indentRefNumberTxt.text = [goodsReceiptNoteInfoDic valueForKey:INVOICE_REF_NUMBER];
        
        
        for(NSDictionary * dic in [goodsReceiptNoteInfoDic valueForKey:ITEMS_LIST]) {
            
            NSMutableDictionary * itemDetailsDic = [dic mutableCopy];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%@%@", [self checkGivenValueIsNullOrNil:[dic valueForKey:EXPIRY_DATE_STR] defaultReturn:@""],@" 00:00:00"] forKey:EXPIRY_DATE_STR];
            
            [requestedItemsInfoArr addObject:itemDetailsDic];
        }
        
        //APPROVED_BY,SUBMITTED_BY,kDeliveredBy,-------------approvedByTxt.text,submitedByTxt.text,deliveredByTxt.text,
        if(![[goodsReceiptNoteInfoDic valueForKey:APPROVED_BY] isKindOfClass: [NSNull class]] &&  [goodsReceiptNoteInfoDic.allKeys containsObject:APPROVED_BY])
            [self provideCustomerRatingfor:[[goodsReceiptNoteInfoDic valueForKey:VENDOR_RATING] intValue]];
        
        // newly added fields...
        shipmentValueTxt.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[goodsReceiptNoteInfoDic  valueForKey:SHIPMENT_CHARGES] defaultReturn:@"0.00"] floatValue]];
        
        totalDiscountValueTxt.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[goodsReceiptNoteInfoDic  valueForKey:TOTAL_BILL_DISCOUNT] defaultReturn:@"0.00"] floatValue]];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
    } @finally {
        
        [requestedItemsTbl reloadData];
        [HUD setHidden:YES];
    }
}


/**
 * @description  handling the getAllStockReceipt errorResponse
 * @date         31/10/2016
 * @method       getSupplieirsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getWarehouseGoodsReceipNotErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        
        [catPopOver dismissPopoverAnimated:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        
        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
    } @finally {
        
    }
}




#pragma -mark GRN delegate methods.......

/**
 * @description  here handling the service call of the getSuppliersSuccessResposne
 * @date         25/08/2016
 * @method       getSuppliersSuccesResponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSuppliersSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        // it was used when dropDown was implemented......
        
        for (NSDictionary *dic in successDictionary[SUPPLIERS]){
            
            NSMutableDictionary *tempDic = [NSMutableDictionary new];
            
            [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[SUPPLIER_CODE] defaultReturn:@"00"] forKey:SUPPLIER_CODE];
            [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[FIRM_NAME] defaultReturn:@"--"] forKey:SUPPLIER_NAME];
            [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[RATING] defaultReturn:@"--"] forKey:RATING];
            
            [vendorIdArr addObject:tempDic];
            
        }
        if(vendorIdArr.count == 0){
            
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
        }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while handling the getSuppliers SuccessResponse----%@",exception);
        
        
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
        
        //*******************------------------------
        //it is used for dropDown....
        
        
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
        
        //************---------------------
        //it used for search implementation.....
        
        
        //        if((vendorIdTxt.tag == [vendorIdTxt.text length])  && ([vendorIdTxt.text length] >= 3)){
        //
        //            [HUD setHidden:YES];
        //
        //            vendorIdTxt.tag = 0;
        //
        //
        //            [catPopOver dismissPopoverAnimated:YES];
        //
        //
        //            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorResponse message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
        //            //        [alert show];
        //
        //
        //            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        //
        //            //self.view.frame.size.height - 150 ------- (searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height)
        //            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        //
        //
        //        }
        //
        //        else{
        //
        //            vendorIdTxt.tag = 0;
        //
        //            [self textFieldDidChange:vendorIdTxt];
        //
        //        }
        
        
    } @catch (NSException *exception) {
        NSLog(@"---- exception while handling the getSuppliers ErrorResponse----%@",exception);
        
    } @finally {
        
    }
    
}

/**
 * @description  handling the sucessResponse received from the services.....
 * @date         07/09/2016
 * @method       searchProductsSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        //checking searchItemsFieldTag.......
        if (successDictionary != nil && (searchItemsTxt.tag == (searchItemsTxt.text).length) ) {
            
            //checking searchItemsFieldTag.......
            if (![successDictionary[PRODUCTS_LIST] isKindOfClass:[NSNull class]]  && [successDictionary.allKeys containsObject:PRODUCTS_LIST]) {
                
                for(NSDictionary *dic in [successDictionary valueForKey:PRODUCTS_LIST]){
                    
                    [searchDisplayItemsArr addObject:dic];
                }
            }
            
            if(searchDisplayItemsArr.count){
                float tableHeight = searchDisplayItemsArr.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = searchDisplayItemsArr.count * 33;
                
                if(searchDisplayItemsArr.count > 5)
                    tableHeight = (tableHeight/searchDisplayItemsArr.count) * 5;
                
                [self showPopUpForTables:searchOrderItemTbl  popUpWidth:searchItemsTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItemsTxt  showViewIn:purchaseOrderView permittedArrowDirections:UIPopoverArrowDirectionUp];
            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            searchItemsTxt.tag = 0;
            [HUD setHidden:YES];
        }
        
        else if ((((searchItemsTxt.text).length >= 3) && (searchItemsTxt.tag != 0)) && (searchItemsTxt.tag != (searchItemsTxt.text).length)) {
            
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
 * @description  handling the errorResponse received from the servicecalls....
 * @date         07/09/2016
 * @method       searchProductsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)searchProductsErrorResponse{
    @try {
        Boolean showView = false;
        
        if (((searchItemsTxt.text).length >= 3) && (searchItemsTxt.tag != 0) && (searchItemsTxt.tag != (searchItemsTxt.text).length)) {
            
            showView = false;
           
            searchItemsTxt.tag = 0;
            [self textFieldDidChange:searchItemsTxt];
        }
        else  if(catPopOver.popoverVisible ||  (searchItemsTxt.tag == (searchItemsTxt.text).length) ){
            
            showView = true;
            
            [catPopOver dismissPopoverAnimated:YES];
            searchItemsTxt.tag = 0;
            [HUD setHidden:YES];
        }
        else{
            
            showView = true;
            [catPopOver dismissPopoverAnimated:YES];
            searchItemsTxt.tag = 0;
            [HUD setHidden:YES];
        }
        
        if(showView){
            
            float y_axis = self.view.frame.size.height - 120;
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_records_found",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
    } @catch (NSException *exception) {
        // if([catPopOver isPopoverVisible])
        //   [catPopOver dismissPopoverAnimated:YES];
        searchItemsTxt.tag = 0;
        [HUD setHidden:YES];
        
        NSLog(@"---- Exception in CreateNewPurchaseOrder in --..-- getPurchaseOrderDetailsErrorResponse ----");
        NSLog(@"----exception in handling he search Success response ----%@",exception);
        
    } @finally {
    }
}

/**
 * @description handling the response received from the serviceCall....
 * @date        12/09/2016
 * @method      getSkuDetailsSuccessResponse		:
 * @author      Srinivasulu
 * @param       NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {

    @try {
        
        isItemScanned = false;
        searchItemsTxt.text = @"";
        
        if (successDictionary != nil) {
            
            BOOL status = FALSE;
            
            int i=0;
            NSMutableDictionary * dic;
            
            for (i=0; i<requestedItemsInfoArr.count; i++) {
                NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                if (itemArray.count > 0) {
                    
                    NSDictionary * itemdic = itemArray[0];
                    
                    dic = [requestedItemsInfoArr[i]  mutableCopy];
                    
                    if ([[dic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && ([[dic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]] || [[dic valueForKey:ITEM_ID] isEqualToString:[itemdic valueForKey:ITEM_ID]] || [[dic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:ITEM_ID]]) && (![isItemTrackingRequiredArray[i] boolValue])){
                        
                        [dic setValue:[NSString stringWithFormat:@"%.2f",[[dic valueForKey:SUPPLIED_QTY] floatValue] + 1] forKey:SUPPLIED_QTY];
                        
                        requestedItemsInfoArr[i] = dic;
                        
                        status = TRUE;
                        break;
                    }
                }
            }
            
            if (!status) {
                
                NSArray * itemArray = [successDictionary valueForKey:kSkuLists];
                if (itemArray.count > 0) {
                    NSDictionary *itemdic = itemArray[0];
                    
                    NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                    
                    /* -- skuId --  pluCode --  itemName -- itemDesc -- category -- itemScanCode -- productRange -- uom -- model -- measurementRange -- hsnCode -- handledBy --
                    -- costpriceEditable -- is_packed -- itemTaxExclusive -- trackingRequired-- taxationonDiscountPrice -- batchRequired
                    -- orderQty -- suppliedQty -- free_qty --
                    -- orderPrice --  supplyPrice -- mrp --
                    -- flat_discount -- itemDiscount --
                    -- totalCost --
                    -- taxRate -- totalTaxAmt -- itemTax
                    -- sgstRate -- sgstValue -- igstRate -- igstValue -- cgstRate -- cgstValue -- cessAmt -- cessRate
                    -- expiryDateStr -- bactchNum -- productBatchNo --*/

                    [itemDetailsDic setValue:[itemdic valueForKey:ITEM_SKU] forKey:ITEM_SKU];
                    [itemDetailsDic setValue:[itemdic valueForKey:PLU_CODE] forKey:PLU_CODE];
                    [itemDetailsDic setValue:[itemdic valueForKey:ITEM_DESCRIPTION] forKey:GOODS_RECEIPT_ITEM_NAME];
                    [itemDetailsDic setValue:[itemdic valueForKey:ITEM_DESCRIPTION] forKey:ITEM_DESC];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:HSN_CODE] defaultReturn:@""] forKey:HSN_CODE];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_BATCH_NO] defaultReturn:@""] forKey:BATCH_NUM];
                    [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                    [itemDetailsDic setValue:EMPTY_STRING forKey:MANUFACTURED_DATE_STR];

                    
                    NSString * expiryDteStr = [self checkGivenValueIsNullOrNil:[itemdic valueForKey:EXPIRY_DATE] defaultReturn:@""];
                    if(expiryDteStr.length){
                    expiryDteStr = [NSString stringWithFormat:@"%@%@", expiryDteStr, @" 00:00:00"];
                    [itemDetailsDic setValue:expiryDteStr forKey:EXPIRY_DATE_STR];
                    }
                    
                    //flag Info--
                    [itemDetailsDic setValue:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] intValue]] forKey:TRACKING_REQUIRED];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COST_PRICE_EDITABLE] defaultReturn:@"1"] intValue]] forKey:COST_PRICE_EDITABLE];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemTaxExclusive] defaultReturn:@"1"] intValue]] forKey:kItemTaxExclusive];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:1] forKey:kItemTaxExclusive];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kPackagedType] defaultReturn:@"0"] intValue]] forKey:IS_PACKED];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TAXATION_ON_DISCOUNT_PRICE] defaultReturn:@"0"] intValue]] forKey:TAXATION_ON_DISCOUNT_PRICE];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:BATCH_REQUIRED] defaultReturn:@"0"] intValue]] forKey:BATCH_REQUIRED];

                    
                    [isItemTrackingRequiredArray addObject:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] intValue]]];// need to be removed
                    [costPriceEditableArray addObject:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COST_PRICE_EDITABLE] defaultReturn:@"0"] intValue]]];// need to be removed

                    //prices related..
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:ITEM_PRICE] floatValue]] forKey:ORDER_PRICE];
                    [itemDetailsDic setValue:@"0.00" forKey:ORDER_PRICE];
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:ITEM_PRICE] floatValue]] forKey:SUPPLY_PRICE];
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:MAX_RETAIL_PRICE] floatValue]] forKey:MAX_RETAIL_PRICE];
                    
                    //qty related..
                    [itemDetailsDic setValue:@"0.00" forKey:ORDER_QTY];
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:SUPPLIED_QTY];
                    [itemDetailsDic setValue:@"0.00" forKey:FREE_QTY];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:Pack_Size] defaultReturn:@"1"] forKey:Pack_Size];

                    //discount related..
                    [itemDetailsDic setValue:@"0.00" forKey:GRN_ITEM_DISCOUNT];
                    [itemDetailsDic setValue:@"0.00" forKey:FLAT_DISCOUNT];
                    [itemDetailsDic setValue:@"0.00" forKey:GRN_ITEM_DISCOUNT];//needs to be removed
                    
                    //taxes related...
                    [itemDetailsDic setValue:@"0.00" forKey:SGST_RATE];
                    [itemDetailsDic setValue:@"0.00" forKey:SGST_VALUE];
                    
                    [itemDetailsDic setValue:@"0.00" forKey:CGST_RATE];
                    [itemDetailsDic setValue:@"0.00" forKey:CGST_VALUE];
                    
                    [itemDetailsDic setValue:@"0.00" forKey:IGST_RATE];
                    [itemDetailsDic setValue:@"0.00" forKey:IGST_VALUE];
                    
                    [itemDetailsDic setValue:@"0.00" forKey:CESS_RATE];
                    [itemDetailsDic setValue:@"0.00" forKey:CESS_AMOUNT];
                    
                    [itemDetailsDic setValue:@"0.00" forKey:TAX_RATE];
                    [itemDetailsDic setValue:@"0.00" forKey:ITEM_TAX];
                    [itemDetailsDic setValue:@"0.00" forKey:TOTAL_TAX_AMOUNT];
                    [itemDetailsDic setValue:@"0.00" forKey:TAX_RATE_STR];

                    NSArray * itemTaxArr;
                    if([[itemDetailsDic allKeys] containsObject:TAX] && ![[itemDetailsDic valueForKey:TAX] isKindOfClass:[NSNull class]]){
                        itemTaxArr = [itemDetailsDic valueForKey:TAX];
                    }
                    else{
                        itemTaxArr = [[NSArray alloc] init];
                    }
                    
                    [itemDetailsDic setValue:itemTaxArr forKey:TAX];
                    [itemDetailsDic setValue:@"0.00" forKey:TOTAL_COST];

                    [requestedItemsInfoArr addObject:itemDetailsDic];
                }
            }
            else
                requestedItemsInfoArr[i] = dic;
            
            //creating the successAlertSound.......
            SystemSoundID    soundFileObject1;
            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
            self.soundFileURLRef = (__bridge CFURLRef) tapSound;
            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
            AudioServicesPlaySystemSound (soundFileObject1);
        }
    }
    @catch (NSException * exception) {
       
        NSLog(@"-------exception will reading.-------%@",exception);
    }
    @finally{
        
        [requestedItemsTbl reloadData];
        [HUD setHidden:YES];
    }
}

/**
 * @description  here handling the errorResponse..........
 * @date         12/09/2016
 * @method       getSkuDetailsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSkuDetailsErrorResponse:(NSString *)failureString {
    @try {
        
        //added by Srinivasulu on 13/04/2017....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = [NSString stringWithFormat:@"%@",failureString];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        isItemScanned = false;
        searchItemsTxt.text = @"";
    }
}

/**
 * @description  handling the response from Service call of getPurchaseOrder.....
 * @date         25/08/2016
 * @method       getPurchaseOrdersSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createWarehouseGoodsReceipNoteSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [HUD setHidden:YES];
        
       float  y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;

        NSDictionary * successDic = [successDictionary valueForKey:RESPONSE_HEADER];
        
        NSString * mesg = [NSString stringWithFormat:@"%@",[successDic valueForKey:RESPONSE_MESSAGE]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis msgType:NSLocalizedString(@"success", nil)  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  hadling the error respone form service call of getPurchseOrder....
 * @date         25/08/2016
 * @method       createWarehouseGoodsReceipNoteErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @modified By  Bhargav.v on 11/01/2018 
 * @verified By
 * @verified On
 *
 */

- (void)createWarehouseGoodsReceipNoteErrorResponse:(NSString *)errorResponse{
    
    @try {
        //changed this buttons local to global. By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        [HUD setHidden:YES];
        
        float  y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 120 msgType:@"" conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  handling the error response received from the service.......
 * @date         03/11/2016
 * @method       updateWarehouseGoodsReceipNoteSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)updateWarehouseGoodsReceipNoteSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [HUD setHidden:YES];
        
        // if(.tag > 0){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@%@%@",NSLocalizedString(@"success", nil),@"\n",NSLocalizedString(@"goods_receipt_note_updated_successfully", nil),@"\n",goodsReceiptRefID];
            
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:(searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height)   msgType:NSLocalizedString(@"success", nil)  conentWidth:600 contentHeight:120  isSoundRequired:YES timming:2.0 noOfLines:4];
        //}
        // else{
        //
        //            NSString *mesg = [NSString stringWithFormat:@"%@%@%@%@%@",NSLocalizedString(@"", nil),@"\n",NSLocalizedString(@"item_updated_successfully", nil),@"\n",@""];
        // NSString *mesg = NSLocalizedString(@"item_updated_successfully", nil);
        
        
        // [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:(searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height)   msgType:NSLocalizedString(@"success", nil)  conentWidth:500 contentHeight:120  isSoundRequired:YES timming:2.0 noOfLines:1];
        // }
        
        
        
        
        
    } @catch (NSException *exception) {
        NSLog(@"-----------excepiton will handling the stockRequestUpdate response----------%@",exception);
        
    } @finally {
        [HUD setHidden:YES];
        
    }
    
}


/**
 * @description  handling the error response received from the service.......
 * @date         03/11/2016
 * @method       updateWarehouseGoodsReceipNoteErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)updateWarehouseGoodsReceipNoteErrorResponse:(NSString *)errorResponse{
    @try {
        
        [HUD setHidden:YES];
        
        float  y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 120 msgType:@"" conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        NSLog(@"-----------excepiton will handling the stockRequestUpdate error----------%@",exception);
        
    } @finally {
        
    }
    
}



#pragma -mark service calls responses for searching the purchaseOrder reference number....


/**
 * @description  here we are handling
 * @date         16/02/2017..
 * @method       getPORefIdsSuccessResponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getPORefIdsSuccessResponse:(NSDictionary *)successDictionary{

    @try {
        
        if (successDictionary != nil && (poRefNoTxt.tag == (poRefNoTxt.text).length)) {
            
            
            for(NSString *idStr in [successDictionary valueForKey:WH_PURCHASE_ORDER_REF_LIST]){
                
                [purchaseOrderRefNoArr addObject:idStr];
            }
            
            if(purchaseOrderRefNoArr.count){
                float tableHeight = purchaseOrderRefNoArr.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = purchaseOrderRefNoArr.count * 33;
                
                if(purchaseOrderRefNoArr.count > 5)
                    tableHeight = (tableHeight/purchaseOrderRefNoArr.count) * 5;
                
                [self showPopUpForTables:purchaseOrderRefNoTbl  popUpWidth:(poRefNoTxt.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:poRefNoTxt  showViewIn:purchaseOrderView];
            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            poRefNoTxt.tag = 0;
            [HUD setHidden:YES];
            
            
        }
        
        else if ( ((poRefNoTxt.text).length >= 3) && (poRefNoTxt.tag != 0) && (poRefNoTxt.tag != (poRefNoTxt.text).length)) {
            poRefNoTxt.tag = 0;
            [self textFieldDidChange:poRefNoTxt];
            
        }
        
        else  if(catPopOver.popoverVisible){
            [catPopOver dismissPopoverAnimated:YES];
            poRefNoTxt.tag = 0;
            [HUD setHidden:YES];
            
        }
        
        
        
    } @catch (NSException *exception) {
        
        [catPopOver dismissPopoverAnimated:YES];
        poRefNoTxt.tag = 0;
        [HUD setHidden:YES];
        
    } @finally {
        
        [HUD setHidden:YES];
        
    }
    
}

/**
 * @description  here we are handling the error response received from service call of getPOIds....
 * @date         16/02/2017..
 * @method       getPORefIdsErrorResponse
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)getPORefIdsErrorResponse:(NSString *)errorResponse{

    @try {
        
        Boolean showView = false;
        
        if ( ((poRefNoTxt.text).length >= 3) && (poRefNoTxt.tag != 0) && (poRefNoTxt.tag != (poRefNoTxt.text).length)) {
            
            showView = false;
            
            poRefNoTxt.tag = 0;
            [self textFieldDidChange:poRefNoTxt];
            
        }
        else  if(catPopOver.popoverVisible ||  (poRefNoTxt.tag == (poRefNoTxt.text).length) ){
            
            showView = true;
            
            [catPopOver dismissPopoverAnimated:YES];
            poRefNoTxt.tag = 0;
            //[HUD setHidden:YES];
            
        }
        else{
            
            showView = true;
            
            [catPopOver dismissPopoverAnimated:YES];
            poRefNoTxt.tag = 0;
            //[HUD setHidden:YES];
        }
        
        if(showView){
            
            [HUD setHidden:YES];
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];

        [catPopOver dismissPopoverAnimated:YES];
        poRefNoTxt.tag = 0;
    } @finally {
        
    }
}


/**
 * @description  hadling the error respone form service call of getPurchseOrder....
 * @date         28/09/2016
 * @method       getPurchaseOrderDetailsSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getPurchaseOrderDetailsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        //NSLog(@"---------%@",successDictionary);
        
        //populating the purhcase order information.......
        populateDic = [[successDictionary valueForKey:WH_PURCHASE_ORDER] mutableCopy];
        
        if(requestedItemsInfoArr == nil)
            requestedItemsInfoArr = [NSMutableArray new];
        else if(requestedItemsInfoArr.count)
            [requestedItemsInfoArr removeAllObjects];
        
        for(NSDictionary * locDic  in [successDictionary valueForKey:ITEM_DETAILS]){

            NSMutableDictionary * temp = [NSMutableDictionary new];
            
            if (![[locDic valueForKey:TRACKING_REQUIRED] boolValue]) {
            
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_ID] defaultReturn:@""] forKey:PLU_CODE];
               
                //Added Fields
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_DESC] defaultReturn:@""] forKey:GOODS_RECEIPT_ITEM_NAME];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:MEASUREMENT_RANGE] defaultReturn:@""]
                        forKey:MEASUREMENT_RANGE];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:kcategory] defaultReturn:@""] forKey:kcategory];
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:CGST_RATE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:CGST_RATE];
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:CGST_VALUE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:CGST_VALUE];
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:SGST_RATE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:SGST_RATE];
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:SGST_VALUE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:SGST_VALUE];


                //upto here
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_DESC] defaultReturn:@""] forKey:ITEM_DESC];
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:TRACKING_REQUIRED] defaultReturn:@""] forKey:TRACKING_REQUIRED];
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:HANDLED_BY] defaultReturn:@""] forKey:HANDLED_BY];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:HSN_CODE] defaultReturn:@""] forKey:HSN_CODE];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];

                [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:QUANTITY] defaultReturn:@""] forKey:ORDER_QTY];
                
                [temp setValue:[NSString stringWithFormat:@"%d",1] forKey:SUPPLIED_QTY];
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:iTEM_PRICE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:ORDER_PRICE];
                
                [temp setValue:[self checkGivenValueIsNullOrNil:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:iTEM_PRICE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] defaultReturn:@""] forKey:SUPPLY_PRICE];
               
                //Added on 27/07/2018...
                float totalCost = [[self checkGivenValueIsNullOrNil:[temp valueForKey:SUPPLY_PRICE] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[temp valueForKey:SUPPLIED_QTY] defaultReturn:@"0.00"] floatValue];
                
                [temp setValue:[NSString stringWithFormat:@"%.2f",totalCost] forKey:TOTAL_COST];
                
                [temp setValue:EMPTY_STRING forKey:HSN_CODE];
                
                [temp setValue:EMPTY_STRING forKey:EXPIRY_DATE_STR];
                
                [temp setValue:@"0.00" forKey:GRN_ITEM_DISCOUNT];
                //upto here...
               
                [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:TAX] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:ITEM_TAX];
            
                
                [requestedItemsInfoArr addObject:temp];

            }
            else {
                
                NSString * inputString = [NSString stringWithFormat:@"%@",[locDic valueForKey:QUANTITY]];
                int value = inputString.intValue;

                for (int i = 0;i < value; i++) {
                    
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_ID] defaultReturn:@""] forKey:PLU_CODE];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_DESC] defaultReturn:@""] forKey:ITEM_DESC];
                    
                    //Added Fields
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_DESC] defaultReturn:@""] forKey:GOODS_RECEIPT_ITEM_NAME];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:MEASUREMENT_RANGE] defaultReturn:@""]
                            forKey:MEASUREMENT_RANGE];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                    
                    [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:CGST_RATE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:CGST_RATE];
                    
                    [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:CGST_VALUE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:CGST_VALUE];
                    
                    [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:SGST_RATE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:SGST_RATE];
                    
                    [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:SGST_VALUE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:SGST_VALUE];

                    //upto here

                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:TRACKING_REQUIRED] defaultReturn:@""] forKey:TRACKING_REQUIRED];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:HANDLED_BY] defaultReturn:@""] forKey:HANDLED_BY];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:HSN_CODE] defaultReturn:@""] forKey:HSN_CODE];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                    [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:QUANTITY] defaultReturn:@""] forKey:ORDER_QTY];
                    [temp setValue:[NSString stringWithFormat:@"%d",1] forKey:SUPPLIED_QTY];
                    
                    [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:iTEM_PRICE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:ORDER_PRICE];
                  
                    [temp setValue:[self checkGivenValueIsNullOrNil:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:iTEM_PRICE] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] defaultReturn:@""] forKey:SUPPLY_PRICE];
                    
                    //Added on 27/07/2018...
                    float totalCost = [[self checkGivenValueIsNullOrNil:[temp valueForKey:SUPPLY_PRICE] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[temp valueForKey:SUPPLIED_QTY] defaultReturn:@"0.00"] floatValue];
                    
                    [temp setValue:[NSString stringWithFormat:@"%.2f",totalCost] forKey:TOTAL_COST];
                    
                    [temp setValue:EMPTY_STRING forKey:HSN_CODE];

                    [temp setValue:EMPTY_STRING forKey:EXPIRY_DATE_STR];
                    
                    [temp setValue:@"0.00" forKey:GRN_ITEM_DISCOUNT];

                    //upto here...
                    [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:TAX] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:ITEM_TAX];
                    
                    [requestedItemsInfoArr addObject:temp];

                }
            }
        }
        
        poRefNoTxt.text =    [self checkGivenValueIsNullOrNil:[populateDic valueForKey:PO_REF] defaultReturn:@""];
        submitedByTxt.text = [self checkGivenValueIsNullOrNil:[populateDic valueForKey:ORDER_SUBMITTED_BY] defaultReturn:@""];
        approvedByTxt.text = [self checkGivenValueIsNullOrNil:[populateDic valueForKey:ORDER_APPROVED_BY] defaultReturn:@""];
        
        //Allocation of VendorIdDictionary.....
        
        if(vendorIdDic  == nil)
            vendorIdDic = [NSMutableDictionary new];
        
        [vendorIdDic setValue:[self checkGivenValueIsNullOrNil:[populateDic valueForKey:SUPPLIER_Id]  defaultReturn:@""] forKey:SUPPLIER_ID];
        [vendorIdDic setValue:[self checkGivenValueIsNullOrNil:[populateDic valueForKey:SUPPLIER_Name]  defaultReturn:@""] forKey:SUPPLIER_NAME];
        
        vendorIdTxt.text = [vendorIdDic valueForKey:SUPPLIER_ID];
        
        supplierNameTxt.text = [vendorIdDic valueForKey:SUPPLIER_NAME];
        
        if(![[populateDic valueForKey:DELIVERY_DATE] isKindOfClass: [NSNull class]] &&  [populateDic.allKeys containsObject:DELIVERY_DATE]){
            deliveredDateTxt.text = [[populateDic valueForKey:DELIVERY_DATE] componentsSeparatedByString:@" "][0];
            
            NSDateFormatter * requiredDateFormat = [[NSDateFormatter alloc] init];
            requiredDateFormat.dateFormat = @"dd/MM/yyyy";
            
            NSDate *populateDate = [requiredDateFormat dateFromString:deliveredDateTxt.text];
            NSDate *dateString_2 = [self getDate:populateDate daysAhead:1];
            dueDateTxt.text = [requiredDateFormat stringFromDate:dateString_2];
            
        }
        
    } @catch (NSException *exception) {
        NSLog(@"------exception while handling the response getPUrchaseOrders-------%@",exception);
    } @finally {
    
        [requestedItemsTbl reloadData];
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

- (void)getPurchaseOrderDetailsErrorResponse:(NSString *)errorResponse {
    
    [HUD setHidden:YES];
    
    @try{
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

    }
    @catch(NSException * exception){
        
    }
    @finally{
        
    }
}



/**
 * @description  handling the response from Service call of getPurchaseOrder.....
 * @date         25/08/2016
 * @method       getPurchaseOrdersSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)getPurchaseOrdersSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        NSLog(@"-----%@",successDictionary);
        
        if ([[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == -1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
            
            [HUD setHidden:YES];
            
        }
        else{
            if(poRefNoTxt.tag == (poRefNoTxt.text).length){
                
                for(NSDictionary *dic  in [successDictionary valueForKey:ORDERS_LIST]){
                    
                    [purchaseOrderRefNoArr addObject:dic];
                }
                
                if(purchaseOrderRefNoArr.count){
                    float tableHeight = purchaseOrderRefNoArr.count * 40;
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                        tableHeight = purchaseOrderRefNoArr.count * 33;
                    
                    if(purchaseOrderRefNoArr.count > 5)
                        tableHeight = (tableHeight/purchaseOrderRefNoArr.count) * 5;
                    
                    [self showPopUpForTables:purchaseOrderRefNoTbl  popUpWidth:poRefNoTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:poRefNoTxt  showViewIn:purchaseOrderView];
                }
                else
                    [catPopOver dismissPopoverAnimated:YES];
                
                poRefNoTxt.tag = 0;
                [HUD setHidden:YES];
                
            }
            else {
                
                [self textFieldDidChange:poRefNoTxt];
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"---- exception while handling the getPurchase SuccessResponse----%@",exception);
        
    } @finally {
        
    }
    
}

/**
 * @description  hadling the error respone form service call of getPurchseOrder....
 * @date         25/08/2016
 * @method       getpurchaseOrdersErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getPurchaseOrdersErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        if( (poRefNoTxt.tag == (poRefNoTxt.text).length)){
            poRefNoTxt.tag = 0;
            [HUD setHidden:YES];
            if(purchaseOrderRefNoArr.count == 0){
                
                //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorResponse message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                //[alert show];
                
                NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:(searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height)   msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            }
        }
        else{
            [self textFieldDidChange:poRefNoTxt];
            
        }
        
    } @catch (NSException *exception) {
        NSLog(@"---- exception while handling the getSuppliers ErrorResponse----%@",exception);
        
    } @finally {
        
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

-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view {
    
    @try {
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height >= height) ){
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
        
        
        UITextField *textView = displayFrame;
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake( 0.0, 0.0, width, height)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        
        //tableName = [[UITableView alloc]init];
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
            
            [popover presentPopoverFromRect:textView.frame inView:view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            //customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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

/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         08/10/2016
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

-(void)showPopUpForTables:(UITableView *)tableName popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections{
    
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
        
        
        UITextView *textView = displayFrame;
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake( 0.0, 0.0, width, height)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        
        //tableName = [[UITableView alloc]init];
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
            
            //customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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

#pragma -mark calculating total.......

/**
 * @description  here we are calculating the Totalprice of order..........
 * @date         27/09/2016
 * @method       calculateTotal: isToCalCulateOtherDiscount
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)calculateTotal:(BOOL)isToCalCulateOtherDiscount{
    
    @try {
        float totalInvoiceSubTotalValue = 0;
        float totalItemsLevelDiscountValue = 0;
        float totalTaxValue = 0;
     
        for(int itemToReplace = 0; itemToReplace < [requestedItemsInfoArr count]; itemToReplace++) {
            
            NSMutableDictionary * grnTempItemDic = [[requestedItemsInfoArr objectAtIndex:itemToReplace] mutableCopy];
            
            float unitItemPrice = [[self checkGivenValueIsNullOrNil:[grnTempItemDic valueForKey:SUPPLY_PRICE] defaultReturn:@"0.00"] floatValue];
            float itemQty = [[self checkGivenValueIsNullOrNil:[grnTempItemDic valueForKey:SUPPLIED_QTY] defaultReturn:@"0.00"] floatValue] - [[self checkGivenValueIsNullOrNil:[grnTempItemDic valueForKey:FREE_QTY] defaultReturn:@"0.00"] floatValue];
            float itemTotalCost = unitItemPrice * itemQty;
            
            float itemDiscountPrice = 0;
            if([[self checkGivenValueIsNullOrNil:[grnTempItemDic valueForKey:GRN_ITEM_DISCOUNT] defaultReturn:@"0.00"] floatValue] > 0)
              itemDiscountPrice = (itemTotalCost *  [[self checkGivenValueIsNullOrNil:[grnTempItemDic valueForKey:GRN_ITEM_DISCOUNT] defaultReturn:@"0.00"] floatValue]/100);

            itemDiscountPrice += [[self checkGivenValueIsNullOrNil:[grnTempItemDic valueForKey:FLAT_DISCOUNT] defaultReturn:@"0.00"] floatValue];
            
            float itemTotalCostAfterDiscount = itemTotalCost - itemDiscountPrice;
            
            
            if([totalDiscountValueTxt.text floatValue] > 0 && isToCalCulateOtherDiscount){
              
                float fraction = (itemTotalCostAfterDiscount / [totalCostValueLbl.text floatValue]) * 100;
                itemDiscountPrice += ([totalDiscountValueTxt.text floatValue] * fraction) / 100;
                itemTotalCostAfterDiscount = itemTotalCostAfterDiscount - itemDiscountPrice;
            }
            
            
            bool isInclusiveType = ![[self checkGivenValueIsNullOrNil:[grnTempItemDic valueForKey:kItemTaxExclusive] defaultReturn:@"0"] boolValue];
            
            if((discCalcOn.length > 0 && [discCalcOn caseInsensitiveCompare:ORIGINAL_PRICE] == NSOrderedSame)){
                
            }
            else if(itemDiscountPrice > 0){
                itemTotalCost = itemTotalCostAfterDiscount;
                if (discTaxation.length > 0 && [discTaxation caseInsensitiveCompare:INCLUSIVE] == NSOrderedSame)
                    isInclusiveType = true;
                else if (discTaxation.length > 0 && [discTaxation caseInsensitiveCompare:EXCLUSIVE] == NSOrderedSame)
                    isInclusiveType = false;
            }
            
            if ([[grnTempItemDic valueForKey:TAXATION_ON_DISCOUNT_PRICE] boolValue]) {
                
                unitItemPrice = itemTotalCostAfterDiscount / itemQty;
            }
            
            [self calculateItemTax:grnTempItemDic  totalPrice:itemTotalCost rangeCheckAmount:unitItemPrice taxType:isInclusiveType];
            
            float itemTotalTaxValue = [[grnTempItemDic valueForKey:ITEM_TAX] floatValue];
            
            if(isInclusiveType)
                itemTotalCostAfterDiscount -= [[self checkGivenValueIsNullOrNil:[NSNumber numberWithFloat:itemTotalTaxValue] defaultReturn:@"0.00"] floatValue];
//            else
//                itemTotalCostAfterDiscount += [[self checkGivenValueIsNullOrNil:[NSNumber numberWithFloat:itemTotalTaxValue] defaultReturn:@"0.00"] floatValue];
            [grnTempItemDic setValue:[NSNumber numberWithBool:isInclusiveType] forKey:TAX_INCLUSIVE];
            [grnTempItemDic setValue:[NSString stringWithFormat:@"%.2f", itemDiscountPrice] forKey:TOTAL_BILL_DISCOUNT];

            [grnTempItemDic setValue:[NSNumber numberWithFloat:itemTotalCostAfterDiscount] forKey:TOTAL_COST];

            
            if(itemTotalCostAfterDiscount < 0)
                itemTotalCostAfterDiscount = 0;
            
            totalInvoiceSubTotalValue += itemTotalCostAfterDiscount;
            totalItemsLevelDiscountValue += itemDiscountPrice;
            totalTaxValue += itemTotalTaxValue;
            
            
            [requestedItemsInfoArr replaceObjectAtIndex:itemToReplace withObject:grnTempItemDic];
        }
        
        subTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",totalInvoiceSubTotalValue];
        itemLevelDiscountValueLbl.text = [NSString stringWithFormat:@"%.2f",totalItemsLevelDiscountValue];
        taxValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",totalTaxValue];
        
        shipmentCost = (shipmentValueTxt.text).floatValue;
        shipmentValueTxt.text = [NSString stringWithFormat:@"%.2f",shipmentCost];
        totalCostValueLbl.text = [NSString stringWithFormat:@"%.2f",(totalInvoiceSubTotalValue + shipmentCost + totalTaxValue)];
        totalInvoiceGrossValueLbl.text = [NSString stringWithFormat:@"%.2f",([totalCostValueLbl.text floatValue] + totalItemsLevelDiscountValue)];
        
        if([totalDiscountValueTxt.text floatValue] > 0 && !isToCalCulateOtherDiscount){
            
            totalDiscountValueTxt.text = [NSString stringWithFormat:@"%.2f",[totalDiscountValueTxt.text floatValue]];
            [self calculateTotal:TRUE];
        }
    } @catch (NSException *exception) {
        
        NSLog(@"------exception in while calculating the totalValue-----%@",exception);
    }
    @finally {
        
    }
}

-(void)calculateItemTax:(NSMutableDictionary *)itemDetailsDic totalPrice:(float)itemTotalCost rangeCheckAmount:(float)rangeCheckPrice taxType:(Boolean)isTaxInclusive{
    
    float totalTaxRateValue = 0;
    float taxValue = 0;
    NSString *taxCodeStr = @"";
    NSMutableArray * taxDispalyArr;
    taxDispalyArr = [[NSMutableArray alloc]init];
    
    @try{
        
        for (NSDictionary * taxdic in [itemDetailsDic valueForKey:TAX]) {
            
            float specifiedTaxValue = 0;
            float taxRateValue = [[taxdic valueForKey:TAX_RATE] floatValue];
            
            taxCodeStr = [taxdic valueForKey: TAX_CODE];
            
            for (NSDictionary * saleRangeListDic in [taxdic valueForKey:SALE_RANGES_LIST]) {
                
                if ( ([[saleRangeListDic valueForKey:SALE_VALUE_FROM]floatValue] <= rangeCheckPrice) && (rangeCheckPrice <= [[saleRangeListDic valueForKey:SALE_VALUE_TO]floatValue]) ) {
                    
                    taxRateValue = [[saleRangeListDic valueForKey:TAX_RATE] floatValue];
                    break;
                }
            }
            
            if ([[taxdic valueForKey:TAX_TYPE] caseInsensitiveCompare:Percentage] == NSOrderedSame) {
                
                if (isTaxInclusive) {
                    
                    specifiedTaxValue = ( itemTotalCost - (itemTotalCost / (100 + taxRateValue * 2) * 100 ) ) / 2;
                }
                else{
                    
                    specifiedTaxValue = (itemTotalCost * taxRateValue)/100;
                    
                    float itemTotalPrice = [[itemDetailsDic valueForKey:ITEM_TOTAL_COST] floatValue];
                    itemTotalPrice+= ((itemTotalCost * taxRateValue)/100);
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:ITEM_TOTAL_COST];
                }
            }
            else{
                
                specifiedTaxValue = (taxRateValue * [[itemDetailsDic valueForKey:ORDERED_QUANTITY]floatValue]);
            }
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",specifiedTaxValue] forKey:taxCodeStr];
            taxValue += specifiedTaxValue;
            totalTaxRateValue += taxRateValue;
            
            
            //taxes related...
            if([taxCodeStr.uppercaseString containsString:CGST]){
               
                [itemDetailsDic setValue:[NSNumber numberWithFloat:taxRateValue] forKey:CGST_RATE];
                [itemDetailsDic setValue:[NSNumber numberWithFloat:specifiedTaxValue] forKey:CGST_VALUE];
            }
            else if([taxCodeStr.uppercaseString containsString:SGST]){
                
                [itemDetailsDic setValue:[NSNumber numberWithFloat:taxRateValue] forKey:SGST_RATE];
                [itemDetailsDic setValue:[NSNumber numberWithFloat:specifiedTaxValue] forKey:SGST_VALUE];
            }
            else if([taxCodeStr.uppercaseString containsString:IGST]){
                
                [itemDetailsDic setValue:[NSNumber numberWithFloat:taxRateValue] forKey:IGST_RATE];
                [itemDetailsDic setValue:[NSNumber numberWithFloat:specifiedTaxValue] forKey:IGST_VALUE];
            }
            else{
                
                [itemDetailsDic setValue:[NSNumber numberWithFloat:taxRateValue] forKey:CESS_RATE];
                [itemDetailsDic setValue:[NSNumber numberWithFloat:specifiedTaxValue] forKey:CESS_AMOUNT];
            }
        }
   
        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",totalTaxRateValue] forKey:TAX_RATE];
        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",totalTaxRateValue] forKey:TAX_RATE_STR];

        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",taxValue] forKey:ITEM_TAX];
        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",taxValue] forKey:TOTAL_TAX_AMOUNT];
    }
    @catch(NSException * exception){
        NSLog(@"%@",exception.name);
    }
    
    @finally{
        
    }
    
}

-(void)changeTaxRate:(NSMutableDictionary *)itemDic newTaxRate:(NSString *)changeRate{
    
    @try {
        BOOL isTaxNotTheir = true;
        NSMutableArray * taxArr= [[itemDic valueForKey:TAX] mutableCopy];
        
        if(taxArr != nil){
            if([taxArr count]){
                int countArr = (int)[taxArr count];
                changeRate = [NSString stringWithFormat:@"%.2f", ([changeRate floatValue]/countArr)];

                for(int i = 0; i < [taxArr count]; i++){
                    
                    NSMutableDictionary * tempTaxDic = [[taxArr objectAtIndex:i] mutableCopy];
                    [tempTaxDic setValue:changeRate forKey:TAX_RATE];

                    if([[tempTaxDic allKeys] containsObject:SALE_RANGES_LIST] && ![[tempTaxDic valueForKey:SALE_RANGES_LIST] isKindOfClass:[NSNull class]]){
                    NSMutableArray * saleRangesArr = [[tempTaxDic valueForKey:SALE_RANGES_LIST] mutableCopy];

                        for(int j = 0; j < [saleRangesArr count]; j++){

                            NSMutableDictionary * tempTaxSaleDic = [taxArr objectAtIndex:j];
                            [tempTaxSaleDic setValue:changeRate forKey:TAX_RATE];
                            [saleRangesArr replaceObjectAtIndex:j withObject:tempTaxDic];
                        }
                        
                        [tempTaxDic setValue:saleRangesArr forKey:SALE_RANGES_LIST];
                    }
                    
                    isTaxNotTheir = false;
                    [taxArr replaceObjectAtIndex:i withObject:tempTaxDic];
                }
            }
        }
        else{
            taxArr = [NSMutableArray new];
        }
        
        
        if(isTaxNotTheir){

            changeRate = [NSString stringWithFormat:@"%.2f", ([changeRate floatValue]/2)];
            
            NSArray * loyaltyKeys = @[TAX_CATEGORY_,TAX_CODE,TAX_RATE,TAX_TYPE];
            NSArray * loyaltyObjects = @[@"GST",@"CGST",changeRate,@"Percentage"];
            NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            [taxArr addObject:dictionary];
            
            loyaltyObjects = @[@"GST",@"SGST",changeRate,@"Percentage"];
            dictionary = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            [taxArr addObject:dictionary];
        }

        [itemDic setValue:taxArr forKey:TAX];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)validateAndSaveTheDiscountAmount:(NSMutableDictionary *)itemDic newDiscountValue:(NSString *)discountValue discountType:(NSString *)discountTypeStr{

    @try {
        float itemQty = [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SUPPLIED_QTY] defaultReturn:@"0.00"] floatValue] - [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:FREE_QTY] defaultReturn:@"0.00"] floatValue];
        float itemTotalCost  =  [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SUPPLY_PRICE] defaultReturn:@"0.00"] floatValue] * itemQty;
        
//        if([[self checkGivenValueIsNullOrNil:[itemDic valueForKey:TAX_INCLUSIVE] defaultReturn:@"1"] boolValue])
//          itemTotalCost  = itemTotalCost + [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:TAX_VALUE] defaultReturn:@"0.00"] floatValue];
        
        
        float currentDiscountVaue = [discountValue floatValue];
        BOOL isToShowAlert = false;
        
        if([discountTypeStr isEqualToString:Percentage]){
            itemTotalCost = itemTotalCost - [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:FLAT_DISCOUNT] defaultReturn:@"0.00"] floatValue];
            
            if(currentDiscountVaue > 100){
                isToShowAlert = true;
            }
            else{
//                currentDiscountVaue = itemTotalCost * currentDiscountVaue/100;
                [itemDic setValue:[NSString stringWithFormat:@"%.2f",currentDiscountVaue] forKey:GRN_ITEM_DISCOUNT];
            }
        }
        else{
            
            if([[self checkGivenValueIsNullOrNil:[itemDic valueForKey:GRN_ITEM_DISCOUNT] defaultReturn:@"0.00"] floatValue] > 0)
            itemTotalCost = itemTotalCost - (itemTotalCost * [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:GRN_ITEM_DISCOUNT] defaultReturn:@"0.00"] floatValue]/100);
            
            if(currentDiscountVaue > itemTotalCost){
                isToShowAlert = true;
            }
            else{
                [itemDic setValue:[NSString stringWithFormat:@"%.2f",currentDiscountVaue] forKey:FLAT_DISCOUNT];
            }
        }
        
        if(isToShowAlert){
            float y_axis = 300;
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"sorry", nil),@"\n",NSLocalizedString(@"discount_amount_should_not_exceeds_item_cost", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:320 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
#pragma -mark keyboard notification methods

/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       keyboardWillShow
 * @author       Srinivasulu
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
 * @author       Srinivasulu
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
 * @author       Srinivasulu
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
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
}


#pragma -mark actions used in this class.......

/**
 * @description  to remove the unwanted Item for the cart
 * @date         16/03/2016
 * @method       deleteItemFromList
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)deleteItemFromList:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        if(requestedItemsInfoArr.count >= sender.tag){
            
            [requestedItemsInfoArr removeObjectAtIndex:sender.tag];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%li",(long)sender.tag);
    }
    @finally {
        
        [requestedItemsTbl reloadData];
    }
}

#pragma  -mark action used to show drop downs....

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

- (void)showAllVendorId:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        //if (![catPopOver isPopoverVisible]){
        if(vendorIdArr == nil ||  vendorIdArr.count == 0){
            [HUD setHidden:NO];
            [self getSuppliers:@""];
        }
        if(vendorIdArr.count){
            float tableHeight = vendorIdArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = vendorIdArr.count * 33;
            
            if(vendorIdArr.count > 5)
                tableHeight = (tableHeight/vendorIdArr.count) * 5;
            
            [self showPopUpForTables:vendorIdsTbl  popUpWidth:(vendorIdTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:vendorIdTxt  showViewIn:purchaseOrderView];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
    }
}


/**
 * @description  Displaying the Categories In Through Location...
 * @date         1/01/2018
 * @method       validatingCategoriesList
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)validatingCategoriesList:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);

    float y_axis = self.view.frame.size.height - 120;
    
    NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    
}

#pragma -mark actions used to dispaly calenderView

/**
 * @description  here we are showing the calenderView.......
 * @date         19/09/2016
 * @method       showCalenderInPopUp
 * @author       Srinivasulu
 * @param        UIButton
 * @param
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
            
            pickView.frame = CGRectMake(15, dueDateTxt.frame.origin.y+dueDateTxt.frame.size.height, 320, 320);
            
        }
        else {
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
        
        //changed by Srinivasulu on 03/02/2017....
        
        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(populateDateToTextField:) forControlEvents:UIControlEventTouchUpInside];
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        //added by srinivasulu on 03/02/2017....
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        //setting frame
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        //upto here on 03/02/2017....
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:dueDateTxt.frame inView:purchaseOrderView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                
                [popover presentPopoverFromRect:deliveredDateTxt.frame inView:purchaseOrderView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  populating the date into the textField of the createdDate and closedDates.......
 * @date         10/09/2016
 * @method       populateDateToTextField:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)populateDateToTextField:(UIButton *)sender{
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
        
        if(  sender.tag == 2){
            if ((deliveredDateTxt.text).length != 0 && ( ![deliveredDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:deliveredDateTxt.text ];
                
                if ([selectedDateString  compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"due_date_should_not_be_earlier_than_delivered_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
                    
                    
                    return;
                    
                }
            }
            
            dueDateTxt.text = dateString;
            
        }
        else{
            
            if ((dueDateTxt.text).length != 0 && ( ![dueDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:dueDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedDescending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivered_date_should_be_earlier_than_due_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            deliveredDateTxt.text = dateString;
            
            if((dueDateTxt.text).length == 0){
            NSDate *dateString_2 = [self getDate:selectedDateString daysAhead:1];
            dueDateTxt.text = [requiredDateFormat stringFromDate:dateString_2];
                
            }
        }
        
    } @catch (NSException *exception) {
        
    }
    
}

/**
 * @description  clear the date from textField and calling services.......
 * @date         03/02/2017
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
        
        
        if(  sender.tag == 2){
            
            dueDateTxt.text = @"";
        }
        else{
            
            deliveredDateTxt.text = @"";
        }
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
    
    
}



#pragma -mark actions need to implement.......

/**
 * @description  here we are showing the complete stockRequest information in popUp.......
 * @date         10/10/2016
 * @method       showCompleteGoodsReceiptNoteInfoSummary
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @veÏrified On
 *
 */

- (void)showCompleteGoodsReceiptNoteInfoSummary:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
}


/**
 * @description  here we are showing the complete stockRequest information in popUp.......
 * @date         10/10/2016
 * @method       showCompleteGoodsReceiptNoteInfoSummary
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @veÏrified On
 *
 */

- (void)updateGRNOrder:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [HUD setHidden:NO];
        
        
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        float totalAmount = 0;
        int qty = 0;
        
        for(NSDictionary *locDic  in requestedItemsInfoArr){
            
            NSMutableDictionary *temp = [NSMutableDictionary new];
            
            
            if(![[locDic valueForKey:S_NO] isKindOfClass: [NSNull class]] &&  [locDic.allKeys containsObject:S_NO])
                [temp setValue:[locDic  valueForKey:S_NO] forKey:S_NO];
            
            [temp setValue:[locDic  valueForKey:ITEM_SKU] forKey:ITEM_SKU];
            [temp setValue:[locDic  valueForKey:ITEM_DESC] forKey:ITEM_DESC];
            [temp setValue:[locDic  valueForKey:ORDER_QTY] forKey:ORDER_QTY];
            [temp setValue:[locDic  valueForKey:ORDER_PRICE] forKey:ORDER_PRICE];
            [temp setValue:[locDic  valueForKey:PLU_CODE] forKey:PLU_CODE];
            
            
            [temp setValue:[locDic  valueForKey:SUPPLIED_QTY] forKey:SUPPLIED_QTY];
            [temp setValue:[locDic  valueForKey:SUPPLY_PRICE] forKey:SUPPLY_PRICE];
            
            
            qty += [[locDic  valueForKey:SUPPLIED_QTY] integerValue];
            
            totalAmount = [[locDic  valueForKey:SUPPLY_PRICE] floatValue] * [[locDic  valueForKey:SUPPLIED_QTY] integerValue];
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",totalAmount ] forKey:TOTAL_COST];
            [temp setValue:[locDic  valueForKey:HANDLED_BY] forKey:HANDLED_BY];
            
            [tempArr addObject:temp];
            
        }
        
        // getting present date & time ..
        NSDate *today = [NSDate date];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        //        [formate setDateFormat:@"dd/MM/yyyy"];
        //        [formate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        formate.dateFormat = @"dd/MM/yyyy HH:mm:ss";
        NSString  * currentdate = [formate stringFromDate:today];
        
        NSString *deliveryDateStr = deliveredDateTxt.text;
        
        NSString *dueDateStr = dueDateTxt.text;
        
        if(deliveryDateStr.length > 1)
            deliveryDateStr = [NSString stringWithFormat:@"%@%@", deliveredDateTxt.text,@" 00:00:00"];
        
        if(dueDateStr.length > 1)
            dueDateStr = [NSString stringWithFormat:@"%@%@", dueDateTxt.text,@" 00:00:00"];
        
        
        NSArray *headerKeys_ = @[REQUEST_HEADER,Po_REF,SUPPLIER_ID,SUPPLIER_NAME,INSPECTED_BY,RECEIVED_BY,CREATED_DATE_STR,DELIVERED_ON_STR,DUE_DATE_STR,VENDOR_RATING,ITEMS_LIST,LOCATION,STATUS];
        
        NSArray *headerObjects_ = @[[RequestHeader getRequestHeader],poRefNoTxt.text,vendorIdTxt.text,supplierNameTxt.text,inspectedByTxt.text,receivedByTxt.text,currentdate,deliveryDateStr,dueDateStr, [NSNumber numberWithInteger:2.5],tempArr,presentLocation,SUBMITTED];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
        [webServiceController createWarehouseGoodsReceiptNote:quoteRequestJsonString];
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in updateStockRequest:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
        [HUD setHidden:YES];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert", nil) message:NSLocalizedString(@"unable_to_update", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
        //        [alert show];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"unable_to_update", nil)];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are showing the complete stockRequest information in popUp.......
 * @date         10/10/2016
 * @method       showCompleteGoodsReceiptNoteInfoSummary
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @veÏrified On
 *
 */

-(void)submitGRNOrder:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(requestedItemsInfoArr.count == 0){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"please_add_items_to_cart", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
        else if((deliveredDateTxt.text).length == 0 ){
            
            [self showCalenderInPopUp:deliveryDateBtn];
            
        }
        else if((dueDateTxt.text).length == 0 ){
            
            [self showCalenderInPopUp:dueDateBtn];
            
        }
        else if((vendorIdTxt.text).length == 0 ){
            
            [self showAllVendorId:vendorIdBtn];
            
        }
        
        //else if([submitedByTxt.text length] == 0 ){
        //[submitedByTxt becomeFirstResponder];
        //}
        
        else if((approvedByTxt.text).length == 0 ){
            
            [approvedByTxt becomeFirstResponder];
            
        }
        else if((inspectedByTxt.text).length == 0 ){
            
            [inspectedByTxt becomeFirstResponder];
            
        }
        else if((receivedByTxt.text).length == 0 ){
            
            [receivedByTxt becomeFirstResponder];
            
        }
        else if((deliveredByTxt.text).length == 0 ){
            
            [deliveredByTxt becomeFirstResponder];
            
        }
        else {
            
            //changed this buttons local to global. By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            submitBtn.userInteractionEnabled = NO;
            saveBtn.userInteractionEnabled = NO;
            
            //upto here on 02/05/2018....
            [HUD setHidden:NO];

            // getting present date & time ..
            NSDate *today = [NSDate date];
            NSDateFormatter *formate = [[NSDateFormatter alloc] init];
            formate.dateFormat = @"dd/MM/yyyy HH:mm:ss";
            NSString  * currentdate = [formate stringFromDate:today];
            
            NSString *deliveryDateStr = deliveredDateTxt.text;
            
            NSString *dueDateStr = dueDateTxt.text;
            
            if(deliveryDateStr.length > 1)
                deliveryDateStr = [NSString stringWithFormat:@"%@%@", deliveredDateTxt.text,@" 00:00:00"];
            
            if(dueDateStr.length > 1)
                dueDateStr = [NSString stringWithFormat:@"%@%@", dueDateTxt.text,@" 00:00:00"];
            
            vendorRating = 0;
            
            if(![[vendorIdDic valueForKey:RATING] isKindOfClass: [NSNull class]] &&  [vendorIdDic.allKeys containsObject:RATING])
                vendorRating = [[vendorIdDic valueForKey:RATING] intValue];
            
            //NSString * statusStr = DRAFT;
            //
            //if(sender.tag == 4)
            //statusStr = SUBMITTED;
            
            NSMutableDictionary * submitGrnOrderDic = [[NSMutableDictionary alloc]init];
            
            submitGrnOrderDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            
            submitGrnOrderDic[SUPPLIER_NAME] = supplierNameTxt.text;
            
            submitGrnOrderDic[SUBMITTED_BY] = submitedByTxt.text;
            
            submitGrnOrderDic[DELIVERED_ON_STR] = deliveryDateStr;
            
            submitGrnOrderDic[inspected_By] = inspectedByTxt.text;
            
            submitGrnOrderDic[kDeliveredBy] = deliveredByTxt.text;
            
            submitGrnOrderDic[RECEIVED_BY] = receivedByTxt.text;
            
            submitGrnOrderDic[APPROVED_BY] = approvedByTxt.text;
            
            submitGrnOrderDic[CREATED_DATE_STR] = currentdate;
            
            submitGrnOrderDic[SUPPLIER_ID] = vendorIdTxt.text;
            
            submitGrnOrderDic[LOCATION] = presentLocation;
            
            submitGrnOrderDic[DUE_DATE_STR] = dueDateStr;
            
            if ((poRefNoTxt.text).length > 0) {
                
                submitGrnOrderDic[Po_REF] = poRefNoTxt.text;
            }
            else {
                
                submitGrnOrderDic[Po_REF] = EMPTY_STRING;
            }
            
            submitGrnOrderDic[QUOTATION_REF_NO] = EMPTY_STRING;
            
            //[submitGrnOrderDic setObject:EMPTY_STRING forKey:STOCK_REQ_REF];
            
            submitGrnOrderDic[VENDOR_RATING] = @(vendorRating);
            
            submitGrnOrderDic[INVOICE_REF_NUMBER] = invoiceNumberTxt.text;
            
            //-*-*-*-*
            submitGrnOrderDic[INVOICE_REF_NUMBER] = indentRefNumberTxt.text;
            submitGrnOrderDic[TOTAL_BILL_DISCOUNT] = totalInvoiceDiscountValLbl.text;
            submitGrnOrderDic[TOTAL_INVOICE_VALUE] = totalInvoiceValueTxt.text;
            submitGrnOrderDic[TOTAL_GRN_VALUE] = totalInvoiceGrossValueLbl.text;

            submitGrnOrderDic[kComments] = EMPTY_STRING;
            
            if (zoneID.length == 0 || [zoneID isKindOfClass:[NSNull class]] || [zoneID isEqualToString:EMPTY_STRING]) {
                
                submitGrnOrderDic[ZONE_Id] = zone;
            }
            else
                
                submitGrnOrderDic[ZONE_Id] = zoneID;
            
            [submitGrnOrderDic setValue:@((taxValueLbl.text).floatValue) forKey:TAX];
            [submitGrnOrderDic setValue:@((shipmentValueTxt.text).floatValue) forKey:SHIPMENT_CHARGES];
            [submitGrnOrderDic setValue:@((totalDiscountValueTxt.text).floatValue) forKey:TOTAL_BILL_DISCOUNT];
            [submitGrnOrderDic setValue:@((subTotalValueLbl.text).floatValue) forKey:SUB_TOTAL];
            [submitGrnOrderDic setValue:@((totalCostValueLbl.text).floatValue) forKey:TOTAL_COST];
            [submitGrnOrderDic setValue:@0.0f forKey:CGST_AMOUNT];
            [submitGrnOrderDic setValue:@0.0f forKey:SGST_AMOUNT];
            [submitGrnOrderDic setValue:@0.0f forKey:OTHER_TAX_AMT];

            if(sender.tag == 2)
                
                submitGrnOrderDic[STATUS] = DRAFT;
            
            else
                
                submitGrnOrderDic[STATUS] = SUBMITTED;
            
            NSMutableArray * locArr = [NSMutableArray new];
            
            for (NSDictionary * dic in requestedItemsInfoArr) {
                
                NSMutableDictionary * itemDetailsDic = [dic mutableCopy];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f" ,([[dic valueForKey:SUPPLIED_QTY] integerValue] * [[dic valueForKey:SUPPLY_PRICE] floatValue])] forKey:TOTAL_COST];
                
                [itemDetailsDic setValue:@0.0f forKey:IGST_RATE];
                [itemDetailsDic setValue:@0.0f forKey:CESS_RATE];
                [itemDetailsDic setValue:@0.0f forKey:IGST_VALUE];
                [itemDetailsDic setValue:@0.0f forKey:CESS_AMOUNT];
                [itemDetailsDic setValue:@0.0f forKey:TOTAL_TAX_AMOUNT];
                [locArr addObject:itemDetailsDic];
                
            }
            
            if(isDraft) {
                
                [submitGrnOrderDic setValue:[goodsReceiptNoteInfoDic valueForKey:RECEIPT_NOTE_ID] forKey:RECEIPT_NOTE_ID];
            }
            
           submitGrnOrderDic[ITEMS_LIST] = locArr;
            
            NSError  * err;
            NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:submitGrnOrderDic options:0 error:&err];
            NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController *webServiceController = [WebServiceController new];
            
            if (isDraft) {
                webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
                [webServiceController updateWarehouseGoodsReceiptNote:quoteRequestJsonString];
            }
            else {
                webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
                [webServiceController createWarehouseGoodsReceiptNote:quoteRequestJsonString];
                
            }
            
            //}
        }
        //end of If statement's.......
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in updateStockRequest:----%@",exception);
        //changed this buttons local to global. By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"unable_to_create_new_grn", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @finally {
        
    }
}

/**
 * @description  here we are navigating back to GoodsReceiptNote View.......
 * @date         10/10/2016
 * @method       showCompleteGoodsReceiptNoteInfoSummary
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @veÏrified On
 */

- (void)cancelupdateGRNOrder:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [self backAction];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma -mark method used to display alert

/**
 * @description  adding the  alertMessage's based on input
 * @date         12/12/2016
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
 */

-(void)displayAlertMessage:(NSString *)message  horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay   noOfLines:(int)noOfLines{
    
    @try {
        //Playing Audio Based on Response....
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
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame) {
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
        fadOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in displayAlertMessage---------%@",exception);
        NSLog(@"----exception while creating the useralertMesssageLbl------------%@",exception);
        
    }
}



/**
 * @description  removing alertMessage add in the  disPlayAlertMessage method
 * @date         12/12/2016
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
        
        if(userAlertMessageLbl.tag == 4){
            
            //added on /11/2016.......
            [self backAction];
            
            //upto here.......
        }
        
        else if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
        
    }
    
}



#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         12/12/2016
 * @method       checkGivenValueIsNullOrNil
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (id)checkGivenValueIsNullOrNil:(id)inputValue {
    
    @try {
        if ([inputValue isKindOfClass:[NSNull class]] || inputValue == nil) {
            return @"--";
        }
        else {
            return inputValue;
        }
    } @catch (NSException *exception) {
        return @"--";
    }
    
}

/**
 * @description  here we are checking whether the object is null or not
 * @date         06/02/2016
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

#pragma  -mark xml parser methods start from here.......

/**
 * @description  in this method we are prasning the data form xmlfile and setting delegate to it....
 * @date         08/07/2016
 * @method       pasringXml:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void) parsingXml:(NSString *)xmlFile
{
    //initialization of Array....
    xmlViewCategotriesInfoDic = [[NSMutableDictionary alloc] init];
    
    //parsering the XmlFile data....
    parserXml = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:xmlFile]];
    parserXml.delegate = self;
    
    @try {
        [parserXml parse];
    }
    @catch (NSException *exception) {
        
        //        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [msg show];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"error", nil),@"\n",NSLocalizedString(@"error_in_parsing_the_xml", nil)];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
        //        [msg release];
        
    }
    
}


/**
 * @description  in this method we are prasning the data form xmlfile and setting delegate to it....
 * @date         08/07/2016
 * @method       parser: didStartElement: namespaceURI: qualifiedName:  attributes:
 * @author       Srinivasulu
 * @param        NSXMLParser
 * @param        NSString
 * @param        NSString
 * @param        NSString
 * @param        NSDictionary
 * @return
 * @verified By
 * @verified On
 *
 */

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict1
{
    @try {
        
        if ( [elementName isEqualToString:@"edit_and_view_table_headers_label_info"] ){
            
            NSMutableDictionary *locDic = [[NSMutableDictionary alloc] init];
            
            locDic[@"font_name"] = attributeDict1[@"font_name"];
            locDic[@"font_size"] = attributeDict1[@"font_size"];
            locDic[@"text"] = attributeDict1[@"text"];
            locDic[@"text_color_code"] = attributeDict1[@"text_color_code"];
            locDic[@"label_backGround_color_code"] = attributeDict1[@"label_backGround_color_code"];
            
            xmlViewCategotriesInfoDic[@"edit_and_view_table_headers_label_info"] = locDic;
        }
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

#pragma - mark used to show employee in popUp

/**
 * @description  here we are calling the getSuppliers of the  customer.......
 * @date         13/12/2016
 * @method       showListOfEmployees
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showListOfEmployees:(UIButton *) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        if(employeesListArr == nil ||  employeesListArr.count == 0) {
            [HUD setHidden:NO];
            [self callingGetEmployees];
        }

        if(employeesListArr.count){
            float tableHeight = employeesListArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = employeesListArr.count * 33;
            
            if(employeesListArr.count > 5)
                tableHeight = (tableHeight/employeesListArr.count) * 5;
            
            //inspectedByTxt.tag = sender.tag;
            
            
            if(sender.tag == 2) {
            
                employeesListTbl.tag = -1;
                
                [self showPopUpForTables:employeesListTbl  popUpWidth:(inspectedByTxt.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:inspectedByTxt  showViewIn:purchaseOrderView];
            }
            
            else {   
                
                //inspectdByBtn.tag = 1;
                employeesListTbl.tag = -2;

                [self showPopUpForTables:employeesListTbl  popUpWidth:(receivedByTxt.frame.size.width )  popUpHeight:tableHeight presentPopUpAt:receivedByTxt  showViewIn:purchaseOrderView];
            }
        }
        
        else
            
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        //hidding HUD show in asynchirous service call's....
        [HUD setHidden:YES];
    }
}


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

-(void)showListOfHandledByEmployees:(UIButton *)sender {
    
    if(employeesListArr == nil ||  employeesListArr.count == 0) {
        [HUD setHidden:NO];
        [self callingGetEmployees];
    }
    
    employeesListTbl.tag = sender.tag;
    
    if(employeesListArr.count){
        float tableHeight = employeesListArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = employeesListArr.count * 33;
        
        if(employeesListArr.count > 5)
            tableHeight = (tableHeight/employeesListArr.count) * 5;
        
        NSIndexPath * selectedRow = [NSIndexPath indexPathForRow:sender.tag inSection:0];
        [self showPopUpForTables:employeesListTbl  popUpWidth:(itemHandledByTxt.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:itemHandledByTxt  showViewIn:[requestedItemsTbl cellForRowAtIndexPath:selectedRow]  permittedArrowDirections:UIPopoverArrowDirectionRight];
    }
    
    else
        
        [catPopOver dismissPopoverAnimated:YES];
}


#pragma -mark service calls to getEmployees...
/**
 * @description  calling getStockSummary service..........
 * @date         12/12/2016
 * @method       callingGetEmployees
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGetEmployees {
    
    @try {
        
        [HUD setHidden:NO];
        
        employeesListArr = [NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,LOCATION];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.employeeServiceDelegate = self;
        [webServiceController getEmployeeMaster:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        [catPopOver dismissPopoverAnimated:YES];
        NSLog(@"---- exception while calling getSuppliers ServicesCall ----%@",exception);
        
    }
}

#pragma -mark handling of getEmployees service calls....


/**
 * @description  here we handling the getEmployees success response....
 * @date         09/02/2017
 * @method       getEmployeesWithDetailsSuccessReponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (BOOL)getEmployeeDetailsSucessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [HUD setHidden:YES];
        
        for( NSDictionary *dic in [successDictionary valueForKey:EMPLOYEE_DETAILS_LIST]){
            
            //            if(checkGivenValueIsNullOrNil)
            NSMutableString *str = [[NSMutableString alloc] init];
            if(![[dic valueForKey:FIRST_NAME] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:FIRST_NAME])
                str = [[dic valueForKey:FIRST_NAME] mutableCopy];
            
            
            if(![[dic valueForKey:LAST_NAME] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:LAST_NAME])
                [str appendString:[dic valueForKey:LAST_NAME]];
            
            
            
            [employeesListArr addObject:str];
            
        }
        
        NSLog(@"------------%@",employeesListArr);
        
        
        
        
    } @catch (NSException *exception) {
        
        NSLog(@"-------exception in while handling re----%@",exception);
    } @finally {
        
    }
    
}

/**
 * @description  here we handling the getEmployees success response....
 * @date         09/02/2017
 * @method       getEmployeesWithDetailsSuccessReponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (BOOL)getEmployeeErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        NSLog(@"------------%@",errorResponse);
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];

        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

#pragma -mark used to get further date....

/**
 * @description  here we are
 * @date         09/02/2017
 * @method       getDate: daysAhead:
 * @author       Srinivasulu
 * @param
 * @param        NSDate
 * @param        NSUInteger
 * @return       NSDate
 * @verified By
 * @verified On
 *
 */


- (NSDate *) getDate:(NSDate *)fromDate daysAhead:(NSUInteger)days
{
    @try {
//        NSLog(@"---------%@",fromDate);

        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        dateComponents.day = days;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *furtherDate = [calendar dateByAddingComponents:dateComponents
                                                         toDate:fromDate
                                                        options:0];
//        NSLog(@"---------%@",furtherDate);

        
        return furtherDate;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    

}

#pragma mark Scanner Functionality....

/**
 * @description  we are changing the switch action & hiding the barcode Button based on the Boolean Condition
 * @date         12/06/2018
 * @method       changeSwitchAction
 * @author       Bhargav.v
 * @param        sender
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)changeSwitchAction:(id)sender {
    
    if (isSearch.on) {
        
        searchBarcodeBtn.hidden = YES;
    }
    else {
        
        searchBarcodeBtn.hidden = NO;
    }
}


/**
 * @description  Searching the BarCode Manullay on  clicking the Search Icon Button
 * @date         12/06/2018
 * @method       searchBarcode
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)searchBarcode:(UIButton *)sender {
    
    //Play Audio For Button Touch.....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Resiging the FirstResonder....
    [searchItemsTxt resignFirstResponder];
    
    @try {
        
        if ((searchItemsTxt.text).length>0) {
            
            if (!isOfflineService) {
                
                searchItemsTxt.tag = (searchItemsTxt.text).length;
                searchString = [searchItemsTxt.text copy];
                //ALLOCATION OF searchDisplayItemsArr FOR MANUAL SEARCH....
                searchDisplayItemsArr = [[NSMutableArray alloc]init];
                
                [self searchProductsWithData:searchItemsTxt.text];
                
            }
            else {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"You need to first login with the internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }
        else {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Enter your search string" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSLog(@"%@",exception);
    }
    @finally{
        
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
- (void)tseries:(PowaTSeries *)tseries deviceConnectedAtPort:(NSUInteger)port;
{
    NSString *string = [NSString stringWithFormat:@"Connected device in port: %i", (int)port];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Connected"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
    [alertView show];
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
- (void)tseries:(PowaTSeries *)tseries deviceDisconnectedAtPort:(NSUInteger)port
{
    NSString *string = [NSString stringWithFormat:@"Disconnected device in port: %i", (int)port];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Disconnected"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
    [alertView show];
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
- (void)tseriesDidFinishInitializing:(PowaTSeries *)tseries
{
    NSString *string = [NSString stringWithFormat:@"Initialized"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Init"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
    [alertView show];
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
- (void)peripheral:(id <PowaPeripheral>)peripheral connectionStateChanged:(PowaPeripheralConnectionState)connectionState
{
    NSString *string = nil;
    
    if(connectionState == PowaPeripheralConnectionStateConnected)
    {
        string = @"Connected";
        powaStatusLblVal.textColor = [UIColor colorWithRed:0.0/255.0 green:102.0/255.0 blue:0.0/255.0 alpha:1.0];
 
    }
    else {

        string = @"Disconnected";
        powaStatusLblVal.textColor = [UIColor redColor];
    }
    
    powaStatusLblVal.text = string;
}

#pragma mark - PowaScannerObserver

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
- (void)scanner:(id<PowaScanner>)scanner scannedBarcodeData:(NSData *)data {
    
    @try {
        
        if(!isItemScanned) {
            isItemScanned = true;
            
            NSString * barcodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            selected_SKID = [barcodeString copy];
            searchItemsTxt.text = selected_SKID;
            
            if (barcodeString.length>0) {
                
                [self callRawMaterialDetails:barcodeString];
                
            }
            else {
                
                //added by Srinivasulu on 19/01/2017....
                isItemScanned = false;
                //upto here on 19/01/2017....
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to scan the barcode" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    @catch(NSException *exception) {
        
        isItemScanned = false;
        [HUD setHidden:YES];
        NSLog(@"%@",exception);
        
    }
    @finally {
        
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
 */
-(void)viewWillDisappear:(BOOL)animated {
    
    @try {
        
        //modified by sonali...
        CheckWifi * wifi = [[CheckWifi alloc] init];
        
        if ([wifi checkWifi]) {
            
            isOfflineService = false;
        }
        
        [scanner removeObserver:self];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@ scanner-%@ printer - %@ powa peripheral- %@",exception,scanner,printer,powaPOS);
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

    //if(xmlViewCategotriesInfoDic == nil){

    //UIColor *labelBackgroundColor;
    //UIColor *labelTextColor;
    //
    //
    //NSString *xmlFile = [[NSBundle mainBundle] pathForResource:@"Template" ofType:@"xml"];
    //[self parsingXml:xmlFile];
    //
    //
    ////populating the date received afterparsing form xml....
    //NSMutableDictionary *locDic = [[NSMutableDictionary alloc] init];
    //
    //
    //locDic  = [xmlViewCategotriesInfoDic valueForKey:@"edit_and_view_table_headers_label_info"];
    //
    //labelBackgroundColor = [WebServiceUtility colorWithHexString:[locDic valueForKey:@"label_backGround_color_code"] alpha:1.0];
    //
    //labelTextColor = [WebServiceUtility colorWithHexString:[locDic valueForKey:@"text_color_code"] alpha:1.0];
    //
    //
    ////giving color to label's....
    //[sNoLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //[skuIdLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //[descriptionLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //[uomLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //[poQtyLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //[poPriceLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //[delveredQtyLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //[delveredPriceLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //[netCostLbl labelColor:labelBackgroundColor labelTextColor:labelTextColor];
    //}

