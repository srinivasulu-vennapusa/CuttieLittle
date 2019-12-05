//
//  StockRequestView.m
//  OmniRetailer
//
//  Created by Bhargav Ram on 9/22/16.

#import "StockRequest.h"
#import "ViewStockRequest.h"
#import "NewStockRequest.h"
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "OmniHomePage.h"

@interface stockRequest ()

@end

@implementation stockRequest
//default setter and getter will be created for this type declearation....

//this properties are used for generating the sounds....
@synthesize soundFileURLRef,soundFileObject;

//this properties are to handle the interalcode of this class/viewController....
@synthesize isOpen,selectIndex,buttonSelectIndex,selectSectionIndex;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         21/09/2016
 * @method       ViewDidLoad
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 */

- (void)viewDidLoad {
    //calling super call method....
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
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
    
    //creating the stockRequestView which will displayed completed Screen...
    stockRequestView = [[UIView alloc] init];
    
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
    
    /*Creation of UIButton for providing user to select the dates.......*/
    UIImage  * summaryImage;
    
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    summaryImage = [UIImage imageNamed:@"emails-letters.png"];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self
                       action:@selector(callingStockRequestSumary:) forControlEvents:UIControlEventTouchDown];
    summaryInfoBtn.tag = 0;
    
    /*Creation of textField used in this page*/
    
    //changed by Srinivasulu on 10/05/2017....
    
    outletIdTxt = [[CustomTextField alloc] init];
    outletIdTxt.placeholder = NSLocalizedString(@"all_outlets", nil);
    outletIdTxt.userInteractionEnabled  = NO;
    outletIdTxt.delegate = self;
    [outletIdTxt awakeFromNib];
    
    zoneIdTxt = [[CustomTextField alloc] init];
    zoneIdTxt.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneIdTxt.delegate = self;
    zoneIdTxt.userInteractionEnabled  = NO;
    [zoneIdTxt awakeFromNib];
    
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDateTxt.userInteractionEnabled  = NO;
    startDateTxt.delegate = self;
    [startDateTxt awakeFromNib];
    
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.userInteractionEnabled = NO;
    endDateTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDateTxt.delegate = self;
    [endDateTxt awakeFromNib];
    
    statusTxt = [[CustomTextField alloc] init];
    statusTxt.userInteractionEnabled = NO;
    statusTxt.placeholder = NSLocalizedString(@"select_status", nil);
    statusTxt.delegate = self;
    [statusTxt awakeFromNib];
    
    
    searchItemsTxt = [[CustomTextField alloc] init];
    searchItemsTxt.placeholder = NSLocalizedString(@"search_request_id",nil);
    searchItemsTxt.delegate = self;
    searchItemsTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemsTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItemsTxt.textAlignment = NSTextAlignmentCenter;
    searchItemsTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItemsTxt.textColor = [UIColor blackColor];
    searchItemsTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemsTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    searchItemsTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
    [searchItemsTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    /*Creation of UIImage used for buttons*/
    UIImage * buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];
    UIImage * buttonImage = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    /* UIButton Used for Dropdown and PopUps*/
    UIButton * outletIdBtn;
    UIButton * zoneIdBtn;
    UIButton * showStartDateBtn;
    UIButton * showEndDateBtn;
    UIButton * categoryBtn;
    UIButton * subCatBtn;
    UIButton * brandBtn;
    UIButton * modelBtn;
    UIButton * stausBtn;
    
    outletIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outletIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [outletIdBtn addTarget:self
                    action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];
    
    zoneIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoneIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [zoneIdBtn addTarget:self
                  action:@selector(showAllZonesId:) forControlEvents:UIControlEventTouchDown];
    
    categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [categoryBtn addTarget:self
                    action:@selector(showAllLocationWiseCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    brandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [brandBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [brandBtn addTarget:self
                 action:@selector(showListOfAllBrands:) forControlEvents:UIControlEventTouchDown];
    
    modelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modelBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [modelBtn addTarget:self
                 action:@selector(showModelList:) forControlEvents:UIControlEventTouchDown];
    
    subCatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subCatBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [subCatBtn addTarget:self
                  action:@selector(showAllSubCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    showStartDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showStartDateBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [showStartDateBtn addTarget:self
                         action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    showEndDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showEndDateBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [showEndDateBtn addTarget:self
                       action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    stausBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stausBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [stausBtn addTarget:self
                 action:@selector(showWorkFlowStatus:) forControlEvents:UIControlEventTouchDown];
    
    //Creation of scroll view
    stockRequestScrollView = [[UIScrollView alloc] init];
    //stockRequestScrollView.backgroundColor = [UIColor lightGrayColor];
    
    
    /*Creation of UILabels used in this page*/
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    requestIDlbl = [[CustomLabel alloc] init];
    [requestIDlbl awakeFromNib];
    
    outletIDLbl = [[CustomLabel alloc] init];
    [outletIDLbl awakeFromNib];
    
    requestDateLbl = [[CustomLabel alloc] init];
    [requestDateLbl awakeFromNib];
    
    requestedByLbl = [[CustomLabel alloc] init];
    [requestedByLbl awakeFromNib];
    
    requestedByLbl = [[CustomLabel alloc] init];
    [requestedByLbl awakeFromNib];
    
    requestedQuantityLbl = [[CustomLabel alloc] init];
    [requestedQuantityLbl awakeFromNib];
    
    approvedQuantityLbl = [[CustomLabel alloc] init];
    [approvedQuantityLbl awakeFromNib];
    
    noOfItemslbl = [[CustomLabel alloc] init];
    [noOfItemslbl awakeFromNib];
    
    approvedItemsLbl = [[CustomLabel alloc] init];
    [approvedItemsLbl awakeFromNib];
    
    deliveryDteLbl = [[CustomLabel alloc] init];
    [deliveryDteLbl awakeFromNib];
    
    requestStatusLbl = [[CustomLabel alloc] init];
    [requestStatusLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    
    //stockRequestTable creation...
    stockRequestSummaryInfoTbl = [[UITableView alloc] init];
    stockRequestSummaryInfoTbl.backgroundColor  = [UIColor clearColor];
    stockRequestSummaryInfoTbl.layer.cornerRadius = 4.0;
    stockRequestSummaryInfoTbl.bounces = FALSE;
    stockRequestSummaryInfoTbl.dataSource = self;
    stockRequestSummaryInfoTbl.delegate = self;
    stockRequestSummaryInfoTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //    allocation of requestedItemsTblHeaderView
    
    requestedItemsTblHeaderView = [[UIView alloc] init];
    
    /*Creation of the UILabels*/
    itemNoLbl = [[CustomLabel alloc] init];
    [itemNoLbl awakeFromNib];
    
    itemCodeLbl = [[CustomLabel alloc] init];
    [itemCodeLbl awakeFromNib];

    
    itemNameLbl = [[CustomLabel alloc] init];
    [itemNameLbl awakeFromNib];
    
    itemGradeLbl = [[CustomLabel alloc] init];
    [itemGradeLbl awakeFromNib];

    currentStockLbl = [[CustomLabel alloc] init];
    [currentStockLbl awakeFromNib];

    itemRequestedQtyLbl = [[CustomLabel alloc] init];
    [itemRequestedQtyLbl awakeFromNib];

    itemApprrovedQtyLbl = [[CustomLabel alloc] init];
    [itemApprrovedQtyLbl awakeFromNib];

    itemApprovedByLbl = [[CustomLabel alloc] init];
    [itemApprovedByLbl awakeFromNib];
    
    
    [requestedItemsTblHeaderView addSubview:itemNoLbl];
    [requestedItemsTblHeaderView addSubview:itemCodeLbl];
    [requestedItemsTblHeaderView addSubview:itemNameLbl];
    [requestedItemsTblHeaderView addSubview:itemGradeLbl];
    [requestedItemsTblHeaderView addSubview:currentStockLbl];
    [requestedItemsTblHeaderView addSubview:itemRequestedQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemApprrovedQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemApprovedByLbl];
    
    /**creating UIButton*/
    UIButton * generateIndentsBtn;
    UIButton * saveAllBtn;
    UIButton * cancelBtn;
    
    saveAllBtn = [[UIButton alloc] init];
    [saveAllBtn addTarget:self
                   action:@selector(saveAllButton:) forControlEvents:UIControlEventTouchDown];
    saveAllBtn.layer.cornerRadius = 3.0f;
    saveAllBtn.backgroundColor = [UIColor grayColor];
    [saveAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    generateIndentsBtn = [[UIButton alloc] init];
    [generateIndentsBtn addTarget:self
                           action:@selector(gnerateIndentButton:) forControlEvents:UIControlEventTouchDown];
    generateIndentsBtn.layer.cornerRadius = 3.0f;
    generateIndentsBtn.backgroundColor = [UIColor grayColor];
    [generateIndentsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(cancelRequest:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.backgroundColor = [UIColor grayColor];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    pagenationTxt = [[CustomTextField alloc] init];
    pagenationTxt.userInteractionEnabled = NO;
    pagenationTxt.textAlignment = NSTextAlignmentCenter;
    pagenationTxt.delegate = self;
    [pagenationTxt awakeFromNib];
    
    UIButton * dropDownBtn;
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
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
    
    
    
    UIButton * clearBtn;
    
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self
                  action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.tag = 2;
    
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //adding UIButton's as subView's....
    [stockRequestView addSubview:searchBtn];
    [stockRequestView addSubview:clearBtn];
    
    
    UILabel * totalQuntityLbl;
    UILabel * totalIndentsRequestLbl;
    
    totalIndentsRequestLbl = [[UILabel alloc] init];
    totalIndentsRequestLbl.layer.masksToBounds = YES;
    totalIndentsRequestLbl.numberOfLines = 1;
    totalIndentsRequestLbl.textColor = [UIColor whiteColor];
    
    totalIndentsRequestValueLbl = [[UILabel alloc] init];
    totalIndentsRequestValueLbl.layer.masksToBounds = YES;
    totalIndentsRequestValueLbl.numberOfLines =1;
    totalIndentsRequestValueLbl.textAlignment = NSTextAlignmentRight;
    totalIndentsRequestValueLbl.textColor = [UIColor whiteColor];
    
    totalQuntityLbl = [[UILabel alloc] init];
    totalQuntityLbl.layer.masksToBounds = YES;
    totalQuntityLbl.numberOfLines = 1;
    totalQuntityLbl.textColor = [UIColor whiteColor];
    
    totalQuntityValueLbl = [[UILabel alloc] init];
    totalQuntityValueLbl.layer.masksToBounds = YES;
    totalQuntityValueLbl.numberOfLines = 1;
    totalQuntityValueLbl.textColor = [UIColor whiteColor];
    totalQuntityValueLbl.textAlignment = NSTextAlignmentRight;
    
    //added by Srinivasulu on 10/05/2017....
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.placeholder = NSLocalizedString(@"all_categories", nil);
    categoryTxt.userInteractionEnabled  = NO;
    categoryTxt.delegate = self;
    [categoryTxt awakeFromNib];
    
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.placeholder = NSLocalizedString(@"all_subcategories_", nil);
    subCategoryTxt.userInteractionEnabled  = NO;
    subCategoryTxt.delegate = self;
    [subCategoryTxt awakeFromNib];
    
    brandTxt = [[CustomTextField alloc] init];
    brandTxt.placeholder = NSLocalizedString(@"all_brands", nil);
    brandTxt.userInteractionEnabled  = NO;
    brandTxt.delegate = self;
    [brandTxt awakeFromNib];
    
    modelTxt = [[CustomTextField alloc] init];
    modelTxt.placeholder = NSLocalizedString(@"all_models", nil);
    modelTxt.userInteractionEnabled  = NO;
    modelTxt.delegate = self;
    [modelTxt awakeFromNib];
    
    
    /*Creation of UIButton's*/
    UIImage * downArrowImg;
    UIButton * selectZoneBtn;
    UIButton * selectOutletBtn;
    
    downArrowImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    selectZoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectZoneBtn setBackgroundImage:downArrowImg forState:UIControlStateNormal];
    [selectZoneBtn addTarget:self
                      action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];
    
    //selectZoneBtn.hidden =YES;
    
    selectOutletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectOutletBtn setBackgroundImage:downArrowImg forState:UIControlStateNormal];
    [selectOutletBtn addTarget:self
                        action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    
    //upto here on 10/05/2017....
    
    /*Creation of UILabels used in this page*/
    
    
    //populating text into the textFields && labels && placeholders && buttons titles....
    @try {
        
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        headerNameLbl.text = NSLocalizedString(@"stock_requestSummary", nil);
        
        
        snoLbl.text = NSLocalizedString(@"S_NO", nil);
        requestIDlbl.text = NSLocalizedString(@"request_id", nil);
        outletIDLbl.text = NSLocalizedString(@"outlet_id",nii);
        
        requestDateLbl.text = NSLocalizedString(@"request_date", nil);;
        requestedByLbl.text = NSLocalizedString(@"requested_by", nil);
        
        requestedQuantityLbl.text = NSLocalizedString(@"req_qty", nil);
        approvedQuantityLbl.text = NSLocalizedString(@"app_qty",nil);
        
        noOfItemslbl.text   = NSLocalizedString(@"no_items",nil);
        approvedItemsLbl.text = NSLocalizedString(@"app_items",nil);
        deliveryDteLbl.text = NSLocalizedString(@"delivery_Date", nil);
        
        requestStatusLbl.text = NSLocalizedString(@"status", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        itemNoLbl.text = NSLocalizedString(@"S_NO", nil);
        itemCodeLbl.text = NSLocalizedString(@"item_code", nil);
        itemNameLbl.text = NSLocalizedString(@"item_name", nil);
        itemGradeLbl.text = NSLocalizedString(@"grade", nil);
        currentStockLbl.text = NSLocalizedString(@"current_Stock", nil);
        
        
        itemRequestedQtyLbl.text = NSLocalizedString(@"req_qty", nil);
        itemApprrovedQtyLbl.text = NSLocalizedString(@"app_qty",nil);
      //itemApprovedTimeLbl.text = NSLocalizedString(@"approved_on", nil);
        itemApprovedByLbl.text = NSLocalizedString(@"approved_by", nil);
        totalIndentsRequestValueLbl.text = NSLocalizedString(@"0_00", nil);
        totalQuntityValueLbl.text = NSLocalizedString(@"0_00", nil);
        
        stockRequestView.backgroundColor = [UIColor blackColor];
        stockRequestView.layer.borderWidth = 1.0f;
        stockRequestView.layer.cornerRadius = 10.0f;
        stockRequestView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        //added by Srinivasulu on 09/05/2017....
        
        [saveAllBtn setTitle:NSLocalizedString(@"save_all", nil) forState:UIControlStateNormal];
        
        [generateIndentsBtn setTitle:NSLocalizedString(@"generate_indents", nil) forState:UIControlStateNormal];
       
        [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
       
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
        
        //Allocation of UIView....
        totalInventoryView = [[UIView alloc]init];
        totalInventoryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        totalInventoryView.layer.borderWidth =3.0f;
        
        totalIndentsRequestLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        totalQuntityLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        totalIndentsRequestValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        totalQuntityValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        totalIndentsRequestLbl.textAlignment = NSTextAlignmentLeft;
        totalQuntityLbl.textAlignment = NSTextAlignmentLeft;
        
        totalIndentsRequestValueLbl.textAlignment = NSTextAlignmentRight;
        totalQuntityValueLbl.textAlignment = NSTextAlignmentRight;
        
        totalIndentsRequestLbl.text =  NSLocalizedString(@"total_indent_requests", nil);
        totalQuntityLbl.text  = NSLocalizedString(@"total_qty",nil);
        
        //setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
        //upto here on 09/05/2017....
        
        requestedItemsTbl = [[UITableView alloc] init];
        requestedItemsTbl.dataSource = self;
        requestedItemsTbl.delegate = self;
        requestedItemsTbl.backgroundColor = [UIColor clearColor];
        requestedItemsTbl.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
        requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        //table's used in popUp's.......
        //locationTbl allocation...
        locationTbl = [[UITableView alloc] init];
        
        //categoriesListTbl allocation...
        categoriesListTbl = [[UITableView alloc] init];
        
        //subCategoriesListTbl allocation...
        subCategoriesListTbl = [[UITableView alloc] init];
        
        //departmentListTbl allocation...
        departmentListTbl = [[UITableView alloc] init];
        
        //subDepartmentListTbl allocation...
        subDepartmentListTbl = [[UITableView alloc] init];
        
        //departmentListTbl allocation...
        brandListTbl = [[UITableView alloc] init];
        
        //modelListTbl  allocation...
        modelListTbl = [[UITableView alloc] init];
        
        //workFlowListTbl  allocation...
        workFlowListTbl = [[UITableView alloc] init];
        
        // pagenationTbl  allocation...
        pagenationTbl = [[UITableView alloc] init];
        
        //stockRequestTable creation...
        stockRequestTbl = [[UITableView alloc] init];
        stockRequestTbl.backgroundColor  = [UIColor blackColor];
        stockRequestTbl.layer.cornerRadius = 4.0;
        stockRequestTbl.bounces = TRUE;
        stockRequestTbl.dataSource = self;
        stockRequestTbl.delegate = self;
        stockRequestTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //upto Here....
     
        
        categoryTxt.tag = 2;
        brandTxt.tag = 1;
        
    } @catch (NSException *exception) {
        NSLog(@"--------exception in the stockRequest---------%@",exception);
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
        }
        else{
            
        }
        
        //setting for the stockReceiptView....
        stockRequestView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake( 0, 0, stockRequestView.frame.size.width, 45);
        
        //seting frame for summaryInfoBtn....
        summaryInfoBtn.frame = CGRectMake(stockRequestView.frame.size.width - 45,headerNameLbl.frame.origin.y,50,50);
        
        //setting first column....
        zoneIdTxt.frame = CGRectMake(stockRequestView.frame.origin.x + 10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, 155, 40);
        
        outletIdTxt.frame = CGRectMake( zoneIdTxt.frame.origin.x, zoneIdTxt.frame.origin.y + zoneIdTxt.frame.size.height +10,zoneIdTxt.frame.size.width, zoneIdTxt.frame.size.height);
        
        //setting second column....
        categoryTxt.frame = CGRectMake( outletIdTxt.frame.origin.x + outletIdTxt.frame.size.width + 10, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        subCategoryTxt.frame = CGRectMake( categoryTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        //setting third column....
        brandTxt.frame = CGRectMake( categoryTxt.frame.origin.x + categoryTxt.frame.size.width + 10, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        modelTxt.frame = CGRectMake( brandTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        //setting third column....
        startDateTxt.frame = CGRectMake( brandTxt.frame.origin.x + brandTxt.frame.size.width + 10, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        endDateTxt.frame = CGRectMake( startDateTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        statusTxt.frame = CGRectMake( startDateTxt.frame.origin.x + startDateTxt.frame.size.width + 10, startDateTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        //setting frame for searchItemsTxt field....
        searchItemsTxt.frame = CGRectMake(10, endDateTxt.frame.origin.y + endDateTxt.frame.size.height + 15, stockRequestView.frame.size.width - 20, 40);
        
        //setting frames for UIButtons....
        outletIdBtn.frame = CGRectMake( (outletIdTxt.frame.origin.x + outletIdTxt.frame.size.width - 45), outletIdTxt.frame.origin.y - 8,  55, 60);
        
        zoneIdBtn.frame = CGRectMake( (zoneIdTxt.frame.origin.x + zoneIdTxt.frame.size.width - 45), zoneIdTxt.frame.origin.y - 8,  55, 60);
        
        //setting for second column row....
        categoryBtn.frame = CGRectMake( (categoryTxt.frame.origin.x + categoryTxt.frame.size.width - 45), categoryTxt.frame.origin.y - 8,  55, 60);
        
        subCatBtn.frame = CGRectMake( (subCategoryTxt.frame.origin.x + subCategoryTxt.frame.size.width - 45), subCategoryTxt.frame.origin.y - 8,  55, 60);
        
        //setting for third column row....
        
        brandBtn.frame = CGRectMake( (brandTxt.frame.origin.x + brandTxt.frame.size.width - 45), brandTxt.frame.origin.y - 8,  55, 60);
        
        modelBtn.frame = CGRectMake( (modelTxt.frame.origin.x + modelTxt.frame.size.width - 45), modelTxt.frame.origin.y - 8,  55, 60);
        
        //setting for fourth column row....
        showStartDateBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-45), startDateTxt.frame.origin.y+2, 40, 35);
        
        showEndDateBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-45), endDateTxt.frame.origin.y+2, 40, 35);
        
        stausBtn.frame = CGRectMake((statusTxt.frame.origin.x + statusTxt.frame.size.width - 45),statusTxt.frame.origin.y -8,55,60);
        
        //setting for fifth column row....
        searchBtn.frame = CGRectMake(((searchItemsTxt.frame.origin.x+searchItemsTxt.frame.size.width)-160), categoryTxt.frame.origin.y,160,40);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x,subCategoryTxt.frame.origin.y,searchBtn.frame.size.width,searchBtn.frame.size.height);
        
        //changed by Srinivasulu frames....
        
        saveAllBtn.frame = CGRectMake(searchItemsTxt.frame.origin.x, stockRequestView.frame.size.height-45, 130, 40);

        generateIndentsBtn.frame = CGRectMake(saveAllBtn.frame.origin.x + saveAllBtn.frame.size.width+30,saveAllBtn.frame.origin.y,180,40);
        
        cancelBtn.frame = CGRectMake(generateIndentsBtn.frame.origin.x + generateIndentsBtn.frame.size.width + 30, generateIndentsBtn.frame.origin.y, 130, 40);
        
        pagenationTxt.frame = CGRectMake(cancelBtn.frame.origin.x+cancelBtn.frame.size.width+20,cancelBtn.frame.origin.y,90,40);
        
        dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width-45), pagenationTxt.frame.origin.y-5, 45, 50);
        
        goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width+15,pagenationTxt.frame.origin.y,80, 40);
        
        //Frame for the UIView...
        totalInventoryView.frame = CGRectMake(searchItemsTxt.frame.origin.x + searchItemsTxt.frame.size.width-265,saveAllBtn.frame.origin.y -18,270,60);
        
        stockRequestScrollView.frame = CGRectMake(searchItemsTxt.frame.origin.x,searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height+5,searchItemsTxt.frame.size.width+120,totalInventoryView.frame.origin.y - (searchItemsTxt.frame.origin.y+searchItemsTxt.frame.size.height + 10));
        
        snoLbl.frame = CGRectMake(0,0,40,35);
        
        requestIDlbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width+2,snoLbl.frame.origin.y,110,snoLbl.frame.size.height);
        
        outletIDLbl.frame = CGRectMake(requestIDlbl.frame.origin.x+requestIDlbl.frame.size.width + 2, snoLbl.frame.origin.y,80,snoLbl.frame.size.height);
        
        requestDateLbl.frame = CGRectMake( outletIDLbl.frame.origin.x + outletIDLbl.frame.size.width + 2, snoLbl.frame.origin.y, 90,snoLbl.frame.size.height);
        
        requestedByLbl.frame = CGRectMake( requestDateLbl.frame.origin.x + requestDateLbl.frame.size.width + 2, snoLbl.frame.origin.y, 75, snoLbl.frame.size.height);
        
        requestedQuantityLbl.frame =CGRectMake(requestedByLbl.frame.origin.x + requestedByLbl.frame.size.width + 2, snoLbl.frame.origin.y, 75, snoLbl.frame.size.height);
        
        approvedQuantityLbl.frame = CGRectMake(requestedQuantityLbl.frame.origin.x +requestedQuantityLbl.frame.size.width + 2, snoLbl.frame.origin.y,70, snoLbl.frame.size.height);
        
        noOfItemslbl.frame = CGRectMake(approvedQuantityLbl.frame.origin.x +approvedQuantityLbl.frame.size.width + 2, snoLbl.frame.origin.y, 80, snoLbl.frame.size.height);
        
        approvedItemsLbl.frame = CGRectMake(noOfItemslbl.frame.origin.x +noOfItemslbl.frame.size.width + 2, snoLbl.frame.origin.y, 80, snoLbl.frame.size.height);

        
        deliveryDteLbl.frame = CGRectMake(approvedItemsLbl.frame.origin.x +approvedItemsLbl.frame.size.width + 2, snoLbl.frame.origin.y, 110, snoLbl.frame.size.height);
        
        requestStatusLbl.frame = CGRectMake(deliveryDteLbl.frame.origin.x + deliveryDteLbl.frame.size.width + 2, snoLbl.frame.origin.y,80,snoLbl.frame.size.height);
        
        actionLbl.frame = CGRectMake(requestStatusLbl.frame.origin.x + requestStatusLbl.frame.size.width + 2, snoLbl.frame.origin.y,90,snoLbl.frame.size.height);
        
        //searchItemsTxt.frame.origin.x + searchItemsTxt.frame.size.width - (requestStatusLbl.frame.origin.x + requestStatusLbl.frame.size.width + 2)
        
        stockRequestTbl.frame = CGRectMake(0,snoLbl.frame.origin.y + snoLbl.frame.size.height,stockRequestScrollView.frame.size.width,stockRequestScrollView.frame.size.height-(snoLbl.frame.origin.y+snoLbl.frame.size.height));

        //stockRequestScrollView.contentSize = CGSizeMake(stockRequestTbl.frame.size.width+90,  stockRequestScrollView.frame.size.height);
        
        totalIndentsRequestLbl.frame =  CGRectMake(5,0,170,40);
        
        totalQuntityLbl.frame =  CGRectMake(totalIndentsRequestLbl.frame.origin.x,totalIndentsRequestLbl.frame.origin.y+totalIndentsRequestLbl.frame.size.height-15,170,40);
        
        totalIndentsRequestValueLbl.frame =  CGRectMake(totalIndentsRequestLbl.frame.origin.x+totalIndentsRequestLbl.frame.size.width,totalIndentsRequestLbl.frame.origin.y,90,40);
        
        totalQuntityValueLbl.frame =  CGRectMake(totalIndentsRequestValueLbl.frame.origin.x, totalQuntityLbl.frame.origin.y,90,40);
        
        requestedItemsTblHeaderView.frame = CGRectMake(requestIDlbl.frame.origin.x,10,searchItemsTxt.frame.size.width,snoLbl.frame.size.height);
        
        itemNoLbl.frame = CGRectMake(0,0,70,30);
        
        itemCodeLbl.frame = CGRectMake(itemNoLbl.frame.origin.x + itemNoLbl.frame.size.width+2,0,100,itemNoLbl.frame.size.height);
        
        itemNameLbl.frame = CGRectMake(itemCodeLbl.frame.origin.x + itemCodeLbl.frame.size.width+2,0,160, itemNoLbl.frame.size.height);
        
        itemGradeLbl.frame =CGRectMake(itemNameLbl.frame.origin.x + itemNameLbl.frame.size.width+2,0,100, itemNoLbl.frame.size.height);
        
        currentStockLbl.frame =CGRectMake(itemGradeLbl.frame.origin.x + itemGradeLbl.frame.size.width+2, 0, 120, itemNoLbl.frame.size.height);
        
        itemRequestedQtyLbl.frame = CGRectMake(currentStockLbl.frame.origin.x +currentStockLbl.frame.size.width+2, 0, 100, itemNoLbl.frame.size.height);
        
        itemApprrovedQtyLbl.frame = CGRectMake(itemRequestedQtyLbl.frame.origin.x+itemRequestedQtyLbl.frame.size.width + 2,0,100, itemNoLbl.frame.size.height);
    }
    else{
        
    }
    
    
    [stockRequestView addSubview:headerNameLbl];

    [stockRequestView addSubview:summaryInfoBtn];
    
    [stockRequestView addSubview:outletIdTxt];
    [stockRequestView addSubview:zoneIdTxt];
    [stockRequestView addSubview:startDateTxt];
    [stockRequestView addSubview:endDateTxt];
    
    //[stockRequestView addSubview:zoneIdBtn];
    [stockRequestView addSubview:outletIdBtn];
    [stockRequestView addSubview:showStartDateBtn];
    [stockRequestView addSubview:showEndDateBtn];
    [stockRequestView addSubview:categoryBtn];
    [stockRequestView addSubview:subCatBtn];
    [stockRequestView addSubview:brandBtn];
    [stockRequestView addSubview:modelBtn];
    
    [stockRequestView addSubview:searchItemsTxt];
    
    [stockRequestView addSubview:categoryTxt];
    [stockRequestView addSubview:subCategoryTxt];
    [stockRequestView addSubview:brandTxt];
    [stockRequestView addSubview:modelTxt];
    
    [stockRequestView addSubview:statusTxt];
    [stockRequestView addSubview:stausBtn];
    
    [stockRequestView addSubview:stockRequestScrollView];
    
    [stockRequestScrollView addSubview:snoLbl];
    [stockRequestScrollView addSubview:requestIDlbl];
    [stockRequestScrollView addSubview:outletIDLbl];
    [stockRequestScrollView addSubview:requestDateLbl];
    [stockRequestScrollView addSubview:requestedByLbl];
    [stockRequestScrollView addSubview:requestedQuantityLbl];
    [stockRequestScrollView addSubview:approvedQuantityLbl];
    [stockRequestScrollView addSubview:noOfItemslbl];
    [stockRequestScrollView addSubview:approvedItemsLbl];
    [stockRequestScrollView addSubview:deliveryDteLbl];
    [stockRequestScrollView addSubview:requestStatusLbl];
    [stockRequestScrollView addSubview:actionLbl];
    
   [stockRequestScrollView addSubview:stockRequestTbl];
    
    [stockRequestView addSubview:saveAllBtn];
    
    [stockRequestView addSubview:generateIndentsBtn];
    [stockRequestView addSubview:cancelBtn];

    [stockRequestView addSubview:pagenationTxt];
    [stockRequestView addSubview:dropDownBtn];
    [stockRequestView addSubview:goButton];
    
    [stockRequestView addSubview:totalInventoryView];
    
    [totalInventoryView addSubview:totalIndentsRequestLbl];
    [totalInventoryView addSubview:totalIndentsRequestValueLbl];
    [totalInventoryView addSubview:totalQuntityLbl];
    [totalInventoryView addSubview:totalQuntityValueLbl];
    
    [self.view addSubview:stockRequestView];
    
    @try {
        
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
        
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:requestedItemsTblHeaderView andSubViews:YES fontSize:16.0f cornerRadius:0];
        
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

        saveAllBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        generateIndentsBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        cancelBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
        totalIndentsRequestLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        totalQuntityLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
        searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
    } @catch (NSException * exception) {
        
    }

    //Handling the HUB user Functinoality..
    @try {
        
        if (isHubLevel) {
            
            zoneIdTxt.text = zoneID;
            outletIdBtn.hidden = NO;
            
        }
        else {
            
            zoneIdTxt.text = zoneID;
            outletIdTxt.text = presentLocation;
            outletIdBtn.hidden = YES;
        }
        
    } @catch (NSException *exception) {
    }
    
    
    //used for identification propous....
    showStartDateBtn.tag = 2;
    showEndDateBtn.tag = 4;
    
}

/**
 * @description  it is one of ViewLifeCylce  which will be executed after execution of  viewDidLoad.......
 * @date         21/09/2016
 * @method       viewDidAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated {
    //calling super method....
    [super viewDidAppear:YES];
    
    @try {
        [HUD setHidden:NO];
        
        requestStartNumber = 0;
        stockRequestsInfoArr = [NSMutableArray new];
        
        if ((searchItemsTxt.text).length != 0)
            
            searchItemsTxt.text = @"";

        [self callingGetStockRequests];
        
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in serviceCall of callingGetStockReqeusts------------%@",exception);
    } @finally {
        
    }
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

//-(void)viewWillAppear:(BOOL)animated {
//calling the superClass method...
//    [super viewWillAppear:YES];

//}

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
 * @description  Calling the GetStockRequest Method to fetch the records...
 * @date         21/09/2016
 * @method       callingGetStockRequests
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/10/2016
 * @reason       hiding the HUD in catch block....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGetStockRequests {
    
    @try {
        
        //showing the hud....
        [HUD setHidden:NO];
        
        //text format of the HUD...
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        
        if(stockRequestsInfoArr == nil && requestStartNumber == 0){
            
            totalNoOfStockRequests = 0;
            
            stockRequestsInfoArr = [NSMutableArray new];
        }
        else if(stockRequestsInfoArr.count ){
            
            [stockRequestsInfoArr removeAllObjects];
        }
        if(requestStartNumber == 0)
            
            totalQuntityValueLbl.text = NSLocalizedString(@"0_00", nil);
        
        
        NSString * categoryStr = categoryTxt.text;
        NSString * subCategoryStr = subCategoryTxt.text;
        NSString * modelStr = modelTxt.text;
        NSString * brandStr = brandTxt.text;
        NSString * locationStr = outletIdTxt.text;
        NSString * statusStr = statusTxt.text;
        NSString * startDteStr = startDateTxt.text;
        
        if((startDateTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDateTxt.text,@"00:00:00"];
        
        NSString * endDteStr  = endDateTxt.text;
        
        if ((endDateTxt.text).length > 0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@"00:00:00"];
        }
        
        if (categoriesListTbl.tag == 0 || (categoryTxt.text).length == 0 || categoriesListTbl.tag == 4)
            categoryStr = @"";
        
        if (subCategoriesListTbl.tag == 0 || (subCategoryTxt.text).length == 0)
            subCategoryStr = @"";
        
        if (locationTbl.tag == 0  || (outletIdTxt.text).length == 0)
            
            locationStr = @"";
        
        if (brandListTbl.tag == 0  || (brandTxt.text).length == 0)
            
            brandStr = @"";
        
        if (modelListTbl.tag == 0  || (modelTxt.text).length == 0)
            
            modelStr = @"";
        
        if (workFlowListTbl.tag == 0  || (statusTxt.text).length == 0)
            
            statusStr = @"";

        NSMutableDictionary * stockRequestDetails = [[NSMutableDictionary alloc] init];
        
        //setting requestHeader....
        stockRequestDetails[REQUEST_HEADER] = [RequestHeader getRequestHeader];

        //setting for pagination....
        stockRequestDetails[START_INDEX] = [NSString stringWithFormat:@"%d",requestStartNumber];

        stockRequestDetails[MAX_RECORDS] = @"10";

        //It is used for searching particular id....
        stockRequestDetails[SEARCH_CRITERIA] = searchItemsTxt.text;

        //setting the isDraftsRequired  as true to get the status of  saved indents or requests ....
        stockRequestDetails[IS_DRAFT_REQUIRED] = [NSNumber numberWithBool:true];

        if(searchBtn.tag == 2) {
            categoryStr    = @"";
            subCategoryStr = @"";
            modelStr       = @"";
            brandStr       = @"";
            startDteStr    = @"";
            endDteStr      = @"";

            if (isHubLevel) {

                locationStr = @"";
            }
        }

        stockRequestDetails[kcategory] = categoryStr;
        stockRequestDetails[kSubCategory] = subCategoryStr;
        stockRequestDetails[MODEL] = modelStr;
        stockRequestDetails[kBrand] = brandStr;
        stockRequestDetails[START_DATE] = startDteStr;
        stockRequestDetails[END_DATE] = endDteStr;
        //setting the currentLocation as storeLocation....

        if (!isHubLevel) {
            stockRequestDetails[FROM_STORE_CODE] = presentLocation;
        }
        else stockRequestDetails[FROM_STORE_CODE] = locationStr;

        stockRequestDetails[STATUS] = statusStr;
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:stockRequestDetails options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockRequestDelegate = self;
        [webServiceController getAllStockRequest:quoteRequestJsonString];
        
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];

        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

        //upto here on 17/01/2016....
        
        NSLog(@"----exception in Service Call---%@",exception);
    } @finally {
        
    }
}

#pragma -mark start of handling service call reponses

/*
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getStockRequestsSuccessResponse:
 * @author       Bhargav .v
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2017
 * @reason       changed the populating date directly to method....
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getStockRequestsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        totalNoOfStockRequests = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"]intValue];
        
        //added on 23/05/2017....
        float qty = 0;
        if((totalQuntityValueLbl.text).length)
            qty = (totalQuntityValueLbl.text).floatValue;
        
        //upto here on 23/05/2017.....
        
        for(NSDictionary * dic in [successDictionary valueForKey:STOCK_REQUESTS]   ) {
            
            [stockRequestsInfoArr addObject:dic];
            
            // added on 23/05/2017....
            
            for(NSDictionary * locDic in [dic valueForKey:STOCK_REQUEST_ITEMS] )
                
                qty  += [[self checkGivenValueIsNullOrNil:[locDic valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue];
            
            //upto here on 23/05/2017.....
        }
        
        totalIndentsRequestValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_INDENTS] defaultReturn:@"0.00"] floatValue]];
        totalQuntityValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", qty];
        
        //upto here on 23/05/2017.....
        
        //Recently Added By Bhargav.v on 17/10/2017..
        //Reason: To Display the Records in pagination mode based on the Total Records..
        
        int strTotalRecords = totalNoOfStockRequests/10;
        int remainder = totalNoOfStockRequests % 10;
        
        //        NSLog(@"%i", strTotalRecords);
        //        NSLog(@"%i", remainder);
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
            
            [pagenationArr addObject:NSLocalizedString(@"1", nil)];
        }
        else{
            
            for(int i = 1;i<= strTotalRecords; i++){
                
                [pagenationArr addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        //Up to here on 16/10/2017...
        
    } @catch (NSException * exception) {
        NSLog(@"----exception in handling serviceCall resposne----%@",exception);
    } @finally {
        
        if(requestStartNumber == 0) {
            pagenationTxt.text = NSLocalizedString(@"1", nil);
        }
        
        [stockRequestTbl reloadData];
        [HUD setHidden: YES];
    }
}

/**
 * @description  here we are handling error response received frome the service.......
 * @date         20/09/2016
 * @method       getStockRequestsErrorResposne:
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 * @verified By
 * @verified On
 */

- (void)getStockRequestsErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [stockRequestTbl setUserInteractionEnabled:YES];
        
        if( (searchItemsTxt.tag == (searchItemsTxt.text).length) || ((searchItemsTxt.text).length > 3)){
            
            totalIndentsRequestValueLbl.text = [NSString stringWithFormat:@"%@",@"0.00"];
            totalQuntityValueLbl.text  = [NSString stringWithFormat:@"%@",@"0.00"];
            
            // [self addLabelsToScrollView:nil];
            
            searchItemsTxt.tag = 0;
            [HUD setHidden:YES];
            if(stockRequestsInfoArr.count == 0){
                
                float y_axis = self.view.frame.size.height - 120;
                NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            }
        }
        else{
            
            [self textFieldDidChange:searchItemsTxt];
        }
    } @catch (NSException * exception) {
        NSLog(@"----exception in handling serviceCall resposne ---%@",exception);
        
    } @finally {
        //        CID8995446
        //        preetesh.dutt@freshworld.in
        //        Password123#
        
        //        if([stockRequestsInfoArr count] <= 10)
        [stockRequestTbl reloadData];
    }
}



#pragma -mark actions used in this page to navigate to other classes....


/**
 * @description  here we are navigation from current page to NewStockRequest based on it status.......
 * @date         26/09/2016
 * @method       newStockRequest;
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (void)newStockRequest:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        NewStockRequest * newStockRequest = [[NewStockRequest alloc] init];
        
        BOOL isDraft = false;
        
        if(stockRequestsInfoArr.count > sender.tag){
            
            NSString * DraftStr;
            DraftStr  = [stockRequestsInfoArr[sender.tag] valueForKey:STATUS];
            
            if ([DraftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
                
                isDraft = true;
            }
        }
        
        if(isDraft){
            
            newStockRequest.requestID = [stockRequestsInfoArr[sender.tag] valueForKey:STOCK_REQUEST_ID];
            [self.navigationController pushViewController:newStockRequest animated:YES];
        }
        else {
            
            [self.navigationController pushViewController:newStockRequest animated:YES];
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in StockRequest page in newStockRequest----");
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
        
    }
}

/**
 * @description  here we are navigation from current page to ViewStockRequest.......
 * @date         26/09/2016
 * @method       stockRequestDetailsView;
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

-(void)stockRequestDetailsView:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        BOOL isDraft = false;
        
        NewStockRequest * newStockRequest = [[NewStockRequest alloc] init];

        if(stockRequestsInfoArr.count > sender.tag) {
            
            NSString * DraftStr;
            
            DraftStr  = [stockRequestsInfoArr[sender.tag] valueForKey:STATUS];
            
            if ([DraftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
                
                isDraft = true;
            }
        }
        if(isDraft) {

            newStockRequest.requestID = [stockRequestsInfoArr[sender.tag] valueForKey:STOCK_REQUEST_ID];
            [self.navigationController pushViewController:newStockRequest animated:YES];

        }
        
        else{
            
            ViewStockRequest * viewStock = [[ViewStockRequest alloc] init ];
            viewStock.requestID = [stockRequestsInfoArr[sender.tag] valueForKey:STOCK_REQUEST_ID];
            [self.navigationController pushViewController:viewStock animated:YES];
 
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"----exception in StockRequest page in newStockRequest----");
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
            
            pickView.frame = CGRectMake( 15, startDateTxt.frame.origin.y+startDateTxt.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
            if((startDateTxt.text).length)
                // callServices = true;
                
                
                startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                // callServices = true;
                
                endDateTxt.text = @"";
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

/**
 * @description  we are populating the Selected Date to current TextField
 * @date         01/03/2017
 * @method       populateDateToTextField
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
        [requiredDateFormat setDateFormat: NSLocalizedString(@"dd/MM/yyyy", nil) ];
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        // getting present date & time ..
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat: NSLocalizedString(@"dd/MM/yyyy", nil) ];
        NSString* currentdate = [f stringFromDate:today];
        //        [f release];
        today = [f dateFromString:currentdate];
        
        if( [today compare:selectedDateString] == NSOrderedAscending ){
            
            [self displayAlertMessage:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        NSDate * existingDateString;
        
        if( sender.tag == 2) {
            if ((endDateTxt.text).length != 0 && (![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:370 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    return;
                }
            }
            startDateTxt.text = dateString;
        }
        else {
            
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:370 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    return;
                }
            }
            endDateTxt.text = dateString;
        }
    } @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


#pragma -mark Start of TextFieldDelegates.......

/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date         11/05/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    @try {
        didTableDataEditing = true;
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
    return  YES;
}


/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField*)textField {
    @try {
        
        if(textField.frame.origin.x == apporvedQtyTxt.frame.origin.x || textField.frame.origin.x == qtyChangeTxt.frame.origin.x){
            @try {
                didTableDataEditing = false;
                
                offSetViewTo = searchItemsTxt.frame.origin.y+requestedItemsTbl.frame.origin.y;
                
                [self keyboardWillShow];
                
            } @catch (NSException * exception) {
                NSLog(@"------exception in the stockReceiptView in textFieldDidBeginEditing:----");
                
                NSLog(@"------exception while creating the popUp in stockView------%@",exception);
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"------exception in the stockReceiptView in textFieldDidBeginEditing:----");
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         06/09/2016
 * @method       textField:  shouldChangeCharactersInRange:  replacementString:
 * @author       Bhargav.v
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
        
        if(textField.frame.origin.x == apporvedQtyTxt.frame.origin.x||textField.frame.origin.x == qtyChangeTxt.frame.origin.x  ){

            
            @try {
                NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                NSString *expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
                NSError *error = nil;
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
                return numberOfMatches != 0;
            } @catch (NSException *exception) {
                return  YES;
                
                NSLog(@"----exception in GoodsReceiptNoteView ----");
                NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            }
        }
        
        return  YES;
        
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the StockReqiestView in shouldChangeCharactersInRange:----");
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        return  YES;
        
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         10/09/2016
 * @method       textFieldDidChange:
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    @try {
        
        if (textField == searchItemsTxt ) {
            
            if ((textField.text).length >= 4 ) {
                
                @try {
                    
                    requestStartNumber = 0;
                    stockRequestsInfoArr = [NSMutableArray new];
                    [self callingGetStockRequests];
                    
                    
                } @catch (NSException *exception) {
                    NSLog(@"---- exception while calling ServicesCall ----%@",exception);
                    
                } @finally {
                    
                }
            }
            else if ((textField.text).length == 0) {
                
                requestStartNumber = 0;
                stockRequestsInfoArr = [NSMutableArray new];
                [self callingGetStockRequests];
            }
        }
        
        else if(textField.frame.origin.x == apporvedQtyTxt.frame.origin.x){
            
            NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
            
            @try {
                
                //changing the quantity's selected items.......
                if (trimmedString.length != 0) {
                    
                    NSMutableDictionary * dic = [requestedItemsInfoArr[textField.tag] mutableCopy];
                    
                    if( (textField.text).floatValue >  [[dic valueForKey:QUANTITY] floatValue] ){
                        
                        NSString * mesg = NSLocalizedString(@"approved_qty_should_be_less_then_or_equal_to_requested_qty", nil);
                        
                        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2 verticalAxis:(searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height + 100)   msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                        return;
                    }
                    
                    [dic setValue:trimmedString forKey:APPROVED_QTY];
                    requestedItemsInfoArr[textField.tag] = dic;
                    
                }
                
            } @catch (NSException *exception) {
                NSLog(@"-------exception while changing the quantity-----");
                NSLog(@"-------exception in the stockRequestView in textFieldDidChange:----");
                NSLog(@"------exception while creating the popUp in stockView------%@",exception);
                
            }
            @finally{
                
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing....
 * @date         29/05/2016
 * @method       textFieldDidEndEditing:
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
//    @try {
        [self keyboardWillHide];
        offSetViewTo = 0;
        
    
        // Changed by Roja on 29-06-2018...
    
        if (textField.frame.origin.x == qtyChangeTxt.frame.origin.x || textField.frame.origin.x == apporvedQtyTxt.frame.origin.x ) {
            
            NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString       * trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
            
            @try {
                
                NSString * qtyKey = QUANTITY;
                
                if(textField.frame.origin.x == apporvedQtyTxt.frame.origin.x)
                    
                    qtyKey = kApprovedQty;
                
                NSMutableDictionary * dic = [requestedItemsInfoArr[textField.tag]  mutableCopy];
                
                [dic setValue:textField.text  forKey:qtyKey];
                
                if([qtyKey isEqualToString: QUANTITY]) {
                    
                    [dic setValue:textField.text  forKey:kApprovedQty];
                }
                
                if( (textField.text).integerValue >  [[dic valueForKey:QUANTITY] integerValue] ){
                    
                    NSString * mesg = NSLocalizedString(@"approved_qty_should_be_less_then_or_equal_to_requested_qty", nil);
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:(searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height + 100)   msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    return;
                }
                
            if (trimmedString.length == 0)
                trimmedString = @"0";
            
            [dic setValue:trimmedString forKey:APPROVED_QTY];
            requestedItemsInfoArr[textField.tag] = dic;
            
        }
        @catch (NSException *exception) {
        NSLog(@"-------exception while changing the quantity-----%@",exception);
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
    }
    @finally  {
        [requestedItemsTbl reloadData];
    }
}
    
}


/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Bhargav.v
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
    
    if (tableView == stockRequestTbl) {
        
        if (stockRequestsInfoArr.count)
            
            return stockRequestsInfoArr.count;
         else
            return 1;
    }
    return 1;
}

/**
 * @description
 * @date
 * @method       numberOfRowsInSection
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == stockRequestTbl){
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                return 1+1;
            }
        }
        
        return 1;
    }
    else if(tableView == requestedItemsTbl){
        
        return  requestedItemsInfoArr.count;
    }
    
    else if(tableView == locationTbl){
        
        if(outletIdTxt.tag == 0)
            return locationArr.count;
        else
            return zoneListArr.count;
        
    }
    else if(tableView == categoriesListTbl){
        
        return locationWiseCategoriesArr.count;
        
    }
    else if(tableView == subCategoriesListTbl){
        
        return subCategoriesListArr.count;
        
    }
    
    else if(tableView == brandListTbl){
        
        return locationWiseBrandsArr.count;
        
    }
    else if(tableView == modelListTbl){
        
        return ModelListArray.count;
        
    }
    
    else if(tableView == stockRequestSummaryInfoTbl){
        if (stockRequestSummaryInfoArr.count)
            
            return stockRequestSummaryInfoArr.count;
        else
            return 2;
        
    }
    else if (tableView == workFlowListTbl) {
        return workFlowsArr.count;
    }
    else if (tableView == pagenationTbl) {
        return pagenationArr.count;
    }
    
    else
        return 0;
    
    
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
    
    if(tableView == stockRequestTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (indexPath.row == 0) {
                return 38;
            }
            else{
                if (requestedItemsInfoArr.count > 4 ) {
                    return (40 * 4)+30;
                }
                
                return (requestedItemsInfoArr.count * 40)+70;
            }
            
        }else{
            if (indexPath.row == 0) {
                return 30;
            }
            else{
                if (requestedItemsInfoArr.count > 4 ) {
                    return 30 * 4;
                }
                
                return requestedItemsInfoArr.count * 30;
            }
        }
    }
    else if(tableView == requestedItemsTbl ||tableView == locationTbl ||tableView == categoriesListTbl ||tableView == subCategoriesListTbl ||tableView == brandListTbl ||tableView == modelListTbl||tableView == workFlowListTbl ||tableView == stockRequestSummaryInfoTbl || tableView == pagenationTbl ){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
           
            return 40;
        }
        else {
            return 90;
        }
    }
    
    else
        
        return 0;
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         26/09/2016
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @return       UITableViewCell
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section and populating the data into labels && creation of labels also....
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == stockRequestTbl) {
        
        if (self.isOpen && self.selectIndex.section == indexPath.section && indexPath.row!= 0) {
           
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
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:10];
            }
            hlcell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            
            
            [hlcell.contentView addSubview:requestedItemsTblHeaderView];
            [hlcell.contentView addSubview:requestedItemsTbl];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (requestedItemsInfoArr.count >4) {
                    
                    hlcell.frame = CGRectMake(stockRequestTbl.frame.origin.x,0,stockRequestTbl.frame.size.width,40*4+ 50);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    requestedItemsTbl.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,requestedItemsTblHeaderView.frame.size.height + 5,  requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height - 80);
                }
                else{
                    
                    hlcell.frame = CGRectMake( stockRequestTbl.frame.origin.x, 0, stockRequestTbl.frame.size.width,  (40  * (requestedItemsInfoArr.count + 2)) + 30);
                    requestedItemsTblHeaderView.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x, 10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    requestedItemsTbl.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height+5,requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height-80);
                }
            }
            else {
                
                if (requestedItemsInfoArr.count >4) {
                    hlcell.frame = CGRectMake( 15, 0,stockRequestTbl.frame.size.width - 15,  30*4);
                    
                    requestedItemsTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, hlcell.frame.size.height);
                }
                else{
                    
                    hlcell.frame = CGRectMake( 25, 0,stockRequestTbl.frame.size.width - 25,  requestedItemsInfoArr.count*30);
                    
                    requestedItemsTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, requestedItemsInfoArr.count*30);
                }
            }
            
            [requestedItemsTbl reloadData];
            
            hlcell.backgroundColor = [UIColor clearColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        
        else {
            
            UITableViewCell * hlcell ;
            
            @try {

            static NSString *hlCellID = @"hlCellID";
            
             hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
      
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }

            CAGradientLayer *layer_1;

            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
                hlcell.accessoryType = UITableViewCellAccessoryNone;

                @try {
                    layer_1 = [CAGradientLayer layer];
                    layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];

                    layer_1.frame = CGRectMake( snoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(snoLbl.frame.origin.x),1);

                    [hlcell.contentView.layer addSublayer:layer_1];

                } @catch (NSException *exception) {

                }
        }
            tableView.separatorColor = [UIColor clearColor];

//            @try {
            
                /*UILabels used in this cell*/
                UILabel * s_no_Lbl;
                UILabel * requestId_Lbl;
                UILabel * outlet_Id_Lbl;
                UILabel * requested_Date_Lbl;
                UILabel * requested_By_Lbl;
                UILabel * requested_quantity_Lbl;
                UILabel * approved_quantity_Lbl;
                UILabel * items_Lbl;
                UILabel * approved_itemsLbl;
                UILabel * deliveryDte_lbl;
                UILabel * status_Lbl;
                
                /*Creation of UILabels used in this cell*/
                s_no_Lbl = [[UILabel alloc] init];
                s_no_Lbl.backgroundColor = [UIColor clearColor];
                s_no_Lbl.textAlignment = NSTextAlignmentCenter;
                s_no_Lbl.numberOfLines = 1;
                s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                requestId_Lbl = [[UILabel alloc] init];
                requestId_Lbl.backgroundColor = [UIColor clearColor];
                requestId_Lbl.textAlignment = NSTextAlignmentCenter;
                requestId_Lbl.numberOfLines = 1;
                requestId_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                outlet_Id_Lbl = [[UILabel alloc] init];
                outlet_Id_Lbl.backgroundColor = [UIColor clearColor];
                outlet_Id_Lbl.textAlignment = NSTextAlignmentCenter;
                outlet_Id_Lbl.numberOfLines = 1;
                outlet_Id_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                requested_Date_Lbl= [[UILabel alloc] init];
                requested_Date_Lbl.backgroundColor = [UIColor clearColor];
                requested_Date_Lbl.textAlignment = NSTextAlignmentCenter;
                requested_Date_Lbl.numberOfLines = 1;
                requested_Date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                requested_By_Lbl = [[UILabel alloc] init];
                requested_By_Lbl.backgroundColor =  [UIColor clearColor];
                requested_By_Lbl.textAlignment = NSTextAlignmentCenter;
                requested_By_Lbl.numberOfLines = 1;
                
                requested_quantity_Lbl = [[UILabel alloc] init];
                requested_quantity_Lbl.backgroundColor =  [UIColor clearColor];
                requested_quantity_Lbl.textAlignment = NSTextAlignmentCenter;
                requested_quantity_Lbl.numberOfLines = 1;
                
                approved_quantity_Lbl = [[UILabel alloc] init];
                approved_quantity_Lbl.backgroundColor =  [UIColor clearColor];
                approved_quantity_Lbl.textAlignment = NSTextAlignmentCenter;
                approved_quantity_Lbl.numberOfLines = 1;
                
                items_Lbl = [[UILabel alloc] init];
                items_Lbl.backgroundColor =  [UIColor clearColor];
                items_Lbl.textAlignment = NSTextAlignmentCenter;
                items_Lbl.numberOfLines = 1;
                
                approved_itemsLbl = [[UILabel alloc] init];
                approved_itemsLbl.backgroundColor =  [UIColor clearColor];
                approved_itemsLbl.textAlignment = NSTextAlignmentCenter;
                approved_itemsLbl.numberOfLines = 1;
                
                deliveryDte_lbl = [[UILabel alloc] init];
                deliveryDte_lbl.backgroundColor =  [UIColor clearColor];
                deliveryDte_lbl.textAlignment = NSTextAlignmentCenter;
                deliveryDte_lbl.numberOfLines = 1;
                
                status_Lbl = [[UILabel alloc] init];
                status_Lbl.backgroundColor =  [UIColor clearColor];
                status_Lbl.textAlignment = NSTextAlignmentCenter;
                status_Lbl.numberOfLines = 1;
                
                /*Creation of UIButton's used in this cell*/
                viewStockRequestBtn = [[UIButton alloc] init];
               // viewStockRequestBtn.backgroundColor = [UIColor blackColor];
                viewStockRequestBtn.titleLabel.textColor = [UIColor whiteColor];
                viewStockRequestBtn.userInteractionEnabled = YES;
                viewStockRequestBtn.tag = indexPath.section;
                [viewStockRequestBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
                
                editStockRequestBtn = [[UIButton alloc] init];
                //editStockRequestBtn.backgroundColor = [UIColor blackColor];
                //editStockRequestBtn.titleLabel.textColor =  [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
                editStockRequestBtn.userInteractionEnabled = YES;
                editStockRequestBtn.tag = indexPath.section;
                [editStockRequestBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                
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
                [viewStockRequestBtn addTarget:self action:@selector(newStockRequest:) forControlEvents:UIControlEventTouchUpInside];
                [editStockRequestBtn addTarget:self action:@selector(stockRequestDetailsView:) forControlEvents:UIControlEventTouchUpInside];
                [viewListOfItemsBtn addTarget:self action:@selector(showListOfItems:) forControlEvents:UIControlEventTouchUpInside];
                
                //setting the color to text....
                s_no_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                requestId_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                outlet_Id_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                requested_Date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                requested_By_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                requested_quantity_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                approved_quantity_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                items_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                approved_itemsLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                deliveryDte_lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                status_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

                
                //added subview to cell View....
                [hlcell.contentView addSubview:s_no_Lbl];
                [hlcell.contentView addSubview:requestId_Lbl];
                [hlcell.contentView addSubview:outlet_Id_Lbl];
                [hlcell.contentView addSubview:requested_Date_Lbl];
                [hlcell.contentView addSubview:requested_By_Lbl];
                [hlcell.contentView addSubview:requested_quantity_Lbl];
                [hlcell.contentView addSubview:approved_quantity_Lbl];
                [hlcell.contentView addSubview:items_Lbl];
                [hlcell.contentView addSubview:approved_itemsLbl];
                [hlcell.contentView addSubview:deliveryDte_lbl];
                [hlcell.contentView addSubview:status_Lbl];
                
                //changed by Srinivasulu on 09/05/2017....
                [hlcell.contentView addSubview:viewStockRequestBtn];
                
                //setting frame and font........
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    //setting frame....
                    s_no_Lbl.frame = CGRectMake(snoLbl.frame.origin.x,0,snoLbl.frame.size.width,hlcell.frame.size.height);
                    requestId_Lbl.frame = CGRectMake(requestIDlbl.frame.origin.x, 0, requestIDlbl.frame.size.width-5,  hlcell.frame.size.height);
                    
                    outlet_Id_Lbl.frame = CGRectMake(outletIDLbl.frame.origin.x, 0, outletIDLbl.frame.size.width-2,  hlcell.frame.size.height);
                    
                    requested_Date_Lbl.frame = CGRectMake(requestDateLbl.frame.origin.x, 0, requestDateLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    requested_By_Lbl.frame = CGRectMake(requestedByLbl.frame.origin.x, 0, requestedByLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    requested_quantity_Lbl.frame = CGRectMake( requestedQuantityLbl.frame.origin.x, 0, requestedQuantityLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    approved_quantity_Lbl.frame = CGRectMake( approvedQuantityLbl.frame.origin.x , 0, approvedQuantityLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    items_Lbl.frame = CGRectMake(noOfItemslbl.frame.origin.x , 0, noOfItemslbl.frame.size.width,  hlcell.frame.size.height);
                   
                    approved_itemsLbl.frame = CGRectMake(approvedItemsLbl.frame.origin.x , 0, approvedItemsLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    deliveryDte_lbl.frame = CGRectMake( deliveryDteLbl.frame.origin.x , 0, deliveryDteLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    status_Lbl.frame = CGRectMake(requestStatusLbl.frame.origin.x,0,requestStatusLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    viewStockRequestBtn.frame = CGRectMake(actionLbl.frame.origin.x-8, 0, 60 ,  hlcell.frame.size.height);
                    
                    editStockRequestBtn.frame = CGRectMake(viewStockRequestBtn.frame.origin.x + viewStockRequestBtn.frame.size.width-12, 0, 60,hlcell.frame.size.height);
                    
                    viewListOfItemsBtn.frame = CGRectMake(editStockRequestBtn.frame.origin.x + editStockRequestBtn.frame.size.width-8,8,30,30);
                    
                    //setting font size....
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0 cornerRadius:0.0];
                    
                    viewStockRequestBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];
                    editStockRequestBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];
                    
                }
                else {
                    
                }
                
                @try {
                    
                    //Setting button Title....
                    [viewStockRequestBtn setTitle:NSLocalizedString(@"New", nil) forState:UIControlStateNormal];
                    [editStockRequestBtn setTitle:NSLocalizedString(@"Open", nil) forState:UIControlStateNormal];
                    
                    //changed by Srinivasulu on 18/01/2016.... populating data into textfields....
                    
                    if (stockRequestsInfoArr.count >= indexPath.section && stockRequestsInfoArr.count ) {
                        
                        //addded by Srinivsulu on 09/05/2017....
                        [hlcell.contentView addSubview:editStockRequestBtn];
                        [hlcell.contentView addSubview:viewListOfItemsBtn];
                        
                        NSDictionary * dic = stockRequestsInfoArr[indexPath.section];
                        
                        s_no_Lbl.text = [NSString stringWithFormat:@"%ld",(indexPath.section + 1) + requestStartNumber];
                        
                        requestId_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:STOCK_REQUEST_ID] defaultReturn:@"--"];
                        
                        outlet_Id_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:FROM_STORE_CODE] defaultReturn:@"--"];
                        
                        if( [dic.allKeys containsObject:REQUEST_DATE_STR] && ![[dic valueForKey:REQUEST_DATE_STR] isKindOfClass:[NSNull class]] )
                            
                            requested_Date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:REQUEST_DATE_STR] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
                        
                        if( [dic.allKeys containsObject:DELIVERY_DATE_STR] && ![[dic valueForKey:DELIVERY_DATE_STR] isKindOfClass:[NSNull class]] )
                            
                            deliveryDte_lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:DELIVERY_DATE_STR] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
                        
                        requested_By_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:REQUESTED_USER_NAME] defaultReturn:@"--"];
                        
                        status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS] defaultReturn:@"--"];
                        
                        float qty = 0;
                        float approvedQty  = 0;
                        float items = 0;
                        
                        for (NSDictionary * locDic in  [dic valueForKey:STOCK_REQUEST_ITEMS]) {
                            
                            qty  = qty + [[self checkGivenValueIsNullOrNil:[locDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
                            approvedQty = approvedQty + [[self checkGivenValueIsNullOrNil:[locDic valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue];
                            
                            items =  [[stockRequestsInfoArr[indexPath.section] valueForKey:STOCK_REQUEST_ITEMS] count];
                        }
                        
                        requested_quantity_Lbl.text = [NSString stringWithFormat:@"%.2f",qty];
                        
                        approved_quantity_Lbl.text = [NSString stringWithFormat:@"%.2f",approvedQty];
                        
                        items_Lbl.text = [NSString stringWithFormat:@"%.2f",items];
                        
                        approved_itemsLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:APPROVED_ITEMS] defaultReturn:@"0.00"] floatValue]];
                        
                    }
                    
                    else {
                        s_no_Lbl.text = NSLocalizedString(@"--", nil);
                        
                        //upto here on 18/01/2016....
                        requestId_Lbl.text = NSLocalizedString(@"--", nil);
                        outlet_Id_Lbl.text = NSLocalizedString(@"--", nil);
                        requested_Date_Lbl.text = NSLocalizedString(@"--", nil);
                        requested_By_Lbl.text =NSLocalizedString(@"--", nil);
                        requested_quantity_Lbl.text = NSLocalizedString(@"--", nil);
                        approved_quantity_Lbl.text = NSLocalizedString(@"--", nil);
                        items_Lbl.text = NSLocalizedString(@"--", nil);
                        approved_itemsLbl.text = NSLocalizedString(@"--", nil);
                        deliveryDte_lbl.text = NSLocalizedString(@"--", nil);
                        status_Lbl.text = NSLocalizedString(@"--", nil);
                        
                        //changed by Srinivasulu on 09/05/2016....
                        viewStockRequestBtn.frame = CGRectMake(actionLbl.frame.origin.x, 0, actionLbl.frame.size.width  , hlcell.frame.size.height);
                        
                        //layer_11.frame = CGRectMake(0, hlcell.frame.size.height - 2, viewStockRequestBtn.frame.size.width, 2);
                        //editStockRequestBtn.hidden = YES;
                        
                       
                    }
                    
                } @catch (NSException * exception) {
                    NSLog(@"----exceptionin StockRequest page----");
                    NSLog(@"----exception in cellForRowAtIndexPath while populating data-----%@",exception);
                }
                @finally{
                    
                }
            }
            @catch (NSException *exception) {
                
                NSLog(@"----exceptionin StockRequest page----");
                NSLog(@"----exception in cellForRowAtIndexPath-----%@",exception);
            }
            @finally{
                
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.tag = indexPath.section;

                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                return hlcell;
            }
        }
    }
    
    else if(tableView == requestedItemsTbl) {
        
        static NSString *hlCellID = @"ItemsCellID";
        
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
        hlcell.backgroundColor = [UIColor clearColor];
        
        @try {
            
            UILabel * item_No_Lbl;
            UILabel * item_code_Lbl;
            UILabel * item_Name_Lbl;
            UILabel * item_Grade_Lbl;
            UILabel * currentStock_Lbl;
            //UILabel * item_Approved_Time_Lbl;
            UILabel * item_Approved_By_Lbl;
            
            item_No_Lbl = [[UILabel alloc] init];
            item_No_Lbl.backgroundColor = [UIColor clearColor];
            item_No_Lbl.textAlignment = NSTextAlignmentCenter;
            item_No_Lbl.numberOfLines = 1;
            item_No_Lbl.layer.borderWidth = 1.5;
            item_No_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_No_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;
            
            item_code_Lbl = [[UILabel alloc] init];
            item_code_Lbl.backgroundColor = [UIColor clearColor];
            item_code_Lbl.textAlignment = NSTextAlignmentCenter;
            item_code_Lbl.numberOfLines = 1;
            item_code_Lbl.layer.borderWidth = 1.5;
            item_code_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_code_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;
            
            item_Name_Lbl = [[UILabel alloc] init];
            item_Name_Lbl.backgroundColor = [UIColor clearColor];
            item_Name_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Name_Lbl.numberOfLines = 1;
            item_Name_Lbl.layer.borderWidth = 1.5;
            item_Name_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_Name_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;
            
            item_Grade_Lbl = [[UILabel alloc] init];
            item_Grade_Lbl.backgroundColor =  [UIColor clearColor];
            item_Grade_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Grade_Lbl.numberOfLines = 1;
            item_Grade_Lbl.layer.borderWidth = 1.5;
            item_Grade_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_Grade_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            currentStock_Lbl = [[UILabel alloc] init];
            currentStock_Lbl.backgroundColor =  [UIColor clearColor];
            currentStock_Lbl.textAlignment = NSTextAlignmentCenter;
            currentStock_Lbl.numberOfLines = 1;
            currentStock_Lbl.layer.borderWidth = 1.5;
            currentStock_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            currentStock_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;
            
            qtyChangeTxt = [[UITextField alloc] init];
            qtyChangeTxt.borderStyle = UITextBorderStyleRoundedRect;
            qtyChangeTxt.textColor = [UIColor blackColor];
            qtyChangeTxt.keyboardType = UIKeyboardTypeNumberPad;
            qtyChangeTxt.layer.borderWidth = 1.5;
            qtyChangeTxt.backgroundColor = [UIColor clearColor];
            qtyChangeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            qtyChangeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            qtyChangeTxt.returnKeyType = UIReturnKeyDone;
            qtyChangeTxt.delegate = self;
            qtyChangeTxt.textAlignment = NSTextAlignmentCenter;
            [qtyChangeTxt awakeFromNib];
            //  [qtyChangeTxt becomeFirstResponder];
            qtyChangeTxt.keyboardType = UIKeyboardTypeNumberPad;
            qtyChangeTxt.tag = indexPath.row;
            [qtyChangeTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            apporvedQtyTxt = [[UITextField alloc] init];
            apporvedQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            apporvedQtyTxt.textColor = [UIColor blackColor];
            apporvedQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            apporvedQtyTxt.layer.borderWidth = 1.5;
            apporvedQtyTxt.backgroundColor = [UIColor clearColor];
            apporvedQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            apporvedQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            apporvedQtyTxt.returnKeyType = UIReturnKeyDone;
            apporvedQtyTxt.delegate = self;
            apporvedQtyTxt.textAlignment = NSTextAlignmentCenter;
            apporvedQtyTxt.tag = indexPath.row;
            [apporvedQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            qtyChangeTxt.userInteractionEnabled = YES;
            apporvedQtyTxt.userInteractionEnabled = NO;
            
            if(isInEditableState && isHubLevel ){
                
                apporvedQtyTxt.userInteractionEnabled = YES;
            }

            saveStockRequestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            saveStockRequestBtn.tag = indexPath.row;
            saveStockRequestBtn.backgroundColor =  [UIColor clearColor];
            saveStockRequestBtn.layer.borderWidth = 1.5;
            saveStockRequestBtn.layer.cornerRadius = 0;
            
            item_Approved_By_Lbl = [[UILabel alloc] init];
            item_Approved_By_Lbl.backgroundColor =  [UIColor clearColor];
            item_Approved_By_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Approved_By_Lbl.numberOfLines = 1;
            item_Approved_By_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;
            
            
            item_No_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_code_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_Name_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            item_Grade_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            currentStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            //            item_Approved_Time_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_Approved_By_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            qtyChangeTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            qtyChangeTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            apporvedQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            apporvedQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            [hlcell.contentView addSubview:item_No_Lbl];
            [hlcell.contentView addSubview:item_code_Lbl];
            [hlcell.contentView addSubview:item_Name_Lbl];
            [hlcell.contentView addSubview:item_Grade_Lbl];
            [hlcell.contentView addSubview:currentStock_Lbl];
            
            [hlcell.contentView addSubview:qtyChangeTxt];
            [hlcell.contentView addSubview:apporvedQtyTxt];
            //            [hlcell.contentView addSubview:item_Approved_Time_Lbl];
            [hlcell.contentView addSubview:item_Approved_By_Lbl];
            [hlcell.contentView addSubview:saveStockRequestBtn];
            
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:14.0f cornerRadius:0.0];
                
                item_No_Lbl.frame = CGRectMake( itemNoLbl.frame.origin.x,0,itemNoLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_code_Lbl.frame = CGRectMake(itemCodeLbl.frame.origin.x ,0, itemCodeLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_Name_Lbl.frame = CGRectMake( itemNameLbl.frame.origin.x,0, itemNameLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_Grade_Lbl.frame = CGRectMake( itemGradeLbl.frame.origin.x, 0, itemGradeLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                currentStock_Lbl.frame = CGRectMake(currentStockLbl.frame.origin.x, 0, currentStockLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                qtyChangeTxt.frame = CGRectMake(itemRequestedQtyLbl.frame.origin.x,0,(itemRequestedQtyLbl.frame.size.width + 2),hlcell.frame.size.height);
                
                apporvedQtyTxt.frame = CGRectMake(itemApprrovedQtyLbl.frame.origin.x,0,itemApprrovedQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                saveStockRequestBtn.frame = CGRectMake(apporvedQtyTxt.frame.origin.x + apporvedQtyTxt.frame.size.width+7,6,32,32);
                
                [saveStockRequestBtn setImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
                
            }
            else{
                
            }
            
            @try {
                
                NSMutableDictionary * locDic = [requestedItemsInfoArr[indexPath.row] mutableCopy] ;
                
                item_No_Lbl.text = [NSString stringWithFormat:@"%ld", (indexPath.row + 1)];
                
                item_code_Lbl.text =  [locDic valueForKey:PLU_CODE];
                item_Name_Lbl.text = [locDic valueForKey:ITEM_DESC];
                
                if ([[locDic valueForKey:PRODUCT_RANGE]isKindOfClass:[NSNull class]]|| (![[locDic valueForKey:PRODUCT_RANGE]isEqualToString:@""])) {
                    
                    item_Grade_Lbl.text = [self checkGivenValueIsNullOrNil:[locDic valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
                }
                else {
                    item_Grade_Lbl.text = NSLocalizedString(@"--", nil);
                }
                
                currentStock_Lbl.text = [NSString stringWithFormat:@"%.2f", [[locDic valueForKey:AVL_QTY] floatValue]];
                qtyChangeTxt.text = [NSString stringWithFormat:@"%.2f", [[locDic valueForKey:QUANTITY] floatValue]];
                
                
                if(![[locDic valueForKey:APPROVED_QTY] isKindOfClass: [NSNull class]] &&  [locDic.allKeys containsObject:APPROVED_QTY])
                    apporvedQtyTxt.text = [NSString stringWithFormat:@"%.2f", [[locDic valueForKey:APPROVED_QTY] floatValue]];
                else {
                    
                    locDic[APPROVED_QTY] = qtyChangeTxt.text;
                    apporvedQtyTxt.text = [NSString stringWithFormat:@"%.2f", [[locDic valueForKey:APPROVED_QTY] floatValue]];
                    
                    requestedItemsInfoArr[indexPath.row] = locDic;
                }
                
                item_Approved_By_Lbl.text = [self checkGivenValueIsNullOrNil:[locDic   valueForKey:REQUEST_APPROVED_BY] defaultReturn:@"--"];
                
                if([[self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:STATUS] defaultReturn:@""] caseInsensitiveCompare:CLOSED]  == NSOrderedSame){
                    
                    saveStockRequestBtn.userInteractionEnabled = NO;
                }
                else
                    saveStockRequestBtn.userInteractionEnabled = YES;
                
                [saveStockRequestBtn addTarget:self action:@selector(saveStockRequest:) forControlEvents:UIControlEventTouchDown];
                
        
            } @catch (NSException *exception) {
                NSLog(@"----exception while populating the data to itemsTbl----%@",exception);
            } @finally {
                
            }
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  hlcell;
        }
    }
    
    else   if(tableView == locationTbl) {
        
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
            if(outletIdTxt.tag == 0)
                hlcell.textLabel.text = locationArr[indexPath.row];
            else
                hlcell.textLabel.text = zoneListArr[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
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
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
        if ((hlcell.contentView).subviews) {
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        @try {
            hlcell.textLabel.numberOfLines = 1;
            hlcell.textLabel.text = subCategoriesListArr[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if (tableView == brandListTbl) {
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
            hlcell.textLabel.numberOfLines = 1;
            hlcell.textLabel.text = locationWiseBrandsArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
         return false;
    }
    
    else if(tableView == modelListTbl) {
        
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
            hlcell.textLabel.text = ModelListArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            
        } @catch (NSException * exception) {
            
        }
        return hlcell;
    }
    
    else if (tableView == stockRequestSummaryInfoTbl){
        
        @try {
            static NSString *hlCellID = @"ItemsCellID";
            
            UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
            
            if ((hlcell.contentView).subviews){
                
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            CAGradientLayer *layer_1;
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
                hlcell.accessoryType = UITableViewCellAccessoryNone;
                
                @try {
                    layer_1 = [CAGradientLayer layer];
                    layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                    
                    layer_1.frame = CGRectMake( summaryLabel_1.frame.origin.x, hlcell.frame.size.height - 2, stockRequestSummaryInfoTbl.frame.size.width, 1);
                    
                    [hlcell.contentView.layer addSublayer:layer_1];
                    
                } @catch (NSException *exception) {
                    
                }
            }
            tableView.separatorColor = [UIColor clearColor];
            hlcell.backgroundColor = [UIColor clearColor];
            
            
            @try {
                
                UILabel * item_No_Lbl;
                UILabel * date_Lbl;
                UILabel * avgIndent_Lbl;
                UILabel * avgSales_Lbl;
                UILabel * avgDump_Lbl;
                UILabel * avgReturn_Lbl;
                
                item_No_Lbl = [[UILabel alloc] init];
                item_No_Lbl.backgroundColor = [UIColor clearColor];
                item_No_Lbl.textAlignment = NSTextAlignmentCenter;
                item_No_Lbl.numberOfLines = 2;
                item_No_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                
                date_Lbl = [[UILabel alloc] init];
                date_Lbl.backgroundColor = [UIColor clearColor];
                date_Lbl.textAlignment = NSTextAlignmentCenter;
                date_Lbl.numberOfLines = 2;
                date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                avgIndent_Lbl = [[UILabel alloc] init];
                avgIndent_Lbl.backgroundColor = [UIColor clearColor];
                avgIndent_Lbl.textAlignment = NSTextAlignmentCenter;
                avgIndent_Lbl.numberOfLines = 2;
                avgIndent_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                avgSales_Lbl = [[UILabel alloc] init];
                avgSales_Lbl.backgroundColor = [UIColor clearColor];
                avgSales_Lbl.textAlignment = NSTextAlignmentCenter;
                avgSales_Lbl.numberOfLines = 2;
                avgSales_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                avgDump_Lbl = [[UILabel alloc] init];
                avgDump_Lbl.backgroundColor = [UIColor clearColor];
                avgDump_Lbl.textAlignment = NSTextAlignmentCenter;
                avgDump_Lbl.numberOfLines = 2;
                avgDump_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                avgReturn_Lbl = [[UILabel alloc] init];
                avgReturn_Lbl.backgroundColor = [UIColor clearColor];
                avgReturn_Lbl.textAlignment = NSTextAlignmentCenter;
                avgReturn_Lbl.numberOfLines = 2;
                avgReturn_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                item_No_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                avgIndent_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                avgSales_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                avgDump_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                avgReturn_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                if (stockRequestSummaryInfoArr.count >= indexPath.row && stockRequestSummaryInfoArr.count ) {
                    
                    NSDictionary * dic = stockRequestSummaryInfoArr[indexPath.row];
                    
                    item_No_Lbl.text = [NSString stringWithFormat:@"%d",(int)(indexPath.row + 1)];
                    
                    date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:DATE_STR] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
                    
                    avgIndent_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVG_INDENT] defaultReturn:@"0.0"] floatValue]];
                    
                    avgSales_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVG_SALES] defaultReturn:@"0.0"] floatValue]];
                    
                    avgDump_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVG_SALES] defaultReturn:@"0.0"] floatValue]];
                    
                    avgReturn_Lbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVG_SALES] defaultReturn:@"0.0"] floatValue]];
                    
                }
                
                else{
                    item_No_Lbl.text = NSLocalizedString(@"--", nil);
                    date_Lbl.text = NSLocalizedString(@"--", nil);
                    avgIndent_Lbl.text = NSLocalizedString(@"--", nil);
                    avgSales_Lbl.text = NSLocalizedString(@"--", nil);
                    avgDump_Lbl.text = NSLocalizedString(@"--", nil);
                    avgReturn_Lbl.text = NSLocalizedString(@"--", nil);
                    
                }
                
                
                [hlcell.contentView addSubview:item_No_Lbl];
                [hlcell.contentView addSubview:date_Lbl];
                [hlcell.contentView addSubview:avgIndent_Lbl];
                [hlcell.contentView addSubview:avgSales_Lbl];
                [hlcell.contentView addSubview:avgDump_Lbl];
                [hlcell.contentView addSubview:avgReturn_Lbl];
                
                item_No_Lbl.frame = CGRectMake(summaryLabel_1.frame.origin.x,0,summaryLabel_1.frame.size.width,hlcell.frame.size.height);
                date_Lbl.frame = CGRectMake(summaryLabel_2.frame.origin.x,0,summaryLabel_2.frame.size.width,hlcell.frame.size.height);
                avgIndent_Lbl.frame = CGRectMake(summaryLabel_3.frame.origin.x,0,summaryLabel_3.frame.size.width,hlcell.frame.size.height);
                avgSales_Lbl.frame = CGRectMake(summaryLabel_4.frame.origin.x,0,summaryLabel_4.frame.size.width,hlcell.frame.size.height);
                avgDump_Lbl.frame = CGRectMake(summaryLabel_5.frame.origin.x,0,summaryLabel_5.frame.size.width,hlcell.frame.size.height);
                avgReturn_Lbl.frame = CGRectMake(summaryLabel_6.frame.origin.x,0,summaryLabel_6.frame.size.width,hlcell.frame.size.height);
                
            }
            @catch (NSException *exception) {
                
            }
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //dismissing teh catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
    
    if(tableView == stockRequestTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            UIButton * showGridBtn = [[UIButton alloc]init];
            showGridBtn.tag = indexPath.section;
            [self showListOfItems:showGridBtn];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if(tableView == locationTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            categoryTxt.tag = 2;
            brandTxt.tag = 1;
            
            categoryTxt.text = @"";
            subCategoryTxt.text = @"";
            searchItemsTxt.text = @"";
            
            locationTbl.tag = indexPath.row;

            
            outletIdTxt.text = locationArr[indexPath.row];

            
            searchItemsTxt.tag = (searchItemsTxt.text).length;
            
        } @catch (NSException *exception) {
            NSLog(@"----exception in changing the textFieldData in didSelec----%@",exception);
        }
    }
    
    else  if(tableView == categoriesListTbl) {
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
            
            //categoryTxt.text = @"";
            
            subCategoryTxt.text = subCategoriesListArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == brandListTbl) {
        
        brandListTbl.tag = indexPath.row;

        brandTxt.text = locationWiseBrandsArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
    }
    
    else if (tableView == modelListTbl) {
        
        @try {
            
            modelListTbl.tag = indexPath.row;

            modelTxt.text = ModelListArray[indexPath.row];
            [catPopOver dismissPopoverAnimated:YES];
            
        }
        @catch (NSException *exception) {
            
        }
    }
    else if (tableView == workFlowListTbl) {
        
        @try {
            
            workFlowListTbl.tag = indexPath.row;
            
            statusTxt.text = workFlowsArr[indexPath.row];
            
        } @catch (NSException * exception) {
            
        }
    }
    
    else if (tableView == pagenationTbl){
        
        @try {
            
            requestStartNumber = 0;
            pagenationTxt.text = pagenationArr[indexPath.row];
            int pageValue = (pagenationTxt.text).intValue;
            requestStartNumber = requestStartNumber + (pageValue * 10) - 10;
            
        } @catch (NSException * exception) {
            
        }
    }
}


