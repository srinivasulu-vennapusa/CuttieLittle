
//  EditStockVerificationController.m
//  OmniRetailer
//  Created by Technolabs on 05/06/17.


#import "EditStockVerificationController.h"
#import "OmniHomePage.h"
#import "OmniRetailerViewController.h"


@interface EditStockVerificationController ()

@end

@implementation EditStockVerificationController
@synthesize soundFileURLRef,soundFileObject;
@synthesize verificationId,isOpen,selectIndex,buttonSelectIndex,selectSectionIndex;

# pragma-mark start of ViewLifeCycle mehods....

/**
 * @description  ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         30/05/2017
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
    
    // Audio Sound load url......
    NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
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
    
    //HUD Display....
    
    HUD.labelText = NSLocalizedString(@"please_wait..",nil);
    [HUD show:YES];
    [HUD setHidden:NO];
    
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
    

    //creating the stockRequestView which will displayed completed Screen.......
    stockVerificationView = [[UIView alloc] init];
    stockVerificationView.backgroundColor = [UIColor blackColor];
    stockVerificationView.layer.borderWidth = 1.0f;
    stockVerificationView.layer.cornerRadius = 10.0f;
    stockVerificationView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    UILabel * headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    
    //it is regard's to the view borderwidth and color setting....
    CALayer *bottomBorder = [CALayer layer];
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

    
    UILabel * userNameLbl = [[UILabel alloc] init];
    userNameLbl.text = firstName ;
    userNameLbl.layer.cornerRadius = 3.0f;
    userNameLbl.layer.masksToBounds = YES;
    userNameLbl.layer.borderWidth  = 1.0f;
    userNameLbl.numberOfLines = 2;
    userNameLbl.textAlignment = NSTextAlignmentCenter;
    userNameLbl.backgroundColor = [UIColor clearColor];
    userNameLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    userNameLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    
    /** creation of UITextField*/
    zoneTxt = [[CustomTextField alloc] init];
    zoneTxt.delegate = self;
    zoneTxt.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneTxt.userInteractionEnabled = NO;
    [zoneTxt awakeFromNib];
    

    outletIDTxt = [[CustomTextField alloc] init];
    outletIDTxt.placeholder = NSLocalizedString(@"outlet_id", nil);
    outletIDTxt.delegate = self;
    outletIDTxt.userInteractionEnabled = NO;
    [outletIDTxt awakeFromNib];
    

    //NSDate *today = [NSDate date];
    //NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //[f setDateFormat:@"dd/MM/yyyy"];
    //NSString* currentdate = [f stringFromDate:today];
    //[f release];
    

    startDteTxt = [[CustomTextField alloc] init];
    startDteTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDteTxt.delegate = self;
    //startDteTxt.text = currentdate;
    startDteTxt.userInteractionEnabled = NO;
    [startDteTxt awakeFromNib];
    
    endDteTxt = [[CustomTextField alloc] init];
    endDteTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDteTxt.delegate = self;
    endDteTxt.userInteractionEnabled = NO;
    [endDteTxt awakeFromNib];
    
    //// getting present Time ..
    //NSDate *time = [NSDate date];
    //NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //[format setDateFormat:@" HH:mm:ss"];
    //NSString * currentTime = [format stringFromDate:time];
    //[format release];
    
    startTimeTxt = [[CustomTextField alloc] init];
    startTimeTxt.placeholder = NSLocalizedString(@"start_time", nil);
    startTimeTxt.delegate = self;
    startTimeTxt.userInteractionEnabled = NO;
    //startTimeTxt.text = currentTime;
    [startTimeTxt awakeFromNib];
    
    endTimeTxt = [[CustomTextField alloc] init];
    endTimeTxt.placeholder = NSLocalizedString(@"end_time", nil);
    endTimeTxt.delegate = self;
    endTimeTxt.userInteractionEnabled = NO;
    [endTimeTxt awakeFromNib];
    
    ActionReqTxt = [[CustomTextField alloc] init];
    ActionReqTxt.placeholder = NSLocalizedString(@"Action Required", nil);
    ActionReqTxt.delegate = self;
    ActionReqTxt.userInteractionEnabled = NO;
    [ActionReqTxt awakeFromNib];
    
    //  Creation of UIButtons...
    
    UIImage * startDteImg;
    UIButton * startDteBtn;
    UIButton * endDteBtn;
    UIButton * startTimeBtn;
    UIButton * endTimeBtn;
    UIButton * selctAction;
    UIImage * actionReqImg;
    
    startDteImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    actionReqImg  = [UIImage imageNamed:@"arrow_1.png"];

    
    startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self
                    action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    startDteBtn.userInteractionEnabled = YES;
    
    endDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [endDteBtn addTarget:self
                    action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    endDteBtn.userInteractionEnabled = YES;

    
    startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startTimeBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [startTimeBtn addTarget:self
                     action:@selector(selectTime:) forControlEvents:UIControlEventTouchDown];
    startTimeBtn.userInteractionEnabled = YES;
    
    endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endTimeBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [endTimeBtn addTarget:self
                   action:@selector(selectTime:) forControlEvents:UIControlEventTouchDown];
    endTimeBtn.userInteractionEnabled = YES;
    
    //used for identification propous....
    startTimeBtn.tag = 2;
    endTimeBtn.tag = 4;
    
    selctAction = [UIButton buttonWithType:UIButtonTypeCustom];
    [selctAction setBackgroundImage:actionReqImg forState:UIControlStateNormal];
    [selctAction addTarget:self
                    action:@selector(showNextAcivities:) forControlEvents:UIControlEventTouchDown];
    
    UIImage * productListImg;
    
    productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
    selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self
                            action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    
   // allocation of workFlowView...
    workFlowView = [[UIView alloc] init];
    workFlowView.backgroundColor = [UIColor  clearColor];

    searchItemTxt = [[CustomTextField alloc] init];
    searchItemTxt.placeholder = NSLocalizedString(@"Search Items Here", nil);
    searchItemTxt.delegate = self;
    [searchItemTxt awakeFromNib];
    searchItemTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    //searchItemTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItemTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemTxt.textColor = [UIColor blackColor];
    searchItemTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    searchItemTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
    [searchItemTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //    creation of UIScrollView....
    
    stockVerificationScrollView = [[UIScrollView alloc]init];
//    stockVerificationScrollView.backgroundColor =  [UIColor greenColor];
    
    //creation Of customLabels....
    
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    skuidLbl = [[CustomLabel alloc] init];
    [skuidLbl awakeFromNib];
    
    skuDescLbl = [[CustomLabel alloc] init];
    [skuDescLbl awakeFromNib];
    
    uomLbl = [[CustomLabel alloc] init];
    [uomLbl awakeFromNib];
    
    openStockLbl = [[CustomLabel alloc] init];
    [openStockLbl awakeFromNib];
    
    saleQtyLbl = [[CustomLabel alloc] init];
    [saleQtyLbl awakeFromNib];
    
    bookStockLbl = [[CustomLabel alloc] init];
    [bookStockLbl awakeFromNib];
    
    actualStockLbl = [[CustomLabel alloc] init];
    [actualStockLbl awakeFromNib];
    
    dumpLbl = [[CustomLabel alloc] init];
    [dumpLbl awakeFromNib];
    
    stockLossLbl = [[CustomLabel alloc] init];
    [stockLossLbl awakeFromNib];
    
    
    declaredStockLbl = [[CustomLabel alloc] init];
    [declaredStockLbl awakeFromNib];
    
    closeStockLbl = [[CustomLabel alloc] init];
    [closeStockLbl awakeFromNib];
    
    lossTypeLbl = [[CustomLabel alloc] init];
    [lossTypeLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    
    UILabel *underLine_1;
    UILabel *totalActualStockLbl;
    UILabel *totalBookStockLbl;
    UILabel *totalOpenStockLbl;
    UILabel *underLine_2;
    
    underLine_1 = [[UILabel alloc] init];
    underLine_1.layer.masksToBounds = YES;
    underLine_1.numberOfLines = 2;
    underLine_1.textAlignment = NSTextAlignmentLeft;
    underLine_1.textColor = [UIColor whiteColor];
    underLine_1.backgroundColor = [UIColor grayColor];
    
    
    totalActualStockLbl = [[UILabel alloc] init];
    totalActualStockLbl.layer.cornerRadius = 14;
    totalActualStockLbl.layer.masksToBounds = YES;
    totalActualStockLbl.textAlignment = NSTextAlignmentLeft;
    totalActualStockLbl.font = [UIFont boldSystemFontOfSize:17.0f];
    totalActualStockLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    totalBookStockLbl = [[UILabel alloc] init];
    totalBookStockLbl.layer.cornerRadius = 14;
    totalBookStockLbl.layer.masksToBounds = YES;
    totalBookStockLbl.textAlignment = NSTextAlignmentLeft;
    totalBookStockLbl.font = [UIFont boldSystemFontOfSize:17.0f];
    totalBookStockLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    totalOpenStockLbl = [[UILabel alloc] init];
    totalOpenStockLbl.layer.cornerRadius = 14;
    totalOpenStockLbl.layer.masksToBounds = YES;
    totalOpenStockLbl.textAlignment = NSTextAlignmentLeft;
    totalOpenStockLbl.font = [UIFont boldSystemFontOfSize:17.0f];
    totalOpenStockLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    totalOpenStockVlueLbl = [[UILabel alloc] init];
    totalOpenStockVlueLbl.layer.cornerRadius = 5;
    totalOpenStockVlueLbl.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalOpenStockVlueLbl.layer.masksToBounds = YES;
    totalOpenStockVlueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    totalOpenStockVlueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalSaleQtyValueLbl = [[UILabel alloc] init];
    totalSaleQtyValueLbl.layer.cornerRadius = 5;
    totalSaleQtyValueLbl.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalSaleQtyValueLbl.layer.masksToBounds = YES;
    totalSaleQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    totalSaleQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalBookStockVlueLbl = [[UILabel alloc] init];
    totalBookStockVlueLbl.layer.cornerRadius = 5;
    totalBookStockVlueLbl.layer.masksToBounds = YES;
    totalBookStockVlueLbl.backgroundColor = [UIColor blackColor];
    totalBookStockVlueLbl.layer.borderWidth = 2.0f;
    totalBookStockVlueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    totalBookStockVlueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    totalBookStockVlueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalActualStockVlueLbl = [[UILabel alloc] init];
    totalActualStockVlueLbl.layer.cornerRadius = 5;
    totalActualStockVlueLbl.layer.masksToBounds = YES;
    totalActualStockVlueLbl.backgroundColor = [UIColor blackColor];
    totalActualStockVlueLbl.layer.borderWidth = 2.0f;
    totalActualStockVlueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    totalActualStockVlueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    totalActualStockVlueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    declaredStockValueLbl = [[UILabel alloc] init];
    declaredStockValueLbl.layer.cornerRadius = 5;
    declaredStockValueLbl.layer.masksToBounds = YES;
    declaredStockValueLbl.backgroundColor = [UIColor blackColor];
    declaredStockValueLbl.layer.borderWidth = 2.0f;
    declaredStockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    declaredStockValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    declaredStockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    dumpValueLbl = [[UILabel alloc] init];
    dumpValueLbl.layer.cornerRadius = 5;
    dumpValueLbl.layer.masksToBounds = YES;
    dumpValueLbl.backgroundColor = [UIColor blackColor];
    dumpValueLbl.layer.borderWidth = 2.0f;
    dumpValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    dumpValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    dumpValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    stockLossValueLbl = [[UILabel alloc] init];
    stockLossValueLbl.layer.cornerRadius = 5;
    stockLossValueLbl.layer.masksToBounds = YES;
    stockLossValueLbl.backgroundColor = [UIColor blackColor];
    stockLossValueLbl.layer.borderWidth = 2.0f;
    stockLossValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    stockLossValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    stockLossValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    closeStockValueLbl = [[UILabel alloc] init];
    closeStockValueLbl.layer.cornerRadius = 5;
    closeStockValueLbl.layer.masksToBounds = YES;
    closeStockValueLbl.backgroundColor = [UIColor blackColor];
    closeStockValueLbl.layer.borderWidth = 2.0f;
    closeStockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    closeStockValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    closeStockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    underLine_2 = [[UILabel alloc] init];
    underLine_2.layer.masksToBounds = YES;
    underLine_2.numberOfLines = 2;
    underLine_2.textAlignment = NSTextAlignmentLeft;
    underLine_2.textColor = [UIColor whiteColor];
    underLine_2.backgroundColor = [UIColor grayColor];
    
    
    totalOpenStockVlueLbl.text   = @"0.0";
    totalSaleQtyValueLbl.text    = @"0.0";
    totalBookStockVlueLbl.text   = @"0.0";
    totalActualStockVlueLbl.text = @"0.0";
    declaredStockValueLbl.text   = @"0.0";
    dumpValueLbl.text            = @"0.0";
    stockLossValueLbl.text            = @"0.0";
    closeStockValueLbl.text      = @"0.0";

    
    totalOpenStockVlueLbl.textAlignment   = NSTextAlignmentCenter;
    totalSaleQtyValueLbl.textAlignment    = NSTextAlignmentCenter;
    totalBookStockVlueLbl.textAlignment   = NSTextAlignmentCenter;
    totalActualStockVlueLbl.textAlignment = NSTextAlignmentCenter;
    declaredStockValueLbl.textAlignment   = NSTextAlignmentCenter;
    dumpValueLbl.textAlignment            = NSTextAlignmentCenter;
    stockLossValueLbl.textAlignment       = NSTextAlignmentCenter;
    closeStockValueLbl.textAlignment      = NSTextAlignmentCenter;
    
    //Allocation of productListTbl
    
    productListTbl = [[UITableView alloc] init];
    
    //Allocation rawMaterialDetailsTbl for Displaying the parent Data ..
    rawMaterialDetailsTbl = [[UITableView alloc] init];
    rawMaterialDetailsTbl.backgroundColor = [UIColor blackColor];
    rawMaterialDetailsTbl.dataSource = self;
    rawMaterialDetailsTbl.delegate = self;
    rawMaterialDetailsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    rawMaterialDetailsTbl.userInteractionEnabled = TRUE;
   
    //Table for Displaying the Child Data...
    
    itemsListTbl = [[UITableView alloc] init];
    itemsListTbl.dataSource = self;
    itemsListTbl.delegate = self;
    itemsListTbl.backgroundColor = [UIColor blackColor];
    itemsListTbl.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    itemsListTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // creation of UIButtons..
    
    submitBtn = [[UIButton alloc] init] ;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.userInteractionEnabled = YES;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    submitBtn.tag = 4;
    
    saveBtn = [[UIButton alloc] init] ;
    saveBtn.backgroundColor = [UIColor grayColor];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.userInteractionEnabled = YES;
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    saveBtn.layer.cornerRadius = 5.0f;
    [saveBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    saveBtn.hidden = YES;
    saveBtn.tag = 2;
    
    cancelButton = [[UIButton alloc] init] ;
    cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.userInteractionEnabled = YES;
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    cancelButton.layer.cornerRadius = 5.0f;
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];

    requestedItemsTblHeaderView = [[UIView alloc] init];
    //requestedItemsTblHeaderView.backgroundColor = [UIColor greenColor];
    
    /*Creation of the UILabels*/
    itemNoLbl = [[CustomLabel alloc] init];
    [itemNoLbl awakeFromNib];
    
    itemDescLbl = [[CustomLabel alloc] init];
    [itemDescLbl awakeFromNib];
    
    itemGradeLbl = [[CustomLabel alloc] init];
    [itemGradeLbl awakeFromNib];
    
    itemOpenStockLbl = [[CustomLabel alloc] init];
    [itemOpenStockLbl awakeFromNib];
    
    itemSaleQtyLbl = [[CustomLabel alloc] init];
    [itemSaleQtyLbl awakeFromNib];
    
    itemActualStockLbl = [[CustomLabel alloc] init];
    [itemActualStockLbl awakeFromNib];
    
    itemGradeStockLbl = [[CustomLabel alloc] init];
    [itemGradeStockLbl awakeFromNib];
    
    itemDumpQtyLbl = [[CustomLabel alloc] init];
    [itemDumpQtyLbl awakeFromNib];
    
    itemStockLossLbl = [[CustomLabel alloc] init];
    [itemStockLossLbl awakeFromNib];
    
    itemCloseStockLbl = [[CustomLabel alloc] init];
    [itemCloseStockLbl awakeFromNib];
    
    itemScanCodeLabel = [[CustomLabel alloc] init];
    [itemScanCodeLabel awakeFromNib];

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
                         action:@selector(searchBarcode) forControlEvents:UIControlEventTouchDown];
    searchBarcodeBtn.tag = 1;
    searchBarcodeBtn.hidden = YES;

    @try {
        
        headerNameLbl.text = NSLocalizedString(@"edit_stock_verification", nil);

        snoLbl.text = NSLocalizedString(@"S_NO",nil);
        skuidLbl.text = NSLocalizedString(@"sku_id",nil);
        skuDescLbl.text = NSLocalizedString(@"sku_desc",nil);
        uomLbl.text = NSLocalizedString(@"uom",nil);
        openStockLbl.text = NSLocalizedString(@"open_stock",nil);
        saleQtyLbl.text = NSLocalizedString(@"sale_qty",nil);
        bookStockLbl.text = NSLocalizedString(@"book_stock",nil);
        actualStockLbl.text = NSLocalizedString(@"actual_stock",nil);
        dumpLbl.text = NSLocalizedString(@"dump",nil);
        stockLossLbl.text = NSLocalizedString(@"stock_loss",nil);
        declaredStockLbl.text = NSLocalizedString(@"declared_stock",nil);
        closeStockLbl.text = NSLocalizedString(@"close_Stock",nil);
        lossTypeLbl.text = NSLocalizedString(@"loss_type",nil);
        actionLbl.text = NSLocalizedString(@"action",nil);

        //Grid Level CustomLabel Strings....
        
        itemNoLbl.text = NSLocalizedString(@"S_NO",nil);
        itemDescLbl.text = NSLocalizedString(@"Sku Desc",nil);
        itemGradeLbl.text = NSLocalizedString(@"Grade",nil);
        itemOpenStockLbl.text = NSLocalizedString(@"Open Stock",nil);
        itemSaleQtyLbl.text = NSLocalizedString(@"Sale Qty",nil);
        itemActualStockLbl.text = NSLocalizedString(@"Actual Stk",nil);
        itemGradeStockLbl.text = NSLocalizedString(@"Grade Stk",nil);
        itemDumpQtyLbl.text = NSLocalizedString(@"Dump Qty",nil);
        itemStockLossLbl.text = NSLocalizedString(@"Stock Loss",nil);
        itemCloseStockLbl.text = NSLocalizedString(@"Close Stk",nil);
        itemScanCodeLabel.text = NSLocalizedString(@"item_code",nil);

        //totalActualStockLbl.text = NSLocalizedString(@"total_actualStock", nil);
        //totalBookStockLbl.text = NSLocalizedString(@"total_bookStock", nil);
        //totalOpenStockLbl.text = NSLocalizedString(@"total_openStock", nil);

        [submitBtn setTitle:NSLocalizedString(@"edit",nil) forState:UIControlStateNormal];
        [saveBtn setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
        [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    if (isHubLevel) {
        
        zoneTxt.text = zoneID;
        outletIDTxt.text = presentLocation;

    }
    else {
        zoneTxt.text = zone;
        outletIDTxt.text = presentLocation;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
            
        }
        
        self.view.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        stockVerificationView.frame = CGRectMake(2,70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        headerNameLbl.frame = CGRectMake(0,0, stockVerificationView.frame.size.width, 45);
        
        //Added By Bhargav.v on 11/06/2018/...
        //Assiginin the Frames for the powaStatus Label..
        powaStatusLbl.frame = CGRectMake(headerNameLbl.frame.size.width - 270,headerNameLbl.frame.origin.y + 5, 130,40);
        powaStatusLblVal.frame = CGRectMake(powaStatusLbl.frame.origin.x + powaStatusLbl.frame.size.width + 5, powaStatusLbl.frame.origin.y, powaStatusLbl.frame.size.width,powaStatusLbl.frame.size.height);

        
        //setting below labe's frame.......
        float textFieldWidth =  180;
        float textFieldHeight = 40;
        //float labelWidth = 120;
        float horizontal_Gap = 50;
        float vertical_Gap = 20;

        //frames for the CustomTextField
        zoneTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+20,textFieldWidth,textFieldHeight);
        
        startDteTxt.frame = CGRectMake(zoneTxt.frame.origin.x+zoneTxt.frame.size.width+horizontal_Gap, zoneTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        outletIDTxt.frame =CGRectMake(zoneTxt.frame.origin.x,zoneTxt.frame.origin.y+zoneTxt.frame.size.height+vertical_Gap, textFieldWidth, textFieldHeight);
        
        endDteTxt.frame = CGRectMake(startDteTxt.frame.origin.x,outletIDTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        startTimeTxt.frame = CGRectMake(startDteTxt.frame.origin.x+startDteTxt.frame.size.width+horizontal_Gap, startDteTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        //
        endTimeTxt.frame = CGRectMake(startTimeTxt.frame.origin.x, outletIDTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        ActionReqTxt.frame = CGRectMake(stockVerificationView.frame.size.width-190,outletIDTxt.frame.origin.y+outletIDTxt.frame.size.height+15,textFieldWidth,textFieldHeight);
        
        userNameLbl.frame =CGRectMake(stockVerificationView.frame.size.width - 190, zoneTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        // frames for the UIButton...
        startDteBtn.frame = CGRectMake((startDteTxt.frame.origin.x+startDteTxt.frame.size.width-40), startDteTxt.frame.origin.y+4, 35, 30);
        
        endDteBtn.frame = CGRectMake((endDteTxt.frame.origin.x+endDteTxt.frame.size.width-40),endDteTxt.frame.origin.y+4,35,30);
        
        startTimeBtn.frame = CGRectMake((startTimeTxt.frame.origin.x+startTimeTxt.frame.size.width-35), startTimeTxt.frame.origin.y+4, 35, 30);
        
        endTimeBtn.frame = CGRectMake((endTimeTxt.frame.origin.x+endTimeTxt.frame.size.width-35), endTimeTxt.frame.origin.y+4, 35, 30);
        
        selctAction.frame = CGRectMake((ActionReqTxt.frame.origin.x+ActionReqTxt.frame.size.width-45),ActionReqTxt.frame.origin.y-8, 55, 60);
        
        workFlowView.frame = CGRectMake(0,outletIDTxt.frame.origin.y + outletIDTxt.frame.size.height+20, ActionReqTxt.frame.origin.x + ActionReqTxt.frame.size.width-(outletIDTxt.frame.origin.x),textFieldHeight);
    
        searchItemTxt.frame = CGRectMake(zoneTxt.frame.origin.x,workFlowView.frame.origin.y+workFlowView.frame.size.height+15,userNameLbl.frame.origin.x+userNameLbl.frame.size.width-(zoneTxt.frame.origin.x+80),40);
        
        selectCategoriesBtn.frame = CGRectMake((searchItemTxt.frame.origin.x+searchItemTxt.frame.size.width + 5),searchItemTxt.frame.origin.y,75,searchItemTxt.frame.size.height);
        
        // frames for the CustomLabels for header section....
        snoLbl.frame = CGRectMake(0, 0,40,35);
        
        skuidLbl.frame = CGRectMake(snoLbl.frame.origin.x + snoLbl.frame.size.width + 2,snoLbl.frame.origin.y,80,snoLbl.frame.size.height);
        
        skuDescLbl.frame = CGRectMake(skuidLbl.frame.origin.x+skuidLbl.frame.size.width + 2,skuidLbl.frame.origin.y,90,skuidLbl.frame.size.height);
        
        uomLbl.frame = CGRectMake(skuDescLbl.frame.origin.x+skuDescLbl.frame.size.width+2,skuidLbl.frame.origin.y,45,skuidLbl.frame.size.height);
        
        openStockLbl.frame = CGRectMake(uomLbl.frame.origin.x + uomLbl.frame.size.width + 2 , skuDescLbl.frame.origin.y ,80,skuDescLbl.frame.size.height);
        
        saleQtyLbl.frame = CGRectMake(openStockLbl.frame.origin.x+openStockLbl.frame.size.width + 2 ,openStockLbl.frame.origin.y ,65, openStockLbl.frame.size.height);
        
        bookStockLbl.frame = CGRectMake(saleQtyLbl.frame.origin.x + saleQtyLbl.frame.size.width + 2 , openStockLbl.frame.origin.y,90,openStockLbl.frame.size.height);
        
        actualStockLbl.frame = CGRectMake(bookStockLbl.frame.origin.x+bookStockLbl.frame.size.width + 2,bookStockLbl.frame.origin.y,75,bookStockLbl.frame.size.height);
        
        dumpLbl.frame = CGRectMake(actualStockLbl.frame.origin.x + actualStockLbl.frame.size.width + 2,bookStockLbl.frame.origin.y,50,actualStockLbl.frame.size.height);
        
        stockLossLbl.frame = CGRectMake(dumpLbl.frame.origin.x + dumpLbl.frame.size.width + 2,bookStockLbl.frame.origin.y,75,actualStockLbl.frame.size.height);
        
        declaredStockLbl.frame = CGRectMake(stockLossLbl.frame.origin.x + stockLossLbl.frame.size.width + 2 , actualStockLbl.frame.origin.y,80,actualStockLbl.frame.size.height);
        
        closeStockLbl.frame = CGRectMake(declaredStockLbl.frame.origin.x+declaredStockLbl.frame.size.width + 2,declaredStockLbl.frame.origin.y ,80,actualStockLbl.frame.size.height);
        
        lossTypeLbl.frame = CGRectMake(closeStockLbl.frame.origin.x+closeStockLbl.frame.size.width + 2,actualStockLbl.frame.origin.y ,75,actualStockLbl.frame.size.height);
        
        actionLbl.frame = CGRectMake(lossTypeLbl.frame.origin.x+lossTypeLbl.frame.size.width + 2,lossTypeLbl.frame.origin.y,50,dumpLbl.frame.size.height);

        // frame for the stockVerificationScrollView...
        
        stockVerificationScrollView.frame = CGRectMake( searchItemTxt.frame.origin.x,searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height+ 5, searchItemTxt.frame.size.width+ 150, 350);
        
        // frame for the stockVerificationScrollView content size...
        // commented on 27/06/2017...
        //stockVerificationScrollView.contentSize = CGSizeMake(searchItemTxt.frame.size.width+200,  stockVerificationScrollView.frame.size.height);
        
        // frame for the rawMaterialDetailsTbl...
        rawMaterialDetailsTbl.frame = CGRectMake(0,snoLbl.frame.origin.y +snoLbl.frame.size.height,actionLbl.frame.origin.x + actionLbl.frame.size.width-(snoLbl.frame.origin.x-80),stockVerificationScrollView.frame.size.height -(snoLbl.frame.origin.y +snoLbl.frame.size.height));

        //product list Table frame...
        //productListTbl.frame = CGRectMake(searchItemTxt.frame.origin.x, searchItemTxt.frame.origin.y+ searchItemTxt.frame.size.height,searchItemTxt.frame.size.width,250);
        
        requestedItemsTblHeaderView.frame = CGRectMake(skuidLbl.frame.origin.x,10,actionLbl.frame.origin.x + actionLbl.frame.size.width - (snoLbl.frame.origin.x),snoLbl.frame.size.height);

        itemNoLbl.frame = CGRectMake(0,0,45,30);
        
        itemDescLbl.frame = CGRectMake(itemNoLbl.frame.origin.x + itemNoLbl.frame.size.width+2,0,130,itemNoLbl.frame.size.height);
        
        itemGradeLbl.frame = CGRectMake(itemDescLbl.frame.origin.x + itemDescLbl.frame.size.width+2,0,70,itemNoLbl.frame.size.height);
        
        itemOpenStockLbl.frame = CGRectMake(itemGradeLbl.frame.origin.x + itemGradeLbl.frame.size.width+2,0,90,itemNoLbl.frame.size.height);
        
        itemSaleQtyLbl.frame = CGRectMake(itemOpenStockLbl.frame.origin.x + itemOpenStockLbl.frame.size.width+2,0,70,itemNoLbl.frame.size.height);
        
        itemActualStockLbl.frame = CGRectMake(itemSaleQtyLbl.frame.origin.x + itemSaleQtyLbl.frame.size.width+2,0,90,itemNoLbl.frame.size.height);
        
        itemDumpQtyLbl.frame = CGRectMake(itemActualStockLbl.frame.origin.x + itemActualStockLbl.frame.size.width+2,0,90,itemNoLbl.frame.size.height);
        
        itemStockLossLbl.frame = CGRectMake(itemDumpQtyLbl.frame.origin.x + itemDumpQtyLbl.frame.size.width + 2,0,90,itemNoLbl.frame.size.height);
        
        itemGradeStockLbl.frame = CGRectMake(itemStockLossLbl.frame.origin.x + itemStockLossLbl.frame.size.width + 2,0,80,itemNoLbl.frame.size.height);
        
        itemCloseStockLbl.frame = CGRectMake(itemGradeStockLbl.frame.origin.x + itemGradeStockLbl.frame.size.width + 2,0, 80, itemNoLbl.frame.size.height);
        
        itemScanCodeLabel.frame = CGRectMake(itemCloseStockLbl.frame.origin.x + itemCloseStockLbl.frame.size.width + 2, 0, 95, itemNoLbl.frame.size.height);

        
        // frame for the UIbuttons...
        submitBtn.frame = CGRectMake(searchItemTxt.frame.origin.x,stockVerificationView.frame.size.height - 50,110, 40);
        saveBtn.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+5,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
        
        cancelButton.frame = CGRectMake(saveBtn.frame.origin.x + saveBtn.frame.size.width+5,submitBtn.frame.origin.y,saveBtn.frame.size.width,40);
        
        //Frames for the total Value labels.....
        // added on  11/07/2017..
        
        totalBookStockVlueLbl.frame = CGRectMake(bookStockLbl.frame.origin.x+5,cancelButton.frame.origin.y,bookStockLbl.frame.size.width,textFieldHeight);
        
        totalActualStockVlueLbl.frame = CGRectMake(actualStockLbl.frame.origin.x+8,cancelButton.frame.origin.y,actualStockLbl.frame.size.width,textFieldHeight);
        
        dumpValueLbl.frame = CGRectMake(dumpLbl.frame.origin.x+8,cancelButton.frame.origin.y,dumpLbl.frame.size.width,textFieldHeight);
        
        stockLossValueLbl.frame = CGRectMake(stockLossLbl.frame.origin.x+8,cancelButton.frame.origin.y,stockLossLbl.frame.size.width,textFieldHeight);
        
        declaredStockValueLbl.frame = CGRectMake(declaredStockLbl.frame.origin.x+8,cancelButton.frame.origin.y,declaredStockLbl.frame.size.width,textFieldHeight);
        
        closeStockValueLbl.frame = CGRectMake(closeStockLbl.frame.origin.x+8,cancelButton.frame.origin.y,closeStockLbl.frame.size.width,textFieldHeight);
        
        // Added By Bhargav.v to implement the Scannner functionality...
        isSearch.frame = CGRectMake(searchItemTxt.frame.size.width - 85, searchItemTxt.frame.origin.y + 3.5, 25, 25);
        searchBarcodeBtn.frame = CGRectMake(isSearch.frame.origin.x + isSearch.frame.size.width + 10,isSearch.frame.origin.y + 2, 30, 30);

    }
    

    
    [stockVerificationView addSubview:headerNameLbl];
    //Recently Added By Bhargav.v to display the Scanner Status....
    //Date: 08/06/2018....
    [stockVerificationView addSubview:powaStatusLbl];
    [stockVerificationView addSubview:powaStatusLblVal];
    //upto here

    [stockVerificationView addSubview:userNameLbl];
    [stockVerificationView addSubview:zoneTxt];
    [stockVerificationView addSubview:outletIDTxt];
    [stockVerificationView addSubview:startDteTxt];
    [stockVerificationView addSubview:endDteTxt];
    [stockVerificationView addSubview:startTimeTxt];
    [stockVerificationView addSubview:endTimeTxt];
    [stockVerificationView addSubview:ActionReqTxt];
    [stockVerificationView addSubview:workFlowView];
    [stockVerificationView addSubview:searchItemTxt];
    
    //Added By Bhargav.v on 08/06/2018..
    [stockVerificationView addSubview:isSearch];
    [stockVerificationView addSubview:searchBarcodeBtn];
    //Upto here...

    [stockVerificationView addSubview:startDteBtn];
    [stockVerificationView addSubview:endDteBtn];
    [stockVerificationView addSubview:startTimeBtn];
    [stockVerificationView addSubview:endTimeBtn];
    [stockVerificationView addSubview:selctAction];
    [stockVerificationView addSubview:selectCategoriesBtn];
    
    [stockVerificationView addSubview:stockVerificationScrollView];
    
    [stockVerificationScrollView addSubview:snoLbl];
    [stockVerificationScrollView addSubview:skuidLbl];
    [stockVerificationScrollView addSubview:skuDescLbl];
    [stockVerificationScrollView addSubview:uomLbl];
    [stockVerificationScrollView addSubview:openStockLbl];
    [stockVerificationScrollView addSubview:saleQtyLbl];
    [stockVerificationScrollView addSubview:bookStockLbl];
    [stockVerificationScrollView addSubview:actualStockLbl];
    [stockVerificationScrollView addSubview:dumpLbl];
    [stockVerificationScrollView addSubview:stockLossLbl];
    [stockVerificationScrollView addSubview:declaredStockLbl];
    [stockVerificationScrollView addSubview:closeStockLbl];
    [stockVerificationScrollView addSubview:lossTypeLbl];
    [stockVerificationScrollView addSubview:actionLbl];
    
    [requestedItemsTblHeaderView addSubview:itemNoLbl];
    [requestedItemsTblHeaderView addSubview:itemDescLbl];
    [requestedItemsTblHeaderView addSubview:itemGradeLbl];
    [requestedItemsTblHeaderView addSubview:itemOpenStockLbl];
    [requestedItemsTblHeaderView addSubview:itemSaleQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemActualStockLbl];
    [requestedItemsTblHeaderView addSubview:itemDumpQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemStockLossLbl];
    [requestedItemsTblHeaderView addSubview:itemGradeStockLbl];
    [requestedItemsTblHeaderView addSubview:itemCloseStockLbl];
    [requestedItemsTblHeaderView addSubview:itemScanCodeLabel];

    [stockVerificationView addSubview:totalBookStockVlueLbl];
    [stockVerificationView addSubview:totalActualStockVlueLbl];
    [stockVerificationView addSubview:dumpValueLbl];
    [stockVerificationView addSubview:stockLossValueLbl];
    [stockVerificationView addSubview:declaredStockValueLbl];
    [stockVerificationView addSubview:closeStockValueLbl];

    [stockVerificationView addSubview:submitBtn];
    [stockVerificationView addSubview:saveBtn];
    [stockVerificationView addSubview:cancelButton];
    
    [self.view addSubview:stockVerificationView];
    
    [stockVerificationView addSubview:productListTbl];
    
    [stockVerificationScrollView addSubview:rawMaterialDetailsTbl];

    //here we are setting font to all subview to mainView.....
    @try {
        [ WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:15.0f cornerRadius:0];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        // Added By Bhargav.v on 1/06/2018
        powaStatusLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        powaStatusLblVal.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

        submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        saveBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        cancelButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];

        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:requestedItemsTblHeaderView andSubViews:YES fontSize:15.0f cornerRadius:0];
        
    } @catch (NSException *exception) {
        NSLog(@"---- exception while setting the fontSize to subViews ----%@",exception);
    }
    
    @try {
        
        for (id view in stockVerificationView.subviews) {
            [view setUserInteractionEnabled:NO];
        }
        
        stockVerificationScrollView.userInteractionEnabled  = YES;
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        cancelButton.userInteractionEnabled = YES;
        
    }
    @catch (NSException *exception) {
        
    }
    
    //Allocation of isPacked Array to check the Boolean flag..
    isPacked = [NSMutableArray new];
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
 *
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
        totalRecords = 0;
        if (rawMaterialDetails == nil)
            
            rawMaterialDetails = [NSMutableArray new];
        
        [self callingProductVerification];
        
    } @catch (NSException *exception) {
      
        [HUD setHidden:YES];
    }
    
    
    
    //added by Bhargav.v on 08/06/2018.......
    isItemScanned = false;
    //upto here on 19/01/2017....

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  - mark start of service calls:


/**
 * @description  here we are calling itemsList to display....
 * @date         2/05/2017...
 * @method       callingProductVerification
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingProductVerification{
    
    @try {
        
        [HUD setHidden:NO];
        
        NSString * startDteStr = startDteTxt.text;
        
        if((startDteTxt.text).length >0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDteTxt.text,@" 00:00:00"];
        
        
        NSString * endDateStr = endDteTxt.text;
        
        if((endDteTxt.text).length > 0)
            endDateStr =  [NSString stringWithFormat:@"%@%@",endDteTxt.text,@" 00:00:00"];
        
        NSMutableDictionary * productVerificationDic = [[NSMutableDictionary alloc]init];
        
        productVerificationDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        productVerificationDic[START_INDEX] = @"-1";
        productVerificationDic[kVerificationUnderMasterCode] = [NSNumber numberWithBool:true];
        productVerificationDic[@"verification_code"] = verificationId;
        //[productVerificationDic setObject:verificationId forKey:@"masterVerificationCode"];
        productVerificationDic[kStartDate] = startDteStr;
        productVerificationDic[END_DATE] = endDateStr;
        
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:productVerificationDic options:0 error:&err];
        NSString * getProductStockVerificationString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductStockVerificationString);
        
        WebServiceController * webServiceController = [[WebServiceController alloc] init];
        webServiceController.storeStockVerificationDelegate = self;
//        [webServiceController getProductVerification:getProductStockVerificationString]; // Soap Service...
        [webServiceController getProductVerificationRestFullService:getProductStockVerificationString];
    }
    @catch (NSException * exception) {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        
    }
}



/**
 * @description  here we are calling searchSku.......
 * @date         07/06/2017
 * @method       callRawMaterials
 * @author       Bhargav.v
 * @param        NSString
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
        
        //productList  =[NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,kSearchCriteria,kStoreLocation];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",searchItemTxt.text,presentLocation];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.searchProductDelegate = self;
        [webServiceController  searchProductsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    
}

/**
 * @description  used to get the ItemDetails in skuList.......
 * @date         21/09/2016
 * @method       callRawMaterialDetails
 * @author       Bhargav.v
 * @param
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
        
        //Setting the Object for the Request Header....
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
        productDetailsDic[START_INDEX] = ZERO_CONSTANT;
        productDetailsDic[ITEM_SKU] = pluCodeStr;
        
        NSError  *  err;
        NSData   *  jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString *  skuDetailsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSKUStockInformation:skuDetailsJsonString];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}



#pragma  -mark  start of service calls


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
        else{
            
            [self displayCategoriesList:nil];
            [categoriesTbl reloadData];
        }
    }
    @catch (NSException * exception) {
        
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

-(void)multipleCategriesSelection:(UIButton*)sender {
    @try {
        
        
        selectCategoriesBtn.tag = 1;

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
                
                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_atleast_one_category",nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40 isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return;
            }
        }
        
        @try {
            [HUD setHidden:NO];
            NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
            
            priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            priceListDic[START_INDEX] = @"-1";
            priceListDic[@"categoryList"] = catArr;
            
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
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
    } @catch (NSException *exception) {
        
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
 * @description  here we are updating the stockVerifcation service...
 * @date         07/06/2017
 * @method       editButtonPressed
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)submitButtonPressed:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        Boolean isZeroQty = false;
        for(NSDictionary * skuDic in rawMaterialDetails)
            
            for(NSDictionary * dic in [skuDic valueForKey:SKU_PRICE_LIST]) {
                
                
                if(![[dic valueForKey:SKU_PHYSICAL_STOCK] integerValue])
                    isZeroQty = true;
                
            }
        
        if([sender.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ){
            
            @try {
                
                for (id view in stockVerificationView.subviews) {
                    [view setUserInteractionEnabled:YES];
                    
                }
                startTimeTxt.userInteractionEnabled = NO;
                endTimeTxt.userInteractionEnabled = NO;
                startDteTxt.userInteractionEnabled = NO;
                endDteTxt.userInteractionEnabled = NO;
                ActionReqTxt.userInteractionEnabled = NO;
             }
            @catch (NSException *exception) {
                
            }
            [rawMaterialDetailsTbl reloadData];
            [submitBtn setTitle:NSLocalizedString(@"update",nil) forState:UIControlStateNormal];
            
            // added by roja on 03/04/2019....
            if ([[updateStockDic valueForKey:STATUS] caseInsensitiveCompare:@"Draft"] == NSOrderedSame) {
                
                [submitBtn setTitle:NSLocalizedString(@"Submit",nil) forState:UIControlStateNormal];
                saveBtn.hidden = NO;
                itemsListTbl.userInteractionEnabled = YES;

                cancelButton.frame = CGRectMake(saveBtn.frame.origin.x + saveBtn.frame.size.width+5,submitBtn.frame.origin.y,saveBtn.frame.size.width,40);
            }
            //Upto here added by roja on 03/04/2019....

        }
        else if (isZeroQty && ((saveBtn.tag != submitBtn.tag) || sender == cancelButton)){
            
            conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"please_verify_zeroQty_items_are_available", nil) message:nil delegate:self cancelButtonTitle:@"CONTINUE" otherButtonTitles:@"CANCEL", nil];
            conformationAlert.tag = sender.tag;
            [conformationAlert show];
        }
        else if (!isZeroQty && (saveBtn.tag != submitBtn.tag) && !(sender == cancelButton) ){
            
            // added by roja on 03/04/2019...
            NSString * titleMsg = @"";

            if ( (ActionReqTxt.text).length > 0 ) {
                
                titleMsg = [NSString stringWithFormat:NSLocalizedString(@"Do you want to %@ this verification ", nil),ActionReqTxt.text];
                ActionReqTxt.placeholder = ActionReqTxt.text;
            }
            else {

                if(sender.tag == 2){
                    titleMsg = @"Do you want to save this Verification";
                }
                else{
                    titleMsg = @"Do you want to submit this Verification";
                }
            }
            
            conformationAlert = [[UIAlertView alloc] initWithTitle:titleMsg  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
            conformationAlert.tag = sender.tag;
            [conformationAlert show];
            //Upto here added by roja on 03/04/2019...
        }

        else {
            
            
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            
            submitBtn.userInteractionEnabled = NO;
            saveBtn.userInteractionEnabled = NO;
            //upto here on 02/05/2018....
            
            [HUD setHidden:NO];
            
            NSMutableDictionary * updateVerificationDic = [[NSMutableDictionary alloc]init];
            
            updateVerificationDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            updateVerificationDic[START_INDEX] = @-1;
            
            NSString * verifiedDteStr = startDteTxt.text;
            
            if(verifiedDteStr.length > 1)
                verifiedDteStr = [NSString stringWithFormat:@"%@%@",startDteTxt.text,@" 00:00:00"];
            
            NSString * updateStatuStr = [updateStockDic valueForKey:STATUS];
            
            if ([updateStatuStr caseInsensitiveCompare:@"draft"] == NSOrderedSame ) {
                
                updateVerificationDic[STATUS] = SUBMITTED;
                // added by roja on 03/04/2019...
                if (sender.tag == 2) { // saveButton
                    updateVerificationDic[STATUS] = DRAFT;
                }
                //Upto here added by roja on 03/04/2019...
            }
            else {
                
                if ((ActionReqTxt.text).length > 0)
                    updateStatuStr = ActionReqTxt.text;
                //upto here on 18/07/2017....
                updateVerificationDic[STATUS] = updateStatuStr;
            }
            
            updateVerificationDic[REMARKS] = EMPTY_STRING;
            updateVerificationDic[VERIFIED_BY] = firstName;
            updateVerificationDic[LOCATION] = presentLocation;
            updateVerificationDic[END_TIME_STR] = endTimeTxt.text;
            updateVerificationDic[VERIFIED_DATE_STR] = verifiedDteStr;
            updateVerificationDic[START_TIME_STR] = startTimeTxt.text;
            updateVerificationDic[VERIFICATION_CODE] = verificationStr;
            updateVerificationDic[MASTER_VERIFICATION_CODE] = masterVerificationStr;
            updateVerificationDic[kVerificationUnderMasterCode] = [NSNumber numberWithBool:false];
            
            NSMutableArray * locArr = [NSMutableArray new];
            
            //start of main for loop....
           
            for(NSDictionary * skuDic in rawMaterialDetails){
                
                for (int i = 0; i < [[skuDic valueForKey:SKU_PRICE_LIST] count]; i++) {
                    
                    NSMutableDictionary * dic  =  [[skuDic valueForKey:SKU_PRICE_LIST][i] mutableCopy];
                    
                    [dic setValue:[NSString stringWithFormat:@"%.2f" ,([[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue] - [[dic valueForKey:DUMP_QTY] floatValue])] forKey:CLOSED_STOCK];
                    
                    [dic setValue:[NSString stringWithFormat:@"%.2f" ,([[dic valueForKey:kSkuCostPrice] floatValue] * [[dic valueForKey:DUMP_QTY] floatValue])] forKey:DUMP_COST];
                    
                    [dic setValue:[NSString stringWithFormat:@"%.2f" ,([[dic valueForKey:kSkuCostPrice] floatValue] * [[dic valueForKey:STOCKLOSS_QTY] floatValue])] forKey:kStock_loss];
                    
                    dic[LOSS_TYPE] = [skuDic valueForKey:LOSS_TYPE];

                    // added by roja on 03/04/2019...
                    [dic setValue:[NSString stringWithFormat:@"%.2f" ,([[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue] - [[dic valueForKey:DUMP_QTY] floatValue])] forKey:DECLARED_QTY];

                    [locArr addObject:dic];
                }
                
            }
            
            updateVerificationDic[ITEMS_LIST] = locArr;
            
            NSError  * err;
            
            NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:updateVerificationDic options:0 error:&err];
           
            NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"--%@",quoteRequestJsonString);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.storeStockVerificationDelegate = self;
            
            if ([[updateStockDic valueForKey:STATUS] isEqualToString:@"Write Off"])   {
                
                [webServiceController doWriteOfStockVerification:quoteRequestJsonString];
            }
            else
//            [webServiceController upDateStockVerification:quoteRequestJsonString];
                [webServiceController upDateStockVerificationRestFullService:quoteRequestJsonString];

        }
    }
    @catch (NSException * exception) {
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        //upto here on 02/05/2018....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @finally {
        
    }
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
            
            saveBtn.tag = conformationAlert.tag;
            submitBtn.tag = conformationAlert.tag;
            
            [self submitButtonPressed:saveBtn];
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
//    // added by roja on 03/04/2019...
    else if (alertView == cancellationAlert) {
        
        if (buttonIndex == 0) {
            
            [self submitButtonPressed:cancelButton];
        }
        else {
            
            [self backAction];
        }
    }
    // Upto here added by roja on 03/04/2019...

}


#pragma -mark start of handling service call reponses

/**
 * @description  here we are handling the resposne received from services...
 * @date         20/0/2016
 * @method       getProductVerificationSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getProductVerificationSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        if (successDictionary.count >0) {
            
            verificationStr  = [[[successDictionary valueForKey:STOCK_VERIFICATION_OBJ]valueForKey:VERIFICATION_CODE]copy];
            
            masterVerificationStr = [[[successDictionary valueForKey:STOCK_VERIFICATION_OBJ]valueForKey:MASTER_VERIFICATION_CODE]copy];
        }
        
        
        // added by roja on 03/04/2019...
        
        totalRecords = (int)[[[successDictionary valueForKey:STOCK_VERIFICATION_OBJ]valueForKey:@"itemsList"] count];
        
        // making a copy of successDictionary for the external use...
        updateStockDic = [[successDictionary valueForKey:STOCK_VERIFICATION_OBJ]mutableCopy];
        
        if(([updateStockDic.allKeys containsObject:VERIFIED_ON_STR]) &&  (![[updateStockDic valueForKey:VERIFIED_ON_STR] isKindOfClass: [NSNull class]]) && ([[updateStockDic valueForKey:VERIFIED_ON_STR] componentsSeparatedByString:@" "].count))
            
            startDteTxt.text =  [[updateStockDic valueForKey:VERIFIED_ON_STR] componentsSeparatedByString:@" "][0];
        
        if(([updateStockDic.allKeys containsObject:UPDATED_ON_STR]) &&  (![[updateStockDic valueForKey:UPDATED_ON_STR] isKindOfClass: [NSNull class]]) && ([[updateStockDic valueForKey:UPDATED_ON_STR] componentsSeparatedByString:@" "].count))
            
            endDteTxt.text =  [[updateStockDic valueForKey:UPDATED_ON_STR] componentsSeparatedByString:@" "][0];
        
        if (![[updateStockDic valueForKey:START_TIME_STR ] isKindOfClass:[NSNull class]]&& [[updateStockDic valueForKey:START_TIME_STR ] length] > 0)
            
            startTimeTxt .text = [NSString stringWithFormat:@"%@",[updateStockDic valueForKey:START_TIME_STR ]];
        
        if (![[updateStockDic valueForKey:END_TIME_STR ] isKindOfClass:[NSNull class]]&& [[updateStockDic valueForKey:END_TIME_STR ] length] > 0)
            
            endTimeTxt .text = [NSString stringWithFormat:@"%@",[updateStockDic valueForKey:END_TIME_STR ]];
        
        // for loop to execute the cart table acoording to the data ....
        
        float bookStock          = 0.0;
        float sku_Physical_Stock = 0.0;
        float declaredQty        = 0.0;
        float dumpQty            = 0.0;
        float stockLossQty       = 0.0;
        float closeStockQty      = 0.0;
        
        for (NSDictionary * dic in [updateStockDic valueForKey:VERF_DETAILS_LIST]) {
            
            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:sku_ID] defaultReturn:@""] forKey:SKU_ID];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:sku_DESC] defaultReturn:@""] forKey:kskuDescription];
            
            // newly added fields...by Bhargav.v on 7/06/2017
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:kSkuCostPrice] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:DUMP_QTY] defaultReturn:@"0.00"] floatValue]] forKey:DUMP_QTY];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:BOOK_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:SKU_BOOK_STOCK];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:ACTUAL_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:SKU_PHYSICAL_STOCK];
            
            // added By Bhargav
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:OPEN_STOCK];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:DECLARED_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:DECLARED_QTY];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f" ,([[dic valueForKey:ACTUAL_STOCK] floatValue] - [[dic valueForKey:DUMP_QTY] floatValue])] forKey:CLOSED_STOCK];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:kStock_loss] defaultReturn:@"0.00"] floatValue]] forKey:kStock_loss];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.00"] floatValue]] forKey:STOCKLOSS_QTY];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:CLOSED_STOCK];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:@"lossType"] defaultReturn:@""] forKey:LOSS_TYPE];
            
            //upto Here
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            bookStock += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:BOOK_STOCK] defaultReturn:@"0.00"] floatValue];
            
            sku_Physical_Stock += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:ACTUAL_STOCK] defaultReturn:@"0.00"] floatValue];
            
            declaredQty += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:DECLARED_STOCK] defaultReturn:@"0.00"] floatValue];
            
            dumpQty += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:DUMP_QTY] defaultReturn:@"0.00"] floatValue];
            
            closeStockQty += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue];
            
            stockLossQty += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.00"] floatValue];
            
            //Parent List...
            
            NSMutableArray * priceListArr = [[NSMutableArray alloc]init];
            
            if ([[dic valueForKey:VERF_ITEM_DETAILS] count]) {
                
                for (NSDictionary * priceListDic in [dic valueForKey:VERF_ITEM_DETAILS]) {
                    
                    NSMutableDictionary * GradeDic = [NSMutableDictionary new];
                    
                    // Setting SkuId as Sku_id
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_ID] defaultReturn:@""] forKey:SKU_ID];
                    
                    //Setting Description as SkuDescription
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kskuDescription] defaultReturn:@""] forKey:kskuDescription];
                    
                    // Setting pluCode as pluCode
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                    
                    // Setting productRange as productRange
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                    
                    // Setting openStock as openStock
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:OPEN_STOCK];
                    
                    // Setting saleQty as saleQty..
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SALE_QTY] defaultReturn:@"0.00"] floatValue]] forKey:SALE_QTY];
                    
                    // Setting sku_book_stock as sku_book_stock
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_BOOK_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:SKU_BOOK_STOCK];
                    
                    // Setting sku_physical_stock as sku_physical_stock
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:SKU_PHYSICAL_STOCK];
                    
                    //Setting quantityInHand as product_physical_stock
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_PHYSICAL_STOCK];
                    
                    //Setting quantityInHand as product_book_stock
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_BOOK_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_BOOK_STOCK];
                    
                    // Setting dumpQty as dumpQty
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:DUMP_QTY] defaultReturn:@"0.00"] floatValue]] forKey:DUMP_QTY];
                    
                    // Setting stockLossQty as stockLossQty
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.00"] floatValue]] forKey:STOCKLOSS_QTY];
                    
                    // Setting declaredQty as declaredQty
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:DECLARED_QTY] defaultReturn:@"0.00"] floatValue]] forKey:DECLARED_QTY];
                    
                    // Setting closedStock as closedStock
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:CLOSED_STOCK];
                    
                    // Setting skuCostPrice as skuCostPrice
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kSkuCostPrice] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
                    
                    // Setting measureRange as measureRange
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                    
                    //Setting subCategory as subCategory
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                    
                    // Setting uom as uom
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                    
                    // Setting ean as ean..
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                    
                    // Setting color as color..
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:VERIFICATION_PRODUCT_ID] defaultReturn:@""]
                                forKey:VERIFICATION_PRODUCT_ID];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:REMARKS] defaultReturn:@""] forKey:REMARKS];
                    
                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:STORAGE_UNIT] defaultReturn:@""] forKey:STORAGE_UNIT];
                    
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_REORDERED_QTY] defaultReturn:@"0.00"] floatValue]] forKey:SKU_REORDERED_QTY];
                    
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_ALLOCATED] defaultReturn:@"0.00"] floatValue]] forKey:SKU_ALLOCATED];
                    
                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kSalePriceValue] defaultReturn:@"0.00"] floatValue]] forKey:kSalePriceValue];
                    
                    [priceListArr addObject:GradeDic];
                }
            }
            
            else {
                
                [priceListArr addObject:itemDetailsDic];
            }
            
            //After Else Condition
            itemDetailsDic[SKU_PRICE_LIST] = priceListArr;
            
            [rawMaterialDetails addObject:itemDetailsDic];
            
        }
        
        totalBookStockVlueLbl.text = [NSString stringWithFormat:@"%.2f",bookStock];
        totalActualStockVlueLbl.text = [NSString stringWithFormat:@"%.2f",sku_Physical_Stock];
        declaredStockValueLbl.text = [NSString stringWithFormat:@"%.2f",declaredQty];
        dumpValueLbl.text = [NSString stringWithFormat:@"%.2f",dumpQty];
        closeStockValueLbl.text = [NSString stringWithFormat:@"%.2f",closeStockQty];
        stockLossValueLbl.text = [NSString stringWithFormat:@"%.2f",stockLossQty];
        
        //allocating mutable array...
        
        nextActivitiesArr = [NSMutableArray new];
        
        
        if([[updateStockDic valueForKey:NEXT_ACTIVITIES] count] || [[updateStockDic  valueForKey:NEXT_WORK_FLOW_STATES] count]){
            
            [nextActivitiesArr addObject:NSLocalizedString(@"--select--", nil)];
            for(NSString *str in [updateStockDic   valueForKey:NEXT_ACTIVITIES])
                [nextActivitiesArr addObject:str];
            
            for(NSString *str in [updateStockDic  valueForKey:NEXT_WORK_FLOW_STATES]  )
                [nextActivitiesArr addObject:str];
            
            cancelButton.frame = CGRectMake(submitBtn.frame.origin.x + submitBtn.frame.size.width+5,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
        }
        if(nextActivitiesArr.count == 0){
            [nextActivitiesArr addObject:@"No Activities"];
            
            submitBtn.hidden = YES;
            saveBtn.hidden = YES;
            itemsListTbl.userInteractionEnabled = NO;
            
            // frame for the UIbuttons...
            cancelButton.frame = CGRectMake(searchItemTxt.frame.origin.x,stockVerificationView.frame.size.height - 50,110, 40);
        }
        // added by roja on 03/03/2019...
        if ([[updateStockDic valueForKey:@"status"] caseInsensitiveCompare:@"Draft"] == NSOrderedSame) {
            
            submitBtn.hidden = NO;
            //                saveBtn.hidden = NO;
            itemsListTbl.userInteractionEnabled = NO;
            cancelButton.frame = CGRectMake(submitBtn.frame.origin.x + submitBtn.frame.size.width+5,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
        }  //Upto here added by roja on 03/03/2019...
        else{
            
            UIImage * workArrowImg = [UIImage imageNamed:@"workflow_arrow.png"];
            
            UIImageView * workFlowImageView = [[UIImageView alloc] init];
            
            workFlowImageView.image = workArrowImg;
            
            [workFlowView addSubview:workFlowImageView];
            
            NSArray *workFlowArr;
            
            workFlowArr = [updateStockDic valueForKey:PREVIOUS_STATES];
            
            workFlowImageView.frame = CGRectMake(workFlowView.frame.origin.x, 5,  workFlowView.frame.size.height + 30 , workFlowView.frame.size.height - 10);
            
            float label_x_origin = workFlowImageView.frame.origin.x + workFlowImageView.frame.size.width;
            float label_y_origin = workFlowImageView.frame.origin.y;
            
            float labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width)/ ((workFlowArr.count *3) - 1)   ;
            float labelHeight = workFlowImageView.frame.size.height;
            
            if( workFlowArr.count <= 3 )
                //taking max as 5 labels.....
                labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width - 380)/ 5;
            
            for(NSString *str  in workFlowArr){
                
                UILabel *workFlowNameLbl;
                UILabel *workFlowLineLbl;
                
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
                    workFlowLineLbl = [[UILabel alloc] init] ;
                    workFlowLineLbl.backgroundColor = [UIColor lightGrayColor];
                    
                    [workFlowView addSubview:workFlowLineLbl];
                    
                    workFlowLineLbl.frame = CGRectMake(label_x_origin,(labelHeight +8)/2,labelWidth, 2);
                    label_x_origin = workFlowLineLbl.frame.origin.x + workFlowLineLbl.frame.size.width;
                }
            }
        }
        //NSLog(@"---------%@",str);
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [rawMaterialDetailsTbl reloadData];
    }
}

/**
 * @description  here we are handling the resposne received from services...
 * @date         20/0/2016
 * @method       getProductVerificationErrorResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getProductVerificationErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         07/06/2017
 * @method       searchProductsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @para
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    
    @try {
        
        //checking the SuccessDictionary whether it is nil..
        if (successDictionary != nil && (searchItemTxt.tag == (searchItemTxt.text).length)) {
            
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
                
                [self showPopUpForTables:productListTbl  popUpWidth:searchItemTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItemTxt  showViewIn:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp];
            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            searchItemTxt.tag = 0;
            [HUD setHidden:YES];
        }
        
        else if ((((searchItemTxt.text).length >= 3) && (searchItemTxt.tag != 0)) && (searchItemTxt.tag != (searchItemTxt.text).length)) {
            
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
    @finally {
        
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       searchProductsErrorResponse:
 * @author       Bhargav Ram.v
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
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
    @finally {
        
        [catPopOver dismissPopoverAnimated:YES];
        searchItemTxt.tag = 0;
        [HUD setHidden:YES];
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/09/17
 * @method       getPriceListSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 */

-(void)getPriceListSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        int totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_SKUS]  defaultReturn:@"0"]intValue];
        
        for (NSDictionary * itemdic in [successDictionary valueForKey:SKU_LIST] ) {
            
            BOOL isExistingItem = false;
            
            NSDictionary * existItemdic;
            
            int i = 0;
            
            for (i= 0; i < rawMaterialDetails.count; i++) {
                
                //reading the existing cartItem....
                existItemdic = rawMaterialDetails[i];
                
                if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]]) {
                    
                    rawMaterialDetails[i] = existItemdic;
                    
                    isExistingItem = true;
                    
                    break;
                }
            }
            
            if (isExistingItem) {
                
                float y_axis = self.view.frame.size.height - 120;
                
                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"item_already_added_to_the_cart",nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType: @""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            }
            
            else {
                NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                
                // setting skuId as skuId
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:SKU_ID];
                
                //setting Description as SkuDescription
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:kskuDescription];
                
                //setting pluCode....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                
                //Setting skuCostPrice as costPrice
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
                
                //setting quantity....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];
                
                //setting productRange....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                
                //setting measureRange
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                
                //setting category
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                
                //setting Product Category...
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
                
                //setting subCategory...
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                
                [itemDetailsDic setValue:EMPTY_STRING forKey:LOSS_TYPE];
                
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
                
                // float openStock  = 0.0;
                
                NSMutableArray * priceListArr = [NSMutableArray new];
                
                if ([[itemdic valueForKey:SKU_PRICE_LIST] count]) {
                    
                    for (NSDictionary * priceListDic in [itemdic valueForKey:SKU_PRICE_LIST]) {
                        
                        NSMutableDictionary * GradeDic = [NSMutableDictionary new];
                        
                        // Setting SkuId as Sku_id
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:SKU_ID];
                        
                        // Setting SkuId as Sku_id
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:VERIFICATION_PRODUCT_ID];
                        
                        
                        //Setting Description as SkuDescription
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:kskuDescription];
                        
                        //Setting pluCode as pluCode
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        //Setting productRange as productRange
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        //Setting quantityInHand as openStock
                        [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:OPEN_STOCK];
                        
                        //Setting quantityInHand as product_physical_stock
                        [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_PHYSICAL_STOCK];
                        
                        //Setting quantityInHand as product_book_stock
                        [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_BOOK_STOCK];
                        
                        //Setting quantityInHand as sku_book_stock
                        [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:SKU_BOOK_STOCK];
                        
                        //Setting soldQty as saleQty
                        [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SOLD_QTY] defaultReturn:@"0.00"] floatValue]] forKey:SALE_QTY];
                        
                        //Setting costPrice as skuCostPrice
                        [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
                        
                        [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:kSalePriceValue];
                        
                        //Setting measureRange as measureRange
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                        
                        //Setting subCategory as subCategory
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        //Setting uom as uom
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        //Setting ean as ean
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        //Setting color as color
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODAL];
                        
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                        
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
                        
                        //Setting productCategory as productCategory(which we are retreving from the Parent Dictionary)....
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PRODUCT_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
                        
                        //Setting productId as productId(which we are retreving from the Parent Dictionary)....
                        [GradeDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PRODUCT_ID] defaultReturn:@""] forKey:PRODUCT_ID];
                        
                        float bookStock = [[self checkGivenValueIsNullOrNil:[GradeDic valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue] -[[self checkGivenValueIsNullOrNil:[GradeDic valueForKey:SALE_QTY] defaultReturn:@"0.00"] floatValue];
                        
                        //Setting openStock - saleQty as sku_book_stock
                        [GradeDic setValue:[NSString stringWithFormat:@"%.2f",bookStock] forKey:SKU_BOOK_STOCK];
                        
                        //setting sku_physical_stock as 0..
                        [GradeDic setValue:[NSString stringWithFormat:@"%d",0] forKey:SKU_PHYSICAL_STOCK];
                        
                        //setting skuBookStock as 0..
                        [GradeDic setValue:[NSString stringWithFormat:@"%d",0] forKey:DECLARED_QTY];
                        
                        //setting dumpQty as 0..
                        [GradeDic setValue:[NSString stringWithFormat:@"%d",0] forKey:DUMP_QTY];
                        
                        //setting closedStock as 0..
                        [GradeDic setValue:[NSString stringWithFormat:@"%d",0] forKey:CLOSED_STOCK];
                        
                        //setting stock_loss as 0..
                        [GradeDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kStock_loss];
                        
                        [GradeDic setValue:[NSString stringWithFormat:@"%d",0] forKey:STOCKLOSS_QTY];
                        
                        [GradeDic setValue:EMPTY_STRING forKey:REMARKS];
                        [GradeDic setValue:EMPTY_STRING forKey:STORAGE_UNIT];
                        [GradeDic setValue:@"0.00" forKey:SKU_REORDERED_QTY];
                        [GradeDic setValue:@"0.00" forKey:SKU_ALLOCATED];
                        //Scan Code...
                        [GradeDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                        
                        [priceListArr addObject:GradeDic];
                    }
                }
                else {
                    
                    [priceListArr addObject:itemDetailsDic];
                }
                
                //After Else Condition
                itemDetailsDic[SKU_PRICE_LIST] = priceListArr;
                
                [rawMaterialDetails addObject:itemDetailsDic];
            }
        }
        
        if (selectCategoriesBtn.tag == 1) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItemTxt.isEditing)
                y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,@"  Records Are added to the cart successfully"];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"CART_RECORDS" conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        
        [self calculateTotal];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [rawMaterialDetailsTbl reloadData];
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
        [categoriesPopOver dismissPopoverAnimated:YES];
        
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

