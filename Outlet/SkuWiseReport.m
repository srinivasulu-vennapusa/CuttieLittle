//
//  SkuWiseReport.m
//  OmniRetailer
//
//  Created by technolans on 16/02/17.
//
//

#import <QuartzCore/QuartzCore.h>
#import "SkuWiseReport.h"
#import "Global.h"
#import "OmniHomePage.h"
#import "SalesReports.h"


@interface SkuWiseReport ()

@end

@implementation SkuWiseReport;
@synthesize soundFileURLRef,soundFileObject;
@synthesize bill,skuReportTable;


#pragma  -mark start of ViewLifeCycle mehods....
    
/*
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         07/08/2017
 * @method       ViewDidLoad
 * @author       Sai Krishna
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef)CFBridgingRetain(tapSound);
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    //  ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    

    self.view.backgroundColor = [UIColor blackColor];
    
    // UIView
    
    //creating the skuWiseReportView which will displayed completed Screen.......
    skuWiseReportView = [[UIView alloc] init];
    //skuWiseReportView.backgroundColor = [UIColor blueColor];
    skuWiseReportView.layer.borderWidth = 1.0f;
    skuWiseReportView.layer.cornerRadius = 10.0f;
    skuWiseReportView.layer.borderColor = [UIColor blackColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.backgroundColor = [UIColor clearColor];
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    
    
    //changing the headerNameLbl backGrouondColor & textColor.......
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.opacity = 5.0f;
    [headerNameLbl.layer addSublayer:bottomBorder];
    
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    //    headerNameLbl.backgroundColor = [UIColor clearColor];
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDateTxt.borderStyle=UITextBorderStyleRoundedRect;
    startDateTxt.delegate = self;
    [startDateTxt awakeFromNib];
    startDateTxt.userInteractionEnabled = NO;

    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDateTxt.borderStyle=UITextBorderStyleRoundedRect;
    endDateTxt.delegate = self;
    [endDateTxt awakeFromNib];
    endDateTxt.userInteractionEnabled = NO;
    
    
    
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.placeholder = NSLocalizedString(@"category", nil);
    categoryTxt.borderStyle=UITextBorderStyleRoundedRect;
    categoryTxt.delegate = self;
    [categoryTxt awakeFromNib];
    categoryTxt.userInteractionEnabled = NO;
    

   
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.placeholder = NSLocalizedString(@"sub_category", nil);
    subCategoryTxt.borderStyle=UITextBorderStyleRoundedRect;
    subCategoryTxt.delegate = self;
    [subCategoryTxt awakeFromNib];
    subCategoryTxt.userInteractionEnabled = NO;
    

    departmentTxt = [[CustomTextField alloc] init];
    departmentTxt.placeholder = NSLocalizedString(@"department", nil);
    departmentTxt.borderStyle=UITextBorderStyleRoundedRect;
    departmentTxt.delegate = self;
    [departmentTxt awakeFromNib];
    departmentTxt.userInteractionEnabled = NO;
    
    
    
    subDepartmentTxt = [[CustomTextField alloc] init];
    subDepartmentTxt.placeholder = NSLocalizedString(@"sub_department", nil);
    subDepartmentTxt.borderStyle=UITextBorderStyleRoundedRect;
    subDepartmentTxt.delegate = self;
    [subDepartmentTxt awakeFromNib];
    subDepartmentTxt.userInteractionEnabled = NO;
    
    
    
    brandTxt = [[CustomTextField alloc] init];
    brandTxt.placeholder = NSLocalizedString(@"brand", nil);
    brandTxt.borderStyle=UITextBorderStyleRoundedRect;
    brandTxt.delegate = self;
    [brandTxt awakeFromNib];
    brandTxt.userInteractionEnabled = NO;
    


    sectionTxt = [[CustomTextField alloc] init];
    sectionTxt.placeholder = NSLocalizedString(@"section",nil);
    sectionTxt.borderStyle=UITextBorderStyleRoundedRect;
    sectionTxt.delegate = self;
    [sectionTxt awakeFromNib];
    sectionTxt.userInteractionEnabled = NO;
    
    modelTxt = [[CustomTextField alloc] init];
    modelTxt.placeholder = NSLocalizedString(@"style",nil);
    modelTxt.borderStyle=UITextBorderStyleRoundedRect;
    modelTxt.delegate = self;
    [modelTxt awakeFromNib];
    modelTxt.userInteractionEnabled = NO;
    
    //Allocation of ClassTxt...
    classTxt = [[CustomTextField alloc] init];
    classTxt.placeholder = NSLocalizedString(@"class",nil);
    classTxt.borderStyle=UITextBorderStyleRoundedRect;
    classTxt.delegate = self;
    [classTxt awakeFromNib];
    classTxt.userInteractionEnabled = NO;
  
    
    //Allocation of UIButton....
    
    startOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startImageDate = [UIImage imageNamed:@"Calandar_Icon.png"];
    [startOrderButton setBackgroundImage:startImageDate forState:UIControlStateNormal];
    [startOrderButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    startOrderButton.tag = 2;
    
    
    endOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    endImageDate = [UIImage imageNamed:@"Calandar_Icon.png"];
    [endOrderButton setBackgroundImage:endImageDate forState:UIControlStateNormal];
    [endOrderButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    
    categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryImage = [UIImage imageNamed:@"arrow_1.png"];
    [categoryButton setBackgroundImage:categoryImage forState:UIControlStateNormal];
    [categoryButton addTarget:self action:@selector(showAllCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    subCategoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subCategoryImage = [UIImage imageNamed:@"arrow_1.png"];
    [subCategoryButton setBackgroundImage:subCategoryImage forState:UIControlStateNormal];
    [subCategoryButton addTarget:self action:@selector(showAllSubCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    
    departmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    departmentImage = [UIImage imageNamed:@"arrow_1.png"];
    [departmentButton setBackgroundImage:departmentImage forState:UIControlStateNormal];
    [departmentButton addTarget:self action:@selector(showDepartmentList:) forControlEvents:UIControlEventTouchDown];
    
    
    subDepartmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subDepartmentImage = [UIImage imageNamed:@"arrow_1.png"];
    [subDepartmentButton setBackgroundImage:subDepartmentImage forState:UIControlStateNormal];
    [subDepartmentButton addTarget:self action:@selector(showSubDepartmentList:) forControlEvents:UIControlEventTouchDown];
    
    
    brandButton = [UIButton buttonWithType:UIButtonTypeCustom];
    brandImage = [UIImage imageNamed:@"arrow_1.png"];
    [brandButton setBackgroundImage:brandImage forState:UIControlStateNormal];
    [brandButton addTarget:self action:@selector(showBrandList:) forControlEvents:UIControlEventTouchDown];
    
    
    sectionImage = [UIImage imageNamed:@"arrow_1.png"];
    
    //Allocation of Model buttton..
    UIButton * classBtn;
    classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [classBtn setBackgroundImage:sectionImage forState:UIControlStateNormal];
    [classBtn addTarget:self
                 action:@selector(showModelList:) forControlEvents:UIControlEventTouchDown];
    
    
    
    //Allocation of Model buttton..
    UIButton * modelBtn;
    modelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modelBtn setBackgroundImage:sectionImage forState:UIControlStateNormal];
    [modelBtn addTarget:self
                 action:@selector(showModelList:) forControlEvents:UIControlEventTouchDown];
    
    sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sectionButton setBackgroundImage:sectionImage forState:UIControlStateNormal];
    [sectionButton addTarget:self action:@selector(showSectionList:) forControlEvents:UIControlEventTouchDown];
    
    //end of UIButtons
    
    
    
    searchFieldTxt = [[CustomTextField alloc]init];
    searchFieldTxt.borderStyle=UITextBorderStyleRoundedRect;
    searchFieldTxt.placeholder=@"Search Field";
    searchFieldTxt.autocorrectionType=UITextAutocorrectionTypeNo;
    searchFieldTxt.backgroundColor=[UIColor lightGrayColor];
    searchFieldTxt.keyboardType=UIKeyboardTypeDefault;
    searchFieldTxt.clearButtonMode=UITextFieldViewModeWhileEditing;
    searchFieldTxt.userInteractionEnabled=YES;
    searchFieldTxt.delegate=self;
    [searchFieldTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    //added the below lines by Saikrishna Kumbhoji on 05/08/2017.......
    
    //allocation of tableviews in SkuWiseReports
    
    //categoriesListTbl creation...
    categoryTbl = [[UITableView alloc] init];
    categoryTbl.layer.borderWidth = 1.0;
    categoryTbl.layer.cornerRadius = 4.0;
    categoryTbl.layer.borderColor = [UIColor blackColor].CGColor;
    categoryTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    categoryTbl.dataSource = self;
    categoryTbl.delegate = self;
    
    
    subCategoryTbl = [[UITableView alloc] init];
    subCategoryTbl.layer.borderWidth = 1.0;
    subCategoryTbl.layer.cornerRadius = 4.0;
    subCategoryTbl.layer.borderColor = [UIColor blackColor].CGColor;
    subCategoryTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    subCategoryTbl.dataSource = self;
    subCategoryTbl.delegate = self;
    
    departmentTbl = [[UITableView alloc] init];
    departmentTbl.layer.borderWidth = 1.0;
    departmentTbl.layer.cornerRadius = 4.0;
    departmentTbl.layer.borderColor = [UIColor blackColor].CGColor;
    departmentTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    departmentTbl.dataSource = self;
    departmentTbl.delegate = self;
    
    subDepartmentTbl = [[UITableView alloc] init];
    subDepartmentTbl.layer.borderWidth = 1.0;
    subDepartmentTbl.layer.cornerRadius = 4.0;
    subDepartmentTbl.layer.borderColor = [UIColor blackColor].CGColor;
    subDepartmentTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    subDepartmentTbl.dataSource = self;
    subDepartmentTbl.delegate = self;
    
    brandTbl = [[UITableView alloc] init];
    brandTbl.layer.borderWidth = 1.0;
    brandTbl.layer.cornerRadius = 4.0;
    brandTbl.layer.borderColor = [UIColor blackColor].CGColor;
    brandTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    brandTbl.dataSource = self;
    brandTbl.delegate = self;
    
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
    
    //upto here as on 03/08/2017..........
    generateReport = [[UIButton alloc] init] ;
    [generateReport addTarget:self action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    generateReport.backgroundColor = [UIColor grayColor];
    generateReport.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    generateReport.layer.cornerRadius = 3.0f;
    generateReport.tag = 2;
    
    //added by Saikrishna Kumbhoji as on 04/08/2017........
    
    cancelBtn = [[UIButton alloc] init] ;
    [cancelBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    cancelBtn.layer.cornerRadius = 3.0f;
    
    //upto here as on 04/08/2017...........
    horizontalScrollView  = [[UIScrollView alloc] init];
//    horizontalScrollView.backgroundColor = [UIColor lightGrayColor];

   
    //Allocation of CustomLabels..
    slno = [[CustomLabel alloc] init];
    [slno awakeFromNib];

    skuId=[[CustomLabel alloc]init];
    [skuId awakeFromNib];

    //added by Saikrishna Kumbhoji on 02/08/2017....
  
    itemDes=[[CustomLabel alloc]init];
    [itemDes awakeFromNib];
    
    ean=[[CustomLabel alloc]init];
    [ean awakeFromNib];
    
    colour=[[CustomLabel alloc]init];
    [colour awakeFromNib];
    
    size=[[CustomLabel alloc]init];
    [size awakeFromNib];
    
    grade=[[CustomLabel alloc]init];
    [grade awakeFromNib];
    
    model=[[CustomLabel alloc]init];
    [model awakeFromNib];
    
    category=[[CustomLabel alloc]init];
    [category awakeFromNib];
    
    subCategory=[[CustomLabel alloc]init];
    [subCategory awakeFromNib];
    
    section=[[CustomLabel alloc]init];
    [section awakeFromNib];
    
    brand=[[CustomLabel alloc]init];
    [brand awakeFromNib];
    
    price=[[CustomLabel alloc]init];
    [price awakeFromNib];
   
    soldQty=[[CustomLabel alloc]init];
    [soldQty awakeFromNib];
    
    returnQty=[[CustomLabel alloc]init];
    [returnQty awakeFromNib];
    
    exchangeQty=[[CustomLabel alloc]init];
    [exchangeQty awakeFromNib];
    
    totalSale=[[CustomLabel alloc]init];
    [totalSale awakeFromNib];
    
    
    //Allocation of skuReportTable..
    skuReportTable = [[UITableView alloc]init];
    skuReportTable.backgroundColor = [UIColor blackColor];
    skuReportTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    skuReportTable.dataSource = self;
    skuReportTable.delegate = self;
    skuReportTable.bounces = TRUE;
    skuReportTable.layer.cornerRadius = 14;
    
    UILabel * underLine_1;
    
    underLine_1 = [[UILabel alloc] init];
    underLine_1.layer.masksToBounds = YES;
    underLine_1.numberOfLines = 2;
    underLine_1.textAlignment = NSTextAlignmentLeft;
    underLine_1.textColor = [UIColor whiteColor];
    underLine_1.backgroundColor = [UIColor grayColor];
    
    totalSoldQty = [[UILabel alloc] init];
    totalSoldQty.layer.masksToBounds = YES;
    totalSoldQty.numberOfLines = 2;
    totalSoldQty.textAlignment = NSTextAlignmentLeft;
    totalSoldQty.textColor = [UIColor whiteColor];
    
    totalSoldValue = [[UILabel alloc] init];
    totalSoldValue.layer.masksToBounds = YES;
    totalSoldValue.numberOfLines = 2;
    totalSoldValue.textAlignment = NSTextAlignmentLeft;
    totalSoldValue.textColor = [UIColor whiteColor];
    
    //Allocation Of UILabels to show the totalValue
    
    //Allocation of UIView....
    totalReportsView = [[UIView alloc]init];
    totalReportsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalReportsView.layer.borderWidth =3.0f;

    UILabel * totalLabel;
    
    totalLabel = [[UILabel alloc] init];
    totalLabel.layer.masksToBounds = YES;
    totalLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    totalLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalLabel.textAlignment= NSTextAlignmentCenter;
    
    totalReportsValueLbl = [[UILabel alloc] init];
    totalReportsValueLbl.numberOfLines = 2;
    totalReportsValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
    totalReportsValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    totalReportsValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalReportsValueLbl.textAlignment= NSTextAlignmentCenter;
    
    @try {
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        headerNameLbl.text = NSLocalizedString(@"sku_wise_reports",nil);
 
        slno.text = NSLocalizedString(@"S_NO",nil);
        skuId.text = NSLocalizedString(@"sku_id",nil);
        itemDes.text = NSLocalizedString(@"description",nil);
        ean.text = NSLocalizedString(@"ean",nil);
        colour.text = NSLocalizedString(@"colour",nil);
        size.text = NSLocalizedString(@"size",nil);
        grade.text = NSLocalizedString(@"grade",nil);
        model.text = NSLocalizedString(@"model",nil);
        category.text = NSLocalizedString(@"category",nil);
        subCategory.text = NSLocalizedString(@"sub_category",nil);
        section.text = NSLocalizedString(@"section",nil);
        brand.text = NSLocalizedString(@"brand",nil);
        price.text = NSLocalizedString(@"price",nil);
        soldQty.text = NSLocalizedString(@"sold_qty",nil);
        returnQty.text = NSLocalizedString(@"return_qty",nil);
        exchangeQty.text = NSLocalizedString(@"exchange_qty",nil);
        totalSale.text = NSLocalizedString(@"total_sale",nil);
        
        totalSoldQty.text = NSLocalizedString(@"total_sold_qty",nil);
        totalSoldValue.text = NSLocalizedString(@"total_sold_Value",nil);

        
        //setting title label text of the UIButton's....
        [generateReport setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];

//        totalLabel.text = NSLocalizedString(@"total_reports",nil);
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    totalSoldQty_1 = [[UILabel alloc] init];
    totalSoldQty_1.font = [UIFont systemFontOfSize:20.0f];
    totalSoldQty_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalSoldQty_1.layer.cornerRadius = 20.0f;
    totalSoldQty_1.layer.masksToBounds = YES;
    totalSoldQty_1.textAlignment = NSTextAlignmentRight;
  
    
    totalSoldValue_1 = [[UILabel alloc] init];
    totalSoldValue_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalSoldValue_1.layer.cornerRadius = 20.0f;
    totalSoldValue_1.layer.masksToBounds = YES;
    totalSoldValue_1.textAlignment = NSTextAlignmentRight;

    totalSoldQty_1.text = @"0.0";
    totalSoldValue_1.text = @"0.0";
    totalReportsValueLbl.text = @"0.0";

    [skuWiseReportView addSubview:locationText];
    [skuWiseReportView addSubview:locationBtn];
    [skuWiseReportView addSubview:startDateTxt];
    [skuWiseReportView addSubview:startOrderButton];
    [skuWiseReportView addSubview:endDateTxt];
    [skuWiseReportView addSubview:endOrderButton];
    [skuWiseReportView addSubview:generateReport];
    [skuWiseReportView addSubview:cancelBtn];
   
    //added by SaiKrishna Kumbhoji as on 03/08/2017.....
    
    //adding header label as subView....
    [skuWiseReportView addSubview:headerNameLbl];
    
    [skuWiseReportView addSubview:searchFieldTxt];
    
    [skuWiseReportView addSubview:categoryTxt];
    [skuWiseReportView addSubview:categoryButton];
    
    [skuWiseReportView addSubview:subCategoryTxt];
    [skuWiseReportView addSubview:subCategoryButton];
   
    [skuWiseReportView addSubview:departmentTxt];
    [skuWiseReportView addSubview:departmentButton];
    
    [skuWiseReportView addSubview:subDepartmentTxt];
    [skuWiseReportView addSubview:subDepartmentButton];
   
    [skuWiseReportView addSubview:brandTxt];
    [skuWiseReportView addSubview:brandButton];
    
    [skuWiseReportView addSubview:sectionTxt];
    [skuWiseReportView addSubview:sectionButton];
    
    [skuWiseReportView addSubview:classTxt];
    [skuWiseReportView addSubview:classBtn];
    
    [skuWiseReportView addSubview:modelTxt];
    [skuWiseReportView addSubview:modelBtn];
    
    [skuWiseReportView addSubview:searchFieldTxt];
    [horizontalScrollView addSubview:slno];
    [horizontalScrollView addSubview:skuId];
    [horizontalScrollView addSubview:itemDes];
    [horizontalScrollView addSubview:ean];
    [horizontalScrollView addSubview:colour];
    [horizontalScrollView addSubview:size];
    [horizontalScrollView addSubview:grade];
    [horizontalScrollView addSubview:model];
    [horizontalScrollView addSubview:category];
    [horizontalScrollView addSubview:subCategory];
    [horizontalScrollView addSubview:section];
    [horizontalScrollView addSubview:brand];
    [horizontalScrollView addSubview:price];
    [horizontalScrollView addSubview:soldQty];
    [horizontalScrollView addSubview:returnQty];
    [horizontalScrollView addSubview:exchangeQty];
    [horizontalScrollView addSubview:totalSale];
    [horizontalScrollView addSubview:skuReportTable];
    
    [skuWiseReportView addSubview:underLine_1];
    [skuWiseReportView addSubview:totalSoldQty];
    [skuWiseReportView addSubview:totalSoldValue];
    [skuWiseReportView addSubview:totalSoldQty_1];
    [skuWiseReportView addSubview:totalSoldValue_1];
    
    //[skuWiseReportView addSubview:totalReportsView];
    //[totalReportsView addSubview:totalLabel];
    //[totalReportsView addSubview:totalReportsValueLbl];
    
    [skuWiseReportView addSubview:horizontalScrollView];
    
    [self.view addSubview:skuWiseReportView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        skuWiseReportView.frame = CGRectMake(2,70,self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        headerNameLbl.frame = CGRectMake(0,0,skuWiseReportView.frame.size.width,45);
        
        
        float textFieldWidth = 160;
        float textFieldHeight = 40;
        float verticalGap = 20;
        float horizontalGap = 10;
       
        //Frame for the categoryTxt
        categoryTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+verticalGap,textFieldWidth,textFieldHeight);
        
        //Frame for the brandTxt....
        brandTxt.frame = CGRectMake(categoryTxt.frame.origin.x+categoryTxt.frame.size.width+horizontalGap,categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the brandTxt
        departmentTxt.frame = CGRectMake(brandTxt.frame.origin.x+brandTxt.frame.size.width+horizontalGap, categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the startDateTxt
        modelTxt.frame = CGRectMake(departmentTxt.frame.origin.x+departmentTxt.frame.size.width+horizontalGap,categoryTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
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
        categoryButton.frame = CGRectMake((categoryTxt.frame.origin.x+categoryTxt.frame.size.width-45),categoryTxt.frame.origin.y-8,55,60);
        subCategoryButton.frame = CGRectMake((subCategoryTxt.frame.origin.x+subCategoryTxt.frame.size.width-45),subCategoryTxt.frame.origin.y-8,55,60);
        
        departmentButton.frame = CGRectMake((departmentTxt.frame.origin.x+departmentTxt.frame.size.width-45),departmentTxt.frame.origin.y-8,55,60);
       
        subDepartmentButton.frame = CGRectMake((subDepartmentTxt.frame.origin.x+subDepartmentTxt.frame.size.width-45),subDepartmentTxt.frame.origin.y-8,55,60);
        
        brandButton.frame = CGRectMake((brandTxt.frame.origin.x+brandTxt.frame.size.width-45),brandTxt.frame.origin.y-8,55,60);
        
        sectionButton.frame = CGRectMake((sectionTxt.frame.origin.x+sectionTxt.frame.size.width-45),sectionTxt.frame.origin.y-8,55,60);
        
        modelBtn.frame = CGRectMake((modelTxt.frame.origin.x+modelTxt.frame.size.width-45),modelTxt.frame.origin.y-8,55,60);
        
        classBtn.frame = CGRectMake((classTxt.frame.origin.x+classTxt.frame.size.width-45),classTxt.frame.origin.y-8,55,60);

        //Frame for the startDteBtn..
        startOrderButton.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-40), startDateTxt.frame.origin.y+2, 35, 30);
        
        //Frame for the endDteBtn..
        endOrderButton.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-40),endDateTxt.frame.origin.y+2,35,30);
        
         //frame for the UITextField..
        searchFieldTxt.frame = CGRectMake(categoryTxt.frame.origin.x,skuWiseReportView.frame.origin.y+110,skuWiseReportView.frame.size.width - (categoryTxt.frame.origin.x+cancelBtn.frame.size.width) - 10,40);
        
        generateReport.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap+10),categoryTxt.frame.origin.y,140,45);
        
        cancelBtn.frame = CGRectMake(generateReport.frame.origin.x,subCategoryTxt.frame.origin.y,generateReport.frame.size.width,generateReport.frame.size.height);

        underLine_1.frame = CGRectMake(searchFieldTxt.frame.origin.x +searchFieldTxt.frame.size.width-250,skuWiseReportView.frame.size.height-60,260,2);

        totalSoldQty.frame = CGRectMake(underLine_1.frame.origin.x, underLine_1.frame.origin.y + underLine_1.frame.size.height+2,180,30);
        
        totalSoldValue.frame = CGRectMake(totalSoldQty.frame.origin.x,totalSoldQty.frame.origin.y+totalSoldQty.frame.size.height+2,totalSoldQty.frame.size.width,30);
        
        totalSoldQty_1.frame = CGRectMake(totalSoldQty.frame.origin.x+totalSoldQty.frame.size.width-100,totalSoldQty.frame.origin.y,totalSoldQty.frame.size.width,totalSoldQty.frame.size.height);
        
        totalSoldValue_1.frame = CGRectMake(totalSoldQty_1.frame.origin.x,totalSoldValue.frame.origin.y, totalSoldValue.frame.size.width,totalSoldQty.frame.size.height);

        horizontalScrollView.frame = CGRectMake(10,searchFieldTxt.frame.origin.y + searchFieldTxt.frame.size.height + 10,searchFieldTxt.frame.size.width + 100,(underLine_1.frame.origin.y-(searchFieldTxt.frame.origin.y + searchFieldTxt.frame.size.height +20)));
        
        //Frames for the CustomLabels
        
        slno.frame=CGRectMake(0,0,60,40);
        
        skuId.frame=CGRectMake(slno.frame.origin.x+slno.frame.size.width+2, slno.frame.origin.y,80,40);
        
        itemDes.frame=CGRectMake(skuId.frame.origin.x+skuId.frame.size.width+2, skuId.frame.origin.y,140,40);
        
        ean.frame=CGRectMake(itemDes.frame.origin.x+itemDes.frame.size.width+2, itemDes.frame.origin.y,100,40);
        
        colour.frame=CGRectMake(ean.frame.origin.x+ean.frame.size.width+2,ean.frame.origin.y,80,40);
        
        size.frame=CGRectMake(colour.frame.origin.x+colour.frame.size.width+2,colour.frame.origin.y,80,40);
        
        grade.frame=CGRectMake(size.frame.origin.x+size.frame.size.width+2,size.frame.origin.y,80, 40);
        
        model.frame=CGRectMake(grade.frame.origin.x+grade.frame.size.width+2, grade.frame.origin.y,80,40);
        
        category.frame=CGRectMake(model.frame.origin.x+model.frame.size.width+2, model.frame.origin.y,100,40);
        
        subCategory.frame=CGRectMake(category.frame.origin.x+category.frame.size.width+2,category.frame.origin.y, 120,40);
        
        section.frame=CGRectMake(subCategory.frame.origin.x+subCategory.frame.size.width+2, subCategory.frame.origin.y,100,40);
        
        brand.frame=CGRectMake(section.frame.origin.x+section.frame.size.width+2, section.frame.origin.y,100,40);
        
        price.frame=CGRectMake(brand.frame.origin.x+brand.frame.size.width+2, brand.frame.origin.y,100,40);
        
        soldQty.frame=CGRectMake(price.frame.origin.x+price.frame.size.width+2, price.frame.origin.y,100,40);
        
        returnQty.frame=CGRectMake(soldQty.frame.origin.x+soldQty.frame.size.width+2, soldQty.frame.origin.y,100,40);
        exchangeQty.frame=CGRectMake(returnQty.frame.origin.x+returnQty.frame.size.width+2, returnQty.frame.origin.y,110,40);
        
        totalSale.frame=CGRectMake(exchangeQty.frame.origin.x+exchangeQty.frame.size.width+2, exchangeQty.frame.origin.y,100,40);
       
        skuReportTable.frame = CGRectMake(slno.frame.origin.x,slno.frame.origin.y +slno.frame.size.height + 10, totalSale.frame.origin.x + totalSale.frame.size.width - slno.frame.origin.x,horizontalScrollView.frame.size.height);
    
          horizontalScrollView.contentSize = CGSizeMake(skuReportTable.frame.size.width+100,horizontalScrollView.frame.size.height);

        totalReportsView.frame = CGRectMake(slno.frame.origin.x+10,horizontalScrollView.frame.origin.y+horizontalScrollView.frame.size.height+30,itemDes.frame.origin.x+itemDes.frame.size.width-(slno.frame.origin.x+40),slno.frame.size.height);
        
        //Frames for the UILabels under the totalReportsView
        
        totalLabel.frame = CGRectMake(0,0,160,40);
        totalReportsValueLbl.frame = CGRectMake(totalLabel.frame.origin.x+totalLabel.frame.size.width-40,totalLabel.frame.origin.y,itemDes.frame.size.width,totalLabel.frame.size.height);
    }
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    generateReport.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    cancelBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
}

    /**
* @description  EXecuted after the VeiwDidLoad Execution
* @date
* @method       viewDidAppear
* @author       SAI KRISHNA
* @param        BOOL
* @param
* @return
* @verified By
* @verified On
*/
    
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self callingSkuServiceforRecords];
}

