//
//  ShipmentReturnSummary.m
//  OmniRetailer
//
//  Created by Technolabs on 12/7/17.


#import "ShipmentReturnSummary.h"
#import "ShipmentReturnNew.h"
#import "ShipmentReturnEdit.h"
#import "OmniHomePage.h"

@interface ShipmentReturnSummary ()

@end

@implementation ShipmentReturnSummary

//this properties are used for generating the sounds....
@synthesize soundFileURLRef,soundFileObject;


/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         07/12/2017..
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
    
    // Show the HUD
    
    [HUD show:YES];
    [HUD setHidden:NO];
    [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
    
    //Allocation of Shipment Return View..
    shipmentReturnView = [[UIView alloc]init];
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
    
    /*Creation of UIButton for providing user to select the dates.......*/
    UIImage  * summaryImage;
    UIButton * summaryInfoBtn;
    
    //Allocation of Summary Info Btn..
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    summaryImage = [UIImage imageNamed:@"emails-letters.png"];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self action:@selector(callingStockRequestSumary:) forControlEvents:UIControlEventTouchDown];
    summaryInfoBtn.tag = 0;
    
    /*Creation of textField used in this page*/
    
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
    
    supplierNameTxt = [[CustomTextField alloc] init];
    supplierNameTxt.placeholder = NSLocalizedString(@"supplier_name", nil);
    supplierNameTxt.userInteractionEnabled  = NO;
    supplierNameTxt.delegate = self;
    [supplierNameTxt awakeFromNib];
    
    itemWiseTxt = [[CustomTextField alloc] init];
    itemWiseTxt.placeholder = NSLocalizedString(@"item_wise", nil);
    itemWiseTxt.userInteractionEnabled  = NO;
    itemWiseTxt.delegate = self;
    [itemWiseTxt awakeFromNib];
    
    
    // getting present date & time ..
