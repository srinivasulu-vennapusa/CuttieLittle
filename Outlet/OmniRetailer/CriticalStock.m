
//  CriticalStock.m
//  OmniRetailer
//  Created by TLMac on 3/30/17.

#import "CriticalStock.h"
#import "StockDetails.h"
#import "OmniHomePage.h"
#import "BillingHome.h"

@interface CriticalStock ()

@end

@implementation CriticalStock

//this property will enable the setter and getter for soundFile objects....
@synthesize soundFileURLRef,soundFileObject;

@synthesize selectedStockTypeStr,serviceCallStr,selectIndex;


#pragma  - mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         18/09/2017
 * @method       ViewDidLoad
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIButton *logoView = [[UIButton alloc] init];
    logoView.backgroundColor = [UIColor clearColor];
    [logoView setBackgroundImage:[UIImage imageNamed:@"Logo_200.png"] forState:UIControlStateNormal];
    [logoView addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *optionsBtn = [[UIButton alloc] init];
    optionsBtn.backgroundColor = [UIColor clearColor];
    [optionsBtn setBackgroundImage:[UIImage imageNamed:@"emails-letters.png"] forState:UIControlStateNormal];
    [optionsBtn addTarget:self action:@selector(openSideMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0, -13.0,600, 70.0)];
    self.titleLabel.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:22.0f];
    
    [titleView addSubview:optionsBtn];
    [titleView addSubview:logoView];
    [titleView addSubview:self.titleLabel];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        optionsBtn.frame = CGRectMake(-20, 0, 45.0, 45.0);
        logoView.frame = CGRectMake(30, 0, 45, 45);
    }
    else {
        
        titleView.frame = CGRectMake(0.0, 0.0, 240.0, 45.0);
        optionsBtn.frame = CGRectMake(10.0, 7.0, 30.0, 30.0);
        logoView.frame = CGRectMake(45.0, 7.0, 30.0, 30.0);
        self.titleLabel.frame = CGRectMake(80.0, -12.0, 300, 70.0);
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
        if (version >= 8.0) {
            self.titleLabel.textColor = [UIColor blackColor];
        }
    }
    
    UIBarButtonItem *leftCustomView = [[UIBarButtonItem alloc] initWithCustomView:titleView];
    
    self.navigationItem.leftBarButtonItem = leftCustomView;
    
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL * tapSound   = [[NSBundle mainBundle] URLForResource:@"tap" withExtension: @"aif"];
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
    [HUD show:YES];
    [HUD setHidden:NO];
    [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
    
    //creating the stockRequestView which will displayed completed Screen.......
    normalStockVeiw = [[UIView alloc] init];
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.backgroundColor = [UIColor clearColor];
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    
    //adding header label as subView....
    [normalStockVeiw addSubview:headerNameLbl];
    
    /** creation of UITextField*/
    //used in first column....
    
    zoneTxt = [[CustomTextField alloc] init];
    zoneTxt.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneTxt.delegate = self;
    [zoneTxt awakeFromNib];
    zoneTxt.userInteractionEnabled = NO;
    
    
    locationTxt = [[CustomTextField alloc] init];
    locationTxt.placeholder = NSLocalizedString(@"all_outlets", nil);
    locationTxt.delegate = self;
    
    [locationTxt awakeFromNib];
    locationTxt.userInteractionEnabled = NO;
    
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.placeholder = NSLocalizedString(@"all_categories", nil);
    categoryTxt.delegate = self;
    categoryTxt.userInteractionEnabled = NO;
    [categoryTxt awakeFromNib];
    
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.placeholder = NSLocalizedString(@"all_subcategories", nil);
    subCategoryTxt.delegate = self;
    subCategoryTxt.userInteractionEnabled = NO;
    [subCategoryTxt awakeFromNib];
    
    brandTxt = [[CustomTextField alloc] init];
    brandTxt.placeholder = NSLocalizedString(@"all_brands", nil);
    brandTxt.delegate = self;
    [brandTxt awakeFromNib];
    brandTxt.userInteractionEnabled = NO;
    
    //used in third column....
    sectionTxt = [[CustomTextField alloc] init];
    sectionTxt.placeholder = NSLocalizedString(@"all_sections", nil);
    sectionTxt.delegate = self;
    [sectionTxt awakeFromNib];
    sectionTxt.userInteractionEnabled = NO;
    
    //used in second column....
    departmentTxt = [[CustomTextField alloc] init];
    departmentTxt.placeholder = NSLocalizedString(@"all_departments", nil);
    departmentTxt.delegate = self;
    [departmentTxt awakeFromNib];
    departmentTxt.userInteractionEnabled = NO;
    
    subDepartmentTxt = [[CustomTextField alloc] init];
    subDepartmentTxt.placeholder = NSLocalizedString(@"all_subDepartments", nil);
    subDepartmentTxt.delegate = self;
    [subDepartmentTxt awakeFromNib];
    subDepartmentTxt.userInteractionEnabled = NO;
    
    modelTxt = [[CustomTextField alloc] init];
    modelTxt.placeholder = NSLocalizedString(@"all_models", nil);
    modelTxt.delegate = self;
    [modelTxt awakeFromNib];
    modelTxt.userInteractionEnabled = NO;
    
    supplierTxt = [[CustomTextField alloc] init];
    supplierTxt.placeholder = NSLocalizedString(@"all_suppliers", nil);
    supplierTxt.delegate = self;
    [supplierTxt awakeFromNib];
    supplierTxt.userInteractionEnabled = NO;
    
    startDteTxt = [[CustomTextField alloc] init];
    startDteTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDteTxt.delegate = self;
    [startDteTxt awakeFromNib];
    startDteTxt.userInteractionEnabled = NO;
    
    endDteTxt = [[CustomTextField alloc] init];
    endDteTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDteTxt.delegate = self;
    [endDteTxt awakeFromNib];
    endDteTxt.userInteractionEnabled = NO;
    
    
    
    //Creationof Search Text to Search Sku's...
    searchItemsTxt = [[CustomTextField alloc]init];
    searchItemsTxt.borderStyle=UITextBorderStyleRoundedRect;
    searchItemsTxt.placeholder = NSLocalizedString(@"search_for_skus", nil);
    searchItemsTxt.autocorrectionType=UITextAutocorrectionTypeNo;
    searchItemsTxt.backgroundColor=[UIColor lightGrayColor];
    searchItemsTxt.keyboardType=UIKeyboardTypeDefault;
    searchItemsTxt.clearButtonMode=UITextFieldViewModeWhileEditing;
    searchItemsTxt.userInteractionEnabled=YES;
    searchItemsTxt.delegate=self;
    [searchItemsTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //adding first column textFields....
    [normalStockVeiw addSubview:zoneTxt];
    [normalStockVeiw addSubview:locationTxt];
    
    
    
    //adding second column textFields....
    [normalStockVeiw addSubview:categoryTxt];
    [normalStockVeiw addSubview:subCategoryTxt];
    
    //adding third column textFields....
    [normalStockVeiw addSubview:departmentTxt];
    [normalStockVeiw addSubview:subDepartmentTxt];
    
    //adding fourth column textFields....
    [normalStockVeiw addSubview:brandTxt];
    [normalStockVeiw addSubview:sectionTxt];
    
    //adding fifth column textFields....
    [normalStockVeiw addSubview:modelTxt];
    [normalStockVeiw addSubview:supplierTxt];
    
    //adding sixth column textFields....
    [normalStockVeiw addSubview:startDteTxt];
    [normalStockVeiw addSubview:endDteTxt];
    
    
    //adding itemSearch textField....
    [normalStockVeiw addSubview:searchItemsTxt];
    /*creation of UIButton's*/
    
    UIButton * clearBtn;
    
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self
                  action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // searchBtn.tag = 2;
    
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    //adding UIButton's as subView's....
    [normalStockVeiw addSubview:searchBtn];
    [normalStockVeiw addSubview:clearBtn];
    
    
    /*Creation of UIImage used for button backgrounds*/
    UIImage * dropDownButtonImage = [UIImage imageNamed:@"arrow.png"];
    
    UIImage *  calendarImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    
    /*Creation  UIButton's  */
    UIButton * zoneBtn;
    UIButton * locationBtn;
    
    UIButton * showCategoriesBtn;
    UIButton * showSubCategoriesBtn;
    
    UIButton * showListOfAllBrandsBtn;
    UIButton * showListOfAllSectionBtn;
    
    
    UIButton * showDepartmentListBtn;
    UIButton * showSubDepartmentBtn;
    
    UIButton * showModelBtn;
    UIButton * showSupplierBtn;
    
    UIButton * showStartDteBtn;
    UIButton * showEndDateBtn;
    
    zoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoneBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [zoneBtn addTarget:self action:@selector(showAllZonesId:) forControlEvents:UIControlEventTouchDown];
    zoneBtn.hidden = YES;
    
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];
    
    showCategoriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showCategoriesBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showCategoriesBtn addTarget:self action:@selector(showAllLocationWiseCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    showSubCategoriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showSubCategoriesBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showSubCategoriesBtn addTarget:self action:@selector(showAllSubCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    showListOfAllBrandsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showListOfAllBrandsBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showListOfAllBrandsBtn addTarget:self action:@selector(showListOfAllBrands:) forControlEvents:UIControlEventTouchDown];
    
    showListOfAllSectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showListOfAllSectionBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showListOfAllSectionBtn addTarget:self action:@selector(showSectionList:) forControlEvents:UIControlEventTouchDown];
    
    showDepartmentListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showDepartmentListBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showDepartmentListBtn addTarget:self action:@selector(showDepartmentList:) forControlEvents:UIControlEventTouchDown];
    
    showSubDepartmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showSubDepartmentBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showSubDepartmentBtn addTarget:self  action:@selector(showSubDepartmentList:) forControlEvents:UIControlEventTouchDown];
    
    showModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showModelBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showModelBtn addTarget:self  action:@selector(showAllModelsList:) forControlEvents:UIControlEventTouchDown];
    
    showSupplierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showSupplierBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showSupplierBtn addTarget:self action:@selector(showAllSuppliersList:) forControlEvents:UIControlEventTouchDown];
    
    showStartDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showStartDteBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [showStartDteBtn addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    showEndDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showEndDateBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [showEndDateBtn addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //adding first column label's....
    
    [normalStockVeiw addSubview:zoneBtn];
    [normalStockVeiw addSubview:locationBtn];
    
    [normalStockVeiw addSubview:showCategoriesBtn];
    [normalStockVeiw addSubview:showSubCategoriesBtn];
    
    [normalStockVeiw addSubview:showListOfAllBrandsBtn];
    [normalStockVeiw addSubview:showListOfAllSectionBtn];
    
    [normalStockVeiw addSubview:showDepartmentListBtn];
    [normalStockVeiw addSubview:showSubDepartmentBtn];
    
    [normalStockVeiw addSubview:showModelBtn];
    [normalStockVeiw addSubview:showSupplierBtn];
    
    [normalStockVeiw addSubview:showStartDteBtn];
    [normalStockVeiw addSubview:showEndDateBtn];
    
    //Allocation of UIScroll View for the label headers...
    
    stockScrollView = [[UIScrollView alloc]init];
    
    tableLabelsHeaderView = [[UIView alloc]init];
    
    /** Table Creation*/
    commonDisplayTbl = [[UITableView alloc] init];
    commonDisplayTbl.dataSource = self;
    commonDisplayTbl.delegate = self;
    commonDisplayTbl.backgroundColor = [UIColor blackColor];
    commonDisplayTbl.bounces = TRUE;
    commonDisplayTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    commonDisplayTbl.separatorColor = [UIColor clearColor];
    //commonDisplayTbl.hidden = YES;
    
    [normalStockVeiw addSubview:stockScrollView];
    [stockScrollView addSubview:tableLabelsHeaderView];
    [stockScrollView addSubview:commonDisplayTbl];
    
    //Added By Bhargav.v on 21/10/2017...
    
    packQtyValueLbl = [[UILabel alloc] init];
    packQtyValueLbl.layer.cornerRadius = 5;
    packQtyValueLbl.layer.masksToBounds = YES;
    packQtyValueLbl.backgroundColor = [UIColor blackColor];
    packQtyValueLbl.layer.borderWidth = 2.0f;
    packQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    packQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    stockQtyValueLbl = [[UILabel alloc] init];
    stockQtyValueLbl.layer.cornerRadius = 5;
    stockQtyValueLbl.layer.masksToBounds = YES;
    stockQtyValueLbl.backgroundColor = [UIColor blackColor];
    stockQtyValueLbl.layer.borderWidth = 2.0f;
    stockQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    stockQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    closePackQtyValueLbl = [[UILabel alloc] init];
    closePackQtyValueLbl.layer.cornerRadius = 5;
    closePackQtyValueLbl.layer.masksToBounds = YES;
    closePackQtyValueLbl.backgroundColor = [UIColor blackColor];
    closePackQtyValueLbl.layer.borderWidth = 2.0f;
    closePackQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    closePackQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    closeStockQtyValueLbl = [[UILabel alloc] init];
    closeStockQtyValueLbl.layer.cornerRadius = 5;
    closeStockQtyValueLbl.layer.masksToBounds = YES;
    closeStockQtyValueLbl.backgroundColor = [UIColor blackColor];
    closeStockQtyValueLbl.layer.borderWidth = 2.0f;
    closeStockQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    closeStockQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    stockValueLbl = [[UILabel alloc] init];
    stockValueLbl.layer.cornerRadius = 5;
    stockValueLbl.layer.masksToBounds = YES;
    stockValueLbl.backgroundColor = [UIColor blackColor];
    stockValueLbl.layer.borderWidth = 2.0f;
    stockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    stockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    packQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    stockQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    closePackQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    closeStockQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    stockValueLbl.textAlignment = NSTextAlignmentCenter;
    
    packQtyValueLbl.text  = @"0.00";
    stockQtyValueLbl.text = @"0.00";
    closePackQtyValueLbl.text  = @"0.00";
    closeStockQtyValueLbl.text = @"0.00";
    stockValueLbl.text    = @"0.00";
    
    [stockScrollView addSubview:packQtyValueLbl];
    [stockScrollView addSubview:stockQtyValueLbl];
    [stockScrollView addSubview:stockValueLbl];
    
    
    UILabel * pagesLbl;
    
    pagesLbl = [[UILabel alloc] init];
    pagesLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    pagesLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    pagesLbl.layer.cornerRadius = 20.0f;
    pagesLbl.layer.masksToBounds = YES;
    pagesLbl.textAlignment = NSTextAlignmentLeft;
    
    pagenationTxt = [[CustomTextField alloc] init];
    pagenationTxt.userInteractionEnabled = NO;
    pagenationTxt.textAlignment = NSTextAlignmentCenter;
    pagenationTxt.delegate = self;
    [pagenationTxt awakeFromNib];
    
    UIButton * dropDownBtn;
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [dropDownBtn addTarget:self
                    action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    
    //creating the UIButton which are used to show CustomerInfo popUp.......
    UIButton * goButton;
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    //Allocation of UIView....
    
    totalInventoryView = [[UIView alloc]init];
    totalInventoryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalInventoryView.layer.borderWidth =3.0f;
    
    UILabel * totalQtyLbl;
    
    totalQtyLbl = [[UILabel alloc] init];
    totalQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalQtyLbl.layer.cornerRadius = 5.0f;
    totalQtyLbl.layer.masksToBounds = YES;
    totalQtyLbl.textAlignment = NSTextAlignmentLeft;
    
    totalQtyValuelbl = [[UILabel alloc] init];
    totalQtyValuelbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalQtyValuelbl.layer.cornerRadius = 5.0f;
    totalQtyValuelbl.layer.masksToBounds = YES;
    
    totalInventoryView_1 = [[UIView alloc]init];
    totalInventoryView_1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalInventoryView_1.layer.borderWidth =3.0f;
    
    UILabel * totalInventoryLbl;
    
    totalInventoryLbl = [[UILabel alloc] init];
    totalInventoryLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalInventoryLbl.layer.cornerRadius = 5.0f;
    totalInventoryLbl.layer.masksToBounds = YES;
    totalInventoryLbl.textAlignment = NSTextAlignmentLeft;
    
    
    totalInventoryValueLbl = [[UILabel alloc] init];
    totalInventoryValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalInventoryValueLbl.layer.cornerRadius = 5.0f;
    totalInventoryValueLbl.layer.masksToBounds = YES;
    
    //Setting Intial Value as Zero...
    totalQtyValuelbl.text = @"0.0";
    totalInventoryValueLbl.text = @"0.0";
    
    //setting alignment for calculate value labels...
    
    totalQtyValuelbl.textAlignment = NSTextAlignmentRight;
    totalInventoryValueLbl.textAlignment = NSTextAlignmentRight;
    
    // Added By Bhargav.v on 23/01/2018
    
    cartBtn = [[UIButton alloc] init];
    cartBtn.backgroundColor = [UIColor clearColor];
    [cartBtn setBackgroundImage:[UIImage imageNamed:@"Basket_new"] forState:UIControlStateNormal];
    cartBtn.tag = 0;
    [cartBtn addTarget:self  action:@selector(navigateBillingPage:) forControlEvents:UIControlEventTouchUpInside];
    [cartBtn setHidden:NO];
    cartBtn.badgeValue = @"0";
    cartBtn.badgeBGColor = [UIColor redColor];
    cartBtn.badgeTextColor = [UIColor whiteColor];
    
    
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    panGesture.minimumNumberOfTouches = 1;
    [cartBtn addGestureRecognizer:panGesture];
    
    [normalStockVeiw addSubview:pagesLbl];
    [normalStockVeiw addSubview:pagenationTxt];
    [normalStockVeiw addSubview:dropDownBtn];
    [normalStockVeiw addSubview:goButton];
    
    [normalStockVeiw addSubview:totalInventoryView];
    [totalInventoryView addSubview:totalQtyLbl];
    [totalInventoryView addSubview:totalQtyValuelbl];
    
    [normalStockVeiw addSubview:totalInventoryView_1];
    [totalInventoryView_1 addSubview:totalInventoryLbl];
    [totalInventoryView_1 addSubview:totalInventoryValueLbl];
    
    [normalStockVeiw addSubview:cartBtn];
    
    
    [self.view addSubview:normalStockVeiw];
    
    @try {
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        headerNameLbl.text = NSLocalizedString(@"view_stocks", nil);
        
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
        
        headerNameLbl.text = NSLocalizedString(@"header_available_stock", nil);
        
        pagesLbl.text = NSLocalizedString(@"pages",nil);
        totalQtyLbl.text = NSLocalizedString(@"total_Qty",nil);
        totalInventoryLbl.text = NSLocalizedString(@"total_inventory_cost_:",nil);
        
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        //self.view.frame = CGRectMake(0,0,[ [ UIScreen mainScreen ] bounds ].size.width, [ [ UIScreen mainScreen ] bounds ].size.height);
        
        // setting frame for normalStockVeiw...
        normalStockVeiw.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        
        // setting frame for the headerNameLbl...
        headerNameLbl.frame = CGRectMake(0,0,normalStockVeiw.frame.size.width,40);
        
        float textFieldWidth =  135;
        float textFieldHeight = 40;
        
        float vertical_Gap = 20;
        float horzantial_Gap = 10;
        
        //Frame for the zoneTxt
        zoneTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+vertical_Gap,textFieldWidth,textFieldHeight);
        
        //Frame for the locationText..
        locationTxt.frame = CGRectMake(zoneTxt.frame.origin.x,zoneTxt.frame.origin.y+zoneTxt.frame.size.height+vertical_Gap,textFieldWidth,textFieldHeight);
        //Frame for the categoryTxt
        categoryTxt.frame = CGRectMake(zoneTxt.frame.origin.x+zoneTxt.frame.size.width+horzantial_Gap,zoneTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the subCategoryTxt
        subCategoryTxt.frame  = CGRectMake(categoryTxt.frame.origin.x,locationTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        
        //Frame for the brandTxt....
        brandTxt.frame = CGRectMake(categoryTxt.frame.origin.x+categoryTxt.frame.size.width+horzantial_Gap,categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        sectionTxt.frame= CGRectMake(brandTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        
        //Frame for the brandTxt
        departmentTxt.frame = CGRectMake(brandTxt.frame.origin.x+brandTxt.frame.size.width+horzantial_Gap, categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the subDepartmentTxt
        subDepartmentTxt.frame = CGRectMake(departmentTxt.frame.origin.x, subCategoryTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        //Frame for the modelTxt
        modelTxt.frame = CGRectMake(departmentTxt.frame.origin.x+departmentTxt.frame.size.width+horzantial_Gap,categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the supplierTxt
        supplierTxt.frame = CGRectMake(modelTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the startDteTxt
        startDteTxt.frame = CGRectMake(modelTxt.frame.origin.x+modelTxt.frame.size.width+horzantial_Gap,modelTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the endDateTxt
        endDteTxt.frame = CGRectMake(startDteTxt.frame.origin.x,supplierTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //setting frame for UIButton's used at bottam....
        searchBtn.frame = CGRectMake((normalStockVeiw.frame.size.width -130), categoryTxt.frame.origin.y,120,40);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x, subCategoryTxt.frame.origin.y, searchBtn.frame.size.width, searchBtn.frame.size.height);
        
        zoneBtn.frame = CGRectMake(zoneTxt.frame.origin.x + zoneTxt.frame.size.width - 45, zoneTxt.frame.origin.y - 8, 55, 60);
        
        //setting frame for UIButton's....
        locationBtn.frame = CGRectMake(locationTxt.frame.origin.x + locationTxt.frame.size.width - 45, locationTxt.frame.origin.y - 8, 55, 60);
        
        showCategoriesBtn.frame = CGRectMake(categoryTxt.frame.origin.x + categoryTxt.frame.size.width - 45, categoryTxt.frame.origin.y - 8, 55, 60);
        
        
        showSubCategoriesBtn.frame = CGRectMake( subCategoryTxt.frame.origin.x + subCategoryTxt.frame.size.width - 45, subCategoryTxt.frame.origin.y - 8, 55, 60);
        
        showListOfAllBrandsBtn.frame = CGRectMake( brandTxt.frame.origin.x + brandTxt.frame.size.width - 45, brandTxt.frame.origin.y - 8, 55, 60);
        
        showListOfAllSectionBtn.frame = CGRectMake( sectionTxt.frame.origin.x + sectionTxt.frame.size.width - 45, sectionTxt.frame.origin.y - 8, 55, 60);
        
        showDepartmentListBtn.frame = CGRectMake( departmentTxt.frame.origin.x + departmentTxt.frame.size.width - 45, departmentTxt.frame.origin.y - 8, 55, 60);
        
        showSubDepartmentBtn.frame = CGRectMake( subDepartmentTxt.frame.origin.x + subDepartmentTxt.frame.size.width - 45, subDepartmentTxt.frame.origin.y - 8, 55, 60);
        
        showModelBtn.frame = CGRectMake( modelTxt.frame.origin.x + modelTxt.frame.size.width - 45, modelTxt.frame.origin.y - 8, 55, 60);
        
        showSupplierBtn.frame = CGRectMake( supplierTxt.frame.origin.x + supplierTxt.frame.size.width - 45, supplierTxt.frame.origin.y - 8, 55, 60);
        
        showStartDteBtn.frame = CGRectMake((startDteTxt.frame.origin.x+startDteTxt.frame.size.width-40), startDteTxt.frame.origin.y+2, 35, 30);
        
        showEndDateBtn.frame = CGRectMake((endDteTxt.frame.origin.x+endDteTxt.frame.size.width-40), endDteTxt.frame.origin.y+2, 35, 30);
        
        //setting frame for search filed...
        searchItemsTxt.frame = CGRectMake( zoneTxt.frame.origin.x, subCategoryTxt.frame.origin.y + subCategoryTxt.frame.size.height + 20,  ((searchBtn.frame.origin.x + searchBtn.frame.size.width) - zoneTxt.frame.origin.x), 40);
        
        NSString * lastLabelWidth = [NSString stringWithFormat:@"%.2f",(searchItemsTxt.frame.size.width - 900)];
        
        labelSidesArr = @[@"50",@"80",@"120",@"70", @"50",@"60",@"60",@"95",@"80",@"80",@"50",@"80",@"100",@"90",@"100",lastLabelWidth];
        
        [self populateLables:@[NSLocalizedString(@"s_no",nil),NSLocalizedString(@"sku_id",nil),NSLocalizedString(@"item_desc",nil),NSLocalizedString(@"color",nil),NSLocalizedString(@"size",nil),NSLocalizedString(@"measure_range",nil),NSLocalizedString(@"grade",nil),NSLocalizedString(@"ean",nil),NSLocalizedString(@"category",nil),NSLocalizedString(@"re_order",nil),NSLocalizedString(@"uom", nil),NSLocalizedString(@"pack_qty",nil),NSLocalizedString(@"stock_qty",nil),NSLocalizedString(@"cost_price",nil),NSLocalizedString(@"stock_value",nil),NSLocalizedString(@"action",nil)] widthsArr:
         
         @[@"50",@"80",@"120",@"70", @"50",@"60",@"60",@"95",@"80",@"80",@"50",@"80",@"100",@"90",@"100",lastLabelWidth]];
        
        //frames used for the pagenation functionality....
        
        pagenationTxt.frame = CGRectMake(searchItemsTxt.frame.origin.x, normalStockVeiw.frame.size.height - 50,90,40);
        
        //pagenationTxt.frame = CGRectMake(pagesLbl.frame.origin.x+pagesLbl.frame.size.width-20, normalStockVeiw.frame.size.height - 50,90,40);
        
        dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width-45), pagenationTxt.frame.origin.y-5, 45, 50);
        
        goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width+15,pagenationTxt.frame.origin.y,80, 40);
        
        stockScrollView.frame = CGRectMake(0, searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height, searchItemsTxt.frame.size.width+10,(pagenationTxt.frame.origin.y -(searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height+10)));
        
        //adding frame for the tableHeaderView....
        tableLabelsHeaderView.frame = CGRectMake(searchItemsTxt.frame.origin.x,0,stockScrollView.frame.size.width,50);
        
        
        // Stock Value Frames based on the
        if ([typeOfStock isEqualToString:NSLocalizedString(@"ordered_stock",nil)]) {
            
            packQtyValueLbl.frame = CGRectMake(1010,stockScrollView.frame.size.height-40,100,40);
            stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+102, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
        }
        else if([typeOfStock isEqualToString:NSLocalizedString(@"boneyard",nil)]){
            
            packQtyValueLbl.frame = CGRectMake(1010,stockScrollView.frame.size.height-40,100,40);
            stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            
            stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+192, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
        }
        
        else if([typeOfStock isEqualToString:NSLocalizedString(@"blocked_stock",nil)] || [typeOfStock isEqualToString:NSLocalizedString(@"returned_stock",nil)]){
            
            packQtyValueLbl.frame = CGRectMake(825,stockScrollView.frame.size.height-40,80,40);
            
            stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            
            stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+192, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
        }
        
        else if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
            
            packQtyValueLbl.frame = CGRectMake(840,stockScrollView.frame.size.height-40,80,40);
            
            stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,80, packQtyValueLbl.frame.size.height);
            
            //            closePackQtyValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,80, packQtyValueLbl.frame.size.height);
            //
            //            closeStockQtyValueLbl.frame = CGRectMake(closePackQtyValueLbl.frame.origin.x+closePackQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,80, packQtyValueLbl.frame.size.height);
            
            stockValueLbl.frame = CGRectMake(closeStockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+170, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
        }
        
        
        else{
            
            packQtyValueLbl.frame = CGRectMake(825,stockScrollView.frame.size.height-40,80,40);
            
            stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            
            stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+92, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
        }
        
        
        // Stock Value Frames...
        
        commonDisplayTbl.frame =  CGRectMake(searchItemsTxt.frame.origin.x,tableLabelsHeaderView.frame.origin.y + tableLabelsHeaderView.frame.size.height, stockScrollView.frame.size.width + 1100, packQtyValueLbl.frame.origin.y - (tableLabelsHeaderView.frame.origin.y + tableLabelsHeaderView.frame.size.height));
        
        //Frame for the UIView...
        totalInventoryView.frame = CGRectMake((searchItemsTxt.frame.size.width)/2.4, goButton.frame.origin.y+5,260,40);
        
        //Frames for the UILabels under the totalInventoryView....
        totalQtyLbl.frame = CGRectMake( 15, 5, 160, 30);
        
        totalQtyValuelbl.frame = CGRectMake( totalQtyLbl.frame.origin.x + totalQtyLbl.frame.size.width - 40,totalQtyLbl.frame.origin.y, 120 ,totalQtyLbl.frame.size.height);
        
        totalInventoryView_1.frame = CGRectMake(totalInventoryView.frame.origin.x + totalInventoryView.frame.size.width+30, totalInventoryView.frame.origin.y,300,40);
        
        totalInventoryLbl.frame = CGRectMake(15, 5, 180, 30);
        
        totalInventoryValueLbl.frame = CGRectMake(totalInventoryLbl.frame.origin.x+totalInventoryLbl.frame.size.width-20,totalInventoryLbl.frame.origin.y,totalQtyValuelbl.frame.size.width,totalInventoryLbl.frame.size.height);
        
        cartBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 350,90 ,90);
        
        cartBtn.badgeOriginX = 60;
        cartBtn.badgeOriginY = 10;
        cartBtn.badgeFont = [UIFont fontWithName:TEXT_FONT_NAME size:16];
        
        cartBtn.badgePadding = 15;
        
        
        //setting font....
        @try {
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0.0f];
            headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            
            searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
            
            clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
            
        } @catch (NSException *exception) {
            
        }
        
    }else{
        
    }
    @try {
        
        //changing the headerNameLbl backGrouondColor & textColor.......
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
        
        bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        bottomBorder.opacity = 5.0f;
        [headerNameLbl.layer addSublayer:bottomBorder];
        
        headerNameLbl.layer.cornerRadius = 10.0f;
        headerNameLbl.layer.masksToBounds = YES;
        headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
        //headerNameLbl.backgroundColor = [UIColor clearColor];
        headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        
        
        normalStockVeiw.backgroundColor = [UIColor clearColor];
        normalStockVeiw.layer.borderWidth = 2.0f;
        normalStockVeiw.layer.cornerRadius = 8.0f;
        normalStockVeiw.layer.borderColor = [UIColor grayColor].CGColor;
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception in Quotation page in ViewDidLoad exception while setting the fontSize to subViews");
        NSLog(@"---- exception is ----%@",exception);
    }
    
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeRightGesture.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:swipeRightGesture];
    //    [self.navigationController.navigationBar addGestureRecognizer:swipeRightGesture];
    
    
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeLeftGesture.direction = (UISwipeGestureRecognizerDirectionLeft);
    [self.view addGestureRecognizer:swipeLeftGesture];
    //    [self.navigationController.navigationBar addGestureRecognizer:swipeLeftGesture];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapView:)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    
    //table's used in popUp's.......
    //categoriesListTbl allocation
    categoriesListTbl = [[UITableView alloc] init];
    
    //subCategoriesListTbl allocation..
    subCategoriesListTbl = [[UITableView alloc] init];
    
    //brandsTbl Allocation...
    brandsTbl = [[UITableView alloc] init];
    
    //sectionTbl Allocation...
    sectionTbl = [[UITableView alloc] init];
    
    //departmentListTbl Allocation...
    departmentListTbl = [[UITableView alloc] init];
    
    //subDepartmentListTbl Allocation...
    subDepartmentListTbl = [[UITableView alloc] init];
    
    //supplierListTbl Allocation...
    modelTable = [[UITableView alloc] init];
    
    //supplierListTbl Allocation ...
    supplierListTbl = [[UITableView alloc] init];
    
    //locationTable Allocation...
    
    locationTable = [[UITableView alloc]init];
    locationTable.tag = -1;
    
    // pagenationTbl Allocation...
    pagenationTbl = [[UITableView alloc] init];
    
    //Qunatity  Display Table View...
    quantityTblView = [[UITableView alloc]init];
    
    //Freezing the current zone and Current location to the respective fields..
    
    if (zoneID.length == 0 || [zoneID isKindOfClass:[NSNull class]] || [zoneID isEqualToString:EMPTY_STRING]) {
        
        zoneTxt.text = zone;
    }
    else {
        
        zoneTxt.text = zoneID;
    }
        
    locationTxt.text = presentLocation;
    
    //used for identification propouse....
    showStartDteBtn.tag = 2;
    showEndDateBtn.tag = 4;
    
    categoryTxt.tag = 2;
    brandTxt.tag = 1;
    
}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidAppear.......
 * @date         !8/09/2017
 * @method       viewWillAppear
 * @author       Srinivasulu
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
    
    @try {
        // [HUD setHidden:NO];

        if(CartItemsArray == nil)
        CartItemsArray = [NSMutableArray new];

        
        if(selectedStockTypeStr == nil || [selectedStockTypeStr isEqualToString:@""]){
            startIndexNumber = 0;
            selectedStockTypeStr  = NSLocalizedString(@"available_stock", nil);
            serviceCallStr = @"normal";
            
            [self normalStockServiceCall:serviceCallStr];
        }
        
        [self openSideMenu];
        
        [commonDisplayTbl reloadData];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  it an view lifeCycle methods
 * @date         18/09/2017
 * @method       viewWillDisappear:
 * @author       Bhargav.v
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewWillDisappear:(BOOL)animated{
    //calling the superClass viewWillDisappear method.......
    [super viewWillDisappear:YES];
    
    @try {
        
        //        sideMenuTable.dataSource = nil;
        //        sideMenuTable.delegate = nil;
        //        sideMenuTable = nil;
        
    } @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the CriticalStock in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}



#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         18/09/2017
 * @method       didReceiveMemoryWarning
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark methods used to display the table header labels.....


/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         18/09/2017
 * @method       populateLables
 * @author       Bhargav.v
 * @param        NSArray
 * @param        NSArray
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)populateLables:(NSArray *)labelStrArr widthsArr:(NSArray *)widthsArray {
    
    @try {
        
        int index = 0;
        
        for (UILabel *label in tableLabelsHeaderView.subviews) {
            
            [label removeFromSuperview];
        }
        
        float xposition = 0;
        
        for (NSString * str in labelStrArr) {
            
            UILabel * label = [[UILabel alloc] init];
            label.layer.cornerRadius = 5.0f;
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.masksToBounds = YES;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 2;
            label.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            label.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            label.textColor = [UIColor whiteColor];
            label.text = str;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                label.frame = CGRectMake(xposition, 5.0,[widthsArray[index] floatValue],35);
                [tableLabelsHeaderView addSubview:label];
                
            }
            xposition = xposition + label.frame.size.width + 2;
            index++;
        }
        
        @try {
            
            tableLabelsHeaderView.frame = CGRectMake(searchItemsTxt.frame.origin.x, 0,xposition,50);
            
            
            // Stock Value Frames based on the
            if ([typeOfStock isEqualToString:NSLocalizedString(@"ordered_stock",nil)]) {
                
                packQtyValueLbl.frame = CGRectMake(1010,stockScrollView.frame.size.height-40,100,40);
                stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
                stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+102, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            }
            else if([typeOfStock isEqualToString:NSLocalizedString(@"boneyard",nil)]){
                
                packQtyValueLbl.frame = CGRectMake(1010,stockScrollView.frame.size.height-40,100,40);
                stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
                
                stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+192, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            }
            
            else if([typeOfStock isEqualToString:NSLocalizedString(@"blocked_stock",nil)] || [typeOfStock isEqualToString:NSLocalizedString(@"returned_stock",nil)]){
                
                packQtyValueLbl.frame = CGRectMake(825,stockScrollView.frame.size.height-40,80,40);
                
                stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
                
                stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x + stockQtyValueLbl.frame.size.width + 192, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            }
            
            else if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
                
                packQtyValueLbl.frame = CGRectMake(840,stockScrollView.frame.size.height-40,80,40);
                stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+5, packQtyValueLbl.frame.origin.y,80, packQtyValueLbl.frame.size.height);
                
                stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+170, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            }
            else {
                
                packQtyValueLbl.frame = CGRectMake(825,stockScrollView.frame.size.height-40,80,40);
                
                stockQtyValueLbl.frame = CGRectMake(packQtyValueLbl.frame.origin.x+packQtyValueLbl.frame.size.width+2, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
                
                stockValueLbl.frame = CGRectMake(stockQtyValueLbl.frame.origin.x+stockQtyValueLbl.frame.size.width+92, packQtyValueLbl.frame.origin.y,100, packQtyValueLbl.frame.size.height);
            }
            // Stock Value Frames
            
            commonDisplayTbl.frame =  CGRectMake(searchItemsTxt.frame.origin.x,tableLabelsHeaderView.frame.origin.y + tableLabelsHeaderView.frame.size.height, stockScrollView.frame.size.width + 1100, packQtyValueLbl.frame.origin.y - (tableLabelsHeaderView.frame.origin.y + tableLabelsHeaderView.frame.size.height));
            
            stockScrollView.contentSize = CGSizeMake( tableLabelsHeaderView.frame.origin.x + tableLabelsHeaderView.frame.size.width, stockScrollView.frame.size.height);
            
        } @catch (NSException *exception) {
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}


#pragma action used to navigate to other pages....
/**
 * @description  for here we are navigating to the ViewStockCard page..
 * @date         12/04/2017....
 * @method       navigateToStockCard:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)navigateToStockCard:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        StockDetails * stockDetailsObj = [StockDetails alloc];
        stockDetailsObj.stockDetailsDic = commonDisplayArr[sender.tag];
        [self.navigationController pushViewController:stockDetailsObj animated:YES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


#pragma -mark action used to show dropdown....

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         03/04/2017....
 * @method       showAllCategoriesList:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showAllCategoriesList:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((categoriesListArr == nil) || (categoriesListArr.count == 0)){
            [HUD setHidden:NO];
            
            //for identification....
            categoriesListTbl.tag = 2;
            subCategoriesListTbl.tag = 4;
            
            //soap service call....
            [self callingCategoriesList:@""];
            
        }
        
        [HUD setHidden:YES];
        
        
        if(categoriesListArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = categoriesListArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = categoriesListArr.count * 33;
        
        if(categoriesListArr.count > 5)
            tableHeight =(tableHeight/categoriesListArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showAllSubCategoriesList:
 * @author       Srinivasulu
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
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        
        if((subCategoriesListArr == nil) || (subCategoriesListArr.count == 0)){
            
            //for identification....
            categoriesListTbl.tag = 4;
            subCategoriesListTbl.tag = 2;
            [self callingCategoriesList:categoryTxt.text];
        }
        
        [HUD setHidden:YES];
        
        if(subCategoriesListArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        float tableHeight = subCategoriesListArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoriesListArr.count * 33;
        
        if(subCategoriesListArr.count > 5)
            tableHeight = (tableHeight/subCategoriesListArr.count)*5;
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:(subCategoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showDepartmentList:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showDepartmentList:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((departmentListArr == nil) || (departmentListArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self callingDepartmentList];
            
        }
        
        [HUD setHidden:YES];
        
        if(departmentListArr.count == 0){
            
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        
        float tableHeight = departmentListArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = departmentListArr.count * 33;
        
        if(departmentListArr.count > 5)
            tableHeight = (tableHeight/departmentListArr.count) * 5;
        
        [self showPopUpForTables:departmentListTbl  popUpWidth:(departmentTxt.frame.size.width*1.5)  popUpHeight:tableHeight presentPopUpAt:departmentTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  showing the availiable  subDepartment.......
 * @date         16/03/2017....
 * @method       showSubDepartmentList:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showSubDepartmentList:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if(subDepartmentListArr == nil ||  subDepartmentListArr.count == 0){
            [HUD setHidden:NO];
            [self callingSubDepartmentList];
        }
        
        if(subDepartmentListArr.count){
            float tableHeight = subDepartmentListArr.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = subDepartmentListArr.count * 33;
            
            if(subDepartmentListArr.count > 5)
                tableHeight = (tableHeight/subDepartmentListArr.count) * 5;
            
            [self showPopUpForTables:subDepartmentListTbl  popUpWidth:(subDepartmentTxt.frame.size.width*1.5)  popUpHeight:tableHeight presentPopUpAt:subDepartmentTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp ];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--exception in the normalStockView in showSubDepartmentList:----%@",exception);
        
        NSLog(@"--exception while creating the popUp in normalStockView------%@",exception);
        
    }
}


/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showListOfAllBrands:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showListOfAllBrands:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((locationWiseBrandsArr == nil) || (locationWiseBrandsArr.count == 0)|| (brandTxt.tag == 1)){
            
            [self getBrandsByLocation];
            
            return;
            
        }
        [HUD setHidden:YES];
        
        if(locationWiseBrandsArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        
        float tableHeight = locationWiseBrandsArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationWiseBrandsArr.count * 33;
        
        if(locationWiseBrandsArr.count > 5)
            tableHeight = (tableHeight/locationWiseBrandsArr.count) * 5;
        
        [self showPopUpForTables:brandsTbl  popUpWidth:(brandTxt.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         19/08/2017....
 * @method       showSectionList:
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)showSectionList:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(!(subCategoryTxt.text).length){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_subCategory",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        
        if((sectionArr == nil) || (sectionArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self callingSectionFromSubCategories];
        }
        [HUD setHidden:YES];
        
        if(sectionArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        float tableHeight = sectionArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = sectionArr.count * 33;
        
        if(sectionArr.count > 5)
            tableHeight = (tableHeight/sectionArr.count) * 5;
        
        [self showPopUpForTables:sectionTbl  popUpWidth:(sectionTxt.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:sectionTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  we are displaying the models data in a table...
 * @date         22/08/2017
 * @method       showAllModelsList
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showAllModelsList:(UIButton*)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((modelListArr == nil) || (modelListArr.count == 0)){
            
            [self getModels];
        }
        [HUD setHidden:YES];
        
        if(modelListArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        
        float tableHeight = modelListArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = modelListArr.count * 33;
        
        if(modelListArr.count > 5)
            
            tableHeight = (tableHeight/modelListArr.count) * 5;
        
        [self showPopUpForTables:modelTable  popUpWidth:(modelTxt.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:modelTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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

-(void)showAllSuppliersList:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((supplierListArr == nil) || (supplierListArr.count == 0)){
            
            [self getSuppliers];
        }
        [HUD setHidden:YES];
        
        if(supplierListArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = supplierListArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = supplierListArr.count * 33;
        
        if(supplierListArr.count > 5)
            tableHeight = (tableHeight/supplierListArr.count) * 5;
        
        [self showPopUpForTables:supplierListTbl  popUpWidth:(supplierTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:supplierTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are showing the all availiable outlerId.......
 * @date         10/05/2016
 * @method       showAllOutletId
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (void)showAllOutletId:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        //        if (![catPopOver isPopoverVisible]){
        if(locationArr == nil ||  locationArr.count == 0){
            [HUD setHidden:NO];
            //changed on 17/02/2017....
            [self getZones];
            //[self getOutletsMappedToThisWarehouse];
        }
        
        if(locationArr.count){
            float tableHeight = locationArr.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = locationArr.count * 33;
            
            if(locationArr.count > 5)
                tableHeight = (tableHeight/locationArr.count) * 5;
            
            zoneTxt.tag = 2;
            locationTxt.tag = 0;
            
            [self showPopUpForTables:locationTable  popUpWidth:(locationTxt.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:locationTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the stockReceiptView in showAllOutletId:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
}

/**
 * @description  here we are showing the all availiable outlerId.......
 * @date         19/09/2016
 * @method       showAllZonesId
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showAllZonesId:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        //        if (![catPopOver isPopoverVisible]){
        if(zoneListArr == nil ||  zoneListArr.count == 0){
            [HUD setHidden:NO];
            
            //changed on 17/02/2017....
            [self getZones];
            //[self getOutletsMappedToThisWarehouse];
            
        }
        [HUD setHidden:YES];
        
        if(zoneListArr.count){
            float tableHeight = zoneListArr.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = zoneListArr.count * 33;
            
            if(zoneListArr.count > 5)
                tableHeight = (tableHeight/zoneListArr.count) * 5;
            
            zoneTxt.tag = 0;
            locationTxt.tag = 2;
            
            [self showPopUpForTables:locationTable  popUpWidth:(zoneTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:zoneTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the stockReceiptView in showAllZonesId:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
}


/**
 * @description
 * @date         20/12/2017
 * @method       showAllLocationWiseCategoriesList
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)showAllLocationWiseCategoriesList:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        
        if( ((locationWiseCategoriesArr == nil) || (locationWiseCategoriesArr.count == 0)) || (categoryTxt.tag == 2)){
            
            //for identification....
            categoriesListTbl.tag = 2;
            subCategoriesListTbl.tag = 4;
            
            //Restful service call....
            [self getCategoriesByLocation];
            return;
        }
        
        [HUD setHidden:YES];
        
        if(locationWiseCategoriesArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = locationWiseCategoriesArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationWiseCategoriesArr.count * 33;
        
        if(locationWiseCategoriesArr.count > 5)
            tableHeight =(tableHeight/locationWiseCategoriesArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}




#pragma -mark service calls used in dropDowns....

/**
 * @description  here we are calling the getDepartment services.....
 * @date         08/08/2017
 * @method       callingDepartmentList
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingDepartmentList{
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        departmentListArr = [NSMutableArray new];
        dept_SubDeptDic = [NSMutableDictionary new];
        
        NSArray * keys = @[REQUEST_HEADER,START_INDEX,@"noOfSubDepartments",@"slNo",kStoreLocation];
        NSArray * objects = @[[RequestHeader getRequestHeader],@"-1",[NSNumber numberWithBool:true],[NSNumber numberWithBool:true],presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * departmentJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getDepartmentList:departmentJsonString];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
    }
    
    @finally {
        
    }
}

/**
 * @description  here we are calling the getDepartment services.....
 * @date         08/08/2017
 * @method       callingSubDepartmentList
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingSubDepartmentList {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden: NO];
        
        subDepartmentListArr = [NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,kPrimaryDepartment,@"subDepartment",kStoreLocation];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",departmentTxt.text,@"",presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * departmentJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getDepartmentList:departmentJsonString];
    }
    @catch (NSException *exception){
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
        
    }
    @finally {
        
    }
}

/**
 * @description  here we are calling the getDepartmentList services.....
 * @date         08/08/2017
 * @method       callingCategoriesList
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)callingCategoriesList:(NSString *)categoryName{
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(categoriesListTbl.tag == 2 )
            categoriesListArr = [NSMutableArray new];
        else
            subCategoriesListArr = [NSMutableArray new];
        
        NSArray * keys = @[REQUEST_HEADER,START_INDEX,kCategoryName,SL_NO,FLAG,kStoreLocation];
        NSArray * objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,categoryName,[NSNumber numberWithBool:true],EMPTY_STRING,presentLocation];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * categoryJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getProductCategory:categoryJsonStr];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
    }
    @finally {
        
    }
}

/**
 * @description  here we are calling the sections from SubCategories services.....
 * @date         09/08/2017
 * @method       callingSectionFromSubCategories
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)callingSectionFromSubCategories{
    @try {
        BOOL status = false;
        [HUD show: YES];
        [HUD setHidden:NO];
        
        if (sectionArr == nil) {
            sectionArr  = [NSMutableArray new];
        }
        
        NSString * subCatStr = subCategoryTxt.text;
        
        NSMutableDictionary * sectionDic = [[NSMutableDictionary alloc] init];
        
        [sectionDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [sectionDic setValue:[NSString stringWithFormat:@"%d",0] forKey:START_INDEX];
        [sectionDic setValue:[NSString stringWithFormat:@"%d",10] forKey:MAX_RECORDS];
        [sectionDic setValue:presentLocation forKey:kStoreLocation];
        
        [sectionDic setValue:subCatStr forKey:kSubCategoryName];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:sectionDic options:0 error:&err];
        NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductsJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.utilityMasterDelegate = self;
        status = [webServiceController getProductSubCategories:getProductsJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  here we are calling the getDepartmentList services.....
 * @date         08/08/2017
 * @method       callingListOfBrands
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingListOfBrands{
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        
        if (brandsArr == nil) {
            brandsArr  = [NSMutableArray new];
        }
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,BNAME,SL_NO,kStoreLocation];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,EMPTY_STRING, [NSNumber numberWithBool:true],presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * brandListJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getBrandList:brandListJsonString];
        
    }
    @catch (NSException *exception){
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
    }
    @finally {
        
    }
}

/**
 * @description  here we are calling the getModels services.....
 * @date         08/08/2017
 * @method       getModels
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getModels{
    @try {
        
        
        [HUD setHidden:NO];
        
        if (modelListArr == nil) {
            
            modelListArr  = [NSMutableArray new];
        }
        
        // Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSMutableDictionary * modelDic = [[NSMutableDictionary alloc]init];
        
        [modelDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [modelDic setValue:presentLocation forKey:kStoreLocation];
        
        [modelDic setValue:@0 forKey:START_INDEX];
        
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:modelDic options:0 error:&err];
        NSString * modelJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.modelMasterDelegate = self;
        [webServiceController getModelDetails:modelJsonStr];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while callingModelList ServicesCall ----%@",exception);
        
    }
    @finally {
        
    }
}

/**
 * @description
 * @date         09/10/2017
 * @method       getSuppliers
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


// Commented by roja on 17/10/2019.. // reason:- getSuppliers method contains SOAP Service call .. so taken new method with same name(getSuppliers) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getSuppliers {
//    // BOOL status = FALSE;
//
//    [HUD setHidden:NO];
//
//    NSArray *keys = @[REQUEST_HEADER,PAGE_NO,kStoreLocation];
//    NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,presentLocation];
//
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//    NSError  * err;
//    NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    if (supplierListArr == nil) {
//        supplierListArr  = [NSMutableArray new];
//    }
//
//    SupplierServiceSoapBinding * skuService = [SupplierServiceSvc SupplierServiceSoapBinding];
//    SupplierServiceSvc_getSuppliers * getSkuid = [[SupplierServiceSvc_getSuppliers alloc] init];
//    getSkuid.supplierDetails = salesReportJsonString;
//
//
//    @try {
//
//        SupplierServiceSoapBindingResponse * response = [skuService getSuppliersUsingParameters:getSkuid];
//        NSArray *responseBodyParts = response.bodyParts;
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[SupplierServiceSvc_getSuppliersResponse class]]) {
//                SupplierServiceSvc_getSuppliersResponse *body = (SupplierServiceSvc_getSuppliersResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//                NSError * e;
//                NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                      options: NSJSONReadingMutableContainers
//                                                                        error: &e];
//                [HUD setHidden:YES];
//
//
//                [supplierListArr addObject:NSLocalizedString(@"all_suppliers",nil)];
//
//                NSArray * list = JSON[@"suppliers"];
//                for (int i=0; i<list.count; i++) {
//
//                    NSDictionary * dic = list[i];
//                    [supplierListArr addObject:dic[@"firmName"]];
//                }
//            }
//            else{
//
//            }
//        }
//
//    }
//    @catch (NSException * exception) {
//        [HUD setHidden:YES];
//        float y_axis = self.view.frame.size.height - 350;
//
//        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",exception];
//        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//    }
//    @finally{
//        [HUD setHidden:YES];
//        [supplierListTbl reloadData];
//    }
//
//}



//getSuppliers method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getSuppliers {
    
    [HUD setHidden:NO];
    
    NSArray *keys = @[REQUEST_HEADER,PAGE_NO,kStoreLocation];
    NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,presentLocation];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError  * err;
    NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (supplierListArr == nil) {
        supplierListArr  = [NSMutableArray new];
    }
    
    WebServiceController * services  = [[WebServiceController alloc] init];
    services.supplierServiceSvcDelegate =  self;
    [services getSupplierDetailsData:salesReportJsonString];
    
}


// added by Roja on 17/10/2019…. // OLD code written below...
- (void)getSuppliersSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [supplierListArr addObject:NSLocalizedString(@"all_suppliers",nil)];
        
        NSArray * list = successDictionary[@"suppliers"];
        for (int i=0; i<list.count; i++) {
            
            NSDictionary * dic = list[i];
            [supplierListArr addObject:dic[@"firmName"]];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [supplierListTbl reloadData];
    }
}

// added by Roja on 17/10/2019…. // OLD code written below...
- (void)getSuppliersErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        float y_axis = self.view.frame.size.height - 350;
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [supplierListTbl reloadData];

    }
}

/**
 * @description  here calling the service to getAllLocations............
 * @date         20/09/2016
 * @method       getZones
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getZones {
    
    @try {
        [HUD setHidden:NO];
        
        if(locationArr == nil)
            locationArr = [NSMutableArray new];
        
        if(zoneListArr == nil)
            zoneListArr = [NSMutableOrderedSet new];
        
        if(zoneWiseLocationDic == nil)
            zoneWiseLocationDic = [NSMutableDictionary new];
        
        //Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSString * zoneStr = zoneTxt.text;
        
        NSMutableDictionary * zoneDic  = [[NSMutableDictionary alloc]init];
        
        [zoneDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [zoneDic setValue:@"0" forKey:START_INDEX];
        [zoneDic setValue:zoneStr forKey:ZONE_ID];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:zoneDic options:0 error:&err_];
        NSString * zoneJsonStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.zoneMasterDelegate = self;
        [webServiceController getZoneIdsRequest:zoneJsonStr];
        
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getZones ServicesCall ----%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  here calling the service to getAllLocations............
 * @date         20/09/2016
 * @method       getLocations
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocations {
    
    @try {
        
        if(locationArr == nil)
            locationArr = [NSMutableArray new];
        
        if(zoneListArr == nil)
            zoneListArr = [NSMutableOrderedSet new];
        
        if(zoneWiseLocationDic == nil)
            zoneWiseLocationDic = [NSMutableDictionary new];
        
        // Changes Made By Bhargav.v on 20/10/2017....
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSMutableDictionary * locationDic = [[NSMutableDictionary alloc]init];
        
        [locationDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [locationDic setValue:NEGATIVE_ONE forKey:START_INDEX];
        
        NSError  * err_;
        NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:locationDic options:0 error:&err_];
        NSString * locationJSonStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.utilityMasterDelegate = self;
        [webServiceController getAllLocationDetailsData:locationJSonStr];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getLocations ServicesCall ----%@",exception);
        
    } @finally {
        
    }
}


/*
 * @description  forming request to get the categories based on location
 * @date         20/12/2017
 * @method       getCategoriesByLocation
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getCategoriesByLocation {
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        
        if(locationWiseCategoriesArr == nil)
            locationWiseCategoriesArr = [NSMutableArray new];
        else if(locationWiseCategoriesArr.count)
            [locationWiseCategoriesArr removeAllObjects];
        
        NSMutableDictionary * locationDictionary = [[NSMutableDictionary alloc]init];
        
        [locationDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        NSString *  outLetStoreID = locationTxt.text;
        
        [locationDictionary setValue:outLetStoreID forKey:kStoreLocation];
        
        [locationDictionary setValue:@"-1" forKey:START_INDEX_STR];
        
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:OUTLET_ALL];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:WAREHOUSE_ALL];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:ISSUE_AND_CLOSE];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:kNotForDownload];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:SAVE_STOCK_REPORT];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:ENFORCE_GENERATE_PO];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:IS_TOTAL_COUNT_REQUIRED];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:ZERO_STOCK_CHECK_AT_OUTLET_LEVEL];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:locationDictionary options:0 error:&err];
        NSString * locationJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.skuServiceDelegate = self;
        [webServiceController getCategoriesByLocation:locationJsonStr];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getWorkFlows ServicesCall ----%@",exception);
        
    } @finally {
        
    }
}

/**
 * @description  forming request to get the categories based on location
 * @date         20/12/2017
 * @method       getCategoriesByLocation
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getBrandsByLocation {
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        
        if(locationWiseBrandsArr == nil)
            locationWiseBrandsArr = [NSMutableArray new];
        else if(locationWiseBrandsArr.count)
            [locationWiseBrandsArr removeAllObjects];
        
        NSMutableDictionary * locationDictionary = [[NSMutableDictionary alloc]init];
        
        [locationDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        NSString *  outLetStoreID = locationTxt.text;
        
        [locationDictionary setValue:outLetStoreID forKey:kStoreLocation];
        
        [locationDictionary setValue:@"-1" forKey:START_INDEX_STR];
        
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:OUTLET_ALL];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:WAREHOUSE_ALL];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:ISSUE_AND_CLOSE];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:kNotForDownload];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:SAVE_STOCK_REPORT];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:ENFORCE_GENERATE_PO];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:IS_TOTAL_COUNT_REQUIRED];
        [locationDictionary setValue:[NSNumber numberWithBool:false] forKey:ZERO_STOCK_CHECK_AT_OUTLET_LEVEL];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:locationDictionary options:0 error:&err];
        NSString * locationJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.skuServiceDelegate = self;
        [webServiceController getBrandsByLocation:locationJsonStr];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getWorkFlows ServicesCall ----%@",exception);
        
    } @finally {
        
    }
}

#pragma - mark service calls used for getting table data....

/**
 * @description  here we are calling the getDepartmentList services.....
 * @date         03/04/2017
 * @method       normalStockServiceCall
 * @author       Bhargav.v
 * @param        selectedTypeStr
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)normalStockServiceCall:(NSString*)selectedTypeStr {
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(commonDisplayArr.count){
            
            [commonDisplayArr removeAllObjects];
        }
        else{
            commonDisplayArr = [NSMutableArray new];
        }
        packQtyValueLbl.text   = @"0.0";
        stockQtyValueLbl.text  = @"0.0";
        stockValueLbl.text     = @"0.0";
        
        //[commonDisplayTbl reloadData];
        
        NSMutableDictionary * reqDic = [NSMutableDictionary new];
        
        [reqDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [reqDic setValue:@(startIndexNumber) forKey:kStartIndex];
        [reqDic setValue:@10 forKey:kRequiredRecords];
        
        //adding filters....
        
        NSString  * catStr     = categoryTxt.text;
        NSString  * subCatStr  = subCategoryTxt.text;
        NSString  * deptStr    = departmentTxt.text;
        NSString  * subDeptStr = subDepartmentTxt.text;
        NSString  * brandStr   = brandTxt.text;
        NSString  * sectionStr = sectionTxt.text;
        NSString  * supplierStr= supplierTxt.text;
        NSString  * modelStr   = modelTxt.text;
        NSString  * locationStr = locationTxt.text;
        
        NSString * searchStr = @"";
        
        if((searchItemsTxt.text).length > 3)
            searchStr = searchItemsTxt.text;
        
        NSString * startDteStr = startDteTxt.text;
        
        if((startDteTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDteTxt.text,@" 00:00:00"];
        
        NSString *  endDteStr  = endDteTxt.text;
        
        if ((endDteTxt.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDteTxt.text,@" 00:00:00"];
        }
        
        isBoneYard = false;
        
        if ([selectedTypeStr  caseInsensitiveCompare:@"boneyard"] == NSOrderedSame ) {
            
            isBoneYard = true;
        }
        
        [reqDic setValue:searchStr forKey:kSearchCriteria];
        
        [reqDic setValue:selectedTypeStr forKey:kStockType];
        
        [reqDic setValue:EMPTY_STRING forKey:kSearchType];
        
        [reqDic setValue:@0.0f forKey:START_PRICE_RANGE];
        
        [reqDic setValue:@0.0f forKey:END_PRICE_RANGE];
        
        [reqDic setValue:@(isBoneYard) forKey:BONEYARD_SUMMARY_FLAG];
        
        [reqDic setValue:[NSNumber numberWithBool:false] forKey:SAVE_STOCK_FLAG];
        
        if (categoriesListTbl.tag == 0 || (categoryTxt.text).length == 0)
            
            //|| categoriesListTbl.tag == 4
            
            catStr      = @"";
        
        if (subCategoriesListTbl.tag == 0 || (subCategoryTxt.text).length == 0)
            
            subCatStr   = @"";
        
        if (brandsTbl.tag == 0 || (brandTxt.text).length == 0)
            
            brandStr    = @"";
        
        if (sectionTbl.tag == 0 || (sectionTxt.text).length == 0)
            
            sectionStr  = @"";
        
        if (departmentListTbl.tag == 0 || (departmentTxt.text).length == 0)
            
            deptStr     = @"";
        
        if (subDepartmentListTbl.tag == 0 || (subDepartmentTxt.text).length == 0)
            
            subDeptStr  = @"";
        
        if (modelTable.tag == 0 || (modelTxt.text).length == 0)
            
            modelStr    = @"";
        
        if ([locationTxt.text isEqualToString:NSLocalizedString(@"all_outlets", nil)] && locationTable.tag == 0 && sideMenuTable.tag == 0) {
            
            locationStr = @"";
        }
        
        if (supplierListTbl.tag == 0 || (supplierTxt.text).length == 0)
            
            supplierStr = @"";
        
        if(searchBtn.tag == 2 && sideMenuTable.tag == 0) {
            
            catStr      = @"";
            subCatStr   = @"";
            brandStr    = @"";
            sectionStr  = @"";
            deptStr     = @"";
            subDeptStr  = @"";
            modelStr    = @"";
            supplierStr = @"";
            locationStr = @"";
            
        }
        
        [reqDic setValue:catStr forKey:ITEM_CATEGORY];
        [reqDic setValue:subCatStr forKey:kSubCategory];
        [reqDic setValue:brandStr forKey:kBrand];
        [reqDic setValue:sectionStr forKey:SECTION];
        [reqDic setValue:deptStr forKey:kItemDept];
        [reqDic setValue:subDeptStr forKey:kItemSubDept];
        [reqDic setValue:modelStr forKey:MODEL];
        [reqDic setValue:supplierStr forKey:SUPPLIER_NAME];
        [reqDic setValue:startDteStr forKey:kStartDate];
        [reqDic setValue:endDteStr forKey:END_DATE];
        [reqDic setValue:locationStr forKey:kStoreLocation];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * stockJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getScrapStockDelegate = self;
        [webServiceController getScrapStockDetails:stockJsonStr];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
        
    }
    @finally {
        
    }
}

/**
 * @description  here we are calling the getDepartmentList services.....
 * @date         03/04/2017
 * @method       callingDepartmentList
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getDailyStockReport:(NSString *)selectedTypeStr {
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(commonDisplayArr.count){
            
            [commonDisplayArr removeAllObjects];
        }
        else{
            commonDisplayArr = [NSMutableArray new];
        }
        
        packQtyValueLbl.text   = @"0.0";
        stockQtyValueLbl.text  = @"0.0";
        stockValueLbl.text     = @"0.0";
        
        totalQtyValuelbl.text = @"0.0";
        totalInventoryValueLbl.text = @"0.0";
        
        
        NSMutableDictionary * reqDic = [NSMutableDictionary new];
        
        [reqDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [reqDic setValue:@(startIndexNumber) forKey:kStartIndex];
        [reqDic setValue:@10 forKey:kRequiredRecords];
        
        
        //adding filters....
        
        NSString  * catStr     = categoryTxt.text;
        NSString  * subCatStr  = subCategoryTxt.text;
        NSString  * deptStr    = departmentTxt.text;
        NSString  * subDeptStr = subDepartmentTxt.text;
        NSString  * brandStr   = brandTxt.text;
        NSString  * sectionStr = sectionTxt.text;
        NSString  * supplierStr= supplierTxt.text;
        NSString  * modelStr   = modelTxt.text;
        NSString  * locationStr = locationTxt.text;
        
        
        NSString * searchStr = @"";
        
        if((searchItemsTxt.text).length > 3)
            searchStr = searchItemsTxt.text;
        
        NSString * startDteStr = startDteTxt.text;
        
        if((startDteTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDteTxt.text,@" 00:00:00"];
        
        NSString *  endDteStr  = endDteTxt.text;
        
        if ((endDteTxt.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDteTxt.text,@" 00:00:00"];
        }
        
        [reqDic setValue:searchStr forKey:kSearchCriteria];
        
        //[reqDic setValue:presentLocation forKey:STORE_LOCATION];
        
        [reqDic setValue:[NSNumber numberWithBool:false] forKey:BONEYARD_SUMMARY_FLAG];
        
        [reqDic setValue:[NSNumber numberWithBool:false] forKey:SAVE_STOCK_FLAG];
        
        [reqDic setValue:[NSNumber numberWithBool:false] forKey:IS_SAVE_REPORT];
        
        [reqDic setValue:selectedTypeStr forKey:kStockType];
        
        if (categoriesListTbl.tag == 0 || (categoryTxt.text).length == 0 || categoriesListTbl.tag == 4)
            
            catStr      = @"";
        
        if (subCategoriesListTbl.tag == 0 || (subCategoryTxt.text).length == 0)
            
            subCatStr   = @"";
        
        if (brandsTbl.tag == 0 || (brandTxt.text).length == 0)
            
            brandStr    = @"";
        
        if (sectionTbl.tag == 0 || (sectionTxt.text).length == 0)
            
            sectionStr  = @"";
        
        if (departmentListTbl.tag == 0 || (departmentTxt.text).length == 0)
            
            deptStr     = @"";
        
        if (subDepartmentListTbl.tag == 0 || (subDepartmentTxt.text).length == 0)
            
            subDeptStr  = @"";
        
        if (modelTable.tag == 0 || (modelTxt.text).length == 0)
            
            modelStr    = @"";
        
        if (supplierListTbl.tag == 0 || (supplierTxt.text).length == 0)
            
            supplierStr = @"";
        
        if (locationTable.tag == 0 || (locationTxt.text).length == 0) {
            
            locationStr = @"";
        }
        
        if(searchBtn.tag == 2) {
            
            catStr      = @"";
            subCatStr   = @"";
            brandStr    = @"";
            sectionStr  = @"";
            deptStr     = @"";
            subDeptStr  = @"";
            modelStr    = @"";
            supplierStr = @"";
            
            if (locationTable.tag == 0){
            locationStr = @"";
            }
            else if( (locationTxt.text).length == 0){
                locationTxt.text = presentLocation;
                locationStr = presentLocation;
            }
        }
        
        [reqDic setValue:catStr      forKey:ITEM_CATEGORY];
        [reqDic setValue:subCatStr   forKey:kSubCategory];
        [reqDic setValue:brandStr    forKey:kBrand];
        [reqDic setValue:sectionStr  forKey:SECTION];
        [reqDic setValue:deptStr     forKey:kItemDept];
        [reqDic setValue:subDeptStr  forKey:kItemSubDept];
        [reqDic setValue:modelStr    forKey:MODEL];
        [reqDic setValue:supplierStr forKey:SUPPLIER_NAME];
        [reqDic setValue:startDteStr forKey:kStartDate];
        [reqDic setValue:endDteStr   forKey:END_DATE];
        [reqDic setValue:locationStr forKey:kStoreLocation];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * stockJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController  * webServiceController = [WebServiceController new];
        webServiceController.salesServiceDelegate = self;
        [webServiceController getDailyStockReport:stockJsonStr];
        
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
        
    }
    @finally {
        
    }
}


/**
 * @description  calling getSkuDetails services
 * @date         19/05/2016
 * @method       callingSkuDetails
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingSkuDetails:(NSString*)selected_skuID {
    
    @try {
        
        [HUD show:YES];
        
        [HUD setHidden:NO];
        
        if(skuListsArr == nil)
            skuListsArr = [NSMutableArray new];
        else if(skuListsArr.count)
            [skuListsArr removeAllObjects];

        
        //NSArray * keys = [NSArray arrayWithObjects:ITEM_SKU,REQUEST_HEADER,TOTAL_BILLS,kStoreLocation, nil];
        //NSArray * objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",selected_skuID],[RequestHeader getRequestHeader],@"",presentLocation, nil];
 
        //NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSMutableDictionary * productDetailsDic = [[NSMutableDictionary alloc] init];
        
        productDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        productDetailsDic[kStoreLocation] = locationTxt.text;
        productDetailsDic[ITEM_SKU] = [NSString stringWithFormat:@"%@",selected_skuID];
        productDetailsDic[START_INDEX] = NEGATIVE_ONE;

        //setting the Boolean Value  as false...
        productDetailsDic[OUTLET_ALL] = [NSNumber numberWithBool:false];
        //setting the Boolean Value  as false...
        productDetailsDic[WAREHOUSE_ALL] = [NSNumber numberWithBool:false];
        
        //setting the Boolean Value  as false...
        productDetailsDic[REQUIRED_SUPP_PRODUCTS] = [NSNumber numberWithBool:true];

        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    }
}

#pragma -mark skuDetails Response Handling

/**
 * @description  getting response from service for skuDetails as success..
 * @date         29/05/2016
 * @method       getCategorySuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        skuListsArr = [[successDictionary valueForKey:kSkuLists] mutableCopy];
        
        if (skuListsArr.count) {
            
            [self displaySkuInfoView:0];
        }
        
    }
    @catch (NSException * exception) {
        
    }
    @finally{
        
        [HUD setHidden:YES];
    }
}

/**
 * @description  getting response from service as error..
 * @date         29/05/2016
 * @method       getCategoryErrorResponse:
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSkuDetailsErrorResponse:(NSString *)errorMessage{
    @try {
        [HUD setHidden:YES];
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorMessage];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        
    }
}

#pragma -mark handling of service calls response handling....

/**
 * @description  handling the successResponse received from the services end....
 * @date
 * @method       getScrapStockSuccessResponse:
 * @author
 * @param        NSDictionary
 * @param
 * @return       void
 * @verified By
 * @verified On
 */

- (void)getScrapStockSuccessResponse:(NSDictionary*)successDictionary {
    
    @try {
        
        totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_SKUS]  defaultReturn:@"0"]intValue];
        
        if((searchItemsTxt.tag == (searchItemsTxt.text).length)  || ((searchItemsTxt.text).length < 3)){
            
            NSString * resposneKey_1 = SKU;
            
            searchItemsTxt.tag = 0;
            
            float PackQty    = 0;
            float stockQty   = 0;
            float stockValue = 0;
            
            if((packQtyValueLbl.text).length)
                PackQty = (packQtyValueLbl.text).floatValue;
            
            if((stockQtyValueLbl.text).length)
                stockQty = (stockQtyValueLbl.text).floatValue;
            
            if((stockValueLbl.text).length)
                stockValue = (stockValueLbl.text).floatValue;
            
            if([successDictionary.allKeys containsObject:resposneKey_1] && (![[successDictionary valueForKey:resposneKey_1] isKindOfClass:[NSNull class]])){
                //added on 23/05/2017....
                
                for(NSDictionary * dic in [successDictionary valueForKey:resposneKey_1] ) {
                    
                    [commonDisplayArr addObject: dic];
                    
                    PackQty   += [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
                    stockQty  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:STOCK_QTY] defaultReturn:@"0.00"] floatValue];
                    stockValue  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:STOCK_VALUE] defaultReturn:@"0.00"] floatValue];
                }
            }
            
            packQtyValueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@"", PackQty];
            stockQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", stockQty];
            stockValueLbl.text     = [NSString stringWithFormat:@"%@%.2f",@"", stockValue];
            
            totalQtyValuelbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_QTY] defaultReturn:@"0.00"] floatValue]];
            
            totalInventoryValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILL_AMT] defaultReturn:@"0.00"] floatValue]];
        }
        else {
            
            searchItemsTxt.tag = 0;
            [self textFieldDidChange:searchItemsTxt];
        }
        
        //Recently Added By Bhargav.v on 21/10/2017..
        //Reason: To Display the Records in pagination mode based on the TotalRecords..
        
        int strTotalRecords = totalRecords/10;
        
        int remainRecords = totalRecords % 10;
        
        if(remainRecords == 0)
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
        
    } @catch (NSException *exception) {
        
        NSLog(@"--exception in --%@",exception);
        
    } @finally {
        
        if(startIndexNumber == 0){
            pagenationTxt.text = @"1";
        }
        
        [commonDisplayTbl reloadData];
        [HUD setHidden:YES];
    }
}

