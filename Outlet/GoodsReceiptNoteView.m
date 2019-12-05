//
//  GoodsReceiptNoteView.m
//  OmniRetailer
//
//  Created by TLMac on 10/10/16.
//
//

#import "GoodsReceiptNoteView.h"

#import "OmniHomePage.h"
#import "CreateAndViewGoodsReceiptNote.h"
#import "CreateNewWareHouseGoodsReceiptNote.h"

@interface GoodsReceiptNoteView ()

@end

@implementation GoodsReceiptNoteView

@synthesize soundFileURLRef,soundFileObject;
@synthesize isOpen,selectIndex,selectSectionIndex;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         08/10/2016
 * @method       ViewDidLoad
 * @author       Srinivasulu
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
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
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
    [HUD show:NO];
    [HUD setHidden:YES];
    
    //creating the stockRequestView which will displayed completed Screen.......
    goodsReceiptNoteView = [[UIView alloc] init];
    goodsReceiptNoteView.backgroundColor = [UIColor clearColor];
    goodsReceiptNoteView.layer.borderWidth = 1.0f;
    goodsReceiptNoteView.layer.cornerRadius = 10.0f;
    goodsReceiptNoteView.layer.borderColor = [UIColor grayColor].CGColor;

    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    
    //changing the headerNameLbl backGrouondColor & textColor.......
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.opacity = 5.0f;
    [headerNameLbl.layer addSublayer:bottomBorder];
    
    /*Creation of UIButton for providing user to select the dates.......*/
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *summaryImage = [UIImage imageNamed:@"emails-letters.png"];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self action:@selector(callingGetStockRequestSummary) forControlEvents:UIControlEventTouchDown];
    
    //creation of customTextField.......
    vendorIdTxt = [[CustomTextField alloc] init];
    vendorIdTxt.placeholder = NSLocalizedString(@"vendor_name", nil);
    vendorIdTxt.delegate = self;
    [vendorIdTxt awakeFromNib];
    vendorIdTxt.userInteractionEnabled = NO;
    [vendorIdTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    itemWiseTxt = [[CustomTextField alloc] init];
    itemWiseTxt.placeholder = NSLocalizedString(@"item_wise", nil);
    itemWiseTxt.delegate = self;
    [itemWiseTxt awakeFromNib];
    itemWiseTxt.userInteractionEnabled = NO;
    [itemWiseTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDateTxt.delegate = self;
    [startDateTxt awakeFromNib];
    startDateTxt.userInteractionEnabled = NO;
    
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDateTxt.delegate = self;
    [endDateTxt awakeFromNib];
    endDateTxt.userInteractionEnabled = NO;
    
    searchItemsTxt = [[CustomTextField alloc] init];
    searchItemsTxt.placeholder = NSLocalizedString(@"search_here", nil);
    searchItemsTxt.delegate = self;
    [searchItemsTxt awakeFromNib];
    
    searchItemsTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemsTxt.textColor = [UIColor blackColor];
    searchItemsTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemsTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [searchItemsTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //creating the UIButton which are used to show CustomerInfo popUp.......
    UIButton *vendorIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage_ = [UIImage imageNamed:@"arrow.png"];
    [vendorIdBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [vendorIdBtn addTarget:self  action:@selector(showAllVendorId:) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton * itemWiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemWiseBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [itemWiseBtn addTarget:self action:@selector(showAllItemWiseData:) forControlEvents:UIControlEventTouchDown];
    
    UIImage * buttonImage = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton *showStartDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showStartDateBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [showStartDateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    showStartDateBtn.tag = 2;
    
    UIButton *showEndDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showEndDateBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [showEndDateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    showEndDateBtn.tag = 4;
    
    //Allocation of UIview for the HeaderLaberls....
    
    headerScrollView = [[UIScrollView alloc]init];
    //headerScrollView.backgroundColor = [UIColor lightGrayColor];

    
    /*Creation of Label's used as tableHeader's*/
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    grnRefNumberLbl  = [[CustomLabel alloc] init];
    [grnRefNumberLbl awakeFromNib];
    
    poRefNumberLbl = [[CustomLabel alloc] init];
    [poRefNumberLbl awakeFromNib];
    
    requestDateLbl = [[CustomLabel alloc] init];
    [requestDateLbl awakeFromNib];
    
    deliveredByLbl = [[CustomLabel alloc] init];
    [deliveredByLbl awakeFromNib];
    
    statusLbl = [[CustomLabel alloc] init];
    [statusLbl awakeFromNib];
    
    vendorIdLbl = [[CustomLabel alloc] init];
    [vendorIdLbl awakeFromNib];
    
    poQuantityLbl = [[CustomLabel alloc] init];
    [poQuantityLbl awakeFromNib];
    
    deliveredQuantityLbl = [[CustomLabel alloc] init];
    [deliveredQuantityLbl awakeFromNib];
    
    totalGRNLbl = [[CustomLabel alloc] init];
    [totalGRNLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];

    /**creating UIButton*/
    UIButton *saveAllBtn;
    UIButton *cancelBtn;
    
    saveAllBtn = [[UIButton alloc] init];
    [saveAllBtn addTarget:self
                   action:@selector(saveAll:) forControlEvents:UIControlEventTouchDown];
    saveAllBtn.layer.cornerRadius = 3.0f;
    saveAllBtn.backgroundColor = [UIColor grayColor];
    [saveAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    createGRNBtn = [[UIButton alloc] init];
    [createGRNBtn addTarget:self
                     action:@selector(createGRNS:) forControlEvents:UIControlEventTouchDown];
    createGRNBtn.layer.cornerRadius = 3.0f;
    createGRNBtn.backgroundColor = [UIColor grayColor];
    [createGRNBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //createGRNBtn.enabled = false;
    
    cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(cancelGoodsReceiptNoteView:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.backgroundColor = [UIColor grayColor];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [saveAllBtn setTitle:NSLocalizedString(@"save_all", nil) forState:UIControlStateNormal];
    [createGRNBtn setTitle:NSLocalizedString(@"create_grn", nil) forState:UIControlStateNormal];
    [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    
    pagenationTxt = [[CustomTextField alloc] init];
    pagenationTxt.userInteractionEnabled = NO;
    pagenationTxt.textAlignment = NSTextAlignmentCenter;
    pagenationTxt.delegate = self;
    [pagenationTxt awakeFromNib];
    
    UIButton *  dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [dropDownBtn addTarget:self action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    
    //creating the UIButton which are used to show CustomerInfo popUp.......
    
    UIButton * goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];

    //stockReceiptTbl creation.......
    stockReceiptTbl = [[UITableView alloc] init];
    stockReceiptTbl.backgroundColor  = [UIColor clearColor];
    stockReceiptTbl.layer.cornerRadius = 4.0;
    stockReceiptTbl.bounces = TRUE;
    stockReceiptTbl.dataSource = self;
    stockReceiptTbl.delegate = self;
    stockReceiptTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    stockReceiptTbl.tag = 0;
    
    
    //table's used in popUp's.......
    //vendorIdsTbl creation...
    vendorIdsTbl = [[UITableView alloc] init];
    
    //employeesListTbl creation.......
    employeesListTbl = [[UITableView alloc] init];

    //Allocation of Pagination Table....
    
    pagenationTbl = [[UITableView alloc]init];
    
    //requestedItemsTbl creation.......
    requestedItemsTbl = [[UITableView alloc] init];
    requestedItemsTbl.dataSource = self;
    requestedItemsTbl.delegate = self;
    requestedItemsTbl.backgroundColor = [UIColor clearColor];
    requestedItemsTbl.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //searchOrderItemTbl creation...
    itemWiseListTbl = [[UITableView alloc] init];
    
    /*RequestedItemsTbl Header*/
    requestedItemsTblHeaderView = [[UIView alloc] init];
    
    itemNoLbl = [[CustomLabel alloc] init];
    [itemNoLbl awakeFromNib];
    
    itemNameLbl = [[CustomLabel alloc] init];
    [itemNameLbl awakeFromNib];
    
    itemGradeLbl = [[CustomLabel alloc] init];
    [itemGradeLbl awakeFromNib];
    
    itemRequestedQtyLbl = [[CustomLabel alloc] init];
    [itemRequestedQtyLbl awakeFromNib];
    
    itemRequestedPriceLbl = [[CustomLabel alloc] init];
    [itemRequestedPriceLbl awakeFromNib];
    
    itemApprrovedQtyLbl = [[CustomLabel alloc] init];
    [itemApprrovedQtyLbl awakeFromNib];
    
    itemApprrovedPriceLbl = [[CustomLabel alloc] init];
    [itemApprrovedPriceLbl awakeFromNib];
    
    itemsNetCostLbl = [[CustomLabel alloc] init];
    [itemsNetCostLbl awakeFromNib];
    
    itemHandledByLbl = [[CustomLabel alloc] init];
    [itemHandledByLbl awakeFromNib];
    
    [requestedItemsTblHeaderView addSubview:itemNoLbl];
    [requestedItemsTblHeaderView addSubview:itemNameLbl];
    [requestedItemsTblHeaderView addSubview:itemGradeLbl];
    [requestedItemsTblHeaderView addSubview:itemRequestedQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemRequestedPriceLbl];
    [requestedItemsTblHeaderView addSubview:itemApprrovedQtyLbl];
    [requestedItemsTblHeaderView addSubview:itemApprrovedPriceLbl];
    [requestedItemsTblHeaderView addSubview:itemsNetCostLbl];
    [requestedItemsTblHeaderView addSubview:itemHandledByLbl];
    
    
    //Allocation of UIView....
    totalInventoryView = [[UIView alloc]init];
    totalInventoryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalInventoryView.layer.borderWidth =3.0f;

    UILabel * totalQuntityLabel;
    UILabel * totalGrnLabel;
    

    
    totalQuntityLabel = [[UILabel alloc] init];
    totalQuntityLabel.layer.masksToBounds = YES;
    totalQuntityLabel.numberOfLines = 1;
    totalQuntityLabel.textColor = [UIColor whiteColor];

    totalGrnLabel = [[UILabel alloc] init];
    totalGrnLabel.layer.masksToBounds = YES;
    totalGrnLabel.numberOfLines = 1;
    totalGrnLabel.textColor = [UIColor whiteColor];
    
    totalQuantityValueLabel = [[UILabel alloc] init];
    totalQuantityValueLabel.layer.masksToBounds = YES;
    totalQuantityValueLabel.numberOfLines = 1;
    totalQuantityValueLabel.textColor = [UIColor whiteColor];
    
    totalGrnValueLabel = [[UILabel alloc] init];
    totalGrnValueLabel.layer.masksToBounds = YES;
    totalGrnValueLabel.numberOfLines = 1;
    totalGrnValueLabel.textColor = [UIColor whiteColor];
    
    totalQuntityLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalGrnLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalQuantityValueLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalGrnValueLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalQuntityLabel.textAlignment = NSTextAlignmentLeft;
    totalGrnLabel.textAlignment = NSTextAlignmentLeft;
    
    totalQuantityValueLabel.textAlignment = NSTextAlignmentRight;
    totalGrnValueLabel.textAlignment = NSTextAlignmentRight;

    totalGrnLabel.text =  NSLocalizedString(@"total_grn_value", nil);
    totalQuntityLabel.text  = NSLocalizedString(@"total_qty",nil);
    
    totalQuantityValueLabel.text = NSLocalizedString(@"0.00", nil);
    totalGrnValueLabel.text = NSLocalizedString(@"0.00", nil);


    //setting the textField data.......
    @try {
        
        //setting the titleName for the Page....
        
       // self.titleLabel.text = NSLocalizedString(@"omniretailer", nil);
        headerNameLbl.text = NSLocalizedString(@"goods_receipt_note_summary", nil);
        
        snoLbl.text = NSLocalizedString(@"s_no", nil);
        grnRefNumberLbl.text = NSLocalizedString(@"grn_ref_no",nil);
        poRefNumberLbl.text = NSLocalizedString(@"po_ref", nil);
        requestDateLbl.text = NSLocalizedString(@"date", nil);;
        deliveredByLbl.text = NSLocalizedString(@"divrd_by", nil);
        
        statusLbl.text  = NSLocalizedString(@"status", nil);
        
        vendorIdLbl.text = NSLocalizedString(@"vendor_name", nil);
        poQuantityLbl.text = NSLocalizedString(@"po_qty", nil);
        
        deliveredQuantityLbl.text = NSLocalizedString(@"divrd_qty",nil);
        
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        // To Display Grid Level Item labels ....
        
        itemNoLbl.text = NSLocalizedString(@"s_no", nil);
        itemNameLbl.text = NSLocalizedString(@"item_name", nil);
        itemGradeLbl.text = NSLocalizedString(@"grade", nil);
        itemRequestedQtyLbl.text = NSLocalizedString(@"order_qty", nil);
        itemRequestedPriceLbl.text = NSLocalizedString(@"order_price", nil);
        itemApprrovedQtyLbl.text = NSLocalizedString(@"supply_qty", nil);
        itemApprrovedPriceLbl.text = NSLocalizedString(@"supply_price", nil);
        itemsNetCostLbl.text = NSLocalizedString(@"net_cost", nil);
        itemHandledByLbl.text = NSLocalizedString(@"handled_by", nil);
        
        totalGRNLbl.text = NSLocalizedString(@"grn_value", nil);
        
        searchItemsTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:searchItemsTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
        
        
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];

        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception will populating the data to textField ----%@",exception);
    }
    
    
    //setting of frame and font started in below based on the deviceOrientation.......
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
       
        self.view.frame = CGRectMake(0, 0, [ UIScreen mainScreen ].bounds .size.width, [ UIScreen mainScreen ].bounds .size.height);
        
        goodsReceiptNoteView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        headerNameLbl.frame = CGRectMake( 0, 0, goodsReceiptNoteView.frame.size.width, 45);
        
        summaryInfoBtn.frame = CGRectMake( goodsReceiptNoteView.frame.size.width - 45,headerNameLbl.frame.origin.y,50,50);
        
        vendorIdTxt.frame = CGRectMake(10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 20, 160, 40);
        
        vendorIdBtn.frame = CGRectMake( (vendorIdTxt.frame.origin.x + vendorIdTxt.frame.size.width - 45), vendorIdTxt.frame.origin.y - 8,  55, 60);
        
        itemWiseTxt.frame = CGRectMake(  vendorIdTxt.frame.origin.x + vendorIdTxt.frame.size.width + 20, vendorIdTxt.frame.origin.y, 160, 40);
        
        itemWiseBtn.frame = CGRectMake( (itemWiseTxt.frame.origin.x + itemWiseTxt.frame.size.width - 45), itemWiseTxt.frame.origin.y - 8,  55, 60);
        
        startDateTxt.frame = CGRectMake (itemWiseTxt.frame.origin.x + itemWiseTxt.frame.size.width+320, itemWiseTxt.frame.origin.y, 160,40);
        
        showStartDateBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-45), startDateTxt.frame.origin.y+2, 40, 35);

        endDateTxt.frame = CGRectMake( startDateTxt.frame.origin.x + startDateTxt.frame.size.width + 20, itemWiseTxt.frame.origin.y, 160, 40);
        
        showEndDateBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-45), endDateTxt.frame.origin.y+2, 40, 35);
        
        searchItemsTxt.frame = CGRectMake( vendorIdTxt.frame.origin.x, vendorIdTxt.frame.origin.y + vendorIdTxt.frame.size.height + 20, goodsReceiptNoteView.frame.size.width - 20, 40);
        
        saveAllBtn.frame = CGRectMake(searchItemsTxt.frame.origin.x,goodsReceiptNoteView.frame.size.height-45, 140, 40);
        
        cancelBtn.frame = CGRectMake( saveAllBtn.frame.origin.x + saveAllBtn.frame.size.width + 50, saveAllBtn.frame.origin.y, 140, 40);
        
        pagenationTxt.frame = CGRectMake(cancelBtn.frame.origin.x+cancelBtn.frame.size.width+20,cancelBtn.frame.origin.y,90,40);
        
        dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width-45), pagenationTxt.frame.origin.y-5, 45, 50);
        
        goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width+15,pagenationTxt.frame.origin.y,80, 40);

        headerScrollView.frame = CGRectMake(searchItemsTxt.frame.origin.x,searchItemsTxt.frame.origin.y+searchItemsTxt.frame.size.height+5,searchItemsTxt.frame.size.width+120, saveAllBtn.frame.origin.y - (searchItemsTxt.frame.origin.y+searchItemsTxt.frame.size.height + 10));
        
        snoLbl.frame = CGRectMake( 0, 0, 40, 35);

        grnRefNumberLbl.frame = CGRectMake( snoLbl.frame.origin.x + snoLbl.frame.size.width + 2, snoLbl.frame.origin.y, 110,  snoLbl.frame.size.height);

        poRefNumberLbl.frame = CGRectMake( grnRefNumberLbl.frame.origin.x + grnRefNumberLbl.frame.size.width + 2, snoLbl.frame.origin.y, 110,  snoLbl.frame.size.height);

        requestDateLbl.frame = CGRectMake( poRefNumberLbl.frame.origin.x + poRefNumberLbl.frame.size.width + 2, snoLbl.frame.origin.y, 110,snoLbl.frame.size.height);

        deliveredByLbl.frame = CGRectMake( requestDateLbl.frame.origin.x + requestDateLbl.frame.size.width + 2, snoLbl.frame.origin.y, 80, snoLbl.frame.size.height);

        statusLbl.frame =  CGRectMake( deliveredByLbl.frame.origin.x + deliveredByLbl.frame.size.width + 2, snoLbl.frame.origin.y, 90, snoLbl.frame.size.height);

        vendorIdLbl.frame = CGRectMake( statusLbl.frame.origin.x + statusLbl.frame.size.width + 2, snoLbl.frame.origin.y, 110, snoLbl.frame.size.height);

        poQuantityLbl.frame =CGRectMake(vendorIdLbl.frame.origin.x + vendorIdLbl.frame.size.width + 2, snoLbl.frame.origin.y, 70, snoLbl.frame.size.height);

        deliveredQuantityLbl.frame = CGRectMake( poQuantityLbl.frame.origin.x + poQuantityLbl.frame.size.width + 2, snoLbl.frame.origin.y, 80, snoLbl.frame.size.height);

        totalGRNLbl.frame = CGRectMake( deliveredQuantityLbl.frame.origin.x + deliveredQuantityLbl.frame.size.width + 2, snoLbl.frame.origin.y, 90, snoLbl.frame.size.height);

        actionLbl.frame = CGRectMake( totalGRNLbl.frame.origin.x + totalGRNLbl.frame.size.width + 2, snoLbl.frame.origin.y, 90, snoLbl.frame.size.height);
       
        stockReceiptTbl.frame = CGRectMake(0,snoLbl.frame.origin.y + snoLbl.frame.size.height,headerScrollView.frame.size.width,headerScrollView.frame.size.height-(snoLbl.frame.origin.y+snoLbl.frame.size.height));

        // Frame  for the Header Labels under the Grid.....

        requestedItemsTblHeaderView.frame = CGRectMake(grnRefNumberLbl.frame.origin.x,10,searchItemsTxt.frame.size.width,snoLbl.frame.size.height);
        
        itemNoLbl.frame = CGRectMake( 0, 0, 50, 30);

        itemNameLbl.frame = CGRectMake(itemNoLbl.frame.origin.x + itemNoLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);

        itemGradeLbl.frame =CGRectMake( itemNameLbl.frame.origin.x + itemNameLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);

        itemRequestedQtyLbl.frame = CGRectMake( itemGradeLbl.frame.origin.x + itemGradeLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);
       
        itemRequestedPriceLbl.frame = CGRectMake( itemRequestedQtyLbl.frame.origin.x + itemRequestedQtyLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);
        
        itemApprrovedQtyLbl.frame =  CGRectMake( itemRequestedPriceLbl.frame.origin.x + itemRequestedPriceLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);
        
        itemApprrovedPriceLbl.frame = CGRectMake( itemApprrovedQtyLbl.frame.origin.x + itemApprrovedQtyLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);
        
        itemsNetCostLbl.frame = CGRectMake( itemApprrovedPriceLbl.frame.origin.x + itemApprrovedPriceLbl.frame.size.width + 2, 0, 100, itemNoLbl.frame.size.height);
        
        itemHandledByLbl.frame = CGRectMake( itemsNetCostLbl.frame.origin.x + itemsNetCostLbl.frame.size.width + 2, 0, 120, itemNoLbl.frame.size.height);
        
        
        //Frame for the UIView...
        totalInventoryView.frame = CGRectMake(searchItemsTxt.frame.origin.x + searchItemsTxt.frame.size.width-265,saveAllBtn.frame.origin.y -18,270,60);
        
        totalQuntityLabel.frame =  CGRectMake(5,0,170,40);
        
        totalGrnLabel.frame =  CGRectMake(totalQuntityLabel.frame.origin.x,totalQuntityLabel.frame.origin.y+totalQuntityLabel.frame.size.height-15,170,40);

        totalQuantityValueLabel.frame =  CGRectMake(totalQuntityLabel.frame.origin.x+totalQuntityLabel.frame.size.width,totalQuntityLabel.frame.origin.y,90,40);
        
        totalGrnValueLabel.frame =  CGRectMake(totalQuantityValueLabel.frame.origin.x, totalGrnLabel.frame.origin.y,90,40);

        
    }
    else {
        
        //DO CODING FOR IPHONE......
    }
    
    
    [goodsReceiptNoteView addSubview:headerNameLbl];
    
    [goodsReceiptNoteView addSubview:summaryInfoBtn];
    
    [goodsReceiptNoteView addSubview:vendorIdTxt];
    [goodsReceiptNoteView addSubview:vendorIdBtn];
    [goodsReceiptNoteView addSubview:itemWiseTxt];
    [goodsReceiptNoteView addSubview:itemWiseBtn];
    
    
    [goodsReceiptNoteView addSubview:pagenationTxt];
    [goodsReceiptNoteView addSubview:dropDownBtn];
    [goodsReceiptNoteView addSubview:goButton];
    
    [goodsReceiptNoteView addSubview:saveAllBtn];
    [goodsReceiptNoteView addSubview:cancelBtn];

    
    [goodsReceiptNoteView addSubview:startDateTxt];
    [goodsReceiptNoteView addSubview:showStartDateBtn];
    [goodsReceiptNoteView addSubview:endDateTxt];
    [goodsReceiptNoteView addSubview:showEndDateBtn];
    [goodsReceiptNoteView addSubview:searchItemsTxt];
    
    
    [headerScrollView addSubview:snoLbl];
    [headerScrollView addSubview:grnRefNumberLbl];
    [headerScrollView addSubview:poRefNumberLbl];
    [headerScrollView addSubview:requestDateLbl];
    [headerScrollView addSubview:deliveredByLbl];
    
    [headerScrollView addSubview:statusLbl];
    
    [headerScrollView addSubview:vendorIdLbl];
    [headerScrollView addSubview:poQuantityLbl];
    [headerScrollView addSubview:deliveredQuantityLbl];
    [headerScrollView addSubview:totalGRNLbl];
    [headerScrollView addSubview:actionLbl];
    [headerScrollView addSubview:stockReceiptTbl];

    [goodsReceiptNoteView addSubview:headerScrollView];
    [goodsReceiptNoteView addSubview:totalInventoryView];
    
    [totalInventoryView addSubview:totalQuntityLabel];
    [totalInventoryView addSubview:totalGrnLabel];
    
    [totalInventoryView addSubview:totalQuantityValueLabel];
    [totalInventoryView addSubview:totalGrnValueLabel];

    
    [self.view addSubview:goodsReceiptNoteView];
    
    //here we are setting font to all subview to mainView.....
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0.0];
        
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:requestedItemsTblHeaderView andSubViews:YES fontSize:16.0f cornerRadius:0.0];
        
        saveAllBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        cancelBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

    } @catch (NSException *exception) {
        NSLog(@"---- exception while setting the fontSize to subViews ----%@",exception);
    }
}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidLoad.......
 * @date         21/09/2016
 * @method       viewDidAppear
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated{
    
    @try {
        
        [HUD setHidden:NO];
        
        if( stockReceiptInfoArr == nil) {
            NSDate *todayDate = [NSDate date];
            
            NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
            requiredDateFormat.dateFormat = @"dd/MM/yyyy";
            
            startDateTxt.text = [requiredDateFormat stringFromDate:todayDate];
        }
        
        requestStartNumber = 0;

        //changed by Srinivasulu on 12/11/2018....
//        searchItemsTxt.tag = searchItemsTxt.text;
        searchItemsTxt.tag = searchItemsTxt.tag;

        vendorIdTxt.tag = 0;
        itemWiseTxt.tag = 0;
        
        if((vendorIdTxt.text).length  == 0) {
            vendorIdTxt.text = @"";
            vendorIdsTbl.tag = 0;
        }
        
        if((itemWiseTxt.text).length == 0) {
            itemWiseTxt.text = @"";
            
            itemWiseListTbl.tag = 0;
        }
        
        searchItemsTxt.tag = (searchItemsTxt.text).length;
        
        [self callingGetAllGRNS:@""];
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in serviceCall of callingGetStockReqeusts------------%@",exception);
    } @finally {
        
    }
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidAppear.......
 * @date         21/09/2016
 * @method       viewWillAppear
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void) viewWillAppear:(BOOL)animated {
    
    //calling the superClass method.......
    [super viewWillAppear:YES];
    
}
#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         21/09/2016
 * @method       didReceiveMemoryWarning
 * @author       Srinivasulu
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


