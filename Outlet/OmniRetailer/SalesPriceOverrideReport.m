
//  SalesPriceOverrideReport.m
//  OmniRetailer
//  Created by TLMac on 9/15/17.


#import "SalesPriceOverrideReport.h"
#import "RequestHeader.h"
#import "OmniHomePage.h"

@interface SalesPriceOverrideReport ()

@end

@implementation SalesPriceOverrideReport

@synthesize soundFileURLRef,soundFileObject;

/*
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         07/08/2017
 * @method       ViewDidLoad
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    // here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource:@"tap" withExtension:@"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    // setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    
    // ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
     //Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    // Allocation of overrideReportview...
    
    overrideReportview = [[UIView alloc]init];
    
    /* Creation of UILabel for headerDisplay.......*/
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
    
    /*Creation of textField used in this page*/
    
    //Allocation of location Text...
    zoneTxt = [[CustomTextField alloc] init];
    zoneTxt.delegate = self;
    zoneTxt.userInteractionEnabled  = NO;
    zoneTxt.text = zone;
    zoneTxt.placeholder = NSLocalizedString(@"location", nil);
    [zoneTxt awakeFromNib];

    //Allocation of CounterTxt
    counterTxt = [[CustomTextField alloc] init];
    counterTxt.delegate = self;
    counterTxt.userInteractionEnabled  = NO;
    counterTxt.text = counterName;
    counterTxt.placeholder = NSLocalizedString(@"counter",nil);
    [counterTxt awakeFromNib];

    
    //Allocation of categoryTxt
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.delegate = self;
    categoryTxt.userInteractionEnabled  = NO;
    categoryTxt.placeholder = NSLocalizedString(@"category", nil);
    [categoryTxt awakeFromNib];
    
    //Allocation of subCategoryTxt
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.delegate = self;
    subCategoryTxt.userInteractionEnabled  = NO;
    subCategoryTxt.placeholder = NSLocalizedString(@"sub_category", nil);
    [subCategoryTxt awakeFromNib];
    
    //Allocation of departmentTxt
    departmentTxt = [[CustomTextField alloc] init];
    departmentTxt.delegate = self;
    departmentTxt.userInteractionEnabled  = NO;
    departmentTxt.placeholder = NSLocalizedString(@"department", nil);
    [departmentTxt awakeFromNib];
    
    //Allocation of subDepartmentTxt
    subDepartmentTxt = [[CustomTextField alloc] init];
    subDepartmentTxt.delegate = self;
    subDepartmentTxt.userInteractionEnabled  = NO;
    subDepartmentTxt.placeholder = NSLocalizedString(@"sub_department", nil);
    [subDepartmentTxt awakeFromNib];
    
 
    
    //Allocation of sectionTxt
    sectionTxt = [[CustomTextField alloc] init];
    sectionTxt.delegate = self;
    sectionTxt.userInteractionEnabled  = NO;
    sectionTxt.placeholder = NSLocalizedString(@"section",nil);
    [sectionTxt awakeFromNib];
    
    
    //Allocation of startDateTxt
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.delegate = self;
    startDateTxt.userInteractionEnabled  = NO;
    startDateTxt.placeholder = NSLocalizedString(@"start_date",nil);
    [startDateTxt awakeFromNib];
    
    //Allocation of endDateTxt
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.delegate = self;
    endDateTxt.userInteractionEnabled  = NO;
    endDateTxt.placeholder = NSLocalizedString(@"end_date",nil);
    [endDateTxt awakeFromNib];

    UIImage  * startDteImg;
    UIImage  * dropDown_img;
    UIButton * categoryBtn;
    UIButton * subCategoryBtn;
    UIButton * departmentBtn;
    UIButton * subDepartmentBtn;
    UIButton * sectionBtn;
    UIButton * startDteBtn;
    UIButton * endDteBtn;

    //Allocation of startDteImg
    startDteImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    //Allocation of dropDown_img
    dropDown_img  = [UIImage imageNamed:@"arrow_1.png"];

    
    // Allocation of CategoryBtn
    categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [categoryBtn addTarget:self
                    action:@selector(showAllCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of subCategoryBtn
    subCategoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subCategoryBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [subCategoryBtn addTarget:self
                       action:@selector(showAllSubCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
  
    //Allocation of departmentBtn
    departmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [departmentBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [departmentBtn addTarget:self
                      action:@selector(showDepartmentList:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of subDepartmentBtn
    subDepartmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [subDepartmentBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [subDepartmentBtn addTarget:self
                         action:@selector(showSubDepartmentList:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of subDepartmentBtn
    sectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sectionBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [sectionBtn addTarget:self
                         action:@selector(showSectionList:) forControlEvents:UIControlEventTouchDown];

    
    
    //Allocation of startDteBtn
    startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self
                    action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of endDteBtn
    endDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [endDteBtn addTarget:self
                  action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
   
    // used for identification purpose..
    startDteBtn.tag = 2;
    endDteBtn.tag = 4;

    UIButton * clearBtn;
    
    
    //Allocation of searchBtn
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self
                  action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.tag = 2;
    
    //Allocation of clearBtn
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    searchItemsTxt = [[CustomTextField alloc] init];
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

    
    
    //Allocation Of UIScrollView...
    overrideSalesScrollView = [[UIScrollView alloc]init];
    //overrideSalesScrollView.backgroundColor = [UIColor greenColor];

    // allocation Of CustomLabels...

    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    dateLbl = [[CustomLabel alloc] init];
    [dateLbl awakeFromNib];
    
    skuiDLbl = [[CustomLabel alloc] init];
    [skuiDLbl awakeFromNib];
    
    categoryLbl = [[CustomLabel alloc] init];
    [categoryLbl awakeFromNib];
    
    subCategoryLbl = [[CustomLabel alloc] init];
    [subCategoryLbl awakeFromNib];
    
    sectionLbl = [[CustomLabel alloc] init];
    [sectionLbl awakeFromNib];

    descriptionLbl = [[CustomLabel alloc] init];
    [descriptionLbl awakeFromNib];

    soldQtyLbl = [[CustomLabel alloc] init];
    [soldQtyLbl awakeFromNib];
  
    originalPriceLbl = [[CustomLabel alloc] init];
    [originalPriceLbl awakeFromNib];
    
    editedPriceLbl = [[CustomLabel alloc] init];
    [editedPriceLbl awakeFromNib];

    totalSaleCostLbl = [[CustomLabel alloc] init];
    [totalSaleCostLbl awakeFromNib];
    
    departmentLbl = [[CustomLabel alloc] init];
    [departmentLbl awakeFromNib];
    
    locationLbl = [[CustomLabel alloc] init];
    [locationLbl awakeFromNib];
    
    cashierNameLbl = [[CustomLabel alloc] init];
    [cashierNameLbl awakeFromNib];
    
    
    
    
    //Allocation Of UITableView....
    
    /** Create TableView */
    salesPriceOverrideTbl = [[UITableView alloc]init];
    salesPriceOverrideTbl.backgroundColor = [UIColor blackColor];
    salesPriceOverrideTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    salesPriceOverrideTbl.dataSource = self;
    salesPriceOverrideTbl.delegate = self;
    salesPriceOverrideTbl.bounces = TRUE;
    salesPriceOverrideTbl.separatorColor = [UIColor clearColor];

    //    Tables to show as popOver...
    
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
    
    
    //departmentListTbl creation...
    departmentListTbl = [[UITableView alloc] init];
    departmentListTbl.layer.borderWidth = 1.0;
    departmentListTbl.layer.cornerRadius = 4.0;
    departmentListTbl.layer.borderColor = [UIColor blackColor].CGColor;
    departmentListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    departmentListTbl.dataSource = self;
    departmentListTbl.delegate = self;
    
    //sectionTbl creation...
    sectionTbl = [[UITableView alloc] init];
    sectionTbl.layer.borderWidth = 1.0;
    sectionTbl.layer.cornerRadius = 4.0;
    sectionTbl.layer.borderColor = [UIColor blackColor].CGColor;
    sectionTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    sectionTbl.dataSource = self;
    sectionTbl.delegate = self;
    
    //Allocation of UIView....
    
    totalOverrideSalesView = [[UIView alloc]init];
    totalOverrideSalesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalOverrideSalesView.layer.borderWidth =3.0f;
    
    UILabel *totalQtyLbl;
    UILabel *totalPriceLbl;
    
    totalQtyLbl = [[UILabel alloc] init];
    totalQtyLbl.font = [UIFont systemFontOfSize:18.0f];
    totalQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalQtyLbl.layer.cornerRadius = 20.0f;
    totalQtyLbl.layer.masksToBounds = YES;
    totalQtyLbl.textAlignment = NSTextAlignmentLeft;

    totalPriceLbl = [[UILabel alloc] init];
    totalPriceLbl.font = [UIFont systemFontOfSize:18.0f];
    totalPriceLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalPriceLbl.layer.cornerRadius = 20.0f;
    totalQtyLbl.layer.masksToBounds = YES;
    totalPriceLbl.textAlignment = NSTextAlignmentLeft;

    totalQuantityValueLbl = [[UILabel alloc] init];
    totalQuantityValueLbl.font = [UIFont systemFontOfSize:20.0f];
    totalQuantityValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalQuantityValueLbl.layer.cornerRadius = 20.0f;
    totalQuantityValueLbl.layer.masksToBounds = YES;
    
    totalPriceValueLbl = [[UILabel alloc] init];
    totalPriceValueLbl.font = [UIFont systemFontOfSize:20.0f];
    totalPriceValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalPriceValueLbl.layer.cornerRadius = 20.0f;
    totalPriceValueLbl.layer.masksToBounds = YES;

  
    //Setting Intial Value as Zero...
    totalQuantityValueLbl.text = @"0.0";
    totalPriceValueLbl.text = @"0.0";
    
    //setting alignment for the  calculate value labels...
    
    totalQuantityValueLbl.textAlignment = NSTextAlignmentRight;
    totalPriceValueLbl.textAlignment = NSTextAlignmentRight;
    
    @try {
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        
         //calss Name for the headerNameLbl...
         headerNameLbl.text = NSLocalizedString(@"override_sales",nil);
        [goButton setTitle:NSLocalizedString(@"go",nil) forState:UIControlStateNormal];
        
        //Creation Of CustomLabels....
        
        snoLbl.text = NSLocalizedString(@"S_NO",nil);
        dateLbl.text = NSLocalizedString(@"date",nil);
        cashierNameLbl.text = NSLocalizedString(@"cashier_name",nil);
        categoryLbl.text = NSLocalizedString(@"category",nil);
        subCategoryLbl.text = NSLocalizedString(@"sub_category",nil);
        sectionLbl.text = NSLocalizedString(@"section",nil);
        departmentLbl.text = NSLocalizedString(@"department",nil);
        locationLbl.text = NSLocalizedString(@"location",nil);

        skuiDLbl.text = NSLocalizedString(@"sku_id",nil);
        descriptionLbl.text = NSLocalizedString(@"description",nil);
        soldQtyLbl.text = NSLocalizedString(@"sold_qty",nil);
        originalPriceLbl.text = NSLocalizedString(@"original_price",nil);
        editedPriceLbl.text = NSLocalizedString(@"edit_price",nil);
        totalSaleCostLbl.text = NSLocalizedString(@"total_sale_cost",nil);

        totalQtyLbl.text = NSLocalizedString(@"total_Qty",nil);
        totalPriceLbl.text = NSLocalizedString(@"total_price:",nil);
        
        // setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
       
        // setting place Holder of the UItextfield
        searchItemsTxt.placeholder = NSLocalizedString(@"search_here",nil);

    } @catch (NSException *exception) {
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
        }
        //setting for the overrideReportview....
        overrideReportview.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake(0,0,overrideReportview.frame.size.width,45);
        
        //Frame for the CustomTextFields....
        
        float textFieldWidth = 180;
        float textFieldHeight = 40;
        float labelHeight = 40;
        
        float verticalGap = 20;
        float horizontalGap = 20;

        
        // Frame for the categoryTxt
        zoneTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+verticalGap,textFieldWidth,textFieldHeight);
        
        categoryTxt.frame = CGRectMake(zoneTxt.frame.origin.x+zoneTxt.frame.size.width+horizontalGap, zoneTxt.frame.origin.y,textFieldWidth,textFieldHeight);

        departmentTxt.frame = CGRectMake(categoryTxt.frame.origin.x+categoryTxt.frame.size.width+horizontalGap, categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);

        
        startDateTxt.frame = CGRectMake(departmentTxt.frame.origin.x+departmentTxt.frame.size.width+horizontalGap, categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);

        
        
        counterTxt.frame = CGRectMake(zoneTxt.frame.origin.x, zoneTxt.frame.origin.y+zoneTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        
        subCategoryTxt.frame  = CGRectMake(categoryTxt.frame.origin.x,counterTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        sectionTxt.frame  = CGRectMake(departmentTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);

        endDateTxt.frame  = CGRectMake(startDateTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        

        //Frame for the categoryBtn
        categoryBtn.frame = CGRectMake((categoryTxt.frame.origin.x + categoryTxt.frame.size.width-45), categoryTxt.frame.origin.y-8,55,60);
        
        //Frame for the subCategoryBtn
        subCategoryBtn.frame = CGRectMake((subCategoryTxt.frame.origin.x+subCategoryTxt.frame.size.width-45), subCategoryTxt.frame.origin.y-8,55,60);
       
        //Frame for the departmentBtn
        departmentBtn.frame = CGRectMake((departmentTxt.frame.origin.x+departmentTxt.frame.size.width-45), departmentTxt.frame.origin.y-8,55,60);
        
        //Frame for the sectionBtn
        sectionBtn.frame = CGRectMake((sectionTxt.frame.origin.x+sectionTxt.frame.size.width-45), sectionTxt.frame.origin.y-8,55,60);
        
      
        //Frame for the startDteBtn...
        startDteBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-40), startDateTxt.frame.origin.y+2, 35, 30);
        
        //Frame for the endDateBtn...
        endDteBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-40), endDateTxt.frame.origin.y+2, 35, 30);
        
        searchBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap+60), categoryTxt.frame.origin.y,140,45);

        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x,subCategoryTxt.frame.origin.y,searchBtn.frame.size.width,searchBtn.frame.size.height);

        //frame for the UITextField..
        searchItemsTxt.frame = CGRectMake(zoneTxt.frame.origin.x,subCategoryTxt.frame.origin.y+subCategoryTxt.frame.size.height+verticalGap,searchBtn.frame.origin.x+searchBtn.frame.size.width-(zoneTxt.frame.origin.x),40);

      
        //Frame for the overrideScrollView...
        overrideSalesScrollView.frame = CGRectMake(10,searchItemsTxt.frame.origin.y+searchItemsTxt.frame.size.height+10,overrideReportview.frame.size.width+80,380);
        
        snoLbl.frame = CGRectMake(0, 0, 50,labelHeight);
        
        dateLbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width+2,snoLbl.frame.origin.y,90,labelHeight);
        
        cashierNameLbl.frame = CGRectMake(dateLbl.frame.origin.x+dateLbl.frame.size.width+2,snoLbl.frame.origin.y,110  ,labelHeight);
        
        categoryLbl.frame = CGRectMake(cashierNameLbl.frame.origin.x+cashierNameLbl.frame.size.width+2,snoLbl.frame.origin.y,100  ,labelHeight);

        subCategoryLbl.frame = CGRectMake(categoryLbl.frame.origin.x+categoryLbl.frame.size.width+2,snoLbl.frame.origin.y,100  ,labelHeight);

        sectionLbl.frame = CGRectMake(subCategoryLbl.frame.origin.x+subCategoryLbl.frame.size.width+2,snoLbl.frame.origin.y,100  ,labelHeight);

        departmentLbl.frame = CGRectMake(sectionLbl.frame.origin.x+sectionLbl.frame.size.width+2,snoLbl.frame.origin.y,90  ,labelHeight);

        locationLbl.frame = CGRectMake(departmentLbl.frame.origin.x+departmentLbl.frame.size.width+2,snoLbl.frame.origin.y,90  ,labelHeight);

        skuiDLbl.frame = CGRectMake(locationLbl.frame.origin.x+locationLbl.frame.size.width+2,snoLbl.frame.origin.y,70  ,labelHeight);
        
        descriptionLbl.frame = CGRectMake(skuiDLbl.frame.origin.x+skuiDLbl.frame.size.width+2,snoLbl.frame.origin.y,110  ,labelHeight);
        
        soldQtyLbl.frame = CGRectMake(descriptionLbl.frame.origin.x+descriptionLbl.frame.size.width+2,snoLbl.frame.origin.y,70  ,labelHeight);

        originalPriceLbl.frame = CGRectMake(soldQtyLbl.frame.origin.x+soldQtyLbl.frame.size.width+2,snoLbl.frame.origin.y,100  ,labelHeight);
        
        editedPriceLbl.frame = CGRectMake(originalPriceLbl.frame.origin.x+originalPriceLbl.frame.size.width+2,snoLbl.frame.origin.y,80  ,labelHeight);

        totalSaleCostLbl.frame = CGRectMake(editedPriceLbl.frame.origin.x+editedPriceLbl.frame.size.width+2,snoLbl.frame.origin.y,120  ,labelHeight);
        
        salesPriceOverrideTbl.frame = CGRectMake(snoLbl.frame.origin.x,snoLbl.frame.origin.y+snoLbl.frame.size.height+5,totalSaleCostLbl.frame.origin.x+totalSaleCostLbl.frame.size.width-(snoLbl.frame.origin.x),overrideSalesScrollView.frame.size.height-20);
        
        overrideSalesScrollView.contentSize = CGSizeMake(salesPriceOverrideTbl.frame.size.width+100,overrideSalesScrollView.frame.size.height);

        
        
        //Frame for the UIView...
        
        totalOverrideSalesView.frame = CGRectMake(overrideReportview.frame.size.width-300, overrideSalesScrollView.frame.origin.y+overrideSalesScrollView.frame.size.height+10,300,60);
        
         //Frames for the UILabels under the totalInventoryView....
        
        totalQtyLbl.frame = CGRectMake(5,0,180,40);
        totalPriceLbl.frame = CGRectMake(totalQtyLbl.frame.origin.x,totalQtyLbl.frame.origin.y+totalQtyLbl.frame.size.height-15,totalQtyLbl.frame.size.width,totalQtyLbl.frame.size.height);
        
        totalQuantityValueLbl.frame = CGRectMake(totalQtyLbl.frame.origin.x+totalQtyLbl.frame.size.width-10,totalQtyLbl.frame.origin.y,120,totalQtyLbl.frame.size.height);
        
        totalPriceValueLbl.frame = CGRectMake(totalQuantityValueLbl.frame.origin.x,totalPriceLbl.frame.origin.y,totalQuantityValueLbl.frame.size.width,totalPriceLbl.frame.size.height);
    }
    
    //Adding sub Views For the overrideReportview
    [overrideReportview addSubview:headerNameLbl];
    
    [overrideReportview addSubview:zoneTxt];
    [overrideReportview addSubview:counterTxt];

    [overrideReportview addSubview:categoryTxt];
    [overrideReportview addSubview:subCategoryTxt];
    
    [overrideReportview addSubview:sectionTxt];
    [overrideReportview addSubview:departmentTxt];
    
    [overrideReportview addSubview:startDateTxt];
    [overrideReportview addSubview:endDateTxt];
    
    
    [overrideReportview addSubview:categoryBtn];
    [overrideReportview addSubview:subCategoryBtn];
    [overrideReportview addSubview:departmentBtn];
    [overrideReportview addSubview:sectionBtn];
    [overrideReportview addSubview:startDteBtn];
    [overrideReportview addSubview:endDteBtn];
    
    [overrideReportview addSubview:searchBtn];
    [overrideReportview addSubview:clearBtn];
    
    [overrideReportview addSubview:searchItemsTxt];

    
    
    //[overrideReportview addSubview:goButton];
    
    //Adding the ScrollView to the overrideReportView.....
    
    [overrideReportview addSubview:overrideSalesScrollView];
    
    [overrideSalesScrollView addSubview:snoLbl];
    [overrideSalesScrollView addSubview:dateLbl];
    [overrideSalesScrollView addSubview:cashierNameLbl];
    [overrideSalesScrollView addSubview:categoryLbl];
    [overrideSalesScrollView addSubview:subCategoryLbl];
    [overrideSalesScrollView addSubview:sectionLbl];
    [overrideSalesScrollView addSubview:departmentLbl];
    [overrideSalesScrollView addSubview:locationLbl];

    [overrideSalesScrollView addSubview:skuiDLbl];
    [overrideSalesScrollView addSubview:descriptionLbl];
    [overrideSalesScrollView addSubview:soldQtyLbl];
    [overrideSalesScrollView addSubview:originalPriceLbl];
    [overrideSalesScrollView addSubview:editedPriceLbl];
    [overrideSalesScrollView addSubview:totalSaleCostLbl];
    
    [overrideSalesScrollView addSubview:salesPriceOverrideTbl];
    
    [overrideReportview addSubview:totalOverrideSalesView];
    
    [totalOverrideSalesView addSubview:totalQtyLbl];
    [totalOverrideSalesView addSubview:totalPriceLbl];
    [totalOverrideSalesView addSubview:totalQuantityValueLbl];
    [totalOverrideSalesView addSubview:totalPriceValueLbl];
    
    //Adding categoryWiseReportView For the self.view
    [self.view addSubview:overrideReportview];

    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:15.0f cornerRadius:0];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        goButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];

    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  EXecuted after the VeiwDidLoad Execution
 * @date         15/09/2017..
 * @method       viewDidAppear
 * @author       Bhargav.v
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
    @try {
        startIndexInt = 0;
        totalNumberOfReports = 0;
        overrideSalesArr = [NSMutableArray new];
        [self getSalesOverrideReports];

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Dispose of any resources that can be recreated
 * @date         15/09/2017
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
 * @description  we are sending the request in this method to get the data from the DB
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

-(void)getSalesOverrideReports {
    
    @try {
        
        [HUD setHidden:NO];
        
        if( overrideSalesArr == nil && startIndexInt == 0){
            
            overrideSalesArr = [NSMutableArray new];
        }
        else if(startIndexInt == 0 &&  overrideSalesArr.count ){
            
            [overrideSalesArr removeAllObjects];
        }
        
        NSString * startDteStr = startDateTxt.text;
        
        if((startDateTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDateTxt.text,@" 00:00:00"];
        
        NSString *  endDteStr  = endDateTxt.text;
        
        if ((endDateTxt.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        }
        
        NSString * counterStr       = counterTxt.text;
        NSString * categoryStr      = categoryTxt.text;
        NSString * subCategoryStr   = subCategoryTxt.text;
        NSString * departmentStr    = departmentTxt.text;
        NSString * sectionStr       = sectionTxt.text;
        NSString * searchStr        = searchItemsTxt.text;
        
        NSMutableDictionary * overrideSalesDic = [[NSMutableDictionary alloc] init];
        
        [overrideSalesDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [overrideSalesDic setValue:presentLocation forKey:STORE_LOCATION];
        [overrideSalesDic setValue:counterStr forKey:COUNTER];
        [overrideSalesDic setValue:[NSString stringWithFormat:@"%d",startIndexInt] forKey:START_INDEX];
        [overrideSalesDic setValue:[NSString stringWithFormat:@"%d",10] forKey:kMaxRecords];
        [overrideSalesDic setValue:[NSNumber numberWithBool:false] forKey:IS_SAVE_REPORT];
  
        if(searchBtn.tag == 2){
            categoryStr      = @"";
            subCategoryStr   = @"";
            departmentStr    = @"";
            sectionStr       = @"";
            startDteStr      = @"";
            endDteStr        = @"";
        }

        [overrideSalesDic setValue:categoryStr forKey:kCategoryName];
        [overrideSalesDic setValue:subCategoryStr forKey:kSubCategory];
        [overrideSalesDic setValue:departmentStr forKey:kItemDept];
        [overrideSalesDic setValue:sectionStr forKey:SECTION];
        [overrideSalesDic setValue:searchStr forKey:SEARCH_CRITERIA];
        overrideSalesDic[kStartDate] = startDteStr;
        overrideSalesDic[END_DATE] = endDteStr;

        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:overrideSalesDic options:0 error:&err];
        NSString * overrideSalesJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        // NSLog(@"%@--json product Categories String--",overrideSalesJsonStr);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.salesServiceDelegate = self;
        [webServiceController getOverrideSales:overrideSalesJsonStr];

        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  We Are Fetching the Data which is retrieved from the DB
 * @date         15/08/2017
 * @method       getSalesPriceOverrideReportSuccessReponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getSalesPriceOverrideReportSuccessReponse:(NSDictionary *)successDictionary {
    
    @try {
        
        
        totalNumberOfReports= [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"]intValue];

        
        if (successDictionary.count) {
            
            for (NSDictionary * overrideSalesDic in [successDictionary valueForKey:@"reportsList"]) {
                
                [overrideSalesArr addObject:overrideSalesDic];
            }
            
            
            totalQuantityValueLbl.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[[successDictionary valueForKey:@"categorySummery"]valueForKey:@"totalQuantity"] defaultReturn:@"0.00"] floatValue] + (totalQuantityValueLbl.text).floatValue)];
            
            totalPriceValueLbl.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[[successDictionary valueForKey:@"categorySummery"]valueForKey:@"totalPrice"] defaultReturn:@"0.00"] floatValue] + (totalPriceValueLbl.text).floatValue)];
            
            
        }
        
    } @catch (NSException * exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [salesPriceOverrideTbl reloadData];
    }
}


