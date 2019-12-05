
//  StockReceiptList.m
//  OmniRetailer
//  Created by Chandrasekhar on 12/2/16.


#import "OpenStockReceipt.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"
#import "MaterialTransferReciepts.h"
#import "EditStockReceipt.h"

@interface OpenStockReceipt ()

@end

@implementation OpenStockReceipt
int totalNoOfStockReceipts;


@synthesize soundFileURLRef,soundFileObject;
@synthesize isOpen,selectIndex,buttonSelectIndex,selectSectionIndex;
//@synthesize totalNoOfStockReceipts;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         21/09/2016
 * @method       ViewDidLoad
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 25/05/2017....
 * @reason       added commons and some new field and there functionality....
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {
    
    //calling super call method....
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //setting the background colour of the self.view....
    self.view.backgroundColor = [UIColor blackColor];
    
    //reading os version of the build installed device and storing....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    //setting sound from sound file....
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef)tapSound;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //creation of progress/processing bar and adding it to slef.navigationController....
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //creation of stockReceiptView....
    StockReceiptView = [[UIView alloc] init];
    StockReceiptView.backgroundColor = [UIColor blackColor];
    StockReceiptView.layer.borderWidth = 1.0f;
    StockReceiptView.layer.cornerRadius = 10.0f;
    StockReceiptView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
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

    /*Creation of UIButon used in this page*/
    UIImage * summaryInfoImg;
    UIButton * summaryInfoBtn;
    
    summaryInfoImg = [UIImage imageNamed:@"emails-letters.png"];
    
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [summaryInfoBtn setBackgroundImage:summaryInfoImg forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self
                       action:@selector(populateSumaryInfo:) forControlEvents:UIControlEventTouchDown];
    