#pragma -mark action used to show childTableView....


/**
 * @description  here we are showing the list of requestedItems.......
 * @date         20/09/2016
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
    
    @try {
        
        requestedItemsTbl.tag = sender.tag;
        
        requestedItemsInfoArr = [NSMutableArray new];
        //        [self callingGetStockReceiptDetails:[[stockReceiptInfoArr objectAtIndex:sender.tag] valueForKey:RECEIPT_NOTE_ID]];
        
        for(NSDictionary *dic in [stockReceiptInfoArr[sender.tag] valueForKey:ITEMS_LIST]){
            
            [requestedItemsInfoArr addObject:dic];
        }
        
        if(requestedItemsInfoArr.count == 0)
            return;
        
        
        isInEditableState = false;
        
        //here we are formating the next
        updateDictionary = [stockReceiptInfoArr[sender.tag] mutableCopy];
        
        if([[updateDictionary valueForKey:NEXT_ACTIVITIES] count] || [[updateDictionary valueForKey:NEXT_WORK_FLOW_STATES] count]){
            isInEditableState = true;
            
        }
        //upto here.......
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
        
        
        if (path.row == 0) {
            
            UITableViewCell *cell2 = [stockReceiptTbl cellForRowAtIndexPath:path];
            
            
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
                    
                    [self didSelectCellRowFirstDo:YES nextDo:NO];
                    
                }else
                {
                    
                    selectSectionIndex = path;
                    
                    
                    cell2 = [stockReceiptTbl cellForRowAtIndexPath: self.selectIndex];
                    
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
        
    } @finally {
        
    }
    
    
}

/**
 * @description  it is an delegate method. it will be called for everCell.
 * @date         04/05/2016
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
        
        [stockReceiptTbl beginUpdates];
        
        int section = (int) self.selectIndex.section;
        int contentCount;
        
        contentCount =1;
        
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i < contentCount+1 ; i++) {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
            [rowToInsert addObject:indexPathToInsert];
        }
        
        if (firstDoInsert)
        {
            
            [stockReceiptTbl  insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [stockReceiptTbl deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        
        [stockReceiptTbl endUpdates];
        
        if (nextDoInsert) {
            self.isOpen = YES;
            self.selectIndex = selectSectionIndex;
            //            requestedItemsInfoArr = [[stockRequestsInfoArr objectAtIndex:selectIndex.section] valueForKey:@"stockRequestItems"];
            
            UITableViewCell *cell2 = [stockReceiptTbl cellForRowAtIndexPath:selectIndex];
            
            for (UIButton *button in cell2.contentView.subviews) {
                
                if(button.frame.origin.x == viewListOfItemsBtn.frame.origin.x){
                    
                    UIImage * availiableSuppliersListImage = [UIImage imageNamed:@"brown_down_arrow.png"];
                    
                    [button setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
                    
                }
                
                
                
            }
            [self didSelectCellRowFirstDo:YES nextDo:NO];
        }
        if (self.isOpen)
            [stockReceiptTbl scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }    @catch (NSException *exception) {
        
    }
    @finally {
    }
    
}

#pragma -mark action used for filters....

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

- (void)showAllVendorId:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        //        if (![catPopOver isPopoverVisible]){
        if(vendorIdArr == nil ||  vendorIdArr.count == 0){
            [HUD setHidden:NO];
          
            [self getSuppliers:@""];
            
        }
        
        if(vendorIdArr.count){
            float tableHeight = vendorIdArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = vendorIdArr.count * 33;
            
            if(vendorIdArr.count > 5)
                tableHeight = (tableHeight/vendorIdArr.count) * 5;
            
            [self showPopUpForTables:vendorIdsTbl  popUpWidth:(vendorIdTxt.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:vendorIdTxt  showViewIn:goodsReceiptNoteView  permittedArrowDirections:UIPopoverArrowDirectionUp];
            
        }
        else{
            [HUD setHidden:YES];

            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 ];
            
            //upto here work for drop down...
            
            [catPopOver dismissPopoverAnimated:YES];
        
        }
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
}


/**
 * @description  here we are showing the all availiable items.......
 * @date         12/10/2016
 * @method       showAllItems
 * @author       Srinivasulu
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
            
            [self showPopUpForTables:itemWiseListTbl  popUpWidth:(itemWiseTxt.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:itemWiseTxt  showViewIn:goodsReceiptNoteView permittedArrowDirections:UIPopoverArrowDirectionUp ];
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
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 ];
            
            return;
        }
        float tableHeight = pagenationArr.count *40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArr.count * 33;
        
        if(pagenationArr.count> 5)
            tableHeight = (tableHeight/pagenationArr.count) * 5;
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:goodsReceiptNoteView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


#pragma -mark action used to show calenderView

/**
 * @description  here we are showing the calenderView.......
 * @date         19/09/2016
 * @method       showCalenderInPopUp
 * @author       Srinivasulu
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
        
        //changed by Srinivasulu on 03/02/2017....
        
        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(populateDateToTextField:) forControlEvents:UIControlEventTouchUpInside];
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        
        //added by srinivasulu on 03/02/2017....
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        
        //setting frame
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        //upto here on 03/02/2017....
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:startDateTxt.frame inView:goodsReceiptNoteView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:goodsReceiptNoteView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
        }
        
        else {
            
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
        
    } @finally {
        
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

-(void)populateDateToTextField:(UIButton *)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        
        
        //added on 09/12/2016....
        
        // getting present date & time ..
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        //        [f release];
        today = [f dateFromString:currentdate];
        
        if( ([today compare:selectedDateString] == NSOrderedAscending) ){
            //&& sender.tag == 2
            [self displayAlertMessage:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0];
            
            return;
            
        }
        
        //upto here on 09/12/2016....
        
        NSDate *existingDateString;
        
        /*z;
         UITextField *endDateTxt;*/
        
        if(  sender.tag == 2){
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"create_date_should_be_earlier_than_closed_date", nil) horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0];
                    
                    return;
                }
            }
            
            callServices = true;
            
            
            startDateTxt.text = dateString;
            
        }
        else{
            
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivered_date_should_be_earlier_than_due_date", nil) horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0];
                    
                    return;
                    
                }
            }
            
            callServices = true;
            
            endDateTxt.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
        
        @try {
            
            if((((startDateTxt.text).length != 0) || ((endDateTxt.text).length != 0) )&& callServices){
                [HUD setHidden:NO];
                
                
                searchItemsTxt.tag = (searchItemsTxt.text).length;
                requestStartNumber = 0;
                totalNoOfStockRequests = 0;
                [self callingGetAllGRNS:@""];
            }
            
        } @catch (NSException *exception) {
            
            [HUD setHidden:YES];
            NSLog(@"----exception in the stockReceiptView in populateDateToTextField:----%@",exception);
            NSLog(@"------exception while creating the popUp in stockView------%@",exception);
            
        }
    }
    
}