/**
 * @description  description
 * @date         date
 * @method       name
 * @author       Bhargav.v
 * @param        param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getSalesPriceOverrideReportErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        if (startIndexInt == 0 &&  (!overrideSalesArr.count)) {
            
            totalQuantityValueLbl.text = @"0.00";
            totalPriceValueLbl.text = @"0.00";
            
            [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    } @catch (NSException *exception) {
        
    } @finally {

        [HUD setHidden:YES];
        [salesPriceOverrideTbl reloadData];
    }
}


#pragma mark Service Calls For the Filters...

/**
 * @description  here we are calling the getCategories services.....
 * @date         08/08/2017
 * @method       callingCategoriesList
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingCategories:(NSString *)categoryName{
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        
        if(categoriesListTbl.tag == 2 )
            categoriesListArr = [NSMutableArray new];
        else
            subCategoriesListArr = [NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,@"categoryName",SL_NO,@"flag"];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,categoryName,[NSNumber numberWithBool:true],EMPTY_STRING];
        
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * departmentJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getProductCategory:departmentJsonString];
        
    }
    @catch (NSException * exception) {
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
        
        departmentArr = [NSMutableArray new];
//        dept_SubDeptDic = [NSMutableDictionary new];
        
        NSArray * keys = @[REQUEST_HEADER,START_INDEX,@"noOfSubDepartments",@"slNo"];
        NSArray * objects = @[[RequestHeader getRequestHeader],@"-1",[NSNumber numberWithBool:true],[NSNumber numberWithBool:true]];
        
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
 * @description   here we are calling the sections from SubCategories services.....
 * @date         09/08/2017
 * @method       callingSectionList
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
        
        [sectionDic setValue:subCatStr forKey:kSubCategoryName];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:sectionDic options:0 error:&err];
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





#pragma mark Service Call Response..

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
        
        for (NSDictionary * categoryDic in  [sucessDictionary valueForKey:@"categories"]){
            
            if(categoriesListTbl.tag == 2){
                
                [categoriesListArr addObject:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:@"categoryName"]  defaultReturn:@""]];
            }
            else{
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
        float y_axis = self.view.frame.size.height - 350;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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
 *
 */

