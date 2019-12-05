//
//  PastDeals.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Offers.h"
//#import "SDZDealService.h"
#import "DealServicesSvc.h"
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "OfferServiceSvc.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

@implementation Offers

@synthesize soundFileURLRef,soundFileObject;

@synthesize isSavingLocally;


#pragma  - mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         05/02/2018
 * @method       ViewDidLoad
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)viewDidLoad {
    //Super class Method.....
    [super viewDidLoad];
    
    // Do any Additional Setup After loading The view...
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
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
    
    //creating the stockRequestView which will displayed completed Screen.......
    offersView = [[UIView alloc] init];
    offersView.backgroundColor = [UIColor blackColor];
    offersView.layer.borderWidth = 1.0f;
    offersView.layer.cornerRadius = 10.0f;
    offersView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
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
    
    // UI under the Deals View.....
    
    
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
    
    modelTxt = [[CustomTextField alloc] init];
    modelTxt.placeholder = NSLocalizedString(@"all_models", nil);
    modelTxt.delegate = self;
    [modelTxt awakeFromNib];
    modelTxt.userInteractionEnabled = NO;
    
    statusTxt = [[CustomTextField alloc] init];
    statusTxt.placeholder = NSLocalizedString(@"select_status", nil);
    statusTxt.delegate = self;
    [statusTxt awakeFromNib];
    statusTxt.userInteractionEnabled = NO;
    
    UIButton * clearBtn;
    
    searchBtn = [[UIButton alloc] init];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    clearBtn = [[UIButton alloc] init];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [searchBtn addTarget:self action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    
    /*Creation of UIImage used for button backgrounds*/
    UIImage * dropDownButtonImage = [UIImage imageNamed:@"arrow.png"];
    
    UIImage *  calendarImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    
    /*Creation  UIButton's  */
    UIButton * zoneBtn;
    UIButton * locationBtn;
    
    UIButton * showCategoriesBtn;
    UIButton * showSubCategoriesBtn;
    
    UIButton * showDepartmentListBtn;
    UIButton * showSubDepartmentBtn;
    
    UIButton * showModelBtn;
    UIButton * showStatusBtn;
    
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
    
    showDepartmentListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showDepartmentListBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showDepartmentListBtn addTarget:self action:@selector(showDepartmentList:) forControlEvents:UIControlEventTouchDown];
    
    showSubDepartmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showSubDepartmentBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showSubDepartmentBtn addTarget:self  action:@selector(showSubDepartmentList:) forControlEvents:UIControlEventTouchDown];
    
    showModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showModelBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showModelBtn addTarget:self  action:@selector(showAllModelsList:) forControlEvents:UIControlEventTouchDown];
    
    showStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showStatusBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [showStatusBtn addTarget:self action:@selector(showDealStatusList:) forControlEvents:UIControlEventTouchDown];
    
    showStartDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showStartDteBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [showStartDteBtn addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    showEndDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showEndDateBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [showEndDateBtn addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //Creation of Search Text to Search deals...
    searchOffersText = [[CustomTextField alloc]init];
    searchOffersText.borderStyle = UITextBorderStyleRoundedRect;
    searchOffersText.placeholder = NSLocalizedString(@"search_deals", nil);
    searchOffersText.autocorrectionType = UITextAutocorrectionTypeNo;
    searchOffersText.backgroundColor = [UIColor lightGrayColor];
    searchOffersText.keyboardType = UIKeyboardTypeDefault;
    searchOffersText.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchOffersText.userInteractionEnabled = YES;
    searchOffersText.delegate = self;
    // [searchOffersText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton * dropDownBtn;
    UIButton * goButton;
    
    //Creation of pagenationTxt...
    
    pagenationTxt = [[CustomTextField alloc] init];
    pagenationTxt.userInteractionEnabled = NO;
    pagenationTxt.textAlignment = NSTextAlignmentCenter;
    pagenationTxt.delegate = self;
    [pagenationTxt awakeFromNib];
    
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:dropDownButtonImage forState:UIControlStateNormal];
    [dropDownBtn addTarget:self action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    
    //creating the UIButton which are used to show CustomerInfo popUp..
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    
    //Creation of scroll view
    dealsScrollView = [[UIScrollView alloc] init];
    // dealsScrollView.backgroundColor = [UIColor lightGrayColor];
    
    /*Creation of UILabels used in this page*/
    
    snoLabel = [[CustomLabel alloc] init];
    [snoLabel awakeFromNib];
    
    offerIdsLabel = [[CustomLabel alloc] init];
    [offerIdsLabel awakeFromNib];
    
    descriptionLabel = [[CustomLabel alloc] init];
    [descriptionLabel awakeFromNib];
    
    startDateLabel = [[CustomLabel alloc] init];
    [startDateLabel awakeFromNib];
    
    endDateLabel = [[CustomLabel alloc] init];
    [endDateLabel awakeFromNib];
    
    statusLabel = [[CustomLabel alloc] init];
    [statusLabel awakeFromNib];
    
    itemGroupLabel = [[CustomLabel alloc] init];
    [itemGroupLabel awakeFromNib];
    
    offerTypeLabel = [[CustomLabel alloc] init];
    [offerTypeLabel awakeFromNib];
    
    saleQtyLabel = [[CustomLabel alloc] init];
    [saleQtyLabel awakeFromNib];
    
    saleValueLabel = [[CustomLabel alloc] init];
    [saleValueLabel awakeFromNib];
    
    //stockRequestTable creation...
    currentOffersTable = [[UITableView alloc] init];
    currentOffersTable.backgroundColor  = [UIColor blackColor];
    currentOffersTable.layer.cornerRadius = 4.0;
    currentOffersTable.bounces = TRUE;
    currentOffersTable.dataSource = self;
    currentOffersTable.delegate = self;
    currentOffersTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //table's used in popUp's.......
    //categoriesListTbl allocation
    categoriesListTbl = [[UITableView alloc] init];
    
    //subCategoriesListTbl allocation..
    subCategoriesListTbl = [[UITableView alloc] init];
    
    
    //departmentListTbl Allocation...
    departmentListTbl = [[UITableView alloc] init];
    
    //subDepartmentListTbl Allocation...
    subDepartmentListTbl = [[UITableView alloc] init];
    
    //supplierListTbl Allocation...
    modelTable = [[UITableView alloc] init];
    
    //pagenationTbl Allocation.....
    pagenationTbl = [[UITableView alloc] init];
    
    //setting the titleName for the Page....
    self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
    HUD.labelText        = NSLocalizedString(@"please_wait..", nil);
    headerNameLbl.text   = NSLocalizedString(@"offers_view", nil);
    
    [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
    [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
    
    [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
    
    
    //Strings For Custom Labels.....
    
    
    snoLabel.text         = NSLocalizedString(@"S_NO", nil);
    offerIdsLabel.text    = NSLocalizedString(@"offerIds", nil);
    descriptionLabel.text = NSLocalizedString(@"description", nil);
    startDateLabel.text   = NSLocalizedString(@"start_date", nil);
    endDateLabel.text     = NSLocalizedString(@"end_date", nil);
    statusLabel.text      = NSLocalizedString(@"status", nil);
    itemGroupLabel.text   = NSLocalizedString(@"item_group", nil);
    offerTypeLabel.text   = NSLocalizedString(@"offer_type", nil);
    saleQtyLabel.text     = NSLocalizedString(@"sale_qty", nil);
    saleValueLabel.text   = NSLocalizedString(@"sale_val", nil);
    
    if (currentOrientation==UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame for the main view....
            offersView.frame = CGRectMake(2,70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            //setting frame for the headerNameLbl....
            headerNameLbl.frame = CGRectMake( 0, 0, offersView.frame.size.width, 45);
            
            float textFieldWidth =  160;
            float textFieldHeight = 40;
            
            float vertical_Gap = 20;
            float horzantial_Gap = 10;
            
            //Frame for the zoneTxt
            zoneTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + vertical_Gap,textFieldWidth,textFieldHeight);
            
            //Frame for the locationText..
            locationTxt.frame = CGRectMake(zoneTxt.frame.origin.x, zoneTxt.frame.origin.y + zoneTxt.frame.size.height + vertical_Gap,textFieldWidth,textFieldHeight);
            //Frame for the categoryTxt
            categoryTxt.frame = CGRectMake(zoneTxt.frame.origin.x+zoneTxt.frame.size.width + horzantial_Gap,zoneTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            //Frame for the subCategoryTxt
            subCategoryTxt.frame  = CGRectMake(categoryTxt.frame.origin.x,locationTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            //Frame for the brandTxt....
            
            //brandTxt.frame = CGRectMake(categoryTxt.frame.origin.x+categoryTxt.frame.size.width + horzantial_Gap,categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            //sectionTxt.frame= CGRectMake(brandTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            
            //Frame for the brandTxt
            departmentTxt.frame = CGRectMake(categoryTxt.frame.origin.x + categoryTxt.frame.size.width + horzantial_Gap, categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            //Frame for the subDepartmentTxt
            subDepartmentTxt.frame = CGRectMake(departmentTxt.frame.origin.x, subCategoryTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            
            //Frame for the modelTxt
            modelTxt.frame = CGRectMake(departmentTxt.frame.origin.x+departmentTxt.frame.size.width + horzantial_Gap,categoryTxt.frame.origin.y, textFieldWidth,textFieldHeight);
            
            //Frame for the supplierTxt
            statusTxt.frame = CGRectMake(modelTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            
            //Frame for the startDteTxt
            startDteTxt.frame = CGRectMake(modelTxt.frame.origin.x+modelTxt.frame.size.width + horzantial_Gap,categoryTxt.frame.origin.y, textFieldWidth,textFieldHeight);
            
            //Frame for the endDateTxt
            endDteTxt.frame = CGRectMake(startDteTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            //setting frame for UIButton's used at bottam....
            searchBtn.frame = CGRectMake((offersView.frame.size.width - 130), categoryTxt.frame.origin.y, 120, 40);
            
            clearBtn.frame = CGRectMake(searchBtn.frame.origin.x, subCategoryTxt.frame.origin.y, searchBtn.frame.size.width, searchBtn.frame.size.height);
            
            //setting frame for UIButton's....
            locationBtn.frame = CGRectMake(locationTxt.frame.origin.x + locationTxt.frame.size.width - 45, locationTxt.frame.origin.y - 8, 55, 60);
            
            showCategoriesBtn.frame = CGRectMake(categoryTxt.frame.origin.x + categoryTxt.frame.size.width - 45, categoryTxt.frame.origin.y - 8, 55, 60);
            
            showSubCategoriesBtn.frame = CGRectMake( subCategoryTxt.frame.origin.x + subCategoryTxt.frame.size.width - 45, subCategoryTxt.frame.origin.y - 8, 55, 60);
            
            showDepartmentListBtn.frame = CGRectMake( departmentTxt.frame.origin.x + departmentTxt.frame.size.width - 45, departmentTxt.frame.origin.y - 8, 55, 60);
            
            showSubDepartmentBtn.frame = CGRectMake( subDepartmentTxt.frame.origin.x + subDepartmentTxt.frame.size.width - 45, subDepartmentTxt.frame.origin.y - 8, 55, 60);
            
            showModelBtn.frame = CGRectMake( modelTxt.frame.origin.x + modelTxt.frame.size.width - 45, modelTxt.frame.origin.y - 8, 55, 60);
            
            showStatusBtn.frame = CGRectMake( statusTxt.frame.origin.x + statusTxt.frame.size.width - 45, statusTxt.frame.origin.y - 8, 55, 60);
            
            showStartDteBtn.frame = CGRectMake((startDteTxt.frame.origin.x+startDteTxt.frame.size.width-40), startDteTxt.frame.origin.y+4, 35, 30);
            
            showEndDateBtn.frame = CGRectMake((endDteTxt.frame.origin.x+endDteTxt.frame.size.width-40), endDteTxt.frame.origin.y+4, 35, 30);
            
            //setting frame for search filed...
            searchOffersText.frame = CGRectMake( zoneTxt.frame.origin.x, subCategoryTxt.frame.origin.y + subCategoryTxt.frame.size.height + 20,  ((searchBtn.frame.origin.x + searchBtn.frame.size.width) - zoneTxt.frame.origin.x), 40);
            
            //Setting frame for the PagenationTxt...
            pagenationTxt.frame = CGRectMake(locationTxt.frame.origin.x, offersView.frame.size.height - 45,90,40);
            
            dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x + pagenationTxt.frame.size.width - 45), pagenationTxt.frame.origin.y - 5, 45, 50);
            
            goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x + pagenationTxt.frame.size.width + 15, pagenationTxt.frame.origin.y, 80, 40);
            
            //Frame for the UIScrollVIew....
            dealsScrollView.frame = CGRectMake(searchOffersText.frame.origin.x, searchOffersText.frame.origin.y + searchOffersText.frame.size.height+5,searchOffersText.frame.size.width + 120, pagenationTxt.frame.origin.y - (searchOffersText.frame.origin.y + searchOffersText.frame.size.height + 10));
            
            snoLabel.frame = CGRectMake(0,0,45,40);
            
            offerIdsLabel.frame = CGRectMake(snoLabel.frame.origin.x + snoLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
            
            descriptionLabel.frame = CGRectMake(offerIdsLabel.frame.origin.x + offerIdsLabel.frame.size.width + 2,snoLabel.frame.origin.y, 140, snoLabel.frame.size.height);
            
            startDateLabel.frame = CGRectMake(descriptionLabel.frame.origin.x + descriptionLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
            
            endDateLabel.frame = CGRectMake(startDateLabel.frame.origin.x + startDateLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
            
            statusLabel.frame = CGRectMake(endDateLabel.frame.origin.x + endDateLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
            
            itemGroupLabel.frame = CGRectMake(statusLabel.frame.origin.x + statusLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
            
            offerTypeLabel.frame = CGRectMake(itemGroupLabel.frame.origin.x + itemGroupLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
            
            saleQtyLabel.frame = CGRectMake(offerTypeLabel.frame.origin.x + offerTypeLabel.frame.size.width + 2,snoLabel.frame.origin.y, 95, snoLabel.frame.size.height);
            
            saleValueLabel.frame = CGRectMake(saleQtyLabel.frame.origin.x + saleQtyLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
            
            currentOffersTable.frame = CGRectMake(0, snoLabel.frame.origin.y + snoLabel.frame.size.height, dealsScrollView.frame.size.width,dealsScrollView.frame.size.height - (snoLabel.frame.origin.y + snoLabel.frame.size.height));
            
        }
        
        
        else {
            
            //DO CODING FOR IPHONE AND OTHER DEVICES....
            
        }
    }
    
    
    // Adding the subViews to the Class after assigining the frames for the UI elements Dynaically....
    
    [offersView addSubview:headerNameLbl];
    
    //adding first column textFields....
    [offersView addSubview:zoneTxt];
    [offersView addSubview:locationTxt];
    
    //adding second column textFields....
    [offersView addSubview:categoryTxt];
    [offersView addSubview:subCategoryTxt];
    
    //adding third column textFields....
    [offersView addSubview:departmentTxt];
    [offersView addSubview:subDepartmentTxt];
    
    //    //adding fourth column textFields....
    //    [offersView addSubview:brandTxt];
    //    [offersView addSubview:sectionTxt];
    
    // adding fifth column textFields....
    [offersView addSubview:modelTxt];
    [offersView addSubview:statusTxt];
    
    //adding sixth column textFields....
    [offersView addSubview:startDteTxt];
    [offersView addSubview:endDteTxt];
    
    //adding UIButton's as subView's....
    [offersView addSubview:searchBtn];
    [offersView addSubview:clearBtn];
    
    //adding first column label's....
    
    [offersView addSubview:zoneBtn];
    //[offersView addSubview:locationBtn];
    
    [offersView addSubview:showCategoriesBtn];
    [offersView addSubview:showSubCategoriesBtn];
    
    [offersView addSubview:showDepartmentListBtn];
    [offersView addSubview:showSubDepartmentBtn];
    
    [offersView addSubview:showModelBtn];
    [offersView addSubview:showStatusBtn];
    
    [offersView addSubview:showStartDteBtn];
    [offersView addSubview:showEndDateBtn];
    
    [offersView addSubview:pagenationTxt];
    [offersView addSubview:dropDownBtn];
    [offersView addSubview:goButton];
    
    [offersView addSubview:searchOffersText];
    
    [offersView addSubview:dealsScrollView];
    
    [dealsScrollView addSubview:snoLabel];
    [dealsScrollView addSubview:offerIdsLabel];
    [dealsScrollView addSubview:descriptionLabel];
    [dealsScrollView addSubview:startDateLabel];
    [dealsScrollView addSubview:endDateLabel];
    [dealsScrollView addSubview:statusLabel];
    [dealsScrollView addSubview:itemGroupLabel];
    [dealsScrollView addSubview:offerTypeLabel];
    [dealsScrollView addSubview:saleQtyLabel];
    [dealsScrollView addSubview:saleValueLabel];
    
    [dealsScrollView addSubview:currentOffersTable];
    
    
    //Adding offersView for the main view..
    [self.view addSubview:offersView];
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
    
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    
    searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    
    //Freezing the current zone and Current location to the respective fields..
    
    if (zoneID.length == 0 || [zoneID isKindOfClass:[NSNull class]] || [zoneID isEqualToString:@""] ) {
        
        zoneTxt.text = zone;
    }
    
    else {
        
        zoneTxt.text = zoneID;
    }
    
    locationTxt.text = presentLocation;
    
    //used for identification propouse....
    showStartDteBtn.tag = 2;
    showEndDateBtn.tag = 4;
    
    // initialize the arrays ..
    itemNameArray = [[NSMutableArray alloc] init];
    itemIDArray = [[NSMutableArray alloc] init];
    OfferPriceArray = [[NSMutableArray alloc] init];
    validFromArray = [[NSMutableArray alloc] init];
    validToArray = [[NSMutableArray alloc] init];
    minAmtArray = [[NSMutableArray alloc] init];
    minQtyArray = [[NSMutableArray alloc] init];
    giftSKUArray = [[NSMutableArray alloc] init];
    offerDesc = [[NSMutableArray alloc]init];
    offerValues = [[NSMutableArray alloc]init];

    
}


/**
 * @description  Displaying the Deal  Details....
 * @date         06/02/2018
 * @method
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)displayOfferDetailsView:(int)rowNumber {
    
    @try {
        
        transperentView = [[UIView alloc] init];
        transperentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        //UILabel used for displaying header information...
        UILabel  * headerlabel;
        UILabel  * headerNameLbl;
        UIButton * closeBtn;
        
        // close button to close the view ..
        UIImage * image = [UIImage imageNamed:@"delete.png"];
        
        closeBtn = [[UIButton alloc] init] ;
        [closeBtn addTarget:self action:@selector(closeOfferDetailsView) forControlEvents:UIControlEventTouchUpInside];
        
        [closeBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        offerDetailsView = [[UIView alloc] init];
        offerDetailsView.opaque = NO;
        offerDetailsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        offerDetailsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        offerDetailsView.layer.borderWidth = 2.0f;
        
        headerlabel = [[UILabel alloc] init];
        headerlabel.textColor = [UIColor whiteColor];
        headerlabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        headerlabel.textAlignment = NSTextAlignmentLeft;
        
        headerNameLbl = [[UILabel alloc] init];
        headerNameLbl.layer.cornerRadius = 14;
        headerNameLbl.layer.masksToBounds = YES;
        headerNameLbl.numberOfLines = 1;
        headerNameLbl.textAlignment = NSTextAlignmentLeft;
        headerNameLbl.backgroundColor = [UIColor clearColor];
        headerNameLbl.textColor = [UIColor whiteColor];
        
        //UI ELEMENTS UNDER THE DEAL DETAILS VIEW......
        
        UILabel * dealNameLabel;
        UILabel * createdOnLabel;
        UILabel * dealStatusLabel;
        
        UILabel * colon_1;
        UILabel * colon_2;
        UILabel * colon_3;
        
        //creation of UILabel used in page....
        dealNameLabel = [[UILabel alloc] init];
        dealNameLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        dealNameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        dealNameLabel.textAlignment = NSTextAlignmentLeft;
        
        createdOnLabel = [[UILabel alloc] init];
        createdOnLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        createdOnLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        createdOnLabel.textAlignment = NSTextAlignmentLeft;
        
        dealStatusLabel = [[UILabel alloc] init];
        dealStatusLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        dealStatusLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        dealStatusLabel.textAlignment = NSTextAlignmentLeft;
        
        colon_1 = [[UILabel alloc] init];
        colon_1.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_1.font = [UIFont boldSystemFontOfSize:16.0];
        colon_1.textAlignment = NSTextAlignmentCenter;
        
        colon_2 = [[UILabel alloc] init];
        colon_2.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_2.font = [UIFont boldSystemFontOfSize:16.0];
        colon_2.textAlignment = NSTextAlignmentCenter;
        
        colon_3 = [[UILabel alloc] init];
        colon_3.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_3.font = [UIFont boldSystemFontOfSize:16.0];
        colon_3.textAlignment = NSTextAlignmentCenter;
        
        offerNameValueLabel = [[UILabel alloc] init];
        offerNameValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        offerNameValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        offerNameValueLabel.textAlignment = NSTextAlignmentLeft;
        
        createdOnValueLabel = [[UILabel alloc] init];
        createdOnValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        createdOnValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        createdOnValueLabel.textAlignment = NSTextAlignmentLeft;
        
        offerStatusValueLabel = [[UILabel alloc] init];
        offerStatusValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        offerStatusValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        offerStatusValueLabel.textAlignment = NSTextAlignmentLeft;
        
        UILabel * startDate_Label;
        UILabel * endDate_Label;
        UILabel * startTimeLabel;
        UILabel * endTimeLabel;
        
        startDate_Label = [[UILabel alloc] init];
        startDate_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        startDate_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        startDate_Label.textAlignment = NSTextAlignmentLeft;
        
        endDate_Label = [[UILabel alloc] init];
        endDate_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        endDate_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        endDate_Label.textAlignment = NSTextAlignmentLeft;
        
        startTimeLabel = [[UILabel alloc] init];
        startTimeLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        startTimeLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        startTimeLabel.textAlignment = NSTextAlignmentLeft;
        
        endTimeLabel = [[UILabel alloc] init];
        endTimeLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        endTimeLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        endTimeLabel.textAlignment = NSTextAlignmentLeft;
        
        UILabel * colon_4;
        UILabel * colon_5;
        UILabel * colon_6;
        UILabel * colon_7;
        
        
        colon_4 = [[UILabel alloc] init];
        colon_4.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_4.font = [UIFont boldSystemFontOfSize:16.0];
        colon_4.textAlignment = NSTextAlignmentCenter;
        
        colon_5 = [[UILabel alloc] init];
        colon_5.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_5.font = [UIFont boldSystemFontOfSize:16.0];
        colon_5.textAlignment = NSTextAlignmentCenter;
        
        colon_6 = [[UILabel alloc] init];
        colon_6.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_6.font = [UIFont boldSystemFontOfSize:16.0];
        colon_6.textAlignment = NSTextAlignmentCenter;
        
        colon_7 = [[UILabel alloc] init];
        colon_7.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_7.font = [UIFont boldSystemFontOfSize:16.0];
        colon_7.textAlignment = NSTextAlignmentCenter;
        
        startDateText = [[UITextField alloc] init];
        startDateText.borderStyle = UITextBorderStyleBezel;
        startDateText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        startDateText.font = [UIFont boldSystemFontOfSize:16.0];
        startDateText.delegate = self;
        startDateText.userInteractionEnabled = NO;
        startDateText.keyboardType = UIKeyboardTypeNumberPad;
        
        endDateText = [[UITextField alloc] init];
        endDateText.borderStyle = UITextBorderStyleBezel;
        endDateText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        endDateText.font = [UIFont boldSystemFontOfSize:16.0];
        endDateText.delegate = self;
        endDateText.userInteractionEnabled = NO;
        endDateText.keyboardType = UIKeyboardTypeNumberPad;
        
        startTimeText = [[UITextField alloc] init];
        startTimeText.borderStyle = UITextBorderStyleBezel;
        startTimeText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        startTimeText.font = [UIFont boldSystemFontOfSize:16.0];
        startTimeText.delegate = self;
        startTimeText.userInteractionEnabled = NO;
        startTimeText.keyboardType = UIKeyboardTypeNumberPad;
        
        endTimeText = [[UITextField alloc] init];
        endTimeText.borderStyle = UITextBorderStyleBezel;
        endTimeText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        endTimeText.font = [UIFont boldSystemFontOfSize:16.0];
        endTimeText.delegate = self;
        endTimeText.userInteractionEnabled = NO;
        endTimeText.keyboardType = UIKeyboardTypeNumberPad;
        
        
        UILabel * underLineLabel_1;
        UILabel * locationsLabel;
        UILabel * underLinelabel_2;
        
        underLineLabel_1 = [[UILabel alloc] init];
        underLineLabel_1.textColor = [UIColor blackColor];
        underLineLabel_1.font = [UIFont boldSystemFontOfSize:16.0f];
        underLineLabel_1.textAlignment = NSTextAlignmentCenter;
        underLineLabel_1.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        locationsLabel = [[UILabel alloc] init];
        locationsLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        locationsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        locationsLabel.textAlignment = NSTextAlignmentLeft;
        
        underLinelabel_2 = [[UILabel alloc] init];
        underLinelabel_2.textColor = [UIColor blackColor];
        underLinelabel_2.font = [UIFont boldSystemFontOfSize:16.0f];
        underLinelabel_2.textAlignment = NSTextAlignmentCenter;
        underLinelabel_2.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        UIView * locationsView = [[UIView alloc] init];
        
        locationsView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        locationsView.layer.borderWidth = 1.0f;
        locationsView.layer.cornerRadius = 1.0f;
        locationsView.layer.borderColor = [[UIColor blackColor]colorWithAlphaComponent:0.2].CGColor;
        
        //locationsTable creation...
        locationsTable = [[UITableView alloc] init];
        locationsTable.backgroundColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        locationsTable.layer.cornerRadius = 4.0;
        locationsTable.bounces = TRUE;
        locationsTable.dataSource = self;
        locationsTable.delegate = self;
        locationsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        
        // Deal Days Line...
        
        UILabel * underLineLabel_3;
        UILabel * offerDaysLabel;
        UILabel * underLineLabel_4;
        
        
        underLineLabel_3 = [[UILabel alloc] init];
        underLineLabel_3.textColor = [UIColor blackColor];
        underLineLabel_3.font = [UIFont boldSystemFontOfSize:16.0f];
        underLineLabel_3.textAlignment = NSTextAlignmentCenter;
        underLineLabel_3.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        offerDaysLabel = [[UILabel alloc] init];
        offerDaysLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        offerDaysLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        offerDaysLabel.textAlignment = NSTextAlignmentCenter;
        
        underLineLabel_4 = [[UILabel alloc] init];
        underLineLabel_4.textColor = [UIColor blackColor];
        underLineLabel_4.font = [UIFont boldSystemFontOfSize:16.0f];
        underLineLabel_4.textAlignment = NSTextAlignmentCenter;
        underLineLabel_4.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        UIButton* checkBoxBtn1;
        UIButton* checkBoxBtn2;
        UIButton* checkBoxBtn3;
        UIButton* checkBoxBtn4;
        UIButton* checkBoxBtn5;
        UIButton* checkBoxBtn6;
        UIButton* checkBoxBtn7;
        
        UIImage * checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
        
        checkBoxBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        checkBoxBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        checkBoxBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        checkBoxBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        checkBoxBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        checkBoxBtn6 = [UIButton buttonWithType:UIButtonTypeCustom];
        checkBoxBtn7 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        checkBoxBtn1.userInteractionEnabled = NO;
        checkBoxBtn2.userInteractionEnabled = NO;
        checkBoxBtn3.userInteractionEnabled = NO;
        checkBoxBtn4.userInteractionEnabled = NO;
        checkBoxBtn5.userInteractionEnabled = NO;
        checkBoxBtn6.userInteractionEnabled = NO;
        checkBoxBtn7.userInteractionEnabled = NO;

        
        UILabel * day1_Label;
        UILabel * day2_Label;
        UILabel * day3_Label;
        UILabel * day4_Label;
        UILabel * day5_Label;
        UILabel * day6_Label;
        UILabel * day7_Label;
        
        
        day1_Label = [[UILabel alloc] init];
        day1_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        day1_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        day1_Label.textAlignment = NSTextAlignmentCenter;
        
        day2_Label = [[UILabel alloc] init];
        day2_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        day2_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        day2_Label.textAlignment = NSTextAlignmentCenter;
        
        day3_Label = [[UILabel alloc] init];
        day3_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        day3_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        day3_Label.textAlignment = NSTextAlignmentCenter;
        
        day4_Label = [[UILabel alloc] init];
        day4_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        day4_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        day4_Label.textAlignment = NSTextAlignmentCenter;
        
        day5_Label = [[UILabel alloc] init];
        day5_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        day5_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        day5_Label.textAlignment = NSTextAlignmentCenter;
        
        day6_Label = [[UILabel alloc] init];
        day6_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        day6_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        day6_Label.textAlignment = NSTextAlignmentCenter;
        
        day7_Label = [[UILabel alloc] init];
        day7_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        day7_Label.font = [UIFont boldSystemFontOfSize:14.0f];
        day7_Label.textAlignment = NSTextAlignmentCenter;
        
        UILabel * underLineLabel_5;
        
        underLineLabel_5 = [[UILabel alloc] init];
        underLineLabel_5.textColor = [UIColor blackColor];
        underLineLabel_5.font = [UIFont boldSystemFontOfSize:16.0f];
        underLineLabel_5.textAlignment = NSTextAlignmentCenter;
        underLineLabel_5.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        
        UIButton * allowReturnsCheckBoxBtn;
        UIButton * allowExchangeCheckBoxBtn;
        
        allowReturnsCheckBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [allowReturnsCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
        allowReturnsCheckBoxBtn.userInteractionEnabled = NO;

        allowExchangeCheckBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [allowExchangeCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
        allowExchangeCheckBoxBtn.userInteractionEnabled = NO;

        UILabel * allowReturnsLabel;
        UILabel * allowExhangesLabel;
        
        allowReturnsLabel = [[UILabel alloc] init];
        allowReturnsLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        allowReturnsLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        allowReturnsLabel.textAlignment = NSTextAlignmentCenter;
        
        allowExhangesLabel = [[UILabel alloc] init];
        allowExhangesLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        allowExhangesLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        allowExhangesLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel * underLineLabel_6;
        
        underLineLabel_6 = [[UILabel alloc] init];
        underLineLabel_6.textColor = [UIColor blackColor];
        underLineLabel_6.font = [UIFont boldSystemFontOfSize:16.0f];
        underLineLabel_6.textAlignment = NSTextAlignmentCenter;
        underLineLabel_6.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        UILabel * rewardTypeLabel;
        UILabel * rewardCriteriaLabel;
        UILabel * startPriceLabel;
        
        rewardTypeLabel = [[UILabel alloc] init];
        rewardTypeLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        rewardTypeLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        rewardTypeLabel.textAlignment = NSTextAlignmentLeft;
        
        rewardCriteriaLabel = [[UILabel alloc] init];
        rewardCriteriaLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        rewardCriteriaLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        rewardCriteriaLabel.textAlignment = NSTextAlignmentLeft;
        
        startPriceLabel = [[UILabel alloc] init];
        startPriceLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        startPriceLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        startPriceLabel.textAlignment = NSTextAlignmentLeft;
        
        
        UILabel * colon_8;
        UILabel * colon_9;
        UILabel * colon_10;
        
        colon_8 = [[UILabel alloc] init];
        colon_8.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_8.font = [UIFont boldSystemFontOfSize:16.0];
        colon_8.textAlignment = NSTextAlignmentCenter;
        
        colon_9 = [[UILabel alloc] init];
        colon_9.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_9.font = [UIFont boldSystemFontOfSize:16.0];
        colon_9.textAlignment = NSTextAlignmentCenter;
        
        colon_10 = [[UILabel alloc] init];
        colon_10.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_10.font = [UIFont boldSystemFontOfSize:16.0];
        colon_10.textAlignment = NSTextAlignmentCenter;
        
        rewardTypeText = [[UITextField alloc] init];
        rewardTypeText.borderStyle = UITextBorderStyleBezel;
        rewardTypeText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        rewardTypeText.font = [UIFont boldSystemFontOfSize:16.0];
        rewardTypeText.delegate = self;
        rewardTypeText.userInteractionEnabled = NO;
        rewardTypeText.keyboardType = UIKeyboardTypeNumberPad;
        
        
        rewardCriteriaText = [[UITextField alloc] init];
        rewardCriteriaText.borderStyle = UITextBorderStyleBezel;
        rewardCriteriaText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        rewardCriteriaText.font = [UIFont boldSystemFontOfSize:16.0];
        rewardCriteriaText.delegate = self;
        rewardCriteriaText.userInteractionEnabled = NO;
        rewardCriteriaText.keyboardType = UIKeyboardTypeNumberPad;
        
        startPriceText = [[UITextField alloc] init];
        startPriceText.borderStyle = UITextBorderStyleBezel;
        startPriceText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        startPriceText.font = [UIFont boldSystemFontOfSize:16.0];
        startPriceText.delegate = self;
        startPriceText.userInteractionEnabled = NO;
        startPriceText.keyboardType = UIKeyboardTypeNumberPad;
        
        UILabel * minQtyLabel;
        UILabel * minAmtLabel;
        UILabel * endPriceLabel;
        
        minQtyLabel = [[UILabel alloc] init];
        minQtyLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        minQtyLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        minQtyLabel.textAlignment = NSTextAlignmentLeft;
        
        minAmtLabel = [[UILabel alloc] init];
        minAmtLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        minAmtLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        minAmtLabel.textAlignment = NSTextAlignmentLeft;
        
        endPriceLabel = [[UILabel alloc] init];
        endPriceLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        endPriceLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        endPriceLabel.textAlignment = NSTextAlignmentLeft;
        
        
        UILabel * colon_11;
        UILabel * colon_12;
        UILabel * colon_13;
        
        colon_11 = [[UILabel alloc] init];
        colon_11.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_11.font = [UIFont boldSystemFontOfSize:16.0];
        colon_11.textAlignment = NSTextAlignmentCenter;
        
        colon_12 = [[UILabel alloc] init];
        colon_12.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_12.font = [UIFont boldSystemFontOfSize:16.0];
        colon_12.textAlignment = NSTextAlignmentCenter;
        
        colon_13 = [[UILabel alloc] init];
        colon_13.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_13.font = [UIFont boldSystemFontOfSize:16.0];
        colon_13.textAlignment = NSTextAlignmentCenter;
        
        minimumQtyText = [[UITextField alloc] init];
        minimumQtyText.borderStyle = UITextBorderStyleBezel;
        minimumQtyText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        minimumQtyText.font = [UIFont boldSystemFontOfSize:16.0];
        minimumQtyText.delegate = self;
        minimumQtyText.userInteractionEnabled = NO;
        minimumQtyText.keyboardType = UIKeyboardTypeNumberPad;
        
        minAmtText = [[UITextField alloc] init];
        minAmtText.borderStyle = UITextBorderStyleBezel;
        minAmtText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        minAmtText.font = [UIFont boldSystemFontOfSize:16.0];
        minAmtText.delegate = self;
        minAmtText.userInteractionEnabled = NO;
        minAmtText.keyboardType = UIKeyboardTypeNumberPad;
        
        endPriceText = [[UITextField alloc] init];
        endPriceText.borderStyle = UITextBorderStyleBezel;
        endPriceText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        endPriceText.font = [UIFont boldSystemFontOfSize:16.0];
        endPriceText.delegate = self;
        endPriceText.userInteractionEnabled = NO;
        endPriceText.keyboardType = UIKeyboardTypeNumberPad;
        
        //
        UILabel * rewardValueLabel;
        UILabel * rangeModelabel;
        
        rewardValueLabel = [[UILabel alloc] init];
        rewardValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        rewardValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        rewardValueLabel.textAlignment = NSTextAlignmentLeft;
        
        rangeModelabel = [[UILabel alloc] init];
        rangeModelabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        rangeModelabel.font = [UIFont boldSystemFontOfSize:14.0f];
        rangeModelabel.textAlignment = NSTextAlignmentLeft;
        
        UILabel * colon_14;
        UILabel * colon_15;
        
        colon_14 = [[UILabel alloc] init];
        colon_14.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_14.font = [UIFont boldSystemFontOfSize:16.0];
        colon_14.textAlignment = NSTextAlignmentCenter;
        
        colon_15 = [[UILabel alloc] init];
        colon_15.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_15.font = [UIFont boldSystemFontOfSize:16.0];
        colon_15.textAlignment = NSTextAlignmentCenter;
        
        rewardValueText = [[UITextField alloc] init];
        rewardValueText.borderStyle = UITextBorderStyleBezel;
        rewardValueText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        rewardValueText.font = [UIFont boldSystemFontOfSize:16.0];
        rewardValueText.delegate = self;
        rewardValueText.userInteractionEnabled = NO;
        rewardValueText.keyboardType = UIKeyboardTypeNumberPad;
        
        rangeModeText = [[UITextField alloc] init];
        rangeModeText.borderStyle = UITextBorderStyleBezel;
        rangeModeText.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        rangeModeText.font = [UIFont boldSystemFontOfSize:16.0];
        rangeModeText.delegate = self;
        rangeModeText.userInteractionEnabled = NO;
        rangeModeText.keyboardType = UIKeyboardTypeNumberPad;
        
        UILabel * lowPriceItemLabel;
        UILabel * colon_16;
        UIButton* lowPriceItemCheckBoxBtn;
        
        lowPriceItemLabel = [[UILabel alloc] init];
        lowPriceItemLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        lowPriceItemLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        lowPriceItemLabel.textAlignment = NSTextAlignmentLeft;
        
        colon_16 = [[UILabel alloc] init];
        colon_16.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_16.font = [UIFont boldSystemFontOfSize:16.0];
        colon_16.textAlignment = NSTextAlignmentCenter;
        
        lowPriceItemCheckBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [lowPriceItemCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
        lowPriceItemCheckBoxBtn.userInteractionEnabled = NO;

        UILabel * repeatLabel;
        UILabel * colon_17;
        UIButton* repeatCheckBoxBtn;
        
        repeatLabel = [[UILabel alloc] init];
        repeatLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        repeatLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        repeatLabel.textAlignment = NSTextAlignmentLeft;
        
        colon_17 = [[UILabel alloc] init];
        colon_17.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_17.font = [UIFont boldSystemFontOfSize:16.0];
        colon_17.textAlignment = NSTextAlignmentCenter;
        
        repeatCheckBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [repeatCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
        repeatCheckBoxBtn.userInteractionEnabled = NO;

        UILabel * allowMultipleDiscountsLabel;
        UILabel * colon_18;
        UIButton* allowMultipleDiscountsCheckBoxBtn;
        
        allowMultipleDiscountsLabel = [[UILabel alloc] init];
        allowMultipleDiscountsLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        allowMultipleDiscountsLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        allowMultipleDiscountsLabel.textAlignment = NSTextAlignmentLeft;
        
        colon_18 = [[UILabel alloc] init];
        colon_18.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_18.font = [UIFont boldSystemFontOfSize:16.0];
        colon_18.textAlignment = NSTextAlignmentCenter;
        
        allowMultipleDiscountsCheckBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [allowMultipleDiscountsCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
        allowMultipleDiscountsCheckBoxBtn.userInteractionEnabled = NO;

        UILabel * offerAttributesLabel;
        
        //allocation of userNameLbl.....
        offerAttributesLabel = [[UILabel alloc] init];
        offerAttributesLabel.layer.cornerRadius = 2.0f;
        offerAttributesLabel.layer.masksToBounds = YES;
        offerAttributesLabel.layer.borderWidth  = 1.0f;
        offerAttributesLabel.numberOfLines = 1;
        offerAttributesLabel.textAlignment = NSTextAlignmentLeft;
        offerAttributesLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        offerAttributesLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
        offerAttributesLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        offerAttributesLabel.layer.borderColor = [[UIColor blackColor]colorWithAlphaComponent:0.8].CGColor;
        
        UILabel * underLineLabel_7;
        UILabel * productCategorizationLabel;
        UILabel * underLineLabel_8;
        
        
        
        underLineLabel_7 = [[UILabel alloc] init];
        underLineLabel_7.textColor = [UIColor blackColor];
        underLineLabel_7.font = [UIFont boldSystemFontOfSize:16.0f];
        underLineLabel_7.textAlignment = NSTextAlignmentCenter;
        underLineLabel_7.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        productCategorizationLabel = [[UILabel alloc] init];
        productCategorizationLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        productCategorizationLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        productCategorizationLabel.textAlignment = NSTextAlignmentLeft;
        
        underLineLabel_8 = [[UILabel alloc] init];
        underLineLabel_8.textColor = [UIColor blackColor];
        underLineLabel_8.font = [UIFont boldSystemFontOfSize:16.0f];
        underLineLabel_8.textAlignment = NSTextAlignmentCenter;
        underLineLabel_8.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        
        UILabel * categoryLabel;
        UILabel * subCategoryLabel;
        UILabel * sectionLabel;
        
        categoryLabel = [[UILabel alloc] init];
        categoryLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        categoryLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        categoryLabel.textAlignment = NSTextAlignmentLeft;
        
        subCategoryLabel = [[UILabel alloc] init];
        subCategoryLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        subCategoryLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        subCategoryLabel.textAlignment = NSTextAlignmentLeft;
        
        sectionLabel = [[UILabel alloc] init];
        sectionLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        sectionLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        sectionLabel.textAlignment = NSTextAlignmentLeft;
        //sectionLabel.backgroundColor = [UIColor greenColor];
        //sectionLabel.layer.cornerRadius = 2.0f;
        
        
        UILabel * colon_19;
        UILabel * colon_20;
        UILabel * colon_21;
        
        colon_19 = [[UILabel alloc] init];
        colon_19.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_19.font = [UIFont boldSystemFontOfSize:16.0];
        colon_19.textAlignment = NSTextAlignmentCenter;
        
        colon_20 = [[UILabel alloc] init];
        colon_20.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_20.font = [UIFont boldSystemFontOfSize:16.0];
        colon_20.textAlignment = NSTextAlignmentCenter;
        
        colon_21 = [[UILabel alloc] init];
        colon_21.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_21.font = [UIFont boldSystemFontOfSize:16.0];
        colon_21.textAlignment = NSTextAlignmentCenter;
        
        UILabel * categoryValueLabel;
        UILabel * subCategoryValueLabel;
        UILabel * sectionValueLabel;
        
        categoryValueLabel = [[UILabel alloc] init];
        categoryValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        categoryValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        categoryValueLabel.textAlignment = NSTextAlignmentLeft;
        
        subCategoryValueLabel = [[UILabel alloc] init];
        subCategoryValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        subCategoryValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        subCategoryValueLabel.textAlignment = NSTextAlignmentLeft;
        //subCategoryValueLabel.backgroundColor = [UIColor greenColor];
        //subCategoryValueLabel.layer.cornerRadius = 2.0f;
        
        sectionValueLabel = [[UILabel alloc] init];
        sectionValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        sectionValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        sectionValueLabel.textAlignment = NSTextAlignmentLeft;
        
        
        UILabel * departmentLabel;
        UILabel * subDepartmentLabel;
        UILabel * classLabel;
        UILabel * subClassLabel;
        
        departmentLabel = [[UILabel alloc] init];
        departmentLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        departmentLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        departmentLabel.textAlignment = NSTextAlignmentLeft;
        
        subDepartmentLabel = [[UILabel alloc] init];
        subDepartmentLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        subDepartmentLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        subDepartmentLabel.textAlignment = NSTextAlignmentLeft;
        
        classLabel = [[UILabel alloc] init];
        classLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        classLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        classLabel.textAlignment = NSTextAlignmentLeft;
        
        subClassLabel = [[UILabel alloc] init];
        subClassLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        subClassLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        subClassLabel.textAlignment = NSTextAlignmentLeft;
        
        UILabel * colon_22;
        UILabel * colon_23;
        UILabel * colon_24;
        UILabel * colon_25;
        
        colon_22 = [[UILabel alloc] init];
        colon_22.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_22.font = [UIFont boldSystemFontOfSize:16.0];
        colon_22.textAlignment = NSTextAlignmentCenter;
        
        colon_23 = [[UILabel alloc] init];
        colon_23.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_23.font = [UIFont boldSystemFontOfSize:16.0];
        colon_23.textAlignment = NSTextAlignmentCenter;
        
        colon_24 = [[UILabel alloc] init];
        colon_24.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_24.font = [UIFont boldSystemFontOfSize:16.0];
        colon_24.textAlignment = NSTextAlignmentCenter;
        
        colon_25 = [[UILabel alloc] init];
        colon_25.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        colon_25.font = [UIFont boldSystemFontOfSize:16.0];
        colon_25.textAlignment = NSTextAlignmentCenter;
        
        UILabel * departmentValueLabel;
        UILabel * subDepartmentValueLabel;
        UILabel * classValueLabel;
        UILabel * subClassValueLabel;
        
        
        departmentValueLabel = [[UILabel alloc] init];
        departmentValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        departmentValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        departmentValueLabel.textAlignment = NSTextAlignmentLeft;
        
        subDepartmentValueLabel = [[UILabel alloc] init];
        subDepartmentValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        subDepartmentValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        subDepartmentValueLabel.textAlignment = NSTextAlignmentLeft;
        
        classValueLabel = [[UILabel alloc] init];
        classValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        classValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        classValueLabel.textAlignment = NSTextAlignmentLeft;
        
        subClassValueLabel = [[UILabel alloc] init];
        subClassValueLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        subClassValueLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        subClassValueLabel.textAlignment = NSTextAlignmentLeft;
        
        
        UIView * itemDetailsView = [[UIView alloc] init];
        
        itemDetailsView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        itemDetailsView.layer.borderWidth = 1.0f;
        itemDetailsView.layer.cornerRadius = 1.0f;
        itemDetailsView.layer.borderColor = [[UIColor blackColor]colorWithAlphaComponent:0.2].CGColor;
        
        skuidLabel = [[UILabel alloc]init];
        skuidLabel.layer.cornerRadius = 2.0f;
        skuidLabel.textAlignment = NSTextAlignmentCenter;
        skuidLabel.layer.masksToBounds = YES;
        skuidLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        skuidLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        skuidLabel.textColor = [UIColor whiteColor];
        
        productDescriptionLabel = [[UILabel alloc]init];
        productDescriptionLabel.layer.cornerRadius = 2.0f;
        productDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        productDescriptionLabel.layer.masksToBounds = YES;
        productDescriptionLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        productDescriptionLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        productDescriptionLabel.textColor = [UIColor whiteColor];
        
        eanLabel = [[UILabel alloc]init];
        eanLabel.layer.cornerRadius = 2.0f;
        eanLabel.textAlignment = NSTextAlignmentCenter;
        eanLabel.layer.masksToBounds = YES;
        eanLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        eanLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        eanLabel.textColor = [UIColor whiteColor];
        
        rangeLabel = [[UILabel alloc]init];
        rangeLabel.layer.cornerRadius = 2.0f;
        rangeLabel.textAlignment = NSTextAlignmentCenter;
        rangeLabel.layer.masksToBounds = YES;
        rangeLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        rangeLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        rangeLabel.textColor = [UIColor whiteColor];
        
        mrpLabel = [[UILabel alloc]init];
        mrpLabel.layer.cornerRadius = 2.0f;
        mrpLabel.textAlignment = NSTextAlignmentCenter;
        mrpLabel.layer.masksToBounds = YES;
        mrpLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        mrpLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        mrpLabel.textColor = [UIColor whiteColor];
        
        salePriceLabel = [[UILabel alloc]init];
        salePriceLabel.layer.cornerRadius = 2.0f;
        salePriceLabel.textAlignment = NSTextAlignmentCenter;
        salePriceLabel.layer.masksToBounds = YES;
        salePriceLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        salePriceLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        salePriceLabel.textColor = [UIColor whiteColor];
        
        //itemDetailsTable creation...
        itemDetailsTable = [[UITableView alloc] init];
        itemDetailsTable.backgroundColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        itemDetailsTable.layer.cornerRadius = 4.0;
        itemDetailsTable.bounces = TRUE;
        itemDetailsTable.dataSource = self;
        itemDetailsTable.delegate = self;
        itemDetailsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        //NSLocalized Strings for.....
        headerNameLbl.text = NSLocalizedString(@"offer_details_view", nil);
        
        dealNameLabel.text   = NSLocalizedString(@"offer_name", nil);
        createdOnLabel.text  = NSLocalizedString(@"created_on", nil);
        dealStatusLabel.text = NSLocalizedString(@"offer_status", nil);
        
        startDate_Label.text   = NSLocalizedString(@"start_date", nil);
        endDate_Label.text     = NSLocalizedString(@"end_date", nil);
        startTimeLabel.text    = NSLocalizedString(@"start_time", nil);
        endTimeLabel.text      = NSLocalizedString(@"end_time", nil);
        
        startDateText.placeholder = NSLocalizedString(@"start_date", nil);
        endDateText.placeholder   = NSLocalizedString(@"end_date", nil);
        startTimeText.placeholder = NSLocalizedString(@"start_time", nil);
        endTimeText.placeholder   = NSLocalizedString(@"end_time", nil);
        
        
        colon_1.text  = NSLocalizedString(@":", nil);
        colon_2.text  = NSLocalizedString(@":", nil);
        colon_3.text  = NSLocalizedString(@":", nil);
        
        colon_4.text  = NSLocalizedString(@":", nil);
        colon_5.text  = NSLocalizedString(@":", nil);
        colon_6.text  = NSLocalizedString(@":", nil);
        colon_7.text  = NSLocalizedString(@":", nil);
        
        locationsLabel.text = NSLocalizedString(@"locations", nil);
        offerDaysLabel.text  = NSLocalizedString(@"offer_days", nil);
        
        day1_Label.text = NSLocalizedString(@"sunday", nil);
        day2_Label.text = NSLocalizedString(@"monday", nil);
        day3_Label.text = NSLocalizedString(@"tuesday", nil);
        day4_Label.text = NSLocalizedString(@"wednesday", nil);
        day5_Label.text = NSLocalizedString(@"thursday", nil);
        day6_Label.text = NSLocalizedString(@"friday", nil);
        day7_Label.text = NSLocalizedString(@"Saturday", nil);
        
        allowReturnsLabel.text  = NSLocalizedString(@"allow_returns", nil);
        allowExhangesLabel.text = NSLocalizedString(@"allow_exchanges", nil);
        
        rewardTypeLabel.text     = NSLocalizedString(@"reward_type", nil);
        rewardCriteriaLabel.text = NSLocalizedString(@"reward_Criteria", nil);
        startPriceLabel.text     = NSLocalizedString(@"start_price", nil);
        
        rewardTypeText.placeholder = NSLocalizedString(@"reward_type", nil);
        rewardCriteriaText.placeholder   = NSLocalizedString(@"reward_Criteria", nil);
        startPriceText.placeholder = NSLocalizedString(@"start_price", nil);
        
        
        colon_8.text   = NSLocalizedString(@":", nil);
        colon_9.text   = NSLocalizedString(@":", nil);
        colon_10.text  = NSLocalizedString(@":", nil);
        
        minQtyLabel.text     = NSLocalizedString(@"min_qty", nil);
        minAmtLabel.text     = NSLocalizedString(@"min_amount", nil);
        endPriceLabel.text   = NSLocalizedString(@"end_price", nil);
        
        colon_11.text  = NSLocalizedString(@":", nil);
        colon_12.text  = NSLocalizedString(@":", nil);
        colon_13.text  = NSLocalizedString(@":", nil);
        
        minimumQtyText.placeholder = NSLocalizedString(@"min_qty", nil);
        minAmtText.placeholder   = NSLocalizedString(@"min_amount", nil);
        endPriceText.placeholder = NSLocalizedString(@"end_price", nil);
        
        rewardValueLabel.text = NSLocalizedString(@"reward_value", nil);
        rangeModelabel.text   = NSLocalizedString(@"range_mode", nil);
        
        colon_14.text  = NSLocalizedString(@":", nil);
        colon_15.text  = NSLocalizedString(@":", nil);
        
        rewardValueText.placeholder   = NSLocalizedString(@"reward_value", nil);
        rangeModeText.placeholder   = NSLocalizedString(@"range_mode", nil);
        
        lowPriceItemLabel.text = NSLocalizedString(@"low_price_item", nil);
        colon_16.text  = NSLocalizedString(@":", nil);
        
        repeatLabel.text = NSLocalizedString(@"repeat", nil);
        colon_17.text  = NSLocalizedString(@":", nil);
        
        allowMultipleDiscountsLabel.text = NSLocalizedString(@"allow_multiple_discounts", nil);
        colon_18.text  = NSLocalizedString(@":", nil);
        
        offerAttributesLabel.text = NSLocalizedString(@"offer_attributes", nil);
        productCategorizationLabel.text = NSLocalizedString(@"product_categorization", nil);
        
        categoryLabel.text    = NSLocalizedString(@"category", nil);
        subCategoryLabel.text = NSLocalizedString(@"sub_category", nil);
        sectionLabel.text     = NSLocalizedString(@"section", nil);
        
        colon_19.text  = NSLocalizedString(@":", nil);
        colon_20.text  = NSLocalizedString(@":", nil);
        colon_21.text  = NSLocalizedString(@":", nil);
        
        
        
        departmentLabel.text    = NSLocalizedString(@"department", nil);
        subDepartmentLabel.text = NSLocalizedString(@"sub_department", nil);
        classLabel.text         = NSLocalizedString(@"class", nil);
        subClassLabel.text      = NSLocalizedString(@"sub_class", nil);
        
        colon_22.text  = NSLocalizedString(@":", nil);
        colon_23.text  = NSLocalizedString(@":", nil);
        colon_24.text  = NSLocalizedString(@":", nil);
        colon_25.text  = NSLocalizedString(@":", nil);
        
        
        skuidLabel.text              = NSLocalizedString(@"sku_id", nil);
        productDescriptionLabel.text = NSLocalizedString(@"product_desc", nil);
        eanLabel.text                = NSLocalizedString(@"ean", nil);
        rangeLabel.text              = NSLocalizedString(@"range", nil);
        mrpLabel.text                = NSLocalizedString(@"mrp", nil);
        salePriceLabel.text          = NSLocalizedString(@"sale_price", nil);
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
            }
            else{
            }
            
            transperentView.frame = self.view.frame;
            
            headerlabel.frame = CGRectMake( 0, 0, transperentView.frame.size.width - 20, 40);
            
            headerNameLbl.frame = CGRectMake(8, 5, 200, 30);
            
            closeBtn.frame =  CGRectMake( headerlabel.frame.size.width - 45, 0, 40 , 40);
            
            offerDetailsView.frame = CGRectMake((transperentView.frame.size.width - headerlabel.frame.size.width) / 2,locationTxt.frame.origin.y  , headerlabel.frame.size.width, pagenationTxt.frame.origin.y - (locationTxt.frame.origin.y + locationTxt.frame.size.height - 80));
            
            float labelWidth  = 110;
            float labelHeight = 25;
            //
            dealNameLabel.frame  = CGRectMake(10, headerlabel.frame.origin.y + headerNameLbl.frame.size.height + 20 ,labelWidth , labelHeight);
            
            createdOnLabel.frame = CGRectMake(dealNameLabel.frame.origin.x, dealNameLabel.frame.origin.y + dealNameLabel.frame.size.height ,labelWidth, labelHeight);
            
            dealStatusLabel.frame = CGRectMake(dealNameLabel.frame.origin.x, createdOnLabel.frame.origin.y + createdOnLabel.frame.size.height,labelWidth , labelHeight);
            //
            colon_1.frame = CGRectMake( dealNameLabel.frame.origin.x + dealNameLabel.frame.size.width - 20, dealNameLabel.frame.origin.y, 5, 25);
            
            colon_2.frame = CGRectMake( colon_1.frame.origin.x , createdOnLabel.frame.origin.y, 5, 25);
            
            colon_3.frame = CGRectMake( colon_1.frame.origin.x , dealStatusLabel.frame.origin.y, 5, 25);
            
            //
            offerNameValueLabel.frame = CGRectMake(colon_1.frame.origin.x + colon_1.frame.size.width +  10, dealNameLabel.frame.origin.y,labelWidth+100, labelHeight);
            
            createdOnValueLabel.frame = CGRectMake(colon_2.frame.origin.x + colon_2.frame.size.width + 10, createdOnLabel.frame.origin.y,labelWidth+100, labelHeight);
            
            offerStatusValueLabel.frame = CGRectMake(colon_3.frame.origin.x + colon_3.frame.size.width + 10, dealStatusLabel.frame.origin.y,labelWidth, labelHeight);
            
            //
            startDate_Label.frame  = CGRectMake(dealNameLabel.frame.origin.x, dealStatusLabel.frame.origin.y + dealStatusLabel.frame.size.height + 20 ,labelWidth , labelHeight + 10);
            
            endDate_Label.frame  = CGRectMake(startDate_Label.frame.origin.x, startDate_Label.frame.origin.y + startDate_Label.frame.size.height  ,labelWidth , labelHeight + 10);
            
            startTimeLabel.frame  = CGRectMake(startDate_Label.frame.origin.x, endDate_Label.frame.origin.y + endDate_Label.frame.size.height + 20 ,labelWidth , labelHeight + 10);
            
            endTimeLabel.frame  = CGRectMake(startDate_Label.frame.origin.x, startTimeLabel.frame.origin.y + startTimeLabel.frame.size.height  ,labelWidth , labelHeight + 10);
            
            //
            colon_4.frame = CGRectMake( colon_1.frame.origin.x, startDate_Label.frame.origin.y + 5, 5, 25);
            
            colon_5.frame = CGRectMake( colon_4.frame.origin.x, endDate_Label.frame.origin.y + 5, 5, 25);
            
            colon_6.frame = CGRectMake( colon_4.frame.origin.x, startTimeLabel.frame.origin.y + 5, 5, 25);
            
            colon_7.frame = CGRectMake( colon_4.frame.origin.x, endTimeLabel.frame.origin.y + 5, 5, 25);
            
            //
            startDateText.frame = CGRectMake(colon_4.frame.origin.x + colon_4.frame.size.width + 10, colon_4.frame.origin.y, 130, 30);
            endDateText.frame   = CGRectMake(colon_5.frame.origin.x + colon_5.frame.size.width + 10, colon_5.frame.origin.y, 130, 30);
            //
            startTimeText.frame   = CGRectMake(colon_6.frame.origin.x + colon_6.frame.size.width + 10, colon_6.frame.origin.y, 110, 30);
            endTimeText.frame     = CGRectMake(colon_7.frame.origin.x + colon_7.frame.size.width + 10, colon_7.frame.origin.y, 110, 30);
            
            //
            underLineLabel_1.frame = CGRectMake(startDateText.frame.origin.x + startDateText.frame.size.width + 20, startDateText.frame.origin.y, startDate_Label.frame.size.width - 70, 1);
            
            locationsLabel.frame   = CGRectMake(underLineLabel_1.frame.origin.x + underLineLabel_1.frame.size.width , startDateText.frame.origin.y - 12, 80 ,labelHeight);
            
            underLinelabel_2.frame = CGRectMake(locationsLabel.frame.origin.x + locationsLabel.frame.size.width, underLineLabel_1.frame.origin.y, underLineLabel_1.frame.size.width, 1);
            
            
            locationsView.frame = CGRectMake(underLineLabel_1.frame.origin.x, underLineLabel_1.frame.origin.y + underLineLabel_1.frame.size.height + 10, underLinelabel_2.frame.origin.x +underLinelabel_2.frame.size.width -(underLineLabel_1.frame.origin.x), endTimeText.frame.origin.y -  (underLineLabel_1.frame.origin.y + underLineLabel_1.frame.size.height - 25));
            
            
            locationsTable.frame = CGRectMake(0, 0, locationsView.frame.size.width, locationsView.frame.size.height);
            
            
            //
            underLineLabel_3.frame = CGRectMake(underLinelabel_2.frame.origin.x + underLinelabel_2.frame.size.width + 20, underLineLabel_1.frame.origin.y, underLineLabel_1.frame.size.width + 80 , 1);
            
            offerDaysLabel.frame   = CGRectMake(underLineLabel_3.frame.origin.x + underLineLabel_3.frame.size.width , startDateText.frame.origin.y - 12, 90 ,labelHeight);
            
            underLineLabel_4.frame = CGRectMake(offerDaysLabel.frame.origin.x + offerDaysLabel.frame.size.width, underLineLabel_3.frame.origin.y, underLineLabel_3.frame.size.width  + 30, 1);
            //
            checkBoxBtn1.frame = CGRectMake(underLineLabel_3.frame.origin.x, underLineLabel_3.frame.origin.y + underLineLabel_3.frame.size.height + 10,20, 20);
            day1_Label.frame = CGRectMake(checkBoxBtn1.frame.origin.x + checkBoxBtn1.frame.size.width , checkBoxBtn1.frame.origin.y - 2, 30, labelHeight);
            
            //
            checkBoxBtn2.frame = CGRectMake(day1_Label.frame.origin.x + day1_Label.frame.size.width + 2 , checkBoxBtn1.frame.origin.y, 20, 20);
            day2_Label.frame = CGRectMake(checkBoxBtn2.frame.origin.x + checkBoxBtn2.frame.size.width , day1_Label.frame.origin.y, 30, labelHeight);
            
            //
            checkBoxBtn3.frame = CGRectMake(day2_Label.frame.origin.x + day2_Label.frame.size.width + 2, checkBoxBtn1.frame.origin.y, 20, 20);
            day3_Label.frame = CGRectMake(checkBoxBtn3.frame.origin.x + checkBoxBtn3.frame.size.width, day1_Label.frame.origin.y, 30, labelHeight);
            
            //
            checkBoxBtn4.frame = CGRectMake(day3_Label.frame.origin.x + day3_Label.frame.size.width + 2, checkBoxBtn1.frame.origin.y, 20, 20);
            day4_Label.frame = CGRectMake(checkBoxBtn4.frame.origin.x + checkBoxBtn4.frame.size.width, day1_Label.frame.origin.y, 30, labelHeight);
            
            //
            checkBoxBtn5.frame = CGRectMake(day4_Label.frame.origin.x + day4_Label.frame.size.width + 2, checkBoxBtn1.frame.origin.y, 20, 20);
            day5_Label.frame = CGRectMake(checkBoxBtn5.frame.origin.x + checkBoxBtn5.frame.size.width, day1_Label.frame.origin.y, 30, labelHeight);
            
            //
            checkBoxBtn6.frame = CGRectMake(day5_Label.frame.origin.x + day5_Label.frame.size.width + 2, checkBoxBtn1.frame.origin.y, 20, 20);
            day6_Label.frame = CGRectMake(checkBoxBtn6.frame.origin.x + checkBoxBtn6.frame.size.width, day1_Label.frame.origin.y, 30, labelHeight);
            
            //
            checkBoxBtn7.frame = CGRectMake(day6_Label.frame.origin.x + day6_Label.frame.size.width + 2, checkBoxBtn1.frame.origin.y, 20, 20);
            day7_Label.frame = CGRectMake(checkBoxBtn7.frame.origin.x + checkBoxBtn7.frame.size.width, day1_Label.frame.origin.y, 30, labelHeight);
            
            //
            underLineLabel_5.frame = CGRectMake( underLineLabel_4.frame.origin.x + underLineLabel_4.frame.size.width + 20,underLineLabel_4.frame.origin.y , underLineLabel_3.frame.size.width + 50, 1);
            
            allowReturnsCheckBoxBtn.frame =  CGRectMake(underLineLabel_5.frame.origin.x , underLineLabel_5.frame.origin.y + underLineLabel_5.frame.size.height + 10, 20, 20);
            
            allowReturnsLabel.frame = CGRectMake(allowReturnsCheckBoxBtn.frame.origin.x + allowReturnsCheckBoxBtn.frame.size.width, allowReturnsCheckBoxBtn.frame.origin.y - 2, labelWidth, labelHeight);
            
            allowExchangeCheckBoxBtn.frame = CGRectMake(allowReturnsCheckBoxBtn.frame.origin.x,allowReturnsCheckBoxBtn.frame.origin.y + allowReturnsCheckBoxBtn.frame.size.height + 5 ,20, 20);
            
            allowExhangesLabel.frame = CGRectMake(allowReturnsLabel.frame.origin.x, allowExchangeCheckBoxBtn.frame.origin.y -2, labelWidth + 20, labelHeight);
            
            //
            underLineLabel_6.frame = CGRectMake(underLineLabel_3.frame.origin.x , allowExhangesLabel.frame.origin.y + allowExhangesLabel.frame.size.height + 10, underLineLabel_5.frame.origin.x + underLineLabel_5.frame.size.width - (underLineLabel_3.frame.origin.x), 1);
            
            rewardTypeLabel.frame = CGRectMake(underLineLabel_6.frame.origin.x , underLineLabel_6.frame.origin.y + underLineLabel_6.frame.size.height + 10 , labelWidth, labelHeight);
            
            rewardCriteriaLabel.frame = CGRectMake(rewardTypeLabel.frame.origin.x , rewardTypeLabel.frame.origin.y + rewardTypeLabel.frame.size.height + 10 , labelWidth, labelHeight);
            
            startPriceLabel.frame = CGRectMake(rewardTypeLabel.frame.origin.x , rewardCriteriaLabel.frame.origin.y + rewardCriteriaLabel.frame.size.height + 10 , labelWidth, labelHeight);
            
            //
            colon_8.frame = CGRectMake(rewardTypeLabel.frame.origin.x + rewardTypeLabel.frame.size.width , rewardTypeLabel.frame.origin.y, 5, 25);
            
            colon_9.frame = CGRectMake(colon_8.frame.origin.x , rewardCriteriaLabel.frame.origin.y, 5, 25);
            
            colon_10.frame = CGRectMake(colon_8.frame.origin.x , startPriceLabel.frame.origin.y, 5, 25);
            
            //
            rewardTypeText.frame     = CGRectMake(colon_8.frame.origin.x + colon_8.frame.size.width + 5, colon_8.frame.origin.y, 90, 30);
            
            rewardCriteriaText.frame = CGRectMake(rewardTypeText.frame.origin.x , colon_9.frame.origin.y, 90, 30);
            
            startPriceText.frame     = CGRectMake(rewardTypeText.frame.origin.x , colon_10.frame.origin.y, 90, 30);
            
            //
            
            minQtyLabel.frame = CGRectMake(rewardTypeText.frame.origin.x + rewardTypeText.frame.size.width + 10, rewardTypeLabel.frame.origin.y, 70  , labelHeight);
            
            minAmtLabel.frame = CGRectMake(minQtyLabel.frame.origin.x , rewardCriteriaLabel.frame.origin.y, 70  , labelHeight);
            
            endPriceLabel.frame = CGRectMake(minQtyLabel.frame.origin.x , startPriceLabel.frame.origin.y, 70  , labelHeight);
            
            colon_11.frame = CGRectMake(minQtyLabel.frame.origin.x + minQtyLabel.frame.size.width - 5 , minQtyLabel.frame.origin.y, 5, 25);
            
            colon_12.frame = CGRectMake(colon_11.frame.origin.x , minAmtLabel.frame.origin.y, 5, 25);
            
            colon_13.frame = CGRectMake(colon_11.frame.origin.x , endPriceLabel.frame.origin.y, 5, 25);
            
            minimumQtyText.frame = CGRectMake(colon_11.frame.origin.x + colon_11.frame.size.width + 5, colon_8.frame.origin.y, 70, 30);
            minAmtText.frame     = CGRectMake(minimumQtyText.frame.origin.x , colon_12.frame.origin.y, 70, 30);
            endPriceText.frame   = CGRectMake(minimumQtyText.frame.origin.x , colon_13.frame.origin.y, 70, 30);
            
            //
            rewardValueLabel.frame = CGRectMake(minimumQtyText.frame.origin.x + minimumQtyText.frame.size.width + 10, minQtyLabel.frame.origin.y, 95, labelHeight);
            
            rangeModelabel.frame = CGRectMake(rewardValueLabel.frame.origin.x, minAmtLabel.frame.origin.y, 95, labelHeight);
            
            colon_14.frame = CGRectMake(rewardValueLabel.frame.origin.x + rewardValueLabel.frame.size.width , minQtyLabel.frame.origin.y, 5, 25);
            
            colon_15.frame = CGRectMake(colon_14.frame.origin.x , minAmtLabel.frame.origin.y, 5, 25);
            
            rewardValueText.frame = CGRectMake(colon_14.frame.origin.x + colon_14.frame.size.width + 5, colon_14.frame.origin.y, 70, 30);
            
            rangeModeText.frame = CGRectMake(rewardValueText.frame.origin.x , colon_15.frame.origin.y, 70, 30);
            
            //
            lowPriceItemLabel.frame = CGRectMake(rewardTypeLabel.frame.origin.x , startPriceText.frame.origin.y + startPriceText.frame.size.height + 10 , labelWidth, labelHeight);
            
            colon_16.frame = CGRectMake(colon_8.frame.origin.x, lowPriceItemLabel.frame.origin.y, 5, 25);
            
            lowPriceItemCheckBoxBtn.frame = CGRectMake(colon_16.frame.origin.x + colon_16.frame.size.width + 5, colon_16.frame.origin.y + 2 , 20, 20);
            
            //
            repeatLabel.frame = CGRectMake(minQtyLabel.frame.origin.x , lowPriceItemLabel.frame.origin.y  , labelWidth, labelHeight);
            
            colon_17.frame = CGRectMake(colon_11.frame.origin.x, lowPriceItemLabel.frame.origin.y, 5, 25);
            
            repeatCheckBoxBtn.frame = CGRectMake(colon_17.frame.origin.x + colon_17.frame.size.width + 5, colon_17.frame.origin.y + 2 , 20, 20);
            
            //
            allowMultipleDiscountsLabel.frame = CGRectMake(rangeModelabel.frame.origin.x - 30 , lowPriceItemLabel.frame.origin.y  , labelWidth + 60, labelHeight);
            
            colon_18.frame = CGRectMake(allowMultipleDiscountsLabel.frame.origin.x + allowMultipleDiscountsLabel.frame.size.width, lowPriceItemLabel.frame.origin.y, 5, 25);
            
            allowMultipleDiscountsCheckBoxBtn.frame = CGRectMake(colon_18.frame.origin.x + colon_18.frame.size.width + 5, colon_18.frame.origin.y + 2 , 20, 20);
            //
            offerAttributesLabel.frame = CGRectMake(dealNameLabel.frame.origin.x, allowMultipleDiscountsLabel.frame.origin.y + allowMultipleDiscountsLabel.frame.size.height +10, 215, labelHeight);
            //
            underLineLabel_7.frame = CGRectMake(offerAttributesLabel.frame.origin.x + offerAttributesLabel.frame.size.width, offerAttributesLabel.frame.origin.y, underLineLabel_6.frame.origin.x + underLineLabel_6.frame.size.width - (endTimeText.frame.origin.x ) - 110 , 1);
            
            productCategorizationLabel.frame = CGRectMake(underLineLabel_7.frame.origin.x + 20, underLineLabel_7.frame.origin.y + underLineLabel_7.frame.size.height,240,labelHeight);
            
            underLineLabel_8.frame = CGRectMake(underLineLabel_7.frame.origin.x , productCategorizationLabel.frame.origin.y + productCategorizationLabel.frame.size.height - 2, underLineLabel_7.frame.size.width , 1);
            //
            categoryLabel.frame = CGRectMake(dealNameLabel.frame.origin.x,offerAttributesLabel.frame.origin.y + offerAttributesLabel.frame.size.height + 10,95,labelHeight);
            
            subCategoryLabel.frame = CGRectMake(categoryLabel.frame.origin.x, categoryLabel.frame.origin.y + categoryLabel.frame.size.height, 95, labelHeight);
            
            sectionLabel.frame = CGRectMake(categoryLabel.frame.origin.x, subCategoryLabel.frame.origin.y + subCategoryLabel.frame.size.height, 95, labelHeight);
            
            //
            colon_19.frame = CGRectMake(colon_1.frame.origin.x + 2, categoryLabel.frame.origin.y, 5, 25);
            
            colon_20.frame = CGRectMake(colon_1.frame.origin.x + 2, subCategoryLabel.frame.origin.y, 5, 25);
            
            colon_21.frame = CGRectMake(colon_1.frame.origin.x + 2, sectionLabel.frame.origin.y, 5, 25);
            
            //
            categoryValueLabel.frame = CGRectMake(offerNameValueLabel.frame.origin.x , categoryLabel.frame.origin.y, labelWidth, labelHeight);
            
            subCategoryValueLabel.frame = CGRectMake(offerNameValueLabel.frame.origin.x ,subCategoryLabel.frame.origin.y, labelWidth, labelHeight);
            
            sectionValueLabel.frame = CGRectMake(offerNameValueLabel.frame.origin.x , sectionLabel.frame.origin.y, labelWidth, labelHeight);
            
            //
            departmentLabel.frame    = CGRectMake(productCategorizationLabel.frame.origin.x, categoryLabel.frame.origin.y, labelWidth + 5,labelHeight);
            
            subDepartmentLabel.frame = CGRectMake(departmentLabel.frame.origin.x, subCategoryLabel.frame.origin.y, labelWidth + 5, labelHeight);
            
            classLabel.frame         = CGRectMake(departmentLabel.frame.origin.x, sectionLabel.frame.origin.y, labelWidth + 5, labelHeight);
            
            subClassLabel.frame      = CGRectMake(departmentLabel.frame.origin.x, classLabel.frame.origin.y + classLabel.frame.size.height, labelWidth + 5, labelHeight);
            //
            colon_22.frame = CGRectMake(departmentLabel.frame.origin.x + departmentLabel.frame.size.width, colon_19.frame.origin.y, 5, 25);
            
            colon_23.frame = CGRectMake(colon_22.frame.origin.x , colon_20.frame.origin.y, 5, 25);
            
            colon_24.frame = CGRectMake(colon_22.frame.origin.x , colon_21.frame.origin.y, 5, 25);
            
            colon_25.frame = CGRectMake(colon_22.frame.origin.x , subClassLabel.frame.origin.y, 5, 25);
            
            
            //
            departmentValueLabel.frame    = CGRectMake(colon_22.frame.origin.x + colon_22.frame.size.width + 5 , departmentLabel.frame.origin.y, labelWidth + 5,labelHeight);
            
            subDepartmentValueLabel.frame = CGRectMake(departmentValueLabel.frame.origin.x , subDepartmentLabel.frame.origin.y, labelWidth + 5,labelHeight);
            
            classValueLabel.frame = CGRectMake(departmentValueLabel.frame.origin.x , classLabel.frame.origin.y, labelWidth + 5,labelHeight);
            
            subClassValueLabel.frame = CGRectMake(departmentValueLabel.frame.origin.x , subClassLabel.frame.origin.y, labelWidth + 5,labelHeight);
            
            //
            itemDetailsView.frame = CGRectMake( rewardTypeText.frame.origin.x , departmentLabel.frame.origin.y, rewardValueText.frame.origin.x + rewardValueText.frame.size.width - rewardTypeText.frame.origin.x, 100);
            
            //
            skuidLabel.frame = CGRectMake(0,0,60,25);
            
            productDescriptionLabel.frame = CGRectMake(skuidLabel.frame.origin.x + skuidLabel.frame.size.width + 1,skuidLabel.frame.origin.y, 120, skuidLabel.frame.size.height);
            
            eanLabel.frame = CGRectMake(productDescriptionLabel.frame.origin.x + productDescriptionLabel.frame.size.width + 1,skuidLabel.frame.origin.y, 60, skuidLabel.frame.size.height);
            
            rangeLabel.frame = CGRectMake(eanLabel.frame.origin.x + eanLabel.frame.size.width + 1,skuidLabel.frame.origin.y, 60, skuidLabel.frame.size.height);
            
            mrpLabel.frame = CGRectMake(rangeLabel.frame.origin.x + rangeLabel.frame.size.width + 1,skuidLabel.frame.origin.y, 50, skuidLabel.frame.size.height);
            
            salePriceLabel.frame = CGRectMake(mrpLabel.frame.origin.x + mrpLabel.frame.size.width + 1,skuidLabel.frame.origin.y, 74, skuidLabel.frame.size.height);
            
            itemDetailsTable.frame = CGRectMake(0,skuidLabel.frame.origin.y + skuidLabel.frame.size.height,itemDetailsView.frame.size.width,itemDetailsView.frame.size.height-(skuidLabel.frame.origin.y+ skuidLabel.frame.size.height));
            
        }
        
#pragma mark Handling the Response
        
        @try {
        
            //Appending the Values To The Labels  from the  the response data .

            NSDictionary * dic = offerIdDetailsArr[rowNumber];

             offerNameValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:OFFER_NAME] defaultReturn:@"--"];;
        
        if( [dic.allKeys containsObject:CREATED_Date] && ![[dic valueForKey:CREATED_Date] isKindOfClass:[NSNull class]] )
        
             createdOnValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:CREATED_Date] defaultReturn:@"--"];
        
        offerStatusValueLabel.text    = [self checkGivenValueIsNullOrNil:[dic valueForKey:OFFER_STATUS] defaultReturn:@"--"];
        
        startDateText.text            = [self checkGivenValueIsNullOrNil:[[dic valueForKey:OFFER_START_DATE] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
        
        if( [dic.allKeys containsObject:OFFER_END_DATE] && ![[dic valueForKey:OFFER_END_DATE] isKindOfClass:[NSNull class]] )
        
        endDateText.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:OFFER_END_DATE] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
        
        startTimeText.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:OFFER_START_TIME] defaultReturn:@"--"];
        
        endTimeText.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:OFFER_END_TIME] defaultReturn:@"--"];
        
            
        //categoryValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:DEAL_PRODUCT_CATEGORY] defaultReturn:@"--"];
        //
        //subCategoryValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kProductSubCategory] defaultReturn:@"--"];
        //
        //sectionValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SECTION] defaultReturn:@"--"];
        //
        //departmentValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kItemDept] defaultReturn:@"--"];
        //
        //subDepartmentValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kItemSubDept] defaultReturn:@"--"];
        //
        //classValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_CLASS] defaultReturn:@"--"];
        //
        //subClassValueLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_SUB_CLASS] defaultReturn:@"--"];
        
            NSNumber * day_1 = [self checkGivenValueIsNullOrNil:[dic valueForKey:DAY_1] defaultReturn:@""];
            NSNumber * day_2 = [self checkGivenValueIsNullOrNil:[dic valueForKey:DAY_2] defaultReturn:@""];
            NSNumber * day_3 = [self checkGivenValueIsNullOrNil:[dic valueForKey:DAY_3] defaultReturn:@""];
            NSNumber * day_4 = [self checkGivenValueIsNullOrNil:[dic valueForKey:DAY_4] defaultReturn:@""];
            NSNumber * day_5 = [self checkGivenValueIsNullOrNil:[dic valueForKey:DAY_5] defaultReturn:@""];
            NSNumber * day_6 = [self checkGivenValueIsNullOrNil:[dic valueForKey:DAY_6] defaultReturn:@""];
            NSNumber * day_7 = [self checkGivenValueIsNullOrNil:[dic valueForKey:DAY_7] defaultReturn:@""];
            
            NSNumber * repeatBool         = [self checkGivenValueIsNullOrNil:[dic valueForKey:REPEAT] defaultReturn:@""];
            NSNumber * multipleDiscBool   = [self checkGivenValueIsNullOrNil:[dic valueForKey: ALLOW_MULTIPLE_DISCOUNTS] defaultReturn:@""];
            NSNumber * priceBasedConfig   = [self checkGivenValueIsNullOrNil:[dic valueForKey:PRICE_BASED_CONFIGURATION] defaultReturn:@""];
            NSNumber * allowReturnsBool   = [self checkGivenValueIsNullOrNil:[dic valueForKey:ALLOW_RETURNS] defaultReturn:@""];
            NSNumber * allowExchangesBool = [self checkGivenValueIsNullOrNil:[dic valueForKey:ALLOW_EXCHANGES] defaultReturn:@""];
            NSNumber * lowestPriceItemBool= [self checkGivenValueIsNullOrNil:[dic valueForKey:LOW_PRICE_ITEM] defaultReturn:@""];
          
            if (day_1.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [checkBoxBtn1 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [checkBoxBtn1 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (day_2.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [checkBoxBtn2 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [checkBoxBtn2 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (day_3.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [checkBoxBtn3 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [checkBoxBtn3 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (day_4.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [checkBoxBtn4 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [checkBoxBtn4 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (day_5.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [checkBoxBtn5 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [checkBoxBtn5 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (day_6.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [checkBoxBtn6 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [checkBoxBtn6 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (day_7.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [checkBoxBtn7 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [checkBoxBtn7 setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (repeatBool.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [repeatCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [repeatCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (multipleDiscBool.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [allowMultipleDiscountsCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [allowMultipleDiscountsCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            
            if (allowReturnsBool.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [allowReturnsCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [allowReturnsCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            
            if (allowReturnsBool.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [allowReturnsCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [allowReturnsCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            if (allowExchangesBool.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [allowExchangeCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [allowExchangeCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            if (lowestPriceItemBool.boolValue == YES) {
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                [lowPriceItemCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            else {
                
                checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
                [lowPriceItemCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            }
            
            
            if (priceBasedConfig.boolValue == YES) {
                
                rewardCriteriaText.text = NSLocalizedString(@"quantity_based", nil);
            }
            else
                rewardCriteriaText.text = NSLocalizedString(@"turnOver_based", nil);
            
                rewardTypeText.text     = [self checkGivenValueIsNullOrNil:[dic valueForKey:REWARD_TYPE] defaultReturn:@"--"];
            
            float startPrice = 0;
            float endPrice   = 0;
            float minimumPurchaseQty = 0;
            float minimumPurchaseAmt = 0;
            float rewardValue = 0;
            
            for (NSDictionary * offerRangesList in [dic valueForKey:OFFER_RANGES_LIST]) {
                
                startPrice +=   [[self checkGivenValueIsNullOrNil:[offerRangesList valueForKey:START_PRICE] defaultReturn:@"0.00"] floatValue];
                
                endPrice   +=   [[self checkGivenValueIsNullOrNil:[offerRangesList valueForKey:END_PRICE] defaultReturn:@"0.00"] floatValue];
                
                minimumPurchaseQty   +=   [[self checkGivenValueIsNullOrNil:[offerRangesList valueForKey:MINIMUM_PURCHASE_QTY] defaultReturn:@"0.00"] floatValue];
                
                minimumPurchaseAmt   +=   [[self checkGivenValueIsNullOrNil:[offerRangesList valueForKey:MINIMUM_PURCHASE_AMT] defaultReturn:@"0.00"] floatValue];
                rewardValue          +=   [[self checkGivenValueIsNullOrNil:[offerRangesList valueForKey:REWARD_VALUE] defaultReturn:@"0.00"] floatValue];
                
                rangeModeText.text    = [self checkGivenValueIsNullOrNil:[offerRangesList valueForKey:RANGE_MODE] defaultReturn:@"--"];
                
            }
            
            startPriceText.text = [NSString stringWithFormat:@"%.2f",startPrice];
            endPriceText.text   = [NSString stringWithFormat:@"%.2f",endPrice];
            minimumQtyText.text = [NSString stringWithFormat:@"%.2f",minimumPurchaseQty];
            minAmtText.text     = [NSString stringWithFormat:@"%.2f",minimumPurchaseAmt];
            rewardValueText.text     = [NSString stringWithFormat:@"%.2f",rewardValue];
            
           
            if((offerProductsArray == nil) || (offerProductsArray.count == 0)){
                
                for (NSDictionary * offerProductsDic in [dic valueForKey:OFFER_PRODUCTS]) {
                    
                    [offerProductsArray addObject:offerProductsDic];
                    
                }
            }
            if((locationsArr == nil) || (locationsArr.count == 0)){
                
                for (NSDictionary * locationDic in [dic valueForKey:OFFER_LOCATION_LIST]) {
                    
                    [locationsArr addObject:locationDic];
                }
            }

        } @catch (NSException * exception) {
            
        }
  
        [transperentView addSubview:offerDetailsView];
        [offerDetailsView addSubview:headerlabel];
        [offerDetailsView addSubview:headerNameLbl];
        [offerDetailsView addSubview:closeBtn];
        
        [offerDetailsView addSubview: dealNameLabel];
        [offerDetailsView addSubview: createdOnLabel];
        [offerDetailsView addSubview: dealStatusLabel];
        
        [offerDetailsView addSubview: colon_1];
        [offerDetailsView addSubview: colon_2];
        [offerDetailsView addSubview: colon_3];
        
        [offerDetailsView addSubview: offerNameValueLabel];
        [offerDetailsView addSubview: createdOnValueLabel];
        [offerDetailsView addSubview: offerStatusValueLabel];
        
        [offerDetailsView addSubview: startDate_Label];
        [offerDetailsView addSubview: endDate_Label];
        [offerDetailsView addSubview: startTimeLabel];
        [offerDetailsView addSubview: endTimeLabel];
        
        [offerDetailsView addSubview: colon_4];
        [offerDetailsView addSubview: colon_5];
        [offerDetailsView addSubview: colon_6];
        [offerDetailsView addSubview: colon_7];
        
        [offerDetailsView addSubview: startDateText];
        [offerDetailsView addSubview: endDateText];
        [offerDetailsView addSubview: startTimeText];
        [offerDetailsView addSubview: endTimeText];
        
        [offerDetailsView addSubview:underLineLabel_1];
        [offerDetailsView addSubview:locationsLabel];
        [offerDetailsView addSubview:underLinelabel_2];
        
        [offerDetailsView addSubview:locationsView];
        
        [locationsView addSubview:locationsTable];
        
        [offerDetailsView addSubview:underLineLabel_3];
        [offerDetailsView addSubview:offerDaysLabel];
        [offerDetailsView addSubview:underLineLabel_4];
        
        [offerDetailsView addSubview:checkBoxBtn1];
        [offerDetailsView addSubview:checkBoxBtn2];
        [offerDetailsView addSubview:checkBoxBtn3];
        [offerDetailsView addSubview:checkBoxBtn4];
        [offerDetailsView addSubview:checkBoxBtn5];
        [offerDetailsView addSubview:checkBoxBtn6];
        [offerDetailsView addSubview:checkBoxBtn7];
        
        [offerDetailsView addSubview:day1_Label];
        [offerDetailsView addSubview:day2_Label];
        [offerDetailsView addSubview:day3_Label];
        [offerDetailsView addSubview:day4_Label];
        [offerDetailsView addSubview:day5_Label];
        [offerDetailsView addSubview:day6_Label];
        [offerDetailsView addSubview:day7_Label];
        
        [offerDetailsView addSubview:underLineLabel_5];
        
        [offerDetailsView addSubview:allowReturnsCheckBoxBtn];
        [offerDetailsView addSubview:allowReturnsLabel];
        [offerDetailsView addSubview:allowExchangeCheckBoxBtn];
        [offerDetailsView addSubview:allowExhangesLabel];
        
        [offerDetailsView addSubview:underLineLabel_6];
        
        [offerDetailsView addSubview:rewardTypeLabel];
        [offerDetailsView addSubview:rewardCriteriaLabel];
        [offerDetailsView addSubview:startPriceLabel];
        
        [offerDetailsView addSubview:colon_8];
        [offerDetailsView addSubview:colon_9];
        [offerDetailsView addSubview:colon_10];
        
        [offerDetailsView addSubview:rewardTypeText];
        [offerDetailsView addSubview:rewardCriteriaText];
        [offerDetailsView addSubview:startPriceText];
        
        [offerDetailsView addSubview:minQtyLabel];
        [offerDetailsView addSubview:minAmtLabel];
        [offerDetailsView addSubview:endPriceLabel];
        
        [offerDetailsView addSubview:colon_11];
        [offerDetailsView addSubview:colon_12];
        [offerDetailsView addSubview:colon_13];
        
        [offerDetailsView addSubview:minimumQtyText];
        [offerDetailsView addSubview:minAmtText];
        [offerDetailsView addSubview:endPriceText];
        
        [offerDetailsView addSubview:rewardValueLabel];
        [offerDetailsView addSubview:rangeModelabel];
        
        [offerDetailsView addSubview:colon_14];
        [offerDetailsView addSubview:colon_15];
        
        [offerDetailsView addSubview:rewardValueText];
        [offerDetailsView addSubview:rangeModeText];
        
        [offerDetailsView addSubview:lowPriceItemLabel];
        [offerDetailsView addSubview:colon_16];
        [offerDetailsView addSubview:lowPriceItemCheckBoxBtn];
        
        [offerDetailsView addSubview:repeatLabel];
        [offerDetailsView addSubview:colon_17];
        [offerDetailsView addSubview:repeatCheckBoxBtn];
        
        [offerDetailsView addSubview:allowMultipleDiscountsLabel];
        [offerDetailsView addSubview:colon_18];
        [offerDetailsView addSubview:allowMultipleDiscountsCheckBoxBtn];
        
        [offerDetailsView addSubview:offerAttributesLabel];
        
        [offerDetailsView addSubview:underLineLabel_7];
        [offerDetailsView addSubview:productCategorizationLabel];
        [offerDetailsView addSubview:underLineLabel_8];
        
        [offerDetailsView addSubview:categoryLabel];
        [offerDetailsView addSubview:subCategoryLabel];
        [offerDetailsView addSubview:sectionLabel];
        
        [offerDetailsView addSubview:colon_19];
        [offerDetailsView addSubview:colon_20];
        [offerDetailsView addSubview:colon_21];
        
        
        [offerDetailsView addSubview:categoryValueLabel];
        [offerDetailsView addSubview:subCategoryValueLabel];
        [offerDetailsView addSubview:sectionValueLabel];
        
        [offerDetailsView addSubview:departmentLabel];
        [offerDetailsView addSubview:subDepartmentLabel];
        [offerDetailsView addSubview:classLabel];
        [offerDetailsView addSubview:subClassLabel];
        
        [offerDetailsView addSubview:colon_22];
        [offerDetailsView addSubview:colon_23];
        [offerDetailsView addSubview:colon_24];
        [offerDetailsView addSubview:colon_25];
        
        [offerDetailsView addSubview:departmentValueLabel];
        [offerDetailsView addSubview:subDepartmentValueLabel];
        [offerDetailsView addSubview:classValueLabel];
        [offerDetailsView addSubview:subClassValueLabel];
        
        
        [offerDetailsView addSubview:itemDetailsView];
        
        [itemDetailsView addSubview:skuidLabel];
        [itemDetailsView addSubview:productDescriptionLabel];
        [itemDetailsView addSubview:eanLabel];
        [itemDetailsView addSubview:rangeLabel];
        [itemDetailsView addSubview:mrpLabel];
        [itemDetailsView addSubview:salePriceLabel];
        [itemDetailsView addSubview:itemDetailsTable];
        
        
        [self.view addSubview:transperentView];
        
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
        [itemDetailsTable reloadData];
        [locationsTable reloadData];
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
-(void)closeOfferDetailsView {
    
    //play audio for button touch...
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        transperentView.hidden = YES;
        
        if ([transperentView isDescendantOfView:self.view])
            [transperentView removeFromSuperview];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       name
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)viewDidAppear:(BOOL)animated {
    //super calss method...
    [super viewDidAppear:YES];
    
    @try {
        isSecondOfferServiceCal = false; // added by roja on 17/10/2019...

        [self getOffers:nil];
        
    } @catch (NSException * exception) {
        
    }
}

#pragma mark Offers Call...

/**
 * @description  Forming the request String to get the offers summary....
 * @date         09/02/2018
 * @method       getOffers
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getOffers:(NSString *)offerIDString {
    
    @try {
        
        [HUD setHidden:NO];
        
        NSMutableDictionary * offersDictionary = [[NSMutableDictionary alloc] init];
   
        if (isOffersSummary == true) {
            
            offerIndex = 0;
            
            if(offerIdDetailsArr == nil) {
                
                offerIdDetailsArr = [NSMutableArray new];
            }
            
            //setting the Boolean Value  as false...
            offersDictionary[ALLOW_MULTIPLE_DISCOUNTS] = [NSNumber numberWithBool:false];
            
            //setting the 0 as Start Index...
            offersDictionary[START_INDEX] = [NSString stringWithFormat:@"%d",offerIndex];
            
            //setting the Boolean Value  as false...
            offersDictionary[IS_EMPLOYEE_SPECIFIC] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[IS_CUSTOMER_SPECIFIC] = [NSNumber numberWithBool:false];
            
            //sending the Deal ID to get the Deal ID Details response...
            offersDictionary[OFFER_ID] = [NSString stringWithFormat:@"%@",offerIDString];
            
            //Setting the Request Header object...
            offersDictionary[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            
            //setting the Boolean Value  as false...
            offersDictionary[LOW_PRICE_ITEM] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[IMAGE_DELETED] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[IMAGE_DELETED] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as true...
            offersDictionary[IMAGE_REQUIRED] = [NSNumber numberWithBool:true];
            
            offersDictionary[REPEAT] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[DAY_1] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[DAY_2] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[DAY_3] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[DAY_4] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[DAY_5] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[DAY_6] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[DAY_7] = [NSNumber numberWithBool:false];
            
            //setting the Boolean Value  as false...
            offersDictionary[COMBO] = [NSNumber numberWithBool:false];
            
            //setting the store location...
            offersDictionary[STORELOCATION] = presentLocation;
            
            //sending max records as empty...
            offersDictionary[MAX_RECORDS] = @"";
            
        }
        
        else {
            
            if(offerDetailsArray == nil ){
                
                offerDetailsArray = [NSMutableArray new];
            }
            else if(offerDetailsArray.count){
                
                [offerDetailsArray removeAllObjects];
            }
            
            //Setting the Request Header object...
            offersDictionary[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            
            //setting the 0 as Start Index...
            offersDictionary[START_INDEX] = [NSString stringWithFormat:@"%d",offerIndex];
            
            //setting the store location....
            offersDictionary[STORELOCATION] = presentLocation;
            
            
            //It is used for searching particular id....
            offersDictionary[SEARCH_CRITERIA] = searchOffersText.text;

   
            NSString  *catStr      = categoryTxt.text;
            NSString  *subCatStr   = subCategoryTxt.text;
            NSString  *deptStr     = departmentTxt.text;
            NSString  *subDeptStr  = subDepartmentTxt.text;
            NSString  *modelStr    = modelTxt.text;
            NSString  *statusStr   = statusTxt.text;
            NSString  *startDteStr = startDteTxt.text;
            NSString  *endDteStr   = endDteTxt.text;
            
            
            
            if((startDteTxt.text).length > 0)
                startDteStr =  [NSString stringWithFormat:@"%@%@",startDteTxt.text,@" 00:00:00"];
            
            
            if ((endDteTxt.text).length>0) {
                endDteStr = [NSString stringWithFormat:@"%@%@",endDteTxt.text,@" 00:00:00"];
                
            }
            
            if (categoriesListTbl.tag == 0 || (categoryTxt.text).length == 0)
                
                catStr      = @"";
            
            if (subCategoriesListTbl.tag == 0 || (subCategoryTxt.text).length == 0)
                
                subCatStr   = @"";
            
            if (departmentListTbl.tag == 0 || (departmentTxt.text).length == 0)
                
                deptStr     = @"";
            
            if (subDepartmentListTbl.tag == 0 || (subDepartmentTxt.text).length == 0)
                
                subDeptStr  = @"";
            
            if (modelTable.tag == 0 || (modelTxt.text).length == 0)
                
                modelStr    = @"";
            
            if (statusTable.tag == 0 || (statusTxt.text).length == 0)
                
                statusStr    = @"";
            
            if(searchBtn.tag == 2 ) {
                
                catStr      = @"";
                subCatStr   = @"";
                deptStr     = @"";
                subDeptStr  = @"";
                modelStr    = @"";
                startDteStr = @"";
                endDteStr   = @"";
                
            }
            
            //[DealsDictionary setValue:catStr forKey:ITEM_CATEGORY];
            //[DealsDictionary setValue:subCatStr forKey:kSubCategory];
            //[DealsDictionary setValue:deptStr forKey:kItemDept];
            //[DealsDictionary setValue:subDeptStr forKey:kItemSubDept];
            //[DealsDictionary setValue:modelStr forKey:MODEL];
            //[offersDictionary setValue:startDteStr forKey:OFFER_START_DATE];
            //[offersDictionary setValue:endDteStr forKey:OFFER_END_DATE];
            
        }
        
        
        isSecondOfferServiceCal = false; // added by roja on 17/10/2019...
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:offersDictionary options:0 error:&err];
        NSString * getOffers = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        WebServiceController * getOffersService = [[WebServiceController alloc] init];
        getOffersService.offerMasterDelegate = self;
        [getOffersService getOffersDetails:getOffers];

    } @catch (NSException *exception) {
        
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

-(void)callingSubCategories:(NSString *)categoryName {
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        
        if (subCategoriesListArr == nil) {
            
            subCategoriesListArr = [NSMutableArray new];
            
        }
        
        NSArray * keys = @[REQUEST_HEADER,START_INDEX,kCategoryName,SL_NO,FLAG,kStoreLocation];
        NSArray * objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,categoryName,[NSNumber numberWithBool:true],EMPTY_STRING,presentLocation];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
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
 * @description  Handling the SuccessResponse for Get Offers....
 * @date         07/02/2018
 * @method       getoffersSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getoffersSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        
        // added by roja on 17/10/2019....
        if(isSecondOfferServiceCal){
            if (!isSavingLocally) {
                
                [self getOfferDetailsHandler:successDictionary];
            }
        }
        
        else {
            //Upto here added by roja on 17/10/2019....

            if (isOffersSummary == true) {
                
                if (offerProductsArray == nil) {
                    
                    offerProductsArray = [NSMutableArray new];
                }
                
                if (locationsArr == nil) {
                    
                    locationsArr = [NSMutableArray new];
                }
                
                //else if([offerProductsArray count]) {
                //[offerProductsArray removeAllObjects];
                //}
                
                offerIdDetailsArr = [[successDictionary valueForKey:OFFER_LIST] copy];
                
                if (offerIdDetailsArr.count) {
                    
                    [self displayOfferDetailsView:0];
                }
                
            }
            
            else {
                
                isOffersSummary = false;
                
                totalOffers = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"]intValue];
                
                for (NSDictionary * offerDetailsDic in [successDictionary valueForKey:OFFER_LIST]) {
                    
                    [offerDetailsArray addObject:offerDetailsDic];
                    
                }
                
                
                //Reason: To Display the Records in pagination mode based on the TotalRecords..
                
                int strTotalRecords = totalOffers/10;
                
                int remainRecords = totalOffers % 10;
                
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
                
                if(offerIndex == 0){
                    pagenationTxt.text = @"1";
                    
                }
            
            }
        }

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [currentOffersTable reloadData];
    }
}

/**
 * @description  Handling the ErrorResponse for Get Offers....
 * @date         07/02/2018
 * @method       getOffersErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getOffersErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        if(isSecondOfferServiceCal){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Currently No Offers To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else{
            
            float y_axis = self.view.frame.size.height - 120;
            NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
            [self displayAlertMessage: mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
    
    } @catch (NSException *exception) {
   
    } @finally {
        
        [HUD setHidden:YES];
    }
}

#pragma -mark handling of service calls response used in dropDowns....

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
        
        
        
        //if(categoriesListTbl.tag == 2)
        //[categoriesListArr addObject:NSLocalizedString(@"all_categories",nil)];
        //else
        
        [subCategoriesListArr addObject:NSLocalizedString(@"all_subcategories",nil)];
        
        for (NSDictionary * categoryDic in  [sucessDictionary valueForKey:@"categories"]) {
            
            if([categoryTxt.text isEqualToString:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:@"categoryName"]  defaultReturn:@""]] ){
                
                if([categoryDic.allKeys containsObject:@"subCategories"] && (![[categoryDic valueForKey:@"subCategories"] isKindOfClass: [NSNull class]]))
                    
                    for (NSDictionary * subCatDic in  [categoryDic valueForKey:@"subCategories"]) {
                        
                        [subCategoriesListArr addObject:[self checkGivenValueIsNullOrNil:[subCatDic valueForKey:@"subcategoryName"]  defaultReturn:@""]];
                    }
                
                break;
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
        
        NSString  * mesg = [NSString stringWithFormat:@"%@",error];
        
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
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma mark popOver Methods

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
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            return;
        }
        
        float tableHeight = locationWiseCategoriesArr.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = locationWiseCategoriesArr.count * 33;
        
        if(locationWiseCategoriesArr.count > 5)
            tableHeight =(tableHeight/locationWiseCategoriesArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:(categoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:offersView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
            [self callingSubCategories:categoryTxt.text];
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
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:(subCategoryTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:offersView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


/**
 * @description  showing the availiable  Departments.......
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
        
        [self showPopUpForTables:departmentListTbl  popUpWidth:(departmentTxt.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:departmentTxt  showViewIn:offersView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
            
            [self showPopUpForTables:subDepartmentListTbl  popUpWidth:(subDepartmentTxt.frame.size.width*1.5)  popUpHeight:tableHeight presentPopUpAt:subDepartmentTxt  showViewIn:offersView permittedArrowDirections:UIPopoverArrowDirectionUp ];
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
        
        [self showPopUpForTables:modelTable  popUpWidth:(modelTxt.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:modelTxt  showViewIn:offersView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
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

-(void)showOfferStatusList:(UIButton*)sender{
    
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
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:offersView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
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
        
        isOffersSummary = false;

        [self getOffers:nil];
    }
    
    @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"----exception while calling the service Call---%@",exception);
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
                
                [popover presentPopoverFromRect:startDteTxt.frame inView:offersView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                
                [popover presentPopoverFromRect:endDteTxt.frame inView:offersView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0  && (departmentTxt.text).length== 0  && (subDepartmentTxt.text).length== 0 && (startDteTxt.text).length == 0 && (endDteTxt.text).length== 0   && (modelTxt.text).length== 0 && (statusTxt.text).length == 0 ) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_above_fields_before_proceeding",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        else
            [HUD setHidden:NO];
       
        offerIndex = 0;
        
        isOffersSummary = false;
        [self getOffers:nil];
        
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
        
        categoryTxt.text    = @"";
        subCategoryTxt.text = @"";
        departmentTxt.text  = @"";
        subCategoryTxt.text = @"";
        modelTxt.text       = @"";
        startDteTxt.text    = @"";
        endDteTxt.text      = @"";
        statusTxt.text      = @"";
        
        offerIndex = 0;
        
        [self getOffers:nil];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
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

//- (void)textFieldDidChange:(UITextField *)textField {
//    
//        if (textField == searchOffersText ) {
//            
//            if ([textField.text length] >= 4 ) {
//                
//                @try {
//                    
//                    requestStartNumber = 0;
//                    stockRequestsInfoArr = [NSMutableArray new];
//                    [self callingGetStockRequests];
//                    
//                    
//                } @catch (NSException *exception) {
//                    NSLog(@"---- exception while calling ServicesCall ----%@",exception);
//                    
//                } @finally {
//                    
//                }
//            }
//            else if ([textField.text length] == 0) {
//                
//                requestStartNumber = 0;
//                stockRequestsInfoArr = [NSMutableArray new];
//                [self callingGetStockRequests];
//            }
//        }
//    }


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

    if(tableView == currentOffersTable) {
        
        if (offerDetailsArray.count)
            
            return offerDetailsArray.count;
        
        else  return 1;
    }
    else if(tableView == categoriesListTbl){
        
        return locationWiseCategoriesArr.count;
        
    }
    else if(tableView == subCategoriesListTbl){
        
        return subCategoriesListArr.count;
        
    }
    
    else if(tableView == departmentListTbl){
        
        return departmentListArr.count;
    }
    else if(tableView == subDepartmentListTbl){
        
        return subDepartmentListArr.count;
        
    }
    else if(tableView == modelTable){
        
        return modelListArr.count;
        
    }
    else if(tableView == pagenationTbl) {
        
        return pagenationArr.count;
    }
    else if(tableView == itemDetailsTable) {
        
        return offerProductsArray.count;
    }
    else if(tableView == locationsTable) {
        
        return locationsArr.count;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if(tableView == currentOffersTable){
            
            return  38;
        }
        else if (tableView == categoriesListTbl || tableView == subCategoriesListTbl || tableView == departmentListTbl || tableView == subDepartmentListTbl || tableView == modelTable || tableView == pagenationTbl || tableView == locationsTable) {
            
            return 35;
        }
        else if (tableView == itemDetailsTable) {
            
            return 20;
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
   
    if (tableView == currentOffersTable) {
        
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
                
                layer_1.frame = CGRectMake(snoLabel.frame.origin.x, hlcell.frame.size.height - 2,saleValueLabel.frame.origin.x+saleValueLabel.frame.size.width-(snoLabel.frame.origin.x),1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException *exception) {
                
            }
        }
        tableView.separatorColor = [UIColor clearColor];
        
        
        /*UILabels used in this cell*/
        UILabel * sno_Label;
        UILabel * offerId_Label;
        UILabel * description_Label;
        UILabel * startDate_Label;
        UILabel * endDate_Label;
        UILabel * status_Label;
        UILabel * itemGroup_Label;
        UILabel * offerType_Label;
        UILabel * saleQty_Label;
        UILabel * saleValue_Label;
        
        /*Creation of UILabels used in this cell*/
        sno_Label = [[UILabel alloc] init];
        sno_Label.backgroundColor = [UIColor clearColor];
        sno_Label.textAlignment = NSTextAlignmentCenter;
        sno_Label.numberOfLines = 1;
        sno_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        offerId_Label = [[UILabel alloc] init];
        offerId_Label.backgroundColor = [UIColor clearColor];
        offerId_Label.textAlignment = NSTextAlignmentCenter;
        offerId_Label.numberOfLines = 1;
        offerId_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        description_Label = [[UILabel alloc] init];
        description_Label.backgroundColor = [UIColor clearColor];
        description_Label.textAlignment = NSTextAlignmentCenter;
        description_Label.numberOfLines = 1;
        description_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        startDate_Label = [[UILabel alloc] init];
        startDate_Label.backgroundColor = [UIColor clearColor];
        startDate_Label.textAlignment = NSTextAlignmentCenter;
        startDate_Label.numberOfLines = 1;
        startDate_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        endDate_Label = [[UILabel alloc] init];
        endDate_Label.backgroundColor = [UIColor clearColor];
        endDate_Label.textAlignment = NSTextAlignmentCenter;
        endDate_Label.numberOfLines = 1;
        endDate_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        status_Label = [[UILabel alloc] init];
        status_Label.backgroundColor = [UIColor clearColor];
        status_Label.textAlignment = NSTextAlignmentCenter;
        status_Label.numberOfLines = 1;
        status_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemGroup_Label = [[UILabel alloc] init];
        itemGroup_Label.backgroundColor = [UIColor clearColor];
        itemGroup_Label.textAlignment = NSTextAlignmentCenter;
        itemGroup_Label.numberOfLines = 1;
        itemGroup_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        offerType_Label = [[UILabel alloc] init];
        offerType_Label.backgroundColor = [UIColor clearColor];
        offerType_Label.textAlignment = NSTextAlignmentCenter;
        offerType_Label.numberOfLines = 1;
        offerType_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        saleQty_Label = [[UILabel alloc] init];
        saleQty_Label.backgroundColor = [UIColor clearColor];
        saleQty_Label.textAlignment = NSTextAlignmentCenter;
        saleQty_Label.numberOfLines = 1;
        saleQty_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        saleValue_Label = [[UILabel alloc] init];
        saleValue_Label.backgroundColor = [UIColor clearColor];
        saleValue_Label.textAlignment = NSTextAlignmentCenter;
        saleValue_Label.numberOfLines = 1;
        saleValue_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        //setting the color to text....
        sno_Label.textColor          = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        offerId_Label.textColor       = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        description_Label.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        startDate_Label.textColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        endDate_Label.textColor      = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        status_Label.textColor       = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemGroup_Label.textColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        offerType_Label.textColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        saleQty_Label.textColor      = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        saleValue_Label.textColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        
        //added subview to cell View....
        [hlcell.contentView addSubview:sno_Label];
        [hlcell.contentView addSubview:offerId_Label];
        [hlcell.contentView addSubview:description_Label];
        
        [hlcell.contentView addSubview:startDate_Label];
        [hlcell.contentView addSubview:endDate_Label];
        [hlcell.contentView addSubview:status_Label];
        
        [hlcell.contentView addSubview:itemGroup_Label];
        [hlcell.contentView addSubview:offerType_Label];
        [hlcell.contentView addSubview:saleQty_Label];
        
        [hlcell.contentView addSubview:saleValue_Label];
        
        
        //setting frame and font........
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame....
            sno_Label.frame          = CGRectMake(snoLabel.frame.origin.x, 0, snoLabel.frame.size.width, hlcell.frame.size.height);
            
            offerId_Label.frame       = CGRectMake(offerIdsLabel.frame.origin.x, 0, offerIdsLabel.frame.size.width, hlcell.frame.size.height);
            
            description_Label.frame  = CGRectMake(descriptionLabel.frame.origin.x, 0, descriptionLabel.frame.size.width, hlcell.frame.size.height);
            
            startDate_Label.frame    = CGRectMake(startDateLabel.frame.origin.x, 0, startDateLabel.frame.size.width, hlcell.frame.size.height);
            
            endDate_Label.frame      = CGRectMake(endDateLabel.frame.origin.x, 0, endDateLabel.frame.size.width, hlcell.frame.size.height);
            
            status_Label.frame       = CGRectMake(statusLabel.frame.origin.x, 0, statusLabel.frame.size.width, hlcell.frame.size.height);
            
            itemGroup_Label.frame    = CGRectMake(itemGroupLabel.frame.origin.x, 0, itemGroupLabel.frame.size.width, hlcell.frame.size.height);
            
            offerType_Label.frame     = CGRectMake(offerTypeLabel.frame.origin.x, 0, offerTypeLabel.frame.size.width, hlcell.frame.size.height);
            
            saleQty_Label.frame      = CGRectMake(saleQtyLabel.frame.origin.x, 0, saleQtyLabel.frame.size.width, hlcell.frame.size.height);
            
            saleValue_Label.frame    = CGRectMake(saleValueLabel.frame.origin.x, 0, saleValueLabel.frame.size.width, hlcell.frame.size.height);
        }
        
        if (offerDetailsArray.count >= indexPath.row && offerDetailsArray.count ) {
            
            NSDictionary * dic = offerDetailsArray[indexPath.row];
            
            sno_Label.text           = [NSString stringWithFormat:@"%ld", (indexPath.row + 1)+offerIndex];
            
            offerId_Label.text        = [self checkGivenValueIsNullOrNil:[dic valueForKey:OFFER_ID] defaultReturn:@"--"];
            
            description_Label.text   = [self checkGivenValueIsNullOrNil:[dic valueForKey:OFFER_DESCRIPTION] defaultReturn:@"--"];
            
            if( [dic.allKeys containsObject:OFFER_START_DATE] && ![[dic valueForKey:OFFER_START_DATE] isKindOfClass:[NSNull class]] )
                
                startDate_Label.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:OFFER_START_DATE] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
            
            if( [dic.allKeys containsObject:OFFER_END_DATE] && ![[dic valueForKey:OFFER_END_DATE] isKindOfClass:[NSNull class]] )
                
                endDate_Label.text   = [self checkGivenValueIsNullOrNil:[[dic valueForKey:OFFER_END_DATE] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
            
            status_Label.text    = [self checkGivenValueIsNullOrNil:[dic valueForKey:OFFER_STATUS] defaultReturn:@"--"];
            
            offerType_Label.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:OFFER_CATEGORY] defaultReturn:@"--"];
            
            for (NSDictionary * rangeListDic in [dic valueForKey:@"offerRangesList"]) {
                
                itemGroup_Label.text = [self checkGivenValueIsNullOrNil:[rangeListDic valueForKey:@"groupId"] defaultReturn:@"--"];
                
                saleQty_Label.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[rangeListDic valueForKey:@"minimumPurchaseQuantity"] defaultReturn:@"0.00"] floatValue]];
                
                saleValue_Label.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[rangeListDic valueForKey:@"minimumPurchaseamount"] defaultReturn:@"0.00"] floatValue]];
            }
        }
        
        else {
            
            sno_Label.text         = @"--";
            offerId_Label.text      = @"--";
            description_Label.text = @"--";
            startDate_Label.text   = @"--";
            endDate_Label.text     = @"--";
            status_Label.text      = @"--";
            itemGroup_Label.text   = @"--";
            offerType_Label.text    = @"--";
            saleQty_Label.text     = @"--";
            saleValue_Label.text   = @"--";
            
        }
        
        //setting font size....
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
        
        
        hlcell.backgroundColor = [UIColor clearColor];
        hlcell.tag = indexPath.row;
        
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return hlcell;
        
    }
    else if(tableView == categoriesListTbl) {
        
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
    else if (tableView == modelTable) {
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
            
            hlcell.textLabel.text = pagenationArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == itemDetailsTable) {
        
        static NSString * hlCellID = @"hlCellID";
        
        UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        //CAGradientLayer *layer_1;
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            //            @try {
            //                layer_1 = [CAGradientLayer layer];
            //
            //                layer_1.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:171/255 green:171/255 blue:171/255 alpha:1.0] CGColor],(id)[[UIColor colorWithRed:171/255 green:171/255 blue:171/255 alpha:1.0] CGColor],nil];
            //
            //                layer_1.frame = CGRectMake(skuidLabel.frame.origin.x, hlcell.frame.size.height - 2,salePriceLabel.frame.origin.x+salePriceLabel.frame.size.width-(skuidLabel.frame.origin.x),1);
            //
            //                [hlcell.contentView.layer addSublayer:layer_1];
            //
            //            } @catch (NSException *exception) {
            
            //}
        }
        
        tableView.separatorColor = [UIColor clearColor];
        
        
        UILabel * skuid_Label;
        UILabel * productDesc_Label;
        UILabel * ean_Label;
        UILabel * range_Label;
        UILabel * mrp_Label;
        UILabel * salePrice_Label;
        
        /*Creation of UILabels used in this cell*/
        skuid_Label = [[UILabel alloc] init];
        skuid_Label.backgroundColor = [UIColor clearColor];
        skuid_Label.textAlignment = NSTextAlignmentCenter;
        
        skuid_Label.numberOfLines = 1;
        skuid_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        productDesc_Label = [[UILabel alloc] init];
        productDesc_Label.backgroundColor = [UIColor clearColor];
        productDesc_Label.textAlignment = NSTextAlignmentCenter;
        productDesc_Label.numberOfLines = 1;
        productDesc_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        ean_Label = [[UILabel alloc] init];
        ean_Label.backgroundColor = [UIColor clearColor];
        ean_Label.textAlignment = NSTextAlignmentCenter;
        ean_Label.numberOfLines = 1;
        ean_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        range_Label = [[UILabel alloc] init];
        range_Label.backgroundColor = [UIColor clearColor];
        range_Label.textAlignment = NSTextAlignmentCenter;
        range_Label.numberOfLines = 1;
        range_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        mrp_Label = [[UILabel alloc] init];
        mrp_Label.backgroundColor = [UIColor clearColor];
        mrp_Label.textAlignment = NSTextAlignmentCenter;
        mrp_Label.numberOfLines = 1;
        mrp_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        salePrice_Label = [[UILabel alloc] init];
        salePrice_Label.backgroundColor = [UIColor clearColor];
        salePrice_Label.textAlignment = NSTextAlignmentCenter;
        salePrice_Label.numberOfLines = 1;
        salePrice_Label.lineBreakMode = NSLineBreakByWordWrapping;
        
        skuid_Label.textColor       = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        productDesc_Label.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        ean_Label.textColor         = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        range_Label.textColor       = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        mrp_Label.textColor         = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        salePrice_Label.textColor   = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        
        
        skuid_Label.font     = [UIFont boldSystemFontOfSize:12.0f];
        productDesc_Label.font = [UIFont boldSystemFontOfSize:12.0f];
        ean_Label.font       = [UIFont boldSystemFontOfSize:12.0f];
        range_Label.font     = [UIFont boldSystemFontOfSize:12.0f];
        mrp_Label.font       = [UIFont boldSystemFontOfSize:12.0f];
        salePrice_Label.font = [UIFont boldSystemFontOfSize:12.0f];
        
        //added subview to cell View....
        [hlcell.contentView addSubview:skuid_Label];
        [hlcell.contentView addSubview:productDesc_Label];
        [hlcell.contentView addSubview:ean_Label];
        [hlcell.contentView addSubview:range_Label];
        [hlcell.contentView addSubview:mrp_Label];
        [hlcell.contentView addSubview:salePrice_Label];
        
        //setting frame and font........
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame....
            skuid_Label.frame  = CGRectMake(snoLabel.frame.origin.x, 0, snoLabel.frame.size.width, hlcell.frame.size.height);
            productDesc_Label.frame = CGRectMake(productDescriptionLabel.frame.origin.x, 0, productDescriptionLabel.frame.size.width, hlcell.frame.size.height);
            ean_Label.frame    = CGRectMake(eanLabel.frame.origin.x, 0, eanLabel.frame.size.width, hlcell.frame.size.height);
            range_Label.frame  = CGRectMake(rangeLabel.frame.origin.x, 0, rangeLabel.frame.size.width, hlcell.frame.size.height);
            mrp_Label.frame    = CGRectMake(mrpLabel.frame.origin.x, 0, mrpLabel.frame.size.width, hlcell.frame.size.height);
            salePrice_Label.frame = CGRectMake(salePriceLabel.frame.origin.x, 0, salePriceLabel.frame.size.width, hlcell.frame.size.height);
            
        }
        
        if (offerProductsArray.count >= indexPath.row && offerProductsArray.count) {
            
            NSMutableDictionary * locDic = offerProductsArray[indexPath.row] ;
          
            skuid_Label.text = [locDic valueForKey:ITEM_SKU];
            productDesc_Label.text = [locDic valueForKey:ITEM_DESC];
            ean_Label.text = [locDic valueForKey:EAN];
            
            range_Label.text       = @"--";
            mrp_Label.text         = @"--";
            salePrice_Label.text   = @"--";

        }
        else {
        
        skuid_Label.text       = @"--";
        productDesc_Label.text = @"--";
        ean_Label.text         = @"--";
        range_Label.text       = @"--";
        mrp_Label.text         = @"--";
        salePrice_Label.text   = @"--";
        
        }
        
        hlcell.backgroundColor = [UIColor clearColor];
        hlcell.tag = indexPath.row;
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return hlcell;
    }
    
    else if (tableView == locationsTable){
        
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
            
            hlcell.textLabel.text = [locationsArr valueForKey:STORELOCATION][indexPath.row];
            hlcell.textLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont boldSystemFontOfSize:14.0f];
        } @catch (NSException *exception) {
            
        }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //dismissing teh catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
   
    if (tableView == currentOffersTable) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        isOffersSummary = true;
        
        // currentDealsTable.tag = indexPath.row;
        
        if (offerDetailsArray.count) {
            
            NSDictionary * detailsDic = offerDetailsArray[indexPath.row];
            
            [HUD setHidden:NO];
            
            HUD.labelText =  NSLocalizedString(@"please_wait..",nil);
            
            NSString * offerIdString;
            
            offerIdString = [NSString stringWithFormat:@"%@",detailsDic[@"offerID"]];
            
            [self getOffers:offerIdString];

        }
        else {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
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
            
            //categoryTxt.text = @"";
            
            subCategoryTxt.text = subCategoriesListArr[indexPath.row];
            
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
    else if(tableView == modelTable) {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            modelTable.tag = indexPath.row;
            
            modelTxt.text = modelListArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if (tableView == pagenationTbl){
        
        @try {
            
            offerIndex = 0;
            pagenationTxt.text = pagenationArr[indexPath.row];
            int pageValue = (pagenationTxt.text).intValue;
            offerIndex = offerIndex + (pageValue * 10) - 10;
            
        } @catch (NSException * exception) {
            
        }
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
        
        
    } @catch (NSException * exception) {
        
    } @finally {
        [tableName reloadData];
        
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
            
            if(searchOffersText.isEditing)
                yPosition = searchOffersText.frame.origin.y + searchOffersText.frame.size.height;
            
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
        
        NSLog(@"----exception in the stockReceiptView in removeAlertMessages----%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label----%@",exception);
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
    } @catch (NSException * exception) {
        
        return @"--";
        
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


#pragma mark Method which is in use to save offers Locally ...


// Commented by roja on 17/10/2019.. // reason :- offerServiceCall: method contains SOAP Service call .. so taken new method with same name(offerServiceCall:) method name which contains REST service call....
// At the time of converting SOAP call's to REST
//-(NSString *)offerServiceCall:(int)startIndex isDownloading:(BOOL)isDownloading  {
//
//    @try {
//        if (itemNameArray.count>0) {
//
//            [itemNameArray removeAllObjects];
//            [itemIDArray removeAllObjects];
//            [OfferPriceArray removeAllObjects];
//            [validFromArray removeAllObjects];
//            [validToArray removeAllObjects];
//            [giftSKUArray removeAllObjects];
//            [offerDesc removeAllObjects];
//            [minQtyArray removeAllObjects];
//        }
//
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//
//        OfferServiceSoapBinding * service = [OfferServiceSvc OfferServiceSoapBinding] ;
//
//        OfferServiceSvc_getOffer * aparams = [[OfferServiceSvc_getOffer alloc] init];
//
//
//        NSArray *loyaltyKeys = @[@"storeLocation",@"store_location",@"startIndex",@"requestHeader",LAST_SKU_PRICE_UPDATED_DATE,@"maxRecords"];
//
//        NSArray *loyaltyObjects;
//        // [defaults setValue:@"10/11/2016 00:00:00" forKey:@"lastOffersUpdated"];
//        // [defaults setValue:@"" forKey:@"lastOffersUpdated"];
//
//        if (startIndex == -1 || isDownloading) {
//            if ([[defaults valueForKey:@"lastOffersUpdated"] length] == 0) {
//                loyaltyObjects = @[presentLocation,presentLocation,[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader],@"",@"1000"];
//            }
//            else {
//                loyaltyObjects = @[presentLocation,presentLocation,[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader],@"",@"1000"];
//            }
//        }
//        else {
//            loyaltyObjects = @[presentLocation,presentLocation,[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader],@"",@"10"];
//        }
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err_];
//        NSString * getOffers = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        aparams.offerID = getOffers;
//
//        @try {
//            OfferServiceSoapBindingResponse *response = [service getOfferUsingParameters:aparams];
//            NSArray *responseBodyparts = response.bodyParts;
//
//            if (responseBodyparts != nil) {
//
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[OfferServiceSvc_getOfferResponse class]]) {
//                        OfferServiceSvc_getOfferResponse *body = (OfferServiceSvc_getOfferResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        if (!isSavingLocally) {
//
//                            [self getOfferDetailsHandler:body.return_];
//
//                        }
//                        else {
//                            return body.return_;
//                        }
//                    }
//                    else {
//
//                        return @"";
//                    }
//                }
//            }
//            else {
//
//                return @"";
//
//            }
//        }
//        @catch (NSException *exception) {
//
//            return @"";
//
//        }
//        @finally {
//            [HUD setHidden:YES];
//        }
//
//    } @catch (NSException *exception) {
//
//    } @finally {
//        [HUD setHidden:YES];
//
//    }
//}


//offerServiceCall: method changed by roja on 17/10/2019.. // reason :- removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(NSString *)offerServiceCall:(int)startIndex isDownloading:(BOOL)isDownloading  {
    
    @try {
        if (itemNameArray.count>0) {
            
            [itemNameArray removeAllObjects];
            [itemIDArray removeAllObjects];
            [OfferPriceArray removeAllObjects];
            [validFromArray removeAllObjects];
            [validToArray removeAllObjects];
            [giftSKUArray removeAllObjects];
            [offerDesc removeAllObjects];
            [minQtyArray removeAllObjects];
        }
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSArray *loyaltyKeys = @[@"storeLocation",@"store_location",@"startIndex",@"requestHeader",LAST_SKU_PRICE_UPDATED_DATE,@"maxRecords"];
        NSArray *loyaltyObjects;
        // [defaults setValue:@"10/11/2016 00:00:00" forKey:@"lastOffersUpdated"];
        // [defaults setValue:@"" forKey:@"lastOffersUpdated"];
        
        if (startIndex == -1 || isDownloading) {
            if ([[defaults valueForKey:@"lastOffersUpdated"] length] == 0) {
                loyaltyObjects = @[presentLocation,presentLocation,[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader],@"",@"1000"];
            }
            else {
                loyaltyObjects = @[presentLocation,presentLocation,[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader],@"",@"1000"];
            }
        }
        else {
            loyaltyObjects = @[presentLocation,presentLocation,[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader],@"",@"10"];
        }
        
        isSecondOfferServiceCal = true; // added by roja on 17/10/2019...

        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err_];
        NSString * getOffers = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        [HUD setHidden:NO];

        WebServiceController * services = [[WebServiceController alloc] init];
        services.offerMasterDelegate = self;
        [services getOffersDetails:getOffers];

    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
//        return @"";
    }
}



// Commented by roja on 17/10/2019... // Reason: As per Latest REST service call below method handling also changes..
// so, latest changes done in another method with same method name(getOfferDetailsHandler:)

// Handle the response from getDealDetails.

//- (void) getOfferDetailsHandler: (NSString *) value {
//
//    @try {
//        if([value isKindOfClass:[NSError class]]) {
//            //NSLog(@"%@", value);
//            return;
//        }
//
//        // Handle faults
//        //    if([value isKindOfClass:[SoapFault class]]) {
//        //        //NSLog(@"%@", value);
//        //        return;
//        //    }
//
//
//        [HUD setHidden:YES];
//
//        // Do something with the NSString* result
//        NSString* result = (NSString*)value;
//
//        NSError *e;
//        if (result != nil) {
//            NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
//                                                                  options: NSJSONReadingMutableContainers
//                                                                    error: &e];
//            NSArray *temp = JSON1[@"offerList"];
//
//            if (temp.count > 0) {
//
//                //                startLbl1.text = [NSString stringWithFormat:@"%d",(offerPageNo * 10) + 1];
//                //                endLbl1.text = [NSString stringWithFormat:@"%d",[startLbl1.text intValue] + (10 - 1)];
//                //                totalLbl1.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"totalRecords"]];
//
//                if ([NSString stringWithFormat:@"%@",JSON1[@"totalRecords"]].intValue <= 10) {
//                    //                    endLbl1.text = [NSString stringWithFormat:@"%d",[totalLbl1.text intValue]];
//                    //                    nextButton.enabled =  NO;
//                    //                    previousButton.enabled = NO;
//                    //                    firstPage1.enabled = NO;
//                    //                    lastPage1.enabled = NO;
//                }
////                else{
////
////                    if (changeNum12 == 0) {
////                        previousButton.enabled = NO;
////                        firstPage1.enabled = NO;
////                        nextButton.enabled = YES;
////                        lastPage1.enabled = YES;
////                    }
////                    else if (([[NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"totalRecords"]] intValue] - (10 * (changeNum12+1))) <= 0) {
////
////                        nextButton.enabled = NO;
////                        lastPage1.enabled = NO;
////                        endLbl1.text = totalLbl1.text;
////                    }
////                }
//
//                for (int i = 0; i < temp.count; i++) {
//                    NSDictionary *JSON = temp[i];
//
//                    //                NSArray *arr1 = [JSON valueForKey:@"offerImage"];
//                    //                if ([arr1 count]!=0) {
//                    //
//                    //                    unsigned c = [arr1 count];
//                    //                    uint8_t *bytes = (uint8_t *) malloc(sizeof(*bytes) * c);
//                    //
//                    //                    for (unsigned i = 0; i < c; i++)
//                    //                    {
//                    //                        NSString *str = [arr1 objectAtIndex:i];
//                    //                        int byte = [str intValue];
//                    //                        bytes[i] = byte;
//                    //                    }
//                    //                    NSData *data = [NSData dataWithBytesNoCopy:bytes length:c freeWhenDone:YES];
//                    //                    UIImage *banner_image = [UIImage imageWithData:data];
//                    //                    [dealImgArr addObject:banner_image];
//                    //                    // [image_arr addObject:[NSKeyedArchiver archivedDataWithRootObject:[dic valueForKey:@"dealImage"]]];
//                    //                }
//
//                    //                else {
//                    //
//                    //                    [dealImgArr addObject:[UIImage imageNamed:@"no-image.png"]];
//                    //
//                    //                }
//                    if ([JSON[@"offerName"] isKindOfClass:[NSNull class]] || JSON[@"offerName"] == nil) {
//                        [itemNameArray addObject:@"---"];
//                    }
//                    else{
//                        [itemNameArray addObject:JSON[@"offerName"]];
//                    }
//                    [itemIDArray addObject:JSON[@"offerID"]];
//                    [OfferPriceArray addObject:JSON[@"offerCategory"]];
//                    [validFromArray addObject:[JSON[@"offerStartDate"] componentsSeparatedByString:@" "][0]];
//                    [validToArray addObject:[JSON[@"offerEndDate"] componentsSeparatedByString:@" "][0]];
//                    //                [sellProductIdsArr addObject:[JSON objectForKey:@"sellProducts"]];
//                    //                [sellSkuIdsArr addObject:[JSON objectForKey:@"sellSkuids"]];
//                    // [dealSkuIds addObject:[JSON objectForKey:@"offerSkus"]];
//
//                    NSArray *arr = JSON[@"offerRangesList"];
//
//                    // for (int i=0; i<[arr count]; i++) {
//                    if (arr.count > 0) {
//                        NSDictionary *dic = arr[0];
//                        if ([JSON[@"description"] isKindOfClass:[NSNull class]] || JSON[@"description"] == nil) {
//                            [offerDesc addObject:@"---"];
//                        }
//                        else {
//                            [offerDesc addObject:[dic valueForKey:@"description"]];
//
//                        }
//                        [offerValues addObject:[dic valueForKey:@"rewardValue"]];
//                    }
//                    else{
//                        [offerDesc addObject:@"---"];
//                        [offerValues addObject:@"0.0"];
//                    }
//                    // }
//
//                    //    [minAmtArray addObject:[JSON objectForKey:@"minimumPurchaseAmount"]];
//                    //    [minQtyArray addObject:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"minimumPurchaseQuantity"]]];
//                    //[giftSKUArray addObject:[temp2 objectAtIndex:8]];
//                    //  [giftSKUArray addObject:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"cost"]]];  // this is for actual price.....
//                    //            }
//
//
//                }
//
//              //  [pastDealsTable reloadData];
//
//
//            }
//            else{
//
//
//                //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Currently No Deals To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                //            [alert show];
//
//                //scrollValueStatus = YES;
//
//                //nextButton.backgroundColor = [UIColor lightGrayColor];
//            }
//
//        }
//        else{
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Currently No Offers To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//
//    } @catch (NSException *exception) {
//
//    } @finally {
//
//    }
//    // Handle errors
//}


// getOfferDetailsHandler: method handling changed by roja on 17/10/2019... //  as per latest REST service call
- (void) getOfferDetailsHandler: (NSDictionary *) successResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        // Do something with the NSString* result
        
            NSArray *temp = successResponse[@"offerList"];
            
            if (temp.count > 0) {
                
                //                startLbl1.text = [NSString stringWithFormat:@"%d",(offerPageNo * 10) + 1];
                //                endLbl1.text = [NSString stringWithFormat:@"%d",[startLbl1.text intValue] + (10 - 1)];
                //                totalLbl1.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"totalRecords"]];
                
                if ([NSString stringWithFormat:@"%@",successResponse[@"totalRecords"]].intValue <= 10) {
                    //                    endLbl1.text = [NSString stringWithFormat:@"%d",[totalLbl1.text intValue]];
                    //                    nextButton.enabled =  NO;
                    //                    previousButton.enabled = NO;
                    //                    firstPage1.enabled = NO;
                    //                    lastPage1.enabled = NO;
                }
                //                else{
                //
                //                    if (changeNum12 == 0) {
                //                        previousButton.enabled = NO;
                //                        firstPage1.enabled = NO;
                //                        nextButton.enabled = YES;
                //                        lastPage1.enabled = YES;
                //                    }
                //                    else if (([[NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"totalRecords"]] intValue] - (10 * (changeNum12+1))) <= 0) {
                //
                //                        nextButton.enabled = NO;
                //                        lastPage1.enabled = NO;
                //                        endLbl1.text = totalLbl1.text;
                //                    }
                //                }
                
                for (int i = 0; i < temp.count; i++) {
                    NSDictionary *JSON = temp[i];
                    
                    //                NSArray *arr1 = [JSON valueForKey:@"offerImage"];
                    //                if ([arr1 count]!=0) {
                    //
                    //                    unsigned c = [arr1 count];
                    //                    uint8_t *bytes = (uint8_t *) malloc(sizeof(*bytes) * c);
                    //
                    //                    for (unsigned i = 0; i < c; i++)
                    //                    {
                    //                        NSString *str = [arr1 objectAtIndex:i];
                    //                        int byte = [str intValue];
                    //                        bytes[i] = byte;
                    //                    }
                    //                    NSData *data = [NSData dataWithBytesNoCopy:bytes length:c freeWhenDone:YES];
                    //                    UIImage *banner_image = [UIImage imageWithData:data];
                    //                    [dealImgArr addObject:banner_image];
                    //                    // [image_arr addObject:[NSKeyedArchiver archivedDataWithRootObject:[dic valueForKey:@"dealImage"]]];
                    //                }
                    
                    //                else {
                    //
                    //                    [dealImgArr addObject:[UIImage imageNamed:@"no-image.png"]];
                    //
                    //                }
                    if ([JSON[@"offerName"] isKindOfClass:[NSNull class]] || JSON[@"offerName"] == nil) {
                        [itemNameArray addObject:@"---"];
                    }
                    else{
                        [itemNameArray addObject:JSON[@"offerName"]];
                    }
                    [itemIDArray addObject:JSON[@"offerID"]];
                    [OfferPriceArray addObject:JSON[@"offerCategory"]];
                    [validFromArray addObject:[JSON[@"offerStartDate"] componentsSeparatedByString:@" "][0]];
                    [validToArray addObject:[JSON[@"offerEndDate"] componentsSeparatedByString:@" "][0]];
                    //                [sellProductIdsArr addObject:[JSON objectForKey:@"sellProducts"]];
                    //                [sellSkuIdsArr addObject:[JSON objectForKey:@"sellSkuids"]];
                    // [dealSkuIds addObject:[JSON objectForKey:@"offerSkus"]];
                    
                    NSArray *arr = JSON[@"offerRangesList"];
                    
                    // for (int i=0; i<[arr count]; i++) {
                    if (arr.count > 0) {
                        NSDictionary *dic = arr[0];
                        if ([JSON[@"description"] isKindOfClass:[NSNull class]] || JSON[@"description"] == nil) {
                            [offerDesc addObject:@"---"];
                        }
                        else {
                            [offerDesc addObject:[dic valueForKey:@"description"]];
                            
                        }
                        [offerValues addObject:[dic valueForKey:@"rewardValue"]];
                    }
                    else{
                        [offerDesc addObject:@"---"];
                        [offerValues addObject:@"0.0"];
                    }
                    // }
                    
                    //    [minAmtArray addObject:[JSON objectForKey:@"minimumPurchaseAmount"]];
                    //    [minQtyArray addObject:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"minimumPurchaseQuantity"]]];
                    //[giftSKUArray addObject:[temp2 objectAtIndex:8]];
                    //  [giftSKUArray addObject:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"cost"]]];  // this is for actual price.....
                    //            }
                    
                    
                }
                
                //  [pastDealsTable reloadData];
                
                
            }
            else{
                
                
                //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Currently No Deals To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //            [alert show];
                
                //scrollValueStatus = YES;
                
                //nextButton.backgroundColor = [UIColor lightGrayColor];
            }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    // Handle errors
}

@end