/**
 * @description  handling the successResponse received from the services end....
 * @date
 * @method       getScrapStockErrorResponse:
 * @author
 * @param        NSString
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

- (void)getScrapStockErrorResponse:(NSString *)responseMessage {
    @try {
        
        if((searchItemsTxt.tag == (searchItemsTxt.text).length)  || ((searchItemsTxt.text).length < 3)){
            
            searchItemsTxt.tag = 0;
            
            [HUD setHidden:YES];
            float y_axis = self.view.frame.size.height - 120;
            
            packQtyValueLbl.text   = @"0.0";
            stockQtyValueLbl.text  = @"0.0";
            stockValueLbl.text     = @"0.0";
            
            totalQtyValuelbl.text = @"0.0";
            totalInventoryValueLbl.text = @"0.0";
            
            if(searchItemsTxt.isEditing)
                y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
            
            //            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",responseMessage];
            
            NSString * mesg = [NSString stringWithFormat:@"%@",responseMessage];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        else{
            searchItemsTxt.tag = 0;
            [self textFieldDidChange:searchItemsTxt];
        }
        
    } @catch (NSException *  exception) {
        
    } @finally {
        [commonDisplayTbl reloadData];
        
        [pagenationArr removeAllObjects];
        
    }
}

/**
 * @description  handling the successResponse received from the services end....
 * @date
 * @method       getScrapStockSuccessResponse:
 * @author
 * @param        NSDictionary
 * @param
 * @return       void
 * @verified By
 * @verified On
 */