-(void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    //
    [HUD setHidden:YES];
    
    isItemScanned = false;
    searchItemTxt.text = @"";
    
    @try {
        
        //To Display the Pric List view when we have variant products under one sku...
        priceDic = [[NSMutableArray alloc]init];
        
        NSArray * price_arr = [successDictionary valueForKey:kSkuLists];
        
        for (int i=0; i<price_arr.count; i++) {
            
            NSDictionary * json = price_arr[i];
            [priceDic addObject:json];
        }
        if (((NSArray *)[successDictionary valueForKey:kSkuLists]).count>1) {
            
            if (priceDic.count> 0) {
                [HUD setHidden:YES];
                transparentView.hidden = NO;
                [pricListTbl reloadData];
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"popup_tune" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                
                //Audio Allocation...
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        
        else {
            
            NSMutableArray * priceListArr = [NSMutableArray new];
            
            NSUInteger priceLists = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:kSkuLists]  defaultReturn:@"0"]count];
            
            for (NSDictionary * itemdic in [successDictionary valueForKey:kSkuLists]) {
                
                BOOL isExistingItem = false;
                
                NSDictionary * existItemdic;
                int i = 0;

                // added by roja on 02/05/2019...
                NSDictionary * existPriceListDic;
                int j = 0;

                for (i = 0; i < rawMaterialDetails.count; i++) {
                    
                    existItemdic = rawMaterialDetails[i];

                    //reading the existing cartItem....
                    if ([[existItemdic valueForKey:SKU_ID] isEqualToString:[itemdic valueForKey:ITEM_SKU]] &&  (![[itemdic valueForKey:TRACKING_REQUIRED] boolValue])) {
                        //[[existItemdic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]] &&
                        for (j = 0; j < [[existItemdic valueForKey:@"skuPriceLists"] count]; j++) {

                            existPriceListDic = [existItemdic valueForKey:@"skuPriceLists"][j];
                            
                            if ([[existPriceListDic valueForKey:SKU_ID] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[existPriceListDic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]] ) { //&& (![[itemdic valueForKey:TRACKING_REQUIRED] boolValue])
                                
                                [existPriceListDic setValue:[NSString stringWithFormat:@"%.2f",[[existPriceListDic valueForKey:SKU_PHYSICAL_STOCK] floatValue] + 1] forKey:SKU_PHYSICAL_STOCK];
                                
                                isExistingItem = true;
                                break;
                            }
                        }
                        
                        [[existItemdic valueForKey:@"skuPriceLists"] replaceObjectAtIndex:j withObject:existPriceListDic];
                        rawMaterialDetails[i] = existItemdic;
                    }
                }
                
                // Commented by roja on 02/05/2019...
                // Reason Previously only once item should be added.. now repeatedly item can add.
//                for (i = 0; i < rawMaterialDetails.count; i++) {
//
//                    //reading the existing cartItem....
//                    existItemdic = rawMaterialDetails[i];
//
//                    if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]] && (![[itemdic valueForKey:TRACKING_REQUIRED] boolValue])) {
//
//                        rawMaterialDetails[i] = existItemdic;
//                        isExistingItem = true;
//                        break;
//                    }
//                }
//                if (isExistingItem) {
//                    float y_axis = self.view.frame.size.height - 120;
//                    NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"item_already_added_to_the_cart",nil)];
//
//                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType: @""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
//                }
                //Upto here Commented by roja on 02/05/2019...

                
                if(!isExistingItem){
                    
                    NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                    
                    // setting skuId as skuId
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:SKU_ID];
                    
                    //setting Description as SkuDescription
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:kskuDescription];
                    
                    //setting pluCode....
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                    
                    //Setting skuCostPrice as costPrice
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
                    
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:kSalePriceValue];
                    
                    
                    //setting quantity....
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];
                    
                    //setting productRange....
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                    
                    //setting measureRange
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                    
                    //setting category
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                    
                    //setting Product Category...
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
                    
                    //setting subCategory...
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MODEL] defaultReturn:@""] forKey:MODAL];
                    
                    [itemDetailsDic setValue:EMPTY_STRING forKey:LOSS_TYPE];
                    
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
                    
                    //To Display the grid Items based on skuLists count...
                    for (int j = 0; j < priceLists; j++) {
                        
                        NSMutableDictionary * priceListDictionary = [[NSMutableDictionary alloc] init];
                        
                        // Setting SkuId as Sku_id
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:SKU_ID];
                        
                        // Setting SkuId as Sku_id
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:VERIFICATION_PRODUCT_ID];
                        
                        //setting pluCode....
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        //Setting Description as SkuDescription
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:kskuDescription];
                        
                        //Setting productRange as productRange
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        //Setting quantityInHand as openStock
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:OPEN_STOCK];
                        
                        //Setting quantityInHand as product_physical_stock
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_PHYSICAL_STOCK];
                        
                        //Setting quantityInHand as product_book_stock
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_BOOK_STOCK];
                        
                        //Setting quantityInHand as sku_book_stock
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:SKU_BOOK_STOCK];
                        
                        //Setting soldQty as saleQty
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SOLD_QTY] defaultReturn:@"0.00"] floatValue]] forKey:SALE_QTY];
                        
                        //Setting costPrice as skuCostPrice
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
                        
                        //SALE_PRICE for SalePriceValue
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:kSalePriceValue];
                        
                        //Setting measureRange as measureRange
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                        
                        //Setting subCategory as subCategory
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        //Setting uom as uom
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];

                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];

                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
                        
                        [priceListDictionary setValue:EMPTY_STRING forKey:REMARKS];
                        [priceListDictionary setValue:EMPTY_STRING forKey:STORAGE_UNIT];
                        [priceListDictionary setValue:@"0.00" forKey:SKU_REORDERED_QTY];
                        [priceListDictionary setValue:@"0.00" forKey:SKU_ALLOCATED];
                        [priceListDictionary setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                        
                        // added by roja on 02/05/2019...
                        //setting sku_physical_stock as 0..
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:SKU_PHYSICAL_STOCK];
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:DECLARED_QTY];
                        //setting dumpQty as 0..
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:DUMP_QTY];
                        //setting closedStock as 0..
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:CLOSED_STOCK];
                        //setting stock_loss as 0..
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:kStock_loss];
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:STOCKLOSS_QTY];
                        // upto here added by roja on 02/05/2019...
                        
                        [priceListArr addObject:priceListDictionary];
                        
                    }
                    
                    itemDetailsDic[SKU_PRICE_LIST] = priceListArr;
                    
                    [rawMaterialDetails addObject:itemDetailsDic];
                }
                
                //creating the successAlertSound.......
                if(!isExistingItem) {
                    SystemSoundID    soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                }
            }
            
            [self calculateTotal];
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [rawMaterialDetailsTbl reloadData];
        [categoriesPopOver dismissPopoverAnimated:YES];
        
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
- (void)getSkuDetailsErrorResponse:(NSString *)failureString {
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",failureString];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        isItemScanned = false;
        searchItemTxt.text = @"";
        
        [HUD setHidden:YES];
        [categoriesPopOver dismissPopoverAnimated:YES];
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
-(void)updateStockVerificationSuccessResponse:(NSDictionary *)successDictionary {
    
    float y_axis;
    NSString * mesg;
    
    @try {
        [HUD setHidden:YES];
        
        y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_verification_updated_successfully",nil),@"\n",[successDictionary valueForKey:VERIFICATION_CODE]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException * exception) {
        
        mesg = [NSString stringWithFormat:@"%@%@",@"stock verification updated Successfully",@"\n"];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
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

-(void)updateStockVerificationErrorResponse:(NSString *)requestString{
    
    @try {
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        //upto here on 02/05/2018....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",requestString];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
    }
}

#pragma mark displaying the calendar..

/**
 * @description  here we are showing the calender in popUp view....
 * @date         26/09/2016
 * @method       showCalenderInPopUp:
 * @author       Bhargav.v
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
            
            pickView.frame = CGRectMake( 15, startDteTxt.frame.origin.y+startDteTxt.frame.size.height, 320, 320);
            
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
            
            
            
            [popover presentPopoverFromRect:startDteTxt.frame inView:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @description  clear the date from textField and calling services.......
 * @date         01/03/2017
 * @method       clearDate:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)clearDate:(UIButton *)sender {
    //    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        if((startDteTxt.text).length)
            
            
            startDteTxt.text = @"";
        
        
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  Here we are populating date to text field...
 * @date         01/03/2017
 * @method       populateDateToTextField:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
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
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate *existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if(sender.tag == 2){
            if ((startDteTxt.text).length != 0 && ( ![startDteTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDteTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDteTxt.text = @"";
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    return;
                }
            }
            startDteTxt.text = dateString;
        }
        else{
            
            if ((endDteTxt.text).length != 0 && (![endDteTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDteTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDteTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            endDteTxt.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
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
            
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
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
            
            [popover presentPopoverFromRect:ActionReqTxt.frame inView:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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



#pragma mark display the loss Type...


/**
 * @description  displaying popOVer for the priority List.......
 * @date         20/0/2016
 * @method       populatePriorityList:
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

-(void)showLossTypeList:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        lossTypeArr = [NSMutableArray new];
        [lossTypeArr addObject:@"Damaged"];
        [lossTypeArr addObject:@"Theft"];
        [lossTypeArr addObject:@"Others"];
        
        int count = 5;
        
        
        if (lossTypeArr.count < count){
            count = (int)lossTypeArr.count;
        }
        
        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,lossTypeTxt.frame.size.width+10,count* 35)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        losstypeTbl = [[UITableView alloc] init];
        losstypeTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        losstypeTbl.dataSource = self;
        losstypeTbl.delegate = self;
        (losstypeTbl.layer).borderWidth = 1.0f;
        losstypeTbl.layer.cornerRadius = 3;
        losstypeTbl.layer.borderColor = [UIColor grayColor].CGColor;
        losstypeTbl.separatorColor = [UIColor grayColor];
        losstypeTbl.tag = sender.tag;

        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            losstypeTbl.frame = CGRectMake(0,0,customView.frame.size.width,customView.frame.size.height);
            
        }
        
        [customView addSubview:losstypeTbl];
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            NSIndexPath * selectedRow = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
            
            UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:lossTypeTxt.frame inView:[rawMaterialDetailsTbl cellForRowAtIndexPath:selectedRow] permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
            catPopOver= popover;
        }
        
        else {
            
            customerInfoPopUp.preferredContentSize = CGSizeMake(160.0,250.0);
            
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
        
        [losstypeTbl reloadData];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  Displaying the popover to show the SKU and DESCRIPTION of the ITEM
 * @date         08/07/2018
 * @method       showItemSkuAndDescrption
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)showItemSkuAndDescrption:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);

    @try {
        
        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,itemSkuidButton.frame.size.width + 220,70)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        
        UILabel * item_skuidLabel = [[UILabel alloc] init];
        item_skuidLabel.layer.borderWidth = 0;
        item_skuidLabel.textAlignment = NSTextAlignmentCenter;
        item_skuidLabel.numberOfLines = 1;
        item_skuidLabel.lineBreakMode = NSLineBreakByWordWrapping;
        item_skuidLabel.textColor = [UIColor blackColor];
        
        UILabel * item_DescriptionLabel = [[UILabel alloc] init];
        item_DescriptionLabel.layer.borderWidth = 0;
        item_DescriptionLabel.textAlignment = NSTextAlignmentCenter;
        item_DescriptionLabel.numberOfLines = 1;
        item_DescriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        item_DescriptionLabel.textColor = [UIColor blackColor];
        
        item_skuidLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
        item_DescriptionLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            item_skuidLabel.frame = CGRectMake(0,0,customView.frame.size.width,30);
            item_DescriptionLabel.frame = CGRectMake(0,item_skuidLabel.frame.origin.y + item_skuidLabel.frame.size.height + 5,customView.frame.size.width,30);
        }
        
        [customView addSubview:item_skuidLabel];
        [customView addSubview:item_DescriptionLabel];
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            NSIndexPath * selectedRow = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
            
            UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:itemSkuidButton.frame inView:[rawMaterialDetailsTbl cellForRowAtIndexPath:selectedRow] permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            
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
        
        if (rawMaterialDetails.count) {
            
            item_skuidLabel.text = [self checkGivenValueIsNullOrNil:[rawMaterialDetails[sender.tag] valueForKey:SKU_ID]  defaultReturn:@"--"];
            item_DescriptionLabel.text = [self checkGivenValueIsNullOrNil:[rawMaterialDetails[sender.tag] valueForKey:kskuDescription]  defaultReturn:@"--"];
        }
    }
    @catch(NSException * exception){
        
    }
    @finally {
        
    }
}


#pragma mark diaplaying the time for the selection..

- (void)selectTime:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        
        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        pickView = [[UIView alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            pickView.frame = CGRectMake( 15, startTimeTxt.frame.origin.y+startTimeTxt.frame.size.height, 320, 320);
            
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
        NSDate * now = [NSDate date];
        [myPicker setDate:now animated:YES];
        myPicker.backgroundColor = [UIColor whiteColor];
        
        //        myPicker.datePickerMode = UIDatePickerModeTime;
        
        UIButton  * pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        
        
        //        pickButton.backgroundColor = [UIColor grayColor];
        
        
        //        pickButton.backgroundColor = [UIColor clearColor];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(getTime:) forControlEvents:UIControlEventTouchUpInside];
        //        pickButton.layer.borderColor = [UIColor blackColor].CGColor;
        //        pickButton.layer.borderWidth = 0.5f;
        //        pickButton.layer.cornerRadius = 12;
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        //added by srinivasulu on 02/02/2017....
        
        UIButton  * clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        
        
        //        pickButton.backgroundColor = [UIColor grayColor];
        
        //        clearButton.backgroundColor = [UIColor clearColor];
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearTime:) forControlEvents:UIControlEventTouchUpInside];
        //        clearButton.layer.borderColor = [UIColor blackColor].CGColor;
        //        clearButton.layer.borderWidth = 0.5f;
        //        clearButton.layer.cornerRadius = 12;
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        
        //pickButton.frame = CGRectMake( (customView.frame.size.width / 2)-(100/2), 269, 100, 45);
        //clearButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
        
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        //upto here on 02/02/2017....
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:startTimeTxt.frame inView:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else if (sender.tag == 4)
                [popover presentPopoverFromRect:endTimeTxt.frame inView:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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

-(void)clearTime:(UIButton *)sender{
    
    //BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        if(  sender.tag == 2){
            if((startTimeTxt.text).length)
                //                callServices = true;
                
                startTimeTxt.text = @"";
        }
        else{
            if((endTimeTxt.text).length)
                //                callServices = true;
                
                endTimeTxt.text = @"";
        }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate()----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}

/**
 * @description  clear the date from textField and calling services.......
 * @date         01/09/2017
 * @method       getTime:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getTime:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        
        //Date Formate Setting...
        NSDateFormatter * requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"HH:mm:ss";
        dateString =  [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate *existingDateString;
        /*z;
         UITextField *endstartDteTxt;*/
        
        if(sender.tag == 2){
            if ((startTimeTxt.text).length != 0 && (![startTimeTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startTimeTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startTimeTxt.text = @"";
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start Time should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    return;
                }
            }
            startTimeTxt.text = dateString;
        }
        else {
            
            if ((endTimeTxt.text).length != 0 && (![endTimeTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endTimeTxt.text];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endTimeTxt.text = @"";
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"End Time should not be earlier than start date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            endTimeTxt.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
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
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x || textField.frame.origin.x == gradeStockTxt.frame.origin.x || textField.frame.origin.x == dumpQtyTxt.frame.origin.x)
        
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    @try {
        
        @try {
            
            if(textField == searchItemTxt){
                
                offSetViewTo = 120;
            }
            
            else if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x || textField.frame.origin.x  == gradeStockTxt.frame.origin.x || textField.frame.origin.x  == dumpQtyTxt.frame.origin.x  ) {
                
                [textField selectAll:nil];
                [UIMenuController sharedMenuController].menuVisible = NO;
                
                offSetViewTo = 140;
            }
            [self keyboardWillShow];
            
        } @catch (NSException * exception) {
            
        }
        
    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
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
    
    
    if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x || textField.frame.origin.x  == gradeStockTxt.frame.origin.x || textField.frame.origin.x  == dumpQtyTxt.frame.origin.x ) {
        
        
        @try {
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
            NSError  *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
            return numberOfMatches != 0;
        } @catch (NSException * exception) {
            
            NSLog(@"-exception in texField:shouldChangeCharactersInRange:replalcement----%@",exception);
            
            return YES;
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
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 * @return
 * @return
 * @verified By
 * @verified On
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchItemTxt) {
        
        if (isSearch.on) {
            
            if ((textField.text).length>= 3) {
                
                @try {
                    
                    if (searchItemTxt.tag == 0) {
                        
                        searchItemTxt.tag = (textField.text).length;
                        productList = [[NSMutableArray alloc]init];
                        searchString = [textField.text copy];
                        [self callRawMaterials:textField.text];
                    }
                    
                    else {
                        
                        [HUD setHidden:YES];
                        [catPopOver dismissPopoverAnimated:YES];
                    }
                    
                } @catch (NSException *exception) {
                    
                }
            }
        }
        //added by Roja on 03/04/2019....
        else{
            if ((textField.text).length>= 9) {
                
                @try {
                    //                searchItemTxt.tag = 0;
                    
                    if(intervalTImer == nil)
                        intervalTImer =  [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(searchBarcode) userInfo:nil repeats:NO];
                    else{
                        [intervalTImer invalidate];
                        
                        intervalTImer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(searchBarcode) userInfo:nil repeats:NO];
                    }
                    
                } @catch (NSException * exception) {
                    
                }
            }
            
        }
        
        // Commented by roja on 03/04/2019....
        //        else {
        //            [HUD setHidden:YES];
        //            searchItemTxt.tag = 0;
        //            [catPopOver dismissPopoverAnimated:YES];
        //
        //        }
        
    
    }
    
    else if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x) {
        
        reloadTableData = true;
        
        @try {
            
            
            NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
            
            float bookStock  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:SKU_BOOK_STOCK] defaultReturn:@"0.00"] floatValue];
            float actualStock= (textField.text).floatValue;
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",(bookStock - actualStock)] forKey:STOCKLOSS_QTY];
            [temp setValue:textField.text  forKey:SKU_PHYSICAL_STOCK];
            
            itemsListArr[textField.tag] = temp;
            
            NSMutableDictionary * mutDic = rawMaterialDetails[itemsListTbl.tag];
            
            [mutDic setValue:itemsListArr forKey:SKU_PRICE_LIST];
            rawMaterialDetails[itemsListTbl.tag] = mutDic;
            
        }
        @catch (NSException * exception) {
            NSLog(@"---%@",exception);
        }
        @finally {
            
        }
    }

    else if (textField.frame.origin.x == dumpQtyTxt.frame.origin.x) {
        reloadTableData = true;
        
        @try {
            
            NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
            
            float actualStock  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue];
            float dumpStock = (textField.text).floatValue;
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",(actualStock - dumpStock)] forKey:DECLARED_QTY];
            [temp setValue:textField.text  forKey:DUMP_QTY];
            
            itemsListArr[textField.tag] = temp;
            
            NSMutableDictionary * mutDic = rawMaterialDetails[itemsListTbl.tag];
            
            [mutDic setValue:itemsListArr forKey:SKU_PRICE_LIST];
            rawMaterialDetails[itemsListTbl.tag] = mutDic;
            
        }
        @catch (NSException * exception) {
            NSLog(@"---%@",exception);
        }
        @finally {
            
        }
    }
    
    else if (textField.frame.origin.x == gradeStockTxt.frame.origin.x ) {
        
        reloadTableData = true;
        
        @try {
            
            NSString * qtyKey = DECLARED_QTY;
            
            if(textField.frame.origin.x == gradeStockTxt.frame.origin.x)
                
                qtyKey = DECLARED_QTY;
            
            NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            itemsListArr[textField.tag] = temp;
            
            NSMutableDictionary * mutDic = rawMaterialDetails[itemsListTbl.tag];
            
            [mutDic setValue:itemsListArr forKey:SKU_PRICE_LIST];
            rawMaterialDetails[itemsListTbl.tag] = mutDic;
            
        }
        @catch(NSException * exception) {
            
            NSLog(@"---%@",exception);
            
        }
    }
    
    else if(textField.frame.origin.x == scanCodeText.frame.origin.x) {
        
        @try {
            NSMutableDictionary * dic =  [itemsListArr[textField.tag] mutableCopy];
            
            [dic setValue:textField.text  forKey:ITEM_SCAN_CODE];
            itemsListArr[textField.tag] = dic;
        }
        @catch(NSException * exception) {
            
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

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    
    offSetViewTo = 0;
    
    if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x ) {
        
        @try {
            
            NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
            
            float bookStock  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:SKU_BOOK_STOCK] defaultReturn:@"0.00"] floatValue];
            float actualStock= (textField.text).floatValue;
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",(bookStock - actualStock)] forKey:STOCKLOSS_QTY];
            [temp setValue:textField.text  forKey:SKU_PHYSICAL_STOCK];
            
            itemsListArr[textField.tag] = temp;
            
            NSMutableDictionary * mutDic = rawMaterialDetails[itemsListTbl.tag];
            
            [mutDic setValue:itemsListArr forKey:SKU_PRICE_LIST];
            rawMaterialDetails[itemsListTbl.tag] = mutDic;
            
        }
        @catch (NSException *exception) {
            NSLog(@"---------%@",exception);
        }
        @finally {
            if(reloadTableData)
                [rawMaterialDetailsTbl reloadData];
            [self calculateTotal];
            
        }
        
    }
    
    else if (textField.frame.origin.x == dumpQtyTxt.frame.origin.x ) {
        
        @try {
            if ((textField.text).integerValue == 0) {
                
            }
            NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
            
            float actualStock  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue];
            float dumpStock = (textField.text).floatValue;
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",(actualStock - dumpStock)] forKey:DECLARED_QTY];
            [temp setValue:textField.text  forKey:DUMP_QTY];
            
            itemsListArr[textField.tag] = temp;
            
            NSMutableDictionary * mutDic = rawMaterialDetails[itemsListTbl.tag];
            
            [mutDic setValue:itemsListArr forKey:SKU_PRICE_LIST];
            rawMaterialDetails[itemsListTbl.tag] = mutDic;
            
        }
        @catch (NSException *exception) {
            NSLog(@"---------%@",exception);
        }
        @finally {
            if(reloadTableData)
                [rawMaterialDetailsTbl reloadData];
            [self calculateTotal];
            
        }
    }
    
    else if (textField.frame.origin.x == gradeStockTxt.frame.origin.x ) {
        
        @try {
            
            NSString * qtyKey = DECLARED_QTY;
            
            if(textField.frame.origin.x == gradeStockTxt.frame.origin.x)
                
                qtyKey = DECLARED_QTY;
            
            NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            itemsListArr[textField.tag] = temp;
            
            NSMutableDictionary * mutDic = rawMaterialDetails[itemsListTbl.tag];
            
            [mutDic setValue:itemsListArr forKey:SKU_PRICE_LIST];
            rawMaterialDetails[itemsListTbl.tag] = mutDic;
            
            
        }
        @catch (NSException *exception) {
            NSLog(@"---------%@",exception);
        }
        @finally {
            if(reloadTableData)
                [rawMaterialDetailsTbl reloadData];
            
            [self calculateTotal];
            
        }
    }
    
    else if(textField.frame.origin.x == scanCodeText.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary * dic =  [itemsListArr[textField.tag] mutableCopy];
            [dic setValue:textField.text  forKey:ITEM_SCAN_CODE];
            itemsListArr[textField.tag] = dic;
        }
        @catch(NSException * exception) {
            
        }
        if(reloadTableData)
            [rawMaterialDetailsTbl reloadData];
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