#pragma mark end of lifecycle Methods....
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 
* @method: calling sku ServiceForRecords

*/

// Commented by roja on 17/10/2019.. // reason :- callingSkuServiceforRecords method contains SOAP Service call .. so taken new method with same name(callingSkuServiceforRecords) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void) callingSkuServiceforRecords{
//    NSDate * today = [NSDate date];
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"dd/MM/yyyy";
//    NSString* currentdate = [formatter stringFromDate:today];
//
//    if ((startDateTxt.text).length>0) {
//
//        currentdate = [startDateTxt.text copy];
//    }
//
//    if (!isOfflineService) {
//        @try {
//
//            [HUD show:YES];
//            [HUD setHidden:NO];
//
//            NSString * categoryStr = categoryTxt.text;
//            NSString * subCategoryStr = subCategoryTxt.text;
//            NSString * departmentStr = departmentTxt.text;
//            NSString * subDepartmentStr = subDepartmentTxt.text;
//            NSString * brandStr = brandTxt.text;
//            NSString * sectionStr = sectionTxt.text;
//
//            NSString * startDateStr = @"";
//
//            if((startDateTxt.text).length > 0)
//                startDateStr = [NSString stringWithFormat:@"%@%@", startDateTxt.text,@" 00:00:00"];
//
//            NSString * endDteStr = @"";
//
//            if ((endDateTxt.text).length>0) {
//                endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
//            }
//
//            NSMutableDictionary * reports = [[NSMutableDictionary alloc]init];
//            reports[@"date"] = currentdate;
//            reports[@"startDate"] = startDateStr;
//            reports[@"endDate"] = endDteStr;
//            reports[@"shiftId"] = shiftId;
//            reports[@"paymentMode"] = @"";
//            reports[@"store_location"] = presentLocation;
//
//            NSString * searchStr = @"";
//
//            reports[@"searchCriteria"] = @"skuSales";
//
//            searchStr = searchFieldTxt.text;
//
//            reports[@"searchCriteriaStr"] = searchStr;
//
//            //[reports setObject:@"skuSales" forKey:@"searchCriteria"];
//            reports[@"counterId"] = @"";
//
//            reports[@"requiredRecords"] = [NSString stringWithFormat:@"%i",10];
//
//            reports[@"startIndex"] = [NSString stringWithFormat:@"%i",reportStartIndex];
//            reports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
//            reports[@"searchName"] = @"";
//
//            if(generateReport.tag == 2){
//                categoryStr = @"";
//                subCategoryStr = @"";
//                departmentStr = @"";
//                subDepartmentStr = @"";
//                brandStr = @"";
//                sectionStr = @"";
//                startDateStr = @"";
//                endDteStr = @"";
//            }
//
//            reports[kcategory] = categoryStr;
//            reports[kSubCategory] = subCategoryStr;
//            reports[kItemDept] = departmentStr;
//            reports[kItemSubDept] = subDepartmentStr;
//            reports[kBrand] = brandStr;
//            reports[SECTION] = sectionStr;
//
//            NSError *err;
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
//            NSString *reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            item = [[NSMutableArray alloc] init];
//
//            SalesServiceSvcSoapBinding *salesBindng =  [SalesServiceSvc SalesServiceSvcSoapBinding];
//            SalesServiceSvc_getSalesReports *aParameters =  [[SalesServiceSvc_getSalesReports alloc] init];
//
//
//            aParameters.searchCriteria = reportsJsonString;
//            SalesServiceSvcSoapBindingResponse *response = [salesBindng getSalesReportsUsingParameters:aParameters];
//
//            NSArray *responseBodyParts = response.bodyParts;
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[SalesServiceSvc_getSalesReportsResponse class]]) {
//                    SalesServiceSvc_getSalesReportsResponse *body = (SalesServiceSvc_getSalesReportsResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//
//                    NSError *e;
//                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                         options: NSJSONReadingMutableContainers
//                                                                           error: &e];
//
//                    if (![body.return_ isKindOfClass:[NSNull class]]) {
//
//                        @try {
//
//                            if (skuWiseArr == nil && reportStartIndex == 0) {
//
//                                totalRecordsInt = 0;
//
//                                skuWiseArr = [NSMutableArray new];
//
//                            }
//                            else if (reportStartIndex == 0  && skuWiseArr.count) {
//
//                                [skuWiseArr removeAllObjects];
//
//                            }
//
//                            NSDictionary  *json1 = JSON[RESPONSE_HEADER];
//
//                            if ([json1[RESPONSE_CODE]intValue] == 0) {
//
//                                totalRecordsInt = [[JSON valueForKey:@"totalRecords"] intValue];
//
//                                for (NSDictionary * skuWiseDic in [JSON valueForKey:@"itemReportList" ]  ) {
//
//                                    [skuWiseArr addObject:skuWiseDic];
//                                }
//
//                                totalSoldQty_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[JSON valueForKey:@"totalSoldQty"] defaultReturn:@"0.00"] floatValue]];
//
//                                 totalSoldValue_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[JSON valueForKey:@"totalSoldValue"] defaultReturn:@"0.00"] floatValue]];
//
//                                totalReportsValueLbl.text = [NSString stringWithFormat:@"%.2f", [[JSON valueForKey:TOTAL_BILLS] floatValue]];
//                            }
//                            else{
//
//                                    if (reportStartIndex == 0) {
//
//                                        [self displayAlertMessage:NSLocalizedString(@"No Records Found",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//
//                                        totalSoldQty_1.text  = @"0.0";
//                                        totalSoldValue_1.text  = @"0.0";
//                                        totalReportsValueLbl.text = @"0.0";
//                                }
//                            }
//                        }
//                        @catch (NSException * exception) {
//
//                        }
//                        @finally {
//                            [skuReportTable reloadData];
//                            [HUD setHidden:YES];
//                        }
//                    }
//
//                }
//            }
//
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the reports" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//
//    }
//}





//callingSkuServiceforRecords method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void) callingSkuServiceforRecords{
    NSDate * today = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [formatter stringFromDate:today];
    
    if ((startDateTxt.text).length>0) {
        
        currentdate = [startDateTxt.text copy];
    }
    
    if (!isOfflineService) {
        
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
            reports[@"date"] = currentdate;
            reports[@"startDate"] = startDateStr;
            reports[@"endDate"] = endDteStr;
            reports[@"shiftId"] = shiftId;
            reports[@"paymentMode"] = @"";
            reports[@"store_location"] = presentLocation;
            
            NSString * searchStr = @"";
            
            reports[@"searchCriteria"] = @"skuSales";
            
            searchStr = searchFieldTxt.text;
            
            reports[@"searchCriteriaStr"] = searchStr;
            
            //[reports setObject:@"skuSales" forKey:@"searchCriteria"];
            reports[@"counterId"] = @"";
            
            reports[@"requiredRecords"] = [NSString stringWithFormat:@"%i",10];
            
            reports[@"startIndex"] = [NSString stringWithFormat:@"%i",reportStartIndex];
            reports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            reports[@"searchName"] = @"";
            
            if(generateReport.tag == 2){
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
            
            NSError *err;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
            NSString *reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            item = [[NSMutableArray alloc] init];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.salesServiceDelegate = self;
            [services getSalesReport:reportsJsonString];
            
        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the reports" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }
}



// added by Roja on 17/10/2019…. // Old code only written below
- (void)getSalesReportsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        if (skuWiseArr == nil && reportStartIndex == 0) {
            
            totalRecordsInt = 0;
            skuWiseArr = [NSMutableArray new];
        }
        else if (reportStartIndex == 0  && skuWiseArr.count) {
            
            [skuWiseArr removeAllObjects];
        }
        
        NSDictionary  *json1 = successDictionary[RESPONSE_HEADER];
        
        if ([json1[RESPONSE_CODE]intValue] == 0) {
            
            totalRecordsInt = [[successDictionary valueForKey:@"totalRecords"] intValue];
            
            for (NSDictionary * skuWiseDic in [successDictionary valueForKey:@"itemReportList" ]  ) {
                
                [skuWiseArr addObject:skuWiseDic];
            }
            
            totalSoldQty_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totalSoldQty"] defaultReturn:@"0.00"] floatValue]];
            
            totalSoldValue_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totalSoldValue"] defaultReturn:@"0.00"] floatValue]];
            
            totalReportsValueLbl.text = [NSString stringWithFormat:@"%.2f", [[successDictionary valueForKey:TOTAL_BILLS] floatValue]];
        }
        else{
            
            if (reportStartIndex == 0) {
                
                [self displayAlertMessage:NSLocalizedString(@"No Records Found",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                totalSoldQty_1.text  = @"0.0";
                totalSoldValue_1.text  = @"0.0";
                totalReportsValueLbl.text = @"0.0";
            }
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
        [skuReportTable reloadData];
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // Old code only written below
- (void)getSalesReportsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        
        [skuReportTable reloadData];
        [HUD setHidden:YES];
    }
}

#pragma -mark displaying calendar:

/**
 * @description  here we are showing the calenderView.......
 * @date         01/03/2017
 * @method       showCalenderInPopUp
 * @author       Bhargav
 * @param        UIButton
 * @param
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        NSLog(@"----exception in the taxReportsView in showCalenderInPopUp:----%@",exception);
        
    }
    
}

/**
 * @description  clear the date from textField and calling services.......
 * @date         08/08/2017.........
 * @method       clearDate:
 * @author       Saikrishha Kumbhoji
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)clearDate:(UIButton *)sender{
    //    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(  sender.tag == 2){
            if((startDateTxt.text).length)
                //                callServices = true;
                startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                //                callServices = true;
                endDateTxt.text = @"";
        }
        
        //       if(callServices){
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
        
        NSDate *existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if(  sender.tag == 2){
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDateTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
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
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Closed date should not be earlier than start date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
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

/** Table Implementation */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == skuReportTable) {
        return skuWiseArr.count;
    }
    else if(tableView == categoryTbl){
        return categoryArr.count;
    }
    else if(tableView == subCategoryTbl){
        return subCategoryArr.count;
    }
    else if(tableView == departmentTbl){
        return departmentArr.count;
    }
    else if(tableView == subDepartmentTbl){
        return subDepartmentArr.count;
    }
    else if(tableView == brandTbl){
        return brandArr.count;
    }
    else if(tableView == sectionTbl){
        return sectionArr.count;
    }

    else return 0;
}


//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == skuReportTable) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 40;
        }
        else{
            return 45;
        }
    }
    else if (tableView == categoryTbl|| tableView == subCategoryTbl||tableView == departmentTbl ||subDepartmentTbl || tableView == brandTbl ||tableView == sectionTbl ){
        
        return 45.0;
    }
    else return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView == skuReportTable) {
        
        static NSString * hlCellID = @"hlCellID";
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.separatorColor = [UIColor clearColor];
        
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
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
           
              if (!isOfflineService) {
         
                    UILabel *slno_1 = [[UILabel alloc] init] ;
                    slno_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    slno_1.layer.masksToBounds = YES;
                    slno_1.textAlignment = NSTextAlignmentCenter;
                  
                    UILabel * skuId_1 = [[UILabel alloc] init];
                    skuId_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    skuId_1.layer.masksToBounds = YES;
                    skuId_1.textAlignment = NSTextAlignmentCenter;
                  
                  
                    UILabel *itemDes_1 = [[UILabel alloc] init];
                    itemDes_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    itemDes_1.layer.masksToBounds = YES;
                    itemDes_1.textAlignment = NSTextAlignmentCenter;
                  
                  //added by Saikrishna Kumbhoji on 01/08/2017......
                  
                  UILabel * ean_1 = [[UILabel alloc] init];
                  ean_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  ean_1.layer.masksToBounds = YES;
                  ean_1.textAlignment = NSTextAlignmentCenter;
                  
                  UILabel * colour_1 = [[UILabel alloc] init];
                  colour_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  colour_1.layer.masksToBounds = YES;
                  colour_1.textAlignment = NSTextAlignmentCenter;
                  
                  
                  UILabel * size_1 = [[UILabel alloc] init];
                  size_1.font = [UIFont systemFontOfSize:18.0f];
                  size_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  size_1.layer.cornerRadius = 20.0f;
                  size_1.layer.masksToBounds = YES;
                  size_1.textAlignment = NSTextAlignmentCenter;
                  
                  UILabel * grade_1 = [[UILabel alloc] init];
                  grade_1.font = [UIFont systemFontOfSize:18.0f];
                  grade_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  grade_1.layer.cornerRadius = 20.0f;
                  grade_1.layer.masksToBounds = YES;
                  grade_1.textAlignment = NSTextAlignmentCenter;
                  
                  
                  UILabel * model_1 = [[UILabel alloc] init];
                  model_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  model_1.layer.masksToBounds = YES;
                  model_1.textAlignment = NSTextAlignmentCenter;
                  
                  UILabel * category_1 = [[UILabel alloc] init];
                  category_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  category_1.layer.masksToBounds = YES;
                  category_1.textAlignment = NSTextAlignmentCenter;
                
                  UILabel * subCategory_1 = [[UILabel alloc] init];
                  subCategory_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  subCategory_1.layer.masksToBounds = YES;
                  subCategory_1.textAlignment = NSTextAlignmentCenter;

                  
                  UILabel * section_1 = [[UILabel alloc] init];
                  section_1.font = [UIFont systemFontOfSize:18.0f];
                  section_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  section_1.layer.cornerRadius = 20.0f;
                  section_1.layer.masksToBounds = YES;
                  section_1.textAlignment = NSTextAlignmentCenter;
                  

                  UILabel * brand_1 = [[UILabel alloc] init];
                  brand_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  brand_1.layer.masksToBounds = YES;
                  brand_1.textAlignment = NSTextAlignmentCenter;
     
                  UILabel *price_1 = [[UILabel alloc] init];
                  price_1.font = [UIFont systemFontOfSize:18.0f];
                  price_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  price_1.layer.cornerRadius = 20.0f;
                  price_1.layer.masksToBounds = YES;
                  price_1.textAlignment = NSTextAlignmentCenter;
                  
                  UILabel *soldQty_1 = [[UILabel alloc] init];
                  soldQty_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  soldQty_1.layer.masksToBounds = YES;
                  soldQty_1.textAlignment = NSTextAlignmentCenter;
                  
                  UILabel * returnQty_1 = [[UILabel alloc] init];
                  returnQty_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  returnQty_1.layer.masksToBounds = YES;
                  returnQty_1.textAlignment = NSTextAlignmentCenter;
                  
                  UILabel * exchangeQty_1 = [[UILabel alloc] init];
                  exchangeQty_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  exchangeQty_1.layer.masksToBounds = YES;
                  exchangeQty_1.textAlignment = NSTextAlignmentCenter;
                  
                  UILabel *totalSale_1 = [[UILabel alloc] init];
                  totalSale_1.font = [UIFont systemFontOfSize:18.0f];
                  totalSale_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                  totalSale_1.layer.cornerRadius = 20.0f;
                  totalSale_1.layer.masksToBounds = YES;
                  totalSale_1.textAlignment = NSTextAlignmentCenter;
                  
                  
                  
                  
                  slno_1.frame = CGRectMake(0,0,slno.frame.size.width,hlcell.frame.size.height);
                  
                  skuId_1.frame = CGRectMake(skuId.frame.origin.x,0,skuId.frame.size.width,hlcell.frame.size.height);
                  itemDes_1.frame = CGRectMake(itemDes.frame.origin.x,0,itemDes.frame.size.width,hlcell.frame.size.height);
                  ean_1.frame = CGRectMake(ean.frame.origin.x,0,ean.frame.size.width,hlcell.frame.size.height);
                  
                  colour_1.frame = CGRectMake(colour.frame.origin.x,0,colour.frame.size.width,hlcell.frame.size.height);
                  size_1.frame = CGRectMake(size.frame.origin.x,0,size.frame.size.width,hlcell.frame.size.height);
                  
                  grade_1.frame = CGRectMake(grade.frame.origin.x, 0,grade.frame.size.width,hlcell.frame.size.height);
                  model_1.frame = CGRectMake(model.frame.origin.x, 0, model.frame.size.width,  hlcell.frame.size.height);
                  category_1.frame = CGRectMake(category.frame.origin.x,0,category.frame.size.width,  hlcell.frame.size.height);
                  subCategory_1.frame = CGRectMake(subCategory.frame.origin.x,0,subCategory.frame.size.width,  hlcell.frame.size.height);
                  section_1.frame = CGRectMake(section.frame.origin.x,0,section.frame.size.width,hlcell.frame.size.height);
                  brand_1.frame = CGRectMake(brand.frame.origin.x, 0, brand.frame.size.width,hlcell.frame.size.height);
                  price_1.frame = CGRectMake(price.frame.origin.x,0,price.frame.size.width,hlcell.frame.size.height);
                  soldQty_1.frame = CGRectMake(soldQty.frame.origin.x,0,soldQty.frame.size.width,hlcell.frame.size.height);
                  returnQty_1.frame = CGRectMake(returnQty.frame.origin.x,0,returnQty.frame.size.width,hlcell.frame.size.height);
                  exchangeQty_1.frame = CGRectMake(exchangeQty.frame.origin.x,0,exchangeQty.frame.size.width,  hlcell.frame.size.height);
                  totalSale_1.frame = CGRectMake(totalSale.frame.origin.x,0,totalSale.frame.size.width+2,hlcell.frame.size.height);

                  //setting font size....
                  [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];

                    [hlcell.contentView addSubview:slno_1];
                    [hlcell.contentView addSubview:skuId_1];
                    [hlcell.contentView addSubview:itemDes_1];
                    [hlcell.contentView addSubview:ean_1];
                    [hlcell.contentView addSubview:colour_1];
                    [hlcell.contentView addSubview:size_1];
                    [hlcell.contentView addSubview:grade_1];
                    [hlcell.contentView addSubview:model_1];
                    [hlcell.contentView addSubview:category_1];
                    [hlcell.contentView addSubview:subCategory_1];
                    [hlcell.contentView addSubview:section_1];
                    [hlcell.contentView addSubview:brand_1];
                    [hlcell.contentView addSubview:price_1];
                    [hlcell.contentView addSubview:soldQty_1];
                    [hlcell.contentView addSubview:returnQty_1];
                    [hlcell.contentView addSubview:exchangeQty_1];
                    [hlcell.contentView addSubview:totalSale_1];
                  
                
                  @try {
                      NSDictionary *summaryDic = skuWiseArr[indexPath.row];
                      
                      slno_1.text = [NSString stringWithFormat:@"%d",(indexPath.row +1)] ;
                      
                      skuId_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"skuId"] defaultReturn:@"--"];
                      
                      itemDes_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"itemDescription"] defaultReturn:@"--"];
                      
                      ean_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"ean"] defaultReturn:@"0.00"] floatValue]];
                      
                      colour_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"colour"] defaultReturn:@"--"];
                      // size_1.text = [self checkGivenValueIsNullOrNil: defaultReturn:@"--"];
                      
                      size_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"size"] defaultReturn:@"0.00"] floatValue]];
                      
                      grade_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"grade"] defaultReturn:@"--"];
                      
                      model_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"model"] defaultReturn:@"--"];
                      
                      category_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"category"] defaultReturn:@"--"];
                      
                      subCategory_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"subCategory"] defaultReturn:@"--"];
                      
                      section_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"section"] defaultReturn:@"--"];
                      
                      brand_1.text = [self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"brand"] defaultReturn:@"--"];
                      
                      price_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"itemUnitPrice"] defaultReturn:@"0.00"] floatValue]];
                      
                      soldQty_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"soldQty"] defaultReturn:@"0.00"] floatValue]];
                      
                      returnQty_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"returnedQty"] defaultReturn:@"0.00"] floatValue]];
                      
                      exchangeQty_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"exchangedQty"] defaultReturn:@"0.00"] floatValue]];
                      
                      totalSale_1.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:@"totalCost"] defaultReturn:@"0.00"] floatValue]];
                  } @catch (NSException *exception) {
                      
                  }
                  
                  
                  
                }
         }
     
        hlcell.backgroundColor = [UIColor clearColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
    }
    else if(tableView == categoryTbl){
        
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
            hlcell.textLabel.text = categoryArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    else if(tableView == subCategoryTbl){
        
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
            hlcell.textLabel.text = subCategoryArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    else if(tableView == departmentTbl){
        
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
            hlcell.textLabel.text = departmentArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    
    else if(tableView == subDepartmentTbl){
        
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
            hlcell.textLabel.text = subDepartmentArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    else if(tableView == brandTbl){
        
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
            hlcell.textLabel.text = brandArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    else if(tableView == sectionTbl){
        
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
            hlcell.textLabel.text = sectionArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }

    else return false;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        
        if(tableView == skuReportTable){
            
            @try {
                
                if ((indexPath.row == (skuWiseArr.count -1)) && (skuWiseArr.count < totalRecordsInt ) && (skuWiseArr.count> reportStartIndex )) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    reportStartIndex = reportStartIndex + 10;
                    [self callingSkuServiceforRecords];
                    [skuReportTable reloadData];

                }
                
            } @catch (NSException *exception) {
                NSLog(@"-----------exception in servicecall-------------%@",exception);
                [HUD setHidden:YES];
            }
        }
    } @catch (NSException *exception) {
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == categoryTbl){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            categoryTxt.text = categoryArr[indexPath.row];
            
            subCategoryTxt.text = @"";
            
            if(subCategoryArr.count)
                [subCategoryArr removeAllObjects];
            
            
        } @catch (NSException *exception) {
            
        }
        @finally{
            
            [catPopOver dismissPopoverAnimated:YES];
        }
        
    }
    else if(tableView == subCategoryTbl){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            subCategoryTxt.text = subCategoryArr[indexPath.row];
            
            
            
        } @catch (NSException *exception) {
            
        }
        @finally{
            [catPopOver dismissPopoverAnimated:YES];
        }
    }
    
        else if(tableView == departmentTbl){
            //Play Audio for button touch....
            AudioServicesPlaySystemSound (soundFileObject);
    
            @try {
    
                departmentTxt.text = departmentArr[indexPath.row];
    
                departmentTbl.tag = indexPath.row;
                subDepartmentTbl.tag = -2;
    
                subDepartmentTxt.text = @"";
    
                subDepartmentArr = [[dept_SubDeptDic valueForKey:departmentArr[indexPath.row]] mutableCopy];
    
    
            } @catch (NSException *exception) {
    
            }@finally{
                [catPopOver dismissPopoverAnimated:YES];
            }
    
        }
        else if(tableView == subDepartmentTbl){
            //Play Audio for button touch....
            AudioServicesPlaySystemSound (soundFileObject);
            
            @try {
                
                subDepartmentTxt.text = subDepartmentArr[indexPath.row];
                
                
                
            } @catch (NSException *exception) {
                
            }
            @finally{
                [catPopOver dismissPopoverAnimated:YES];
            }
        }
        else if(tableView == brandTbl){
            //Play Audio for button touch....
            AudioServicesPlaySystemSound (soundFileObject);
            
            @try {
                
                brandTxt.text = brandArr[indexPath.row];
                
                
                
            } @catch (NSException *exception) {
                
            }
            @finally{
                [catPopOver dismissPopoverAnimated:YES];
            }
        }
        else if(tableView == sectionTbl){
            //Play Audio for button touch....
            AudioServicesPlaySystemSound (soundFileObject);
            
            @try {
                
                sectionTxt.text = sectionArr[indexPath.row];
                
                
                
            } @catch (NSException *exception) {
                
            }
            @finally{
                [catPopOver dismissPopoverAnimated:YES];
            }
        }
    
}