-(void)getDailyStockReportSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_SKUS]  defaultReturn:@"0"]intValue];
        
        if((searchItemsTxt.tag == (searchItemsTxt.text).length)  || ((searchItemsTxt.text).length < 3)){
            
            NSString * resposneKey_1 = REPORT_LIST;
            
            searchItemsTxt.tag = 0;
            
            float PackQty    = 0;
            float stockQty   = 0;
            float closePack  = 0;
            float closeStock = 0;
            float stockValue = 0;
            
            if((packQtyValueLbl.text).length)
                PackQty = (packQtyValueLbl.text).floatValue;
            
            if((stockQtyValueLbl.text).length)
                stockQty = (stockQtyValueLbl.text).floatValue;
            
            if((closePackQtyValueLbl.text).length)
                closePack = (closePackQtyValueLbl.text).floatValue;
            
            if((closeStockQtyValueLbl.text).length)
                closeStock = (closeStockQtyValueLbl.text).floatValue;
            
            if((stockValueLbl.text).length)
                stockValue = (stockValueLbl.text).floatValue;
            
            if([successDictionary.allKeys containsObject:resposneKey_1] && (![[successDictionary valueForKey:resposneKey_1] isKindOfClass:[NSNull class]])){
                //added on 23/05/2017....
                
                for(NSDictionary * dic in [successDictionary valueForKey:resposneKey_1] ) {
                    
                    [commonDisplayArr addObject: dic];
                    
                    PackQty    += [[self checkGivenValueIsNullOrNil:[dic valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue];
                    
                    stockQty   += [[self checkGivenValueIsNullOrNil:[dic valueForKey:OPEN_STOCK_QTY] defaultReturn:@"0.00"] floatValue];
                    
                    closePack  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue];
                    
                    closeStock += [[self checkGivenValueIsNullOrNil:[dic valueForKey:CLOSED_STOCK_QTY] defaultReturn:@"0.00"] floatValue];
                    
                    stockValue += [[self checkGivenValueIsNullOrNil:[dic valueForKey:TOTAL_COST] defaultReturn:@"0.00"] floatValue];
                }
            }
            
            packQtyValueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@"", PackQty];
            
            stockQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", stockQty];
            
            closePackQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", closePack];
            
            closeStockQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", closeStock];
            
            stockValueLbl.text     = [NSString stringWithFormat:@"%@%.2f",@"", stockValue];
            
            //for temporary purpose...
            totalQtyValuelbl.text = [NSString stringWithFormat:@"%@%.2f",@"", closeStock];
            
            totalInventoryValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"", stockValue];
            
        }
        else{
            searchItemsTxt.tag = 0;
            [self textFieldDidChange:searchItemsTxt];
        }
        
        //Recently Added By Bhargav.v on 21/10/2017..
        //Reason: To Display the Records in pagination mode based on the TotalRecords..
        
        
        int strTotalRecords = totalRecords/10;
        
        int remainRecords = totalRecords % 10;
        
        if(remainRecords == 0)
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
        
        else {
            
            for(int i = 1;i<= strTotalRecords;i++){
                
                [pagenationArr addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        
        //Up to Here on 16/10/2017...
        
    } @catch (NSException *exception) {
        
        NSLog(@"--exception in --%@",exception);
        
    } @finally {
        
        if(startIndexNumber == 0){
            pagenationTxt.text = @"1";
        }
        
        [commonDisplayTbl reloadData];
        [HUD setHidden:YES];
        
    }
}


/**
 * @description  handling the successResponse received from the services end....
 * @date
 * @method       getScrapStockErrorResponse:
 * @author
 * @param        NSString
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)getDailyStockReportErrorResponse:(NSString *)errorResponse {
    @try {
        
        if((searchItemsTxt.tag == (searchItemsTxt.text).length)  || ((searchItemsTxt.text).length < 3)){
            
            searchItemsTxt.tag = 0;
            
            // Hiding the HUD....
            [HUD setHidden:YES];
            
            float y_axis = self.view.frame.size.height - 120;
            
            packQtyValueLbl.text   = @"0.0";
            stockQtyValueLbl.text  = @"0.0";
            stockValueLbl.text     = @"0.0";
            
            totalQtyValuelbl.text = @"0.0";
            totalInventoryValueLbl.text = @"0.0";
            
            if(searchItemsTxt.isEditing)
                y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
            
            //NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",responseMessage];
            
            NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        else {
            
            searchItemsTxt.tag = 0;
            [self textFieldDidChange:searchItemsTxt];
        }
        
    } @catch (NSException * exception) {
        
    } @finally {
        [commonDisplayTbl reloadData];
        
        //removing data in the pagenation Array..
        [pagenationArr removeAllObjects];
    }
}

#pragma -mark handling of service calls response used in dropDowns....


/**
 * @description  handling the success response received from server side....
 * @date         03/04/2017
 * @method       getCategorySuccessResponse:
 * @author       Bhargav
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getCategorySuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try   {
        
        
        
        if(categoriesListTbl.tag == 2)
            [categoriesListArr addObject:NSLocalizedString(@"all_categories",nil)];
        else
            [subCategoriesListArr addObject:NSLocalizedString(@"all_subcategories",nil)];
        
        for (NSDictionary * categoryDic in  [sucessDictionary valueForKey:@"categories"]){
            
            if(categoriesListTbl.tag == 2) {
                
                [categoriesListArr addObject:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:@"categoryName"]  defaultReturn:@""]];
            }
            else {
                
                if([categoryTxt.text isEqualToString:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:@"categoryName"]  defaultReturn:@""]] ){
                    
                    if([categoryDic.allKeys containsObject:@"subCategories"] && (![[categoryDic valueForKey:@"subCategories"] isKindOfClass: [NSNull class]]))
                        
                        for (NSDictionary * subCatDic in  [categoryDic valueForKey:@"subCategories"]){
                            
                            [subCategoriesListArr addObject:[self checkGivenValueIsNullOrNil:[subCatDic valueForKey:@"subcategoryName"]  defaultReturn:@""]];
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
 * @description  handling the service call error resposne....
 * @date         03/04/2017
 * @method       getAllDepartmentsErrorResponse:
 * @author       Srinivasulu
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
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  handling the success response received from server side....
 * @date         08/08/2017
 * @method       getProductSubCategoriesSuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)getProductSubCategoriesSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        [sectionArr addObject:NSLocalizedString(@"all_sections",nil)];
        
        
        for (NSDictionary * sectionDic in  [[successDictionary valueForKey:PRODUCT_DETAILS]valueForKey:SUB_CATEGORYSECTIONS]) {
            
            if (sectionDic!= nil) {
                [sectionArr addObject:[self checkGivenValueIsNullOrNil:[sectionDic valueForKey:SECTION_NAME][0] defaultReturn:@""]];
            }
        }
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
    return false;
}

/**
 * @description  handling the success response received from server side....
 * @date         08/08/2017
 * @method       getProductSubCategoriesErrorResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)getProductSubCategoriesErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
    
    return false;
}

/**
 * @description  handling the success response received from server side....
 * @date         08/08/2017
 * @method       getBrandMasterSuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getBrandMasterSuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        
        
        [brandsArr addObject:NSLocalizedString(@"all_brands",nil)];
        
        for (NSDictionary * brand in  [sucessDictionary valueForKey:@"brandDetails" ]) {
            
            [brandsArr addObject:[self checkGivenValueIsNullOrNil:[brand valueForKey:@"bName"]  defaultReturn:@""]];
            
        }
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  handling the service call error resposne....
 * @date         08/08/2017
 * @method       getBrandMasterErrorResponse:
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getBrandMasterErrorResponse:(NSString*)error {
    
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  handling the success response received from server side....
 * @date         31/03/2017
 * @method       getAllDepartmentsSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getDepartmentSuccessResponse:(NSDictionary*)sucessDictionary{
    
    @try{
        
        if ((departmentTxt.text).length == 0)
            
            [departmentListArr addObject:NSLocalizedString(@"all_departments",nil)];
        else
            
            [subDepartmentListArr addObject:NSLocalizedString(@"all_subDepartments",nil)];
        
        if ((departmentTxt.text).length == 0) {
            
            for (NSDictionary * department in [[sucessDictionary valueForKey:kDepartments]valueForKey:kPrimaryDepartment])
                [departmentListArr addObject:department];
            
        }
        else  if ((departmentTxt.text).length > 0) {
            for (NSDictionary * department in  [sucessDictionary valueForKey:kDepartments]) {
                
                
                NSMutableArray * subDepartment = [NSMutableArray new];
                for (NSDictionary * primary in [department valueForKey:SECONDARY_DEPARTMENTS]) {
                    [subDepartment addObject:[primary valueForKey:SECONDARY_DEPARTMENT]];
                    [subDepartmentListArr addObject:[primary valueForKey:SECONDARY_DEPARTMENT]];
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
 * @description  handling the service call error resposne....
 * @date         31/03/2017
 * @method       getAllDepartmentsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getDepartmentErrorResponse:(NSString*)error {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  we are storing the data from the database....
 * @date         22/08/2017
 * @method       getModelSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getModelSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        [modelListArr addObject:NSLocalizedString(@"all_models",nil)];
        
        
        if ([[successDictionary valueForKey:RESPONSE_CODE] intValue] == 0) {
            
            for (NSDictionary * modelDic in [successDictionary valueForKey:@"modelList"]) {
                
                [modelListArr addObject:modelDic];
            }
        }
        
    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  we are displaying the error response...
 * @date         23/08/2017
 * @method       getModelErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getModelErrorResponse:(NSString*)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Handling the Response for GetZones to get the locations based on the ZONE ID...
 * @date         21/09/2016
 * @method       getZonesSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getZonesSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        //here we are reading the Locations based on zone ID and bussiness type......
        [locationArr addObject:NSLocalizedString(@"all_outlets",nil)];
        
        for(NSDictionary * locDic in [[successDictionary valueForKey:ZONE_MASTER_LIST] valueForKey:ZONE_DETAILS][0]) {
            
            if ([[locDic valueForKey:LOCATION_TYPE] caseInsensitiveCompare:RETAIL_OUTLET] == NSOrderedSame) {
                
                [locationArr addObject:[locDic valueForKey:LOCATION]];
            }
            
            //if ([locationArr containsObject:presentLocation]) {
            //[locationArr removeObject:presentLocation];
            //}
        }
        
    } @catch (NSException *exception) {
        NSLog(@"----exception while handling the zoneResponse----%@",exception);
    } @finally {
        [HUD setHidden:YES];
        
    }
}

/**
 * @description  handling the error respone of getZones....
 * @date         21/09/2016
 * @method       getZonesErrorResponse:
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getZonesErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  handling the response of getLocation....
 * @date         21/09/2016
 * @method       getLocationSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocationSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        NSArray * locations = [successDictionary valueForKey:LOCATIONS_DETAILS];
        
        if (locations.count!= 0 && locationArr.count == 0) {
            
            [locationArr addObject:NSLocalizedString(@"all_outlets",nil)];
            for (NSDictionary *locationDic in locations) {
                
                [locationArr addObject:[locationDic  valueForKey:LOCATION_ID]];
            }
            
            if(locationArr.count)
                zoneWiseLocationDic[NSLocalizedString(@"all_outlets",nil)] = locationArr;
        }
        
        else {
            [catPopOver dismissPopoverAnimated:YES];
        }
        
    } @catch (NSException *exception) {
        
        [catPopOver dismissPopoverAnimated:YES];
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

/**
 * @description  handling the error respone of getLocation....
 * @date         21/09/2016
 * @method       getLocationErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [catPopOver dismissPopoverAnimated:YES];
        if(commonDisplayArr.count)
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


-(void)getCategoriesByLocationSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        [locationWiseCategoriesArr addObject:NSLocalizedString(@"all_categories",nil)];
        
        for(NSDictionary * categoryDic in [successDictionary valueForKey:CATEGORY_LIST]) {
            
            [locationWiseCategoriesArr addObject:categoryDic];
        }
        
        categoryTxt.tag = 4;
        
        if (locationWiseCategoriesArr.count) {
            
            [self showAllLocationWiseCategoriesList:nil];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
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

-(void)getCategoriesByLocationErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        
    } @catch (NSException * exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
}


/**
 * @description  Handling the SuccessResponse..
 * @date         20/12/2017
 * @method       getBrandsByLocationSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getBrandsByLocationSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        [locationWiseBrandsArr addObject:NSLocalizedString(@"all_brands",nil)];
        
        for(NSDictionary * brandsDictionary in [successDictionary valueForKey:BRANDS_LIST]) {
            
            [locationWiseBrandsArr addObject:brandsDictionary];
        }
        
        brandTxt.tag = 3;
        
        if (locationWiseBrandsArr.count) {
            
            [self showListOfAllBrands:nil];
        }
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}


/**
 * @description  Handling the Error Response..
 * @date         21/12/2017
 * @method       getBrandsByLocationErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getBrandsByLocationErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
        
    }
    
    
    
}

#pragma mark populate Calendar

/**
 * @description  To create picker frame and set the date inside the dueData textfield.
 * @date         07/08/2017
 * @method       DateButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(IBAction)DateButtonPressed:(UIButton*) sender {
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
        NSDate * now = [NSDate date];
        [myPicker setDate:now animated:YES];
        myPicker.backgroundColor = [UIColor whiteColor];
        
        //        myPicker.datePickerMode = UIDatePickerModeTime;
        
        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        
        //        pickButton.backgroundColor = [UIColor grayColor];
        //        pickButton.backgroundColor = [UIColor clearColor];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
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
                [popover presentPopoverFromRect:startDteTxt.frame inView:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDteTxt.frame inView:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @date         07/08/2017
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
    
    //        BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(sender.tag == 2){
            if((startDteTxt.text).length)
                //                callServices = true;
                
                startDteTxt.text = @"";
        }
        else{
            if((endDteTxt.text).length)
                //                callServices = true;
                
                endDteTxt.text = @"";
        }
        
        //                if(callServices){
        //                    [HUD setHidden:NO];
        //
        //                    requestStartNumber = 0;
        //                    totalNoOfStockRequests = 0;
        //                    [self callingGetPurchaseStockReturns];
        //                }
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
    
}

/**
 * @description   Handle getDate method for pick date from calendar.
 * @date         07/08/2017
 * @method       getDate
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(IBAction)getDate:(UIButton*)sender
{
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
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_endDate",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            startDteTxt.text = dateString;
        }
        else{
            
            if ((endDteTxt.text).length != 0 && ( ![endDteTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDteTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDteTxt.text = @"";
                    
                    [self displayAlertMessage:NSLocalizedString(@"closed_date_should_not_be_earlier_than_created_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
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



#pragma mark SkuVariants View

//Added By Bhargav.v on 13/12/2017....
/**
 * @description  populating UIView to Display the information of selected SKU
 * @date         13/12/2017
 * @method       populateSkuInfoView
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)displaySkuInfoView:(int)rowNumber {
    
    
    
    skuTransparentView = [[UIView alloc] init];
    skuTransparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    UILabel * headerLbl = [[UILabel alloc] init];
    headerLbl.textColor = [UIColor whiteColor];
    headerLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    headerLbl.textAlignment = NSTextAlignmentLeft;
    
    UIButton * closeBtn;
    
    skuDetailsView = [[UIView alloc] init];
    skuDetailsView.opaque = NO;
    skuDetailsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    skuDetailsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    skuDetailsView.layer.borderWidth = 2.0f;
    
    // close button to close the view ..
    UIImage *image = [UIImage imageNamed:@"delete.png"];
    
    closeBtn = [[UIButton alloc] init] ;
    [closeBtn addTarget:self action:@selector(closeSkuDetailsView:) forControlEvents:UIControlEventTouchUpInside];
    
    [closeBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    productImageView = [[UIImageView alloc]init];
    productImageView.clipsToBounds = YES;
    productImageView.layer.cornerRadius = 4.0;
    productImageView.layer.borderWidth = 2.0;
    productImageView.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    UILabel * itemSkuLabel;
    UILabel * measureRangeLbl;
    UILabel * styleLbl;
    UILabel * sizeLbl;
    UILabel * colorLbl;
    UILabel * patternLbl;
    UILabel * descLabel;
    UILabel * locationLbl;
    UILabel * priceLabel;
    UILabel * quantityLabel;
    
    // newly Added By Bhargav.v on 15/05/2018...
    
    UILabel * batchNoLabel;
    
    
    //UILabel *
    
    itemDescriptionLbl = [[UILabel alloc] init];
    itemDescriptionLbl.layer.cornerRadius = 4;
    itemDescriptionLbl.layer.masksToBounds = YES;
    itemDescriptionLbl.numberOfLines = 1;
    itemDescriptionLbl.textAlignment = NSTextAlignmentLeft;
    itemDescriptionLbl.backgroundColor = [UIColor clearColor];
    itemDescriptionLbl.textColor = [UIColor whiteColor];
    
    itemSkuLabel = [[UILabel alloc] init];
    itemSkuLabel.layer.cornerRadius = 4;
    itemSkuLabel.layer.masksToBounds = YES;
    itemSkuLabel.numberOfLines = 1;
    itemSkuLabel.textAlignment = NSTextAlignmentLeft;
    itemSkuLabel.backgroundColor = [UIColor clearColor];
    itemSkuLabel.textColor = [UIColor blackColor];
    
    itemSkuValueLabel = [[UILabel alloc] init];
    itemSkuValueLabel.layer.cornerRadius = 4;
    itemSkuValueLabel.layer.masksToBounds = YES;
    itemSkuValueLabel.numberOfLines = 1;
    itemSkuValueLabel.textAlignment = NSTextAlignmentLeft;
    itemSkuValueLabel.backgroundColor = [UIColor clearColor];
    itemSkuValueLabel.textColor = [UIColor blackColor];
    
    measureRangeLbl = [[UILabel alloc] init];
    measureRangeLbl.layer.cornerRadius = 4;
    measureRangeLbl.layer.masksToBounds = YES;
    measureRangeLbl.numberOfLines = 1;
    measureRangeLbl.textAlignment = NSTextAlignmentLeft;
    measureRangeLbl.backgroundColor = [UIColor clearColor];
    measureRangeLbl.textColor = [UIColor blackColor];
    
    measureRangeValueLbl = [[UILabel alloc] init];
    measureRangeValueLbl.layer.cornerRadius = 4;
    measureRangeValueLbl.layer.masksToBounds = YES;
    measureRangeValueLbl.numberOfLines = 1;
    measureRangeValueLbl.textAlignment = NSTextAlignmentLeft;
    measureRangeValueLbl.backgroundColor = [UIColor clearColor];
    measureRangeValueLbl.textColor = [UIColor blackColor];
    
    styleLbl = [[UILabel alloc] init];
    styleLbl.layer.cornerRadius = 4;
    styleLbl.layer.masksToBounds = YES;
    styleLbl.numberOfLines = 1;
    styleLbl.textAlignment = NSTextAlignmentLeft;
    styleLbl.backgroundColor = [UIColor clearColor];
    styleLbl.textColor = [UIColor blackColor];
    
    styleValueLbl = [[UILabel alloc] init];
    styleValueLbl.layer.cornerRadius = 4;
    styleValueLbl.layer.masksToBounds = YES;
    styleValueLbl.numberOfLines = 1;
    styleValueLbl.textAlignment = NSTextAlignmentLeft;
    styleValueLbl.backgroundColor = [UIColor clearColor];
    styleValueLbl.textColor = [UIColor blackColor];
    
    sizeLbl = [[UILabel alloc] init];
    sizeLbl.layer.cornerRadius = 4;
    sizeLbl.layer.masksToBounds = YES;
    sizeLbl.numberOfLines = 1;
    sizeLbl.textAlignment = NSTextAlignmentLeft;
    sizeLbl.backgroundColor = [UIColor clearColor];
    sizeLbl.textColor = [UIColor blackColor];
    
    sizeValueLbl = [[UILabel alloc] init];
    sizeValueLbl.layer.cornerRadius = 4;
    sizeValueLbl.layer.masksToBounds = YES;
    sizeValueLbl.numberOfLines = 1;
    sizeValueLbl.textAlignment = NSTextAlignmentLeft;
    sizeValueLbl.backgroundColor = [UIColor clearColor];
    sizeValueLbl.textColor = [UIColor blackColor];
    
    colorLbl = [[UILabel alloc] init];
    colorLbl.layer.cornerRadius = 4;
    colorLbl.layer.masksToBounds = YES;
    colorLbl.numberOfLines = 1;
    colorLbl.textAlignment = NSTextAlignmentLeft;
    colorLbl.backgroundColor = [UIColor clearColor];
    colorLbl.textColor = [UIColor blackColor];
    
    colorValueLbl = [[UILabel alloc] init];
    colorValueLbl.layer.cornerRadius = 4;
    colorValueLbl.layer.masksToBounds = YES;
    colorValueLbl.numberOfLines = 1;
    colorValueLbl.textAlignment = NSTextAlignmentLeft;
    colorValueLbl.backgroundColor = [UIColor clearColor];
    colorValueLbl.textColor = [UIColor blackColor];
    
    patternLbl = [[UILabel alloc] init];
    patternLbl.layer.cornerRadius = 4;
    patternLbl.layer.masksToBounds = YES;
    patternLbl.numberOfLines = 1;
    patternLbl.textAlignment = NSTextAlignmentLeft;
    patternLbl.backgroundColor = [UIColor clearColor];
    patternLbl.textColor = [UIColor blackColor];
    
    patternValueLbl = [[UILabel alloc] init];
    patternValueLbl.layer.cornerRadius = 4;
    patternValueLbl.layer.masksToBounds = YES;
    patternValueLbl.numberOfLines = 1;
    patternValueLbl.textAlignment = NSTextAlignmentLeft;
    patternValueLbl.backgroundColor = [UIColor clearColor];
    patternValueLbl.textColor = [UIColor blackColor];
    
    priceLabel = [[UILabel alloc] init];
    priceLabel.layer.cornerRadius = 4;
    priceLabel.layer.masksToBounds = YES;
    priceLabel.numberOfLines = 1;
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.textColor = [UIColor blackColor];
    
    priceValueLabel = [[UILabel alloc] init];
    priceValueLabel.layer.cornerRadius = 4;
    priceValueLabel.layer.masksToBounds = YES;
    priceValueLabel.numberOfLines = 1;
    priceValueLabel.textAlignment = NSTextAlignmentLeft;
    priceValueLabel.backgroundColor = [UIColor clearColor];
    priceValueLabel.textColor = [UIColor blackColor];
    
    descLabel = [[UILabel alloc] init];
    descLabel.layer.cornerRadius = 4;
    descLabel.layer.masksToBounds = YES;
    descLabel.numberOfLines = 1;
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textColor = [UIColor blackColor];
    
    locationLbl = [[UILabel alloc] init];
    locationLbl.layer.cornerRadius = 4;
    locationLbl.layer.masksToBounds = YES;
    locationLbl.numberOfLines = 1;
    locationLbl.textAlignment = NSTextAlignmentLeft;
    locationLbl.backgroundColor = [UIColor clearColor];
    locationLbl.textColor = [UIColor blackColor];
    
    locationValueLbl = [[UILabel alloc] init];
    locationValueLbl.layer.cornerRadius = 4;
    locationValueLbl.layer.masksToBounds = YES;
    locationValueLbl.numberOfLines = 1;
    locationValueLbl.textAlignment = NSTextAlignmentLeft;
    locationValueLbl.backgroundColor = [UIColor clearColor];
    locationValueLbl.textColor = [UIColor blackColor];
    
    
    quantityLabel = [[UILabel alloc] init];
    quantityLabel.layer.cornerRadius = 4;
    quantityLabel.layer.masksToBounds = YES;
    quantityLabel.numberOfLines = 1;
    quantityLabel.textAlignment = NSTextAlignmentLeft;
    quantityLabel.backgroundColor = [UIColor clearColor];
    quantityLabel.textColor = [UIColor blackColor];
    
    quantityValueLabel = [[UILabel alloc] init];
    quantityValueLabel.layer.cornerRadius = 4;
    quantityValueLabel.layer.masksToBounds = YES;
    quantityValueLabel.numberOfLines = 1;
    quantityValueLabel.textAlignment = NSTextAlignmentLeft;
    quantityValueLabel.backgroundColor = [UIColor clearColor];
    quantityValueLabel.textColor = [UIColor blackColor];
    
    batchNoLabel = [[UILabel alloc] init];
    batchNoLabel.layer.cornerRadius = 4;
    batchNoLabel.layer.masksToBounds = YES;
    batchNoLabel.numberOfLines = 1;
    batchNoLabel.textAlignment = NSTextAlignmentLeft;
    batchNoLabel.backgroundColor = [UIColor clearColor];
    batchNoLabel.textColor = [UIColor blackColor];
    
    batchNoValueLabel = [[UILabel alloc] init];
    batchNoValueLabel.layer.cornerRadius = 4;
    batchNoValueLabel.layer.masksToBounds = YES;
    batchNoValueLabel.numberOfLines = 1;
    batchNoValueLabel.textAlignment = NSTextAlignmentLeft;
    batchNoValueLabel.backgroundColor = [UIColor clearColor];
    batchNoValueLabel.textColor = [UIColor blackColor];


    descriptionView = [[UITextView alloc]init];
    descriptionView.backgroundColor = [UIColor whiteColor];
    descriptionView.scrollEnabled = YES;
    descriptionView.clipsToBounds = YES;
    descriptionView.delegate = self;
    descriptionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    UIButton * showItemsBtn;
    UIButton * addItemsBtn;
    
    /*Creation of UIImage used for button backgrounds*/
    UIImage * dropDownButtonImage = [UIImage imageNamed:@"arrow.png"];
    
    itemText = [[UITextField alloc] init];
    itemText.borderStyle = UITextBorderStyleBezel;
    itemText.textColor = [UIColor blackColor];
    itemText.userInteractionEnabled = NO;
    
    showItemsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showItemsBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showItemsBtn addTarget:self action:@selector(showQuantityList:) forControlEvents:UIControlEventTouchDown];
    
    addItemsBtn = [[UIButton alloc] init];
    [addItemsBtn addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchDown];
    addItemsBtn.layer.cornerRadius = 3.0f;
    addItemsBtn.backgroundColor = [UIColor grayColor];
    [addItemsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //headerLbl.text =  NSLocalizedString(@"sku_information", nil);
    
    itemSkuLabel.text    = NSLocalizedString(@"sku_id:",nil);
    measureRangeLbl.text = NSLocalizedString(@"range",nil);
    styleLbl.text        = NSLocalizedString(@"style_",nil);
    sizeLbl.text         = NSLocalizedString(@"size",nil);
    colorLbl.text        = NSLocalizedString(@"colour",nil);
    patternLbl.text      = NSLocalizedString(@"pattern",nil);
    descLabel.text       = NSLocalizedString(@"description",nil);
    priceLabel.text      = NSLocalizedString(@"price:", nil);
    locationLbl.text     = NSLocalizedString(@"location_",nil);
    quantityLabel.text   = NSLocalizedString(@"quantity:", nil);
    batchNoLabel.text    = NSLocalizedString(@"batch_no",nil);
    
    [addItemsBtn  setTitle: NSLocalizedString(@"add", nil) forState:UIControlStateNormal];
    
    
    [skuDetailsView addSubview:headerLbl];
    [skuDetailsView addSubview:itemDescriptionLbl];
    [skuDetailsView addSubview:closeBtn];
    
    [skuDetailsView addSubview:productImageView];
    
    [skuDetailsView addSubview:itemSkuLabel];
    [skuDetailsView addSubview:itemSkuValueLabel];
    
    [skuDetailsView addSubview:measureRangeLbl];
    [skuDetailsView addSubview:measureRangeValueLbl];
    
    [skuDetailsView addSubview:styleLbl];
    [skuDetailsView addSubview:styleValueLbl];
    
    [skuDetailsView addSubview:sizeLbl];
    [skuDetailsView addSubview:sizeValueLbl];
    
    [skuDetailsView addSubview:colorLbl];
    [skuDetailsView addSubview:colorValueLbl];
    
    [skuDetailsView addSubview:patternLbl];
    [skuDetailsView addSubview:patternValueLbl];
    
    [skuDetailsView addSubview:descLabel];
    
    [skuDetailsView  addSubview:descriptionView];
    
    [skuDetailsView addSubview:locationLbl];
    [skuDetailsView addSubview:locationValueLbl];
    
    [skuDetailsView addSubview:priceLabel];
    [skuDetailsView addSubview:priceValueLabel];
    
    [skuDetailsView addSubview:quantityLabel];
    [skuDetailsView addSubview:quantityValueLabel];
    
    [skuDetailsView addSubview:batchNoLabel];
    [skuDetailsView addSubview:batchNoValueLabel];
    
    [skuDetailsView addSubview:itemText];
    [skuDetailsView addSubview:showItemsBtn];
    [skuDetailsView addSubview:addItemsBtn];
    
    //Adding skuDetailsView to the transparentView
    [skuTransparentView addSubview:skuDetailsView];
    
    //Adding transparentView to the main view..
    [self.view addSubview:skuTransparentView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
        }
        else{
        }
        
        skuTransparentView.frame = self.view.frame;
        
        headerLbl.frame = CGRectMake( 0, 0, skuTransparentView.frame.size.width - 280, 40);
        
        itemDescriptionLbl.frame = CGRectMake(8, 5, 400, 30);
        
        closeBtn.frame =  CGRectMake( headerLbl.frame.size.width - 43, 0, 40, 40);
        
        skuDetailsView.frame = CGRectMake((skuTransparentView.frame.size.width - headerLbl.frame.size.width) / 2.5, (skuTransparentView.frame.size.height - (commonDisplayTbl.frame.origin.y +  commonDisplayTbl.frame.size.height))/1.6, headerLbl.frame.size.width, commonDisplayTbl.frame.origin.y +  commonDisplayTbl.frame.size.height+30);
        
        productImageView.frame = CGRectMake( 10, headerLbl.frame.origin.y + headerLbl.frame.size.height + 5 , 290 , 290 );
        
        itemSkuLabel.frame = CGRectMake( productImageView.frame.origin.x + productImageView.frame.size.width+10, productImageView.frame.origin.y, 50, 30);
        
        itemSkuValueLabel.frame = CGRectMake( itemSkuLabel.frame.origin.x + itemSkuLabel.frame.size.width+20,itemSkuLabel.frame.origin.y,180,30);
        
        measureRangeLbl.frame = CGRectMake( itemSkuLabel.frame.origin.x, itemSkuLabel.frame.origin.y + itemSkuLabel.frame.size.height -5 , 200, 30);
        
        measureRangeValueLbl.frame = CGRectMake( itemSkuValueLabel.frame.origin.x,measureRangeLbl.frame.origin.y,itemSkuValueLabel.frame.size.width,30);
        
        styleLbl.frame = CGRectMake(measureRangeLbl.frame.origin.x,measureRangeLbl.frame.origin.y + measureRangeLbl.frame.size.height -5,measureRangeLbl.frame.size.width,30);
        
        styleValueLbl.frame  = CGRectMake(itemSkuValueLabel.frame.origin.x, styleLbl.frame.origin.y, 100, 30);
        
        sizeLbl.frame = CGRectMake(styleLbl.frame.origin.x, styleLbl.frame.origin.y + styleLbl.frame.size.height -5, styleLbl.frame.size.width,30);
        
        sizeValueLbl.frame = CGRectMake(styleValueLbl.frame.origin.x, sizeLbl.frame.origin.y, styleValueLbl.frame.size.width ,30);
        
        
        colorLbl.frame = CGRectMake(sizeLbl.frame.origin.x,sizeLbl.frame.origin.y + sizeLbl.frame.size.height -5, sizeLbl.frame.size.width, 30);
        
        colorValueLbl.frame = CGRectMake(sizeValueLbl.frame.origin.x, colorLbl.frame.origin.y,sizeValueLbl.frame.size.width,30);
        
        patternLbl.frame = CGRectMake(sizeLbl.frame.origin.x,colorLbl.frame.origin.y + colorLbl.frame.size.height -5, colorLbl.frame.size.width, 30);
        
        patternValueLbl.frame = CGRectMake(colorValueLbl.frame.origin.x, patternLbl.frame.origin.y,sizeValueLbl.frame.size.width,30);
        
        descLabel.frame = CGRectMake(patternLbl.frame.origin.x,patternLbl.frame.origin.y + patternLbl.frame.size.height -5, colorLbl.frame.size.width, 30);
        
        descriptionView.frame = CGRectMake(itemSkuLabel.frame.origin.x,descLabel.frame.origin.y+descLabel.frame.size.height- 5, productImageView.frame.size.width + 140, 150);
        
        locationLbl.frame = CGRectMake(styleValueLbl.frame.origin.x+styleValueLbl.frame.size.width+40, styleValueLbl.frame.origin.y,120,30);
        
        locationValueLbl.frame = CGRectMake(locationLbl.frame.origin.x+locationLbl.frame.size.width-45,locationLbl.frame.origin.y,140,30);
        
        
        //Added on 25/05/2018...
        
        batchNoLabel.frame = CGRectMake(locationLbl.frame.origin.x,descLabel.frame.origin.y,110,30);
        batchNoValueLabel.frame = CGRectMake(locationValueLbl.frame.origin.x, batchNoLabel.frame.origin.y,100,30);
        
        priceLabel.frame = CGRectMake(locationLbl.frame.origin.x,colorLbl.frame.origin.y,80,30);
        
        priceValueLabel.frame = CGRectMake(locationValueLbl.frame.origin.x, priceLabel.frame.origin.y, 100, 30);
        
        quantityLabel.frame = CGRectMake(priceLabel.frame.origin.x, priceLabel.frame.origin.y+priceLabel.frame.size.height - 5, 120, 30);
        
        quantityValueLabel.frame = CGRectMake(priceValueLabel.frame.origin.x,quantityLabel.frame.origin.y,80,30);
        
        itemText.frame    = CGRectMake((productImageView.frame.size.width)/2.7,productImageView.frame.origin.y + productImageView.frame.size.height + 10, 75, 30);
        
        //setting frame for UIButton's....
        showItemsBtn.frame = CGRectMake(itemText.frame.origin.x + itemText.frame.size.width - 40, itemText.frame.origin.y - 8, 40, 45);
        
        addItemsBtn.frame = CGRectMake(itemText.frame.origin.x+itemText.frame.size.width+5,itemText.frame.origin.y,110,itemText.frame.size.height);
        
    }
    
    else{
        
        // DO CODING FOR IPHONE....
    }
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:skuDetailsView andSubViews:YES fontSize:15.0f cornerRadius:3.0f];
    
    itemDescriptionLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    addItemsBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
    
    
    
    @try {
        
        NSString * string = [skuListsArr[rowNumber] valueForKey:SKU_IMAGE];
        
        string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/" ];
        NSURL *url = [NSURL URLWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@"%20" ]];
        //NSURL *url = [NSURL URLWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@"%20" ]];
        
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if ([UIImage imageWithData:data]) {
                productImageView.image = [UIImage imageWithData:data];
            }
            else{
                
                productImageView.image = [UIImage imageNamed:@"no-image.png"];
            }
        }];
        if ([NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:url]])] == nil) {
            productImageView.image = [UIImage imageNamed:@"no-image.png"];
            
        }
        
        itemDescriptionLbl.text = [self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber] valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
        
        itemSkuValueLabel.text = [self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber] valueForKey:ITEM_SKU] defaultReturn:@"--"];
        
        measureRangeValueLbl.text = [self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber] valueForKey:kMeasureRange] defaultReturn:@"--"];
        
        styleValueLbl.text = [self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber] valueForKey:MODEL] defaultReturn:@"--"];
        
        colorValueLbl.text = [self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber] valueForKey:COLOR] defaultReturn:@"--"];
        
        patternValueLbl.text = @"--";
        
        descriptionView.text = [self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber] valueForKey:PRODUCT_DESCRIPTION] defaultReturn:@"--"];
        
        priceValueLabel.text = [NSString stringWithFormat:@"%@%.2f",NSLocalizedString(@"currency_symbol", nil),[[self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber] valueForKey:SALE_PRICE] defaultReturn:@"--"] floatValue]];
        
        quantityValueLabel.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber]valueForKey:QUANTITY ] defaultReturn:@"0.00"] floatValue]];
        
        batchNoValueLabel.text = [self checkGivenValueIsNullOrNil:[skuListsArr[rowNumber] valueForKey:PRODUCT_BATCH_NO] defaultReturn:@"--"];

        
       //
        locationValueLbl.text = locationTxt.text;
        
        NSMutableArray * buttonsArr = [NSMutableArray new];
        
        for (int skuListCount = 0 ; skuListCount<(int)skuListsArr.count; skuListCount++) {
            
            [buttonsArr addObject: [NSString stringWithFormat:@"%i", skuListCount + 1]];
        }
        //Up to here on 16/10/2017...
        
        [self populateButtons:buttonsArr];
        
        //Assigining the totalQuantity to display the
        
        totalQuantity = (int)[[skuListsArr valueForKey:QUANTITY][0] floatValue];
        
        
        quantityArr = [NSMutableArray new];
        
        for(int i = 1;i <= totalQuantity;i++) {
            
            if (i > 100)
                break;
            [quantityArr addObject:[NSString stringWithFormat:@"%i",i]];
        }
        
        if (quantityArr == nil || quantityArr.count == 0) {
            
            itemText.text = nil;
        }
        else {
            itemText.text = @"1";
        }
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
    
}