#pragma -mark start of UITableViewDelegateMethods


/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         09/05/2017
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
    
    if (tableView == rawMaterialDetailsTbl) {
        
        return rawMaterialDetails.count;

        // Commented by roja on 27/05/2019..
        // Reason should follow the rawMaterialDetails.count..
//        if (rawMaterialDetails.count)
//
//            return rawMaterialDetails.count;
       
//        else
//
//         return 1;
    }
  
    return 1;
}



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
    else if(tableView == rawMaterialDetailsTbl) {
        
        @try{
            if (self.isOpen) {
                if (self.selectIndex.section == section) {
                    return 1+1;
                }
            }
        } @catch(NSException *exception){
            
            [self calculateTotal];
        }
        return 1;
    }
    
    else if (tableView == categoriesTbl) {
        
        return categoriesArr.count;
    }
    else if (tableView == nextActivityTbl) {
        return nextActivitiesArr.count;
    }
    
    else if (tableView == losstypeTbl) {
        return lossTypeArr.count;
    }
    
    else if (tableView == itemsListTbl){
        
        return itemsListArr.count;
    }
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (tableView == rawMaterialDetailsTbl) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (indexPath.row == 0) {
                return 40;
            }
            else{
                if (itemsListArr.count > 4 ) {
                    return (40 * 4) + 30;
                }
                
                return (itemsListArr.count * 40) + 70;
                
            }
        }
        else {
            if (indexPath.row == 0) {
                return 30;
            }
            else{
                if (itemsListArr.count > 4) {
                    return 30 * 4;
                }
                
                return itemsListArr.count * 30;
            }
        }
    }
    
  else  if (tableView == productListTbl|| tableView == categoriesTbl|| tableView == nextActivityTbl|| tableView == losstypeTbl || tableView == itemsListTbl){
        return 35;
    }
    
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
    
    else if (tableView == rawMaterialDetailsTbl) {
        
        if (self.isOpen && self.selectIndex.section == indexPath.section&&indexPath.row!= 0) {
            
            static NSString  * cellIdentifier = @"cell1";
            
            UITableViewCell  * hlcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ((hlcell.contentView).subviews){
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                hlcell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
                
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:10];
            }
            hlcell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            
            
            [hlcell.contentView addSubview:requestedItemsTblHeaderView];
            [hlcell.contentView addSubview:itemsListTbl];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (itemsListArr.count > 4) {
                    
                    hlcell.frame = CGRectMake(rawMaterialDetailsTbl.frame.origin.x,0,rawMaterialDetailsTbl.frame.size.width,40*4+40);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    itemsListTbl.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,requestedItemsTblHeaderView.frame.size.height + 5,  requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height-77);
                }
                
                else {
                    
                    hlcell.frame = CGRectMake(rawMaterialDetailsTbl.frame.origin.x, 0, rawMaterialDetailsTbl.frame.size.width,  (40 * (itemsListArr.count + 2))+ 30);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x, 10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    itemsListTbl.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height+5,requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height-80);
                    
                }
            }
            
            else {
                
                if (itemsListArr.count >4) {
                    
                    hlcell.frame = CGRectMake( 15, 0,rawMaterialDetailsTbl.frame.size.width - 15,  30*4);
                    
                    itemsListTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, hlcell.frame.size.height);
                    
                }
                else {
                    
                    hlcell.frame = CGRectMake(25,0,rawMaterialDetailsTbl.frame.size.width - 25,  itemsListArr.count*30);
                    
                    itemsListTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10,itemsListArr.count*30);
                }
            }
            
            [itemsListTbl reloadData];
            
            hlcell.backgroundColor = [UIColor clearColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
       
        else {
            
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            static NSString * hlCellID = @"hlCellID";
            
            UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
            
            if ((hlcell.contentView).subviews){
                for (UIView * subview in (hlcell.contentView).subviews) {
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
                    
                    layer_1.frame = CGRectMake(snoLbl.frame.origin.x, hlcell.frame.size.height - 2, actionLbl.frame.origin.x+actionLbl.frame.size.width-(snoLbl.frame.origin.x), 1);
                    
                    [hlcell.contentView.layer addSublayer:layer_1];
                    
                } @catch (NSException *exception) {
                    
                }
            }
            
            UILabel * item_NoLbl;
            UILabel * item_DescLbl;
            UILabel * uom_Label;
            UILabel * openStock_Lbl;
            UILabel * saleQty_Lbl;
            UILabel * bookStock_Lbl;
            UILabel * actualStock_Lbl;
            UILabel * dump_Lbl;
            UILabel * stockLoss_Lbl;
            UILabel * declaredStock_Lbl;
            UILabel * closeStock_Lbl;

            
            item_NoLbl = [[UILabel alloc] init];
            item_NoLbl.backgroundColor = [UIColor clearColor];
            item_NoLbl.layer.borderWidth = 0;
            item_NoLbl.textAlignment = NSTextAlignmentCenter;
            item_NoLbl.numberOfLines = 1;
            item_NoLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemSkuidButton = [[UIButton alloc] init] ;
            itemSkuidButton.tag = indexPath.section;
            [itemSkuidButton addTarget:self action:@selector(showItemSkuAndDescrption:) forControlEvents:UIControlEventTouchUpInside];

            item_DescLbl = [[UILabel alloc] init];
            item_DescLbl.backgroundColor = [UIColor clearColor];
            item_DescLbl.layer.borderWidth = 0;
            item_DescLbl.textAlignment = NSTextAlignmentCenter;
            item_DescLbl.numberOfLines = 1;
            item_DescLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            uom_Label = [[UILabel alloc] init];
            uom_Label.backgroundColor = [UIColor clearColor];
            uom_Label.layer.borderWidth = 0;
            uom_Label.textAlignment = NSTextAlignmentCenter;
            uom_Label.numberOfLines = 1;
            uom_Label.lineBreakMode = NSLineBreakByWordWrapping;
            
            openStock_Lbl = [[UILabel alloc] init];
            openStock_Lbl.backgroundColor = [UIColor clearColor];
            openStock_Lbl.layer.borderWidth = 0;
            openStock_Lbl.textAlignment = NSTextAlignmentCenter;
            openStock_Lbl.numberOfLines = 1;
            openStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            saleQty_Lbl = [[UILabel alloc] init];
            saleQty_Lbl.backgroundColor = [UIColor clearColor];
            saleQty_Lbl.layer.borderWidth = 0;
            saleQty_Lbl.textAlignment = NSTextAlignmentCenter;
            saleQty_Lbl.numberOfLines = 1;
            saleQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            bookStock_Lbl = [[UILabel alloc] init];
            bookStock_Lbl.backgroundColor = [UIColor clearColor];
            bookStock_Lbl.layer.borderWidth = 0;
            bookStock_Lbl.textAlignment = NSTextAlignmentCenter;
            bookStock_Lbl.numberOfLines = 1;
            bookStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            actualStock_Lbl = [[UILabel alloc] init];
            actualStock_Lbl.backgroundColor = [UIColor clearColor];
            actualStock_Lbl.layer.borderWidth = 0;
            actualStock_Lbl.textAlignment = NSTextAlignmentCenter;
            actualStock_Lbl.numberOfLines = 1;
            actualStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            dump_Lbl = [[UILabel alloc] init];
            dump_Lbl.backgroundColor = [UIColor clearColor];
            dump_Lbl.layer.borderWidth = 0;
            dump_Lbl.textAlignment = NSTextAlignmentCenter;
            dump_Lbl.numberOfLines = 1;
            dump_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            stockLoss_Lbl = [[UILabel alloc] init];
            stockLoss_Lbl.backgroundColor = [UIColor clearColor];
            stockLoss_Lbl.layer.borderWidth = 0;
            stockLoss_Lbl.textAlignment = NSTextAlignmentCenter;
            stockLoss_Lbl.numberOfLines = 1;
            stockLoss_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            declaredStock_Lbl = [[UILabel alloc] init];
            declaredStock_Lbl.backgroundColor = [UIColor clearColor];
            declaredStock_Lbl.layer.borderWidth = 0;
            declaredStock_Lbl.textAlignment = NSTextAlignmentCenter;
            declaredStock_Lbl.numberOfLines = 1;
            declaredStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            closeStock_Lbl = [[UILabel alloc] init];
            closeStock_Lbl.backgroundColor = [UIColor clearColor];
            closeStock_Lbl.layer.borderWidth = 0;
            closeStock_Lbl.textAlignment = NSTextAlignmentCenter;
            closeStock_Lbl.numberOfLines = 1;
            closeStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            lossTypeTxt = [[UITextField alloc] init];
            lossTypeTxt.borderStyle = UITextBorderStyleRoundedRect;
            lossTypeTxt.layer.borderWidth = 2;
            lossTypeTxt.backgroundColor = [UIColor clearColor];
            lossTypeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            lossTypeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            lossTypeTxt.returnKeyType = UIReturnKeyDone;
            lossTypeTxt.delegate = self;
            lossTypeTxt.textAlignment = NSTextAlignmentLeft;
            lossTypeTxt.tag = indexPath.section;
            lossTypeTxt.userInteractionEnabled = NO;
            
            UIImage * buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];

            lossTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [lossTypeBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
            lossTypeBtn.tag = indexPath.section;
            [lossTypeBtn addTarget:self action:@selector(showLossTypeList:) forControlEvents:UIControlEventTouchDown];
            
            delrowbtn = [[UIButton alloc] init];
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            delrowbtn.tag = indexPath.section;
            delrowbtn.backgroundColor = [UIColor clearColor];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];

            if([submitBtn.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ){
                
                delrowbtn.userInteractionEnabled   = NO;
                lossTypeBtn.userInteractionEnabled = NO;
                
            }
            else {
                
                delrowbtn.userInteractionEnabled   = YES;
                lossTypeBtn.userInteractionEnabled = YES;
            }
            
            viewListOfItemsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage * availiableSuppliersListImage;
            
            if(self.isOpen && self.selectIndex.section == indexPath.section){
                availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
            }
            else{
                availiableSuppliersListImage = [UIImage imageNamed:@"brown_right_arrow.png"];
            }
            
            [viewListOfItemsBtn setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
            viewListOfItemsBtn.userInteractionEnabled = YES;
            viewListOfItemsBtn.tag = indexPath.section;
            viewListOfItemsBtn.hidden = YES;
            //[viewListOfItemsBtn addTarget:self action:@selector(showListOfItems:) forControlEvents:UIControlEventTouchUpInside];

            
            item_NoLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemSkuidButton.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            item_DescLbl .layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            uom_Label .layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            openStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            saleQty_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            bookStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            actualStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            dump_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            stockLoss_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            declaredStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            closeStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            lossTypeTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            item_NoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemSkuidButton.titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
            item_DescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            uom_Label.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            openStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            saleQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            bookStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            actualStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            dump_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            stockLoss_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            declaredStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            closeStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            lossTypeTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            

            
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                //changed by Srinivasulu on 14/04/2017.....
                
                item_NoLbl.frame = CGRectMake(snoLbl.frame.origin.x,0,snoLbl.frame.size.width,hlcell.frame.size.height);
                
                itemSkuidButton.frame = CGRectMake(skuidLbl.frame.origin.x,0,skuidLbl.frame.size.width,  hlcell.frame.size.height);
                
                item_DescLbl.frame = CGRectMake(skuDescLbl.frame.origin.x, 0, skuDescLbl.frame.size.width,  hlcell.frame.size.height);
                
                uom_Label.frame = CGRectMake(uomLbl.frame.origin.x, 0, uomLbl.frame.size.width,  hlcell.frame.size.height);
                
                openStock_Lbl.frame = CGRectMake(openStockLbl.frame.origin.x, 0, openStockLbl.frame.size.width,  hlcell.frame.size.height);
                
                saleQty_Lbl.frame = CGRectMake(saleQtyLbl.frame.origin.x, 0,saleQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                bookStock_Lbl.frame = CGRectMake(bookStockLbl.frame.origin.x, 0, bookStockLbl.frame.size.width,  hlcell.frame.size.height);
                
                actualStock_Lbl.frame = CGRectMake(actualStockLbl.frame.origin.x, 0,actualStockLbl.frame.size.width,hlcell.frame.size.height);
                
                dump_Lbl.frame = CGRectMake(dumpLbl.frame.origin.x, 0,dumpLbl.frame.size.width,hlcell.frame.size.height);
                
                stockLoss_Lbl.frame = CGRectMake(stockLossLbl.frame.origin.x, 0,stockLossLbl.frame.size.width,hlcell.frame.size.height);
                
                declaredStock_Lbl.frame = CGRectMake(declaredStockLbl.frame.origin.x, 0,declaredStockLbl.frame.size.width,hlcell.frame.size.height);
                
                closeStock_Lbl.frame = CGRectMake(closeStockLbl.frame.origin.x,0,closeStockLbl.frame.size.width,hlcell.frame.size.height);
                
                lossTypeTxt.frame = CGRectMake(lossTypeLbl.frame.origin.x,0,lossTypeLbl.frame.size.width,36);
                
                lossTypeBtn.frame = CGRectMake((lossTypeTxt.frame.origin.x+lossTypeTxt.frame.size.width-40), lossTypeTxt.frame.origin.y-5,45,50);
                
                delrowbtn.frame= CGRectMake(lossTypeTxt.frame.origin.x+lossTypeTxt.frame.size.width+10,0,35,35);
                
                //newly added  field for displaying the items in grid...
                viewListOfItemsBtn.frame = CGRectMake(delrowbtn.frame.origin.x + delrowbtn.frame.size.width-3,delrowbtn.frame.origin.y+5,30,30);
                
            }
            
            [hlcell.contentView addSubview:item_NoLbl];
            [hlcell.contentView addSubview:itemSkuidButton];
            [hlcell.contentView addSubview:item_DescLbl];
            [hlcell.contentView addSubview:uom_Label];
            [hlcell.contentView addSubview:openStock_Lbl];
            [hlcell.contentView addSubview:saleQty_Lbl];
            [hlcell.contentView addSubview:bookStock_Lbl];
            [hlcell.contentView addSubview:actualStock_Lbl];
            [hlcell.contentView addSubview:dump_Lbl];
            [hlcell.contentView addSubview:stockLoss_Lbl];
            [hlcell.contentView addSubview:declaredStock_Lbl];
            [hlcell.contentView addSubview:closeStock_Lbl];
            [hlcell.contentView addSubview:lossTypeTxt];
            [hlcell.contentView addSubview:lossTypeBtn];
            [hlcell.contentView addSubview:delrowbtn];
            [hlcell.contentView addSubview:viewListOfItemsBtn];
            
            @try {

                if (rawMaterialDetails.count >= indexPath.section && rawMaterialDetails.count) {
                    
                    NSDictionary * temp = rawMaterialDetails[indexPath.section];
                    
                    item_NoLbl.text = [NSString stringWithFormat:@"%li", (indexPath.section + 1) ];
                    
                    [itemSkuidButton setTitle:[self checkGivenValueIsNullOrNil:[temp valueForKey:SKU_ID] defaultReturn:@"--"] forState:UIControlStateNormal];

                    item_DescLbl.text =  [self checkGivenValueIsNullOrNil:[temp valueForKey:kskuDescription] defaultReturn:@"--"];
                    
                    uom_Label.text =  [self checkGivenValueIsNullOrNil:[temp valueForKey:SELL_UOM] defaultReturn:@"--"];
                    
                    float openStock     = 0.0;
                    float saleQty       = 0.0;
                    float bookStock     = 0.0;
                    float actualStock   = 0.0;
                    float declaredStock = 0.0;
                    float dumpStock     = 0.0;
                    
                    for(NSDictionary * dic in [temp valueForKey:SKU_PRICE_LIST]) {
                        
                        openStock     += [[self checkGivenValueIsNullOrNil:[dic valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue];
                        saleQty       += [[self checkGivenValueIsNullOrNil:[dic valueForKey:SALE_QTY] defaultReturn:@"0.00"] floatValue];
                        bookStock     += [[self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_BOOK_STOCK] defaultReturn:@"0.00"] floatValue];
                        actualStock   += [[self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue];
                        declaredStock += [[self checkGivenValueIsNullOrNil:[dic valueForKey:DECLARED_QTY] defaultReturn:@"0.00"] floatValue];
                        dumpStock     += [[self checkGivenValueIsNullOrNil:[dic valueForKey:DUMP_QTY] defaultReturn:@"0.00"] floatValue];
                    }
                    
                    openStock_Lbl.text   = [NSString stringWithFormat:@"%.2f", openStock];
                    
                    saleQty_Lbl.text     = [NSString stringWithFormat:@"%.2f", saleQty];
                    //Book Stock is equal to Actualstock....
                    bookStock_Lbl.text   = [NSString stringWithFormat:@"%.2f",bookStock];
                    actualStock_Lbl.text = [NSString stringWithFormat:@"%.2f",actualStock];
                    declaredStock_Lbl.text= [NSString stringWithFormat:@"%.2f",declaredStock];
                    dump_Lbl.text        = [NSString stringWithFormat:@"%.2f",dumpStock];
                    
                    stockLoss_Lbl.text = [NSString stringWithFormat:@"%.2f",bookStock - actualStock];
                    
                    closeStock_Lbl.text = [NSString stringWithFormat:@"%.2f",(actualStock_Lbl.text).floatValue - (dump_Lbl.text).floatValue];
                    
                    lossTypeTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:LOSS_TYPE] defaultReturn:@""];

                    // added by roja on 03/04/2019....
                    declaredStock_Lbl.text = [NSString stringWithFormat:@"%.2f",(actualStock_Lbl.text).floatValue - (dump_Lbl.text).floatValue];
                }
                else {
                    
                    item_NoLbl.text        = @"--";
                    [itemSkuidButton setTitle:@"--" forState:UIControlStateNormal];
                    item_DescLbl.text      = @"--";
                    uom_Label.text         = @"--";
                    openStock_Lbl.text     = @"--";
                    saleQty_Lbl.text       = @"--";
                    bookStock_Lbl.text     = @"--";
                    actualStock_Lbl.text   = @"--";
                    dump_Lbl.text          = @"--";
                    stockLoss_Lbl.text     = @"--";
                    declaredStock_Lbl.text = @"--";
                    closeStock_Lbl.text    = @"--";

                }
            }
            @catch (NSException * exception) {
                
            }
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
    }
    
    else if (tableView == itemsListTbl) {
        
        static NSString * hlCellID = @"ItemsCellID";
        
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
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        UILabel * item_No_Lbl;
        UILabel * itemSkuDesc_Lbl;
        UILabel * itemGrade_Lbl;
        UILabel * itemOpenStock_Lbl;
        UILabel * itemSaleQty_Lbl;
        UILabel * itemStockLoss_Lbl;
        UILabel * itemCloseStk_Lbl;
        
        item_No_Lbl = [[UILabel alloc] init];
        item_No_Lbl.backgroundColor = [UIColor clearColor];
        item_No_Lbl.textAlignment = NSTextAlignmentCenter;
        item_No_Lbl.numberOfLines = 1;
        item_No_Lbl.layer.borderWidth = 1.5;
        item_No_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        item_No_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemSkuDesc_Lbl = [[UILabel alloc] init];
        itemSkuDesc_Lbl.backgroundColor = [UIColor clearColor];
        itemSkuDesc_Lbl.textAlignment = NSTextAlignmentCenter;
        itemSkuDesc_Lbl.numberOfLines = 1;
        itemSkuDesc_Lbl.layer.borderWidth = 1.5;
        itemSkuDesc_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        itemSkuDesc_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemGrade_Lbl = [[UILabel alloc] init];
        itemGrade_Lbl.backgroundColor = [UIColor clearColor];
        itemGrade_Lbl.textAlignment = NSTextAlignmentCenter;
        itemGrade_Lbl.numberOfLines = 1;
        itemGrade_Lbl.layer.borderWidth = 1.5;
        itemGrade_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        itemGrade_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemOpenStock_Lbl = [[UILabel alloc] init];
        itemOpenStock_Lbl.backgroundColor = [UIColor clearColor];
        itemOpenStock_Lbl.textAlignment = NSTextAlignmentCenter;
        itemOpenStock_Lbl.numberOfLines = 1;
        itemOpenStock_Lbl.layer.borderWidth = 1.5;
        itemOpenStock_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        itemOpenStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemSaleQty_Lbl = [[UILabel alloc] init];
        itemSaleQty_Lbl.backgroundColor = [UIColor clearColor];
        itemSaleQty_Lbl.textAlignment = NSTextAlignmentCenter;
        itemSaleQty_Lbl.numberOfLines = 1;
        itemSaleQty_Lbl.layer.borderWidth = 1.5;
        itemSaleQty_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        itemSaleQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        itemLevelActualStockTxt = [[UITextField alloc] init];
        itemLevelActualStockTxt.borderStyle = UITextBorderStyleRoundedRect;
        itemLevelActualStockTxt.keyboardType = UIKeyboardTypeNumberPad;
        itemLevelActualStockTxt.layer.borderWidth = 1.5;
        itemLevelActualStockTxt.backgroundColor = [UIColor clearColor];
        itemLevelActualStockTxt.autocorrectionType = UITextAutocorrectionTypeNo;
        itemLevelActualStockTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        itemLevelActualStockTxt.returnKeyType = UIReturnKeyDone;
        itemLevelActualStockTxt.delegate = self;
        itemLevelActualStockTxt.textAlignment = NSTextAlignmentCenter;
        itemLevelActualStockTxt.tag = indexPath.row;
        itemLevelActualStockTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemLevelActualStockTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        [itemLevelActualStockTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        gradeStockTxt = [[UITextField alloc] init];
        gradeStockTxt.borderStyle = UITextBorderStyleRoundedRect;
        gradeStockTxt.keyboardType = UIKeyboardTypeNumberPad;
        gradeStockTxt.layer.borderWidth = 1.5;
        gradeStockTxt.backgroundColor = [UIColor clearColor];
        gradeStockTxt.autocorrectionType = UITextAutocorrectionTypeNo;
        gradeStockTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        gradeStockTxt.returnKeyType = UIReturnKeyDone;
        gradeStockTxt.delegate = self;
        gradeStockTxt.textAlignment = NSTextAlignmentCenter;
        gradeStockTxt.tag = indexPath.row;
        gradeStockTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        gradeStockTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        [gradeStockTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        dumpQtyTxt = [[UITextField alloc] init];
        dumpQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
        dumpQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
        dumpQtyTxt.layer.borderWidth = 1.5;
        dumpQtyTxt.backgroundColor = [UIColor clearColor];
        dumpQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
        dumpQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        dumpQtyTxt.returnKeyType = UIReturnKeyDone;
        dumpQtyTxt.delegate = self;
        dumpQtyTxt.textAlignment = NSTextAlignmentCenter;
        dumpQtyTxt.tag = indexPath.row;
        dumpQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        dumpQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        [dumpQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        
        itemStockLoss_Lbl = [[UILabel alloc] init];
        itemStockLoss_Lbl.backgroundColor = [UIColor clearColor];
        itemStockLoss_Lbl.textAlignment = NSTextAlignmentCenter;
        itemStockLoss_Lbl.numberOfLines = 1;
        itemStockLoss_Lbl.layer.borderWidth = 1.5;
        itemStockLoss_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        itemStockLoss_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemCloseStk_Lbl = [[UILabel alloc] init];
        itemCloseStk_Lbl.backgroundColor = [UIColor clearColor];
        itemCloseStk_Lbl.textAlignment = NSTextAlignmentCenter;
        itemCloseStk_Lbl.numberOfLines = 1;
        itemCloseStk_Lbl.layer.borderWidth = 1.5;
        itemCloseStk_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        itemCloseStk_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        scanCodeText = [[UITextField alloc] init];
        scanCodeText.borderStyle = UITextBorderStyleRoundedRect;
        scanCodeText.keyboardType = UIKeyboardTypeNumberPad;
        scanCodeText.layer.borderWidth = 1.5;
        scanCodeText.backgroundColor = [UIColor clearColor];
        scanCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
        scanCodeText.clearButtonMode = UITextFieldViewModeWhileEditing;
        scanCodeText.returnKeyType = UIReturnKeyDone;
        scanCodeText.delegate = self;
        scanCodeText.textAlignment = NSTextAlignmentCenter;
        scanCodeText.tag = indexPath.row;
        scanCodeText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        scanCodeText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        [scanCodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        scanCodeText.placeholder = NSLocalizedString(@"item_code",nil);
        scanCodeText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:scanCodeText.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];

        gradeStockTxt.userInteractionEnabled = NO;

        if([submitBtn.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ){
            
            itemLevelActualStockTxt.userInteractionEnabled   = NO;
//            gradeStockTxt.userInteractionEnabled = NO;
            dumpQtyTxt.userInteractionEnabled = NO;

        }
        else {
            
            itemLevelActualStockTxt.userInteractionEnabled   = YES;
//            gradeStockTxt.userInteractionEnabled = YES;
            dumpQtyTxt.userInteractionEnabled = YES;
        }

        
        [hlcell.contentView addSubview:item_No_Lbl];
        [hlcell.contentView addSubview:itemSkuDesc_Lbl];
        [hlcell.contentView addSubview:itemGrade_Lbl];
        [hlcell.contentView addSubview:itemOpenStock_Lbl];
        [hlcell.contentView addSubview:itemSaleQty_Lbl];
        [hlcell.contentView addSubview:itemLevelActualStockTxt];
        [hlcell.contentView addSubview:gradeStockTxt];
        [hlcell.contentView addSubview:dumpQtyTxt];
        [hlcell.contentView addSubview:itemStockLoss_Lbl];
        [hlcell.contentView addSubview:itemCloseStk_Lbl];
        [hlcell.contentView addSubview:scanCodeText];
        
        item_No_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemSkuDesc_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemGrade_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemOpenStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemSaleQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemLevelActualStockTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        gradeStockTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        dumpQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemStockLoss_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemCloseStk_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        scanCodeText.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            item_No_Lbl.frame = CGRectMake(itemNoLbl.frame.origin.x,0,itemNoLbl.frame.size.width+2, hlcell.frame.size.height);
            
            itemSkuDesc_Lbl.frame = CGRectMake(itemDescLbl.frame.origin.x,0,itemDescLbl.frame.size.width+2, hlcell.frame.size.height);
            
            itemGrade_Lbl.frame = CGRectMake(itemGradeLbl.frame.origin.x,0,itemGradeLbl.frame.size.width+2, hlcell.frame.size.height);
            
            itemOpenStock_Lbl.frame = CGRectMake(itemOpenStockLbl.frame.origin.x,0,itemOpenStockLbl.frame.size.width+2, hlcell.frame.size.height);
            
            itemSaleQty_Lbl.frame = CGRectMake(itemSaleQtyLbl.frame.origin.x,0,itemSaleQtyLbl.frame.size.width+2, hlcell.frame.size.height);
            
            itemLevelActualStockTxt.frame = CGRectMake(itemActualStockLbl.frame.origin.x,0,itemActualStockLbl.frame.size.width+2, hlcell.frame.size.height);
            
            dumpQtyTxt.frame = CGRectMake(itemDumpQtyLbl.frame.origin.x,0,itemDumpQtyLbl.frame.size.width+2, hlcell.frame.size.height);
            
            gradeStockTxt.frame = CGRectMake(itemGradeStockLbl.frame.origin.x,0,itemGradeStockLbl.frame.size.width+2, hlcell.frame.size.height);
            
            itemStockLoss_Lbl.frame = CGRectMake(itemStockLossLbl.frame.origin.x,0,itemStockLossLbl.frame.size.width+2, hlcell.frame.size.height);
            
            itemCloseStk_Lbl.frame = CGRectMake(itemCloseStockLbl.frame.origin.x,0,itemCloseStockLbl.frame.size.width, hlcell.frame.size.height);
            
            scanCodeText.frame = CGRectMake(itemScanCodeLabel.frame.origin.x - 2,0,itemScanCodeLabel.frame.size.width, hlcell.frame.size.height);

            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:14.0f cornerRadius:0.0];
            
        }
        
        else{
            
            //Code For the iPhone
        }
        
        @try {
            
            NSDictionary * locDic = itemsListArr[indexPath.row];
            
            item_No_Lbl.text = [NSString stringWithFormat:@"%li",(indexPath.row + 1)];
            
            itemSkuDesc_Lbl.text = [self checkGivenValueIsNullOrNil:[locDic valueForKey:kskuDescription] defaultReturn:@"--"];
            
            itemGrade_Lbl.text = [self checkGivenValueIsNullOrNil:[locDic valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
            
            itemOpenStock_Lbl.text =[NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:OPEN_STOCK] defaultReturn:@"0.0"] floatValue]];
            
            itemSaleQty_Lbl.text =[NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:SALE_QTY] defaultReturn:@"0.0"] floatValue]];
            
            itemLevelActualStockTxt.text =[NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@"0.0"] floatValue]];
            
            gradeStockTxt.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:DECLARED_QTY] defaultReturn:@"0.0"] floatValue]];
            
            dumpQtyTxt.text =[NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:DUMP_QTY] defaultReturn:@"0.0"] floatValue]];
            
            itemStockLoss_Lbl.text = [NSString stringWithFormat:@"%.2f", ([[locDic valueForKey:SKU_BOOK_STOCK] floatValue] - [[locDic valueForKey:SKU_PHYSICAL_STOCK] floatValue])];
            
            scanCodeText.text  = [self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_SCAN_CODE] defaultReturn:@"--"];

            
            float closeStock;
            
            closeStock = ([[locDic valueForKey:SKU_PHYSICAL_STOCK] floatValue] - [[locDic valueForKey:DUMP_QTY] floatValue]);
            
            itemCloseStk_Lbl.text = [NSString stringWithFormat:@"%.2f",closeStock];
            
            // added by roja on 03/04/2019..
            gradeStockTxt.text = [NSString stringWithFormat:@"%.2f",closeStock];

            
        } @catch (NSException * exception) {
            
        }
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        hlcell.backgroundColor = [UIColor clearColor];
        return  hlcell;
        
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
            
            //            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,15, 30, 30)];
            //            imageView.image = [UIImage imageNamed:@"checkbox_off_background"];
            //            imageView.backgroundColor = [UIColor clearColor];
            
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
    
    else if (tableView == losstypeTbl) {
        
        static NSString * CellIdentifier = @"Cell";
        
        UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
        
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:lossTypeArr[indexPath.row]  defaultReturn:@""];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
        
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
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
        } @catch (NSException *exception) {
            
        }
        
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];

    theCell.contentView.backgroundColor=[UIColor clearColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [catPopOver dismissPopoverAnimated:YES];

    if (tableView == productListTbl){
        
        //Changes Made Bhargav.v on 11/05/2018...
        //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
        //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
        
        NSDictionary * detailsDic = productList[indexPath.row];
        NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[@"skuID"]];
        
        if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
            
            inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
        }
        [self callRawMaterialDetails:inputServiceStr];
        
        searchItemTxt.text = @"";
    }
    
    else if(tableView == nextActivityTbl){
        
        
        @try {
            if(indexPath.row == 0)
                ActionReqTxt.text = @"";
            else
                ActionReqTxt.text = nextActivitiesArr[indexPath.row];
            
            [catPopOver dismissPopoverAnimated:YES];
            
            
        } @catch (NSException *exception) {
            
            NSLog(@"----exception changing the textField text in didSelectRowAtIndexPath:----%@",exception);
        }
    }
    
    
    else if (tableView == losstypeTbl) {
        
        @try {
            lossTypeTxt.text = lossTypeArr[indexPath.row];
            
            NSMutableDictionary * changeDic;
            
            if(rawMaterialDetails.count > losstypeTbl.tag){
                changeDic = rawMaterialDetails[losstypeTbl.tag];
                
                changeDic[LOSS_TYPE] = lossTypeTxt.text;
                
                rawMaterialDetails[losstypeTbl.tag] = changeDic;
            }
            
            [rawMaterialDetailsTbl reloadData];
        } @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == rawMaterialDetailsTbl) {
        
        //play Audio for button touch....
        AudioServicesPlaySystemSound(soundFileObject);
        
        @try {
            
            UIButton * showGridBtn = [[UIButton alloc]init];
            showGridBtn.tag = indexPath.section;
            [self showListOfItems:showGridBtn];
            
        } @catch (NSException *exception) {
            
        }
    }
}