/**
 * @description  clear the date from textField and calling services.......
 * @date         03/02/2017
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
    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(  sender.tag == 2){
            if((startDateTxt.text).length)
                callServices = true;
            
            
            startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                callServices = true;
            
            endDateTxt.text = @"";
        }
        
        if(callServices){
            [HUD setHidden:NO];
            
            searchItemsTxt.tag = (searchItemsTxt.text).length;
            requestStartNumber = 0;
            totalNoOfStockRequests = 0;
            [self callingGetAllGRNS:@""];
            
        }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
    
    
}



#pragma -mark action need to be implemented.......

/**
 * @description  here we are showing the complete stockRequest information in popUp.......
 * @date         19/09/2016
 * @method       showCompleteGRNInfo
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showCompleteGRNInfo:(UIButton *)sender {
    
    @try {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400, 260)];
        customerView.opaque = NO;
        customerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customerView.layer.borderWidth = 2.0f;
        [customerView setHidden:NO];
        
        UILabel *noOfPOItemsLbl;
        UILabel *totalPoQtyLbl;
        UILabel *noOfReceivedItemsLbl;
        UILabel *totalNoOfReceivedQtyLbl;
        
        UILabel *line_1;
        UILabel *qtyVarianceLbl;
        UILabel *qtyVarianceInPrecentageLbl;
        
        UILabel *line_2;
        
        UILabel *noOfPOItemsValueLbl;
        UILabel *totalPoQtyValueLbl;
        UILabel *noOfReceivedItemsValueLbl;
        UILabel *totalNoOfReceivedQtyValueLbl;
        
        UILabel *qtyVarianceValueLbl;
        UILabel *qtyVarianceInPrecentageValueLbl;
        
        noOfPOItemsLbl = [[UILabel alloc] init];
        noOfPOItemsLbl.textColor = [UIColor blackColor];
        
        totalPoQtyLbl = [[UILabel alloc] init];
        totalPoQtyLbl.textColor = [UIColor blackColor];
        
        noOfReceivedItemsLbl = [[UILabel alloc] init];
        noOfReceivedItemsLbl.textColor = [UIColor blackColor];
        
        totalNoOfReceivedQtyLbl = [[UILabel alloc] init];
        totalNoOfReceivedQtyLbl.textColor = [UIColor blackColor];
        
        qtyVarianceLbl = [[UILabel alloc] init];
        qtyVarianceLbl.textColor = [UIColor blackColor];
        
        qtyVarianceInPrecentageLbl = [[UILabel alloc] init];
        qtyVarianceInPrecentageLbl.textColor = [UIColor blackColor];
        
        
        noOfPOItemsValueLbl = [[UILabel alloc] init];
        noOfPOItemsValueLbl.textColor = [UIColor blackColor];
        
        totalPoQtyValueLbl = [[UILabel alloc] init];
        totalPoQtyValueLbl.textColor = [UIColor blackColor];
        
        noOfReceivedItemsValueLbl = [[UILabel alloc] init];
        noOfReceivedItemsValueLbl.textColor = [UIColor blackColor];
        
        totalNoOfReceivedQtyValueLbl = [[UILabel alloc] init];
        totalNoOfReceivedQtyValueLbl.textColor = [UIColor blackColor];
        
        qtyVarianceValueLbl = [[UILabel alloc] init];
        qtyVarianceValueLbl.textColor = [UIColor blackColor];
        
        qtyVarianceInPrecentageValueLbl = [[UILabel alloc] init];
        qtyVarianceInPrecentageValueLbl.textColor = [UIColor blackColor];
        
        
        line_1 = [[UILabel alloc] init];
        line_1.backgroundColor  = [UIColor grayColor];
        
        line_2 = [[UILabel alloc] init];
        line_2.backgroundColor  = [UIColor grayColor];
        
        
        @try {
            
            [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"no_of_po_items", nil),NSLocalizedString(@"no_of_po_items", nil)];
            
            noOfPOItemsLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"1)", nil),NSLocalizedString(@"no_of_po_items", nil)];
            
            totalPoQtyLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"2)", nil),NSLocalizedString(@"total_po_quantity", nil)]; ;
        
            noOfReceivedItemsLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"3)", nil),NSLocalizedString(@"no_received_items", nil)];;
            
            totalNoOfReceivedQtyLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"4)", nil),NSLocalizedString(@"total_received_qunatity", nil)]; ;
            
            qtyVarianceLbl.text  = NSLocalizedString(@"quantity_variance", nil);
            
            qtyVarianceInPrecentageLbl.text  = NSLocalizedString(@"quantity_varience_in_%", nil) ;
            
            noOfPOItemsValueLbl.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@":", nil),NSLocalizedString(@"0", nil)];
            
            totalPoQtyValueLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@":", nil),NSLocalizedString(@"0", nil)];
            
            noOfReceivedItemsValueLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@":", nil),NSLocalizedString(@"0", nil)];;
            
            totalNoOfReceivedQtyValueLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@":", nil),NSLocalizedString(@"0", nil)]; ;
            
            qtyVarianceValueLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@":", nil),NSLocalizedString(@"0", nil)];
            
            qtyVarianceInPrecentageValueLbl.text  = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@":", nil),NSLocalizedString(@"0", nil)] ;
            
            
            
        } @catch (NSException *exception) {
            NSLog(@"------exception while creating the popUp in stockView------%@",exception);
            
        }
        
        
        [customerView addSubview:noOfPOItemsLbl];
        [customerView addSubview:totalPoQtyLbl];
        [customerView addSubview:noOfReceivedItemsLbl];
        [customerView addSubview:totalNoOfReceivedQtyLbl];
        
        [customerView addSubview:line_1];
        [customerView addSubview:qtyVarianceLbl];
        [customerView addSubview:qtyVarianceInPrecentageLbl];
        [customerView addSubview:line_2];
        
        [customerView addSubview:noOfPOItemsValueLbl];
        [customerView addSubview:totalPoQtyValueLbl];
        [customerView addSubview:noOfReceivedItemsValueLbl];
        [customerView addSubview:totalNoOfReceivedQtyValueLbl];
        
        [customerView addSubview:qtyVarianceValueLbl];
        [customerView addSubview:qtyVarianceInPrecentageValueLbl];
        
        
        //setting frame
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            float veritical_gap = 0;
            float horizantal_gap = 10;
        
            //setting frame for valueLabels.......
            noOfPOItemsValueLbl.frame =  CGRectMake( customerView.frame.size.width - 140, 5, 140, 40);
            
            totalPoQtyValueLbl.frame =  CGRectMake( noOfPOItemsValueLbl.frame.origin.x,  noOfPOItemsValueLbl.frame.origin.y + noOfPOItemsValueLbl.frame.size.height + veritical_gap, noOfPOItemsValueLbl.frame.size.width, noOfPOItemsValueLbl.frame.size.height);
            
            noOfReceivedItemsValueLbl.frame =  CGRectMake( noOfPOItemsValueLbl.frame.origin.x,  totalPoQtyValueLbl.frame.origin.y + totalPoQtyValueLbl.frame.size.height + veritical_gap, noOfPOItemsValueLbl.frame.size.width, noOfPOItemsValueLbl.frame.size.height);
            
            totalNoOfReceivedQtyValueLbl.frame =  CGRectMake( noOfPOItemsValueLbl.frame.origin.x,  noOfReceivedItemsValueLbl.frame.origin.y + noOfReceivedItemsValueLbl.frame.size.height + veritical_gap, noOfPOItemsValueLbl.frame.size.width, noOfPOItemsValueLbl.frame.size.height);
            
            
            line_1.frame =   CGRectMake( 10, totalNoOfReceivedQtyValueLbl.frame.origin.y + totalNoOfReceivedQtyValueLbl.frame.size.height + veritical_gap, customerView.frame.size.width - (2 * horizantal_gap), 2);
            
            
            qtyVarianceValueLbl.frame =  CGRectMake( noOfPOItemsValueLbl.frame.origin.x,  line_1.frame.origin.y + line_1.frame.size.height + veritical_gap, noOfPOItemsValueLbl.frame.size.width, noOfPOItemsValueLbl.frame.size.height);
            
            qtyVarianceInPrecentageValueLbl.frame =  CGRectMake( noOfPOItemsValueLbl.frame.origin.x,  qtyVarianceValueLbl.frame.origin.y + qtyVarianceValueLbl.frame.size.height + veritical_gap, noOfPOItemsValueLbl.frame.size.width, noOfPOItemsValueLbl.frame.size.height);
            
            
            line_2.frame =   CGRectMake( line_1.frame.origin.x, qtyVarianceInPrecentageValueLbl.frame.origin.y + qtyVarianceInPrecentageValueLbl.frame.size.height + veritical_gap, line_1.frame.size.width, line_1.frame.size.height);
            
            
            
            noOfPOItemsLbl.frame =  CGRectMake(  line_1.frame.origin.x,  noOfPOItemsValueLbl.frame.origin.y, noOfPOItemsValueLbl.frame.origin.x - line_1.frame.origin.x, noOfPOItemsValueLbl.frame.size.height);
            
            
            totalPoQtyLbl.frame =  CGRectMake(  noOfPOItemsLbl.frame.origin.x,  totalPoQtyValueLbl.frame.origin.y, noOfPOItemsLbl.frame.size.width, noOfPOItemsLbl.frame.size.height);
            
            
            noOfReceivedItemsLbl.frame =  CGRectMake(  noOfPOItemsLbl.frame.origin.x,  noOfReceivedItemsValueLbl.frame.origin.y, noOfPOItemsLbl.frame.size.width, noOfPOItemsLbl.frame.size.height);
            
            totalNoOfReceivedQtyLbl.frame =  CGRectMake(  noOfPOItemsLbl.frame.origin.x,  totalNoOfReceivedQtyValueLbl.frame.origin.y, noOfPOItemsLbl.frame.size.width, noOfPOItemsLbl.frame.size.height);
            
            
            qtyVarianceLbl.frame =  CGRectMake(  noOfPOItemsLbl.frame.origin.x,  qtyVarianceValueLbl.frame.origin.y, noOfPOItemsLbl.frame.size.width, noOfPOItemsLbl.frame.size.height);
            
            qtyVarianceInPrecentageLbl.frame =  CGRectMake(  noOfPOItemsLbl.frame.origin.x,  qtyVarianceInPrecentageValueLbl.frame.origin.y, noOfPOItemsLbl.frame.size.width, noOfPOItemsLbl.frame.size.height);
            
            @try {
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:customerView andSubViews:YES fontSize:20.0 cornerRadius:0.0];
            } @catch (NSException *exception) {
                
            }
        }else{
            
        }
        
        @try {
            
            if(goodsReceiptNoteSummaryInfoArr.count){
                int poItems = 0;
                float poItemsQty = 0;
                int receivedItems = 0;
                float receivedItemsQty = 0;
                
                for(NSDictionary *dic in goodsReceiptNoteSummaryInfoArr){
                    
                    if(![[dic valueForKey:TOTAL_ORDERED_ITEMS] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:TOTAL_ORDERED_ITEMS])
                        poItems +=  [[dic valueForKey:TOTAL_ORDERED_ITEMS] integerValue];
                    
                    if(![[dic valueForKey:TOTAL_ORDERED_ITEMS_QTY] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:TOTAL_ORDERED_ITEMS_QTY])
                        poItemsQty += [[dic valueForKey:TOTAL_ORDERED_ITEMS_QTY] integerValue];
                    
                    if(![[dic valueForKey:TOTAL_SUPPLIED_QTY] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:TOTAL_SUPPLIED_QTY])
                        receivedItemsQty += [[dic valueForKey:TOTAL_SUPPLIED_QTY] integerValue];
                    
                    //key need to know.......
                    if(![[dic valueForKey:@"totalItemsSupplied"] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:@"totalItemsSupplied"])
                        receivedItems += [[dic valueForKey:@"totalItemsSupplied"] integerValue];
                }
                
                noOfPOItemsValueLbl.text = [NSString stringWithFormat:@"%@%i",@": ",poItems];
                totalPoQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@": ", poItemsQty];
                
                noOfReceivedItemsValueLbl.text = [NSString stringWithFormat:@"%@%i",@": ", receivedItems];
                totalNoOfReceivedQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@": ", receivedItemsQty];
                
                
                if( (poItemsQty != 0) && (  poItemsQty != receivedItemsQty)){
                    
                    
                    
                    qtyVarianceValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@": ", poItemsQty - receivedItemsQty ];
                    
                    qtyVarianceInPrecentageValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@": ", 100 * ((float) ((poItemsQty - receivedItemsQty)/ poItemsQty))];
                    
                }else{
                    qtyVarianceValueLbl.text = [NSString stringWithFormat:@"%@",@":0.00  "];
                    qtyVarianceInPrecentageValueLbl.text = [NSString stringWithFormat:@"%@",@":0.00  "];
                    
                }
            }
            
        } @catch (NSException *exception) {
            
        }
        
        customerInfoPopUp.view = customerView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customerView.frame.size.width, customerView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:sender.frame inView:goodsReceiptNoteView  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            
            popover.backgroundColor = [UIColor lightGrayColor];
            
        }
        
        else {
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            popover = popover;
            
        }
        
        customerView.backgroundColor = [UIColor lightGrayColor];
        
    } @catch (NSException *exception) {
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    } @finally {
        [HUD setHidden:YES];
        
    }
}

/**
 * @description  we are Navigating to the New Grn page for creation purpose...
 * @date         26/09/2016
 * @method       openGoodsReceiptNote:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)navigateToNewGrn:(UIButton *)sender {
    
    @try {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        CreateNewWareHouseGoodsReceiptNote  * newGrn  = [[CreateNewWareHouseGoodsReceiptNote alloc] init];
        
        BOOL isDraft = false;
        
        if(stockReceiptInfoArr.count > sender.tag){
            
            NSString * DraftStr;
            DraftStr  = [stockReceiptInfoArr[sender.tag] valueForKey:STATUS];
            
            if ([DraftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
                
                isDraft = true;
            }
        }

        if(isDraft) {
            
            newGrn.goodsReceiptRefID = [stockReceiptInfoArr[sender.tag] valueForKey:RECEIPT_NOTE_ID];
            [self.navigationController pushViewController:newGrn animated:YES];
        }
        else {
            
            [self.navigationController pushViewController: newGrn animated:YES];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception will navigation the View -----------%@",exception);
        
    } @finally {
        
    }
}

/**
 * @description  here we are showing the list of requestedItems.......
 * @date         26/09/2016
 * @method       openEditStockReceiptView;
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)openEditStockReceiptView:(UIButton *)sender {
    
    @try {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        CreateNewWareHouseGoodsReceiptNote  * newGrn  = [[CreateNewWareHouseGoodsReceiptNote alloc] init];

        BOOL isDraft = false;
        
        if(stockReceiptInfoArr.count > sender.tag){
            
            NSString * DraftStr;
            DraftStr  = [stockReceiptInfoArr[sender.tag] valueForKey:STATUS];
            
            if ([DraftStr caseInsensitiveCompare:@"draft"] == NSOrderedSame) {
                
                isDraft = true;
            }
        }
        
        if(isDraft) {
            
            newGrn.goodsReceiptRefID = [stockReceiptInfoArr[sender.tag] valueForKey:RECEIPT_NOTE_ID];
            [self.navigationController pushViewController:newGrn animated:YES];
        }

        else {
            
            CreateAndViewGoodsReceiptNote * openStock = [[CreateAndViewGoodsReceiptNote alloc] init];
            openStock.goodsReceiptRefID = [stockReceiptInfoArr[sender.tag] valueForKey:RECEIPT_NOTE_ID];
            openStock.selectedString = @"edit";
            
            [self.navigationController pushViewController:openStock animated:YES];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception will navigation the View -----------%@",exception);
        
    } @finally {
        
    }
    
}

/**
 * @description
 * @date         27/09/2016
 * @method       saveAll:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)saveAll:(UIButton*)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType: @""  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:1];

        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description
 * @date         27/09/2016
 * @method       createGRNS:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createGRNS:(UIButton*)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        
        //changed this buttons local to global. By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...

        createGRNBtn.userInteractionEnabled = NO;
        
        //upto here on 02/05/2018....
        
        
        [HUD setHidden:NO];
        
        NSArray *loyaltyKeys = @[REQUEST_HEADER,@"warehouseLocation",DEF_SUPPLIER_QTY,@"location"];
        
        NSArray *loyaltyObjects = @[[RequestHeader getRequestHeader],presentLocation,@YES,presentLocation];
        NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *controller = [WebServiceController new];
        controller.warehouseGoodsReceipNoteServiceDelegate = self;
        [controller generateGRNs:loyaltyString];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        //changed this buttons local to global. By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        createGRNBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        NSLog(@"----exception in the stockReceiptView in createGRNS:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    } @finally {
        
    }
    
}


/**
 * @description  here we are navigating back to homepage.......
 * @date         27/09/2016
 * @method       cancelGoodsReceiptNoteView:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)cancelGoodsReceiptNoteView:(UIButton*)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [self backAction];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  here update the stockRequest...........
 * @date         22/09/2016
 * @method       saveStockRequest
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)saveGrn:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [HUD setHidden:NO];
        
        //used for Updating the row.......
        stockReceiptTbl.tag = sender.tag;
        
        //updating the request based on arrow button clicked.......
        NSMutableDictionary *dic = [stockReceiptInfoArr[requestedItemsTbl.tag] mutableCopy];
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        float totalAmount = 0;
        int qty = 0;
        
        for(NSDictionary *locDic  in requestedItemsInfoArr){
            
            NSMutableDictionary *temp = [NSMutableDictionary new];
            
            if(![[locDic valueForKey:S_NO] isKindOfClass: [NSNull class]] &&  [locDic.allKeys containsObject:S_NO])
                [temp setValue:[locDic  valueForKey:S_NO] forKey:S_NO];
            
            [temp setValue:[locDic  valueForKey:ITEM_SKU] forKey:ITEM_SKU];
            [temp setValue:[locDic  valueForKey:ITEM_DESC] forKey:ITEM_DESC];
            [temp setValue:[locDic  valueForKey:ORDER_QTY] forKey:ORDER_QTY];
            [temp setValue:[locDic  valueForKey:ORDER_PRICE] forKey:ORDER_PRICE];
            [temp setValue:[locDic  valueForKey:PLU_CODE] forKey:PLU_CODE];
            [temp setValue:[locDic  valueForKey:ITEM_SCAN_CODE] forKey:ITEM_SCAN_CODE];
            [temp setValue:[locDic  valueForKey:BATCH_NUM] forKey:BATCH_NUM];
            [temp setValue:[locDic  valueForKey:SELL_UOM] forKey:SELL_UOM];
            
            [temp setValue:[locDic  valueForKey:TRACKING_REQUIRED] forKey:TRACKING_REQUIRED];

            [temp setValue:[self checkGivenValueIsNullOrNil:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[locDic  valueForKey:ITEM_TAX] defaultReturn:@"0.00"] floatValue]] defaultReturn:@""] forKey:ITEM_TAX];

            [temp setValue:[locDic  valueForKey:SUPPLIED_QTY] forKey:SUPPLIED_QTY];
            [temp setValue:[locDic  valueForKey:SUPPLY_PRICE] forKey:SUPPLY_PRICE];
            
            qty +=  [[locDic  valueForKey:SUPPLIED_QTY] integerValue];
            
            totalAmount = [[locDic  valueForKey:SUPPLY_PRICE] floatValue] * [[locDic  valueForKey:SUPPLIED_QTY] integerValue];
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",totalAmount ] forKey:TOTAL_COST];
            [temp setValue:[locDic  valueForKey:HANDLED_BY] forKey:HANDLED_BY];
            
            [tempArr addObject:temp];
        }
        
        dic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        dic[SUPPLIED_QTY] = @(qty);
        
        dic[ITEMS_LIST] = tempArr;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
        [webServiceController updateWarehouseGoodsReceiptNote:quoteRequestJsonString];
        
        /*{
         deliveryDateStr = "22/08/2016 17:58:01";
         fromStoreCode = "LB Nagar";
         fromWareHouseId = "LB Nagar";
         nextActivities =             (
         );
         outletAll = 0;
         reason = "";
         remarks = "";
         requestApprovedBy = Annapurna;
         requestDateStr = "22/08/2016 17:58:01";
         requestedUserName = Annapurna;
         shippingCost = 200;
         shippingMode = Rail;
         status = Closed;
         stockRequestId = SR20160822180711;
         stockRequestItems =             (
         {
         color = "";
         id = SRIID2016082218071154;
         itemDesc = "LOTUS HONEY SOAP 100G";
         itemPrice = 80;
         model = NA;
         pluCode = 02544105;
         quantity = 10;
         size = NA;
         skuId = 025441;
         stockRequestId = SR20160822180711;
         totalCost = 800;
         }
         );
         toStoreCode = Kondapur;
         toWareHouseId = Kondapur;
         totalStockRequestValue = 800;
         warehouseAll = 0;
         },*/
        
        /* for (int i = 0; i < [rawMaterialDetails count]; i++) {
         NSArray *itemArr = [rawMaterialDetails objectAtIndex:i];
         NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
         [temp setValue:[itemArr objectAtIndex:0] forKey:@"skuId"];
         [temp setValue:[itemArr objectAtIndex:1] forKey:@"pluCode"];
         [temp setValue:[itemArr objectAtIndex:2] forKey:@"itemDesc"];
         [temp setValue:[itemArr objectAtIndex:3] forKey:@"itemPrice"];
         [temp setValue:[itemArr objectAtIndex:4] forKey:@"quantity"];
         [temp setValue:[itemArr objectAtIndex:5] forKey:@"totalCost"];
         [temp setValue:[itemArr objectAtIndex:6] forKey:@"color"];
         [temp setValue:[itemArr objectAtIndex:7] forKey:@"model"];
         [temp setValue:[itemArr objectAtIndex:8] forKey:@"size"];
         [temparr addObject:temp];
         }
         
         NSArray *keys = [NSArray arrayWithObjects:@"stockRequestId", @"fromStoreCode",@"fromWareHouseId",@"toStoreCode",@"toWareHouseId",@"reason",@"requestDateStr",@"deliveryDateStr",@"requestApprovedBy",@"requestedUserName",@"shippingMode",@"shippingCost",@"totalStockRequestValue",@"remarks",@"stockRequestItems",@"status",@"requestHeader", nil];
         
         NSArray *objects1 = [NSArray arrayWithObjects:requestReceiptID, location.text,location.text,supplierID.text,supplierName.text,reasonTxt.text,date.text,poReference.text,deliveredBy.text,inspectedBy.text,shipmentNote.text, @"200.0",totalCost.text,@"",temparr,@"Submitted",[RequestHeader getRequestHeader], nil];*/
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"unable_to_update", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0];
        
    } @finally {
        
    }
}



