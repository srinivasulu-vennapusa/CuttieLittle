//
//  StockVerification.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/4/15.
//
//

#import "StockVerification.h"
//#import "StoreStockVerificationImplServiceSvc.h"
#import "StoreStockVerificationServiceSvc.h"
#import "Global.h"
#import "Cell1.h"
#import "Cell2.h"
#import "UtilityMasterServiceSvc.h"
#import "SkuServiceSvc.h"
#import "CheckWifi.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

#ifndef ZXQR
#define ZXQR 1
#endif


//#if ZXQR
//#import "MultiFormatOneDReader.h"
//#endif


#ifndef ZXAZ
#define ZXAZ 0
#endif

@interface StockVerification ()

@end

@implementation StockVerification

@synthesize soundFileURLRef,soundFileObject,selectIndex,isOpen;

//Cell2 *cell2;
Cell1 *cell1;
int cellPosition = 0;

int  fromlocationStartIndex1 = 0;


NSDictionary *verifyJSON = NULL;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    // Do any additional setup after loading the view.
    
    if (scanner) {
        
        [scanner addObserver:self];
        [scanner setScannerAutoScan:YES];
    }
    
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    
    self.titleLabel.text = @"Stock Verification";
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = FALSE;
    
    locationArr = [[NSMutableArray alloc] init];
    //    storageUnits = [[NSMutableArray alloc] initWithObjects:@"ST001",@"ST002",@"ST003",@"ST004",@"ST005", nil];
    tempSkuArrayList = [[NSMutableArray alloc]init];
    rawMaterials = [[NSMutableArray alloc]init];
    skuArrayList = [[NSMutableArray alloc]init];
    
    
    location = [[CustomTextField alloc] init];
    location.borderStyle = UITextBorderStyleRoundedRect;
    location.textColor = [UIColor blackColor];
    location.font = [UIFont systemFontOfSize:18.0];
    location.backgroundColor = [UIColor whiteColor];
    location.clearButtonMode = UITextFieldViewModeWhileEditing;
    location.backgroundColor = [UIColor whiteColor];
    location.autocorrectionType = UITextAutocorrectionTypeNo;
    location.layer.borderColor = [UIColor whiteColor].CGColor;
    location.backgroundColor = [UIColor whiteColor];
    location.delegate = self;
    location.placeholder = @"   Location";
    [location awakeFromNib];
    location.text = presentLocation;
    location.userInteractionEnabled = FALSE;
    // [location addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    selectLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [selectLocation setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectLocation addTarget:self
                       action:@selector(getListOfStorageLocations:) forControlEvents:UIControlEventTouchDown];
    selectLocation.tag = 1;
    selectLocation.enabled = false;
    
    locationTable = [[UITableView alloc] init];
    locationTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    locationTable.dataSource = self;
    locationTable.delegate = self;
    (locationTable.layer).borderWidth = 1.0f;
    locationTable.layer.cornerRadius = 3;
    locationTable.layer.borderColor = [UIColor grayColor].CGColor;
    locationTable.hidden = YES;
    
    selectStorage = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD1 = [UIImage imageNamed:@"combo.png"];
    [selectStorage setBackgroundImage:buttonImageDD1 forState:UIControlStateNormal];
    [selectStorage addTarget:self
                      action:@selector(getListOfStorageUnits:) forControlEvents:UIControlEventTouchDown];
    selectStorage.tag = 2;
    
    storageTable = [[UITableView alloc] init];
    storageTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    storageTable.dataSource = self;
    storageTable.delegate = self;
    (storageTable.layer).borderWidth = 1.0f;
    storageTable.layer.cornerRadius = 3;
    storageTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    storageLocations = [[UITableView alloc] init];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString* currentdate = [f stringFromDate:today];
    
    verifiedDate = [[CustomTextField alloc] init];
    verifiedDate.borderStyle = UITextBorderStyleRoundedRect;
    verifiedDate.textColor = [UIColor blackColor];
    verifiedDate.font = [UIFont systemFontOfSize:18.0];
    verifiedDate.backgroundColor = [UIColor whiteColor];
    verifiedDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifiedDate.backgroundColor = [UIColor whiteColor];
    verifiedDate.autocorrectionType = UITextAutocorrectionTypeNo;
    verifiedDate.layer.borderColor = [UIColor whiteColor].CGColor;
    verifiedDate.backgroundColor = [UIColor whiteColor];
    verifiedDate.delegate = self;
    verifiedDate.placeholder = @"   Verified Date";
    verifiedDate.text = currentdate;
    [verifiedDate addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [verifiedDate awakeFromNib];
    verifiedDate.userInteractionEnabled = NO;
    
    verifiedBy = [[CustomTextField alloc] init];
    verifiedBy.borderStyle = UITextBorderStyleRoundedRect;
    verifiedBy.textColor = [UIColor blackColor];
    verifiedBy.font = [UIFont systemFontOfSize:18.0];
    verifiedBy.backgroundColor = [UIColor whiteColor];
    verifiedBy.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifiedBy.backgroundColor = [UIColor whiteColor];
    verifiedBy.autocorrectionType = UITextAutocorrectionTypeNo;
    verifiedBy.layer.borderColor = [UIColor whiteColor].CGColor;
    verifiedBy.backgroundColor = [UIColor whiteColor];
    verifiedBy.delegate = self;
    verifiedBy.placeholder = @"   Verified By";
    verifiedBy.text = firstName;
    [verifiedBy setUserInteractionEnabled:FALSE];
    [verifiedBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [verifiedBy awakeFromNib];
    
    storageUnit = [[CustomTextField alloc] init];
    storageUnit.borderStyle = UITextBorderStyleRoundedRect;
    storageUnit.textColor = [UIColor blackColor];
    storageUnit.font = [UIFont systemFontOfSize:18.0];
    storageUnit.backgroundColor = [UIColor whiteColor];
    storageUnit.clearButtonMode = UITextFieldViewModeWhileEditing;
    storageUnit.backgroundColor = [UIColor whiteColor];
    storageUnit.autocorrectionType = UITextAutocorrectionTypeNo;
    storageUnit.layer.borderColor = [UIColor whiteColor].CGColor;
    storageUnit.backgroundColor = [UIColor whiteColor];
    storageUnit.delegate = self;
    storageUnit.placeholder = @"   Storage Unit";
    [storageUnit addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [storageUnit awakeFromNib];
    storageUnit.text = @"All";
    
    
    storageLocation = [[CustomTextField alloc] init];
    storageLocation.borderStyle = UITextBorderStyleRoundedRect;
    storageLocation.textColor = [UIColor blackColor];
    storageLocation.font = [UIFont systemFontOfSize:18.0];
    storageLocation.backgroundColor = [UIColor whiteColor];
    storageLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
    storageLocation.backgroundColor = [UIColor whiteColor];
    storageLocation.autocorrectionType = UITextAutocorrectionTypeNo;
    storageLocation.layer.borderColor = [UIColor whiteColor].CGColor;
    storageLocation.backgroundColor = [UIColor whiteColor];
    storageLocation.delegate = self;
    storageLocation.placeholder = @"   Storage Location";
    [storageLocation addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [storageLocation awakeFromNib];
    storageLocation.text = @"All";
    
    reorderedDate = [[CustomTextField alloc] init];
    reorderedDate.borderStyle = UITextBorderStyleRoundedRect;
    reorderedDate.textColor = [UIColor blackColor];
    reorderedDate.placeholder = @"Verification Code";
    reorderedDate.backgroundColor = [UIColor whiteColor];
    reorderedDate.keyboardType = UIKeyboardTypeDefault;
    reorderedDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    reorderedDate.autocorrectionType = UITextAutocorrectionTypeNo;
    reorderedDate.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    reorderedDate.userInteractionEnabled = NO;
    reorderedDate.delegate = self;
    [reorderedDate awakeFromNib];
    
    
    reorderedDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD_ = [UIImage imageNamed:@"combo.png"];
    [reorderedDateBtn setBackgroundImage:buttonImageDD_ forState:UIControlStateNormal];
    [reorderedDateBtn addTarget:self
                         action:@selector(dueDateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    reorderedDateBtn.tag = 0;
    
    searchItem = [[UITextField alloc] init];
    searchItem.borderStyle = UITextBorderStyleRoundedRect;
    searchItem.textColor = [UIColor blackColor];
    searchItem.font = [UIFont systemFontOfSize:18.0];
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItem.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    searchItem.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItem.layer.borderColor = [UIColor whiteColor].CGColor;
    searchItem.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    searchItem.delegate = self;
    searchItem.placeholder = @"   Search Item Here";
    [searchItem addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    skListTable = [[UITableView alloc] init];
    skListTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    skListTable.dataSource = self;
    skListTable.delegate = self;
    (skListTable.layer).borderWidth = 1.0f;
    skListTable.layer.cornerRadius = 3;
    skListTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    barcodeBtn  = [[UIButton alloc] init];
    [barcodeBtn setImage:[UIImage imageNamed:@"scan_icon.png"] forState:UIControlStateNormal];
    [barcodeBtn addTarget:self action:@selector(barcodeScanner:) forControlEvents:UIControlEventTouchUpInside];
    barcodeBtn.tag = 1;
    
    
    UILabel *label2 = [[UILabel alloc] init] ;
    label2.text = @"S No";
    label2.layer.cornerRadius = 14;
    label2.layer.masksToBounds = YES;
    label2.numberOfLines = 2;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont boldSystemFontOfSize:14.0];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *label11 = [[UILabel alloc] init] ;
    label11.text = @"Description";
    label11.layer.cornerRadius = 14;
    label11.layer.masksToBounds = YES;
    label11.numberOfLines = 2;
    label11.textAlignment = NSTextAlignmentCenter;
    label11.font = [UIFont boldSystemFontOfSize:14.0];
    label11.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label11.textColor = [UIColor whiteColor];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"Price";
    label3.layer.cornerRadius = 14;
    label3.layer.masksToBounds = YES;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont boldSystemFontOfSize:14.0];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    
    UILabel *label4 = [[UILabel alloc] init] ;
    label4.text = @"Book Qty";
    label4.layer.cornerRadius = 14;
    label4.layer.masksToBounds = YES;
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont boldSystemFontOfSize:14.0];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    
    UILabel *label5 = [[UILabel alloc] init] ;
    label5.text = @"PRV. Verified Qty";
    label5.layer.cornerRadius = 14;
    label5.layer.masksToBounds = YES;
    label5.textAlignment = NSTextAlignmentCenter;
    label5.font = [UIFont boldSystemFontOfSize:14.0];
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label6 = [[UILabel alloc] init] ;
    label6.text = @"Sku Id";
    label6.layer.cornerRadius = 14;
    label6.layer.masksToBounds = YES;
    label6.textAlignment = NSTextAlignmentCenter;
    label6.font = [UIFont boldSystemFontOfSize:14.0];
    label6.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label6.textColor = [UIColor whiteColor];
    
    UILabel *label7 = [[UILabel alloc] init] ;
    label7.text = @"Physical Qty";
    label7.layer.cornerRadius = 14;
    label7.layer.masksToBounds = YES;
    label7.textAlignment = NSTextAlignmentCenter;
    label7.font = [UIFont boldSystemFontOfSize:14.0];
    label7.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label7.textColor = [UIColor whiteColor];
    
    UILabel *label8 = [[UILabel alloc] init] ;
    label8.text = @"Stock Loss";
    label8.layer.cornerRadius = 14;
    label8.layer.masksToBounds = YES;
    label8.textAlignment = NSTextAlignmentCenter;
    label8.font = [UIFont boldSystemFontOfSize:14.0];
    label8.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label8.textColor = [UIColor whiteColor];
    
    UILabel *label9 = [[UILabel alloc] init] ;
    label9.text = @"Loss Type";
    label9.layer.cornerRadius = 14;
    label9.layer.masksToBounds = YES;
    label9.textAlignment = NSTextAlignmentCenter;
    label9.font = [UIFont boldSystemFontOfSize:14.0];
    label9.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label9.textColor = [UIColor whiteColor];
    
    itemTable = [[UITableView alloc] init];
    itemTable.dataSource = self;
    itemTable.delegate = self;
    itemTable.backgroundColor = [UIColor clearColor];
    itemTable.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    itemTable.hidden = YES;
    
    submitBtn = [[UIButton alloc] init] ;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed) forControlEvents:UIControlEventTouchDown];
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    submitBtn.userInteractionEnabled = YES;
    cancelButton.userInteractionEnabled = YES;
    
    itemArray = [[NSMutableArray alloc] init];
    //
    itemSubArray = [[NSMutableArray alloc] init];
    
    
    UILabel *verificationCodeLbl = [[UILabel alloc] init];
    verificationCodeLbl.backgroundColor =[UIColor clearColor];
    verificationCodeLbl.text = @"Code :";
    verificationCodeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    verificationCodeLblVal = [[UILabel alloc] init];
    verificationCodeLblVal.backgroundColor =[UIColor clearColor];
    verificationCodeLblVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    UILabel *startDateLbl = [[UILabel alloc] init];
    startDateLbl.backgroundColor =[UIColor clearColor];
    startDateLbl.text = @"Start Date :";
    startDateLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    startDateLblVal = [[UILabel alloc] init];
    startDateLblVal.backgroundColor =[UIColor clearColor];
    startDateLblVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    UILabel *endDateLbl = [[UILabel alloc] init];
    endDateLbl.backgroundColor =[UIColor clearColor];
    endDateLbl.text = @"End Date :";
    endDateLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    endDateLblVal = [[UILabel alloc] init];
    endDateLblVal.backgroundColor =[UIColor clearColor];
    endDateLblVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        verificationCodeLbl.font = [UIFont boldSystemFontOfSize:20];
        verificationCodeLbl.frame = CGRectMake(10.0, 70, [verificationCodeLbl.text sizeWithFont:[UIFont boldSystemFontOfSize:20]].width + 5, 40);
        verificationCodeLblVal.font = [UIFont boldSystemFontOfSize:18];
        verificationCodeLblVal.frame = CGRectMake(verificationCodeLbl.frame.origin.x + verificationCodeLbl.frame.size.width, 70, 200, 40);
        startDateLbl.font = [UIFont boldSystemFontOfSize:20];
        startDateLbl.frame = CGRectMake(340, 70, [startDateLbl.text sizeWithFont:[UIFont boldSystemFontOfSize:20]].width + 5, 40);
        startDateLblVal.font = [UIFont boldSystemFontOfSize:18];
        startDateLblVal.frame = CGRectMake(startDateLbl.frame.origin.x + startDateLbl.frame.size.width, 70, 150, 40);
        endDateLbl.font = [UIFont boldSystemFontOfSize:20];
        endDateLbl.frame = CGRectMake(670, 70, [endDateLbl.text sizeWithFont:[UIFont boldSystemFontOfSize:20]].width +5 , 40);
        endDateLblVal.font = [UIFont boldSystemFontOfSize:18];
        endDateLblVal.frame = CGRectMake(endDateLbl.frame.origin.x + endDateLbl.frame.size.width, 70, 180, 40);
        
        
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(10.0, 150, 300, 40);
        
        selectLocation.frame = CGRectMake(330, 75, 50, 55);
        
        locationTable.frame = CGRectMake(10.0, location.frame.origin.y, 300, 0);
        
        verifiedDate.font = [UIFont boldSystemFontOfSize:20];
        verifiedDate.frame = CGRectMake(340.0, location.frame.origin.y, 300, 40);
        
        verifiedBy.font = [UIFont boldSystemFontOfSize:20];
        verifiedBy.frame = CGRectMake(670.0, location.frame.origin.y, 300, 40);
        
        storageLocation.font = [UIFont boldSystemFontOfSize:20];
        storageLocation.frame = CGRectMake(340.0, location.frame.origin.y + 50, 300, 40);
        
        storageUnit.font = [UIFont boldSystemFontOfSize:20];
        storageUnit.frame = CGRectMake(10.0, location.frame.origin.y + 50, 300, 40);
        
        reorderedDate.font = [UIFont boldSystemFontOfSize:20];
        reorderedDate.frame = CGRectMake(670.0, 130.0, 300, 40);
        reorderedDateBtn.frame = CGRectMake(940.0, 125.0, 50, 55);
        
        selectLocation.frame = CGRectMake(600.0, location.frame.origin.y + 45, 50, 55);
        selectStorage.frame = CGRectMake(270.0, location.frame.origin.y + 45, 50, 55);
        
        
        storageTable.frame = CGRectMake(10.0, storageUnit.frame.origin.y + storageUnit.frame.size.height, 300.0, 0);
        
        searchItem.font = [UIFont boldSystemFontOfSize:22];
        searchItem.frame = CGRectMake(10.0, storageUnit.frame.origin.y + 70, 1010.0, 40);
        
        
        
        label2.font = [UIFont boldSystemFontOfSize:15];
        label2.frame = CGRectMake(10, searchItem.frame.origin.y+searchItem.frame.size.height + 10, 80, 40);
        label6.font = [UIFont boldSystemFontOfSize:15];
        label6.frame = CGRectMake(95, searchItem.frame.origin.y+searchItem.frame.size.height+10, 120, 40);
        label11.font = [UIFont boldSystemFontOfSize:15];
        label11.frame = CGRectMake(220.0, searchItem.frame.origin.y+searchItem.frame.size.height+10, 120.0, 40);
        label3.font = [UIFont boldSystemFontOfSize:15];
        label3.frame = CGRectMake(345.0, searchItem.frame.origin.y+searchItem.frame.size.height+10, 80, 40);
        label4.font = [UIFont boldSystemFontOfSize:15];
        label4.frame = CGRectMake(430.0, searchItem.frame.origin.y+searchItem.frame.size.height+10, 80, 40);
        label5.font = [UIFont boldSystemFontOfSize:15];
        label5.frame = CGRectMake(515, searchItem.frame.origin.y+searchItem.frame.size.height+10, 130, 40);
        label7.font = [UIFont boldSystemFontOfSize:15];
        label7.frame = CGRectMake(650, searchItem.frame.origin.y+searchItem.frame.size.height + 10, 120, 40);
        label8.font = [UIFont boldSystemFontOfSize:15];
        label8.frame = CGRectMake(775, searchItem.frame.origin.y+searchItem.frame.size.height+10, 120, 40);
        label9.font = [UIFont boldSystemFontOfSize:15];
        label9.frame = CGRectMake(900, searchItem.frame.origin.y+searchItem.frame.size.height+10, 120, 40);
        
        itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        itemTable.frame = CGRectMake(0, label9.frame.origin.y + label9.frame.size.height + 5, 1030, 300.0);
        skListTable.frame = CGRectMake(10.0, 280.0, 1000,0);
        
        
        submitBtn.frame = CGRectMake(120.0, 680.0,300.0, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelButton.frame = CGRectMake(530.0f, 680.0,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.6]}];
        // fromLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:fromLocation.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        verifiedBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:verifiedBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.6]}];
        storageUnit.attributedPlaceholder = [[NSAttributedString alloc]initWithString:storageUnit.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.6]}];
        storageLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:storageLocation.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.6]}];
        reorderedDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:reorderedDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.6]}];
        
        [self.view addSubview:label2];
        [self.view addSubview:label11];
        [self.view addSubview:label3];
        [self.view addSubview:label4];
        [self.view addSubview:label5];
        [self.view addSubview:label6];
        [self.view addSubview:label7];
        [self.view addSubview:label8];
        [self.view addSubview:label9];
        [self.view addSubview:itemTable];
        
        
    }
    else{
        if (version>=8.0) {
            
            scrollView.frame = CGRectMake(0, 200.0, 768, 200);
            scrollView.contentSize = CGSizeMake(1100, 200);
            
            location.font = [UIFont boldSystemFontOfSize:15];
            location.frame = CGRectMake(0, 70, 150, 35);
            
            selectStorage.frame = CGRectMake(290.0, 105, 30, 50);
            
            locationTable.frame = CGRectMake(10.0, 65.0, 150, 0);
            
            verifiedDate.font = [UIFont boldSystemFontOfSize:15];
            verifiedDate.frame = CGRectMake(155.0, 70, 150, 35);
            
            verifiedBy.font = [UIFont boldSystemFontOfSize:15];
            verifiedBy.frame = CGRectMake(0, 110, 150, 35);
            
            storageUnit.font = [UIFont boldSystemFontOfSize:15];
            storageUnit.frame = CGRectMake(155, 110, 150, 35);
            
            searchItem.font = [UIFont boldSystemFontOfSize:15];
            searchItem.frame = CGRectMake(0.0, 160, self.view.frame.size.width, 35.0);
            
            itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            itemTable.frame = CGRectMake(0, 35.0, 778, 500);
            skListTable.frame = CGRectMake(200, 195.0, 360,0);
            //            barcodeBtn.frame = CGRectMake(223.0f, 70.0f, 40.0f, 40.0f);
            
            
            label2.font = [UIFont boldSystemFontOfSize:12];
            label2.frame = CGRectMake(5, 0, 60, 30);
            label6.font = [UIFont boldSystemFontOfSize:8];
            label6.frame = CGRectMake(65, 0, 60, 30);
            label11.font = [UIFont boldSystemFontOfSize:10];
            label11.frame = CGRectMake(125, 0, 60, 30);
            label3.font = [UIFont boldSystemFontOfSize:12];
            label3.frame = CGRectMake(185, 0, 60, 30);
            label4.font = [UIFont boldSystemFontOfSize:12];
            label4.frame = CGRectMake(245, 0, 60, 30);
            label5.font = [UIFont boldSystemFontOfSize:12];
            label5.frame = CGRectMake(305, 0, 60, 30);
            label7.font = [UIFont boldSystemFontOfSize:12];
            label7.frame = CGRectMake(365, 0, 80, 30);
            label8.font = [UIFont boldSystemFontOfSize:12];
            label8.frame = CGRectMake(445, 0, 80, 30);
            label9.font = [UIFont boldSystemFontOfSize:12];
            label9.frame = CGRectMake(525, 0, 80, 30);
            
            submitBtn.frame = CGRectMake(15.0f, 465,150.0f, 40.0f);
            submitBtn.layer.cornerRadius = 18.0f;
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            cancelButton.frame = CGRectMake(175, 465,150.0f, 40);
            cancelButton.layer.cornerRadius = 18.0f;
            cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            
            [scrollView addSubview:label2];
            [scrollView addSubview:label11];
            [scrollView addSubview:label3];
            [scrollView addSubview:label4];
            [scrollView addSubview:label5];
            [scrollView addSubview:label6];
            [scrollView addSubview:label7];
            [scrollView addSubview:label8];
            [scrollView addSubview:label9];
            [scrollView addSubview:itemTable];
        }
        else {
            scrollView.frame = CGRectMake(0, 140, 768, 200);
            scrollView.contentSize = CGSizeMake(1100, 200);
            
            location.font = [UIFont boldSystemFontOfSize:15];
            location.frame = CGRectMake(0, 10, 150, 35);
            
            selectStorage.frame = CGRectMake(290.0, 50, 30, 50);
            
            locationTable.frame = CGRectMake(10.0, 45.0, 150, 0);
            
            verifiedDate.font = [UIFont boldSystemFontOfSize:15];
            verifiedDate.frame = CGRectMake(155.0, 10, 150, 35);
            
            verifiedBy.font = [UIFont boldSystemFontOfSize:15];
            verifiedBy.frame = CGRectMake(0, 55, 150, 35);
            
            storageUnit.font = [UIFont boldSystemFontOfSize:15];
            storageUnit.frame = CGRectMake(155, 55, 150, 35);
            
            searchItem.font = [UIFont boldSystemFontOfSize:15];
            searchItem.frame = CGRectMake(0.0, 100, self.view.frame.size.width, 35.0);
            
            itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            itemTable.frame = CGRectMake(0, 35.0, 778, 500);
            skListTable.frame = CGRectMake(200, 135.0, 360,0);
            //            barcodeBtn.frame = CGRectMake(223.0f, 70.0f, 40.0f, 40.0f);
            
            
            label2.font = [UIFont boldSystemFontOfSize:12];
            label2.frame = CGRectMake(5, 0, 60, 30);
            label6.font = [UIFont boldSystemFontOfSize:8];
            label6.frame = CGRectMake(65, 0, 60, 30);
            label11.font = [UIFont boldSystemFontOfSize:10];
            label11.frame = CGRectMake(125, 0, 60, 30);
            label3.font = [UIFont boldSystemFontOfSize:12];
            label3.frame = CGRectMake(185, 0, 60, 30);
            label4.font = [UIFont boldSystemFontOfSize:12];
            label4.frame = CGRectMake(245, 0, 60, 30);
            label5.font = [UIFont boldSystemFontOfSize:12];
            label5.frame = CGRectMake(305, 0, 60, 30);
            label7.font = [UIFont boldSystemFontOfSize:12];
            label7.frame = CGRectMake(365, 0, 80, 30);
            label8.font = [UIFont boldSystemFontOfSize:12];
            label8.frame = CGRectMake(445, 0, 80, 30);
            label9.font = [UIFont boldSystemFontOfSize:12];
            label9.frame = CGRectMake(525, 0, 80, 30);
            
            submitBtn.frame = CGRectMake(15.0f, 365.0,150.0f, 40.0f);
            submitBtn.layer.cornerRadius = 18.0f;
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            cancelButton.frame = CGRectMake(175, 365.0,150.0f, 40);
            cancelButton.layer.cornerRadius = 18.0f;
            cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            
            [scrollView addSubview:label2];
            [scrollView addSubview:label11];
            [scrollView addSubview:label3];
            [scrollView addSubview:label4];
            [scrollView addSubview:label5];
            [scrollView addSubview:label6];
            [scrollView addSubview:label7];
            [scrollView addSubview:label8];
            [scrollView addSubview:label9];
            [scrollView addSubview:itemTable];
            
        }
        
        
    }
    
    itemTable.sectionFooterHeight = 0;
    itemTable.sectionHeaderHeight = 0;
    self.isOpen = NO;
    
    [self.view addSubview:location];
    [self.view addSubview:verificationCodeLbl];
    [self.view addSubview:verificationCodeLblVal];
    [self.view addSubview:startDateLbl];
    [self.view addSubview:startDateLblVal];
    [self.view addSubview:endDateLbl];
    [self.view addSubview:endDateLblVal];
    [self.view addSubview:verifiedDate];
    [self.view addSubview:verifiedBy];
    [self.view addSubview:storageUnit];
    [self.view addSubview:storageLocation];
    [self.view addSubview:selectStorage];
    [self.view addSubview:storageTable];
    [self.view addSubview:selectLocation];
    //    [self.view addSubview:reorderedDateBtn];
    [self.view addSubview:searchItem];
    [self.view addSubview:skListTable];
    [self.view addSubview:barcodeBtn];
    
    [self.view addSubview:submitBtn];
    [self.view addSubview:cancelButton];
    [self.view addSubview:scrollView];
    
    priceTable = [[UITableView alloc] init];
    priceTable.backgroundColor = [UIColor blackColor];
    priceTable.dataSource = self;
    priceTable.delegate = self;
    // [priceTable.layer setBorderWidth:1.0f];
    priceTable.layer.cornerRadius = 3;
    // priceTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    priceArr = [[NSMutableArray alloc]init];
    descArr = [[NSMutableArray alloc]init];
    
    closeBtn = [[UIButton alloc] init] ;
    [closeBtn addTarget:self action:@selector(closePriceView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 11;
    
    UIImage *image = [UIImage imageNamed:@"delete.png"];
    [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
    
    
    priceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    priceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    // priceView.hidden = YES;
    
    transparentPriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transparentPriceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentPriceView.hidden = YES;
    
    descLabl = [[UILabel alloc]init];
    descLabl.text = @"Description";
    descLabl.layer.cornerRadius = 14;
    descLabl.textAlignment = NSTextAlignmentCenter;
    descLabl.layer.masksToBounds = YES;
    descLabl.font = [UIFont boldSystemFontOfSize:14.0];
    descLabl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14.0f];
    descLabl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    descLabl.textColor = [UIColor whiteColor];
    
    
    priceLbl = [[UILabel alloc]init];
    priceLbl.text = @"Price";
    priceLbl.layer.cornerRadius = 14;
    priceLbl.layer.masksToBounds = YES;
    priceLbl.textAlignment = NSTextAlignmentCenter;
    priceLbl.font = [UIFont boldSystemFontOfSize:14.0];
    priceLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14.0f];
    priceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    priceLbl.textColor = [UIColor whiteColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        priceView.frame = CGRectMake(200, 150, 550,400);
        priceView.layer.borderColor = [UIColor whiteColor].CGColor;
        priceView.layer.borderWidth = 1.0;
        descLabl.frame = CGRectMake(30, 5, 200, 30);
        priceLbl.frame = CGRectMake(320.0, 5, 120, 30);
        transparentPriceView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        priceTable.frame = CGRectMake(0, 40, 550, 400);
        closeBtn.frame = CGRectMake(700, 112, 40, 40);
    }
    else {
        descLabl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
        priceLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
        priceView.frame = CGRectMake(10, 50.0, self.view.frame.size.width, self.view.frame.size.height);
        priceLbl.frame = CGRectMake(140.0, 5, 100, 30);
        descLabl.frame = CGRectMake(30, 5, 100, 30);
        closeBtn.frame = CGRectMake(250.0, 50.0, 40, 40);
        transparentPriceView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        priceTable.frame = CGRectMake(20, 40, 220,200);
    }
    [priceView addSubview:priceLbl];
    [priceView addSubview:descLabl];
    [priceView addSubview:priceTable];
    [transparentPriceView addSubview:priceView];
    [transparentPriceView addSubview:closeBtn];
    [self.view addSubview:transparentPriceView];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    HUD.labelText = @"Loading..";
    //    [self.view addSubview:cancelButton];
    
    
    lossTypeList = [[NSMutableArray alloc] init];
    [lossTypeList addObject:@"Shop Theft"];
    [lossTypeList addObject:@"Damaged"];
    [lossTypeList addObject:@"Expired"];
    [lossTypeList addObject:@"Manufacturing Defect"];
    [lossTypeList addObject:@"Other"];
    
    isVerifiable = true;
    
    productInfoArr = [NSMutableArray new];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    @try {
        [self getVerificationCode];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(void)getVerificationCode {
    
    @try {
        
        [HUD setHidden:NO];
        
        NSDictionary *reqDic = @{REQUEST_HEADER: [RequestHeader getRequestHeader],@"location": presentLocation,@"startIndex": @"-1",@"status": @"In Progress"};
        
        //   @"validMasterCode"
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getCodeJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_VERIFICATION_CODE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,getCodeJsonString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if (![[billingResponse valueForKey:RESPONSE_HEADER]isKindOfClass:[NSNull class]] &&[[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [HUD setHidden:YES];
                     
                     NSDictionary *dic = [billingResponse valueForKey:@"verificationMasterList"][0];
                     
                     
                     verificationCodeLblVal.text = [dic valueForKey:@"verification_code"];
                     startDateLblVal.text = [dic valueForKey:@"verificationStartDateStr"];
                     endDateLblVal.text = [dic valueForKey:@"verificationEndDateStr"];
                     
                     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                     formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
                     formatter.dateFormat = @"dd/MM/yyyy";
                     NSDate *endDate = [formatter dateFromString:endDateLblVal.text];
                     
                     NSComparisonResult result = [endDate compare:[NSDate date]];
                     
                     if(result==NSOrderedAscending) {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your verfication time period is up" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alert show];
                         
                         self.view.userInteractionEnabled = FALSE;
                         isVerifiable = false;
                         return;
                     }
                     
                 }
                 else {
                     [HUD setHidden:YES];
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     self.view.userInteractionEnabled = FALSE;
                     
                 }
             }
             else {
                 [HUD setHidden:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:connectionError.localizedDescription message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
                 self.view.userInteractionEnabled = FALSE;
             }
         }];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
    
    
}

-(IBAction) dueDateButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    
    pickView = [[UIView alloc] init];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(15, reorderedDate.frame.origin.y+reorderedDate.frame.size.height, 320, 320);
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
    
    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
    pickButton.frame = CGRectMake(85, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    //pickButton.layer.masksToBounds = YES;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:reorderedDate.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
        catPopOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
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
}

-(IBAction)getDate:(id)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [pickView setHidden:YES];
    [catPopOver dismissPopoverAnimated:YES];
    //Date Formate Setting...
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    sdayFormat.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString *dateString = [sdayFormat stringFromDate:myPicker.date];
    
    NSComparisonResult result = [myPicker.date compare:[NSDate date]];
    
    //    if(result==NSOrderedAscending) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Invalid Date Selection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //        [alert release];
    //    }
    //    else {
    
    NSArray *temp =[dateString componentsSeparatedByString:@" "];
    NSLog(@" %@",temp);
    
    reorderedDate.text = dateString;
    // [pickView removeFromSuperview];
    
    //    }
}

#pragma mark - PowaScannerObserver

- (void)scanner:(id<PowaScanner>)scanner scannedBarcodeData:(NSData *)data
{
    @try {
        
        NSString *barcodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (barcodeString.length>0 && isVerifiable) {
            searchedString= [barcodeString copy];
            @try {
                
                NSArray *keys = @[@"skuId",@"requestHeader",@"storeLocation"];
                NSArray *objects = @[barcodeString,[RequestHeader getRequestHeader],presentLocation];
                
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                
                NSError * err;
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
                NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                //                    getSkuid.skuID = salesReportJsonString;
               /// dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    
                    WebServiceController *serviceController = [WebServiceController new];
                    serviceController.getSkuDetailsDelegate = self;
                    [serviceController getSkuDetailsWithData:salesReportJsonString];
                    
//                });
            }
            @catch (NSException *exception) {
                
                
            }
            @finally {
                
                
            }
            
        }
    }
    @catch(NSException * exception) {
        
    }
}

- (void) barcodeScanner:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    searchItem.text = @"";
    [searchItem resignFirstResponder];
    skListTable.hidden = YES;
    
    barcodeBtn.tag = 1;
    
    
    //    ZXingWidgetController *widController =
    //    [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:YES];
    //
    //    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    //
    //    MultiFormatOneDReader* reader = [[MultiFormatOneDReader alloc] init];
    //    [readers addObject:reader];
    //    [reader release];
    //
    //    widController.readers = readers;
    //    [readers release];
    //
    //    //    NSBundle *mainBundle = [NSBundle mainBundle];
    //    //    widController.soundToPlay =
    //    //    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    //
    //    [self presentViewController:widController animated:YES completion:NULL];
    
    
}

#pragma mark -
#pragma mark ZXingWidgetDelegateMethods
//- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
//    [self dismissViewControllerAnimated:YES completion:NULL];
//
//        if (result) {
//
//            HUD.dimBackground = YES;
//            HUD.labelText = @"Please Wait..";
//            [HUD setHidden:NO];
//
//
//            SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
//
//            SkuServiceSvc_getSkuDetails *getSkuid = [[SkuServiceSvc_getSkuDetails alloc] init];
//
//            NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
//            NSArray *str = [time componentsSeparatedByString:@" "];
//            NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
//            NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
//
//            NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
//            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
//
//            NSArray *keys = [NSArray arrayWithObjects:@"skuId",@"requestHeader", nil];
//            NSArray *objects = [NSArray arrayWithObjects:result,dictionary_, nil];
//
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//            getSkuid.skuID = salesReportJsonString;
//            SkuServiceSoapBindingResponse *response = [skuService getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)getSkuid];
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
//                    SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
//                    printf("\nresponse=%s",[body.return_ UTF8String]);
//                    NSError *e;
//                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                         options: NSJSONReadingMutableContainers
//                                                                           error: &e];
//                    if (![[NSString stringWithFormat:@"%@",[JSON objectForKey:@"productName"]] isEqualToString:@"<null>"]) {
//
//                        [HUD setHidden:YES];
//
//                        NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@",result,@"#",[JSON valueForKey:@"quantity"],@"#",[JSON valueForKey:@"quantity"],@"#",@"0",@"#",@"--",@"#",[JSON valueForKey:@"description"],@"#",@"--"];
//                        selected_SKID = result;
//                        [self getSkuDetailsHandler:itemString];
////                        [itemArray addObject:itemString];
////                        itemTable.hidden = NO;
////                        [itemTable reloadData];
//
//
//                     //   }
////                        else{
////                            [HUD setHidden:YES];
////                            UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Stock Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////                            [alert show];
////                            [alert release];
////                        }
//                    }
//
//
//                }
//            }
//
//        }
//    }
//- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
//
//    [self dismissViewControllerAnimated:YES completion:NULL];
//
//    barcodeBtn.tag = 0;
//    //
//}


// Commented by roja on 17/10/2019.. // reason:- getListOfStorageLocations: method contains SOAP Service call .. so taken new method with same name(getListOfStorageLocations:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getListOfStorageLocations:(id)sender {
//
//    @try {
//
//        [HUD setHidden:NO];
//
//        storageLocationsArr = [[NSMutableArray alloc]init];
//
//        storeStockVerificationServicesSoapBinding *materialBinding = [storeStockVerificationServicesSvc storeStockVerificationServicesSoapBinding];
//
//
//        NSArray *loyaltyKeys = @[@"storage_unit",REQUEST_HEADER];
//
//        NSArray *loyaltyObjects = @[storageUnit.text,[RequestHeader getRequestHeader]];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        storeStockVerificationServicesSvc_getStorageLocation *getStorageLocation = [[storeStockVerificationServicesSvc_getStorageLocation alloc] init];
//        getStorageLocation.storage_unit = loyaltyString;
//
//
//        storeStockVerificationServicesSoapBindingResponse *response_ = [materialBinding getStorageLocationUsingParameters:getStorageLocation];
//
//        NSArray *responseBodyParts1_ = response_.bodyParts;
//        NSDictionary *JSON1;
//        for (id bodyPart in responseBodyParts1_) {
//
//            if ([bodyPart isKindOfClass:[storeStockVerificationServicesSvc_getStorageLocationResponse class]]) {
//                // status = TRUE;
//                storeStockVerificationServicesSvc_getStorageLocationResponse *body = (storeStockVerificationServicesSvc_getStorageLocationResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//
//                //status = body.return_;
//                NSError *e;
//                JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &e] copy];
//
//                if (![[JSON1 valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
//
//                    if (![[JSON1 valueForKey:@"storage_location"] isKindOfClass:[NSNull class]]) {
//                        [storageLocationsArr addObject:@"All"];
//                        for (NSString *units in [JSON1 valueForKey:@"storage_location"]) {
//
//                            [storageLocationsArr addObject:units];
//                        }
//
//                        [self populateView:storageLocations];
//
//                    }
//
//                }
//
//            }
//        }
//
//        //        else {
//        //
//        //            fromlocationScrollValueStatus_ = YES;
//        //
//        //        }
//
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//
//        [HUD setHidden:YES];
//    }
//}


//getListOfStorageLocations: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getListOfStorageLocations:(id)sender {
    
    @try {
        
        [HUD setHidden:NO];
        
        storageLocationsArr = [[NSMutableArray alloc]init];
        
        NSArray *loyaltyKeys = @[@"storage_unit",REQUEST_HEADER];
        
        NSArray *loyaltyObjects = @[storageUnit.text,[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * services =  [[WebServiceController alloc] init];
        services.storeStockVerificationDelegate = self;
        [services getStoreLocation:loyaltyString];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
    }
}


// added by Roja on 17/10/2019…. // OLd code only pasted here
- (void)getStoreLocationSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        if (![[successDictionary valueForKey:@"storage_location"] isKindOfClass:[NSNull class]]) {
            
            [storageLocationsArr addObject:@"All"];
            
            for (NSString *units in [successDictionary valueForKey:@"storage_location"]) {
                
                [storageLocationsArr addObject:units];
            }
            
            [self populateView:storageLocations];
            
        }
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}

// added by Roja on 17/10/2019…. // OLd code only pasted here
- (void)getStoreLocationErrorResponse:(NSString *)requestString{
    
    @try {
        
        NSLog(@"getStoreLocationErrorResponse in StockVerification: %@", requestString);
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}


// Commented by roja on 17/10/2019.. // reason :- getLocations: method contains SOAP Service call .. so taken new method with same name(getLocations:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getLocations:(int)startIndex {
//    @try {
//
//        locationArr = [[NSMutableArray alloc]init];
//
//        UtilityMasterServiceSoapBinding *utility =  [UtilityMasterServiceSvc UtilityMasterServiceSoapBinding];
//        utility.logXMLInOut = YES;
//
//        //    NSError * err;
//        //    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//        //    NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
//
//        NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader]];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        UtilityMasterServiceSvc_getLocation *location2 = [[UtilityMasterServiceSvc_getLocation alloc] init];
//        location2.locationDetails = loyaltyString;
//
//
//        UtilityMasterServiceSoapBindingResponse *response_ = [utility getLocationUsingParameters:location2];
//
//        NSArray *responseBodyParts1_ = response_.bodyParts;
//        NSDictionary *JSON1;
//        for (id bodyPart in responseBodyParts1_) {
//
//            if ([bodyPart isKindOfClass:[UtilityMasterServiceSvc_getLocationResponse class]]) {
//                // status = TRUE;
//                UtilityMasterServiceSvc_getLocationResponse *body = (UtilityMasterServiceSvc_getLocationResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//
//                //status = body.return_;
//                NSError *e;
//                JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &e] copy];
//            }
//        }
//
//        NSDictionary *responseHeader = [JSON1 valueForKey:@"responseHeader"];
//
//        if ([[responseHeader valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseHeader valueForKey:@"responseMessage"] isEqualToString:@"Location Details"]) {
//
//            NSArray *locations = [JSON1 valueForKey:@"locationDetails"];
//
//            for (int i=0; i < locations.count; i++) {
//
//                NSDictionary *location1 = locations[i];
//
//                [locationArr addObject:[location1 valueForKey:@"locationId"]];
//
//            }
//
//            if ([locationArr containsObject:presentLocation]) {
//
//                [locationArr removeObject:presentLocation];
//            }
//
//            [locationTable reloadData];
//
//        }
//        //        else {
//        //
//        //            fromlocationScrollValueStatus_ = YES;
//        //
//        //        }
//
//    }
//    @catch (NSException *exception) {
//
//    }
//}


//getLocations: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

-(void)getLocations:(int)startIndex {
    
    @try {
        [HUD setHidden:NO];

        locationArr = [[NSMutableArray alloc]init];
        NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
        
        NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * services  = [[WebServiceController alloc] init];
        services.utilityMasterDelegate = self;
        [services getAllLocationDetailsData:loyaltyString];
        
    }
    @catch (NSException *exception) {
        
    }
}


// added by Roja on 17/10/2019…. // OLd code only written below
- (void)getLocationSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        NSArray *locations = [sucessDictionary valueForKey:@"locationDetails"];
        
        for (int i=0; i < locations.count; i++) {
            
            NSDictionary *location1 = locations[i];
            [locationArr addObject:[location1 valueForKey:@"locationId"]];
        }
        
        if ([locationArr containsObject:presentLocation]) {
            
            [locationArr removeObject:presentLocation];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [locationTable reloadData];
    }
}


// added by Roja on 17/10/2019…. // OLd code only written below
- (void)getLocationErrorResponse:(NSString *)error{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [locationTable reloadData];

    }
}






