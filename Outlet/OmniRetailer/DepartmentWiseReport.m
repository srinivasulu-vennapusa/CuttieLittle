
//  DepartmentWiseReport.m
//  OmniRetailer
//  Created by Bhargav.v on 9/22/17.

#import "DepartmentWiseReport.h"
#import "SkuWiseReport.h"
#import "Global.h"
#import "OmniHomePage.h"
#import "SalesReports.h"

@interface DepartmentWiseReport ()

@end

@implementation DepartmentWiseReport

@synthesize soundFileURLRef,soundFileObject;

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         25/09/2017
 * @method       viewDidLoad
 * @author       Bhargav.v
 * @param         
 * @param
 * @return
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
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource:@"tap" withExtension:@"aif"];
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

    
    //    [HUD show:YES];
//    [HUD setHidden:NO];
    
    //Allocation of Category Report View...
    
    departmentWiseReportView = [[UIView alloc]init];
    
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
    
    /*Creation of textField used in this page*/
    
    
    //Allocation of zoneTxt
    zoneTxt = [[CustomTextField alloc] init];
    zoneTxt.delegate = self;
    zoneTxt.userInteractionEnabled  = NO;
    zoneTxt.text = zone;
    zoneTxt.placeholder = NSLocalizedString(@"zone",nil);
    [zoneTxt awakeFromNib];

    //Allocation of zoneTxt
    locationTxt = [[CustomTextField alloc] init];
    locationTxt.delegate = self;
    locationTxt.userInteractionEnabled  = NO;
    locationTxt.text = presentLocation;
    locationTxt.placeholder = NSLocalizedString(@"location",nil);
    [locationTxt awakeFromNib];

    
    
    //Allocation of categoryTxt
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.delegate = self;
    categoryTxt.userInteractionEnabled  = NO;
    categoryTxt.placeholder = NSLocalizedString(@"category",nil);
    [categoryTxt awakeFromNib];
    
    //Allocation of subCategoryTxt
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.delegate = self;
    subCategoryTxt.userInteractionEnabled  = NO;
    subCategoryTxt.placeholder = NSLocalizedString(@"sub_category",nil);
    [subCategoryTxt awakeFromNib];
    
    //Allocation of departmentTxt
    departmentTxt = [[CustomTextField alloc] init];
    departmentTxt.delegate = self;
    departmentTxt.userInteractionEnabled  = NO;
    departmentTxt.placeholder = NSLocalizedString(@"department",nil);
    [departmentTxt awakeFromNib];
    
    //Allocation of subDepartmentTxt
    subDepartmentTxt = [[CustomTextField alloc] init];
    subDepartmentTxt.delegate = self;
    subDepartmentTxt.userInteractionEnabled  = NO;
    subDepartmentTxt.placeholder = NSLocalizedString(@"sub_department",nil);
    [subDepartmentTxt awakeFromNib];
    
    //Allocation of brandTxt
    brandTxt = [[CustomTextField alloc] init];
    brandTxt.delegate = self;
    brandTxt.userInteractionEnabled  = NO;
    brandTxt.placeholder = NSLocalizedString(@"brand",nil);
    [brandTxt awakeFromNib];
    
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
    
    //Allocation Of UIScrollView...
   
    departmentWiseScrollView = [[UIScrollView alloc]init];
    
    //departmentWiseScrollView.backgroundColor = [UIColor greenColor];
    

    // allocation Of CustomLabels...
    
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];

    dateLbl = [[CustomLabel alloc] init];
    [dateLbl awakeFromNib];

    categoryLbl = [[CustomLabel alloc] init];
    [categoryLbl awakeFromNib];
    
    subCategoryLbl = [[CustomLabel alloc] init];
    [subCategoryLbl awakeFromNib];
    
    sectionLbl = [[CustomLabel alloc] init];
    [sectionLbl awakeFromNib];

    departmentLbl = [[CustomLabel alloc] init];
    [departmentLbl awakeFromNib];

    departmentDescLbl = [[CustomLabel alloc] init];
    [departmentDescLbl awakeFromNib];

    quantityLbl = [[CustomLabel alloc] init];
    [quantityLbl awakeFromNib];
   
    totalSaleLbl = [[CustomLabel alloc] init];
    [totalSaleLbl awakeFromNib];

    
    //Allocation of UIButtons....
    
    UIImage  * startDteImg;
    UIImage  * dropDown_img;
    UIButton * categoryBtn;
    UIButton * subCategoryBtn;
    UIButton * departmentBtn;
    UIButton * subDepartmentBtn;
    UIButton * brandBtn;
    UIButton * sectionBtn;
    UIButton * startDteBtn;
    UIButton * endDteBtn;
    
    UIButton * clearBtn;
    
    
    //Allocation of startDteImg
    startDteImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    //Allocation of dropDown_img
    dropDown_img  = [UIImage imageNamed:@"arrow_1.png"];
    
    //Allocation of CategoryBtn
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
    
    //Allocation of brandBtn
    brandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [brandBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [brandBtn addTarget:self
                 action:@selector(showBrandList:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of sectionBtn
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
    
    //used for identification propouse....
    startDteBtn.tag = 2;
    endDteBtn.tag = 4;
    
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
    
    
    /** Create TableView */
    departmentWiseTbl = [[UITableView alloc]init];
    departmentWiseTbl.backgroundColor = [UIColor blackColor];
    departmentWiseTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    departmentWiseTbl.dataSource = self;
    departmentWiseTbl.delegate = self;
    departmentWiseTbl.bounces = TRUE;
    departmentWiseTbl.separatorColor = [UIColor clearColor];
    
    
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
    
    //subDepartmentListTbl creation...
    subDepartmentListTbl = [[UITableView alloc] init];
    subDepartmentListTbl.layer.borderWidth = 1.0;
    subDepartmentListTbl.layer.cornerRadius = 4.0;
    subDepartmentListTbl.layer.borderColor = [UIColor blackColor].CGColor;
    subDepartmentListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    subDepartmentListTbl.dataSource = self;
    subDepartmentListTbl.delegate = self;
    
    //brandListTbl creation...
    brandListTbl = [[UITableView alloc] init];
    brandListTbl.layer.borderWidth = 1.0;
    brandListTbl.layer.cornerRadius = 4.0;
    brandListTbl.layer.borderColor = [UIColor blackColor].CGColor;
    brandListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    brandListTbl.dataSource = self;
    brandListTbl.delegate = self;
    
    //sectionTbl creation...
    sectionTbl = [[UITableView alloc] init];
    sectionTbl.layer.borderWidth = 1.0;
    sectionTbl.layer.cornerRadius = 4.0;
    sectionTbl.layer.borderColor = [UIColor blackColor].CGColor;
    sectionTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    sectionTbl.dataSource = self;
    sectionTbl.delegate = self;

    quantityValueLbl = [[UILabel alloc] init];
    quantityValueLbl.layer.cornerRadius = 5;
    quantityValueLbl.layer.masksToBounds = YES;
    quantityValueLbl.backgroundColor = [UIColor blackColor];
    quantityValueLbl.layer.borderWidth = 2.0f;
    quantityValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    quantityValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalSaleValueLbl = [[UILabel alloc] init];
    totalSaleValueLbl.layer.cornerRadius = 5;
    totalSaleValueLbl.layer.masksToBounds = YES;
    totalSaleValueLbl.backgroundColor = [UIColor blackColor];
    totalSaleValueLbl.layer.borderWidth = 2.0f;
    totalSaleValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    totalSaleValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];


    quantityValueLbl.textAlignment      = NSTextAlignmentCenter;
    totalSaleValueLbl.textAlignment      = NSTextAlignmentCenter;

    // Initially we are setting the  Values as 0.0
   
    quantityValueLbl.text   = @"0.0";
    totalSaleValueLbl.text   = @"0.0";

    
    @try {
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        
        snoLbl.text = NSLocalizedString(@"S_NO",nil);
        dateLbl.text = NSLocalizedString(@"date",nil);
        categoryLbl.text = NSLocalizedString(@"category",nil);
        subCategoryLbl.text = NSLocalizedString(@"sub_category",nil);
        sectionLbl.text = NSLocalizedString(@"section",nil);

        departmentLbl.text = NSLocalizedString(@"department",nil);
        departmentDescLbl.text = NSLocalizedString(@"department_desc",nil);
        quantityLbl.text = NSLocalizedString(@"sale_qty",nil);
        totalSaleLbl.text = NSLocalizedString(@"total_sale",nil);
        
        headerNameLbl.text = NSLocalizedString(@"department_wise",nil);
        //setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    //Frame Design for the Category wise Report View....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
        }
        //setting for the stockReceiptView....
        departmentWiseReportView.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        // setting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake(0,0,departmentWiseReportView.frame.size.width,45);
        
        float textFieldWidth = 160;
        float textFieldHeight = 40;
        float labelHeight = 40;
        float verticalGap = 20;
        float horizontalGap = 10;
        //Column 1
        
        //Frame for the categoryTxt
        zoneTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+verticalGap,textFieldWidth,textFieldHeight);
        
        //Frame for the brandTxt....
        categoryTxt.frame = CGRectMake(zoneTxt.frame.origin.x+zoneTxt.frame.size.width+horizontalGap,zoneTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the brandTxt
        brandTxt.frame = CGRectMake(categoryTxt.frame.origin.x+categoryTxt.frame.size.width+horizontalGap, zoneTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        departmentTxt.frame = CGRectMake(brandTxt.frame.origin.x+brandTxt.frame.size.width+horizontalGap,brandTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        startDateTxt.frame = CGRectMake(departmentTxt.frame.origin.x+departmentTxt.frame.size.width+horizontalGap,zoneTxt.frame.origin.y,textFieldWidth,textFieldHeight);

        
        //Column 2
        
        //Frame for the subCategoryTxt
        locationTxt.frame  = CGRectMake(zoneTxt.frame.origin.x,zoneTxt.frame.origin.y+zoneTxt.frame.size.height+verticalGap+5,textFieldWidth,textFieldHeight);
        
        //Frame for the subDepartmentTxt
        subCategoryTxt.frame= CGRectMake(categoryTxt.frame.origin.x,locationTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        sectionTxt.frame= CGRectMake(brandTxt.frame.origin.x,locationTxt.frame.origin.y,textFieldWidth,textFieldHeight);

        
        //Frame for the sectionTxt
       subDepartmentTxt.frame = CGRectMake(departmentTxt.frame.origin.x, subCategoryTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        //Frame for the endDateTxt
        endDateTxt.frame = CGRectMake(startDateTxt.frame.origin.x,subDepartmentTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frames for the UIButton...
        
        //Frame for the categoryBtn
        categoryBtn.frame = CGRectMake((categoryTxt.frame.origin.x + categoryTxt.frame.size.width-45), categoryTxt.frame.origin.y-8,55,60);
        
        //Frame for the subCategoryBtn
        subCategoryBtn.frame = CGRectMake((subCategoryTxt.frame.origin.x+subCategoryTxt.frame.size.width-45), subCategoryTxt.frame.origin.y-8,55,60);
        
        //Frame for the departmentBtn
        departmentBtn.frame = CGRectMake((departmentTxt.frame.origin.x+departmentTxt.frame.size.width-45), departmentTxt.frame.origin.y-8,55,60);
        
        //Frame for the subDepartmentBtn
        subDepartmentBtn.frame = CGRectMake((subDepartmentTxt.frame.origin.x+subDepartmentTxt.frame.size.width-45), subDepartmentTxt.frame.origin.y-8,55,60);
        
        //Frame for the brandBtn
        brandBtn.frame = CGRectMake((brandTxt.frame.origin.x+brandTxt.frame.size.width-45),brandTxt.frame.origin.y-8,55,60);
        
        //Frame for the sectionBtn
        sectionBtn.frame = CGRectMake((sectionTxt.frame.origin.x+sectionTxt.frame.size.width-45),sectionTxt.frame.origin.y-8,55,60);
        
        //Frame for the startDteBtn
        startDteBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-40), startDateTxt.frame.origin.y+2, 35, 30);
        
        //Frame for the endDteBtn
        endDteBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-40),endDateTxt.frame.origin.y+2,35,30);
        
        searchBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap+10), categoryTxt.frame.origin.y,140,40);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x,subCategoryTxt.frame.origin.y,searchBtn.frame.size.width,searchBtn.frame.size.height);

        //Frame for the overrideScrollView...
        departmentWiseScrollView.frame = CGRectMake(10,endDateTxt.frame.origin.y+endDateTxt.frame.size.height+20,departmentWiseReportView.frame.size.width+100,450);
        
        snoLbl.frame = CGRectMake(0, 0,60,labelHeight);
        
        dateLbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width+2,0,100,labelHeight);
        
        departmentLbl.frame = CGRectMake(dateLbl.frame.origin.x+dateLbl.frame.size.width+2,0,140,labelHeight);
        
        departmentDescLbl.frame = CGRectMake(departmentLbl.frame.origin.x+departmentLbl.frame.size.width+2,0,140,labelHeight);
        
        categoryLbl.frame = CGRectMake(departmentDescLbl.frame.origin.x+departmentDescLbl.frame.size.width+2,0,120,labelHeight);
        subCategoryLbl.frame = CGRectMake(categoryLbl.frame.origin.x+categoryLbl.frame.size.width+2,0,120,labelHeight);
        sectionLbl.frame = CGRectMake(subCategoryLbl.frame.origin.x+subCategoryLbl.frame.size.width+2,0,120,labelHeight);
        
        quantityLbl.frame = CGRectMake(sectionLbl.frame.origin.x+sectionLbl.frame.size.width+2,0,90,labelHeight);
        
        totalSaleLbl.frame = CGRectMake(quantityLbl.frame.origin.x+quantityLbl.frame.size.width+2,0,100,labelHeight);
        
        //frame for the UITableView
        departmentWiseTbl.frame = CGRectMake(snoLbl.frame.origin.x,snoLbl.frame.origin.y+snoLbl.frame.size.height+5,totalSaleLbl.frame.origin.x+totalSaleLbl.frame.size.width-(snoLbl.frame.origin.x),departmentWiseScrollView.frame.origin.y+departmentWiseScrollView.frame.size.height-30);

        quantityValueLbl.frame = CGRectMake(quantityLbl.frame.origin.x+5,departmentWiseTbl.frame.origin.y+departmentWiseTbl.frame.size.height,quantityLbl.frame.size.width,40);

        totalSaleValueLbl.frame = CGRectMake(totalSaleLbl.frame.origin.x+5,quantityValueLbl.frame.origin.y,totalSaleLbl.frame.size.width,40);
        
    }

    //Adding hourWiseReportView as a subView for the self.view...
    [self.view addSubview:departmentWiseReportView];
    
    [departmentWiseReportView addSubview:headerNameLbl];
    
    [departmentWiseReportView addSubview:zoneTxt];
    [departmentWiseReportView addSubview:locationTxt];
    [departmentWiseReportView addSubview:categoryTxt];
    [departmentWiseReportView addSubview:subCategoryTxt];
    [departmentWiseReportView addSubview:brandTxt];
    [departmentWiseReportView addSubview:sectionTxt];
    [departmentWiseReportView addSubview:departmentTxt];
    [departmentWiseReportView addSubview:subDepartmentTxt];
    
    [departmentWiseReportView addSubview:startDateTxt];
    [departmentWiseReportView addSubview:endDateTxt];
    
    
    [departmentWiseReportView addSubview:categoryBtn];
    [departmentWiseReportView addSubview:subCategoryBtn];
    
    [departmentWiseReportView addSubview:brandBtn];
    [departmentWiseReportView addSubview:sectionBtn];
    
    [departmentWiseReportView addSubview:departmentBtn];
    [departmentWiseReportView addSubview:subDepartmentBtn];
    
    [departmentWiseReportView addSubview:startDteBtn];
    [departmentWiseReportView addSubview:endDteBtn];
    
    [departmentWiseReportView addSubview:searchBtn];
    [departmentWiseReportView addSubview:clearBtn];
    
    [departmentWiseReportView addSubview:departmentWiseScrollView];
    
    [departmentWiseScrollView addSubview:snoLbl];
    [departmentWiseScrollView addSubview:dateLbl];
    [departmentWiseScrollView addSubview:departmentLbl];
    [departmentWiseScrollView addSubview:departmentDescLbl];
    [departmentWiseScrollView addSubview:categoryLbl];
    [departmentWiseScrollView addSubview:subCategoryLbl];
    [departmentWiseScrollView addSubview:sectionLbl];
    [departmentWiseScrollView addSubview:quantityLbl];
    [departmentWiseScrollView addSubview:totalSaleLbl];
    [departmentWiseScrollView addSubview:departmentWiseTbl];
    
    [departmentWiseReportView addSubview:quantityValueLbl];
    [departmentWiseReportView addSubview:totalSaleValueLbl];

    
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:15.0f cornerRadius:0];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
      
        searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

    } @catch (NSException * exception) {
        
    }

}