/**
 * @description  ...
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
        
        [self callingGetAllGRNS:@""];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
    }
}


#pragma  -mark ServiceCalls.......

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
    // BOOL status = FALSE;
    
    @try {
        
        [HUD setHidden:NO];
        
        if(vendorIdArr == nil)
            vendorIdArr = [NSMutableArray new];
        else if(vendorIdArr.count){
            [vendorIdArr removeAllObjects];
        }
        
        NSArray *keys = @[REQUEST_HEADER,PAGE_NO,SEARCH_CRITERIA];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,supplierNameStr];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.supplierServiceSvcDelegate = self;
        [webServiceController getSupplierDetailsData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        [catPopOver dismissPopoverAnimated:YES];
        NSLog(@"---- exception while calling getSuppliers ServicesCall ----%@",exception);
        
    }
    
}

/**
 * @description  calling getStockRequests service..........
 * @date         19/09/2016
 * @method       callingGetStockRequests
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGetAllGRNS:(NSString *)stockReceiptReferenceNumber{
    
    @try {
        
        //Changed The Service Call format BY Bhargav.v on 10/01/2018
        //Reason Forming the Request using a Dictionary Instead of using individual Arrays...
        
        [HUD setHidden:NO];
        
        //text format of the HUD...
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if((requestStartNumber == 0) &&  (stockReceiptInfoArr == nil)){
            
            totalNoOfStockRequests = 0;
            
            stockReceiptInfoArr = [NSMutableArray new];
            
        }
        else if(stockReceiptInfoArr.count){
            
            [stockReceiptInfoArr removeAllObjects];
        }
        
        if(requestStartNumber == 0)
            totalQuantityValueLabel.text = [NSString stringWithFormat:@"%@",@"0.00"];
            totalGrnValueLabel.text  = [NSString stringWithFormat:@"%@",@"0.00"];

        //upto here on 06/02/2017....
        NSString *str1 = startDateTxt.text;
        NSString *str2 = endDateTxt.text;
       
        NSString * locationName = @"";

        if(str1.length > 1)
            str1 = [NSString stringWithFormat:@"%@%@", startDateTxt.text,@" 00:00:00"];
        
        if(str2.length > 1)
            str2 = [NSString stringWithFormat:@"%@%@", endDateTxt.text,@" 00:00:00"];

        searchString = @"";
        if((searchItemsTxt.text).length >= 3)
            searchString = [searchItemsTxt.text copy];
      
        NSMutableArray *zoneArr = [NSMutableArray new];
        
        NSString *vendorIdStr = @"";
        NSLog(@"-----%li",(long)vendorIdsTbl.tag);
        if(vendorIdsTbl.tag > 0){
            
            vendorIdStr =  [self checkGivenValueIsNullOrNil:vendorIdArr[vendorIdsTbl.tag][SUPPLIER_CODE] defaultReturn:@""];
        }
        
        NSString *itemSkuIdStr = @"";
        
        if( itemWiseListTbl.tag > 0 ){
            itemSkuIdStr =  [self checkGivenValueIsNullOrNil:[itemWiseListArr[itemWiseListTbl.tag] valueForKey:SKUID] defaultReturn:@""];
        }
        
        if(requestStartNumber == 0){
            isOpen = false;
            self.selectIndex = nil;
        }
        
        NSMutableDictionary * grnReceiptDetailsDictionary = [[NSMutableDictionary alloc]init];
        
        //setting requestHeader....
        grnReceiptDetailsDictionary[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        //setting for pagination....
        grnReceiptDetailsDictionary[START_INDEX] = [NSString stringWithFormat:@"%d",requestStartNumber];

        //Sending the Boolean value for the given key
        grnReceiptDetailsDictionary[OUTLET_ALL] = @YES;

        //Sending the Boolean value for the given key
        grnReceiptDetailsDictionary[WAREHOUSE_ALL] = @NO;
        
        //Setting the Empty String
        grnReceiptDetailsDictionary[FROM_STORE_CODE] = locationName;
        
        // sending the Date value String Format
        grnReceiptDetailsDictionary[START_DATE] = str1;
        
        // sending the Date value String Format
        grnReceiptDetailsDictionary[END_DATE] = str2;
        
        // setting the present location for the Location which we get it from the App Settings....
        grnReceiptDetailsDictionary[LOCATION] = presentLocation;
        // Similar
        grnReceiptDetailsDictionary[TO_WARE_HOUSE_ID] = presentLocation;

        //Setting the String Which we entered in Search Bar
        grnReceiptDetailsDictionary[SEARCH_CRITERIA] = searchString;
        
        //Setting the Array for the ZoneList
        grnReceiptDetailsDictionary[ZONE_LIST] = zoneArr;

        //Sending the Boolean value for the given key
        grnReceiptDetailsDictionary[ITEMS_REQUIRED] = @YES;

        //Setting the selected  String
        grnReceiptDetailsDictionary[SUPPLIER_ID] = vendorIdStr;
        
        //Setting the selected  String
        grnReceiptDetailsDictionary[ITEM_SKU] = itemSkuIdStr;

        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:grnReceiptDetailsDictionary options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        
        webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
        [webServiceController getAllWarehouseGoodsReceiptNotes:quoteRequestJsonString];

        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 ];
    }
}

/**
 * @description  here we are calling the getPurchaseOrders of the  customer.......
 * @date         28/09/2016
 * @method       callingGetStockReceiptDetails
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGetStockReceiptDetails:(NSString *)POReferenceNumber{
    @try {
        [HUD setHidden:NO];
        
        
        NSArray *loyaltyKeys = @[RECEIPT_NOTE_ID,REQUEST_HEADER,START_INDEX];
        
        NSArray *loyaltyObjects = @[POReferenceNumber,[RequestHeader getRequestHeader],NEGATIVE_ONE];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
        [webServiceController getWarehouseGoodsReceiptNoteWithDetailsWithSynchronousRequest:normalStockString];
        
    } @catch (NSException *exception) {
        
        NSLog(@"-----exception while callign getPurchaseOrdeDetails-----%@",exception);
    }
}

/**
 * @description  calling getStockSummary service..........
 * @date         17/10/2016
 * @method       getStockSummary
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGetStockRequestSummary{
    
    @try {
        [HUD setHidden:NO];
        
        if(goodsReceiptNoteSummaryInfoArr == nil)
            goodsReceiptNoteSummaryInfoArr = [NSMutableArray new];
        else if(goodsReceiptNoteSummaryInfoArr.count)
                [goodsReceiptNoteSummaryInfoArr removeAllObjects];
        
        
        NSArray *headerKeys_ = @[START_INDEX,REQUEST_HEADER,OUTLET_ALL,WAREHOUSE_ALL,FROM_STORE_CODE,START_DATE,END_DATE,LOCATION,TO_WARE_HOUSE_ID,SEARCH_CRITERIA,ZONE_LIST,ITEMS_REQUIRED,SUPPLIER_ID,ITEM_SKU];/*"outletAll":false,"warehouseAll":true,"itemsRequired":true}*/
        
        NSString *str1 = startDateTxt.text;
        NSString *str2 = endDateTxt.text;
        
        
        if(str1.length > 1)
            str1 = [NSString stringWithFormat:@"%@%@", startDateTxt.text,@" 00:00:00"];
        
        if(str2.length > 1)
            str2 = [NSString stringWithFormat:@"%@%@", endDateTxt.text,@" 00:00:00"];
        
//        @(requestStartNumber);
//        [NSString stringWithFormat:@"%d",requestStartNumber];
        
        
        NSString *locationName = @"";
        NSMutableArray *zoneArr = [NSMutableArray new];
        
        
        NSString *vendorIdStr = @"";
        NSLog(@"-----%li",(long)vendorIdsTbl.tag);
        if((vendorIdsTbl.tag >= 0 && (vendorIdTxt.text).length >= 3   )&& ((vendorIdArr.count - 1) >= vendorIdsTbl.tag )){
            
            vendorIdStr =  [self checkGivenValueIsNullOrNil:vendorIdArr[vendorIdsTbl.tag][SUPPLIER_CODE] defaultReturn:@""];
            
        }
        
        NSString *itemSkuIdStr = @"";
        
        
        if((itemWiseListTbl.tag >= 0  && (itemWiseTxt.text).length >= 3) && ((itemWiseListArr.count - 1) >= itemWiseListTbl.tag  )){
            itemSkuIdStr =  [self checkGivenValueIsNullOrNil:[itemWiseListArr[itemWiseListTbl.tag] valueForKey:@"skuID"] defaultReturn:@""];
        }
        
        searchString = @"";
        if((searchItemsTxt.text).length >= 3)
            searchString = [searchItemsTxt.text copy];
        
        NSArray *headerObjects_ = @[NEGATIVE_ONE,[RequestHeader getRequestHeader], @NO ,@YES,locationName,str1,str2,presentLocation,presentLocation,searchString,zoneArr,@YES,vendorIdStr,itemSkuIdStr];
        
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceController = [WebServiceController new];
        
        webServiceController.warehouseGoodsReceipNoteServiceDelegate = self;
        [webServiceController getWarehouseGoodsReceiptNoteSummaryDataWithSynchronousRequest:quoteRequestJsonString];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"----exception in service Call------%@",exception);
    }
    
}