// Commented by roja on 17/10/2019.. // reason :- getListOfStorageUnits: method contains SOAP Service call .. so taken new method with same name(getListOfStorageUnits:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void) getListOfStorageUnits:(UIButton *)sender {
//
//    @try {
//
//        if (storageUnits !=nil && storageUnits.count) {
//
//            [self populateView:storageTable];
//        }
//        else {
//
//            [HUD setHidden:NO];
//
//            storageUnits = [[NSMutableArray alloc]init];
//
//            storeStockVerificationServicesSoapBinding *materialBinding = [storeStockVerificationServicesSvc storeStockVerificationServicesSoapBinding];
//
//
//            NSArray *loyaltyKeys = @[@"store_location",REQUEST_HEADER];
//
//            NSArray *loyaltyObjects = @[presentLocation,[RequestHeader getRequestHeader]];
//            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//            storeStockVerificationServicesSvc_getStorageUnit *getStorageUnit = [[storeStockVerificationServicesSvc_getStorageUnit alloc] init];
//            getStorageUnit.store_location = loyaltyString;
//
//
//            storeStockVerificationServicesSoapBindingResponse *response_ = [materialBinding getStorageUnitUsingParameters:getStorageUnit];
//
//            NSArray *responseBodyParts1_ = response_.bodyParts;
//            NSDictionary *JSON1;
//            for (id bodyPart in responseBodyParts1_) {
//
//                if ([bodyPart isKindOfClass:[storeStockVerificationServicesSvc_getStorageUnitResponse class]]) {
//                    // status = TRUE;
//                    storeStockVerificationServicesSvc_getStorageUnitResponse *body = (storeStockVerificationServicesSvc_getStorageUnitResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//
//                    //status = body.return_;
//                    NSError *e;
//                    JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                             options: NSJSONReadingMutableContainers
//                                                               error: &e] copy];
//
//                    if (![[JSON1 valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
//
//                        if (![[JSON1 valueForKey:@"storage_unit"] isKindOfClass:[NSNull class]]) {
//                            [storageUnits addObject:@"All"];
//                            for (NSString *units in [JSON1 valueForKey:@"storage_unit"]) {
//
//                                [storageUnits addObject:units];
//                            }
//
//                            [self populateView:storageTable];
//
//                        }
//
//
//                    }
//
//                }
//            }
//
//
//            //        else {
//            //
//            //            fromlocationScrollValueStatus_ = YES;
//            //
//            //        }
//
//        }
//
//
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//
//        [HUD setHidden:YES];
//
//    }
//
//
//}


