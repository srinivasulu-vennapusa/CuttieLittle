
//#import "ReceiptGoodsProcurement.h"
#import "RawMaterialServiceSvc.h"
#import "StockReceiptServiceSvc.h"
#import "MaterialTransferIssue.h"
#import "OpenStockIssue.h"
#import "StockIssueServiceSvc.h"
#import "SkuServiceSvc.h"
#import "UtilityMasterServiceSvc.h"
#import "CustomTextField.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"
#import "NewStockIssue.h"


@interface MaterialTransferIssue ()

@end

@implementation MaterialTransferIssue

@synthesize soundFileURLRef,soundFileObject;

int  startIndexInt = 0;

//this properties are to handle the internalcode of this class/viewController....
@synthesize isOpen,selectIndex,buttonSelectIndex,selectSectionIndex;



#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By ...
 * @reason      added comments....
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
    
    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
    
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //creation of progress/processing bar and adding it to slef.navigationController....
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = NSLocalizedString(@"please_wait..",nil);
    
    // Showing && hidding the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //creation of goodsIssueView....
    goodsIssueView = [[UIView alloc] init];
    goodsIssueView.backgroundColor = [UIColor blackColor];
    goodsIssueView.layer.borderWidth = 1.0f;
    goodsIssueView.layer.cornerRadius = 10.0f;
    goodsIssueView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    UILabel * headerNameLbl;
    CALayer * bottomBorder;
    
    //headerNameLbl used to identify the flow....
    headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    
    //it is regard's to the view borderwidth and color setting....
    bottomBorder = [CALayer layer];
    bottomBorder.opacity = 5.0f;
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    [headerNameLbl.layer addSublayer:bottomBorder];
    
    /*UIImages used for setting the UIButton*/
    UIImage * indentsImg;
    UIImage * buttonImage_;
    UIImage * dateImg;
    
    /*UIButton's used in this page*/
    
    UIButton * summaryInfoBtn;
    
    indentsImg = [UIImage imageNamed:@"emails-letters.png"];
    buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];
    dateImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [summaryInfoBtn setBackgroundImage:indentsImg forState:UIControlStateNormal];
    summaryInfoBtn.hidden = YES;
    [summaryInfoBtn addTarget:self
                       action:@selector(populateSumaryInfo) forControlEvents:UIControlEventTouchDown];
    
    outletIdTxt = [[CustomTextField alloc] init];
    outletIdTxt.placeholder = NSLocalizedString(@"all_outlets", nil);
    outletIdTxt.delegate = self;
    outletIdTxt.userInteractionEnabled  = NO;
    [outletIdTxt awakeFromNib];
    
    zoneIdTxt = [[CustomTextField alloc] init];
    zoneIdTxt.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneIdTxt.delegate = self;
    zoneIdTxt.userInteractionEnabled  = NO;
    [zoneIdTxt awakeFromNib];
    
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.userInteractionEnabled = NO;
    categoryTxt.placeholder = NSLocalizedString(@"all_categories", nil);
    categoryTxt.delegate = self;
    [categoryTxt awakeFromNib];
    
    
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.userInteractionEnabled = NO;
    subCategoryTxt.placeholder = NSLocalizedString(@"all_subcategories", nil);
    subCategoryTxt.delegate = self;
    [subCategoryTxt awakeFromNib];
    
    brandTxt = [[CustomTextField alloc] init];
    brandTxt.userInteractionEnabled = NO;
    brandTxt.placeholder = NSLocalizedString(@"all_brands", nil);
    brandTxt.delegate = self;
    [brandTxt awakeFromNib];
    
    modelTxt = [[CustomTextField alloc] init];
    modelTxt.userInteractionEnabled = NO;
    modelTxt.placeholder = NSLocalizedString(@"all_models",nil);
    modelTxt.delegate = self;
    [modelTxt awakeFromNib];
    
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.placeholder = NSLocalizedString(@"start_date",nil);
    startDateTxt.userInteractionEnabled  = NO;
    startDateTxt.delegate = self;
    [startDateTxt awakeFromNib];
    
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.userInteractionEnabled = NO;
    endDateTxt.placeholder = NSLocalizedString(@"end_date",nil);
    endDateTxt.delegate = self;
    [endDateTxt awakeFromNib];
    
    statusTxt = [[CustomTextField alloc] init];
    statusTxt.userInteractionEnabled = NO;
    statusTxt.placeholder = NSLocalizedString(@"select_status", nil);
    statusTxt.delegate = self;
    [statusTxt awakeFromNib];
    
    toStoreTxt = [[CustomTextField alloc] init];
    toStoreTxt.userInteractionEnabled = NO;
    toStoreTxt.placeholder = NSLocalizedString(@"to_store", nil);
    toStoreTxt.delegate = self;
    [toStoreTxt awakeFromNib];
    
    searchItemsTxt = [[CustomTextField alloc] init];
    searchItemsTxt.placeholder = NSLocalizedString(@"search_issue_id", nil);
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
    
    /*Creation of UIButton used in this page*/
    
    //UIButton used for dropDowns....
    UIButton * zoneIdBtn;
    UIButton * outletIdBtn;
    UIButton * categoryBtn;
    UIButton * subCategoryBtn;
    UIButton * brandBtn;
    UIButton * modelBtn;
    UIButton * startDteBtn;
    UIButton * endDateBtn;
    UIButton * statusBtn;
    UIButton * selectToStoreBtn;
    
    //UIButton used for searching, clearing and newStockIssue functionalities....
    UIButton * clearBtn;
    UIButton * newStockIssueBtn;
    
    zoneIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoneIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [zoneIdBtn addTarget:self action:@selector(displayZone) forControlEvents:UIControlEventTouchDown];
    
    zoneIdBtn.hidden = YES;
    
    outletIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outletIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [outletIdBtn addTarget:self action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];
    
    categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [categoryBtn addTarget:self action:@selector(showAllLocationWiseCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    subCategoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subCategoryBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [subCategoryBtn addTarget:self action:@selector(showAllSubCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    brandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [brandBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [brandBtn addTarget:self action:@selector(showBrandList:) forControlEvents:UIControlEventTouchDown];
    
    modelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modelBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [modelBtn addTarget:self  action:@selector(showModelList:) forControlEvents:UIControlEventTouchDown];
    
    startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:dateImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    endDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDateBtn setBackgroundImage:dateImg forState:UIControlStateNormal];
    [endDateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [statusBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [statusBtn addTarget:self action:@selector(showWorkFlowStatus:) forControlEvents:UIControlEventTouchDown];
    
    selectToStoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectToStoreBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [selectToStoreBtn addTarget:self action:@selector(showAllToStoreLocations:) forControlEvents:UIControlEventTouchDown];
    
    
    //used for identification propous....
    startDteBtn.tag = 2;
    endDateBtn.tag = 4;
    
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self
                  action:@selector(searchTheProducts) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.tag = 2;
    
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFiltersInSearch) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    newStockIssueBtn = [[UIButton alloc] init];
    [newStockIssueBtn addTarget:self action:@selector(newStockIssue:) forControlEvents:UIControlEventTouchDown];
    newStockIssueBtn.layer.cornerRadius = 3.0f;
    newStockIssueBtn.backgroundColor = [UIColor grayColor];
    [newStockIssueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    /*Creation of UIScrollView....*/
    stockIssueScrollView = [[UIScrollView alloc] init];
    
    // Creation of header label....
    
    sNoLbl = [[CustomLabel alloc] init];
    [sNoLbl awakeFromNib];
    
    issueRefLbl = [[CustomLabel alloc] init];
    [issueRefLbl awakeFromNib];
    
    issueFromLbl = [[CustomLabel alloc] init];
    [issueFromLbl awakeFromNib];
    
    dateLbl = [[CustomLabel alloc] init];
    [dateLbl awakeFromNib];
    
    issueToLbl = [[CustomLabel alloc] init];
    [issueToLbl awakeFromNib];
    
    noOfItemsLbl = [[CustomLabel alloc] init];
    [noOfItemsLbl awakeFromNib];
    
    issueQtyLbl = [[CustomLabel alloc] init];
    [issueQtyLbl awakeFromNib];
    
    issuedByLbl = [[CustomLabel alloc] init];
    [issuedByLbl awakeFromNib];
    
    
    receivedQtyLbl = [[CustomLabel alloc] init];
    [receivedQtyLbl awakeFromNib];
    
    statusLbl = [[CustomLabel alloc] init];
    [statusLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    
    /*Creation  of UIButton's used at bottam of the page....*/
    UIButton * submitBtn;
    UIButton * cancelBtn;
    
    submitBtn = [[UIButton alloc] init] ;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitMethod:) forControlEvents:UIControlEventTouchDown];
    
    cancelBtn = [[UIButton alloc] init] ;
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 5.0f;
    [cancelBtn addTarget:self action:@selector(cancelMethod:) forControlEvents:UIControlEventTouchDown];
    
    /*Creation  of UIButton's used at bottam of the page....*/
    UILabel * totalIssuesLbl;
    UILabel * totalSaleCostLbl;
    
    totalIssuesLbl = [[UILabel alloc] init];
    totalIssuesLbl.layer.masksToBounds = YES;
    totalIssuesLbl.numberOfLines = 1;
    totalIssuesLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    totalSaleCostLbl = [[UILabel alloc] init];
    totalSaleCostLbl.layer.masksToBounds = YES;
    totalSaleCostLbl.numberOfLines = 1;
    totalSaleCostLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalIssuesValueLbl = [[UILabel alloc] init];
    totalIssuesValueLbl.layer.masksToBounds = YES;
    totalIssuesValueLbl.numberOfLines = 1;
    totalIssuesValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalSaleValueLbl = [[UILabel alloc] init];
    totalSaleValueLbl.layer.masksToBounds = YES;
    totalSaleValueLbl.numberOfLines = 1;
    totalSaleValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalIssuesLbl.textAlignment = NSTextAlignmentLeft;
    totalSaleCostLbl.textAlignment = NSTextAlignmentLeft;
    
    totalIssuesValueLbl.textAlignment = NSTextAlignmentRight;
    totalSaleValueLbl.textAlignment = NSTextAlignmentRight;
    
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
    goButton = [[UIButton alloc] init];
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressed:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    //Allocation of UIView....
    
    totalInventoryView = [[UIView alloc]init];
    totalInventoryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalInventoryView.layer.borderWidth =3.0f;
    
    receiptIdsTbl = [[UITableView alloc] init];
    receiptIdsTbl.dataSource = self;
    receiptIdsTbl.delegate = self;
    receiptIdsTbl.backgroundColor = [UIColor blackColor];
    receiptIdsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //added by Bhargav.v on 09/05/2017....
    /*RequestedItemsTbl Header*/
    requestedItemsTblHeaderView = [[UIView alloc] init];
    //requestedItemsTblHeaderView.backgroundColor = [UIColor redColor];
    
    /*Creation of the UILabels*/
    
    itemNoLbl = [[CustomLabel alloc] init];
    [itemNoLbl awakeFromNib];
    
    itemSkuIDLbl = [[CustomLabel alloc] init];
    [itemSkuIDLbl awakeFromNib];
    
    itemDescLbl = [[CustomLabel alloc] init];
    [itemDescLbl awakeFromNib];
    
    itemIssueQtyLbl = [[CustomLabel alloc] init];
    [itemIssueQtyLbl awakeFromNib];
    
    itemPriceLbl = [[CustomLabel alloc] init];
    [itemPriceLbl awakeFromNib];
    
    itemGradeLbl = [[CustomLabel alloc] init];
    [itemGradeLbl awakeFromNib];
    
    @try {
        
        //setting title label text....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        //setting text for headerLabel....
        headerNameLbl.text = NSLocalizedString(@"stock_issue_summary", nil);
        
        //setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search",nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear",nil) forState:UIControlStateNormal];
        [newStockIssueBtn setTitle:NSLocalizedString(@"new_issue", nil) forState:UIControlStateNormal];
        
        //setting  text for UILabels used on top of the table....
        sNoLbl.text = NSLocalizedString(@"S_NO", nil);
        issueRefLbl.text = NSLocalizedString(@"issue_ref", nil);
        issueFromLbl.text = NSLocalizedString(@"issue_from", nil);
        dateLbl.text = NSLocalizedString(@"issue_date", nil);
        issueToLbl.text = NSLocalizedString(@"issue_to", nil);
        issuedByLbl.text = NSLocalizedString(@"issued_by", nil);
        issueQtyLbl.text = NSLocalizedString(@"qty", nil);
        receivedQtyLbl.text = NSLocalizedString(@"received_qty", nil);
        noOfItemsLbl.text = NSLocalizedString(@"sku_count", nil);
        statusLbl.text = NSLocalizedString(@"status", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        //setting text for the UILabels....
        totalIssuesLbl.text = NSLocalizedString(@"total_issues_:", nil);
        totalSaleCostLbl.text = NSLocalizedString(@"total_sale_cost_:", nil);
        totalIssuesValueLbl.text = @"0.0";
        totalSaleValueLbl.text = @"0.0";
        
        //Header Label Strings under Grid Level....
        
        itemNoLbl.text = NSLocalizedString(@"s_no", nil);
        itemSkuIDLbl.text = NSLocalizedString(@"sku_id", nil);
        itemDescLbl.text = NSLocalizedString(@"sku_desc", nil);
        itemPriceLbl.text = NSLocalizedString(@"price", nil);
        itemIssueQtyLbl.text = NSLocalizedString(@"issue_qty", nil);
        
        itemGradeLbl.text = NSLocalizedString(@"grade", nil);
        
        //setting title label text of the UIButton's used at bottam of the page....
        [submitBtn setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
        
        pagesLbl.text = NSLocalizedString(@"pages",nil);
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
        
        
    } @catch (NSException * exception) {
        
    }
    @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    [goodsIssueView addSubview:headerNameLbl];
    [goodsIssueView addSubview:summaryInfoBtn];
    [goodsIssueView addSubview:zoneIdTxt];
    [goodsIssueView addSubview:outletIdTxt];
    [goodsIssueView addSubview:categoryTxt];
    [goodsIssueView addSubview:subCategoryTxt];
    [goodsIssueView addSubview:brandTxt];
    [goodsIssueView addSubview:modelTxt];
    [goodsIssueView addSubview:startDateTxt];
    [goodsIssueView addSubview:endDateTxt];
    [goodsIssueView addSubview:statusTxt];
    [goodsIssueView addSubview:toStoreTxt];
    
    
    [goodsIssueView addSubview: zoneIdBtn];
    [goodsIssueView addSubview: outletIdBtn];
    [goodsIssueView addSubview: categoryBtn];
    [goodsIssueView addSubview: subCategoryBtn];
    [goodsIssueView addSubview: brandBtn];
    [goodsIssueView addSubview: modelBtn];
    [goodsIssueView addSubview: startDteBtn];
    [goodsIssueView addSubview: endDateBtn];
    [goodsIssueView addSubview: statusBtn];
    [goodsIssueView addSubview: selectToStoreBtn];
    
    
    [goodsIssueView addSubview: searchBtn];
    [goodsIssueView addSubview: clearBtn];
    [goodsIssueView addSubview: newStockIssueBtn];
    [goodsIssueView addSubview: searchItemsTxt];
    
    [goodsIssueView addSubview:submitBtn];
    [goodsIssueView addSubview:cancelBtn];
    
    [goodsIssueView addSubview:pagesLbl];
    [goodsIssueView addSubview:pagenationTxt];
    [goodsIssueView addSubview:dropDownBtn];
    [goodsIssueView addSubview:goButton];
    
    [stockIssueScrollView addSubview: sNoLbl];
    [stockIssueScrollView addSubview: issueRefLbl];
    [stockIssueScrollView addSubview: issueFromLbl];
    [stockIssueScrollView addSubview: dateLbl];
    [stockIssueScrollView addSubview: issueToLbl];
    [stockIssueScrollView addSubview: issuedByLbl];
    [stockIssueScrollView addSubview: issueQtyLbl];
    [stockIssueScrollView addSubview: receivedQtyLbl];
    [stockIssueScrollView addSubview: noOfItemsLbl];
    [stockIssueScrollView addSubview: statusLbl];
    [stockIssueScrollView addSubview: actionLbl];
    
    [stockIssueScrollView addSubview:receiptIdsTbl];
    
    [goodsIssueView addSubview:stockIssueScrollView];
    
    [totalInventoryView addSubview:totalIssuesLbl];
    [totalInventoryView addSubview:totalSaleCostLbl];
    [totalInventoryView addSubview:totalIssuesValueLbl];
    [totalInventoryView addSubview:totalSaleValueLbl];
    
    [goodsIssueView addSubview:totalInventoryView];
    
    [requestedItemsTblHeaderView addSubview:itemNoLbl];
    [requestedItemsTblHeaderView addSubview:itemSkuIDLbl];
    [requestedItemsTblHeaderView addSubview:itemDescLbl];
    [requestedItemsTblHeaderView addSubview:itemPriceLbl];
    [requestedItemsTblHeaderView addSubview:itemIssueQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemGradeLbl];
    
    [self.view addSubview:goodsIssueView];
    
#pragma mark assiging frame :
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
        }
        else{
        }
        
        //setting for the goodsIssueView...
        goodsIssueView.frame = CGRectMake(2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake( 0, 0, goodsIssueView.frame.size.width, 45);
        
        //seting frame for summaryInfoBtnBtn....
        summaryInfoBtn.frame = CGRectMake( goodsIssueView.frame.size.width - 50,  headerNameLbl.frame.origin.y ,50,50);
        
        //setting first column....
        zoneIdTxt.frame = CGRectMake( goodsIssueView.frame.origin.x +10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, 155, 40);
        
        outletIdTxt.frame = CGRectMake( zoneIdTxt.frame.origin.x, zoneIdTxt.frame.origin.y + zoneIdTxt.frame.size.height + 10, zoneIdTxt.frame.size.width, zoneIdTxt.frame.size.height);
        
        //setting second column....
        categoryTxt.frame = CGRectMake( outletIdTxt.frame.origin.x + outletIdTxt.frame.size.width + 10, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        subCategoryTxt.frame = CGRectMake( categoryTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        //setting third column....
        brandTxt.frame = CGRectMake( categoryTxt.frame.origin.x + categoryTxt.frame.size.width + 10, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        modelTxt.frame = CGRectMake( brandTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        //setting fourth column....
        startDateTxt.frame = CGRectMake( brandTxt.frame.origin.x + brandTxt.frame.size.width + 10, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        endDateTxt.frame = CGRectMake( startDateTxt.frame.origin.x, outletIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        statusTxt.frame = CGRectMake(startDateTxt.frame.origin.x + startDateTxt.frame.size.width + 10, zoneIdTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        toStoreTxt.frame = CGRectMake(statusTxt.frame.origin.x , endDateTxt.frame.origin.y, outletIdTxt.frame.size.width, outletIdTxt.frame.size.height);
        
        
        //setting frames for UIButtons....
        outletIdBtn.frame = CGRectMake((outletIdTxt.frame.origin.x + outletIdTxt.frame.size.width - 45), outletIdTxt.frame.origin.y - 8,  55, 60);
        zoneIdBtn.frame = CGRectMake((zoneIdTxt.frame.origin.x + zoneIdTxt.frame.size.width - 45), zoneIdTxt.frame.origin.y-8,55,60);
        
        //setting for second column row....
        categoryBtn.frame = CGRectMake((categoryTxt.frame.origin.x + categoryTxt.frame.size.width - 45), categoryTxt.frame.origin.y-8,55,60);
        subCategoryBtn.frame = CGRectMake((subCategoryTxt.frame.origin.x + subCategoryTxt.frame.size.width - 45), subCategoryTxt.frame.origin.y-8,55,60);
        
        //setting for third column row....
        brandBtn.frame = CGRectMake( (brandTxt.frame.origin.x + brandTxt.frame.size.width - 45), brandTxt.frame.origin.y - 8,  55, 60);
        modelBtn.frame = CGRectMake( (modelTxt.frame.origin.x + modelTxt.frame.size.width - 45), modelTxt.frame.origin.y - 8,  55, 60);
        
        //setting for fourth column row....
        startDteBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-45), startDateTxt.frame.origin.y+2, 40, 35);
        
        endDateBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-45), endDateTxt.frame.origin.y+2, 40, 35);
        
        statusBtn.frame = CGRectMake((statusTxt.frame.origin.x + statusTxt.frame.size.width - 45), statusTxt.frame.origin.y-8,55,60);
        
        selectToStoreBtn.frame = CGRectMake((toStoreTxt.frame.origin.x + toStoreTxt.frame.size.width - 45), toStoreTxt.frame.origin.y-8,55,60);
        
        //setting for the search field....
        //searchItemsTxt.frame = CGRectMake(10, endDateTxt.frame.origin.y + endDateTxt.frame.size.height + 20, goodsIssueView.frame.size.width -40,40);
        
        searchItemsTxt.frame = CGRectMake(10,outletIdTxt.frame.origin.y+outletIdTxt.frame.size.height+10, statusTxt.frame.origin.x+statusTxt.frame.size.width-(zoneIdTxt.frame.origin.x),40);
        
        newStockIssueBtn.frame = CGRectMake(searchItemsTxt.frame.origin.x + searchItemsTxt.frame.size.width+30,searchItemsTxt.frame.origin.y,160,40);
        //setting for fifth column row....
        
        searchBtn.frame = CGRectMake((( newStockIssueBtn.frame.origin.x + newStockIssueBtn.frame.size.width) - 160), categoryTxt.frame.origin.y, 160, 40);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x, subCategoryTxt.frame.origin.y, searchBtn.frame.size.width, searchBtn.frame.size.height);
        
        //setting frames for the stockIssueScrollView....
        
        float x_position;
        
        x_position = newStockIssueBtn.frame.origin.x + newStockIssueBtn.frame.size.width - searchItemsTxt.frame.origin.x;
        
        stockIssueScrollView.frame =  CGRectMake( searchItemsTxt.frame.origin.x, searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height + 5, x_position+20,435);
        
        submitBtn.frame = CGRectMake(searchItemsTxt.frame.origin.x,goodsIssueView.frame.size.height-45,140,40);
        
        cancelBtn.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+40,submitBtn.frame.origin.y,submitBtn.frame.size.width,submitBtn.frame.size.height);
        
        pagesLbl.frame = CGRectMake(cancelBtn.frame.origin.x+cancelBtn.frame.size.width+20, cancelBtn.frame.origin.y,100,40);
        
        pagenationTxt.frame = CGRectMake(pagesLbl.frame.origin.x+pagesLbl.frame.size.width-20, pagesLbl.frame.origin.y,90,40);
        
        dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width-45), pagenationTxt.frame.origin.y-5, 45, 50);
        
        goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width+15,pagenationTxt.frame.origin.y,80, 40);
        
        totalInventoryView.frame = CGRectMake(searchItemsTxt.frame.origin.x + searchItemsTxt.frame.size.width-80,submitBtn.frame.origin.y -18,270,60);
        
        totalIssuesLbl.frame = CGRectMake(5,5,120,25);
        totalSaleCostLbl.frame = CGRectMake(totalIssuesLbl.frame.origin.x,totalIssuesLbl.frame.origin.y+totalIssuesLbl.frame.size.height,130,25);
        
        totalIssuesValueLbl.frame = CGRectMake(totalIssuesLbl.frame.origin.x+totalIssuesLbl.frame.size.width, totalIssuesLbl.frame.origin.y,135,25);
        
        totalSaleValueLbl.frame = CGRectMake(totalIssuesValueLbl.frame.origin.x, totalSaleCostLbl.frame.origin.y,135,25);
        
        //setting frames for the table header labels....
        sNoLbl.frame = CGRectMake(0,0,40,35);
        
        issueRefLbl.frame = CGRectMake( (sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 205, 40.0);
        
        issueFromLbl.frame = CGRectMake((issueRefLbl.frame.origin.x + issueRefLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 95, 40.0);
        
        dateLbl.frame = CGRectMake( (issueFromLbl.frame.origin.x + issueFromLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 90, 40.0);
        
        issueToLbl.frame = CGRectMake((dateLbl.frame.origin.x + dateLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, 40.0);
        
        issuedByLbl.frame = CGRectMake((issueToLbl.frame.origin.x + issueToLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, 40.0);
        
        issueQtyLbl.frame = CGRectMake((issuedByLbl.frame.origin.x + issuedByLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 60, 40.0);
        
        receivedQtyLbl.frame = CGRectMake( (issueQtyLbl.frame.origin.x + issueQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 110, 40.0);
        
        noOfItemsLbl.frame = CGRectMake((receivedQtyLbl.frame.origin.x + receivedQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y,80,40.0);
        
        statusLbl.frame = CGRectMake( (noOfItemsLbl.frame.origin.x + noOfItemsLbl.frame.size.width + 2), sNoLbl.frame.origin.y,75,40.0);
        
        actionLbl.frame = CGRectMake( (statusLbl.frame.origin.x + statusLbl.frame.size.width + 2), sNoLbl.frame.origin.y,70,40.0);
        
        receiptIdsTbl.frame= CGRectMake(0,sNoLbl.frame.origin.y+sNoLbl.frame.size.height, actionLbl.frame.origin.x + actionLbl.frame.size.width+30, stockIssueScrollView.frame.size.height-(sNoLbl.frame.origin.y + sNoLbl.frame.size.height+20));
        
        //stockIssueScrollView.contentSize = CGSizeMake(receiptIdsTbl.frame.origin.x + receiptIdsTbl.frame.size.width, stockIssueScrollView.frame.size.height);
        
        // Frames for the Grid Labels and Table View....
        requestedItemsTblHeaderView.frame = CGRectMake(searchItemsTxt.frame.origin.x, 10, searchItemsTxt.frame.size.width, sNoLbl.frame.size.height);
        
        itemNoLbl.frame = CGRectMake(issueRefLbl.frame.origin.x, 0,70, 30);
        
        itemSkuIDLbl.frame = CGRectMake(itemNoLbl.frame.origin.x + itemNoLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);
        
        itemDescLbl.frame = CGRectMake(itemSkuIDLbl.frame.origin.x + itemSkuIDLbl.frame.size.width + 2, 0, 200, itemSkuIDLbl.frame.size.height);
        
        itemPriceLbl.frame = CGRectMake(itemDescLbl.frame.origin.x + itemDescLbl.frame.size.width + 2, 0, 100, itemDescLbl.frame.size.height);
        
        itemIssueQtyLbl.frame = CGRectMake(itemPriceLbl.frame.origin.x + itemPriceLbl.frame.size.width + 2, 0, 100, itemDescLbl.frame.size.height);
        
        itemGradeLbl.frame = CGRectMake(itemIssueQtyLbl.frame.origin.x + itemIssueQtyLbl.frame.size.width + 2, 0, 100, itemIssueQtyLbl.frame.size.height);
        
        @try {
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:requestedItemsTblHeaderView andSubViews:YES fontSize:16.0f cornerRadius:0];
            
            headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            
            searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
            newStockIssueBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            cancelBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
        } @catch (NSException *exception) {
            
        }
    }
    else {
        //need to set frame for iPHONE....
    }
    
    //table's used in popUp's.......
    
    categoriesListTbl = [[UITableView alloc] init];
    subCategoriesListTbl = [[UITableView alloc] init];
    brandListTbl = [[UITableView alloc] init];
    modelListTbl = [[UITableView alloc] init];
    locationTbl = [[UITableView alloc] init];
    workFlowListTbl = [[UITableView alloc] init];
    pagenationTbl = [[UITableView alloc] init];
    toStoreLocationTbl = [[UITableView alloc]init];
    //upto here on 09/05/2017....
    
    requestedItemsTbl = [[UITableView alloc] init];
    requestedItemsTbl.dataSource = self;
    requestedItemsTbl.delegate = self;
    requestedItemsTbl.backgroundColor = [UIColor blackColor];
    requestedItemsTbl.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    
    //Used for Identification purpose...
    categoryTxt.tag = 2;
    brandTxt.tag = 1;
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidAppear.......
 * @date
 * @method       viewWillAppear
 * @author       Bhargav.v
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By on 13/04/2017...
 * @reason      added comments....
 *
 */

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    @try {
        [HUD setHidden:NO];
        
        startIndexInt = 0;
        
        receiptDetails = [NSMutableArray new];
        
        [self callingGetStockIssue];
        
        
    } @catch (NSException * exception) {
        NSLog(@"----exception in serviceCall of callingGetStockReqeusts------------%@",exception);
    } @finally {
        
    }
}
#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         27/02/2017
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


/**
 * @description   in this method we will call the services....
 * @method        callingGetStockIssue
 * @author        Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By  ...
 * @reason       added comments....
 *
 */

-(void)callingGetStockIssue {
    
    @try {
        
        [HUD setHidden:NO];
        
        if(receiptDetails == nil && startIndexInt == 0){
            
            totalNumberOfRecords = 0;
            
            receiptDetails = [NSMutableArray new];
        }
        else if(receiptDetails.count ){
            
            [receiptDetails removeAllObjects];
        }
        
        NSString * categoryStr = categoryTxt.text;
        NSString * subCategoryStr = subCategoryTxt.text;
        NSString * modelStr = modelTxt.text;
        NSString * brandStr = brandTxt.text;
        NSString * statusStr = statusTxt.text;
        NSString * toStoreLocationStr = toStoreTxt.text;
        
        NSString * startDteStr = startDateTxt.text;
        if((startDateTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@", startDateTxt.text,@" 00:00:00"];
        
        NSString * endDteStr  = endDateTxt.text;
        if ((endDateTxt.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        }
        
        if (categoriesListTbl.tag == 0 || (categoryTxt.text).length == 0 || categoriesListTbl.tag == 4)
            
            categoryStr = @"";
        
        if (subCategoriesListTbl.tag == 0 || (subCategoryTxt.text).length == 0)
            
            subCategoryStr = @"";
        
        if (brandListTbl.tag == 0  || (brandTxt.text).length == 0)
            
            brandStr = @"";
        
        if (modelListTbl.tag == 0  || (modelTxt.text).length == 0)
            
            modelStr = @"";
        
        
        //        if (brandListTbl.tag == 0  || [brandTxt.text length] == 0)
        //
        //            brandStr = @"";
        //
        //        if (modelListTbl.tag == 0  || [modelTxt.text length] == 0)
        //
        //            modelStr = @"";
        //
        if (workFlowListTbl.tag == 0  || (statusTxt.text).length == 0)
            
            statusStr = @"";
        
        if (toStoreLocationTbl.tag == 0 || (toStoreTxt.text).length == 0) {
            
            toStoreLocationStr = @"";
        }
        
        
        
        NSMutableDictionary * IssueDictionary = [[NSMutableDictionary alloc]init];
        
        //setting requestHeader....
        IssueDictionary[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        IssueDictionary[START_INDEX] = [NSString stringWithFormat:@"%d",startIndexInt];
        IssueDictionary[SEARCH_CRITERIA] = searchItemsTxt.text;
        
        //setting the kShippedFrom as storeLocation....
        
        IssueDictionary[kShippedFrom] = presentLocation;
        
        IssueDictionary[MAX_RECORDS] = @"10";
        
        if(searchBtn.tag == 2){
            categoryStr = @"";
            subCategoryStr = @"";
            modelStr = @"";
            brandStr = @"";
            startDteStr = @"";
            endDteStr = @"";
            statusStr = @"";
            toStoreLocationStr = @"";
            
        }
        
        IssueDictionary[kcategory] = categoryStr;
        IssueDictionary[kSubCategory] = subCategoryStr;
        IssueDictionary[MODEL] = modelStr;
        IssueDictionary[kBrand] = brandStr;
        IssueDictionary[START_DATE] = startDteStr;
        IssueDictionary[END_DATE] = endDteStr;
        IssueDictionary[STATUS] = statusStr;
        IssueDictionary[kIssuedTo] = toStoreLocationStr;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:IssueDictionary options:0 error:&err];
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController getStockIssue:getStockIssueJsonString];
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        //upto here on 17/01/2016....
        
    }
    @finally {
        
    }
    
}

# pragma mark Service Calls....

/**
 * @description  here calling the service to getAllLocations............
 * @date         20/09/2016
 * @method       getLocations
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocations {
    
    @try {
        
        if(toStoreLocationArr == nil)
            toStoreLocationArr = [NSMutableArray new];
        
        //if(zoneListArr == nil)
        //zoneListArr = [NSMutableOrderedSet new];
        
        //if(zoneWiseLocationDic == nil)
        //zoneWiseLocationDic = [NSMutableDictionary new];
        
        NSArray *loyaltyKeys = @[START_INDEX,REQUEST_HEADER];
        
        NSArray *loyaltyObjects = @[NEGATIVE_ONE,[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
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
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:zoneDic options:0 error:&err_];
        NSString * zoneJsonStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
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
 * @description  here we are calling the getDepartmentList services.....
 * @date         31/03/2017
 * @method       callingDepartmentList
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
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling callingCategoriesList ServicesCall ----%@",exception);
        
    }
    @finally {
        
    }
}


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
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @finally {
        
    }
    
}


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
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
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

-(void)getWorkFlows {
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        
        workFlowsArr = [NSMutableArray new];
        
        NSMutableDictionary * workFlowDic = [[NSMutableDictionary alloc]init];
        
        [workFlowDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [workFlowDic setValue:STOCK_ISSUE forKey:BUSINESSFLOW];
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
        
        [locationDictionary setValue:NEGATIVE_ONE forKey:START_INDEX_STR];
        
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



#pragma mark Displaying PopOver....


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
        }
        if(locationArr.count){
            float tableHeight = locationArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = locationArr.count * 33;
            
            if(locationArr.count > 5)
                tableHeight = (tableHeight/locationArr.count) * 5;
            
            zoneIdTxt.tag = 2;
            outletIdTxt.tag = 0;
            
            [self showPopUpForTables:locationTbl  popUpWidth:(outletIdTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:outletIdTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--exception in the StockIssueView in showAllOutletId:--%@",exception);
        
        NSLog(@"--exception while creating the popUp in StockIssueView--%@",exception);
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

- (void)showAllToStoreLocations:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(toStoreLocationArr == nil ||  toStoreLocationArr.count == 0){
            
            [HUD setHidden:NO];
            //changed on 17/02/2017....
            [self getLocations];
        }
        if(toStoreLocationArr.count){
            float tableHeight = toStoreLocationArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = toStoreLocationArr.count * 33;
            
            if(toStoreLocationArr.count > 5)
                tableHeight = (tableHeight/toStoreLocationArr.count) * 5;
            
            [self showPopUpForTables:toStoreLocationTbl  popUpWidth:(toStoreTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:toStoreTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--exception in the StockIssueView in showAllOutletId:--%@",exception);
        
        NSLog(@"--exception while creating the popUp in StockIssueView--%@",exception);
    }
}




/**
 * @description  showing the availiable  Shipment modes.......
 * @date         03/04/2017....
 * @method       showDepartmentList:
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
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        float tableHeight = categoriesListArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = categoriesListArr.count * 33;
        
        if(categoriesListArr.count > 5)
            tableHeight =(tableHeight/categoriesListArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showSubDepartments:
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
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_atleast_one_category", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
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
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        
        
        float tableHeight = subCategoriesListArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoriesListArr.count * 33;
        
        if(subCategoriesListArr.count > 5)
            tableHeight = (tableHeight/subCategoriesListArr.count) * 5;
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:(subCategoryTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         16/03/2017....
 * @method       showBrandList:
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showBrandList:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((locationWiseBrandsArr == nil) || (locationWiseBrandsArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self getBrandsByLocation];
            return;
        }
        
        [HUD setHidden:YES];
        
        if(locationWiseBrandsArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        float tableHeight = locationWiseBrandsArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationWiseBrandsArr.count * 33;
        
        if(locationWiseBrandsArr.count > 5)
            tableHeight = (tableHeight/locationWiseBrandsArr.count) * 5;
        
        [self showPopUpForTables:brandListTbl  popUpWidth:(brandTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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

-(void)showModelList:(UIButton *)sender{
    
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
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        
        float tableHeight = ModelListArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = ModelListArray.count * 33;
        
        if(ModelListArray.count > 5)
            tableHeight = (tableHeight/ModelListArray.count) * 5;
        
        [self showPopUpForTables:modelListTbl  popUpWidth:(modelTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:modelTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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

-(void)showWorkFlowStatus:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [self getWorkFlows];
        
        [HUD setHidden:YES];
        
        if(workFlowsArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = workFlowsArr.count *40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = workFlowsArr.count * 33;
        
        if(workFlowsArr.count>5)
            tableHeight = (tableHeight/workFlowsArr.count) * 5;
        
        [self showPopUpForTables:workFlowListTbl  popUpWidth:(statusTxt.frame.size.width *1.5)  popUpHeight:tableHeight presentPopUpAt:statusTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


/**
 * @description
 * @date         31/10/2017
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
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = pagenationArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArr.count   * 33;
        
        if(pagenationArr.count> 5)
            tableHeight = (tableHeight/pagenationArr.count) * 5;
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionLeft ];
        
        
    } @catch (NSException * exception) {
        
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
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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

-(void)searchTheProducts {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        searchBtn.tag  = 4;
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0 && (brandTxt.text).length == 0 && (modelTxt.text).length== 0 && (startDateTxt.text).length == 0 && (endDateTxt.text).length== 0 && (statusTxt.text).length == 0 && (outletIdTxt.text).length == 0   &&  (toStoreTxt.text).length == 0 ) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_above_fields_before_proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        
        else
            
            [HUD setHidden:NO];
        
        startIndexInt = 0;
        
        [self callingGetStockIssue];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
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

-(void)clearAllFiltersInSearch{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        searchBtn.tag  = 2;
        
        categoryTxt.text    = @"";
        subCategoryTxt.text = @"";
        brandTxt.text       = @"";
        modelTxt.text       = @"";
        startDateTxt.text   = @"";
        endDateTxt.text     = @"";
        statusTxt.text      = @"";
        toStoreTxt.text     = @"";
        
        startIndexInt = 0;
        
        [self callingGetStockIssue];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}


#pragma mark Service Call Response....

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified BY Srinivasulu on 13/04/2017..
 * @reason      placed the conduction as well as the
 */

- (void)getStockIssueSuccessResponse:(NSDictionary *)sucessDictionary {
    @try {
        
        //added on 23/05/2017....
        float totalSaleCost = 0;
        float totalIssues = 0;
        
        if((totalIssuesValueLbl.text).length)
            totalIssues = (totalIssuesValueLbl.text).floatValue;
        
        if (![[sucessDictionary valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[sucessDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
            
            totalNumberOfRecords = (int)[[sucessDictionary valueForKey:TOTAL_SKUS] integerValue];
            
            for(NSDictionary * dic in [sucessDictionary valueForKey:kIssueIds]){
                
                for( NSDictionary * locDic in [dic valueForKey:RECEIPT_DETAILS] )
                    totalSaleCost  =  totalSaleCost+[[self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"] floatValue];
                
                [receiptDetails addObject:dic];
            }
        }
        
        totalIssues = receiptDetails.count;
        totalIssuesValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", totalIssues];
        
        totalSaleValueLbl.text  =  [NSString stringWithFormat:@"%@%.2f",@"", totalSaleCost];
        
        
        // This functionality is implemented for the sake of pagenation based on the Total Records...
        // Date: 31/10/2017...
        // Implemented By Bhargav.v ....
        
        int strTotalRecords = totalNumberOfRecords/10;
        int remainder = totalNumberOfRecords % 10;
        
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
        // Up to here on 31/10/2017...
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        
        if(startIndexInt == 0) {
            pagenationTxt.text = @"1";
        }
        
        
        [HUD setHidden: YES];
        [receiptIdsTbl reloadData];
    }
    
}

/**
 * @description  we are displaying the stockIssue Error Response...
 * @date
 * @method       getStockIssueErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified BY Srinivasulu on 13/04/2017..
 * @reason
 */

- (void)getStockIssueErrorResponse:(NSString *)error {
    @try {
        
        
        if(receiptDetails.count == 0){
            
            [HUD setHidden:YES];
            
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItemsTxt.isEditing)
                y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",error];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD hide: YES];
        [receiptIdsTbl reloadData];
        [requestedItemsTbl reloadData];
        
        totalIssuesValueLbl.text = [NSString stringWithFormat:@"%@%@",@"",@"0.00"];
        totalSaleValueLbl.text = [NSString stringWithFormat:@"%@%@",@"",@"0.00"];
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

-(void)getLocationSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        NSArray * locations = [successDictionary valueForKey:LOCATIONS_DETAILS];
        
        if (locations.count!= 0 && toStoreLocationArr.count == 0) {
            
            [toStoreLocationArr addObject:NSLocalizedString(@"all_outlets",nil) ];
            
            for (NSDictionary * locationDic in locations) {
                
                [toStoreLocationArr addObject:[locationDic  valueForKey:LOCATION_ID]];
            }
            
            // if([toStoreLocationArr count])
            //[zoneWiseLocationDic setObject:locationArr forKey:NSLocalizedString(@"all_outlets",nil) ];
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
 */

-(void)getLocationErrorResponse:(NSString *)errorResponse{
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        if(receiptDetails.count)
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

-(void)getCategorySuccessResponse:(NSDictionary *)sucessDictionary {
    
    @try {
        
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
        
        NSString * mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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
        
        for (NSDictionary * brand in  [sucessDictionary valueForKey:BRAND_DETAILS ]) {
            
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
    
    if(searchItemsTxt.isEditing)
        y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
    
    
    NSString *mesg = [NSString stringWithFormat:@"%@",error];
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
}

// newly added on 24/05/2017  by Bhargav


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
    
    if(searchItemsTxt.isEditing)
        y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
    
    
    NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
    
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
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
            
            [self showBrandList:nil];
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





#pragma mark navigation methods:

/**
 * @description  here we are showing the list of Issued Items.......
 * @date         26/09/2016
 * @method       openEditStockRequestView;
 * @author       bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By Srinivasulu on 13/04/2017...
 * @reason added comments && added the exception handling....
 */

-(void)newStockIssue:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        for (int i; i<receiptDetails.count;i++) {
        }
        
        NewStockIssue * controller = [[NewStockIssue alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        
    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  here we are showing the list of Issued Items.......
 * @date         26/09/2016
 * @method       openStockIssue..
 * @author       bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)openStockIssue:(UIButton*)sender {
    
    @try {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        BOOL isDraft = false;
        
        NewStockIssue * stockIssue = [[NewStockIssue alloc] init];
        
        if (receiptDetails.count > sender.tag) {
            
            NSString * DraftStr;
            
            DraftStr  = [receiptDetails[sender.tag] valueForKey:STATUS];
            
            if ([DraftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
                
                isDraft = true;
            }
        }
        
        if(isDraft) {
            
            stockIssue.IssueId = [receiptDetails[sender.tag] valueForKey:kGoodsIssueRef];
            
            [self.navigationController pushViewController:stockIssue animated:YES];
        }
        
        else if(!isDraft) {
            
            OpenStockIssue * viewStock = [[OpenStockIssue alloc] init ];
            viewStock.IssueId = [receiptDetails[sender.tag] valueForKey:kGoodsIssueRef];
            [self.navigationController pushViewController:viewStock animated:YES];
            
        }
        
        
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception will navigation the View -----------%@",exception);
        
    } @finally {
        
    }
    
}

#pragma -mark used to display calender....

/**
 * @description  in this method we will show the calender in popUp....
 * @method       selectrequiredDate:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments....
 *
 */

-(void)showCalenderInPopUp:(UIButton *)sender  {
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
        
        UIButton  * pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
        
        UIButton  * clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        
        //        pickButton.backgroundColor = [UIColor grayColor];
        
        //        clearButton.backgroundColor = [UIColor clearColor];
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:goodsIssueView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
                //callServices = true;
                
                startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                //callServices = true;
                
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


#pragma mark text Fied Delegates:
/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date
 * @method       textFieldDidChange:
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */


-(void)textFieldDidChange:(UITextField *)textField  {
    @try {
        
        if (textField == searchItemsTxt) {
            
            if ((textField.text).length >= 4) {
                [HUD show:YES];
                [HUD  setHidden: NO];
                
                startIndexInt = 0;
                receiptDetails = [NSMutableArray new];
                
                [self callingGetStockIssue];
            }
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma mark Table view delegates:



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
    
    if (tableView == receiptIdsTbl) {
        if (receiptDetails.count)
            
            return receiptDetails.count;
        else
            return 1;
    }
    return 1;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if(tableView == receiptIdsTbl){
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
    else if(tableView == workFlowListTbl){
        
        return workFlowsArr.count;
    }
    else if (tableView == pagenationTbl) {
        
        return pagenationArr.count;
    }
    
    else if (tableView == toStoreLocationTbl) {
        
        return toStoreLocationArr.count;
    }
    
    else return 0;
}

/**
 * @description  we are configuring the height of the RowAtIndexpath level..
 * @date
 * @method       heightForRowAtIndexPath
 * @author       Bhargav.v
 * @param        NSIndexPath
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == receiptIdsTbl){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (indexPath.row == 0) {
                return 38;
            }
            else{
                if (requestedItemsInfoArr.count > 4 ) {
                    return (40 * 4) + 30;
                }
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
    
    else if(tableView == requestedItemsTbl || tableView == locationTbl || tableView == categoriesListTbl ||tableView ==subCategoriesListTbl || tableView == brandListTbl || tableView == modelListTbl || tableView ==  workFlowListTbl ||tableView == pagenationTbl  || tableView == toStoreLocationTbl ){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 40;
        }
        else {
            return 0.0;
        }
    }
    
    return 0;
}

/**
 * @description  we are configuring the cellForRowAtIndexPath Table level..
 * @date
 * @method       heightForRowAtIndexPath
 * @author       Bhargav.v
 * @param        NSIndexPath
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == receiptIdsTbl) {
        
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!= 0){
            // if (self.isOpen&&indexPath.row!=0) {
            
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
                    
                    hlcell.frame = CGRectMake(receiptIdsTbl.frame.origin.x, 0,receiptIdsTbl.frame.size.width,  40 * 4  + 50);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x, +10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    requestedItemsTbl.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height +5,requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height - 80);
                }
                else {
                    
                    hlcell.frame = CGRectMake(receiptIdsTbl.frame.origin.x,0,receiptIdsTbl.frame.size.width,(40* (requestedItemsInfoArr.count+2)+40));
                    
                    requestedItemsTblHeaderView.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x, 0 + 10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    requestedItemsTbl.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height+5,requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height-120);
                }
            }
            else {
                if (requestedItemsInfoArr.count >4) {
                    hlcell.frame = CGRectMake(15,0,receiptIdsTbl.frame.size.width-15,30*4);
                    requestedItemsTbl.frame = CGRectMake(hlcell.frame.origin.x+10,hlcell.frame.origin.y,hlcell.frame.size.width-10,hlcell.frame.size.height);
                }
                else{
                    hlcell.frame = CGRectMake(25,0,receiptIdsTbl.frame.size.width-25,requestedItemsInfoArr.count*30);
                    requestedItemsTbl.frame = CGRectMake(hlcell.frame.origin.x + 10,hlcell.frame.origin.y,hlcell.frame.size.width - 10, requestedItemsInfoArr.count*30);
                }
            }
            [requestedItemsTbl reloadData];
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
        
        else{
            
            @try {
                
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
                    
                    @try {
                        layer_1 = [CAGradientLayer layer];
                        layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                        
                        layer_1.frame = CGRectMake(sNoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(sNoLbl.frame.origin.x),1);
                        
                        [hlcell.contentView.layer addSublayer:layer_1];
                        
                    } @catch (NSException *exception) {
                        
                    }
                }
                
                
                tableView.separatorColor = [UIColor clearColor];
                
                UILabel * s_no_Lbl = [[UILabel alloc] init];
                s_no_Lbl.backgroundColor = [UIColor clearColor];
                s_no_Lbl.textAlignment = NSTextAlignmentCenter;
                s_no_Lbl.numberOfLines = 1;
                s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                UILabel * issue_Ref_Lbl = [[UILabel alloc] init];
                issue_Ref_Lbl.backgroundColor = [UIColor clearColor];
                issue_Ref_Lbl.textAlignment = NSTextAlignmentCenter;
                issue_Ref_Lbl.numberOfLines = 1;
                issue_Ref_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                
                UILabel * issueFrom_Lbl = [[UILabel alloc] init];
                issueFrom_Lbl.backgroundColor = [UIColor clearColor];
                issueFrom_Lbl.textAlignment = NSTextAlignmentCenter;
                issueFrom_Lbl.numberOfLines =1;
                issueFrom_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                UILabel * date_Lbl= [[UILabel alloc] init];
                date_Lbl.backgroundColor = [UIColor clearColor];
                date_Lbl.textAlignment = NSTextAlignmentCenter;
                date_Lbl.numberOfLines = 1;
                date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
                
                
                UILabel * Issued_To_Lbl = [[UILabel alloc] init];
                Issued_To_Lbl.backgroundColor =  [UIColor clearColor];
                Issued_To_Lbl.textAlignment = NSTextAlignmentCenter;
                Issued_To_Lbl.numberOfLines = 1;
                
                UILabel * noOf_temsLbl = [[UILabel alloc] init];
                noOf_temsLbl.backgroundColor =  [UIColor clearColor];
                noOf_temsLbl.textAlignment = NSTextAlignmentCenter;
                noOf_temsLbl.numberOfLines = 1;
                
                UILabel * issueQty_Lbl = [[UILabel alloc] init];
                issueQty_Lbl.backgroundColor =  [UIColor clearColor];
                issueQty_Lbl.textAlignment = NSTextAlignmentCenter;
                issueQty_Lbl.numberOfLines = 1;
                
                UILabel * issuedBy_LBl = [[UILabel alloc] init];
                issuedBy_LBl.backgroundColor =  [UIColor clearColor];
                issuedBy_LBl.textAlignment = NSTextAlignmentCenter;
                issuedBy_LBl.numberOfLines = 1;
                
                UILabel * receivedQty_Lbl = [[UILabel alloc] init];
                receivedQty_Lbl.backgroundColor =  [UIColor clearColor];
                receivedQty_Lbl.textAlignment = NSTextAlignmentCenter;
                receivedQty_Lbl.numberOfLines = 1;
                
                UILabel * status_Lbl = [[UILabel alloc] init];
                status_Lbl.backgroundColor =  [UIColor clearColor];
                status_Lbl.textAlignment = NSTextAlignmentCenter;
                status_Lbl.numberOfLines = 1;
                
                openGoodsIssueBtn = [[UIButton alloc] init];
                //openGoodsIssueBtn.backgroundColor = [UIColor blackColor];
                openGoodsIssueBtn.titleLabel.textColor =  [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
                openGoodsIssueBtn.userInteractionEnabled = YES;
                openGoodsIssueBtn.tag = indexPath.section;
                [openGoodsIssueBtn addTarget:self action:@selector(openStockIssue:) forControlEvents:UIControlEventTouchUpInside];
                [openGoodsIssueBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                
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
                issue_Ref_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                issueFrom_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                Issued_To_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                noOf_temsLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                issueQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                issuedBy_LBl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                receivedQty_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
                status_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                
                //setting frame....
                s_no_Lbl.frame = CGRectMake( 0, 0, sNoLbl.frame.size.width + 1, hlcell.frame.size.height);
                
                issue_Ref_Lbl.frame = CGRectMake(issueRefLbl.frame.origin.x, 0, issueRefLbl.frame.size.width,  hlcell.frame.size.height);
                
                
                issueFrom_Lbl.frame = CGRectMake(issueFromLbl.frame.origin.x, 0, issueFromLbl.frame.size.width ,  hlcell.frame.size.height);
                
                date_Lbl.frame = CGRectMake(dateLbl.frame.origin.x, 0, dateLbl.frame.size.width ,  hlcell.frame.size.height);
                
                Issued_To_Lbl.frame = CGRectMake(issueToLbl.frame.origin.x, 0, issueToLbl.frame.size.width ,  hlcell.frame.size.height);
                
                issuedBy_LBl.frame = CGRectMake(issuedByLbl.frame.origin.x,0,issuedByLbl.frame.size.width ,  hlcell.frame.size.height);
                
                issueQty_Lbl.frame = CGRectMake(issueQtyLbl.frame.origin.x, 0,issueQtyLbl.frame.size.width ,  hlcell.frame.size.height);
                
                receivedQty_Lbl.frame = CGRectMake(receivedQtyLbl.frame.origin.x,0,receivedQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                noOf_temsLbl.frame = CGRectMake(noOfItemsLbl.frame.origin.x, 0,noOfItemsLbl.frame.size.width ,  hlcell.frame.size.height);
                
                status_Lbl.frame = CGRectMake(statusLbl.frame.origin.x,0,statusLbl.frame.size.width ,  hlcell.frame.size.height);
                
                openGoodsIssueBtn.frame = CGRectMake(actionLbl.frame.origin.x,0,actionLbl.frame.size.width,  hlcell.frame.size.height);
                
                viewListOfItemsBtn.frame = CGRectMake(openGoodsIssueBtn.frame.origin.x+openGoodsIssueBtn.frame.size.width-15,10,30,30);
                
                [hlcell.contentView addSubview:s_no_Lbl];
                [hlcell.contentView addSubview:issue_Ref_Lbl];
                [hlcell.contentView addSubview:issueFrom_Lbl];
                [hlcell.contentView addSubview:date_Lbl];
                [hlcell.contentView addSubview:Issued_To_Lbl];
                [hlcell.contentView addSubview:issueQty_Lbl];
                [hlcell.contentView addSubview:noOf_temsLbl];
                [hlcell.contentView addSubview:issuedBy_LBl];
                [hlcell.contentView addSubview:receivedQty_Lbl];
                [hlcell.contentView addSubview:status_Lbl];
                //[hlcell.contentView addSubview:action_Lbl];
                [hlcell.contentView addSubview:openGoodsIssueBtn];
                [hlcell.contentView addSubview:viewListOfItemsBtn];
                
                //setting frame and font........
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
                    openGoodsIssueBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    [openGoodsIssueBtn setTitle:NSLocalizedString(@"Open", nil) forState:UIControlStateNormal];
                    
                }
                else {
                    
                }
                //setting frame and font.......
                
                @try {
                    
                    if (receiptDetails.count >= indexPath.section && receiptDetails.count ) {
                        
                        NSDictionary * dic = receiptDetails[indexPath.section];
                        
                        s_no_Lbl.text = [NSString stringWithFormat:@"%i",(int)(indexPath.section + 1)+startIndexInt];
                        
                        issue_Ref_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kGoodsIssueRef] defaultReturn:@"--"];
                        issueFrom_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kShippedFrom] defaultReturn:@"--"];
                        
                        date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:kCreatedDateStr] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
                        
                        Issued_To_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kIssuedTo] defaultReturn:@"--"];
                        
                        float items = 0;
                        for (NSDictionary * locDic in  [dic valueForKey:RECEIPT_DETAILS]) {
                            
                            items =  [[receiptDetails[indexPath.section] valueForKey:RECEIPT_DETAILS] count];
                            receivedQty_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic valueForKey:kReceived] defaultReturn:@"0.00"]  floatValue]];
                        }
                        
                        noOf_temsLbl.text =[NSString stringWithFormat:@"%.2f",items];
                        
                        issueQty_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:ISSUE_TOTAL_QTY] defaultReturn:@"0.00"] floatValue]];
                        
                        issuedBy_LBl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kIssuedBy] defaultReturn:@"--"];
                        
                        status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS] defaultReturn:@"--"];
                    }
                    else {
                        s_no_Lbl.text = @"--";
                        issue_Ref_Lbl.text = @"--";
                        issueFrom_Lbl.text = @"--";
                        date_Lbl.text = @"--";
                        Issued_To_Lbl.text = @"--";
                        noOf_temsLbl.text = @"--";
                        issueQty_Lbl.text = @"--";
                        issuedBy_LBl.text = @"--";
                        receivedQty_Lbl.text = @"--";
                        status_Lbl.text = @"--";
                        [openGoodsIssueBtn setTitle:NSLocalizedString(@"--",nil) forState:UIControlStateNormal];
                        openGoodsIssueBtn.userInteractionEnabled = NO;
                        viewListOfItemsBtn.hidden = YES;
                        
                    }
                    
                }
                
                @catch (NSException *exception) {
                    
                } @finally {
                    
                }
                
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.tag = indexPath.row;
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return hlcell;
            }
            @catch (NSException *exception) {
                
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
            UILabel * item_skuid_Lbl;
            UILabel * item_skuDesc_Lbl;
            UILabel * item_price_Lbl;
            UILabel * item_IsueQty_Lbl;
            UILabel * item_gradeLbl;
            
            item_No_Lbl = [[UILabel alloc] init];
            item_No_Lbl.backgroundColor = [UIColor clearColor];
            item_No_Lbl.textAlignment = NSTextAlignmentCenter;
            item_No_Lbl.numberOfLines = 1;
            item_No_Lbl.layer.borderWidth = 1.5;
            item_No_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_No_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_skuid_Lbl = [[UILabel alloc] init];
            item_skuid_Lbl.backgroundColor = [UIColor clearColor];
            item_skuid_Lbl.textAlignment = NSTextAlignmentCenter;
            item_skuid_Lbl.numberOfLines = 1;
            item_skuid_Lbl.layer.borderWidth = 1.5;
            item_skuid_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_skuid_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_skuDesc_Lbl = [[UILabel alloc] init];
            item_skuDesc_Lbl.backgroundColor = [UIColor clearColor];
            item_skuDesc_Lbl.textAlignment = NSTextAlignmentCenter;
            item_skuDesc_Lbl.numberOfLines = 1;
            item_skuDesc_Lbl.layer.borderWidth = 1.5;
            item_skuDesc_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_skuDesc_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_price_Lbl = [[UILabel alloc] init];
            item_price_Lbl.backgroundColor = [UIColor clearColor];
            item_price_Lbl.textAlignment = NSTextAlignmentCenter;
            item_price_Lbl.numberOfLines = 1;
            item_price_Lbl.layer.borderWidth = 1.5;
            item_price_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_price_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_IsueQty_Lbl = [[UILabel alloc] init];
            item_IsueQty_Lbl.backgroundColor = [UIColor clearColor];
            item_IsueQty_Lbl.textAlignment = NSTextAlignmentCenter;
            item_IsueQty_Lbl.numberOfLines = 1;
            item_IsueQty_Lbl.layer.borderWidth = 1.5;
            item_IsueQty_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_IsueQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_gradeLbl = [[UILabel alloc] init];
            item_gradeLbl.backgroundColor = [UIColor clearColor];
            item_gradeLbl.textAlignment = NSTextAlignmentCenter;
            item_gradeLbl.numberOfLines = 1;
            item_gradeLbl.layer.borderWidth = 1.5;
            item_gradeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_gradeLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_No_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_skuid_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_skuDesc_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_price_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_IsueQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_gradeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            [hlcell.contentView addSubview:item_No_Lbl];
            [hlcell.contentView addSubview:item_skuid_Lbl];
            [hlcell.contentView addSubview:item_skuDesc_Lbl];
            [hlcell.contentView addSubview:item_price_Lbl];
            [hlcell.contentView addSubview:item_IsueQty_Lbl];
            [hlcell.contentView addSubview:item_gradeLbl];
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:14.0f cornerRadius:0.0];
                
                item_No_Lbl.frame = CGRectMake(itemNoLbl.frame.origin.x,0,itemNoLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_skuid_Lbl.frame = CGRectMake(itemSkuIDLbl.frame.origin.x,0,itemSkuIDLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_skuDesc_Lbl.frame = CGRectMake(itemDescLbl.frame.origin.x,0,itemDescLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_price_Lbl.frame = CGRectMake(itemPriceLbl.frame.origin.x,0,itemPriceLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_IsueQty_Lbl.frame = CGRectMake(itemIssueQtyLbl.frame.origin.x,0,itemIssueQtyLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_gradeLbl.frame = CGRectMake(itemGradeLbl.frame.origin.x,0,itemGradeLbl.frame.size.width,hlcell.frame.size.height);
            }
            else {
                // Frames for the iPhone
            }
            //        Here we  need to display the labels....
            
            @try {
                
                NSMutableDictionary * locDic = [requestedItemsInfoArr[indexPath.row] mutableCopy] ;
                
                item_No_Lbl.text = [NSString stringWithFormat:@"%d",(int)(indexPath.row + 1)];
                
                item_skuid_Lbl.text =  [locDic valueForKey:PLU_CODE];
                item_skuDesc_Lbl.text = [locDic valueForKey:ITEM_DESCRIPTION];
                
                item_price_Lbl.text = [NSString stringWithFormat:@"%.2f", [[locDic valueForKey:kPrice] floatValue]];
                
                item_IsueQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[locDic valueForKey:QUANTITY] floatValue]];
                
                if ( ((![[locDic valueForKey:PRODUCT_RANGE] isKindOfClass: [NSNull class]]) && [locDic.allKeys containsObject:PRODUCT_RANGE]) )
                    item_gradeLbl.text = [locDic valueForKey:PRODUCT_RANGE];
                
                else
                    item_gradeLbl.text = @"--";
                
            } @catch (NSException *exception) {
                
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
            hlcell.textLabel.numberOfLines = 2;
            
            
            if(outletIdTxt.tag == 0)
                hlcell.textLabel.text = locationArr[indexPath.row];
            else
                hlcell.textLabel.text = zoneListArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else  if(tableView == toStoreLocationTbl){
        
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
            
            hlcell.textLabel.numberOfLines = 2;
            hlcell.textLabel.text = toStoreLocationArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
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
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        @try {
            hlcell.textLabel.text = subCategoriesListArr[indexPath.row];
            
            hlcell.textLabel.numberOfLines = 1;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } @catch (NSException *exception) {
            
        }
        
        return hlcell;
        
    }
    
    else if (tableView == brandListTbl) {
        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (hlcell == nil) {
            hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            hlcell.frame = CGRectZero;
        }
        
        for (UIView *subview in (hlcell.contentView).subviews) {
            [subview removeFromSuperview];
        }
        
        @try {
            
            hlcell.textLabel.text = locationWiseBrandsArr[indexPath.row];
        }
        @catch (NSException *exception) {
            
        }
        hlcell.textLabel.numberOfLines = 1;
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
        } @catch (NSException *exception) {
            
        }
        hlcell.textLabel.numberOfLines = 1;
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        return hlcell;
    }
    
    else if (tableView == workFlowListTbl){
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

            hlcell.textLabel.text = workFlowsArr[indexPath.row];
        }
        @catch (NSException *exception) {
        }
        
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
    }
    
    else if (tableView == pagenationTbl) {
        
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
        @try {
            
            hlcell.textLabel.text = pagenationArr[indexPath.row];
        }
        @catch (NSException *exception) {
            
        }
        
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        
        //dismissing teh catPopOver.......
        [catPopOver dismissPopoverAnimated:YES];
        
        if (tableView == receiptIdsTbl) {
            
            @try {
                
                
                if (receiptDetails.count) {
                    
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
        
        else if(tableView == locationTbl) {
            
            // Play Audio for button touch....
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
            } @finally {
                
            }
        }
        
        else if (tableView == toStoreLocationTbl) {
            
            //Play Audio for button touch....
            AudioServicesPlaySystemSound (soundFileObject);
            
            @try {
                
                toStoreLocationTbl.tag = indexPath.row;
                
                toStoreTxt.text = toStoreLocationArr[indexPath.row];
                
            } @catch (NSException *exception) {
                
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
        }
        
        else if (tableView == modelListTbl) {
            
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
                
                startIndexInt = 0;
                pagenationTxt.text = pagenationArr[indexPath.row];
                int pageValue = (pagenationTxt.text).intValue;
                startIndexInt = startIndexInt + (pageValue * 10) - 10;
                
            } @catch (NSException * exception) {
                
            }
        }
    }
    @catch (NSException *exception) {
        
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
        
        if(userAlertMessageLbl.tag == 4){
            
            
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

#pragma -mark reusable method to check  nil resaponse:

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
        requestedItemsInfoArr = [[receiptDetails[sender.tag] valueForKey:RECEIPT_DETAILS] mutableCopy];
        
        isInEditableState = false;
        
        //here we are formating the next
        updateDictionary = [receiptDetails[sender.tag] mutableCopy];
        
        if(([[updateDictionary valueForKey:NEXT_ACTIVITIES] count]) || ([[updateDictionary valueForKey:NEXT_WORK_FLOW_STATES] count]) || ([[self checkGivenValueIsNullOrNil:[updateDictionary  valueForKey:STATUS] defaultReturn:@""] isEqualToString:APPROVED]) ){
            isInEditableState = true;
        }
        //upto here.......
        
        if(requestedItemsInfoArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        
        NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
        
        if (path.row == 0) {
            
            UITableViewCell *cell2 = [receiptIdsTbl cellForRowAtIndexPath:path];
            
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
                    
                    cell2 = [receiptIdsTbl cellForRowAtIndexPath: self.selectIndex];
                    
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
        
        [receiptIdsTbl beginUpdates];
        
        int section =  (int)self.selectIndex.section;
        int contentCount;
        
        contentCount =1;
        
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i < contentCount+1 ; i++) {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
            [rowToInsert addObject:indexPathToInsert];
        }
        
        if (firstDoInsert)
        {
            
            [receiptIdsTbl  insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [receiptIdsTbl deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [receiptIdsTbl endUpdates];
        
        if (nextDoInsert) {
            self.isOpen = YES;
            self.selectIndex = selectSectionIndex;
            //            requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:selectIndex.section] valueForKey:@"stockRequestItems"];
            
            UITableViewCell *cell2 = [receiptIdsTbl cellForRowAtIndexPath:selectIndex];
            
            for (UIButton *button in cell2.contentView.subviews) {
                
                if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                    
                    UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                    
                    [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                    
                }
                
                
                
            }
            [self didSelectCellRowFirstDo:YES nextDo:NO];
        }
        if (self.isOpen)
            [receiptIdsTbl scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        //[stockRequestTbl scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }    @catch (NSException *exception) {
        NSLog(@"----exception in the stockIssueView in didSelectCellRowFirsDo: nextDo----%@",exception);
        
        NSLog(@"----exception in inserting the row in table----%@",exception);
        
    }
    @finally {
        //[stockRequestTbl reloadData];
    }
    
}


/**
 * @description  in this method we will call the services....
 * @method       goButtonPressed:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments....
 */

-(void)goButtonPressed:(UIButton *)sender {
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self callingGetStockIssue];
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
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)submitMethod:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  We can Navigate to Home page using this method....
 * @date         - - - -
 * @method       cancelMethod
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)cancelMethod:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [self backAction];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


/**
 * @description  here we are navigating back to home page.......
 * @date         26/09/2016
 * @method       homeButonClicked
 * @author       Bhargav Ram
 * @param
 * @param
 * @param
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
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section && added try catch block....
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

@end

//                if(outletIdTxt.tag == 0){

//                    outletIdTxt.text = @"";

//outletIdTxt.text = [locationArr objectAtIndex:indexPath.row];

//                    outLetStoreName = [NSString stringWithFormat:@"%@",@""];
//                    if(indexPath.row != 0)
//                        outLetStoreName = [NSString stringWithFormat:@"%@",outletIdTxt.text];
//                }
//                else{
//
//                    zoneIdTxt.text = @"";
//                    outletIdTxt.text = @"";
//
//                    zoneIdTxt.text = [zoneListArr objectAtIndex:indexPath.row];
//
//                    zoneName = [NSString stringWithFormat:@"%@",@""];
//                    if(indexPath.row != 0)
//                        zoneName = [NSString stringWithFormat:@"%@",zoneIdTxt.text];
//
//                    [locationArr removeAllObjects];
//                    locationArr = [[zoneWiseLocationDic valueForKey:zoneIdTxt.text] mutableCopy];
//                }
//
//                searchItemsTxt.tag = [searchItemsTxt.text length];


