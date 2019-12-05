//
//  VoidItemsReport.m
//  OmniRetailer

//  Created by Bhargav.v on 8/28/17.


#import "VoidItemsReport.h"
#import "Global.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

@interface VoidItemsReport ()

@end

@implementation VoidItemsReport

@synthesize soundFileURLRef,soundFileObject;


/**
 * @description
 * @date         08/08/2017
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
    //calling super call method....
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
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //Allocation of Category Report View...
    
    voidItemsReportView = [[UIView alloc]init];
    
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
    
    modelTxt = [[CustomTextField alloc]init];
    modelTxt.delegate = self;
    modelTxt.userInteractionEnabled = NO;
    modelTxt.placeholder = NSLocalizedString(@"style",nil);
    [modelTxt awakeFromNib];
    
    classTxt = [[CustomTextField alloc]init];
    classTxt.delegate = self;
    classTxt.userInteractionEnabled = NO;
    classTxt.placeholder = NSLocalizedString(@"class",nil);
    [classTxt awakeFromNib];
    
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
    UIButton * modelBtn;
    UIButton * classBtn;
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
    
    //Allocation of Model buttton..
    modelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modelBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [modelBtn addTarget:self
                 action:@selector(showModelList:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of Model buttton..
    classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [classBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [classBtn addTarget:self
                 action:@selector(showClassList:) forControlEvents:UIControlEventTouchDown];
    
    
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
    
    //allocation of void Items Report scroll view....
    
    voidItemsScrollView = [[UIScrollView alloc]init];
    
    //creation Of customLabels....

    sNoLbl = [[CustomLabel alloc] init];
    [sNoLbl awakeFromNib];
    
    dateTimeLbl = [[CustomLabel alloc] init];
    [dateTimeLbl awakeFromNib];

    userNameLbl = [[CustomLabel alloc] init];
    [userNameLbl awakeFromNib];

    categoryLbl = [[CustomLabel alloc] init];
    [categoryLbl awakeFromNib];

    subCatLbl = [[CustomLabel alloc] init];
    [subCatLbl awakeFromNib];

    sectionLbl = [[CustomLabel alloc] init];
    [sectionLbl awakeFromNib];

    departmentLbl = [[CustomLabel alloc] init];
    [departmentLbl awakeFromNib];

    locationLbl = [[CustomLabel alloc] init];
    [locationLbl awakeFromNib];

    zoneLbl = [[CustomLabel alloc] init];
    [zoneLbl awakeFromNib];

    skuIdLbl = [[CustomLabel alloc] init];
    [skuIdLbl awakeFromNib];

    descriptionLbl = [[CustomLabel alloc] init];
    [descriptionLbl awakeFromNib];

    eanLbl = [[CustomLabel alloc] init];
    [eanLbl awakeFromNib];

    voidItemQtyLbl = [[CustomLabel alloc] init];
    [voidItemQtyLbl awakeFromNib];
    
    originalPriceLbl = [[CustomLabel alloc] init];
    [originalPriceLbl awakeFromNib];
    
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

    
    //Allocation of skuReportTable..
    voidItemsTbl = [[UITableView alloc]init];
    voidItemsTbl.backgroundColor = [UIColor blackColor];
    voidItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    voidItemsTbl.dataSource = self;
    voidItemsTbl.delegate = self;
    voidItemsTbl.bounces = TRUE;
    voidItemsTbl.layer.cornerRadius = 14;

    
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
    
    
    modelTbl = [[UITableView alloc] init];
    modelTbl.layer.borderWidth = 1.0;
    modelTbl.layer.cornerRadius = 4.0;
    modelTbl.layer.borderColor = [UIColor blackColor].CGColor;
    modelTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    modelTbl.dataSource = self;
    modelTbl.delegate = self;
    
    classTbl = [[UITableView alloc] init];
    classTbl.layer.borderWidth = 1.0;
    classTbl.layer.cornerRadius = 4.0;
    classTbl.layer.borderColor = [UIColor blackColor].CGColor;
    classTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    classTbl.dataSource = self;
    classTbl.delegate = self;
    
    //populating text into the textFields && labels && placeholders && buttons titles....
    
    @try {
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        
        headerNameLbl.text = NSLocalizedString(@"void_items_report", nil);
        //setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
        
        searchItemsTxt.placeholder = NSLocalizedString(@"search_void_items",nil);

        //Strings for the header Section...
        
        sNoLbl.text = NSLocalizedString(@"S_NO",nil);
        dateTimeLbl.text = NSLocalizedString(@"date_time",nil);
        userNameLbl.text = NSLocalizedString(@"user_name",nil);
        categoryLbl.text = NSLocalizedString(@"category",nil);
        subCatLbl.text = NSLocalizedString(@"sub_category",nil);
        sectionLbl.text = NSLocalizedString(@"section",nil);
        departmentLbl.text = NSLocalizedString(@"department",nil);
        locationLbl.text = NSLocalizedString(@"location",nil);
        zoneLbl.text = NSLocalizedString(@"zone",nil);
        skuIdLbl.text = NSLocalizedString(@"sku_id",nil);
        descriptionLbl.text = NSLocalizedString(@"description",nil);
        eanLbl.text = NSLocalizedString(@"ean",nil);
        voidItemQtyLbl.text = NSLocalizedString(@"void_item_qty",nil);
        originalPriceLbl.text = NSLocalizedString(@"original_price",nil);

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
        voidItemsReportView.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake(0,0,voidItemsReportView.frame.size.width,45);
        
        float textFieldWidth = 160;
        float textFieldHeight = 40;
        float verticalGap = 20;
        float horizontalGap = 10;
        //Column 1
        
        // Frame for the categoryTxt
        categoryTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+verticalGap,textFieldWidth,textFieldHeight);
        
        // Frame for the brandTxt....
        brandTxt.frame = CGRectMake(categoryTxt.frame.origin.x+categoryTxt.frame.size.width+horizontalGap,categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        // Frame for the departmentTxt
        departmentTxt.frame = CGRectMake(brandTxt.frame.origin.x+brandTxt.frame.size.width+horizontalGap, categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        // Frame for the modelTxt
        modelTxt.frame = CGRectMake(departmentTxt.frame.origin.x+departmentTxt.frame.size.width+horizontalGap,categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        // Frame for the startDateTxt
        startDateTxt.frame = CGRectMake(modelTxt.frame.origin.x+modelTxt.frame.size.width+horizontalGap,modelTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        
        //Column 2
        
        //Frame for the subCategoryTxt
        subCategoryTxt.frame  = CGRectMake(categoryTxt.frame.origin.x,categoryTxt.frame.origin.y+categoryTxt.frame.size.height+verticalGap,textFieldWidth,textFieldHeight);
        
        //Frame for the subDepartmentTxt
        sectionTxt.frame= CGRectMake(brandTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the sectionTxt
        subDepartmentTxt.frame = CGRectMake(departmentTxt.frame.origin.x, subCategoryTxt.frame.origin.y, textFieldWidth, textFieldHeight);
        
        //Frame for the class text...
        classTxt.frame = CGRectMake(modelTxt.frame.origin.x,subDepartmentTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the endDateTxt
        endDateTxt.frame = CGRectMake(startDateTxt.frame.origin.x,subCategoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
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
        
        modelBtn.frame = CGRectMake((modelTxt.frame.origin.x+modelTxt.frame.size.width-45),modelTxt.frame.origin.y-8,55,60);
        
        //Frame for the classBtn
        classBtn.frame = CGRectMake((classTxt.frame.origin.x+classTxt.frame.size.width-45),classTxt.frame.origin.y-8,55,60);
        
        
        searchBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap+10), categoryTxt.frame.origin.y,140,45);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x,subCategoryTxt.frame.origin.y,searchBtn.frame.size.width,searchBtn.frame.size.height);
    
        //frame for the UITextField..
        searchItemsTxt.frame = CGRectMake(categoryTxt.frame.origin.x,subCategoryTxt.frame.origin.y+subCategoryTxt.frame.size.height+verticalGap,searchBtn.frame.origin.x+searchBtn.frame.size.width-(categoryTxt.frame.origin.x),40);
        
        voidItemsScrollView.frame = CGRectMake(10,searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height + 10,searchItemsTxt.frame.size.width + 100,500);
      
//       frames for the CustomLabels.....
        
        sNoLbl.frame=CGRectMake(0,0,60,40);
        dateTimeLbl.frame=CGRectMake(sNoLbl.frame.origin.x+sNoLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        userNameLbl.frame=CGRectMake(dateTimeLbl.frame.origin.x+dateTimeLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);

        categoryLbl.frame=CGRectMake(userNameLbl.frame.origin.x+userNameLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        subCatLbl.frame=CGRectMake(categoryLbl.frame.origin.x+categoryLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        sectionLbl.frame=CGRectMake(subCatLbl.frame.origin.x+subCatLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        departmentLbl.frame=CGRectMake(sectionLbl.frame.origin.x+sectionLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        locationLbl.frame=CGRectMake(departmentLbl.frame.origin.x+departmentLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        
        zoneLbl.frame=CGRectMake(locationLbl.frame.origin.x+locationLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
       
        skuIdLbl.frame=CGRectMake(zoneLbl.frame.origin.x+zoneLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        
        descriptionLbl.frame=CGRectMake(skuIdLbl.frame.origin.x+skuIdLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        
        eanLbl.frame=CGRectMake(descriptionLbl.frame.origin.x+descriptionLbl.frame.size.width+2, sNoLbl.frame.origin.y,80,40);

        voidItemQtyLbl.frame=CGRectMake(eanLbl.frame.origin.x+eanLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);
        
        originalPriceLbl.frame=CGRectMake(voidItemQtyLbl.frame.origin.x+voidItemQtyLbl.frame.size.width+2, sNoLbl.frame.origin.y,100,40);

        voidItemsTbl.frame = CGRectMake(sNoLbl.frame.origin.x,sNoLbl.frame.origin.y +sNoLbl.frame.size.height + 10, originalPriceLbl.frame.origin.x + originalPriceLbl.frame.size.width - sNoLbl.frame.origin.x,voidItemsScrollView.frame.size.height-100);

        voidItemsScrollView.contentSize = CGSizeMake(voidItemsTbl.frame.size.width+100,voidItemsScrollView.frame.size.height);
        
//        voidItemsScrollView.backgroundColor = [UIColor greenColor];
        
        
    }
    
    
    //Adding sub Views For the categoryWiseReportView
    [voidItemsReportView addSubview:headerNameLbl];
    [voidItemsReportView addSubview:categoryTxt];
    [voidItemsReportView addSubview:subCategoryTxt];
    [voidItemsReportView addSubview:brandTxt];
    [voidItemsReportView addSubview:sectionTxt];
    
    [voidItemsReportView addSubview:departmentTxt];
    [voidItemsReportView addSubview:subDepartmentTxt];
    
    [voidItemsReportView addSubview:modelTxt];
    [voidItemsReportView addSubview:classTxt];
    
    [voidItemsReportView addSubview:startDateTxt];
    [voidItemsReportView addSubview:endDateTxt];
    
    
    [voidItemsReportView addSubview:categoryBtn];
    [voidItemsReportView addSubview:subCategoryBtn];
    
    [voidItemsReportView addSubview:brandBtn];
    [voidItemsReportView addSubview:sectionBtn];
    
    [voidItemsReportView addSubview:departmentBtn];
    [voidItemsReportView addSubview:subDepartmentBtn];
    
    [voidItemsReportView addSubview:modelBtn];
    [voidItemsReportView addSubview:classBtn];
    
    [voidItemsReportView addSubview:startDteBtn];
    [voidItemsReportView addSubview:endDteBtn];
    
    [voidItemsReportView addSubview:searchBtn];
    [voidItemsReportView addSubview:clearBtn];
   
    [voidItemsReportView addSubview:searchItemsTxt];
    
    [voidItemsScrollView addSubview:sNoLbl];
    [voidItemsScrollView addSubview:dateTimeLbl];
    [voidItemsScrollView addSubview:userNameLbl];
    [voidItemsScrollView addSubview:categoryLbl];
    [voidItemsScrollView addSubview:subCatLbl];
    [voidItemsScrollView addSubview:sectionLbl];
    [voidItemsScrollView addSubview:departmentLbl];
    [voidItemsScrollView addSubview:locationLbl];
    [voidItemsScrollView addSubview:zoneLbl];
    [voidItemsScrollView addSubview:skuIdLbl];
    [voidItemsScrollView addSubview:descriptionLbl];
    [voidItemsScrollView addSubview:eanLbl];
    [voidItemsScrollView addSubview:voidItemQtyLbl];
    [voidItemsScrollView addSubview:originalPriceLbl];
    [voidItemsScrollView addSubview:voidItemsTbl];


    
    [voidItemsReportView addSubview:voidItemsScrollView];
    
    //Adding categoryWiseReportView For the self.view
    [self.view addSubview:voidItemsReportView];
    
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:15.0f cornerRadius:0];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
    } @catch (NSException *exception) {
        
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


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
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
 * @modified BY
 * @reason
 * * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [HUD setHidden:NO];
    
    @try {
        
        startIndexInt = 0;
        [self getVoidItemReports:nil];
        
    } @catch (NSException *exception) {
        NSLog(@"----exception while calling service call------------%@",exception);
    } @finally {
        
    }
}




/**
 * @description  we are calling sales Void item reports...
 * @date         28/08/2017
 * @method       getVoidItemReports
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getVoidItemReports:(NSString*)searchStr{
    
    @try {
        
        [HUD setHidden:NO];
        
        if( voidReportsArr == nil && startIndexInt == 0){
            
            voidReportsArr = [NSMutableArray new];
        }
        else if(startIndexInt == 0 &&  voidReportsArr.count ){
            
            [voidReportsArr removeAllObjects];
        }
        
        NSString * startDteStr = startDateTxt.text;
        
        if((startDateTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDateTxt.text,@" 00:00:00"];
        
        NSString *  endDteStr  = endDateTxt.text;
        
        if ((endDateTxt.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        }

        
        NSString * categoryStr      = categoryTxt.text;
        NSString * subCategoryStr   = subCategoryTxt.text;
        NSString * departmentStr    = departmentTxt.text;
        NSString * subDepartmentStr = subDepartmentTxt.text;
        NSString * brandStr         = brandTxt.text;
        NSString * sectionStr       = sectionTxt.text;
//        NSString * searchVoidStr    = searchItemsTxt.text;
        
        
        
        
        
        if(searchBtn.tag == 2){
            
            categoryStr      = @"";
            subCategoryStr   = @"";
            departmentStr    = @"";
            subDepartmentStr = @"";
            brandStr         = @"";
            sectionStr       = @"";
            startDteStr      = @"";
            endDteStr        = @"";
        }
        
        
        NSMutableDictionary * voidItemDic = [[NSMutableDictionary alloc] init];
        
        [voidItemDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [voidItemDic setValue:presentLocation forKey:STORE_LOCATION];
        [voidItemDic setValue:[NSString stringWithFormat:@"%d",startIndexInt] forKey:START_INDEX];
        [voidItemDic setValue:[NSString stringWithFormat:@"%d",10]  forKey:kRequiredRecords];
        [voidItemDic setValue:[NSNumber numberWithBool:false] forKey:IS_SAVE_REPORT];

        //added by Srinivasulu on 21/09/2017....
        
        [voidItemDic setValue:counterName forKey:@"counterId"];

        //upto here on 21/09/2017....
        
        
        [voidItemDic setValue:categoryStr forKey:kCategoryName];
        [voidItemDic setValue:@"" forKey:ZONE_Id];
        [voidItemDic setValue:subCategoryStr forKey:kSubCategory];
        [voidItemDic setValue:brandStr forKey:kBrand];
        [voidItemDic setValue:departmentStr forKey:kItemDept];
        [voidItemDic setValue:@"" forKey:SECTION];
        [voidItemDic setValue:@"" forKey:SUPPLIER_NAME];
        [voidItemDic setValue:searchStr forKey:SEARCH_CRITERIA];
        voidItemDic[START_DATE] = startDteStr;
        voidItemDic[END_DATE] = endDteStr;
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:voidItemDic options:0 error:&err];
        NSString * voidItemReportJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",voidItemReportJsonStr);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.salesServiceDelegate = self;
        [webServiceController getVoidItemsReport:voidItemReportJsonStr];

        
    } @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @finally {
        
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
 * @date         08/08/2017
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
 * @description  here we are calling the getModels services.....
 * @date         08/08/2017
 * @method       getModelList
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getModelList{
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        
        if (modelListArr == nil) {
            modelListArr  = [NSMutableArray new];
        }
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,kMaxRecords,STORE_LOCATION];
        NSArray *objects = @[[RequestHeader getRequestHeader],@0,@"10",presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * modelJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.modelMasterDelegate = self;
        [webServiceController  getModelDetails:modelJsonString];
        
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
 * @description  calling ProductClass method from SkuServices
 * @date         24/08/2017
 * @method       getProductClass
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getProductClass{
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        if (classArr == nil) {
            classArr  = [NSMutableArray new];
        }
        
        NSArray * keys = @[REQUEST_HEADER,START_INDEX,kMaxRecords,STORE_LOCATION];
        NSArray * objects = @[[RequestHeader getRequestHeader],@0,@"10",presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * classJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.skuServiceDelegate = self;
        [webServiceController  getProductClass:classJsonString];
        
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);
    } @finally {
        
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

-(void)getVoidItemReportsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        totalNumberOfReports= [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"]intValue];

        if (successDictionary.count) {
            for (NSDictionary * reportDic in [successDictionary valueForKey:@"reportsList"]) {
                
                [voidReportsArr addObject:reportDic];
            }
        }
   
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [voidItemsTbl reloadData];
    }
}

/**
 * @description we are displaying the error Response....
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

-(void)getVoidItemReportErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        if (startIndexInt == 0) {
            
            [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [voidItemsTbl reloadData];
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
    
    [HUD setHidden:YES];
    float y_axis = self.view.frame.size.height - 350;
    
    NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
    
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
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

-(void)getModelSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        
        
        
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

-(void)getModelErrorResponse:(NSString*)errorResponse {
    
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Handling the Response from the DataBase.....
 * @date         24/08/2017
 * @method       getProductClassSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getProductClassSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


/**
 * @description   displaying the Error Response...
 * @date         24/08/2017
 * @method       getProductClassErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getProductClassErrorResponse:(NSString *)errorResponse{
    
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
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
        
        [self showPopUpForTables:categoriesListTbl  popUpWidth:categoryTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        
        [self showPopUpForTables:subCategoriesListTbl  popUpWidth:subCategoryTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        
        [self showPopUpForTables:departmentListTbl  popUpWidth:departmentTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:departmentTxt  showViewIn:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        
        if(subDepartmentArr == nil ||  subDepartmentArr.count == 0){
            [HUD setHidden:NO];
            [self callingSubDepartmentList];
        }
        
        if(subDepartmentArr.count){
            float tableHeight = subDepartmentArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = subDepartmentArr.count * 33;
            
            if(subDepartmentArr.count > 5)
                tableHeight = (tableHeight/subDepartmentArr.count) * 5;
            
            [self showPopUpForTables:subDepartmentListTbl  popUpWidth:subDepartmentTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:subDepartmentTxt  showViewIn:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
            
            
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
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = brandListArray.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = brandListArray.count * 33;
        
        if(brandListArray.count > 5)
            tableHeight = (tableHeight/brandListArray.count) * 5;
        
        [self showPopUpForTables:brandListTbl  popUpWidth:brandTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
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
        
        [self showPopUpForTables:sectionTbl  popUpWidth:sectionTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:sectionTxt  showViewIn:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  we are trying to get the model data from the service  ...
 * @date         14/08/2017
 * @method       ShowModelList.
 * @author       Bhargav.v
 * @param        UIButton.
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showModelList:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((modelListArr == nil) || (modelListArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self getModelList];
        }
        [HUD setHidden:YES];
        
        if(modelListArr.count == 0){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = modelListArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = modelListArr.count * 33;
        
        if(modelListArr.count > 5)
            tableHeight = (tableHeight/modelListArr.count) * 5;
        
        [self showPopUpForTables:modelTbl  popUpWidth:modelTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:modelTxt  showViewIn:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
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

-(void)showClassList:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if((classArr == nil) || (classArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self getProductClass];
        }
        [HUD setHidden:YES];
        
        if(classArr.count == 0){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = classArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = classArr.count * 33;
        
        if(classArr.count > 5)
            tableHeight = (tableHeight/classArr.count) * 5;
        
        [self showPopUpForTables:sectionTbl  popUpWidth:classTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:classTxt  showViewIn:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
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
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0 && (brandTxt.text).length == 0 && (sectionTxt.text).length== 0 && (startDateTxt.text).length == 0 && (endDateTxt.text).length== 0 && (departmentTxt.text).length== 0 && (subDepartmentTxt.text).length== 0) {
            
            float y_axis = self.view.frame.size.height-200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert",nil),@"\n",NSLocalizedString(@"Please select above fields before proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        else
            [HUD setHidden:NO];
        startIndexInt = 0;
        voidReportsArr = [NSMutableArray new];
        [self getVoidItemReports:nil];
        
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
        brandTxt.text         = @"";
        sectionTxt.text       = @"";
        
        startIndexInt = 0;
        
        [self getVoidItemReports:nil];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception  viewWillDisappear------%@",exception);
        NSLog(@"--exception is-----%@",exception);
        
    } @finally {
        
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
            
            UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:startDateTxt.frame inView:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:voidItemsReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
                voidReportsArr = [NSMutableArray new];
                [self getVoidItemReports:searchItemsTxt.text];
                
                
            } @catch (NSException *exception) {
                NSLog(@"---- exception while calling ServicesCall ----%@",exception);
                
            } @finally {
                
            }
        }
        else if ((searchItemsTxt.text).length == 0){
            startIndexInt = 0;
            voidReportsArr = [NSMutableArray new];
            [self getVoidItemReports:nil];
        }

    }
}

#pragma mark UITableVIew Delegates....

/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         09/05/2017
 * @method       tableView: numberOfRowsInSectionL
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @verified By
 * @verified On
 *
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == voidItemsTbl) {
        if (voidReportsArr.count)
            
            return voidReportsArr.count;
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
    
    return 1;
}


/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == voidItemsTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 45;
        }
        else{
            
            return 45;
        }
    }
    else if (tableView == categoriesListTbl|| tableView == subCategoriesListTbl||tableView == departmentListTbl ||subDepartmentListTbl || tableView == brandListTbl ||tableView == sectionTbl ){
        
        return 45.0;
    }

    
    return 0.0;
    
}

 /**
 * @description  Customize the appearance of table view cells.
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (tableView == voidItemsTbl) {
      
        
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
      
        UILabel * slno_Lbl;
        UILabel * dateTime_Lbl;
        UILabel * userName_Lbl;
        UILabel * category_Lbl;
        UILabel * subCategory_Lbl;
        UILabel * section_Lbl;
        UILabel * department_Lbl;
        UILabel * location_Lbl;
        UILabel * zone_Lbl;
        UILabel * skuID_Lbl;
        UILabel * description_Lbl;
        UILabel * ean_Lbl;
        UILabel * void_item_Lbl;
        UILabel * original_Price_Lbl;
        
        
        /*Creation of UILabels used in this cell*/
        slno_Lbl = [[UILabel alloc] init];
        slno_Lbl.backgroundColor = [UIColor clearColor];
        slno_Lbl.textAlignment = NSTextAlignmentCenter;
        slno_Lbl.numberOfLines = 1;
        slno_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        dateTime_Lbl = [[UILabel alloc] init];
        dateTime_Lbl.backgroundColor = [UIColor clearColor];
        dateTime_Lbl.textAlignment = NSTextAlignmentCenter;
        dateTime_Lbl.numberOfLines = 1;
        dateTime_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        userName_Lbl = [[UILabel alloc] init];
        userName_Lbl.backgroundColor = [UIColor clearColor];
        userName_Lbl.textAlignment = NSTextAlignmentCenter;
        userName_Lbl.numberOfLines = 1;
        userName_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

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
        
        zone_Lbl = [[UILabel alloc] init];
        zone_Lbl.backgroundColor = [UIColor clearColor];
        zone_Lbl.textAlignment = NSTextAlignmentCenter;
        zone_Lbl.numberOfLines = 1;
        zone_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        skuID_Lbl = [[UILabel alloc] init];
        skuID_Lbl.backgroundColor = [UIColor clearColor];
        skuID_Lbl.textAlignment = NSTextAlignmentCenter;
        skuID_Lbl.numberOfLines = 1;
        skuID_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        description_Lbl = [[UILabel alloc] init];
        description_Lbl.backgroundColor = [UIColor clearColor];
        description_Lbl.textAlignment = NSTextAlignmentCenter;
        description_Lbl.numberOfLines = 1;
        description_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        
        ean_Lbl = [[UILabel alloc] init];
        ean_Lbl.backgroundColor = [UIColor clearColor];
        ean_Lbl.textAlignment = NSTextAlignmentCenter;
        ean_Lbl.numberOfLines = 1;
        ean_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        void_item_Lbl = [[UILabel alloc] init];
        void_item_Lbl.backgroundColor = [UIColor clearColor];
        void_item_Lbl.textAlignment = NSTextAlignmentCenter;
        void_item_Lbl.numberOfLines = 1;
        void_item_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        original_Price_Lbl = [[UILabel alloc] init];
        original_Price_Lbl.backgroundColor = [UIColor clearColor];
        original_Price_Lbl.textAlignment = NSTextAlignmentCenter;
        original_Price_Lbl.numberOfLines = 1;
        original_Price_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

        
        
        
        slno_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        dateTime_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        userName_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        category_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        subCategory_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        section_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        department_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        location_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        zone_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        skuID_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        description_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        ean_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        void_item_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        original_Price_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        // adding subViews for the...
        [hlcell.contentView addSubview:slno_Lbl];
        [hlcell.contentView addSubview:dateTime_Lbl];
        [hlcell.contentView addSubview:userName_Lbl];
        [hlcell.contentView addSubview:category_Lbl];
        [hlcell.contentView addSubview:category_Lbl];
        [hlcell.contentView addSubview:subCategory_Lbl];
        [hlcell.contentView addSubview:section_Lbl];
        [hlcell.contentView addSubview:department_Lbl];
        [hlcell.contentView addSubview:location_Lbl];
        [hlcell.contentView addSubview:zone_Lbl];
        [hlcell.contentView addSubview:skuID_Lbl];
        [hlcell.contentView addSubview:description_Lbl];
        [hlcell.contentView addSubview:ean_Lbl];
        [hlcell.contentView addSubview:void_item_Lbl];
        [hlcell.contentView addSubview:original_Price_Lbl];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            slno_Lbl.frame = CGRectMake(0,0,sNoLbl.frame.size.width,hlcell.frame.size.height);
            dateTime_Lbl.frame = CGRectMake(dateTimeLbl.frame.origin.x,0,dateTimeLbl.frame.size.width,hlcell.frame.size.height);
            userName_Lbl.frame = CGRectMake(userNameLbl.frame.origin.x,0,userNameLbl.frame.size.width,hlcell.frame.size.height);
            category_Lbl.frame = CGRectMake(categoryLbl.frame.origin.x,0,categoryLbl.frame.size.width,hlcell.frame.size.height);
            subCategory_Lbl.frame = CGRectMake(subCatLbl.frame.origin.x,0,subCatLbl.frame.size.width,hlcell.frame.size.height);
            section_Lbl.frame = CGRectMake(sectionLbl.frame.origin.x,0,sectionLbl.frame.size.width,hlcell.frame.size.height);
            department_Lbl.frame = CGRectMake(departmentLbl.frame.origin.x,0,departmentLbl.frame.size.width,hlcell.frame.size.height);
            location_Lbl.frame = CGRectMake(locationLbl.frame.origin.x,0,locationLbl.frame.size.width,hlcell.frame.size.height);
            zone_Lbl.frame = CGRectMake(zoneLbl.frame.origin.x,0,zoneLbl.frame.size.width,hlcell.frame.size.height);
            skuID_Lbl.frame = CGRectMake(skuIdLbl.frame.origin.x,0,skuIdLbl.frame.size.width,hlcell.frame.size.height);

            description_Lbl.frame = CGRectMake(descriptionLbl.frame.origin.x,0,descriptionLbl.frame.size.width,hlcell.frame.size.height);

            ean_Lbl.frame = CGRectMake(eanLbl.frame.origin.x,0,eanLbl.frame.size.width,hlcell.frame.size.height);

            void_item_Lbl.frame = CGRectMake(voidItemQtyLbl.frame.origin.x,0,voidItemQtyLbl.frame.size.width,hlcell.frame.size.height);

            original_Price_Lbl.frame = CGRectMake(originalPriceLbl.frame.origin.x,0,originalPriceLbl.frame.size.width,hlcell.frame.size.height);
            
        }
        else{
            
            //Code For the iPhone
        }
        //setting font size....
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];

        
        if (voidReportsArr.count >= indexPath.row && voidReportsArr.count) {
            
            NSDictionary * dic  = voidReportsArr[indexPath.row];
            
            slno_Lbl.text = [NSString stringWithFormat:@"%d",(indexPath.row+1)];
            
            dateTime_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:@"date"] componentsSeparatedByString:@" "][0]  defaultReturn:@"--"];
 
            userName_Lbl.text = @"--";
            
            category_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];
            
            subCategory_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kSubCategory] defaultReturn:@"--"];

            section_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SECTION] defaultReturn:@"--"];
          
            department_Lbl.text = @"--";

            location_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:LOCATION] defaultReturn:@"--"];
           
            zone_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"zone"] defaultReturn:@"--"];

            skuID_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@"--"];
           
            description_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESC] defaultReturn:@"--"];
            ean_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:EAN] defaultReturn:@"--"];
           
            void_item_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];

            original_Price_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:@"mrp"] defaultReturn:@"0.00"] floatValue]];

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


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        
        if(tableView == voidItemsTbl){
            
            @try {
                
                if ((indexPath.row == (voidReportsArr.count-1)) && (voidReportsArr.count < totalNumberOfReports) && (voidReportsArr.count> startIndexInt)) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    startIndexInt = startIndexInt +10;
                    [self getVoidItemReports:nil];
                   
                    //[hourReportTable reloadData];
                }
                
            } @catch (NSException * exception) {
                NSLog(@"-----------exception in servicecall-------------%@",exception);
                [HUD setHidden:YES];
            }
        }
    } @catch (NSException *exception) {
        
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