/**
 * @description  EXecuted after the VeiwDidLoad Execution
 * @date         25/09/2017..
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
        reportStartIndex = 0;
        
        departmentWiseArr = [NSMutableArray new];
        
        [self calllingDepartmentWiseReports];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description
 * @date         25/09/2017
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
 * @description  we are reteriving the data from the service through sending the Request....
 * @date         25/09/2017
 * @method       calllingDepartmentWiseReports
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

// Commented by roja on 17/10/2019.. // reason : calllingDepartmentWiseReports method contains SOAP Service call .. so taken new method with same name(calllingDepartmentWiseReports) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)calllingDepartmentWiseReports {
//
//    @try {
//
//        [HUD show:YES];
//        [HUD setHidden:NO];
//
//        NSString * categoryStr = categoryTxt.text;
//        NSString * subCategoryStr = subCategoryTxt.text;
//        NSString * departmentStr = departmentTxt.text;
//        NSString * subDepartmentStr = subDepartmentTxt.text;
//        NSString * brandStr = brandTxt.text;
//        NSString * sectionStr = sectionTxt.text;
//
//        NSString * startDateStr = @"";
//
//        if((startDateTxt.text).length > 0)
//            startDateStr = [NSString stringWithFormat:@"%@%@", startDateTxt.text,@" 00:00:00"];
//
//        NSString * endDteStr = @"";
//
//        if ((endDateTxt.text).length>0) {
//            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
//        }
//
//        NSMutableDictionary * reports = [[NSMutableDictionary alloc]init];
//        //[reports setObject:currentdate forKey:@"date"];
//        reports[@"startDate"] = startDateStr;
//        reports[@"endDate"] = endDteStr;
//        reports[@"shiftId"] = shiftId;
//        reports[@"paymentMode"] = @"";
//        reports[@"store_location"] = presentLocation;
//
//        reports[@"searchCriteria"] = @"Department";
//
//        reports[@"counterId"] = @"";
//
//        reports[@"requiredRecords"] = [NSString stringWithFormat:@"%d",10];
//
//        reports[@"startIndex"] = [NSString stringWithFormat:@"%d",reportStartIndex];
//        reports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
//        reports[@"searchName"] = @"";
//
//        if(searchBtn.tag == 2){
//            categoryStr = @"";
//            subCategoryStr = @"";
//            departmentStr = @"";
//            subDepartmentStr = @"";
//            brandStr = @"";
//            sectionStr = @"";
//            startDateStr = @"";
//            endDteStr = @"";
//        }
//
//        reports[kcategory] = categoryStr;
//        reports[kSubCategory] = subCategoryStr;
//        reports[kItemDept] = departmentStr;
//        reports[kItemSubDept] = subDepartmentStr;
//        reports[kBrand] = brandStr;
//        reports[SECTION] = sectionStr;
//
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
//        NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        //            item = [[NSMutableArray alloc] init];
//
//        SalesServiceSvcSoapBinding *salesBindng =  [SalesServiceSvc SalesServiceSvcSoapBinding];
//        SalesServiceSvc_getSalesReports *aParameters =  [[SalesServiceSvc_getSalesReports alloc] init];
//
//
//        aParameters.searchCriteria = reportsJsonString;
//        SalesServiceSvcSoapBindingResponse * response = [salesBindng getSalesReportsUsingParameters:aParameters];
//
//        NSArray * responseBodyParts = response.bodyParts;
//
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[SalesServiceSvc_getSalesReportsResponse class]]) {
//                SalesServiceSvc_getSalesReportsResponse *body = (SalesServiceSvc_getSalesReportsResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//
//                NSError * e;
//                NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                      options: NSJSONReadingMutableContainers
//                                                                        error: &e];
//
//                if (![body.return_ isKindOfClass:[NSNull class]]) {
//
//                    @try {
//
//                        if (departmentWiseArr == nil && reportStartIndex == 0) {
//
//                            totalRecordsInt = 0;
//
//                            departmentWiseArr = [NSMutableArray new];
//
//                        }
//                        else if (reportStartIndex == 0  && departmentWiseArr.count) {
//
//                            [departmentWiseArr removeAllObjects];
//                        }
//
//                        NSDictionary  * json1 = JSON[RESPONSE_HEADER];
//
//                        if ([json1[RESPONSE_CODE]intValue] == 0) {
//
//                            totalRecordsInt = [[JSON valueForKey:@"totalRecords"] intValue];
//                            //
//                            for (NSDictionary * departmentWiseDic in [JSON valueForKey:@"reportsList" ]  ) {
//
//                                [departmentWiseArr addObject:departmentWiseDic];
//                            }
//                            //
//                            quantityValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[[JSON valueForKey:@"categorySummery"]valueForKey:@"totalQuantity" ] defaultReturn:@"0.00"] floatValue]];
//
//                            totalSaleValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[[JSON valueForKey:@"categorySummery"]valueForKey:@"totalPrice" ] defaultReturn:@"0.00"] floatValue]];
//
//                        }
//                        else{
//
//                            if (reportStartIndex == 0) {
//
//                                [self displayAlertMessage:NSLocalizedString(@"No Records Found",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//
//                                quantityValueLbl.text  = @"0.0";
//                                totalSaleValueLbl.text  = @"0.0";
//                            }
//                        }
//                    }
//                    @catch (NSException * exception) {
//
//                    }
//
//                }
//                else {
//
//                    [self displayAlertMessage:NSLocalizedString(@"failed to get the reports",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//                }
//
//            }
//            else{
//
//                [self displayAlertMessage:NSLocalizedString(@"failed to get the reports",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//            }
//        }
//
//    }
//    @catch (NSException *exception) {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the reports" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    @finally{
//
//        [departmentWiseTbl reloadData];
//        [HUD setHidden: YES];
//    }
//
//}




//validateOLP method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)calllingDepartmentWiseReports {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        NSString * categoryStr = categoryTxt.text;
        NSString * subCategoryStr = subCategoryTxt.text;
        NSString * departmentStr = departmentTxt.text;
        NSString * subDepartmentStr = subDepartmentTxt.text;
        NSString * brandStr = brandTxt.text;
        NSString * sectionStr = sectionTxt.text;
        
        NSString * startDateStr = @"";
        
        if((startDateTxt.text).length > 0)
            startDateStr = [NSString stringWithFormat:@"%@%@", startDateTxt.text,@" 00:00:00"];
        
        NSString * endDteStr = @"";
        
        if ((endDateTxt.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        }
        
        NSMutableDictionary * reports = [[NSMutableDictionary alloc]init];
        //[reports setObject:currentdate forKey:@"date"];
        reports[@"startDate"] = startDateStr;
        reports[@"endDate"] = endDteStr;
        reports[@"shiftId"] = shiftId;
        reports[@"paymentMode"] = @"";
        reports[@"store_location"] = presentLocation;
        reports[@"searchCriteria"] = @"Department";
        reports[@"counterId"] = @"";
        reports[@"requiredRecords"] = [NSString stringWithFormat:@"%d",10];
        reports[@"startIndex"] = [NSString stringWithFormat:@"%d",reportStartIndex];
        reports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        reports[@"searchName"] = @"";
        
        if(searchBtn.tag == 2){
            categoryStr = @"";
            subCategoryStr = @"";
            departmentStr = @"";
            subDepartmentStr = @"";
            brandStr = @"";
            sectionStr = @"";
            startDateStr = @"";
            endDteStr = @"";
        }
        
        reports[kcategory] = categoryStr;
        reports[kSubCategory] = subCategoryStr;
        reports[kItemDept] = departmentStr;
        reports[kItemSubDept] = subDepartmentStr;
        reports[kBrand] = brandStr;
        reports[SECTION] = sectionStr;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
        NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //            item = [[NSMutableArray alloc] init];
        
        if (departmentWiseArr == nil && reportStartIndex == 0) {
            
            totalRecordsInt = 0;
            
            departmentWiseArr = [NSMutableArray new];
            
        }
        else if (reportStartIndex == 0  && departmentWiseArr.count) {
            
            [departmentWiseArr removeAllObjects];
        }
        
        WebServiceController * services = [[WebServiceController alloc] init];
        services.salesServiceDelegate = self;
        [services getSalesReport:reportsJsonString];
        
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the reports" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    @finally{
        
        [departmentWiseTbl reloadData];
        [HUD setHidden: YES];
    }
    
}

// added by Roja on 17/10/2019….
- (void)getSalesReportsSuccessResponse:(NSDictionary *)successDictionary{

    @try {
        
        totalRecordsInt = [[successDictionary valueForKey:@"totalRecords"] intValue];
        for (NSDictionary * departmentWiseDic in [successDictionary valueForKey:@"reportsList" ]  ) {
            
            [departmentWiseArr addObject:departmentWiseDic];
        }

        quantityValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[[successDictionary valueForKey:@"categorySummery"]valueForKey:@"totalQuantity" ] defaultReturn:@"0.00"] floatValue]];
        
        totalSaleValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[[successDictionary valueForKey:@"categorySummery"]valueForKey:@"totalPrice" ] defaultReturn:@"0.00"] floatValue]];
        
    }
    @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}

// added by Roja on 17/10/2019….
- (void)getSalesReportsErrorResponse:(NSString *)errorResponse{

    @try {
        
        if (reportStartIndex == 0) {
            
            [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            quantityValueLbl.text  = @"0.0";
            totalSaleValueLbl.text  = @"0.0";
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



#pragma mark Service Calls For the Filters...

/**
 * @description  here we are calling the getCategories services.....
 * @date         25/09/2017
 * @method       callingCategoriesList
 * @author       Bhargav
 * @param        NSString
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
 * @date         25/09/2017
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
        dept_SubDeptDic = [NSMutableDictionary new];
        
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
 * @description  here we are calling the getDepartment services.....
 * @date         25/09/2017
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
        
        subDepartmentArr = [NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,kPrimaryDepartment,@"subDepartment"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",departmentTxt.text,@""];
        
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
 * @description  here we are calling the getBrandList services.....
 * @date         25/09/2017
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
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,@"bName",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",@"", @0];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * brandListJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getBrandList:brandListJsonString];
        
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
 * @description   here we are calling the sections from SubCategories services.....
 * @date         25/09/2017
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
 * @date         25/09/2017
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
 * @date         25/09/2017
 * @method       getCategoryErrorResponse:
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
 * @description  handling the success response received from Data Base....
 * @date         25/09/2017
 * @method       getDepartmentSuccessResponse:
 * @author       Bhargav.v
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
        else  if ((departmentTxt.text).length > 0){
            for (NSDictionary * department in  [sucessDictionary valueForKey:kDepartments]) {
                
                
                NSMutableArray *subDepartment = [NSMutableArray new];
                for (NSDictionary * primary in [department valueForKey:SECONDARY_DEPARTMENTS]) {
                    [subDepartment addObject:[primary valueForKey:SECONDARY_DEPARTMENT]];
                    [subDepartmentArr addObject:[primary valueForKey:SECONDARY_DEPARTMENT]];
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
 * @date         26/09/2017
 * @method       getAllDepartmentsErrorResponse:
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
        float y_axis = self.view.frame.size.height - 350;
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  handling the success response received from server side....
 * @date         26/09/2017
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
        
        for (NSDictionary * brand in  [sucessDictionary valueForKey:@"brandDetails" ]) {
            [brandListArray addObject:brand];
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
 * @date         25/09/2017
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
    float y_axis = self.view.frame.size.height - 350;
    
    NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
    
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
}



/**
 * @description  handling the success response received from server side....
 * @date         25/09/2017
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
 * @date         25/09/2017...
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

# pragma mark Actions...

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         25/09/2017....
 * @method       showDepartmentList:
 * @author       Bhargav.v
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
        
        
        
        float tableHeight = categoriesListArr.count * 45;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = categoriesListArr.count * 33;
        
        if(categoriesListArr.count > 5)
            tableHeight =(tableHeight/categoriesListArr.count) * 5;
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:categoryTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:departmentWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


/**
 * @description  showing the availiable  Shipment modes.......
 * @date         26/09/2017....
 * @method       showAllSubCategoriesList:
 * @author       Bhargav.v
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
        float tableHeight = subCategoriesListArr.count * 45;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoriesListArr.count * 33;
        
        if(subCategoriesListArr.count > 5)
            tableHeight = (tableHeight/subCategoriesListArr.count)*5;
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:subCategoryTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:departmentWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         25/09/2017....
 * @method       showDepartmentList:
 * @author       Bhargav.v
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
        
        
        float tableHeight = departmentArr.count * 45;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = departmentArr.count * 33;
        
        if(departmentArr.count > 5)
            tableHeight = (tableHeight/departmentArr.count) * 5;
        
        [self showPopUpForTables:departmentListTbl  popUpWidth:departmentTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:departmentTxt  showViewIn:departmentWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  showing the availiable  subDepartment.......
 * @date         26/09/2017....
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
        
        if(subDepartmentArr == nil ||  subDepartmentArr.count == 0){
            [HUD setHidden:NO];
            [self callingSubDepartmentList];
        }
        
        if(subDepartmentArr.count){
            float tableHeight = subDepartmentArr.count * 45;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = subDepartmentArr.count * 33;
            
            if(subDepartmentArr.count > 5)
                tableHeight = (tableHeight/subDepartmentArr.count) * 5;
            
            [self showPopUpForTables:subDepartmentListTbl  popUpWidth:subDepartmentTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:subDepartmentTxt  showViewIn:departmentWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
            
            
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the normalStockView in showBrandList:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in normalStockView------%@",exception);
        
    }
}

/**
 * @description  showing the availiable  Brands.......
 * @date         26/09/2017....
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
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = brandListArray.count * 45;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = brandListArray.count * 33;
        
        if(brandListArray.count > 5)
            tableHeight = (tableHeight/brandListArray.count) * 5;
        
        [self showPopUpForTables:brandListTbl  popUpWidth:brandTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:departmentWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = sectionArr.count * 45;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = sectionArr.count * 33;
        
        if(sectionArr.count > 5)
            tableHeight = (tableHeight/sectionArr.count) * 5;
        
        [self showPopUpForTables:sectionTbl  popUpWidth:sectionTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:sectionTxt  showViewIn:departmentWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


#pragma mark populate Calendar

/**
 * @description  To create picker frame and set the date inside the dueData textfield.
 * @date         26/09/2017
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:departmentWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:departmentWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @date         25/09/2017
 * @method       clearDate:
 * @author       Bhargav.v
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
 * @date         26/09/2017
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
 * @date         26/09/2017
 * @method       goButtonClicked
 * @author       Bhargav.v
 * @param        sender
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)searchTheProducts:(UIButton*)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        searchBtn.tag  = 4;
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0 && (brandTxt.text).length == 0 && (sectionTxt.text).length == 0  && (departmentTxt.text).length == 0 && (subDepartmentTxt.text).length == 0 && (startDateTxt.text).length == 0 && (endDateTxt.text).length == 0  ) {
            
            float y_axis = self.view.frame.size.height-200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert",nil),@"\n",NSLocalizedString(@"Please select above fields before proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        else
        [HUD setHidden:NO];
        
        reportStartIndex = 0;
        departmentWiseArr = [NSMutableArray new];
        [self calllingDepartmentWiseReports];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are creating request string for creation of new SupplierQuotation.......
 * @date         26/09/2017
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
        
        categoryTxt.text      = @"";
        subCategoryTxt.text   = @"";
        brandTxt.text         = @"";
        sectionTxt.text       = @"";
        departmentTxt.text    = @"";
        subDepartmentTxt.text = @"";
        startDateTxt.text     = @"";
        endDateTxt.text       = @"";
       
        reportStartIndex = 0;
      
        [self calllingDepartmentWiseReports];
        
    } @catch (NSException * exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the dateWiseReportView.... in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}

/** Table Implementation */