#pragma -mark service calls to getEmployees...
/**
 * @description  calling getStockSummary service..........
 * @date         12/12/2016
 * @method       callingGetEmployees
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingGetEmployees {
    
    @try {
        
        [HUD setHidden:NO];
        
        employeesListArr = [NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,LOCATION];
        NSArray *objects = @[[RequestHeader getRequestHeader],NEGATIVE_ONE,presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.employeeServiceDelegate = self;
        [webServiceController getEmployeeMaster:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        [catPopOver dismissPopoverAnimated:YES];
        NSLog(@"---- exception while calling getSuppliers ServicesCall ----%@",exception);
        
    }
}


#pragma -mark handling of getEmployees service calls....


/**
 * @description  here we handling the getEmployees success response....
 * @date         09/02/2017
 * @method       getEmployeesWithDetailsSuccessReponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (BOOL)getEmployeeDetailsSucessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [HUD setHidden:YES];
        
        for( NSDictionary *dic in [successDictionary valueForKey:EMPLOYEE_DETAILS_LIST]){
            
            //            if(checkGivenValueIsNullOrNil)
            NSMutableString *str = [[NSMutableString alloc] init];
            if(![[dic valueForKey:FIRST_NAME] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:FIRST_NAME])
                str = [[dic valueForKey:FIRST_NAME] mutableCopy];
            
            if(![[dic valueForKey:LAST_NAME] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:LAST_NAME])
                [str appendString:[dic valueForKey:LAST_NAME]];
            
            [employeesListArr addObject:str];
            
        }
        
        NSLog(@"------------%@",employeesListArr);
        
    } @catch (NSException *exception) {
        
        NSLog(@"-------exception in while handling re----%@",exception);
    } @finally {
        
    }
    
}

/**
 * @description  here we handling the getEmployees success response....
 * @date         09/02/2017
 * @method       getEmployeesWithDetailsSuccessReponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (BOOL)getEmployeeErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        NSLog(@"------------%@",errorResponse);
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height -120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 ];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

#pragma -mark ServiceResponse handling  which are used for search....


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

- (void)getSuppliersSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        if([successDictionary[SUPPLIERS] count]){
            [vendorIdArr addObject:@"All"];
            
            for (NSDictionary *dic in successDictionary[SUPPLIERS]){
                
                NSMutableDictionary *tempDic = [NSMutableDictionary new];
                
                [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[SUPPLIER_CODE] defaultReturn:@"00"] forKey:SUPPLIER_CODE];
                [tempDic setValue:[self checkGivenValueIsNullOrNil:dic[FIRM_NAME] defaultReturn:@"--"] forKey:SUPPLIER_NAME];
                
                
                [vendorIdArr addObject:tempDic];
            }
        }
        else{
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height -120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 ];
            
        }
        
    } @catch (NSException *exception) {
        
        NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height -120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 ];
        
        NSLog(@"---- exception while handling the getSuppliers SuccessResponse----%@",exception);
        
        
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
        [catPopOver dismissPopoverAnimated:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = goodsReceiptNoteView.frame.origin.y + snoLbl.frame.origin.y + snoLbl.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0 ];
        
    } @catch (NSException * exception) {
        NSLog(@"---- exception while handling the getSuppliers ErrorResponse----%@",exception);
        
    } @finally {
        
    }
    
}

#pragma -mark GRN delegate methods.......

/**
 * @description  here handling the service call of the getAllStockReceipt
 * @date         12/10/2016
 * @method       getStockReceiptSuccessResponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getWarehouseGoodsReceipNoteSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        //Using to Display the Item wise Data (Description)....
        itemWiseListArr = [NSMutableArray new];

        if((searchItemsTxt.tag == (searchItemsTxt.text).length)  || ((searchItemsTxt.text).length < 3) || requestStartNumber >= 10){
            
            totalNoOfStockRequests = (int)[[successDictionary valueForKey:TOTAL_BILLS] integerValue];
            
            [itemWiseListArr addObject:@"All"];
           
            float deliveredQty = 0 ;
            if((totalQuantityValueLabel.text).length)
                deliveredQty = (totalQuantityValueLabel.text).floatValue;
            
            
            double grnValue = 0;
            if((totalGrnValueLabel.text).length)
                grnValue = (totalGrnValueLabel.text).floatValue;

            for(NSDictionary * dic in [successDictionary valueForKey:GRN_LIST]){
                
                for (NSDictionary * itemDic in [dic valueForKey:ITEMS_LIST] ) {
                    
                    NSMutableDictionary * itemWiseDic = [ NSMutableDictionary new];
                    
                    itemWiseDic[ITEM_DESC] = [self checkGivenValueIsNullOrNil:[itemDic valueForKey:ITEM_DESC] defaultReturn:@"--"];
                    itemWiseDic[ITEM_SKU] = [self checkGivenValueIsNullOrNil:[itemDic valueForKey:ITEM_SKU] defaultReturn:@"--"];
                    
                    deliveredQty += [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SUPPLIED_QTY] defaultReturn:@"0.00"] floatValue];
                    
                    grnValue     += [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SUPPLIED_QTY] defaultReturn:@"0"] integerValue] *  [[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SUPPLY_PRICE] defaultReturn:@"0"] floatValue];


                    [itemWiseListArr addObject:itemWiseDic];
                }
                
                [stockReceiptInfoArr addObject:dic];
                
            }
            
            totalQuantityValueLabel.text  = [NSString stringWithFormat:@"%@%.2f",@"", deliveredQty];
            totalGrnValueLabel.text  = [NSString stringWithFormat:@"%@%.2f",@"", grnValue];
            
            searchItemsTxt.tag = 0;
            [stockReceiptTbl reloadData];
            [HUD setHidden:YES];
        }
        
        else{
            
            searchItemsTxt.tag = 0;
            
            [self textFieldDidChange:searchItemsTxt];
            
        }
        
        //Recently Added By Bhargav.v on 17/10/2017..
        //Reason: To Display the Records in pagination mode based on the Total Records..
        
        
        int strTotalRecords = totalNoOfStockRequests/10;
        
        int remainder = totalNoOfStockRequests % 10;
        
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
        searchItemsTxt.tag = 0;
        [HUD setHidden:YES];
        
        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
    } @finally {
        
        if(requestStartNumber == 0){
            pagenationTxt.text = @"1";
        }
        
        [stockReceiptTbl reloadData];
        [HUD setHidden: YES];
    }
    
}

/**
 * @description  handling the getAllStockReceipt errorResponse
 * @date         31/10/2016
 * @method       getSupplieirsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getWarehouseGoodsReceipNotErrorResponse:(NSString *)errorResponse{
    
    @try {
        if( (searchItemsTxt.tag == (searchItemsTxt.text).length) || ((searchItemsTxt.text).length < 3) || requestStartNumber >= 10){
            
            totalQuantityValueLabel.text = [NSString stringWithFormat:@"%@",@"0.00"];
            totalGrnValueLabel.text  = [NSString stringWithFormat:@"%@",@"0.00"];

            searchItemsTxt.tag = 0;
            [HUD setHidden:YES];
            if(stockReceiptInfoArr.count == 0){
                
                float y_axis = self.view.frame.size.height - 120;
                
                NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0 ];
            }
        }
        else{
            
            searchItemsTxt.tag = 0;
            
            [self textFieldDidChange:searchItemsTxt];
            
        }
        
        
    } @catch (NSException *exception) {
        searchItemsTxt.tag = 0;
        [HUD setHidden:YES];
        
        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
    } @finally {
        [stockReceiptTbl reloadData];
        [HUD setHidden:YES];
        
    }
    
}

/**
 * @description  here handling the service call of the getAllStockReceipt
 * @date         12/10/2016
 * @method       getStockReceiptSuccessResponse
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getWarehouseGoodsReceipNoteWithDetailsSuccessResponse:(NSDictionary *)successDictionary{
    
    
    @try {
        requestedItemsInfoDic = [[NSMutableDictionary alloc] init];
        
        requestedItemsInfoDic = successDictionary[GRN_OBJ];
        
        
        for(NSDictionary *locDic in successDictionary[GRN_OBJ][ITEMS_LIST]){
            
            [requestedItemsInfoArr addObject:locDic];
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
    } @finally {
        [HUD setHidden:YES];
        
    }
    
}

/**
 * @description  handling the getAllStockReceipt errorResponse
 * @date         12/10/2016
 * @method       getSupplieirsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)getWarehouseGoodsReceipNoteWithDetailsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = goodsReceiptNoteView.frame.origin.y + snoLbl.frame.origin.y + snoLbl.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0 ];
        
        
    } @catch (NSException *exception) {
        
        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
    } @finally {
        [HUD setHidden:YES];
        
    }
    
}



/**
 * @description  here handling the service call of the updateGoodsReceiptNote
 * @date         12/10/2016
 * @method       updateWarehouseGoodsReceipNoteSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)updateWarehouseGoodsReceipNoteSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        updateDictionary[ITEMS_LIST] = requestedItemsInfoArr;
        stockReceiptInfoArr[requestedItemsTbl.tag] = updateDictionary;
        [stockReceiptTbl reloadData];
        
        
    } @catch (NSException *exception) {
        NSLog(@"-----------excepiton will handling the stockRequestUpdate response----------%@",exception);
        
    } @finally {
        [HUD setHidden:YES];
        
    }
    
    
}



/**
 * @description  here handling the service call of the updateGoodsReceiptNote
 * @date         12/10/2016
 * @method       updateWarehouseGoodsReceipNoteSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)updateWarehouseGoodsReceipNoteErrorResponse:(NSString *)errorResponse{
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = goodsReceiptNoteView.frame.origin.y + snoLbl.frame.origin.y + snoLbl.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0 ];
        
        
    } @catch (NSException *exception) {
        NSLog(@"-----------excepiton will handling the stockRequestUpdate error----------%@",exception);
        
    } @finally {
        
    }
    
}

/**
 * @description  here handling the service call of the updateGoodsReceiptNote
 * @date         12/10/2016
 * @method       updateWarehouseGoodsReceipNoteSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getWarehouseGoodsReceipNoteSummarySuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        for (NSDictionary *dic in [successDictionary valueForKey:SUMMARY_LIST]) {
            
            [goodsReceiptNoteSummaryInfoArr addObject:dic];
        }
        if(goodsReceiptNoteSummaryInfoArr.count)
           [self showCompleteGRNInfo:summaryInfoBtn];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
    
}

/**
 * @description  handling the getGoodsReceiptSummary errorResponse
 * @date         12/10/2016
 * @method       getWarehouseGoodsReceipNoteSummaryErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getWarehouseGoodsReceipNoteSummaryErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = goodsReceiptNoteView.frame.origin.y + snoLbl.frame.origin.y + snoLbl.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0 ];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
}


/**
 * @description  here we are handling error response received frome the service.......
 * @date         20/09/2016
 * @method       saveAllErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)createGRNsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        //changed this buttons local to global. By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        createGRNBtn.userInteractionEnabled = NO;
        
        //upto here on 02/05/2018....
        
        [HUD setHidden:YES];
        
        NSString *str = @"GRN's Created successfully";
        
        if([[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] isKindOfClass: [NSString class]])
            str = [[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
        
        
        [self displayAlertMessage:str horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are handling error response received frome the service.......
 * @date         20/09/2016
 * @method       getcreateGRNSSummaryErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)createGRNsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        //changed this buttons local to global. By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        createGRNBtn.userInteractionEnabled = NO;
        
        //upto here on 02/05/2018....
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = goodsReceiptNoteView.frame.origin.y + snoLbl.frame.origin.y + snoLbl.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0 ];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
}


#pragma -mark start of UITableViewDelegateMethods

/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         10/09/2016
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
    
    if (tableView == stockReceiptTbl) {
        if(stockReceiptInfoArr.count )
            return  stockReceiptInfoArr.count;
        else
            return 1;
    }
    return 1;
}


/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         10/09/2016
 * @method       tableView: numberOfRowsInSectionL
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @verified By
 * @verified On
 *
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == vendorIdsTbl)
        return vendorIdArr.count;
    
    
    else if(tableView == stockReceiptTbl){
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
    else if(tableView == employeesListTbl){
        
        return  employeesListArr.count;
    }
    
    else if (tableView == pagenationTbl) {
        return pagenationArr.count;
    }
    
    else if(tableView == itemWiseListTbl)
        return itemWiseListArr.count;
    
    else
        return 0;
    
}

/**
 * @description  it is tableViewDelegate method it will execute and return height in Table.....
 * @date         21/09/2016
 * @method       tableView: hegintForRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if(tableView == vendorIdsTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 40;
        }
        else {
            return 150.0;
        }
    }
    
    else     if(tableView == stockReceiptTbl){
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
        }else {
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
    else if(tableView == requestedItemsTbl || tableView ==  employeesListTbl  || tableView ==  itemWiseListTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
           
            return 35;
 
        }
        
        else {
          
            return 45;
        }
    }
    return 45;

}

/**
 * @description  it is tableViewDelegate method it will execute and return cell in Table.....
 * @date         21/09/2016
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @return       UITableViewCell
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == vendorIdsTbl) {
        
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
            
            if(indexPath.row == 0)
                hlcell.textLabel.text = vendorIdArr[indexPath.row];
            else
                hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:vendorIdArr[indexPath.row][SUPPLIER_NAME] defaultReturn:@"--"];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        } @catch (NSException *exception) {
            
        }
        
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
    }
    
    else if(tableView == itemWiseListTbl) {
        
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
           
            hlcell.textLabel.numberOfLines = 1;
            
            if(indexPath.row == 0)
                hlcell.textLabel.text = itemWiseListArr[indexPath.row];
            else
                hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:itemWiseListArr[indexPath.row][ITEM_DESC] defaultReturn:@"--"];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
        } @catch (NSException *exception) {
            
        }
        
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    
    else if(tableView == stockReceiptTbl) {
 
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
            
            static NSString *cellIdentifier = @"cell1";
            
            UITableViewCell  *hlcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
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
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
                
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:10];
            }
           
            hlcell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (requestedItemsInfoArr.count >4) {
                    
                    hlcell.frame = CGRectMake(stockReceiptTbl.frame.origin.x,0,stockReceiptTbl.frame.size.width,40*4+ 50);
                    
                    requestedItemsTblHeaderView.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    requestedItemsTbl.frame = CGRectMake( requestedItemsTblHeaderView.frame.origin.x,requestedItemsTblHeaderView.frame.size.height + 5,  requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height - 80);
                }
                else{
                    
                    hlcell.frame = CGRectMake( stockReceiptTbl.frame.origin.x, 0, stockReceiptTbl.frame.size.width,  (40  * (requestedItemsInfoArr.count + 2)) + 30);
                    requestedItemsTblHeaderView.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x, 10,requestedItemsTblHeaderView.frame.size.width, requestedItemsTblHeaderView.frame.size.height);
                    
                    requestedItemsTbl.frame = CGRectMake(requestedItemsTblHeaderView.frame.origin.x,  requestedItemsTblHeaderView.frame.size.height+5,requestedItemsTblHeaderView.frame.size.width, hlcell.frame.size.height-80);
                }
            }
            else {
                
                if (requestedItemsInfoArr.count >4) {
                    hlcell.frame = CGRectMake( 15, 0,stockReceiptTbl.frame.size.width - 15,  30*4);
                    
                    requestedItemsTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, hlcell.frame.size.height);
                }
                else{
                    
                    hlcell.frame = CGRectMake( 25, 0,stockReceiptTbl.frame.size.width - 25,  requestedItemsInfoArr.count*30);
                    
                    requestedItemsTbl.frame = CGRectMake(hlcell.frame.origin.x + 10, hlcell.frame.origin.y,hlcell.frame.size.width - 10, requestedItemsInfoArr.count * 30);
                }
            }
            [requestedItemsTbl reloadData];
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:requestedItemsTblHeaderView];
            [hlcell.contentView addSubview:requestedItemsTbl];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        else{
            
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
            
            //if ([quotatedItemsArr count] >= 1) {
            
            // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorColor = [UIColor clearColor];
            
            UILabel *s_no_Lbl;
            UILabel *grnRefNo_Lbl;
            UILabel *po_Ref_Lbl;
            UILabel *requested_Date_Lbl;
            UILabel *requested_By_Lbl;
            UILabel *status_Lbl;
            
            UILabel *vendor_Id_Lbl;
            UILabel *requested_quantity_Lbl ;
            UILabel *approved_quantity_Lbl  ;
            
            UILabel *grn_value_Lbl;
            
            
            s_no_Lbl = [[UILabel alloc] init];
            s_no_Lbl.backgroundColor = [UIColor clearColor];
            s_no_Lbl.textAlignment = NSTextAlignmentCenter;
            s_no_Lbl.numberOfLines = 1;
            s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            grnRefNo_Lbl = [[UILabel alloc] init];
            grnRefNo_Lbl.backgroundColor = [UIColor clearColor];
            grnRefNo_Lbl.textAlignment = NSTextAlignmentCenter;
            grnRefNo_Lbl.numberOfLines = 1;
            grnRefNo_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            
            po_Ref_Lbl = [[UILabel alloc] init];
            po_Ref_Lbl.backgroundColor = [UIColor clearColor];
            po_Ref_Lbl.textAlignment = NSTextAlignmentCenter;
            po_Ref_Lbl.numberOfLines = 1;
            po_Ref_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            requested_Date_Lbl= [[UILabel alloc] init];
            requested_Date_Lbl.backgroundColor = [UIColor clearColor];
            requested_Date_Lbl.textAlignment = NSTextAlignmentCenter;
            requested_Date_Lbl.numberOfLines = 1;
            requested_Date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            requested_By_Lbl = [[UILabel alloc] init];
            requested_By_Lbl.backgroundColor =  [UIColor clearColor];
            requested_By_Lbl.textAlignment = NSTextAlignmentCenter;
            requested_By_Lbl.numberOfLines = 1;
            
            status_Lbl = [[UILabel alloc] init];
            status_Lbl.backgroundColor =  [UIColor clearColor];
            status_Lbl.textAlignment = NSTextAlignmentCenter;
            status_Lbl.numberOfLines = 1;
            
            vendor_Id_Lbl = [[UILabel alloc] init];
            vendor_Id_Lbl.backgroundColor =  [UIColor clearColor];
            vendor_Id_Lbl.textAlignment = NSTextAlignmentCenter;
            vendor_Id_Lbl.numberOfLines = 1;
            
            requested_quantity_Lbl  = [[UILabel alloc] init];
            requested_quantity_Lbl .backgroundColor =  [UIColor clearColor];
            requested_quantity_Lbl .textAlignment = NSTextAlignmentCenter;
            requested_quantity_Lbl .numberOfLines = 1;
            
            approved_quantity_Lbl   = [[UILabel alloc] init];
            approved_quantity_Lbl  .backgroundColor =  [UIColor clearColor];
            approved_quantity_Lbl  .textAlignment = NSTextAlignmentCenter;
            approved_quantity_Lbl  .numberOfLines = 1;
            
            grn_value_Lbl   = [[UILabel alloc] init];
            grn_value_Lbl.backgroundColor =  [UIColor clearColor];
            grn_value_Lbl.textAlignment = NSTextAlignmentCenter;
            grn_value_Lbl.numberOfLines = 1;
            
            viewStockRequestBtn = [[UIButton alloc] init];
            viewStockRequestBtn.backgroundColor = [UIColor blackColor];
            viewStockRequestBtn.titleLabel.textColor = [UIColor whiteColor];
            viewStockRequestBtn.userInteractionEnabled = YES;
            viewStockRequestBtn.tag = indexPath.section;
            
            editStockRequestBtn = [[UIButton alloc] init];
            editStockRequestBtn.backgroundColor = [UIColor blackColor];
            editStockRequestBtn.titleLabel.textColor = [UIColor whiteColor];
            editStockRequestBtn.userInteractionEnabled = YES;
            editStockRequestBtn.tag = indexPath.section;
            
            viewListOfItemsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *availiableSuppliersListImage;
            
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
            
            [viewStockRequestBtn addTarget:self action:@selector(navigateToNewGrn:) forControlEvents:UIControlEventTouchUpInside];
            [editStockRequestBtn addTarget:self action:@selector(openEditStockReceiptView:) forControlEvents:UIControlEventTouchUpInside];
            [viewListOfItemsBtn addTarget:self action:@selector(showListOfItems:) forControlEvents:UIControlEventTouchUpInside];
            
            
            s_no_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            grnRefNo_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            po_Ref_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            requested_Date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            requested_By_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            status_Lbl.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            approved_quantity_Lbl  .textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            vendor_Id_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            requested_quantity_Lbl .textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            grn_value_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            [viewStockRequestBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
            [editStockRequestBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
            
            
            //setting frame....
            s_no_Lbl.frame = CGRectMake( snoLbl.frame.origin.x, 0, snoLbl.frame.size.width, hlcell.frame.size.height);
            
            grnRefNo_Lbl.frame = CGRectMake(grnRefNumberLbl.frame.origin.x , 0, grnRefNumberLbl.frame.size.width-7, hlcell.frame.size.height);
            
            po_Ref_Lbl.frame = CGRectMake( poRefNumberLbl.frame.origin.x , 0, poRefNumberLbl.frame.size.width-2, hlcell.frame.size.height);
            
            requested_Date_Lbl.frame = CGRectMake( requestDateLbl.frame.origin.x, 0, requestDateLbl.frame.size.width , hlcell.frame.size.height);
            
            requested_By_Lbl.frame = CGRectMake( deliveredByLbl.frame.origin.x , 0, deliveredByLbl.frame.size.width,  hlcell.frame.size.height);
            
            status_Lbl.frame = CGRectMake( statusLbl.frame.origin.x , 0, statusLbl.frame.size.width,  hlcell.frame.size.height);
            
            vendor_Id_Lbl.frame = CGRectMake( vendorIdLbl.frame.origin.x , 0, vendorIdLbl.frame.size.width ,  hlcell.frame.size.height);
            
            requested_quantity_Lbl.frame = CGRectMake( poQuantityLbl.frame.origin.x , 0, poQuantityLbl.frame.size.width ,hlcell.frame.size.height);
            
            approved_quantity_Lbl.frame = CGRectMake( deliveredQuantityLbl .frame.origin.x , 0, deliveredQuantityLbl.frame.size.width,hlcell.frame.size.height);
            
            grn_value_Lbl.frame = CGRectMake( totalGRNLbl.frame.origin.x , 0, totalGRNLbl.frame.size.width, hlcell.frame.size.height);
            
            if(stockReceiptInfoArr.count){
                
                viewStockRequestBtn.frame = CGRectMake(actionLbl.frame.origin.x-10, 0, 60 ,  hlcell.frame.size.height);
                
                editStockRequestBtn.frame = CGRectMake(viewStockRequestBtn.frame.origin.x + viewStockRequestBtn.frame.size.width-12, 0, 60,hlcell.frame.size.height);
                
                viewListOfItemsBtn.frame = CGRectMake(editStockRequestBtn.frame.origin.x + editStockRequestBtn.frame.size.width + 2, 10,  30,  30);
            }
            else {
                
                viewStockRequestBtn.frame = CGRectMake(actionLbl.frame.origin.x, 0, actionLbl.frame.size.width  , hlcell.frame.size.height);
                
            }
            
            [hlcell.contentView addSubview:s_no_Lbl];
            [hlcell.contentView addSubview:grnRefNo_Lbl];

            [hlcell.contentView addSubview:po_Ref_Lbl];
            [hlcell.contentView addSubview:requested_Date_Lbl];
            [hlcell.contentView addSubview:requested_By_Lbl];
            
            [hlcell.contentView addSubview:status_Lbl];
            
            [hlcell.contentView addSubview:vendor_Id_Lbl];
            [hlcell.contentView addSubview:requested_quantity_Lbl ];
            
            [hlcell.contentView addSubview:approved_quantity_Lbl ];
            
            [hlcell.contentView addSubview:grn_value_Lbl];
            
            [hlcell.contentView addSubview:viewStockRequestBtn];
            
            if(stockReceiptInfoArr.count){
                
                [hlcell.contentView addSubview:editStockRequestBtn];
                [hlcell.contentView addSubview:viewListOfItemsBtn];
                
            }
            
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0 cornerRadius:0.0];
            
            viewStockRequestBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];
            editStockRequestBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];
            
            
            @try {
                
                if(stockReceiptInfoArr.count){
                    
                    NSDictionary *dic = stockReceiptInfoArr[indexPath.section];
                    
                    s_no_Lbl.text = [NSString stringWithFormat:@"%li", (indexPath.section + 1)+ requestStartNumber];
                    
                    if ([[dic valueForKey:RECEIPT_NOTE_ID]isKindOfClass:[NSNull class]]|| (![[dic valueForKey:RECEIPT_NOTE_ID]isEqualToString:@""])) {
                        
                        grnRefNo_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:RECEIPT_NOTE_ID] defaultReturn:@"--"];
                    }
                    else
                        grnRefNo_Lbl.text = @"--";
                    
                    
                    if ([[dic valueForKey:Po_REF]isKindOfClass:[NSNull class]]|| (![[dic valueForKey:Po_REF]isEqualToString:@""])) {
                        
                        po_Ref_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:Po_REF] defaultReturn:@"--"];
                    }
                    else
                        po_Ref_Lbl.text = @"--";

                    
                    if(![[dic valueForKey:CREATED_DATE_STR] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:CREATED_DATE_STR])
                        requested_Date_Lbl.text = [[dic valueForKey:CREATED_DATE_STR] componentsSeparatedByString:@" "][0];
                    
                    
                    else   if(![[dic valueForKey:CREATED_Date] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:CREATED_Date])
                        requested_Date_Lbl.text = [NSString stringWithFormat:@"%@", [dic valueForKey:CREATED_Date]];
                    
                    requested_By_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kDeliveredBy]  defaultReturn:@"--"];
                    
                    status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:STATUS]  defaultReturn:@"--"];
                    
                    //vendor_Id_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SUPPLIER_ID]  defaultReturn:@"--"];
                    
                    vendor_Id_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SUPPLIER_NAME]  defaultReturn:@"--"];
                    
                    if(![[dic valueForKey:ORDERED_QTY] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:ORDERED_QTY]){
                        requested_quantity_Lbl.text = [NSString stringWithFormat:@"%ld", [[dic valueForKey:ORDERED_QTY] integerValue]];
                        
                 }
                    
                    if(![[dic valueForKey:SUPPLIED_QTY] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:SUPPLIED_QTY]){
                        
                        approved_quantity_Lbl.text = [NSString stringWithFormat:@"%ld", [[dic valueForKey:SUPPLIED_QTY] integerValue]];
                        
                    }
                    else{
                        
                        int qty = 0;
                        
                        for(NSDictionary *locDic  in [dic valueForKey:ITEMS_LIST]){
                            
                            if(![[locDic valueForKey:SUPPLIED_QTY] isKindOfClass: [NSNull class]] &&  [locDic.allKeys containsObject:SUPPLIED_QTY])
                                qty +=  [[locDic valueForKey:SUPPLIED_QTY] integerValue];
                            
                        }
                        
                        approved_quantity_Lbl.text = [NSString stringWithFormat:@"%i", qty];
                    }
                    
                    if(![[dic valueForKey:TOTAL_GRN_VALUE] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:TOTAL_GRN_VALUE]){
                        
                        grn_value_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:TOTAL_GRN_VALUE] defaultReturn:@"0"] floatValue]];
                    }
                    else {
                        
                        double amount = 0.0;
                        
                        for(NSDictionary *locDic  in [dic valueForKey:ITEMS_LIST]){
                            
                            amount = [[self checkGivenValueIsNullOrNil:[locDic valueForKey:SUPPLIED_QTY] defaultReturn:@"0"] integerValue] *  [[self checkGivenValueIsNullOrNil:[locDic valueForKey:SUPPLY_PRICE] defaultReturn:@"0"] floatValue];
                        }
                        
                        grn_value_Lbl.text = [NSString stringWithFormat:@"%.2f", amount];
                    }
                }
                else{
                    
                    s_no_Lbl.text = @"--";
                    grnRefNo_Lbl.text = @"--";
                    po_Ref_Lbl.text = @"--";
                    requested_Date_Lbl.text = @"--";
                    requested_By_Lbl.text = @"--";
                    status_Lbl.text = @"--";
                    approved_quantity_Lbl.text = @"--";
                    vendor_Id_Lbl.text = @"--";
                    requested_quantity_Lbl.text = @"--";
                    grn_value_Lbl.text = @"--";
                    
                }
                
                [viewStockRequestBtn setTitle:NSLocalizedString(@"new", nil) forState:UIControlStateNormal];
                [editStockRequestBtn setTitle:NSLocalizedString(@"open", nil) forState:UIControlStateNormal];
                [viewStockRequestBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0] forState:UIControlStateNormal];
                [editStockRequestBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0] forState:UIControlStateNormal];
                
            } @catch (NSException *exception) {
                NSLog(@"------exception in cell---%@",exception);
            } @finally {
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.tag = indexPath.row;
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                return hlcell;
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
            
            UILabel *item_No_Lbl;
            UILabel *item_Name_Lbl;
            UILabel *item_Grade_Lbl;
            //qty
            UILabel *item_Requested_Price_Lbl;
            //qty
            UILabel *item_Net_Cost_Lbl;
            
            
            item_No_Lbl = [[UILabel alloc] init];
            item_No_Lbl.backgroundColor = [UIColor clearColor];
            item_No_Lbl.textAlignment = NSTextAlignmentCenter;
            item_No_Lbl.numberOfLines = 1;
            item_No_Lbl.layer.borderWidth = 1.5;
            item_No_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_No_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;

            item_Name_Lbl = [[UILabel alloc] init];
            item_Name_Lbl.backgroundColor = [UIColor clearColor];
            item_Name_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Name_Lbl.numberOfLines = 1;
            item_Name_Lbl.layer.borderWidth = 1.5;
            item_Name_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_Name_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;

            item_Grade_Lbl = [[UILabel alloc] init];
            item_Grade_Lbl.backgroundColor = [UIColor clearColor];
            item_Grade_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Grade_Lbl.numberOfLines = 1;
            item_Grade_Lbl.layer.borderWidth = 1.5;
            item_Grade_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_Grade_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;
            
            qtyChangeTxt = [[UITextField alloc] init];
            qtyChangeTxt.borderStyle = UITextBorderStyleRoundedRect;
            qtyChangeTxt.textColor = [UIColor blackColor];
            qtyChangeTxt.keyboardType = UIKeyboardTypeNumberPad;
            qtyChangeTxt.layer.borderWidth = 1.5;
            qtyChangeTxt.backgroundColor = [UIColor clearColor];
            qtyChangeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            qtyChangeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            qtyChangeTxt.returnKeyType = UIReturnKeyDone;
            qtyChangeTxt.delegate = self;
            [qtyChangeTxt awakeFromNib];
            qtyChangeTxt.keyboardType = UIKeyboardTypeNumberPad;
            qtyChangeTxt.tag = indexPath.row;
            [qtyChangeTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            
            item_Requested_Price_Lbl = [[UILabel alloc] init];
            item_Requested_Price_Lbl.backgroundColor = [UIColor clearColor];
            item_Requested_Price_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Requested_Price_Lbl.numberOfLines = 1;
            item_Requested_Price_Lbl.layer.borderWidth = 1.5;
            item_Requested_Price_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_Requested_Price_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;
            
            apporvedQtyTxt = [[UITextField alloc] init];
            apporvedQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            apporvedQtyTxt.textColor = [UIColor blackColor];
            apporvedQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            apporvedQtyTxt.layer.borderWidth = 1.5;
            apporvedQtyTxt.backgroundColor = [UIColor clearColor];
            apporvedQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            apporvedQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            apporvedQtyTxt.returnKeyType = UIReturnKeyDone;
            apporvedQtyTxt.delegate = self;
            [apporvedQtyTxt awakeFromNib];
            apporvedQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            apporvedQtyTxt.tag = indexPath.row;
            [apporvedQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            
            saveGrnButton = [UIButton buttonWithType:UIButtonTypeCustom];
            saveGrnButton.tag = indexPath.section;
            saveGrnButton.backgroundColor =  [UIColor clearColor];
            saveGrnButton.layer.borderWidth = 1.5;
            saveGrnButton.layer.cornerRadius = 0;
            
            divrdPriceTxt = [[UITextField alloc] init];
            divrdPriceTxt.borderStyle = UITextBorderStyleRoundedRect;
            divrdPriceTxt.textColor = [UIColor blackColor];
            divrdPriceTxt.keyboardType = UIKeyboardTypeNumberPad;
            divrdPriceTxt.layer.borderWidth = 1.5;
            divrdPriceTxt.backgroundColor = [UIColor clearColor];
            divrdPriceTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            divrdPriceTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            divrdPriceTxt.returnKeyType = UIReturnKeyDone;
            divrdPriceTxt.delegate = self;
            [divrdPriceTxt awakeFromNib];
            divrdPriceTxt.keyboardType = UIKeyboardTypeNumberPad;
            divrdPriceTxt.tag = indexPath.row;
            [divrdPriceTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            item_Net_Cost_Lbl = [[UILabel alloc] init];
            item_Net_Cost_Lbl.backgroundColor = [UIColor clearColor];
            item_Net_Cost_Lbl.textAlignment = NSTextAlignmentCenter;
            item_Net_Cost_Lbl.numberOfLines = 1;
            item_Net_Cost_Lbl.layer.borderWidth = 1.5;
            item_Net_Cost_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            item_Net_Cost_Lbl.lineBreakMode = NSLineBreakByTruncatingTail;
           
            itemHandledByTxt = [[UITextField alloc] init];
            itemHandledByTxt.borderStyle = UITextBorderStyleRoundedRect;
            itemHandledByTxt.keyboardType = UIKeyboardTypeNumberPad;
            itemHandledByTxt.layer.borderWidth = 1;
            itemHandledByTxt.backgroundColor = [UIColor clearColor];
            itemHandledByTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            itemHandledByTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            itemHandledByTxt.returnKeyType = UIReturnKeyDone;
            itemHandledByTxt.delegate = self;
            itemHandledByTxt.tag = indexPath.row;
            itemHandledByTxt.userInteractionEnabled = NO;
            
            itemHandledByTxt.placeholder = NSLocalizedString(@"handled_by",nil);
            itemHandledByTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:itemHandledByTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];

            
            item_No_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_Name_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_Grade_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_Requested_Price_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            divrdPriceTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_Net_Cost_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            qtyChangeTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            apporvedQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            divrdPriceTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemHandledByTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

            qtyChangeTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            apporvedQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            divrdPriceTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemHandledByTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;

            //creating the UIButton which are used to show CustomerInfo popUp.......
            UIButton * handledByBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage * buttonImage_ = [UIImage imageNamed:@"arrow.png"];
            [handledByBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
            [handledByBtn setImage:buttonImage_ forState:UIControlStateNormal];
            [handledByBtn addTarget:self action:@selector(showListOfEmployees:) forControlEvents:UIControlEventTouchDown];
            handledByBtn.tag = indexPath.row;
            
            [hlcell.contentView addSubview:item_No_Lbl];
            [hlcell.contentView addSubview:item_Name_Lbl];
            [hlcell.contentView addSubview:item_Grade_Lbl];
            [hlcell.contentView addSubview:qtyChangeTxt];
            [hlcell.contentView addSubview:item_Requested_Price_Lbl];
            [hlcell.contentView addSubview:apporvedQtyTxt];
            [hlcell.contentView addSubview:divrdPriceTxt];
            [hlcell.contentView addSubview:item_Net_Cost_Lbl];
            [hlcell.contentView addSubview:itemHandledByTxt];
            [hlcell.contentView addSubview:saveGrnButton];
            
            [hlcell.contentView addSubview:handledByBtn];
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                item_No_Lbl.frame = CGRectMake( itemNoLbl.frame.origin.x,0,itemNoLbl.frame.size.width + 2,hlcell.frame.size.height);
                
                item_Name_Lbl.frame = CGRectMake( itemNameLbl.frame.origin.x ,0, itemNameLbl.frame.size.width + 2, hlcell.frame.size.height);
                
                item_Grade_Lbl.frame = CGRectMake( itemGradeLbl.frame.origin.x, 0, itemGradeLbl.frame.size.width + 2, hlcell.frame.size.height);
                
                qtyChangeTxt.frame = CGRectMake( itemRequestedQtyLbl.frame.origin.x, 0,(itemRequestedQtyLbl.frame.size.width + 2) , hlcell.frame.size.height);
                
                item_Requested_Price_Lbl.frame = CGRectMake( itemRequestedPriceLbl.frame.origin.x, 0, itemRequestedPriceLbl.frame.size.width + 2,  hlcell.frame.size.height);
                
                apporvedQtyTxt.frame = CGRectMake( itemApprrovedQtyLbl.frame.origin.x, 0, (itemApprrovedQtyLbl.frame.size.width + 2), hlcell.frame.size.height);
                
                divrdPriceTxt.frame = CGRectMake( itemApprrovedPriceLbl.frame.origin.x , 0, (itemApprrovedPriceLbl.frame.size.width + 2), hlcell.frame.size.height );
                
                item_Net_Cost_Lbl.frame = CGRectMake( itemsNetCostLbl.frame.origin.x , 0, itemsNetCostLbl.frame.size.width + 2 , hlcell.frame.size.height);
                
                itemHandledByTxt.frame = CGRectMake( itemHandledByLbl.frame.origin.x , 0, itemHandledByLbl.frame.size.width,  hlcell.frame.size.height );
                
                saveGrnButton.frame = CGRectMake(itemHandledByTxt.frame.origin.x + itemHandledByTxt.frame.size.width + 2, 5,32,  32);
                
                qtyChangeTxt.textAlignment = NSTextAlignmentCenter;
                apporvedQtyTxt.textAlignment = NSTextAlignmentCenter;
                divrdPriceTxt.textAlignment = NSTextAlignmentCenter;
                
                handledByBtn.frame = CGRectMake((itemHandledByTxt.frame.origin.x + itemHandledByTxt.frame.size.width - 40), itemHandledByTxt.frame.origin.y - 5,45,50);
            }
            else{
                
            }
            //setting frame and font..........
            
            [saveGrnButton setImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            
            @try {
                
                NSMutableDictionary *dic = [requestedItemsInfoArr[indexPath.row] mutableCopy];
                
                /*
                 handledBy = unknown;
                 itemDesc = "RASNA FRUIT PLUS ORANGE";
                 orderPrice = 30;
                 orderQty = 10;
                 pluCode = 00000201;
                 receiptNoteRef = GRN20161024124734;
                 skuId = 000002;
                 sno = 16;
                 totalCost = 300;
                 */
                
                item_No_Lbl.text = [NSString stringWithFormat:@"%i", (int)(indexPath.row + 1)];
                
                if(![[dic valueForKey:ITEM_DESC] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:ITEM_DESC])
                    item_Name_Lbl.text = [dic valueForKey:ITEM_DESC];
                
                if(![[dic valueForKey:PRODUCT_RANGE] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:PRODUCT_RANGE])
                    item_Grade_Lbl.text = [dic valueForKey:PRODUCT_RANGE];
                else
                    item_Grade_Lbl.text = @"--";
                
                if(![[dic valueForKey:ORDER_QTY] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:ORDER_QTY])
                    qtyChangeTxt.text = [NSString stringWithFormat:@"%i",(int) [[dic valueForKey:ORDER_QTY] integerValue]];
                
                if(![[dic valueForKey:ORDER_PRICE] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:ORDER_PRICE])
                    item_Requested_Price_Lbl.text = [NSString stringWithFormat:@"%.2f", [[dic valueForKey:ORDER_PRICE] floatValue]];
                
                if(![[dic valueForKey:SUPPLIED_QTY] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:SUPPLIED_QTY])
                    apporvedQtyTxt.text = [NSString stringWithFormat:@"%i", (int)[[dic valueForKey:SUPPLIED_QTY] integerValue]];
                else{
                    
                    dic[SUPPLIED_QTY] = @"0";
                    apporvedQtyTxt.text = [NSString stringWithFormat:@"%i",(int) [[dic valueForKey:SUPPLIED_QTY] integerValue]];
                    
                    requestedItemsInfoArr[indexPath.row] = dic;
                    
                }
                
                if(![[dic valueForKey:SUPPLY_PRICE] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:SUPPLY_PRICE])
                    divrdPriceTxt.text = [NSString stringWithFormat:@"%.2f", [[dic valueForKey:SUPPLY_PRICE] floatValue]];
                else{
                    
                    dic[SUPPLY_PRICE] = [dic valueForKey:ORDER_PRICE];
                    divrdPriceTxt.text = [NSString stringWithFormat:@"%.2f", [[dic valueForKey:SUPPLY_PRICE] floatValue]];
                    
                    requestedItemsInfoArr[indexPath.row] = dic;
                    
                }
                
                item_Net_Cost_Lbl.text = [NSString stringWithFormat:@"%.2f", ([[dic valueForKey:SUPPLIED_QTY] integerValue] * [[dic valueForKey:SUPPLY_PRICE] floatValue])];
                
                
                //added on 12/12/2016....
                if(isInEditableState){
                    
                    qtyChangeTxt.userInteractionEnabled = NO;
                    apporvedQtyTxt.userInteractionEnabled = YES;
                    divrdPriceTxt.userInteractionEnabled = YES;
                    saveGrnButton.userInteractionEnabled = YES;
                    
                }
                else{
                    
                    qtyChangeTxt.userInteractionEnabled = NO;
                    apporvedQtyTxt.userInteractionEnabled = NO;
                    divrdPriceTxt.userInteractionEnabled = NO;
                    saveGrnButton.userInteractionEnabled = NO;
                    
                }
                
                //upto here..
                
                if(![[dic valueForKey:HANDLED_BY] isKindOfClass: [NSNull class]] &&  [dic.allKeys containsObject:HANDLED_BY])
                    itemHandledByTxt.text = [dic valueForKey:HANDLED_BY] ;
                
                [saveGrnButton addTarget:self action:@selector(saveGrn:) forControlEvents:UIControlEventTouchDown];
                
            } @catch (NSException *exception) {
                NSLog(@"----exception while populating the data to itemsTbl----%@",exception);
            } @finally {
                
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  hlcell;
        }
    }
    else if( tableView == employeesListTbl) {
        
        //        tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
        static NSString *CellIdentifier = @"employeeCell";
        
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
            
            
            hlcell.textLabel.text = employeesListArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
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
    
    else{
        return nil;
        
    }

}


