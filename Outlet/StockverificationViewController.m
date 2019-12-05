//  StockvericationViewController.m
//  OmniRetailer
//  Created by Bhargav.v on 31/05/17.


#import "StockverificationViewController.h"
#import "OmniHomePage.h"
#import "OmniRetailerViewController.h"




@interface StockverificationViewController ()

@end

@implementation StockverificationViewController
@synthesize soundFileURLRef,soundFileObject;
@synthesize verificationCode,isOpen,selectIndex,buttonSelectIndex,selectSectionIndex;

#pragma  - mark start of ViewLifeCycle mehods....

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
 */

- (void)viewDidLoad {
    // calling super call method....
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    // here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef)tapSound;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    // setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    
    // ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time..
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
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
    
    
    // Allocation of stockVerificationView..
    stockVerificationView = [[UIView alloc] init];
    stockVerificationView.backgroundColor = [UIColor blackColor];
    stockVerificationView.layer.borderWidth = 1.0f;
    stockVerificationView.layer.cornerRadius = 10.0f;
    stockVerificationView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    /* Creation of UILabel for headerDisplay.......*/
    // creating line  UILabel which will display at topOfThe  billingView.......
    UILabel * headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    
    
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
    
    
    //it is regard's to the view borderwidth and color setting....
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.opacity = 5.0f;
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    [headerNameLbl.layer addSublayer:bottomBorder];
    
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
    zoneTxt.userInteractionEnabled = NO;
    [zoneTxt awakeFromNib];
    
    outletIDTxt = [[CustomTextField alloc] init];
    outletIDTxt.delegate = self;
    outletIDTxt.userInteractionEnabled = NO;
    outletIDTxt.placeholder = NSLocalizedString(@"all_Stores",nil);
    [outletIDTxt awakeFromNib];
    
    startDteTxt = [[CustomTextField alloc] init];
    startDteTxt.placeholder = NSLocalizedString(@"start_date",nil);
    startDteTxt.userInteractionEnabled = NO;
    startDteTxt.delegate = self;
    [startDteTxt awakeFromNib];
    
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDateTxt.userInteractionEnabled = NO;
    endDateTxt.delegate = self;
    [endDateTxt awakeFromNib];
    
    // getting present date & time ..
    //NSDate *time = [NSDate date];
    //NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //[format setDateFormat:@" HH:mm:ss"];
    //NSString * currentTime = [format stringFromDate:time];
    
    startTimeTxt = [[CustomTextField alloc] init];
    startTimeTxt.placeholder = NSLocalizedString(@"start_time", nil);
    startTimeTxt.userInteractionEnabled = NO;
    startTimeTxt.delegate = self;
    [startTimeTxt awakeFromNib];
    
    endTimeTxt = [[CustomTextField alloc] init];
    endTimeTxt.delegate = self;
    endTimeTxt.placeholder = NSLocalizedString(@"end_time", nil);
    endTimeTxt.userInteractionEnabled = NO;
    [endTimeTxt awakeFromNib];
    
    ActionReqTxt = [[CustomTextField alloc] init];
    ActionReqTxt.placeholder = NSLocalizedString(@"Action Required", nil);
    ActionReqTxt.delegate = self;
    ActionReqTxt.userInteractionEnabled = NO;
    [ActionReqTxt awakeFromNib];
    ActionReqTxt.hidden =YES;
    
    startDteTxt.text  = [self checkGivenValueIsNullOrNil:[verificationCode valueForKey:@"verfStartDateStr"] defaultReturn:@"--"];
    endDateTxt.text  = [self checkGivenValueIsNullOrNil:[verificationCode valueForKey:@"verfEndDateStr"] defaultReturn:@"--"];
    
    startTimeTxt.text  = [self checkGivenValueIsNullOrNil:[verificationCode valueForKey:@"startTimeStr"] defaultReturn:@"--"];
    endTimeTxt.text  = [self checkGivenValueIsNullOrNil:[verificationCode valueForKey:@"endTimeStr"] defaultReturn:@"--"];

    //   Creation of UIButtons...
    UIImage * startDteImg;
    UIButton * startDteBtn;
    UIButton * endDteBtn;
    UIButton * startTimeBtn;
    UIButton * endTimeBtn;
    UIButton * outletIdBtn;
    
    startDteImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    UIImage * actionReqImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    startDteBtn.userInteractionEnabled = YES;
    
    
    endDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [endDteBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    endDteBtn.userInteractionEnabled = YES;
    
    //used for identification propous....
    startDteBtn.tag = 2;
    endDteBtn.tag = 4;
    
    startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startTimeBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [startTimeBtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchDown];
    startTimeBtn.userInteractionEnabled = YES;
    
    endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endTimeBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [endTimeBtn addTarget:self
                   action:@selector(selectTime:) forControlEvents:UIControlEventTouchDown];
    endTimeBtn.userInteractionEnabled = YES;
    
    outletIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outletIdBtn setBackgroundImage:actionReqImg forState:UIControlStateNormal];
    [outletIdBtn addTarget:self  action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    
    //creation of searchItemTxt....
    
    searchItemTxt = [[CustomTextField alloc] init];
    searchItemTxt.delegate = self;
    [searchItemTxt awakeFromNib];
    //searchItemTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItemTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItemTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemTxt.textColor = [UIColor blackColor];
    searchItemTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    searchItemTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
    [searchItemTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImage * productListImg;
    
    productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
    selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    //creation of UIScrollView....
    
    stockVerificationScrollView = [[UIScrollView alloc]init];
    //stockVerificationScrollView.backgroundColor = [UIColor lightGrayColor];
    
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
    openStockLbl.numberOfLines =  2;
    
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
    
    // openGridLbl added by roja
    openGridLbl = [[CustomLabel alloc] init];
    [openGridLbl awakeFromNib];
    
    
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
    
    declaredStockValueLbl = [[UILabel alloc] init];
    declaredStockValueLbl.layer.cornerRadius = 5;
    declaredStockValueLbl.layer.masksToBounds = YES;
    declaredStockValueLbl.backgroundColor = [UIColor blackColor];
    declaredStockValueLbl.layer.borderWidth = 2.0f;
    declaredStockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    declaredStockValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    declaredStockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    closeStockValueLbl = [[UILabel alloc] init];
    closeStockValueLbl.layer.cornerRadius = 5;
    closeStockValueLbl.layer.masksToBounds = YES;
    closeStockValueLbl.backgroundColor = [UIColor blackColor];
    closeStockValueLbl.layer.borderWidth = 2.0f;
    closeStockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    closeStockValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    closeStockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalBookStockVlueLbl.text   = @"0.0";
    totalActualStockVlueLbl.text = @"0.0";
    dumpValueLbl.text            = @"0.0";
    stockLossValueLbl.text       = @"0.0";
    declaredStockValueLbl.text   = @"0.0";
    closeStockValueLbl.text      = @"0.0";
    
    totalBookStockVlueLbl.textAlignment   = NSTextAlignmentCenter;
    totalActualStockVlueLbl.textAlignment = NSTextAlignmentCenter;
    dumpValueLbl.textAlignment            = NSTextAlignmentCenter;
    stockLossValueLbl.textAlignment       = NSTextAlignmentCenter;
    declaredStockValueLbl.textAlignment   = NSTextAlignmentCenter;
    closeStockValueLbl.textAlignment      = NSTextAlignmentCenter;
    
    // Table for diaplaying products ..
    
    productListTbl = [[UITableView alloc] init];
    productListTbl.dataSource = self;
    productListTbl.delegate = self;
    productListTbl.backgroundColor = [UIColor blackColor];
    productListTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    productListTbl.hidden = YES;
    
    // Table for items List...
    rawMaterialDetailsTbl = [[UITableView alloc] init];
    rawMaterialDetailsTbl.backgroundColor = [UIColor blackColor];
    rawMaterialDetailsTbl.dataSource = self;
    rawMaterialDetailsTbl.delegate = self;
    rawMaterialDetailsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    rawMaterialDetailsTbl.userInteractionEnabled = TRUE;
    
    //table's used in popUp's...
    
    //locationTable Table allocation...
    
    locationTable = [[UITableView alloc] init];
    
    // Creation of UIButtons..
    
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
    saveBtn.tag = 2;
    
    cancelButton = [[UIButton alloc] init] ;
    cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.userInteractionEnabled = YES;
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    cancelButton.layer.cornerRadius = 5.0f;
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    requestedItemsTblHeaderView = [[UIView alloc] init];
    //requestedItemsTblHeaderView.backgroundColor = [UIColor whiteColor];
    
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

    // batchLbl added by roja
    batchLbl = [[CustomLabel alloc] init];
    [batchLbl awakeFromNib];
    
    itemsListTbl = [[UITableView alloc] init];
    itemsListTbl.dataSource = self;
    itemsListTbl.delegate = self;
    itemsListTbl.backgroundColor = [UIColor clearColor];
    itemsListTbl.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    itemsListTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    @try {
        
        headerNameLbl.text = NSLocalizedString(@"new_stock_verification", nil);
        
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        searchItemTxt.placeholder = NSLocalizedString(@"Search Items Here", nil);
        
        snoLbl.text = NSLocalizedString(@"S_NO",nil);
        skuidLbl.text = NSLocalizedString(@"sku_id",nil);
        skuDescLbl.text = NSLocalizedString(@"sku_desc",nil);
        uomLbl.text = NSLocalizedString(@"uom",nil);
        
        openStockLbl.text = NSLocalizedString(@"open_stock",nil);//
        saleQtyLbl.text = NSLocalizedString(@"sale_qty",nil);
        bookStockLbl.text = NSLocalizedString(@"Book Stck",nil); //book_stock
        actualStockLbl.text = NSLocalizedString(@"actual_stock",nil);//
        dumpLbl.text = NSLocalizedString(@"dump",nil);//
        stockLossLbl.text = NSLocalizedString(@"stock_loss",nil);//
        declaredStockLbl.text = NSLocalizedString(@"declared_stock",nil);
        closeStockLbl.text = NSLocalizedString(@"close_Stock",nil);
        lossTypeLbl.text = NSLocalizedString(@"loss_type",nil);
        actionLbl.text = NSLocalizedString(@"action",nil);
        openGridLbl.text = NSLocalizedString(@"open",nil);

        diffLbl.text = NSLocalizedString(@"diff",nil);
        
        
        //Grid Level CustomLabel Strings....
        itemNoLbl.text         = NSLocalizedString(@"S_NO",nil);
        itemDescLbl.text       = NSLocalizedString(@"Sku Desc",nil);
        itemGradeLbl.text      = NSLocalizedString(@"Grade",nil);
        itemOpenStockLbl.text  = NSLocalizedString(@"Open Stck",nil);
        itemSaleQtyLbl.text    = NSLocalizedString(@"Sale Qty",nil);
        itemActualStockLbl.text= NSLocalizedString(@"Act Stck",nil);
        itemGradeStockLbl.text = NSLocalizedString(@"Grade Stck",nil);
        itemDumpQtyLbl.text    = NSLocalizedString(@"Dump Qty",nil);
        itemStockLossLbl.text  = NSLocalizedString(@"Stck Loss",nil);
        itemCloseStockLbl.text = NSLocalizedString(@"Close Stk",nil);
        itemScanCodeLabel.text = NSLocalizedString(@"item_code",nil);
        batchLbl.text = NSLocalizedString(@"Batch No.",nil);
        
        [submitBtn setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
        [saveBtn setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
        [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
        
        if (isHubLevel) {
            
            zoneTxt.text = zoneID;
            outletIdBtn.hidden = NO;
        }
        else {
            zoneTxt.text = zone;
            outletIDTxt.text = presentLocation;
            outletIdBtn.hidden = YES;
        }
        //used for identification propous....
        startTimeBtn.tag = 2;
        endTimeBtn.tag = 4;
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    // creation of priceList Table....
    pricListTbl = [[UITableView alloc] init];
    pricListTbl.backgroundColor = [UIColor blackColor];
    pricListTbl.dataSource = self;
    pricListTbl.delegate = self;
    pricListTbl.layer.cornerRadius = 3;
    
    
    closeBtn = [[UIButton alloc] init] ;
    [closeBtn addTarget:self action:@selector(closePriceView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 11;
    
    UIImage *image = [UIImage imageNamed:@"delete.png"];
    [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
    
    priceView = [[UIView alloc]init];
    priceView.backgroundColor = [UIColor blackColor];
    priceView.layer.borderWidth = 2.0f;
    priceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    transparentView = [[UIView alloc] init];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    //   labels For Price List....
    
    descLbl = [[CustomLabel alloc] init];
    [descLbl awakeFromNib];
    
    mrpLbl = [[CustomLabel alloc] init];
    [mrpLbl awakeFromNib];
    
    priceLabel = [[CustomLabel alloc] init];
    [priceLabel awakeFromNib];
    
    // added by roja on 03/07/2019
    pluCodeLabel = [[CustomLabel alloc] init];
    [pluCodeLabel awakeFromNib];
    
    eanLabel = [[CustomLabel alloc] init];
    [eanLabel awakeFromNib];
    
    batchLabel = [[CustomLabel alloc] init];
    [batchLabel awakeFromNib];
    
    measureRangeLabel= [[CustomLabel alloc] init];
    [measureRangeLabel awakeFromNib];
    //upto here added by roja on 03/07/2019

    
    
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
        
        descLbl.text = NSLocalizedString(@"description",nil);
        mrpLbl.text =  NSLocalizedString(@"sale_price",nil); //mrp_rps // changed by roja
        priceLabel.text = NSLocalizedString(@"price",nil);
        
        // added by roja on 03/07/2019..
        pluCodeLabel.text =  NSLocalizedString(@"plu_code",nil);
        eanLabel.text =  NSLocalizedString(@"ean",nil);
        batchLabel.text =  NSLocalizedString(@"batch",nil);
        measureRangeLabel.text =  NSLocalizedString(@"measure_range",nil);
        // upto here added by roja on 03/07/2019.
        
    }
    @catch (NSException *exception) {
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
            
        }
        
        //frame for the main view..
        self.view.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        //frame for the stockVerificationView view..
        stockVerificationView.frame = CGRectMake(2,70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        //frame for the headerNameLbl..
        headerNameLbl.frame = CGRectMake(0,0,stockVerificationView.frame.size.width, 45);
        
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
        
        endDateTxt.frame = CGRectMake(startDteTxt.frame.origin.x,outletIDTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        
        startTimeTxt.frame = CGRectMake(startDteTxt.frame.origin.x+startDteTxt.frame.size.width+horizontal_Gap, startDteTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        //
        endTimeTxt.frame = CGRectMake(startTimeTxt.frame.origin.x, outletIDTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        ActionReqTxt.frame = CGRectMake(stockVerificationView.frame.size.width - 200,startTimeTxt.frame.origin.y+startTimeTxt.frame.size.height,textFieldWidth,textFieldHeight);
        
        
        // frames for the UIButton...
        startDteBtn.frame = CGRectMake((startDteTxt.frame.origin.x+startDteTxt.frame.size.width - 40), startDteTxt.frame.origin.y + 4, 35, 30);
        
        endDteBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-40),endDateTxt.frame.origin.y+4,35,30);
        
        startTimeBtn.frame = CGRectMake((startTimeTxt.frame.origin.x+startTimeTxt.frame.size.width-40), startTimeTxt.frame.origin.y+4,35,30);
        
        endTimeBtn.frame = CGRectMake((endTimeTxt.frame.origin.x+endTimeTxt.frame.size.width-40), endTimeTxt.frame.origin.y+4, 35,30);
        
        outletIdBtn.frame = CGRectMake((outletIDTxt.frame.origin.x+outletIDTxt.frame.size.width-45),outletIDTxt.frame.origin.y-8,55,60);
        
        userNameLbl.frame =CGRectMake(stockVerificationView.frame.size.width - 190, zoneTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        searchItemTxt.frame = CGRectMake(zoneTxt.frame.origin.x,outletIDTxt.frame.origin.y+outletIDTxt.frame.size.height + 30,userNameLbl.frame.origin.x+userNameLbl.frame.size.width -(zoneTxt.frame.origin.x + 80),40);
        
        selectCategoriesBtn.frame = CGRectMake((searchItemTxt.frame.origin.x+searchItemTxt.frame.size.width + 5),searchItemTxt.frame.origin.y,75,searchItemTxt.frame.size.height);
        
        // frames for the CustomLabels for header section....
        snoLbl.frame = CGRectMake(0, 0,40,35);
        
        skuidLbl.frame = CGRectMake(snoLbl.frame.origin.x + snoLbl.frame.size.width + 2,snoLbl.frame.origin.y,80,snoLbl.frame.size.height);
        
        skuDescLbl.frame = CGRectMake(skuidLbl.frame.origin.x+skuidLbl.frame.size.width + 2,skuidLbl.frame.origin.y,90,skuidLbl.frame.size.height);
        
        uomLbl.frame = CGRectMake(skuDescLbl.frame.origin.x+skuDescLbl.frame.size.width+2,skuidLbl.frame.origin.y,45,skuidLbl.frame.size.height);
        
        openStockLbl.frame = CGRectMake(uomLbl.frame.origin.x + uomLbl.frame.size.width + 2 , skuDescLbl.frame.origin.y ,80,skuDescLbl.frame.size.height);
        
        saleQtyLbl.frame = CGRectMake(openStockLbl.frame.origin.x+openStockLbl.frame.size.width + 2 ,openStockLbl.frame.origin.y ,65, openStockLbl.frame.size.height);
        
        bookStockLbl.frame = CGRectMake(saleQtyLbl.frame.origin.x + saleQtyLbl.frame.size.width + 2 , openStockLbl.frame.origin.y,80, openStockLbl.frame.size.height);
        
        actualStockLbl.frame = CGRectMake(bookStockLbl.frame.origin.x+bookStockLbl.frame.size.width + 2,bookStockLbl.frame.origin.y,75,bookStockLbl.frame.size.height);
        
        dumpLbl.frame = CGRectMake(actualStockLbl.frame.origin.x + actualStockLbl.frame.size.width + 2,bookStockLbl.frame.origin.y, 60, actualStockLbl.frame.size.height);
        
        stockLossLbl.frame = CGRectMake(dumpLbl.frame.origin.x + dumpLbl.frame.size.width + 2,bookStockLbl.frame.origin.y,75,actualStockLbl.frame.size.height);
        
        declaredStockLbl.frame = CGRectMake(stockLossLbl.frame.origin.x + stockLossLbl.frame.size.width + 2, actualStockLbl.frame.origin.y, 80, actualStockLbl.frame.size.height);
        
        closeStockLbl.frame = CGRectMake(declaredStockLbl.frame.origin.x+declaredStockLbl.frame.size.width + 2,declaredStockLbl.frame.origin.y, 80, actualStockLbl.frame.size.height);
        
        lossTypeLbl.frame = CGRectMake(closeStockLbl.frame.origin.x+closeStockLbl.frame.size.width + 2, actualStockLbl.frame.origin.y, 80, actualStockLbl.frame.size.height);
        
        openGridLbl.frame = CGRectMake(lossTypeLbl.frame.origin.x + lossTypeLbl.frame.size.width + 2, actualStockLbl.frame.origin.y, 80, actualStockLbl.frame.size.height);
        
        actionLbl.frame = CGRectMake(openGridLbl.frame.origin.x+openGridLbl.frame.size.width + 2,openGridLbl.frame.origin.y, 50, actualStockLbl.frame.size.height);
        
        //diffLbl.frame = CGRectMake(dumpLbl.frame.origin.x+dumpLbl.frame.size.width+2,dumpLbl.frame.origin.y,70,dumpLbl.frame.size.height);
        
        // frame for the stockVerificationScrollView...
        stockVerificationScrollView.frame = CGRectMake(searchItemTxt.frame.origin.x,searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height + 5, searchItemTxt.frame.size.width + 130, 380);
        
        // frame for the rawMaterialDetailsTbl...
        rawMaterialDetailsTbl.frame = CGRectMake(0,snoLbl.frame.origin.y+snoLbl.frame.size.height,actionLbl.frame.origin.x+actionLbl.frame.size.width-(snoLbl.frame.origin.x-80),stockVerificationScrollView.frame.size.height-(snoLbl.frame.origin.y+snoLbl.frame.size.height));
        
        // added by roja...
        stockVerificationScrollView.contentSize = CGSizeMake((actionLbl.frame.origin.x + actionLbl.frame.size.width) + 50, stockVerificationScrollView.frame.size.height);

        
        // frame for the productListTbl...
        //productListTbl.frame = CGRectMake(searchItemTxt.frame.origin.x, searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height,searchItemTxt.frame.size.width,250);
        
        requestedItemsTblHeaderView.frame = CGRectMake(skuidLbl.frame.origin.x,10,actionLbl.frame.origin.x + actionLbl.frame.size.width - (snoLbl.frame.origin.x),snoLbl.frame.size.height);
        
        itemNoLbl.frame = CGRectMake(0,0,45,30);
        
        itemDescLbl.frame = CGRectMake(itemNoLbl.frame.origin.x + itemNoLbl.frame.size.width+2,0, 120,itemNoLbl.frame.size.height);
        
        batchLbl.frame = CGRectMake(itemDescLbl.frame.origin.x + itemDescLbl.frame.size.width+2,0, 80, itemDescLbl.frame.size.height);
        
        itemGradeLbl.frame = CGRectMake(batchLbl.frame.origin.x + batchLbl.frame.size.width+2, 0, 70,itemNoLbl.frame.size.height);
        
        itemOpenStockLbl.frame = CGRectMake(itemGradeLbl.frame.origin.x + itemGradeLbl.frame.size.width+2, 0, 70, itemNoLbl.frame.size.height);
        
        itemSaleQtyLbl.frame = CGRectMake(itemOpenStockLbl.frame.origin.x + itemOpenStockLbl.frame.size.width+2, 0,70,itemNoLbl.frame.size.height);
        
        itemActualStockLbl.frame = CGRectMake(itemSaleQtyLbl.frame.origin.x + itemSaleQtyLbl.frame.size.width+2, 0, 75, itemNoLbl.frame.size.height);
        
        itemDumpQtyLbl.frame = CGRectMake(itemActualStockLbl.frame.origin.x + itemActualStockLbl.frame.size.width+2, 0, 75, itemNoLbl.frame.size.height);
        
        itemStockLossLbl.frame = CGRectMake(itemDumpQtyLbl.frame.origin.x + itemDumpQtyLbl.frame.size.width + 2,0, 70,itemNoLbl.frame.size.height);
        
        itemGradeStockLbl.frame = CGRectMake(itemStockLossLbl.frame.origin.x + itemStockLossLbl.frame.size.width + 2,0, 80,itemNoLbl.frame.size.height);
        
        itemCloseStockLbl.frame = CGRectMake(itemGradeStockLbl.frame.origin.x + itemGradeStockLbl.frame.size.width + 2,0, 80, itemNoLbl.frame.size.height);
      
        itemScanCodeLabel.frame = CGRectMake(itemCloseStockLbl.frame.origin.x + itemCloseStockLbl.frame.size.width + 2, 0, 95, itemNoLbl.frame.size.height);
        
        // frame for the UIbuttons...
        submitBtn.frame = CGRectMake(searchItemTxt.frame.origin.x,stockVerificationView.frame.size.height - 50,110, 40);
        
        saveBtn.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+5,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
        
        cancelButton.frame = CGRectMake(saveBtn.frame.origin.x + saveBtn.frame.size.width+5,submitBtn.frame.origin.y,saveBtn.frame.size.width,40);
        
        
        //Frames for the total Value labels.....
        // added on  11/07/2017..
        totalBookStockVlueLbl.frame = CGRectMake(bookStockLbl.frame.origin.x+5,cancelButton.frame.origin.y,bookStockLbl.frame.size.width,textFieldHeight);
        
        totalActualStockVlueLbl.frame = CGRectMake(actualStockLbl.frame.origin.x+5,cancelButton.frame.origin.y,actualStockLbl.frame.size.width,textFieldHeight);
        
        dumpValueLbl.frame = CGRectMake(dumpLbl.frame.origin.x+5,cancelButton.frame.origin.y,dumpLbl.frame.size.width,textFieldHeight);
        
        stockLossValueLbl.frame = CGRectMake(stockLossLbl.frame.origin.x+5,cancelButton.frame.origin.y,stockLossLbl.frame.size.width,textFieldHeight);
        
        declaredStockValueLbl.frame = CGRectMake(declaredStockLbl.frame.origin.x+5,cancelButton.frame.origin.y,declaredStockLbl.frame.size.width,textFieldHeight);
        
        closeStockValueLbl.frame = CGRectMake(closeStockLbl.frame.origin.x+5,cancelButton.frame.origin.y,closeStockLbl.frame.size.width,textFieldHeight);
        
        //frame for the  priceList....
        transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        // commented by roja on 03/07/2019.
        // reason below framings are for old gui..
//        priceView.frame = CGRectMake(200, 295, 550,300);
//        descLbl.frame = CGRectMake(10,10, 225, 35);
//        mrpLbl.frame = CGRectMake(descLbl.frame.origin.x+descLbl.frame.size.width+2,descLbl.frame.origin.y, 150, 35);
//        priceLabel.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, mrpLbl.frame.origin.y, 150, 35);
        
        
        // added by roja on 03/07/2019....
        pluCodeLabel.frame =  CGRectMake(0, 0, 150, 40);
        
        descLbl.frame =  CGRectMake(pluCodeLabel.frame.origin.x + pluCodeLabel.frame.size.width + 1, pluCodeLabel.frame.origin.y, 250, 40);
        
        eanLabel.frame =  CGRectMake(descLbl.frame.origin.x + descLbl.frame.size.width + 1, pluCodeLabel.frame.origin.y, 150, 40);

        batchLabel.frame =  CGRectMake(eanLabel.frame.origin.x + eanLabel.frame.size.width + 1, pluCodeLabel.frame.origin.y, 120, 40);

        measureRangeLabel.frame =  CGRectMake(batchLabel.frame.origin.x + batchLabel.frame.size.width + 1, pluCodeLabel.frame.origin.y, 100, 40);
        
        mrpLbl.frame =  CGRectMake(measureRangeLabel.frame.origin.x + measureRangeLabel.frame.size.width + 1, pluCodeLabel.frame.origin.y, 145, 40);
        
        priceView.frame = CGRectMake(50, 350, self.view.frame.size.width - 100 , 300);

        //frame for the  pricListTbl....
        
        pricListTbl.frame = CGRectMake(pluCodeLabel.frame.origin.x, pluCodeLabel.frame.origin.y + pluCodeLabel.frame.size.height + 2, mrpLbl.frame.origin.x + mrpLbl.frame.size.width - (pluCodeLabel.frame.origin.x), priceView.frame.size.height - (pluCodeLabel.frame.origin.y + pluCodeLabel.frame.size.height +48));
        
        closeBtn.frame = CGRectMake(priceView.frame.size.width + 20, priceView.frame.origin.y - 40, 40, 40);
        //upto here added by roja on 03/07/2019....

//        pricListTbl.frame = CGRectMake(descLbl.frame.origin.x,descLbl.frame.origin.y+descLbl.frame.size.height+10, priceLabel.frame.origin.x+priceLabel.frame.size.width - (descLbl.frame.origin.x), priceView.frame.size.height - (descLbl.frame.origin.y + descLbl.frame.size.height +48));
//
//        closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38, 40, 40);

        
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
    [stockVerificationView addSubview:endDateTxt];
    
    [stockVerificationView addSubview:startTimeTxt];
    [stockVerificationView addSubview:endTimeTxt];
    [stockVerificationView addSubview:ActionReqTxt];
    [stockVerificationView addSubview:searchItemTxt];
    
    //Added By Bhargav.v on 08/06/2018..
    [stockVerificationView addSubview:isSearch];
    [stockVerificationView addSubview:searchBarcodeBtn];
    //Upto here...
   
    [stockVerificationView addSubview:selectCategoriesBtn];
    
    [stockVerificationView addSubview:startDteBtn];
    [stockVerificationView addSubview:endDteBtn];
    [stockVerificationView addSubview:startTimeBtn];
    [stockVerificationView addSubview:endTimeBtn];
    [stockVerificationView addSubview:outletIdBtn];
    
    [stockVerificationView addSubview:totalBookStockVlueLbl];
    [stockVerificationView addSubview:totalActualStockVlueLbl];
    [stockVerificationView addSubview:dumpValueLbl];
    [stockVerificationView addSubview:stockLossValueLbl];
    [stockVerificationView addSubview:declaredStockValueLbl];
    [stockVerificationView addSubview:closeStockValueLbl];
    
    //[stockVerificationView addSubview:underLine_2];
    
    [stockVerificationView addSubview:submitBtn];
    [stockVerificationView addSubview:saveBtn];
    [stockVerificationView addSubview:cancelButton];
    
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
    [stockVerificationScrollView addSubview:openGridLbl];
    [stockVerificationScrollView addSubview:actionLbl];

    
    
    //[stockVerificationScrollView addSubview:diffLbl];
    
    [stockVerificationScrollView addSubview:rawMaterialDetailsTbl];
    
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
    [requestedItemsTblHeaderView addSubview:batchLbl];

    
//    [priceView addSubview:priceLabel]; // commented by roja no need for latest GUI
    [priceView addSubview:mrpLbl];
    [priceView addSubview:descLbl];
    [priceView addSubview:pricListTbl];
    
    // added by roja on 03/07/2019
    [priceView addSubview:pluCodeLabel];
    [priceView addSubview:batchLabel];
    [priceView addSubview:eanLabel];
    [priceView addSubview:measureRangeLabel];
    //upto here added by roja on 03/07/2019

    [transparentView addSubview:priceView];
    [transparentView addSubview:closeBtn];
    [self.view addSubview:stockVerificationView];
    
    [stockVerificationView addSubview:productListTbl];
    [self.view addSubview:transparentView];
    //here we are setting font to all subview to mainView.....
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:15.0f cornerRadius:0];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        powaStatusLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        powaStatusLblVal.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

        submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        saveBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        cancelButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:requestedItemsTblHeaderView andSubViews:YES fontSize:15.0f cornerRadius:0];
        
    } @catch (NSException *exception) {
        NSLog(@"---- exception while setting the fontSize to subViews ----%@",exception);
    }
    
        //Allocation of isPacked Array to check the Boolean flag..
        isPacked = [NSMutableArray new];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSLog(@"key board frame %f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
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

-(void)viewDidAppear:(BOOL)animated {
    
    //calling super Method...
    [super viewDidAppear:YES];
    
    @try {
        if (rawMaterialDetails == nil)
            rawMaterialDetails = [NSMutableArray new];
        
    } @catch (NSException * exception) {
        
    }
    //added by Bhargav.v on 08/06/2018.......
    isItemScanned = false;
    //upto here on 19/01/2017....

}


/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         06/06/2017
 * @method       didReceiveMemoryWarning
 * @author       Bhargav Ram
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



#pragma -mark start of service calls....

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
    
    //play Audio for button touch..
    AudioServicesPlaySystemSound(soundFileObject);
    
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

                [self displayAlertMessage:NSLocalizedString(@"please_select_atleast_one_category", nil) horizontialAxis:(self.view.frame.size.width-350)/2   verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return;
            }
        }
        //Recently Added By Bhargav.v on 16/11/2017...
        if (rawMaterialDetails.count) {
            
            [rawMaterialDetails removeAllObjects];
            
            self.isOpen = false;
            
            self.selectIndex = nil;
        }
        //up to here By Bhargav.v on 16/11/2017...
        
        @try {
            
            [HUD setHidden:NO];
            
            NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
            
            priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            priceListDic[START_INDEX] = @"-1";
            priceListDic[@"categoryList"] = catArr;
            priceListDic[kStoreLocation] = presentLocation;
            priceListDic[kRequiredRecords] = @"0";
            priceListDic[kNotForDownload] = [NSNumber numberWithBool:true];
            priceListDic[LATEST_CAMPAIGNS] = [NSNumber numberWithBool:false];
            priceListDic[kIsEffectiveDateConsidered] = [NSNumber numberWithBool:false];
            priceListDic[kIsApplyCampaigns] = [NSNumber numberWithBool:false];
            priceListDic[@"boneyardSummaryFlag"] = [NSNumber numberWithBool:false];
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
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Products Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
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

-(void)dismissCategoryPopOver:(UIButton*)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        [categoriesPopOver dismissPopoverAnimated:YES];
    } @catch (NSException *exception) {
        
    }
}

#pragma - mark actions with service calls response

/**
 * @description  here we are calling searchSku.......
 * @date         05/06/2017
 * @method       callRawMaterials
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
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
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,kSearchCriteria,kStoreLocation];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,searchItemTxt.text,presentLocation];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
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
 * @description  it will be executed when memory warning is receiveds.......
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

        WebServiceController * webServiceController = [WebServiceController new];
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


/**
 * @description  this method is used to get the locations based on bussinessActivty...
 * @date         21/09/2016
 * @method       getLocations
 * @author       Bhargav Ram
 * @param        int
 * @param        NSString
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       hiding the HUD in catch block....
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocations:(int)selectIndex businessActivity:(NSString *)businessActivity {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        locationArr = [[NSMutableArray alloc] init];
        
        NSArray * loyaltyKeys = @[START_INDEX,REQUEST_HEADER,BUSSINESS_ACTIVITY];
        
        NSArray * loyaltyObjects = @[@"0",[RequestHeader getRequestHeader],businessActivity];
        
        NSDictionary * dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData  *  jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString* loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
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
 * @description  sending request through submit for creating stock verification.......
 * @date         21/09/2016
 * @method       submitButtonPressed
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)submitButtonPressed:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    @try {
        
        Boolean isZeroQty = false;
        for(NSDictionary * skuDic in rawMaterialDetails)
            
            for(NSDictionary * dic in [skuDic valueForKey:SKU_PRICE_LIST]) {
                
                if(![[dic valueForKey:SKU_PHYSICAL_STOCK] integerValue])
                    isZeroQty = true;
            }
        
        if (rawMaterialDetails.count == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_add_items_to_cart", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if (isZeroQty && ((saveBtn.tag != submitBtn.tag) || sender == cancelButton)){
            
            conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"please_verify_zeroQty_items_are_available", nil) message:nil delegate:self cancelButtonTitle:@"CONTINUE" otherButtonTitles:@"CANCEL", nil];
            conformationAlert.tag = sender.tag; // save or submit tags will assigned
            [conformationAlert show];
        }
        else if (!isZeroQty && (saveBtn.tag != submitBtn.tag) && !(sender == cancelButton) ){

            conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_you_want_to_verify_the_stock", nil)  message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
            conformationAlert.tag = sender.tag;
            [conformationAlert show];
        }
        
        else {
            
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            
            submitBtn.userInteractionEnabled = NO;
            saveBtn.userInteractionEnabled = NO;
            //upto here on 02/05/2018....
            
            [HUD setHidden:NO];
            

            NSMutableDictionary * VerificationDic = [[NSMutableDictionary alloc]init];
            
            VerificationDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            VerificationDic[START_INDEX] = @-1;
            
            
            if (isHubLevel) {
                VerificationDic[LOCATION] = outletIDTxt.text;

            }
                VerificationDic[LOCATION] = presentLocation;

            
            NSString * verifiedDteStr = startDteTxt.text;
            NSString * verifiedOnStr  = endDateTxt.text;
            
            if(verifiedDteStr.length > 1)
                verifiedDteStr = [NSString stringWithFormat:@"%@%@", startDteTxt.text,@" 00:00:00"];
            
            if(verifiedOnStr.length > 1)
                verifiedOnStr = [NSString stringWithFormat:@"%@%@", endDateTxt.text,@" 00:00:00"];
            
            VerificationDic[MASTER_VERIFICATION_CODE] = [verificationCode valueForKey:VERIFICATION_REF];
            VerificationDic[VERIFIED_DATE_STR] = verifiedDteStr;
            VerificationDic[VERIFIED_ON] = verifiedOnStr;
            VerificationDic[START_TIME_STR] = startTimeTxt.text;
            VerificationDic[END_TIME_STR] = endTimeTxt.text;
            VerificationDic[VERIFIED_BY] = firstName;
            VerificationDic[REMARKS] = EMPTY_STRING;

            if(sender.tag == 2)
                VerificationDic[STATUS] = DRAFT;
            
            else
                VerificationDic[STATUS] = SUBMITTED;
            
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
            
            //end of main for loop....
            VerificationDic[ITEMS_LIST] = locArr;

            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:VerificationDic options:0 error:&err];
            NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"--%@",quoteRequestJsonString);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.storeStockVerificationDelegate = self;
//            [webServiceController createStockVerification:quoteRequestJsonString];
            [webServiceController createStockVerificationRestFullService:quoteRequestJsonString];

        }
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];

        //changed By Bhargav.v on 13/07/2018....
        //reason.. Need to enable user internation if we get any exception internally while forming a request..
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        //upto here on 02/05/2018....
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

    }
    @finally {
        
        [HUD setHidden:YES];

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
    
    else if (alertView == cancellationAlert) {
        
        if (buttonIndex == 0) {
            
            [self submitButtonPressed:cancelButton];
        }
        else {
            
            saveBtn.tag = 2;
            submitBtn.tag = 4;
            [self backAction];
//            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
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
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)searchProductsSuccessResponse:(NSDictionary*)successDictionary {
    
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
 * @date         7/06/2017
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
        
        [productListTbl reloadData];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
    @finally {
        
        [HUD setHidden:YES];
        searchItemTxt.tag = 0;
        [catPopOver dismissPopoverAnimated:YES];
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

-(void)getPriceListSkuDetailsSuccessResponse:(NSDictionary*)successDictionary {
    
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
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                
                //setting Description as SkuDescription
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                
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
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
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
    [searchItemTxt resignFirstResponder];// added by roja

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
                
                NSMutableDictionary * existItemdic;
                
                int i = 0;
                
                for (i = 0; i < rawMaterialDetails.count; i++) {
                    
                    //reading the existing cartItem....
                    existItemdic = rawMaterialDetails[i];
                    
                    if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]] && (![[itemdic valueForKey:TRACKING_REQUIRED] boolValue])) {
                        
                        rawMaterialDetails[i] = existItemdic;
                        isExistingItem = true;
                        break;
                    }
                }
                
                if (isExistingItem) {

                    // added by roja on 02/05/2019...
                    
                    NSMutableArray *existingPriceList =  [[NSMutableArray alloc]init];
                    
                    for (NSDictionary * tempDic in [existItemdic valueForKey:@"skuPriceLists"]) {

                        [tempDic setValue:[NSString stringWithFormat:@"%.2f",[[tempDic valueForKey:SKU_PHYSICAL_STOCK] floatValue] + 1] forKey:SKU_PHYSICAL_STOCK];
                        
                        [existingPriceList addObject:tempDic];
                    }
                    
                    [existItemdic setValue:existingPriceList forKey:@"skuPriceLists"];
                    rawMaterialDetails[i] = existItemdic;
                    //Upto here added by roja on 02/05/2019...


                    // Commented by roja on 02/05/2019...
                    // Reason Previously only once item should be added.. now repeatedly item can add.
//                    float y_axis = self.view.frame.size.height - 120;
//                    NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"item_already_added_to_the_cart",nil)];
//
//                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType: @""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    //Upto here Commented by roja on 02/05/2019...

                }
                
                else {
                    
                    NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                    
                    // setting skuId as skuId
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                    
                    //setting Description as SkuDescription
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                    
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
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MODEL] defaultReturn:@""] forKey:MODAL];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];

                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];

                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:@"0"] forKey:TRACKING_REQUIRED];
                        
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
//                        [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:STOCKLOSS_QTY];
                        
                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f" ,([[priceListDictionary valueForKey:SKU_BOOK_STOCK] floatValue] - [[priceListDictionary valueForKey:SKU_PHYSICAL_STOCK] floatValue])] forKey:STOCKLOSS_QTY];
                        
//                        [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f" ,([[priceListDictionary valueForKey:kSkuCostPrice] floatValue] * [[priceListDictionary valueForKey:STOCKLOSS_QTY] floatValue])] forKey:kStock_loss];
                        
                        [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kPackagedType] defaultReturn:@"0"] forKey:kPackagedType];// added by roja
                        
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
 * @description  in this method we are displaying the Success Response....
 * @method       createStockVerificationSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)createStockVerificationSuccessResponse:(NSDictionary *)successDictionary {
    
    float y_axis;
    NSString * mesg;
    
    @try {
        [HUD setHidden:YES];
        
        
        y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_verification_generated_successfully",nil),@"\n",[successDictionary valueForKey:VERIFICATION_CODE]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException * exception) {
        
        mesg = [NSString stringWithFormat:NSLocalizedString(@"stock_verification_generated_successfully",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        
    }
}


/**
 * @description  in this method we are displaying the Error Response as per the services....
 * @method       createStockVerificationErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)createStockVerificationErrorResponse:(NSString *)errorResponse {
    @try {
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to enable user internation after servcie calls...
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        //upto here on 02/05/2018....
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
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
        for(NSDictionary *dic in [successDictionary valueForKey:LOCATIONS_DETAILS]){
            
            
            if (![[dic valueForKey:LOCATION_ID] isKindOfClass:[NSNull class]] && [[dic valueForKey:LOCATION_ID] caseInsensitiveCompare:presentLocation] != NSOrderedSame) {
                [locationArr addObject:[dic valueForKey:LOCATION_ID]];
                
            }
            if ([locationArr containsObject:presentLocation]) {
                
                [locationArr removeObject:presentLocation];
            }
            
            //else   {
            //[warehouseLocationArr addObject:dic];
            //
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

-(void)getLocationErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
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
 *
 */

- (void)showListOfItems:(UIButton *)sender {
        //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [rawMaterialDetailsTbl reloadData];

    rawMaterialDetailsTbl.tag = sender.tag; // added by roja

    @try {
        
        itemsListTbl.tag = sender.tag;
        
        itemsListArr = [NSMutableArray new];
        
        for(NSDictionary * dic in [rawMaterialDetails[sender.tag] valueForKey:SKU_PRICE_LIST]) {
            
            [itemsListArr addObject:dic];
        }
        
        if(itemsListArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;

            [self displayAlertMessage:NSLocalizedString(@"no_data_found", nil) horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        else if(itemsListArr.count > 1){ // itemsListArr.count > 1 condition added by roja on 02/04/2019...
        
            NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
            
            if(path.row == 0) {
                
                UITableViewCell * cell2 = [rawMaterialDetailsTbl cellForRowAtIndexPath:path];
                
                if ([path isEqual:self.selectIndex]) { // Here we close the rows..
                    
                    self.isOpen = NO;
                    
                    // required later if 2 drop downs have to show..
                    for (UIButton * button in cell2.contentView.subviews) {

                        if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){//openGridBtn

                            UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"down_arrow.png"];

                            [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];

                            break;
                        }
                    }
                    
                    [self didSelectCellRowFirstDo:NO nextDo:NO];
                    
                    self.selectIndex = nil;
                }
                else  { // Here we open the rows...
                    
                    if (!self.selectIndex) {
                        self.selectIndex = path;
                        
                        // required later if 2 drop downs have to show..
                        for (UIButton * button in cell2.contentView.subviews) {

                            if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){// openGridBtn

                                UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"Up_arrow.png"];

                                [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                                break;
                            }
                        }
                        
                        [self didSelectCellRowFirstDo:YES nextDo:NO];
                        
                    }
                    else {
                        
                        selectSectionIndex = path;
                        
                        cell2 = [rawMaterialDetailsTbl cellForRowAtIndexPath: self.selectIndex];
                        
                        // required later if 2 drop downs have to show..
                        for (UIButton * button in cell2.contentView.subviews) {

                            if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){ // openGridBtn

                                UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"down_arrow.png"];

                                [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                                break;
                            }
                        }
                        
                        [self didSelectCellRowFirstDo:NO nextDo:YES];
                    }
                }
            }
            
            
        } // close bracket added by roja on 02/04/2019...

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
 * @param        NSIndexPath
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
            //requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:selectIndex.section] valueForKey:@"stockRequestItems"];
            
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

#pragma mark popover used to display the calendar & time..

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
            
            pickView.frame = CGRectMake(15,startDteTxt.frame.origin.y+startDteTxt.frame.size.height, 320, 320);
            
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
        
        //myPicker.datePickerMode = UIDatePickerModeTime;
        
        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
        
        
        
        //pickButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
        //clearButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
        
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        //upto here on 02/02/2017....
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:startDteTxt.frame inView:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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

    //BOOL callServices = false;
    
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
 * @description  populating the date to text field....
 * @date         01/03/2017
 * @method       populateDateToTextField:
 * @author       Srinivasulu
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
            
            if ((endDateTxt.text).length != 0 && (![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDateTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            endDateTxt.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
    }
}


/**
 * @description  displaying time to....
 * @date         01/03/2017
 * @method       selectTime:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)selectTime:(UIButton *)sender{
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
        NSDate *now = [NSDate date];
        [myPicker setDate:now animated:YES];
        myPicker.backgroundColor = [UIColor whiteColor];
        
        //myPicker.datePickerMode = UIDatePickerModeTime;
        
        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        
        
        //pickButton.backgroundColor = [UIColor grayColor];
        
        
        
        //pickButton.backgroundColor = [UIColor clearColor];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(getTime:) forControlEvents:UIControlEventTouchUpInside];
        //pickButton.layer.borderColor = [UIColor blackColor].CGColor;
        //pickButton.layer.borderWidth = 0.5f;
        //pickButton.layer.cornerRadius = 12;
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        
        //added by srinivasulu on 02/02/2017....
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        
        //pickButton.backgroundColor = [UIColor grayColor];
        
        //clearButton.backgroundColor = [UIColor clearColor];
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearTime:) forControlEvents:UIControlEventTouchUpInside];
        //clearButton.layer.borderColor = [UIColor blackColor].CGColor;
        //clearButton.layer.borderWidth = 0.5f;
        //clearButton.layer.cornerRadius = 12;
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        
        //pickButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
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
            else
                [popover presentPopoverFromRect:endTimeTxt.frame inView:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            //customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            catPopOver = popover;
        }
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
        
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the stockReceiptView in showCalenderInPopUp:----%@",exception);
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
    }
}

/**
 * @description  clear the time from textField and calling services.......
 * @date         01/03/2017
 * @method       clearTime:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)clearTime:(UIButton *)sender{
    //    BOOL callServices = false;
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(  sender.tag == 2){
            if((startTimeTxt.text).length)
                //callServices = true;
                
                
                startTimeTxt.text = @"";
        }
        else{
            if((endTimeTxt.text).length)
                //callServices = true;
                
                endTimeTxt.text = @"";
        }
        
      
        //if(callServices){
        //[HUD setHidden:NO];
        //
        //searchItemsTxt.tag = [searchItemsTxt.text length];
        ////stockRequestsInfoArr = [NSMutableArray new];
        //requestStartNumber = 0;
        //totalNoOfStockRequests = 0;
        //[self callingGetPurchaseStockReturns];
        //}
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  populating the time to text field....
 * @date         5/06/2017
 * @method       getTime:
 * @author       Bhargav
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
        //[requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
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
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start_time_should_be_earlier_than_end_time", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
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
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"end_time_should_not_be_earlier_than_start_time", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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



/**
 * @description  we are Displaying the outlet Locations...
 * @date         22/07/2017
 * @method       populateLocationsTable
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)populateLocationsTable:(UIButton *)sender {
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self getLocations:selectIndex businessActivity:RETAIL_OUTLET];
        
        if(locationArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:@""  conentWidth:200 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = locationArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationArr.count * 33;
        
        if(locationArr.count>5)
            tableHeight = (tableHeight/locationArr.count) * 5;
        
        [self showPopUpForTables:locationTable  popUpWidth:outletIDTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:outletIDTxt  showViewIn:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException *exception){
        
    } @finally {
        
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

-(void)showLossTypeList:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        lossTypeArr = [NSMutableArray new];
        [lossTypeArr addObject:@"Damaged"];
        [lossTypeArr addObject:@"Theft"];
        [lossTypeArr addObject:@"Others"];
     
        int count = 5;
        
        if (lossTypeArr.count < count) {
            count = (int)lossTypeArr.count;
        }
        
        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,lossTypeTxt.frame.size.width+30,count* 35)];
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
        
        [losstypeTbl reloadData];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    // actualStockValueTF && dumpStockValueTF added by roja on 05/07/2019...
    if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x || textField.frame.origin.x == gradeStockTxt.frame.origin.x || textField.frame.origin.x == dumpQtyTxt.frame.origin.x || textField.frame.origin.x == scanCodeText.frame.origin.x || textField.frame.origin.x  == actualStockValueTF.frame.origin.x || textField.frame.origin.x  == dumpStockValueTF.frame.origin.x)
        
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
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 * @return
 * @return
 * @verified By
 * @verified On
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
        @try {
            
            if(textField == searchItemTxt){
                
                offSetViewTo = 120;
            }
            
            else if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x || textField.frame.origin.x  == gradeStockTxt.frame.origin.x || textField.frame.origin.x  == dumpQtyTxt.frame.origin.x || textField.frame.origin.x == scanCodeText.frame.origin.x) {
                
                [textField selectAll:nil];
                [UIMenuController sharedMenuController].menuVisible = NO;

//                offSetViewTo = 250;//140
                // added by roja on 09/07/2019...
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:rawMaterialDetailsTbl.tag];
                UITableViewCell * selectedCell = [rawMaterialDetailsTbl cellForRowAtIndexPath:indexPath];
                
                offSetViewTo = rawMaterialDetailsTbl.frame.origin.y + selectedCell.frame.origin.y + 80;
            }
            else if(textField.frame.origin.x == actualStockValueTF.frame.origin.x || textField.frame.origin.x  == dumpStockValueTF.frame.origin.x){
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[textField tag]];
                UITableViewCell * selectedCell = [rawMaterialDetailsTbl cellForRowAtIndexPath:indexPath];
                
                offSetViewTo = rawMaterialDetailsTbl.frame.origin.y + selectedCell.frame.origin.y;
            }
            //upto here added by roja on 09/07/2019...

            [self keyboardWillShow];
            
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
    
     if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x || textField.frame.origin.x  == dumpQtyTxt.frame.origin.x){
        
         // changed by roja on 05/07/2019...
         NSArray * selectedItemPriceListArr = [[rawMaterialDetails objectAtIndex:rawMaterialDetailsTbl.tag] valueForKey:SKU_PRICE_LIST];
         
         BOOL isPackedItem = [[[selectedItemPriceListArr objectAtIndex:textField.tag] valueForKey:kPackagedType] boolValue];
         
        if (isPackedItem) {//[isPacked[textField.tag] boolValue]
            //upto here changed by roja on 05/07/2019...

            NSUInteger lengthOfString = string.length;
            
            for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                unichar character = [string characterAtIndex:loopIndex];
                if (character < 48) return NO; // 48 unichar for 0
                if (character > 57) return NO; // 57 unichar for 9
            }
        }
        else {
            
            @try {
                
                NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
                NSError  *error = nil;
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
                
                return numberOfMatches != 0;
                
            } @catch (NSException * exception) {
                
                NSLog(@"--exception in texField:shouldChangeCharactersInRange:replalcement----%@",exception);
                
                return YES;
            }
        }
    }
    
    else if (textField.frame.origin.x == actualStockValueTF.frame.origin.x || textField.frame.origin.x == dumpStockValueTF.frame.origin.x) {
        
        if ([isPacked[textField.tag] boolValue]) {
            
            NSUInteger lengthOfString = string.length;
            
            for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                unichar character = [string characterAtIndex:loopIndex];
                if (character < 48) return NO; // 48 unichar for 0
                if (character > 57) return NO; // 57 unichar for 9
            }
        }
        else {
            
            @try {
                
                NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
                NSError  *error = nil;
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
                
                return numberOfMatches != 0;
                
            } @catch (NSException * exception) {
                
                NSLog(@"--exception in texField:shouldChangeCharactersInRange:replalcement----%@",exception);
                
                return YES;
            }
        }
    }
    
//    else if(textField.frame.origin.x  == gradeStockTxt.frame.origin.x || textField.frame.origin.x  == dumpQtyTxt.frame.origin.x || textField.frame.origin.x == dumpStockValueTF.frame.origin.x){
//
//        @try{
//
//            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//            NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
//            NSError  *error = nil;
//            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
//            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
//            return numberOfMatches != 0;
//
//
//        } @catch (NSException * exception) {
//
//            NSLog(@"--exception in texField:shouldChangeCharactersInRange:replalcement----%@",exception);
//
//            return YES;
//        }
//    }

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
        
        // Commented by roja on 03/04/2019....
//        else {
//            [HUD setHidden:YES];
//            searchItemTxt.tag = 0;
//            [catPopOver dismissPopoverAnimated:YES];
//
//        }
    }
        
    }
    
    else if (textField.frame.origin.x == itemLevelActualStockTxt.frame.origin.x) {
        
        reloadTableData = true;
        
        @try {
            
            NSMutableDictionary * temp = [itemsListArr[textField.tag] mutableCopy];
            
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
    
    else if (textField.frame.origin.x == actualStockValueTF.frame.origin.x) { // added by roja on 05/07/2019
        
        reloadTableData = true;
//
//        @try {
//
////            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag] valueForKey:SKU_PRICE_LIST];
//
//            NSMutableArray * tempPriceListArr = [[NSMutableArray alloc] init];
//
//            for (NSDictionary * tempDic in [rawMaterialDetails[textField.tag] valueForKey:SKU_PRICE_LIST]) {
//
//                float bookStock  = [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:SKU_BOOK_STOCK] defaultReturn:@"0.00"] floatValue];
//                float actualStock= (textField.text).floatValue;
//
//                [tempDic setValue:[NSString stringWithFormat:@"%.2f",(bookStock - actualStock)] forKey:STOCKLOSS_QTY];
//                [tempDic setValue:textField.text  forKey:SKU_PHYSICAL_STOCK];
//
//                [tempPriceListArr addObject:tempDic];
//                break;
//            }
//
//            NSMutableDictionary * mutDic = rawMaterialDetails[textField.tag];
//
//            [mutDic setValue:tempPriceListArr forKey:SKU_PRICE_LIST];
//
//            rawMaterialDetails[textField.tag] = mutDic;
//
//        }
//        @catch (NSException * exception) {
//            NSLog(@"---%@",exception);
//        }
    } //upto here added by roja on 05/07/2019

    
    else if (textField.frame.origin.x == dumpStockValueTF.frame.origin.x) { // added by roja on 05/07/2019
        
        reloadTableData = true;
        
//        @try {
//
//            NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
//
//            float actualStock  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue];
//            float dumpStock = (textField.text).floatValue;
//
//            [temp setValue:[NSString stringWithFormat:@"%.2f",(actualStock - dumpStock)] forKey:DECLARED_QTY];
//            [temp setValue:textField.text  forKey:DUMP_QTY];
//
//            itemsListArr[textField.tag] = temp;
//
//            NSMutableDictionary * mutDic = rawMaterialDetails[itemsListTbl.tag];
//
//            [mutDic setValue:itemsListArr forKey:SKU_PRICE_LIST];
//            rawMaterialDetails[itemsListTbl.tag] = mutDic;
//        }
//        @catch (NSException * exception) {
//            NSLog(@"---%@",exception);
//        }
       
    } //upto here added by roja on 05/07/2019
    
   else if (textField.frame.origin.x == gradeStockTxt.frame.origin.x ) {
      
        reloadTableData = true;
        
        @try {
            
            NSString * qtyKey = DECLARED_QTY;
            
            if(textField.frame.origin.x == gradeStockTxt.frame.origin.x)
                
                qtyKey = DECLARED_QTY;
            
            NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            //if([qtyKey isEqualToString:DECLARED_QTY]) {
            
            //[temp setValue:textField.text  forKey:CLOSED_STOCK];
            //}
            
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
            if ((textField.text).integerValue == 0) {
                
            }
            else{
                
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
            NSMutableDictionary * temp = [itemsListArr[textField.tag] mutableCopy];
            
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
    
//    else if (textField.frame.origin.x == actualStockValueTF.frame.origin.x ) {
//
//        @try {
//
//            if ((textField.text).integerValue == 0) {
//            }
//            else{
//
//                NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
//
//                float bookStock  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:SKU_BOOK_STOCK] defaultReturn:@"0.00"] floatValue];
//                float actualStock= (textField.text).floatValue;
//
//                [temp setValue:[NSString stringWithFormat:@"%.2f",(bookStock - actualStock)] forKey:STOCKLOSS_QTY];
//                [temp setValue:textField.text  forKey:SKU_PHYSICAL_STOCK];
//
//                itemsListArr[textField.tag] = temp;
//
//                NSMutableDictionary * mutDic = rawMaterialDetails[itemsListTbl.tag];
//
//                [mutDic setValue:itemsListArr forKey:SKU_PRICE_LIST];
//                rawMaterialDetails[itemsListTbl.tag] = mutDic;
//
//            }
//        }
//        @catch (NSException *exception) {
//            NSLog(@"---------%@",exception);
//        }
//        @finally {
//            if(reloadTableData)
//                [rawMaterialDetailsTbl reloadData];
//            [self calculateTotal];
//        }
    //        }
    
        
    else if (textField.frame.origin.x == actualStockValueTF.frame.origin.x) { // added by roja on 05/07/2019
        
        reloadTableData = true;
        
        @try {
            
            if ((textField.text).integerValue == 0) {
                
            }
            else{
                
                //            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag] valueForKey:SKU_PRICE_LIST];
                
                NSMutableArray * tempPriceListArr = [[NSMutableArray alloc] init];
                
                for (NSDictionary * tempDic in [rawMaterialDetails[textField.tag] valueForKey:SKU_PRICE_LIST]) {
                    
                    float bookStock  = [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:SKU_BOOK_STOCK] defaultReturn:@"0.00"] floatValue];
                    float actualStock= (textField.text).floatValue;
                    
                    [tempDic setValue:[NSString stringWithFormat:@"%.2f",(bookStock - actualStock)] forKey:STOCKLOSS_QTY];
                    [tempDic setValue:textField.text  forKey:SKU_PHYSICAL_STOCK];
                    
                    [tempPriceListArr addObject:tempDic];
                    break;
                }
                
                NSMutableDictionary * mutDic = rawMaterialDetails[textField.tag];
                
                [mutDic setValue:tempPriceListArr forKey:SKU_PRICE_LIST];
                
                rawMaterialDetails[textField.tag] = mutDic;
                
            }
            
        }
        @catch (NSException * exception) {
            NSLog(@"---%@",exception);
        }
        @finally {
            if(reloadTableData)
                [rawMaterialDetailsTbl reloadData];
            [self calculateTotal];
        }
    } //upto here added by roja on 05/07/2019
    
    else if (textField.frame.origin.x == dumpStockValueTF.frame.origin.x ) { // added by roja on 05/07/2019
        
        @try {
            if ((textField.text).integerValue == 0) {
                
            }
            
            NSMutableArray * tempPriceListArr = [[NSMutableArray alloc] init];
            
            for (NSDictionary * tempDic in [rawMaterialDetails[textField.tag] valueForKey:SKU_PRICE_LIST]) {
                
                float actualStock  = [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@"0.00"] floatValue];
                float dumpStock = (textField.text).floatValue;
                
                [tempDic setValue:[NSString stringWithFormat:@"%.2f",(actualStock - dumpStock)] forKey:DECLARED_QTY];
                [tempDic setValue:textField.text  forKey:DUMP_QTY];
                
                [tempPriceListArr addObject:tempDic];
                
                break;
            }
            
            NSMutableDictionary * mutDic = rawMaterialDetails[textField.tag];
            
            [mutDic setValue:tempPriceListArr forKey:SKU_PRICE_LIST];
            rawMaterialDetails[textField.tag] = mutDic;
        }
        @catch (NSException *exception) {
            NSLog(@"---------%@",exception);
        }
        @finally {
            if(reloadTableData)
                [rawMaterialDetailsTbl reloadData];
            [self calculateTotal];
        }
    } //upto here added by roja on 05/07/2019
    
   else if (textField.frame.origin.x == gradeStockTxt.frame.origin.x ) {
       
       @try {
           
           NSString * qtyKey = DECLARED_QTY;
           
           if(textField.frame.origin.x == gradeStockTxt.frame.origin.x)
               
               qtyKey = DECLARED_QTY;
           
           NSMutableDictionary * temp = [itemsListArr[textField.tag]  mutableCopy];
           [temp setValue:textField.text  forKey:qtyKey];
           
           //if([qtyKey isEqualToString:DECLARED_QTY]) {
           //[temp setValue:textField.text  forKey:CLOSED_STOCK];
           //}
           
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

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
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
    else if(tableView == itemsListTbl) {
        
        return  itemsListArr.count;
    }
    else if (tableView == pricListTbl){
        
            return priceDic.count;
    }
    else if (tableView == categoriesTbl ) {
        
        return categoriesArr.count;
    }
    else if (tableView == losstypeTbl ) {
        
        return lossTypeArr.count;
    }
    else if (tableView == locationTable ) {
        
        return locationArr.count;
    }
    return 0;
}


/**
 * @description  it is tableview delegate method it will be called after heightForRowAtIndexPath.......
 * @date         26/09/2016
 * @method       heightForRowAtIndexPath
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        CGFloat
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
    
    if(tableView == rawMaterialDetailsTbl){
        
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
    else if (tableView == productListTbl || tableView == categoriesTbl || tableView == losstypeTbl || tableView == locationTable || tableView == itemsListTbl || tableView == pricListTbl) {
        
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
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section and populating the data into labels....
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == rawMaterialDetailsTbl) {
        
        if (self.isOpen && self.selectIndex.section == indexPath.section&&indexPath.row!= 0) {
            
            static NSString * cellIdentifier = @"cell1";
            
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
                    
                    itemsListTbl.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height + 5, requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height - 80);
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
            static NSString *hlCellID = @"hlCellID";
            
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
            UILabel  * item_NoLbl;
            //UILabel  * item_SkuIdLbl;
            UILabel  * item_DescLbl;
            UILabel  * item_uomLbl;
            UILabel  * saleQty_Lbl;
            UILabel  * openStock_Lbl;
            UILabel  * bookStock_Lbl;
            UILabel  * stockLoss_Lbl;
            UILabel  * declaredStck_Lbl;
            UILabel  * closeStock_Lbl;
            UILabel  * openGridBackGroundLbl;

            // commented by roja on 05/07/2019..
            // reason taking textfields to edit there values
//            UILabel  * actualStock_Lbl;
//            UILabel  * dump_Lbl;
            // commented by roja on 05/07/2019..

            //dumpStockValueTF &  actualStockValueTF added by roja on 05/07/2019..
            dumpStockValueTF = [[UITextField alloc] init];
            actualStockValueTF = [[UITextField alloc] init];

            item_NoLbl = [[UILabel alloc] init];
            item_NoLbl.backgroundColor = [UIColor clearColor];
            item_NoLbl.layer.borderWidth = 0;
            item_NoLbl.textAlignment = NSTextAlignmentCenter;
            item_NoLbl.numberOfLines = 1;
            item_NoLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemSkuidButton = [[UIButton alloc] init];
            itemSkuidButton.tag = indexPath.section;
            [itemSkuidButton addTarget:self action:@selector(showItemSkuAndDescrption:) forControlEvents:UIControlEventTouchUpInside];
            
            item_DescLbl = [[UILabel alloc] init];
            item_DescLbl.backgroundColor = [UIColor clearColor];
            item_DescLbl.layer.borderWidth = 0;
            item_DescLbl.textAlignment = NSTextAlignmentCenter;
            item_DescLbl.numberOfLines = 1;
            item_DescLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_uomLbl = [[UILabel alloc] init];
            item_uomLbl.backgroundColor = [UIColor clearColor];
            item_uomLbl.layer.borderWidth = 0;
            item_uomLbl.textAlignment = NSTextAlignmentCenter;
            item_uomLbl.numberOfLines = 1;
            item_uomLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
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

//            actualStock_Lbl = [[UILabel alloc] init];
//            actualStock_Lbl.backgroundColor = [UIColor clearColor];
//            actualStock_Lbl.layer.borderWidth = 0;
//            actualStock_Lbl.textAlignment = NSTextAlignmentCenter;
//            actualStock_Lbl.numberOfLines = 1;
//            actualStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
//
//            dump_Lbl = [[UILabel alloc] init];
//            dump_Lbl.backgroundColor = [UIColor clearColor];
//            dump_Lbl.layer.borderWidth = 0;
//            dump_Lbl.textAlignment = NSTextAlignmentCenter;
//            dump_Lbl.numberOfLines = 1;
//            dump_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            //added by roja on 05/07/2019...
            dumpStockValueTF = [[UITextField alloc] init];
            actualStockValueTF = [[UITextField alloc] init];
            
            actualStockValueTF.borderStyle = UITextBorderStyleRoundedRect;
            actualStockValueTF.textColor = [UIColor whiteColor];
            actualStockValueTF.backgroundColor = [UIColor clearColor];
            actualStockValueTF.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
            actualStockValueTF.delegate = self;
            actualStockValueTF.textAlignment = NSTextAlignmentCenter;
            actualStockValueTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            actualStockValueTF.returnKeyType = UIReturnKeyDone;
            [actualStockValueTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            actualStockValueTF.userInteractionEnabled = YES;

            dumpStockValueTF.delegate = self;
            dumpStockValueTF.borderStyle = UITextBorderStyleRoundedRect;
            dumpStockValueTF.textColor = [UIColor whiteColor];
            dumpStockValueTF.backgroundColor = [UIColor clearColor];
            dumpStockValueTF.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
            dumpStockValueTF.textAlignment = NSTextAlignmentCenter;
//            dumpStockValueTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            dumpStockValueTF.returnKeyType = UIReturnKeyDone;
            [dumpStockValueTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            dumpStockValueTF.userInteractionEnabled = YES;
            
            
            openGridBackGroundLbl = [[UILabel alloc] init];
            openGridBackGroundLbl.backgroundColor = [UIColor clearColor];
            
            openGridBtn = [[UIButton alloc] init];
            openGridBtn.tag = indexPath.section;
            [openGridBtn addTarget:self action:@selector(showListOfItems:) forControlEvents:UIControlEventTouchUpInside];
            //Upto here added by roja on 05/07/2019...
            

            stockLoss_Lbl = [[UILabel alloc] init];
            stockLoss_Lbl.backgroundColor = [UIColor clearColor];
            stockLoss_Lbl.layer.borderWidth = 0;
            stockLoss_Lbl.textAlignment = NSTextAlignmentCenter;
            stockLoss_Lbl.numberOfLines = 1;
            stockLoss_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            declaredStck_Lbl = [[UILabel alloc] init];
            declaredStck_Lbl.backgroundColor = [UIColor clearColor];
            declaredStck_Lbl.layer.borderWidth = 0;
            declaredStck_Lbl.textAlignment = NSTextAlignmentCenter;
            declaredStck_Lbl.numberOfLines = 1;
            declaredStck_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
          
            
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
            lossTypeTxt.placeholder = NSLocalizedString(@"loss_type",nil);
            lossTypeTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:lossTypeTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];

            UIImage * buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];
            lossTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [lossTypeBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
            lossTypeBtn.tag = indexPath.section;
            [lossTypeBtn addTarget:self action:@selector(showLossTypeList:) forControlEvents:UIControlEventTouchDown];

            delrowbtn = [[UIButton alloc] init];
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.section;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            viewListOfItemsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImage * availiableSuppliersListImage;
            if(self.isOpen && self.selectIndex.section == indexPath.section){
                availiableSuppliersListImage = [UIImage imageNamed:@"Up_arrow.png"];
            }
            else{
                availiableSuppliersListImage = [UIImage imageNamed:@"down_arrow.png"];
            }
            
//            viewListOfItemsBtn.userInteractionEnabled = NO;
            viewListOfItemsBtn.tag = indexPath.section;
            viewListOfItemsBtn.hidden = YES;
            [viewListOfItemsBtn setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];

//            if([priceDic count] > 1){
                viewListOfItemsBtn.userInteractionEnabled = YES;
                [viewListOfItemsBtn addTarget:self action:@selector(showListOfItems:) forControlEvents:UIControlEventTouchUpInside];
//            }
            
           
            
            item_NoLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemSkuidButton.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            item_DescLbl .layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            item_uomLbl .layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            openStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            saleQty_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            bookStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            stockLoss_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            declaredStck_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            closeStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            lossTypeTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            //            actualStock_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            //            dump_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;

            actualStockValueTF.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            dumpStockValueTF.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            

            item_NoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemSkuidButton.titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
            item_DescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_uomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            saleQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            openStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            bookStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            declaredStck_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            stockLoss_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            closeStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            lossTypeTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            actualStockValueTF.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            dumpStockValueTF.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

//            actualStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//            dump_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                //changed by Srinivasulu on 14/04/2017...
                
                item_NoLbl.frame = CGRectMake( snoLbl.frame.origin.x, 0, snoLbl.frame.size.width, hlcell.frame.size.height);
                
                itemSkuidButton.frame = CGRectMake(skuidLbl.frame.origin.x, 0,skuidLbl.frame.size.width,  hlcell.frame.size.height);
                
                item_DescLbl.frame = CGRectMake(skuDescLbl.frame.origin.x, 0, skuDescLbl.frame.size.width,  hlcell.frame.size.height);
                
                item_uomLbl.frame = CGRectMake(uomLbl.frame.origin.x, 0, uomLbl.frame.size.width,  hlcell.frame.size.height);
                
                openStock_Lbl.frame = CGRectMake(openStockLbl.frame.origin.x, 0, openStockLbl.frame.size.width,  hlcell.frame.size.height);
                
                saleQty_Lbl.frame = CGRectMake(saleQtyLbl.frame.origin.x, 0,saleQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                bookStock_Lbl.frame = CGRectMake(bookStockLbl.frame.origin.x, 0, bookStockLbl.frame.size.width,  hlcell.frame.size.height);
                
                actualStockValueTF.frame = CGRectMake(actualStockLbl.frame.origin.x, 4, actualStockLbl.frame.size.width, 34);
                
                dumpStockValueTF.frame = CGRectMake(dumpLbl.frame.origin.x, 2, dumpLbl.frame.size.width, 36);
                
                stockLoss_Lbl.frame = CGRectMake(stockLossLbl.frame.origin.x, 0, stockLossLbl.frame.size.width, hlcell.frame.size.height);
                
                declaredStck_Lbl.frame = CGRectMake(declaredStockLbl.frame.origin.x, 0,declaredStockLbl.frame.size.width,hlcell.frame.size.height);
                
                closeStock_Lbl.frame = CGRectMake(closeStockLbl.frame.origin.x,0,closeStockLbl.frame.size.width,hlcell.frame.size.height);
                
                lossTypeTxt.frame = CGRectMake(lossTypeLbl.frame.origin.x, 2, lossTypeLbl.frame.size.width, 36);
                
                lossTypeBtn.frame = CGRectMake((lossTypeTxt.frame.origin.x+lossTypeTxt.frame.size.width-40), lossTypeTxt.frame.origin.y-5,45,50);
                
                openGridBackGroundLbl.frame = CGRectMake(openGridLbl.frame.origin.x, 2, openGridLbl.frame.size.width, 36);
                
                openGridBtn.frame = CGRectMake(openGridBackGroundLbl.frame.origin.x +  (openGridBackGroundLbl.frame.size.width/2) -20, 5, 40, 30);
                
                delrowbtn.frame = CGRectMake(openGridBackGroundLbl.frame.origin.x + openGridBackGroundLbl.frame.size.width + 10, 5, 35, 35);
                
                //newly added  field for displaying the items in grid...
                viewListOfItemsBtn.frame = CGRectMake(delrowbtn.frame.origin.x + delrowbtn.frame.size.width-5,delrowbtn.frame.origin.y+5,30,30);
            }

            
            [hlcell.contentView addSubview:item_NoLbl];
            [hlcell.contentView addSubview:itemSkuidButton];
            [hlcell.contentView addSubview:item_DescLbl];
            [hlcell.contentView addSubview:item_uomLbl];
            [hlcell.contentView addSubview:openStock_Lbl];
            [hlcell.contentView addSubview:saleQty_Lbl];
            [hlcell.contentView addSubview:bookStock_Lbl];
            [hlcell.contentView addSubview:declaredStck_Lbl];
            [hlcell.contentView addSubview:actualStockValueTF];
            [hlcell.contentView addSubview:dumpStockValueTF];
            [hlcell.contentView addSubview:stockLoss_Lbl];
            [hlcell.contentView addSubview:closeStock_Lbl];
            [hlcell.contentView addSubview:lossTypeTxt];
            [hlcell.contentView addSubview:lossTypeBtn];
            [hlcell.contentView addSubview:viewListOfItemsBtn];
            // added by roja
            [hlcell.contentView addSubview:openGridBackGroundLbl];
            [hlcell.contentView addSubview:openGridBtn];

            [hlcell.contentView addSubview:delrowbtn];

            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0];
           
            @try {
                
                NSDictionary * temp = rawMaterialDetails[indexPath.section];
                
                item_NoLbl.text = [NSString stringWithFormat:@"%li", (indexPath.section + 1) ];
                
                [itemSkuidButton setTitle:[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SKU] defaultReturn:@"--"] forState:UIControlStateNormal];

                item_DescLbl.text =  [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                
                item_uomLbl.text =  [self checkGivenValueIsNullOrNil:[temp valueForKey:SELL_UOM] defaultReturn:@"--"];
                
                float openStock     = 0.0;
                float saleQty       = 0.0;
                float bookStock     = 0.0;
                float actualStock   = 0.0;
                float declaredStock = 0.0;
                float dumpStock     = 0.0;
                float stockLoss     = 0.0;
                
                for(NSDictionary * dic in [temp valueForKey:SKU_PRICE_LIST]) {
                    
                    openStock     += [[self checkGivenValueIsNullOrNil:[dic valueForKey:OPEN_STOCK] defaultReturn:@""] floatValue];
                    saleQty       += [[self checkGivenValueIsNullOrNil:[dic valueForKey:SALE_QTY] defaultReturn:@""] floatValue];
                    bookStock     += [[self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_BOOK_STOCK] defaultReturn:@""] floatValue];
                    actualStock   += [[self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_PHYSICAL_STOCK] defaultReturn:@""] floatValue];
                    declaredStock += [[self checkGivenValueIsNullOrNil:[dic valueForKey:DECLARED_QTY] defaultReturn:@""] floatValue];
                    dumpStock     += [[self checkGivenValueIsNullOrNil:[dic valueForKey:DUMP_QTY] defaultReturn:@""] floatValue];
                    stockLoss     += ([[dic valueForKey:SKU_BOOK_STOCK] floatValue] - [[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue]);
                }
                openStock_Lbl.text   = [NSString stringWithFormat:@"%.2f", openStock];
                
                saleQty_Lbl.text     = [NSString stringWithFormat:@"%.2f", saleQty];
                //Book Stock is equal to Actualstock....
                bookStock_Lbl.text   = [NSString stringWithFormat:@"%.2f",bookStock];
                declaredStck_Lbl.text= [NSString stringWithFormat:@"%.2f",declaredStock];
                
//                actualStock_Lbl.text = [NSString stringWithFormat:@"%.2f",actualStock];
//                dump_Lbl.text        = [NSString stringWithFormat:@"%.2f",dumpStock];
                
                // added by roja...
                actualStockValueTF.text = [NSString stringWithFormat:@"%.2f",actualStock];
                dumpStockValueTF.text        = [NSString stringWithFormat:@"%.2f",dumpStock];
                //upto here added by roja...

                stockLoss_Lbl.text = [NSString stringWithFormat:@"%.2f",stockLoss];
                
                closeStock_Lbl.text = [NSString stringWithFormat:@"%.2f",(actualStockValueTF.text).floatValue - (dumpStockValueTF.text).floatValue]; // actualStock_Lbl //dump_Lbl
                
                lossTypeTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:LOSS_TYPE] defaultReturn:@""];
                
                // added by roja on 03/04/2019...
                declaredStck_Lbl.text = [NSString stringWithFormat:@"%.2f",(actualStockValueTF.text).floatValue - (dumpStockValueTF.text).floatValue]; // actualStock_Lbl //dump_Lbl
                
                
                
                // added by roja
                
                //            UIImage * dropDownImage;
                //            if(self.isOpen && self.selectIndex.section == indexPath.section){
                //                dropDownImage = [UIImage imageNamed:@"Up_arrow.png"];
                //            }
                //            else{
                //                dropDownImage = [UIImage imageNamed:@"down_arrow.png"];
                //            }
                
//                rawMaterialDetailsTbl.tag = indexPath.section;
                actualStockValueTF.tag = indexPath.section;
                dumpStockValueTF.tag = indexPath.section;
                
                if([[temp valueForKey:SKU_PRICE_LIST] count] > 1){
                    
                    actualStockValueTF.userInteractionEnabled = NO;
                    dumpStockValueTF.userInteractionEnabled = NO;
                    [openGridBtn setImage:[UIImage imageNamed:@"down_arrow.png"] forState:UIControlStateNormal];
                }
                else{
                    actualStockValueTF.layer.borderWidth = 2;
                    dumpStockValueTF.layer.borderWidth = 2;
                    [openGridBtn setTitle:@"--" forState:UIControlStateNormal];
                }
                //up to here added by roja

            }
            
            @catch(NSException * exception) {
                
            }
            @finally {
            }
            
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
        UILabel * batchCodeLbl; // added by roja

        item_No_Lbl = [[UILabel alloc] init];
        item_No_Lbl.backgroundColor = [UIColor clearColor];
        item_No_Lbl.textAlignment = NSTextAlignmentCenter;
        item_No_Lbl.numberOfLines = 1;
        item_No_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        item_No_Lbl.layer.borderWidth = 1.5;
        item_No_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

        
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
        // added by roja on 02/04/2019...
        gradeStockTxt.userInteractionEnabled = NO;
        
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
        
        // added by roja
        batchCodeLbl = [[UILabel alloc] init];
        batchCodeLbl.backgroundColor = [UIColor clearColor];
        batchCodeLbl.textAlignment = NSTextAlignmentCenter;
        batchCodeLbl.numberOfLines = 1;
        batchCodeLbl.layer.borderWidth = 1.5;
        batchCodeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        batchCodeLbl.lineBreakMode = NSLineBreakByWordWrapping;
        //upto here added by roja

        
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
        [hlcell.contentView addSubview:batchCodeLbl];

        
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
        scanCodeText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        batchCodeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            item_No_Lbl.frame = CGRectMake(itemNoLbl.frame.origin.x, 0, itemNoLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            itemSkuDesc_Lbl.frame = CGRectMake(itemDescLbl.frame.origin.x, 0, itemDescLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            batchCodeLbl.frame = CGRectMake(batchLbl.frame.origin.x, 0, batchLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            itemGrade_Lbl.frame = CGRectMake(itemGradeLbl.frame.origin.x, 0, itemGradeLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            itemOpenStock_Lbl.frame = CGRectMake(itemOpenStockLbl.frame.origin.x, 0, itemOpenStockLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            itemSaleQty_Lbl.frame = CGRectMake(itemSaleQtyLbl.frame.origin.x, 0, itemSaleQtyLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            itemLevelActualStockTxt.frame = CGRectMake(itemActualStockLbl.frame.origin.x, 0, itemActualStockLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            dumpQtyTxt.frame = CGRectMake(itemDumpQtyLbl.frame.origin.x, 0, itemDumpQtyLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            gradeStockTxt.frame = CGRectMake(itemGradeStockLbl.frame.origin.x,0,itemGradeStockLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            itemStockLoss_Lbl.frame = CGRectMake(itemStockLossLbl.frame.origin.x,0,itemStockLossLbl.frame.size.width + 2, hlcell.frame.size.height);
            
            itemCloseStk_Lbl.frame = CGRectMake(itemCloseStockLbl.frame.origin.x,0,itemCloseStockLbl.frame.size.width, hlcell.frame.size.height);
            
            scanCodeText.frame = CGRectMake(itemScanCodeLabel.frame.origin.x - 2,0,itemScanCodeLabel.frame.size.width, hlcell.frame.size.height);
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:14.0f cornerRadius:0.0];
            
            // added by roja o 03/07/2019..
            itemLevelActualStockTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            dumpQtyTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            dumpQtyTxt.textColor = [UIColor blackColor];
            itemLevelActualStockTxt.textColor = [UIColor blackColor];
        }
        
        else {
            
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
            
            gradeStockTxt.text =[NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:DECLARED_QTY] defaultReturn:@"0.0"] floatValue]];
            
            dumpQtyTxt.text =[NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:DUMP_QTY] defaultReturn:@"0.0"] floatValue]];
            
            scanCodeText.text  = [self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_SCAN_CODE] defaultReturn:@"--"];
            
            itemStockLoss_Lbl.text =[NSString stringWithFormat:@"%.2f", ([[locDic valueForKey:SKU_BOOK_STOCK] floatValue] - [[locDic valueForKey:SKU_PHYSICAL_STOCK] floatValue])];
            
            float closeStock;
            
            closeStock = ([[locDic valueForKey:SKU_PHYSICAL_STOCK] floatValue] - [[locDic valueForKey:DUMP_QTY] floatValue]);
            
            itemCloseStk_Lbl.text = [NSString stringWithFormat:@"%.2f",closeStock];
            
            // added by roja on 03/04/2019....
            gradeStockTxt.text = [NSString stringWithFormat:@"%.2f",closeStock];
            
            batchCodeLbl.text = [self checkGivenValueIsNullOrNil:[locDic valueForKey:@"productBatchNo"] defaultReturn:@"--"];

        } @catch (NSException * exception) {
            
        }
        
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        hlcell.backgroundColor = [UIColor clearColor];
        return  hlcell;
        
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
    
    else if (tableView == pricListTbl){
        
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
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;

        @try {
            [HUD setHidden:YES];
            
            // added by roja on 03/07/2019....
            UILabel * pluCodeLbl;
            UILabel * eanLbl;
            UILabel * batchLbl;
            UILabel * measureRangeLbl;
            UILabel * salePriceLbl;
            //upto here added by roja on 03/07/2019....
            
            UILabel * itemDescriptionLbl;
//            UILabel *mrpPrice;
//            UILabel *price;
            
            itemDescriptionLbl = [[UILabel alloc] init];
            itemDescriptionLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            itemDescriptionLbl.backgroundColor = [UIColor blackColor];
            itemDescriptionLbl.textColor = [UIColor whiteColor];
            itemDescriptionLbl.textAlignment=NSTextAlignmentCenter;
            //itemDescriptionLbl.adjustsFontSizeToFitWidth = YES;
            
            
            // added by roja on 03/07/2019..
            pluCodeLbl = [[UILabel alloc] init];
            pluCodeLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            pluCodeLbl.backgroundColor = [UIColor blackColor];
            pluCodeLbl.textColor = [UIColor whiteColor];
            pluCodeLbl.textAlignment=NSTextAlignmentCenter;
            //            pluCodeLbl.layer.borderWidth = 1.5;
            //            pluCodeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

            eanLbl = [[UILabel alloc] init];
            eanLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            eanLbl.backgroundColor = [UIColor blackColor];
            eanLbl.textColor = [UIColor whiteColor];
            eanLbl.textAlignment=NSTextAlignmentCenter;
            
            batchLbl = [[UILabel alloc] init];
            batchLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            batchLbl.backgroundColor = [UIColor blackColor];
            batchLbl.textColor = [UIColor whiteColor];
            batchLbl.textAlignment=NSTextAlignmentCenter;
            
            measureRangeLbl = [[UILabel alloc] init];
            measureRangeLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            measureRangeLbl.backgroundColor = [UIColor blackColor];
            measureRangeLbl.textColor = [UIColor whiteColor];
            measureRangeLbl.textAlignment=NSTextAlignmentCenter;
            
            salePriceLbl = [[UILabel alloc] init];
            salePriceLbl.backgroundColor = [UIColor blackColor];
            salePriceLbl.textAlignment = NSTextAlignmentCenter;
            salePriceLbl.numberOfLines = 2;
            salePriceLbl.textColor = [UIColor whiteColor];
            
            // added by roja on 03/07/2019...
            if(priceDic != nil){
                
                NSDictionary * dic = priceDic[indexPath.row];

                pluCodeLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"pluCode"] defaultReturn:@"-"];
                itemDescriptionLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"description"] defaultReturn:@"-"];
                eanLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"ean"] defaultReturn:@"-"];
                batchLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"productBatchNo"] defaultReturn:@"-"];
                measureRangeLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"measureRange"] defaultReturn:@"-"];
                salePriceLbl.text = [self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[dic valueForKey:@"salePrice"] floatValue]] defaultReturn:@"0.0"];
            }
            
            // upto here added by roja on 03/07/2019...

//            price = [[UILabel alloc] init];
//            price.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
//            price.layer.borderWidth = 1.5;
//            price.backgroundColor = [UIColor blackColor];
//            price.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:@"price"] floatValue]];
//            price.textAlignment = NSTextAlignmentCenter;
//            price.numberOfLines = 2;
//            price.textColor = [UIColor whiteColor];

            // added by roja on 03/07/2019...
            itemDescriptionLbl.font = [UIFont systemFontOfSize:18];
            pluCodeLbl.font = [UIFont systemFontOfSize:18];
            measureRangeLbl.font = [UIFont systemFontOfSize:18];
            eanLbl.font = [UIFont systemFontOfSize:18];
            batchLbl.font = [UIFont systemFontOfSize:18];
            salePriceLbl.font = [UIFont systemFontOfSize:18];
            
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:itemDescriptionLbl];
            [hlcell.contentView addSubview:salePriceLbl];
            [hlcell.contentView addSubview:pluCodeLbl];
            [hlcell.contentView addSubview:eanLbl];
            [hlcell.contentView addSubview:measureRangeLbl];
            [hlcell.contentView addSubview:batchLbl];
            
//            [hlcell.contentView addSubview:price];

            pluCodeLbl.frame = CGRectMake( 0, 0, pluCodeLabel.frame.size.width, hlcell.frame.size.height);

            itemDescriptionLbl.frame = CGRectMake(pluCodeLbl.frame.origin.x + pluCodeLbl.frame.size.width + 1, 0, descLbl.frame.size.width, hlcell.frame.size.height);
            
            eanLbl.frame = CGRectMake(itemDescriptionLbl.frame.origin.x + itemDescriptionLbl.frame.size.width + 1, 0, eanLabel.frame.size.width, hlcell.frame.size.height);

            batchLbl.frame = CGRectMake(eanLbl.frame.origin.x + eanLbl.frame.size.width + 1, 0, batchLabel.frame.size.width, hlcell.frame.size.height);
            
            measureRangeLbl.frame = CGRectMake(batchLbl.frame.origin.x + batchLbl.frame.size.width + 1, 0, measureRangeLabel.frame.size.width, hlcell.frame.size.height);
            
            salePriceLbl.frame = CGRectMake(measureRangeLbl.frame.origin.x + measureRangeLbl.frame.size.width + 1, 0, mrpLbl.frame.size.width + 2,  hlcell.frame.size.height);
            
//                    price.font = [UIFont systemFontOfSize:22];
//                    price.frame = CGRectMake(mrpPrice.frame.origin.x + mrpPrice.frame.size.width, 0, priceLabel.frame.size.width+2, hlcell.frame.size.height);

        }
        @catch (NSException * exception) {
            
            NSLog(@"%@",exception);
        }
        @finally {
            
        }
        return hlcell;
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
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
        hlcell.textLabel.numberOfLines = 2;
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
    
    else if (tableView == locationTable){
        @try {
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
            hlcell.textLabel.text = locationArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
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

    //Dismissing the popover
    [catPopOver dismissPopoverAnimated:YES];
    
    if (tableView == productListTbl) {
        
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
    
    else if (tableView == losstypeTbl){
        
        @try {
            lossTypeTxt.text = lossTypeArr[indexPath.row];
            
            NSMutableDictionary * changeDic;
            
            if(rawMaterialDetails.count > losstypeTbl.tag){
                
                changeDic = rawMaterialDetails[losstypeTbl.tag];
                
                changeDic[LOSS_TYPE] = lossTypeTxt.text;
                
                rawMaterialDetails[losstypeTbl.tag] = changeDic;
                
            }
            
            [rawMaterialDetailsTbl reloadData];
        }
        
        @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == pricListTbl) {
        
        //added by Srinisulu on 14/04/2017 expansion handling....
        
        @try {
            
            transparentView.hidden = YES;

            NSMutableArray * priceListArr = [NSMutableArray new];
            
            NSDictionary * detailsDic = priceDic[indexPath.row];
            
            NSUInteger itemCount = priceDic.count;
            
            BOOL isExistingItem = false;
            
            NSDictionary * existItemdic;
            
            int i;
            
            for (i = 0; i<rawMaterialDetails.count;i++) {
              
                //reading the existing cartItem....
                existItemdic = rawMaterialDetails[i];
                
                if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]] && (![[detailsDic valueForKey:TRACKING_REQUIRED] boolValue])) {
                    
                    rawMaterialDetails[i] = existItemdic;
                    
                    isExistingItem = true;
                    
                    break;
                }
            }
            
            if (isExistingItem) {
                
                // added by roja on 03/07/2019..
                // reason item can be added multiple no of times ... so here we need to increased quanity..
//                float y_axis = self.view.frame.size.height - 120;
//
//                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"item_already_added_to_the_cart",nil)];
//
//                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType: @""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                // added by roja on 03/07/2019...
                
                NSMutableArray *existingPriceList =  [[NSMutableArray alloc]init];

                
                for (NSDictionary * tempDic in [existItemdic valueForKey:@"skuPriceLists"]) {
                    
                    
                    if ([[tempDic valueForKey:@"productBatchNo"] isEqualToString:[detailsDic valueForKey:@"productBatchNo"]]) {

                        [tempDic setValue:[NSString stringWithFormat:@"%.2f",[[tempDic valueForKey:SKU_PHYSICAL_STOCK] floatValue] + 1] forKey:SKU_PHYSICAL_STOCK];
                    }
                    
                    [existingPriceList addObject:tempDic];
                }
                
                [existItemdic setValue:existingPriceList forKey:@"skuPriceLists"];
                rawMaterialDetails[i] = existItemdic;
                //Upto here added by roja on 03/07/2019...
  
            }

            else {
                
                NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                
                // setting skuId as skuId
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                
                //setting Description as SkuDescription
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                
                //setting pluCode....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                
                //Setting skuCostPrice as costPrice
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
                
                //setting quantity....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];
                
                //setting productRange....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                
                //setting measureRange
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                
                //setting category
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                
                //setting Product Category...
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PRODUCT_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
                
                //setting subCategory...
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                
                [itemDetailsDic setValue:EMPTY_STRING forKey:LOSS_TYPE];
                
                //To Display the grid Items based on skuLists count...
                
                
                for (int j = 0; j < itemCount; j++) {

                    NSMutableDictionary * priceListDictionary = [[NSMutableDictionary alloc] init];
                    
                    NSDictionary * detailsDic =  [priceDic objectAtIndex:j];
                    
                    // Setting SkuId as Sku_id
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:SKU_ID];
                    
                    //setting pluCode....
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                    
                    //Setting Description as SkuDescription
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:kskuDescription];
                    
                    //Setting productRange as productRange
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                    
                    //Setting quantityInHand as openStock
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:OPEN_STOCK];
                    
                    //Setting quantityInHand as product_physical_stock
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_PHYSICAL_STOCK];
                    
                    //Setting quantityInHand as product_book_stock
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:PRODUCT_BOOK_STOCK];
                    
                    //Setting quantityInHand as sku_book_stock
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:SKU_BOOK_STOCK];
                    
                    //Setting soldQty as saleQty
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:SOLD_QTY] defaultReturn:@"0.00"] floatValue]] forKey:SALE_QTY];
                    
                    //Setting costPrice as skuCostPrice
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:kSkuCostPrice];
                    
                    //Setting measureRange as measureRange
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                    
                    //Setting subCategory as subCategory
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                    
                    //Setting uom as uom
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                    
                    //Setting ean as ean
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                    
                    //Setting color as color
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                    
                    //Setting productCategory as productCategory(which we are retreving from the Parent Dictionary)....
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PRODUCT_CATEGORY] defaultReturn:@""] forKey:PRODUCT_CATEGORY];
                    
                    //Setting productId as productId(which we are retreving from the Parent Dictionary)....
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PRODUCT_ID] defaultReturn:@""] forKey:PRODUCT_ID];
                    
                    float bookStock = [[self checkGivenValueIsNullOrNil:[priceListDictionary valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue] -[[self checkGivenValueIsNullOrNil:[priceListDictionary valueForKey:SALE_QTY] defaultReturn:@"0.00"] floatValue];
                    
                    //Setting openStock - saleQty as sku_book_stock
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%.2f",bookStock] forKey:SKU_BOOK_STOCK];
                    
                    //setting sku_physical_stock as 0..
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:SKU_PHYSICAL_STOCK];
                    
                    //setting skuBookStock as 0..
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:DECLARED_QTY];
                    
                    //setting dumpQty as 0..
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:DUMP_QTY];
                    
                    //setting closedStock as 0..
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:CLOSED_STOCK];
                    
                    //setting stock_loss as 0..
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:kStock_loss];
                    
                    [priceListDictionary setValue:[NSString stringWithFormat:@"%d",0] forKey:STOCKLOSS_QTY];
                    // added by roja
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:@"productBatchNo"] defaultReturn:@""] forKey:@"productBatchNo"];
                    
                    // added by roja on 05/07/2019
                    [priceListDictionary setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kPackagedType] defaultReturn:@"0"] forKey:kPackagedType];// added by roja
                    
                    
                    [priceListArr addObject:priceListDictionary];
                    
                }
                
                itemDetailsDic[SKU_PRICE_LIST] = priceListArr;
                
                [rawMaterialDetails addObject:itemDetailsDic];
            
                
                [self calculateTotal];
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
            [rawMaterialDetailsTbl reloadData];

        }
    }
    else if (tableView == locationTable){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            outletIDTxt.text = locationArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
//    else if (tableView == rawMaterialDetailsTbl) {
//
//        //play Audio for button touch....
//        AudioServicesPlaySystemSound(soundFileObject);
//
//        @try {
//            rawMaterialDetailsTbl.tag = indexPath.section; // added by roja
//
//            UIButton * showGridBtn = [[UIButton alloc]init];
//            showGridBtn.tag = indexPath.section;
//            [self showListOfItems:showGridBtn];
//
//        } @catch (NSException *exception) {
//            NSLog(@"exception near selection of rawMaterialDetailsTbl %@",exception);
//        }
//    }
}

/**
 * @description  Displaying the popover to show the SKU and DESCRIPTION of the ITEM....
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
            
            item_skuidLabel.text = [self checkGivenValueIsNullOrNil:[rawMaterialDetails[sender.tag] valueForKey:ITEM_SKU]  defaultReturn:@""];
            item_DescriptionLabel.text = [self checkGivenValueIsNullOrNil:[rawMaterialDetails[sender.tag] valueForKey:ITEM_DESCRIPTION]  defaultReturn:@""];
        }
    }
    @catch(NSException * exception){
        
    }
    @finally {
        
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





#pragma -mark action used in this page

/**
 * @description  here we are deleting an item.......
 * @date         20/0/2016
 * @method       delRow:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 * @return
 * @verified By
 * @verified On

 */

- (void)delRow:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {

        if (delItemAlert == nil || (delItemAlert.tag == 2)) {
            
            if (delItemAlert == nil)
            delItemAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"remove_this_item_from_the_list", nil) message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
            
            delItemAlert.tag = 2;
            
            delrowbtn = sender;

            
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
        
        for(NSDictionary * skuDic in rawMaterialDetails)
            for(NSDictionary * dic in [skuDic valueForKey:SKU_PRICE_LIST]) {
                
                bookStock     +=    [[dic valueForKey:SKU_BOOK_STOCK]floatValue];
                actualStock   +=     [[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue];
                declaredStock +=     [[dic valueForKey:DECLARED_QTY] floatValue];
                dumpStock     +=     [[dic valueForKey:DUMP_QTY] floatValue];
                stockLoss     +=     ([[dic valueForKey:SKU_BOOK_STOCK] floatValue] - [[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue]);
                closeStock    +=     ([[dic valueForKey:SKU_PHYSICAL_STOCK] floatValue] - [[dic valueForKey:DUMP_QTY] floatValue]);
                
            }
        totalBookStockVlueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@"    ",bookStock];
        totalActualStockVlueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",actualStock];
        dumpValueLbl.text            = [NSString stringWithFormat:@"%@%.2f",@"    ",dumpStock];
        stockLossValueLbl.text            = [NSString stringWithFormat:@"%@%.2f",@"    ",stockLoss];
        closeStockValueLbl.text      = [NSString stringWithFormat:@"%@%.2f",@"    ",closeStock];
        // changed by roja on 03/04/2019...
        declaredStockValueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@"    ",closeStock];
//        declaredStockValueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@"    ",declaredStock];

    } @catch (NSException *exception) {
        NSLog(@"------exception in while calculating the totalValue-----%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  navigating to the super class...
 * @date         18/11/2016
 * @method       cancelButtonPressed
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)cancelButtonPressed:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);

    @try {
        
        if([rawMaterialDetails count] && rawMaterialDetails != nil){
            
            cancelButton.tag = 4;
            
            cancellationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Do you want to submit this Verification", nil)  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
            //            cancellationAlert.tag = submitBtn.tag; // or cancelButton.tag
            [cancellationAlert show];
        }
        else{
              [self backAction];
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
//                searchItemTxt.tag = (searchItemTxt.text).length;
//                searchString = [searchItemTxt.text copy];
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
//
//                }
//            }
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

-(void)searchBarcode {
    
    //Play Audio For Button Touch.....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Resiging the FirstResonder....
    [searchItemTxt resignFirstResponder];
    
    @try {
        
        if ((searchItemTxt.text).length>0) {
            
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
        searchItemTxt.text = @"";
        [HUD setHidden:YES];
        [catPopOver dismissPopoverAnimated:YES];
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


@end