#pragma mark Table view methods


/**
 * @description  Customize the number of rows in the table view.
 * @date         26/09/2017
 * @method       numberOfRowsInSection
 * @author       Bhargav.v
 * @param        NSInteger
 * @param        UITableView
 * @return
 * @verified By
 * @verified On
 *
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == departmentWiseTbl) {
        if (departmentWiseArr.count)
            
            return departmentWiseArr.count;
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
    
    else if(tableView == subDepartmentListTbl){
        
        return subDepartmentArr.count;
    }
    
    else if(tableView == brandListTbl){
        
        return brandListArray.count;
    }
    else if(tableView == sectionTbl){
        
        return sectionArr.count;
    }

    
    return 0;
}




/**
 * @description  Customize HeightForRowAtIndexPath ...
 * @date         26/09/2017
 * @method       heightForRowAtIndexPath
 * @author       Bhargav.v
 * @param        CGFloat
 * @param        UITableView
 * @param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == departmentWiseTbl  ){
        
        return 45;
    }
    
    else if (tableView == categoriesListTbl|| tableView == subCategoriesListTbl||tableView == departmentListTbl ||subDepartmentListTbl || tableView == brandListTbl ||tableView == sectionTbl ){
        
        return 45.0;
    }

    
    return 0.0;
}



/**
 * @description  Customize the appearance of table view cells.
 * @date         26/09/2017
 * @method       cellForRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableViewCell
 * @param        UITableView
 * @param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == departmentWiseTbl) {
        
        
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
            UILabel * category_Lbl;
            UILabel * subCategory_Lbl;
            UILabel * section_Lbl;
            UILabel * department_Lbl;
            UILabel * departmentDesc_Lbl;
            UILabel * quantity_Lbl;
            UILabel * totalSale_Lbl;
            
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
            
            
            department_Lbl = [[UILabel alloc] init];
            department_Lbl.backgroundColor = [UIColor clearColor];
            department_Lbl.textAlignment = NSTextAlignmentCenter;
            department_Lbl.numberOfLines = 1;
            department_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            departmentDesc_Lbl = [[UILabel alloc] init];
            departmentDesc_Lbl.backgroundColor = [UIColor clearColor];
            departmentDesc_Lbl.textAlignment = NSTextAlignmentCenter;
            departmentDesc_Lbl.numberOfLines = 1;
            departmentDesc_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            category_Lbl = [[UILabel alloc] init];
            category_Lbl.backgroundColor = [UIColor clearColor];
            category_Lbl.textAlignment = NSTextAlignmentCenter;
            category_Lbl.numberOfLines = 1;
            category_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            subCategory_Lbl = [[UILabel alloc] init];
            subCategory_Lbl.backgroundColor = [UIColor clearColor];
            subCategory_Lbl.textAlignment = NSTextAlignmentCenter;
            subCategory_Lbl.numberOfLines = 1;
            subCategory_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            section_Lbl = [[UILabel alloc] init];
            section_Lbl.backgroundColor = [UIColor clearColor];
            section_Lbl.textAlignment = NSTextAlignmentCenter;
            section_Lbl.numberOfLines = 1;
            section_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            quantity_Lbl = [[UILabel alloc] init];
            quantity_Lbl.backgroundColor = [UIColor clearColor];
            quantity_Lbl.textAlignment = NSTextAlignmentCenter;
            quantity_Lbl.numberOfLines = 1;
            quantity_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            totalSale_Lbl = [[UILabel alloc] init];
            totalSale_Lbl.backgroundColor = [UIColor clearColor];
            totalSale_Lbl.textAlignment = NSTextAlignmentCenter;
            totalSale_Lbl.numberOfLines = 1;
            totalSale_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            sno_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            department_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            departmentDesc_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            category_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            subCategory_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            section_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            quantity_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            totalSale_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            [hlcell.contentView addSubview:sno_Lbl];
            [hlcell.contentView addSubview:date_Lbl];
            [hlcell.contentView addSubview:department_Lbl];
            [hlcell.contentView addSubview:departmentDesc_Lbl];
            [hlcell.contentView addSubview:category_Lbl];
            [hlcell.contentView addSubview:subCategory_Lbl];
            [hlcell.contentView addSubview:section_Lbl];
            [hlcell.contentView addSubview:quantity_Lbl];
            [hlcell.contentView addSubview:totalSale_Lbl];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                sno_Lbl.frame = CGRectMake(0,0,snoLbl.frame.size.width,hlcell.frame.size.height);
                
                date_Lbl.frame = CGRectMake(dateLbl.frame.origin.x,0,dateLbl.frame.size.width,hlcell.frame.size.height);
                
                department_Lbl.frame = CGRectMake(departmentLbl.frame.origin.x,0,departmentLbl.frame.size.width-5,hlcell.frame.size.height);
                
                departmentDesc_Lbl.frame = CGRectMake(departmentDescLbl.frame.origin.x,0,departmentDescLbl.frame.size.width,hlcell.frame.size.height);

                category_Lbl.frame = CGRectMake(categoryLbl.frame.origin.x,0,categoryLbl.frame.size.width-5,hlcell.frame.size.height);

                subCategory_Lbl.frame = CGRectMake(subCategoryLbl.frame.origin.x,0,subCategoryLbl.frame.size.width,hlcell.frame.size.height);
               
                section_Lbl.frame = CGRectMake(sectionLbl.frame.origin.x,0,sectionLbl.frame.size.width,hlcell.frame.size.height);
                
                quantity_Lbl.frame = CGRectMake(quantityLbl.frame.origin.x,0,quantityLbl.frame.size.width,hlcell.frame.size.height);
                
                totalSale_Lbl.frame = CGRectMake(totalSaleLbl.frame.origin.x,0,totalSaleLbl.frame.size.width,hlcell.frame.size.height);
                
            }
            else{
                
                //Code for iPhone...
                
            }
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            
            
            //appending values based on the service data...
            
            if (departmentWiseArr.count >= indexPath.row && departmentWiseArr.count) {
                
                NSDictionary * dic  = departmentWiseArr[indexPath.row];
                
                sno_Lbl.text = [NSString stringWithFormat:@"%ld",(indexPath.row + 1)];
                
                date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:@"date"] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];//ITEM_DESC
                
                department_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kItemDept] defaultReturn:@"--"];
                
                departmentDesc_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESC] defaultReturn:@"--"];

                category_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];
                
                subCategory_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kSubCategory] defaultReturn:@"--"];
                
                section_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SECTION] defaultReturn:@"--"];
                
                quantity_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                totalSale_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]];
            }
            
            else {
                
                sno_Lbl.text = @"--";
                date_Lbl.text = @"--";
                category_Lbl.text = @"--";
                subCategory_Lbl.text = @"--";
                section_Lbl.text = @"--";
                department_Lbl.text = @"--";
                departmentDesc_Lbl.text = @"--";
                quantity_Lbl.text = @"--";
                totalSale_Lbl.text = @"--";
                
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
    
    else if (tableView == subDepartmentListTbl){
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
            
            hlcell.textLabel.text = subDepartmentArr[indexPath.row];
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
            
            //  hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = [brandListArray[indexPath.row] valueForKey:@"bDescription"];
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
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
 * @description
 * @date         26/09/2017
 * @method       tableView willDisplayCell forRowAtIndexpath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        UITableViewCell
 * @Param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        
        if(tableView == departmentWiseTbl){
            
            @try {
                
                if ((indexPath.row == (departmentWiseArr.count-1)) && (departmentWiseArr.count < totalRecordsInt) && (departmentWiseArr.count> reportStartIndex)) {
                    
                    [HUD setHidden:NO];
                    reportStartIndex = reportStartIndex +10;
                    [self calllingDepartmentWiseReports];
                }
                
            } @catch (NSException * exception) {
                NSLog(@"-----------exception in servicecall-------------%@",exception);
                [HUD setHidden:YES];
            }
        }
    } @catch (NSException * exception) {
        
    }
}


/**
 * @description
 * @date         206/09/2017
 * @method       didSelectRowAtIndexPath
 * @author       Bhargav.v
 * @param        NSIndexPath
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
    else if (tableView == subDepartmentListTbl) {
        
        subDepartmentTxt.text = subDepartmentArr[indexPath.row];
    }
    
    else if (tableView == brandListTbl) {
        
        brandTxt.text = [brandListArray[indexPath.row] valueForKey:@"bDescription"];
    }
    
    else if (tableView == sectionTbl) {
        
        sectionTxt.text = sectionArr[indexPath.row];
    }
}


#pragma -mark reusableMethods.......
#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  Checking whether the object is null or not
 * @date         07/05/2017....
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On

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
        //Play Audio for button touch....
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
        
        NSLog(@"--------exception in the departmentWiseReportView in displayAlertMessage---------%@",exception);
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
        
        NSLog(@"--------exception in the departmentWiseReportView in removeAlertMessages---------%@",exception);
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
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        OmniHomePage * home = [[OmniHomePage alloc]init];
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
    
    //Play Audio for button touch....
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
    
     //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    
    @try {
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException * exception) {
        
    }
}

@end