/**
 * @description  it is tableViewDelegate method it will execute. When an cell is selected in Table.....
 * @date         21/09/2016
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 */


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //added by Srinivasulu on 21/09/2016....
    [catPopOver dismissPopoverAnimated:YES];
    
    if(tableView == stockReceiptTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            UIButton * showGridBtn = [[UIButton alloc]init];
            showGridBtn.tag = indexPath.section;
            [self showListOfItems:showGridBtn];
            
        } @catch (NSException *exception) {
            
        }
    }
    
    else  if(tableView == vendorIdsTbl)  {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            vendorIdsTbl.tag = indexPath.row;
            
            
            if(indexPath.row == 0){
                vendorIdTxt.text = vendorIdArr[0];
            }
            else{
                [vendorIdTxt resignFirstResponder];
                
                vendorIdTxt.text = [self checkGivenValueIsNullOrNil:vendorIdArr[indexPath.row][SUPPLIER_NAME] defaultReturn:@"--"];
                
            }
            
            //calling the service.......
            searchItemsTxt.tag = (searchItemsTxt.text).length;
            //            stockReceiptInfoArr = [NSMutableArray new];
            requestStartNumber = 0;
            totalNoOfStockRequests = 0;
            [self callingGetAllGRNS:@""];
            
        } @catch (NSException *exception) {
            
        }
        
    }
    
    //upto here on 22/12/2016
    
    else if(tableView == itemWiseListTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        itemWiseListTbl.tag = indexPath.row;
        
        @try {
            
            if(indexPath.row == 0)
                itemWiseTxt.text = itemWiseListArr[indexPath.row];
            else
                itemWiseTxt.text = [self checkGivenValueIsNullOrNil:itemWiseListArr[indexPath.row][ITEM_DESC] defaultReturn:@"--"];
            
            //calling the service.......
            searchItemsTxt.tag = (searchItemsTxt.text).length;
            requestStartNumber = 0;
            totalNoOfStockRequests = 0;
            [self callingGetAllGRNS:@""];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    else if(tableView == employeesListTbl) {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            itemHandledByTxt.text = employeesListArr[indexPath.row];

            NSMutableDictionary * dic = [requestedItemsInfoArr[employeesListTbl.tag] mutableCopy];
            
            [dic setValue:employeesListArr[indexPath.row] forKey:HANDLED_BY];
            
            requestedItemsInfoArr[employeesListTbl.tag] = dic;
            
            [requestedItemsTbl reloadData];
            
        } @catch (NSException *exception) {
            NSLog(@"----exception in didSelectRowAtIndexPath----%@",exception);
            
        }
    }
    else if (tableView == pagenationTbl){
        
        @try {
            
            requestStartNumber = 0;
            pagenationTxt.text = pagenationArr[indexPath.row];
            int pageValue = (pagenationTxt.text).intValue;
            requestStartNumber = requestStartNumber + (pageValue * 10) - 10;
            
        } @catch (NSException * exception) {
            
        }
    }
}
#pragma -mark Start of TextFieldDelegates.......

