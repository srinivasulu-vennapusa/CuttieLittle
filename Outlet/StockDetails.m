//
//  StockDetails.m
//  OmniRetailer
//
//  Created by Bhargav.v on 5/15/18.
//

#import "StockDetails.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"
@interface StockDetails ()

@end

@implementation StockDetails
@synthesize soundFileURLRef,soundFileObject;
@synthesize stockDetailsDic;

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

    //Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];

    //creating the stockDetailsView which will displayed completed Screen.......
    stockDetailsView = [[UIView alloc] init];
    stockDetailsView.backgroundColor = [UIColor blackColor];
    stockDetailsView.layer.borderWidth = 1.0f;
    stockDetailsView.layer.cornerRadius = 10.0f;
    stockDetailsView.layer.borderColor = [UIColor lightGrayColor].CGColor;

    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  stockDetailsView.......
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
    
    
    UILabel * skuid_Lbl;
    UILabel * productDesc_Lbl;
    UILabel * ean_Lbl;
    UILabel * uom_Lbl;
    UILabel * category_Lbl;
    UILabel * subCategory_Lbl;
    UILabel * department_Lbl;
    UILabel * subDepartment_Lbl;
    UILabel * class_Lbl;
    UILabel * subClass_Lbl;
    UILabel * sizeLabel;
    UILabel * colorLabel;
    
    skuid_Lbl = [[UILabel alloc] init];
    skuid_Lbl.text = NSLocalizedString(@"sku_id",nil);
    skuid_Lbl.layer.cornerRadius = 4;
    skuid_Lbl.layer.masksToBounds = YES;
    skuid_Lbl.numberOfLines = 2;
    skuid_Lbl.textAlignment = NSTextAlignmentLeft;
    skuid_Lbl.backgroundColor = [UIColor clearColor];
    skuid_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    productDesc_Lbl = [[UILabel alloc] init];
    productDesc_Lbl.text = NSLocalizedString(@"product_desc",nil);
    productDesc_Lbl.layer.cornerRadius = 4;
    productDesc_Lbl.layer.masksToBounds = YES;
    productDesc_Lbl.numberOfLines = 2;
    productDesc_Lbl.textAlignment = NSTextAlignmentLeft;
    productDesc_Lbl.backgroundColor = [UIColor clearColor];
    productDesc_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    ean_Lbl = [[UILabel alloc] init];
    ean_Lbl.text = NSLocalizedString(@"EAN ",nil);
    ean_Lbl.layer.cornerRadius = 4;
    ean_Lbl.layer.masksToBounds = YES;
    ean_Lbl.numberOfLines = 2;
    ean_Lbl.textAlignment = NSTextAlignmentLeft;
    ean_Lbl.backgroundColor = [UIColor clearColor];
    ean_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    uom_Lbl = [[UILabel alloc] init];
    uom_Lbl.text = NSLocalizedString(@"uom",nil);
    uom_Lbl.layer.cornerRadius = 4;
    uom_Lbl.layer.masksToBounds = YES;
    uom_Lbl.numberOfLines = 2;
    uom_Lbl.textAlignment = NSTextAlignmentLeft;
    uom_Lbl.backgroundColor = [UIColor clearColor];
    uom_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    category_Lbl = [[UILabel alloc] init];
    category_Lbl.text = NSLocalizedString(@"category",nil);
    category_Lbl.layer.cornerRadius = 4;
    category_Lbl.layer.masksToBounds = YES;
    category_Lbl.numberOfLines = 2;
    category_Lbl.textAlignment = NSTextAlignmentLeft;
    category_Lbl.backgroundColor = [UIColor clearColor];
    category_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    subCategory_Lbl = [[UILabel alloc] init];
    subCategory_Lbl.text = NSLocalizedString(@"sub_category",nil);
    subCategory_Lbl.layer.cornerRadius = 4;
    subCategory_Lbl.layer.masksToBounds = YES;
    subCategory_Lbl.numberOfLines = 2;
    subCategory_Lbl.textAlignment = NSTextAlignmentLeft;
    subCategory_Lbl.backgroundColor = [UIColor clearColor];
    subCategory_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    department_Lbl = [[UILabel alloc] init];
    department_Lbl.text = NSLocalizedString(@"department",nil);
    department_Lbl.layer.cornerRadius = 4;
    department_Lbl.layer.masksToBounds = YES;
    department_Lbl.numberOfLines = 2;
    department_Lbl.textAlignment = NSTextAlignmentLeft;
    department_Lbl.backgroundColor = [UIColor clearColor];
    department_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    subDepartment_Lbl = [[UILabel alloc] init];
    subDepartment_Lbl.text = NSLocalizedString(@"sub_department",nil);
    subDepartment_Lbl.layer.cornerRadius = 4;
    subDepartment_Lbl.layer.masksToBounds = YES;
    subDepartment_Lbl.numberOfLines = 2;
    subDepartment_Lbl.textAlignment = NSTextAlignmentLeft;
    subDepartment_Lbl.backgroundColor = [UIColor clearColor];
    subDepartment_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    class_Lbl = [[UILabel alloc] init];
    class_Lbl.text = NSLocalizedString(@"class",nil);
    class_Lbl.layer.cornerRadius = 4;
    class_Lbl.layer.masksToBounds = YES;
    class_Lbl.numberOfLines = 2;
    class_Lbl.textAlignment = NSTextAlignmentLeft;
    class_Lbl.backgroundColor = [UIColor clearColor];
    class_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    subClass_Lbl = [[UILabel alloc] init];
    subClass_Lbl.text = NSLocalizedString(@"sub_class",nil);
    subClass_Lbl.layer.cornerRadius = 4;
    subClass_Lbl.layer.masksToBounds = YES;
    subClass_Lbl.numberOfLines = 2;
    subClass_Lbl.textAlignment = NSTextAlignmentLeft;
    subClass_Lbl.backgroundColor = [UIColor clearColor];
    subClass_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    sizeLabel = [[UILabel alloc] init];
    sizeLabel.text = NSLocalizedString(@"size",nil);
    sizeLabel.layer.cornerRadius = 4;
    sizeLabel.layer.masksToBounds = YES;
    sizeLabel.numberOfLines = 2;
    sizeLabel.textAlignment = NSTextAlignmentLeft;
    sizeLabel.backgroundColor = [UIColor clearColor];
    sizeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    colorLabel = [[UILabel alloc] init];
    colorLabel.text = NSLocalizedString(@"colour",nil);
    colorLabel.layer.cornerRadius = 4;
    colorLabel.layer.masksToBounds = YES;
    colorLabel.numberOfLines = 2;
    colorLabel.textAlignment = NSTextAlignmentLeft;
    colorLabel.backgroundColor = [UIColor clearColor];
    colorLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];

    
    /*Creation of textField used in this page*/
    //Allocation of categoryTxt
    skuidTxt = [[CustomTextField alloc] init];
    skuidTxt.delegate = self;
    skuidTxt.userInteractionEnabled  = NO;
    skuidTxt.placeholder = NSLocalizedString(@"sku_id",nil);
    [skuidTxt awakeFromNib];
    
    productDescTxt = [[CustomTextField alloc] init];
    productDescTxt.delegate = self;
    productDescTxt.userInteractionEnabled  = NO;
    productDescTxt.placeholder = NSLocalizedString(@"product_desc",nil);
    [productDescTxt awakeFromNib];
    
    eanTxt = [[CustomTextField alloc] init];
    eanTxt.delegate = self;
    eanTxt.userInteractionEnabled  = NO;
    eanTxt.placeholder = NSLocalizedString(@"ean",nil);
    [eanTxt awakeFromNib];
    
    uomTxt = [[CustomTextField alloc] init];
    uomTxt.delegate = self;
    uomTxt.userInteractionEnabled  = NO;
    uomTxt.placeholder = NSLocalizedString(@"uom",nil);
    [uomTxt awakeFromNib];
    
    categoryTxt = [[CustomTextField alloc] init];
    categoryTxt.delegate = self;
    categoryTxt.userInteractionEnabled  = NO;
    categoryTxt.placeholder = NSLocalizedString(@"category",nil);
    [categoryTxt awakeFromNib];
    
    subCategoryTxt = [[CustomTextField alloc] init];
    subCategoryTxt.delegate = self;
    subCategoryTxt.userInteractionEnabled  = NO;
    subCategoryTxt.placeholder = NSLocalizedString(@"sub_category",nil);
    [subCategoryTxt awakeFromNib];
    
    departmentTxt = [[CustomTextField alloc] init];
    departmentTxt.delegate = self;
    departmentTxt.userInteractionEnabled  = NO;
    departmentTxt.placeholder = NSLocalizedString(@"department",nil);
    [departmentTxt awakeFromNib];
    
    subDepartmentTxt = [[CustomTextField alloc] init];
    subDepartmentTxt.delegate = self;
    subDepartmentTxt.userInteractionEnabled  = NO;
    subDepartmentTxt.placeholder = NSLocalizedString(@"sub_department",nil);
    [subDepartmentTxt awakeFromNib];
    
    classTxt = [[CustomTextField alloc] init];
    classTxt.delegate = self;
    classTxt.userInteractionEnabled  = NO;
    classTxt.placeholder = NSLocalizedString(@"class",nil);
    [classTxt awakeFromNib];
    
    subClassTxt = [[CustomTextField alloc] init];
    subClassTxt.delegate = self;
    subClassTxt.userInteractionEnabled  = NO;
    subClassTxt.placeholder = NSLocalizedString(@"sub_class",nil);
    [subClassTxt awakeFromNib];
    
    sizeText = [[CustomTextField alloc] init];
    sizeText.delegate = self;
    sizeText.userInteractionEnabled  = NO;
    sizeText.placeholder = NSLocalizedString(@"size",nil);
    [sizeText awakeFromNib];
    
    colorText = [[CustomTextField alloc] init];
    colorText.delegate = self;
    colorText.userInteractionEnabled  = NO;
    colorText.placeholder = NSLocalizedString(@"colour",nil);
    [colorText awakeFromNib];


    NSArray * segmentLabels = @[NSLocalizedString(@"stock_transation_history",nil),NSLocalizedString(@"daily_stock_movement",nil),NSLocalizedString(@"item_track_id", nil)];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentLabels];
    segmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    segmentedControl.backgroundColor = [UIColor clearColor];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentAction1:) forControlEvents:UIControlEventValueChanged];
    
    //allocation of void Items Report scroll view....
    
    stockDetailsScrollView = [[UIScrollView alloc]init];
    //stockDetailsScrollView.backgroundColor = [UIColor lightGrayColor];
    
    //Allocation of CustomLabels....
    
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    dateLbl = [[CustomLabel alloc] init];
    [dateLbl awakeFromNib];
    
    soldQtyLbl = [[CustomLabel alloc] init];
    [soldQtyLbl awakeFromNib];
    
    returnQtyLbl = [[CustomLabel alloc] init];
    [returnQtyLbl awakeFromNib];
    
    exchangeQtyLbl = [[CustomLabel alloc] init];
    [exchangeQtyLbl awakeFromNib];
    
    transferredQtyLbl = [[CustomLabel alloc] init];
    [transferredQtyLbl awakeFromNib];
    
    stockReceiptsLbl = [[CustomLabel alloc] init];
    [stockReceiptsLbl awakeFromNib];
    
    stockReturnLbl = [[CustomLabel alloc] init];
    [stockReturnLbl awakeFromNib];
    
    grnQtyLbl = [[CustomLabel alloc] init];
    [grnQtyLbl awakeFromNib];
    
    dumpQtyLbl = [[CustomLabel alloc] init];
    [dumpQtyLbl awakeFromNib];
    
    netStockLbl = [[CustomLabel alloc] init];
    [netStockLbl awakeFromNib];

    //Allocation of stockDetailsTbl..
    stockDetailsTbl = [[UITableView alloc]init];
    stockDetailsTbl.backgroundColor = [UIColor blackColor];
    stockDetailsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    stockDetailsTbl.dataSource = self;
    stockDetailsTbl.delegate = self;
    stockDetailsTbl.bounces = TRUE;
    stockDetailsTbl.layer.cornerRadius = 14;

    
    //Total Value Labels....
    
    //Recently Added Labels For making the total of stock quantity
    
    soldQtyValueLbl = [[UILabel alloc] init];
    soldQtyValueLbl.layer.cornerRadius = 5;
    soldQtyValueLbl.layer.masksToBounds = YES;
    soldQtyValueLbl.backgroundColor = [UIColor blackColor];
    soldQtyValueLbl.layer.borderWidth = 2.0f;
    soldQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    soldQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    returnQtyValueLbl = [[UILabel alloc] init];
    returnQtyValueLbl.layer.cornerRadius = 5;
    returnQtyValueLbl.layer.masksToBounds = YES;
    returnQtyValueLbl.backgroundColor = [UIColor blackColor];
    returnQtyValueLbl.layer.borderWidth = 2.0f;
    returnQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    returnQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    exchangeQtyValueLbl = [[UILabel alloc] init];
    exchangeQtyValueLbl.layer.cornerRadius = 5;
    exchangeQtyValueLbl.layer.masksToBounds = YES;
    exchangeQtyValueLbl.backgroundColor = [UIColor blackColor];
    exchangeQtyValueLbl.layer.borderWidth = 2.0f;
    exchangeQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    exchangeQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    transferredQtyValueLbl = [[UILabel alloc] init];
    transferredQtyValueLbl.layer.cornerRadius = 5;
    transferredQtyValueLbl.layer.masksToBounds = YES;
    transferredQtyValueLbl.backgroundColor = [UIColor blackColor];
    transferredQtyValueLbl.layer.borderWidth = 2.0f;
    transferredQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    transferredQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    stockReceiptsValueLbl = [[UILabel alloc] init];
    stockReceiptsValueLbl.layer.cornerRadius = 5;
    stockReceiptsValueLbl.layer.masksToBounds = YES;
    stockReceiptsValueLbl.backgroundColor = [UIColor blackColor];
    stockReceiptsValueLbl.layer.borderWidth = 2.0f;
    stockReceiptsValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    stockReceiptsValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    stockReturnQtyValuLbl = [[UILabel alloc] init];
    stockReturnQtyValuLbl.layer.cornerRadius = 5;
    stockReturnQtyValuLbl.layer.masksToBounds = YES;
    stockReturnQtyValuLbl.backgroundColor = [UIColor blackColor];
    stockReturnQtyValuLbl.layer.borderWidth = 2.0f;
    stockReturnQtyValuLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    stockReturnQtyValuLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    grnQtyValueLbl = [[UILabel alloc] init];
    grnQtyValueLbl.layer.cornerRadius = 5;
    grnQtyValueLbl.layer.masksToBounds = YES;
    grnQtyValueLbl.backgroundColor = [UIColor blackColor];
    grnQtyValueLbl.layer.borderWidth = 2.0f;
    grnQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    grnQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    dumpQtyValueLbl = [[UILabel alloc] init];
    dumpQtyValueLbl.layer.cornerRadius = 5;
    dumpQtyValueLbl.layer.masksToBounds = YES;
    dumpQtyValueLbl.backgroundColor = [UIColor blackColor];
    dumpQtyValueLbl.layer.borderWidth = 2.0f;
    dumpQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    dumpQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    netStockValueLbl = [[UILabel alloc] init];
    netStockValueLbl.layer.cornerRadius = 5;
    netStockValueLbl.layer.masksToBounds = YES;
    netStockValueLbl.backgroundColor = [UIColor blackColor];
    netStockValueLbl.layer.borderWidth = 2.0f;
    netStockValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    netStockValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    soldQtyValueLbl.textAlignment        = NSTextAlignmentCenter;
    returnQtyValueLbl.textAlignment      = NSTextAlignmentCenter;
    exchangeQtyValueLbl.textAlignment    = NSTextAlignmentCenter;
    transferredQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    stockReceiptsValueLbl.textAlignment  = NSTextAlignmentCenter;
    stockReturnQtyValuLbl.textAlignment  = NSTextAlignmentCenter;
    grnQtyValueLbl.textAlignment         = NSTextAlignmentCenter;
    dumpQtyValueLbl.textAlignment        = NSTextAlignmentCenter;
    netStockValueLbl.textAlignment       = NSTextAlignmentCenter;
    
    soldQtyValueLbl.text       = @"0.00";
    returnQtyValueLbl.text     = @"0.00";
    exchangeQtyValueLbl.text   = @"0.00";
    transferredQtyValueLbl.text= @"0.00";
    stockReceiptsValueLbl.text = @"0.00";
    stockReturnQtyValuLbl.text = @"0.00";
    grnQtyValueLbl.text        = @"0.00";
    dumpQtyValueLbl.text       = @"0.00";
    netStockValueLbl.text      = @"0.00";
    
    //Added By Bhargav.v on 15/05/2018...
    
    itemTrackerView  = [[UIView alloc]init];
    
    itemTrackSnoLabel = [[CustomLabel alloc]init];
    [itemTrackSnoLabel awakeFromNib];
    
    itemTrackIdLabel = [[CustomLabel alloc]init];
    [itemTrackIdLabel awakeFromNib];

    //Allocation of stockDetailsTbl..
    itemTrackerTable = [[UITableView alloc]init];
    itemTrackerTable.backgroundColor = [UIColor clearColor];
    itemTrackerTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    itemTrackerTable.dataSource = self;
    itemTrackerTable.delegate = self;
    itemTrackerTable.bounces = TRUE;
    itemTrackerTable.layer.cornerRadius = 14;
    
    
    //setting the titleName for the Page....
    self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
    HUD.labelText = NSLocalizedString(@"please_wait..",nil);
    
    
    // localizable strings for the Custom labels...
    
    snoLbl.text = NSLocalizedString(@"S_NO",nil);
    dateLbl.text = NSLocalizedString(@"date",nil);
    soldQtyLbl.text = NSLocalizedString(@"sold_qty",nil);
    returnQtyLbl.text = NSLocalizedString(@"return_qty",nil);
    exchangeQtyLbl.text = NSLocalizedString(@"exchange_qty",nil);
    transferredQtyLbl.text = NSLocalizedString(@"transferred_qty",nil);
    stockReceiptsLbl.text = NSLocalizedString(@"stock_receipts",nil);
    stockReturnLbl.text = NSLocalizedString(@"stock_return_qty",nil);
    grnQtyLbl.text = NSLocalizedString(@"grn_qty",nil);
    dumpQtyLbl.text = NSLocalizedString(@"dump_qty",nil);
    netStockLbl.text = NSLocalizedString(@"net_stock",nil);
        
    itemTrackSnoLabel.text = NSLocalizedString(@"serial_number",nil);
    itemTrackIdLabel.text  = NSLocalizedString(@"item_track_id", nil);

    @try {
        
        headerNameLbl.text = [NSString stringWithFormat:@"%@%@",[self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:SKUID] defaultReturn:@"--"],@" - Details"];

        skuidTxt.text  = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:SKUID] defaultReturn:@"--"];
        
        productDescTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
        
        eanTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:EAN] defaultReturn:@"--"];
        
        uomTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:SELL_UOM] defaultReturn:@"--"];
        
        categoryTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];
        
        subCategoryTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:kSubCategory] defaultReturn:@"--"];
        
        departmentTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:kItemDept] defaultReturn:@"--"];
        
        subDepartmentTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:kItemSubDept] defaultReturn:@"--"];
        
        classTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:PRODUCT_CLASS] defaultReturn:@"--"];
        
        subClassTxt.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:PRODUCT_SUB_CLASS] defaultReturn:@"--"];
        
        sizeText.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:SIZE] defaultReturn:@"--"];
        
        colorText.text = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:COLOR] defaultReturn:@"--"];
        
        
        
        
    } @catch (NSException * exception) {
        
    }
        
        
    //if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame for the StockDetailsView....
            stockDetailsView.frame = CGRectMake(2,5, self.view.frame.size.width - 4, self.view.frame.size.height - 75);
            
            //setting frame for the headerNameLbl....
            headerNameLbl.frame = CGRectMake( 0, 0, stockDetailsView.frame.size.width, 45);
            
            
            float labelWidth = 150;
            float textFieldWidth = 140;
            float labelHeight = 30;
            float textFieldHeight = 35;
            float horizontalWidth = 25;
            
            skuid_Lbl.frame = CGRectMake(stockDetailsView.frame.origin.x + 5, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10,50,labelHeight);
            
            skuidTxt.frame = CGRectMake(skuid_Lbl.frame.origin.x,skuid_Lbl.frame.origin.y+skuid_Lbl.frame.size.height - 5,textFieldWidth,textFieldHeight);
            
            productDesc_Lbl.frame = CGRectMake(skuid_Lbl.frame.origin.x,skuidTxt.frame.origin.y+skuidTxt.frame.size.height+5, labelWidth, labelHeight);
            
            productDescTxt.frame = CGRectMake(productDesc_Lbl.frame.origin.x, productDesc_Lbl.frame.origin.y + productDesc_Lbl.frame.size.height - 5, 180, textFieldHeight);
            
            ean_Lbl.frame = CGRectMake(productDescTxt.frame.origin.x + productDescTxt.frame.size.width + horizontalWidth ,skuid_Lbl.frame.origin.y,50,labelHeight);
            
            eanTxt.frame = CGRectMake(ean_Lbl.frame.origin.x,skuidTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            uom_Lbl.frame = CGRectMake(ean_Lbl.frame.origin.x,productDesc_Lbl.frame.origin.y,50,labelHeight);
            
            uomTxt.frame = CGRectMake(uom_Lbl.frame.origin.x,productDescTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            category_Lbl.frame = CGRectMake(eanTxt.frame.origin.x + eanTxt.frame.size.width + horizontalWidth,ean_Lbl.frame.origin.y,80,labelHeight);
            
            categoryTxt.frame = CGRectMake(category_Lbl.frame.origin.x,skuidTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            subCategory_Lbl.frame = CGRectMake(category_Lbl.frame.origin.x,uom_Lbl.frame.origin.y,100,labelHeight);
            
            subCategoryTxt.frame = CGRectMake(subCategory_Lbl.frame.origin.x,productDescTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            department_Lbl.frame = CGRectMake(categoryTxt.frame.origin.x + categoryTxt.frame.size.width + horizontalWidth,ean_Lbl.frame.origin.y,100,labelHeight);
            
            departmentTxt.frame = CGRectMake(department_Lbl.frame.origin.x,skuidTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            subDepartment_Lbl.frame = CGRectMake(department_Lbl.frame.origin.x,subCategory_Lbl.frame.origin.y,120,labelHeight);
            
            subDepartmentTxt.frame = CGRectMake(subDepartment_Lbl.frame.origin.x,productDescTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            
            class_Lbl.frame = CGRectMake(departmentTxt.frame.origin.x + departmentTxt.frame.size.width + horizontalWidth,ean_Lbl.frame.origin.y,60,labelHeight);
            
            classTxt.frame = CGRectMake(class_Lbl.frame.origin.x,skuidTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            subClass_Lbl.frame = CGRectMake(class_Lbl.frame.origin.x,subDepartment_Lbl.frame.origin.y,80,labelHeight);
            
            subClassTxt.frame = CGRectMake(subClass_Lbl.frame.origin.x,productDescTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            
            sizeLabel.frame = CGRectMake(classTxt.frame.origin.x + classTxt.frame.size.width + horizontalWidth,class_Lbl.frame.origin.y,50,labelHeight);
            
            sizeText.frame = CGRectMake(sizeLabel.frame.origin.x, classTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            colorLabel.frame = CGRectMake(sizeLabel.frame.origin.x,subClass_Lbl.frame.origin.y,50,labelHeight);
            
            colorText.frame = CGRectMake(colorLabel.frame.origin.x,productDescTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            segmentedControl.frame = CGRectMake(0,productDescTxt.frame.origin.y + productDescTxt.frame.size.height + 20,stockDetailsView.frame.size.width,40);
            
            stockDetailsScrollView.frame = CGRectMake(0,segmentedControl.frame.origin.y+segmentedControl.frame.size.height+5,segmentedControl.frame.size.width,stockDetailsView.frame.size.height-(segmentedControl.frame.origin.y + segmentedControl.frame.size.height) - 10);
            
            snoLbl.frame = CGRectMake(0,0,50,35);
            
            dateLbl.frame = CGRectMake(snoLbl.frame.origin.x + snoLbl.frame.size.width + 2,snoLbl.frame.origin.y,90,snoLbl.frame.size.height);
            
            soldQtyLbl.frame = CGRectMake(dateLbl.frame.origin.x + dateLbl.frame.size.width + 2,snoLbl.frame.origin.y,80, snoLbl.frame.size.height);
            
            returnQtyLbl.frame = CGRectMake(soldQtyLbl.frame.origin.x+soldQtyLbl.frame.size.width + 2,snoLbl.frame.origin.y,90, snoLbl.frame.size.height);
            
            exchangeQtyLbl.frame = CGRectMake(returnQtyLbl.frame.origin.x + returnQtyLbl.frame.size.width + 2,snoLbl.frame.origin.y,110,snoLbl.frame.size.height);
            
            transferredQtyLbl.frame = CGRectMake(exchangeQtyLbl.frame.origin.x + exchangeQtyLbl.frame.size.width + 2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
            
            stockReceiptsLbl.frame = CGRectMake(transferredQtyLbl.frame.origin.x + transferredQtyLbl.frame.size.width + 2,snoLbl.frame.origin.y,110,snoLbl.frame.size.height);
            
            stockReturnLbl.frame = CGRectMake(stockReceiptsLbl.frame.origin.x + stockReceiptsLbl.frame.size.width + 2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);
            
            grnQtyLbl.frame = CGRectMake(stockReturnLbl.frame.origin.x+stockReturnLbl.frame.size.width + 2,snoLbl.frame.origin.y,80,snoLbl.frame.size.height);
            
            dumpQtyLbl.frame = CGRectMake(grnQtyLbl.frame.origin.x + grnQtyLbl.frame.size.width + 2,snoLbl.frame.origin.y,90,snoLbl.frame.size.height);
            
            netStockLbl.frame = CGRectMake(dumpQtyLbl.frame.origin.x + dumpQtyLbl.frame.size.width + 2,snoLbl.frame.origin.y,85,snoLbl.frame.size.height);
            
            
            stockDetailsTbl.frame = CGRectMake(snoLbl.frame.origin.x,snoLbl.frame.origin.y + snoLbl.frame.size.height + 10,netStockLbl.frame.origin.x + netStockLbl.frame.size.width - (snoLbl.frame.origin.x), stockDetailsScrollView.frame.size.height - 100);
            
            //stockDetailsScrollView.contentSize = CGSizeMake(stockDetailsTbl.frame.size.width,stockDetailsScrollView.frame.size.height);
            
            //Frames for the TotalQty Values....
            
            soldQtyValueLbl.frame = CGRectMake(soldQtyLbl.frame.origin.x,stockDetailsTbl.frame.origin.y+stockDetailsTbl.frame.size.height + 20, soldQtyLbl.frame.size.width,soldQtyLbl.frame.size.height);
            
            returnQtyValueLbl.frame = CGRectMake(returnQtyLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y, returnQtyLbl.frame.size.width,soldQtyValueLbl.frame.size.height);
            
            exchangeQtyValueLbl.frame = CGRectMake(exchangeQtyLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y, exchangeQtyLbl.frame.size.width,soldQtyLbl.frame.size.height);
            
            transferredQtyValueLbl.frame = CGRectMake(transferredQtyLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y, transferredQtyLbl.frame.size.width,soldQtyLbl.frame.size.height);
            
            stockReceiptsValueLbl.frame = CGRectMake(stockReceiptsLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y, stockReceiptsLbl.frame.size.width,soldQtyLbl.frame.size.height);
            
            stockReturnQtyValuLbl.frame = CGRectMake(stockReturnLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y, stockReturnLbl.frame.size.width,soldQtyLbl.frame.size.height);
            
            grnQtyValueLbl.frame = CGRectMake(grnQtyLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y, grnQtyLbl.frame.size.width,soldQtyLbl.frame.size.height);
            
            dumpQtyValueLbl.frame = CGRectMake(dumpQtyLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,dumpQtyLbl.frame.size.width,soldQtyLbl.frame.size.height);
            
            netStockValueLbl.frame = CGRectMake(netStockLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,netStockLbl.frame.size.width,soldQtyLbl.frame.size.height);
            
 
        }
   // }
    
    [stockDetailsView addSubview:headerNameLbl];
    
    [stockDetailsView addSubview:skuid_Lbl];
    [stockDetailsView addSubview:productDesc_Lbl];
    [stockDetailsView addSubview:ean_Lbl];
    [stockDetailsView addSubview:uom_Lbl];
    [stockDetailsView addSubview:category_Lbl];
    [stockDetailsView addSubview:subCategory_Lbl];
    [stockDetailsView addSubview:department_Lbl];
    [stockDetailsView addSubview:subDepartment_Lbl];
    [stockDetailsView addSubview:class_Lbl];
    [stockDetailsView addSubview:subClass_Lbl];
    [stockDetailsView addSubview:sizeLabel];
    [stockDetailsView addSubview:colorLabel];
    
    [stockDetailsView addSubview:skuidTxt];
    [stockDetailsView addSubview:productDescTxt];
    [stockDetailsView addSubview:eanTxt];
    [stockDetailsView addSubview:uomTxt];
    [stockDetailsView addSubview:categoryTxt];
    [stockDetailsView addSubview:subCategoryTxt];
    [stockDetailsView addSubview:departmentTxt];
    [stockDetailsView addSubview:subDepartmentTxt];
    [stockDetailsView addSubview:classTxt];
    [stockDetailsView addSubview:subClassTxt];
    [stockDetailsView addSubview:sizeText];
    [stockDetailsView addSubview:colorText];
    
    [stockDetailsView addSubview:segmentedControl];
    [stockDetailsView addSubview:stockDetailsScrollView];
    
    [stockDetailsScrollView addSubview:snoLbl];
    [stockDetailsScrollView addSubview:dateLbl];
    [stockDetailsScrollView addSubview:soldQtyLbl];
    [stockDetailsScrollView addSubview:returnQtyLbl];
    [stockDetailsScrollView addSubview:exchangeQtyLbl];
    [stockDetailsScrollView addSubview:transferredQtyLbl];
    [stockDetailsScrollView addSubview:stockReceiptsLbl];
    [stockDetailsScrollView addSubview:stockReturnLbl];
    [stockDetailsScrollView addSubview:grnQtyLbl];
    [stockDetailsScrollView addSubview:dumpQtyLbl];
    [stockDetailsScrollView addSubview:netStockLbl];

    
    [stockDetailsScrollView addSubview:stockDetailsTbl];
    
    [stockDetailsScrollView addSubview:soldQtyValueLbl];
    [stockDetailsScrollView addSubview:returnQtyValueLbl];
    [stockDetailsScrollView addSubview:exchangeQtyValueLbl];
    [stockDetailsScrollView addSubview:transferredQtyValueLbl];
    [stockDetailsScrollView addSubview:stockReceiptsValueLbl];
    [stockDetailsScrollView addSubview:stockReturnQtyValuLbl];
    [stockDetailsScrollView addSubview:grnQtyValueLbl];
    [stockDetailsScrollView addSubview:dumpQtyValueLbl];
    [stockDetailsScrollView addSubview:netStockValueLbl];
    
    [itemTrackerView addSubview:itemTrackSnoLabel];
    [itemTrackerView addSubview:itemTrackIdLabel];
    [itemTrackerView addSubview:itemTrackerTable];
    [stockDetailsView addSubview:itemTrackerView];

    [self.view addSubview:stockDetailsView];
    

    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:15.0f cornerRadius:0];
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

}


/**
 * @description  we are fetching the data from normalStock Service call
 * @date         29/08/2017
 * @method       viewDidAppear
 * @author       Bhargav.v
 * @param        BOOL
 * @modified By
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)viewDidAppear:(BOOL)animated {
    //Calling super method...
    [super viewDidAppear:YES];
    
    @try {
        
        startIndexInt = 0;
        dailyStockIndexInt = 0;
        
        [self getStockLedger];
    }
    @catch (NSException* exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
        
    }
}
    
#pragma -mark action used in this viewController....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date
 * @method       segmentAction1
 * @author       Bhargav Ram
 * @param
 * @param        id
 *
 * @return       void
 *
 * @modified By  Akhila on 01/12/22017
 * @reason       added comment's and service call for dailyStock details.
 *
 * @verified By
 * @verified On
 *
 */

- (void)segmentAction1:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        segmentedControl = (UISegmentedControl *)sender;
        NSInteger index = segmentedControl.selectedSegmentIndex;
        switch (index) {
            case 0:
            {
                [stockDetailsScrollView setHidden:NO];
                [itemTrackerView setHidden:YES];
                [stockDetailsTbl reloadData];
                [self displayBottomTotalinViewController];
                break;
                
            }
            case 1:{
                
                [stockDetailsScrollView setHidden:NO];
                [itemTrackerView setHidden:YES];
                
                if (!dailyStockArray.count)
                    [self getDailyStockReport];
                else
                    [stockDetailsTbl reloadData];
                
                break;
            }
            case 2:{
                
                [stockDetailsScrollView setHidden:YES];
                [itemTrackerView setHidden:NO];
                
                //Added By Bhargav.v on 14/05/2018....
                itemTrackerView.frame = CGRectMake(segmentedControl.frame.origin.x, segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 5, stockDetailsScrollView.frame.size.width ,stockDetailsScrollView.frame.size.height);
                
                itemTrackSnoLabel.frame = CGRectMake(0, 0, (itemTrackerView.frame.size.width)/2, 35);
                itemTrackIdLabel.frame  = CGRectMake(itemTrackSnoLabel.frame.origin.x +itemTrackSnoLabel.frame.size.width + 2, itemTrackSnoLabel.frame.origin.y, itemTrackSnoLabel.frame.size.width, itemTrackSnoLabel.frame.size.height);
                
                itemTrackerTable.frame = CGRectMake(stockDetailsTbl.frame.origin.x,stockDetailsTbl.frame.origin.y,stockDetailsTbl.frame.size.width, stockDetailsTbl.frame.size.height + 50);

                
                itemTrackSnoLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
                itemTrackIdLabel.font  =  [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
                
                if(itemTrackerListArray == nil ||  itemTrackerListArray.count == 0){

                    [self getItemTrackerDetails];
                }
                
                break;
            }
                
            default:
                break;
        }
    } @catch (NSException *exception) {
        
    }
    
}

#pragma  -mark  start of service calls

/**
 * @description
 * @date
 * @method
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 *
 * @modified By  Akhila on 01/12/2017
 * @reason       changed service call inputParameter from sku_id to pluCode
 *
 * @verified By
 * @verified On
 *
 */

-(void)getStockLedger {
    
    @try {
        
        [HUD setHidden:NO];
        
        if(salesDetailsArray == nil){
            
            salesDetailsArray = [NSMutableArray new];
        }
        
        if(startIndexInt == 0){
            
        }
        
        NSString * pluCodeStr = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:PLU_CODE] defaultReturn:@""];
        NSString * skuidStr = skuidTxt.text;
        
        NSArray * loyaltyKeys = @[START_INDEX,REQUEST_HEADER,STORELOCATION,kRequiredRecords,PLU_CODE,ITEM_SKU];
        
        NSArray * loyaltyObjects = @[[NSString stringWithFormat:@"%d",startIndexInt],[RequestHeader getRequestHeader],presentLocation,@"10",pluCodeStr,skuidStr];
        
        
        NSDictionary * dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError  * err_;
        NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@--json product Categories String--",normalStockString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.getStockLedgerReportDelegate = self;
        [webServiceController getStockLedgerReport:normalStockString];
    }
    @catch (NSException * exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
    }
}


/**
 * @description
 * @date         23/11/2017
 * @method       getDailyStockReport
 * @author       Akhila
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getDailyStockReport{
    @try {
        [HUD setHidden:NO];
        
        if(dailyStockArray == nil){
            
            dailyStockArray = [NSMutableArray new];
        }
        
        
        NSString * pluCodeStr = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:PLU_CODE] defaultReturn:@""];
        NSString * skuidStr = skuidTxt.text;
        
        
        NSArray * DailyRequestKeys = @[START_INDEX,REQUEST_HEADER,STORELOCATION,kRequiredRecords,PLU_CODE,ITEM_SKU];
        
        NSArray * DailyRequestObjects = @[[NSString stringWithFormat:@"%d",startIndexInt],[RequestHeader getRequestHeader],presentLocation,@"10",pluCodeStr,skuidStr];
        
        NSDictionary * dictionary_ = [NSDictionary dictionaryWithObjects:DailyRequestObjects forKeys:DailyRequestKeys];
        
        NSError  * err_;
        NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.salesServiceDelegate = self;
        [webServiceController getDailyStockReport:normalStockString];
    }
    
    
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 350;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
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

-(void)getItemTrackerDetails {
    
    [HUD setHidden:NO];
    
    if(itemTrackerListArray == nil){
        
        itemTrackerListArray = [NSMutableArray new];
    }
    
    NSString * pluCodeStr = [self checkGivenValueIsNullOrNil:[stockDetailsDic valueForKey:PLU_CODE] defaultReturn:@""];
    
    NSMutableDictionary * itemTrackerDictionary = [[NSMutableDictionary alloc] init];
    
    [itemTrackerDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
    [itemTrackerDictionary setValue:[NSNumber numberWithBool:false]  forKey:IS_SAVE_REPORT];
    [itemTrackerDictionary setValue:[NSNumber numberWithBool:false]  forKey:SAVE_REORT_FLAG];
    [itemTrackerDictionary setValue:presentLocation forKey:STORE_LOCATION];
    [itemTrackerDictionary setValue:pluCodeStr forKey:PLU_CODE];
    
    NSError  * err;
    NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:itemTrackerDictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    WebServiceController * webServiceController = [WebServiceController new];
    webServiceController.salesServiceDelegate = self;
    [webServiceController getTrackerItemsDetails:salesReportJsonString];
    
}


#pragma -mark start of response handling of service calls....

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 *
 * @return
 *
 * @modified By  Akhila on 04/12/2017..
 * @reason      changed the population of totals into comman methods....
 *
 * @verified By
 * @verified On
 *
 */

- (void)getStockLedgerReportSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        if (successDictionary != nil) {
            if (![[successDictionary valueForKey:LEDGER_DETAILS] isKindOfClass:[NSNull class]]) {
                if ([[successDictionary valueForKey:LEDGER_DETAILS] count] > 0) {
                    
                    totalNoOfRecords = [[successDictionary valueForKey:TOTAL_BILLS] intValue];
                    
                    for (NSDictionary * detailsDic in [successDictionary valueForKey:LEDGER_DETAILS]) {
                        
                        [salesDetailsArray addObject:detailsDic];
                    }
                    
                    [self displayBottomTotalinViewController];
                    [stockDetailsTbl reloadData];
                }
                else {
                    [HUD setHidden:YES];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Data to Display" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }
            else if([[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] isEqualToString:@"No Records Found"] || [[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] isEqualToString:@"-1"]){
                if (callServiceCall) {
                    callServiceCall = FALSE;
                    [HUD setHidden:YES];
                    if (salesDetailsArray.count == 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Data to Display" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                }
            }
        }
        else {
            
            [HUD setHidden:YES];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.name);
    }
    @finally {
        [HUD setHidden:YES];
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

- (void)getStockLedgerReportErrorResponse:(NSString*)errorResponse {
    
    @try {
        [self displayBottomTotalinViewController];
        
        [HUD setHidden:YES];
        if(!salesDetailsArray.count){
            float y_axis = self.view.frame.size.height - 350;
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    }@catch (NSException *exception) {
        
    } @finally {
        
        [stockDetailsTbl reloadData];
    }
    
}

/**
 * @description  in this method we are handling the sucess response received from service services
 * @date         27/11/2017
 * @method       getDailyStockReportSuccessResponse
 * @author       Akhila
 * @param
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (void)getDailyStockReportSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        if (![[successDictionary valueForKey:REPORT_LIST] isKindOfClass:[NSNull class]]) {
            if ([[successDictionary valueForKey:REPORT_LIST] count] > 0) {
                
                dailyStockTotalNoOfRecords = [[successDictionary valueForKey:TOTAL_BILLS] intValue];
                
                for (NSDictionary * detailsDic in [successDictionary valueForKey:REPORT_LIST]) {
                    
                    [dailyStockArray addObject:detailsDic];
                }
            }
            else {
                
                //No Data to Display
                
                float y_axis = self.view.frame.size.height - 350;
                
                NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_to_display", nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            }
        }
    }
    @catch (NSException * exception) {
        NSLog(@"%@",exception.name);
    }
    @finally {
        
        [self displayBottomTotalinViewController];
        [stockDetailsTbl reloadData];
        [HUD setHidden:YES];
    }
}

/**
 * @description  in this method we are handling the error response received from service services
 * @date         27/11/2017
 * @method       getDailyStockReportErrorResponse
 * @author       Akhila
 * @param
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */


-(void)getDailyStockReportErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [self displayBottomTotalinViewController];
        
        [HUD setHidden:YES];
        
        if(!dailyStockArray.count){
            float y_axis = self.view.frame.size.height - 120;
            
            
            NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:320 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
        }
    }
    @catch (NSException *exception) {
        
    } @finally {
        
        [stockDetailsTbl reloadData];
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

-(void)getTrackerItemsDetalilsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        for (NSDictionary * trackerListDic in [[successDictionary valueForKey:@"itemdetails"]valueForKey:@"availItemsList"] ) {
            
            [itemTrackerListArray addObject:trackerListDic];
            
        }
    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [itemTrackerTable reloadData];
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


-(void)getTrackerItemsDetailsErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 80;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:320 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
        
    }
    
}






/**
 * @description  in this method we are displaying values at the bottom
 * @date         04/12/2017
 * @method       displayBottomTotalinViewController
 * @author       Akhila
 * @param
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)displayBottomTotalinViewController{
    
    @try {
        
        NSArray * calArr = salesDetailsArray;
        
        NSString * soldQtyKey        = SOLD_QUANTITY;
        NSString * returnQtyKey      = RETURNED_QTY;
        NSString * exchangeQtyKey    = EXCHANGE_QTY;
        NSString * transferredQtyKey = TRANSFERED_QUANTITY;
        NSString * stockReceiptKey   = STOCK_RECEIPTS;
        NSString * stockReturnQtyKey = STOCK_RETURNED_FROM_QUANTITY;
        NSString * grnQtyKey =   GRN_QTY;
        NSString * dumpQtyKey =  DUMP_QTY;
        NSString * netStockKey = NET_STOCK;
        
        if(segmentedControl.selectedSegmentIndex == 1) {
            
            calArr = dailyStockArray;
            
            soldQtyKey        = QUANTITY;
            returnQtyKey      = RETURN_QTY_1;
            exchangeQtyKey    = EXCHANGE_QTY_1;
            transferredQtyKey = SKU_TRNS_QTY;
            stockReceiptKey   = SKU_RECEIPT_QTY;
            stockReturnQtyKey = SKU_RETURN_QTY;
            
            grnQtyKey   = GRN_STOCK;
            dumpQtyKey  = STOCKLOSS_QTY;
            netStockKey = CLOSED_STOCK;
        }
        
        float soldQty        = 0.00;
        float returnQty      = 0.00;
        float exchangeQty    = 0.00;
        float transferredQty = 0.00;
        float stockReceipt   = 0.00;
        float stockReturnQty = 0.00;
        float  grnQty  = 0.00;
        float dumpQty  = 0.00;
        float netStock = 0.00;
        
        for (NSDictionary * detailsDic in calArr) {
            
            soldQty +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:soldQtyKey] defaultReturn:@"0.00"] floatValue];
            
            returnQty +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:returnQtyKey] defaultReturn:@"0.00"] floatValue];
            
            exchangeQty +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:exchangeQtyKey] defaultReturn:@"0.00"] floatValue];
            
            transferredQty +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:transferredQtyKey] defaultReturn:@"0.00"] floatValue];
            
            stockReceipt +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:stockReceiptKey] defaultReturn:@"0.00"] floatValue];
            
            stockReturnQty +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:stockReturnQtyKey] defaultReturn:@"0.00"] floatValue];
            
            grnQty  +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:grnQtyKey] defaultReturn:@"0.00"] floatValue];
            
            dumpQty +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:dumpQtyKey] defaultReturn:@"0.00"] floatValue];
            
            netStock +=  [[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:netStockKey] defaultReturn:@"0.00"] floatValue];
            
        }
        
        soldQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",soldQty];
        returnQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",returnQty];
        exchangeQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",exchangeQty];
        transferredQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",transferredQty];
        stockReceiptsValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",stockReceipt];
        stockReturnQtyValuLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",stockReturnQty];
        grnQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",grnQty];
        dumpQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",dumpQty];
        netStockValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"    ",netStock];
        
    } @catch (NSException *exception) {
        [stockDetailsTbl reloadData];
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
    
    
    if (tableView == stockDetailsTbl) {
        
        if(segmentedControl.selectedSegmentIndex == 0){
            
            if (salesDetailsArray.count)
                return salesDetailsArray.count;
            else
                return 1;
        }
        // Added by Akhila on 30/12/2017
        else{
            
            if (dailyStockArray.count)
                return dailyStockArray.count;
            else
                return 1;
        }
        
        //upto here on 30/12/2017
    }
    else if(tableView == itemTrackerTable) {
        
        return itemTrackerListArray.count;
        
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
    
    if (tableView == stockDetailsTbl || tableView == itemTrackerTable){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 38;
        }
        else{
            
            return 45;
        }
    }
    return 0.0;
}

/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: willDisplayCell: forRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @param        NSIndexPath
 *
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    @try {
        
        
        if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && version >= 8.0 )|| (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
            
            // Remove seperator inset....
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                cell.separatorInset = UIEdgeInsetsZero;
            }
            
            // Prevent the cell from inheriting the Table View's margin settings....
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                cell.preservesSuperviewLayoutMargins = NO;
            }
            
            // Explictly set cell's layout margins....
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                cell.layoutMargins = UIEdgeInsetsZero;
            }
        }
        
        if(tableView == stockDetailsTbl){
            
            @try {
                
                if ((segmentedControl.selectedSegmentIndex == 0) && (indexPath.row == (salesDetailsArray.count - 1)) && (salesDetailsArray.count < totalNoOfRecords ) && (salesDetailsArray.count > startIndexInt )) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    startIndexInt = startIndexInt + 10;
                    [self getStockLedger];
                    [stockDetailsTbl reloadData];
                }
                //added by akhila on 04/12/2017
                else if((segmentedControl.selectedSegmentIndex == 1) && (indexPath.row == (dailyStockArray.count - 1)) && (dailyStockArray.count < dailyStockTotalNoOfRecords) && (dailyStockArray.count > dailyStockIndexInt )){
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    dailyStockIndexInt = dailyStockIndexInt + 10;
                    [self getDailyStockReport];
                    [stockDetailsTbl reloadData];
                }// upto here on 04/12/
            }
            @catch (NSException *exception) {
                [HUD setHidden:YES];
                
                NSLog(@"---exception in servicecall---%@",exception);
            }
        }
    } @catch (NSException *exception) {
        
    }
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
    
    if (tableView == stockDetailsTbl) {
        
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
            UILabel * date_Lbl;
            UILabel * soldQty_Lbl;
            UILabel * returnQty_Lbl;
            UILabel * exchangeQty_Lbl;
            UILabel * transferredQty_Lbl;
            UILabel * stockReceipt_Lbl;
            UILabel * stock_ReturnQty_Lbl;
            UILabel * grnQty_Lbl;
            UILabel * dumpQty_Lbl;
            UILabel * netStock_Lbl;
            
            /*Creation of UILabels used in this cell*/
            slno_Lbl = [[UILabel alloc] init];
            slno_Lbl.backgroundColor = [UIColor clearColor];
            slno_Lbl.textAlignment = NSTextAlignmentCenter;
            slno_Lbl.numberOfLines = 1;
            slno_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            date_Lbl = [[UILabel alloc] init];
            date_Lbl.backgroundColor = [UIColor clearColor];
            date_Lbl.textAlignment = NSTextAlignmentCenter;
            date_Lbl.numberOfLines = 1;
            date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            soldQty_Lbl = [[UILabel alloc] init];
            soldQty_Lbl.backgroundColor = [UIColor clearColor];
            soldQty_Lbl.textAlignment = NSTextAlignmentCenter;
            soldQty_Lbl.numberOfLines = 1;
            soldQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            returnQty_Lbl = [[UILabel alloc] init];
            returnQty_Lbl.backgroundColor = [UIColor clearColor];
            returnQty_Lbl.textAlignment = NSTextAlignmentCenter;
            returnQty_Lbl.numberOfLines = 1;
            returnQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            exchangeQty_Lbl = [[UILabel alloc] init];
            exchangeQty_Lbl.backgroundColor = [UIColor clearColor];
            exchangeQty_Lbl.textAlignment = NSTextAlignmentCenter;
            exchangeQty_Lbl.numberOfLines = 1;
            exchangeQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            transferredQty_Lbl = [[UILabel alloc] init];
            transferredQty_Lbl.backgroundColor = [UIColor clearColor];
            transferredQty_Lbl.textAlignment = NSTextAlignmentCenter;
            transferredQty_Lbl.numberOfLines = 1;
            transferredQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            stockReceipt_Lbl = [[UILabel alloc] init];
            stockReceipt_Lbl.backgroundColor = [UIColor clearColor];
            stockReceipt_Lbl.textAlignment = NSTextAlignmentCenter;
            stockReceipt_Lbl.numberOfLines = 1;
            stockReceipt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            stock_ReturnQty_Lbl = [[UILabel alloc] init];
            stock_ReturnQty_Lbl.backgroundColor = [UIColor clearColor];
            stock_ReturnQty_Lbl.textAlignment = NSTextAlignmentCenter;
            stock_ReturnQty_Lbl.numberOfLines = 1;
            stock_ReturnQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            grnQty_Lbl = [[UILabel alloc] init];
            grnQty_Lbl.backgroundColor = [UIColor clearColor];
            grnQty_Lbl.textAlignment = NSTextAlignmentCenter;
            grnQty_Lbl.numberOfLines = 1;
            grnQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            dumpQty_Lbl = [[UILabel alloc] init];
            dumpQty_Lbl.backgroundColor = [UIColor clearColor];
            dumpQty_Lbl.textAlignment = NSTextAlignmentCenter;
            dumpQty_Lbl.numberOfLines = 1;
            dumpQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            netStock_Lbl = [[UILabel alloc] init];
            netStock_Lbl.backgroundColor = [UIColor clearColor];
            netStock_Lbl.textAlignment = NSTextAlignmentCenter;
            netStock_Lbl.numberOfLines = 1;
            netStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            slno_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            soldQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            returnQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            exchangeQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            transferredQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            stockReceipt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            stock_ReturnQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            grnQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            dumpQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            netStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            [hlcell.contentView addSubview:slno_Lbl];
            [hlcell.contentView addSubview:date_Lbl];
            [hlcell.contentView addSubview:soldQty_Lbl];
            [hlcell.contentView addSubview:returnQty_Lbl];
            [hlcell.contentView addSubview:exchangeQty_Lbl];
            [hlcell.contentView addSubview:transferredQty_Lbl];
            [hlcell.contentView addSubview:stockReceipt_Lbl];
            [hlcell.contentView addSubview:stock_ReturnQty_Lbl];
            [hlcell.contentView addSubview:grnQty_Lbl];
            [hlcell.contentView addSubview:dumpQty_Lbl];
            [hlcell.contentView addSubview:netStock_Lbl];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                slno_Lbl.frame = CGRectMake(0,0,snoLbl.frame.size.width,hlcell.frame.size.height);
                date_Lbl.frame = CGRectMake(dateLbl.frame.origin.x,0,dateLbl.frame.size.width,hlcell.frame.size.height);
                soldQty_Lbl.frame = CGRectMake(soldQtyLbl.frame.origin.x,0,soldQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                returnQty_Lbl.frame = CGRectMake(returnQtyLbl.frame.origin.x,0,returnQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                exchangeQty_Lbl.frame = CGRectMake(exchangeQtyLbl.frame.origin.x,0,exchangeQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                transferredQty_Lbl.frame = CGRectMake(transferredQtyLbl.frame.origin.x,0,transferredQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                stockReceipt_Lbl.frame = CGRectMake(stockReceiptsLbl.frame.origin.x,0,stockReceiptsLbl.frame.size.width,hlcell.frame.size.height);
                
                stock_ReturnQty_Lbl.frame = CGRectMake(stockReturnLbl.frame.origin.x,0,stockReturnLbl.frame.size.width,hlcell.frame.size.height);
                
                grnQty_Lbl.frame = CGRectMake(grnQtyLbl.frame.origin.x,0,grnQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                dumpQty_Lbl.frame = CGRectMake(dumpQtyLbl.frame.origin.x,0,dumpQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                netStock_Lbl.frame = CGRectMake(netStockLbl.frame.origin.x,0,netStockLbl.frame.size.width,hlcell.frame.size.height);
                
            }
            else{
                
                //code for the iPhone
            }
            
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            if( segmentedControl.selectedSegmentIndex == 0 && salesDetailsArray.count >= indexPath.row && salesDetailsArray.count){
                
                
                NSDictionary * dic  = salesDetailsArray[indexPath.row];
                
                slno_Lbl.text = [NSString stringWithFormat:@"%d", (int)(indexPath.row + 1)];
                
                date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:@"strDate"] componentsSeparatedByString:@" "][0]  defaultReturn:@"--"];
                
                soldQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:SOLD_QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                returnQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:RETURNED_QTY] defaultReturn:@"0.00"] floatValue]];
                
                exchangeQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:EXCHANGE_QTY ] defaultReturn:@"0.00"] floatValue]];
                
                transferredQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:TRANSFERED_QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                stockReceipt_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:STOCK_RECEIPTS] defaultReturn:@"0.00"] floatValue]];
                
                stock_ReturnQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:STOCK_RETURNED_FROM_QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                grnQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:GRN_QTY] defaultReturn:@"0.00"] floatValue]];
                
                dumpQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:DUMP_QTY ] defaultReturn:@"0.00"] floatValue]];
                
                netStock_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:NET_STOCK] defaultReturn:@"0.00"] floatValue]];
            }
            
            
            // Added by Akhila on 29/12/2017
            else if (dailyStockArray.count >= indexPath.row && dailyStockArray.count) {
                
                NSDictionary * dic  = dailyStockArray[indexPath.row];
                
                slno_Lbl.text = [NSString stringWithFormat:@"%d", (int)(indexPath.row + 1)];
                
                date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:@"date"] componentsSeparatedByString:@" "][0]  defaultReturn:@"--"];
                
                soldQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                returnQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:RETURN_QTY_1] defaultReturn:@"0.00"] floatValue]];
                
                exchangeQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:EXCHANGE_QTY_1] defaultReturn:@"0.00"] floatValue]];
                
                transferredQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_TRNS_QTY] defaultReturn:@"0.00"] floatValue]];
                
                stockReceipt_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_RECEIPT_QTY] defaultReturn:@"0.00"] floatValue]];
                
                stock_ReturnQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_RETURN_QTY] defaultReturn:@"0.00"] floatValue]];
                
                grnQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:GRN_STOCK] defaultReturn:@"0.00"] floatValue]];
                
                dumpQty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:STOCKLOSS_QTY] defaultReturn:@"0.00"] floatValue]];
                
                netStock_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:CLOSED_STOCK] defaultReturn:@"0.00"] floatValue]];
            }
            //upto here on 29/12/2017
            
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
            
        } @finally {
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
    }
    else if (tableView == itemTrackerTable) {
        
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
        
      
            UILabel * slnoLable;
            UILabel * itemTrackerLable;
            
            /*Creation of UILabels used in this cell*/
            slnoLable = [[UILabel alloc] init];
            slnoLable.backgroundColor = [UIColor clearColor];
            slnoLable.textAlignment = NSTextAlignmentCenter;
            slnoLable.numberOfLines = 1;
            slnoLable.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemTrackerLable = [[UILabel alloc] init];
            itemTrackerLable.backgroundColor = [UIColor clearColor];
            itemTrackerLable.textAlignment = NSTextAlignmentCenter;
            itemTrackerLable.numberOfLines = 1;
            itemTrackerLable.lineBreakMode = NSLineBreakByWordWrapping;
            
            slnoLable.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemTrackerLable.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            [hlcell.contentView addSubview:slnoLable];
            [hlcell.contentView addSubview:itemTrackerLable];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                slnoLable.frame = CGRectMake(0,0,itemTrackSnoLabel.frame.size.width,hlcell.frame.size.height);
                itemTrackerLable.frame = CGRectMake(itemTrackIdLabel.frame.origin.x,0,itemTrackIdLabel.frame.size.width,hlcell.frame.size.height);
            }
            else {
                
            }
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
        
          @try {
        
             if (itemTrackerListArray.count >= indexPath.row && itemTrackerListArray.count) {
                
                slnoLable.text = [NSString stringWithFormat:@"%d", (int)(indexPath.row + 1)];
              
                itemTrackerLable.text = [self checkGivenValueIsNullOrNil:itemTrackerListArray[indexPath.row] defaultReturn:@""];

            }
        }
        
        @catch(NSException * exception){
            
        }
        @finally {
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark used to display the error message...


/**
 * @description  adding the  alertMessage's based on input
 * @date
 * @method       displayAlertMessage
 * @author
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
 * @date
 * @method       removeAlertMessages
 * @author
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
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the CreateReceiptView in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
        
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