/**
 * @description  populating the UIButtons through the for loop
 * @date         19/12/2017
 * @method       populateUIButtons.
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)populateButtons:(NSArray *)buttonsArr {
    
    @try {
        
        int index = 0;
        
        float xposition = 0;
        
        skuVariantScrollView  = [[UIScrollView alloc]init];
        //skuVariantScrollView.backgroundColor = [UIColor blackColor];
        
        /*Creation of UIButton's used in this cell*/
        nextButton = [[UIButton alloc] init];
        nextButton.titleLabel.textColor = [UIColor whiteColor];
        nextButton.userInteractionEnabled = YES;
        [nextButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
        nextButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];
        nextButton.tag = 0;

        [nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //Setting button Title....
        [nextButton setTitle:NSLocalizedString(@"next",nil) forState:UIControlStateNormal];
        
        /*Creation of UIButton's used in this cell*/
        previousButton = [[UIButton alloc] init];
        previousButton.titleLabel.textColor = [UIColor whiteColor];
        previousButton.userInteractionEnabled = YES;
        [previousButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
        previousButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];
        [previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //Setting button Title....
        [previousButton setTitle:NSLocalizedString(@"previous_button",nil) forState:UIControlStateNormal];
        
        int i = 0;
        
        UIButton * skuButton;
        for (NSString * str in buttonsArr) {
            
            skuButton  = [[UIButton alloc]init];
            [skuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [skuButton setBackgroundImage:[UIImage imageNamed:@"Button1.png"] forState:UIControlStateNormal];
            skuButton.backgroundColor = [UIColor whiteColor];
            skuButton.layer.borderColor = [UIColor blackColor].CGColor;
            skuButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
            skuButton.layer.cornerRadius = skuButton.frame.size.height/2.0;
            skuButton.layer.masksToBounds = true;
            skuButton.tag = i;
            i++;

            //skuButton = [[UIButton alloc]init];
            //skuButton.layer.shadowColor = [UIColor blackColor].CGColor;
            //skuButton.layer.shadowOffset = CGSizeMake(0.0, 2.0);
            //skuButton.layer.masksToBounds = false;
            //skuButton.layer.shadowRadius = 1.0;
            //skuButton.layer.shadowOpacity = 0.5;
            //skuButton.layer.cornerRadius = skuButton.frame.size.height / 2;
            //skuButton.layer.masksToBounds = true;
            
            //if (!(i = 0))
            //[skuButton setBackgroundImage:[UIImage imageNamed:@"Button1.png"] forState:UIControlStateNormal];
            
            [skuButton setTitle:[NSString stringWithFormat:@"%@",str] forState:UIControlStateNormal];
            
            [skuButton addTarget:self action:@selector(showSkuVariants:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                skuVariantScrollView.frame = CGRectMake(515, itemSkuValueLabel.frame.origin.y,222,40);
                skuButton.frame = CGRectMake(xposition,5,30,30);
                
                //skuVariantScrollView.frame.size.width
                
                if (skuListsArr.count > 7)
                    nextButton.frame =CGRectMake(skuDetailsView.frame.size.width - 60,skuVariantScrollView.frame.origin.y+skuVariantScrollView.frame.size.height-10,60,30);
                
                [skuDetailsView addSubview:skuVariantScrollView];
                [skuVariantScrollView addSubview:skuButton];
                [skuDetailsView addSubview:nextButton];
                [skuDetailsView addSubview:previousButton];
            }
            
            // xposition  = button.frame.size.width + 2;
            xposition = xposition + skuButton.frame.size.width + 2;
            index++;
        }
        
        skuVariantScrollView.contentSize = CGSizeMake( skuButton.frame.origin.x + skuButton.frame.size.width, skuVariantScrollView.frame.size.height);
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  Displaying Varoius Sku variants..
 * @date         1/101/2017
 * @method       showSkuVariants
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)showSkuVariants:(UIButton *)sender {
    //Play audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        int index = (int)sender.tag;
       
        nextButton.tag = sender.tag;

        NSObject * object = skuListsArr[index];
        
        NSString * string = [object valueForKey:SKU_IMAGE];
        
        string      = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/" ];
        NSURL * url = [NSURL URLWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@"%20" ]];
        
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if ([UIImage imageWithData:data]) {
                productImageView.image = [UIImage imageWithData:data];
            }
            else{
                
                productImageView.image = [UIImage imageNamed:@"no-image.png"];
            }
        }];
        if ([NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:url]])] == nil) {
            productImageView.image = [UIImage imageNamed:@"no-image.png"];
            
        }
        
        itemDescriptionLbl.text = [self checkGivenValueIsNullOrNil:[object valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
        
        itemSkuValueLabel.text = [self checkGivenValueIsNullOrNil:[object valueForKey:ITEM_SKU] defaultReturn:@"--"];
        
        colorValueLbl.text = [self checkGivenValueIsNullOrNil:[object valueForKey:COLOR] defaultReturn:@"--"];
        
        measureRangeValueLbl.text = [self checkGivenValueIsNullOrNil:[object valueForKey:kMeasureRange] defaultReturn:@"--"];
        
        styleValueLbl.text = [self checkGivenValueIsNullOrNil:[object valueForKey:MODEL] defaultReturn:@"--"];
        
        patternValueLbl.text = @"--";
        
        descriptionView.text = [self checkGivenValueIsNullOrNil:[object valueForKey:PRODUCT_DESCRIPTION] defaultReturn:@"--"];
        
        priceValueLabel.text = [NSString stringWithFormat:@"%@%.2f",NSLocalizedString(@"currency_symbol", nil),[[self checkGivenValueIsNullOrNil:[object valueForKey:SALE_PRICE] defaultReturn:@"--"] floatValue]];
        
        quantityValueLabel.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[object valueForKey:QUANTITY ] defaultReturn:@"0.00"] floatValue]];
        
        batchNoValueLabel.text = [self checkGivenValueIsNullOrNil:[object valueForKey:PRODUCT_BATCH_NO] defaultReturn:@"--"];
        
        locationValueLbl.text = locationTxt.text;
        
        totalQuantity = (int)[[object valueForKey:QUANTITY] integerValue];
        
        quantityArr = [NSMutableArray new];
        
        for(int i = 1;i <= totalQuantity;i++) {
            
            [quantityArr addObject:[NSString stringWithFormat:@"%i",i]];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {

        
        
    }
}