#pragma -mark reusableMethods.......

/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         05/08/2017
 * @method       showPopUpForTables:-- popUpWidth:-- popUpHeight:-- presentPopUpAt:-- showViewIn:-- permittedArrowDirections:--
 * @author       Saikrishna Kumbhoji
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
#pragma -mark Service Call......
/**
 * @description  here we are calling the getDepartmentList services.....
 * @date         05/08/2017
 * @method       callingDepartmentList
 * @author       Saikrishna Kumbhoji
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
        
        
        if(categoryTbl.tag == 2 )
            categoryArr = [NSMutableArray new];
        else
            subCategoryArr = [NSMutableArray new];
        
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
 * @description  here we are calling the getDepartmentList services.....
 * @date         08/08/2017........
 * @method       callingDepartmentList
 * @author       Saikrishna Kumbhoji
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
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,@"noOfSubDepartments",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",[NSNumber numberWithBool:true],[NSNumber numberWithBool:true]];
        
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


-(void)callingSubDepartment {
    
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
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(void)callingBrandList {
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        
        if (brandArr == nil) {
            brandArr  = [NSMutableArray new];
        }
        
        
        NSArray *keys = @[@"requestHeader",@"startIndex",@"bName",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",@"", [NSNumber numberWithBool:true]];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * brandListJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getBrandList:brandListJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  here we are calling the getModels services.....
 * @date         08/08/2017
 * @method       callingBrandList
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
        
        NSArray * keys = @[REQUEST_HEADER,START_INDEX,kMaxRecords,STORE_LOCATION];
        NSArray * objects = @[[RequestHeader getRequestHeader],@0,@"10",presentLocation];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * modelJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.modelMasterDelegate = self;
        [webServiceController  getModelDetails:modelJsonString];
    }
    @catch (NSException * exception){
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2  verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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

-(void)callingSectionFromSubCategories {
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
    @catch (NSException * exception) {
        
    }
    @finally {
        
    }
}
    
#pragma -mark action used in the Page to show PopUp....

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         05/08/2017....
 * @method       showDepartmentList:
 * @author       Saikrishna Kumbhoji
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
        
        if((categoryArr == nil) || (categoryArr.count == 0)){
            [HUD setHidden:NO];
            
            //for identification....
            categoryTbl.tag = 2;
            subCategoryTbl.tag = 4;
            
            //soap service call....
            [self callingCategoriesList:@""];
            
        }
        
        [HUD setHidden:YES];
        
        
        if(categoryArr.count == 0){
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = categoryArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = categoryArr.count * 33;
        
        if(categoryArr.count > 5)
            tableHeight = (tableHeight/categoryArr.count) * 5;
        
        [self showPopUpForTables:categoryTbl  popUpWidth:categoryTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         08/08/2017....
 * @method       showSubDepartments:
 * @author       Saikrishna Kumbhoji
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
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
            
        }
        
        if((subCategoryArr == nil) || (subCategoryArr.count == 0)){
            
            //for identification....
            categoryTbl.tag = 4;
            subCategoryTbl.tag = 2;
            
            [self callingCategoriesList:categoryTxt.text];
            
        }
        
        [HUD setHidden:YES];
        
        if(subCategoryArr.count == 0){
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        
        float tableHeight = subCategoryArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = subCategoryArr.count * 33;
        
        if(subCategoryArr.count > 5)
            tableHeight = (tableHeight/subCategoryArr.count) * 5;
        
        [self showPopUpForTables:subCategoryTbl  popUpWidth:subCategoryTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:subCategoryTxt  showViewIn:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

-(void)showDepartmentList:(UIButton*)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        
        //     if (![catPopOver isPopoverVisible]){
        if(departmentArr == nil ||  departmentArr.count == 0){
            [HUD setHidden:NO];
            [self callingDepartmentList];
            
        }
        
        
        if(departmentArr.count){
            float tableHeight = departmentArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = departmentArr.count * 33;
            
            if(departmentArr.count > 5)
                tableHeight = (tableHeight/departmentArr.count) * 5;
            
            
            [self showPopUpForTables:departmentTbl  popUpWidth:departmentTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:departmentTxt  showViewIn:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
            
            
            
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the normalStockView in showBrandList:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in normalStockView------%@",exception);
        
    }
}



-(void)showSubDepartmentList:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        
        //     if (![catPopOver isPopoverVisible]){
        if(subDepartmentArr == nil ||  subDepartmentArr.count == 0){
            [HUD setHidden:NO];
            [self callingSubDepartment];
            
        }
        
        
        if(subDepartmentArr.count){
            float tableHeight = subDepartmentArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = subDepartmentArr.count * 33;
            
            if(categoryArr.count > 5)
                tableHeight = (tableHeight/categoryArr.count) * 5;
            
            [self showPopUpForTables:subDepartmentTbl  popUpWidth:subDepartmentTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:subDepartmentTxt  showViewIn:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
            
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
 * @date         07/08/2017....
 * @method       showBrandList:
 * @author       Saikrishna Kumbhoji
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
        
        if((brandArr == nil) || (brandArr.count == 0)){
            [HUD setHidden:NO];
            
            //soap service call....
            [self callingBrandList];
            
        }
        
        [HUD setHidden:YES];
        
        if(brandArr.count == 0){
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        
        
        float tableHeight = brandArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = brandArr.count * 33;
        
        if(brandArr.count > 5)
            tableHeight = (tableHeight/brandArr.count) * 5;
        
        [self showPopUpForTables:brandTbl  popUpWidth:brandTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  showing the availiable  Shipment modes.......
 * @date         07/08/2017....
 * @method       showSectionList:
 * @author       Saikrishna Kumbhoji
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)showSectionList:(UIButton*)sender{
    
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
        
        [self showPopUpForTables:sectionTbl  popUpWidth:sectionTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:sectionTxt  showViewIn:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException *exception) {
        
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
        
        [self showPopUpForTables:modelTbl  popUpWidth:modelTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:modelTxt  showViewIn:skuWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException *exception) {
        
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
        
        generateReport.tag  = 4;
        
        if ((categoryTxt.text).length == 0  && (subCategoryTxt.text).length == 0 && (brandTxt.text).length == 0 && (sectionTxt.text).length== 0 && (startDateTxt.text).length == 0 && (endDateTxt.text).length== 0 && (departmentTxt.text).length== 0 && (subDepartmentTxt.text).length== 0  && (modelTxt.text).length == 0) {
            
            float y_axis = self.view.frame.size.height-200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert",nil),@"\n",NSLocalizedString(@"Please select above fields before proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        else {
            
            [HUD setHidden:NO];
            reportStartIndex = 0;
            [self callingSkuServiceforRecords];
        }

        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are creating request string for creation of new SupplierQuotation.......
 * @date         07/08/2017.....
 * @method       clearAllFilterInSearch
 * @author       Saikrishna Kumbhoji
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
        generateReport.tag  = 2;
        
        categoryTxt.text = @"";
        subCategoryTxt.text = @"";
        departmentTxt.text = @"";
        subDepartmentTxt.text = @"";
        brandTxt.text = @"";
        sectionTxt.text = @"";
        startDateTxt.text = @"";
        endDateTxt.text = @"";
        
        reportStartIndex = 0;
        [self callingSkuServiceforRecords];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the skuWiseReportView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}

#pragma -mark handling serviceCallRespone.......

/**
 * @description  handling the success response received from server side....
 * @date         08/08/2017........
 * @method       getAllDepartmentsSuccessResponse:
 * @author       Saikrishna Kumbhoji
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
            
            if(categoryTbl.tag == 2){
                
                [categoryArr addObject:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:@"categoryName"]  defaultReturn:@""]];
            }
            else{
                if([categoryTxt.text isEqualToString:[self checkGivenValueIsNullOrNil:[categoryDic valueForKey:@"categoryName"]  defaultReturn:@""]] ){
                    
                    
                    if([categoryDic.allKeys containsObject:@"subCategories"] && (![[categoryDic valueForKey:@"subCategories"] isKindOfClass: [NSNull class]]))
                        for (NSDictionary * subCatDic in  [categoryDic valueForKey:@"subCategories"]){
                            
                            [subCategoryArr addObject:[self checkGivenValueIsNullOrNil:[subCatDic valueForKey:@"subcategoryName"]  defaultReturn:@""]];
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
 * @date         08/08/2017
 * @method       getAllDepartmentsErrorResponse:
 * @author       Saikrishna Kumbhoji
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
 * @date         08/08/2017.........
 * @method       getAllDepartmentsSuccessResponse:
 * @author       Saikrishna Kumbhoji
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getDepartmentSuccessResponse:(NSDictionary*)sucessDictionary{
    
    @try   {
        
        for (NSDictionary * department in  [sucessDictionary valueForKey:@"departments"]){
            [departmentArr addObject:[self checkGivenValueIsNullOrNil:[department valueForKey:@"primaryDepartment"]  defaultReturn:@""]];
            
            NSMutableArray *locArr = [NSMutableArray new];
            
            @try {
                
                
                for (NSDictionary * subDepartment in [department valueForKey:@"secondaryDepartments"]){
                    
                    [locArr addObject:[self checkGivenValueIsNullOrNil:[subDepartment valueForKey:@"secondaryDepartment"]  defaultReturn:@""]];
                }
                
            } @catch (NSException *exception) {
                
            }
            
            
            dept_SubDeptDic[[self checkGivenValueIsNullOrNil:[department valueForKey:@"primaryDepartment"]  defaultReturn:@""]] = locArr;
            
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
 * @date         08/08/2017........
 * @method       getAllDepartmentsErrorResponse:
 * @author       Saikrishna Kumbhoji
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
        
        if(searchFieldTxt.isEditing)
            y_axis = searchFieldTxt.frame.origin.y + searchFieldTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


/**
 * @description  handling the success response received from server side....
 * @date         07/08/2017
 * @method       getModelSuccessResponse:
 * @author       Saikrishna Kumbhoji
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getBrandMasterSuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        for (NSDictionary * brandDic in  [sucessDictionary valueForKey: @"brandDetails" ]) {
            
            [brandArr addObject:brandDic];
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
 * @date         07/08/2017
 * @method       getModelErrorResponse:
 * @author       Saikrishna Kumbhoji
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
    
    if(searchFieldTxt.isEditing)
        y_axis = searchFieldTxt.frame.origin.y + searchFieldTxt.frame.size.height;
    
    
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
    } @catch (NSException *exception) {
        
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
    
    [HUD setHidden:YES];
    float y_axis = self.view.frame.size.height - 350;
    
    NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
    
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    
    return false;
    
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
-(void)getModelSuccessResponse:(NSDictionary*)successDictionary{
    
    @try {
        
        for (NSDictionary * modelDic in [successDictionary valueForKey:@"modelList"]) {
            
            [modelListArr addObject:modelDic];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
        
       //[self showListOfBrands:nil];
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

-(void)getModelErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 350;
        
        if(searchFieldTxt.isEditing)
            y_axis = searchFieldTxt.frame.origin.y+searchFieldTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
        
    } @finally {
        
    }
}

/**
 * @description  Handling the Response from the DataBase..
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

#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         08/08/2017..........
 * @method       displayAlertMessage
 * @author       Saikrishna Kumbhoji
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
            
            if(searchFieldTxt.isEditing)
                yPosition = searchFieldTxt.frame.origin.y + searchFieldTxt.frame.size.height;
            
            
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
 * @date         08/08/2017
 * @method       removeAlertMessages
 * @author       Saikrishna Kumbhoji
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




#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         08/08/2017....
 * @method       checkGivenValueIsNullOrNil
 * @author       Saikrishna Kumbhoji
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
    //
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

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         07/08/2017.....
 * @method       textFieldDidChange:
 * @author       Saikrishna Kumbhoji
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
        
        if (textField == searchFieldTxt ){
            
            if ((textField.text).length >= 4) {
                
                @try {
                    
                    reportStartIndex = 0;
                    skuWiseArr = [NSMutableArray new];
                    [self callingSkuServiceforRecords];
                    
                } @catch (NSException *exception) {
                    NSLog(@"---- exception while calling ServicesCall ----%@",exception);
                    
                } @finally {
                    
                }
            }
            
            else if ((searchFieldTxt.text).length == 0){
                reportStartIndex = 0;
                skuWiseArr = [NSMutableArray new];
                [self callingSkuServiceforRecords];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

@end






