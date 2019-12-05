
//  NewStockVerificationViewController.m
//  OmniRetailer
//  Created by Technolabs on 17/05/17.

#import "NewStockVerificationViewController.h"
#import "StockverificationViewController.h"
#import "OmniHomePage.h"
#import "EditStockVerificationController.h"

@interface NewStockVerificationViewController ()

@end

@implementation NewStockVerificationViewController
@synthesize soundFileURLRef,soundFileObject;
@synthesize isOpen,selectIndex,buttonSelectIndex,selectSectionIndex;

#pragma  -mark start of ViewLifeCycle mehods....

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
 *
 * @verified By
 * @verified On
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
    
    [HUD show:YES];
    [HUD setHidden:NO];
    HUD.labelText = @"Please Wait..";
    
    //allocation the stockVerificationView which will displayed completed Screen.......
    stockVerificationView = [[UIView alloc] init];
    stockVerificationView.backgroundColor = [UIColor blackColor];
    stockVerificationView.layer.borderWidth = 1.0f;
    stockVerificationView.layer.cornerRadius = 10.0f;
    stockVerificationView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    
    UILabel  * headerNameLbl;
    CALayer  * bottomBorder;
    UIImage  * startDteImg;
    UIButton * startDteBtn;
    UIImage  * categoryImg;
    UIButton * locationBtn;
    UIButton * categoryBtn;
    UIButton * endDateBtn;
    UIButton * workFlowBtn;
    UIButton * subCategoryBtn;
    UIButton * clearBtn;
    UILabel  * userNameLbl;
    
    //Declaring UIImage in String Format
    categoryImg  = [UIImage imageNamed:@"arrow_1.png"];
    startDteImg  = [UIImage imageNamed:@"Calandar_Icon.png"];

    //allocation of headerNameLbl.
    headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    
    // Regard's to the view borderwidth and color setting....
    bottomBorder = [CALayer layer];
    bottomBorder.opacity = 5.0f;
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    [headerNameLbl.layer addSublayer:bottomBorder];
    
    
    /** creation of UITextField*/
    //allocation of zoneTxt.
    zoneTxt = [[CustomTextField alloc] init];
    zoneTxt.delegate = self;
    zoneTxt.userInteractionEnabled = NO;
    zoneTxt.placeholder =  NSLocalizedString(@"zone",nil);
    [zoneTxt awakeFromNib];
    
    //allocation of outletIDTxt.
    outletIDTxt = [[CustomTextField alloc] init];
    outletIDTxt.placeholder = NSLocalizedString(@"all_outlets", nil);
    outletIDTxt.delegate = self;
    outletIDTxt.userInteractionEnabled = NO;
    [outletIDTxt awakeFromNib];

    //allocation of categoryTxt.
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.placeholder = NSLocalizedString(@"all_categories", nil);
    categoryTxt.delegate = self;
    categoryTxt.userInteractionEnabled = NO;
    [categoryTxt awakeFromNib];
    
    //allocation of subCategoryTxt.
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.placeholder = NSLocalizedString(@"all_subcategories", nil);
    subCategoryTxt.delegate = self;
    subCategoryTxt.userInteractionEnabled = NO;
    [subCategoryTxt awakeFromNib];
    
    //allocation of startDteTxt.
    startDteTxt = [[CustomTextField alloc] init];
    startDteTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDteTxt.delegate = self;
    startDteTxt.userInteractionEnabled = NO;
    [startDteTxt awakeFromNib];

    //allocation of endDateTxt.
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDateTxt.delegate = self;
    endDateTxt.userInteractionEnabled = NO;
    [endDateTxt awakeFromNib];
    
    
    statusTxt = [[CustomTextField alloc] init];
    statusTxt.placeholder = NSLocalizedString(@"select_status", nil);
    statusTxt.delegate = self;
    statusTxt.userInteractionEnabled = NO;
    [statusTxt awakeFromNib];
    
    //allocation of locationBtn.
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setBackgroundImage:categoryImg forState:UIControlStateNormal];
    [locationBtn addTarget:self
                    action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    
    //allocation of CategoryBtn.
    categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryBtn setBackgroundImage:categoryImg forState:UIControlStateNormal];
    [categoryBtn addTarget:self
                    action:@selector(showCategoriesList:) forControlEvents:UIControlEventTouchDown];
   
    //allocation of subCategoryBtn.
    subCategoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subCategoryBtn setBackgroundImage:categoryImg forState:UIControlStateNormal];
    [subCategoryBtn addTarget:self
                       action:@selector(showAllSubCategoriesList:) forControlEvents:UIControlEventTouchDown];
    //allocation of startDteBtn.
    startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self
                    action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    startDteBtn.userInteractionEnabled = YES;
    
    //allocation of endDateBtn.
    endDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDateBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [endDateBtn addTarget:self
                   action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    endDateBtn.userInteractionEnabled = YES;
    
    //allocation of endDateBtn.
    workFlowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [workFlowBtn setBackgroundImage:categoryImg forState:UIControlStateNormal];
    [workFlowBtn addTarget:self
                    action:@selector(showWorkFlowStatus:) forControlEvents:UIControlEventTouchDown];
    workFlowBtn.userInteractionEnabled = YES;
    
    //used for identification propouse....
    
    //allocation of searchBtn.
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self
                  action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //allocation of clearBtn.
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //allocation of userNameLbl.
    userNameLbl = [[UILabel alloc] init];
    userNameLbl.text = firstName;
    userNameLbl.layer.cornerRadius = 3.0f;
    userNameLbl.layer.masksToBounds = YES;
    userNameLbl.layer.borderWidth  = 1.0f;
    userNameLbl.numberOfLines = 2;
    userNameLbl.textAlignment = NSTextAlignmentCenter;
    userNameLbl.backgroundColor = [UIColor clearColor];
    userNameLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    userNameLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    
    //allocation of startVerificationBtn.
    startVerificationBtn = [[UIButton alloc] init];
    [startVerificationBtn addTarget:self
                             action:@selector(startVerification:) forControlEvents:UIControlEventTouchDown];
    startVerificationBtn.layer.cornerRadius = 3.0f;
    startVerificationBtn.backgroundColor = [UIColor grayColor];
    [startVerificationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startVerificationBtn.userInteractionEnabled = YES;
    startVerificationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    
    stockVerificationScrollView = [[UIScrollView alloc]init];
    //stockVerificationScrollView.backgroundColor = [UIColor lightGrayColor];

    
    
    //header Section:
    //Creation of items TableHeader's.......
    
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    dateLbl = [[CustomLabel alloc] init];
    [dateLbl awakeFromNib];
    
    outletIdLbl = [[CustomLabel alloc] init];
    [outletIdLbl awakeFromNib];
    
    openStockLbl = [[CustomLabel alloc] init];
    [openStockLbl awakeFromNib];
    
    saleQtyLbl = [[CustomLabel alloc] init];
    [saleQtyLbl awakeFromNib];
    
    bookStockLbl = [[CustomLabel alloc] init];
    [bookStockLbl awakeFromNib];
    
    declaredStockLbl = [[CustomLabel alloc] init];
    [declaredStockLbl awakeFromNib];
    
    stockDumpLbl = [[CustomLabel alloc] init];
    [stockDumpLbl awakeFromNib];
    
    dumpCostLbl = [[CustomLabel alloc] init];
    [dumpCostLbl awakeFromNib];
    
    stockLossLbl = [[CustomLabel alloc] init];
    [stockLossLbl awakeFromNib];
    
    lossCostLbl = [[CustomLabel alloc] init];
    [lossCostLbl awakeFromNib];
    
    closeStockLbl = [[CustomLabel alloc] init];
    [closeStockLbl awakeFromNib];
    
    statusLbl = [[CustomLabel alloc] init];
    [statusLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    //creation of UITable View:
    
    stockVerificationTbl = [[UITableView alloc] init];
    stockVerificationTbl.dataSource = self;
    stockVerificationTbl.delegate = self;
    stockVerificationTbl.backgroundColor = [UIColor blackColor];
    stockVerificationTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //creation of  itemsListTable UITable View:
    
    itemsListTbl = [[UITableView alloc] init];
    itemsListTbl.dataSource = self;
    itemsListTbl.delegate = self;
    itemsListTbl.backgroundColor = [UIColor clearColor];
    itemsListTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    //table's used in popUp's.......
    //catrgory Table creation...
    categoriesTbl = [[UITableView alloc] init];
    
    //subCategorytbl Table creation...
    subCategorytbl = [[UITableView alloc] init];
    
    //locationTable Table creation...
    locationTable = [[UITableView alloc] init];
    
    //workFlowListTbl Table creation...
    workFlowListTbl = [[UITableView alloc] init];

    //workFlowListTbl Table creation...
    pagenationTbl = [[UITableView alloc] init];

    
    requestedItemsTblHeaderView = [[UIView alloc] init];
    
    // Creation of items TableHeader's.......
    itemNoLbl = [[CustomLabel alloc] init];
    [itemNoLbl awakeFromNib];
    
    categoryLbl = [[CustomLabel alloc] init];
    [categoryLbl awakeFromNib];
    
    openStock = [[CustomLabel alloc] init];
    [openStock awakeFromNib];

    
    itemSaleQtyLbl = [[CustomLabel alloc] init];
    [itemSaleQtyLbl awakeFromNib];
    
    itemSaleLbl = [[CustomLabel alloc] init];
    [itemSaleLbl awakeFromNib];
    
    
    dumpLbl = [[CustomLabel alloc] init];
    [dumpLbl awakeFromNib];
    
    dumpVal = [[CustomLabel alloc] init];
    [dumpVal awakeFromNib];
    
    dumpPercentLbl = [[CustomLabel alloc] init];
    [dumpPercentLbl awakeFromNib];
    
    itemlevelStockLossLbl = [[CustomLabel alloc]init];
    [itemlevelStockLossLbl awakeFromNib];
    
    itemLevelLossCostLbl = [[CustomLabel alloc]init];
    [itemLevelLossCostLbl awakeFromNib];

    lossLbl = [[CustomLabel alloc] init];
    [lossLbl awakeFromNib];
    
    
//    allocation of UILabels to check the total value of inventory levels...
    
    UILabel * totalLabel;
    totalLabel = [[UILabel alloc] init];
    totalLabel.layer.cornerRadius = 5;
    totalLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalLabel.layer.masksToBounds = YES;
    totalLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    totalLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    openStockValueLbl = [[UILabel alloc] init];
    openStockValueLbl.layer.cornerRadius = 5;
    openStockValueLbl.layer.masksToBounds = YES;
    openStockValueLbl.backgroundColor = [UIColor blackColor];
    openStockValueLbl.layer.borderWidth = 2.0f;
    openStockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    openStockValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    openStockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    saleQtyValueLbl = [[UILabel alloc] init];
    saleQtyValueLbl.layer.cornerRadius = 5;
    saleQtyValueLbl.backgroundColor = [UIColor blackColor];
    saleQtyValueLbl.layer.masksToBounds = YES;
    saleQtyValueLbl.layer.borderWidth = 2.0f;
    saleQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    saleQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    saleQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    bookStockValueLbl = [[UILabel alloc] init];
    bookStockValueLbl.layer.cornerRadius = 5;
    bookStockValueLbl.backgroundColor = [UIColor blackColor];
    bookStockValueLbl.layer.masksToBounds = YES;
    bookStockValueLbl.layer.borderWidth = 2.0f;
    bookStockValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    bookStockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    bookStockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    declaredQtyValueLbl = [[UILabel alloc] init];
    declaredQtyValueLbl.layer.cornerRadius = 5;
    declaredQtyValueLbl.backgroundColor = [UIColor blackColor];
    declaredQtyValueLbl.layer.masksToBounds = YES;
    declaredQtyValueLbl.layer.borderWidth = 2.0f;
    declaredQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    declaredQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    declaredQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    stockDumpValueLbl = [[UILabel alloc] init];
    stockDumpValueLbl.layer.cornerRadius = 5;
    stockDumpValueLbl.backgroundColor = [UIColor blackColor];
    stockDumpValueLbl.layer.masksToBounds = YES;
    stockDumpValueLbl.layer.borderWidth = 2.0f;
    stockDumpValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    stockDumpValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    stockDumpValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    dumpCostValueLbl = [[UILabel alloc] init];
    dumpCostValueLbl.layer.cornerRadius = 5;
    dumpCostValueLbl.backgroundColor = [UIColor blackColor];
    dumpCostValueLbl.layer.masksToBounds = YES;
    dumpCostValueLbl.layer.borderWidth = 2.0f;
    dumpCostValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    dumpCostValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    dumpCostValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    stockLossValueLbl = [[UILabel alloc] init];
    stockLossValueLbl.layer.cornerRadius = 5;
    stockLossValueLbl.backgroundColor = [UIColor blackColor];
    stockLossValueLbl.layer.masksToBounds = YES;
    stockLossValueLbl.layer.borderWidth = 2.0f;
    stockLossValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    stockLossValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    stockLossValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    
    lossCostValueLbl = [[UILabel alloc] init];
    lossCostValueLbl.layer.cornerRadius = 5;
    lossCostValueLbl.backgroundColor = [UIColor blackColor];
    lossCostValueLbl.layer.masksToBounds = YES;
    lossCostValueLbl.layer.borderWidth = 2.0f;
    lossCostValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    lossCostValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    lossCostValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    
    closeStockValueLbl = [[UILabel alloc] init];
    closeStockValueLbl.layer.cornerRadius = 5;
    closeStockValueLbl.backgroundColor = [UIColor blackColor];
    closeStockValueLbl.layer.masksToBounds = YES;
    closeStockValueLbl.layer.borderWidth = 2.0f;
    closeStockValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    closeStockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    closeStockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    totalLabel.textAlignment          = NSTextAlignmentCenter;
    openStockValueLbl.textAlignment   = NSTextAlignmentCenter;
    saleQtyValueLbl.textAlignment     = NSTextAlignmentCenter;
    bookStockValueLbl.textAlignment   = NSTextAlignmentCenter;
    declaredQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    stockDumpValueLbl.textAlignment   = NSTextAlignmentCenter;
    dumpCostValueLbl.textAlignment    = NSTextAlignmentCenter;
    stockLossValueLbl.textAlignment   = NSTextAlignmentCenter;
    lossCostValueLbl.textAlignment    = NSTextAlignmentCenter;
    closeStockValueLbl.textAlignment  = NSTextAlignmentCenter;

    openStockValueLbl.text   = @"0.00";
    saleQtyValueLbl.text     = @"0.00";
    bookStockValueLbl.text   = @"0.00";
    declaredQtyValueLbl.text = @"0.00";
    stockDumpValueLbl.text   = @"0.00";
    dumpCostValueLbl.text    = @"0.00";
    stockLossValueLbl.text   = @"0.00";
    lossCostValueLbl.text    = @"0.00";
    closeStockValueLbl.text  = @"0.00";
    
    
    pagenationTxt = [[CustomTextField alloc] init];
    pagenationTxt.userInteractionEnabled = NO;
    pagenationTxt.textAlignment = NSTextAlignmentCenter;
    pagenationTxt.delegate = self;
    [pagenationTxt awakeFromNib];
    
    UIButton * dropDownBtn;
    UIButton * goButton;
    
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:categoryImg forState:UIControlStateNormal];
    [dropDownBtn addTarget:self
                    action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    
    //creating the UIButton which are used to show CustomerInfo popUp.......
    
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];

    @try {
        
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        headerNameLbl.text =   NSLocalizedString(@"stock_verification", nil);
        
         [startVerificationBtn setTitle:NSLocalizedString(@"start_verification", nil) forState:UIControlStateNormal];
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];

        snoLbl.text = NSLocalizedString(@"S_NO",nil);
        dateLbl.text = NSLocalizedString(@"Date",nil);
        outletIdLbl.text = NSLocalizedString(@"outlet_id",nil);

        openStockLbl.text = NSLocalizedString(@"open_stock",nil);
        saleQtyLbl.text = NSLocalizedString(@"sale_qty",nil);
        bookStockLbl.text = NSLocalizedString(@"book_stock",nil);

        declaredStockLbl.text = NSLocalizedString(@"declared_stock",nil);
        stockDumpLbl.text = NSLocalizedString(@"stock_dump",nil);
        dumpCostLbl.text = NSLocalizedString(@"dump_cost",nil);
        stockLossLbl.text = NSLocalizedString(@"stock_loss",nil);
        lossCostLbl.text = NSLocalizedString(@"loss_cost",nil);
        closeStockLbl.text = NSLocalizedString(@"close_Stock",nil);
        statusLbl.text = NSLocalizedString(@"status",nil);
        actionLbl.text = NSLocalizedString(@"Action",nil);
        
        //gridLevel Labels Text....
        
        itemNoLbl.text = NSLocalizedString(@"S_NO", nil);
        categoryLbl.text = NSLocalizedString(@"category", nil);
        itemSaleQtyLbl.text = NSLocalizedString(@"sale_qty", nil);
        itemSaleLbl.text = NSLocalizedString(@"sale_val", nil);

        openStock.text = NSLocalizedString(@"open_stock", nil);
        dumpLbl.text = NSLocalizedString(@"dump_qty",nil);
        dumpVal.text = NSLocalizedString(@"dump_Val",nil);
        dumpPercentLbl.text = NSLocalizedString(@"dump_%", nil);
        itemlevelStockLossLbl.text  = NSLocalizedString(@"stock_loss",nil);
        itemLevelLossCostLbl.text  = NSLocalizedString(@"loss_cost",nil);

        lossLbl.text = NSLocalizedString(@"loss_%", nil);
   
        totalLabel.text = NSLocalizedString(@"total",nil);
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
    }
    @catch (NSException *exception) {
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
            
        }
        self.view.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        stockVerificationView.frame = CGRectMake(2,70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        headerNameLbl.frame = CGRectMake(0,0, stockVerificationView.frame.size.width, 45);
        
        //setting below labe's frame.......
        float textFieldWidth =  180;
        float textFieldHeight = 40;
        float horizontal_Gap = 20;
        float vertical_Gap = 10;
        
        zoneTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+10,textFieldWidth,textFieldHeight);
        
        categoryTxt.frame = CGRectMake(zoneTxt.frame.origin.x+zoneTxt.frame.size.width+horizontal_Gap, zoneTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        startDteTxt.frame = CGRectMake(categoryTxt.frame.origin.x+categoryTxt.frame.size.width+horizontal_Gap, zoneTxt.frame.origin.y, textFieldWidth, textFieldHeight);

        //        second column
        
        outletIDTxt.frame =CGRectMake( zoneTxt.frame.origin.x, zoneTxt.frame.origin.y+zoneTxt.frame.size.height+vertical_Gap, textFieldWidth, textFieldHeight);

        subCategoryTxt.frame =CGRectMake( categoryTxt.frame.origin.x,outletIDTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        endDateTxt.frame =CGRectMake(startDteTxt.frame.origin.x,outletIDTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        userNameLbl.frame =CGRectMake(startDteTxt.frame.origin.x + startDteTxt.frame.size.width+horizontal_Gap, categoryTxt.frame.origin.y, 180, 40);
        
        //frame for the workFlowText which is used under hubUser...
        
        statusTxt.frame = CGRectMake(userNameLbl.frame.origin.x,endDateTxt.frame.origin.y,userNameLbl.frame.size.width,userNameLbl.frame.size.height);

        //Frames for the UIButtons...
        locationBtn.frame = CGRectMake((outletIDTxt.frame.origin.x+outletIDTxt.frame.size.width-45), outletIDTxt.frame.origin.y-8,55,60);
        
        categoryBtn.frame = CGRectMake((categoryTxt.frame.origin.x+categoryTxt.frame.size.width-45), categoryTxt.frame.origin.y-8, 55, 60);
        
        subCategoryBtn.frame = CGRectMake((subCategoryTxt.frame.origin.x+subCategoryTxt.frame.size.width-45), subCategoryTxt.frame.origin.y-8, 55, 60);
        
        startDteBtn.frame = CGRectMake((startDteTxt.frame.origin.x+startDteTxt.frame.size.width-40), startDteTxt.frame.origin.y+4, 35, 30);
        
        endDateBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-40), endDateTxt.frame.origin.y+4, 35, 30);
        
        workFlowBtn.frame = CGRectMake((statusTxt.frame.origin.x+statusTxt.frame.size.width-45),statusTxt.frame.origin.y-8,55,60);

        
        //setting for fifth column row....
        
        searchBtn.frame = CGRectMake(stockVerificationView.frame.size.width-165,categoryTxt.frame.origin.y,160,40);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x,subCategoryTxt.frame.origin.y, searchBtn.frame.size.width,searchBtn.frame.size.height);
        
        startVerificationBtn.frame = CGRectMake(stockVerificationView.frame.size.width-205, endDateTxt.frame.origin.y+endDateTxt.frame.size.height+vertical_Gap, 200,40);
        
        stockVerificationScrollView.frame = CGRectMake(0, startVerificationBtn.frame.origin.y + startVerificationBtn.frame.size.height + 10,stockVerificationView.frame.size.width,430);
        
        snoLbl.frame = CGRectMake(5, 0,40,35);
        
        dateLbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width+2,snoLbl.frame.origin.y,90, 40);
        
        outletIdLbl.frame = CGRectMake(dateLbl.frame.origin.x+dateLbl.frame.size.width+2,snoLbl.frame.origin.y,85,40);

        openStockLbl.frame = CGRectMake(outletIdLbl.frame.origin.x+outletIdLbl.frame.size.width+2,snoLbl.frame.origin.y,  90, 40);
        
        saleQtyLbl.frame = CGRectMake(openStockLbl.frame.origin.x+openStockLbl.frame.size.width+2,snoLbl.frame.origin.y,70,40);
        
        bookStockLbl.frame = CGRectMake(saleQtyLbl.frame.origin.x+saleQtyLbl.frame.size.width+2,snoLbl.frame.origin.y,90,40);
        
        declaredStockLbl.frame = CGRectMake(bookStockLbl.frame.origin.x+bookStockLbl.frame.size.width+2,snoLbl.frame.origin.y,90,40);
        
        stockDumpLbl.frame = CGRectMake(declaredStockLbl.frame.origin.x+declaredStockLbl.frame.size.width+2,snoLbl.frame.origin.y,90,40);
        
        dumpCostLbl.frame = CGRectMake(stockDumpLbl.frame.origin.x+stockDumpLbl.frame.size.width+2,snoLbl.frame.origin.y,95,40);
        
        stockLossLbl.frame = CGRectMake(dumpCostLbl.frame.origin.x+dumpCostLbl.frame.size.width+2,snoLbl.frame.origin.y,80,40);
        
        lossCostLbl.frame = CGRectMake(stockLossLbl.frame.origin.x+stockLossLbl.frame.size.width+2,snoLbl.frame.origin.y,80, 40);
        
        closeStockLbl.frame = CGRectMake(lossCostLbl.frame.origin.x+lossCostLbl.frame.size.width+2,snoLbl.frame.origin.y,90,40);
        
        statusLbl.frame = CGRectMake(closeStockLbl.frame.origin.x+closeStockLbl.frame.size.width+2,snoLbl.frame.origin.y,90,40);
        
        actionLbl.frame = CGRectMake(statusLbl.frame.origin.x+statusLbl.frame.size.width+2,snoLbl.frame.origin.y,80,40);
        
        //searchItemsTxt.frame.origin.x + searchItemsTxt.frame.size.width - (requestStatusLbl.frame.origin.x + requestStatusLbl.frame.size.width + 2)
        
        stockVerificationTbl.frame = CGRectMake(0,snoLbl.frame.origin.y + snoLbl.frame.size.height,stockVerificationScrollView.frame.size.width+1100,stockVerificationScrollView.frame.size.height-(snoLbl.frame.origin.y+snoLbl.frame.size.height));
        
        stockVerificationScrollView.contentSize = CGSizeMake(stockVerificationScrollView.frame.origin.x+ stockVerificationScrollView.frame.size.width+175,  stockVerificationScrollView.frame.size.height);

        //Grid  Level Labels Frame:
       
        requestedItemsTblHeaderView.frame = CGRectMake(0,10,actionLbl.frame.origin.x+actionLbl.frame.size.width-(snoLbl.frame.origin.x),snoLbl.frame.size.height);
        
        itemNoLbl.frame = CGRectMake(dateLbl.frame.origin.x,0,50,30);
        
        categoryLbl.frame = CGRectMake(itemNoLbl.frame.origin.x + itemNoLbl.frame.size.width + 2, 0, 110, itemNoLbl.frame.size.height);
        
        openStock.frame = CGRectMake(categoryLbl.frame.origin.x + categoryLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);
        
        itemSaleQtyLbl.frame = CGRectMake(openStock.frame.origin.x + openStock.frame.size.width + 2, 0,90, itemNoLbl.frame.size.height);
        
        itemSaleLbl.frame = CGRectMake(itemSaleQtyLbl.frame.origin.x + itemSaleQtyLbl.frame.size.width + 2, 0, 90, itemNoLbl.frame.size.height);
        
        dumpLbl.frame = CGRectMake(itemSaleLbl.frame.origin.x + itemSaleLbl.frame.size.width + 2, 0, 80, itemNoLbl.frame.size.height);
        
        dumpVal.frame = CGRectMake(dumpLbl.frame.origin.x+dumpLbl.frame.size.width + 2, 0, 80, itemNoLbl.frame.size.height);
        
        dumpPercentLbl.frame = CGRectMake(dumpVal.frame.origin.x +dumpVal.frame.size.width+2,0,90,itemNoLbl.frame.size.height);
        
        itemlevelStockLossLbl.frame = CGRectMake(dumpPercentLbl.frame.origin.x +dumpPercentLbl.frame.size.width+2,0,90,itemNoLbl.frame.size.height);
      
        itemLevelLossCostLbl.frame = CGRectMake(itemlevelStockLossLbl.frame.origin.x +itemlevelStockLossLbl.frame.size.width+2,0,90,itemNoLbl.frame.size.height);

        lossLbl.frame = CGRectMake(itemLevelLossCostLbl.frame.origin.x+itemLevelLossCostLbl.frame.size.width+2,0,80,itemNoLbl.frame.size.height);

        // frames for the totalValues in stockVerificationView
        
        
        totalLabel.frame = CGRectMake(outletIdLbl.frame.origin.x+20,stockVerificationScrollView.frame.origin.y+stockVerificationScrollView.frame.size.height+10,outletIdLbl.frame.size.width-20,40);
        totalLabel.hidden = YES;

        pagenationTxt.frame = CGRectMake(zoneTxt.frame.origin.x,totalLabel.frame.origin.y,90,40);
        
        dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width-45), pagenationTxt.frame.origin.y-5, 45, 50);
        
        goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width+15,pagenationTxt.frame.origin.y,70, 40);

        
        openStockValueLbl.frame = CGRectMake(openStockLbl.frame.origin.x,totalLabel.frame.origin.y,openStockLbl.frame.size.width,totalLabel.frame.size.height);
        
        saleQtyValueLbl.frame = CGRectMake(saleQtyLbl.frame.origin.x,totalLabel.frame.origin.y,saleQtyLbl.frame.size.width,totalLabel.frame.size.height);
       
        bookStockValueLbl.frame = CGRectMake(bookStockLbl.frame.origin.x,totalLabel.frame.origin.y,bookStockLbl.frame.size.width,totalLabel.frame.size.height);
        
        declaredQtyValueLbl.frame = CGRectMake(declaredStockLbl.frame.origin.x,totalLabel.frame.origin.y,declaredStockLbl.frame.size.width,totalLabel.frame.size.height);
        
        stockDumpValueLbl.frame = CGRectMake(stockDumpLbl.frame.origin.x,totalLabel.frame.origin.y,stockDumpLbl.frame.size.width,totalLabel.frame.size.height);

        dumpCostValueLbl.frame = CGRectMake(dumpCostLbl.frame.origin.x,totalLabel.frame.origin.y,dumpCostLbl.frame.size.width,totalLabel.frame.size.height);
        
        stockLossValueLbl.frame = CGRectMake(stockLossLbl.frame.origin.x,totalLabel.frame.origin.y,stockLossLbl.frame.size.width,totalLabel.frame.size.height);

        lossCostValueLbl.frame = CGRectMake(lossCostLbl.frame.origin.x,totalLabel.frame.origin.y,lossCostLbl.frame.size.width,totalLabel.frame.size.height);

        closeStockValueLbl.frame = CGRectMake(closeStockLbl.frame.origin.x,totalLabel.frame.origin.y,closeStockLbl.frame.size.width,totalLabel.frame.size.height);

    }
    
    else{
        
        //CODE FOR IPHONE
    }
    
    
    [stockVerificationView addSubview:headerNameLbl];
    [stockVerificationView addSubview:zoneTxt];
    [stockVerificationView addSubview:categoryTxt];
    [stockVerificationView addSubview:categoryBtn];
    
    [stockVerificationView addSubview:startDteTxt];
    [stockVerificationView addSubview:startDteBtn];
    [stockVerificationView addSubview:outletIDTxt];
    [stockVerificationView addSubview:statusTxt];
    [stockVerificationView addSubview:workFlowBtn];
    
    [stockVerificationView addSubview:subCategoryTxt];
    [stockVerificationView addSubview:subCategoryBtn];
    
    [stockVerificationView addSubview:endDateTxt];
    [stockVerificationView addSubview:endDateBtn];
    [stockVerificationView addSubview:userNameLbl];
    
    [stockVerificationView addSubview:searchBtn];
    [stockVerificationView addSubview:clearBtn];
    
    [stockVerificationView addSubview:startVerificationBtn];
    
    [stockVerificationView addSubview:stockVerificationScrollView];
    
    [stockVerificationScrollView addSubview:snoLbl];
    [stockVerificationScrollView addSubview:dateLbl];
    [stockVerificationScrollView addSubview:outletIdLbl];

    [stockVerificationScrollView addSubview:openStockLbl];
    [stockVerificationScrollView addSubview:saleQtyLbl];
    [stockVerificationScrollView addSubview:bookStockLbl];

    [stockVerificationScrollView addSubview:declaredStockLbl];
    [stockVerificationScrollView addSubview:stockDumpLbl];
    [stockVerificationScrollView addSubview:dumpCostLbl];
    [stockVerificationScrollView addSubview:stockLossLbl];
    [stockVerificationScrollView addSubview:lossCostLbl];
    [stockVerificationScrollView addSubview:closeStockLbl];
    [stockVerificationScrollView addSubview:statusLbl];
    [stockVerificationScrollView addSubview:actionLbl];
    
    [stockVerificationScrollView addSubview:stockVerificationTbl];

    [requestedItemsTblHeaderView addSubview:itemNoLbl];
    [requestedItemsTblHeaderView addSubview:categoryLbl];
    [requestedItemsTblHeaderView addSubview:itemSaleQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemSaleLbl];
    [requestedItemsTblHeaderView addSubview:openStock];
    [requestedItemsTblHeaderView addSubview:dumpLbl];
    [requestedItemsTblHeaderView addSubview:dumpVal];
    [requestedItemsTblHeaderView addSubview:dumpPercentLbl];
    [requestedItemsTblHeaderView addSubview:itemlevelStockLossLbl];
    [requestedItemsTblHeaderView addSubview:itemLevelLossCostLbl];
    [requestedItemsTblHeaderView addSubview:lossLbl];

    //Adding Total Value subViews as a sub view for stockVerificationView...
   
    [stockVerificationView addSubview:totalLabel];
    
    [stockVerificationView addSubview:openStockValueLbl];
    [stockVerificationView addSubview:saleQtyValueLbl];
    [stockVerificationView addSubview:bookStockValueLbl];
    [stockVerificationView addSubview:declaredQtyValueLbl];
    [stockVerificationView addSubview:stockDumpValueLbl];
    [stockVerificationView addSubview:dumpCostValueLbl];
    [stockVerificationView addSubview:stockLossValueLbl];
    [stockVerificationView addSubview:lossCostValueLbl];
    [stockVerificationView addSubview:closeStockValueLbl];

    [stockVerificationView addSubview:pagenationTxt];
    [stockVerificationView addSubview:dropDownBtn];
    [stockVerificationView addSubview:goButton];
    
    [self.view addSubview:stockVerificationView];

    
    //here we are setting font to all subview to mainView.....
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:requestedItemsTblHeaderView andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
        
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        startVerificationBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
    } @catch (NSException * exception) {
        NSLog(@"---- exception while setting the fontSize to subViews ----%@",exception);
    }
   
    
    
    if (isHubLevel) {
        
        zoneTxt.text  = zoneID;
        [stockVerificationView addSubview:locationBtn];
    }
    else
        
    zoneTxt.text  = zone;
    outletIDTxt.text = presentLocation;
    
    
    startDteBtn.tag = 2;
    endDateBtn.tag = 4;
    
    searchBtn.tag = 2;

    
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
    [HUD setHidden:NO];
    
    @try {
        verificationIndex = 0;
        stockVerificationArr = [NSMutableArray new];

        [self callingProductVerification];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * @description  here we are calling getCategories.......
 * @date         30/05/2017
 * @method       getCategories
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingCategoriesList:(NSString *)categoryName{
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(categoriesTbl.tag == 2 )
            categoriesArr= [NSMutableArray new];
        else
            subCategoryArr = [NSMutableArray new];
        
        // Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSMutableDictionary * categoriesDic = [[NSMutableDictionary alloc]init];
        
        [categoriesDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [categoriesDic setValue:NEGATIVE_ONE forKey:START_INDEX];
        [categoriesDic setValue:[NSNumber numberWithBool:true] forKey:SL_NO];
        [categoriesDic setValue:categoryName forKey:@"categoryName"];
        [categoriesDic setValue:EMPTY_STRING forKey:@"flag"];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:categoriesDic options:0 error:&err];
        NSString * categoriesJSonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getProductCategory:categoriesJSonStr];
        
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling CategoriesList ServicesCall ----%@",exception);
        
    }
    @finally {
        
    }
}

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