/**
 * @description  Displaying Sku variants....
 * @date         1/101/2017
 * @method       nextButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)nextButtonPressed:(UIButton *)sender {
    
    //Play audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float origin_x = skuVariantScrollView.contentOffset.x + 32;
        
        if(skuVariantScrollView.contentOffset.x < skuVariantScrollView.contentSize.width)
            skuVariantScrollView.contentOffset = CGPointMake(origin_x, 0);
        
        if(skuVariantScrollView.contentOffset.x > 23){
            
            previousButton.hidden = NO;
            previousButton.frame = CGRectMake(skuVariantScrollView.frame.origin.x-5, skuVariantScrollView.frame.origin.y+skuVariantScrollView.frame.size.height-10,60,30);
        }
        else{
            
            previousButton.hidden = YES;
        }
        
        
    } @catch (NSException * exception) {
        
    }
}


/**
 * @description  scrolling the buttons with a button functionality.....
 * @date         19/01/2018
 * @method       previousButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)previousButtonPressed:(UIButton *)sender {
    
    //play Audio for Button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        float origin_x = 0;
        
        if(skuVariantScrollView.contentOffset.x > 0)
            origin_x = skuVariantScrollView.contentOffset.x - 32;
        
        skuVariantScrollView.contentOffset = CGPointMake(origin_x, 0);
        
        if(skuVariantScrollView.contentOffset.x <= 0){
            
            
            previousButton.hidden = YES;
        }
        
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  changing the ButtonFrame base on user gesture....
 * @date         14/06/2016
 * @method       pan
 * @author       Srinivasulu
 * @param        UIPanGestureRecognizer
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)pan:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint point = [recognizer locationInView:normalStockVeiw];
    if ((point.x >= -10 && point.x < (normalStockVeiw.frame.size.width - cartBtn.frame.size.width) + 10) || (point.y <=(normalStockVeiw.frame.size.height - cartBtn.frame.size.height) + 10  && point.y >= -10)) {
        CGRect newframe = CGRectMake( point.x, point.y, cartBtn.frame.size.width, cartBtn.frame.size.height);
        cartBtn.frame = newframe;
        newframe = CGRectMake( point.x, point.y, cartBtn.frame.size.width, cartBtn.frame.size.height);
        
        if(recognizer.state == UIGestureRecognizerStateEnded)
        {
            CGRect frameone  = CGRectMake( point.x, point.y, cartBtn.frame.size.width, cartBtn.frame.size.height);
            if (point.x < 00) {
                frameone = CGRectMake( 00, point.y, cartBtn.frame.size.width, cartBtn.frame.size.height);
                
            }
            else if(point.y < 00){
                frameone = CGRectMake( point.x, 0, cartBtn.frame.size.width, cartBtn.frame.size.height);
            }
            else if(point.x > (normalStockVeiw.frame.size.width - cartBtn.frame.size.width)){
                frameone = CGRectMake( (normalStockVeiw.frame.size.width - cartBtn.frame.size.width), point.y, cartBtn.frame.size.width, cartBtn.frame.size.height);
                
            }
            else if(point.y > (normalStockVeiw.frame.size.height - cartBtn.frame.size.height)){
                frameone = CGRectMake( point.x,(normalStockVeiw.frame.size.height - cartBtn.frame.size.height), cartBtn.frame.size.width, cartBtn.frame.size.height);
                
            }
            cartBtn.frame = frameone;
        }
    }
}


/*
 * @description  showing the quantity list
 * @date         20/01/2018
 * @method       showQuantityList
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)showQuantityList:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if (quantityArr == nil || quantityArr.count == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"stock_not_available", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        
       else if (quantityArr.count) {
            float tableHeight = quantityArr.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = quantityArr.count * 33;
            
            if(quantityArr.count > 5)
                tableHeight = (tableHeight/quantityArr.count) * 5;
            
            [self showPopUpForTables:quantityTblView  popUpWidth:(itemText.frame.size.width ) popUpHeight:tableHeight presentPopUpAt:itemText  showViewIn:skuDetailsView permittedArrowDirections:UIPopoverArrowDirectionRight];
        }
        else
        [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the stockReceiptView in showAllOutletId:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
}


/**
 * @description  adding items to the cart which will lock the added items in the other store...
 * @date         19/01/2017
 * @method       addToCart
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)addToCart:(UIButton *)sender {
    
    // play audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    if ((itemText.text).length > 0) {
        
        @try {
            
            NSMutableDictionary * selectItemDic = [skuListsArr[nextButton.tag] mutableCopy];
            
            bool  isNewItem = true;
            
            int itemSno = 0;
            
            for(itemSno = 0; itemSno < CartItemsArray.count; itemSno++){
                
                NSDictionary * existItemDic  = CartItemsArray[itemSno];
                
                if ([[existItemDic valueForKey:ITEM_SKU] isEqualToString:[selectItemDic valueForKey:ITEM_SKU]] && [[existItemDic valueForKey:PLU_CODE] isEqualToString:[selectItemDic valueForKey:PLU_CODE]]) {
                    
                    isNewItem = false;
                    break;
                }
            }
            
            [selectItemDic setValue:itemText.text  forKey:BILLED_QUANTITY];
            
            if(isNewItem){
                
                [CartItemsArray addObject:selectItemDic];
                
                //Sound File Object after Adding the Stock to The Cart..
                SystemSoundID    soundFileObject1;
                NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
                
            }
            else {
                
                CartItemsArray[itemSno] = selectItemDic;
            }
            
        } @catch (NSException * exception) {
            
        } @finally {
            
            cartBtn.badgeValue = [NSString stringWithFormat:@"%li", CartItemsArray.count];
            
        }
    }
    
    else {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_add_items_to_the_cart", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
}

/**
 * @description  Dismissing the closeSkuDetailsView....
 * @date         13/12/2017
 * @method       closeSkuDetailsView:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @modified By
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)closeSkuDetailsView:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        skuTransparentView.hidden = YES;
        
        if ([skuTransparentView isDescendantOfView:self.view])
            [skuTransparentView removeFromSuperview];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)navigateBillingPage:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(CartItemsArray.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_add_items_to_the_cart", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

        }

        else {
            
            BillingHome * bhPage = [[BillingHome alloc] init];
            bhPage.itemsFromCartArr = CartItemsArray;
            
            [self.navigationController pushViewController:bhPage animated:YES];
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


#pragma -mark start of UITableViewDelegateMethods..



/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         31/03/2017
 * @method       tableView: numberOfRowsInSectionL
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    //it sideMenu table....
    if (tableView == sideMenuTable) {
        return sidemenuTitles.count;
    }
    else if(tableView == departmentListTbl){
        
        return departmentListArr.count;
        
    }
    else if(tableView == subDepartmentListTbl){
        
        return subDepartmentListArr.count;
        
    }
    else if(tableView == categoriesListTbl){
        
        return locationWiseCategoriesArr.count;
        
    }
    else if(tableView == subCategoriesListTbl){
        
        return subCategoriesListArr.count;
        
    }
    else if(tableView == brandsTbl){
        
        return locationWiseBrandsArr.count;
        
    }
    else if(tableView == supplierListTbl){
        
        return supplierListArr.count;
        
    }
    else if(tableView == sectionTbl){
        
        return sectionArr.count;
    }
    
    else if(tableView == modelTable){
        
        return modelListArr.count;
    }
    
    else if(tableView == locationTable){
        
        //if(locationTxt.tag == 0)
        return locationArr.count;
        //else
        //return [zoneListArr count];
    }
    
    else if(tableView == pagenationTbl){
        
        return pagenationArr.count;
    }
    else if (tableView == quantityTblView) {
        
        return quantityArr.count;
    }
    
    else if(tableView == commonDisplayTbl){
        
        if(commonDisplayArr.count)
            
            return  commonDisplayArr.count;
        else
            
            return 1;
    }
    else
        return  0;
}


/**
 * @description  it is tableViewDelegate method it will execute and return height in Table.....
 * @date         15/03/2017
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
    
    if(tableView == sideMenuTable){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 70;
        }
        else {
            return 90.0;
        }
    }
    
    else if(tableView == commonDisplayTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 32;
        }
        else {
            return 90.0;
        }
    }
    
    else if (tableView == categoriesListTbl || tableView == subCategoriesListTbl || tableView == brandsTbl ||tableView == sectionTbl ||tableView == departmentListTbl ||tableView == subDepartmentListTbl ||tableView == supplierListTbl || tableView == modelTable || tableView == pagenationTbl || tableView == locationTable ||tableView == quantityTblView) {
        
        return 35;
    }
    
    else
        return 0;
}

/**
 * @description  it is tableViewDelegate method it will execute and return cell in Table.....
 * @date         15/03/2017
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @return       UITableViewCell
 * @verified By
 * @verified On
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if (tableView == sideMenuTable) {
        
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
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
                hlcell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            tableView.separatorColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
            
            @try {
                hlcell.imageView.image = [UIImage imageNamed:sidemenuImages[indexPath.row]];
                hlcell.textLabel.text = [NSString stringWithFormat:@"%@",sidemenuTitles[indexPath.row]];
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    hlcell.imageView.frame = CGRectMake(hlcell.imageView.frame.origin.x, hlcell.imageView.frame.origin.y, 30, 30);
                }
                else {
                    hlcell.textLabel.font = [UIFont systemFontOfSize:12.0];
                }
                hlcell.backgroundColor = [UIColor clearColor];
            }
            
            @catch(NSException * e) {
                
                NSLog(@"%@",e);
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
            return hlcell;
        }
    }
    
    else if(tableView == commonDisplayTbl) {
        
        if(([selectedStockTypeStr isEqualToString:NSLocalizedString(@"available_stock", nil)]) || ([selectedStockTypeStr isEqualToString:NSLocalizedString(@"critical_stock", nil)])) {
            
            static NSString * CellIdentifier = @"Available Stock";
            
            UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
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
            
            @try {
                UILabel * slNoLbl_1;
                UILabel * skuIdLbl_1;
                UILabel * description_1;
                UILabel * colorLbl_1;
                UILabel * sizeLbl_1;
                UILabel * measureRangeLbl_1;
                UILabel * gradeLbl_1;
                UILabel * eanLbl_1;
                UILabel * categoryLbl_1;
                UILabel * reorderPointLbl_1;
                UILabel * uomLbl_1;
                UILabel * packQtyLbl_1;
                UILabel * stockQtyLbl_1;
                UILabel * costPriceLbl_1;
                UILabel * itemQtyInhandLbl;
                
                UIProgressView * itemprice;
                
                itemprice = [[UIProgressView alloc] init];
                itemprice.trackTintColor = [UIColor whiteColor];
                
                UIColor * progressColor = [UIColor colorWithRed:60.0/255 green:127.0/255 blue:4.0/255 alpha:1.0];
                
                itemprice.progressTintColor = progressColor;
                
                /*creation of UIButton's*/
                UIButton * itemsSummaryBtn;
                
                
                itemsSummaryBtn = [[UIButton alloc] init];
                [itemsSummaryBtn addTarget:self action:@selector(navigateToStockCard:) forControlEvents:UIControlEventTouchDown];
                itemsSummaryBtn.layer.cornerRadius = 3.0f;
                itemsSummaryBtn.backgroundColor = [UIColor clearColor];
                [itemsSummaryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                itemsSummaryBtn.userInteractionEnabled = NO;
                itemsSummaryBtn.tag = indexPath.row;
                
                slNoLbl_1 = [[UILabel alloc] init];
                slNoLbl_1.backgroundColor = [UIColor clearColor];
                slNoLbl_1.layer.borderWidth = 0;
                slNoLbl_1.textAlignment = NSTextAlignmentCenter;
                slNoLbl_1.numberOfLines = 1;
                slNoLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                skuIdLbl_1 = [[UILabel alloc] init];
                skuIdLbl_1.backgroundColor = [UIColor clearColor];
                skuIdLbl_1.textAlignment = NSTextAlignmentCenter;
                skuIdLbl_1.numberOfLines = 1;
                skuIdLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                description_1 = [[UILabel alloc] init];
                description_1.backgroundColor = [UIColor clearColor];
                description_1.textAlignment = NSTextAlignmentCenter;
                description_1.numberOfLines = 1;
                description_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                colorLbl_1 = [[UILabel alloc] init];
                colorLbl_1.backgroundColor = [UIColor clearColor];
                colorLbl_1.textAlignment = NSTextAlignmentCenter;
                colorLbl_1.numberOfLines = 1;
                colorLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                sizeLbl_1 = [[UILabel alloc] init];
                sizeLbl_1.backgroundColor = [UIColor clearColor];
                sizeLbl_1.textAlignment = NSTextAlignmentCenter;
                sizeLbl_1.numberOfLines = 1;
                sizeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                measureRangeLbl_1 = [[UILabel alloc] init];
                measureRangeLbl_1.backgroundColor = [UIColor clearColor];
                measureRangeLbl_1.textAlignment = NSTextAlignmentCenter;
                measureRangeLbl_1.numberOfLines = 1;
                measureRangeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                gradeLbl_1 = [[UILabel alloc] init];
                gradeLbl_1.backgroundColor = [UIColor clearColor];
                gradeLbl_1.textAlignment = NSTextAlignmentCenter;
                gradeLbl_1.numberOfLines = 1;
                gradeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                eanLbl_1 = [[UILabel alloc] init];
                eanLbl_1.backgroundColor = [UIColor clearColor];
                eanLbl_1.textAlignment = NSTextAlignmentCenter;
                eanLbl_1.numberOfLines = 1;
                eanLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                categoryLbl_1 = [[UILabel alloc] init];
                categoryLbl_1.backgroundColor = [UIColor clearColor];
                categoryLbl_1.textAlignment = NSTextAlignmentCenter;
                categoryLbl_1.numberOfLines = 1;
                categoryLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                reorderPointLbl_1 = [[UILabel alloc] init];
                reorderPointLbl_1.backgroundColor = [UIColor clearColor];
                reorderPointLbl_1.textAlignment = NSTextAlignmentCenter;
                reorderPointLbl_1.numberOfLines = 1;
                reorderPointLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                uomLbl_1 = [[UILabel alloc] init];
                uomLbl_1.backgroundColor = [UIColor clearColor];
                uomLbl_1.textAlignment = NSTextAlignmentCenter;
                uomLbl_1.numberOfLines = 1;
                uomLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                packQtyLbl_1 = [[UILabel alloc] init];
                packQtyLbl_1.backgroundColor = [UIColor clearColor];
                packQtyLbl_1.textAlignment = NSTextAlignmentCenter;
                packQtyLbl_1.numberOfLines = 1;
                packQtyLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                
                stockQtyLbl_1 = [[UILabel alloc] init];
                stockQtyLbl_1.backgroundColor = [UIColor clearColor];
                stockQtyLbl_1.textAlignment = NSTextAlignmentCenter;
                stockQtyLbl_1.numberOfLines = 1;
                stockQtyLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                costPriceLbl_1 = [[UILabel alloc] init];
                costPriceLbl_1.backgroundColor = [UIColor clearColor];
                costPriceLbl_1.textAlignment = NSTextAlignmentCenter;
                costPriceLbl_1.numberOfLines = 1;
                costPriceLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                itemQtyInhandLbl = [[UILabel alloc] init];
                itemQtyInhandLbl.backgroundColor = [UIColor clearColor];
                itemQtyInhandLbl.textAlignment = NSTextAlignmentCenter;
                itemQtyInhandLbl.numberOfLines = 1;
                itemQtyInhandLbl.lineBreakMode = NSLineBreakByTruncatingTail;
                
                slNoLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                skuIdLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                description_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                colorLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                sizeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                measureRangeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                gradeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                eanLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                categoryLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                reorderPointLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                uomLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                packQtyLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                stockQtyLbl_1.textColor = [UIColor orangeColor];
                itemQtyInhandLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                costPriceLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                [hlcell.contentView addSubview:slNoLbl_1];
                [hlcell.contentView addSubview:skuIdLbl_1];
                [hlcell.contentView addSubview:description_1];
                [hlcell.contentView addSubview:colorLbl_1];
                [hlcell.contentView addSubview:sizeLbl_1];
                [hlcell.contentView addSubview:measureRangeLbl_1];
                [hlcell.contentView addSubview:gradeLbl_1];
                [hlcell.contentView addSubview:eanLbl_1];
                [hlcell.contentView addSubview:categoryLbl_1];
                [hlcell.contentView addSubview:reorderPointLbl_1];
                [hlcell.contentView addSubview:uomLbl_1];
                [hlcell.contentView addSubview:packQtyLbl_1];
                [hlcell.contentView addSubview:costPriceLbl_1];
                
                [hlcell.contentView addSubview:itemprice];
                [hlcell.contentView addSubview:stockQtyLbl_1];
                
                [hlcell.contentView addSubview:itemQtyInhandLbl];
                [hlcell.contentView addSubview:itemsSummaryBtn];
                
                //setting frame and font........
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    //                if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                    //                }
                    //                else{
                    //
                    //
                    //
                    //                }
                    
                    itemprice.transform = CGAffineTransformMakeScale( 1.0, 10.0);
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
                    
                    
                    slNoLbl_1.frame = CGRectMake( 0, 0, [labelSidesArr[0] floatValue], hlcell.frame.size.height);
                    
                    skuIdLbl_1.frame = CGRectMake(slNoLbl_1.frame.origin.x + slNoLbl_1.frame.size.width + 2, 0, [labelSidesArr[1] floatValue],  slNoLbl_1.frame.size.height);
                    
                    description_1.frame = CGRectMake( skuIdLbl_1.frame.origin.x + skuIdLbl_1.frame.size.width + 2, 0, [labelSidesArr[2] floatValue],  slNoLbl_1.frame.size.height);
                    
                    colorLbl_1.frame = CGRectMake( description_1.frame.origin.x + description_1.frame.size.width + 2, 0, [labelSidesArr[3] floatValue],  slNoLbl_1.frame.size.height);
                    
                    sizeLbl_1.frame = CGRectMake( colorLbl_1.frame.origin.x + colorLbl_1.frame.size.width + 2, 0, [labelSidesArr[4] floatValue],  slNoLbl_1.frame.size.height);
                    
                    
                    measureRangeLbl_1.frame = CGRectMake( sizeLbl_1.frame.origin.x + sizeLbl_1.frame.size.width + 2, 0, [labelSidesArr[5] floatValue],  slNoLbl_1.frame.size.height);
                    
                    gradeLbl_1.frame = CGRectMake( measureRangeLbl_1.frame.origin.x + measureRangeLbl_1.frame.size.width + 2, 0, [labelSidesArr[6] floatValue],  slNoLbl_1.frame.size.height);
                    
                    eanLbl_1.frame = CGRectMake( gradeLbl_1.frame.origin.x + gradeLbl_1.frame.size.width + 2, 0, [labelSidesArr[7] floatValue],  slNoLbl_1.frame.size.height);
                    
                    categoryLbl_1.frame = CGRectMake( eanLbl_1.frame.origin.x + eanLbl_1.frame.size.width + 2, 0, [labelSidesArr[8] floatValue],  slNoLbl_1.frame.size.height);
                    
                    reorderPointLbl_1.frame = CGRectMake( categoryLbl_1.frame.origin.x + categoryLbl_1.frame.size.width + 2, 0, [labelSidesArr[9] floatValue],  slNoLbl_1.frame.size.height);
                    
                    uomLbl_1.frame = CGRectMake( reorderPointLbl_1.frame.origin.x + reorderPointLbl_1.frame.size.width + 2, 0, [labelSidesArr[10] floatValue],  slNoLbl_1.frame.size.height);
                    
                    packQtyLbl_1.frame = CGRectMake( uomLbl_1.frame.origin.x + uomLbl_1.frame.size.width + 2, 0, [labelSidesArr[11] floatValue],  slNoLbl_1.frame.size.height);
                    
                    itemprice.frame =  CGRectMake( packQtyLbl_1.frame.origin.x + packQtyLbl_1.frame.size.width + 2, 15, [labelSidesArr[12] floatValue],  30);
                    
                    stockQtyLbl_1.frame = CGRectMake(packQtyLbl_1.frame.origin.x + packQtyLbl_1.frame.size.width + 2, 2, [labelSidesArr[12] floatValue],30);
                    
                    costPriceLbl_1.frame = CGRectMake( stockQtyLbl_1.frame.origin.x + stockQtyLbl_1.frame.size.width + 2, 0, [labelSidesArr[13] floatValue],  slNoLbl_1.frame.size.height);
                    
                    itemQtyInhandLbl.frame =  CGRectMake( costPriceLbl_1.frame.origin.x + costPriceLbl_1.frame.size.width + 2, 0, [labelSidesArr[14] floatValue],  slNoLbl_1.frame.size.height);
                    
                    itemsSummaryBtn.frame =  CGRectMake( itemQtyInhandLbl.frame.origin.x + itemQtyInhandLbl.frame.size.width + 2, 0, [labelSidesArr[15] floatValue],  slNoLbl_1.frame.size.height);
                    
                    CATransform3D transform = CATransform3DScale( itemprice.layer.transform, 1.0f, 10.0f, 1.0f);
                    itemprice.layer.transform = transform;
                    
                    [itemsSummaryBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0] forState:UIControlStateNormal];
                }
                else{
                    itemprice.transform = CGAffineTransformMakeScale(1.0, 3.0);
                    // [itemprice setTransform:CGAffineTransformMakeScale(1.0, 3.0)];
                }
                
                //populating text into the field's....
                
                if(commonDisplayArr.count > indexPath.row) {
                    
                    
                    NSMutableDictionary * tempDic = [commonDisplayArr[indexPath.row] mutableCopy];
                    
                    slNoLbl_1.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1)+ startIndexNumber ];
                    
                    skuIdLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"skuID"] defaultReturn:@"--"];
                    
                    description_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                    
                    //colorLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:COLOR] defaultReturn:@"0.00"] floatValue]];
                    
                    colorLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:COLOR] defaultReturn:@"--"];
                    
                    
                    // sizeLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:SIZE] defaultReturn:@"0.00"] floatValue]];
                    
                    sizeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:SIZE] defaultReturn:@"--"];
                    
                    measureRangeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@"--"];
                    
                    gradeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
                    
                    //  eanLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:EAN] defaultReturn:@"0.00"] floatValue]];
                    
                    eanLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:EAN] defaultReturn:@"--"];
                    
                    //  categoryLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:CATEGORY] defaultReturn:@"0.00"] floatValue]];
                    
                    categoryLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];
                    
                    reorderPointLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue]];
                    
                    uomLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"uom"] defaultReturn:@"--"];
                    
                    packQtyLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                    
                    stockQtyLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:STOCK_QTY] defaultReturn:@"0.00"] floatValue]];
                    
                    costPriceLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]];
                    
                    itemQtyInhandLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:STOCK_VALUE] defaultReturn:@"0.00"] floatValue]];
                    
                    if([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue] >= 1){
                        
                        itemprice.progress = 1;
                        
                    }
                    else{
                        itemprice.progress = 0;
                        
                    }
                    
                    [itemsSummaryBtn setTitle:NSLocalizedString(@"stock_card", nil) forState:UIControlStateNormal];
                    
                    itemsSummaryBtn.userInteractionEnabled = YES;
                    
                    
                }
                else{
                    slNoLbl_1.text = @"--";
                    skuIdLbl_1.text = @"--";
                    description_1.text = @"--";
                    colorLbl_1.text = @"--";
                    sizeLbl_1.text = @"--";
                    measureRangeLbl_1.text = @"--";
                    gradeLbl_1.text = @"--";
                    eanLbl_1.text = @"--";
                    categoryLbl_1.text = @"--";
                    reorderPointLbl_1.text = @"--";
                    uomLbl_1.text = @"--";
                    packQtyLbl_1.text = @"--";
                    stockQtyLbl_1.text = @"--";
                    costPriceLbl_1.text = @"--";
                    itemQtyInhandLbl.text = @"--";
                    itemprice.progress = 0;
                    
                    [itemsSummaryBtn setTitle:@"--" forState:UIControlStateNormal];
                    
                    
                }
            } @catch (NSException * exception) {
                
            }
            @finally{
                
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                return hlcell;
            }
        }
        
        else if ([selectedStockTypeStr isEqualToString:NSLocalizedString(@"daily_stock", nil)]) {
            
            static NSString * CellIdentifier = @"dayWiseStock";
            
            UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
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
            
            @try {
                UILabel * snoLbl;
                UILabel * skuidLbl;
                UILabel * descLbl;
                UILabel * colorLbl;
                UILabel * sizeLbl;
                UILabel * rangeLbl;
                UILabel * gradeLbl;
                UILabel * eanLbl;
                UILabel * categoryLbl;
                UILabel * dateLbl;
                UILabel * uomLbl;
                UILabel * openPacksLbl;
                UILabel * openStockQtyLbl;
                UILabel * closePacksLbl;
                UILabel * closeStockQtyLbl;
                UILabel * stockValue_Lbl;
                
                
                snoLbl = [[UILabel alloc] init];
                snoLbl.backgroundColor = [UIColor clearColor];
                snoLbl.layer.borderWidth = 0;
                snoLbl.textAlignment = NSTextAlignmentCenter;
                snoLbl.numberOfLines = 1;
                snoLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                skuidLbl = [[UILabel alloc] init];
                skuidLbl.backgroundColor = [UIColor clearColor];
                skuidLbl.layer.borderWidth = 0;
                skuidLbl.textAlignment = NSTextAlignmentCenter;
                skuidLbl.numberOfLines = 1;
                skuidLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                descLbl = [[UILabel alloc] init];
                descLbl.backgroundColor = [UIColor clearColor];
                descLbl.layer.borderWidth = 0;
                descLbl.textAlignment = NSTextAlignmentCenter;
                descLbl.numberOfLines = 1;
                descLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                colorLbl = [[UILabel alloc] init];
                colorLbl.backgroundColor = [UIColor clearColor];
                colorLbl.layer.borderWidth = 0;
                colorLbl.textAlignment = NSTextAlignmentCenter;
                colorLbl.numberOfLines = 1;
                colorLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                sizeLbl = [[UILabel alloc] init];
                sizeLbl.backgroundColor = [UIColor clearColor];
                sizeLbl.layer.borderWidth = 0;
                sizeLbl.textAlignment = NSTextAlignmentCenter;
                sizeLbl.numberOfLines = 1;
                sizeLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                rangeLbl = [[UILabel alloc] init];
                rangeLbl.backgroundColor = [UIColor clearColor];
                rangeLbl.layer.borderWidth = 0;
                rangeLbl.textAlignment = NSTextAlignmentCenter;
                rangeLbl.numberOfLines = 1;
                rangeLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                gradeLbl = [[UILabel alloc] init];
                gradeLbl.backgroundColor = [UIColor clearColor];
                gradeLbl.layer.borderWidth = 0;
                gradeLbl.textAlignment = NSTextAlignmentCenter;
                gradeLbl.numberOfLines = 1;
                gradeLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                eanLbl = [[UILabel alloc] init];
                eanLbl.backgroundColor = [UIColor clearColor];
                eanLbl.layer.borderWidth = 0;
                eanLbl.textAlignment = NSTextAlignmentCenter;
                eanLbl.numberOfLines = 1;
                eanLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                categoryLbl = [[UILabel alloc] init];
                categoryLbl.backgroundColor = [UIColor clearColor];
                categoryLbl.layer.borderWidth = 0;
                categoryLbl.textAlignment = NSTextAlignmentCenter;
                categoryLbl.numberOfLines = 1;
                categoryLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                dateLbl = [[UILabel alloc] init];
                dateLbl.backgroundColor = [UIColor clearColor];
                dateLbl.layer.borderWidth = 0;
                dateLbl.textAlignment = NSTextAlignmentCenter;
                dateLbl.numberOfLines = 1;
                dateLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                uomLbl = [[UILabel alloc] init];
                uomLbl.backgroundColor = [UIColor clearColor];
                uomLbl.layer.borderWidth = 0;
                uomLbl.textAlignment = NSTextAlignmentCenter;
                uomLbl.numberOfLines = 1;
                uomLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                openPacksLbl = [[UILabel alloc] init];
                openPacksLbl.backgroundColor = [UIColor clearColor];
                openPacksLbl.layer.borderWidth = 0;
                openPacksLbl.textAlignment = NSTextAlignmentCenter;
                openPacksLbl.numberOfLines = 1;
                openPacksLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                openStockQtyLbl = [[UILabel alloc] init];
                openStockQtyLbl.backgroundColor = [UIColor clearColor];
                openStockQtyLbl.layer.borderWidth = 0;
                openStockQtyLbl.textAlignment = NSTextAlignmentCenter;
                openStockQtyLbl.numberOfLines = 1;
                openStockQtyLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                closePacksLbl = [[UILabel alloc] init];
                closePacksLbl.backgroundColor = [UIColor clearColor];
                closePacksLbl.layer.borderWidth = 0;
                closePacksLbl.textAlignment = NSTextAlignmentCenter;
                closePacksLbl.numberOfLines = 1;
                closePacksLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                closeStockQtyLbl = [[UILabel alloc] init];
                closeStockQtyLbl.backgroundColor = [UIColor clearColor];
                closeStockQtyLbl.layer.borderWidth = 0;
                closeStockQtyLbl.textAlignment = NSTextAlignmentCenter;
                closeStockQtyLbl.numberOfLines = 1;
                closeStockQtyLbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                stockValue_Lbl = [[UILabel alloc] init];
                stockValue_Lbl.backgroundColor = [UIColor clearColor];
                stockValue_Lbl.layer.borderWidth = 0;
                stockValue_Lbl.textAlignment = NSTextAlignmentCenter;
                stockValue_Lbl.numberOfLines = 1;
                stockValue_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                /*creation of UIButton's*/
                UIButton * itemsSummaryBtn;
                
                itemsSummaryBtn = [[UIButton alloc] init];
                [itemsSummaryBtn addTarget:self action:@selector(navigateToStockCard:) forControlEvents:UIControlEventTouchDown];
                itemsSummaryBtn.layer.cornerRadius = 3.0f;
                itemsSummaryBtn.backgroundColor = [UIColor clearColor];
                [itemsSummaryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                itemsSummaryBtn.userInteractionEnabled = NO;
                itemsSummaryBtn.tag = indexPath.row;
                
                
                snoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                skuidLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                descLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                colorLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                sizeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                rangeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                gradeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                eanLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                categoryLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                dateLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                uomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                openPacksLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                openStockQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                closePacksLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                closeStockQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                stockValue_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                [hlcell.contentView addSubview:snoLbl];
                [hlcell.contentView addSubview:skuidLbl];
                [hlcell.contentView addSubview:descLbl];
                [hlcell.contentView addSubview:colorLbl];
                [hlcell.contentView addSubview:sizeLbl];
                [hlcell.contentView addSubview:rangeLbl];
                [hlcell.contentView addSubview:gradeLbl];
                [hlcell.contentView addSubview:eanLbl];
                [hlcell.contentView addSubview:categoryLbl];
                [hlcell.contentView addSubview:dateLbl];
                [hlcell.contentView addSubview:uomLbl];
                [hlcell.contentView addSubview:openPacksLbl];
                [hlcell.contentView addSubview:openStockQtyLbl];
                [hlcell.contentView addSubview:closePacksLbl];
                [hlcell.contentView addSubview:closeStockQtyLbl];
                [hlcell.contentView addSubview:stockValue_Lbl];
                [hlcell.contentView addSubview:itemsSummaryBtn];
                
                //setting frame and font........
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
                    
                    snoLbl.frame = CGRectMake( 0, 0, [labelSidesArr[0] floatValue], hlcell.frame.size.height);
                    
                    skuidLbl.frame = CGRectMake(snoLbl.frame.origin.x + snoLbl.frame.size.width + 2, 0, [labelSidesArr[1] floatValue], snoLbl.frame.size.height);
                    
                    descLbl.frame = CGRectMake(skuidLbl.frame.origin.x + skuidLbl.frame.size.width + 2, 0, [labelSidesArr[2] floatValue], snoLbl.frame.size.height);
                    
                    colorLbl.frame = CGRectMake(descLbl.frame.origin.x + descLbl.frame.size.width + 2, 0, [labelSidesArr[3] floatValue], snoLbl.frame.size.height);
                    
                    sizeLbl.frame = CGRectMake(colorLbl.frame.origin.x + colorLbl.frame.size.width + 2, 0, [labelSidesArr[4] floatValue], snoLbl.frame.size.height);
                    
                    rangeLbl.frame = CGRectMake(sizeLbl.frame.origin.x + sizeLbl.frame.size.width + 2, 0, [labelSidesArr[5] floatValue], snoLbl.frame.size.height);
                    
                    gradeLbl.frame = CGRectMake(rangeLbl.frame.origin.x + rangeLbl.frame.size.width + 2, 0, [labelSidesArr[6] floatValue], snoLbl.frame.size.height);
                    
                    eanLbl.frame = CGRectMake(gradeLbl.frame.origin.x + gradeLbl.frame.size.width + 2, 0, [labelSidesArr[7] floatValue], snoLbl.frame.size.height);
                    
                    categoryLbl.frame = CGRectMake(eanLbl.frame.origin.x + eanLbl.frame.size.width + 2, 0, [labelSidesArr[8] floatValue], snoLbl.frame.size.height);
                    
                    dateLbl.frame = CGRectMake(categoryLbl.frame.origin.x + categoryLbl.frame.size.width + 2, 0, [labelSidesArr[9] floatValue], snoLbl.frame.size.height);
                    
                    uomLbl.frame = CGRectMake(dateLbl.frame.origin.x + dateLbl.frame.size.width + 2, 0, [labelSidesArr[10] floatValue], snoLbl.frame.size.height);
                    
                    openPacksLbl.frame = CGRectMake(uomLbl.frame.origin.x + uomLbl.frame.size.width+2, 0, [labelSidesArr[11] floatValue]/2.5, snoLbl.frame.size.height);
                    
                    openStockQtyLbl.frame = CGRectMake(openPacksLbl.frame.origin.x + openPacksLbl.frame.size.width + 2, 0, [labelSidesArr[11] floatValue]/1.5, snoLbl.frame.size.height);
                    
                    
                    closePacksLbl.frame = CGRectMake(openStockQtyLbl.frame.origin.x + openStockQtyLbl.frame.size.width-10, 0, [labelSidesArr[12] floatValue]/2.5, snoLbl.frame.size.height);
                    
                    closeStockQtyLbl.frame = CGRectMake(closePacksLbl.frame.origin.x + closePacksLbl.frame.size.width + 2, 0, [labelSidesArr[12] floatValue]/1.5, snoLbl.frame.size.height);
                    
                    stockValue_Lbl.frame = CGRectMake(closeStockQtyLbl.frame.origin.x + closeStockQtyLbl.frame.size.width -10, 0, [labelSidesArr[13] floatValue], snoLbl.frame.size.height);
                    
                }
                else {
                    
                    //CODE FOR IPHONE...
                }
                
                //populating text into the field's....
                
                if(commonDisplayArr.count > indexPath.row){
                    
                    
                    NSMutableDictionary * tempDic = [commonDisplayArr[indexPath.row] mutableCopy];
                    
                    snoLbl.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1)+ startIndexNumber ];
                    
                    skuidLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_SKU]   defaultReturn:@"--"];
                    
                    descLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_DESC]   defaultReturn:@"--"];
                    
                    colorLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:COLOR]   defaultReturn:@"--"];
                    
                    sizeLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:SIZE]   defaultReturn:@"--"];
                    
                    rangeLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@"--"];
                    
                    gradeLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:PRODUCT_RANGE]  defaultReturn:@"--"];
                    
                    eanLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:EAN]  defaultReturn:@"--"];
                    
                    categoryLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:kCategoryName]  defaultReturn:@"--"];
                    
                    dateLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:REPORT_DATE]  defaultReturn:@"--"];
                    
                    uomLbl.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:SELL_UOM]  defaultReturn:@"--"];
                    
                    openPacksLbl.text    = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:OPEN_STOCK] defaultReturn:@"0.00"] floatValue]];
                    
                    openStockQtyLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:OPEN_STOCK_QTY] defaultReturn:@"0.00"] floatValue]];
                    
                    closePacksLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue]];
                    
                    closeStockQtyLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:CLOSED_STOCK_QTY] defaultReturn:@"0.00"] floatValue]];
                    
                    stockValue_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:TOTAL_COST] defaultReturn:@"0.00"] floatValue]];
                    
                    //openStockQty
                    
                }
                else {
                    
                    snoLbl.text = @"--";
                    skuidLbl.text = @"--";
                    descLbl.text = @"--";
                    colorLbl.text = @"--";
                    sizeLbl.text = @"--";
                    rangeLbl.text = @"--";
                    gradeLbl.text = @"--";
                    eanLbl.text = @"--";
                    categoryLbl.text = @"--";
                    dateLbl.text = @"--";
                    uomLbl.text = @"--";
                    openPacksLbl.text = @"--";
                    openStockQtyLbl.text = @"--";
                    closePacksLbl.text = @"--";
                    closeStockQtyLbl.text = @"--";
                    stockValue_Lbl.text = @"--";
                    
                    
                }
                
                
            } @catch (NSException *exception) {
                
            }
            hlcell.backgroundColor = [UIColor clearColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        
        else if([selectedStockTypeStr isEqualToString:NSLocalizedString(@"ordered_stock",nil)]) {
            
            static NSString * CellIdentifier = @"CommanCell_2";
            
            UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if ((hlcell.contentView).subviews){
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            //CAGradientLayer *layer_8;
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                hlcell.accessoryType = UITableViewCellAccessoryNone;
                
                
            }
            
            @try {
                UILabel * slNoLbl_1;
                UILabel * orderedDateLbl_1;
                UILabel * deliveredDateLbl_1;
                UILabel * skuIdLbl_1;
                UILabel * description_1;
                UILabel * colorLbl_1;
                UILabel * sizeLbl_1;
                UILabel * measureRangeLbl_1;
                UILabel * gradeLbl_1;
                UILabel * categoryLbl_1;
                UILabel * eanLbl_1;
                UILabel * uomLbl_1;
                UILabel * packQtyLbl_1;
                UILabel * stockQtyLbl_1;
                UILabel * costPriceLbl_1;
                UILabel * itemQtyInhandLbl;
                
                slNoLbl_1 = [[UILabel alloc] init];
                slNoLbl_1.backgroundColor = [UIColor clearColor];
                slNoLbl_1.layer.borderWidth = 0;
                slNoLbl_1.textAlignment = NSTextAlignmentCenter;
                slNoLbl_1.numberOfLines = 1;
                slNoLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                orderedDateLbl_1 = [[UILabel alloc] init];
                orderedDateLbl_1.backgroundColor = [UIColor clearColor];
                orderedDateLbl_1.layer.borderWidth = 0;
                orderedDateLbl_1.textAlignment = NSTextAlignmentCenter;
                orderedDateLbl_1.numberOfLines = 1;
                orderedDateLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                deliveredDateLbl_1 = [[UILabel alloc] init];
                deliveredDateLbl_1.backgroundColor = [UIColor clearColor];
                deliveredDateLbl_1.layer.borderWidth = 0;
                deliveredDateLbl_1.textAlignment = NSTextAlignmentCenter;
                deliveredDateLbl_1.numberOfLines = 1;
                deliveredDateLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                skuIdLbl_1 = [[UILabel alloc] init];
                skuIdLbl_1.backgroundColor = [UIColor clearColor];
                skuIdLbl_1.textAlignment = NSTextAlignmentCenter;
                skuIdLbl_1.numberOfLines = 1;
                skuIdLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                description_1 = [[UILabel alloc] init];
                description_1.backgroundColor = [UIColor clearColor];
                description_1.textAlignment = NSTextAlignmentCenter;
                description_1.numberOfLines = 1;
                description_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                colorLbl_1 = [[UILabel alloc] init];
                colorLbl_1.backgroundColor = [UIColor clearColor];
                colorLbl_1.textAlignment = NSTextAlignmentCenter;
                colorLbl_1.numberOfLines = 1;
                colorLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                sizeLbl_1 = [[UILabel alloc] init];
                sizeLbl_1.backgroundColor = [UIColor clearColor];
                sizeLbl_1.textAlignment = NSTextAlignmentCenter;
                sizeLbl_1.numberOfLines = 1;
                sizeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                measureRangeLbl_1 = [[UILabel alloc] init];
                measureRangeLbl_1.backgroundColor = [UIColor clearColor];
                measureRangeLbl_1.textAlignment = NSTextAlignmentCenter;
                measureRangeLbl_1.numberOfLines = 1;
                measureRangeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                gradeLbl_1 = [[UILabel alloc] init];
                gradeLbl_1.backgroundColor = [UIColor clearColor];
                gradeLbl_1.textAlignment = NSTextAlignmentCenter;
                gradeLbl_1.numberOfLines = 1;
                gradeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                categoryLbl_1 = [[UILabel alloc] init];
                categoryLbl_1.backgroundColor = [UIColor clearColor];
                categoryLbl_1.textAlignment = NSTextAlignmentCenter;
                categoryLbl_1.numberOfLines = 1;
                categoryLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                eanLbl_1 = [[UILabel alloc] init];
                eanLbl_1.backgroundColor = [UIColor clearColor];
                eanLbl_1.textAlignment = NSTextAlignmentCenter;
                eanLbl_1.numberOfLines = 1;
                eanLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                uomLbl_1 = [[UILabel alloc] init];
                uomLbl_1.backgroundColor = [UIColor clearColor];
                uomLbl_1.textAlignment = NSTextAlignmentCenter;
                uomLbl_1.numberOfLines = 1;
                uomLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                packQtyLbl_1 = [[UILabel alloc] init];
                packQtyLbl_1.backgroundColor = [UIColor clearColor];
                packQtyLbl_1.textAlignment = NSTextAlignmentCenter;
                packQtyLbl_1.numberOfLines = 1;
                packQtyLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                stockQtyLbl_1 = [[UILabel alloc] init];
                stockQtyLbl_1.backgroundColor = [UIColor clearColor];
                stockQtyLbl_1.textAlignment = NSTextAlignmentCenter;
                stockQtyLbl_1.numberOfLines = 1;
                stockQtyLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                costPriceLbl_1 = [[UILabel alloc] init];
                costPriceLbl_1.backgroundColor = [UIColor clearColor];
                costPriceLbl_1.textAlignment = NSTextAlignmentCenter;
                costPriceLbl_1.numberOfLines = 1;
                costPriceLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                itemQtyInhandLbl = [[UILabel alloc] init];
                itemQtyInhandLbl.backgroundColor = [UIColor clearColor];
                itemQtyInhandLbl.textAlignment = NSTextAlignmentCenter;
                itemQtyInhandLbl.numberOfLines = 1;
                itemQtyInhandLbl.lineBreakMode = NSLineBreakByTruncatingTail;
                
                //itemQtyInhandLbl.textColor = [UIColor blackColor];
                
                UIProgressView * itemprice;
                
                itemprice = [[UIProgressView alloc] init];
                itemprice.trackTintColor = [UIColor whiteColor];
                
                UIColor * progressColor = [UIColor colorWithRed:60.0/255 green:127.0/255 blue:4.0/255 alpha:1.0];
                
                itemprice.progressTintColor = progressColor;
                
                /*creation of UIButton's*/
                UIButton * itemsSummaryBtn;
                
                itemsSummaryBtn = [[UIButton alloc] init];
                [itemsSummaryBtn addTarget:self action:@selector(navigateToStockCard:) forControlEvents:UIControlEventTouchDown];
                itemsSummaryBtn.layer.cornerRadius = 3.0f;
                itemsSummaryBtn.backgroundColor = [UIColor clearColor];
                [itemsSummaryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                itemsSummaryBtn.userInteractionEnabled = NO;
                itemsSummaryBtn.tag = indexPath.row;
                
                slNoLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                orderedDateLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                deliveredDateLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                skuIdLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                description_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                colorLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                sizeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                measureRangeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                gradeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                categoryLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                eanLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                uomLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                packQtyLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                stockQtyLbl_1.textColor = [UIColor orangeColor];
                
                costPriceLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                itemQtyInhandLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                
                [hlcell.contentView addSubview:slNoLbl_1];
                [hlcell.contentView addSubview:orderedDateLbl_1];
                [hlcell.contentView addSubview:deliveredDateLbl_1];
                
                [hlcell.contentView addSubview:skuIdLbl_1];
                [hlcell.contentView addSubview:description_1];
                [hlcell.contentView addSubview:colorLbl_1];
                [hlcell.contentView addSubview:sizeLbl_1];
                [hlcell.contentView addSubview:measureRangeLbl_1];
                [hlcell.contentView addSubview:gradeLbl_1];
                [hlcell.contentView addSubview:categoryLbl_1];
                [hlcell.contentView addSubview:eanLbl_1];
                [hlcell.contentView addSubview:uomLbl_1];
                [hlcell.contentView addSubview:packQtyLbl_1];
                [hlcell.contentView addSubview:costPriceLbl_1];
                
                [hlcell.contentView addSubview:itemprice];
                [hlcell.contentView addSubview:stockQtyLbl_1];
                
                [hlcell.contentView addSubview:itemQtyInhandLbl];
                
                [hlcell.contentView addSubview:itemsSummaryBtn];
                
                //setting frame and font........
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    itemprice.transform = CGAffineTransformMakeScale( 1.0, 10.0);
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
                    
                    slNoLbl_1.frame = CGRectMake( 0, 0, [labelSidesArr[0] floatValue], hlcell.frame.size.height);
                    
                    orderedDateLbl_1.frame = CGRectMake(slNoLbl_1.frame.origin.x + slNoLbl_1.frame.size.width + 2, 0, [labelSidesArr[1] floatValue],  slNoLbl_1.frame.size.height);
                    
                    deliveredDateLbl_1.frame = CGRectMake(orderedDateLbl_1.frame.origin.x + orderedDateLbl_1.frame.size.width + 2, 0, [labelSidesArr[2] floatValue],  slNoLbl_1.frame.size.height);
                    
                    skuIdLbl_1.frame = CGRectMake(deliveredDateLbl_1.frame.origin.x + deliveredDateLbl_1.frame.size.width + 2, 0, [labelSidesArr[3] floatValue],  slNoLbl_1.frame.size.height);
                    
                    description_1.frame = CGRectMake(skuIdLbl_1.frame.origin.x + skuIdLbl_1.frame.size.width + 2, 0, [labelSidesArr[4] floatValue],  slNoLbl_1.frame.size.height);
                    
                    colorLbl_1.frame = CGRectMake( description_1.frame.origin.x + description_1.frame.size.width + 2, 0, [labelSidesArr[5] floatValue],  slNoLbl_1.frame.size.height);
                    
                    sizeLbl_1.frame = CGRectMake( colorLbl_1.frame.origin.x + colorLbl_1.frame.size.width + 2, 0, [labelSidesArr[6] floatValue],  slNoLbl_1.frame.size.height);
                    
                    measureRangeLbl_1.frame = CGRectMake(sizeLbl_1.frame.origin.x + sizeLbl_1.frame.size.width + 2, 0, [labelSidesArr[7] floatValue],  slNoLbl_1.frame.size.height);
                    
                    gradeLbl_1.frame = CGRectMake( measureRangeLbl_1.frame.origin.x + measureRangeLbl_1.frame.size.width + 2, 0, [labelSidesArr[8] floatValue],  slNoLbl_1.frame.size.height);
                    
                    categoryLbl_1.frame = CGRectMake( gradeLbl_1.frame.origin.x + gradeLbl_1.frame.size.width + 2, 0, [labelSidesArr[9] floatValue],  slNoLbl_1.frame.size.height);
                    
                    eanLbl_1.frame = CGRectMake( categoryLbl_1.frame.origin.x + categoryLbl_1.frame.size.width + 2, 0, [labelSidesArr[10] floatValue],  slNoLbl_1.frame.size.height);
                    
                    uomLbl_1.frame = CGRectMake( eanLbl_1.frame.origin.x + eanLbl_1.frame.size.width + 2, 0, [labelSidesArr[11] floatValue],  slNoLbl_1.frame.size.height);
                    
                    packQtyLbl_1.frame = CGRectMake( uomLbl_1.frame.origin.x + uomLbl_1.frame.size.width + 2, 0, [labelSidesArr[12] floatValue],  slNoLbl_1.frame.size.height);
                    
                    itemprice.frame =  CGRectMake( packQtyLbl_1.frame.origin.x + packQtyLbl_1.frame.size.width + 2, 15, [labelSidesArr[13] floatValue],  30);
                    
                    stockQtyLbl_1.frame = CGRectMake( packQtyLbl_1.frame.origin.x + packQtyLbl_1.frame.size.width + 2,2, [labelSidesArr[13] floatValue],30);
                    
                    costPriceLbl_1.frame = CGRectMake( stockQtyLbl_1.frame.origin.x + stockQtyLbl_1.frame.size.width + 2, 0, [labelSidesArr[14] floatValue],  slNoLbl_1.frame.size.height);
                    
                    itemQtyInhandLbl.frame =  CGRectMake( costPriceLbl_1.frame.origin.x + costPriceLbl_1.frame.size.width + 2, 5, [labelSidesArr[15] floatValue],slNoLbl_1.frame.size.height);
                    
                    itemsSummaryBtn.frame =  CGRectMake( itemQtyInhandLbl.frame.origin.x + itemQtyInhandLbl.frame.size.width + 2, 0, [labelSidesArr[16] floatValue],slNoLbl_1.frame.size.height);
                    
                    CATransform3D transform = CATransform3DScale( itemprice.layer.transform, 1.0f, 10.0f, 1.0f);
                    itemprice.layer.transform = transform;
                    
                    [itemsSummaryBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0] forState:UIControlStateNormal];
                }
                else{
                    itemprice.transform = CGAffineTransformMakeScale(1.0, 3.0);
                    // [itemprice setTransform:CGAffineTransformMakeScale(1.0, 3.0)];
                    
                }
                
                
                //populating text into the field's....
                
                if(commonDisplayArr.count > indexPath.row){
                    
                    NSMutableDictionary *tempDic = [commonDisplayArr[indexPath.row] mutableCopy];
                    
                    slNoLbl_1.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1)+ startIndexNumber ];
                    
                    orderedDateLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"orderDate"]   defaultReturn:@"--"];
                    
                    deliveredDateLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"deliveryDate"]   defaultReturn:@"--"];
                    
                    skuIdLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"skuID"] defaultReturn:@"--"];
                    
                    
                    description_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                    
                    colorLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:COLOR] defaultReturn:@"--"];
                    
                    
                    sizeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:SIZE] defaultReturn:@"--"];
                    
                    measureRangeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@"--"];
                    
                    
                    gradeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
                    
                    categoryLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];
                    
                    eanLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:EAN] defaultReturn:@"--"];
                    
                    //reorderPointLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue]];
                    
                    uomLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"uom"] defaultReturn:@"--"];
                    
                    packQtyLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                    
                    stockQtyLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:STOCK_QTY] defaultReturn:@"0.00"] floatValue]];
                    
                    costPriceLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]];
                    
                    itemQtyInhandLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:STOCK_VALUE] defaultReturn:@"0.00"] floatValue]];
                    
                    //if( ([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue]) && ([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue])){
                    
                    //float totalQty = [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue] * 4;
                    //
                    //itemprice.progress = ([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]) / totalQty;
                    //
                    //}
                    //else
                    
                    if([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]>= 1){
                        
                        itemprice.progress = 1;
                        
                    }
                    else{
                        itemprice.progress = 0;
                        
                    }
                    
                    [itemsSummaryBtn setTitle:NSLocalizedString(@"stock_card", nil) forState:UIControlStateNormal];
                    
                    itemsSummaryBtn.userInteractionEnabled = YES;
                    
                }
                else{
                    slNoLbl_1.text = @"--";
                    orderedDateLbl_1.text = @"--";
                    deliveredDateLbl_1.text = @"--";
                    skuIdLbl_1.text = @"--";
                    description_1.text = @"--";
                    colorLbl_1.text = @"--";
                    sizeLbl_1.text = @"--";
                    
                    measureRangeLbl_1.text = @"--";
                    gradeLbl_1.text = @"--";
                    categoryLbl_1.text = @"--";
                    eanLbl_1.text = @"--";
                    //reorderPointLbl_1.text = @"--";
                    uomLbl_1.text = @"--";
                    packQtyLbl_1.text = @"--";
                    stockQtyLbl_1.text = @"--";
                    costPriceLbl_1.text = @"--";
                    itemQtyInhandLbl.text = @"--";
                    
                    itemprice.progress = 0;
                    
                    [itemsSummaryBtn setTitle:@"--" forState:UIControlStateNormal];
                }
            } @catch (NSException *exception) {
                
            } @finally {
                
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                return hlcell;
                
            }
        }
        
        else if (([selectedStockTypeStr isEqualToString:NSLocalizedString(@"blocked_stock",nil)])||([selectedStockTypeStr isEqualToString:NSLocalizedString(@"returned_stock",nil)])) {
            
            static NSString * CellIdentifier = @"Demand forecast";
            
            UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
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
            
            @try {
                UILabel * slNoLbl_1;
                UILabel * skuIdLbl_1;
                UILabel * description_1;
                UILabel * colorLbl_1;
                UILabel * sizeLbl_1;
                UILabel * measureRangeLbl_1;
                UILabel * gradeLbl_1;
                UILabel * eanLbl_1;
                UILabel * reorderPointLbl_1;
                UILabel * uomLbl_1;
                UILabel * packQtyLbl_1;
                UILabel * stockQtyLbl_1;
                
                UILabel * categoryLbl_1;
                UILabel * costPriceLbl_1;
                UILabel * itemQtyInhandLbl;
                UIProgressView * itemprice;
                
                /*creation of UIButton's*/
                UIButton * itemsSummaryBtn;
                
                slNoLbl_1 = [[UILabel alloc] init];
                slNoLbl_1.backgroundColor = [UIColor clearColor];
                slNoLbl_1.layer.borderWidth = 0;
                slNoLbl_1.textAlignment = NSTextAlignmentCenter;
                slNoLbl_1.numberOfLines = 1;
                slNoLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                skuIdLbl_1 = [[UILabel alloc] init];
                skuIdLbl_1.backgroundColor = [UIColor clearColor];
                skuIdLbl_1.textAlignment = NSTextAlignmentCenter;
                skuIdLbl_1.numberOfLines = 1;
                skuIdLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                description_1 = [[UILabel alloc] init];
                description_1.backgroundColor = [UIColor clearColor];
                description_1.textAlignment = NSTextAlignmentCenter;
                description_1.numberOfLines = 1;
                description_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                colorLbl_1 = [[UILabel alloc] init];
                colorLbl_1.backgroundColor = [UIColor clearColor];
                colorLbl_1.textAlignment = NSTextAlignmentCenter;
                colorLbl_1.numberOfLines = 1;
                colorLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                sizeLbl_1 = [[UILabel alloc] init];
                sizeLbl_1.backgroundColor = [UIColor clearColor];
                sizeLbl_1.textAlignment = NSTextAlignmentCenter;
                sizeLbl_1.numberOfLines = 1;
                sizeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                measureRangeLbl_1 = [[UILabel alloc] init];
                measureRangeLbl_1.backgroundColor = [UIColor clearColor];
                measureRangeLbl_1.textAlignment = NSTextAlignmentCenter;
                measureRangeLbl_1.numberOfLines = 1;
                measureRangeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                gradeLbl_1 = [[UILabel alloc] init];
                gradeLbl_1.backgroundColor = [UIColor clearColor];
                gradeLbl_1.textAlignment = NSTextAlignmentCenter;
                gradeLbl_1.numberOfLines = 1;
                gradeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                eanLbl_1 = [[UILabel alloc] init];
                eanLbl_1.backgroundColor = [UIColor clearColor];
                eanLbl_1.textAlignment = NSTextAlignmentCenter;
                eanLbl_1.numberOfLines = 1;
                eanLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                categoryLbl_1 = [[UILabel alloc] init];
                categoryLbl_1.backgroundColor = [UIColor clearColor];
                categoryLbl_1.textAlignment = NSTextAlignmentCenter;
                categoryLbl_1.numberOfLines = 1;
                categoryLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                reorderPointLbl_1 = [[UILabel alloc] init];
                reorderPointLbl_1.backgroundColor = [UIColor clearColor];
                reorderPointLbl_1.textAlignment = NSTextAlignmentCenter;
                reorderPointLbl_1.numberOfLines = 1;
                reorderPointLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                uomLbl_1 = [[UILabel alloc] init];
                uomLbl_1.backgroundColor = [UIColor clearColor];
                uomLbl_1.textAlignment = NSTextAlignmentCenter;
                uomLbl_1.numberOfLines = 1;
                uomLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                packQtyLbl_1 = [[UILabel alloc] init];
                packQtyLbl_1.backgroundColor = [UIColor clearColor];
                packQtyLbl_1.textAlignment = NSTextAlignmentCenter;
                packQtyLbl_1.numberOfLines = 1;
                packQtyLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                stockQtyLbl_1 = [[UILabel alloc] init];
                stockQtyLbl_1.backgroundColor = [UIColor clearColor];
                stockQtyLbl_1.textAlignment = NSTextAlignmentCenter;
                stockQtyLbl_1.numberOfLines = 1;
                stockQtyLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                costPriceLbl_1 = [[UILabel alloc] init];
                costPriceLbl_1.backgroundColor = [UIColor clearColor];
                costPriceLbl_1.textAlignment = NSTextAlignmentCenter;
                costPriceLbl_1.numberOfLines = 1;
                costPriceLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                itemQtyInhandLbl = [[UILabel alloc] init];
                itemQtyInhandLbl.backgroundColor = [UIColor clearColor];
                itemQtyInhandLbl.textAlignment = NSTextAlignmentCenter;
                itemQtyInhandLbl.numberOfLines = 1;
                itemQtyInhandLbl.lineBreakMode = NSLineBreakByTruncatingTail;
                
                itemprice = [[UIProgressView alloc] init];
                itemprice.trackTintColor = [UIColor whiteColor];
                
                UIColor * progressColor = [UIColor colorWithRed:60.0/255 green:127.0/255 blue:4.0/255 alpha:1.0];
                
                itemprice.progressTintColor = progressColor;
                
                
                
                itemsSummaryBtn = [[UIButton alloc] init];
                [itemsSummaryBtn addTarget:self action:@selector(navigateToStockCard:) forControlEvents:UIControlEventTouchDown];
                itemsSummaryBtn.layer.cornerRadius = 3.0f;
                itemsSummaryBtn.backgroundColor = [UIColor clearColor];
                [itemsSummaryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                itemsSummaryBtn.userInteractionEnabled = NO;
                itemsSummaryBtn.tag = indexPath.row;
                
                slNoLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                skuIdLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                description_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                colorLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                sizeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                measureRangeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                gradeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                eanLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                categoryLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                reorderPointLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                uomLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                packQtyLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                stockQtyLbl_1.textColor = [UIColor orangeColor];
                itemQtyInhandLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                costPriceLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                [hlcell.contentView addSubview:slNoLbl_1];
                [hlcell.contentView addSubview:skuIdLbl_1];
                [hlcell.contentView addSubview:description_1];
                [hlcell.contentView addSubview:colorLbl_1];
                [hlcell.contentView addSubview:sizeLbl_1];
                [hlcell.contentView addSubview:measureRangeLbl_1];
                [hlcell.contentView addSubview:gradeLbl_1];
                [hlcell.contentView addSubview:eanLbl_1];
                [hlcell.contentView addSubview:reorderPointLbl_1];
                [hlcell.contentView addSubview:uomLbl_1];
                [hlcell.contentView addSubview:packQtyLbl_1];
                [hlcell.contentView addSubview:categoryLbl_1];
                [hlcell.contentView addSubview:costPriceLbl_1];
                
                [hlcell.contentView addSubview:itemprice];
                [hlcell.contentView addSubview:stockQtyLbl_1];
                
                [hlcell.contentView addSubview:itemQtyInhandLbl];
                [hlcell.contentView addSubview:itemsSummaryBtn];
                
                //setting frame and font........
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    itemprice.transform = CGAffineTransformMakeScale( 1.0, 10.0);
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
                    
                    
                    slNoLbl_1.frame = CGRectMake( 0, 0, [labelSidesArr[0] floatValue], hlcell.frame.size.height);
                    
                    skuIdLbl_1.frame = CGRectMake(slNoLbl_1.frame.origin.x + slNoLbl_1.frame.size.width + 2, 0, [labelSidesArr[1] floatValue],  slNoLbl_1.frame.size.height);
                    
                    description_1.frame = CGRectMake( skuIdLbl_1.frame.origin.x + skuIdLbl_1.frame.size.width + 2, 0, [labelSidesArr[2] floatValue],  slNoLbl_1.frame.size.height);
                    
                    colorLbl_1.frame = CGRectMake( description_1.frame.origin.x + description_1.frame.size.width + 2, 0, [labelSidesArr[3] floatValue],  slNoLbl_1.frame.size.height);
                    
                    sizeLbl_1.frame = CGRectMake( colorLbl_1.frame.origin.x + colorLbl_1.frame.size.width + 2, 0, [labelSidesArr[4] floatValue],  slNoLbl_1.frame.size.height);
                    
                    measureRangeLbl_1.frame = CGRectMake( sizeLbl_1.frame.origin.x + sizeLbl_1.frame.size.width + 2, 0, [labelSidesArr[5] floatValue],  slNoLbl_1.frame.size.height);
                    
                    gradeLbl_1.frame = CGRectMake( measureRangeLbl_1.frame.origin.x + measureRangeLbl_1.frame.size.width + 2, 0, [labelSidesArr[6] floatValue],  slNoLbl_1.frame.size.height);
                    
                    eanLbl_1.frame = CGRectMake( gradeLbl_1.frame.origin.x + gradeLbl_1.frame.size.width + 2, 0, [labelSidesArr[7] floatValue],  slNoLbl_1.frame.size.height);
                    
                    reorderPointLbl_1.frame = CGRectMake( eanLbl_1.frame.origin.x + eanLbl_1.frame.size.width + 2, 0, [labelSidesArr[8] floatValue],  slNoLbl_1.frame.size.height);
                    
                    uomLbl_1.frame = CGRectMake( reorderPointLbl_1.frame.origin.x + reorderPointLbl_1.frame.size.width + 2, 0, [labelSidesArr[9] floatValue],  slNoLbl_1.frame.size.height);
                    
                    packQtyLbl_1.frame = CGRectMake(uomLbl_1.frame.origin.x + uomLbl_1.frame.size.width + 2, 0, [labelSidesArr[10] floatValue],  slNoLbl_1.frame.size.height);
                    
                    itemprice.frame =  CGRectMake( packQtyLbl_1.frame.origin.x + packQtyLbl_1.frame.size.width + 2,15, [labelSidesArr[11] floatValue],  30);
                    
                    stockQtyLbl_1.frame = CGRectMake(packQtyLbl_1.frame.origin.x + packQtyLbl_1.frame.size.width + 2,2, [labelSidesArr[11] floatValue],30);
                    
                    categoryLbl_1.frame = CGRectMake(stockQtyLbl_1.frame.origin.x + stockQtyLbl_1.frame.size.width + 2, 0, [labelSidesArr[12] floatValue],  slNoLbl_1.frame.size.height);
                    
                    costPriceLbl_1.frame = CGRectMake( categoryLbl_1.frame.origin.x + categoryLbl_1.frame.size.width + 2, 0, [labelSidesArr[13] floatValue],  slNoLbl_1.frame.size.height);
                    
                    
                    itemQtyInhandLbl.frame =  CGRectMake( costPriceLbl_1.frame.origin.x + costPriceLbl_1.frame.size.width + 2, 5, [labelSidesArr[14] floatValue],  30);
                    
                    itemsSummaryBtn.frame =  CGRectMake( itemQtyInhandLbl.frame.origin.x+itemQtyInhandLbl.frame.size.width + 2, 0, [labelSidesArr[15] floatValue],  slNoLbl_1.frame.size.height);
                    
                    CATransform3D transform = CATransform3DScale(itemprice.layer.transform, 1.0f, 10.0f, 1.0f);
                    itemprice.layer.transform = transform;
                    
                    [itemsSummaryBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0] forState:UIControlStateNormal];
                }
                else{
                    itemprice.transform = CGAffineTransformMakeScale(1.0, 3.0);
                    
                }
                //populating text into the field's....
                
                if(commonDisplayArr.count > indexPath.row){
                    
                    NSMutableDictionary * tempDic = [commonDisplayArr[indexPath.row] mutableCopy];
                    
                    slNoLbl_1.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1)+ startIndexNumber ];
                    
                    skuIdLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"skuID"] defaultReturn:@"--"];
                    
                    description_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                    
                    colorLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:COLOR] defaultReturn:@"--"];
                    
                    sizeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:SIZE] defaultReturn:@"--"];
                    
                    measureRangeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@"--"];
                    
                    gradeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
                    
                    eanLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:EAN] defaultReturn:@"--"];
                    
                    reorderPointLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue]];
                    
                    uomLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"uom"] defaultReturn:@"--"];
                    
                    packQtyLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                    
                    stockQtyLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:STOCK_QTY] defaultReturn:@"0.00"] floatValue]];
                    
                    categoryLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];
                    
                    costPriceLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]];
                    
                    itemQtyInhandLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:STOCK_VALUE] defaultReturn:@"0.00"] floatValue]];
                    
                    
                    //if( ([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue]) && ([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue])){
                    
                    //float totalQty = [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue] * 4;
                    
                    //itemprice.progress = ([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]) / totalQty;
                    //}
                    //else
                    
                    if([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]>=1){
                        
                        itemprice.progress = 1;
                        
                    }
                    else{
                        itemprice.progress = 0;
                    }
                    
                    [itemsSummaryBtn setTitle:NSLocalizedString(@"stock_card", nil) forState:UIControlStateNormal];
                    
                    itemsSummaryBtn.userInteractionEnabled = YES;
                    
                }
                else{
                    slNoLbl_1.text = @"--";
                    skuIdLbl_1.text = @"--";
                    description_1.text = @"--";
                    colorLbl_1.text = @"--";
                    sizeLbl_1.text = @"--";
                    
                    measureRangeLbl_1.text = @"--";
                    gradeLbl_1.text = @"--";
                    eanLbl_1.text = @"--";
                    categoryLbl_1.text = @"--";
                    reorderPointLbl_1.text = @"--";
                    
                    uomLbl_1.text = @"--";
                    packQtyLbl_1.text = @"--";
                    stockQtyLbl_1.text = @"--";
                    costPriceLbl_1.text = @"--";
                    itemQtyInhandLbl.text = @"--";
                    
                    itemprice.progress = 0;
                    
                    [itemsSummaryBtn setTitle:@"--" forState:UIControlStateNormal];
                    
                }
            } @catch (NSException * exception) {
                
            }
            @finally{
                
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                return hlcell;
            }
        }
        else if (([selectedStockTypeStr isEqualToString:NSLocalizedString(@"boneyard",nil)])) {
            
            static NSString * CellIdentifier = @"Boneyard";
            
            UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if ((hlcell.contentView).subviews){
                for (UIView * subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                hlcell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            
            @try {
                UILabel * slNoLbl_1;
                UILabel * locationLbl_1;
                UILabel * dateLbl_1;
                UILabel * skuIdLbl_1;
                UILabel * description_1;
                UILabel * colorLbl_1;
                UILabel * sizeLbl_1;
                UILabel * measureRangeLbl_1;
                UILabel * gradeLbl_1;
                UILabel * eanLbl_1;
                UILabel * categoryLbl_1;
                UILabel * uomLbl_1;
                UILabel * packQtyLbl_1;
                UILabel * stockQtyLbl_1;
                UILabel * costPriceLbl_1;
                UILabel * salePriceLbl_1;
                UILabel * itemQtyInhandLbl;
                UIProgressView * itemprice;
                
                /*creation of UIButton's*/
                UIButton * itemsSummaryBtn;
                
                slNoLbl_1 = [[UILabel alloc] init];
                slNoLbl_1.backgroundColor = [UIColor clearColor];
                slNoLbl_1.layer.borderWidth = 0;
                slNoLbl_1.textAlignment = NSTextAlignmentCenter;
                slNoLbl_1.numberOfLines = 1;
                slNoLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                locationLbl_1 = [[UILabel alloc] init];
                locationLbl_1.backgroundColor = [UIColor clearColor];
                locationLbl_1.layer.borderWidth = 0;
                locationLbl_1.textAlignment = NSTextAlignmentCenter;
                locationLbl_1.numberOfLines = 1;
                locationLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                dateLbl_1 = [[UILabel alloc] init];
                dateLbl_1.backgroundColor = [UIColor clearColor];
                dateLbl_1.layer.borderWidth = 0;
                dateLbl_1.textAlignment = NSTextAlignmentCenter;
                dateLbl_1.numberOfLines = 1;
                dateLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                skuIdLbl_1 = [[UILabel alloc] init];
                skuIdLbl_1.backgroundColor = [UIColor clearColor];
                skuIdLbl_1.textAlignment = NSTextAlignmentCenter;
                skuIdLbl_1.numberOfLines = 1;
                skuIdLbl_1.lineBreakMode = NSLineBreakByWordWrapping;
                
                description_1 = [[UILabel alloc] init];
                description_1.backgroundColor = [UIColor clearColor];
                description_1.textAlignment = NSTextAlignmentCenter;
                description_1.numberOfLines = 1;
                description_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                colorLbl_1 = [[UILabel alloc] init];
                colorLbl_1.backgroundColor = [UIColor clearColor];
                colorLbl_1.textAlignment = NSTextAlignmentCenter;
                colorLbl_1.numberOfLines = 1;
                colorLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                sizeLbl_1 = [[UILabel alloc] init];
                sizeLbl_1.backgroundColor = [UIColor clearColor];
                sizeLbl_1.textAlignment = NSTextAlignmentCenter;
                sizeLbl_1.numberOfLines = 1;
                sizeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                measureRangeLbl_1 = [[UILabel alloc] init];
                measureRangeLbl_1.backgroundColor = [UIColor clearColor];
                measureRangeLbl_1.textAlignment = NSTextAlignmentCenter;
                measureRangeLbl_1.numberOfLines = 1;
                measureRangeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                gradeLbl_1 = [[UILabel alloc] init];
                gradeLbl_1.backgroundColor = [UIColor clearColor];
                gradeLbl_1.textAlignment = NSTextAlignmentCenter;
                gradeLbl_1.numberOfLines = 1;
                gradeLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                eanLbl_1 = [[UILabel alloc] init];
                eanLbl_1.backgroundColor = [UIColor clearColor];
                eanLbl_1.textAlignment = NSTextAlignmentCenter;
                eanLbl_1.numberOfLines = 1;
                eanLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                categoryLbl_1 = [[UILabel alloc] init];
                categoryLbl_1.backgroundColor = [UIColor clearColor];
                categoryLbl_1.textAlignment = NSTextAlignmentCenter;
                categoryLbl_1.numberOfLines = 1;
                categoryLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                uomLbl_1 = [[UILabel alloc] init];
                uomLbl_1.backgroundColor = [UIColor clearColor];
                uomLbl_1.textAlignment = NSTextAlignmentCenter;
                uomLbl_1.numberOfLines = 1;
                uomLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                packQtyLbl_1 = [[UILabel alloc] init];
                packQtyLbl_1.backgroundColor = [UIColor clearColor];
                packQtyLbl_1.textAlignment = NSTextAlignmentCenter;
                packQtyLbl_1.numberOfLines = 1;
                packQtyLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                stockQtyLbl_1 = [[UILabel alloc] init];
                stockQtyLbl_1.backgroundColor = [UIColor clearColor];
                stockQtyLbl_1.textAlignment = NSTextAlignmentCenter;
                stockQtyLbl_1.numberOfLines = 1;
                stockQtyLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                costPriceLbl_1 = [[UILabel alloc] init];
                costPriceLbl_1.backgroundColor = [UIColor clearColor];
                costPriceLbl_1.textAlignment = NSTextAlignmentCenter;
                costPriceLbl_1.numberOfLines = 1;
                costPriceLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                salePriceLbl_1 = [[UILabel alloc] init];
                salePriceLbl_1.backgroundColor = [UIColor clearColor];
                salePriceLbl_1.textAlignment = NSTextAlignmentCenter;
                salePriceLbl_1.numberOfLines = 1;
                salePriceLbl_1.lineBreakMode = NSLineBreakByTruncatingTail;
                
                
                itemQtyInhandLbl = [[UILabel alloc] init];
                itemQtyInhandLbl.backgroundColor = [UIColor clearColor];
                itemQtyInhandLbl.textAlignment = NSTextAlignmentCenter;
                itemQtyInhandLbl.numberOfLines = 1;
                itemQtyInhandLbl.lineBreakMode = NSLineBreakByTruncatingTail;
                
                itemprice = [[UIProgressView alloc] init];
                itemprice.trackTintColor = [UIColor whiteColor];
                
                UIColor * progressColor = [UIColor colorWithRed:60.0/255 green:127.0/255 blue:4.0/255 alpha:1.0];
                itemprice.progressTintColor = progressColor;
                
                
                itemsSummaryBtn = [[UIButton alloc] init];
                [itemsSummaryBtn addTarget:self action:@selector(navigateToStockCard:) forControlEvents:UIControlEventTouchDown];
                itemsSummaryBtn.layer.cornerRadius = 3.0f;
                itemsSummaryBtn.backgroundColor = [UIColor clearColor];
                [itemsSummaryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                itemsSummaryBtn.userInteractionEnabled = NO;
                itemsSummaryBtn.tag = indexPath.row;
                
                slNoLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                locationLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                dateLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                skuIdLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                description_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                colorLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                sizeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                measureRangeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                gradeLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                eanLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                categoryLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                uomLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                packQtyLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                stockQtyLbl_1.textColor = [UIColor orangeColor];
                costPriceLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                salePriceLbl_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                itemQtyInhandLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                [hlcell.contentView addSubview:slNoLbl_1];
                [hlcell.contentView addSubview:locationLbl_1];
                [hlcell.contentView addSubview:dateLbl_1];
                [hlcell.contentView addSubview:skuIdLbl_1];
                [hlcell.contentView addSubview:description_1];
                [hlcell.contentView addSubview:colorLbl_1];
                [hlcell.contentView addSubview:sizeLbl_1];
                [hlcell.contentView addSubview:measureRangeLbl_1];
                [hlcell.contentView addSubview:gradeLbl_1];
                [hlcell.contentView addSubview:eanLbl_1];
                [hlcell.contentView addSubview:categoryLbl_1];
                [hlcell.contentView addSubview:uomLbl_1];
                [hlcell.contentView addSubview:packQtyLbl_1];
                [hlcell.contentView addSubview:costPriceLbl_1];
                [hlcell.contentView addSubview:salePriceLbl_1];
                [hlcell.contentView addSubview:itemprice];
                [hlcell.contentView addSubview:stockQtyLbl_1];
                
                [hlcell.contentView addSubview:itemQtyInhandLbl];
                [hlcell.contentView addSubview:itemsSummaryBtn];
                
                //setting frame and font........
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    itemprice.transform = CGAffineTransformMakeScale(1.0, 10.0);
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
                    
                    slNoLbl_1.frame = CGRectMake(0,0,[labelSidesArr[0] floatValue],hlcell.frame.size.height);
                    
                    locationLbl_1.frame = CGRectMake(slNoLbl_1.frame.origin.x + slNoLbl_1.frame.size.width + 2, 0, [labelSidesArr[1] floatValue],  slNoLbl_1.frame.size.height);
                    
                    dateLbl_1.frame = CGRectMake(locationLbl_1.frame.origin.x + locationLbl_1.frame.size.width + 2, 0, [labelSidesArr[2] floatValue],  slNoLbl_1.frame.size.height);
                    
                    skuIdLbl_1.frame = CGRectMake(dateLbl_1.frame.origin.x + dateLbl_1.frame.size.width + 2, 0, [labelSidesArr[3] floatValue],  slNoLbl_1.frame.size.height);
                    
                    description_1.frame = CGRectMake( skuIdLbl_1.frame.origin.x + skuIdLbl_1.frame.size.width + 2, 0, [labelSidesArr[4] floatValue],  slNoLbl_1.frame.size.height);
                    
                    colorLbl_1.frame = CGRectMake( description_1.frame.origin.x + description_1.frame.size.width + 2, 0, [labelSidesArr[5] floatValue],  slNoLbl_1.frame.size.height);
                    
                    sizeLbl_1.frame = CGRectMake( colorLbl_1.frame.origin.x + colorLbl_1.frame.size.width + 2, 0, [labelSidesArr[6] floatValue],  slNoLbl_1.frame.size.height);
                    
                    measureRangeLbl_1.frame = CGRectMake( sizeLbl_1.frame.origin.x + sizeLbl_1.frame.size.width + 2, 0, [labelSidesArr[7] floatValue],  slNoLbl_1.frame.size.height);
                    
                    gradeLbl_1.frame = CGRectMake( measureRangeLbl_1.frame.origin.x + measureRangeLbl_1.frame.size.width + 2, 0, [labelSidesArr[8] floatValue],  slNoLbl_1.frame.size.height);
                    
                    eanLbl_1.frame = CGRectMake( gradeLbl_1.frame.origin.x + gradeLbl_1.frame.size.width + 2, 0, [labelSidesArr[9] floatValue],  slNoLbl_1.frame.size.height);
                    
                    categoryLbl_1.frame = CGRectMake(eanLbl_1.frame.origin.x + eanLbl_1.frame.size.width + 2, 0, [labelSidesArr[10] floatValue],  slNoLbl_1.frame.size.height);
                    
                    uomLbl_1.frame = CGRectMake( categoryLbl_1.frame.origin.x + categoryLbl_1.frame.size.width + 2, 0, [labelSidesArr[11] floatValue],  slNoLbl_1.frame.size.height);
                    
                    packQtyLbl_1.frame = CGRectMake(uomLbl_1.frame.origin.x + uomLbl_1.frame.size.width + 2, 0, [labelSidesArr[12] floatValue],  slNoLbl_1.frame.size.height);
                    
                    itemprice.frame =  CGRectMake(packQtyLbl_1.frame.origin.x + packQtyLbl_1.frame.size.width + 2,15,[labelSidesArr[13] floatValue],30);
                    
                    stockQtyLbl_1.frame = CGRectMake(packQtyLbl_1.frame.origin.x + packQtyLbl_1.frame.size.width + 2,2,[labelSidesArr[13] floatValue],30);
                    
                    costPriceLbl_1.frame = CGRectMake( stockQtyLbl_1.frame.origin.x + stockQtyLbl_1.frame.size.width + 2,0,[labelSidesArr[14] floatValue],  slNoLbl_1.frame.size.height);
                    
                    salePriceLbl_1.frame = CGRectMake( costPriceLbl_1.frame.origin.x + costPriceLbl_1.frame.size.width + 2,0,[labelSidesArr[15] floatValue],  slNoLbl_1.frame.size.height);
                    
                    
                    itemQtyInhandLbl.frame =  CGRectMake( salePriceLbl_1.frame.origin.x + salePriceLbl_1.frame.size.width + 2, 5, [labelSidesArr[16] floatValue],30);
                    
                    itemsSummaryBtn.frame =  CGRectMake( itemQtyInhandLbl.frame.origin.x + itemQtyInhandLbl.frame.size.width + 2, 0, [labelSidesArr[17] floatValue],  slNoLbl_1.frame.size.height);
                    
                    CATransform3D transform = CATransform3DScale(itemprice.layer.transform, 1.0f, 10.0f, 1.0f);
                    itemprice.layer.transform = transform;
                    
                    [itemsSummaryBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0] forState:UIControlStateNormal];
                }
                else{
                    itemprice.transform = CGAffineTransformMakeScale(1.0, 3.0);
                }
                //populating text into the field's....
                
                if(commonDisplayArr.count > indexPath.row){
                    
                    NSMutableDictionary *tempDic = [commonDisplayArr[indexPath.row] mutableCopy];
                    
                    slNoLbl_1.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1)+ startIndexNumber ];
                    
                    locationLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:LOCATION] defaultReturn:@"--"];
                    
                    dateLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"orderDate"] defaultReturn:@"--"];
                    
                    skuIdLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"skuID"] defaultReturn:@"--"];
                    
                    description_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                    
                    colorLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:COLOR] defaultReturn:@"--"];
                    
                    sizeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:SIZE] defaultReturn:@"--"];
                    
                    measureRangeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@"--"];
                    
                    gradeLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
                    
                    eanLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:EAN] defaultReturn:@"--"];
                    
                    categoryLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];
                    
                    //reorderPointLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue]];
                    
                    uomLbl_1.text = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"uom"] defaultReturn:@"--"];
                    
                    packQtyLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                    
                    stockQtyLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:STOCK_QTY] defaultReturn:@"0.00"] floatValue]];
                    
                    costPriceLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]];
                    
                    salePriceLbl_1.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]];
                    
                    itemQtyInhandLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:STOCK_VALUE] defaultReturn:@"0.00"] floatValue]];
                    
                    //if(([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue]) && ([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue])){
                    
                    //float totalQty = [[self checkGivenValueIsNullOrNil:[tempDic valueForKey:REORDER_POINT] defaultReturn:@"0.00"] floatValue] * 4;
                    
                    //  itemprice.progress = ([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]) / totalQty;
                    
                    //}
                    //else
                    
                    if([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]>=1){
                        
                        itemprice.progress = 1;
                        
                    }
                    else{
                        itemprice.progress = 0;
                    }
                    
                    [itemsSummaryBtn setTitle:NSLocalizedString(@"stock_card", nil) forState:UIControlStateNormal];
                    
                    itemsSummaryBtn.userInteractionEnabled = YES;
                    
                }
                else{
                    slNoLbl_1.text = @"--";
                    locationLbl_1.text = @"--";
                    dateLbl_1.text = @"--";
                    skuIdLbl_1.text = @"--";
                    description_1.text = @"--";
                    colorLbl_1.text = @"--";
                    sizeLbl_1.text = @"--";
                    
                    measureRangeLbl_1.text = @"--";
                    gradeLbl_1.text = @"--";
                    eanLbl_1.text = @"--";
                    categoryLbl_1.text = @"--";
                    //reorderPointLbl_1.text = @"--";
                    
                    uomLbl_1.text = @"--";
                    packQtyLbl_1.text = @"--";
                    stockQtyLbl_1.text = @"--";
                    costPriceLbl_1.text = @"--";
                    salePriceLbl_1.text = @"--";
                    itemQtyInhandLbl.text = @"--";
                    
                    itemprice.progress = 0;
                    
                    [itemsSummaryBtn setTitle:@"--" forState:UIControlStateNormal];
                    
                }
            } @catch (NSException *exception) {
                
            }
            @finally {
                
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                return hlcell;
            }
        }
    }
    
    else if(tableView == categoriesListTbl) {
        
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
            hlcell.textLabel.text = locationWiseCategoriesArr[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
        
    }
    else if(tableView == subCategoriesListTbl) {
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
            hlcell.textLabel.text = subCategoriesListArr[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        } @catch (NSException *exception) {
            
        }
        
        return hlcell;
        
    }
    
    else if(tableView == departmentListTbl) {
        
        static NSString * CellIdentifier = @"Cell";
        
        UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (hlcell == nil) {
            hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            hlcell.frame = CGRectZero;
        }
        if ((hlcell.contentView).subviews){
            for (UIView * subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        @try {
            hlcell.textLabel.numberOfLines = 1;
            hlcell.textLabel.text = departmentListArr[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } @catch (NSException *exception) {
            
        }
        
        return hlcell;
    }
    else if(tableView == subDepartmentListTbl) {
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
            hlcell.textLabel.text = subDepartmentListArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } @catch (NSException *exception) {
            
        }
        
        return hlcell;
    }
    
    else if(tableView == brandsTbl) {
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
            hlcell.textLabel.text = locationWiseBrandsArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.textColor = [UIColor blackColor];
            
        } @catch (NSException *exception) {
            
        }
        
        
        return hlcell;
        
    }
    
    else if (tableView == sectionTbl) {
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
            
            hlcell.textLabel.text = sectionArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    
    else if(tableView == supplierListTbl) {
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
            hlcell.textLabel.text = supplierListArr[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        } @catch (NSException *exception) {
            
            
        }
        
        return hlcell;
    }
    
    else if (tableView == modelTable){
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
            
            hlcell.textLabel.text = modelListArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    else if (tableView == pagenationTbl) {
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
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
        }
    }
    
    else if (tableView == quantityTblView) {
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
            
            hlcell.textLabel.text = quantityArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
        }
    }
    
    else if (tableView == locationTable) {
        
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
            
            //hlcell.textLabel.text = [[locationArr objectAtIndex:indexPath.row] valueForKey:LOCATION_ID];
            //if(locationTxt.tag == 0)
            hlcell.textLabel.text = locationArr[indexPath.row];
            //else
            //hlcell.textLabel.text = [zoneListArr objectAtIndex:indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
}

/**
 * @description  it is tableViewDelegate method it will execute. When an cell is selected in Table.....
 * @date         15/03/2017
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
    
    //dismissing the catPopOver....
    [catPopOver dismissPopoverAnimated:YES];
    
    if(tableView == sideMenuTable) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        
        sideMenuTable.tag = indexPath.row;

        @try {
            
            startIndexNumber = 0;
            pagenationTxt.text = @"1";
            
            typeOfStock = sidemenuTitles[indexPath.row];
            
            if ([typeOfStock isEqualToString:NSLocalizedString(@"demand_forecast",nil)]) {
                
                if (commonDisplayArr.count) {
                    [commonDisplayArr removeAllObjects];
                    [pagenationArr removeAllObjects];
                }
                
                packQtyValueLbl.text  = @"0.0";
                stockQtyValueLbl.text = @"0.0";
                stockValueLbl.text = @"0.0";
                
                totalQtyValuelbl.text = @"0.0";
                totalInventoryValueLbl.text = @"0.0";
                
                headerNameLbl.text = NSLocalizedString(@"header_demand_forecast",nil);
                
                commonDisplayTbl.hidden = YES;
                
                float y_axis = self.view.frame.size.height - 120;
                
                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
                
            }
            
            else if([typeOfStock isEqualToString:NSLocalizedString(@"available_stock", nil)]) {
                
                selectedStockTypeStr  = NSLocalizedString(@"available_stock", nil);
                serviceCallStr = @"normal";
                
                commonDisplayTbl.hidden = NO;
                
                
                NSString * lastLabelWidth = [NSString stringWithFormat:@"%.2f",(searchItemsTxt.frame.size.width - 900)];
                
                labelSidesArr = @[@"50",@"80",@"120",@"70", @"50",@"60",@"60",@"95",@"80",@"80",@"50",@"80",@"100",@"90",@"100",lastLabelWidth];
                
                [self populateLables:@[NSLocalizedString(@"s_no",nil),NSLocalizedString(@"sku_id",nil),NSLocalizedString(@"item_desc",nil),NSLocalizedString(@"color",nil),NSLocalizedString(@"size",nil),NSLocalizedString(@"measure_range",nil),NSLocalizedString(@"grade",nil),NSLocalizedString(@"ean",nil),NSLocalizedString(@"category",nil),NSLocalizedString(@"re_order",nil),NSLocalizedString(@"uom", nil),NSLocalizedString(@"pack_qty",nil),NSLocalizedString(@"stock_qty",nil),NSLocalizedString(@"cost_price",nil),NSLocalizedString(@"stock_value",nil),NSLocalizedString(@"action",nil)] widthsArr:
                 
                 @[@"50",@"80",@"120",@"70",@"50",@"60",@"60",@"95",@"80",@"80",@"50",@"80",@"100",@"90",@"100",lastLabelWidth]];
                
                headerNameLbl.text = NSLocalizedString(@"header_available_stock", nil);
            }
            else if ([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock", nil)]){
                
                selectedStockTypeStr  = NSLocalizedString(@"daily_stock", nil);
                
                serviceCallStr = @"DayWise";
                
                NSString * lastLabelWidth = [NSString stringWithFormat:@"%.2f",(searchItemsTxt.frame.size.width - 900) ];
                
                labelSidesArr = @[@"46",@"80",@"140",@"60",@"60",@"60",@"60",@"80",@"80",@"90",@"60",@"160",@"160",lastLabelWidth];
                
                NSString * openString = [NSString stringWithFormat:@"%@",NSLocalizedString(@"packs", nil)];
                
                [self populateLables:@[NSLocalizedString(@"s_no",nil),NSLocalizedString(@"sku_id",nil),NSLocalizedString(@"item_desc",nil),NSLocalizedString(@"colour",nil),NSLocalizedString(@"size",nil),NSLocalizedString(@"measure_range",nil),NSLocalizedString(@"grade",nil),NSLocalizedString(@"ean",nil),NSLocalizedString(@"category",nil),NSLocalizedString(@"date",nil),NSLocalizedString(@"uom",nil),[NSString stringWithFormat:@"%@ \r %@",NSLocalizedString(@"open",nil),openString],[NSString stringWithFormat:@"%@ \r %@",NSLocalizedString(@"close",nil),openString],NSLocalizedString(@"stock_value",nil)] widthsArr:
                 @[@"46",@"80",@"140",@"60",@"60",@"60",@"60",@"80",@"80",@"90",@"60",@"160",@"160",lastLabelWidth]];
                
                headerNameLbl.text = NSLocalizedString(@"header_daily_stock", nil);
                
            }
            else if ([typeOfStock isEqualToString:NSLocalizedString(@"critical_stock", nil)]){
                
                selectedStockTypeStr  = NSLocalizedString(@"critical_stock", nil);
                serviceCallStr = @"critical";
                
                NSString * lastLabelWidth = [NSString stringWithFormat:@"%.2f",(searchItemsTxt.frame.size.width - 900)];
                
                labelSidesArr = @[@"50",@"90",@"130",@"60", @"50",@"60",@"60",@"75",@"90",@"80",@"50",@"80",@"100",@"90",@"100",lastLabelWidth];
                
                [self populateLables:@[NSLocalizedString(@"s_no",nil),NSLocalizedString(@"sku_id",nil),NSLocalizedString(@"item_desc",nil),NSLocalizedString(@"color",nil),NSLocalizedString(@"size",nil),NSLocalizedString(@"measure_range",nil),NSLocalizedString(@"grade",nil),NSLocalizedString(@"ean",nil),NSLocalizedString(@"category",nil),NSLocalizedString(@"re_order",nil),NSLocalizedString(@"uom", nil),NSLocalizedString(@"pack_qty",nil),NSLocalizedString(@"stock_qty",nil),NSLocalizedString(@"cost_price",nil),NSLocalizedString(@"stock_value",nil),NSLocalizedString(@"action",nil)] widthsArr:
                 
                 @[@"50",@"90",@"130",@"60", @"50",@"60",@"60",@"75",@"90",@"80",@"50",@"80",@"100",@"90",@"100",lastLabelWidth]];
                
                headerNameLbl.text = NSLocalizedString(@"header_critical_stock", nil);
            }
            else if ([typeOfStock isEqualToString:NSLocalizedString(@"ordered_stock", nil)]){
                
                selectedStockTypeStr  = NSLocalizedString(@"ordered_stock", nil);
                serviceCallStr = @"ordered";
                
                NSString * lastLabelWidth = [NSString stringWithFormat:@"%.2f",(searchItemsTxt.frame.size.width - 900) ];
                
                labelSidesArr = @[@"51",@"110",@"110",@"90",@"140",@"70",@"60",@"60",@"60",@"90",@"85",@"50",@"100",@"100",@"100",@"100",lastLabelWidth];
                
                [self populateLables:@[NSLocalizedString(@"s_no",nil),NSLocalizedString(@"ordered_date",nil),NSLocalizedString(@"delivery_Date",nil),NSLocalizedString(@"sku_id",nil),NSLocalizedString(@"item_desc",nil),NSLocalizedString(@"colour",nil),NSLocalizedString(@"size",nil),NSLocalizedString(@"measure_range",nil),NSLocalizedString(@"grade",nil),NSLocalizedString(@"category",nil),NSLocalizedString(@"ean",nil),NSLocalizedString(@"uom",nil),NSLocalizedString(@"order_packs", nil),NSLocalizedString(@"order_qty",nil),NSLocalizedString(@"cost_price",nil),NSLocalizedString(@"order_value",nil),NSLocalizedString(@"action",nil)] widthsArr:
                 @[@"51",@"110",@"110",@"90",@"140",@"70",@"60",@"60",@"60",@"90",@"85",@"50",@"100",@"100",@"100",@"100",lastLabelWidth]];
                
                headerNameLbl.text = NSLocalizedString(@"header_ordered_stock", nil);
                
            }
            else if ([typeOfStock isEqualToString:NSLocalizedString(@"blocked_stock", nil)]){
                
                selectedStockTypeStr  = NSLocalizedString(@"blocked_stock", nil);
                serviceCallStr = @"blocked";
                
                NSString * lastLabelWidth = [NSString stringWithFormat:@"%.2f",(searchItemsTxt.frame.size.width - 900) ];
                
                labelSidesArr = @[@"51",@"90",@"140",@"85",@"60",@"60",@"60",@"100",@"90",@"60",@"80",@"100",@"90",@"90",@"100",lastLabelWidth];
                
                [self populateLables:@[NSLocalizedString(@"s_no", nil),NSLocalizedString(@"sku_id",nil),NSLocalizedString(@"item_desc", nil),NSLocalizedString(@"color",nil),NSLocalizedString(@"size",nil),NSLocalizedString(@"measure_range", nil),NSLocalizedString(@"grade", nil),NSLocalizedString(@"ean",nil), NSLocalizedString(@"re_order",nil), NSLocalizedString(@"uom",nil),NSLocalizedString(@"pack_qty", nil),NSLocalizedString(@"stock_qty",nil),NSLocalizedString(@"category",nil),NSLocalizedString(@"cost_price",nil),NSLocalizedString(@"stock_value",nil), NSLocalizedString(@"action",nil)]
                           widthsArr:
                 @[@"51",@"90",@"140",@"85",@"60",@"60",@"60",@"100",@"90",@"60",@"80",@"100",@"90",@"90",@"100",lastLabelWidth]];
                
                headerNameLbl.text = NSLocalizedString(@"header_blocked_stock", nil);
                
            }
            else if ([typeOfStock isEqualToString:NSLocalizedString(@"returned_stock", nil)]){
                
                selectedStockTypeStr  = NSLocalizedString(@"returned_stock", nil);
                serviceCallStr = @"returned";
                
                NSString * lastLabelWidth = [NSString stringWithFormat:@"%.2f",(searchItemsTxt.frame.size.width - 900) ];
                
                labelSidesArr = @[@"51",@"90",@"140",@"65",@"60",@"60",@"70",@"90",@"80",@"80",@"90",@"100",@"90",@"90",@"100",lastLabelWidth];
                
                [self populateLables:@[NSLocalizedString(@"s_no", nil),NSLocalizedString(@"sku_id",nil),NSLocalizedString(@"item_desc", nil),NSLocalizedString(@"color",nil),NSLocalizedString(@"size",nil),NSLocalizedString(@"measure_range", nil),NSLocalizedString(@"grade", nil),NSLocalizedString(@"ean",nil), NSLocalizedString(@"re_order",nil), NSLocalizedString(@"uom",nil),NSLocalizedString(@"pack_qty", nil),NSLocalizedString(@"stock_qty",nil),NSLocalizedString(@"category",nil),NSLocalizedString(@"cost_price",nil),NSLocalizedString(@"stock_value",nil), NSLocalizedString(@"action",nil)]
                           widthsArr:@[@"51",@"90",@"140",@"65",@"60",@"60",@"70",@"90",@"80",@"80",@"90",@"100",@"90",@"90",@"100",lastLabelWidth]];
                
                headerNameLbl.text = NSLocalizedString(@"header_returned_stock", nil);
            }
            else if ([typeOfStock isEqualToString:NSLocalizedString(@"boneyard",nil)]){
                
                selectedStockTypeStr  = NSLocalizedString(@"boneyard",nil);
                serviceCallStr = @"boneyard";
                
                NSString * lastLabelWidth = [NSString stringWithFormat:@"%.2f",(searchItemsTxt.frame.size.width - 900) ];
                
                labelSidesArr = @[@"51",@"90",@"90",@"90",@"140",@"80",@"60",@"60",@"60",@"90",@"95",@"70",@"100",@"100",@"90",@"100",@"100",lastLabelWidth];
                
                [self populateLables:@[NSLocalizedString(@"s_no", nil),NSLocalizedString(@"location", nil),NSLocalizedString(@"date", nil),NSLocalizedString(@"sku_id", nil),NSLocalizedString(@"item_desc", nil),NSLocalizedString(@"color", nil),NSLocalizedString(@"size", nil),NSLocalizedString(@"measure_range",nil),NSLocalizedString(@"grade",nil),NSLocalizedString(@"ean",nil),NSLocalizedString(@"category",nil),NSLocalizedString(@"uom",nil),NSLocalizedString(@"dump_packs", nil),NSLocalizedString(@"dump_qty",nil),NSLocalizedString(@"cost_price",nil),NSLocalizedString(@"sale_price",nil),NSLocalizedString(@"dump_value",nil),NSLocalizedString(@"action",nil)] widthsArr:
                 @[@"51",@"90",@"90",@"90",@"140",@"80",@"60",@"60",@"60",@"90",@"95",@"70",@"100",@"100",@"90",@"100",@"100",lastLabelWidth]];
                
                headerNameLbl.text = NSLocalizedString(@"header_bonyard_stock", nil);
            }
            
            /*added by Srinivasulu on 13/04/2017....*/
            searchBtn.tag  = 2;
            
            categoryTxt.text      = @"";
            subCategoryTxt.text   = @"";
            departmentTxt.text    = @"";
            subDepartmentTxt.text = @"";
            brandTxt.text         = @"";
            
            [self removeSideMenu];
            
            
            if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
                startIndexNumber = 0;
                [self getDailyStockReport:serviceCallStr];
                
            }
            
            else
                if (![typeOfStock isEqualToString:NSLocalizedString(@"demand_forecast",nil)]) {
                    
                    startIndexNumber = 0;
                    [self normalStockServiceCall:serviceCallStr];
                    
                }
            
        } @catch (NSException * exception) {
            
        } @finally {
            
        }
    }
    else if (tableView == commonDisplayTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            NSDictionary * detailsDic = commonDisplayArr[indexPath.row];
            
            [HUD setHidden:NO];
            
            HUD.labelText =  NSLocalizedString(@"please_wait..",nil);
            
            NSString * skuStr;
            
            if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
                
                skuStr = [NSString stringWithFormat:@"%@",detailsDic[@"skuId"]];
            }
            else
                
                skuStr = [NSString stringWithFormat:@"%@",detailsDic[@"skuID"]];
            
            [self callingSkuDetails:skuStr];
            
        } @catch (NSException *exception) {
            
        }
        
    }
    
    else if(tableView == departmentListTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            departmentListTbl.tag = indexPath.row;
            
            departmentTxt.text = departmentListArr[indexPath.row];
            
            //subDepartmentListTbl.tag = 2;
            
            subDepartmentTxt.text = @"";
            
            subDepartmentListArr = [[dept_SubDeptDic valueForKey:departmentListArr[indexPath.row]] mutableCopy];
            
        } @catch (NSException *exception) {
            
        }
    }
    else if(tableView == subDepartmentListTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            subDepartmentListTbl.tag = indexPath.row;
            
            subDepartmentTxt.text = subDepartmentListArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    else if(tableView == categoriesListTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            categoriesListTbl.tag = indexPath.row;
            
            categoryTxt.text = locationWiseCategoriesArr[indexPath.row];
            
            subCategoryTxt.text = @"";
            
            if(subCategoriesListArr.count && subCategoriesListArr != nil)
                [subCategoriesListArr removeAllObjects];
            
        } @catch (NSException *exception) {
            
        }
    }
    else if(tableView == subCategoriesListTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            subCategoriesListTbl.tag = indexPath.row;
            
            subCategoryTxt.text = subCategoriesListArr[indexPath.row];
            
        } @catch (NSException * exception) {
            
        }
    }
    else if(tableView == brandsTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            brandsTbl.tag = indexPath.row;
            
            brandTxt.text = locationWiseBrandsArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == sectionTbl) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        
        sectionTbl.tag = indexPath.row;
        
        sectionTxt.text = sectionArr[indexPath.row];
    }
    
    else if(tableView == supplierListTbl) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            supplierListTbl.tag = indexPath.row;
            
            supplierTxt.text = supplierListArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if(tableView == modelTable) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            modelTable.tag = indexPath.row;
            
            modelTxt.text = modelListArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    //Newly added for the location filter...
    
    else if(tableView == locationTable) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            categoryTxt.tag = 2;
            brandTxt.tag = 1;
            
            categoryTxt.text = @"";
            subCategoryTxt.text = @"";
            brandTxt.text = @"";
            searchItemsTxt.text = @"";
            
            locationTable.tag = indexPath.row;
            locationTxt.text = locationArr[indexPath.row];
            
            
            searchItemsTxt.tag = (searchItemsTxt.text).length;
            
        } @catch (NSException *exception) {
            NSLog(@"----exception in changing the textFieldData in didSelec----%@",exception);
        }
    }
    else if (tableView == pagenationTbl){
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            startIndexNumber = 0;
            pagenationTxt.text = pagenationArr[indexPath.row];
            int pageValue = (pagenationTxt.text).intValue;
            startIndexNumber = startIndexNumber + (pageValue * 10) - 10;
        } @catch (NSException * exception) {
            
        }
    }
    else if(tableView == quantityTblView) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            //modelTable.tag = indexPath.row;
            
            itemText.text = quantityArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    
}