#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         07/05/2017....
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav.v
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
 * @description  here we are showing the list of requestedItems.......
 * @date         09/05/2017....
 * @method       showListOfItems;
 * @author       Bhargav.v
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
    
     [stockRequestTbl reloadData];
    
    @try {
        
        requestedItemsTbl.tag = sender.tag;
        
        requestedItemsInfoArr = [NSMutableArray new];
        requestedItemsInfoArr = [[stockRequestsInfoArr[sender.tag] valueForKey:STOCK_REQUEST_ITEMS] mutableCopy];
        
        isInEditableState = false;
        
        //here we are formating the next
        updateDictionary = [stockRequestsInfoArr[sender.tag] mutableCopy];
        
        //if(([[updateDictionary valueForKey:NEXT_ACTIVITIES] count]) || ([[updateDictionary valueForKey:NEXT_WORK_FLOW_STATES] count]) || ([[self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:STATUS] defaultReturn:@""] isEqualToString:SUBMITTED ]) ){
        
        if([[self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:STATUS] defaultReturn:@""] caseInsensitiveCompare:SUBMITTED]  == NSOrderedSame){
            
            isInEditableState = true;
        }
        
        //upto here.......
        if(requestedItemsInfoArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        
        NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
        
        if (path.row == 0) {
            
            UITableViewCell *cell2 = [stockRequestTbl cellForRowAtIndexPath:path];
            
            if ([path isEqual:self.selectIndex]) {
                self.isOpen = NO;
                
                for (UIButton *button in cell2.contentView.subviews) {
                    
                    if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                        
                        UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_right_arrow.png"];
                        
                        [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                        
                    }
                }
                
                [self didSelectCellRowFirstDo:NO nextDo:NO];
                self.selectIndex = nil;
                
            }
            else {
                
                if (!self.selectIndex) {
                    self.selectIndex = path;
                    
                    for (UIButton *button in cell2.contentView.subviews) {
                        
                        if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                            
                            UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                            
                            [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                        }
                    }
                    
                    //requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:path.section] valueForKey:@"stockRequestItems"];
                    
                    [self didSelectCellRowFirstDo:YES nextDo:NO];
                    
                }
                else {
                    
                    selectSectionIndex = path;
                    
                    cell2 = [stockRequestTbl cellForRowAtIndexPath: self.selectIndex];
                    
                    for (UIButton *button in cell2.contentView.subviews) {
                        
                        if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                            
                            UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_right_arrow.png"];
                            
                            [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                        }
                    }
                    
                    [self didSelectCellRowFirstDo:NO nextDo:YES];
                }
                
                //  selectProductCatRowNo = [NSNumber numberWithInt:selectIndex.section];
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in showListOfItems----%@",exception);
        NSLog(@"----exception in inserting the row in table----%@",exception);
        
    } @finally {
        
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
        
        [stockRequestTbl beginUpdates];
        
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
            
            [stockRequestTbl  insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [stockRequestTbl deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [stockRequestTbl endUpdates];
        
        if (nextDoInsert) {
            self.isOpen = YES;
            self.selectIndex = selectSectionIndex;
            //            requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:selectIndex.section] valueForKey:@"stockRequestItems"];
            
            UITableViewCell * cell2 = [stockRequestTbl cellForRowAtIndexPath:selectIndex];
            
            for (UIButton * button in cell2.contentView.subviews) {
                
                if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                    
                    UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                    
                    [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                    
                }
            }
            [self didSelectCellRowFirstDo:YES nextDo:NO];
        }
        if (self.isOpen)
            [stockRequestTbl scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        //[stockRequestTbl scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }    @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in didSelectCellRowFirsDo: nextDo----%@",exception);
        
        NSLog(@"----exception in inserting the row in table----%@",exception);
        
    }
    @finally {
        //        [stockRequestTbl reloadData];
    }
    
}


#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         09/05/2017
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

-(void)displayAlertMessage:(NSString *)message  horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float)labelWidth contentHeight:(float)labelHeight  isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay  noOfLines:(int)noOfLines {
    
    
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
 * @date         09/05/2017
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


//#pragma  -mark labels added

//-(void)addLabelsToScrollView:(NSArray *)labelsArr{
//
//    @try {
//
//        if([labelsArr count]){
//
//            if(detailsFooterView == nil){
//
//                detailsFooterView = [[UIScrollView alloc] init];
//                detailsFooterView.delegate = self;
//                detailsFooterView.showsVerticalScrollIndicator = YES;
//                [detailsFooterScrollView addSubview:detailsFooterView];

//                scrollViewBarImgView = [[UIImageView alloc] init];
//                UIImage *imgBar = [UIImage imageNamed:@"Gradient_2.png"];
//                [scrollViewBarImgView setImage:imgBar];
//                CGRect frame = scrollViewBarImgView.frame;
//                frame.size.width = 8;
//                frame.size.height = 60;
//                frame.origin.x = 312;
//                frame.origin.y = 0;
//                [scrollViewBarImgView setFrame:frame];
//
//            }
//            else{
//
//                for(id view in detailsFooterView.subviews){
//
//                    [view removeFromSuperview];
//                }
//            }
//            float origin_y = 0;
//            for(NSDictionary *dic in labelsArr){

//                UILabel *statusNameLbl = [[UILabel alloc] init];
//                statusNameLbl.layer.masksToBounds = YES;
//                statusNameLbl.numberOfLines = 2;
//                [statusNameLbl setTextAlignment:NSTextAlignmentLeft];
//                statusNameLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//
//                UILabel *semiColonLbl = [[UILabel alloc] init];
//                semiColonLbl.layer.masksToBounds = YES;
//                semiColonLbl.numberOfLines = 2;
//                [semiColonLbl setTextAlignment:NSTextAlignmentRight];
//                semiColonLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//
//                UILabel *statusValueLbl = [[UILabel alloc] init];
//                statusValueLbl.layer.masksToBounds = YES;
//                statusValueLbl.numberOfLines = 2;
//                [statusValueLbl setTextAlignment:NSTextAlignmentRight];
//                statusValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//
//                statusNameLbl.frame =  CGRectMake( 0, origin_y, 180, 40);
//
//                semiColonLbl.frame =  CGRectMake( statusNameLbl.frame.origin.x + statusNameLbl.frame.size.width, statusNameLbl.frame.origin.y, 5, 40);
//
//                statusValueLbl.frame =  CGRectMake( semiColonLbl.frame.origin.x + semiColonLbl.frame.size.width, statusNameLbl.frame.origin.y, underLine_2.frame.size.width - statusNameLbl.frame.size.width - 15, 40);
//
//                origin_y = origin_y + statusNameLbl.frame.size.height;
//
//                [detailsFooterView addSubview:statusNameLbl];
//                [detailsFooterView addSubview:semiColonLbl];
//                [detailsFooterView addSubview:statusValueLbl];
//
//                @try {
//
//                    statusNameLbl.text = [NSString stringWithFormat:@"%@%@%@",[self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS_NAME] defaultReturn:@"--"],@" ",NSLocalizedString(@"qty", nil)];
//
//                    semiColonLbl.text = NSLocalizedString(@":", nil);
//                    statusValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",[[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
//
//                } @catch (NSException *exception) {
//
//                }
//            }
//            detailsFooterView.frame = CGRectMake( underLine_2.frame.origin.x, 0, underLine_2.frame.size.width, detailsFooterScrollView.frame.size.height);
//
//            //added by Srinivasulu on 11/02/2017....
//
//            [detailsFooterView addSubview:scrollViewBarImgView];
//
//            scrollViewBarImgView.frame = CGRectMake( detailsFooterView.frame.size.width - 10, 0, 10, 40);
//
//            //upto here on 11/02/2017....
//
//            detailsFooterView.contentSize = CGSizeMake(detailsFooterView.frame.size.width, origin_y);
//
//            detailsFooterView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
//
//            detailsFooterView.showsVerticalScrollIndicator = YES;
//
//            if( [labelsArr count] <= 2)
//                scrollViewBarImgView.hidden = YES;
//            else
//                scrollViewBarImgView.hidden = NO;
//
//
//            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:detailsFooterScrollView andSubViews:YES fontSize:20.0 cornerRadius:10.0f];
//
//            detailsFooterScrollView.hidden = NO;
//            detailsFooterView.hidden = NO;
//
//            //            scrollViewBarImgView.hidden = NO;
//        }
//        else{
//            detailsFooterView.hidden = YES;
//            scrollViewBarImgView.hidden = YES;
//
//        }
//    } @catch (NSException * exception) {
//
//    } @finally {
//
//    }
//}

#pragma -mark UIScrollView delegate methods....

/**
 * @description  this is method will be executed when scrollView in
 * @date         11/02/2017..
 * @method       scrollViewDidScroll:
 * @author       Srinivasulu
 * @param        UIScrollView
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    
    @try {
        if(scrollView == detailsFooterView){
            
            //reading the scrollView frame && scrollView offSet....
            CGPoint offset = scrollView.contentOffset;
            CGRect frame = scrollViewBarImgView.frame;
            
            float fact = (scrollView.contentSize.height + 50) / scrollView.contentSize.height;
            
            frame.origin.y = offset.y + (offset.y/fact);
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            scrollViewBarImgView.frame = frame;
            [UIView commitAnimations];
            
        }
        
    } @catch (NSException *  exception) {
        
    } @finally {
        
    }
}



#pragma -mark action used to update the service calls....

/**
 * @description  here update the stockRequest...........
 * @date         22/09/2016
 * @method       saveStockRequest
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)saveStockRequest:(UIButton*)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
    @try {
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"updating_stock_request..", nil)];
        
        //used for Updating the row.......
        stockRequestTbl.tag = sender.tag;
        
        // added by roja on 29-06-2018...
        float requestedNoOfItems = 0;
        requestedNoOfItems = [[stockRequestsInfoArr[sender.tag] valueForKey:STOCK_REQUEST_ITEMS] count];
        
        //updating the request based on arrow button clicked.......
        NSMutableDictionary * dic = [stockRequestsInfoArr[requestedItemsTbl.tag] mutableCopy];
        
        updateDictionary = [stockRequestsInfoArr[requestedItemsTbl.tag] mutableCopy];
        
        NSMutableArray * tempArr = [NSMutableArray new];
        
        float totalRequestAmount = 0;
        float totalAmount = 0;
        float estimatedCost = 0;
        int requiredQty = 0;
        int approvedQty = 0;
        
        for(NSDictionary * locDic  in requestedItemsInfoArr) {
            
            NSMutableDictionary * temp = [NSMutableDictionary new];
            
            requiredQty = requiredQty + (int) [[locDic  valueForKey:QUANTITY] integerValue];
            approvedQty = approvedQty + (int) [[locDic  valueForKey:kApprovedQty] integerValue];
            
            // Changed by Roja on 29-06-2018...
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_DESC] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:iTEM_PRICE] defaultReturn:@"0.00"] forKey:iTEM_PRICE];

            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:QUANTITY] defaultReturn:@"0.00"] forKey:QUANTITY];

            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:kApprovedQty] defaultReturn:@"0.00"] forKey:kApprovedQty];
            
            totalAmount = [[locDic valueForKey: iTEM_PRICE] floatValue] * [[locDic valueForKey:kApprovedQty] floatValue] ;
            totalRequestAmount = totalRequestAmount + totalAmount;
            [temp setValue:[NSString stringWithFormat:@"%.2f", totalAmount] forKey:TOTAL_COST];
            
            estimatedCost = [[locDic valueForKey: iTEM_PRICE] floatValue] * [[locDic valueForKey:QUANTITY] floatValue] ;
            [temp setValue:[NSString stringWithFormat:@"%.2f", estimatedCost] forKey:ESTIMATED_COST];

            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];

            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];

            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];

            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:AVL_QTY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:MEASUREMENT_RANGE] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];

            [temp setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:QOH] defaultReturn:@"0.00"] floatValue]] forKey:QOH];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:kProductId] defaultReturn:EMPTY_STRING] forKey:kProductId];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:EAN] defaultReturn:EMPTY_STRING] forKey:EAN];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
            
            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:kBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];

            [temp setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];

            [tempArr addObject:temp];
        }
        
        updateDictionary[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        updateDictionary[STOCK_REQUEST_ITEMS] = tempArr;
        updateDictionary[APPROVED_QTY] = [ NSString stringWithFormat:@"%i",requiredQty ];
        updateDictionary[QUANTITY] = [ NSString stringWithFormat:@"%i",approvedQty ];
        
        updateDictionary[TOTAL_STOCK_REQUEST_VALUE] = @(totalRequestAmount);
        
        updateDictionary[STATUS] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:STATUS] defaultReturn:EMPTY_STRING];
        
        updateDictionary[STOCK_REQUEST_ID] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:STOCK_REQUEST_ID] defaultReturn:EMPTY_STRING];

        updateDictionary[FROM_STORE_CODE] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:FROM_STORE_CODE] defaultReturn:EMPTY_STRING];

        updateDictionary[FROM_WARE_HOUSE_ID] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:FROM_WARE_HOUSE_ID] defaultReturn:EMPTY_STRING];

        updateDictionary[TO_STORE_CODE] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:TO_STORE_CODE] defaultReturn:EMPTY_STRING];

        updateDictionary[TO_WARE_HOUSE_ID] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:TO_WARE_HOUSE_ID] defaultReturn:EMPTY_STRING];

        updateDictionary[REASON] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:REASON] defaultReturn:EMPTY_STRING];

        updateDictionary[REQUEST_DATE_STR] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:REQUEST_DATE_STR] defaultReturn:EMPTY_STRING];

        updateDictionary[DELIVERY_DATE_STR] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:DELIVERY_DATE_STR] defaultReturn:EMPTY_STRING];

        updateDictionary[REQUESTED_USER_NAME] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:REQUESTED_USER_NAME] defaultReturn:EMPTY_STRING];

        updateDictionary[REMARKS] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:REMARKS] defaultReturn:EMPTY_STRING];

        updateDictionary[SHIPPING_MODE] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:SHIPPING_MODE] defaultReturn:EMPTY_STRING];

        updateDictionary[SHIPPING_COST] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:SHIPPING_COST] defaultReturn:EMPTY_STRING];

        updateDictionary[REQUEST_APPROVED_BY] = [self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:REQUEST_APPROVED_BY] defaultReturn:EMPTY_STRING];

        NSMutableDictionary * dicionary = [NSMutableDictionary new];
        dicionary[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        dicionary[STATUS] = [self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS] defaultReturn:EMPTY_STRING];
        
        dicionary[STOCK_REQUEST_ID] = [self checkGivenValueIsNullOrNil:[dic valueForKey:STOCK_REQUEST_ID] defaultReturn:EMPTY_STRING];
        
        dicionary[FROM_STORE_CODE] = [self checkGivenValueIsNullOrNil:[dic valueForKey:FROM_STORE_CODE] defaultReturn:EMPTY_STRING];
        
        dicionary[FROM_WARE_HOUSE_ID] = [self checkGivenValueIsNullOrNil:[dic valueForKey:FROM_WARE_HOUSE_ID] defaultReturn:EMPTY_STRING];
        
        dicionary[TO_STORE_CODE] = [self checkGivenValueIsNullOrNil:[dic valueForKey:TO_STORE_CODE] defaultReturn:EMPTY_STRING];
        
        dicionary[TO_WARE_HOUSE_ID] = [self checkGivenValueIsNullOrNil:[dic valueForKey:TO_WARE_HOUSE_ID] defaultReturn:EMPTY_STRING];
        
        dicionary[REASON] = [self checkGivenValueIsNullOrNil:[dic valueForKey:REASON] defaultReturn:EMPTY_STRING];
        
        dicionary[REQUEST_DATE_STR] = [self checkGivenValueIsNullOrNil:[dic valueForKey:REQUEST_DATE_STR] defaultReturn:EMPTY_STRING];
        
        dicionary[DELIVERY_DATE_STR] = [self checkGivenValueIsNullOrNil:[dic valueForKey:DELIVERY_DATE_STR] defaultReturn:EMPTY_STRING];
        
        dicionary[REQUESTED_USER_NAME] = [self checkGivenValueIsNullOrNil:[dic valueForKey:REQUESTED_USER_NAME] defaultReturn:EMPTY_STRING];
        
        dicionary[REMARKS] = [self checkGivenValueIsNullOrNil:[dic valueForKey:REMARKS] defaultReturn:EMPTY_STRING];
        
        dicionary[SHIPPING_MODE] = [self checkGivenValueIsNullOrNil:[dic  valueForKey:SHIPPING_MODE] defaultReturn:EMPTY_STRING];
        
        dicionary[SHIPPING_COST] = [self checkGivenValueIsNullOrNil:[dic valueForKey:SHIPPING_COST] defaultReturn:EMPTY_STRING];
        
        dicionary[REQUEST_APPROVED_BY] = [self checkGivenValueIsNullOrNil:[dic valueForKey:REQUEST_APPROVED_BY] defaultReturn:EMPTY_STRING];
        // adding noOfItems Key
        // added by roja
        dicionary[NO_OF_ITEMS] = [NSString stringWithFormat:@"%.2f",requestedNoOfItems ];
        
        dicionary[APPROVED_QTY] = [ NSString stringWithFormat:@"%i", approvedQty];
        dicionary[QUANTITY] = [ NSString stringWithFormat:@"%i", requiredQty];
        dicionary[TOTAL_STOCK_REQUEST_VALUE] = @(totalRequestAmount);
        dicionary[STOCK_REQUEST_ITEMS] = tempArr;
        
        // till here on 29-06-2018...
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:updateDictionary options:0 error:&err];
//        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockRequestDelegate = self;
        [webServiceController updateStockRequest: jsonData];
        
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"----exception in the stockReceiptView in updateStockRequest:----%@",exception);
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    } @finally {
        
    }
    
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getStockRequestsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method && status not updating fixed....
 *
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)updateStockRequestsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height-350;
        
        if (searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        stockRequestsInfoArr[requestedItemsTbl.tag] = updateDictionary;
        
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
        [requestedItemsTbl reloadData];
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getStockRequestsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)updateStockRequestsErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


#pragma -mark reusableMethods.......

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

-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
    
    @try {
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height > height) ){
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
            
            // customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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

#pragma -mark action used in this page to show the popups....

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
 *
 */

- (void)showAllOutletId:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        //        if (![catPopOver isPopoverVisible]){
        if(locationArr == nil ||  locationArr.count == 0) {
            
            [HUD setHidden:NO];
            
            // changed on 17/02/2017....
            [self getZones];
            
        }
        
        if(locationArr.count){
            float tableHeight = locationArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = locationArr.count * 33;
            
            if(locationArr.count > 5)
                tableHeight = (tableHeight/locationArr.count) * 5;
            
            zoneIdTxt.tag = 2;
            outletIdTxt.tag = 0;
            
            [self showPopUpForTables:locationTbl  popUpWidth:(outletIdTxt.frame.size.width* 1.5) popUpHeight:tableHeight presentPopUpAt:outletIdTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp];
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
            //            [self getOutletsMappedToThisWarehouse];
            
        }
        [HUD setHidden:YES];
        
        
        if(zoneListArr.count){
            float tableHeight = zoneListArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = zoneListArr.count * 33;
            
            if(zoneListArr.count > 5)
                tableHeight = (tableHeight/zoneListArr.count) * 5;
            
            
            zoneIdTxt.tag = 0;
            outletIdTxt.tag = 2;
            
            
            [self showPopUpForTables:locationTbl  popUpWidth:(zoneIdTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:zoneIdTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp];
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
        
        float tableHeight = categoriesListArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = categoriesListArr.count * 33;
        
        if(categoriesListArr.count > 5)
            tableHeight =(tableHeight/categoriesListArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showAllSubCategoriesList:
 * @author       Bhargav.v
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
        float tableHeight = subCategoriesListArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoriesListArr.count * 33;
        
        if(subCategoriesListArr.count > 5)
            tableHeight = (tableHeight/subCategoriesListArr.count)*5;
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:(subCategoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
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

-(void)showListOfAllBrands:(UIButton *)sender {
    
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
        
        float tableHeight = locationWiseBrandsArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationWiseBrandsArr.count * 33;
        
        if(locationWiseBrandsArr.count > 5)
            tableHeight = (tableHeight/locationWiseBrandsArr.count) * 5;
        
        [self showPopUpForTables:brandListTbl  popUpWidth:(brandTxt.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showModelList:
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)showModelList:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((ModelListArray == nil) || (ModelListArray.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self callingModelList];
            
            return;
        }
        
        [HUD setHidden:YES];
        
        if(ModelListArray.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = ModelListArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = ModelListArray.count * 33;
        
        if(ModelListArray.count > 5)
            tableHeight = (tableHeight/ModelListArray.count) * 5;
        
        [self showPopUpForTables:modelListTbl  popUpWidth:(modelTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:modelTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}



/**
 * @description  sending the Request to get the WorkFlow States In Stock Request...
 * @date         10/09/2017
 * @method       showWorkFlowStatus
 * @author       Bhargav.v
 * @param        UIButton
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
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        float tableHeight = workFlowsArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = workFlowsArr.count * 33;
        
        if(workFlowsArr.count>5)
            tableHeight = (tableHeight/workFlowsArr.count) * 5;
        
        [self showPopUpForTables:workFlowListTbl  popUpWidth:(statusTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:statusTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are sending the Request through searchTheProducts to filter the Records .......
 * @date         31/03/2017
 * @method       searchTheProducts
 * @author       Bhargav.v
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
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0 && (brandTxt.text).length == 0 && (modelTxt.text).length== 0 && (startDateTxt.text).length == 0 && (endDateTxt.text).length== 0 && (outletIdTxt.text).length== 0 && (statusTxt.text).length == 0 ) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_above_fields_before_proceeding",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        else
            [HUD setHidden:NO];
        requestStartNumber = 0;
        [self callingGetStockRequests];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Clearing the All Data in  searchTheProducts to get All The Records...
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
        searchBtn.tag  = 2;
        
        categoryTxt.text = @"";
        subCategoryTxt.text = @"";
        brandTxt.text = @"";
        modelTxt.text = @"";
        startDateTxt.text = @"";
        endDateTxt.text = @"";
        
        if (isHubLevel) {
            
            outletIdTxt.text = @"";
        }
        statusTxt.text = @"";
        
        requestStartNumber = 0;
        
        [self callingGetStockRequests];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
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
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}



#pragma -mark service call.......

/**
 * @description  here calling the service to getAllLocations............
 * @date         29/05/2017
 * @method       getZones
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By Srinivasulu on 10/06/2017....
 * @reason      hidding hud in catch....
 *
 */


-(void)callingStockRequestSumary:(UIButton *)sender {
    
    @try {
        
        [HUD setHidden: NO];
        
        if (stockRequestSummaryInfoArr == nil) {
            stockRequestSummaryInfoArr  = [NSMutableArray new];
        }
        else if (stockRequestSummaryInfoArr.count){
            [stockRequestSummaryInfoArr removeAllObjects];
        }
        
        NSMutableDictionary * stockRequestSummaryDic = [[NSMutableDictionary alloc] init];
        
        stockRequestSummaryDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        stockRequestSummaryDic[START_INDEX] = @0;
        stockRequestSummaryDic[FROM_STORE_CODE] = presentLocation;
        stockRequestSummaryDic[ISOUTLET] = [NSNumber numberWithBool:true];
        
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:stockRequestSummaryDic options:0 error:&err];
        NSString * stockRequestJSonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockRequestDelegate = self;
        [webServiceController getStockRequestSummaryInfo:stockRequestJSonStr];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while callingStockRequestSumary ServicesCall ----%@",exception);
        
    }
    @finally {
        
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
        
        NSString * zoneStr = zoneIdTxt.text;
        
        NSMutableDictionary * zoneDic  = [[NSMutableDictionary alloc]init];
        
        [zoneDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [zoneDic setValue:@0 forKey:START_INDEX];
        [zoneDic setValue:zoneStr forKey:ZONE_ID];
        
        NSError * err_;
        NSData  * jsonData_ = [NSJSONSerialization dataWithJSONObject:zoneDic options:0 error:&err_];
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
        
        // Changes Made By Bhargav.v on 20/10/2017
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

/**
 * @description  here we are calling the getDepartmentList services.....
 * @date         31/03/2017
 * @method       callingCategoriesList
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)callingCategoriesList:(NSString *)categoryName {
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(categoriesListTbl.tag == 2 )
            categoriesListArr = [NSMutableArray new];
        else
            subCategoriesListArr = [NSMutableArray new];
        
        // Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSMutableDictionary * categoriesDic = [[NSMutableDictionary alloc]init];
        
        [categoriesDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [categoriesDic setValue:NEGATIVE_ONE forKey:START_INDEX];
        [categoriesDic setValue:[NSNumber numberWithBool:true] forKey:SL_NO];
        [categoriesDic setValue:categoryName forKey:kCategoryName];
        [categoriesDic setValue:EMPTY_STRING forKey:FLAG];
        
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
 * @description  sending the Request to get the Brands
 * @date         30/04/2017
 * @method       callingBrandList
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)callingBrandList {
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        
        if (brandListArray == nil) {
            brandListArray  = [NSMutableArray new];
        }
        
        
        // Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSMutableDictionary * brandDic = [[NSMutableDictionary alloc]init];
        
        [brandDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [brandDic setValue: NSLocalizedString(@"-1", nil) forKey:START_INDEX];
        
        //[brandDic setValue:[NSNumber numberWithBool:true] forKey:SL_NO];
        //[brandDic setValue:@"" forKey:@"bName"];

        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:brandDic options:0 error:&err];
        NSString * brandListJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getBrandList:brandListJsonString];
        
    }
    @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while callingBrandList ServicesCall ----%@",exception);
        
    }
    @finally {
        
    }
    
}

/**
 * @description  sending Request to the Service To get Models
 * @date         4/05/2017
 * @method       callingModelList
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingModelList {
    @try {
        
        
        [HUD setHidden:NO];
        
        if (ModelListArray == nil) {
            ModelListArray  = [NSMutableArray new];
        }
        
        // Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSMutableDictionary * modelDic = [[NSMutableDictionary alloc]init];
        
        [modelDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [modelDic setValue:@0 forKey:START_INDEX];
        
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:modelDic options:0 error:&err];
        NSString * modelJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.modelMasterDelegate = self;
        [webServiceController getModelDetails:modelJsonStr];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while callingModelList ServicesCall ----%@",exception);
        
    }
    @finally {
        
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
 */

-(void)getWorkFlows {
    
    @try {
        
        [HUD show: YES];
        [HUD setHidden:NO];
        
        workFlowsArr = [NSMutableArray new];
        
        NSMutableDictionary * workFlowDic = [[NSMutableDictionary alloc]init];
        
        [workFlowDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [workFlowDic setValue:NSLocalizedString(@"stock_request", nil) forKey:BUSINESSFLOW];
        [workFlowDic setValue:presentLocation forKey:STORE_LOCATION];
        [workFlowDic setValue:NSLocalizedString(@"-1", nil) forKey:START_INDEX];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:workFlowDic options:0 error:&err];
        NSString * workFlowJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.rolesServiceDelegate = self;
        [webServiceController getWorkFlows:workFlowJsonStr];
        
        
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getWorkFlows ServicesCall ----%@",exception);
        
    } @finally {
        
        
    }
}


/**
 * @description  forming the request to  get the categories based on location.
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
        
        NSString *  outLetStoreID = outletIdTxt.text;
    
        [locationDictionary setValue:outLetStoreID forKey:kStoreLocation];

        
        [locationDictionary setValue: NSLocalizedString(@"-1", nil) forKey:START_INDEX_STR];
       
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
        
        NSString *  outLetStoreID = outletIdTxt.text;
        
        [locationDictionary setValue:outLetStoreID forKey:kStoreLocation];
        
        [locationDictionary setValue:NSLocalizedString(@"-1", nil) forKey:START_INDEX_STR];
        
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


#pragma -mark handling serviceCallRespone.......


/**
 * @description  handling the response of GetStockReuest....
 * @date         21/09/2016
 * @method       stockRequestSummarySuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getStockRequestSummarySuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        summaryFieldsDic = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary * summaryDic in [successDictionary valueForKey:SUMMARY_RESPONSE]) {
            
            [stockRequestSummaryInfoArr addObject:summaryDic];
        }
        
        summaryFieldsDic = [successDictionary copy];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        if(stockRequestSummaryInfoArr.count){
            [self showCompleteStockRequestInfo:nil];
            [stockRequestSummaryInfoTbl reloadData];
            
        }
        else{
            
            [HUD setHidden:YES];
            float y_axis = self.view.frame.size.height - 350;
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        [HUD setHidden:YES];
    }
}

/**
 * @description  handling the response of GetStockReuest....
 * @date         21/09/2016
 * @method       getStockRequestSummaryErrorResponse:
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getStockRequestSummaryErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    }
    @catch (NSException *exception) {
        
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
        
        
        NSArray *locations = [successDictionary valueForKey:LOCATIONS_DETAILS];
        
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
        if(stockRequestsInfoArr.count)
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
        if(stockRequestsInfoArr.count)
            [HUD setHidden:YES];
    }
    
}


/**
 * @description  Handling the Response for GetZones...
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


    @try{
    
        //here we are reading the Locations based on zone ID and bussiness type......
        [locationArr addObject:NSLocalizedString(@"all_outlets",nil)];
        
        for(NSDictionary * locDic in [[successDictionary valueForKey:ZONE_MASTER_LIST] valueForKey:ZONE_DETAILS][0]) {
            
            
            if ([[locDic valueForKey:LOCATION_TYPE] caseInsensitiveCompare:RETAIL_OUTLET] == NSOrderedSame) {
                
                [locationArr addObject:[locDic valueForKey:LOCATION]];
            }
            
            if ([locationArr containsObject:presentLocation]) {
                
                [locationArr removeObject:presentLocation];
            }
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
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  handling the success response for GetCategories....
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

-(void)getCategorySuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try   {
        
        if(categoriesListTbl.tag == 2)
            [categoriesListArr addObject:NSLocalizedString(@"all_categories",nil)];
        else
            [subCategoriesListArr addObject:NSLocalizedString(@"all_subcategories_",nil)];
        
        for (NSDictionary * categoryDic in  [sucessDictionary valueForKey:CATEGORIES]){
            
            if(categoriesListTbl.tag == 2) {
                

                [categoriesListArr addObject:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:kCategoryName]  defaultReturn:@""]];
            }
            else {
                
                if([categoryTxt.text isEqualToString:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:kCategoryName]  defaultReturn:@""]] ){
                    
                    if([categoryDic.allKeys containsObject:SUB_CATEGORIES] && (![[categoryDic valueForKey:SUB_CATEGORIES] isKindOfClass: [NSNull class]]))
                    
                        for (NSDictionary * subCatDic in  [categoryDic valueForKey:SUB_CATEGORIES]){
                            
                            [subCategoriesListArr addObject:[self checkGivenValueIsNullOrNil:[subCatDic valueForKey:kSubCategoryName]  defaultReturn:@""]];
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
 * @description  handling the service call error resposne for GetCategories....
 * @date         03/04/2017
 * @method       getCategoryErrorResponse:
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getCategoryErrorResponse:(NSString*)error {
    
    [HUD setHidden:YES];
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  handling the success response for getDepartments....
 * @date         31/03/2017
 * @method       getDepartmentSuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getDepartmentSuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try   {
        
        for (NSDictionary * department in  [sucessDictionary valueForKey:kDepartments]){
            [departmentListArr addObject:[self checkGivenValueIsNullOrNil:[department valueForKey:kPrimaryDepartment]  defaultReturn:@""]];
            
            NSMutableArray *locArr = [NSMutableArray new];
            
            @try {
                
                
                for (NSDictionary * subDepartment in [department valueForKey:SECONDARY_DEPARTMENTS]){
                    
                    [locArr addObject:[self checkGivenValueIsNullOrNil:[subDepartment valueForKey:SECONDARY_DEPARTMENT]  defaultReturn:@""]];
                }
                
            } @catch (NSException *exception) {
                
            }
            
            dept_SubDeptDic[[self checkGivenValueIsNullOrNil:[department valueForKey:kPrimaryDepartment]  defaultReturn:@""]] = locArr;
            
        }
        
    }
    
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden: YES];
    }
    
    
}


/**
 * @description  handling the service call error resposne for GetDepartments....
 * @date         31/03/2017
 * @method       getDepartmentErrorResponse:
 * @author       Bhargav.v
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


/**
 * @description  handling the success response for GetBrands....
 * @date         24/05/2017
 * @method       getBrandMasterSuccessResponse:
 * @author       Bhargav
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getBrandMasterSuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
   
        
        [brandListArray addObject:NSLocalizedString(@"all_brands",nil)];

        for (NSDictionary * brand in  [sucessDictionary valueForKey: BRAND_DETAILS ]) {
            
            [brandListArray addObject:[self checkGivenValueIsNullOrNil:[brand valueForKey:BNAME]  defaultReturn:@""]];
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
 * @date         24/05/2017
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
    
    [HUD setHidden:YES];
    
    float y_axis = self.view.frame.size.height - 120;
    
    NSString *mesg = [NSString stringWithFormat:@"%@",error];
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
}

// newly added on 24/05/2017  by Bhargav


/**
 * @description  handling the success response for GetModels...
 * @date         24/05/2017
 * @method       getModelSuccessResponse:
 * @author       Bhargav
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getModelSuccessResponse:(NSDictionary*)successDictionary {
    
    
    @try {
        
        
        [ModelListArray addObject:NSLocalizedString(@"all_models",nil)];

        
        for (NSDictionary * modelDic in [successDictionary valueForKey:MODEL_LIST]) {
            
            [ModelListArray addObject:modelDic];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
        
    }
}

/**
 * @description  handling the service call error resposne for GetModels....
 * @date         24/05/2017
 * @method       getModelErrorResponse:
 * @author       Bhargav
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getModelErrorResponse:(NSString *)errorResponse {
    
    [HUD setHidden:YES];
    
    float y_axis = self.view.frame.size.height - 120;
    
    NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
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

-(void)getWorkFlowsSuccessResponse:(NSDictionary *)successDictionary {
    
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
 * @description  Handling the Eror response for GetWorkFlows...
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        
    } @catch (NSException * exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
}

/**
 * @description  Handling the Success Response..
 * @date         21/12/2017
 * @method       getCategoriesByLocationSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
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
 * @description  Handling the error response...
 * @date         21/12/2017
 * @method       getCategoriesByLocationErrorResponse
 * @author       Bhargav.v
 * @param        NSString
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
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
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
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:--");
        NSLog(@"----exception while changing frame self.view---%@",exception);
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
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
}

/**
 * @description  here we are showing the complete stockRequest information in popUp.......
 * @date         19/09/2016
 * @method       showCompleteStockRequestInfo
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showCompleteStockRequestInfo:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
   
    PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 750, stockRequestSummaryInfoArr.count * 40 + 240)];
    customerView.opaque = NO;
    customerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customerView.layer.borderWidth = 2.0f;
    [customerView setHidden:NO];
    
    //creation on UIView......
    UIView *headerView = [[UIView alloc] init];
    
    //tableHeader......
    summaryLabel_1 = [[CustomLabel alloc] init];
    [summaryLabel_1 awakeFromNib];
    
    summaryLabel_2 = [[CustomLabel alloc] init];
    [summaryLabel_2 awakeFromNib];
    
    summaryLabel_3 = [[CustomLabel alloc] init];
    [summaryLabel_3 awakeFromNib];
    
    summaryLabel_4 = [[CustomLabel alloc] init];
    [summaryLabel_4 awakeFromNib];
    
    summaryLabel_5 = [[CustomLabel alloc] init];
    [summaryLabel_5 awakeFromNib];
    
    summaryLabel_6 = [[CustomLabel alloc] init];
    [summaryLabel_6 awakeFromNib];
    
    UILabel * totalQtyLbl;
    UILabel * totalEstCostLbl;

    totalQtyLbl= [[UILabel alloc] init];
    totalQtyLbl.backgroundColor = [UIColor clearColor];
    totalQtyLbl.textAlignment = NSTextAlignmentLeft;
    totalQtyLbl.numberOfLines = 2;
    totalQtyLbl.lineBreakMode = NSLineBreakByTruncatingTail;
    
    totalEstCostLbl= [[UILabel alloc] init];
    totalEstCostLbl.backgroundColor = [UIColor clearColor];
    totalEstCostLbl.textAlignment = NSTextAlignmentLeft;
    totalEstCostLbl.numberOfLines = 2;
    totalEstCostLbl.lineBreakMode = NSLineBreakByTruncatingTail;
    
    totalQtyValueLbl= [[UILabel alloc] init];
    totalQtyValueLbl.backgroundColor = [UIColor clearColor];
    totalQtyValueLbl.numberOfLines = 2;
    totalQtyValueLbl.lineBreakMode = NSLineBreakByTruncatingTail;
    
    totalEstCostValueLbl= [[UILabel alloc] init];
    totalEstCostValueLbl.backgroundColor = [UIColor clearColor];
    totalEstCostValueLbl.numberOfLines = 2;
    totalEstCostValueLbl.lineBreakMode = NSLineBreakByTruncatingTail;
    
    totalQtyLbl.textColor = [UIColor blackColor];
    totalEstCostLbl.textColor = [UIColor blackColor];
    
    totalQtyValueLbl.textColor = [UIColor blackColor];
    totalEstCostValueLbl.textColor = [UIColor blackColor];
    
    
    //UILabel creations.....
    UILabel *line_1 = [[UILabel alloc] init];
    UILabel *line_2 = [[UILabel alloc] init];
    
    UILabel *semi_colon_1 = [[UILabel alloc] init];
    UILabel *semi_colon_2 = [[UILabel alloc] init];
    
    semi_colon_1.textColor = [UIColor blackColor];
    semi_colon_2.textColor = [UIColor blackColor];
    
    totalQtyValueLbl.textAlignment = NSTextAlignmentRight;
    totalEstCostValueLbl.textAlignment = NSTextAlignmentRight;
    
    @try {
        
        summaryLabel_1.text = NSLocalizedString(@"s_no", nil);
        summaryLabel_2.text = NSLocalizedString(@"date", nil);
        summaryLabel_3.text = NSLocalizedString(@"avg_indent", nil);
        summaryLabel_4.text = NSLocalizedString(@"avg_sales", nil);
        summaryLabel_5.text = NSLocalizedString(@"avg_dump", nil);
        summaryLabel_6.text = NSLocalizedString(@"avg_return", nil);
        
        totalEstCostLbl.text = NSLocalizedString(@"totalEst_cost", nil);
        totalQtyLbl.text = NSLocalizedString(@"total_qty",nil);
        
        
        semi_colon_1.text = NSLocalizedString(@":", nil);
        semi_colon_2.text = NSLocalizedString(@":", nil);
        
        
        @try {
            if (summaryFieldsDic.count) {
                totalQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",[[self checkGivenValueIsNullOrNil:[summaryFieldsDic valueForKey:TOTAL_QTY] defaultReturn:@"0.00"] floatValue]];
                
                totalEstCostValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",[[self checkGivenValueIsNullOrNil:[summaryFieldsDic valueForKey:TOTAL_EST_COST] defaultReturn:@"0.00"] floatValue]];
            }
            
        } @catch (NSException *exception) {
            
        }
        
        summaryLabel_1.backgroundColor = [UIColor grayColor];
        summaryLabel_2.backgroundColor = [UIColor grayColor];
        summaryLabel_3.backgroundColor = [UIColor grayColor];
        summaryLabel_4.backgroundColor = [UIColor grayColor];
        summaryLabel_5.backgroundColor = [UIColor grayColor];
        summaryLabel_6.backgroundColor = [UIColor grayColor];
        
        line_1.backgroundColor = [UIColor blackColor];
        line_2.backgroundColor = [UIColor blackColor];
        
        
        [headerView addSubview:summaryLabel_1];
        [headerView addSubview:summaryLabel_2];
        [headerView addSubview:summaryLabel_3];
        [headerView addSubview:summaryLabel_4];
        [headerView addSubview:summaryLabel_5];
        [headerView addSubview:summaryLabel_6];
        
        [customerView addSubview:headerView];
        
        [customerView addSubview:stockRequestSummaryInfoTbl];
        
        [customerView addSubview:line_1];
        [customerView addSubview:line_2];
        [customerView addSubview:totalQtyLbl];
        [customerView addSubview:totalEstCostLbl];
        [customerView addSubview:semi_colon_1];
        [customerView addSubview:semi_colon_2];
        
        [customerView addSubview:totalQtyValueLbl];
        [customerView addSubview:totalEstCostValueLbl];
        
        //setting frame
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
            }
            else{
                
            }
            headerView.frame = CGRectMake( 5, 10, customerView.frame.size.width - 10, snoLbl.frame.size.height);
            
            summaryLabel_1.frame = CGRectMake( 0, 0, 60, snoLbl.frame.size.height);
            summaryLabel_2.frame = CGRectMake(summaryLabel_1.frame.origin.x + summaryLabel_1.frame.size.width + 2, 0, 120, summaryLabel_1.frame.size.height);
            summaryLabel_3.frame =CGRectMake( summaryLabel_2.frame.origin.x + summaryLabel_2.frame.size.width + 2, 0, 120, summaryLabel_1.frame.size.height);
            summaryLabel_4.frame =CGRectMake( summaryLabel_3.frame.origin.x + summaryLabel_3.frame.size.width + 2, 0, 120, summaryLabel_1.frame.size.height);
            summaryLabel_5.frame =CGRectMake( summaryLabel_4.frame.origin.x + summaryLabel_4.frame.size.width + 2, 0, 120, summaryLabel_1.frame.size.height);
            
            summaryLabel_6.frame =CGRectMake(summaryLabel_5.frame.origin.x + summaryLabel_5.frame.size.width + 2, 0, (headerView.frame.size.width - (summaryLabel_5.frame.origin.x + summaryLabel_5.frame.size.width + 2)), summaryLabel_1.frame.size.height);
            
            stockRequestSummaryInfoTbl.frame = CGRectMake( headerView.frame.origin.x, headerView.frame.origin.y + headerView.frame.size.height + 5, headerView.frame.size.width, stockRequestSummaryInfoArr.count* 40 + 5);
            
            //            stockRequestSummaryInfoTbl.frame = CGRectMake( headerView.frame.origin.x, headerView.frame.origin.y + headerView.frame.size.height + 5, headerView.frame.size.width, 100);
            
            line_1.frame = CGRectMake(summaryLabel_5.frame.origin.x,stockRequestSummaryInfoTbl.frame.origin.y + stockRequestSummaryInfoTbl.frame.size.height + 10,customerView.frame.size.width/2.5,  2);
            
            totalQtyLbl.frame =  CGRectMake( line_1.frame.origin.x, line_1.frame.origin.y + line_1.frame.size.height + 2, line_1.frame.size.width/2,  35);
            
            
            totalEstCostLbl.frame = CGRectMake( totalQtyLbl.frame.origin.x, totalQtyLbl.frame.origin.y + totalQtyLbl.frame.size.height + 2, totalQtyLbl.frame.size.width,  totalQtyLbl.frame.size.height);
            
            semi_colon_1.frame = CGRectMake(totalQtyLbl.frame.origin.x + totalQtyLbl.frame.size.width, totalQtyLbl.frame.origin.y, 5, totalQtyLbl.frame.size.height);
            
            
            semi_colon_2.frame = CGRectMake( totalEstCostLbl.frame.origin.x + totalEstCostLbl.frame.size.width, totalEstCostLbl.frame.origin.y,5, totalQtyLbl.frame.size.height);
            
            totalQtyValueLbl.frame =   CGRectMake( semi_colon_1.frame.origin.x + semi_colon_1.frame.size.width, totalQtyLbl.frame.origin.y,  line_1.frame.size.width - (totalQtyLbl.frame.size.width + semi_colon_1.frame.size.width),  summaryLabel_1.frame.size.height);
            
            
            totalEstCostValueLbl.frame =   CGRectMake( totalQtyValueLbl.frame.origin.x, totalEstCostLbl.frame.origin.y,  totalQtyValueLbl.frame.size.width,  summaryLabel_1.frame.size.height);
            
            line_2.frame = CGRectMake(line_1.frame.origin.x,totalEstCostLbl.frame.origin.y+totalEstCostLbl.frame.size.height+5,line_1.frame.size.width,line_1.frame.size.height);
            
            @try {
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:headerView andSubViews:YES fontSize:20.0 cornerRadius:0.0];
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:customerView andSubViews:YES fontSize:20.0 cornerRadius:0.0];
                
            } @catch (NSException *exception) {
                
                NSLog(@"----exception in the stockReceiptView in showCompleteStockRequestInfo:----%@",exception);
                
                NSLog(@"----exception in setting textFont----%@",exception);
            }
            
        }else{
            
        }
        
        customerInfoPopUp.view = customerView;
        
        //        self.navigationController?: .customerInfoPopUp?.backGroundColor =
        customerInfoPopUp.view.backgroundColor = [UIColor blueColor];
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customerView.frame.size.width, customerView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:summaryInfoBtn.frame inView:stockRequestView  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            //        popover= popover;
            
            //            self.navigationController?.popover?.backGroundColor =
            popover.backgroundColor = [UIColor lightGrayColor];
            
            //            CALayer *la = [popover layer];
            
        }
        
        else {
            
            //            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 260.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            // popover.contentViewController.view.alpha = 0.0;
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            popover = popover;
            
        }
        
        //        UIGraphicsBeginImageContext(customerView.frame.size);
        //        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customerView.bounds];
        //        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        //        customerView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        customerView.backgroundColor = [UIColor lightGrayColor];
        
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in showCompleteStockRequestInfo:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    } @finally {
        
        
        [stockRequestSummaryInfoTbl reloadData];
        
        [HUD setHidden:YES];
        
    }
    
}

#pragma mark Actions yet to implement...


/**
 * @description
 * @date
 * @method       saveAllButton
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)saveAllButton:(UIButton *)sender {
    
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
 * @description
 * @date
 * @method       gnerateIndentButton
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)gnerateIndentButton:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


/**
 * @description
 * @date
 * @method       cancelRequest
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)cancelRequest:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [self backAction];
        
    } @catch (NSException *exception) {
        
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

-(void)showPaginationData:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [HUD setHidden:YES];
        
        if(pagenationArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = pagenationArr.count *40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArr.count * 33;
        
        if(pagenationArr.count> 5)
            tableHeight = (tableHeight/pagenationArr.count) * 5;
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
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
        
        
        [self callingGetStockRequests];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
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