//getListOfStorageUnits: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

-(void) getListOfStorageUnits:(UIButton *)sender {
    
    @try {
        
        if (storageUnits !=nil && storageUnits.count) {
            
            [self populateView:storageTable];
        }
        else {
            
            [HUD setHidden:NO];
            
            storageUnits = [[NSMutableArray alloc]init];
            
            NSArray *loyaltyKeys = @[@"store_location",REQUEST_HEADER];
            
            NSArray *loyaltyObjects = @[presentLocation,[RequestHeader getRequestHeader]];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * services  =  [[WebServiceController alloc] init];
            services.storeStockVerificationDelegate =  self;
            [services getStoreUnit:loyaltyString];
         
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
    }
}

// added by Roja on 17/10/2019…. // OLD code only added below
- (void)getStoreUnitSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        if (![[successDictionary valueForKey:@"storage_unit"] isKindOfClass:[NSNull class]]) {
            [storageUnits addObject:@"All"];
            for (NSString *units in [successDictionary valueForKey:@"storage_unit"]) {
                
                [storageUnits addObject:units];
            }
            [self populateView:storageTable];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // OLD code only added below
- (void)getStoreUnitErrorResponse:(NSString *)requestString{
    
    @try {
        
        NSLog(@"getStoreUnitErrorResponse in StockVerification : %@",requestString );
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



-(void)searchProduct:(NSString *)searchString{
    
    
    CheckWifi *wifi = [CheckWifi new];
    
    if ([wifi checkWifi]) {
        
        
        @try {
            
            NSString *storageUnitStr = @"";
            NSString *storageLoc = @"";
            NSArray *keys,*objects;
            if (![storageUnit.text isEqualToString:@"All"]) {
                
                storageUnitStr = storageUnit.text;
            }
            if (![storageLocation.text isEqualToString:@"All"]) {
                
                storageLoc = storageLocation.text;
            }
            
            
            keys = @[@"requestHeader",@"startIndex",@"searchCriteria",@"storeLocation",@"storage_unit",@"storage_location"];
            objects = @[[RequestHeader getRequestHeader],@"-1",searchString,presentLocation,storageUnitStr,storageLoc];
            
            
            
            //            NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"startIndex",@"searchCriteria",@"storeLocation",nil];
            //            NSArray *objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader],@"-1",searchString,presentLocation, nil];
            
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //        getSkuid.searchCriteria = salesReportJsonString;
            //
            if (tempSkuArrayList.count!=0) {
                [tempSkuArrayList removeAllObjects];
            }
            //
            
            WebServiceController *webServiceController = [WebServiceController new];
            webServiceController.searchProductDelegate = self;
            [webServiceController searchProductsWithData:salesReportJsonString];
        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
            
        }
    }
    else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please enable wi-fi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - Search Products Service Reposnse Delegates

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    [tempSkuArrayList removeAllObjects];
    
    [HUD setHidden:YES];
    
    @try {
        if (successDictionary != nil) {
            if (![successDictionary[@"productsList"] isKindOfClass:[NSNull class]]) {
                NSArray *list = successDictionary[@"productsList"];
                [tempSkuArrayList addObjectsFromArray:list];
            }
            [skuArrayList removeAllObjects];
            [rawMaterials removeAllObjects];
            priceArrayList = [NSMutableArray new];
            for (NSDictionary *product in tempSkuArrayList)
            {
                NSComparisonResult result;
                
                //                if (!([[product objectForKey:@"productId"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound))
                //                {
                //                    result = [[product objectForKey:@"productId"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchStringStock length])];
                //                    if (result == NSOrderedSame)
                //                    {
                //                        [skuArrayList addObject:[product objectForKey:@"productId"]];
                //                        [rawMaterials addObject:product];
                //
                //                    }
                //                }
                if (!([product[@"description"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound)) {
                    
                    [skuArrayList addObject:product[@"description"]];
                    [rawMaterials addObject:product];
                    
                    [priceArrayList addObject:[product[@"price"] stringValue]];
                    
                }
                else {
                    
                    // [filteredSkuArrayList addObject:[product objectForKey:@"skuID"]];
                    
                    
                    result = [product[@"skuID"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, searchStringStock.length)];
                    
                    if (result == NSOrderedSame)
                    {
                        [skuArrayList addObject:product[@"skuID"]];
                        [rawMaterials addObject:product];
                        [priceArrayList addObject:[product[@"price"] stringValue]];
                        
                    }
                }
                
                
            }
            
            if (skuArrayList.count > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    skListTable.frame = CGRectMake(searchItem.frame.origin.x, searchItem.frame.origin.y + searchItem.frame.size.height, searchItem.frame.size.width,240);
                }
                else {
                    if (version >= 8.0) {
                        skListTable.frame = CGRectMake(10, 170, 310.0,200);
                    }
                    else{
                        skListTable.frame = CGRectMake(10.0, 170.0, 310.0, 130);
                    }
                }
                
                if (skuArrayList.count > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        skListTable.frame = CGRectMake(searchItem.frame.origin.x, searchItem.frame.origin.y + searchItem.frame.size.height, searchItem.frame.size.width,240);
                    }
                    else {
                        if (version >= 8.0) {
                            skListTable.frame = CGRectMake(10, 170, 310,200);
                        }
                        else{
                            skListTable.frame = CGRectMake(10, 170.0, 310, 130);
                        }
                    }
                }
                [self.view bringSubviewToFront:skListTable];
                [skListTable reloadData];
                skListTable.hidden = NO;
            }
            else {
                skListTable.hidden = YES;
            }
        }
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
    }
    
}
- (void)searchProductsErrorResponse {
    [HUD setHidden:YES];
    
}

#pragma mark End of Search Products Service Reposnse Delegates -


-(void)searchParticularProduct :(NSString *)searchString{
    
    
    CheckWifi *wifi = [CheckWifi new];
    
    if ([wifi checkWifi]) {
        
        HUD.dimBackground = YES;
        [HUD setHidden:NO];
        
        //        SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
        //
        //        SkuServiceSvc_getSkuDetails *getSkuid = [[SkuServiceSvc_getSkuDetails alloc] init];
        @try {
            
            searchedString = [searchString copy];
            
            NSArray *keys = @[@"skuId",@"requestHeader",@"storeLocation"];
            NSArray *objects = @[searchString,[RequestHeader getRequestHeader],presentLocation];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            //        getSkuid.skuID = salesReportJsonString;
            
            WebServiceController *webServiceController = [WebServiceController new];
            webServiceController.getSkuDetailsDelegate = self;
            [webServiceController getSkuDetailsWithData:salesReportJsonString];
            
            
        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
        }
        
        
    }
    else {
        UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enable Wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    
}
- (void) getSkuDetailsHandler: (NSString *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        //NSLog(@"%@", value);
        return;
    }
    
    @try {
        // Do something with the NSString* result
        NSString* result = (NSString*)value;
        
        
        //    if (barcodeBtn.tag == 1) {
        if (result.length > 0) {
            
            int qty = 0;
            
            //  need to do this.....
            
            //            float price = 0.0 ;
            //float unitPrice = 0.0;
            
            for (int i = 0; i < itemArray.count; i++) {
                
                if ([[itemArray[i] componentsSeparatedByString:@"#"][0] isEqualToString:selected_SKID] && [[itemArray[i] componentsSeparatedByString:@"#"][9] isEqualToString:selected_SKID_pluCode]) {
                    NSArray *itemArr = [itemArray[i] componentsSeparatedByString:@"#"];
                    NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",itemArr[0],@"#",itemArr[1],@"#",itemArr[2],@"#",itemArr[3],@"#",itemArr[4],@"#",itemArr[5],@"#",[NSString stringWithFormat:@"%.2f",[itemArr[6] floatValue] + 1],@"#",[NSString stringWithFormat:@"%.2f",([itemArr[4] floatValue] - ([itemArr[6] floatValue] + 1))],@"#",itemArr[8],@"#",itemArr[9],@"#",itemArr[10]];
                    itemArray[i] = itemString;
                    qty++;
                }
                
            }
            
            
            if (qty == 0) {
                
                [itemArray addObject:result];
                
            }
            
            itemTable.hidden = NO;
            [itemTable reloadData];
            
            
            
            SystemSoundID    soundFileObject1;
            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
            AudioServicesPlaySystemSound (soundFileObject1);
        }
        else {
            
            SystemSoundID    soundFileObject1;
            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
            AudioServicesPlaySystemSound (soundFileObject1);
            
            UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"No Product or Failed to scan" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.name);
        [HUD setHidden:YES];
    }
    @finally {
        [HUD setHidden:YES];
    }
}

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary
{
    @try {
        if (successDictionary != nil) {
            if (![[successDictionary valueForKey:@"skuLists"] isKindOfClass:[NSNull class]]) {
                
                priceDic = [[NSMutableArray alloc]init];
                
                NSArray *price_arr = [successDictionary valueForKey:@"skuLists"];
                for (int i=0; i<price_arr.count; i++) {
                    
                    NSDictionary *json = price_arr[i];
                    [priceDic addObject:json];
                }
                
                if ([[successDictionary valueForKey:@"skuLists"] count]>1) {
                    
                    
                    if (priceDic.count>0) {
                        [HUD setHidden:YES];
                        transparentPriceView.hidden = NO;
                        [priceTable reloadData];
                    }
                }
                else {
                    
                    
                    NSDictionary *itemDic = priceDic[0];
                    
                    NSMutableDictionary *productInfoDic = [NSMutableDictionary new];
                    
                    if (([itemDic.allKeys containsObject:kProductCategory] && ![itemDic[kProductCategory] isKindOfClass:[NSNull class]])) {
                        
                        productInfoDic[kProductCategory] = itemDic[kProductCategory];
                    }
                    else {
                        productInfoDic[kProductCategory] = @"";

                    }
                    
                    if (([itemDic.allKeys containsObject:kProductSubCategory] && ![itemDic[kProductSubCategory] isKindOfClass:[NSNull class]])) {
                        
                        productInfoDic[kProductSubCategory] = itemDic[kProductSubCategory];
                    }
                    else {
                        productInfoDic[kProductSubCategory] = @"";
                        
                    }
                  
                    
                    if (([itemDic.allKeys containsObject:kProductBrand] && ![itemDic[kProductBrand] isKindOfClass:[NSNull class]])) {
                        
                        productInfoDic[kProductBrand] = itemDic[kProductBrand];
                    }
                    else {
                        productInfoDic[kProductBrand] = @"";
                        
                    }
                    if (([itemDic.allKeys containsObject:kProductModel] && ![itemDic[kProductModel] isKindOfClass:[NSNull class]])) {
                        
                        productInfoDic[kProductModel] = itemDic[kProductModel];
                    }
                    else {
                        productInfoDic[kProductModel] = @"";
                        
                    }
                    if (![productInfoArr containsObject:productInfoDic]) {
                        [productInfoArr addObject:productInfoDic];
                    }

                    
                    if ([[itemDic valueForKey:@"quantity"] integerValue]>0) {
                        NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",[itemDic valueForKey:@"skuId"],@"#",@"-",@"#",[itemDic valueForKey:@"description"],@"#",[itemDic valueForKey:@"price"],@"#",[itemDic valueForKey:@"quantity"],@"#",@"-",@"#",@"1",@"#",[NSString stringWithFormat:@"%.2f",([[itemDic valueForKey:@"quantity"] floatValue] - 1)],@"#",@" ",@"#",[itemDic valueForKey:@"pluCode"],@"#",[itemDic valueForKey:@"uom"]];
                        selected_SKID = [[itemDic valueForKey:@"skuId"] copy];
                        selected_SKID_pluCode = [[itemDic valueForKey:@"pluCode"] copy];
                        [self getSkuDetailsHandler:itemString];
                        
                    }
                    else {
                        
                        [HUD setHidden:YES];
                        
                        NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",[itemDic valueForKey:@"skuId"],@"#",@"-",@"#",[itemDic valueForKey:@"description"],@"#",[itemDic valueForKey:@"price"],@"#",[itemDic valueForKey:@"quantity"],@"#",@"-",@"#",@"1",@"#",[NSString stringWithFormat:@"%.2f",[[itemDic valueForKey:@"quantity"] floatValue]],@"#",@" ",@"#",[itemDic valueForKey:@"pluCode"],@"#",[itemDic valueForKey:@"uom"]];
                        selected_SKID = [[itemDic valueForKey:@"skuId"] copy];
                        selected_SKID_pluCode = [[itemDic valueForKey:@"pluCode"] copy];
                        [self getSkuDetailsHandler:itemString];
                        
                    }
                    
                }
            }
        }
    }
    @catch(NSException *exception) {
        [HUD setHidden:YES];
        
    }
}

- (void)getSkuDetailsErrorResponse:(NSString *)failureString {
    [HUD setHidden:YES];
    UIAlertView * alert=  [[UIAlertView alloc] initWithTitle:failureString message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == searchItem) {
        if ((textField.text).length >= 3) {
            //            [itemArray removeAllObjects];
            //            [itemTable reloadData];
            searchStringStock = [textField.text copy];
            [HUD setHidden:NO];
            [self searchProduct:textField.text];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void) openQTYView
{
    
    @try {
        itemTable.userInteractionEnabled  = NO;
        
        NSArray *temp = [itemArray[cellPosition] componentsSeparatedByString:@"#"];
        
        transparentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
        transparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        transparentView.hidden = NO;
        rejectQtyChangeDisplayView = [[UIView alloc]init];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            rejectQtyChangeDisplayView.frame = CGRectMake(150.0, 100.0, 740.0, 620);
        }
        else{
            rejectQtyChangeDisplayView.frame = CGRectMake(20, 70, 280, 380);
        }
        rejectQtyChangeDisplayView.layer.borderWidth = 1.0;
        rejectQtyChangeDisplayView.layer.cornerRadius = 10.0;
        rejectQtyChangeDisplayView.layer.masksToBounds = YES;
        rejectQtyChangeDisplayView.hidden = NO;
        rejectQtyChangeDisplayView.layer.borderColor = [UIColor whiteColor].CGColor;
        rejectQtyChangeDisplayView.backgroundColor = [UIColor blackColor];
        
        UIImageView *img  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
        
        // a label on top of the view ..
        UILabel *topbar = [[UILabel alloc] init];
        topbar.backgroundColor = [UIColor grayColor];
        topbar.text = @"Enter Verified Quantity";
        topbar.backgroundColor = [UIColor clearColor];
        topbar.textAlignment = NSTextAlignmentCenter;
        topbar.font = [UIFont boldSystemFontOfSize:17];
        topbar.textColor = [UIColor whiteColor];
        
        UIButton *backbutton = [[UIButton alloc] init] ;
        [backbutton addTarget:self action:@selector(closeQuantityView:) forControlEvents:UIControlEventTouchUpInside];
        backbutton.tag = 11;
        
        UIImage *image = [UIImage imageNamed:@"delete.png"];
        [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
        
        
        UILabel *unitPrice = [[UILabel alloc] init];
        unitPrice.text = @"Book Quantity       :";
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        unitPrice.backgroundColor = [UIColor clearColor];
        unitPrice.textColor = [UIColor whiteColor];
        
        UILabel *unitPriceData = [[UILabel alloc] init];
        if(temp.count > 9 && ![temp[10] isKindOfClass:[NSNull class]]) {
            unitPriceData.text = [NSString stringWithFormat:@"%@\t (%@)",temp[4],temp[10]];
        }
        else {
            unitPriceData.text = [NSString stringWithFormat:@"%@",temp[4]];
            
        }
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        unitPriceData.backgroundColor = [UIColor clearColor];
        unitPriceData.textColor = [UIColor whiteColor];
        
        UILabel *physicalQty = [[UILabel alloc] init];
        
        physicalQty.text = @"Physical Qty         :";
        physicalQty.font = [UIFont boldSystemFontOfSize:14];
        physicalQty.backgroundColor = [UIColor clearColor];
        physicalQty.textColor = [UIColor whiteColor];
        
        rejecQtyField = [[CustomTextField alloc] init];
        rejecQtyField.borderStyle = UITextBorderStyleRoundedRect;
        rejecQtyField.textColor = [UIColor blackColor];
        rejecQtyField.placeholder = @"  Enter Qty";
        //NumberKeyBoard hidden....
        UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar1.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar1 sizeToFit];
        rejecQtyField.keyboardType = UIKeyboardTypeNumberPad;
        rejecQtyField.inputAccessoryView = numberToolbar1;
        //        rejecQtyField.text = textField.text;
        rejecQtyField.font = [UIFont systemFontOfSize:17.0];
        rejecQtyField.backgroundColor = [UIColor whiteColor];
        rejecQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
        //qtyFeild.keyboardType = UIKeyboardTypeDefault;
        rejecQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
        rejecQtyField.returnKeyType = UIReturnKeyDone;
        rejecQtyField.delegate = self;
        [rejecQtyField becomeFirstResponder];
        [rejecQtyField awakeFromNib];
        rejecQtyField.text = [NSString stringWithFormat:@"%@",temp[6]];
        
        UILabel *lossType = [[UILabel alloc] init];
        
        lossType.text = @"Loss Type             :";
        lossType.font = [UIFont boldSystemFontOfSize:14];
        lossType.backgroundColor = [UIColor clearColor];
        lossType.textColor = [UIColor whiteColor];
        
        lossTypeField = [[CustomTextField alloc] init];
        lossTypeField.borderStyle = UITextBorderStyleRoundedRect;
        lossTypeField.textColor = [UIColor blackColor];
        lossTypeField.font = [UIFont systemFontOfSize:18.0];
        lossTypeField.backgroundColor = [UIColor whiteColor];
        lossTypeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        lossTypeField.backgroundColor = [UIColor whiteColor];
        lossTypeField.autocorrectionType = UITextAutocorrectionTypeNo;
        lossTypeField.layer.borderColor = [UIColor whiteColor].CGColor;
        lossTypeField.backgroundColor = [UIColor whiteColor];
        lossTypeField.delegate = self;
        lossTypeField.placeholder = @"   Loss Type";
        [lossTypeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        lossTypeField.userInteractionEnabled = NO;
        [lossTypeField awakeFromNib];
        if (![temp[4] isEqualToString:@"--"]) {
            
            lossTypeField.text = [NSString stringWithFormat:@"%@",temp[8]];
            
        }
        
        lossTypeTable = [[UITableView alloc] init];
        lossTypeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        lossTypeTable.dataSource = self;
        lossTypeTable.delegate = self;
        (lossTypeTable.layer).borderWidth = 1.0f;
        lossTypeTable.layer.cornerRadius = 3;
        lossTypeTable.layer.borderColor = [UIColor grayColor].CGColor;
        lossTypeTable.hidden = YES;
        
        lossTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
        [lossTypeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
        [lossTypeButton addTarget:self action:@selector(populateLossTypes) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *remarks = [[UILabel alloc] init];
        
        remarks.text = @"Remarks";
        remarks.font = [UIFont boldSystemFontOfSize:14];
        remarks.backgroundColor = [UIColor clearColor];
        remarks.textColor = [UIColor whiteColor];
        
        remarkTextView = [[UITextView alloc] init];
        remarkTextView.delegate = self;
        remarkTextView.textColor = [UIColor whiteColor];
        remarkTextView.layer.cornerRadius = 5.0f;
        remarkTextView.backgroundColor = [UIColor clearColor];
        remarkTextView.layer.borderWidth = 1.0f;
        remarkTextView.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        
        if (temp.count >11) {
            
            remarkTextView.text = [NSString stringWithFormat:@"%@",temp[11]];
            
        }
        
        okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
        [okButton addTarget:self
                     action:@selector(orderButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        okButton.backgroundColor = [UIColor grayColor];
        
        /** CancelButton for qtyChangeDisplyView....*/
        qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
        [qtyCancelButton addTarget:self
                            action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        qtyCancelButton.backgroundColor = [UIColor grayColor];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            
            img.frame = CGRectMake(0, 0, 740.0, 50);
            topbar.frame = CGRectMake(0, 5, 740.0, 40);
            topbar.font = [UIFont boldSystemFontOfSize:22];
            
            backbutton.frame = CGRectMake(topbar.frame.size.width - 50, 10, 40, 40);
            
            unitPrice.frame = CGRectMake(50,60,200,40);
            unitPrice.font = [UIFont boldSystemFontOfSize:20];
            
            
            unitPriceData.frame = CGRectMake(240.0,60,2500,40);
            unitPriceData.font = [UIFont boldSystemFontOfSize:20];
            
            physicalQty.frame = CGRectMake(50,120.0,200,40);
            physicalQty.font = [UIFont boldSystemFontOfSize:20];
            
            rejecQtyField.frame = CGRectMake(240.0, 120, 200.0, 40);
            rejecQtyField.font = [UIFont boldSystemFontOfSize:20];
            
            lossType.frame = CGRectMake(50,180.0,200,40);
            lossType.font = [UIFont boldSystemFontOfSize:20];
            
            lossTypeField.font = [UIFont boldSystemFontOfSize:20];
            lossTypeField.frame = CGRectMake(240.0, 180.0, 200.0, 40);
            
            lossTypeButton.frame = CGRectMake(410.0, 174.0, 40.0, 55.0);
            
            lossTypeTable.frame = CGRectMake(240.0, 220.0, 250.0, 270);
            
            remarks.frame = CGRectMake(50,240,200,40);
            remarks.font = [UIFont boldSystemFontOfSize:20];
            
            remarkTextView.font = [UIFont boldSystemFontOfSize:20];
            remarkTextView.frame = CGRectMake(50.0, 300.0, 600.0, 200.0);
            
            okButton.frame = CGRectMake(60, 180, 80, 50);
            okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            okButton.frame = CGRectMake(100.0, 540.0, 165, 45);
            okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            okButton.layer.cornerRadius = 20.0f;
            
            qtyCancelButton.frame = CGRectMake(470.0, 540.0, 165, 45);
            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            qtyCancelButton.layer.cornerRadius = 20.0f;
            
            
        }
        else{
            
            if (version>=8.0) {
                
                img.frame = CGRectMake(0, 0, 280, 32);
                topbar.frame = CGRectMake(0, 0, 175, 30);
                topbar.font = [UIFont boldSystemFontOfSize:10];
                
                unitPrice.frame = CGRectMake(10,40,150,30);
                unitPrice.font = [UIFont boldSystemFontOfSize:10];
                
                unitPriceData.frame = CGRectMake(150,40 ,60,30);
                unitPriceData.font = [UIFont boldSystemFontOfSize:10];
                
                physicalQty.frame = CGRectMake(10,80,200,40);
                physicalQty.font = [UIFont boldSystemFontOfSize:10];
                
                rejecQtyField.frame = CGRectMake(150, 80, 100, 30);
                rejecQtyField.font = [UIFont systemFontOfSize:10];
                
                
                lossType.frame = CGRectMake(10,120,200,40);
                lossType.font = [UIFont boldSystemFontOfSize:10];
                
                lossTypeField.font = [UIFont boldSystemFontOfSize:10];
                lossTypeField.frame = CGRectMake(150, 120, 100, 30);
                
                lossTypeButton.frame = CGRectMake(240.0, 115, 30.0, 40.0);
                
                lossTypeTable.frame = CGRectMake(150, 150, 100, 200);
                
                remarks.frame = CGRectMake(10,160,200,40);
                remarks.font = [UIFont boldSystemFontOfSize:10];
                
                remarkTextView.font = [UIFont boldSystemFontOfSize:10];
                remarkTextView.frame = CGRectMake(10, 200, 230, 120);
                
                
                okButton.frame = CGRectMake(50, 340, 75, 30);
                okButton.layer.cornerRadius = 14.0f;
                okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
                
                qtyCancelButton.frame = CGRectMake(150, 340, 75, 30);
                qtyCancelButton.layer.cornerRadius = 14.0f;
                qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                
                
            }
            else {
                
                img.frame = CGRectMake(0, 0, 280, 32);
                topbar.frame = CGRectMake(0, 0, 175, 30);
                topbar.font = [UIFont boldSystemFontOfSize:10];
                
                unitPrice.frame = CGRectMake(10,40,150,30);
                unitPrice.font = [UIFont boldSystemFontOfSize:10];
                
                unitPriceData.frame = CGRectMake(150,40 ,60,30);
                unitPriceData.font = [UIFont boldSystemFontOfSize:10];
                
                physicalQty.frame = CGRectMake(10,80,200,40);
                physicalQty.font = [UIFont boldSystemFontOfSize:10];
                
                rejecQtyField.frame = CGRectMake(150, 80, 100, 30);
                rejecQtyField.font = [UIFont systemFontOfSize:10];
                
                
                lossType.frame = CGRectMake(10,120,200,40);
                lossType.font = [UIFont boldSystemFontOfSize:10];
                
                lossTypeField.font = [UIFont boldSystemFontOfSize:10];
                lossTypeField.frame = CGRectMake(150, 120, 100, 30);
                
                lossTypeButton.frame = CGRectMake(240.0, 115, 30.0, 40.0);
                
                lossTypeTable.frame = CGRectMake(150, 150, 100, 200);
                
                remarks.frame = CGRectMake(10,160,200,40);
                remarks.font = [UIFont boldSystemFontOfSize:10];
                
                remarkTextView.font = [UIFont boldSystemFontOfSize:10];
                remarkTextView.frame = CGRectMake(10, 200, 230, 120);
                
                
                okButton.frame = CGRectMake(50, 340, 75, 30);
                okButton.layer.cornerRadius = 14.0f;
                okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
                
                qtyCancelButton.frame = CGRectMake(150, 340, 75, 30);
                qtyCancelButton.layer.cornerRadius = 14.0f;
                qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                
            }
            
            
            
        }
        
        [rejectQtyChangeDisplayView addSubview:img];
        [rejectQtyChangeDisplayView addSubview:topbar];
        [rejectQtyChangeDisplayView addSubview:backbutton];
        [rejectQtyChangeDisplayView addSubview:unitPrice];
        [rejectQtyChangeDisplayView addSubview:unitPriceData];
        [rejectQtyChangeDisplayView addSubview:physicalQty];
        [rejectQtyChangeDisplayView addSubview:rejecQtyField];
        [rejectQtyChangeDisplayView addSubview:lossType];
        
        [rejectQtyChangeDisplayView addSubview:lossTypeField];
        [rejectQtyChangeDisplayView addSubview:lossTypeButton];
        [rejectQtyChangeDisplayView addSubview:remarks];
        [rejectQtyChangeDisplayView addSubview:remarkTextView];
        [rejectQtyChangeDisplayView addSubview:okButton];
        [rejectQtyChangeDisplayView addSubview:qtyCancelButton];
        [rejectQtyChangeDisplayView addSubview:lossTypeTable];
        [transparentView addSubview:rejectQtyChangeDisplayView];
        [self.view addSubview:transparentView];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
    
    
    
}

-(void)orderButtonPressed:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    NSString *value = [rejecQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *lossTypeValue = [lossTypeField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *remarksValue = [remarkTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:rejecQtyField.text];
    NSArray *temp = [itemArray[cellPosition] componentsSeparatedByString:@"#"];
    float qty = value.floatValue;
    if(value.length == 0 || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter quantity in number" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        rejecQtyField.text = NO;
    }
    //    else if([rejecQtyField.text isEqualToString:@"0"]){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter valid quantity" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //
    //        rejecQtyField.text = nil;
    //    }
    else if (qty > [temp[4] floatValue]){
        qtyWarning = [[UIAlertView alloc] initWithTitle:@"Physical quantity exceeding the booked quantity" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        [qtyWarning show];
    }
    else if (([temp[4] floatValue] - qty) > 0 && lossTypeValue.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select Loss Type" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        NSString *str = @"";
        if (remarksValue.length == 0) {
            str  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",temp[0],@"#",temp[1],@"#",temp[2],@"#",temp[3],@"#",temp[4],@"#",temp[5],@"#",[NSString stringWithFormat:@"%.2f",qty],@"#",[NSString stringWithFormat:@"%.2f",[temp[4] floatValue] - qty],@"#",lossTypeField.text,@"#",temp[9],@"#",temp[10],@"#",@"--"];
        }
        else{
            str  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",temp[0],@"#",temp[1],@"#",temp[2],@"#",temp[3],@"#",temp[4],@"#",temp[5],@"#",[NSString stringWithFormat:@"%.2f",qty],@"#",[NSString stringWithFormat:@"%.2f",[temp[4] floatValue] - qty],@"#",lossTypeField.text,@"#",temp[9],@"#",temp[10],@"#",remarkTextView.text];
        }
        
        //        if ([lossTypeField.text isEqualToString:@"None"]) {
        //            str  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",[temp objectAtIndex:0],@"#",[temp objectAtIndex:1],@"#",[temp objectAtIndex:2],@"#",[temp objectAtIndex:3],@"#",[temp objectAtIndex:4],@"#",[temp objectAtIndex:5],@"#",[NSString stringWithFormat:@"%d",qty],@"#",[NSString stringWithFormat:@"%d",[[temp objectAtIndex:4] intValue] - qty],@"#",@"--",@"#",[temp objectAtIndex:9],@"#",remarkTextView.text];
        //        }
        itemArray[cellPosition] = str;
        
        transparentView.hidden = YES;
        
        [rejecQtyField resignFirstResponder];
        
        itemTable.userInteractionEnabled = YES;
        
        [itemTable reloadData];
    }
}

-(void)cancelButtonPressed:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    transparentView.hidden = YES;
    itemTable.userInteractionEnabled = YES;
}

-(void)closePriceView:(UIButton *)sender {
    transparentPriceView.hidden = YES;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == itemTable) {
        return itemArray.count;
    }
    else{
        return 1;
    }
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == skListTable){
        
        return  rawMaterials.count;
    }
    else if(tableView == itemTable){
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                return [itemSubArray[0] count] + 1;
            }
        }
        return 1;
    }
    else if (tableView == locationTable) {
        
        return locationArr.count;
    }
    else if (tableView == storageTable) {
        return storageUnits.count;
    }
    else if (tableView == storageLocations) {
        return storageLocationsArr.count;
    }
    else if (tableView == lossTypeTable){
        return  lossTypeList.count;
    }
    else if (tableView == priceTable){
        return priceDic.count;
    }
    else{
        return 0;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if(tableView == lossTypeTable){
//
//
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//
//            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
//            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//
//            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 255, 30)] autorelease];
//            label1.font = [UIFont boldSystemFontOfSize:22.0];
//            label1.backgroundColor = [UIColor clearColor];
//            label1.text = @"Select Loss Type";
//            label1.textColor = [UIColor whiteColor];
//            [headerView addSubview:label1];
//
//            UIButton *closeButton = [[UIButton alloc] init] ;
//            [closeButton addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
//            closeButton.frame = CGRectMake(200.0, 4, 30, 30);
//            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
//            [closeButton setBackgroundImage:image    forState:UIControlStateNormal];
//            [headerView addSubview:closeButton];
//
//            return headerView;
//        }
//        else{
//
//            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
//            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//
//            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 175, 30)] autorelease];
//            label1.font = [UIFont boldSystemFontOfSize:17.0];
//            label1.backgroundColor = [UIColor clearColor];
//            label1.text = @"Select The ShipMode";
//            label1.textColor = [UIColor whiteColor];
//            [headerView addSubview:label1];
//
//            UIButton *closeButton = [[UIButton alloc] init] ;
//            [closeButton addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
//            closeButton.frame = CGRectMake(185, 4, 28, 28);
//            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
//            [closeButton setBackgroundImage:image    forState:UIControlStateNormal];
//            [headerView addSubview:closeButton];
//
//            return headerView;
//
//        }
//
//    }
//    else{
//        return NO;
//    }
//}

//Customize HeightForHeaderInSection ...
//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (tableView == lossTypeTable) {
//        return 35.0;
//    }
//    else{
//        return 0;
//    }
//}

//heigth for tableviewcell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == skListTable) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 45.0;
            
        }
        else {
            return 35.0;
        }
    }
    else if (tableView == priceTable) {
        return 40.0;
    }
    else if(tableView == itemTable){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (indexPath.row == 0) {
                return 70.0;
            }
            else{
                return 50.0;
            }
            
        }
        else {
            if (indexPath.row == 0) {
                return 40;
            }
            else{
                return 30.0;
            }
        }
        
    }
    else if (tableView == lossTypeTable){
        return 35.0;
    }
    else{
        return 45.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"TableView";
    
    if (tableView == skListTable) {
        
        
        static NSString *hlCellID = @"hlCellID";
        
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
        @try {
            
            //  NSDictionary *dic = [priceDic objectAtIndex:indexPath.row];
            
            UILabel *skid = [[UILabel alloc] init] ;
            skid.layer.borderWidth = 1.5;
            skid.font = [UIFont systemFontOfSize:13.0];
            skid.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            skid.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            skid.backgroundColor = [UIColor whiteColor];
            skid.textColor = [UIColor blackColor];
            skid.text = skuArrayList[indexPath.row];
            skid.textAlignment=NSTextAlignmentLeft;
            
            
            UILabel *name = [[UILabel alloc] init] ;
            name.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            name.layer.borderWidth = 1.5;
            name.backgroundColor =[UIColor whiteColor];
            name.text = [NSString stringWithFormat:@"%.2f",[priceArrayList[indexPath.row] floatValue]];
            name.textAlignment = NSTextAlignmentCenter;
            name.numberOfLines = 2;
            name.textColor = [UIColor blackColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                skid.font = [UIFont systemFontOfSize:18];
                skid.frame = CGRectMake(0, 0, searchItem.frame.size.width/2, 50);
                name.font = [UIFont systemFontOfSize:18];
                name.frame = CGRectMake(skid.frame.size.width, 0, searchItem.frame.size.width/2, 50);
                
                
            }
            else {
                
                skid.frame = CGRectMake(5, 0, 130, 34);
                name.frame = CGRectMake(135, 0, 70, 34);
                
                
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:skid];
            [hlcell.contentView addSubview:name];
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        }
        
        return hlcell;
        
        
        
    }
    else if (tableView == priceTable) {
        
        static NSString *hlCellID = @"hlCellID";
        
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
        @try {
            
            NSDictionary *dic = priceDic[indexPath.row];
            
            UILabel *skid = [[UILabel alloc] init] ;
            skid.layer.borderWidth = 1.5;
            skid.font = [UIFont systemFontOfSize:13.0];
            skid.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            skid.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            skid.backgroundColor = [UIColor blackColor];
            skid.textColor = [UIColor whiteColor];
            skid.text = [dic valueForKey:@"description"];
            skid.textAlignment=NSTextAlignmentCenter;
            //            skid.adjustsFontSizeToFitWidth = YES;
            
            
            UILabel *name = [[UILabel alloc] init] ;
            name.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            name.layer.borderWidth = 1.5;
            name.backgroundColor = [UIColor blackColor];
            name.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:@"price"] floatValue]];
            name.textAlignment = NSTextAlignmentCenter;
            name.numberOfLines = 2;
            name.textColor = [UIColor whiteColor];
            // name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                skid.font = [UIFont systemFontOfSize:18];
                skid.frame = CGRectMake(0, 0, 300, 50);
                name.font = [UIFont systemFontOfSize:18];
                name.frame = CGRectMake(300, 0, 210, 50);
                //                }
                //                else {
                //                    //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
                //                    skid.font = [UIFont fontWithName:@"Helvetica" size:22];
                //                    skid.frame = CGRectMake(5, 0, 125, 56);
                //                    name.font = [UIFont fontWithName:@"Helvetica" size:18];
                //                    name.frame = CGRectMake(130, 0, 125, 56);
                //
                //                }
                //
                
            }
            else {
                
                skid.frame = CGRectMake(10, 0, 100, 34);
                name.frame = CGRectMake(120, 0, 90, 34);
                
                
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:skid];
            [hlcell.contentView addSubview:name];
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        }
        @finally {
            
            
        }
        return hlcell;
        
        
    }
    else if (tableView == lossTypeTable){
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",lossTypeList[indexPath.row]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            hlcell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
            
        }
        else {
            hlcell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            
        }
        hlcell.textLabel.textColor = [UIColor blackColor];
    }
    else if (tableView == itemTable){
        
        
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
            
            static NSString *CellIdentifier = @"Cell2";
//            cell2 = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            
//            if (!cell2) {
//                cell2 = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
//            }
            //NSArray *list = [itemSubArray objectAtIndex:indexPath.row];
            
            //            NSArray *titleList = [list objectAtIndex:0];
            ////            priceList = [list objectAtIndex:1];
            //            //        NSArray *list1 = [[list objectAtIndex:indexPath.row-1] componentsSeparatedByString:@" "];
            //            //        NSLog(@"%@",list1);
            //            cell2.titleLabel.text = [titleList objectAtIndex:indexPath.row-1];
            //            cell2.priceLabel.text = [NSString stringWithFormat:@"%.2f",[[priceList objectAtIndex:indexPath.row-1] floatValue]];
            //            [cell2 setBackgroundColor:[UIColor blackColor]];
            //
            //            // cell2.piecesLabel.text = @"2pcs";
            //
            //            if ([dictionary1 count] == 0) {
            //
            //                cell2.orderedQtyLabel.text = @"";
            //            }
            //            else {
            //
            //                if ([dictionary1 objectForKey:cell2.titleLabel.text]) {
            //
            //                    cell2.orderedQtyLabel.text = [dictionary1 valueForKey:cell2.titleLabel.text];
            //                }
            //                else {
            //                    cell2.orderedQtyLabel.text = @"";
            //
            //                }
            //
            //            }
            //[cell2 setBackgroundColor:[UIColor blackColor]];
           // return cell2;
        }else
        {
            itemTable.hidden = NO;
            NSArray *temp = [itemArray[indexPath.section] componentsSeparatedByString:@"#"];
            //            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            static NSString *CellIdentifier_;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                CellIdentifier_ = @"Cell1";
            }
            else{
                CellIdentifier_ = @"Cell1-iPhone";
            }
            cell1 = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier_];
            if (!cell1) {
                cell1 = [[NSBundle mainBundle] loadNibNamed:CellIdentifier_ owner:self options:nil][0];
            }
            //            NSString *name = [menuItemsCategories objectAtIndex:indexPath.section];
            cell1.titleLabel.text = [NSString stringWithFormat:@"%d",indexPath.section + 1];
            cell1.priceModel.text = [NSString stringWithFormat:@"%@",temp[0]];
            cell1.itemDesc.text = [NSString stringWithFormat:@"%@",temp[2]];
            cell1.itemPrice.text = [NSString stringWithFormat:@"%@",temp[3]];
            cell1.bookQuantity.text = [NSString stringWithFormat:@"%@",temp[4]];
            cell1.prvVerifiedQty.text = [NSString stringWithFormat:@"%@",temp[4]];
            cell1.physicalQty.text = [NSString stringWithFormat:@"%@",temp[6]];
            cell1.quantityLoss.text = [NSString stringWithFormat:@"%@",temp[7]];
            cell1.lossType.text = [NSString stringWithFormat:@"%@",temp[8]];
            cell1.itemDesc.numberOfLines = 3;
            
            cell1.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [cell1 changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
            cell1.backgroundColor = [UIColor blackColor];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
            }
            return cell1;
        }
    }
    else if (tableView == locationTable) {
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
        }
        
        hlcell.textLabel.text = locationArr[indexPath.row];
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellEditingStyleNone;
        return hlcell;
        
    }
    else if (tableView == storageTable) {
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            }
        }
        hlcell.textLabel.text = storageUnits[indexPath.row];
        // [hlcell setBackgroundColor:[UIColor clearColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            hlcell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        hlcell.selectionStyle = UITableViewCellEditingStyleNone;
        return hlcell;
        
    }
    else if (tableView == storageLocations) {
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            }
        }
        hlcell.textLabel.text = storageLocationsArr[indexPath.row];
        // [hlcell setBackgroundColor:[UIColor clearColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            hlcell.textLabel.font = [UIFont systemFontOfSize:12.0];
        }
        hlcell.selectionStyle = UITableViewCellEditingStyleNone;
        return hlcell;
        
    }
    return hlcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    [searchItem resignFirstResponder];
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor clearColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == skListTable) {
        selected_SKID = skuArrayList[indexPath.row];
        searchItem.text = @"";
        skListTable.hidden = YES;
        NSDictionary *json = rawMaterials[indexPath.row];
        [self searchParticularProduct:[NSString stringWithFormat:@"%@",[json valueForKey:@"skuID"]]];
    }
    else if (tableView == priceTable) {
        transparentPriceView.hidden = YES;
        NSDictionary *JSON = priceDic[indexPath.row];
        
        @try {
            
            NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",[JSON valueForKey:@"skuId"],@"#",@"-",@"#",[JSON valueForKey:@"description"],@"#",[JSON valueForKey:@"price"],@"#",[JSON valueForKey:@"quantity"],@"#",@"-",@"#",@"1",@"#",[NSString stringWithFormat:@"%.2f",([[JSON valueForKey:@"quantity"] floatValue] - 1)],@"#",@"--",@"#",[JSON valueForKey:@"pluCode"],@"#",[JSON valueForKey:@"uom"]];
            selected_SKID = [[JSON valueForKey:@"skuId"] copy];
            selected_SKID_pluCode = [[JSON valueForKey:@"pluCode"] copy];
            
            NSMutableDictionary *productInfoDic = [NSMutableDictionary new];
            
            if (([JSON.allKeys containsObject:kProductCategory] && ![JSON[kProductCategory] isKindOfClass:[NSNull class]])) {
                
                productInfoDic[kProductCategory] = JSON[kProductCategory];
            }
            else {
                productInfoDic[kProductCategory] = @"";
                
            }
            
            if (([JSON.allKeys containsObject:kProductSubCategory] && ![JSON[kProductSubCategory] isKindOfClass:[NSNull class]])) {
                
                productInfoDic[kProductSubCategory] = JSON[kProductSubCategory];
            }
            else {
                productInfoDic[kProductSubCategory] = @"";
                
            }
            
            
            if (([JSON.allKeys containsObject:kProductBrand] && ![JSON[kProductBrand] isKindOfClass:[NSNull class]])) {
                
                productInfoDic[kProductBrand] = JSON[kProductBrand];
            }
            else {
                productInfoDic[kProductBrand] = @"";
                
            }
            if (([JSON.allKeys containsObject:kProductModel] && ![JSON[kProductModel] isKindOfClass:[NSNull class]])) {
                
                productInfoDic[kProductModel] = JSON[kProductModel];
            }
            else {
                productInfoDic[kProductModel] = @"";
                
            }
            if (![productInfoArr containsObject:productInfoDic]) {
                [productInfoArr addObject:productInfoDic];
            }

            
            [self getSkuDetailsHandler:itemString];
            
        }
        @catch (NSException* exception) {
            
        }
    }
    else if (tableView == lossTypeTable){
        
        [catPopOver dismissPopoverAnimated:YES];
        
        lossTypeField.text = [NSString stringWithFormat:@"%@",lossTypeList[indexPath.row]];
        lossTypeTable.hidden = YES;
        okButton.enabled = YES;
        cancelButton.enabled = YES;
        
    }
    else if (tableView == itemTable){
        cellPosition = indexPath.section;
        [self openQTYView];
        //        if (indexPath.row == 0) {
        //
        //            if ([indexPath isEqual:self.selectIndex]) {
        //                self.isOpen = NO;
        //                [self didSelectCellRowFirstDo:NO nextDo:NO];
        //                self.selectIndex = nil;
        //
        //            }else
        //            {
        //                if (!self.selectIndex) {
        //                    self.selectIndex = indexPath;
        //                    [self didSelectCellRowFirstDo:YES nextDo:NO];
        //
        //                }else
        //                {
        //
        //                    [self didSelectCellRowFirstDo:NO nextDo:YES];
        //                }
        //            }
        //
        //        }
    }
    //        if (indexPath.row == 0) {
    //
    //            //cell1 = (Cell1 *)[tableView cellForRowAtIndexPath:self.selectIndex];
    //
    //            if ([indexPath isEqual:self.selectIndex]) {
    //                self.isOpen = NO;
    //                [self didSelectCellRowFirstDo:NO nextDo:NO];
    //                self.selectIndex = nil;
    //
    //            }else
    //            {
    //                if (!self.selectIndex) {
    //                    self.selectIndex = indexPath;
    //                    [self didSelectCellRowFirstDo:YES nextDo:NO];
    //
    //                }else
    //                {
    //
    //                    [self didSelectCellRowFirstDo:NO nextDo:YES];
    //                }
    //            }
    //
    //        }else
    //        {
    //        }
    
    else if (tableView == locationTable) {
        
        location.text = @"";
        [location resignFirstResponder];
        locationTable.hidden = YES;
        location.text = locationArr[indexPath.row];
        [skListTable setUserInteractionEnabled:YES];
        [selectLocation setEnabled:YES];
        [submitBtn setEnabled:YES];
        [cancelButton setEnabled:YES];
        [locationArr removeAllObjects];
        selectLocation.tag = 1;
    }
    else if (tableView == storageTable) {
        
        [catPopOver dismissPopoverAnimated:YES];
        storageUnit.text = @"";
        [storageUnit resignFirstResponder];
        storageTable.hidden = YES;
        storageUnit.text = storageUnits[indexPath.row];
        [itemTable setUserInteractionEnabled:YES];
        [selectStorage setEnabled:YES];
        selectStorage.tag = 2;
        selectLocation.enabled = YES;
    }
    else if (tableView == storageLocations) {
        
        [catPopOver dismissPopoverAnimated:YES];
        storageTable.hidden = YES;
        storageLocation.text = storageLocationsArr[indexPath.row];
    }
    
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    cell1 = (Cell1 *)[itemTable cellForRowAtIndexPath:self.selectIndex];
    [cell1 changeArrowWithUp:firstDoInsert];
    
    [itemTable beginUpdates];
    
    int section = self.selectIndex.section;
    int contentCount = [itemSubArray[0] count];
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i < contentCount + 1; i++) {
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
        [rowToInsert addObject:indexPathToInsert];
    }
    
    if (firstDoInsert)
    {
        [itemTable insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [itemTable deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    
    [itemTable endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = itemTable.indexPathForSelectedRow;
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [itemTable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}



// Commented by roja on 17/10/2019.. // reason :- submitButtonPressed method contains SOAP Service call .. so taken new method with same name(submitButtonPressed) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)submitButtonPressed{
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    BOOL countStatus = FALSE;
//
//    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *verifiedDateValue = [verifiedDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *verifiedByValue = [verifiedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *storageValue = [storageUnit.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    if (itemArray.count == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else if (locationValue.length == 0 || verifiedDateValue.length == 0 || verifiedByValue.length == 0){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please provide all the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//
//    else{
//
//        MBProgressHUD *HUD_ = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//        [self.navigationController.view addSubview:HUD_];
//        // Regiser for HUD callbacks so we can remove it from the window at the right time
//        HUD_.delegate = self;
//        HUD_.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
//        HUD_.mode = MBProgressHUDModeCustomView;
//        // Show the HUD
//        [HUD_ show:YES];
//        [HUD_ setHidden:NO];
//        [HUD_ setHidden:NO];
//        HUD_.labelText = @"Verifying Stock..";
//
//        float productBookStock = 0;
//        float productPhysicalStock = 0;
//        NSMutableArray *stockList = [[NSMutableArray alloc] init];
//
//        for (int i = 0; i < itemArray.count; i++) {
//            NSArray *temp = [itemArray[i] componentsSeparatedByString:@"#"];
//            productBookStock = productBookStock + [temp[1] floatValue];
//            productPhysicalStock = productPhysicalStock + [temp[2] floatValue];
//        }
//        @try {
//
//
//            for (int c = 0; c < itemArray.count; c++) {
//
//
//                //            @Column(name = "sku_replenishment_date")
//                //            private Date sku_replenishment_date;
//
//                NSDictionary *productInfo = productInfoArr[c];
//
//
//                NSArray *temp_ = [[itemArray[c] componentsSeparatedByString:@"#"] copy];
//                //  if ([[temp_ objectAtIndex:3] intValue] > 0) {
//                NSArray *headerKeys = @[@"product_id", @"sku_id",@"product_book_stock",@"product_physical_stock",@"sku_book_stock",@"sku_physical_stock",@"stock_loss",@"loss_type",@"remarks",@"pluCode",@"sku_allocated",@"sku_reordered_qty",@"sku_reOrderDate",@"skuSalePrice",@"costPriceValue",@"mrpValue",@"salePriceValue",@"costPriceVariance",@"mrpVariance",@"salePriceVariance",@"skuCostPrice",@"skuMrp",@"skuDescription",@"sku_expected_date",@"productCategory",@"subCategory",@"brand",@"model"];
//
//                NSArray *headerObjects = @[[NSString stringWithFormat:@"%@",temp_[0]],[NSString stringWithFormat:@"%@",temp_[0]],[NSString stringWithFormat:@"%@",temp_[4]],[NSString stringWithFormat:@"%@",temp_[6]],[NSString stringWithFormat:@"%@",temp_[4]],[NSString stringWithFormat:@"%@",temp_[6]],[NSString stringWithFormat:@"%@",temp_[7]],[NSString stringWithFormat:@"%@",temp_[8]],@"", [NSString stringWithFormat:@"%@",temp_[9]],@100.0f,@100.0f,verifiedDate.text,@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),temp_[2],verifiedDate.text,[productInfo valueForKey:kProductCategory],[productInfo valueForKey:kProductSubCategory],[productInfo valueForKey:kProductBrand],[productInfo valueForKey:kProductModel]];
//
//
//                NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
//
//                [stockList addObject:dictionary_];
//
//                countStatus = TRUE;
//                //            }
//            }
//
//            //        if (!countStatus) {
//            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Quantity Lost is Zero for All the products" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            //            [alert show];
//            //            [alert release];
//            //            [HUD_ setHidden:YES];
//            //            [HUD_ release];
//            //            return;
//            //        }
//
//
//            BOOL status = FALSE;
//            storeStockVerificationServicesSoapBinding *materialBinding = [storeStockVerificationServicesSvc storeStockVerificationServicesSoapBinding];
//            storeStockVerificationServicesSvc_createStock *aParams = [[storeStockVerificationServicesSvc_createStock alloc] init];
//
//
//            NSArray *keys = @[@"verified_on", @"verified_by",@"location",@"storageUnit",@"itemsList",@"requestHeader",@"masterVerificationCode"];
//            NSArray *objects;
//            if (storageValue.length == 0) {
//                objects = @[verifiedDate.text,verifiedBy.text,location.text,@"--",stockList,[RequestHeader getRequestHeader],verificationCodeLblVal.text];
//            }
//            else {
//                objects = @[verifiedDate.text,verifiedBy.text,location.text,storageUnit.text,stockList,[RequestHeader getRequestHeader],verificationCodeLblVal.text];
//            }
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//            NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//            aParams.stockVerificationDetails = createReceiptJsonString;
//
//            storeStockVerificationServicesSoapBindingResponse *response = [materialBinding createStockUsingParameters:(storeStockVerificationServicesSvc_createStock *)aParams];
//            NSArray *responseBodyParts = response.bodyParts;
//            NSDictionary *JSONData ;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[storeStockVerificationServicesSvc_createStockResponse class]]) {
//                    storeStockVerificationServicesSvc_createStockResponse *body = (storeStockVerificationServicesSvc_createStockResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    NSError *err;
//                    status = TRUE;
//                    JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                options: NSJSONReadingMutableContainers
//                                                                  error: &err] copy];
//                    verifyJSON = [JSONData copy];
//                }
//            }
//            if (status) {
//
//                NSDictionary *json = verifyJSON[@"responseHeader"];
//
//                if ([json[@"responseCode"] intValue] == 0) {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Stock Verified Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//
//                    storageLocation.text = nil;
//                    storageUnit.text = nil;
//                    @try {
//
//                        [itemArray removeAllObjects];
//                        [itemSubArray removeAllObjects];
//
//                        [itemTable reloadData];
//                    }
//                    @catch (NSException *exception) {
//
//
//                    }
//
//
//
//                    [HUD_ setHidden:YES];
//
//                    //[self viewDidLoad];
//                }
//                else{
//                    [HUD_ setHidden:YES];
//                    NSLog(@"successfully hitting the server");
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Update Stock" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//                }
//            }
//
//        }
//        @catch (NSException *exception) {
//            [HUD_ setHidden:YES];
//            NSLog(@"%@",exception.description);
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Update Stock" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//        @finally {
//
//        }
//    }
//}


//submitButtonPressed method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)submitButtonPressed{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    BOOL countStatus = FALSE;
    
    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *verifiedDateValue = [verifiedDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *verifiedByValue = [verifiedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *storageValue = [storageUnit.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (itemArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (locationValue.length == 0 || verifiedDateValue.length == 0 || verifiedByValue.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please provide all the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else{
        
        [HUD show:YES];
        [HUD setHidden:NO];
        HUD.labelText = @"Verifying Stock..";
        
        float productBookStock = 0;
        float productPhysicalStock = 0;
        NSMutableArray *stockList = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < itemArray.count; i++) {
            NSArray *temp = [itemArray[i] componentsSeparatedByString:@"#"];
            productBookStock = productBookStock + [temp[1] floatValue];
            productPhysicalStock = productPhysicalStock + [temp[2] floatValue];
        }
        @try {
            
            for (int c = 0; c < itemArray.count; c++) {
                
                
                //            @Column(name = "sku_replenishment_date")
                //            private Date sku_replenishment_date;
                
                NSDictionary *productInfo = productInfoArr[c];
                
                NSArray *temp_ = [[itemArray[c] componentsSeparatedByString:@"#"] copy];
                //  if ([[temp_ objectAtIndex:3] intValue] > 0) {
                NSArray *headerKeys = @[@"product_id", @"sku_id",@"product_book_stock",@"product_physical_stock",@"sku_book_stock",@"sku_physical_stock",@"stock_loss",@"loss_type",@"remarks",@"pluCode",@"sku_allocated",@"sku_reordered_qty",@"sku_reOrderDate",@"skuSalePrice",@"costPriceValue",@"mrpValue",@"salePriceValue",@"costPriceVariance",@"mrpVariance",@"salePriceVariance",@"skuCostPrice",@"skuMrp",@"skuDescription",@"sku_expected_date",@"productCategory",@"subCategory",@"brand",@"model"];
                
                NSArray *headerObjects = @[[NSString stringWithFormat:@"%@",temp_[0]],[NSString stringWithFormat:@"%@",temp_[0]],[NSString stringWithFormat:@"%@",temp_[4]],[NSString stringWithFormat:@"%@",temp_[6]],[NSString stringWithFormat:@"%@",temp_[4]],[NSString stringWithFormat:@"%@",temp_[6]],[NSString stringWithFormat:@"%@",temp_[7]],[NSString stringWithFormat:@"%@",temp_[8]],@"", [NSString stringWithFormat:@"%@",temp_[9]],@100.0f,@100.0f,verifiedDate.text,@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),@([temp_[3] floatValue]),temp_[2],verifiedDate.text,[productInfo valueForKey:kProductCategory],[productInfo valueForKey:kProductSubCategory],[productInfo valueForKey:kProductBrand],[productInfo valueForKey:kProductModel]];
                
                
                NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
                
                [stockList addObject:dictionary_];
                
                countStatus = TRUE;
                //            }
            }
           
            
            NSArray *keys = @[@"verified_on", @"verified_by",@"location",@"storageUnit",@"itemsList",@"requestHeader",@"masterVerificationCode"];
            NSArray *objects;
            if (storageValue.length == 0) {
                objects = @[verifiedDate.text,verifiedBy.text,location.text,@"--",stockList,[RequestHeader getRequestHeader],verificationCodeLblVal.text];
            }
            else {
                objects = @[verifiedDate.text,verifiedBy.text,location.text,storageUnit.text,stockList,[RequestHeader getRequestHeader],verificationCodeLblVal.text];
            }
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.storeStockVerificationDelegate = self;
            [services createStockVerificationRestFullService:createReceiptJsonString];
            
        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
            NSLog(@"%@",exception.description);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Update Stock" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
      
    }
}


// added by Roja on 17/10/2019…. // Old code only added below...
- (void)createStockVerificationSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        verifyJSON = [successDictionary copy];
        
//        NSDictionary *json = verifyJSON[@"responseHeader"];
        //        if ([json[@"responseCode"] intValue] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Stock Verified Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        storageLocation.text = nil;
        storageUnit.text = nil;
        
        [itemArray removeAllObjects];
        [itemSubArray removeAllObjects];
        [itemTable reloadData];
        
        
        //        }
        //        else{
        //            [HUD setHidden:YES];
        //            NSLog(@"successfully hitting the server");
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Update Stock" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //            [alert show];
        //        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // Old code only added below...
- (void)createStockVerificationErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        NSLog(@"createStockVerificationErrorResponse in stockVerification :%@", errorResponse);

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}




-(void)cancelButtonPressed{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (itemArray.count>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(IBAction) shipoModeButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    okButton.enabled = NO;
    cancelButton.enabled = NO;
    cancelButton.enabled = NO;
    //timeButton.enabled = NO;
    
    
    
    lossTypeTable.hidden = NO;
    [rejectQtyChangeDisplayView bringSubviewToFront:lossTypeTable];
    [lossTypeTable reloadData];
    
}

// Handle serchOrderItemTableCancel Pressed....
-(IBAction) serchOrderItemTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    okButton.enabled = YES;
    cancelButton.enabled = YES;
    lossTypeTable.hidden = YES;
}

-(void)backAction {
    if (itemArray.count>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    if (alertView == warning) {
        
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView == qtyWarning) {
        
        if (buttonIndex == 0) {
            
            NSString *value = [rejecQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSString *lossTypeValue = [lossTypeField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSString *remarksValue = [remarkTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            // PhoNumber validation...
            NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
            NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
            NSArray *temp = [itemArray[cellPosition] componentsSeparatedByString:@"#"];
            float qty = value.floatValue;
            
            
            NSString *str = @"";
            if (remarksValue.length == 0) {
                str  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",temp[0],@"#",temp[1],@"#",temp[2],@"#",temp[3],@"#",temp[4],@"#",temp[5],@"#",[NSString stringWithFormat:@"%.2f",qty],@"#",[NSString stringWithFormat:@"%.2f",[temp[4] floatValue] - qty],@"#",lossTypeField.text,@"#",temp[9],@"#",@"--"];
            }
            else{
                str  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",temp[0],@"#",temp[1],@"#",temp[2],@"#",temp[3],@"#",temp[4],@"#",temp[5],@"#",[NSString stringWithFormat:@"%.2f",qty],@"#",[NSString stringWithFormat:@"%.2f",[temp[4] floatValue] - qty],@"#",lossTypeField.text,@"#",temp[9],@"#",remarkTextView.text];
            }
            
            if ([lossTypeField.text isEqualToString:@"None"]) {
                str  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",temp[0],@"#",temp[1],@"#",temp[2],@"#",temp[3],@"#",temp[4],@"#",temp[5],@"#",[NSString stringWithFormat:@"%.2f",qty],@"#",[NSString stringWithFormat:@"%.2f",[temp[4] floatValue] - qty],@"#",@"--",@"#",temp[9],@"#",remarkTextView.text];
            }
            itemArray[cellPosition] = str;
            
            transparentView.hidden = YES;
            
            [rejecQtyField resignFirstResponder];
            
            itemTable.userInteractionEnabled = YES;
            
            [itemTable reloadData];
        }
        else {
            
            [alertView dismissWithClickedButtonIndex:0 animated:NO];
        }
    }
    
    //added  by Srinivasulu on 20/04/2017....
    else if(alertView == offlineModeAlert){
        
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        
        [self changeOperationMode:buttonIndex];
        //[super alertView:alertView didDismissWithButtonIndex:buttonIndex_];
    }
    
    else if (alertView == uploadConfirmationAlert)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
        
        
        [self syncOfflinebillsToOnline:buttonIndex];
        
        
    }
    //upto here on 28/04/2017...

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
}


-(void)doneWithNumberPad {
    [rejecQtyField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}

-(void)populateView :(UITableView*)tableView {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250,200)];
    
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    //    tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    tableView.dataSource = self;
    tableView.delegate = self;
    (tableView.layer).borderWidth = 1.0f;
    tableView.layer.cornerRadius = 3;
    tableView.layer.borderColor = [UIColor grayColor].CGColor;
    tableView.hidden = false;
    
    if(tableView == storageTable) {
        
        customView.frame = CGRectMake(customView.frame.origin.x, customView.frame.origin.y, storageUnit.frame.size.width, customView.frame.size.height);
    }
    else {
        customView.frame = CGRectMake(customView.frame.origin.x, customView.frame.origin.y, storageLocation.frame.size.width, customView.frame.size.height);
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        tableView.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
        
    }
    
    
    
    [customView addSubview:tableView];
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        if(tableView == storageTable) {
            
            [popover presentPopoverFromRect:storageUnit.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
        }
        else {
            [popover presentPopoverFromRect:storageLocation.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
        }
        
        
        catPopOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
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
    
    [tableView reloadData];
    
    
}

-(void)populateLossTypes {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, lossTypeField.frame.size.width,200)];
    
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    //    tableView = [[UITableView alloc] init];
    lossTypeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    lossTypeTable.dataSource = self;
    lossTypeTable.delegate = self;
    (lossTypeTable.layer).borderWidth = 1.0f;
    lossTypeTable.layer.cornerRadius = 3;
    lossTypeTable.layer.borderColor = [UIColor grayColor].CGColor;
    lossTypeTable.hidden = false;
    
    
    customView.frame = CGRectMake(customView.frame.origin.x, customView.frame.origin.y, lossTypeField.frame.size.width, customView.frame.size.height);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        lossTypeTable.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
        
    }
    
    
    
    [customView addSubview:lossTypeTable];
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:lossTypeField.frame inView:rejectQtyChangeDisplayView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
        catPopOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
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
    
    [lossTypeTable reloadData];
    
    
}

-(void)closeQuantityView:(UIButton*)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    transparentView.hidden = YES;
    itemTable.userInteractionEnabled = YES;
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
