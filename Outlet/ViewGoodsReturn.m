//
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/24/15.
//
//

#import "ViewGoodsReturn.h"
#import "StockReturnServiceSvc.h"
#import "PopOverViewController.h"
#import "OmniHomePage.h"
#import "EditGoodsReturn.h"
#import "GoodsReturn.h"
#import "Global.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"


@implementation ViewGoodsReturn

@synthesize soundFileURLRef,soundFileObject;



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
    
    //Show the HUD...
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //Allocation of goodsReturnView....
    
    goodsReturnView = [[UIView alloc] init];
    goodsReturnView.backgroundColor = [UIColor blackColor];
    goodsReturnView.layer.borderWidth = 1.0f;
    goodsReturnView.layer.cornerRadius = 10.0f;
    goodsReturnView.layer.borderColor = [UIColor grayColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView...
    UILabel * headerNameLbl;
    CALayer * bottomBorder;
    
    headerNameLbl  = [[UILabel alloc] init];
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

    UIImage  * summaryInfoImg;
    UIButton * summaryInfoBtn;
    
    summaryInfoImg = [UIImage imageNamed:@"summaryInfo.png"];
    
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [summaryInfoBtn setBackgroundImage:summaryInfoImg forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self
                       action:@selector(populateSumaryInfo) forControlEvents:UIControlEventTouchDown];
    
    summaryInfoBtn.hidden= YES;
    
    outletIdTxt = [[CustomTextField alloc] init];
    outletIdTxt.delegate = self;
    outletIdTxt.placeholder = NSLocalizedString(@"all_outlets", nil);
    outletIdTxt.userInteractionEnabled  = NO;
    [outletIdTxt awakeFromNib];
    
    zoneIdTxt = [[CustomTextField alloc] init];
    zoneIdTxt.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneIdTxt.delegate = self;
    zoneIdTxt.userInteractionEnabled  = NO;
    [zoneIdTxt awakeFromNib];
    
    
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
    
    returnIDTxt = [[CustomTextField alloc] init];
    returnIDTxt.placeholder = NSLocalizedString(@"search_stock_return_id",nil);
    returnIDTxt.delegate = self;
    returnIDTxt.borderStyle = UITextBorderStyleRoundedRect;
    returnIDTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    returnIDTxt.textAlignment = NSTextAlignmentCenter;
    returnIDTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    returnIDTxt.textColor = [UIColor blackColor];
    returnIDTxt.layer.borderColor = [UIColor clearColor].CGColor;
    returnIDTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    returnIDTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
    [returnIDTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
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
                    action:@selector(showAllCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    brandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [brandBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [brandBtn addTarget:self
                 action:@selector(showBrandList:) forControlEvents:UIControlEventTouchDown];
    
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
    
    //used for identification propous....
    showStartDateBtn.tag = 2;
    showEndDateBtn.tag = 4;
  
    
    
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
    
    
    //Creation of scroll view
    
    stockReturnScrollView = [[UIScrollView alloc] init];
    //stockReturnScrollView.backgroundColor = [UIColor lightGrayColor];
    
    //creation of header labels:
    
    sNoLbl = [[CustomLabel alloc] init] ;
    [sNoLbl awakeFromNib];
    
    returnRefNoLbl = [[CustomLabel alloc] init] ;
    [returnRefNoLbl awakeFromNib];

    dateOfReturnLbl = [[CustomLabel alloc] init] ;
    [dateOfReturnLbl awakeFromNib];

    returnedByLbl = [[CustomLabel alloc] init] ;
    [returnedByLbl awakeFromNib];

    shipmentModeLbl = [[CustomLabel alloc] init] ;
    [shipmentModeLbl awakeFromNib];

    toLocationLbl = [[CustomLabel alloc] init] ;
    [toLocationLbl awakeFromNib];

    returnQtyLbl = [[CustomLabel alloc] init] ;
    [returnQtyLbl awakeFromNib];
    
    totalValueLbl = [[CustomLabel alloc] init] ;
    [totalValueLbl awakeFromNib];

    statusLbl = [[CustomLabel alloc] init] ;
    [statusLbl awakeFromNib];

    actionLbl = [[CustomLabel alloc] init] ;
    [actionLbl awakeFromNib];
    
    
    //Table view Creation:
    stockReturnTbl = [[UITableView alloc] init];
    stockReturnTbl.dataSource = self;
    stockReturnTbl.delegate = self;
    stockReturnTbl.backgroundColor = [UIColor clearColor];
    stockReturnTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
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
    
    //Allocation of UIView....
    totalInventoryView = [[UIView alloc]init];
    totalInventoryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalInventoryView.layer.borderWidth =3.0f;
    
    
    
    UILabel * totalReturnQuntityLbl;
    UILabel * totalStockReturnsLbl;
    
    totalReturnQuntityLbl = [[UILabel alloc] init];
    totalReturnQuntityLbl.layer.masksToBounds = YES;
    totalReturnQuntityLbl.numberOfLines = 1;
    totalReturnQuntityLbl.textColor = [UIColor whiteColor];
    
    totalReturnQtyValueLbl = [[UILabel alloc] init];
    totalReturnQtyValueLbl.layer.masksToBounds = YES;
    totalReturnQtyValueLbl.numberOfLines =1;
    totalReturnQtyValueLbl.textAlignment = NSTextAlignmentRight;
    totalReturnQtyValueLbl.textColor = [UIColor whiteColor];
    
    totalStockReturnsLbl = [[UILabel alloc] init];
    totalStockReturnsLbl.layer.masksToBounds = YES;
    totalStockReturnsLbl.numberOfLines = 1;
    totalStockReturnsLbl.textColor = [UIColor whiteColor];
    
    totalStockReturnValueLbl = [[UILabel alloc] init];
    totalStockReturnValueLbl.layer.masksToBounds = YES;
    totalStockReturnValueLbl.numberOfLines = 1;
    totalStockReturnValueLbl.textColor = [UIColor whiteColor];
    totalStockReturnValueLbl.textAlignment = NSTextAlignmentRight;

    totalStockReturnsLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalReturnQuntityLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalStockReturnValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalReturnQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalStockReturnsLbl.textAlignment = NSTextAlignmentLeft;
    totalReturnQuntityLbl.textAlignment = NSTextAlignmentLeft;
    
    totalStockReturnValueLbl.textAlignment = NSTextAlignmentRight;
    totalReturnQtyValueLbl.textAlignment = NSTextAlignmentRight;

    
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
    
    
    //populating text into the textFields && labels && placeholders && buttons titles....
    @try {
        
        //setting the titleName for the Page....
        
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        headerNameLbl.text = NSLocalizedString(@"stock_return_summary",nil);
        
        sNoLbl.text = NSLocalizedString(@"S_NO", nil);
        returnRefNoLbl.text = NSLocalizedString(@"refNo", nil);
        dateOfReturnLbl.text = NSLocalizedString(@"returnDate", nil);
        returnedByLbl.text = NSLocalizedString(@"returnedBy", nil);
        shipmentModeLbl.text = NSLocalizedString(@"shipment", nil);
        toLocationLbl.text = NSLocalizedString(@"toLocation", nil);
        returnQtyLbl.text = NSLocalizedString(@"return_qty", nil);
        totalValueLbl.text = NSLocalizedString(@"total_value", nil);
        statusLbl.text = NSLocalizedString(@"status", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        totalStockReturnsLbl.text  = NSLocalizedString(@"total_Stock_return",nil);
        totalReturnQuntityLbl.text =  NSLocalizedString(@"total_return_qty", nil);
        
        totalStockReturnValueLbl.text = NSLocalizedString(@"0.00", nil);
        totalReturnQtyValueLbl.text = NSLocalizedString(@"0.00", nil);

        
        
        //setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
        
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
        
        
    } @catch (NSException *exception) {
        
    }
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        //setting for the goodsReturnView....
        goodsReturnView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake( 0, 0, goodsReturnView.frame.size.width, 45);
      
        //seting frame for summaryInfoBtn....
        summaryInfoBtn.frame = CGRectMake(goodsReturnView.frame.size.width - 45,headerNameLbl.frame.origin.y,50,50);
        
        //setting first column....
        zoneIdTxt.frame = CGRectMake(goodsReturnView.frame.origin.x + 10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, 155, 40);
        
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
        returnIDTxt.frame = CGRectMake(10, endDateTxt.frame.origin.y + endDateTxt.frame.size.height + 15, goodsReturnView.frame.size.width - 20, 40);
        
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
        searchBtn.frame = CGRectMake(((returnIDTxt.frame.origin.x+returnIDTxt.frame.size.width)-160), categoryTxt.frame.origin.y,160,40);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x,subCategoryTxt.frame.origin.y,searchBtn.frame.size.width,searchBtn.frame.size.height);
        
        pagenationTxt.frame = CGRectMake(returnIDTxt.frame.origin.x,goodsReturnView.frame.size.height - 45,90,40);
        
        dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width-45), pagenationTxt.frame.origin.y-5, 45, 50);
        
        goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width+15,pagenationTxt.frame.origin.y,80, 40);
        
        //Frame for the UIView...
        
        totalInventoryView.frame = CGRectMake(returnIDTxt.frame.origin.x + returnIDTxt.frame.size.width-265,pagenationTxt.frame.origin.y -18,270,60);

        totalStockReturnsLbl.frame =  CGRectMake(5,0,170,40);
       
        totalReturnQuntityLbl.frame =  CGRectMake(totalStockReturnsLbl.frame.origin.x,totalStockReturnsLbl.frame.origin.y+totalStockReturnsLbl.frame.size.height-15,170,40);
        
        totalStockReturnValueLbl.frame = CGRectMake(totalStockReturnsLbl.frame.origin.x+totalStockReturnsLbl.frame.size.width,totalStockReturnsLbl.frame.origin.y,90,40);
        totalReturnQtyValueLbl.frame = CGRectMake(totalStockReturnValueLbl.frame.origin.x, totalReturnQuntityLbl.frame.origin.y,90,40);
        
        
        stockReturnScrollView.frame = CGRectMake(returnIDTxt.frame.origin.x,returnIDTxt.frame.origin.y + returnIDTxt.frame.size.height+5,returnIDTxt.frame.size.width+120,totalInventoryView.frame.origin.y - (returnIDTxt.frame.origin.y+returnIDTxt.frame.size.height + 10));
        
        sNoLbl.frame = CGRectMake(0,0,45,35);
        
        returnRefNoLbl.frame = CGRectMake(sNoLbl.frame.origin.x+sNoLbl.frame.size.width+2,sNoLbl.frame.origin.y,180,sNoLbl.frame.size.height);
        
        dateOfReturnLbl.frame = CGRectMake(returnRefNoLbl.frame.origin.x+returnRefNoLbl.frame.size.width+2,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);
        
        returnedByLbl.frame = CGRectMake(dateOfReturnLbl.frame.origin.x+dateOfReturnLbl.frame.size.width+2,sNoLbl.frame.origin.y,105,sNoLbl.frame.size.height);
        
        shipmentModeLbl.frame = CGRectMake(returnedByLbl.frame.origin.x+returnedByLbl.frame.size.width+2,sNoLbl.frame.origin.y,90,sNoLbl.frame.size.height);
        
        toLocationLbl.frame = CGRectMake(shipmentModeLbl.frame.origin.x+shipmentModeLbl.frame.size.width+2,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);
        
        returnQtyLbl.frame = CGRectMake(toLocationLbl.frame.origin.x+toLocationLbl.frame.size.width+2,sNoLbl.frame.origin.y,90,sNoLbl.frame.size.height);
        
        totalValueLbl.frame = CGRectMake(returnQtyLbl.frame.origin.x+returnQtyLbl.frame.size.width+2,sNoLbl.frame.origin.y,90,sNoLbl.frame.size.height);
        
        statusLbl.frame = CGRectMake(totalValueLbl.frame.origin.x+totalValueLbl.frame.size.width+2,sNoLbl.frame.origin.y,80,sNoLbl.frame.size.height);
        
        actionLbl.frame = CGRectMake(statusLbl.frame.origin.x+statusLbl.frame.size.width+2,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);
        
        stockReturnTbl.frame = CGRectMake(0,sNoLbl.frame.origin.y + sNoLbl.frame.size.height,stockReturnScrollView.frame.size.width,stockReturnScrollView.frame.size.height-(sNoLbl.frame.origin.y+sNoLbl.frame.size.height));
        
        //stockReturnScrollView.contentSize = CGSizeMake(stockReturnTbl.frame.size.width+90,  stockReturnScrollView.frame.size.height);
        
    }

    
    else{
        
        //CODE  FOR IPHONE....
    }
    
    //Adding all the UIElements as a SubView to the goodsReturnView
    [goodsReturnView addSubview:headerNameLbl];
    
    [goodsReturnView addSubview:outletIdTxt];
    [goodsReturnView addSubview:zoneIdTxt];
    [goodsReturnView addSubview:startDateTxt];
    [goodsReturnView addSubview:endDateTxt];
    [goodsReturnView addSubview:statusTxt];
    [goodsReturnView addSubview:categoryTxt];
    [goodsReturnView addSubview:subCategoryTxt];
    [goodsReturnView addSubview:brandTxt];
    [goodsReturnView addSubview:modelTxt];
    [goodsReturnView addSubview:returnIDTxt];
    
    [goodsReturnView addSubview:outletIdBtn];
    
    //[goodsReturnView addSubview:zoneIdBtn];
    
    [goodsReturnView addSubview:showStartDateBtn];
    [goodsReturnView addSubview:showEndDateBtn];
    [goodsReturnView addSubview:categoryBtn];
    [goodsReturnView addSubview:subCatBtn];
    [goodsReturnView addSubview:brandBtn];
    [goodsReturnView addSubview:modelBtn];
    [goodsReturnView addSubview:stausBtn];
    
    [goodsReturnView addSubview:searchBtn];
    [goodsReturnView addSubview: clearBtn];
    
    [goodsReturnView addSubview:stockReturnScrollView];
    
    [stockReturnScrollView addSubview:sNoLbl];
    [stockReturnScrollView addSubview:returnRefNoLbl];
    [stockReturnScrollView addSubview:dateOfReturnLbl];
    [stockReturnScrollView addSubview:returnedByLbl];
    [stockReturnScrollView addSubview:shipmentModeLbl];
    [stockReturnScrollView addSubview:toLocationLbl];
    [stockReturnScrollView addSubview:returnQtyLbl];
    [stockReturnScrollView addSubview:totalValueLbl];
    [stockReturnScrollView addSubview:statusLbl];
    [stockReturnScrollView addSubview:actionLbl];
    
    [stockReturnScrollView addSubview:stockReturnTbl];
    
    [goodsReturnView addSubview: pagenationTxt];
    [goodsReturnView addSubview: dropDownBtn];
    [goodsReturnView addSubview: goButton];
    
    [goodsReturnView addSubview: totalInventoryView];
    
    [totalInventoryView addSubview: totalStockReturnsLbl];
    [totalInventoryView addSubview: totalReturnQuntityLbl];
    
    [totalInventoryView addSubview:totalStockReturnValueLbl];
    [totalInventoryView addSubview:totalReturnQtyValueLbl];

    
    

    //adding goodsReturnView to the class
    [self.view addSubview:goodsReturnView];
    
    //Setting all the UIElements fontSize  as 16...
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];

    //Setting all the headerNameLbl fontSize  as 16...
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    
    //Setting all the searchBtn fontSize  as 16...
    searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    
    //Setting all the clearBtn fontSize  as 16...
    clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    
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
        
    } @catch (NSException * exception) {
    }
    
}