-(void)callingProductVerification {
    
    @try {
        
        [HUD setHidden: NO];
        
        if (stockVerificationArr == nil && verificationIndex == 0) {
            
            totalRecords = 0;
            
            stockVerificationArr = [NSMutableArray new];
        }
        
        else if (stockVerificationArr.count)      {
            
            [stockVerificationArr removeAllObjects];
        }
        
        //first Column..
        NSString * locationStr = @"";
        
        //Second Column..
        NSString * categoryStr = @"";
        NSString * subCategoryStr = @"";
        
        //Third Column..

        NSString * startDteStr = @"";
        NSString * endDateStr = @"";

        //Fourth Column..
        NSString * statusStr = @"";
        
        if(searchBtn.tag == 4) {
            
            locationStr    = outletIDTxt.text;
            categoryStr    = categoryTxt.text;
            subCategoryStr = subCategoryTxt.text;
            statusStr      = statusTxt.text;
        }

        if (locationTable.tag == 0  || (outletIDTxt.text).length == 0)
            
            locationStr = @"";
        
        if (categoriesTbl.tag == 0 || (categoryTxt.text).length == 0 )
            categoryStr = @"";
        
        if (subCategorytbl.tag == 0 || (subCategoryTxt.text).length == 0)
            subCategoryStr = @"";
        
        if((startDteTxt.text).length >0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDteTxt.text,@" 00:00:00"];
        
        if((endDateTxt.text).length > 0)
            endDateStr =  [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        
        if (workFlowListTbl.tag == 0  || (statusTxt.text).length == 0)
            
            statusStr = @"";
        
        NSMutableDictionary * productVerificationDic = [[NSMutableDictionary alloc]init];
        
        productVerificationDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        productVerificationDic[START_INDEX] = [NSString stringWithFormat:@"%d",verificationIndex];
        

        productVerificationDic[kStartDate] = startDteStr;
        productVerificationDic[END_DATE] = endDateStr;
        productVerificationDic[kcategory] = categoryStr;
        productVerificationDic[kSubCategoryName] = subCategoryStr;
        productVerificationDic[kRequiredRecords] = @"10";

        if (!isHubLevel) {
            
            productVerificationDic[LOCATION] = presentLocation;
        }
        else
            productVerificationDic[LOCATION] = locationStr;
        productVerificationDic[STATUS] = statusStr;
        
        productVerificationDic[kVerificationUnderMasterCode] = [NSNumber numberWithBool:false];

        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:productVerificationDic options:0 error:&err];
        NSString * getProductStockVerificationString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductStockVerificationString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.storeStockVerificationDelegate = self;
//        [webServiceController getProductVerification:getProductStockVerificationString]; // commented by roja on 17/10/2019... // AT the time of converting soap to rest services.
        
        [webServiceController getProductVerificationRestFullService:getProductStockVerificationString]; // added by roja on 17/10/2019..

        
    }
    @catch (NSException * exception) {
       
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
    }
}