#pragma mark textView Delegates:

/**
 * @description  it is an textViewDelegate method it will be executed when user interaction........
 * @date         16/09/2016
 * @method       textViewShouldBeginEditing;
 * @author       Bhargav.v
 * @param        UITextView
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return  NO;
    
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
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if(textView == descriptionView) {
        
        
    }
    
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
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma -mark Start of TextFieldDelegates.......
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
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    @try {
        
    } @catch (NSException *exception) {
        
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
    
    return  YES;
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

- (void)textFieldDidChange:(UITextField *)textField {
    
    @try {
        if(textField == searchItemsTxt){
            
            if ((textField.text).length >= 3) {
                
                @try {
                    if (searchItemsTxt.tag == 0) {
                        searchItemsTxt.tag = (textField.text).length;
                        
                        
                        if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
                            
                            [self getDailyStockReport:serviceCallStr];
                            
                        }
                        else {
                            
                            [self normalStockServiceCall:serviceCallStr];
                            
                        }
                    }
                    
                } @catch (NSException *exception) {
                    NSLog(@"---- exception while calling getSuppliers ServicesCall ----%@",exception);
                }
            }
            
            else if ((searchItemsTxt.text).length == 0 ) {
                
                if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
                    
                    [self getDailyStockReport:serviceCallStr];
                }
                else {
                    [self normalStockServiceCall:serviceCallStr];
                    
                }
            }
            else{
                
                [HUD setHidden:YES];
                searchItemsTxt.tag = 0;
            }
        }
        
    } @catch (NSException * exception) {
        
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

-(void)textFieldDidEndEditing:(UITextField *)textField{
    @try {
        [self keyboardWillHide];
        offSetViewTo = 0;
        
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing the quantity-----%@",exception);
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


#pragma -mark methods related to the gesture....

/**
 * @description  this method will be executed then the user move on the view....
 * @date         31/03/2017
 * @method       handleSwipeFrom:
 * @author       Srinivasulu
 * @param        UISwipeGestureRecognizer
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self removeSideMenu];
    }
    else {
        [self openSideMenu];
    }
}

/**
 * @description  this method will be executed then the user touched on the view....
 * @date         31/03/2017
 * @method       singleTapView:
 * @author       Srinivasulu
 * @param        UISwipeGestureRecognizer
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)singleTapView:(UITapGestureRecognizer *)gestureRecognizer {
    //    if (sideMenu.alpha == 0) {
    //    //[self openSideMenu];
    //    }
    //    else {
    //        [self removeSideMenu];
    //    }
}

/**
 * @description  this method will be executed then the user touched on the view....
 * @date         31/03/2017
 * @method       touchesBegan: withEvent:
 * @author       Srinivasulu
 * @param        UISwipeGestureRecognizer
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self removeSideMenu];
}

#pragma -mark actions related to sideMenu....

/**
 * @description  this method will be executed based on user gestures and button click.....
 * @date         31/03/2017
 * @method       openSideMenu
 * @author       Srinivasulu
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

- (void)openSideMenu {
    
    @try {
        
        AudioServicesPlaySystemSound (soundFileObject);
        
        if(transparentView == nil){
            
            sidemenuTitles = [NSMutableArray new];
            [sidemenuTitles addObject:NSLocalizedString(@"demand_forecast", nil)];
            [sidemenuTitles addObject:NSLocalizedString(@"available_stock", nil)];
            [sidemenuTitles addObject:NSLocalizedString(@"daily_stock", nil)];
            [sidemenuTitles addObject:NSLocalizedString(@"ordered_stock",nil)];
            [sidemenuTitles addObject:NSLocalizedString(@"critical_stock", nil)];
            [sidemenuTitles addObject:NSLocalizedString(@"blocked_stock", nil)];
            [sidemenuTitles addObject:NSLocalizedString(@"returned_stock", nil)];
            [sidemenuTitles addObject:NSLocalizedString(@"boneyard", nil)];
            
            sidemenuImages = [NSMutableArray new];
            [sidemenuImages addObject:@"DemandForcast.png"];
            [sidemenuImages addObject:@"Available_Stock.png"];
            
            //Added on 28/11/2017 by Bhargav to show the daily stock image as available stock image..(Temporarly)
            [sidemenuImages addObject:@"Available_Stock.png"];
            //Up to here...
            [sidemenuImages addObject:@"Ordered_Stock.png"];
            [sidemenuImages addObject:@"Critical_Stock.png"];
            [sidemenuImages addObject:@"Blocked_Stock.png"];
            [sidemenuImages addObject:@"Returned_Stock.png"];
            [sidemenuImages addObject:@"Scrap_Stock.png"];
            
            transparentView = [[UIView alloc] initWithFrame:CGRectMake( 0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
            transparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
            
            sideMenu = [[UIView alloc] initWithFrame:CGRectMake( 0.0, 0.0, 320.0, 800.0)];
            sideMenu.backgroundColor = [UIColor lightGrayColor];
            sideMenu.layer.cornerRadius = 8.0f;
            
            sideMenuTable = [[UITableView alloc] init];
            sideMenuTable.dataSource = self;
            sideMenuTable.delegate = self;
            sideMenuTable.backgroundColor = [UIColor clearColor];
            sideMenuTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            sideMenuTable.frame = CGRectMake( 0.0, 70.0, sideMenu.frame.size.width, sideMenu.frame.size.height);
            
            CATransition *transition = [CATransition new];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            transition.duration = 0.5f;
            [sideMenu.layer addAnimation:transition forKey:@"transition"];
            [sideMenu addSubview:sideMenuTable];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:sideMenu];
            
            [self.view addSubview:transparentView];
            [sideMenuTable reloadData];
            
        }
        else   if(sideMenu.alpha == 1.0){
            
            sideMenu.alpha = 0.0;
            
            CATransition *transition = [CATransition new];
            transition.type = kCATransitionReveal;
            transition.subtype = kCATransitionFromRight;
            transition.duration = 0.5f;
            [sideMenu.layer addAnimation:transition forKey:@"transition"];
            
            transparentView.alpha = 0.0;        }
        else{
            
            sideMenu.alpha = 1.0;
            
            CATransition *transition = [CATransition new];
            transition.type = kCATransitionReveal;
            transition.subtype = kCATransitionFromRight;
            transition.duration = 0.5f;
            [sideMenu.layer addAnimation:transition forKey:@"transition"];
            
            transparentView.alpha = 1.0;
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)removeSideMenu {
    
    @try {
        
        //[UIView beginAnimations: @"Fade Out" context:nil];
        
        // wait for time before begin
        
        //[UIView setAnimationDelay:0.3];
        
        // druation of animation
        //[UIView setAnimationDuration:0.8];
        sideMenu.alpha = 0.0;
        //[UIView commitAnimations];
        
        CATransition * transition = [CATransition new];
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;
        transition.duration = 0.5f;
        [sideMenu.layer addAnimation:transition forKey:@"transition"];
        
        transparentView.alpha = 0.0;
    } @catch (NSException *exception) {
        
    } @finally {
    }
}

#pragma -mark action used for service calls....

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
 */