/**
 * @description  it is one of ViewLifeCylce
 which will be executed after execution of
 viewDidLoad.......
 * @date         30/11/2017
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
    [super viewDidAppear:YES];
    
    @try {
        
        [HUD setHidden:NO];
        
        startIndexint = 0;
        
        [self callingGetStockReturn];
    }
    @catch (NSException *exception) {
        
    }
    
}

/**
 * @description  here calling the service to Get StockReturn Data..
 * @date         30/11/2017
 * @method       callingGetStockReturn
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGetStockReturn {
    @try {
        
        [HUD setHidden:NO];
        
        //text format of the HUD...
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];

        
        if(stockReturnArr == nil && startIndexint == 0){
            
            totalNoOfStockReturn = 0;
            
            stockReturnArr = [NSMutableArray new];
        }
        else if(stockReturnArr.count ){
            
            [stockReturnArr removeAllObjects];
        }
        
        if(startIndexint == 0)
            
            totalReturnQtyValueLbl.text = @"0.00";
        

        
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

        if(searchBtn.tag == 4){
            
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
        
        NSMutableDictionary *stockReturn = [[NSMutableDictionary alloc] init];
        stockReturn[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        stockReturn[START_INDEX] = [NSString stringWithFormat:@"%d",startIndexint];
        stockReturn[LOCATIONS] = presentLocation;
        stockReturn[START_DATE] = startDteStr;
        stockReturn[END_DATE] = endDteStr;
        stockReturn[kMaxRecords] = @"10";
        stockReturn[SEARCH_CRITERIA] = returnIDTxt.text;
        
        //setting secondColumn....
        stockReturn[ITEM_CATEGORY] = categoryStr;
        
        stockReturn[kSubCategory] = subCategoryStr;
        
        //setting thirdColumn....
        stockReturn[kBrand] = brandStr;
        
        stockReturn[MODEL] = modelStr;
        
        //setting fourthColumn....
        stockReturn[START_DATE] = startDteStr;
        
        stockReturn[END_DATE] = endDteStr;
        
        stockReturn[STATUS] = statusStr;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:stockReturn options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockReturnDelegate = self;
        [webServiceController getStockReturn:quoteRequestJsonString];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"----exception in Service Call---%@",exception);
        
    }
    @finally {
        
    }
    
}


/**
 * @description  here calling the service to getAllLocations............
 * @date         30/11/2017
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
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSMutableDictionary * zoneDic  = [[NSMutableDictionary alloc]init];
        
        [zoneDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [zoneDic setValue:NEGATIVE_ONE forKey:START_INDEX];
        
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
        [brandDic setValue:NEGATIVE_ONE forKey:START_INDEX];
        
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

-(void)getWorkFlows{
    
    @try {
        
        [HUD show: YES];
        [HUD setHidden:NO];
        
        workFlowsArr = [NSMutableArray new];
        
        NSMutableDictionary * workFlowDic = [[NSMutableDictionary alloc]init];
        
        [workFlowDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [workFlowDic setValue:STOCK_RETURN forKey:BUSINESSFLOW];
        [workFlowDic setValue:presentLocation forKey:STORE_LOCATION];
        [workFlowDic setValue:NEGATIVE_ONE forKey:START_INDEX];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:workFlowDic options:0 error:&err];
        NSString * workFlowJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
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
 * @description  here we are Storing the Data in to a Dictionary...
 * @date         30/11/2017
 * @method       getStockReturnSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getStockReturnSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        totalNoOfStockReturn = (int)[[successDictionary valueForKey:TOTAL_BILLS] integerValue];
        
        float totalReturnQtyValue;
        
        for(NSDictionary * dic in [successDictionary valueForKey:STOCK_RETURN_LIST]){
            
            [stockReturnArr addObject:dic];
            
            
            // added on 02/11/2017....
            
            for(NSDictionary * locDic in [dic valueForKey:STOCK_LIST] )
                totalReturnQtyValue  += [[self checkGivenValueIsNullOrNil:[locDic valueForKey:VALUE] defaultReturn:@"0.00"] floatValue];
            
            //upto here on 02/11/2017.....

            
        }
        
        totalStockReturnValueLbl.text = [NSString stringWithFormat:@"%i",(int)[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS] defaultReturn:@"0.00"] integerValue]];
        
        totalReturnQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", totalReturnQtyValue];
        
        //upto here on 23/05/2017.....
        

        
        
        
        //Recently Added By Bhargav.v on 17/10/2017..
        //Reason: To Display the Records in pagination mode based on the Total Records..
        
        
        int strTotalRecords = totalNoOfStockReturn/10;
        
        int remainder = totalNoOfStockReturn % 10;
        
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
            
            [pagenationArr addObject:@"1"];
            
        }
        else{
            
            for(int i = 1;i<= strTotalRecords; i++){
                
                [pagenationArr addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        //Up to here on 16/10/2017...
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        if(startIndexint == 0){
            pagenationTxt.text = @"1";
        }
        [stockReturnTbl reloadData];
        [HUD setHidden: YES];
    }
}

/**
 * @description  Displaying the error response...
 * @date         30/11/2017
 * @method       getStockReturnErrorResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getStockReturnErrorResponse:(NSString *)errorResponse {
    @try {
     
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

        totalReturnQtyValueLbl.text = [NSString stringWithFormat:@"%@%@",@"",@"0.00"];
        totalReturnQtyValueLbl.text  = [NSString stringWithFormat:@"%@%@",@"",@"0.00"];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [stockReturnTbl reloadData];
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
        if(stockReturnArr.count)
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
        if(stockReturnArr.count)
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
    float y_axis = self.view.frame.size.height - 120;
    
    NSString *mesg = [NSString stringWithFormat:@"%@",error];
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    
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
        //if (![catPopOver isPopoverVisible]){
        if(locationArr == nil ||  locationArr.count == 0){
            
            [HUD setHidden:NO];
            
            //changed on 17/02/2017....
            [self getLocations];
        }
        
        if(locationArr.count){
            float tableHeight = locationArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = locationArr.count * 33;
            
            if(locationArr.count > 5)
                tableHeight = (tableHeight/locationArr.count) * 5;
            
            zoneIdTxt.tag = 2;
            outletIdTxt.tag = 0;
            
            [self showPopUpForTables:locationTbl  popUpWidth:(outletIdTxt.frame.size.width* 1.5) popUpHeight:tableHeight presentPopUpAt:outletIdTxt  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp];
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
        
        //if (![catPopOver isPopoverVisible]){
        
        if(zoneListArr == nil ||  zoneListArr.count == 0){
            [HUD setHidden:NO];
            
            //changed on 17/02/2017....
            [self getZones];
            
        }
        [HUD setHidden:YES];
        
        
        if(zoneListArr.count){
            float tableHeight = zoneListArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = zoneListArr.count * 33;
            
            if(zoneListArr.count > 5)
                tableHeight = (tableHeight/zoneListArr.count) * 5;
            
            
            zoneIdTxt.tag = 0;
            outletIdTxt.tag = 2;
            
            
            [self showPopUpForTables:locationTbl  popUpWidth:(zoneIdTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:zoneIdTxt  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp];
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
        
        float tableHeight = categoriesListArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = categoriesListArr.count * 33;
        
        if(categoriesListArr.count > 5)
            tableHeight =(tableHeight/categoriesListArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        float tableHeight = subCategoriesListArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoriesListArr.count * 33;
        
        if(subCategoriesListArr.count > 5)
            tableHeight = (tableHeight/subCategoriesListArr.count)*5;
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:(subCategoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
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
        
        if((brandListArray == nil) || (brandListArray.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self callingBrandList];
            
        }
        
        [HUD setHidden:YES];
        
        if(brandListArray.count == 0){
            
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = brandListArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = brandListArray.count * 33;
        
        if(brandListArray.count > 5)
            tableHeight = (tableHeight/brandListArray.count) * 5;
        
        [self showPopUpForTables:brandListTbl  popUpWidth:(brandTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = ModelListArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = ModelListArray.count * 33;
        
        if(ModelListArray.count > 5)
            tableHeight = (tableHeight/ModelListArray.count) * 5;
        
        [self showPopUpForTables:modelListTbl  popUpWidth:(modelTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:modelTxt  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        
        [self showPopUpForTables:workFlowListTbl  popUpWidth:(statusTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:statusTxt  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
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
        

        startIndexint = 0;
        
        [self callingGetStockReturn];

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
        
        startIndexint = 0;
        
        [self callingGetStockReturn];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
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
        
        
        [self callingGetStockReturn];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
    }
}



#pragma -mark navigation used in this page ......

/**
 * @description  here we are showing the list of requestedItems.......
 * @date         26/09/2016
 * @method       openViewStockRequestInDetail;
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createGoodsReturn:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        GoodsReturn * vc = [[GoodsReturn alloc ] init];
        
        BOOL isDraft = false;
        if(stockReturnArr.count > sender.tag) {
            
            NSString * DraftStr;
            DraftStr  = [stockReturnArr[sender.tag] valueForKey:STATUS];
            
            if ([DraftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
                
                isDraft = true;
            }
        }
        if(isDraft){
            
            vc.returnID = [stockReturnArr[sender.tag] valueForKey:kReturnNoteRef];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    @catch (NSException *exception) {
        
    } @finally {
        
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
- (void)editGoodsReturn:(UIButton *)sender {
    
    @try {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        BOOL isDraft = false;
        
        if (stockReturnArr.count > sender.tag) {
            
            NSString * draftStr;
            draftStr = [stockReturnArr[sender.tag] valueForKey:STATUS];
            
            if ([draftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
                
                isDraft = true;
            }
        }
        if (isDraft) {
            
            GoodsReturn * newStockReturn = [[GoodsReturn alloc ] init];
            newStockReturn.returnID = [stockReturnArr[sender.tag] valueForKey:kReturnNoteRef];
            [self.navigationController pushViewController:newStockReturn animated:YES];
        }
        else {
            
            EditGoodsReturn *viewStock = [[EditGoodsReturn alloc] init ];
            viewStock.returnID = [stockReturnArr[sender.tag] valueForKey:kReturnNoteRef];
            [self.navigationController pushViewController:viewStock animated:YES];
        }
    } @catch (NSException *exception) {
        NSLog(@"-exception while reading -%@ ",exception );
        
    } @finally {
        
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
            
            [self displayAlertMessage:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        
        NSDate *existingDateString;
        
        
        if(  sender.tag == 2){
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    return;
                    
                }
            }
            
            startDateTxt.text = dateString;
        }
        else{
            
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
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
        
        
        if(sender.tag == 2) {
            if((startDateTxt.text).length)
                //callServices = true;
                
                startDateTxt.text = @"";
        }
        else {
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


-(void)goButtonPressed:(UIButton*)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        startIndexint = 0;
        [self callingGetStockReturn];
        
        NSLog(@"---method calling--@");
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma mark text Fied Delegates:


-(void)textFieldDidChange:(UITextField *)textField  {
    @try {
        
        if (textField == returnIDTxt) {
            
            if ((textField.text).length >= 4) {
                [HUD show:YES];
                [HUD  setHidden: NO];
                
                startIndexint = 0;
                stockReturnArr = [NSMutableArray new];
                [self callingGetStockReturn];
            }
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma -mark start of UITableViewDelegateMethods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == stockReturnTbl){
        if (stockReturnArr.count)
            
            return stockReturnArr.count;
        else
            return 1;
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
        
        if(tableView == stockReturnTbl){
            
            return  38;
        }
        
        else if(tableView == locationTbl ||tableView == categoriesListTbl ||tableView == subCategoriesListTbl ||tableView == brandListTbl ||tableView == modelListTbl||tableView == workFlowListTbl ||tableView == pagenationTbl){
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                return 40;
            }
            else {
                return 38;
            }
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == stockReturnTbl) {
        
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
            
            UILabel * s_no_Lbl;
            UILabel * refrence_Lbl;
            UILabel * returnDate_Lbl;
            UILabel * returned_By;
            UILabel * shipmentMode_Lbl;
            UILabel * to_LocationLbl;
            UILabel * returnQty_Lbl;
            UILabel * totalValue_Lbl;
            UILabel * status_Lbl;
            UILabel *action_Lbl;
            
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
            
            returnDate_Lbl= [[UILabel alloc] init];
            returnDate_Lbl.backgroundColor = [UIColor clearColor];
            returnDate_Lbl.textAlignment = NSTextAlignmentCenter;
            returnDate_Lbl.numberOfLines = 1;
            returnDate_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            returned_By= [[UILabel alloc] init];
            returned_By.backgroundColor = [UIColor clearColor];
            returned_By.textAlignment = NSTextAlignmentCenter;
            returned_By.numberOfLines = 1;
            returned_By.lineBreakMode = NSLineBreakByWordWrapping;
            
            shipmentMode_Lbl= [[UILabel alloc] init];
            shipmentMode_Lbl.backgroundColor = [UIColor clearColor];
            shipmentMode_Lbl.textAlignment = NSTextAlignmentCenter;
            shipmentMode_Lbl.numberOfLines = 1;
            shipmentMode_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            to_LocationLbl= [[UILabel alloc] init];
            to_LocationLbl.backgroundColor = [UIColor clearColor];
            to_LocationLbl.textAlignment = NSTextAlignmentCenter;
            to_LocationLbl.numberOfLines = 1;
            to_LocationLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            returnQty_Lbl= [[UILabel alloc] init];
            returnQty_Lbl.backgroundColor = [UIColor clearColor];
            returnQty_Lbl.textAlignment = NSTextAlignmentCenter;
            returnQty_Lbl.numberOfLines = 1;
            returnQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            totalValue_Lbl= [[UILabel alloc] init];
            totalValue_Lbl.backgroundColor = [UIColor clearColor];
            totalValue_Lbl.textAlignment = NSTextAlignmentCenter;
            totalValue_Lbl.numberOfLines = 1;
            totalValue_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            status_Lbl = [[UILabel alloc] init];
            status_Lbl.backgroundColor =  [UIColor clearColor];
            status_Lbl.textAlignment = NSTextAlignmentCenter;
            status_Lbl.numberOfLines = 1;
            
            action_Lbl = [[UILabel alloc] init];
            action_Lbl.backgroundColor =  [UIColor clearColor];
            action_Lbl.textAlignment = NSTextAlignmentCenter;
            action_Lbl.numberOfLines = 1;
            
            newButton = [[UIButton alloc] init];
            //newButton.backgroundColor = [UIColor blackColor];
            newButton.titleLabel.textColor = [UIColor whiteColor];
            newButton.userInteractionEnabled = YES;
            newButton.tag = indexPath.row;
            [newButton addTarget:self action:@selector(createGoodsReturn:) forControlEvents:UIControlEventTouchUpInside];
            [newButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
            //newButton.
            
            openButton = [[UIButton alloc] init];
            //openButton.backgroundColor = [UIColor blackColor];
            openButton.titleLabel.textColor =  [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
            openButton.userInteractionEnabled = YES;
            openButton.tag = indexPath.row;
            [openButton addTarget:self action:@selector(editGoodsReturn:) forControlEvents:UIControlEventTouchUpInside];
            [openButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            s_no_Lbl.textColor         = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            refrence_Lbl.textColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            returnDate_Lbl.textColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            returned_By.textColor      = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            shipmentMode_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            to_LocationLbl.textColor   = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
            returnQty_Lbl.textColor    = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
            totalValue_Lbl.textColor   = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
            status_Lbl.textColor       = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            action_Lbl.textColor       = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                //setting frame....
                s_no_Lbl.frame = CGRectMake( 0, 0,sNoLbl.frame.size.width + 1, hlcell.frame.size.height);
                
                refrence_Lbl.frame = CGRectMake(returnRefNoLbl.frame.origin.x, 0, returnRefNoLbl.frame.size.width,  hlcell.frame.size.height);
                
                returnDate_Lbl.frame = CGRectMake(dateOfReturnLbl.frame.origin.x, 0, dateOfReturnLbl.frame.size.width,  hlcell.frame.size.height);
                
                returned_By.frame = CGRectMake(returnedByLbl.frame.origin.x, 0, returnedByLbl.frame.size.width,  hlcell.frame.size.height);
                
                shipmentMode_Lbl.frame = CGRectMake(shipmentModeLbl.frame.origin.x, 0, shipmentModeLbl.frame.size.width,  hlcell.frame.size.height);
                
                to_LocationLbl.frame = CGRectMake(toLocationLbl.frame.origin.x, 0, toLocationLbl.frame.size.width,  hlcell.frame.size.height);
                
                returnQty_Lbl.frame = CGRectMake(returnQtyLbl.frame.origin.x, 0, returnQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                totalValue_Lbl.frame = CGRectMake(totalValueLbl.frame.origin.x, 0, totalValueLbl.frame.size.width,  hlcell.frame.size.height);
                
                status_Lbl.frame = CGRectMake(statusLbl.frame.origin.x, 0, statusLbl.frame.size.width,  hlcell.frame.size.height);
                
                newButton.frame = CGRectMake( status_Lbl.frame.origin.x + status_Lbl.frame.size.width + 2, 0, (actionLbl.frame.size.width - 5)/2 ,  hlcell.frame.size.height);
                
                openButton.frame = CGRectMake( newButton.frame.origin.x + newButton.frame.size.width + 2, 0, newButton.frame.size.width,  hlcell.frame.size.height);
                
            }
            else {
                
              // CODE FOR IPHONE...
            }
            
            [hlcell.contentView addSubview:s_no_Lbl];
            [hlcell.contentView addSubview:refrence_Lbl];
            [hlcell.contentView addSubview:returnDate_Lbl];
            [hlcell.contentView addSubview:returned_By];
            [hlcell.contentView addSubview:shipmentMode_Lbl];
            [hlcell.contentView addSubview:to_LocationLbl];
            [hlcell.contentView addSubview:returnQty_Lbl];
            [hlcell.contentView addSubview:totalValue_Lbl];
            [hlcell.contentView addSubview:status_Lbl];
            [hlcell.contentView addSubview:newButton];
            [hlcell.contentView addSubview:openButton];
            
            
            @try {
                
                [newButton setTitle:NSLocalizedString(@"New", nil) forState:UIControlStateNormal];
                [openButton setTitle:NSLocalizedString(@"Open", nil) forState:UIControlStateNormal];

                
                if (stockReturnArr.count >= indexPath.row && stockReturnArr.count ) {
                    
                    NSDictionary *dic = stockReturnArr[indexPath.row];
                    
                    s_no_Lbl.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row +1)+startIndexint];
                    
                    refrence_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kReturnNoteRef] defaultReturn:@"--"];
                    
                    returnDate_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:kDateOfReturn] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
                    
                    returned_By.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kReturnBy] defaultReturn:@"--"];
                    
                    shipmentMode_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kShipmentMode] defaultReturn:@"--"];
                    
                    to_LocationLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kToLocation] defaultReturn:@"--"];
                    
                    
                    float returnQty  = 0;
                    float totalValue = 0;
                    
                    for(NSDictionary * localDic in [dic valueForKey:STOCK_LIST]) {
                        
                        returnQty  = [[self checkGivenValueIsNullOrNil:[localDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
                        
                        totalValue = [[self checkGivenValueIsNullOrNil:[localDic valueForKey:VALUE] defaultReturn:@"0.00"] floatValue];

                    }
                    
                    returnQty_Lbl.text = [NSString stringWithFormat:@"%.2f",returnQty];

                    totalValue_Lbl.text = [NSString stringWithFormat:@"%.2f",totalValue];
                    
                    status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS] defaultReturn:@"--"];
                }
                
                else {
                    
                    s_no_Lbl.text         = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1)];
                    refrence_Lbl.text     = @"--";
                    returnDate_Lbl.text   = @"--";
                    returned_By.text      = @"--";
                    shipmentMode_Lbl.text = @"--";
                    to_LocationLbl.text   = @"--";
                    returnQty_Lbl.text    = @"--";
                    totalValue_Lbl.text   = @"--";
                    status_Lbl.text       = @"--";
                    
                    newButton.frame = CGRectMake(status_Lbl.frame.origin.x + status_Lbl.frame.size.width + 2, 0, actionLbl.frame.size.width,hlcell.frame.size.height);
                    
                    openButton.hidden = YES;
                }
            }
            
            @catch (NSException *exception) {
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
            newButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];
            openButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];

            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
    }
    else   if(tableView == locationTbl) {
        
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
            
            //            hlcell.textLabel.text = [[locationArr objectAtIndex:indexPath.row] valueForKey:LOCATION_ID];
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
            hlcell.textLabel.text = categoriesListArr[indexPath.row];
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
            hlcell.textLabel.text = brandListArray[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
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
    
    else if (tableView == workFlowListTbl) {
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
 * @description  it is tableViewDelegate method it will execute. When an cell is selected in Table.....
 * @date         21/09/2016
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Bhargav
 * @param        UITableView
 * @param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //dismissing teh catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
    
    if(tableView ==stockReturnTbl ){
        
        AudioServicesPlaySystemSound (soundFileObject);
        
        if (stockReturnArr.count){
            
            EditGoodsReturn *viewStock = [[EditGoodsReturn alloc] init ];
            viewStock.returnID = [stockReturnArr[indexPath.row] valueForKey:kReturnNoteRef];
            [self.navigationController pushViewController:viewStock animated:YES];
        }
        else {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
        }

    }
    
    else if(tableView == locationTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            locationTbl.tag = indexPath.row;
            
            outletIdTxt.text = locationArr[indexPath.row];
            
            outLetStoreName = [NSString stringWithFormat:@"%@",@""];
            if(indexPath.row != 0)
                outLetStoreName = [NSString stringWithFormat:@"%@",outletIdTxt.text];
            
            
        } @catch (NSException *exception) {
            NSLog(@"----exception in changing the textFieldData in didSelec----%@",exception);
        }
    }
    
    else  if(tableView == categoriesListTbl) {
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
        
        brandTxt.text = brandListArray[indexPath.row];
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
            
            startIndexint = 0;
            
            pagenationTxt.text = pagenationArr[indexPath.row];
            int pageValue = (pagenationTxt.text).intValue;
            startIndexint = startIndexint + (pageValue * 10) - 10;
            
        } @catch (NSException * exception) {
            
        }
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

-(void)displayAlertMessage:(NSString *)message  horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float)labelWidth contentHeight:(float)labelHeight  isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay  noOfLines:(int)noOfLines {
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
            
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont systemFontOfSize:20];
        userAlertMessageLbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        userAlertMessageLbl.layer.cornerRadius = 5.0f;
        userAlertMessageLbl.text =  message;
        userAlertMessageLbl.textAlignment = NSTextAlignmentCenter;
        userAlertMessageLbl.numberOfLines = 2;
        userAlertMessageLbl.tag =2;
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame) {
            
            userAlertMessageLbl.tag = 4;
            userAlertMessageLbl.textColor = [UIColor colorWithRed:114.0/255.0 green:203.0/255.0 blue:158.0/255.0 alpha:1.0];
            
            if(soundStatus){
                
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        else{
            userAlertMessageLbl.textColor = [UIColor redColor];
            
            if(soundStatus){
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
            
            
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
            
        }
        else{
            if (version > 8.0) {
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                userAlertMessageLbl.font = [UIFont systemFontOfSize:18];
                
            }
            else{
                userAlertMessageLbl.font = [UIFont systemFontOfSize:18];
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                
            }
            
        }
        
        [self.view addSubview:userAlertMessageLbl];
        fadeOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"----%@",exception);
        NSLog(@"----%@",exception);
        
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
 *
 */

-(void)removeAlertMessages{
    @try {
        
        if(userAlertMessageLbl.tag == 4){
            
            stockRequest *home = [[stockRequest alloc]init];
            [self.navigationController pushViewController:home animated:YES];
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

- (id)checkGivenValueIsNullOrNil:(id)inputValue defaultReturn:(NSString *)returnStirng {
    
    
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