/**
 * @description  we are getting master verification code from the verification details...
 * @date         2/05/2017...
 * @method       getVerificationDetails
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)stockVerificationMasterChilds {
    @try {
        
            [HUD setHidden:NO];
        
            if (verificationMasterChildListArr == nil) {
                verificationMasterChildListArr = [NSMutableArray new];
            }
            else if(verificationMasterChildListArr.count ){
                
                [verificationMasterChildListArr removeAllObjects];
            }
            
            NSMutableDictionary * masterDetails = [[NSMutableDictionary alloc] init];
            
            masterDetails[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            masterDetails[START_INDEX] = NEGATIVE_ONE;
            masterDetails[kLocation] = presentLocation;
            masterDetails[kVerificationUnderMasterCode] = [NSNumber numberWithBool:false];
            
            NSError  * err;
            NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:masterDetails options:0 error:&err];
            NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.stockVerificationDelegate = self;
            [webServiceController getStockVerificationMasterChildDetails:quoteRequestJsonString];
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
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

        
    } @finally {
        
    }
}

/**
 * @description  we are using this method to get workflows in.....
 * @date         03/08/2017
 * @method       GetWorkFlows
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getWorkFlows{
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        workFlowsArr = [NSMutableArray new];
        
        
        NSMutableDictionary * workFlowDic = [[NSMutableDictionary alloc]init];
        
        [workFlowDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [workFlowDic setValue:@"Store Stock Verification" forKey:BUSINESSFLOW];
        [workFlowDic setValue:presentLocation forKey:STORE_LOCATION];
        [workFlowDic setValue:@"-1" forKey:START_INDEX];

        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:workFlowDic options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"--%@",quoteRequestJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.rolesServiceDelegate = self;
        [webServiceController getWorkFlows:quoteRequestJsonString];

        
    } @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
        

    } @finally {
        
        
    }
}

#pragma mark Handling Service call Response:

/**
 * @description  here we are Handling the getCategories SuccessResponse...
 * @date         30/05/2017
 * @method       getCategorySuccessResponse
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getCategorySuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        
        if(categoriesTbl.tag == 2)
            [categoriesArr addObject:NSLocalizedString(@"all_categories",nil)];
        else
            [subCategoryArr addObject:NSLocalizedString(@"all_subcategories",nil)];
        
        for (NSDictionary * categoryDic in  [sucessDictionary valueForKey:@"categories"]){
            
            if(categoriesTbl.tag == 2) {
                
                
                [categoriesArr addObject:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:@"categoryName"]  defaultReturn:@""]];
            }
            else {
                
                if([categoryTxt.text isEqualToString:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:@"categoryName"]  defaultReturn:@""]] ){
                    
                    if([categoryDic.allKeys containsObject:@"subCategories"] && (![[categoryDic valueForKey:@"subCategories"] isKindOfClass: [NSNull class]]))
                        
                        for (NSDictionary * subCatDic in  [categoryDic valueForKey:@"subCategories"]){
                            
                            [subCategoryArr addObject:[self checkGivenValueIsNullOrNil:[subCatDic valueForKey:@"subcategoryName"]  defaultReturn:@""]];
                        }
                    
                    break;
                }
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden: YES];
    }
}

/**
 * @description  here we are Handling the getCategories ErrorResponse...
 * @date         30/05/2017
 * @method       getCategorySuccessResponse
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getCategoryErrorResponse:(NSString*)error {
    
    @try {
        [HUD setHidden:YES];
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


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
        
        totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"]intValue];
        
        float openStockval     = 0;
        float saleQtyVal       = 0;
        float bookStockVal     = 0;
        float declaredStockval = 0;
        float stockDumpVal     = 0;
        float dumpCostVal      = 0;
        float stockLossVal     = 0;
        float lossCostval      = 0;
        float closeStockVal    = 0;
        
        
        for (NSDictionary * verificationDic in [successDictionary valueForKey:VERIFIACTION_LIST]) {
            
            [stockVerificationArr addObject:verificationDic];
            
            //for (NSDictionary * itemDic in [verificationDic valueForKey:ITEMS_LIST]) {
            
                openStockval      += [[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue];
                
                saleQtyVal        +=[[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:SALE_QTY] defaultReturn:@"0.00"] floatValue];
            
                bookStockVal      +=[[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:BOOK_QTY] defaultReturn:@"0.00"] floatValue];
            
                declaredStockval  +=[[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:DECLARED_QTY] defaultReturn:@"0.00"] floatValue];
                
                stockDumpVal      +=[[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:DUMP_QTY] defaultReturn:@"0.00"] floatValue];
                
                dumpCostVal       += [[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:DUMP_COST] defaultReturn:@"0.00"] floatValue];
                
                stockLossVal      +=[[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.00"] floatValue];
                
                //for temporary we are binding this key... kStock_loss
                lossCostval       +=[[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:STOCK_COST] defaultReturn:@"0.00"] floatValue];
                
                closeStockVal     +=[[self checkGivenValueIsNullOrNil:[verificationDic valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue];
            
                //NSLog(@"%f----Totalval",openStockval);
                
//}
        }
        openStockValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",   openStockval];
        saleQtyValueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@"",     saleQtyVal];
        bookStockValueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@"", bookStockVal];
        
        declaredQtyValueLbl.text= [NSString stringWithFormat:@"%@%.2f",@"",declaredStockval];
        stockDumpValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",   stockDumpVal];
        dumpCostValueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@"",    dumpCostVal];
        stockLossValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",   stockLossVal];
        lossCostValueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@"",    lossCostval];
        closeStockValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",  closeStockVal];
        
        //Recently Added By Bhargav.v on 17/10/2017..
        //Reason: To Display the Records in pagination mode based on the Total Records..
        
        int strTotalRecords = totalRecords/10;
        
        int remainder = totalRecords % 10;
        
        
        if(remainder == 0)
        {
            strTotalRecords = strTotalRecords;
        }
        else
        {
            strTotalRecords = strTotalRecords + 1;
        }
        
        pagenationArr = [NSMutableArray new];
        
        if(strTotalRecords < 1){
            
            [pagenationArr addObject:@"1"];
        }
        else{
            
            for(int i = 1;i<= strTotalRecords;i++){
                
                [pagenationArr addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        //Up to here on 16/10/2017...
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
        if(verificationIndex == 0){
            pagenationTxt.text = @"1";
        }
        
        [HUD setHidden:YES];
        [stockVerificationTbl reloadData];
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
        
        [stockVerificationArr removeAllObjects];
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        openStockValueLbl.text   = @"0.0";
        saleQtyValueLbl.text     = @"0.0";
        bookStockValueLbl.text   = @"0.0";
        declaredQtyValueLbl.text = @"0.0";
        stockDumpValueLbl.text   = @"0.0";
        dumpCostValueLbl.text    = @"0.0";
        stockLossValueLbl.text   = @"0.0";
        lossCostValueLbl.text    = @"0.0";
        closeStockValueLbl.text  = @"0.0";
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [stockVerificationTbl reloadData];
    }
}


/**
 * @description  here we are handling the resposne received from services...
 * @date         02/06/2017
 * @method       getStockVerificationMasterDetailsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getStockVerificationMasterChildSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        for(NSDictionary * VerificationCodeDic in [successDictionary valueForKey:VERIFICATION_MASTER_CHILDLIST]){
            
//            verificationRef
            
            [verificationMasterChildListArr addObject:VerificationCodeDic];
        }
        
        @try {
            [self startVerification:nil];
        }
        @catch (NSException *exception) {
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
        
    }
}


/**
 * @description  here we are handling the resposne received from services...
 * @date         02/06/2017
 * @method       getStockVerificationMasterDetailsErrorResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getStockVerificationMasterChildsErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        // commeted by roja on 25/05/2019..
        // Reason static msg no need
//        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_master_verification_code_is_available", nil)];
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException * exception) {
        NSLog(@"--%@",exception );
        
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
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
}



/**
 * @description  we are storing the workFlow States from the successResponse...
 * @date         03/08/2017
 * @method       getWorkFlowsSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getWorkFlowsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [workFlowsArr addObject:NSLocalizedString(@"select_status",nil)];
        
        for (NSDictionary * statusDictionary  in [[successDictionary valueForKey:WORKFLOW_LIST]valueForKey:STATUS_NAME]) {
            
            [workFlowsArr addObject:statusDictionary];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden: YES];
    }
}


/**
 * @description  we are Showing the Error Response...
 * @date         03/08/2017
 * @method       gerWorkFlowsErrorResponse
 * @author       Bhargav.v
 * @param        NSString.
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)gerWorkFlowsErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException * exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
}

#pragma -mark action used in this page to show the popups....

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
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        float tableHeight = locationArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationArr.count * 33;
        
        if(locationArr.count>5)
            tableHeight = (tableHeight/locationArr.count) * 5;
        
        [self showPopUpForTables:locationTable  popUpWidth:(outletIDTxt.frame.size.width* 1.5) popUpHeight:tableHeight presentPopUpAt:outletIDTxt  showViewIn:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException *exception){
        
    } @finally {
        
    }
}


/**
 * @description  Displaying the all availiable Categories.......
 * @date         30/05/2017
 * @method       showCategoriesList
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)showCategoriesList:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((categoriesArr == nil) || (categoriesArr.count == 0)){
            
            [HUD setHidden:NO];
            
            //for identification....
            categoriesTbl.tag = 2;
            subCategorytbl.tag = 4;
            
            //soap service call....
            [self callingCategoriesList:@""];
        }
        
        [HUD setHidden:YES];
        
        
        if(categoriesArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = categoriesArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            
            tableHeight = categoriesArr.count * 33;
        
        if(categoriesArr.count > 5)
            tableHeight =(tableHeight/categoriesArr.count) * 5;
        
        [self showPopUpForTables:categoriesTbl  popUpWidth:(categoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Displaying the all availiable SubCategories based on category selection .......
 * @date         30/05/2017
 * @method       showSubCategoriesList
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)showAllSubCategoriesList:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(!(categoryTxt.text).length){
            
            float y_axis = self.view.frame.size.height - 120;
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_category_first",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        
        if((subCategoryArr == nil) || (subCategoryArr.count == 0)){
            
            //for identification....
            categoriesTbl.tag = 4;
            subCategorytbl.tag = 2;
            [self callingCategoriesList:categoryTxt.text];
        }
        
        [HUD setHidden:YES];
        
        if(subCategoryArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        float tableHeight = subCategoryArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoryArr.count * 33;
        
        if(subCategoryArr.count > 5)
            tableHeight = (tableHeight/subCategoryArr.count)*5;
        
        [self showPopUpForTables:subCategorytbl  popUpWidth:(subCategoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
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

-(void)showWorkFlowStatus:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [self getWorkFlows];
        
        [HUD setHidden:YES];
        
        if(workFlowsArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        float tableHeight = workFlowsArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = workFlowsArr.count * 33;
        
        if(workFlowsArr.count> 5)
            tableHeight = (tableHeight/workFlowsArr.count) * 5;
        
        [self showPopUpForTables:workFlowListTbl  popUpWidth:(statusTxt.frame.size.width* 1.5) popUpHeight:tableHeight presentPopUpAt:statusTxt  showViewIn:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
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

-(void)showPaginationData:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [HUD setHidden:YES];
        
        if(pagenationArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        float tableHeight = pagenationArr.count *40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArr.count * 33;
        
        if(pagenationArr.count> 5)
            tableHeight = (tableHeight/pagenationArr.count) * 5;
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:stockVerificationView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are making the service call to get the  Records based on pagenation...
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
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        [self callingProductVerification];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
    }
}


#pragma -mark action used to display calender in popUP....

/**
 * @description  here we are showing the calender in popUp view....
 * @date         26/09/2016
 * @method       showCalenderInPopUp:
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


/*
 * @description  clear the date from textField and calling services.......
 * @date         01/03/2017
 * @method       clearDate:
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)clearDate:(UIButton *)sender{
    
    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        if(sender.tag == 2){
            if((startDteTxt.text).length)
                callServices = true;
            
            startDteTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                callServices = true;
            
            endDateTxt.text = @"";
        }
        
        if(callServices){
            [HUD setHidden:NO];
            
            stockVerificationArr = [NSMutableArray new];
            
            [self callingProductVerification];
        }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}

/*
 * @description  populating the date in textfield.......
 * @date         01/03/2017
 * @method       populateDateToTextField:
 * @author       Bhargav
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
        
        //[requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate *existingDateString;
        /*z;
         UITextField * endDateTxt;*/
        
        if(sender.tag == 2){
            if ((startDteTxt.text).length != 0 && ( ![startDteTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDteTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDteTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start Date should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    return;
                }
            }
            startDteTxt.text = dateString;
        }
        else {
            
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDateTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"End date should not be earlier than start date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

/*
 * @description  We allow the user to navigate to the new stock verification based on the "Master Verification Code".......
 * @date         01/03/2017
 * @method       startVerification:
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)startVerification:(UIButton*)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if (verificationMasterChildListArr == nil || verificationMasterChildListArr.count == 0) {
            [self stockVerificationMasterChilds];
        }
        
        if (verificationMasterChildListArr.count) {
            
            StockverificationViewController * vc = [[StockverificationViewController alloc] init];
            vc.verificationCode = verificationMasterChildListArr[0];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma  mark Actions used in this page to navigate...

/**
 * @description  here we are creating request string for creation of new SupplierQuotation.......
 * @date         31/03/2017
 * @method       searchTheProducts
 * @author       Srinivasulu
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
        
        searchBtn.tag  = 4;
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0 && (startDteTxt.text).length == 0 && (endDateTxt.text).length== 0 && (statusTxt.text).length==0 && (outletIDTxt.text).length == 0) {
            
            float y_axis = self.view.frame.size.height- 200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"Please select above fields before proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        else
            
            [HUD setHidden:NO];
        [self callingProductVerification];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are creating request string for creation of new SupplierQuotation.......
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
        
        searchBtn.tag = 2;
        
        categoryTxt.text    = @"";
        subCategoryTxt.text = @"";
        startDteTxt.text    = @"";
        endDateTxt.text     = @"";
        statusTxt.text      = @"";
        
        if (isHubLevel) {
            
            outletIDTxt.text = @"";
        }
        
        [self callingProductVerification];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}

/*
 * @description  We allow the user to navigate to the edit stock verification based on the "Verification Code"to get details  .......
 * @date         01/03/2017
 * @method       openEditStockVerification:
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)openEditStockVerification:(UIButton*)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        EditStockVerificationController * viewStock = [[EditStockVerificationController alloc] init];
        viewStock.verificationId = [stockVerificationArr[sender.tag] valueForKey:VERIFICATION_CODE];
        [self.navigationController pushViewController:viewStock animated:YES];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
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
    
    if (tableView == stockVerificationTbl) {
        if (stockVerificationArr.count)
            
            return stockVerificationArr.count;
        else
            return 1;
    }
    return 1;
}

/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         10/09/2016
 * @method       tableView: numberOfRowsInSection...
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == stockVerificationTbl){
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                return 1+1;
            }
        }
        return 1;
    }
    
    else if (tableView == itemsListTbl) {
        
        if (itemsListArr.count)
            
            return itemsListArr.count;
        else
            return 1;
    }
    
    if (tableView == categoriesTbl) {
        return categoriesArr.count;
    }
    else if (tableView == subCategorytbl) {
        return subCategoryArr.count;
    }
    
    else if (tableView == locationTable) {
        return locationArr.count;
    }
    else if (tableView == workFlowListTbl) {
        return workFlowsArr.count;
    }
    else if (tableView == pagenationTbl) {
        return pagenationArr.count;
    }
    return 0;
}


/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         30/05/2017
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @return
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if(tableView == stockVerificationTbl){
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (indexPath.row == 0) {
                    return 38;
                }
                else {
                    if (itemsListArr.count > 4 ) {
                        return (40 * 4) + 30;
                    }
                    
                    return (itemsListArr.count * 40) + 70;
                }
            }
            else{
                if (indexPath.row == 0) {
                    return 30;
                }
                else{
                    if (itemsListArr.count > 4 ) {
                        return 30 * 4;
                    }
                    return itemsListArr.count * 30;
                }
            }
        }
        else if (tableView == itemsListTbl || tableView == categoriesTbl || tableView == subCategorytbl || tableView == locationTable || tableView == workFlowListTbl || tableView == pagenationTbl ) {
            return 40;
        }
    }
    
    return 0.0;
}



/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         30/05/2017
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 * @return       UITableViewCell
 * @verified By
 * @verified On
 *
 */


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if(tableView == stockVerificationTbl) {
        
        
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!= 0) {
            // if (self.isOpen&&indexPath.row!=0) {
            
            static NSString *cellIdentifier = @"cell1";
            
            UITableViewCell  *hlcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
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
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16];
                
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:10];
            }
            hlcell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            
            
            [hlcell.contentView addSubview:requestedItemsTblHeaderView];
            [hlcell.contentView addSubview:itemsListTbl];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (itemsListArr.count >4) {
                    
                    hlcell.frame = CGRectMake( stockVerificationTbl.frame.origin.x, 0,stockVerificationTbl.frame.size.width,  40 * 4+50);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x, 10,requestedItemsTblHeaderView.frame.size.width,requestedItemsTblHeaderView.frame.size.height);
                    
                    itemsListTbl.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height+5,  requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height - 80);
                    
                }
                else{
                    
                    hlcell.frame = CGRectMake( stockVerificationTbl.frame.origin.x, 0, stockVerificationTbl.frame.size.width,  (40  * (itemsListArr.count + 2)) + 30);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x, 10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    itemsListTbl.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height+5,  requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height-100);
                }
                
            }
            else {
                
                if (itemsListArr.count >4) {
                    hlcell.frame = CGRectMake( 15, 0,stockVerificationTbl.frame.size.width - 15,  30*4);
                    itemsListTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, hlcell.frame.size.height);
                }
                else{
                    hlcell.frame = CGRectMake( 25, 0,stockVerificationTbl.frame.size.width - 25,  itemsListArr.count*30);
                    itemsListTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, itemsListArr.count*30);
                }
            }
            [itemsListTbl reloadData];
            
            hlcell.backgroundColor = [UIColor clearColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        else {
            
            static NSString * hlCellID = @"hlCellID";
            
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
                    
                    layer_1.frame = CGRectMake(snoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(snoLbl.frame.origin.x),1);
                    
                    [hlcell.contentView.layer addSublayer:layer_1];
                    
                } @catch (NSException *exception) {
                    
                }
            }
            tableView.separatorColor = [UIColor clearColor];
            
            
            @try {
                /*UILabels used in this cell*/
                UILabel * s_no_Lbl;
                UILabel * date_Lbl;
                UILabel * outletId_Lbl;
                UILabel * openStock_Lbl;
                UILabel * saleQty_Lbl;
                UILabel * bookStock_Lbl;
                UILabel * declared_stockLbl;
                UILabel * closeStock_Lbl;
                UILabel * stockDump_Lbl;
                UILabel * stockLoss_Lbl;
                UILabel * lossCost_Lbl;
                UILabel * dumpCost_Lbl;
                UILabel * status_Lbl;
                
                /*Creation of UILabels used in this cell*/
                s_no_Lbl = [[UILabel alloc] init];
                s_no_Lbl.backgroundColor = [UIColor clearColor];
                s_no_Lbl.textAlignment = NSTextAlignmentCenter;
                s_no_Lbl.numberOfLines = 1;
                s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                date_Lbl = [[UILabel alloc] init];
                date_Lbl.backgroundColor = [UIColor clearColor];
                date_Lbl.textAlignment = NSTextAlignmentCenter;
                date_Lbl.numberOfLines = 1;
                date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                outletId_Lbl = [[UILabel alloc] init];
                outletId_Lbl.backgroundColor = [UIColor clearColor];
                outletId_Lbl.textAlignment = NSTextAlignmentCenter;
                outletId_Lbl.numberOfLines = 1;
                outletId_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

                openStock_Lbl = [[UILabel alloc] init];
                openStock_Lbl.backgroundColor = [UIColor clearColor];
                openStock_Lbl.textAlignment = NSTextAlignmentCenter;
                openStock_Lbl.numberOfLines = 1;
                openStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                saleQty_Lbl = [[UILabel alloc] init];
                saleQty_Lbl.backgroundColor = [UIColor clearColor];
                saleQty_Lbl.textAlignment = NSTextAlignmentCenter;
                saleQty_Lbl.numberOfLines = 1;
                saleQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                bookStock_Lbl = [[UILabel alloc] init];
                bookStock_Lbl.backgroundColor = [UIColor clearColor];
                bookStock_Lbl.textAlignment = NSTextAlignmentCenter;
                bookStock_Lbl.numberOfLines = 1;
                bookStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

                
                declared_stockLbl = [[UILabel alloc] init];
                declared_stockLbl.backgroundColor = [UIColor clearColor];
                declared_stockLbl.textAlignment = NSTextAlignmentCenter;
                declared_stockLbl.numberOfLines = 1;
                declared_stockLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                stockDump_Lbl = [[UILabel alloc] init];
                stockDump_Lbl.backgroundColor = [UIColor clearColor];
                stockDump_Lbl.textAlignment = NSTextAlignmentCenter;
                stockDump_Lbl.numberOfLines = 1;
                stockDump_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

                dumpCost_Lbl = [[UILabel alloc] init];
                dumpCost_Lbl.backgroundColor = [UIColor clearColor];
                dumpCost_Lbl.textAlignment = NSTextAlignmentCenter;
                dumpCost_Lbl.numberOfLines = 1;
                dumpCost_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                stockLoss_Lbl = [[UILabel alloc] init];
                stockLoss_Lbl.backgroundColor = [UIColor clearColor];
                stockLoss_Lbl.textAlignment = NSTextAlignmentCenter;
                stockLoss_Lbl.numberOfLines = 1;
                stockLoss_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

                
                lossCost_Lbl = [[UILabel alloc] init];
                lossCost_Lbl.backgroundColor = [UIColor clearColor];
                lossCost_Lbl.textAlignment = NSTextAlignmentCenter;
                lossCost_Lbl.numberOfLines = 1;
                lossCost_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                closeStock_Lbl = [[UILabel alloc] init];
                closeStock_Lbl.backgroundColor = [UIColor clearColor];
                closeStock_Lbl.textAlignment = NSTextAlignmentCenter;
                closeStock_Lbl.numberOfLines = 1;
                closeStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                status_Lbl = [[UILabel alloc] init];
                status_Lbl.backgroundColor = [UIColor clearColor];
                status_Lbl.textAlignment = NSTextAlignmentCenter;
                status_Lbl.numberOfLines = 1;
                status_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                /*Creation of UIButton's used in this cell*/
                viewButton = [[UIButton alloc] init];
                //viewButton.backgroundColor = [UIColor blackColor];
                viewButton.titleLabel.textColor = [UIColor whiteColor];
                viewButton.userInteractionEnabled = YES;
                viewButton.tag = indexPath.section;
                [viewButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
                [viewButton addTarget:self action:@selector(openEditStockVerification:) forControlEvents:UIControlEventTouchUpInside];
                
                viewListOfItemsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage * availiableSuppliersListImage;
                
                if(self.isOpen&&self.selectIndex.section == indexPath.section){
                    availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                }
                else{
                    availiableSuppliersListImage = [UIImage imageNamed:@"brown_right_arrow.png"];
                }
                
                [viewListOfItemsBtn setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                viewListOfItemsBtn.userInteractionEnabled = YES;
                viewListOfItemsBtn.tag = indexPath.section;
                viewListOfItemsBtn.hidden = YES;
                [viewListOfItemsBtn addTarget:self action:@selector(showListOfItems:) forControlEvents:UIControlEventTouchUpInside];
                
                s_no_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                outletId_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                openStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                saleQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                bookStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                declared_stockLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                stockDump_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                dumpCost_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                stockLoss_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                lossCost_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                closeStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                status_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

                
                [hlcell.contentView addSubview:s_no_Lbl];
                [hlcell.contentView addSubview:date_Lbl];
                [hlcell.contentView addSubview:outletId_Lbl];
                [hlcell.contentView addSubview:openStock_Lbl];
                [hlcell.contentView addSubview:saleQty_Lbl];
                [hlcell.contentView addSubview:bookStock_Lbl];
                [hlcell.contentView addSubview:declared_stockLbl];
                [hlcell.contentView addSubview:stockDump_Lbl];
                [hlcell.contentView addSubview:dumpCost_Lbl];
                [hlcell.contentView addSubview:stockLoss_Lbl];
                [hlcell.contentView addSubview:lossCost_Lbl];
                [hlcell.contentView addSubview:closeStock_Lbl];
                [hlcell.contentView addSubview:status_Lbl];
                [hlcell.contentView addSubview:viewButton];
                [hlcell.contentView addSubview:viewListOfItemsBtn];
                
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    s_no_Lbl.frame = CGRectMake(snoLbl.frame.origin.x,0,snoLbl.frame.size.width,hlcell.frame.size.height);
                    date_Lbl.frame = CGRectMake(dateLbl.frame.origin.x,0,dateLbl.frame.size.width,hlcell.frame.size.height);
                    
                    openStock_Lbl.frame = CGRectMake(openStockLbl.frame.origin.x,0,openStockLbl.frame.size.width,hlcell.frame.size.height);
                    
                    outletId_Lbl.frame = CGRectMake(outletIdLbl.frame.origin.x,0,outletIdLbl.frame.size.width,hlcell.frame.size.height);

                    saleQty_Lbl.frame = CGRectMake(saleQtyLbl.frame.origin.x,0,saleQtyLbl.frame.size.width,hlcell.frame.size.height);
                    
                    bookStock_Lbl.frame = CGRectMake(bookStockLbl.frame.origin.x,0,bookStockLbl.frame.size.width,hlcell.frame.size.height);

                    declared_stockLbl.frame = CGRectMake(declaredStockLbl.frame.origin.x,0,declaredStockLbl.frame.size.width,hlcell.frame.size.height);
                    
                    stockDump_Lbl.frame = CGRectMake(stockDumpLbl.frame.origin.x,0,stockDumpLbl.frame.size.width,hlcell.frame.size.height);
                    
                    dumpCost_Lbl.frame = CGRectMake(dumpCostLbl.frame.origin.x,0,dumpCostLbl.frame.size.width,hlcell.frame.size.height);

                    stockLoss_Lbl.frame = CGRectMake(stockLossLbl.frame.origin.x,0,stockLossLbl.frame.size.width,hlcell.frame.size.height);
                    
                    lossCost_Lbl.frame = CGRectMake(lossCostLbl.frame.origin.x,0,lossCostLbl.frame.size.width,hlcell.frame.size.height);

                    closeStock_Lbl.frame = CGRectMake(closeStockLbl.frame.origin.x,0,closeStockLbl.frame.size.width,hlcell.frame.size.height);
                    
                    status_Lbl.frame = CGRectMake(statusLbl.frame.origin.x,0,statusLbl.frame.size.width,hlcell.frame.size.height);
                    
                    viewButton.frame = CGRectMake(actionLbl.frame.origin.x+5,0,(actionLbl.frame.size.width),hlcell.frame.size.height);
                    
                    viewListOfItemsBtn.frame = CGRectMake(viewButton.frame.origin.x + viewButton.frame.size.width-5,viewButton.frame.origin.y+8,30,30);
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
                    
                    viewButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

                    
                    @try {
                        [viewButton setTitle:NSLocalizedString(@"Open",nil) forState:UIControlStateNormal];
                        
                        if (stockVerificationArr.count >= indexPath.section && stockVerificationArr.count) {
                            
                            NSDictionary * dic  = stockVerificationArr[indexPath.section];
                            
                            s_no_Lbl.text = [NSString stringWithFormat:@"%ld",(indexPath.section + 1) + verificationIndex];
                            
                            date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:UPDATED_ON_STR] componentsSeparatedByString:@" "][0]  defaultReturn:@"--"];
                            
                            outletId_Lbl.text =    [self checkGivenValueIsNullOrNil:[dic valueForKey:LOCATION] defaultReturn:@"--"];
                            
                            openStock_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:OPEN_STOCK] defaultReturn:@"0.0"]floatValue]];
                            
                            saleQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:SALE_QTY] defaultReturn:@"0.0"] floatValue]];
                            
                            bookStock_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:BOOK_QTY] defaultReturn:@"0.0"] floatValue]];

                            declared_stockLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:DECLARED_QTY] defaultReturn:@"0.0"] floatValue]];
                            
                            stockDump_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:DUMP_QTY] defaultReturn:@"0.0"] floatValue]];
                            
                            dumpCost_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:DUMP_COST] defaultReturn:@"0.0"] floatValue]];
                            
                            stockLoss_Lbl.text =[NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.0"] floatValue]];

                            
                            lossCost_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:STOCK_COST] defaultReturn:@"0.0"] floatValue]];
                            
                            closeStock_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:CLOSED_STOCK] defaultReturn:@"0.0"] floatValue]];
                            status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS] defaultReturn:@"--"];
                        }
                        else {
                            s_no_Lbl.text = @"--";
                            date_Lbl.text = @"--";
                            outletId_Lbl.text = @"--";
                            openStock_Lbl.text = @"--";
                            saleQty_Lbl.text = @"--";
                            bookStock_Lbl.text = @"--";
                            declared_stockLbl.text = @"--";
                            stockDump_Lbl.text = @"--";
                            dumpCost_Lbl.text = @"--";
                            stockLoss_Lbl.text = @"--";
                            lossCost_Lbl.text = @"--";
                            closeStock_Lbl.text = @"--";
                            status_Lbl.text = @"--";
                            [viewButton setTitle:NSLocalizedString(@"--",nil) forState:UIControlStateNormal];
                            viewListOfItemsBtn.hidden = YES;
                        }
                    }
                    @catch (NSException *exception){
                        
                    }
                    @finally {
                        hlcell.backgroundColor = [UIColor clearColor];
                        hlcell.tag = indexPath.section;
                        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return hlcell;
                    }
                }

                else {
                    
                }
            }
            @catch (NSException * exception) {
                
            }
            @finally {
                
            }
        }
    }
    
    else if (tableView == itemsListTbl ) {
        
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
        tableView.separatorColor = [UIColor clearColor];
        
        @try {
            
            UILabel * item_No_Lbl;
            UILabel * category_Lbl;
            UILabel * openStock_Lbl;
            UILabel * saleQty_Lbl;
            UILabel * saleValue_Lbl;
            UILabel * dump_Lbl;
            UILabel * dumpValue_Lbl;
            UILabel * dump_percent_Lbl;
            UILabel * stockLoss_Lbl;
            UILabel * lossCost_Lbl;
            UILabel * loss_Lbl;
            
            item_No_Lbl = [[UILabel alloc] init];
            item_No_Lbl.backgroundColor = [UIColor clearColor];
            item_No_Lbl.textAlignment = NSTextAlignmentCenter;
            item_No_Lbl.numberOfLines = 1;
            item_No_Lbl.layer.borderWidth = 1.5;
            item_No_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_No_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            category_Lbl = [[UILabel alloc] init];
            category_Lbl.backgroundColor = [UIColor clearColor];
            category_Lbl.textAlignment = NSTextAlignmentCenter;
            category_Lbl.numberOfLines = 1;
            category_Lbl.layer.borderWidth = 1.5;
            category_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            category_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            openStock_Lbl = [[UILabel alloc] init];
            openStock_Lbl.backgroundColor = [UIColor clearColor];
            openStock_Lbl.textAlignment = NSTextAlignmentCenter;
            openStock_Lbl.numberOfLines = 1;
            openStock_Lbl.layer.borderWidth = 1.5;
            openStock_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            openStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            
            saleQty_Lbl = [[UILabel alloc] init];
            saleQty_Lbl.backgroundColor = [UIColor clearColor];
            saleQty_Lbl.textAlignment = NSTextAlignmentCenter;
            saleQty_Lbl.numberOfLines = 1;
            saleQty_Lbl.layer.borderWidth = 1.5;
            saleQty_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            saleQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            saleValue_Lbl = [[UILabel alloc] init];
            saleValue_Lbl.backgroundColor = [UIColor clearColor];
            saleValue_Lbl.textAlignment = NSTextAlignmentCenter;
            saleValue_Lbl.numberOfLines = 1;
            saleValue_Lbl.layer.borderWidth = 1.5;
            saleValue_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            saleValue_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            dump_Lbl = [[UILabel alloc] init];
            dump_Lbl.backgroundColor = [UIColor clearColor];
            dump_Lbl.textAlignment = NSTextAlignmentCenter;
            dump_Lbl.numberOfLines = 1;
            dump_Lbl.layer.borderWidth = 1.5;
            dump_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            dump_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            dumpValue_Lbl = [[UILabel alloc] init];
            dumpValue_Lbl.backgroundColor = [UIColor clearColor];
            dumpValue_Lbl.textAlignment = NSTextAlignmentCenter;
            dumpValue_Lbl.numberOfLines = 1;
            dumpValue_Lbl.layer.borderWidth = 1.5;
            dumpValue_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            dumpValue_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            dump_percent_Lbl = [[UILabel alloc] init];
            dump_percent_Lbl.backgroundColor = [UIColor clearColor];
            dump_percent_Lbl.textAlignment = NSTextAlignmentCenter;
            dump_percent_Lbl.numberOfLines = 1;
            dump_percent_Lbl.layer.borderWidth = 1.5;
            dump_percent_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            dump_percent_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            stockLoss_Lbl = [[UILabel alloc] init];
            stockLoss_Lbl.backgroundColor = [UIColor clearColor];
            stockLoss_Lbl.textAlignment = NSTextAlignmentCenter;
            stockLoss_Lbl.numberOfLines = 1;
            stockLoss_Lbl.layer.borderWidth = 1.5;
            stockLoss_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            stockLoss_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            lossCost_Lbl = [[UILabel alloc] init];
            lossCost_Lbl.backgroundColor = [UIColor clearColor];
            lossCost_Lbl.textAlignment = NSTextAlignmentCenter;
            lossCost_Lbl.numberOfLines = 1;
            lossCost_Lbl.layer.borderWidth = 1.5;
            lossCost_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            lossCost_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            
            
            loss_Lbl = [[UILabel alloc] init];
            loss_Lbl.backgroundColor = [UIColor clearColor];
            loss_Lbl.textAlignment = NSTextAlignmentCenter;
            loss_Lbl.numberOfLines = 1;
            loss_Lbl.layer.borderWidth = 1.5;
            loss_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            loss_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            [hlcell.contentView addSubview:item_No_Lbl];
            [hlcell.contentView addSubview:category_Lbl];
            [hlcell.contentView addSubview:openStock_Lbl];
            [hlcell.contentView addSubview:saleQty_Lbl];
            [hlcell.contentView addSubview:saleValue_Lbl];
            [hlcell.contentView addSubview:dump_Lbl];
            [hlcell.contentView addSubview:dumpValue_Lbl];
            [hlcell.contentView addSubview:dump_percent_Lbl];
            [hlcell.contentView addSubview:stockLoss_Lbl];
            [hlcell.contentView addSubview:lossCost_Lbl];
            [hlcell.contentView addSubview:loss_Lbl];

            
            item_No_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            category_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            openStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            saleQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            saleValue_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            dump_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            dumpValue_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            dump_percent_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            stockLoss_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            lossCost_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            loss_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
           
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:14.0f cornerRadius:0.0];
                
                item_No_Lbl.frame = CGRectMake(itemNoLbl.frame.origin.x,0,itemNoLbl.frame.size.width+2, hlcell.frame.size.height);
                
                category_Lbl.frame = CGRectMake(categoryLbl.frame.origin.x,0,categoryLbl.frame.size.width+2,  hlcell.frame.size.height);
                
                openStock_Lbl.frame = CGRectMake(openStock.frame.origin.x,0,openStock.frame.size.width+2,hlcell.frame.size.height);

                saleQty_Lbl.frame = CGRectMake(itemSaleQtyLbl.frame.origin.x,0,itemSaleQtyLbl.frame.size.width+2,  hlcell.frame.size.height);
                
                saleValue_Lbl.frame = CGRectMake(itemSaleLbl.frame.origin.x,0,itemSaleLbl.frame.size.width+2,  hlcell.frame.size.height);
                
                dump_Lbl.frame = CGRectMake(dumpLbl.frame.origin.x,0,dumpLbl.frame.size.width+2,hlcell.frame.size.height);
                
                dumpValue_Lbl.frame = CGRectMake(dumpVal.frame.origin.x,0,dumpVal.frame.size.width+2,hlcell.frame.size.height);
                
                dump_percent_Lbl.frame = CGRectMake(dumpPercentLbl.frame.origin.x,0,dumpPercentLbl.frame.size.width+2,hlcell.frame.size.height);
                
                stockLoss_Lbl.frame = CGRectMake(itemlevelStockLossLbl.frame.origin.x,0,itemlevelStockLossLbl.frame.size.width+2,hlcell.frame.size.height);
                
                lossCost_Lbl.frame = CGRectMake(itemLevelLossCostLbl.frame.origin.x,0,itemLevelLossCostLbl.frame.size.width+2,hlcell.frame.size.height);

                loss_Lbl.frame = CGRectMake(lossLbl.frame.origin.x,0,lossLbl.frame.size.width,hlcell.frame.size.height);
               
            }
            
            else{
                
            }
            
            @try {
                
                NSDictionary * locDic = itemsListArr[indexPath.row];
                
                item_No_Lbl.text = [NSString stringWithFormat:@"%li", (indexPath.row + 1)];
                
                category_Lbl.text = [locDic valueForKey:PRODUCT_CATEGORY];
                
                openStock_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:OPEN_STOCK] defaultReturn:@"0.0"] floatValue]];

                
                saleQty_Lbl.text =   [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:SALE_QTY] defaultReturn:@"0.0"] floatValue]];
             
                saleValue_Lbl.text =  [NSString stringWithFormat:@"%.2f",0.0];
                
                
                dump_Lbl.text =  [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic valueForKey:DUMP_QTY] defaultReturn:@"0.0"] floatValue]];
                
                dumpValue_Lbl.text =  [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic valueForKey:DUMP_COST] defaultReturn:@"0.0"] floatValue]];

                float dump_percentageValue = 0;
                float loss_percentageValue = 0;
                
                //if([[self checkGivenValueIsNullOrNil:[locDic valueForKey:OPEN_STOCK] defaultReturn:@"0.0"] floatValue] == 0)
                    
                dump_percentageValue = ([[self checkGivenValueIsNullOrNil:[locDic valueForKey:DUMP_QTY] defaultReturn:@"0.0"] floatValue]/ [[self checkGivenValueIsNullOrNil:[locDic valueForKey:OPEN_STOCK] defaultReturn:@"0.0"] floatValue]) * 100;
                
                loss_percentageValue = ([[self checkGivenValueIsNullOrNil:[locDic valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.0"] floatValue]/ [[self checkGivenValueIsNullOrNil:[locDic valueForKey:OPEN_STOCK] defaultReturn:@"0.0"] floatValue]) * 100;
                
                dump_percent_Lbl.text =  [NSString stringWithFormat:@"%.2f%@",dump_percentageValue,@"%"];

                stockLoss_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.0"] floatValue]];
                
                lossCost_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[locDic valueForKey:kStock_loss] defaultReturn:@"0.0"] floatValue]];
                
                loss_Lbl.text =  [NSString stringWithFormat:@"%.2f%@",loss_percentageValue,@"%"];

            }
            
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }
        @catch (NSException * exception) {
            
        }
        @finally {
            
        }
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        hlcell.backgroundColor = [UIColor clearColor];

        return  hlcell;
    }
    
    else if (tableView == categoriesTbl){
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
            
            hlcell.textLabel.text = categoriesArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == subCategorytbl){
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
            hlcell.textLabel.text = subCategoryArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
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
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
    }
    else if (tableView == workFlowListTbl){
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
            hlcell.textLabel.text = workFlowsArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
        }
      }
    
    else if (tableView == pagenationTbl){
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
            hlcell.textLabel.text = pagenationArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
        }
    }
    
    return false;
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         30/05/2017
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [catPopOver dismissPopoverAnimated:YES];

      if(tableView == categoriesTbl) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            categoriesTbl.tag = indexPath.row;
            
            categoryTxt.text = categoriesArr[indexPath.row];
            
            subCategoryTxt.text = @"";
            
            if(subCategoryArr.count && subCategoryArr != nil)
                [subCategoryArr removeAllObjects];
            
        } @catch (NSException *exception) {
            
        }
    }
    else if(tableView == subCategorytbl) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            subCategorytbl.tag = indexPath.row;
            
            //categoryTxt.text = @"";
            
            subCategoryTxt.text = subCategoryArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    else if (tableView == locationTable){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            locationTable.tag = indexPath.row;
            
            outletIDTxt.text = locationArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == workFlowListTbl){
        
        @try {
            workFlowListTbl.tag = indexPath.row;
            
            statusTxt.text = workFlowsArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    else if (tableView == pagenationTbl){
        
        @try {
            
            verificationIndex = 0;
            pagenationTxt.text = pagenationArr[indexPath.row];
            int pageValue = (pagenationTxt.text).intValue;
            verificationIndex = verificationIndex + (pageValue * 10) - 10;
            
        } @catch (NSException * exception) {
            
        }
    }
    
    else if (tableView == stockVerificationTbl) {
        
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

-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view  permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections{
    
    @try {
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height > height) ){
            catPopOver.popoverContentSize =  CGSizeMake(width, height);
            
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

#pragma mark  Disaplay the Grid functionality... 

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
    
    @try {
    
        itemsListTbl.tag = sender.tag;
        
        itemsListArr = [NSMutableArray new];
        
        
    //  we are checking the null class.. neither the data is  storing nor....
        if(![[stockVerificationArr[sender.tag] valueForKey:@"categoryWiseitemsList"] isKindOfClass:[NSNull class]]) {
        
        itemsListArr = [[stockVerificationArr[sender.tag] valueForKey:@"categoryWiseitemsList"]mutableCopy];
            
        }
        
        if(itemsListArr.count == 0) {
            
            [self displayAlertMessage:NSLocalizedString(@"no_data_found", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        
        NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
        
        if(path.row ==0 ) {
            
            
            UITableViewCell * cell2 = [stockVerificationTbl cellForRowAtIndexPath:path];
            
            
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
                
            }else
            {
                if (!self.selectIndex) {
                    self.selectIndex = path;
                    
                    
                    
                    for (UIButton *button in cell2.contentView.subviews) {
                        
                        if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                            
                            UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                            
                            [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                        }
                        
                    }
                    
                    //   itemsListArr = [[stockVerificationArr objectAtIndex:path.section] valueForKey:ITEMS_LIST];
                   
                    
                    [self didSelectCellRowFirstDo:YES nextDo:NO];
                    
                }else
                {
                    
                    selectSectionIndex = path;
                    
                    
                    cell2 = [stockVerificationTbl cellForRowAtIndexPath: self.selectIndex];
                    
                    for (UIButton * button in cell2.contentView.subviews) {
                        
                        if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                            
                            UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_right_arrow.png"];
                            
                            [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                        }
                    }
                    
                    [self didSelectCellRowFirstDo:NO nextDo:YES];
                }
                
                //                selectProductCatRowNo = [NSNumber numberWithInt:selectIndex.section];
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
 * @method       tableView: willDisplayCell: forRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableViewCell
 * @param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert{
    @try {
        
        self.isOpen = firstDoInsert;
        //        subProductsCount = [productsArr count];
        
        [stockVerificationTbl beginUpdates];
        
        int section = (int)self.selectIndex.section;
        int contentCount;
        
        contentCount =1;
        
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i < contentCount+1 ; i++) {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
            [rowToInsert addObject:indexPathToInsert];
        }
        
        if (firstDoInsert)
        {
            
            [stockVerificationTbl  insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [stockVerificationTbl deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [stockVerificationTbl endUpdates];
        
        if (nextDoInsert) {
            self.isOpen = YES;
            self.selectIndex = selectSectionIndex;
            //            requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:selectIndex.section] valueForKey:@"stockRequestItems"];
            
            UITableViewCell *cell2 = [stockVerificationTbl cellForRowAtIndexPath:selectIndex];
            
            for (UIButton *button in cell2.contentView.subviews) {
                
                if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                    
                    UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                    
                    [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                    
                }
                
            }
            [self didSelectCellRowFirstDo:YES nextDo:NO];
        }
        if (self.isOpen)
            [stockVerificationTbl scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        //[stockRequestTbl scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }    @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in didSelectCellRowFirsDo: nextDo----%@",exception);
        
        NSLog(@"----exception in inserting the row in table----%@",exception);
        
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
        if (([inputValue isKindOfClass:[NSNull class]] || inputValue == nil )) {
        
                    
            return returnStirng;
        }
        else {
            
            
            if([inputValue isKindOfClass:[NSString class]])
                if([inputValue isEqualToString:@"<null>"])
                    return returnStirng;
            
            return inputValue;
        }
    } @catch (NSException * exception) {
        return returnStirng;
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
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
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
            
            //            if(searchItemTxt.isEditing)
            //                yPosition = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
            //
            
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