- (void)searchTheProducts:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        searchBtn.tag  = 4;
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0 && (brandTxt.text).length == 0 && (modelTxt.text).length == 0 && (startDteTxt.text).length == 0 && (endDteTxt.text).length== 0 && (departmentTxt.text).length == 0 && (subDepartmentTxt.text).length == 0 && (supplierTxt.text).length == 0 && (locationTxt.text).length == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_above_fields_before_proceeding",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        
        if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
            
            [self getDailyStockReport:serviceCallStr];
            
        }
        
        else
            if (![typeOfStock isEqualToString:NSLocalizedString(@"demand_forecast",nil)]) {
                
                startIndexNumber = 0;
                [self normalStockServiceCall:serviceCallStr];
            }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are creating request string for creation of new SupplierQuotation.......
 * @date         31/03/2017
 * @method       clearAllFilterInSearch
 * @author       Bhargav.v
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
        searchBtn.tag  = 2;
        
        categoryTxt.text      = @"";
        subCategoryTxt.text   = @"";
        brandTxt.text         = @"";
        sectionTxt.text       = @"";
        departmentTxt.text    = @"";
        subDepartmentTxt.text = @"";
        modelTxt.text         = @"";
        supplierTxt.text      = @"";
        startDteTxt.text      = @"";
        endDteTxt.text        = @"";
        
        
        locationTxt.text = presentLocation;
        
        if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
            
            startIndexNumber = 0;
            [self getDailyStockReport:serviceCallStr];
            
        }
        
        else
            if (![typeOfStock isEqualToString:NSLocalizedString(@"demand_forecast",nil)]) {
                
                startIndexNumber = 0;
                [self normalStockServiceCall:serviceCallStr];
            }
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
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