//    NSDate *today = [NSDate date];
//    NSDateFormatter *f = [[NSDateFormatter alloc] init];
//    [f setDateFormat:@"dd/MM/yyyy"];
//    NSString * currentdate = [f stringFromDate:today];

    
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDateTxt.userInteractionEnabled  = NO;
    startDateTxt.delegate = self;
    //startDateTxt.text = currentdate;
    [startDateTxt awakeFromNib];
    
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDateTxt.userInteractionEnabled  = NO;
    endDateTxt.delegate = self;
    [endDateTxt awakeFromNib];
    
    
    UIButton * clearBtn;
    
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self
                  action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    shipmentReturnTxt = [[CustomTextField alloc] init];
    shipmentReturnTxt.placeholder = NSLocalizedString(@"search_return_id",nil);
    shipmentReturnTxt.delegate = self;
    shipmentReturnTxt.borderStyle = UITextBorderStyleRoundedRect;
    shipmentReturnTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentReturnTxt.textAlignment = NSTextAlignmentCenter;
    shipmentReturnTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentReturnTxt.textColor = [UIColor blackColor];
    shipmentReturnTxt.layer.borderColor = [UIColor clearColor].CGColor;
    shipmentReturnTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    shipmentReturnTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
    [shipmentReturnTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    /*Creation of UIImage used for buttons*/
    UIImage * buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];
    UIImage * buttonImage = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    /* UIButton Used for Dropdown and PopUps*/
    UIButton * outletIdBtn;
    UIButton * zoneIdBtn;
    UIButton * categoryBtn;
    UIButton * subCatBtn;
    UIButton * supplierNameBtn;
    UIButton * itemWiseBtn;
    
    UIButton * showStartDateBtn;
    UIButton * showEndDateBtn;

    
    outletIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outletIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    //[outletIdBtn addTarget:self action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];
    
    zoneIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoneIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    zoneIdBtn.hidden = YES;
    
    //[zoneIdBtn addTarget:self action:@selector(showAllZonesId:) forControlEvents:UIControlEventTouchDown];
    
    categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    
    [categoryBtn addTarget:self action:@selector(showAllLocationWiseCategoriesList:) forControlEvents:UIControlEventTouchDown];

    
    subCatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subCatBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
   [subCatBtn addTarget:self action:@selector(showAllSubCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    supplierNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [supplierNameBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [supplierNameBtn addTarget:self action:@selector(showVendorIds:) forControlEvents:UIControlEventTouchDown];

    itemWiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemWiseBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [itemWiseBtn addTarget:self action:@selector(showAllItemWiseData:) forControlEvents:UIControlEventTouchDown];

    
    showStartDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showStartDateBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [showStartDateBtn addTarget:self  action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    showEndDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showEndDateBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [showEndDateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];

    //Creation of scroll view
    
    shipmentReturnScrollView = [[UIScrollView alloc] init];
    //shipmentReturnScrollView.backgroundColor = [UIColor lightGrayColor];

    /*Creation of UILabels used in this page*/
   
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    shipmentReturnRefLbl = [[CustomLabel alloc] init];
    [shipmentReturnRefLbl awakeFromNib];
    
    createdDateLbl = [[CustomLabel alloc] init];
    [createdDateLbl awakeFromNib];
    
    shipmentDateLbl = [[CustomLabel alloc] init];
    [shipmentDateLbl awakeFromNib];
    
    supplierNameLbl = [[CustomLabel alloc] init];
    [supplierNameLbl awakeFromNib];
    
    shipmentModeLbl = [[CustomLabel alloc] init];
    [shipmentModeLbl awakeFromNib];
    
    receivedQtyLbl = [[CustomLabel alloc] init];
    [receivedQtyLbl awakeFromNib];
    
    returnQtyLbl = [[CustomLabel alloc] init];
    [returnQtyLbl awakeFromNib];
    
    totalValueLbl = [[CustomLabel alloc] init];
    [totalValueLbl awakeFromNib];
    
    statusLbl = [[CustomLabel alloc] init];
    [statusLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    // UILabels for Displaying Totals In Footer....
    
    receivedQtyValueLbl = [[UILabel alloc] init];
    receivedQtyValueLbl.layer.cornerRadius = 5;
    receivedQtyValueLbl.layer.masksToBounds = YES;
    receivedQtyValueLbl.backgroundColor = [UIColor blackColor];
    receivedQtyValueLbl.layer.borderWidth = 2.0f;
    receivedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    receivedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    receivedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalQtyValueLbl = [[UILabel alloc] init];
    totalQtyValueLbl.layer.cornerRadius = 5;
    totalQtyValueLbl.layer.masksToBounds = YES;
    totalQtyValueLbl.backgroundColor = [UIColor blackColor];
    totalQtyValueLbl.layer.borderWidth = 2.0f;
    totalQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    totalQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    totalQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    returnQtyValueLbl = [[UILabel alloc] init];
    returnQtyValueLbl.layer.cornerRadius = 5;
    returnQtyValueLbl.layer.masksToBounds = YES;
    returnQtyValueLbl.backgroundColor = [UIColor blackColor];
    returnQtyValueLbl.layer.borderWidth = 2.0f;
    returnQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    returnQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    returnQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    receivedQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    returnQtyValueLbl.textAlignment   = NSTextAlignmentCenter;
    totalQtyValueLbl.textAlignment    = NSTextAlignmentCenter;

    receivedQtyValueLbl.text = @"0.00";
    returnQtyValueLbl.text   = @"0.00";
    totalQtyValueLbl.text       = @"0.00";

    UIButton * dropDownBtn;
    UIButton * goButton;

    //Creation of pagenationTxt...
    
    pagenationTxt = [[CustomTextField alloc] init];
    pagenationTxt.userInteractionEnabled = NO;
    pagenationTxt.textAlignment = NSTextAlignmentCenter;
    pagenationTxt.delegate = self;
    [pagenationTxt awakeFromNib];
    
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [dropDownBtn addTarget:self action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    
    //creating the UIButton which are used to show CustomerInfo popUp..
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    //stockRequestTable creation...
    shipmentReturnTable = [[UITableView alloc] init];
    shipmentReturnTable.backgroundColor  = [UIColor blackColor];
    shipmentReturnTable.layer.cornerRadius = 4.0;
    shipmentReturnTable.bounces = TRUE;
    shipmentReturnTable.dataSource = self;
    shipmentReturnTable.delegate = self;
    shipmentReturnTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //UITableView for the PopOvers to Display Filters based functionality
    
    categoriesListTbl = [[UITableView alloc]init];
    
    subCategoriesListTbl = [[UITableView alloc]init];
    
    supplierListTbl = [[UITableView alloc]init];
    
    vendorIdsTable = [[UITableView alloc]init];
    
    itemWiseListTbl = [[UITableView alloc]init];
    
    pagenationTbl = [[UITableView alloc]init];
    
    //upto Here....

    //populating text into the textFields && labels && placeholders && buttons titles....
    
    @try {
        
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        headerNameLbl.text = NSLocalizedString(@"shipment_return_summary", nil);
        
        
        //setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
        
        //Strings for Custom Labels..
        
        snoLbl.text = NSLocalizedString(@"S_NO", nil);
        shipmentReturnRefLbl.text = NSLocalizedString(@"Shipment_return_ref", nil);
        createdDateLbl.text = NSLocalizedString(@"date", nil);
        shipmentDateLbl.text = NSLocalizedString(@"shipment_date", nil);
        supplierNameLbl.text = NSLocalizedString(@"supplier_name", nil);
        shipmentModeLbl.text = NSLocalizedString(@"shpmnt_mode", nil);
        receivedQtyLbl.text = NSLocalizedString(@"recved_qty", nil);
        returnQtyLbl.text = NSLocalizedString(@"retrn_qty", nil);
        totalValueLbl.text = NSLocalizedString(@"total_value", nil);
        statusLbl.text = NSLocalizedString(@"status", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
        
    } @catch (NSException *exception) {
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        float textFieldWidth  = 170;
        float textFieldHeight = 40;
        float horizontalGap   = 25;
        
        //setting frame for the shipmentReturnView....
        shipmentReturnView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        //setting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake( 0, 0, shipmentReturnView.frame.size.width, 45);
        
        //setting frame for summaryInfoBtn....
        summaryInfoBtn.frame = CGRectMake(shipmentReturnView.frame.size.width - 45,headerNameLbl.frame.origin.y, 50, 50);
        
        //setting frame first column....
        zoneIdTxt.frame = CGRectMake(shipmentReturnView.frame.origin.x + 10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, textFieldWidth, 40);
        
        outletIdTxt.frame = CGRectMake(zoneIdTxt.frame.origin.x, zoneIdTxt.frame.origin.y + zoneIdTxt.frame.size.height +10, textFieldWidth, textFieldHeight);
        //setting frame for second column....
        categoryTxt.frame = CGRectMake(outletIdTxt.frame.origin.x + outletIdTxt.frame.size.width +horizontalGap, zoneIdTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        subCategoryTxt.frame = CGRectMake(categoryTxt.frame.origin.x, outletIdTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        //setting third column....
        supplierNameTxt.frame = CGRectMake( categoryTxt.frame.origin.x + categoryTxt.frame.size.width +horizontalGap, zoneIdTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        itemWiseTxt.frame = CGRectMake( supplierNameTxt.frame.origin.x, outletIdTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        //setting fourth column....
        startDateTxt.frame = CGRectMake( supplierNameTxt.frame.origin.x + supplierNameTxt.frame.size.width + horizontalGap, zoneIdTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        endDateTxt.frame = CGRectMake( startDateTxt.frame.origin.x, outletIdTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        //setting for the search field....
        shipmentReturnTxt.frame = CGRectMake(zoneIdTxt.frame.origin.x, endDateTxt.frame.origin.y + endDateTxt.frame.size.height +10, shipmentReturnView.frame.size.width-20,40);
        
        //setting frames for UIButtons....
        outletIdBtn.frame = CGRectMake( (outletIdTxt.frame.origin.x + outletIdTxt.frame.size.width - 45), outletIdTxt.frame.origin.y - 8,  55, 60);
        
        zoneIdBtn.frame = CGRectMake( (zoneIdTxt.frame.origin.x + zoneIdTxt.frame.size.width - 45), zoneIdTxt.frame.origin.y - 8,  55, 60);
        
        //setting for second column row....
        categoryBtn.frame = CGRectMake( (categoryTxt.frame.origin.x + categoryTxt.frame.size.width - 45), categoryTxt.frame.origin.y - 8,  55, 60);
        
        subCatBtn.frame = CGRectMake( (subCategoryTxt.frame.origin.x + subCategoryTxt.frame.size.width - 45), subCategoryTxt.frame.origin.y - 8,  55, 60);

        //setting for second column row....
        supplierNameBtn.frame = CGRectMake( (supplierNameTxt.frame.origin.x + supplierNameTxt.frame.size.width - 45), supplierNameTxt.frame.origin.y - 8,  55, 60);
        
        itemWiseBtn.frame = CGRectMake( (itemWiseTxt.frame.origin.x + itemWiseTxt.frame.size.width - 45), itemWiseTxt.frame.origin.y - 8,  55, 60);
        
        //setting for fourth column row....
        showStartDateBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-45), startDateTxt.frame.origin.y+2, 40, 35);
        
        showEndDateBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-45), endDateTxt.frame.origin.y+2, 40, 35);
        
        //setting for fifth column row....
        searchBtn.frame = CGRectMake((( shipmentReturnTxt.frame.origin.x + shipmentReturnTxt.frame.size.width) - 150), categoryTxt.frame.origin.y,150,40);
        
        clearBtn.frame = CGRectMake( searchBtn.frame.origin.x, subCategoryTxt.frame.origin.y, searchBtn.frame.size.width, searchBtn.frame.size.height);

        //Setting frame for the PagenationTxt...
         pagenationTxt.frame = CGRectMake(outletIdTxt.frame.origin.x, shipmentReturnView.frame.size.height - 45,90,40);
        
        dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x + pagenationTxt.frame.size.width-45), pagenationTxt.frame.origin.y - 5, 45, 50);
        
        goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width+15,pagenationTxt.frame.origin.y,80, 40);

        // Frame for the UIView...
        //totalInventoryView.frame = CGRectMake( shipmentReturnTxt.frame.origin.x + shipmentReturnTxt.frame.size.width - 265, pagenationTxt.frame.origin.y -18, 270, 60);
        
        // Frame for ShipmentReturnScrollView..
        
        shipmentReturnScrollView.frame = CGRectMake(shipmentReturnTxt.frame.origin.x, shipmentReturnTxt.frame.origin.y + shipmentReturnTxt.frame.size.height+5,shipmentReturnTxt.frame.size.width + 120, pagenationTxt.frame.origin.y - (shipmentReturnTxt.frame.origin.y + shipmentReturnTxt.frame.size.height + 10));
    
        snoLbl.frame = CGRectMake(0,0,40,35);
        
        shipmentReturnRefLbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        createdDateLbl.frame = CGRectMake(shipmentReturnRefLbl.frame.origin.x+shipmentReturnRefLbl.frame.size.width+2,snoLbl.frame.origin.y,80,snoLbl.frame.size.height);
        
        shipmentDateLbl.frame = CGRectMake(createdDateLbl.frame.origin.x+createdDateLbl.frame.size.width+2,snoLbl.frame.origin.y,110,snoLbl.frame.size.height);
        
        supplierNameLbl.frame = CGRectMake(shipmentDateLbl.frame.origin.x+shipmentDateLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);
        
        shipmentModeLbl.frame = CGRectMake(supplierNameLbl.frame.origin.x+supplierNameLbl.frame.size.width+2,snoLbl.frame.origin.y,110,snoLbl.frame.size.height);
        
        receivedQtyLbl.frame = CGRectMake(shipmentModeLbl.frame.origin.x+shipmentModeLbl.frame.size.width+2,snoLbl.frame.origin.y,80,snoLbl.frame.size.height);
        
        returnQtyLbl.frame = CGRectMake(receivedQtyLbl.frame.origin.x+receivedQtyLbl.frame.size.width+2,snoLbl.frame.origin.y,75,snoLbl.frame.size.height);
        
        totalValueLbl.frame = CGRectMake(returnQtyLbl.frame.origin.x+returnQtyLbl.frame.size.width+2,snoLbl.frame.origin.y,90,snoLbl.frame.size.height);
        
        statusLbl.frame = CGRectMake(totalValueLbl.frame.origin.x+totalValueLbl.frame.size.width+2,snoLbl.frame.origin.y,80,snoLbl.frame.size.height);
        
        actionLbl.frame = CGRectMake(statusLbl.frame.origin.x+statusLbl.frame.size.width+2,snoLbl.frame.origin.y,95,snoLbl.frame.size.height);

        shipmentReturnTable.frame = CGRectMake(0, snoLbl.frame.origin.y + snoLbl.frame.size.height, shipmentReturnScrollView.frame.size.width,shipmentReturnScrollView.frame.size.height - (snoLbl.frame.origin.y + snoLbl.frame.size.height));
        
        
        //Frame for the Total values in footer level...
        receivedQtyValueLbl.frame = CGRectMake(receivedQtyLbl.frame.origin.x+5,pagenationTxt.frame.origin.y, receivedQtyLbl.frame.size.width,receivedQtyLbl.frame.size.height);

        returnQtyValueLbl.frame = CGRectMake(returnQtyLbl.frame.origin.x+5,receivedQtyValueLbl.frame.origin.y, returnQtyLbl.frame.size.width,receivedQtyLbl.frame.size.height);

        totalQtyValueLbl.frame = CGRectMake(totalValueLbl.frame.origin.x+5,returnQtyValueLbl.frame.origin.y, totalValueLbl.frame.size.width,receivedQtyLbl.frame.size.height);

        
        
        
        
    }
    
    //Adding subViews for the shipmentReturnView..
    
    [shipmentReturnView addSubview:headerNameLbl];
    [shipmentReturnView addSubview:zoneIdTxt];
    [shipmentReturnView addSubview:outletIdTxt];
    [shipmentReturnView addSubview:categoryTxt];
    [shipmentReturnView addSubview:subCategoryTxt];
    [shipmentReturnView addSubview:supplierNameTxt];
    [shipmentReturnView addSubview:itemWiseTxt];
    [shipmentReturnView addSubview:startDateTxt];
    [shipmentReturnView addSubview:endDateTxt];
    
    [shipmentReturnView addSubview:outletIdBtn];
    [shipmentReturnView addSubview:zoneIdBtn];
    [shipmentReturnView addSubview:categoryBtn];
    [shipmentReturnView addSubview:subCatBtn];
    [shipmentReturnView addSubview:supplierNameBtn];
    [shipmentReturnView addSubview:itemWiseBtn];
    [shipmentReturnView addSubview:showStartDateBtn];
    [shipmentReturnView addSubview:showEndDateBtn];
    
    [shipmentReturnView addSubview:shipmentReturnTxt];
    
    [shipmentReturnView addSubview:shipmentReturnScrollView];
    
    [shipmentReturnScrollView addSubview:snoLbl];
    [shipmentReturnScrollView addSubview:shipmentReturnRefLbl];
    [shipmentReturnScrollView addSubview:createdDateLbl];
    [shipmentReturnScrollView addSubview:shipmentDateLbl];
    [shipmentReturnScrollView addSubview:supplierNameLbl];
    [shipmentReturnScrollView addSubview:shipmentModeLbl];
    [shipmentReturnScrollView addSubview:receivedQtyLbl];
    [shipmentReturnScrollView addSubview:returnQtyLbl];
    [shipmentReturnScrollView addSubview:totalValueLbl];
    [shipmentReturnScrollView addSubview:statusLbl];
    [shipmentReturnScrollView addSubview:actionLbl];
    
    [shipmentReturnScrollView addSubview:shipmentReturnTable];
    
    [shipmentReturnView addSubview:pagenationTxt];
    [shipmentReturnView addSubview:dropDownBtn];
    [shipmentReturnView addSubview:goButton];
    
    [shipmentReturnView addSubview:receivedQtyValueLbl];
    [shipmentReturnView addSubview:returnQtyValueLbl];
    [shipmentReturnView addSubview:totalQtyValueLbl];

    
    [shipmentReturnView addSubview:searchBtn];
    
    [shipmentReturnView addSubview:clearBtn];

    //Adding shipmentReturnView for the main view..
    
    [self.view addSubview:shipmentReturnView];
    
    //Using the Default font size for the whole veiw..
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
    
    //font size for the headerNameLbl..
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    
    searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];


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
    
    
    //Tags Used for the Identification purpose...
    searchBtn.tag = 2;
    itemWiseListTbl.tag = 0;
    
    showStartDateBtn.tag = 2;
    showEndDateBtn.tag = 4;

    categoryTxt.tag = 2;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/**
 * @description  it is one of ViewLifeCylce which will be executed after execution of viewDidLoad.......
 * @date         08/12/2017
 * @method       viewDidAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated {
    //calling super method....
    [super viewDidAppear:YES];
    
    @try {
        [HUD setHidden:NO];
        
        //startIndex = 0;
        //shipmentReturnArray = [NSMutableArray new];
        
        [self getShipmentReturn];
        
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in serviceCall of callingGetStockReqeusts------------%@",exception);
    } @finally {
        
    }
}



#pragma mark Methods.

/**
 * @description  Sending the Request to DB to Get the ShipmentReturn Details...
 * @date         08/12/2017
 * @method       getShipmentReturn
 * @author       Bhargav.v
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
-(void)getShipmentReturn {
    
    @try {
      
        //showing the hud....
        [HUD setHidden:NO];
        
        //text format of the HUD...
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(shipmentReturnArray == nil && startIndex == 0){
            
            totalShipmentReturns = 0;
            
            shipmentReturnArray = [NSMutableArray new];
        }
        else if(shipmentReturnArray.count ){
            
            [shipmentReturnArray removeAllObjects];
        }
        
        if (startIndex == 0)
            receivedQtyValueLbl.text = [NSString stringWithFormat:@"%@",@"0.00"];
        returnQtyValueLbl.text   = [NSString stringWithFormat:@"%@",@"0.00"];
        totalQtyValueLbl.text   = [NSString stringWithFormat:@"%@",@"0.00"];

        

        NSString * startDteStr = startDateTxt.text;
        NSString * endDteStr  = endDateTxt.text;
        
        NSMutableDictionary * shipmentReturnDetails = [[NSMutableDictionary alloc] init];
        
        //setting requestHeader....
        shipmentReturnDetails[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        //Setting startIndex as 0
        shipmentReturnDetails[START_INDEX] = [NSString stringWithFormat:@"%d",startIndex];
        
        //Setting itemsReq as true (Boolean )
        shipmentReturnDetails[ITEMS_REQ] = [NSNumber numberWithBool:true];

        //Setting SupplierId As empty String.(temporary)
        shipmentReturnDetails[SUPPLIER_ID] = @"";

        shipmentReturnDetails[SEARCH_CRITERIA] = shipmentReturnTxt.text;

        //Setting purchaseStockReturnRef As empty String.(temporary)
        shipmentReturnDetails[PURCHASE_STOCK_RETURN_REF] = @"";

        //Setting skuId As empty String.(temporary)
        shipmentReturnDetails[ITEM_SKU] = @"";

        
        if((startDateTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDateTxt.text,@" 00:00:00"];
        
        
        if ((endDateTxt.text).length > 0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        }

        //Setting startDate
        shipmentReturnDetails[START_DATE] = startDteStr;

        //Setting endDate
        shipmentReturnDetails[END_DATE] = endDteStr;
        
        //Setting category As empty String.(temporary)
        shipmentReturnDetails[ITEM_CATEGORY] = @"";

        //Setting subCategory As empty String.(temporary)
        shipmentReturnDetails[kSubCategory] = @"";

        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:shipmentReturnDetails options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.shipmentReturnDelegate = self;
        [webServiceController getShipmentReturn:quoteRequestJsonString];

        
    } @catch (NSException *exception) {
        
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getWorkFlows ServicesCall ----%@",exception);
        
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


-(void)callingSubCategoriesList:(NSString *)categoryName {
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(categoriesListTbl.tag == 2 )
            locationWiseCategoriesArr = [NSMutableArray new];
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling CategoriesList ServicesCall ----%@",exception);
        
    }
    @finally {
        
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

-(void)getSuppliers:(NSString *)supplierNameStr {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        if(vendorIdsArray == nil)
            
            vendorIdsArray = [NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,PAGE_NO,SEARCH_CRITERIA];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,supplierNameStr];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.supplierServiceSvcDelegate = self;
        [webServiceController getSupplierDetailsData:salesReportJsonString];
        
    }
    @catch (NSException * exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
    }
    
}



#pragma mark Response Handling Methods..


/**
 * @description  Handling the Success Response
 * @date         08 /12/2017
 * @method       getShipmentReturnSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)getShipmentReturnSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        //Using to Display the Item wise Data (Description)....
        itemWiseListArr = [NSMutableArray new];
        
        //added on 23/05/2017....
        float receivedQty = 0;
        float returnQty   = 0;
        float totalValue  = 0;
        
        if((receivedQtyValueLbl.text).length)
            receivedQty = (receivedQtyValueLbl.text).floatValue;
        
        if((returnQtyValueLbl.text).length)
            returnQty = (returnQtyValueLbl.text).floatValue;
        
        if((totalQtyValueLbl.text).length)
            totalValue = (totalQtyValueLbl.text).floatValue;

        
        totalShipmentReturns  = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_RECORDS]  defaultReturn:@"0"]intValue];
        
        for(NSDictionary * dic in [successDictionary valueForKey:STORE_SHIPMENT_RETURN_LIST]){
            
            for (NSDictionary * itemDic in [dic valueForKey:STOCK_RETURN_ITEMS] ) {
                
                receivedQty  += [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"] floatValue];
                returnQty    += [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
                
                totalValue   += [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:ITEM_TOTAL_VALUE] defaultReturn:@"0.00"] floatValue];
                
                NSMutableDictionary * itemWiseDic  = [NSMutableDictionary new];
                                                      
                itemWiseDic[ITEM_DESC] = [self checkGivenValueIsNullOrNil:[itemDic valueForKey:ITEM_DESC] defaultReturn:@"--"];
                itemWiseDic[kItemID] = [self checkGivenValueIsNullOrNil:[itemDic valueForKey:kItemID] defaultReturn:@"--"];
                
                [itemWiseListArr addObject:itemWiseDic];
            }
            
            [shipmentReturnArray addObject:dic];
           
            receivedQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", receivedQty];
            returnQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", returnQty];
            totalQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"", totalValue];

        }
        
        //Recently Added By Bhargav.v on 17/10/2017..
        //Reason: To Display the Records in pagination mode based on the Total Records..
        
        int strTotalRecords = totalShipmentReturns/10;
        
        int remainder = totalShipmentReturns % 10;
        
        //NSLog(@"%i", strTotalRecords);
        //NSLog(@"%i", remainder);
        
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

        
    } @catch (NSException *exception) {
        
    } @finally {
        
        if(startIndex == 0){
            pagenationTxt.text = @"1";
        }

        
        [shipmentReturnTable reloadData];
        
        [HUD setHidden: YES];

    }
    
    
}

/**
 * @description Handling the Error Response..
 * @date        08/12/2017
 * @method      getShipmentReturnErrorResponse
 * @author      Bhargav.v
 * @param       NSString
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
-(void)getShipmentReturnErrorResponse:(NSString *)errorResponse {
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];

    } @catch (NSException *exception) {
        
    } @finally {
        
        
        [shipmentReturnTable reloadData];

    }
}


/**
 * @description  Handling the Success Response..
 * @date         21/12/2017 (Added in this class on 2/01/2018)
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
        
        for(NSDictionary * categoryDic in [successDictionary valueForKey:@"categoryList"]) {
            
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
        
        
    } @catch (NSException * exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
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
            [locationWiseCategoriesArr addObject:NSLocalizedString(@"all_categories",nil)];
        else
            [subCategoriesListArr addObject:NSLocalizedString(@"all_subcategories",nil)];
        
        for (NSDictionary * categoryDic in  [sucessDictionary valueForKey:CATEGORIES]){
            
            if(categoriesListTbl.tag == 2) {
                
                
                [locationWiseCategoriesArr addObject:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:kCategoryName]  defaultReturn:@""]];
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
 */

-(void)getCategoryErrorResponse:(NSString*)error {
    
    [HUD setHidden:YES];
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


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

- (void)getSuppliersSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        if([successDictionary[SUPPLIERS] count]){
            
            
            for (NSDictionary *dic in successDictionary[SUPPLIERS]){
                
                NSMutableDictionary *tempDic = [NSMutableDictionary new];
                
                [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[SUPPLIER_CODE] defaultReturn:@""] forKey:SUPPLIER_CODE];
                [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[FIRM_NAME] defaultReturn:@""] forKey:SUPPLIER_NAME];
                
                [vendorIdsArray addObject:tempDic];
            }
            
        }
        else{
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
            
        }
        
        
    } @catch (NSException *exception) {
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
        
        
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
        
        if(shipmentReturnTxt.isEditing)
            y_axis = shipmentReturnTxt.frame.origin.y + shipmentReturnTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        NSLog(@"---- exception while handling the getSuppliers ErrorResponse----%@",exception);
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
    }
    
}

#pragma mark popovers used to display...

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
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = locationWiseCategoriesArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationWiseCategoriesArr.count * 33;
        
        if(locationWiseCategoriesArr.count > 5)
            tableHeight =(tableHeight/locationWiseCategoriesArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
            return;
        }
        
        if((subCategoriesListArr == nil) || (subCategoriesListArr.count == 0)){
            
            //for identification....
            categoriesListTbl.tag = 4;
            subCategoriesListTbl.tag = 2;
            [self callingSubCategoriesList:categoryTxt.text];
        }
        
        [HUD setHidden:YES];
        
        if(subCategoriesListArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
            
            return;
        }
        float tableHeight = subCategoriesListArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoriesListArr.count * 33;
        
        if(subCategoriesListArr.count > 5)
            tableHeight = (tableHeight/subCategoriesListArr.count)*5;
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:(subCategoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
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

- (void)showVendorIds:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((vendorIdsArray == nil) || (vendorIdsArray.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self getSuppliers:@""];
        }
        
        [HUD setHidden:YES];
        
        if(vendorIdsArray.count == 0){
            
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = vendorIdsArray.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = vendorIdsArray.count * 33;
        
        if(vendorIdsArray.count > 5)
            tableHeight = (tableHeight/vendorIdsArray.count) * 5;
        
        [self showPopUpForTables:vendorIdsTable  popUpWidth:(supplierNameTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:supplierNameTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}



/**
 * @description  Displaying  itemWise List by calling the shipment Return.....
 * @date         02/01/2018
 * @method       showAllItemWiseData
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)showAllItemWiseData:(UIButton*)sender {
    
    @try {
        
        if (itemWiseListArr.count) {
            
            float tableHeight = itemWiseListArr.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = itemWiseListArr.count * 33;
            
            if(itemWiseListArr.count > 5)
                tableHeight = (tableHeight/itemWiseListArr.count) * 5;
            
            [self showPopUpForTables:itemWiseListTbl  popUpWidth:(itemWiseTxt.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:itemWiseTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        }
        
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
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
            return;
        }
        float tableHeight = pagenationArr.count *40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArr.count * 33;
        
        if(pagenationArr.count> 5)
            tableHeight = (tableHeight/pagenationArr.count) * 5;
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
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
        
        [self getShipmentReturn];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
    }
}


/**
 * @description  here we are sending the Request through searchTheProducts to filter the Records based on the selection...
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
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0  && (startDateTxt.text).length == 0 && (endDateTxt.text).length== 0 && (outletIdTxt.text).length== 0 ) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_above_fields_before_proceeding",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
            return;
        }
        else
            [HUD setHidden:NO];
         startIndex = 0;
        [self getShipmentReturn];
        
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
        
        categoryTxt.text     = @"";
        subCategoryTxt.text  = @"";
        supplierNameTxt.text = @"";
        itemWiseTxt.text     = @"";
        startDateTxt.text    = @"";
        endDateTxt.text      = @"";
        
        startIndex = 0;
        [self getShipmentReturn];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
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

- (void)newShipmentReturn:(UIButton *)sender {
    
    @try {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        ShipmentReturnNew * shipmentReturn = [[ShipmentReturnNew alloc ] init];
        [self.navigationController pushViewController:shipmentReturn animated:YES];
        
    } @catch (NSException *exception) {
        
        
    } @finally {
        
        
    }
}


/**
 * @description
 * @date         04/01/2018
 * @method
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)openShipmentReturn:(UIButton *)sender {
    
    @try {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        ShipmentReturnEdit * shipmentReturn = [[ShipmentReturnEdit alloc ] init];
        shipmentReturn.purchaseStockStr = [shipmentReturnArray[sender.tag] valueForKey:PURCHASE_STOCK_RETURN_REF];

        [self.navigationController pushViewController:shipmentReturn animated:YES];

    } @catch (NSException *exception) {
        
    } @finally {
        
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
        
        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:shipmentReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
                //                callServices = true;
                
                
                startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                //                callServices = true;
                
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
            
            [self displayAlertMessage:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
            
            return;
        }
        
        NSDate * existingDateString;
        
        if( sender.tag == 2) {
            if ((endDateTxt.text).length != 0 && (![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:370 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
                    return;
                    
                }
            }
            
            startDateTxt.text = dateString;
        }
        else {
            
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:370 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
                    
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
        
        
        if (textField == shipmentReturnTxt ) {
            
            if ((textField.text).length >= 4 ) {
                
                @try {
                    
                    startIndex = 0;
                    shipmentReturnArray = [NSMutableArray new];
                    [self getShipmentReturn];
                    
                    
                } @catch (NSException *exception) {
                    NSLog(@"---- exception while calling ServicesCall ----%@",exception);
                    
                } @finally {
                    
                }
            }
            else if ((textField.text).length == 0) {
                
                startIndex = 0;
                shipmentReturnArray = [NSMutableArray new];
                [self getShipmentReturn];
            }
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }

}
#pragma mark Table View Delegates..

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
    
    if(tableView == shipmentReturnTable){
        if (shipmentReturnArray.count)
            
            return shipmentReturnArray.count;
        else
            return 1;
    }
    
    else if(tableView == categoriesListTbl){
        
        return locationWiseCategoriesArr.count;
        
    }
    else if(tableView == subCategoriesListTbl){
        
        return subCategoriesListArr.count;
        
    }
    else if(tableView == itemWiseListTbl){
        
        return itemWiseListArr.count;
    }
    else if (tableView == vendorIdsTable){
        
        return vendorIdsArray.count;
    }
    else if (tableView == pagenationTbl){
        
        return pagenationArr.count;
    }

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
        
        if(tableView == shipmentReturnTable){
            
            return  38;
        }
        
        else if (tableView == categoriesListTbl ||tableView == subCategoriesListTbl || tableView == itemWiseListTbl || tableView == vendorIdsTable || tableView == pagenationTbl) {
            
            return 35;
        }
        
    }
    
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
 * @modified BY
 * @reason
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == shipmentReturnTable) {
        
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
                
                layer_1.frame = CGRectMake( snoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(snoLbl.frame.origin.x),1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException *exception) {
                
            }
        }
        tableView.separatorColor = [UIColor clearColor];
        
        
        /*UILabels used in this cell*/
        UILabel * sno_Lbl;
        UILabel * returnRef_Lbl;;
        UILabel * createdDate_Lbl;
        UILabel * shipmentDate_Lbl;
        UILabel * supplierName_Lbl;
        UILabel * shipmentMode_Lbl;
        UILabel * receivedQty_Lbl;
        UILabel * returnQty_Lbl;
        UILabel * totalValue_Lbl;
        UILabel * status_Lbl;
        
        
        /*Creation of UILabels used in this cell*/
        sno_Lbl = [[UILabel alloc] init];
        sno_Lbl.backgroundColor = [UIColor clearColor];
        sno_Lbl.textAlignment = NSTextAlignmentCenter;
        sno_Lbl.numberOfLines = 1;
        sno_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        returnRef_Lbl = [[UILabel alloc] init];
        returnRef_Lbl.backgroundColor = [UIColor clearColor];
        returnRef_Lbl.textAlignment = NSTextAlignmentCenter;
        returnRef_Lbl.numberOfLines = 1;
        returnRef_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        createdDate_Lbl = [[UILabel alloc] init];
        createdDate_Lbl.backgroundColor = [UIColor clearColor];
        createdDate_Lbl.textAlignment = NSTextAlignmentCenter;
        createdDate_Lbl.numberOfLines = 1;
        createdDate_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        shipmentDate_Lbl = [[UILabel alloc] init];
        shipmentDate_Lbl.backgroundColor = [UIColor clearColor];
        shipmentDate_Lbl.textAlignment = NSTextAlignmentCenter;
        shipmentDate_Lbl.numberOfLines = 1;
        shipmentDate_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        supplierName_Lbl = [[UILabel alloc] init];
        supplierName_Lbl.backgroundColor = [UIColor clearColor];
        supplierName_Lbl.textAlignment = NSTextAlignmentCenter;
        supplierName_Lbl.numberOfLines = 1;
        supplierName_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        shipmentMode_Lbl = [[UILabel alloc] init];
        shipmentMode_Lbl.backgroundColor = [UIColor clearColor];
        shipmentMode_Lbl.textAlignment = NSTextAlignmentCenter;
        shipmentMode_Lbl.numberOfLines = 1;
        shipmentMode_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        receivedQty_Lbl = [[UILabel alloc] init];
        receivedQty_Lbl.backgroundColor = [UIColor clearColor];
        receivedQty_Lbl.textAlignment = NSTextAlignmentCenter;
        receivedQty_Lbl.numberOfLines = 1;
        receivedQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        returnQty_Lbl = [[UILabel alloc] init];
        returnQty_Lbl.backgroundColor = [UIColor clearColor];
        returnQty_Lbl.textAlignment = NSTextAlignmentCenter;
        returnQty_Lbl.numberOfLines = 1;
        returnQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        totalValue_Lbl = [[UILabel alloc] init];
        totalValue_Lbl.backgroundColor = [UIColor clearColor];
        totalValue_Lbl.textAlignment = NSTextAlignmentCenter;
        totalValue_Lbl.numberOfLines = 1;
        totalValue_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        status_Lbl = [[UILabel alloc] init];
        status_Lbl.backgroundColor = [UIColor clearColor];
        status_Lbl.textAlignment = NSTextAlignmentCenter;
        status_Lbl.numberOfLines = 1;
        status_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        
        /* Creation of UIButton's used in this cell for navigation */
        
        newButton = [[UIButton alloc] init];
        newButton.titleLabel.textColor = [UIColor whiteColor];
        newButton.userInteractionEnabled = YES;
        newButton.tag = indexPath.row;
        [newButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
        
        openButton = [[UIButton alloc] init];
        openButton.titleLabel.textColor =  [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        openButton.userInteractionEnabled = YES;
        openButton.tag = indexPath.row;
        [openButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];

        [newButton addTarget:self action:@selector(newShipmentReturn:) forControlEvents:UIControlEventTouchUpInside];
        [openButton addTarget:self action:@selector(openShipmentReturn:) forControlEvents:UIControlEventTouchUpInside];

        
        //setting the color to text....
        sno_Lbl.textColor          = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        returnRef_Lbl.textColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        createdDate_Lbl.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        shipmentDate_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        supplierName_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        shipmentMode_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        receivedQty_Lbl.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        returnQty_Lbl.textColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        totalValue_Lbl.textColor   = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        status_Lbl.textColor       = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        
        //added subview to cell View....
        [hlcell.contentView addSubview:sno_Lbl];
        [hlcell.contentView addSubview:returnRef_Lbl];
        [hlcell.contentView addSubview:createdDate_Lbl];
        [hlcell.contentView addSubview:shipmentDate_Lbl];
        [hlcell.contentView addSubview:supplierName_Lbl];
        [hlcell.contentView addSubview:shipmentMode_Lbl];
        [hlcell.contentView addSubview:receivedQty_Lbl];
        [hlcell.contentView addSubview:returnQty_Lbl];
        [hlcell.contentView addSubview:totalValue_Lbl];
        [hlcell.contentView addSubview:status_Lbl];
        [hlcell.contentView addSubview:newButton];

        
        //setting frame and font........
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame....
            sno_Lbl.frame = CGRectMake(snoLbl.frame.origin.x, 0, snoLbl.frame.size.width, hlcell.frame.size.height);

            returnRef_Lbl.frame = CGRectMake(shipmentReturnRefLbl.frame.origin.x, 0, shipmentReturnRefLbl.frame.size.width-6, hlcell.frame.size.height);

            createdDate_Lbl.frame = CGRectMake(createdDateLbl.frame.origin.x, 0, createdDateLbl.frame.size.width, hlcell.frame.size.height);

            shipmentDate_Lbl.frame = CGRectMake(shipmentDateLbl.frame.origin.x, 0, shipmentDateLbl.frame.size.width, hlcell.frame.size.height);

            supplierName_Lbl.frame = CGRectMake(supplierNameLbl.frame.origin.x, 0, supplierNameLbl.frame.size.width, hlcell.frame.size.height);

            shipmentMode_Lbl.frame = CGRectMake(shipmentModeLbl.frame.origin.x, 0, shipmentModeLbl.frame.size.width, hlcell.frame.size.height);

            receivedQty_Lbl.frame = CGRectMake(receivedQtyLbl.frame.origin.x, 0, receivedQtyLbl.frame.size.width, hlcell.frame.size.height);

            returnQty_Lbl.frame = CGRectMake(returnQtyLbl.frame.origin.x, 0, returnQtyLbl.frame.size.width, hlcell.frame.size.height);

            totalValue_Lbl.frame = CGRectMake(totalValueLbl.frame.origin.x, 0, totalValueLbl.frame.size.width, hlcell.frame.size.height);

            status_Lbl.frame = CGRectMake(statusLbl.frame.origin.x, 0, statusLbl.frame.size.width, hlcell.frame.size.height);

            newButton.frame = CGRectMake(actionLbl.frame.origin.x-8, 0, 60 ,  hlcell.frame.size.height);
            
            openButton.frame = CGRectMake(newButton.frame.origin.x + newButton.frame.size.width-12, 0, 60,hlcell.frame.size.height);

            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0 cornerRadius:0.0];
            
            newButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];
            openButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];

            
        }
        else{
            
            //DO CODING FOR IPHONE
        }
        
        @try {
            
            //Setting button Title....
            [newButton setTitle:NSLocalizedString(@"New", nil) forState:UIControlStateNormal];
            [openButton setTitle:NSLocalizedString(@"Open", nil) forState:UIControlStateNormal];

            
            if (shipmentReturnArray.count >= indexPath.row && shipmentReturnArray.count ) {
                
                //addded by Srinivsulu on 09/05/2017....
                [hlcell.contentView addSubview:openButton];
                
                NSDictionary * dic = shipmentReturnArray[indexPath.row];
                
                sno_Lbl.text = [NSString stringWithFormat:@"%d",(int)(indexPath.row + 1) + startIndex];
                
                returnRef_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:PURCHASE_STOCK_RETURN_REF] defaultReturn:@""];
                
                createdDate_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:CREATED_DATE_STR] componentsSeparatedByString:@" "][0] defaultReturn:@""];
                
                shipmentDate_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:kShippedOnStr] componentsSeparatedByString:@" "][0] defaultReturn:@""];
                
                supplierName_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SUPPLIER_NAME] defaultReturn:@""];
                
                if ([[dic valueForKey:TRANSPORT_MODE]isKindOfClass:[NSNull class]]|| (![[dic valueForKey:TRANSPORT_MODE]isEqualToString:@""])) {
                    
                    shipmentMode_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:TRANSPORT_MODE] defaultReturn:@""];
                }
                else
                    shipmentMode_Lbl.text = @"--";
                
                float receivedQty = 0;
                float returnedQty = 0;
                float totalValue  = 0;
                
                for (NSDictionary * locDic in  [dic valueForKey:STOCK_RETURN_ITEMS]) {
                    
                    receivedQty  += [[self checkGivenValueIsNullOrNil:[locDic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"] floatValue];
                    
                    returnedQty  += [[self checkGivenValueIsNullOrNil:[locDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
                    
                    totalValue   += [[self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_TOTAL_VALUE] defaultReturn:@"0.00"] floatValue];

                }
                
                receivedQty_Lbl.text = [NSString stringWithFormat:@"%.2f",receivedQty];
                
                returnQty_Lbl.text = [NSString stringWithFormat:@"%.2f",returnedQty];
                
                totalValue_Lbl.text = [NSString stringWithFormat:@"%.2f",totalValue];
                
                status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS] defaultReturn:@""];
            }
            
            else {
                
                sno_Lbl.text          = @"--";
                returnRef_Lbl.text    = @"--";
                createdDate_Lbl.text  = @"--";
                shipmentDate_Lbl.text = @"--";
                supplierName_Lbl.text = @"--";
                shipmentMode_Lbl.text = @"--";
                receivedQty_Lbl.text  = @"--";
                returnQty_Lbl.text    = @"--";
                totalValue_Lbl.text   = @"--";
                status_Lbl.text       = @"--";
                
                newButton.frame = CGRectMake(actionLbl.frame.origin.x, 0, actionLbl.frame.size.width, hlcell.frame.size.height);
                
            }
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        hlcell.backgroundColor = [UIColor clearColor];
        hlcell.tag = indexPath.section;
        
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
 
    }
    else if(tableView == categoriesListTbl) {
        
        static NSString *CellIdentifier = @"Cell";
        
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
        static NSString * CellIdentifier = @"Cell";
        
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
    
    else if(tableView == itemWiseListTbl) {
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
            hlcell.textLabel.text = [itemWiseListArr valueForKey:ITEM_DESC ][indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        
        } @catch (NSException * exception) {
            
        }
        return hlcell;
    }
    if(tableView == vendorIdsTable) {
    
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
        
        @try {
            
            hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:vendorIdsArray[indexPath.row][SUPPLIER_NAME] defaultReturn:@""];
            
            hlcell.textLabel.numberOfLines = 1;
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            return hlcell;
            
        } @catch (NSException *exception) {
            
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

    return 0;
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
    
    if(tableView == categoriesListTbl) {
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
    
    else if(tableView == itemWiseListTbl) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            itemWiseListTbl.tag = indexPath.row;
            
            itemWiseTxt.text = [itemWiseListArr valueForKey:ITEM_DESC ][indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == vendorIdsTable){
        
        vendorIdsTable.tag = indexPath.row;
        
        supplierNameTxt.text = [self checkGivenValueIsNullOrNil:vendorIdsArray[indexPath.row][SUPPLIER_NAME] defaultReturn:@"--"] ;
        
    }
    
    else if (tableView == pagenationTbl){
        
        @try {
            
            startIndex = 0;
            pagenationTxt.text = pagenationArr[indexPath.row];
            int pageValue = (pagenationTxt.text).intValue;
            startIndex = startIndex + (pageValue * 10) - 10;
            
        } @catch (NSException * exception) {
            
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timing:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines {
    
    
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
            
            if(shipmentReturnTxt.isEditing)
                
                yPosition = shipmentReturnTxt.frame.origin.y + shipmentReturnTxt.frame.size.height;
            
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
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } @catch (NSException *exception) {
        
    }
}


@end