/**
 * @description  here we are showing the list of requestedItems.......
 * @date         09/05/2017....
 * @method       showListOfItems;
 * @author       Bhargav.v...
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (void)showListOfItems:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);

    @try {
        
        itemsListTbl.tag = sender.tag;
        
        itemsListArr = [NSMutableArray new];
        
        for(NSDictionary * dic in [rawMaterialDetails[sender.tag] valueForKey:SKU_PRICE_LIST]) {
            
            [itemsListArr addObject:dic];
        }

        if(itemsListArr.count == 0){
            
            [self displayAlertMessage:NSLocalizedString(@"no_data_found", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        
        NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
        
        if(path.row == 0) {
            
            UITableViewCell * cell2 = [rawMaterialDetailsTbl cellForRowAtIndexPath:path];
            
            if ([path isEqual:self.selectIndex]) {
                self.isOpen = NO;
                
                
                for (UIButton * button in cell2.contentView.subviews) {
                    
                    if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                        
                        UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_right_arrow.png"];
                        
                        [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                    }
                }
                
                [self didSelectCellRowFirstDo:NO nextDo:NO];
                
                self.selectIndex = nil;
                
            }
            else
            {
                if (!self.selectIndex) {
                    self.selectIndex = path;
                    
                    for (UIButton * button in cell2.contentView.subviews) {
                        
                        if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                            
                            UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                            
                            [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                        }
                    }
                    
                    [self didSelectCellRowFirstDo:YES nextDo:NO];
                    
                }
                else {
                    
                    selectSectionIndex = path;
                    
                    cell2 = [rawMaterialDetailsTbl cellForRowAtIndexPath: self.selectIndex];
                    
                    for (UIButton * button in cell2.contentView.subviews) {
                        
                        if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                            
                            UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_right_arrow.png"];
                            
                            [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                        }
                    }
                    
                    [self didSelectCellRowFirstDo:NO nextDo:YES];
                }
            }
        }
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
    }
}



/**
 * @description  it is an delegate method. it will be called for everCell.
 * @date         09/05/2017
 * @method       didSelectCellRowFirstDo:
 * @author       Bhargav.v
 * @param        BOOL
 * @param        BOOL
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert {
    @try {
        
        self.isOpen = firstDoInsert;
        
        //subProductsCount = [productsArr count];
        
        [rawMaterialDetailsTbl beginUpdates];
        
        int section = (int) self.selectIndex.section;
        int contentCount;
        
        contentCount = 1;
        
        NSMutableArray * rowToInsert = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i < contentCount+1 ; i++) {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
            [rowToInsert addObject:indexPathToInsert];
        }
        
        if (firstDoInsert)
        {
            
            
            [rawMaterialDetailsTbl  insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [rawMaterialDetailsTbl deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [rawMaterialDetailsTbl endUpdates];
        
        if (nextDoInsert) {
            self.isOpen = YES;
            self.selectIndex = selectSectionIndex;
            //            requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:selectIndex.section] valueForKey:@"stockRequestItems"];
            
            UITableViewCell *cell2 = [rawMaterialDetailsTbl cellForRowAtIndexPath:selectIndex];
            
            for (UIButton *button in cell2.contentView.subviews) {
                
                if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                    
                    UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                    
                    [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                    
                }
                
            }
            [self didSelectCellRowFirstDo:YES nextDo:NO];
        }
        if (self.isOpen)
            
            [rawMaterialDetailsTbl scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        
        //[rawMaterialDetailsTbl reloadRowsAtIndexPaths:[NSArray arrayWithObjects:selectIndex, selectSectionIndex, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
    @catch (NSException * exception) {
        
        NSLog(@"----exception in inserting the row in table --%@",exception);
        
    }
    @finally {
    }
    
}



#pragma -mark action used in this page

/**
 * @description  here we are deleting an item.......
 * @date         20/0/2016
 * @method       delRow:
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

- (void)delRow:(UIButton *)sender {
    
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
                
                self.isOpen = false;
                self.selectIndex = nil;
                
                [rawMaterialDetailsTbl reloadData];
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

-(void)calculateTotal {
    
    @try {
        float  bookStock     = 0.0;
        float  actualStock   = 0.0;
        float  declaredStock = 0.0;
        float  dumpStock     = 0.0;
        float  stockLoss     = 0.0;
        float  closeStock    = 0.0;
        
        for(NSDictionary     * skuDic in rawMaterialDetails)
            for(NSDictionary * dic in [skuDic valueForKey:SKU_PRICE_LIST]) {
                
                bookStock     +=    [[dic valueForKey:SKU_BOOK_STOCK] floatValue];
                actualStock   +=     [[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue];
                declaredStock +=     [[dic valueForKey:DECLARED_QTY] floatValue];
                dumpStock     +=     [[dic valueForKey:DUMP_QTY] floatValue];
                stockLoss     +=     ([[dic valueForKey:SKU_BOOK_STOCK] floatValue] - [[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue]);
                closeStock    +=     ([[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue] - [[dic valueForKey:DUMP_QTY] floatValue]);
                
            }
        totalBookStockVlueLbl.text   = [NSString stringWithFormat:@"%.2f",bookStock];
        totalActualStockVlueLbl.text = [NSString stringWithFormat:@"%.2f",actualStock];
        dumpValueLbl.text            = [NSString stringWithFormat:@"%.2f",dumpStock];
        stockLossValueLbl.text       = [NSString stringWithFormat:@"%.2f",stockLoss];
        closeStockValueLbl.text      = [NSString stringWithFormat:@"%.2f",closeStock];
        //changed by roja on 03/04/2015...
        declaredStockValueLbl.text   = [NSString stringWithFormat:@"%.2f",closeStock];
//        declaredStockValueLbl.text   = [NSString stringWithFormat:@"%.2f",declaredStock];

    } @catch (NSException *exception) {
        NSLog(@"------exception in while calculating the totalValue-----%@",exception);
        
    } @finally {
        
    }
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



#pragma -mark reusableMethods.......
/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         30/05/2017
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
        
        NSLog(@"-------- exception in the customerWalOut in removeAlertMessages---------%@",exception);
        NSLog(@"---- exception in removing userAlertMessageLbl label------------%@",exception);
        
    }
    
}



/**
 * @description  Here we are handling cancel button action
 * @date         03/04/2019...
 * @method       cancelButtonPressed
 * @author       Roja
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
-(void)cancelButtonPressed:(UIButton *)sender{
    
    @try {
        if( ([submitBtn.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ||  [submitBtn.titleLabel.text caseInsensitiveCompare:@"Submit"] == NSOrderedSame || [submitBtn.titleLabel.text caseInsensitiveCompare:@"UPDATE"] == NSOrderedSame) && [rawMaterialDetails count] == totalRecords){

              [self backAction];
        }
        else{
            cancelButton.tag = 4;

            cancellationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Do you want to submit this Verification", nil)  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
//            cancellationAlert.tag = submitBtn.tag; // or cancelButton.tag
            [cancellationAlert show];
        }
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

-(void)changeSwitchAction:(id)sender {
    
    if (isSearch.on) {
        
        searchBarcodeBtn.hidden = YES;
    }
    else {
        
        searchBarcodeBtn.hidden = NO;
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
//-(void)searchBarcode:(UIButton *)sender {
//
//    //Play Audio For Button Touch.....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    //Resiging the FirstResonder....
//    [searchItemTxt resignFirstResponder];
//
//    @try {
//
//        if ((searchItemTxt.text).length>0 && (searchItemTxt.tag == 0)) {
//
//            if (!isOfflineService) {
//
//                searchString = [searchItemTxt.text copy];
//                searchItemTxt.tag = (searchItemTxt.text).length;
//
//                //ALLOCATION OF PRODUCT LIST FOR MANUAL SEARCH....
//                productList = [[NSMutableArray alloc]init];
//
//                [self callRawMaterials:searchItemTxt.text];
//
//            }
//            else {
//
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"You need to first login with the internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//        }
//        else {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter your search string" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }
//    @catch (NSException * exception) {
//        [HUD setHidden:YES];
//
//        NSLog(@"%@",exception);
//    }
//    @finally{
//
//        [HUD setHidden:YES];
//    }
//}

/**
 * @description
 * @date
 * @method       searchBarcode
 * @author       ROja
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)searchBarcode{
    
    //Play Audio For Button Touch.....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Resiging the FirstResonder....
    [searchItemTxt resignFirstResponder];
    
    @try {
        
        if ((searchItemTxt.text).length>0 ) {
            
            if (!isOfflineService) {
                
                searchString = [searchItemTxt.text copy];
                //ALLOCATION OF PRODUCT LIST FOR MANUAL SEARCH....
                productList = [[NSMutableArray alloc]init];
                
                [self callRawMaterials:searchItemTxt.text];
            }
            else {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"You need to first login with the internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter your search string" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    else
    {
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
            searchItemTxt.text = selected_SKID;
            
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


//- (void)storeStockVerificationServiceSuccessResponse:(NSDictionary *)successDictionary{
//
//    @try {
//        if (successDictionary.count >0) {
//
//            verificationStr  = [[[successDictionary valueForKey:STOCK_VERIFICATION_OBJ]valueForKey:VERIFICATION_CODE]copy];
//
//            masterVerificationStr = [[[successDictionary valueForKey:STOCK_VERIFICATION_OBJ]valueForKey:MASTER_VERIFICATION_CODE]copy];
//        }
//
//
//        // added by roja on 03/04/2019...
//
//        totalRecords = (int)[[[successDictionary valueForKey:STOCK_VERIFICATION_OBJ]valueForKey:@"itemsList"] count];
//
//        // making a copy of successDictionary for the external use...
//        updateStockDic = [[successDictionary valueForKey:STOCK_VERIFICATION_OBJ]mutableCopy];
//
//        if(([updateStockDic.allKeys containsObject:VERIFIED_ON_STR]) &&  (![[updateStockDic valueForKey:VERIFIED_ON_STR] isKindOfClass: [NSNull class]]) && ([[updateStockDic valueForKey:VERIFIED_ON_STR] componentsSeparatedByString:@" "].count))
//
//            startDteTxt.text =  [[updateStockDic valueForKey:VERIFIED_ON_STR] componentsSeparatedByString:@" "][0];
//
//        if(([updateStockDic.allKeys containsObject:UPDATED_ON_STR]) &&  (![[updateStockDic valueForKey:UPDATED_ON_STR] isKindOfClass: [NSNull class]]) && ([[updateStockDic valueForKey:UPDATED_ON_STR] componentsSeparatedByString:@" "].count))
//
//            endDteTxt.text =  [[updateStockDic valueForKey:UPDATED_ON_STR] componentsSeparatedByString:@" "][0];
//
//        if (![[updateStockDic valueForKey:START_TIME_STR ] isKindOfClass:[NSNull class]]&& [[updateStockDic valueForKey:START_TIME_STR ] length] > 0)
//
//            startTimeTxt .text = [NSString stringWithFormat:@"%@",[updateStockDic valueForKey:START_TIME_STR ]];
//
//        if (![[updateStockDic valueForKey:END_TIME_STR ] isKindOfClass:[NSNull class]]&& [[updateStockDic valueForKey:END_TIME_STR ] length] > 0)
//
//            endTimeTxt .text = [NSString stringWithFormat:@"%@",[updateStockDic valueForKey:END_TIME_STR ]];
//
//        // for loop to execute the cart table acoording to the data ....
//
//        float bookStock          = 0.0;
//        float sku_Physical_Stock = 0.0;
//        float declaredQty        = 0.0;
//        float dumpQty            = 0.0;
//        float stockLossQty       = 0.0;
//        float closeStockQty      = 0.0;
//
//        for (NSDictionary * dic in [updateStockDic valueForKey:VERF_DETAILS_LIST]) {
//
//            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:sku_ID] defaultReturn:@""] forKey:SKU_ID];
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:sku_DESC] defaultReturn:@""] forKey:kskuDescription];
//
//            // newly added fields...by Bhargav.v on 7/06/2017
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:kSkuCostPrice] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:DUMP_QTY] defaultReturn:@"0.00"] floatValue]] forKey:DUMP_QTY];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:BOOK_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:SKU_BOOK_STOCK];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:ACTUAL_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:SKU_PHYSICAL_STOCK];
//
//            // added By Bhargav
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:OPEN_STOCK];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:DECLARED_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:DECLARED_QTY];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f" ,([[dic valueForKey:ACTUAL_STOCK] floatValue] - [[dic valueForKey:DUMP_QTY] floatValue])] forKey:CLOSED_STOCK];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:kStock_loss] defaultReturn:@"0.00"] floatValue]] forKey:kStock_loss];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.00"] floatValue]] forKey:STOCKLOSS_QTY];
//
//            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:CLOSED_STOCK];
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:@"lossType"] defaultReturn:@""] forKey:LOSS_TYPE];
//
//            //upto Here
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
//
//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
//
//            bookStock += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:BOOK_STOCK] defaultReturn:@"0.00"] floatValue];
//
//            sku_Physical_Stock += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:ACTUAL_STOCK] defaultReturn:@"0.00"] floatValue];
//
//            declaredQty += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:DECLARED_STOCK] defaultReturn:@"0.00"] floatValue];
//
//            dumpQty += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:DUMP_QTY] defaultReturn:@"0.00"] floatValue];
//
//            closeStockQty += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue];
//
//            stockLossQty += [[self checkGivenValueIsNullOrNil:[dic  valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.00"] floatValue];
//
//            //Parent List...
//
//            NSMutableArray * priceListArr = [[NSMutableArray alloc]init];
//
//            if ([[dic valueForKey:VERF_ITEM_DETAILS] count]) {
//
//                for (NSDictionary * priceListDic in [dic valueForKey:VERF_ITEM_DETAILS]) {
//
//                    NSMutableDictionary * GradeDic = [NSMutableDictionary new];
//
//                    // Setting SkuId as Sku_id
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_ID] defaultReturn:@""] forKey:SKU_ID];
//
//                    //Setting Description as SkuDescription
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kskuDescription] defaultReturn:@""] forKey:kskuDescription];
//
//                    // Setting pluCode as pluCode
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
//
//                    // Setting productRange as productRange
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
//
//                    // Setting openStock as openStock
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:OPEN_STOCK];
//
//                    // Setting saleQty as saleQty..
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SALE_QTY] defaultReturn:@"0.00"] floatValue]] forKey:SALE_QTY];
//
//                    // Setting sku_book_stock as sku_book_stock
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_BOOK_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:SKU_BOOK_STOCK];
//
//                    // Setting sku_physical_stock as sku_physical_stock
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:SKU_PHYSICAL_STOCK];
//
//                    //Setting quantityInHand as product_physical_stock
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_PHYSICAL_STOCK];
//
//                    //Setting quantityInHand as product_book_stock
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_BOOK_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_BOOK_STOCK];
//
//                    // Setting dumpQty as dumpQty
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:DUMP_QTY] defaultReturn:@"0.00"] floatValue]] forKey:DUMP_QTY];
//
//                    // Setting stockLossQty as stockLossQty
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.00"] floatValue]] forKey:STOCKLOSS_QTY];
//
//                    // Setting declaredQty as declaredQty
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:DECLARED_QTY] defaultReturn:@"0.00"] floatValue]] forKey:DECLARED_QTY];
//
//                    // Setting closedStock as closedStock
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue]] forKey:CLOSED_STOCK];
//
//                    // Setting skuCostPrice as skuCostPrice
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kSkuCostPrice] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
//
//                    // Setting measureRange as measureRange
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
//
//                    //Setting subCategory as subCategory
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
//
//                    // Setting uom as uom
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
//
//                    // Setting ean as ean..
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
//
//                    // Setting color as color..
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:PRODUCT_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:VERIFICATION_PRODUCT_ID] defaultReturn:@""]
//                                forKey:VERIFICATION_PRODUCT_ID];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:REMARKS] defaultReturn:@""] forKey:REMARKS];
//
//                    [GradeDic setValue:[self checkGivenValueIsNullOrNil:[priceListDic valueForKey:STORAGE_UNIT] defaultReturn:@""] forKey:STORAGE_UNIT];
//
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_REORDERED_QTY] defaultReturn:@"0.00"] floatValue]] forKey:SKU_REORDERED_QTY];
//
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:SKU_ALLOCATED] defaultReturn:@"0.00"] floatValue]] forKey:SKU_ALLOCATED];
//
//                    [GradeDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[priceListDic  valueForKey:kSalePriceValue] defaultReturn:@"0.00"] floatValue]] forKey:kSalePriceValue];
//
//                    [priceListArr addObject:GradeDic];
//                }
//            }
//
//            else {
//
//                [priceListArr addObject:itemDetailsDic];
//            }
//
//            //After Else Condition
//            itemDetailsDic[SKU_PRICE_LIST] = priceListArr;
//
//            [rawMaterialDetails addObject:itemDetailsDic];
//
//        }
//
//        totalBookStockVlueLbl.text = [NSString stringWithFormat:@"%.2f",bookStock];
//        totalActualStockVlueLbl.text = [NSString stringWithFormat:@"%.2f",sku_Physical_Stock];
//        declaredStockValueLbl.text = [NSString stringWithFormat:@"%.2f",declaredQty];
//        dumpValueLbl.text = [NSString stringWithFormat:@"%.2f",dumpQty];
//        closeStockValueLbl.text = [NSString stringWithFormat:@"%.2f",closeStockQty];
//        stockLossValueLbl.text = [NSString stringWithFormat:@"%.2f",stockLossQty];
//
//        //allocating mutable array...
//
//        nextActivitiesArr = [NSMutableArray new];
//
//
//        if([[updateStockDic valueForKey:NEXT_ACTIVITIES] count] || [[updateStockDic  valueForKey:NEXT_WORK_FLOW_STATES] count]){
//
//            [nextActivitiesArr addObject:NSLocalizedString(@"--select--", nil)];
//            for(NSString *str in [updateStockDic   valueForKey:NEXT_ACTIVITIES])
//                [nextActivitiesArr addObject:str];
//
//            for(NSString *str in [updateStockDic  valueForKey:NEXT_WORK_FLOW_STATES]  )
//                [nextActivitiesArr addObject:str];
//
//            cancelButton.frame = CGRectMake(submitBtn.frame.origin.x + submitBtn.frame.size.width+5,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
//        }
//        if(nextActivitiesArr.count == 0){
//            [nextActivitiesArr addObject:@"No Activities"];
//
//            submitBtn.hidden = YES;
//            saveBtn.hidden = YES;
//            itemsListTbl.userInteractionEnabled = NO;
//
//            // frame for the UIbuttons...
//            cancelButton.frame = CGRectMake(searchItemTxt.frame.origin.x,stockVerificationView.frame.size.height - 50,110, 40);
//        }
//        // added by roja on 03/03/2019...
//        if ([[updateStockDic valueForKey:@"status"] caseInsensitiveCompare:@"Draft"] == NSOrderedSame) {
//
//            submitBtn.hidden = NO;
//            //                saveBtn.hidden = NO;
//            itemsListTbl.userInteractionEnabled = NO;
//            cancelButton.frame = CGRectMake(submitBtn.frame.origin.x + submitBtn.frame.size.width+5,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
//        }  //Upto here added by roja on 03/03/2019...
//        else{
//
//            UIImage * workArrowImg = [UIImage imageNamed:@"workflow_arrow.png"];
//
//            UIImageView * workFlowImageView = [[UIImageView alloc] init];
//
//            workFlowImageView.image = workArrowImg;
//
//            [workFlowView addSubview:workFlowImageView];
//
//            NSArray *workFlowArr;
//
//            workFlowArr = [updateStockDic valueForKey:PREVIOUS_STATES];
//
//            workFlowImageView.frame = CGRectMake(workFlowView.frame.origin.x, 5,  workFlowView.frame.size.height + 30 , workFlowView.frame.size.height - 10);
//
//            float label_x_origin = workFlowImageView.frame.origin.x + workFlowImageView.frame.size.width;
//            float label_y_origin = workFlowImageView.frame.origin.y;
//
//            float labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width)/ ((workFlowArr.count *3) - 1)   ;
//            float labelHeight = workFlowImageView.frame.size.height;
//
//            if( workFlowArr.count <= 3 )
//                //taking max as 5 labels.....
//                labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width - 380)/ 5;
//
//            for(NSString *str  in workFlowArr){
//
//                UILabel *workFlowNameLbl;
//                UILabel *workFlowLineLbl;
//
//                workFlowNameLbl = [[UILabel alloc] init];
//                workFlowNameLbl.layer.masksToBounds = YES;
//                workFlowNameLbl.numberOfLines = 2;
//                workFlowNameLbl.textAlignment = NSTextAlignmentCenter;
//                workFlowNameLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//                //workFlowNameLbl.text = @"Closed-----Cancelled";
//                workFlowNameLbl.text = str;
//
//                [workFlowView addSubview:workFlowNameLbl];
//
//                workFlowNameLbl.frame = CGRectMake(label_x_origin,label_y_origin,labelWidth,labelHeight);
//
//                label_x_origin = workFlowNameLbl.frame.origin.x + workFlowNameLbl.frame.size.width;
//
//                if(![str isEqualToString:workFlowArr.lastObject]){
//                    workFlowLineLbl = [[UILabel alloc] init] ;
//                    workFlowLineLbl.backgroundColor = [UIColor lightGrayColor];
//
//                    [workFlowView addSubview:workFlowLineLbl];
//
//                    workFlowLineLbl.frame = CGRectMake(label_x_origin,(labelHeight +8)/2,labelWidth, 2);
//                    label_x_origin = workFlowLineLbl.frame.origin.x + workFlowLineLbl.frame.size.width;
//                }
//            }
//        }
//        //NSLog(@"---------%@",str);
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//
//        [HUD setHidden:YES];
//        [rawMaterialDetailsTbl reloadData];
//    }
//}


//- (void)storeStockVerificationServiceFailureResponse:(NSString *)failureString{
//
//    @try {
//        [HUD setHidden:YES];
//
//        float y_axis = self.view.frame.size.height - 120;
//
//        NSString * mesg = [NSString stringWithFormat:@"%@",failureString];
//
//        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//
//    }
//}

@end