-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections{
    
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
        
        
        UITextView * textView = displayFrame;
        
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

#pragma -mark keyboard notification methods

/**
 * @description  called when keyboard is displayed
 * @date         15/03/2017
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
 * @date         15/03/2017
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
 * @date         15/03/2017
 * @method       setViewMovedUp
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)setViewMovedUp:(BOOL)movedUp
{
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
        userAlertMessageLbl.backgroundColor = [UIColor lightGrayColor];
        userAlertMessageLbl.layer.cornerRadius = 5.0f;
        userAlertMessageLbl.text =  message;
        userAlertMessageLbl.textAlignment = NSTextAlignmentCenter;
        userAlertMessageLbl.numberOfLines = noOfLines;
        
        userAlertMessageLbl.tag = 2;
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame) {
            userAlertMessageLbl.tag = 4;
            
            userAlertMessageLbl.textColor = [UIColor colorWithRed:114.0/255.0 green:203.0/255.0 blue:158.0/255.0 alpha:1.0];
            
            
            
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
 * @date         15/03/2017
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
        
        
        if ([userAlertMessageLbl isDescendantOfView:self.view])
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
 * @date         15/03/2017
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


#pragma - mark super class methods

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
        
        [self removeSideMenu];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } @catch (NSException *exception) {
        
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

-(void)showPaginationData:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [HUD setHidden:YES];
        
        if(pagenationArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        float tableHeight = pagenationArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArr.count * 33;
        
        if(pagenationArr.count> 5)
            tableHeight = (tableHeight/pagenationArr.count) * 5;
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:normalStockVeiw permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are navigation from current page to ViewStockRequest.......
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
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if([typeOfStock isEqualToString:NSLocalizedString(@"daily_stock",nil)]){
            
            [self getDailyStockReport:serviceCallStr];
        }
        else
            [self normalStockServiceCall:serviceCallStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
    }
}

@end