/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date         10/09/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    @try {
        
        if ( (textField.frame.origin.x == qtyChangeTxt.frame.origin.x) || (textField.frame.origin.x == apporvedQtyTxt.frame.origin.x) || (textField.frame.origin.x == divrdPriceTxt.frame.origin.x))
            didTableDataEditing = false;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return  YES;
}


/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    @try {
        
        if ( (textField.frame.origin.x == qtyChangeTxt.frame.origin.x) || (textField.frame.origin.x == apporvedQtyTxt.frame.origin.x) || (textField.frame.origin.x == divrdPriceTxt.frame.origin.x)){
            @try {
                didTableDataEditing = true;

                offSetViewTo = 120;
                
                if((requestedItemsTbl.tag + textField.tag) > (stockReceiptInfoArr.count - 3)){
                    
                    offSetViewTo = offSetViewTo + 120;
                }
                [self keyboardWillShow];
                
                
                
            } @catch (NSException *exception) {
                
            }
        }
        
    } @catch (NSException *exception) {
        
    }
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         06/09/2016
 * @method       textField:  shouldChangeCharactersInRange:  replacementString:
 * @author       Srinivasulu
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ( (textField.frame.origin.x == qtyChangeTxt.frame.origin.x) || (textField.frame.origin.x == apporvedQtyTxt.frame.origin.x) || (textField.frame.origin.x == divrdPriceTxt.frame.origin.x)){

        
        //        NSUInteger lengthOfString = string.length;
        //        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
        //            unichar character = [string characterAtIndex:loopIndex];
        //            if (character < 48) return NO; // 48 unichar for 0
        //            if (character > 57) return NO; // 57 unichar for 9
        //
        //        }
        //
        
        
        
        
        //    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        //    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:textField.text];
        //
        //    BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
        //    return stringIsValid;
        
        
        @try {
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString *expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
            return numberOfMatches != 0;
        } @catch (NSException *exception) {
            return  YES;
            
            NSLog(@"----exception in GoodsReceiptNoteView ----");
            NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
        }
        
        
    }
    
    
    return  YES;
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         10/09/2016
 * @method       textFieldDidChange:
 * @author       Srinivasulu
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
        
        if (textField == searchItemsTxt) {
            
            if ((textField.text).length >= 3) {
                
                @try {
                    if ( searchItemsTxt.tag == 0) {
                        searchItemsTxt.tag = (textField.text).length;
                      
                        requestStartNumber = 0;
                        totalNoOfStockRequests = 0;
                        [self callingGetAllGRNS:@""];
                    }
                    
                    
                } @catch (NSException *exception) {
                    NSLog(@"---- exception while calling getSuppliers ServicesCall ----%@",exception);
                    
                } @finally {
                    
                }
                
            }
            else if (((textField.text).length == 0) || searchString.length == 3) {
                
                searchItemsTxt.tag = 0;
                requestStartNumber = 0;
                totalNoOfStockRequests = 0;
                [self callingGetAllGRNS:@""];
                
            }
            else{
                [HUD setHidden:YES];
                searchItemsTxt.tag = 0;
                
            }
        }
        
        else if(textField.frame.origin.x == apporvedQtyTxt.frame.origin.x){
            
            NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
            
            
            @try {
                
                NSMutableDictionary * dic = [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                [dic setValue:trimmedString forKey:SUPPLIED_QTY];
                
                requestedItemsInfoArr[textField.tag] = dic;
                
                
            } @catch (NSException *exception) {
                NSLog(@"-------exception while changing the quantity-----%@",exception);
            }
        }
        
        else if(textField.frame.origin.x == divrdPriceTxt.frame.origin.x){
            
            NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
            
            
            @try {
                
                NSMutableDictionary * dic = [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                [dic setValue:trimmedString forKey:SUPPLY_PRICE];
                
                requestedItemsInfoArr[textField.tag] = dic;
                
            } @catch (NSException *exception) {
                NSLog(@"-------exception while changing the quantity-----%@",exception);
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing....
 * @date         29/05/2016
 * @method       textFieldDidEndEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    @try {
        [self keyboardWillHide];
        offSetViewTo = 0;
        
        //        if( textField == qtyChangeTxt || textField == apporvedQtyTxt){
        
        if(textField.frame.origin.x == apporvedQtyTxt.frame.origin.x){
            
            NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
            
            NSMutableDictionary * dic = [requestedItemsInfoArr[textField.tag] mutableCopy];
   
            if (trimmedString.length == 0)
                trimmedString = @"0";
            
            
            [dic setValue:trimmedString forKey:SUPPLIED_QTY];
            
            requestedItemsInfoArr[textField.tag] = dic;
            
            if(didTableDataEditing)
            [requestedItemsTbl reloadData];
            
        }
        
        else if(textField.frame.origin.x == divrdPriceTxt.frame.origin.x){
            
            NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
            
            
            @try {
                
                //changing the quantity's selected items.......
                //                if ([trimmedString length] != 0) {
                
                NSMutableDictionary * dic = [requestedItemsInfoArr[textField.tag] mutableCopy];
                
                //                    if( [textField.text integerValue] >  [[dic valueForKey:ORDER_QTY] integerValue] ){
                //
                //                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"approved_qty_should_be_less_then_requested_qty", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                //                        [alert show];
                //
                //                        return;
                //                    }
                //
                
                [dic setValue:trimmedString forKey:SUPPLY_PRICE];
                
                requestedItemsInfoArr[textField.tag] = dic;
                
                if(didTableDataEditing)
                   [requestedItemsTbl reloadData];
                
                //                }
                
            } @catch (NSException *exception) {
                NSLog(@"-------exception while changing the quantity-----%@",exception);
            }
        }
        
        
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing the quantity-----%@",exception);
    }
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



#pragma -mark reusableMethods.......

/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         08/10/2016
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

#pragma -mark keyboard notification methods

/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       keyboardWillShow
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillShow {
    // Animate the current view out of the way
    @try {
        [self setViewMovedUp:YES];
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  called when keyboard is dismissed
 * @date         04/06/2016
 * @method       keyboardWillHide
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillHide {
    @try {
        [self setViewMovedUp:NO];
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  method to move the view up/down whenever the keyboard is shown/dismissed
 * @date         04/06/2016
 * @method       setViewMovedUp
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)setViewMovedUp:(BOOL)movedUp
{
    @try {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3]; // if you want to slide up the view
        
        CGRect rect = self.view.frame;
        
        //    CGRect rect = scrollView.frame;
        
        if (movedUp)
        {
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            rect.origin.y = (rect.origin.y -(rect.origin.y + offSetViewTo));
        }
        else
        {
            // revert back to the normal state.
            rect.origin.y +=  offSetViewTo;
        }
        self.view.frame = rect;
        //   scrollView.frame = rect;
        
        [UIView commitAnimations];
        
        /* offSetViewTo = 80;
         [self keyboardWillShow];*/
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
    
}



/**
 * @description  adding the  alertMessage's based on input
 * @date         18/11/2016
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay{
    
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
        userAlertMessageLbl.numberOfLines = 2;
        
        userAlertMessageLbl.textAlignment = NSTextAlignmentCenter;
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame) {
            
            userAlertMessageLbl.textColor = [UIColor blackColor];
            
            if(soundStatus){
                
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
                
                [HUD setHidden:NO];
                
                searchItemsTxt.tag = (searchItemsTxt.text).length;
                requestStartNumber = 0;
                totalNoOfStockRequests = 0;
                [self callingGetAllGRNS:@""];
                
            }
        }
        else {
            
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
 * @date         18/11/2016
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
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
        
    }
    
}
#pragma  -mark xml parser methods start from here.......

/**
 * @description  in this method we are prasning the data form xmlfile and setting delegate to it....
 * @date         08/07/2016
 * @method       pasringXml:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void) parsingXml:(NSString *)xmlFile
{
    //initialization of Array....
    xmlViewCategotriesInfoDic = [[NSMutableDictionary alloc] init];
    
    //parsering the XmlFile data....
    parserXml = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:xmlFile]];
    parserXml.delegate = self;
    
    @try {
        [parserXml parse];
    }
    @catch (NSException *exception) {
        
        //        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [msg show];
        
        NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"error_in_parsing_the_xml", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0];
        //        [msg release];
        
    }
    
}


/**
 * @description  in this method we are prasning the data form xmlfile and setting delegate to it....
 * @date         08/07/2016
 * @method       parser: didStartElement: namespaceURI: qualifiedName:  attributes:
 * @author       Srinivasulu
 * @param        NSXMLParser
 * @param        NSString
 * @param        NSString
 * @param        NSString
 * @param        NSDictionary
 * @return
 * @verified By
 * @verified On
 *
 */

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict1
{
    @try {
        
        if ( [elementName isEqualToString:@"header_info"] ){
            
            NSMutableDictionary *locDic = [[NSMutableDictionary alloc] init];
            
            locDic[@"font_name"] = attributeDict1[@"font_name"];
            locDic[@"font_size"] = attributeDict1[@"font_size"];
            locDic[@"text"] = attributeDict1[@"text"];
            locDic[@"text_color_code"] = attributeDict1[@"text_color_code"];
            
            xmlViewCategotriesInfoDic[@"header_info"] = locDic;
        }
        else if ( [elementName isEqualToString:@"table_one_headers_label_info"] ){
            
            NSMutableDictionary *locDic = [[NSMutableDictionary alloc] init];
            
            locDic[@"font_name"] = attributeDict1[@"font_name"];
            locDic[@"font_size"] = attributeDict1[@"font_size"];
            locDic[@"text"] = attributeDict1[@"text"];
            locDic[@"text_color_code"] = attributeDict1[@"text_color_code"];
            locDic[@"label_backGround_color_code"] = attributeDict1[@"label_backGround_color_code"];
            
            xmlViewCategotriesInfoDic[@"table_one_headers_label_info"] = locDic;
        }
        else if ( [elementName isEqualToString:@"table_two_headers_label_info"] ){
            
            NSMutableDictionary *locDic = [[NSMutableDictionary alloc] init];
            
            locDic[@"font_name"] = attributeDict1[@"font_name"];
            locDic[@"font_size"] = attributeDict1[@"font_size"];
            locDic[@"text"] = attributeDict1[@"text"];
            locDic[@"text_color_code"] = attributeDict1[@"text_color_code"];
            locDic[@"label_backGround_color_code"] = attributeDict1[@"label_backGround_color_code"];
            
            xmlViewCategotriesInfoDic[@"table_two_headers_label_info"] = locDic;
        }
        
        /*<table_one_headers_label_info  font_name = "ArialRoundedMTBold" font_size = "20" text = "HOME" text_color_code = "#FFFFFF" label_backGround_color_code = "#FFFFFF" />
         
         <table_two_headers_label_info  font_name = "ArialRoundedMTBold" font_size = "20" text = "HOME" text_color_code = "#FFFFFF" label_backGround_color_code = "#FFFFFF" />*/
        
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         18/11/2016
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
 * @description  here we are calling the getSuppliers of the  customer.......
 * @date         13/12/2016
 * @method       showListOfEmployees
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showListOfEmployees:(UIButton *) sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        if(employeesListArr == nil ||  employeesListArr.count == 0){
            
            [self callingGetEmployees];
        }
        
        employeesListTbl.tag = sender.tag;
        
        if(employeesListArr.count){
            float tableHeight = employeesListArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = employeesListArr.count * 33;
            
            if(employeesListArr.count > 5)
                tableHeight = (tableHeight/employeesListArr.count) * 5;
            
            NSIndexPath * selectedRow = [NSIndexPath indexPathForRow:sender.tag inSection:0];
            
            [self showPopUpForTables:employeesListTbl  popUpWidth:(itemHandledByTxt.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:itemHandledByTxt  showViewIn:[requestedItemsTbl cellForRowAtIndexPath:selectedRow]  permittedArrowDirections:UIPopoverArrowDirectionRight];

            
            //[self showPopUpForTables:employeesListTbl  popUpWidth:(itemHandledByTxt.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:itemHandledByTxt  showViewIn:requestedItemsTbl  permittedArrowDirections:UIPopoverArrowDirectionRight];
            
        }
        else {
            [HUD setHidden:YES];
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 ];
            
            //upto here work for drop down...
            
            [catPopOver dismissPopoverAnimated:YES];
            
        }
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
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


/*
 - (void) showSubCategoriesTable: (UIButton *) sender  {
 AudioServicesPlayAlertSound(soundFileObject);
 
 @try {
 NSIndexPath *path;
 
 
 if ([subCategoriousTbl isHidden]) {
 if([sender isKindOfClass:[UITapGestureRecognizer class]]){
 
 UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
 UIView *view = (UIView *)recognizer.view;
 path = [NSIndexPath indexPathForRow:0 inSection:view.tag];
 selectedCategoryNo = view.tag;
 productsCatArr = [productSubCategoryArr objectAtIndex:view.tag];
 
 NSLog(@"%i",view.tag);
 //                NSLog(@"%i",)
 NSLog(@"..........************----------======");
 }
 
 CategoriesCell  *cell_1 = (CategoriesCell *)[categoriousTbl cellForRowAtIndexPath:path];
 
 UITableViewCell *cell2 = [categoriousTbl cellForRowAtIndexPath:path];
 CGRect selectedCellFrame = [cell2.superview convertRect:cell2.frame toView:self.view];
 
 float frame_Y_position = selectedCellFrame.origin.y + cell_1.showSubCategoriousView.frame.origin.y + cell_1.showSubCategoriousView.frame.size.height;
 
 float frame_Height = self.view.frame.size.height - (selectedCellFrame.origin.y + cell_1.showSubCategoriousView.frame.origin.y + cell_1.showSubCategoriousView.frame.size.height);
 //segmentedControl.frame.origin.y - (selectedCellFrame.origin.y + cell_1.subCategortyLbl.frame.origin.y + cell_1.subCategortyLbl.frame.size.height);
 
 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
 
 if (([productsCatArr count] * 40)< frame_Height)
 frame_Height = [productsCatArr count] * 40;
 
 if (version >= 8.0) {
 subCategoriousTbl.frame =  CGRectMake( cell_1.showSubCategoriousView.frame.origin.x, frame_Y_position, cell_1.showSubCategoriousView.frame.size.width, frame_Height);
 }
 else{
 subCategoriousTbl.frame =  CGRectMake( cell_1.showSubCategoriousView.frame.origin.x, frame_Y_position, cell_1.showSubCategoriousView.frame.size.width , frame_Height);
 }
 }
 else{
 if (([productsCatArr count] * 75)< frame_Height)
 frame_Height = [productsCatArr count] * 75;
 
 
 subCategoriousTbl.frame =  CGRectMake( cell_1.showSubCategoriousView.frame.origin.x, frame_Y_position, cell_1.showSubCategoriousView.frame.size.width , frame_Height);
 }
 
 [self.view addSubview:subCategoriousTbl];
 subCategoriousTbl.hidden = NO;
 //            [categoriousTbl setUserInteractionEnabled:NO];
 [categoriousTbl setContentOffset:categoriousTbl.contentOffset animated:NO];
 categoriousTbl.scrollEnabled = false;
 
 }
 else{
 
 subCategoriousTbl.hidden = YES;
 //            [categoriousTbl setUserInteractionEnabled:NO];
 [categoriousTbl setContentOffset:categoriousTbl.contentOffset animated:YES];
 categoriousTbl.scrollEnabled = true;
 
 }
 
 }
 @catch (NSException *exception) {
 
 }
 @finally {
 
 [subCategoriousTbl reloadData];
 }
 
 }*/
//#pragma -mark handling serviceCallRespone.......
//
///**
// * @description  here handling the service call of the getAllStockReceipt
// * @date         12/10/2016
// * @method       getStockReceiptSuccessResponse
// * @author       Srinivasulu
// * @param        NSDictionary
// * @param
// * @return
// * @verified By
// * @verified On
// *
// */
//
//- (void)getStockReceiptSuccessResponse:(NSDictionary *)successDictionary{
//    
//    @try {
//        
//        if(searchItemsTxt.tag == [searchItemsTxt.text length]){
//            
//            totalNoOfStockRequests = (int) [[successDictionary valueForKey:TOTAL_RECEIPTS] integerValue];
//            
//            for(NSDictionary *dic in [successDictionary valueForKey:RECEIPTS]){
//                
//                [stockReceiptInfoArr addObject:dic];
//            }
//            
//            searchItemsTxt.tag = 0;
//            [HUD setHidden:YES];
//            
//        }
//        else{
//            [self textFieldDidChange:searchItemsTxt];
//            
//        }
//        
//    } @catch (NSException *exception) {
//        
//        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
//    } @finally {
//        [HUD setHidden:YES];
//        [stockReceiptTbl reloadData];
//    }
//}
//
///**
// * @description  handling the getAllStockReceipt errorResponse
// * @date         12/10/2016
// * @method       getSupplieirsErrorResponse:
// * @author       Srinivasulu
// * @param        NSString
// * @param
// * @return
// * @verified By
// * @verified On
// *
// */
//
//- (void)getStockReceiptErrorResponse:(NSString *)errorResponse{
//    
//    @try {
//        if( (searchItemsTxt.tag == [searchItemsTxt.text length])){
//            
//            
//            searchItemsTxt.tag = 0;
//            [HUD setHidden:YES];
//            if([stockReceiptInfoArr count] == 0){
//                
//                float y_axis = self.view.frame.size.height - 120;
//                
//                if(searchItemsTxt.isEditing)
//                    y_axis = goodsReceiptNoteView.frame.origin.y + snoLbl.frame.origin.y + snoLbl.frame.size.height;
//                
//                NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
//                
//                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0 ];
//            }
//        }
//        else{
//            [self textFieldDidChange:searchItemsTxt];
//            
//        }
//        
//    } @catch (NSException *exception) {
//        
//        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
//    } @finally {
//        [HUD setHidden:YES];
//        [stockReceiptTbl reloadData];
//        
//    }
//}
//
///**
// * @description  here handling the service call of the getAllStockReceipt
// * @date         12/10/2016
// * @method       getStockReceiptSuccessResponse
// * @author       Srinivasulu
// * @param        NSDictionary
// * @param
// * @return
// * @verified By
// * @verified On
// *
// */
//
//- (void)getStockReceiptWithDetailsSuccessResponse:(NSDictionary *)successDictionary{
//    
//    
//    @try {
//        requestedItemsInfoDic = [[NSMutableDictionary alloc] init];
//        
//        requestedItemsInfoDic = [successDictionary copy];
//        
//        for(NSDictionary *locDic in [successDictionary objectForKey:@"itemDetails"]){
//            
//            [requestedItemsInfoArr addObject:locDic];
//        }
//        
//    } @catch (NSException *exception) {
//        
//        NSLog(@"----excepion in handling the response for getSockReceipt----%@",exception);
//    } @finally {
//        [HUD setHidden:YES];
//        
//    }
//}
//
///**
// * @description  handling the getAllStockReceipt errorResponse
// * @date         12/10/2016
// * @method       getSupplieirsErrorResponse:
// * @author       Srinivasulu
// * @param        NSString
// * @param
// * @return
// * @verified By
// * @verified On
// *
// */
//
//- (void)getStockReceiptWithDetailsErrorResponse:(NSString *)errorResponse{
//    
//    @try {
//        
//        [HUD setHidden:YES];
//        
//        float y_axis = self.view.frame.size.height - 120;
//        
//        if(searchItemsTxt.isEditing)
//            y_axis = goodsReceiptNoteView.frame.origin.y + snoLbl.frame.origin.y + snoLbl.frame.size.height;
//        
//        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
//        
//        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:1.0 ];
//        
//    } @catch (NSException *exception) {
//        
//    } @finally {
//        [HUD setHidden:YES];
//        
//    }
//}