//    summaryInfoBtn.hidden= YES;
    
    /*Creation of UITextField used in this page*/
    //used in first collum....
    outletIdTxt = [[CustomTextField alloc] init];
    outletIdTxt.delegate = self;
    outletIdTxt.placeholder = NSLocalizedString(@"from_outlets", nil);
    outletIdTxt.userInteractionEnabled  = NO;
    outletIdTxt.text = presentLocation;

    [outletIdTxt awakeFromNib];
    
    zoneIdTxt = [[CustomTextField alloc] init];
    zoneIdTxt.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneIdTxt.delegate = self;
    zoneIdTxt.userInteractionEnabled  = NO;
    [zoneIdTxt awakeFromNib];
    
    
    //used in second collum....
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.placeholder = NSLocalizedString(@"all_categories", nil);
    categoryTxt.userInteractionEnabled  = NO;
    categoryTxt.delegate = self;
    [categoryTxt awakeFromNib];
    
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.placeholder = NSLocalizedString(@"all_subcategories", nil);
    subCategoryTxt.userInteractionEnabled  = NO;
    subCategoryTxt.delegate = self;
    [subCategoryTxt awakeFromNib];
    
    //used in third collum....
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
    
    //used in fourth collum....
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDateTxt.userInteractionEnabled = NO;
    startDateTxt.delegate = self;
    [startDateTxt awakeFromNib];
    
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.userInteractionEnabled = NO;
    endDateTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDateTxt.delegate = self;
    [endDateTxt awakeFromNib];
    
    //used in fifth column....
    
    statusTxt = [[CustomTextField alloc] init];
    statusTxt.placeholder = NSLocalizedString(@"select_status", nil);
    statusTxt.userInteractionEnabled = NO;
    statusTxt.delegate = self;
    [statusTxt awakeFromNib];

    toOutletsTxt = [[CustomTextField alloc] init];
    toOutletsTxt.placeholder = NSLocalizedString(@"select_to_outlets", nil);
    toOutletsTxt.userInteractionEnabled = NO;
    toOutletsTxt.delegate = self;
    [toOutletsTxt awakeFromNib];
    
    /*Creation of UIImage used for buttons*/
    
    UIImage * buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];
    UIImage * buttonImage = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    /*UIButton used for dropdown and popUps*/
    UIButton * outletIdBtn;
    UIButton * zoneIdBtn;
  
    UIButton * categoryBtn;
    UIButton * subCatBtn;

    UIButton * brandBtn;
    UIButton * modelBtn;
    
    UIButton * showStartDateBtn;
    UIButton * showEndDateBtn;
    
    UIButton * statusBtn;
    UIButton * toLocatonBtn;
    
    outletIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outletIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [outletIdBtn addTarget:self
                    action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];
    
    zoneIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoneIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [zoneIdBtn addTarget:self
                  action:@selector(showAllZonesId:) forControlEvents:UIControlEventTouchDown];
    zoneIdBtn.hidden = YES;
    
    categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [categoryBtn addTarget:self
                    action:@selector(showAllCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    brandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [brandBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [brandBtn addTarget:self
                 action:@selector(showListOfBrands:) forControlEvents:UIControlEventTouchDown];
    
    modelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modelBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [modelBtn addTarget:self
                 action:@selector(showListOfModels:) forControlEvents:UIControlEventTouchDown];
    
    
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
    
    statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [statusBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [statusBtn addTarget:self action:@selector(showWorkFlowStatus:) forControlEvents:UIControlEventTouchDown];
     

    toLocatonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toLocatonBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
 
    [toLocatonBtn addTarget:self action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];

    @try {
        
        if (isHubLevel) {
            zoneIdTxt.text = zoneID;
            [StockReceiptView addSubview:outletIdBtn];
        }
        else
            zoneIdTxt.text = zoneID;
        
    } @catch (NSException *exception) {
        
    }
    
    UIButton * clearBtn;
    
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.tag = 2;
    
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    receiptIdTxt = [[UITextField alloc] init];
    receiptIdTxt.borderStyle = UITextBorderStyleRoundedRect;
    receiptIdTxt.textColor = [UIColor blackColor];
    receiptIdTxt.font = [UIFont systemFontOfSize:18.0];
    receiptIdTxt.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
    receiptIdTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    receiptIdTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    receiptIdTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    receiptIdTxt.textAlignment = NSTextAlignmentCenter;
    receiptIdTxt.delegate = self;
    receiptIdTxt.placeholder = NSLocalizedString(@"search_receipt_id", nil);
    
    [receiptIdTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //creation of UIScrollView....
    stockReceiptScrollView = [[UIScrollView alloc]init];
    //stockReceiptScrollView.backgroundColor = [UIColor lightGrayColor];
    
    //creation of header labels:
    
    sNoLbl = [[CustomLabel alloc] init];
    [sNoLbl awakeFromNib];
    
    RefNoLbl = [[CustomLabel alloc] init];
    [RefNoLbl awakeFromNib];
    
    dateLbl = [[CustomLabel alloc] init];
    [dateLbl awakeFromNib];

    issuedByLbl = [[CustomLabel alloc] init];
    [issuedByLbl awakeFromNib];
    
    receivedByLbl = [[CustomLabel alloc] init];
    [receivedByLbl awakeFromNib];
    
    requestedQtyLbl = [[CustomLabel alloc] init];
    [requestedQtyLbl awakeFromNib];
    
    issuedQtyLbl = [[CustomLabel alloc] init];
    [issuedQtyLbl awakeFromNib];

    weightedQtyLbl = [[CustomLabel alloc] init];
    [weightedQtyLbl awakeFromNib];
    
    receivedQtyLbl = [[CustomLabel alloc] init];
    [receivedQtyLbl awakeFromNib];


    statusLbl = [[CustomLabel alloc] init];
    [statusLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];

    
    StockReceiptTbl = [[UITableView alloc] init];
    StockReceiptTbl.dataSource = self;
    StockReceiptTbl.delegate = self;
    StockReceiptTbl.backgroundColor = [UIColor clearColor];
    StockReceiptTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UILabel * pagesLbl;
    UIButton * dropDownBtn;
    UIButton * goButton;

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
    
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [dropDownBtn addTarget:self action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    
    //creating the UIButton which are used to show CustomerInfo popUp.......
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressed:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];

    UILabel * totalNoOfItemsLbl;
    UILabel * totalItemsQtyLbl;
    
    totalNoOfItemsLbl = [[UILabel alloc] init];
    totalNoOfItemsLbl.layer.masksToBounds = YES;
    totalNoOfItemsLbl.numberOfLines = 2;
    totalNoOfItemsLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    totalNoOfItemsValueLbl = [[UILabel alloc] init];
    totalNoOfItemsValueLbl.layer.masksToBounds = YES;
    totalNoOfItemsValueLbl.numberOfLines = 2;
    totalNoOfItemsValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    totalItemsQtyLbl = [[UILabel alloc] init];
    totalItemsQtyLbl.layer.masksToBounds = YES;
    totalItemsQtyLbl.numberOfLines = 2;
    totalItemsQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    totalItemsQtyValueLbl = [[UILabel alloc] init];
    totalItemsQtyValueLbl.layer.masksToBounds = YES;
    totalItemsQtyValueLbl.numberOfLines = 2;
    totalItemsQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    totalItemsQtyLbl.textAlignment = NSTextAlignmentLeft;
    totalNoOfItemsLbl.textAlignment = NSTextAlignmentLeft;
    
    totalItemsQtyValueLbl.textAlignment = NSTextAlignmentRight;
    totalNoOfItemsValueLbl.textAlignment = NSTextAlignmentRight;
    
    
    //Allocation of UIView....
    
    totalInventoryView = [[UIView alloc]init];
    totalInventoryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalInventoryView.layer.borderWidth =3.0f;

    
    /*RequestedItemsTbl Header*/
    requestedItemsTblHeaderView = [[UIView alloc] init];
//    requestedItemsTblHeaderView.backgroundColor = [UIColor lightGrayColor];
    
    /*Creation of the UILabels*/
    itemNoLbl = [[CustomLabel alloc] init];
    [itemNoLbl awakeFromNib];
    
    itemCodeLbl = [[CustomLabel alloc] init];
    [itemCodeLbl awakeFromNib];

    itemNameLbl = [[CustomLabel alloc] init];
    [itemNameLbl awakeFromNib];

    itemGradeLbl = [[CustomLabel alloc] init];
    [itemGradeLbl awakeFromNib];

    itemReqstQtyLbl = [[CustomLabel alloc] init];
    [itemReqstQtyLbl awakeFromNib];
    
    itemIssueQtyLbl = [[CustomLabel alloc] init];
    [itemIssueQtyLbl awakeFromNib];

    
    
    [requestedItemsTblHeaderView addSubview:itemNoLbl];
    [requestedItemsTblHeaderView addSubview:itemCodeLbl];
    [requestedItemsTblHeaderView addSubview:itemNameLbl];
    [requestedItemsTblHeaderView addSubview:itemGradeLbl];
    [requestedItemsTblHeaderView addSubview:itemReqstQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemIssueQtyLbl];

    //table's used in popUp's.......
    //locationTbl creation...
    locationTbl = [[UITableView alloc] init];
    locationTbl.layer.borderWidth = 1.0;
    locationTbl.layer.cornerRadius = 4.0;
    locationTbl.layer.borderColor = [UIColor blackColor].CGColor;
    locationTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    locationTbl.dataSource = self;
    locationTbl.delegate = self;
    
    
    //categoriesListTbl creation...
    categoriesListTbl = [[UITableView alloc] init];
    categoriesListTbl.layer.borderWidth = 1.0;
    categoriesListTbl.layer.cornerRadius = 4.0;
    categoriesListTbl.layer.borderColor = [UIColor blackColor].CGColor;
    categoriesListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    categoriesListTbl.dataSource = self;
    categoriesListTbl.delegate = self;
    
    //subCategoriesListTbl creation...
    subCategoriesListTbl = [[UITableView alloc] init];
    subCategoriesListTbl.layer.borderWidth = 1.0;
    subCategoriesListTbl.layer.cornerRadius = 4.0;
    subCategoriesListTbl.layer.borderColor = [UIColor blackColor].CGColor;
    subCategoriesListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    subCategoriesListTbl.dataSource = self;
    subCategoriesListTbl.delegate = self;
    
    //brandListTbl creation...
    brandListTbl = [[UITableView alloc] init];
    brandListTbl.layer.borderWidth = 1.0;
    brandListTbl.layer.cornerRadius = 4.0;
    brandListTbl.layer.borderColor = [UIColor blackColor].CGColor;
    brandListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    brandListTbl.dataSource = self;
    brandListTbl.delegate = self;
    
    //modelListTbl creation...
    modelListTbl = [[UITableView alloc] init];
    modelListTbl.layer.borderWidth = 1.0;
    modelListTbl.layer.cornerRadius = 4.0;
    modelListTbl.layer.borderColor = [UIColor blackColor].CGColor;
    modelListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    modelListTbl.dataSource = self;
    modelListTbl.delegate = self;
    
    //workFlowListTbl creation...
    workFlowListTbl = [[UITableView alloc] init];
    workFlowListTbl.layer.borderWidth = 1.0;
    workFlowListTbl.layer.cornerRadius = 4.0;
    workFlowListTbl.layer.borderColor = [UIColor blackColor].CGColor;
    workFlowListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    workFlowListTbl.dataSource = self;
    workFlowListTbl.delegate = self;
    
    //workFlowListTbl creation...
    pagenationTbl = [[UITableView alloc] init];
    pagenationTbl.layer.borderWidth = 1.0;
    pagenationTbl.layer.cornerRadius = 4.0;
    pagenationTbl.layer.borderColor = [UIColor blackColor].CGColor;
    pagenationTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    pagenationTbl.dataSource = self;
    pagenationTbl.delegate = self;
    
    // upto here on 30/06/2017....
    // Used to display the grid level items....
    
    requestedItemsTbl = [[UITableView alloc] init];
    requestedItemsTbl.dataSource = self;
    requestedItemsTbl.delegate = self;
    requestedItemsTbl.backgroundColor = [UIColor clearColor];
    requestedItemsTbl.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    searchBtn.tag  = 4;
    //added by Srinivasulu on 25/05/2017....
    @try {
        //populating the text into textField / labels....
        
        //setting the titleLabel text in this view....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        headerNameLbl.text = NSLocalizedString(@"stock_receipt_c", nil);
        
        //setting titletext for the hud....
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        
        //setting font to UIButtons....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
        
        //setting font to UILables used as table headers....
        sNoLbl.text = NSLocalizedString(@"s_no", nil);
        RefNoLbl.text = NSLocalizedString(@"ref_no", nil);
        dateLbl.text = NSLocalizedString(@"date", nil);
        receivedByLbl.text = NSLocalizedString(@"received_by", nil);
        requestedQtyLbl.text = NSLocalizedString(@"req_qty", nil);
        receivedQtyLbl.text = NSLocalizedString(@"recevd_qty", nil);
        statusLbl.text = NSLocalizedString(@"status", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        //added by Srinivasulu on 26/05/2017....
        issuedByLbl.text = NSLocalizedString(@"issued_by", nil);
        issuedQtyLbl.text = NSLocalizedString(@"issued_qty", nil);
        weightedQtyLbl.text = NSLocalizedString(@"weigh_qty", nil);
        
        pagesLbl.text = NSLocalizedString(@"pages",nil);

        //upto here on 26/04/2017...
        
        totalNoOfItemsLbl.text = NSLocalizedString(@"total_items", nil);
        totalItemsQtyLbl.text = NSLocalizedString(@"total_Qty", nil);
        totalNoOfItemsValueLbl.text = NSLocalizedString(@"0_00", nil);
        totalItemsQtyValueLbl.text = NSLocalizedString(@"0_00", nil);
      
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
        
        //grid Level labels localisable strings...
        itemNoLbl.text = NSLocalizedString(@"s_no", nil);
        itemCodeLbl.text = NSLocalizedString(@"item_code", nil);
        itemNameLbl.text = NSLocalizedString(@"item_name", nil);
        itemGradeLbl.text = NSLocalizedString(@"grade", nil);
        itemReqstQtyLbl.text = NSLocalizedString(@"req_qty", nil);
        itemIssueQtyLbl.text = NSLocalizedString(@"issued_qty", nil);

        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    //added summarybutton as subView....
    [StockReceiptView addSubview:headerNameLbl];

    [StockReceiptView addSubview:summaryInfoBtn];
    
    //adding first row fields....
    [StockReceiptView addSubview:zoneIdTxt];
    [StockReceiptView addSubview:outletIdTxt];
    
    //used in second row....
    [StockReceiptView addSubview:categoryTxt];
    [StockReceiptView addSubview:subCategoryTxt];
    
    //used in the third row....
    [StockReceiptView addSubview:brandTxt];
    [StockReceiptView addSubview:modelTxt];
    
    //usedin the fourth row....
    [StockReceiptView addSubview:startDateTxt];
    [StockReceiptView addSubview:endDateTxt];
    
    //used in the fifth row...
    
    [StockReceiptView addSubview:statusTxt];
    [StockReceiptView addSubview:toOutletsTxt];
    
    [StockReceiptView addSubview:zoneIdBtn];
  
    [StockReceiptView addSubview:showStartDateBtn];
    [StockReceiptView addSubview:showEndDateBtn];
  
    [StockReceiptView addSubview:categoryBtn];
    [StockReceiptView addSubview:subCatBtn];
  
    [StockReceiptView addSubview:brandBtn];
    [StockReceiptView addSubview:modelBtn];
   
    [StockReceiptView addSubview:statusBtn];
    [StockReceiptView addSubview:toLocatonBtn];

    //adding UIButton's as subView's....
    [StockReceiptView addSubview:searchBtn];
    [StockReceiptView addSubview:clearBtn];
    
    [StockReceiptView addSubview:receiptIdTxt];
    
    [StockReceiptView addSubview:stockReceiptScrollView];
    
    [stockReceiptScrollView addSubview:sNoLbl];
    [stockReceiptScrollView addSubview:RefNoLbl];
    
    [stockReceiptScrollView addSubview:dateLbl];
    [stockReceiptScrollView addSubview:receivedByLbl];
    
    [stockReceiptScrollView addSubview:requestedQtyLbl];
    [stockReceiptScrollView addSubview:receivedQtyLbl];
    
    [stockReceiptScrollView addSubview:statusLbl];
    [stockReceiptScrollView addSubview:actionLbl];
    
    //added by Srinivasulu on 26/05/2017....
    
    [stockReceiptScrollView addSubview:issuedByLbl];
    [stockReceiptScrollView addSubview:issuedQtyLbl];
    [stockReceiptScrollView addSubview:weightedQtyLbl];
    
    [stockReceiptScrollView addSubview:StockReceiptTbl];
    
    //upto here on 26/04/2017...
    
    [StockReceiptView addSubview:pagesLbl];
    [StockReceiptView addSubview:pagenationTxt];
    [StockReceiptView addSubview:dropDownBtn];
    [StockReceiptView addSubview:goButton];
    
    [StockReceiptView addSubview:totalInventoryView];
    
    [totalInventoryView addSubview:totalNoOfItemsLbl];
    [totalInventoryView addSubview:totalItemsQtyLbl];
    [totalInventoryView addSubview:totalNoOfItemsValueLbl];
    [totalInventoryView addSubview:totalItemsQtyValueLbl];
    
    [self.view addSubview:StockReceiptView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
        }
        else{
        }
        
        //setting for the stockReceiptView....
        StockReceiptView.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        
        headerNameLbl.frame = CGRectMake(0,0,StockReceiptView.frame.size.width,45);
        
        //seting frame for summaryInfoBtn....
         summaryInfoBtn.frame = CGRectMake(StockReceiptView.frame.size.width - 45,headerNameLbl.frame.origin.y,50,50);

        //setting first column....
        zoneIdTxt.frame = CGRectMake(StockReceiptView.frame.origin.x+10,summaryInfoBtn.frame.origin.y + summaryInfoBtn.frame.size.height+10,150,40);
        
        outletIdTxt.frame = CGRectMake( zoneIdTxt.frame.origin.x, zoneIdTxt.frame.origin.y + zoneIdTxt.frame.size.height + 10, zoneIdTxt.frame.size.width, zoneIdTxt.frame.size.height);
        
        //setting second column....
        categoryTxt.frame = CGRectMake( outletIdTxt.frame.origin.x + outletIdTxt.frame.size.width + 15, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        subCategoryTxt.frame = CGRectMake( categoryTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        //setting third column....
        brandTxt.frame = CGRectMake( categoryTxt.frame.origin.x + categoryTxt.frame.size.width + 15, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        modelTxt.frame = CGRectMake( brandTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        //setting fourth column....
        startDateTxt.frame = CGRectMake( brandTxt.frame.origin.x + brandTxt.frame.size.width + 15, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        endDateTxt.frame = CGRectMake( startDateTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        statusTxt.frame = CGRectMake(startDateTxt.frame.origin.x+startDateTxt.frame.size.width+15,startDateTxt.frame.origin.y,startDateTxt.frame.size.width,startDateTxt.frame.size.height);
        
        toOutletsTxt.frame = CGRectMake(statusTxt.frame.origin.x, endDateTxt.frame.origin.y,statusTxt.frame.size.width, statusTxt.frame.size.height);
        
        
        //setting frames for UIButtons....
        outletIdBtn.frame = CGRectMake( (outletIdTxt.frame.origin.x + outletIdTxt.frame.size.width - 45), outletIdTxt.frame.origin.y - 8,  55, 60);
        zoneIdBtn.frame = CGRectMake( (zoneIdTxt.frame.origin.x + zoneIdTxt.frame.size.width - 45), zoneIdTxt.frame.origin.y - 8,  55, 60);
        
        //setting for second column row....
        categoryBtn.frame = CGRectMake( (categoryTxt.frame.origin.x + categoryTxt.frame.size.width - 45), categoryTxt.frame.origin.y - 8,  55, 60);
        subCatBtn.frame = CGRectMake( (subCategoryTxt.frame.origin.x + subCategoryTxt.frame.size.width - 45), subCategoryTxt.frame.origin.y - 8,  55, 60);
        
        
        //setting for third column row....
        brandBtn.frame = CGRectMake( (brandTxt.frame.origin.x + brandTxt.frame.size.width - 45), brandTxt.frame.origin.y - 8,55,60);
        modelBtn.frame = CGRectMake( (modelTxt.frame.origin.x + modelTxt.frame.size.width - 45), modelTxt.frame.origin.y - 8,55, 60);
        
        //setting for fourth column row....
        showStartDateBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-40), startDateTxt.frame.origin.y+5,35,30);
        
        showEndDateBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-40), endDateTxt.frame.origin.y+5,35,30);
        
        statusBtn.frame = CGRectMake((statusTxt.frame.origin.x + statusTxt.frame.size.width - 45), statusTxt.frame.origin.y - 8,55,60);
        
        toLocatonBtn.frame = CGRectMake((toOutletsTxt.frame.origin.x + toOutletsTxt.frame.size.width - 45), toOutletsTxt.frame.origin.y - 8,  55, 60);
        
        //setting for the search field....
        receiptIdTxt.frame = CGRectMake(zoneIdTxt.frame.origin.x, endDateTxt.frame.origin.y + endDateTxt.frame.size.height +10, StockReceiptView.frame.size.width-20,40);
        
        //setting for fifth column row....
        searchBtn.frame = CGRectMake((( receiptIdTxt.frame.origin.x + receiptIdTxt.frame.size.width) - 150), categoryTxt.frame.origin.y,150,40);
        
        clearBtn.frame = CGRectMake(  searchBtn.frame.origin.x, subCategoryTxt.frame.origin.y, searchBtn.frame.size.width, searchBtn.frame.size.height);

        stockReceiptScrollView.frame = CGRectMake(receiptIdTxt.frame.origin.x, receiptIdTxt.frame.origin.y + receiptIdTxt.frame.size.height +5, receiptIdTxt.frame.size.width+30,420);
        
        //Frame for the UILables....
        sNoLbl.frame = CGRectMake(0,0,40,35);
        
        RefNoLbl.frame = CGRectMake((sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 215, 35);
        
        dateLbl.frame = CGRectMake((RefNoLbl.frame.origin.x + RefNoLbl.frame.size.width + 2), RefNoLbl.frame.origin.y, 90, 35);
        
        issuedByLbl.frame = CGRectMake((dateLbl.frame.origin.x + dateLbl.frame.size.width + 2), dateLbl.frame.origin.y, 80, 35);
        
        receivedByLbl.frame = CGRectMake((issuedByLbl.frame.origin.x + issuedByLbl.frame.size.width + 2), dateLbl.frame.origin.y, 75, 35);
        
        requestedQtyLbl.frame = CGRectMake((receivedByLbl.frame.origin.x + receivedByLbl.frame.size.width + 2), receivedByLbl.frame.origin.y, 70, 35);
        
        issuedQtyLbl.frame = CGRectMake((requestedQtyLbl.frame.origin.x + requestedQtyLbl.frame.size.width + 2), requestedQtyLbl.frame.origin.y, 90, 35);
        
        weightedQtyLbl.frame = CGRectMake((issuedQtyLbl.frame.origin.x + issuedQtyLbl.frame.size.width + 2), requestedQtyLbl.frame.origin.y, 85, 35);
        
        receivedQtyLbl.frame = CGRectMake((weightedQtyLbl.frame.origin.x+weightedQtyLbl.frame.size.width + 2), requestedQtyLbl.frame.origin.y,95,35);
        
        statusLbl.frame = CGRectMake((receivedQtyLbl.frame.origin.x+receivedQtyLbl.frame.size.width+2), receivedQtyLbl.frame.origin.y,80,35);
        
        actionLbl.frame = CGRectMake((statusLbl.frame.origin.x + statusLbl.frame.size.width + 2), statusLbl.frame.origin.y, 60, 35);
        
        StockReceiptTbl.frame = CGRectMake(0,sNoLbl.frame.origin.y + sNoLbl.frame.size.height + 5,actionLbl.frame.origin.x+actionLbl.frame.size.width+30, stockReceiptScrollView.frame.size.height-(sNoLbl.frame.origin.y + sNoLbl.frame.size.height));
        
        
        pagesLbl.frame = CGRectMake(outletIdTxt.frame.origin.x, StockReceiptView.frame.size.height - 45,100,40);
        
        pagenationTxt.frame = CGRectMake(pagesLbl.frame.origin.x+pagesLbl.frame.size.width-20, pagesLbl.frame.origin.y,90,40);
        
        dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width-45), pagenationTxt.frame.origin.y-5, 45, 50);
        
        goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width+15,pagenationTxt.frame.origin.y,80, 40);
        
        
        totalInventoryView.frame = CGRectMake(receiptIdTxt.frame.origin.x + receiptIdTxt.frame.size.width-270,pagesLbl.frame.origin.y-18,270,60);
        
        totalNoOfItemsLbl.frame =  CGRectMake(5,0,170,40);
        
        totalItemsQtyLbl.frame =  CGRectMake(totalNoOfItemsLbl.frame.origin.x,totalNoOfItemsLbl.frame.origin.y + totalNoOfItemsLbl.frame.size.height-15,180,40);
        
        totalNoOfItemsValueLbl.frame =  CGRectMake(totalNoOfItemsLbl.frame.origin.x+ totalNoOfItemsLbl.frame.size.width, totalNoOfItemsLbl.frame.origin.y,90,40);
        
        totalItemsQtyValueLbl.frame =  CGRectMake(totalNoOfItemsValueLbl.frame.origin.x,totalItemsQtyLbl.frame.origin.y,totalNoOfItemsValueLbl.frame.size.width,40);
        
        // frames For Header view under the stock Request Table
        
        requestedItemsTblHeaderView.frame = CGRectMake(sNoLbl.frame.origin.x,10,receiptIdTxt.frame.size.width, sNoLbl.frame.size.height);
        
        itemNoLbl.frame = CGRectMake(RefNoLbl.frame.origin.x,0,70,30);
        
        itemCodeLbl.frame = CGRectMake(itemNoLbl.frame.origin.x + itemNoLbl.frame.size.width + 2, 0, 140, itemNoLbl.frame.size.height);
        
        itemNameLbl.frame = CGRectMake(itemCodeLbl.frame.origin.x + itemCodeLbl.frame.size.width + 2, 0, 160, itemNoLbl.frame.size.height);
        
        itemGradeLbl.frame = CGRectMake(itemNameLbl.frame.origin.x + itemNameLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);
        
        itemReqstQtyLbl.frame = CGRectMake(itemGradeLbl.frame.origin.x + itemGradeLbl.frame.size.width + 2, 0, 100, itemGradeLbl.frame.size.height);
        
        itemIssueQtyLbl.frame = CGRectMake(itemReqstQtyLbl.frame.origin.x + itemReqstQtyLbl.frame.size.width + 2,0, 100,itemReqstQtyLbl.frame.size.height);
        
        @try {
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:requestedItemsTblHeaderView andSubViews:YES fontSize:16.0f cornerRadius:0];
            
            headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
        } @catch (NSException *exception) {
            
        }
    }
    else{
        
        //Need to design for iphone....
    }
    
    
    //used for identification propous....
    
    outletIdBtn.tag = 1;
    toLocatonBtn.tag = 2;
    
    showStartDateBtn.tag = 2;
    showEndDateBtn.tag = 4;

    
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

-(void)viewDidAppear:(BOOL)animated {
    
    @try {
        
        [HUD setHidden:NO];
        
        startIndexint = 0;
        stockReceiptsArr = [NSMutableArray new];
        
        [self callingStockReceipts];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
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


- (void) viewWillAppear:(BOOL)animated {
    
    //calling the superClass method.......
    [super viewWillAppear:YES];
    
    
    
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

#pragma -mark actions used in this page to navigate to other classes....


/**
 * @description  here we are navigation from current page to NewStockRequest.......
 * @date         26/09/2016
 * @method       openViewStockRequestInDetail;
 * @author       Bhargav Ram
 * @param        NSString
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


-(void)newStockReceipt:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
            MaterialTransferReciepts * materialTransfer = [[MaterialTransferReciepts alloc] init];
            
            BOOL isDraft = false;
            
            if(stockReceiptsArr.count > sender.tag) {
                
                NSString * DraftStr;
                DraftStr  = [stockReceiptsArr[sender.tag] valueForKey:STATUS];
                
                if ([DraftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
                    
                    isDraft = true;
                }
            }
            
            if(isDraft){
                
                materialTransfer.receiptId = [stockReceiptsArr[sender.tag] valueForKey:kGoodsReceiptRef];
                [self.navigationController pushViewController:materialTransfer animated:YES];
            }
            else {
                
                [self.navigationController pushViewController:materialTransfer animated:YES];
            }
        
    }
    @catch (NSException *exception) {
        
    }
}


/**
 * @description  here we are navigation from current page to ViewStockRequest.......
 * @date         26/09/2016
 * @method       stockRequestDetailsView;
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 * @return
 * @return
 * @verified By
 * @verified On
 */

-(void)editStockReceipt:(UIButton*)sender {
    @try {
        // Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        
//        BOOL isDraft = false;
//
//        MaterialTransferReciepts * materialTransfer = [[MaterialTransferReciepts alloc] init];
//
//        if([stockReceiptsArr count] > sender.tag) {
//
//            NSString * DraftStr;
//            DraftStr  = [[stockReceiptsArr objectAtIndex:sender.tag] valueForKey:STATUS];
//
//            if ([DraftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
//
//                isDraft = true;
//            }
//        }
//
//        if(isDraft) {
//
//            materialTransfer.receiptId = [[stockReceiptsArr objectAtIndex:sender.tag] valueForKey:kGoodsReceiptRef];
//            [self.navigationController pushViewController:materialTransfer animated:YES];
//        }
//
//        else {
        
            EditStockReceipt * viewStockReceipt = [[EditStockReceipt alloc] init];
            viewStockReceipt.receiptId = [stockReceiptsArr[sender.tag] valueForKey:kGoodsReceiptRef];
            
            [self.navigationController pushViewController:viewStockReceipt animated:YES];

//}
        
        
    }
    @catch (NSException *exception) {
        
    }
}

#pragma mark Text Field Delegates


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
    
    if (textField == receiptIdTxt ) {
        
        if ((textField.text).length >= 4) {
            
            @try {
                
                startIndexint = 0;
                stockReceiptsArr = [NSMutableArray new];
                [self callingStockReceipts];
                
            } @catch (NSException *exception) {
                NSLog(@"---- exception while calling ServicesCall ----%@",exception);
                
            }
            
        }
        
    }
    
}


#pragma -mark action used in this page

/**
 * @description  here we are showing the calender in popUp view.......
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
            
            pickView.frame = CGRectMake(15, startDateTxt.frame.origin.y+startDateTxt.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
    } @finally {
        
    }
    
}


/**
 * @description  here we are showing the calender in popUp view.......
 * @date         26/09/2016
 * @method       populateDateToTextField:
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
        //[f release];
        today = [f dateFromString:currentdate];
        
        if( [today compare:selectedDateString] == NSOrderedAscending ){
            
            [self displayAlertMessage:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
            
        }
        
        NSDate *existingDateString;
        
        
        if( sender.tag == 2){
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])) {
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                }
            }
            
            startDateTxt.text = dateString;
            
        }
        else{
            
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
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

/**
 * @description  here we are clearing the dateFields....
 * @date         30/05/2017...
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
            if((startDateTxt.text).length)
                
                
                startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                
                endDateTxt.text = @"";
        }
        
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
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

-(void)goButtonPressed:(UIButton *)sender {
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self callingStockReceipts];
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
    
    if (tableView == StockReceiptTbl) {
        if (stockReceiptsArr.count)
            
            return stockReceiptsArr.count;
        else
            return 1;
    }
    return 1;
}



/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date         26/09/2016
 * @method       tableView: numberOfRowsInSection:
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
    
    if(tableView == StockReceiptTbl){
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
        
        return categoriesListArr.count;
    }
    else if(tableView == subCategoriesListTbl){
        
        return subCategoriesListArr.count;
    }
    else if(tableView == brandListTbl){
        
        return brandListArray.count;
        
    }
    else if(tableView == modelListTbl){
        
        return ModelListArray.count;
        
    }
    else if(tableView == workFlowListTbl){
        
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

    if(tableView == StockReceiptTbl){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (indexPath.row == 0) {
                return 38;
            }
            else{
                if (requestedItemsInfoArr.count > 4 ) {
                    return (40 * 4) + 30;
                }
                //                return (([requestedItemsInfoArr count] + 1) * 40) + 30;
                return (requestedItemsInfoArr.count * 40) + 70;
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
    
    else if(tableView == requestedItemsTbl || tableView == locationTbl || tableView == categoriesListTbl||tableView == subCategoriesListTbl || tableView == brandListTbl || tableView == modelListTbl ||tableView == workFlowListTbl || tableView == pagenationTbl  ){
        
        return 40;
    }

    return 0;
}

/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: willDisplayCell: forRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @param        NSIndexPath
 * @return       void
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section  & changed the cell returning....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    @try {
//
//        if(tableView == StockReceiptTbl){
//
//            @try {
//
//                if((indexPath.section == ([stockReceiptsArr count] - 1))&&([stockReceiptsArr count] < totalNoOfStockReceipts)&&([stockReceiptsArr count]>startIndexint )){
//                    [HUD show:YES];
//                    [HUD setHidden:NO];
//                    startIndexint = startIndexint +10;
//                    [self callingStockReceipts];
//                    [StockReceiptTbl reloadData];
//                }
//
//            } @catch (NSException *exception) {
//                NSLog(@"--exception in servicecall-----%@",exception);
//                [HUD setHidden:YES];
//            }
//        }
//    } @catch (NSException * exception) {
//
//    }
//}

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
    
    if (tableView == StockReceiptTbl) {
        
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
            
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
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
                
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:10];
            }
            hlcell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            
            [hlcell.contentView addSubview:requestedItemsTblHeaderView];
            [hlcell.contentView addSubview:requestedItemsTbl];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (requestedItemsInfoArr.count >4) {
                    
                    hlcell.frame = CGRectMake(StockReceiptTbl.frame.origin.x,0,StockReceiptTbl.frame.size.width,  40 * 4 +50);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x, 10,requestedItemsTblHeaderView.frame.size.width,requestedItemsTblHeaderView.frame.size.height);
                    
                    requestedItemsTbl.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height+5,  requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height - 80);
                }
                else{
                    
                    hlcell.frame = CGRectMake(StockReceiptTbl.frame.origin.x,0,StockReceiptTbl.frame.size.width,  (40 *(requestedItemsInfoArr.count + 2))+50);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x, 10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    requestedItemsTbl.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height + 5,  requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height -120);
                }
            }
            else {
                
                if (requestedItemsInfoArr.count >4) {
                    hlcell.frame = CGRectMake( 15, 0,StockReceiptTbl.frame.size.width - 15,  30*4);
                    requestedItemsTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, hlcell.frame.size.height);
                }
                else{
                    hlcell.frame = CGRectMake( 25, 0,StockReceiptTbl.frame.size.width - 25,  requestedItemsInfoArr.count*30);
                    requestedItemsTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, requestedItemsInfoArr.count*30);
                }
            }
            [requestedItemsTbl reloadData];
            
            hlcell.backgroundColor = [UIColor clearColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        
        else {
            UITableViewCell * hlcell;
            
            @try {
                
                static NSString * hlCellID = @"hlCellID";
                
                hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
                
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
                        
                        layer_1.frame = CGRectMake(sNoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(sNoLbl.frame.origin.x),1);
                        
                        [hlcell.contentView.layer addSublayer:layer_1];
                        
                    } @catch (NSException *exception) {
                        
                    }
                }
                tableView.separatorColor = [UIColor clearColor];
                
                UILabel * s_no_Lbl;
                UILabel * refrence_Lbl;
                UILabel * receipt_date_Lbl;
                UILabel * receivedBy_Lbl;
                UILabel * requested_Qty_Lbl;
                UILabel * received_Total_Qty_Lbl;
                UILabel * status_Lbl;
                UILabel * action_Lbl;
                
                //added by Srinivasulu on 26/05/2017....
                UILabel * issued_By_Lbl;
                UILabel * issued_Qty_Lbl;
                UILabel * weighted_Qty_Lbl;
                
                //upto here on 26/04/2017...
                
                s_no_Lbl = [[UILabel alloc] init];
                s_no_Lbl.backgroundColor = [UIColor clearColor];
                s_no_Lbl.textAlignment = NSTextAlignmentCenter;
                s_no_Lbl.numberOfLines = 1;
                s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                refrence_Lbl = [[UILabel alloc] init];
                refrence_Lbl.backgroundColor = [UIColor clearColor];
                refrence_Lbl.textAlignment = NSTextAlignmentCenter;
                refrence_Lbl.numberOfLines =1;
                refrence_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                receipt_date_Lbl = [[UILabel alloc] init];
                receipt_date_Lbl.backgroundColor = [UIColor clearColor];
                receipt_date_Lbl.textAlignment = NSTextAlignmentCenter;
                receipt_date_Lbl.numberOfLines = 1;
                receipt_date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                
                receivedBy_Lbl = [[UILabel alloc] init];
                receivedBy_Lbl.backgroundColor = [UIColor clearColor];
                receivedBy_Lbl.textAlignment = NSTextAlignmentCenter;
                receivedBy_Lbl.numberOfLines = 1;
                receivedBy_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                requested_Qty_Lbl = [[UILabel alloc] init];
                requested_Qty_Lbl.backgroundColor =  [UIColor clearColor];
                requested_Qty_Lbl.textAlignment = NSTextAlignmentCenter;
                requested_Qty_Lbl.numberOfLines = 1;
                
                received_Total_Qty_Lbl = [[UILabel alloc] init];
                received_Total_Qty_Lbl.backgroundColor =  [UIColor clearColor];
                received_Total_Qty_Lbl.textAlignment = NSTextAlignmentCenter;
                received_Total_Qty_Lbl.numberOfLines = 1;
                
                status_Lbl = [[UILabel alloc] init];
                status_Lbl.backgroundColor =  [UIColor clearColor];
                status_Lbl.textAlignment = NSTextAlignmentCenter;
                status_Lbl.numberOfLines = 1;
                
                action_Lbl = [[UILabel alloc] init];
                action_Lbl.backgroundColor =  [UIColor clearColor];
                action_Lbl.textAlignment = NSTextAlignmentCenter;
                action_Lbl.numberOfLines = 1;
                
                //added by Srinivasulu on 26/05/2017....
                
                issued_By_Lbl = [[UILabel alloc] init];
                issued_By_Lbl.backgroundColor =  [UIColor clearColor];
                issued_By_Lbl.textAlignment = NSTextAlignmentCenter;
                issued_By_Lbl.numberOfLines = 1;
                
                issued_Qty_Lbl = [[UILabel alloc] init];
                issued_Qty_Lbl.backgroundColor =  [UIColor clearColor];
                issued_Qty_Lbl.textAlignment = NSTextAlignmentCenter;
                issued_Qty_Lbl.numberOfLines = 1;
                
                weighted_Qty_Lbl = [[UILabel alloc] init];
                weighted_Qty_Lbl.backgroundColor =  [UIColor clearColor];
                weighted_Qty_Lbl.textAlignment = NSTextAlignmentCenter;
                weighted_Qty_Lbl.numberOfLines = 1;
                
                //upto here on 26/04/2017....
                
                newButton = [[UIButton alloc] init];
                //newButton.backgroundColor = [UIColor blackColor];
                newButton.titleLabel.textColor = [UIColor whiteColor];
                newButton.userInteractionEnabled = YES;
                newButton.tag = indexPath.section;
                [newButton addTarget:self action:@selector(newStockReceipt:) forControlEvents:UIControlEventTouchUpInside];
                [newButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
                //          newButton.
                
                openButton = [[UIButton alloc] init];
                //openButton.backgroundColor = [UIColor blackColor];
                openButton.titleLabel.textColor =  [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
                openButton.userInteractionEnabled = YES;
                openButton.tag = indexPath.section;
                [openButton addTarget:self action:@selector(editStockReceipt:) forControlEvents:UIControlEventTouchUpInside];
                [openButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                
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
                refrence_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                receipt_date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                receivedBy_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                requested_Qty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                received_Total_Qty_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
                status_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                action_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                //added by Srinivasulu on 26/05/2017....
                
                issued_By_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                issued_Qty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                weighted_Qty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                
                [hlcell.contentView addSubview:s_no_Lbl];
                [hlcell.contentView addSubview:refrence_Lbl];
                [hlcell.contentView addSubview:receipt_date_Lbl];
                [hlcell.contentView addSubview:receivedBy_Lbl];
                [hlcell.contentView addSubview:requested_Qty_Lbl];
                [hlcell.contentView addSubview:received_Total_Qty_Lbl];
                [hlcell.contentView addSubview:status_Lbl];
                [hlcell.contentView addSubview:newButton];
                [hlcell.contentView addSubview:openButton];
                [hlcell.contentView addSubview:viewListOfItemsBtn];
                
                
                //added by Srinivasulu on 26/05/2017....
                
                [hlcell.contentView addSubview:issued_By_Lbl];
                [hlcell.contentView addSubview:issued_Qty_Lbl];
                [hlcell.contentView addSubview:weighted_Qty_Lbl];
                
                //upto here on 26/04/2017...
                
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    }
                    else{
                    }
                    [newButton setTitle:NSLocalizedString(@"New", nil) forState:UIControlStateNormal];
                    [openButton setTitle:NSLocalizedString(@"Open", nil) forState:UIControlStateNormal];
                    
                    //setting frame....
                    s_no_Lbl.frame = CGRectMake(sNoLbl.frame.origin.x, 0,sNoLbl.frame.size.width, hlcell.frame.size.height);
                    
                    refrence_Lbl.frame = CGRectMake( RefNoLbl.frame.origin.x, 0, RefNoLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    receipt_date_Lbl.frame = CGRectMake( dateLbl.frame.origin.x, 0, dateLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    receivedBy_Lbl.frame = CGRectMake( receivedByLbl.frame.origin.x, 0, receivedByLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    requested_Qty_Lbl.frame = CGRectMake( requestedQtyLbl.frame.origin.x, 0, requestedQtyLbl.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    received_Total_Qty_Lbl.frame = CGRectMake( receivedQtyLbl.frame.origin.x, 0, receivedQtyLbl.frame.size.width,  hlcell.frame.size.height);
                    
                    issued_By_Lbl.frame = CGRectMake( issuedByLbl.frame.origin.x, 0, issuedByLbl.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    issued_Qty_Lbl.frame = CGRectMake( issuedQtyLbl.frame.origin.x, 0, issuedQtyLbl.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    weighted_Qty_Lbl.frame = CGRectMake( weightedQtyLbl.frame.origin.x, 0, weightedQtyLbl.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    status_Lbl.frame = CGRectMake( statusLbl.frame.origin.x, 0, statusLbl.frame.size.width + 2,  hlcell.frame.size.height);

                    //Commented By Bhargav..on 09/07/2018
                    //Reason: There is no Creation for The Stock Receipt as per the functionality..
                    
                    //newButton.frame = CGRectMake(actionLbl.frame.origin.x-4,0,(actionLbl.frame.size.width-5)/2,  hlcell.frame.size.height);
                    
                    openButton.frame = CGRectMake(actionLbl.frame.origin.x,0,actionLbl.frame.size.width,hlcell.frame.size.height);
                    
                    viewListOfItemsBtn.frame = CGRectMake(openButton.frame.origin.x+openButton.frame.size.width-3,8,30,30);
                    
                    //upto here on 26/04/2017....
                    
                    @try {
                        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
                        
                        newButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                        openButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                        
                    } @catch (NSException *exception) {
                        
                    }
                }
                else{
                    //Code For iPhone UI Under Table View...
                }
                
                @try {
                    
                    if (stockReceiptsArr.count >= indexPath.section && stockReceiptsArr.count ) {
                        
                        NSDictionary * dic = stockReceiptsArr[indexPath.section];
                        
                        s_no_Lbl.text = [NSString stringWithFormat:@"%i",(int)(indexPath.section + 1) + startIndexint];
                        
                        refrence_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kGoodsReceiptRef] defaultReturn:@"--"];
                        
                        receipt_date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:kCreatedDateStr] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
                        
                        receivedBy_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:RECEIVED_by] defaultReturn:@"--"];
                        
                        status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS] defaultReturn:@"--"];
                        
                        //added by Srinivasulu on 26/05/2017....
                        issued_By_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kIssuedBy] defaultReturn:@"--"];
                        
                        requested_Qty_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]  floatValue]];
                        
                        received_Total_Qty_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kReceiptTotalQty] defaultReturn:@"0.00"]  floatValue]];
                        
                        issued_Qty_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kSupplied] defaultReturn:@"0.00"]  floatValue]];
                        
                        float weighedQtyLbl = 0;
                        
                        for (NSDictionary * locDic in [dic valueForKey:RECEIPT_DETAILS]) {
                            
                            weighedQtyLbl += [[self checkGivenValueIsNullOrNil:[locDic valueForKey:WEIGHTED_QTY] defaultReturn:@"0.00"] floatValue];
                            
                        }
                        weighted_Qty_Lbl.text = [NSString stringWithFormat:@"%.2f",weighedQtyLbl];
                        
                        // upto here on 26/04/2017....
                    }
                    
                    else {
                        
                        s_no_Lbl.text = @"--";
                        refrence_Lbl.text = @"--";
                        receipt_date_Lbl.text = @"--";
                        receivedBy_Lbl.text =@"--";
                        requested_Qty_Lbl.text = @"--";
                        received_Total_Qty_Lbl.text = @"--";
                        status_Lbl.text = @"--";
                        
                        //added by Srinivasulu on 26/05/2017....
                        issued_By_Lbl.text = @"--";
                        issued_Qty_Lbl.text = @"--";
                        weighted_Qty_Lbl.text = @"--";
                        
                        //upto here on 26/04/2017...
                        openButton.frame = CGRectMake( actionLbl.frame.origin.x, 0, actionLbl.frame.size.width  ,  hlcell.frame.size.height);
                        [openButton setTitle:@"--" forState:UIControlStateNormal];

                        //layer_8.frame = CGRectMake(0, hlcell.frame.size.height - 2, newButton.frame.size.width,1);
                        //openButton.hidden = YES;
                    }
                }
                @catch (NSException *exception) {
                }
                
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.tag = indexPath.row;
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            @catch (NSException * exception) {
                
            }
            return hlcell;
         
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
            UILabel * item_ReqQty_Lbl;
            UILabel * item_IssueQty_Lbl;

            item_No_Lbl = [[UILabel alloc] init];
            item_No_Lbl.backgroundColor = [UIColor clearColor];
            item_No_Lbl.textAlignment = NSTextAlignmentCenter;
            item_No_Lbl.numberOfLines = 1;
            item_No_Lbl.layer.borderWidth = 1.5;
            item_No_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_No_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_code_Lbl = [[UILabel alloc] init];
            item_code_Lbl.backgroundColor = [UIColor clearColor];
            item_code_Lbl.textAlignment = NSTextAlignmentCenter;
            item_code_Lbl.numberOfLines = 1;
            item_code_Lbl.layer.borderWidth = 1.5;
            item_code_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_code_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            item_Name_Lbl = [[UILabel alloc] init];
            item_Name_Lbl.backgroundColor = [UIColor clearColor];
            item_Name_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Name_Lbl.numberOfLines = 1;
            item_Name_Lbl.layer.borderWidth = 1.5;
            item_Name_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_Name_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_Grade_Lbl = [[UILabel alloc] init];
            item_Grade_Lbl.backgroundColor =  [UIColor clearColor];
            item_Grade_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Grade_Lbl.numberOfLines = 1;
            item_Grade_Lbl.layer.borderWidth = 1.5;
            item_Grade_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_Grade_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_ReqQty_Lbl = [[UILabel alloc] init];
            item_ReqQty_Lbl.backgroundColor =  [UIColor clearColor];
            item_ReqQty_Lbl.textAlignment = NSTextAlignmentCenter;
            item_ReqQty_Lbl.numberOfLines = 1;
            item_ReqQty_Lbl.layer.borderWidth = 1.5;
            item_ReqQty_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_ReqQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_IssueQty_Lbl = [[UILabel alloc] init];
            item_IssueQty_Lbl.backgroundColor =  [UIColor clearColor];
            item_IssueQty_Lbl.textAlignment = NSTextAlignmentCenter;
            item_IssueQty_Lbl.numberOfLines = 1;
            item_IssueQty_Lbl.layer.borderWidth = 1.5;
            item_IssueQty_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_IssueQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_No_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_code_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_Name_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_Grade_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_ReqQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_IssueQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

            [hlcell.contentView addSubview:item_No_Lbl];
            [hlcell.contentView addSubview:item_code_Lbl];
            [hlcell.contentView addSubview:item_Name_Lbl];
            [hlcell.contentView addSubview:item_Grade_Lbl];
            [hlcell.contentView addSubview:item_ReqQty_Lbl];
            [hlcell.contentView addSubview:item_IssueQty_Lbl];
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:14.0f cornerRadius:0.0];
                
                item_No_Lbl.frame = CGRectMake(itemNoLbl.frame.origin.x,0,itemNoLbl.frame.size.width+2, hlcell.frame.size.height);
                item_code_Lbl.frame = CGRectMake(itemCodeLbl.frame.origin.x,0, itemCodeLbl.frame.size.width + 2,  hlcell.frame.size.height);
                item_Name_Lbl.frame = CGRectMake(itemNameLbl.frame.origin.x,0, itemNameLbl.frame.size.width + 2,  hlcell.frame.size.height);
                item_Grade_Lbl.frame = CGRectMake(itemGradeLbl.frame.origin.x,0, itemGradeLbl.frame.size.width + 2,  hlcell.frame.size.height);
                item_ReqQty_Lbl.frame = CGRectMake(itemReqstQtyLbl.frame.origin.x,0,itemReqstQtyLbl.frame.size.width +2,hlcell.frame.size.height);
                item_IssueQty_Lbl.frame = CGRectMake(itemIssueQtyLbl.frame.origin.x,0,itemIssueQtyLbl.frame.size.width,hlcell.frame.size.height);
            }
            
            else {
                
            }
            
            @try {
                
                NSMutableDictionary * locDic = [requestedItemsInfoArr[indexPath.row] mutableCopy];
                
                item_No_Lbl.text = [NSString stringWithFormat:@"%d",(int)(indexPath.row + 1)];
                
                item_code_Lbl.text =  [locDic valueForKey:PLU_CODE];
                item_Name_Lbl.text = [locDic valueForKey:ITEM_DESCRIPTION];
                
                if ( ((![[locDic valueForKey:PRODUCT_RANGE] isKindOfClass: [NSNull class]]) && [locDic.allKeys containsObject:PRODUCT_RANGE]) )
                    item_Grade_Lbl.text = [locDic valueForKey:PRODUCT_RANGE];
                
                else
                    item_Grade_Lbl.text = @"--";
                
                 item_ReqQty_Lbl.text =  [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic valueForKey:QUANTITY] defaultReturn:@"0.00"]  floatValue]];
                
                item_IssueQty_Lbl.text =  [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic valueForKey:ACCEPTED_QTY] defaultReturn:@"0.00"]  floatValue]];
            }
            @catch (NSException *exception) {
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
            
            if(outletIdTxt.tag == 0)
                
                hlcell.textLabel.text = locationArr[indexPath.row];
            else
                hlcell.textLabel.text = zoneListArr[indexPath.row];
            
            hlcell.textLabel.numberOfLines = 1;
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
            hlcell.textLabel.text = categoriesListArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;

        } @catch (NSException *exception) {
            
        }
        
        return hlcell;
        
    }
    else if(tableView == subCategoriesListTbl){
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
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;

        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if(tableView == brandListTbl){
        
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
            hlcell.textLabel.text = brandListArray[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;

        } @catch (NSException *exception) {
            
        }
        
        return hlcell;
    }
    
    else if(tableView == modelListTbl){
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
            hlcell.textLabel.text = ModelListArray[indexPath.row];
            
            hlcell.textLabel.numberOfLines = 1;
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } @catch (NSException *exception) {
            
        }

        return hlcell;
    }
    
    else if (tableView == workFlowListTbl) {
        @try {
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
            hlcell.textLabel.text = workFlowsArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
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
 * @description  it is tableview delegate method it will be called after cellForRowIndexPath.......
 * @date
 * @method       tableView: didSelectRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        NSIndexPath
 * @param
 * @return       void
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // dismissing the catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
    
    if(tableView ==StockReceiptTbl ){
        
        @try {
          
            if (stockReceiptsArr.count) {
                
                UIButton * showGridBtn = [[UIButton alloc]init];
                showGridBtn.tag = indexPath.section;
                [self showListOfItems:showGridBtn];
            }
            
            else {
                
                float y_axis = self.view.frame.size.height - 120;
                
                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            }
        } @catch (NSException *exception) {
            
        }
    }
    
    else if(tableView == locationTbl){
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        
        @try {
            
            if(toOutletsTxt.tag == 3){
                
                toOutletsTxt.text = @"";
                toOutletsTxt.text = locationArr[indexPath.row];
                
                outLetStoreName = [NSString stringWithFormat:@"%@",@""];
                if(indexPath.row != 0)
                    outLetStoreName = [NSString stringWithFormat:@"%@",toOutletsTxt.text];
                
            }
            else{
                
                zoneIdTxt.text = @"";
                outletIdTxt.text = @"";
                
                zoneIdTxt.text = zoneListArr[indexPath.row];
                
                zoneName = [NSString stringWithFormat:@"%@",@""];
                if(indexPath.row != 0)
                    zoneName = [NSString stringWithFormat:@"%@",zoneIdTxt.text];
                
                [locationArr removeAllObjects];
                locationArr = [[zoneWiseLocationDic valueForKey:zoneIdTxt.text] mutableCopy];
                
            }
            receiptIdTxt.tag = (receiptIdTxt.text).length;
            
        } @catch (NSException *exception) {
            NSLog(@"----exception in changing the textFieldData in didSelec----%@",exception);
        } @finally {
            
        }
    }
    
    else  if(tableView == categoriesListTbl){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            categoriesListTbl.tag = indexPath.row;
            
            categoryTxt.text = categoriesListArr[indexPath.row];
            
            subCategoryTxt.text = @"";
            
            if(subCategoriesListArr.count && subCategoriesListArr != nil)
                [subCategoriesListArr removeAllObjects];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if(tableView == subCategoriesListTbl){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
             subCategoriesListTbl.tag = indexPath.row;
            
             subCategoryTxt.text = subCategoriesListArr[indexPath.row];
            
        } @catch (NSException * exception) {
            
        }
    }
    else if(tableView == brandListTbl) {
        
        brandListTbl.tag = indexPath.row;
        
        brandTxt.text = brandListArray[indexPath.row];
        
    }
    else if(tableView == modelListTbl) {
        
        @try {
            
            modelListTbl.tag = indexPath.row;
            
            modelTxt.text = ModelListArray[indexPath.row];
            
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
    
    else if (tableView == pagenationTbl) {
        
        @try {
            
            startIndexint = 0;
            pagenationTxt.text = pagenationArr[indexPath.row];
            int pageValue = (pagenationTxt.text).intValue;
            startIndexint = startIndexint + (pageValue * 10) - 10;
            
        } @catch (NSException * exception) {
            
        }
    }
}

#pragma -mark service call.......

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

-(void)getZones{
    
    @try {
        [HUD setHidden:NO];
        
        if(locationArr == nil)
            locationArr = [NSMutableArray new];
        
        if(zoneListArr == nil)
            zoneListArr = [NSMutableOrderedSet new];
        
        if(zoneWiseLocationDic == nil)
            zoneWiseLocationDic = [NSMutableDictionary new];
        
        // Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of using NSArray to form the request Param changed to NSMutableDictionary

        NSMutableDictionary * zoneDic  = [[NSMutableDictionary alloc]init];
        
        [zoneDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [zoneDic setValue:NEGATIVE_ONE forKey:START_INDEX];

        NSError  * err_;
        NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:zoneDic options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.zoneMasterDelegate = self;
        [webServiceController getZoneIdsRequest:loyaltyString];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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

-(void)getLocations{
    
    @try {
        
        if(locationArr == nil)
            locationArr = [NSMutableArray new];
        
        if(zoneListArr == nil)
            zoneListArr = [NSMutableOrderedSet new];
        
        if(zoneWiseLocationDic == nil)
            zoneWiseLocationDic = [NSMutableDictionary new];
        
        // Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of using NSArray to form the request Param changed to NSMutableDictionary
        
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
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getLocations ServicesCall ----%@",exception);
        
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are calling the categoriesList services.....
 * @date         26/05/2017
 * @method       callingCategoriesList
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)callingCategoriesList:(NSString *)categoryName  {
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        
        if(categoriesListTbl.tag == 2 )
            categoriesListArr = [NSMutableArray new];
        else
            subCategoriesListArr = [NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,kCategoryName,SL_NO,FLAG];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,categoryName,[NSNumber numberWithBool:true],EMPTY_STRING];
        
        
        //        NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"startIndex",@"categoryName",@"slNo",@"flag",nil];
        //        NSArray *objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader],@"-1",@"",[NSNumber numberWithBool:true],@"", nil];
        
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * departmentJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getProductCategory:departmentJsonString];
        
    }
    @catch (NSException *exception) {
   
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling callingCategoriesList ServicesCall ----%@",exception);
        
    }
    @finally {
        
    }
    
}

/**
 * @description  here we are calling the getDepartmentList services.....
 * @date         26/05/2017
 * @method       callingDepartmentList
 * @author       Srinivasulu
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
        
        brandListArray = [NSMutableArray new];
        dept_SubDeptDic = [NSMutableDictionary new];
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,kNumberOfSubDepartments,SL_NO];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,[NSNumber numberWithBool:true],[NSNumber numberWithBool:true]];
        
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
        
        NSLog(@"---- exception while  calling DepartmentList ServicesCall ----%@",exception);
    }
    @finally {
        
    }
    
}

/**
 * @description  here we are calling the getDepartmentList services.....
 * @date         26/05/2017
 * @method       callingBrandList
 * @author       Srinivasulu
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
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,BNAME,SL_NO];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,@"", [NSNumber numberWithBool:true]];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * brandListJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getBrandList:brandListJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while   calling BrandList ServicesCall ----%@",exception);

    }
    @finally {
        
    }
    
}

/**
 * @description  here we are calling the ModelesList services.....
 * @date         26/05/2017
 * @method       callingModelList
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingModelList{
    @try {
        
        
        [HUD show: YES];
        [HUD setHidden:NO];
        
        if (ModelListArray == nil) {
            ModelListArray  = [NSMutableArray new];
        }
        
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX];
        NSArray *objects = @[[RequestHeader getRequestHeader],@0];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * brandListJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.modelMasterDelegate = self;
        [webServiceController getModelDetails:brandListJsonString];
        
        
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while  calling ModelList ServicesCall ----%@",exception);
        
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
 *
 */

-(void)getWorkFlows{
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        workFlowsArr = [NSMutableArray new];
        
        NSMutableDictionary * workFlowDic = [[NSMutableDictionary alloc]init];
        
        [workFlowDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [workFlowDic setValue:Stock_Receipt forKey:BUSINESSFLOW];
        [workFlowDic setValue:presentLocation forKey:STORE_LOCATION];
        [workFlowDic setValue:NEGATIVE_ONE forKey:START_INDEX];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:workFlowDic options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"--%@",quoteRequestJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.rolesServiceDelegate = self;
        [webServiceController getWorkFlows:quoteRequestJsonString];
        
        
    } @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getWorkFlows ServicesCall ----%@",exception);
        
        
    } @finally {
        
        
    }
}




#pragma -mark handling serviceCallRespone.......

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

-(void)getLocationSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        NSArray *locations = [successDictionary valueForKey:LOCATIONS_DETAILS];
        
        if (locations.count!= 0 && locationArr.count == 0) {
            
            [locationArr addObject:NSLocalizedString(@"All", nil)];
            for (NSDictionary *locationDic in locations) {
                
                [locationArr addObject:[locationDic  valueForKey:LOCATION_ID]];
              
                if ([locationArr containsObject:presentLocation]) {
                    
                    [locationArr removeObject:presentLocation];
                }

            }
            
            if(locationArr.count)
                zoneWiseLocationDic[ALL] = locationArr;
        }
        
        else {
            [catPopOver dismissPopoverAnimated:YES];
        }
        
    } @catch (NSException *exception) {
        [catPopOver dismissPopoverAnimated:YES];
        
    } @finally {
        //        if([stockRequestsInfoArr count])
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

-(void)getLocationErrorResponse:(NSString *)errorResponse{
    
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        //        if([stockRequestsInfoArr count])
        [HUD setHidden:YES];
    }
    
}


/**
 * @description  we are handling the response from service to store zoneList
 * @date
 * @method       getZonesSuccessResponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)getZonesSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        
        [zoneListArr addObject:NSLocalizedString(@"All", nil)];
        
        for(NSDictionary *dic in [successDictionary valueForKey:ZONE_MASTER_LIST]){
            
            [zoneListArr addObject:[dic valueForKey:ZONE_ID]];
            
            
            
            //here we are reading the zoneLocation......
            NSMutableArray *locationsArr = [NSMutableArray new];
            [locationsArr addObject:NSLocalizedString(@"All", nil)];
            
            for(NSDictionary *locDic in [dic valueForKey:ZONE_DETAILS]){
                
                [locationsArr addObject:[locDic valueForKey:LOCATION]];
                
            }
            
            //            if([locationsArr count])
            zoneWiseLocationDic[[dic valueForKey:ZONE_ID]] = locationsArr;
            
        }
        
    } @catch (NSException *exception) {
        NSLog(@"----exception while handling the zoneResponse----%@",exception);
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

- (void)getZonesErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        
    }
    
}

/**
 * @description  handling the success response received from server side....
 * @date         03/04/2017
 * @method       getAllDepartmentsSuccessResponse:
 * @author       Srinivasulu
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
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  handling the success response received from server side....
 * @date         26/05/2017
 * @method       getDepartmentSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getDepartmentSuccessResponse:(NSDictionary*)sucessDictionary{
    
    @try   {
        
        for (NSDictionary * department in  [sucessDictionary valueForKey:kDepartments]){
            [brandListArray addObject:[self checkGivenValueIsNullOrNil:[department valueForKey:kPrimaryDepartment]  defaultReturn:@""]];
            
            NSMutableArray *locArr = [NSMutableArray new];
            
            @try {
                
                
                for (NSDictionary * subDepartment in [department valueForKey:SECONDARY_DEPARTMENTS]){
                    
                    [locArr addObject:[self checkGivenValueIsNullOrNil:[subDepartment valueForKey:SECONDARY_DEPARTMENTS]  defaultReturn:@""]];
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
 * @description  handling the service call error resposne....
 * @date         26/05/2017
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
        
        if(receiptIdTxt.isEditing)
            y_axis = receiptIdTxt.frame.origin.y + receiptIdTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


/**
 * @description  handling the success response received from server side....
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
 * @method       getModelErrorResponse:
 * @author       Bhargav
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
    
    if(receiptIdTxt.isEditing)
        y_axis = receiptIdTxt.frame.origin.y + receiptIdTxt.frame.size.height;
    
    
    NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
    
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
}

/**
 * @description  handling the success response received from server side....
 * @date         26/05/2017
 * @method       getModelSuccessResponse:
 * @author       Srinivasulu
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
 * @description  handling the service call error resposne....
 * @date         26/05/2017
 * @method       getModelErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getModelErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(receiptIdTxt.isEditing)
            
            y_axis = receiptIdTxt.frame.origin.y + receiptIdTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert",nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch(NSException * exception) {
        
        
    } @finally {
        
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

-(void)getWorkFlowsSuccessResponse:(NSDictionary *)successDictionary {
    
    [workFlowsArr addObject:NSLocalizedString(@"select_status",nil)];
    
    
    for (NSDictionary * statusDictionary  in [[successDictionary valueForKey:WORKFLOW_LIST]valueForKey:STATUS_NAME]) {
        
        [workFlowsArr addObject:statusDictionary];
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
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException * exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
}



#pragma -mark action used in this page to show the popups....

/**
 * @description  here we are showing the all availiable outlerId.......
 * @date         26/05/2016
 * @method       showAllOutletId
 * @author       Bhargav.v
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
        if(locationArr == nil ||  locationArr.count == 0){
            [HUD setHidden:NO];
            //changed on 17/02/2017....
            [self getLocations];
            //[self getOutletsMappedToThisWarehouse];
        }
        
        if(locationArr.count){
            float tableHeight = locationArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = locationArr.count * 33;
            
            if(locationArr.count > 5)
                tableHeight = (tableHeight/locationArr.count) * 5;
            
            if (sender.tag == 1) {
                [self showPopUpForTables:locationTbl  popUpWidth:(outletIdTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:outletIdTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp];
            }
            else {
                
                [self showPopUpForTables:locationTbl  popUpWidth:(outletIdTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:toOutletsTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp];
            }
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
 * @author       Srinivasulu
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
            
            [self showPopUpForTables:locationTbl  popUpWidth:(zoneIdTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:zoneIdTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp];
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
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showAllCategoriesList:(UIButton *)sender{
    
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
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        
        float tableHeight = categoriesListArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = categoriesListArr.count * 33;
        
        if(categoriesListArr.count > 5)
            tableHeight = (tableHeight/categoriesListArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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

-(void)showAllSubCategoriesList:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(!(categoryTxt.text).length){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"please_select_category_first", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
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
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        
        float tableHeight = subCategoriesListArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoriesListArr.count * 33;
        
        if(subCategoriesListArr.count > 5)
            tableHeight = (tableHeight/subCategoriesListArr.count) * 5;
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:(subCategoryTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showListOfBrands:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showListOfBrands:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(brandListArray == nil){
            
            //        if((brandListArray == nil) || ([brandListArray count] == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self callingBrandList];
            
        }
        
        [HUD setHidden:YES];
        
        if(brandListArray.count == 0){
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        
        
        float tableHeight = brandListArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = brandListArray.count * 33;
        
        if(brandListArray.count > 5)
            tableHeight = (tableHeight/brandListArray.count) * 5;
        
        [self showPopUpForTables:brandListTbl  popUpWidth:(brandTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showListOfModels:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showListOfModels:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        //        if((ModelListArray == nil) || ([ModelListArray count] == 0)){
        if(ModelListArray == nil){
            
            [self callingModelList];
            return;
            
        }
        
        [HUD setHidden:YES];
        
        if(ModelListArray.count == 0){
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        
        float tableHeight = ModelListArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = ModelListArray.count * 33;
        
        if(ModelListArray.count > 5)
            tableHeight = (tableHeight/ModelListArray.count) * 5;
        
        [self showPopUpForTables:modelListTbl  popUpWidth:(modelTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:modelTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are showing the list of requestedItems.......
 * @date         09/05/2017....
 * @method       showListOfItems;
 * @author       Srinivasulu
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
    
    // [stockRequestTbl reloadData];
    
    @try {
        
        requestedItemsTbl.tag = sender.tag;
        
        requestedItemsInfoArr = [NSMutableArray new];
        requestedItemsInfoArr = [[stockReceiptsArr[sender.tag] valueForKey:RECEIPT_DETAILS] mutableCopy];
        
        isInEditableState = false;
        
        //here we are formating the next...
        updateDictionary = [stockReceiptsArr[sender.tag] mutableCopy];
        
        if(([[updateDictionary valueForKey:NEXT_ACTIVITIES] count]) || ([[updateDictionary valueForKey:NEXT_WORK_FLOW_STATES] count]) || ([[self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:STATUS] defaultReturn:@""] isEqualToString:APPROVED]) ){
            isInEditableState = true;
            
        }
        //upto here..
        
        if(requestedItemsInfoArr.count == 0){
            
            [self displayAlertMessage:NSLocalizedString(@"no_data_found", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
        
        if (path.row == 0) {
            
            UITableViewCell *cell2 = [StockReceiptTbl cellForRowAtIndexPath:path];
            
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
                    
                    //                    requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:path.section] valueForKey:@"stockRequestItems"];
                    [self didSelectCellRowFirstDo:YES nextDo:NO];
                    
                }else
                {
                    selectSectionIndex = path;
                    
                    cell2 = [StockReceiptTbl cellForRowAtIndexPath: self.selectIndex];
                    
                    for (UIButton *button in cell2.contentView.subviews) {
                        
                        if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                            
                            UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_right_arrow.png"];
                            
                            [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                        }
                    }
                    
                    [self didSelectCellRowFirstDo:NO nextDo:YES];
                }
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in showListOfItems----%@",exception);
        NSLog(@"----exception in inserting the row in table----%@",exception);
        
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
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = pagenationArr.count *40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArr.count * 33;
        
        if(pagenationArr.count> 5)
            tableHeight = (tableHeight/pagenationArr.count) * 5;
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionLeft ];
        

    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showListOfModels:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showWorkFlowStatus:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(workFlowsArr == nil){
            
            [self getWorkFlows];
            //return;
        }
        
        [HUD setHidden:YES];
        
        if(workFlowsArr.count == 0){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        float tableHeight = workFlowsArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = workFlowsArr.count * 33;
        
        if(workFlowsArr.count > 5)
            tableHeight = (tableHeight/workFlowsArr.count) * 5;
        
        [self showPopUpForTables:workFlowListTbl  popUpWidth:(statusTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:statusTxt  showViewIn:StockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
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
        
        [StockReceiptTbl beginUpdates];
        
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
            
            [StockReceiptTbl  insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [StockReceiptTbl deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [StockReceiptTbl endUpdates];
        
        if (nextDoInsert) {
            self.isOpen = YES;
            self.selectIndex = selectSectionIndex;
            //            requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:selectIndex.section] valueForKey:@"stockRequestItems"];
            
            UITableViewCell *cell2 = [StockReceiptTbl cellForRowAtIndexPath:selectIndex];
            
            for (UIButton *button in cell2.contentView.subviews) {
                
                if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                    
                    UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                    
                    [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                    
                }
            }
            [self didSelectCellRowFirstDo:YES nextDo:NO];
        }
        if (self.isOpen)
            [StockReceiptTbl scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        //[stockRequestTbl scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }    @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in didSelectCellRowFirsDo: nextDo----%@",exception);
        
        NSLog(@"----exception in inserting the row in table----%@",exception);
        
    }
    @finally {
        //        [stockRequestTbl reloadData];
    }
    
}


/**
 * @description  here we are creating request string for creation of new SupplierQuotation.......
 * @date         26/05/2017
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
        searchBtn.tag  = 2;
        
        if ((outletIdTxt.text).length == 0 &&  (categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0 && (brandTxt.text).length == 0 && (modelTxt.text).length== 0 && (startDateTxt.text).length == 0 && (endDateTxt.text).length== 0 &&  (statusTxt.text).length == 0  &&  (toOutletsTxt.text).length == 0) {

            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"please_select_above_fields_before_proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        else
            
        startIndexint = 0;
        [self callingStockReceipts];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are creating request string for creation of new SupplierQuotation.......
 * @date         26/05/2017
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
        searchBtn.tag  = 4;
        
        categoryTxt.text = @"";
        subCategoryTxt.text = @"";
        brandTxt.text = @"";
        modelTxt.text = @"";
        startDateTxt.text = @"";
        endDateTxt.text = @"";
        statusTxt.text = @"";
        toOutletsTxt.text = @"";

        startIndexint = 0;
        [self callingStockReceipts];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
    
}

#pragma  -mark  start of service calls

/**
 * @description  we get all stockRceipts IDs with complete data......
 * @date         21/09/2016
 * @method       callingStockReceipts
 * @author       Bhargav.v
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

-(void)callingStockReceipts {
    
    @try {
        [HUD setHidden:NO];
        
        if(stockReceiptsArr == nil && startIndexint == 0) {
            
            totalNoOfStockReceipts = 0;
            
            stockReceiptsArr = [NSMutableArray new];
        }
        else if(stockReceiptsArr.count){
            
            [stockReceiptsArr removeAllObjects];
        }
        
        if(startIndexint == 0)
            
            totalItemsQtyValueLbl.text = @"0.00";
        
        
        //first column fields....
        NSString * zoneIdStr = @"";
        NSString * outletIdStr = @"";
        
        //second column fields....
        NSString * categoryStr = @"";
        NSString * subCategoryStr = @"";
        
        //third column fields....
        NSString * brandStr = @"";
        NSString * modelStr = @"";
        
        //fourth column fields....
        NSString * startDteStr = @"";
        NSString * endDteStr  = @"";
        NSString * statusStr = @"";
        NSString * shippedFromStr = @"";
        
        if(searchBtn.tag == 2){
            
            //first column fields....
            zoneIdStr = zoneIdTxt.text;
            outletIdStr = outletIdTxt.text;
            
            //second column fields..
            categoryStr = categoryTxt.text;
            subCategoryStr = subCategoryTxt.text;
            
            //third column fields....
            brandStr = brandTxt.text;
            modelStr = modelTxt.text;
            
            //newyly added filter on 31/08/2017 by bhargav.v
            
            statusStr = statusTxt.text;
            shippedFromStr = toOutletsTxt.text;
            
            //fourth column fields....
            if((startDateTxt.text).length > 0)
                startDteStr =  [NSString stringWithFormat:@"%@%@",startDateTxt.text,@" 00:00:00"];
            
            if ((endDateTxt.text).length>0) {
                endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
            }
        }
        
        if (categoriesListTbl.tag == 0 || (categoryTxt.text).length == 0 || categoriesListTbl.tag == 4)
            
            categoryStr = @"";
        
        if (subCategoriesListTbl.tag == 0 || (subCategoryTxt.text).length == 0)
            
            subCategoryStr = @"";
        
        if (brandListTbl.tag == 0  || (brandTxt.text).length == 0)
            
            brandStr = @"";
        
        if (modelListTbl.tag == 0  || (modelTxt.text).length == 0)
            
            modelStr = @"";
        
        
        if (brandListTbl.tag == 0  || (brandTxt.text).length == 0)
            
            brandStr = @"";
        
        if (modelListTbl.tag == 0  || (modelTxt.text).length == 0)
            
            modelStr = @"";
        
        if (workFlowListTbl.tag == 0  || (statusTxt.text).length == 0)
            
            statusStr = @"";
        
        
        NSMutableDictionary * requestDic = [NSMutableDictionary new];
        
        //setting requestHeader....
        requestDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        //setting storeLocation....
        requestDic[kReceiptLocation] = presentLocation;
        
        //setting pagination....
        requestDic[START_INDEX] = [NSString stringWithFormat:@"%d",startIndexint];
        
        requestDic[kMaxRecords] = @"10";
        
        //setting searchCriteria....
        requestDic[SEARCH_CRITERIA] = receiptIdTxt.text;
        
        //setting fistColumn....
        requestDic[ZONE_ID] = zoneIdStr;
        
        requestDic[ZONE_Id] = zoneIdStr;
        
        requestDic[FROM_STORE_CODE] = outletIdStr;
        
        requestDic[LOCATION] = outletIdStr;
        
        //setting secondColumn....
        requestDic[ITEM_CATEGORY] = categoryStr;
        
        requestDic[kSubCategory] = subCategoryStr;
        
        //setting thirdColumn....
        requestDic[kBrand] = brandStr;
        
        requestDic[MODEL] = modelStr;
        
        //setting fourthColumn....
        requestDic[START_DATE] = startDteStr;
        
        requestDic[END_DATE] = endDteStr;
        
        requestDic[STATUS] = statusStr;
        
        requestDic[kShippedFrom] = shippedFromStr;
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&err];
        NSString * stockReceiptJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockReceiptDelegate = self;
        [webServiceController getStockReceipts:stockReceiptJsonStr];
        
    }
    @catch (NSException *exception) {
        //changed by Srinivasulu on 17/01/2016....
        
        [HUD setHidden:YES];
        
        //upto here on 17/01/2016....
        
        NSLog(@"----exception in Service Call---%@",exception);
    }
}

#pragma - mark start of handling service call reponses

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getStockReceiptsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method & changed the hanlding....
 * @return
 * @verified By
 * @verified On
 */

-(void)getStockReceiptsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        totalNoOfStockReceipts = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:kTotalReceipts]  defaultReturn:@"0"]intValue];
        
        //added on 23/05/2017....
        float qty = 0;
        float totalItems = 0;
        if((totalItemsQtyValueLbl.text).length)
           
            qty = (totalItemsQtyValueLbl.text).floatValue;
        
        //upto here on 23/05/2017.....

        for(NSDictionary * dic in [successDictionary valueForKey:kReceipts]){
            
            [stockReceiptsArr addObject:dic];
        
             qty  =  qty + [[self checkGivenValueIsNullOrNil:[dic valueForKey:kReceiptTotalQty] defaultReturn:@"0.00"] floatValue];
         }

        totalItems = stockReceiptsArr.count;
        totalItemsQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", qty];
        totalNoOfItemsValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", totalItems];
        
        int strTotalRecords = totalNoOfStockReceipts/10;
        int remainder = totalNoOfStockReceipts % 10;
        
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
        else {
            for(int i = 1; i <= strTotalRecords;i++) {
                
                [pagenationArr addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        
        // Up to here on 16/10/2017...

    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
        if(startIndexint == 0) {
            pagenationTxt.text = @"1";
        }
        
        [StockReceiptTbl reloadData];
        [HUD setHidden: YES];
    }
}

/**
 * @description  here we are handling error response received frome the service.......
 * @date         20/09/2016
 * @method       getStockReceiptsErrorResponse:
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getStockReceiptsErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        if(!stockReceiptsArr.count){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [StockReceiptTbl reloadData];
    }
}



#pragma -mark super class methods

/**
 * @description  here we are navigating back to home page.......
 * @date         26/09/2016
 * @method       homeButonClicked
 * @author       Bhargav Ram
 * @param
 * @param
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section && added try catch block....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)homeButonClicked {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        OmniHomePage *home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:YES];
        
        
    } @catch (NSException *exception) {
        
    }
    
}

/**
 * @description  here we are navigating back to home page.......
 * @date         26/09/2016
 * @method       goToHome
 * @author       Bhargav.v
 * @param
 * @param
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section && added try catch block....
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)goToHome {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  here we are navigating back to home page.......
 * @date         26/09/2016
 * @method       backAction
 * @author       Bhargav Ram
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
    AudioServicesPlaySystemSound(soundFileObject);
    
    
    @try {
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
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



#pragma -mark reusable method to check  nil resaponse:

/**
 * @description  here we are checking whether the object is null or not
 * @date         16/12/2016
 * @method       checkGivenValueIsNullOrNil
 * @author       bhargav.v
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines{
    
    
    //[self displayAlertMessage: @"No Products Avaliable" horizontialAxis:segmentedControl.frame.origin.x   verticalAxis:segmentedControl.frame.origin.y  msgType:@"warning" timming:2.0];
    
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
            
            if(receiptIdTxt.isEditing)
                yPosition = receiptIdTxt.frame.origin.y + receiptIdTxt.frame.size.height;
            
            
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


#pragma mark functionality Yet To Implement..

-(void)populateSumaryInfo:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float y_axis = self.view.frame.size.height - 200;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 320)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}



@end