-(void)getDepartmentSuccessResponse:(NSDictionary*)sucessDictionary{
    
    @try   {
        
        if ((departmentTxt.text).length == 0) {
            
            for (NSDictionary * department in  [sucessDictionary valueForKey:kDepartments])
                [departmentArr addObject:department];
            
        }
//        else  if ([departmentTxt.text length] > 0){
//            for (NSDictionary * department in  [sucessDictionary valueForKey:kDepartments]) {
//                
//                
//                NSMutableArray *subDepartment = [NSMutableArray new];
//                for (NSDictionary * primary in [department valueForKey:SECONDARY_DEPARTMENTS]) {
//                    [subDepartment addObject:[primary valueForKey:SECONDARY_DEPARTMENT]];
//                    [subDepartmentArr addObject:[primary valueForKey:SECONDARY_DEPARTMENT]];
//                }
//            }
//        }
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
        float y_axis = self.view.frame.size.height - 350;
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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

-(BOOL)getProductSubCategoriesSuccessResponse:(NSDictionary*)successDictionary {
    
    @try {
        
        for (NSDictionary * sectionDic in  [[successDictionary valueForKey:PRODUCT_DETAILS]valueForKey:SUB_CATEGORYSECTIONS]) {
            
            if (sectionDic!= nil) {
                [sectionArr addObject:[self checkGivenValueIsNullOrNil:[sectionDic valueForKey:SECTION_NAME][0] defaultReturn:@"0.00"]];
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
        float y_axis = self.view.frame.size.height - 350;
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return false;
}



#pragma mark Actions yet to implement...

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
            [self callingCategories:@""];
            
        }
        
        [HUD setHidden:YES];
        
        
        if(categoriesListArr.count == 0){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        
        
        float tableHeight = categoriesListArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = categoriesListArr.count * 33;
        
        if(categoriesListArr.count > 5)
            tableHeight =(tableHeight/categoriesListArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:categoryTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:overrideReportview permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert",nil),@"\n",NSLocalizedString(@"please_select_category_first",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        if((subCategoriesListArr == nil) || (subCategoriesListArr.count == 0)){
            
            //for identification....
            categoriesListTbl.tag = 4;
            subCategoriesListTbl.tag = 2;
            [self callingCategories:categoryTxt.text];
        }
        
        [HUD setHidden:YES];
        
        if(subCategoriesListArr.count == 0){
            
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = subCategoriesListArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoriesListArr.count * 33;
        
        if(subCategoriesListArr.count > 5)
            tableHeight = (tableHeight/subCategoriesListArr.count)*5;
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:subCategoryTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:overrideReportview permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
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

-(void)showDepartmentList:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((departmentArr == nil) || (departmentArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self callingDepartmentList];
            
        }
        
        [HUD setHidden:YES];
        
        if(departmentArr.count == 0){
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        
        float tableHeight = departmentArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = departmentArr.count * 33;
        
        if(departmentArr.count > 5)
            tableHeight = (tableHeight/departmentArr.count) * 5;
        
        [self showPopUpForTables:departmentListTbl  popUpWidth:departmentTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:departmentTxt  showViewIn:overrideReportview permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        
        if((sectionArr == nil) || (sectionArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self callingSectionFromSubCategories];
        }
        [HUD setHidden:YES];
        
        if(sectionArr.count == 0){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = sectionArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = sectionArr.count * 33;
        
        if(sectionArr.count > 5)
            tableHeight = (tableHeight/sectionArr.count) * 5;
        
        [self showPopUpForTables:sectionTbl  popUpWidth:sectionTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:sectionTxt  showViewIn:overrideReportview permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}



#pragma TextField Delegates...
/**
 * @description
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

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchItemsTxt ) {
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                startIndexInt = 0;
                overrideSalesArr = [NSMutableArray new];
                [self getSalesOverrideReports];
                
                
            } @catch (NSException *exception) {
                NSLog(@"---- exception while calling ServicesCall ----%@",exception);
                
            } @finally {
                
            }
        }
        else if ((searchItemsTxt.text).length == 0){
            startIndexInt = 0;
            overrideSalesArr = [NSMutableArray new];
            [self getSalesOverrideReports];
        }
        
    }
}



/** Table Implementation */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == salesPriceOverrideTbl) {
        if (overrideSalesArr.count)
            
            return overrideSalesArr.count;
        else
            return 1;
    }
    else if(tableView == categoriesListTbl){
        
        return  categoriesListArr.count;
    }
    else if(tableView == subCategoriesListTbl){
        
        return subCategoriesListArr.count;
        
    }
    else if(tableView == departmentListTbl){
        
        return departmentArr.count;
    }
    else if(tableView == sectionTbl){
        
        return sectionArr.count;
    }
    
    
     return 0;
}

//Customize HeightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(tableView == salesPriceOverrideTbl){
        
        return 45;
        
    }
    else if (tableView == categoriesListTbl|| tableView == subCategoriesListTbl||tableView == departmentListTbl ||tableView == sectionTbl ){
        
        return 45.0;
    }

    
    
    return 0.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == salesPriceOverrideTbl){
        
        
        static NSString * hlCellID = @"hlCellID";
        
        UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
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
        tableView.separatorColor = [UIColor clearColor];
 
        
        @try {
            
            UILabel * sno_Lbl;
            UILabel * date_Lbl;
            UILabel * cashierName_Lbl;
            UILabel * categoryName_Lbl;
            UILabel * subcategoryName_Lbl;
            UILabel * section_Lbl;
            UILabel * department_Lbl;
            UILabel * location_Lbl;

            UILabel * skuid_Lbl;
            UILabel * description_Lbl;
            UILabel * soldQty_Lbl;
            UILabel * originalPrice_Lbl;
            UILabel * editPrice_Lbl;
            UILabel * totalSaleCost_Lbl;
            
            /*Creation of UILabels used in this cell*/
            sno_Lbl = [[UILabel alloc] init];
            sno_Lbl.backgroundColor = [UIColor clearColor];
            sno_Lbl.textAlignment = NSTextAlignmentCenter;
            sno_Lbl.numberOfLines = 1;
            sno_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            date_Lbl = [[UILabel alloc] init];
            date_Lbl.backgroundColor = [UIColor clearColor];
            date_Lbl.textAlignment = NSTextAlignmentCenter;
            date_Lbl.numberOfLines = 1;
            date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            cashierName_Lbl = [[UILabel alloc] init];
            cashierName_Lbl.backgroundColor = [UIColor clearColor];
            cashierName_Lbl.textAlignment = NSTextAlignmentCenter;
            cashierName_Lbl.numberOfLines = 1;
            cashierName_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            categoryName_Lbl = [[UILabel alloc] init];
            categoryName_Lbl.backgroundColor = [UIColor clearColor];
            categoryName_Lbl.textAlignment = NSTextAlignmentCenter;
            categoryName_Lbl.numberOfLines = 1;
            categoryName_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            subcategoryName_Lbl = [[UILabel alloc] init];
            subcategoryName_Lbl.backgroundColor = [UIColor clearColor];
            subcategoryName_Lbl.textAlignment = NSTextAlignmentCenter;
            subcategoryName_Lbl.numberOfLines = 1;
            subcategoryName_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            section_Lbl = [[UILabel alloc] init];
            section_Lbl.backgroundColor = [UIColor clearColor];
            section_Lbl.textAlignment = NSTextAlignmentCenter;
            section_Lbl.numberOfLines = 1;
            section_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            department_Lbl = [[UILabel alloc] init];
            department_Lbl.backgroundColor = [UIColor clearColor];
            department_Lbl.textAlignment = NSTextAlignmentCenter;
            department_Lbl.numberOfLines = 1;
            department_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            location_Lbl = [[UILabel alloc] init];
            location_Lbl.backgroundColor = [UIColor clearColor];
            location_Lbl.textAlignment = NSTextAlignmentCenter;
            location_Lbl.numberOfLines = 1;
            location_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            skuid_Lbl = [[UILabel alloc] init];
            skuid_Lbl.backgroundColor = [UIColor clearColor];
            skuid_Lbl.textAlignment = NSTextAlignmentCenter;
            skuid_Lbl.numberOfLines = 1;
            skuid_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            description_Lbl = [[UILabel alloc] init];
            description_Lbl.backgroundColor = [UIColor clearColor];
            description_Lbl.textAlignment = NSTextAlignmentCenter;
            description_Lbl.numberOfLines = 1;
            description_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            soldQty_Lbl = [[UILabel alloc] init];
            soldQty_Lbl.backgroundColor = [UIColor clearColor];
            soldQty_Lbl.textAlignment = NSTextAlignmentCenter;
            soldQty_Lbl.numberOfLines = 1;
            soldQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            originalPrice_Lbl = [[UILabel alloc] init];
            originalPrice_Lbl.backgroundColor = [UIColor clearColor];
            originalPrice_Lbl.textAlignment = NSTextAlignmentCenter;
            originalPrice_Lbl.numberOfLines = 1;
            originalPrice_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            editPrice_Lbl = [[UILabel alloc] init];
            editPrice_Lbl.backgroundColor = [UIColor clearColor];
            editPrice_Lbl.textAlignment = NSTextAlignmentCenter;
            editPrice_Lbl.numberOfLines = 1;
            editPrice_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
           
            totalSaleCost_Lbl = [[UILabel alloc] init];
            totalSaleCost_Lbl.backgroundColor = [UIColor clearColor];
            totalSaleCost_Lbl.textAlignment = NSTextAlignmentCenter;
            totalSaleCost_Lbl.numberOfLines = 1;
            totalSaleCost_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            
            sno_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            cashierName_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            categoryName_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            subcategoryName_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            section_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            department_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            location_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

            skuid_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            description_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            soldQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            originalPrice_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            editPrice_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            totalSaleCost_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

            
            [hlcell.contentView addSubview:sno_Lbl];
            [hlcell.contentView addSubview:date_Lbl];
            [hlcell.contentView addSubview:cashierName_Lbl];
            [hlcell.contentView addSubview:categoryName_Lbl];
            [hlcell.contentView addSubview:subcategoryName_Lbl];
            [hlcell.contentView addSubview:section_Lbl];
            [hlcell.contentView addSubview:department_Lbl];
            [hlcell.contentView addSubview:location_Lbl];

            [hlcell.contentView addSubview:skuid_Lbl];
            [hlcell.contentView addSubview:description_Lbl];
            [hlcell.contentView addSubview:soldQty_Lbl];
            [hlcell.contentView addSubview:originalPrice_Lbl];
            [hlcell.contentView addSubview:editPrice_Lbl];
            [hlcell.contentView addSubview:totalSaleCost_Lbl];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                sno_Lbl.frame = CGRectMake(0,0,snoLbl.frame.size.width,hlcell.frame.size.height);
               
                date_Lbl.frame = CGRectMake(dateLbl.frame.origin.x,0,dateLbl.frame.size.width,hlcell.frame.size.height);
                
                cashierName_Lbl.frame = CGRectMake(cashierNameLbl.frame.origin.x,0,cashierNameLbl.frame.size.width,hlcell.frame.size.height);
                
                categoryName_Lbl.frame = CGRectMake(categoryLbl.frame.origin.x,0,categoryLbl.frame.size.width,hlcell.frame.size.height);

                subcategoryName_Lbl.frame = CGRectMake(subCategoryLbl.frame.origin.x,0,subCategoryLbl.frame.size.width,hlcell.frame.size.height);
                
                section_Lbl.frame = CGRectMake(sectionLbl.frame.origin.x,0,sectionLbl.frame.size.width,hlcell.frame.size.height);

                department_Lbl.frame = CGRectMake(departmentLbl.frame.origin.x,0,departmentLbl.frame.size.width,hlcell.frame.size.height);
                
                location_Lbl.frame = CGRectMake(locationLbl.frame.origin.x,0,locationLbl.frame.size.width,hlcell.frame.size.height);

                skuid_Lbl.frame = CGRectMake(skuiDLbl.frame.origin.x,0,skuiDLbl.frame.size.width,hlcell.frame.size.height);

                description_Lbl.frame = CGRectMake(descriptionLbl.frame.origin.x,0,descriptionLbl.frame.size.width,hlcell.frame.size.height);
                
                soldQty_Lbl.frame = CGRectMake(soldQtyLbl.frame.origin.x,0,soldQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                originalPrice_Lbl.frame = CGRectMake(originalPriceLbl.frame.origin.x,0,originalPriceLbl.frame.size.width,hlcell.frame.size.height);

                editPrice_Lbl.frame = CGRectMake(editedPriceLbl.frame.origin.x,0,editedPriceLbl.frame.size.width,hlcell.frame.size.height);
                
                totalSaleCost_Lbl.frame = CGRectMake(totalSaleCostLbl.frame.origin.x,0,totalSaleCostLbl.frame.size.width,hlcell.frame.size.height);

            }
            
            else{
                
                //Code for iPhone...
                
            }
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];

            //appending values based on the service data...
            
            if (overrideSalesArr.count >= indexPath.row && overrideSalesArr.count) {
                
                NSDictionary * dic  = overrideSalesArr[indexPath.row];
                
                sno_Lbl.text = [NSString stringWithFormat:@"%d",(indexPath.row+1)];
                
                date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:@"date"] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];

                cashierName_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:CASHIER_NAME] defaultReturn:@"--"];
                
                categoryName_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];

                subcategoryName_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kSubCategory] defaultReturn:@"--"];
                
                section_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SECTION] defaultReturn:@"--"];
                
                department_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kItemDept] defaultReturn:@"--"];

                location_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:LOCATION] defaultReturn:@"--"];

                
                skuid_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@"--"];//ITEM_SKU

                description_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESC] defaultReturn:@"--"];//ITEM_DESC
                
                soldQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                originalPrice_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:@"mrp"] defaultReturn:@"0.00"] floatValue]];

                editPrice_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:@"editedprice"] defaultReturn:@"0.00"] floatValue]];

                totalSaleCost_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:@"price"] defaultReturn:@"0.00"] floatValue]];
               
            }
            
            else{
                
                sno_Lbl.text = @"--";
                date_Lbl.text = @"--";
                cashierName_Lbl.text = @"--";
                categoryName_Lbl.text = @"--";
                subcategoryName_Lbl.text = @"--";
                section_Lbl.text = @"--";
                department_Lbl.text = @"--";
                location_Lbl.text = @"--";
                skuid_Lbl.text = @"--";
                description_Lbl.text = @"--";
                soldQty_Lbl.text = @"--";
                originalPrice_Lbl.text = @"--";
                editPrice_Lbl.text = @"--";
                totalSaleCost_Lbl.text = @"--";
            }

        } @catch (NSException *exception) {
            
        } @finally {
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;

        }
        
    }
    else if(tableView == categoriesListTbl){
        
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
            hlcell.textLabel.text = categoriesListArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            hlcell.textLabel.numberOfLines = 2;
            hlcell.textLabel.text = subCategoriesListArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    
    else if (tableView == departmentListTbl){
        @try {
            static NSString *CellIdentifier = @"Cell";
            
            UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (hlcell == nil) {
                hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                hlcell.frame = CGRectZero;
            }
            if ((hlcell.contentView).subviews){
                for (UIView *subview in (hlcell.contentView).subviews){
                    [subview removeFromSuperview];
                }
            }
            
            hlcell.textLabel.text = [departmentArr[indexPath.row] valueForKey:kPrimaryDepartment];
            hlcell.textLabel.font =  [UIFont fontWithName:kLabelFont size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    
    else if (tableView == sectionTbl){
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
            
            //  hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = sectionArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:kLabelFont size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //dismissing teh catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
  
    if(tableView == categoriesListTbl){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        @try {
            
            categoryTxt.text = categoriesListArr[indexPath.row];
            subCategoryTxt.text = @"";
            
            if(subCategoriesListArr.count && subCategoriesListArr  != nil)
                [subCategoriesListArr removeAllObjects];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else if(tableView == subCategoriesListTbl){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        subCategoryTxt.text = subCategoriesListArr[indexPath.row];
    }
    else if (tableView == departmentListTbl) {
        
        departmentTxt.text = [departmentArr[indexPath.row] valueForKey:kPrimaryDepartment];
    }
    else if (tableView == sectionTbl) {
        
        sectionTxt.text = sectionArr[indexPath.row];
    }

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        
        if(tableView == salesPriceOverrideTbl){
            
            @try {
                
                if ((indexPath.row == (overrideSalesArr.count-1)) && (overrideSalesArr.count < totalNumberOfReports) && (overrideSalesArr.count> startIndexInt)) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    startIndexInt = startIndexInt +10;
                    [self getSalesOverrideReports];
                }
                
            } @catch (NSException * exception) {
                NSLog(@"-----------exception in servicecall-------------%@",exception);
                [HUD setHidden:YES];
            }
        }
    } @catch (NSException *exception) {
        
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
            
            pickView.frame = CGRectMake(15,startDateTxt.frame.origin.y+startDateTxt.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:overrideReportview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:overrideReportview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
    
    //    BOOL callServices = false;
    
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
 */

-(IBAction)getDate:(UIButton*)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter * requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate * existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if(sender.tag == 2){
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDateTxt.text = @"";
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_endDate", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            startDateTxt.text = dateString;
        }
        else{
            
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDateTxt.text = @"";
                    
                    [self displayAlertMessage:NSLocalizedString(@"closed_date_should_not_be_earlier_than_created_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
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
 * @description  goButton is the method used to make service call through sending date strings for filteers...
 * @date         12/08/2017
 * @method       goButtonClicked
 * @author       Bhargav.v
 * @param        sender
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)goButtonPressed:(UIButton*)sender {
    
    startIndexInt = 0;
    overrideSalesArr = [NSMutableArray new];
    [self getSalesOverrideReports];
}


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
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0  && (sectionTxt.text).length == 0 && (startDateTxt.text).length == 0 && (endDateTxt.text).length== 0 && (departmentTxt.text).length== 0 && (subDepartmentTxt.text).length== 0) {
            
            float y_axis = self.view.frame.size.height-200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert",nil),@"\n",NSLocalizedString(@"Please select above fields before proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        else
            [HUD setHidden:NO];
        startIndexInt = 0;
        overrideSalesArr = [NSMutableArray new];
        [self getSalesOverrideReports];
        
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
        departmentTxt.text    = @"";
        subDepartmentTxt.text = @"";
        startDateTxt.text     = @"";
        endDateTxt.text       = @"";
        sectionTxt.text       = @"";
        
        startIndexInt = 0;
        
        [self getSalesOverrideReports];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception  viewWillDisappear------%@",exception);
        NSLog(@"--exception is-----%@",exception);
        
    } @finally {
        
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
    
    
    //    [self displayAlertMessage: @"No Products Avaliable" horizontialAxis:segmentedControl.frame.origin.x   verticalAxis:segmentedControl.frame.origin.y  msgType:@"warning" timming:2.0];
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
        userAlertMessageLbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
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
            userAlertMessageLbl.textColor = [UIColor redColor];
            
            if(soundStatus){
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
        }
        else{
            if (version > 8.0) {
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35,200,30);
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
            }
            else{
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                userAlertMessageLbl.frame = CGRectMake(xPostion+75, yPosition-35,200,30);
            }
        }
        [self.view addSubview:userAlertMessageLbl];
        fadOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
    }
    @catch (NSException * exception) {
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
        
        if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
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
    
#pragma -mark super class methods

/**
 * @description  Navigating back to home page...
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

-(void)homeButonClicked{
    
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
