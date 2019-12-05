//
//  EditAndStockReceiptView.m
//  OmniRetailer
//
//  Created by BHargav on 12/3/16.
//
//

#import "EditStockReceipt.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"


@interface EditStockReceipt ()

@end

@implementation EditStockReceipt

@synthesize soundFileURLRef,soundFileObject;
@synthesize receiptId;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments && move all text appending into the try - catch block....
 *
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //creating the stockReceiptView which will display Screen.......
    stockReceiptView = [[UIView alloc] init];
    stockReceiptView.backgroundColor = [UIColor blackColor];
    stockReceiptView.layer.borderWidth = 1.0f;
    stockReceiptView.layer.cornerRadius = 10.0f;
    stockReceiptView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
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
    
    
    //   column 1
    
    UILabel * locationLbl;
    UILabel * dateLbl;
    UILabel * receiptRefNoLbl;
    
     locationLbl = [[UILabel alloc] init];
    locationLbl.layer.cornerRadius = 14;
    locationLbl.layer.masksToBounds = YES;
    locationLbl.numberOfLines = 2;
    locationLbl.textAlignment = NSTextAlignmentLeft;
    locationLbl.backgroundColor = [UIColor clearColor];
    locationLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    dateLbl = [[UILabel alloc] init];
    dateLbl.layer.cornerRadius = 14;
    dateLbl.layer.masksToBounds = YES;
    dateLbl.numberOfLines = 2;
    dateLbl.textAlignment = NSTextAlignmentLeft;
    dateLbl.backgroundColor = [UIColor clearColor];
    dateLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    
    receiptRefNoLbl = [[UILabel alloc] init];
    receiptRefNoLbl.layer.cornerRadius = 14;
    receiptRefNoLbl.layer.masksToBounds = YES;
    receiptRefNoLbl.numberOfLines = 2;
    receiptRefNoLbl.textAlignment = NSTextAlignmentLeft;
    receiptRefNoLbl.backgroundColor = [UIColor clearColor];
    receiptRefNoLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    //end of column 1
    
    //column 2
    
    UILabel * issueRefNoLbl;
    UILabel * requestRefLbl;
    UILabel * deliveredByLbl;
    
    issueRefNoLbl = [[UILabel alloc] init];
    issueRefNoLbl.layer.cornerRadius = 14;
    issueRefNoLbl.layer.masksToBounds = YES;
    issueRefNoLbl.numberOfLines = 2;
    issueRefNoLbl.textAlignment = NSTextAlignmentLeft;
    issueRefNoLbl.backgroundColor = [UIColor clearColor];
    issueRefNoLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    
    
    requestRefLbl = [[UILabel alloc] init];
    requestRefLbl.layer.cornerRadius = 14;
    requestRefLbl.layer.masksToBounds = YES;
    requestRefLbl.numberOfLines = 2;
    requestRefLbl.textAlignment = NSTextAlignmentLeft;
    requestRefLbl.backgroundColor = [UIColor clearColor];
    requestRefLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    deliveredByLbl = [[UILabel alloc] init];
    deliveredByLbl.layer.cornerRadius = 14;
    deliveredByLbl.layer.masksToBounds = YES;
    deliveredByLbl.numberOfLines = 2;
    deliveredByLbl.textAlignment = NSTextAlignmentLeft;
    deliveredByLbl.backgroundColor = [UIColor clearColor];
    deliveredByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    // end of column  2
    
    //    column 3
    
    UILabel * inspectedLbl;
    UILabel * receivedByLbl;
    
    
    inspectedLbl = [[UILabel alloc] init];
    inspectedLbl.layer.cornerRadius = 14;
    inspectedLbl.layer.masksToBounds = YES;
    inspectedLbl.numberOfLines = 2;
    inspectedLbl.textAlignment = NSTextAlignmentLeft;
    inspectedLbl.backgroundColor = [UIColor clearColor];
    inspectedLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    receivedByLbl = [[UILabel alloc] init];
    receivedByLbl.layer.cornerRadius = 14;
    receivedByLbl.layer.masksToBounds = YES;
    receivedByLbl.numberOfLines = 2;
    receivedByLbl.textAlignment = NSTextAlignmentLeft;
    receivedByLbl.backgroundColor = [UIColor clearColor];
    receivedByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    // end of column 3
    
    //    column 4
    
    UILabel * issuedByLbl;
    UILabel * shipmentModeLbl;
    UILabel * actionRequiredLbl;
    UILabel * toOutletLbl;

    
    toOutletLbl = [[UILabel alloc] init];
    toOutletLbl.layer.cornerRadius = 14;
    toOutletLbl.layer.masksToBounds = YES;
    toOutletLbl.numberOfLines = 2;
    toOutletLbl.textAlignment = NSTextAlignmentLeft;
    toOutletLbl.backgroundColor = [UIColor clearColor];
    toOutletLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    issuedByLbl = [[UILabel alloc] init];
    issuedByLbl.layer.cornerRadius = 14;
    issuedByLbl.layer.masksToBounds = YES;
    issuedByLbl.numberOfLines = 2;
    issuedByLbl.textAlignment = NSTextAlignmentLeft;
    issuedByLbl.backgroundColor = [UIColor clearColor];
    issuedByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];

    
    shipmentModeLbl = [[UILabel alloc] init];
    shipmentModeLbl.layer.cornerRadius = 14;
    shipmentModeLbl.layer.masksToBounds = YES;
    shipmentModeLbl.numberOfLines = 2;
    shipmentModeLbl.textAlignment = NSTextAlignmentLeft;
    shipmentModeLbl.backgroundColor = [UIColor clearColor];
    shipmentModeLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    actionRequiredLbl = [[UILabel alloc] init];
    actionRequiredLbl.layer.cornerRadius = 14;
    actionRequiredLbl.layer.masksToBounds = YES;
    actionRequiredLbl.numberOfLines = 2;
    actionRequiredLbl.textAlignment = NSTextAlignmentLeft;
    actionRequiredLbl.backgroundColor = [UIColor clearColor];
    actionRequiredLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    //end of column 4
    
    locationTxt = [[CustomTextField alloc] init];
    locationTxt.borderStyle = UITextBorderStyleRoundedRect;
    locationTxt.font = [UIFont systemFontOfSize:18.0];
    locationTxt.layer.cornerRadius = 10.0;
    locationTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    locationTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    locationTxt.delegate = self;
    locationTxt.userInteractionEnabled = NO;
    [locationTxt awakeFromNib];
  
    
    dateTxt = [[CustomTextField alloc] init];
    dateTxt.borderStyle = UITextBorderStyleRoundedRect;
    dateTxt.font = [UIFont systemFontOfSize:18.0];
    dateTxt.layer.cornerRadius = 10.0;
    dateTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    dateTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    dateTxt.delegate = self;
    dateTxt.userInteractionEnabled = NO;
    [dateTxt awakeFromNib];
    
    receiptRefTxt = [[CustomTextField alloc] init];
    receiptRefTxt.borderStyle = UITextBorderStyleRoundedRect;
    receiptRefTxt.font = [UIFont systemFontOfSize:18.0];
    receiptRefTxt.layer.cornerRadius = 10.0;
    receiptRefTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    receiptRefTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    receiptRefTxt.delegate = self;
    
    receiptRefTxt.userInteractionEnabled = NO;
    [receiptRefTxt awakeFromNib];
    
    issueRefTxt = [[CustomTextField alloc] init];
    issueRefTxt.borderStyle = UITextBorderStyleRoundedRect;
    issueRefTxt.font = [UIFont systemFontOfSize:18.0];
    issueRefTxt.layer.cornerRadius = 10.0;
    issueRefTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    issueRefTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    issueRefTxt.delegate = self;
    issueRefTxt.userInteractionEnabled = NO;
    [issueRefTxt awakeFromNib];
    
    requestRefTxt = [[CustomTextField alloc] init];
    requestRefTxt.borderStyle = UITextBorderStyleRoundedRect;
    requestRefTxt.font = [UIFont systemFontOfSize:18.0];
    requestRefTxt.layer.cornerRadius = 10.0;
    requestRefTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    requestRefTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    requestRefTxt.delegate = self;
    requestRefTxt.userInteractionEnabled = NO;
    [requestRefTxt awakeFromNib];
    
    deliveredByTxt = [[CustomTextField alloc] init];
    deliveredByTxt.borderStyle = UITextBorderStyleRoundedRect;
    deliveredByTxt.font = [UIFont systemFontOfSize:18.0];
    deliveredByTxt.layer.cornerRadius = 10.0;
    deliveredByTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    deliveredByTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    deliveredByTxt.delegate = self;
    deliveredByTxt.userInteractionEnabled = NO;
    [deliveredByTxt awakeFromNib];
    
    
    inspectedByTxt = [[CustomTextField alloc] init];
    inspectedByTxt.borderStyle = UITextBorderStyleRoundedRect;
    inspectedByTxt.font = [UIFont systemFontOfSize:18.0];
    inspectedByTxt.layer.cornerRadius = 10.0;
    inspectedByTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    inspectedByTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    inspectedByTxt.delegate = self;
    inspectedByTxt.userInteractionEnabled = NO;
    [inspectedByTxt awakeFromNib];
    
    receivedByTxt = [[CustomTextField alloc] init];
    receivedByTxt.borderStyle = UITextBorderStyleRoundedRect;
    receivedByTxt.font = [UIFont systemFontOfSize:18.0];
    receivedByTxt.layer.cornerRadius = 10.0;
    receivedByTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    receivedByTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    receivedByTxt.delegate = self;
    receivedByTxt.userInteractionEnabled = NO;
    [receivedByTxt awakeFromNib];
    
    toOutletTxt = [[CustomTextField alloc] init];
    toOutletTxt.borderStyle = UITextBorderStyleRoundedRect;
    toOutletTxt.font = [UIFont systemFontOfSize:18.0];
    toOutletTxt.layer.cornerRadius = 10.0;
    toOutletTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    toOutletTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    toOutletTxt.delegate = self;
    toOutletTxt.userInteractionEnabled = NO;
    [toOutletTxt awakeFromNib];
    
    issuedByTxt = [[CustomTextField alloc] init];
    issuedByTxt.borderStyle = UITextBorderStyleRoundedRect;
    issuedByTxt.font = [UIFont systemFontOfSize:18.0];
    issuedByTxt.layer.cornerRadius = 10.0;
    issuedByTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    issuedByTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    issuedByTxt.delegate = self;
    issuedByTxt.userInteractionEnabled = NO;
    [issuedByTxt awakeFromNib];
    
    shipmentModeTxt = [[CustomTextField alloc] init];
    shipmentModeTxt.borderStyle = UITextBorderStyleRoundedRect;
    shipmentModeTxt.font = [UIFont systemFontOfSize:18.0];
    shipmentModeTxt.layer.cornerRadius = 10.0;
    shipmentModeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentModeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentModeTxt.delegate = self;
    shipmentModeTxt.userInteractionEnabled = NO;
    [shipmentModeTxt awakeFromNib];
    
    actionReqTxt = [[CustomTextField alloc] init];
    actionReqTxt.borderStyle = UITextBorderStyleRoundedRect;
    actionReqTxt.font = [UIFont systemFontOfSize:18.0];
    actionReqTxt.layer.cornerRadius = 10.0;
    actionReqTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    actionReqTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    actionReqTxt.delegate = self;
    actionReqTxt.userInteractionEnabled = NO;
    [actionReqTxt awakeFromNib];
    
    UIImage *shipmentImg;
    UIButton * selctShipment;
    UIButton * selctAction;
    
    shipmentImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    selctShipment = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selctShipment setBackgroundImage:shipmentImg forState:UIControlStateNormal];
    [selctShipment addTarget:self action:@selector(getShipmentModes) forControlEvents:UIControlEventTouchDown];
    
    selctAction = [UIButton buttonWithType:UIButtonTypeCustom];
    [selctAction setBackgroundImage:shipmentImg forState:UIControlStateNormal];
    [selctAction addTarget:self action:@selector(showNextAcivities:) forControlEvents:UIControlEventTouchDown];
    
    workFlowView = [[UIView alloc] init];
    //workFlowView.backgroundColor = [UIColor lightGrayColor];
    
    searchItemTxt = [[CustomTextField alloc] init];
    searchItemTxt.delegate = self;
    [searchItemTxt awakeFromNib];
    searchItemTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItemTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItemTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemTxt.textColor = [UIColor blackColor];
    searchItemTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    searchItemTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
    [searchItemTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImage * productListImg;
    productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
    selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    /* creation of header label: */
    sNoLbl = [[CustomLabel alloc] init];
    [sNoLbl awakeFromNib];
    
    sKuidLbl = [[CustomLabel alloc] init];
    [sKuidLbl awakeFromNib];
    
    descLbl = [[CustomLabel alloc] init];
    [descLbl awakeFromNib];
    
    uomLbl = [[CustomLabel alloc] init];
    [uomLbl awakeFromNib];
    
    priceLbll = [[CustomLabel alloc] init];
    [priceLbll awakeFromNib];
    
    requestedQtyLbl = [[CustomLabel alloc] init];
    [requestedQtyLbl awakeFromNib];
    
    issuedQtyLbl = [[CustomLabel alloc] init];
    [issuedQtyLbl awakeFromNib];
    
    receivedQtyLabel = [[CustomLabel alloc] init];
    [receivedQtyLabel awakeFromNib];
    
    acceptedQtyLbl = [[CustomLabel alloc] init];
    [acceptedQtyLbl awakeFromNib];
    
    diffQtyLabel = [[CustomLabel alloc] init];
    [diffQtyLabel awakeFromNib];
    
    itemScanCodeLabel = [[CustomLabel alloc] init];
    [itemScanCodeLabel awakeFromNib];

    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];

    //upto here on 27/05/2017....

    costLbl = [[UILabel alloc] init];
    costLbl.layer.cornerRadius = 10;
    costLbl.layer.masksToBounds = YES;
    costLbl.numberOfLines = 1;
    costLbl.textAlignment = NSTextAlignmentCenter;
    costLbl.font = [UIFont boldSystemFontOfSize:14.0];
    costLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    costLbl.textColor = [UIColor whiteColor];
    
    // Table for displaying the nextActivities..
    nextActivityTbl = [[UITableView alloc] init];
    nextActivityTbl.backgroundColor = [UIColor blackColor];
    nextActivityTbl.dataSource = self;
    nextActivityTbl.delegate = self;
    nextActivityTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    nextActivityTbl.userInteractionEnabled = TRUE;
    
    skListTable = [[UITableView alloc] init];
    
    // Table for storing the items ..
    cartTable = [[UITableView alloc] init];
    cartTable.backgroundColor = [UIColor blackColor];
    cartTable.dataSource = self;
    cartTable.delegate = self;
    cartTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cartTable.userInteractionEnabled = TRUE;
    
    submitBtn = [[UIButton alloc] init] ;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    saveButton = [[UIButton alloc] init] ;
    saveButton.backgroundColor = [UIColor grayColor];
    saveButton.layer.masksToBounds = YES;
    saveButton.layer.cornerRadius = 5.0f;
    [saveButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    cancelButton.layer.cornerRadius = 5.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    submitBtn.userInteractionEnabled = YES;
    saveButton.userInteractionEnabled = YES;
    cancelButton.userInteractionEnabled = YES;
    
    submitBtn.tag = 2;
    saveButton.tag = 4;
    
    
    //Allocation of TotalValue Lables.....
    
    requestQtyValueLbl = [[UILabel alloc] init];
    requestQtyValueLbl.layer.cornerRadius = 5;
    requestQtyValueLbl.layer.masksToBounds = YES;
    requestQtyValueLbl.backgroundColor = [UIColor blackColor];
    requestQtyValueLbl.layer.borderWidth = 2.0f;
    requestQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    requestQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    requestQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    issueQtyValueLbl = [[UILabel alloc] init];
    issueQtyValueLbl.layer.cornerRadius = 5;
    issueQtyValueLbl.layer.masksToBounds = YES;
    issueQtyValueLbl.backgroundColor = [UIColor blackColor];
    issueQtyValueLbl.layer.borderWidth = 2.0f;
    issueQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    issueQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    issueQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    receivedQtyValueLbl = [[UILabel alloc] init];
    receivedQtyValueLbl.layer.cornerRadius = 5;
    receivedQtyValueLbl.layer.masksToBounds = YES;
    receivedQtyValueLbl.backgroundColor = [UIColor blackColor];
    receivedQtyValueLbl.layer.borderWidth = 2.0f;
    receivedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    receivedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    receivedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    acceptedQtyValueLbl = [[UILabel alloc] init];
    acceptedQtyValueLbl.layer.cornerRadius = 5;
    acceptedQtyValueLbl.layer.masksToBounds = YES;
    acceptedQtyValueLbl.backgroundColor = [UIColor blackColor];
    acceptedQtyValueLbl.layer.borderWidth = 2.0f;
    acceptedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    acceptedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    acceptedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    diffQtyValueLabel = [[UILabel alloc] init];
    diffQtyValueLabel.layer.cornerRadius = 5;
    diffQtyValueLabel.layer.masksToBounds = YES;
    diffQtyValueLabel.backgroundColor = [UIColor blackColor];
    diffQtyValueLabel.layer.borderWidth = 2.0f;
    diffQtyValueLabel.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    diffQtyValueLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    diffQtyValueLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    requestQtyValueLbl.text      = @"0.0";
    issueQtyValueLbl.text        = @"0.0";
    receivedQtyValueLbl.text      = @"0.0";
    acceptedQtyValueLbl.text     = @"0.0";
    diffQtyValueLabel.text     = @"0.0";
    
    requestQtyValueLbl.textAlignment  = NSTextAlignmentCenter;
    issueQtyValueLbl.textAlignment    = NSTextAlignmentCenter;
    receivedQtyValueLbl.textAlignment  = NSTextAlignmentCenter;
    acceptedQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    diffQtyValueLabel.textAlignment = NSTextAlignmentCenter;

    priceTable = [[UITableView alloc] init];
    priceTable.backgroundColor = [UIColor blackColor];
    priceTable.dataSource = self;
    priceTable.delegate = self;
    priceTable.layer.cornerRadius = 3;
    
    priceArr = [[NSMutableArray alloc]init];
    
    
    closeBtn = [[UIButton alloc] init] ;
    [closeBtn addTarget:self action:@selector(closePriceView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 11;
    
    UIImage *image = [UIImage imageNamed:@"delete.png"];
    [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
    
    priceView = [[UIView alloc]init];
    priceView.backgroundColor = [UIColor blackColor];
    priceView.layer.borderWidth = 2.0f;
    
    priceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    transparentView = [[UIView alloc] init];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    descLabl = [[UILabel alloc]init];
    descLabl.layer.cornerRadius = 14;
    descLabl.textAlignment = NSTextAlignmentCenter;
    descLabl.layer.masksToBounds = YES;
    descLabl.font = [UIFont boldSystemFontOfSize:14.0];
    descLabl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
    descLabl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    descLabl.textColor = [UIColor whiteColor];
    
    mrpLbl = [[UILabel alloc]init];
    mrpLbl.text = NSLocalizedString(@"mrp_rps", nil) ;
    mrpLbl.layer.cornerRadius = 14;
    mrpLbl.layer.masksToBounds = YES;
    mrpLbl.textAlignment = NSTextAlignmentCenter;
    mrpLbl.font = [UIFont boldSystemFontOfSize:14.0];
    mrpLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
    mrpLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    mrpLbl.textColor = [UIColor whiteColor];
    
    
    priceLbl = [[UILabel alloc]init];
    priceLbl.layer.cornerRadius = 14;
    priceLbl.layer.masksToBounds = YES;
    priceLbl.textAlignment = NSTextAlignmentCenter;
    priceLbl.font = [UIFont boldSystemFontOfSize:14.0];
    priceLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
    priceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    priceLbl.textColor = [UIColor whiteColor];
    
    
    //added the expection handling by Srinivasulu on15/04/2017....
    
    @try {
        //changing the title header text....
        
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        headerNameLbl.text = NSLocalizedString(@"edit_stock_receipt", nil);

        
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        //upto here on 27/05/2017...
        
        //setting text for labels....
        //used in the first column....
        locationLbl.text = NSLocalizedString(@"From Outlet",nil);
        dateLbl.text = NSLocalizedString(@" Date ", nil);
       
        issueRefNoLbl.text = NSLocalizedString(@"Issue Ref No ", nil);
        inspectedLbl.text = NSLocalizedString(@"Inspected By ", nil);
  
        toOutletLbl.text = NSLocalizedString(@"To Outlet",nil);
        shipmentModeLbl.text = NSLocalizedString(@"Shipment Mode ", nil);

        
        receiptRefNoLbl.text = NSLocalizedString(@"Receipt Ref.", nil);
        requestRefLbl.text = NSLocalizedString(@"Request Ref No", nil);
        deliveredByLbl.text = NSLocalizedString(@"Delivered By ", nil);
        
        //used in the third column....
        receivedByLbl.text = NSLocalizedString(@" Received By  ", nil);
        
        //used in the fourth column....
        actionRequiredLbl.text = NSLocalizedString(@"Action Required ", nil);
        
        
        //setting placeHolder's....
        locationTxt.placeholder = NSLocalizedString(@"Location", nil);
        dateTxt.placeholder = NSLocalizedString(@"date", nil);
        issueRefTxt.placeholder = NSLocalizedString(@"issue_ref", nil);
        inspectedByTxt.placeholder = NSLocalizedString(@"inspectced_by", nil);
        toOutletTxt.placeholder = NSLocalizedString(@"to_outlet", nil);
        shipmentModeTxt.placeholder = NSLocalizedString(@"shipment_mode", nil);
        receiptRefTxt.placeholder = NSLocalizedString(@"receipt_ref", nil);
        requestRefTxt.placeholder = NSLocalizedString(@"request_ref_no", nil);
        deliveredByTxt.placeholder = NSLocalizedString(@"delivered_by", nil);
        receivedByTxt.placeholder = NSLocalizedString(@"received_By", nil);
        actionReqTxt.placeholder = NSLocalizedString(@"action_required", nil);

        //with outplaceholder blow line will result in crash....
        
        if((locationTxt.placeholder).length > 0)
            locationTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:locationTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        if((dateTxt.placeholder).length > 0)
            dateTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dateTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
      
        if((issueRefTxt.placeholder).length > 0)
            issueRefTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:issueRefTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        if((inspectedByTxt.placeholder).length > 0)
            inspectedByTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:inspectedByTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];

        if((toOutletTxt.placeholder).length > 0)
            toOutletTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:toOutletTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];

        if((shipmentModeTxt.placeholder).length > 0)
            shipmentModeTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipmentModeTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];

        
        if((receiptRefTxt.placeholder).length > 0)
            receiptRefTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:receiptRefTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        
        if((requestRefTxt.placeholder).length > 0)
            requestRefTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:requestRefTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        if((deliveredByTxt.placeholder).length > 0)
            deliveredByTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:deliveredByTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        if((receivedByTxt.placeholder).length > 0)
            receivedByTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:receivedByTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        if((actionReqTxt.placeholder).length > 0)
            actionReqTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:actionReqTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        //here setting the placeholder of searchItemsTxt....
        searchItemTxt.placeholder = NSLocalizedString(@"Search Sku Here", nil);
        
        //used in the priceList display....
        descLabl.text = NSLocalizedString(@"description", nil);
        priceLbl.text = NSLocalizedString(@"price", nil);
        
    } @catch (NSException *exception) {
        
    }
    
    //upto here on 15/04/2017....
    
    //end of HeaderView creation
    
    //changed by Srinivasulu on 29/05/2017....
    //added by Srinivasulu on 27/05/2017....
    
    /*Creation of  UISCrollView*/
    stockReceiptItemsScrollView = [[UIScrollView alloc] init];
    
    //upto here on 27/05/2017....
    
    [stockReceiptView addSubview:headerNameLbl];
   
    [stockReceiptView addSubview:locationLbl];
    [stockReceiptView addSubview:locationTxt];
    
    [stockReceiptView addSubview:dateLbl];
    [stockReceiptView addSubview:dateTxt];

    [stockReceiptView addSubview:issueRefNoLbl];
    [stockReceiptView addSubview:issueRefTxt];
    
    [stockReceiptView addSubview:inspectedLbl];
    [stockReceiptView addSubview:inspectedByTxt];

    [stockReceiptView addSubview:toOutletLbl];
    [stockReceiptView addSubview:toOutletTxt];

    [stockReceiptView addSubview:shipmentModeLbl];
    [stockReceiptView addSubview:shipmentModeTxt];
    [stockReceiptView addSubview:selctShipment];

    [stockReceiptView addSubview:receiptRefNoLbl];
    [stockReceiptView addSubview:receiptRefTxt];
    
    [stockReceiptView addSubview:deliveredByLbl];
    [stockReceiptView addSubview:deliveredByTxt];
    
    [stockReceiptView addSubview:receivedByLbl];
    [stockReceiptView addSubview:receivedByTxt];
    
    [stockReceiptView addSubview:requestRefLbl];
    [stockReceiptView addSubview:requestRefTxt];
    
    [stockReceiptView addSubview:actionRequiredLbl];
    [stockReceiptView addSubview:actionReqTxt];
    [stockReceiptView addSubview:selctAction];

    [stockReceiptView addSubview:workFlowView];
    [stockReceiptView addSubview:searchItemTxt];
    [stockReceiptView addSubview:selectCategoriesBtn];

    [stockReceiptItemsScrollView addSubview:sNoLbl];
    [stockReceiptItemsScrollView addSubview:sKuidLbl];
    [stockReceiptItemsScrollView addSubview:descLbl];
    [stockReceiptItemsScrollView addSubview:uomLbl];
    [stockReceiptItemsScrollView addSubview:priceLbll];
    [stockReceiptItemsScrollView addSubview:requestedQtyLbl];
    [stockReceiptItemsScrollView addSubview:issuedQtyLbl];
    [stockReceiptItemsScrollView addSubview:receivedQtyLabel];
    [stockReceiptItemsScrollView addSubview:acceptedQtyLbl];
    [stockReceiptItemsScrollView addSubview:diffQtyLabel];
    [stockReceiptItemsScrollView addSubview:itemScanCodeLabel];
    [stockReceiptItemsScrollView addSubview:actionLbl];
   
    [stockReceiptItemsScrollView addSubview:cartTable];
    [stockReceiptView addSubview:stockReceiptItemsScrollView];
  
    //upto here on 27/05/2017....
    [stockReceiptView addSubview:submitBtn];
    [stockReceiptView addSubview:saveButton];
    [stockReceiptView addSubview:cancelButton];
    
    [stockReceiptView addSubview:requestQtyValueLbl];
    [stockReceiptView addSubview:issueQtyValueLbl];
    [stockReceiptView addSubview:receivedQtyValueLbl];
    [stockReceiptView addSubview:acceptedQtyValueLbl];
    [stockReceiptView addSubview:diffQtyValueLabel];

    [stockReceiptView addSubview:skListTable];
    [stockReceiptView addSubview:nextActivityTbl];
    
    [self.view addSubview:stockReceiptView];
    
    [priceView addSubview:priceLbl];
    [priceView addSubview:mrpLbl];
    [priceView addSubview:descLabl];
    [priceView addSubview:priceTable];
    [transparentView addSubview:priceView];
    [transparentView addSubview:closeBtn];
    
    [self.view addSubview:transparentView];

    //added by Srinivasulu on 29/05/2017....
    
    //populating text to textFields....
    @try {
        
        sNoLbl.text = NSLocalizedString(@"Sno",nil);
        sKuidLbl.text = NSLocalizedString(@"Sku ID",nil);
        descLbl.text = NSLocalizedString(@"Desc",nil);
        uomLbl.text = NSLocalizedString(@"uom",nil);
        priceLbll.text = NSLocalizedString(@"Price",nil);
        costLbl.text = NSLocalizedString(@"Cost",nil);
        
        //added by Srinivasulu on 27/05/2017....
        requestedQtyLbl.text = NSLocalizedString(@"req_qty",nil);
        issuedQtyLbl.text = NSLocalizedString(@"issue_qty",nil);
        receivedQtyLabel.text = NSLocalizedString(@"recved_qty",nil);
        acceptedQtyLbl.text = NSLocalizedString(@"accepted_qty",nil);
        diffQtyLabel.text = NSLocalizedString(@"diff_qty",nil);
        itemScanCodeLabel.text = NSLocalizedString(@"item_code",nil);
        actionLbl.text = NSLocalizedString(@"action",nil);
        
        //used in bottam of GUI as buttons....
        [submitBtn  setTitle:NSLocalizedString(@"edit", nil) forState:UIControlStateNormal];
        [saveButton setTitle:NSLocalizedString(@"save", nil) forState:UIControlStateNormal];
        [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
        
        //upto here on 27/05/2017...
        
    } @catch (NSException *exception) {
        
    }
    
#pragma mark frame:
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
        }
        else{
        }
        
        
//        frame for the stockReceiptView
        stockReceiptView.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        
        headerNameLbl.frame = CGRectMake(0,0,stockReceiptView.frame.size.width,45);

        //setting below labe's frame.......
        float labelWidth =  180;
        float labelHeight = 40;
        
        float textFieldWidth =  180;
        float textFieldHeight = 40;
        float horizontalWidth = 20;
        
        // frame for the column1 UI...
        locationLbl.frame =  CGRectMake(10,headerNameLbl.frame.origin.y+45,labelWidth, labelHeight);
        
        locationTxt.frame =  CGRectMake( locationLbl.frame.origin.x, locationLbl.frame.origin.y + locationLbl.frame.size.height-10,textFieldWidth, textFieldHeight);
        
        dateLbl.frame =  CGRectMake( locationLbl.frame.origin.x, locationTxt.frame.origin.y+locationTxt.frame.size.height+0,labelWidth, labelHeight);
        
        dateTxt.frame =  CGRectMake( locationTxt.frame.origin.x, dateLbl.frame.origin.y + dateLbl.frame.size.height-10, textFieldWidth, textFieldHeight);
    
        // end of column1
        
        // frame for the column2 UI...

        issueRefNoLbl.frame =  CGRectMake(locationLbl.frame.origin.x+locationLbl.frame.size.width+horizontalWidth, locationLbl.frame.origin.y,labelWidth, labelHeight);
        
        issueRefTxt.frame =  CGRectMake( issueRefNoLbl.frame.origin.x,locationTxt.frame.origin.y , textFieldWidth, textFieldHeight);
        
        inspectedLbl.frame =  CGRectMake(issueRefNoLbl.frame.origin.x, dateLbl.frame.origin.y,labelWidth, labelHeight);
        
        inspectedByTxt.frame =  CGRectMake(inspectedLbl.frame.origin.x,dateTxt.frame.origin.y , textFieldWidth, textFieldHeight);
        
        toOutletLbl.frame =  CGRectMake(issueRefNoLbl.frame.origin.x+issueRefNoLbl.frame.size.width+horizontalWidth,issueRefNoLbl.frame.origin.y,labelWidth, labelHeight);
      
        toOutletTxt.frame =  CGRectMake( toOutletLbl.frame.origin.x,issueRefTxt.frame.origin.y,textFieldWidth, textFieldHeight);

        shipmentModeLbl.frame =  CGRectMake(toOutletLbl.frame.origin.x, inspectedLbl.frame.origin.y,labelWidth, labelHeight);
        
        shipmentModeTxt.frame =  CGRectMake( shipmentModeLbl.frame.origin.x,inspectedByTxt.frame.origin.y , textFieldWidth, textFieldHeight);
        
        selctShipment.frame = CGRectMake((shipmentModeTxt.frame.origin.x + shipmentModeTxt.frame.size.width - 45), shipmentModeTxt.frame.origin.y - 8, 55, 60);

        receiptRefNoLbl.frame = CGRectMake(toOutletLbl.frame.origin.x+toOutletLbl.frame.size.width+horizontalWidth, toOutletLbl.frame.origin.y, labelWidth,labelHeight);
        
        receiptRefTxt.frame = CGRectMake(receiptRefNoLbl.frame.origin.x, toOutletTxt.frame.origin.y,textFieldWidth, textFieldHeight);
        
        requestRefLbl.frame = CGRectMake(receiptRefNoLbl.frame.origin.x, shipmentModeLbl.frame.origin.y, labelWidth, labelHeight);
        
        requestRefTxt.frame = CGRectMake(requestRefLbl.frame.origin.x,shipmentModeTxt.frame.origin.y,textFieldWidth,textFieldHeight);

       deliveredByLbl.frame =  CGRectMake(receiptRefNoLbl.frame.origin.x+receiptRefNoLbl.frame.size.width+horizontalWidth+20, receiptRefNoLbl.frame.origin.y,labelWidth, labelHeight);
        
        deliveredByTxt.frame =  CGRectMake( deliveredByLbl.frame.origin.x,receiptRefTxt.frame.origin.y , textFieldWidth, textFieldHeight);
        
        receivedByLbl.frame =  CGRectMake(deliveredByLbl.frame.origin.x, shipmentModeLbl.frame.origin.y,labelWidth, labelHeight);
        
        receivedByTxt.frame =  CGRectMake(receivedByLbl.frame.origin.x,shipmentModeTxt.frame.origin.y , textFieldWidth,textFieldHeight);

        actionReqTxt.frame =  CGRectMake(receivedByTxt.frame.origin.x,receivedByTxt.frame.origin.y+receivedByTxt.frame.size.height+10,textFieldWidth,textFieldHeight);
        
        selctAction.userInteractionEnabled = YES;
        selctAction.frame = CGRectMake((actionReqTxt.frame.origin.x+actionReqTxt.frame.size.width-45), actionReqTxt.frame.origin.y-8, 55, 60);
        
        workFlowView.frame = CGRectMake(0,actionReqTxt.frame.origin.y,requestRefTxt.frame.origin.x + requestRefTxt.frame.size.width -dateTxt.frame.origin.x , textFieldHeight);
        
        // frame for the searchItemTxt...
        searchItemTxt.frame = CGRectMake(locationTxt.frame.origin.x, actionReqTxt.frame.origin.y+actionReqTxt.frame.size.height+5 ,stockReceiptView.frame.size.width-100,40);
        
        selectCategoriesBtn.frame = CGRectMake((searchItemTxt.frame.origin.x+searchItemTxt.frame.size.width + 5),searchItemTxt.frame.origin.y,75,searchItemTxt.frame.size.height);
        
        //changed by Srinivasulu on 29/05/20017....
        
        submitBtn.frame = CGRectMake(searchItemTxt.frame.origin.x,stockReceiptView.frame.size.height-45,110,40);
        
        cancelButton.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+40,submitBtn.frame.origin.y,submitBtn.frame.size.width,submitBtn.frame.size.height);
     

        //frame for the header Labels...
        sNoLbl.frame = CGRectMake( 0, 0, 60, 35);
        
        sKuidLbl.frame = CGRectMake((sNoLbl.frame.origin.x + sNoLbl.frame.size.width +2),sNoLbl.frame.origin.y, 100, sNoLbl.frame.size.height);
        
        descLbl.frame = CGRectMake((sKuidLbl.frame.origin.x + sKuidLbl.frame.size.width +2),sNoLbl.frame.origin.y,150, sNoLbl.frame.size.height);
        
        uomLbl.frame = CGRectMake((descLbl.frame.origin.x + descLbl.frame.size.width +2),sNoLbl.frame.origin.y, 65, sNoLbl.frame.size.height);
        
        requestedQtyLbl.frame = CGRectMake((uomLbl.frame.origin.x + uomLbl.frame.size.width +2),sNoLbl.frame.origin.y, 90, sNoLbl.frame.size.height);
        
        issuedQtyLbl.frame = CGRectMake((requestedQtyLbl.frame.origin.x + requestedQtyLbl.frame.size.width +2),sNoLbl.frame.origin.y, 100, sNoLbl.frame.size.height);
        
        receivedQtyLabel.frame = CGRectMake((issuedQtyLbl.frame.origin.x + issuedQtyLbl.frame.size.width +2), sNoLbl.frame.origin.y, 100, sNoLbl.frame.size.height);
        
        acceptedQtyLbl.frame = CGRectMake((receivedQtyLabel.frame.origin.x+receivedQtyLabel.frame.size.width +2), sNoLbl.frame.origin.y,100, sNoLbl.frame.size.height);
        
        diffQtyLabel.frame = CGRectMake((acceptedQtyLbl.frame.origin.x+acceptedQtyLbl.frame.size.width +2), sNoLbl.frame.origin.y,90, sNoLbl.frame.size.height);
        
        itemScanCodeLabel.frame = CGRectMake((diffQtyLabel.frame.origin.x + diffQtyLabel.frame.size.width + 2), sNoLbl.frame.origin.y,100, sNoLbl.frame.size.height);

        actionLbl.frame = CGRectMake((itemScanCodeLabel.frame.origin.x + itemScanCodeLabel.frame.size.width + 2), sNoLbl.frame.origin.y,115,sNoLbl.frame.size.height);

        //frame for the stockReceiptItemsScrollView...
        stockReceiptItemsScrollView.frame = CGRectMake(searchItemTxt.frame.origin.x,searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height + 5,searchItemTxt.frame.size.width + 90, submitBtn.frame.origin.y - (searchItemTxt.frame.origin.y+searchItemTxt.frame.size.height + 10));
        
        //  frame for the cartTable ...
        cartTable.frame = CGRectMake(stockReceiptView.frame.origin.x,sNoLbl.frame.origin.y + sNoLbl.frame.size.height,actionLbl.frame.origin.x + actionLbl.frame.size.width + 20,stockReceiptItemsScrollView.frame.size.height - (sNoLbl.frame.origin.y+sNoLbl.frame.size.height));
        
        //frame for the stockReceiptItemsScrollView.contentSize..
        stockReceiptItemsScrollView.contentSize = CGSizeMake(cartTable.frame.size.width - 10, stockReceiptItemsScrollView.frame.size.height);
        
        requestQtyValueLbl.frame = CGRectMake(requestedQtyLbl.frame.origin.x+7,submitBtn.frame.origin.y,requestedQtyLbl.frame.size.width,40);
        issueQtyValueLbl.frame = CGRectMake(issuedQtyLbl.frame.origin.x+7,requestQtyValueLbl.frame.origin.y,issuedQtyLbl.frame.size.width,40);
        receivedQtyValueLbl.frame = CGRectMake(receivedQtyLabel.frame.origin.x+7,requestQtyValueLbl.frame.origin.y,receivedQtyLabel.frame.size.width,40);
        acceptedQtyValueLbl.frame = CGRectMake(acceptedQtyLbl.frame.origin.x+7,requestQtyValueLbl.frame.origin.y,acceptedQtyLbl.frame.size.width,40);
        diffQtyValueLabel.frame = CGRectMake(diffQtyLabel.frame.origin.x+7,requestQtyValueLbl.frame.origin.y,diffQtyLabel.frame.size.width,40);

        //  sku Table frame
        //skListTable.frame = CGRectMake(searchItemTxt.frame.origin.x, searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height , searchItemTxt.frame.size.width, 260);
        
        //  frame for the Transparent View for displaying price List..
        transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        priceView.frame = CGRectMake(200, 295, 550,400);
        
        descLabl.frame = CGRectMake(10,10, 225, 35);
        mrpLbl.frame = CGRectMake(descLabl.frame.origin.x+descLabl.frame.size.width+2,descLabl.frame.origin.y, 150, 35);
        priceLbl.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, descLabl.frame.origin.y, 150, 35);
        
        
        priceTable.frame = CGRectMake(descLabl.frame.origin.x,descLabl.frame.origin.y+descLabl.frame.size.height+10, priceLbl.frame.origin.x+priceLbl.frame.size.width - (descLabl.frame.origin.x), priceView.frame.size.height - (descLabl.frame.origin.y + descLabl.frame.size.height +48));
        closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38, 40, 40);

        @try {
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView: self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
            
            headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            
            submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            saveButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            cancelButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

            
        } @catch (NSException *exception) {
            
        }
    }
    else{
    //need to code for IPHONE....
        
    }
    
    @try {
        for (id view in stockReceiptView.subviews) {
            [view setUserInteractionEnabled:NO];
        }
        
        submitBtn.userInteractionEnabled =YES;
        cancelButton.userInteractionEnabled = YES;
    }
    @catch (NSException *exception) {
        
    }
    
    //added by Srinivasulu on 29/04/2017....
    stockReceiptItemsScrollView.userInteractionEnabled = YES;
    
    presentStatus = @"";
}



/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidAppear.......
 * @date
 * @method       viewDidAppear
 * @author
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments....
 *
 */

-(void)viewDidAppear:(BOOL)animated{
    @try {
        
        
        //calling super call.....
        [super viewDidAppear:YES];
        
        rawMaterialDetails = [NSMutableArray new];

        
        [self callingReceiptDetails];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
    }
    
}


#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         27/02/2017
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
}





#pragma -mark service Call Methods....

#pragma mark Get Categories

/**
 * @description  this method is used to get Categories List...
 * @date         11/09/2016
 * @method       validatingCategoriesList
 * @author       Bhargav Ram
 * @param        UIButton
 * @return
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)validatingCategoriesList:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        
        if(((categoriesArr == nil)  && (!categoriesArr.count))){
            
            [self callingCategoriesList];
        }
        else {
            
            [self displayCategoriesList:nil];
            [categoriesTbl reloadData];
        }
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        [HUD setHidden:YES];
        
    }
}

#pragma mark Get Categories

/**
 * @description  this method is used to get Categories List...
 * @date         21/09/2016
 * @method       callingCategoriesList
 * @author       Bhargav Ram
 * @param        NSString
 * @return
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingCategoriesList {
    
    @try {
        [HUD show:YES];
        
        [HUD setHidden:NO];
        
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(categoriesArr == nil) {
            
            categoriesArr  = [NSMutableArray new];
            checkBoxArr    = [NSMutableArray new];
        }
        
        NSMutableDictionary * locationWiseCategoryDictionary = [[NSMutableDictionary alloc]init];
        
        [locationWiseCategoryDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [locationWiseCategoryDictionary setValue:presentLocation forKey:kStoreLocation];
        
        
        [locationWiseCategoryDictionary setValue:NEGATIVE_ONE forKey:START_INDEX_STR];
        
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:OUTLET_ALL];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:WAREHOUSE_ALL];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ISSUE_AND_CLOSE];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:kNotForDownload];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:SAVE_STOCK_REPORT];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ENFORCE_GENERATE_PO];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:IS_TOTAL_COUNT_REQUIRED];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ZERO_STOCK_CHECK_AT_OUTLET_LEVEL];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:locationWiseCategoryDictionary options: 0 error: &err];
        NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductsJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.skuServiceDelegate = self;
        [webServiceController getCategoriesByLocation:getProductsJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
}


/**
 * @description  we are calling the details of a particular receipt ID
 * @date
 * @method       callingReceiptDetails
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 14/04/2017....
 * @reason      added the comments and hidding HUD in catch....
 *
 */


-(void)callingReceiptDetails {
    
    @try {
        
        NSMutableDictionary *receiptDetails = [[NSMutableDictionary alloc] init];
        receiptDetails[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        receiptDetails[kGoodsReceiptRef] = receiptId;
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails options:0 error:&err];
        NSString * getStockReceiptJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockReceiptDelegate = self;
        [webServiceController getStockReceiptDetails:getStockReceiptJsonString];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"%@",exception);
    }
}






/**
 * @description  calling the products
 * @requestDteFld         06/10/2016
 * @method       callRawMaterials
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void) callRawMaterials:(NSString *)searchString {
    
    @try {
        [HUD show:YES];
        [HUD setHidden:NO];
        
        NSMutableDictionary * searchProductDic = [[NSMutableDictionary alloc] init];
        
        searchProductDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        searchProductDic[START_INDEX] = ZERO_CONSTANT;
        searchProductDic[kSearchCriteria] = searchItemTxt.text;
        searchProductDic[kStoreLocation] = presentLocation;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:searchProductDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.searchProductDelegate = self;
        [webServiceController searchProductsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
}





/**
 * @description  calling the skuDetails Based on the product
 * @date         06/10/2016
 * @method       callRawMaterialsDetails.
 * @author       Bhargav
 * @param        Skuid
 * @param
 * @return
 * @verified By
 * @verified On
 *
 
 */



-(void) callRawMaterialDetails:(NSString *)pluCodeStr {
    
    @try {
        [HUD show:YES];
        [HUD setHidden: NO];
        
        NSMutableDictionary * productDetailsDic = [[NSMutableDictionary alloc] init];
        
        productDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        productDetailsDic[kStoreLocation] = presentLocation;
        productDetailsDic[ITEM_SKU] = pluCodeStr;
        productDetailsDic[START_INDEX] = NEGATIVE_ONE;

        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //getSkuid.skuID = salesReportJsonString;
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    
}





/**
 * @description  here we are sending the request for stockREceipt Creation...
 * @date         20/0/2016
 * @method       submitButonPressed:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)submitButtonPressed:(UIButton*)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if([sender.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ){
            
            @try {
                
                for (id view in stockReceiptView.subviews) {
                    [view setUserInteractionEnabled:YES];
                }
                
                //added by Srinivasulu on 15/04/2017....
                
                //first column....
                locationTxt.userInteractionEnabled  = NO;
                dateTxt.userInteractionEnabled  = NO;
                receiptRefTxt.userInteractionEnabled  = NO;
                
                //second Column....
                issueRefTxt.userInteractionEnabled  = NO;
                
                //thrid Column....
                shipmentDateTxt.userInteractionEnabled  = NO;
                
                //fourth Column....
                toOutletTxt.userInteractionEnabled  = NO;
                
                //upto here on15/04/2017....
                
            }
            @catch (NSException *exception) {
                
            }
            
            @finally {
                
                [cartTable reloadData];
            }
            [submitBtn setTitle:NSLocalizedString(@"submit", nil) forState:UIControlStateNormal];
        }
        else {
            
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            
            submitBtn.userInteractionEnabled = NO;
            
            //upto here on 02/05/2018....
            
            [HUD setHidden:NO];
            
            NSString * updateStatuStr = presentStatus;
            
            
            if(![actionReqTxt.text isEqualToString:@""] && (actionReqTxt.text).length >0){
                
                updateStatuStr = actionReqTxt.text;
            }
            
            updateStockReceiptDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            
            //private float issue_total;
            //private int issue_total_qty
            //private String item;
            //private String description;
            //private float quantity;
            //private int max_quantity;
            //private Float price;
            //private Float cost;
            //private int supplied;
            //private int recieved;
            //private int rejected;
            //private String skuId;
            
            NSMutableArray * locArr = [NSMutableArray new];
            
            float receiptTotal = 0.0;
            float receiptTotalQty = 0.0;
            float totalCost = 0.0;

            
            for (NSDictionary * dic in rawMaterialDetails) {
                
                NSMutableDictionary * itemDetailsDic = [dic mutableCopy];
                
                [itemDetailsDic setValue:@([[dic valueForKey:ITEM_UNIT_PRICE] floatValue] * [[dic valueForKey:ACCEPTED_QTY] floatValue]) forKey:COST];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f" ,[[dic valueForKey:kReceived] floatValue]] forKey:ACTUAL_QTY];
                
                receiptTotal  += [[self checkGivenValueIsNullOrNil:@([[dic valueForKey:ITEM_UNIT_PRICE] floatValue] * [[dic valueForKey:ACCEPTED_QTY] floatValue]) defaultReturn:@"0.00"] floatValue];

                receiptTotalQty  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:ACCEPTED_QTY] defaultReturn:@"0.00"] floatValue];

                [locArr addObject:itemDetailsDic];
            }
            
            
            updateStockReceiptDic[RECEIPT_DETAILS] = locArr;
            updateStockReceiptDic[kGoodsReceiptRef] = receiptRefTxt.text;
            updateStockReceiptDic[kReceiptTotal] = @(receiptTotal);
            updateStockReceiptDic[kReceiptTotalQty] = @(receiptTotalQty);
            updateStockReceiptDic[GRAND_TOTAL] = @(totalCost);
            updateStockReceiptDic[kSubTotal] = @(totalCost);
            updateStockReceiptDic[kShipmentMode] = shipmentModeTxt.text;
            updateStockReceiptDic[ID_GOODS_RECEIPT] = @(goodsReceiptInt);
            if((issueRefTxt.text).length > 0){
                updateStockReceiptDic[kIssueReferenceNo] = issueRefTxt.text;
            }
            if((requestRefTxt.text).length > 0){
                updateStockReceiptDic[kgoodsReqRef] = requestRefTxt.text;
            }
            else
                updateStockReceiptDic[kgoodsReqRef] = EMPTY_STRING;

            if((receivedByTxt.text).length > 0){
                updateStockReceiptDic[RECEIVED_by] = receivedByTxt.text;
            }
            
            if ((inspectedByTxt.text).length >0) {
                updateStockReceiptDic[inspected_By] = inspectedByTxt.text;
            }
            
            updateStockReceiptDic[DELIVERED_BY] = deliveredByTxt.text;
            
            // doubt issuedBy = firstName or it has to cme from getStockReceiptDetails or issuedBy Label present in ReceiptSummary
            updateStockReceiptDic[kIssuedBy] = EMPTY_STRING;
            
            updateStockReceiptDic[CUSTOMER_ID] = custID;
            
            updateStockReceiptDic[kShippedFrom] = locationTxt.text;
            
            updateStockReceiptDic[kReceiptLocation] = toOutletTxt.text;
            
            updateStockReceiptDic[REMARKS] = EMPTY_STRING;
            updateStockReceiptDic[kShipmentRef] = EMPTY_STRING;

            int  totalItems = (int)rawMaterialDetails.count;
            [updateStockReceiptDic setValue:@(totalItems) forKey:NO_OF_ITEMS];

            NSString * deliveryDteStr = dateTxt.text;
            
            if(deliveryDteStr.length > 1)
                
                deliveryDteStr = [NSString stringWithFormat:@"%@", dateTxt.text];
            
            updateStockReceiptDic[DELIVERY_DATE] = deliveryDteStr;

            updateStockReceiptDic[kIssuedDate] = deliveryDteStr;

            if ((actionReqTxt.text).length == 0) {
                
                if(sender.tag ==4)
                    updateStockReceiptDic[STATUS] = DRAFT;
                
                else
                    updateStockReceiptDic[STATUS] = RECEIVED;
            }
            else {
                
                updateStockReceiptDic[STATUS] = updateStatuStr;
            }

            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:updateStockReceiptDic options:0 error:&err];
            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"---%@",salesReportJsonString);
            
            WebServiceController *webServiceController = [WebServiceController new];
            webServiceController.stockReceiptDelegate = self;
            [webServiceController updateStockReceipt:jsonData];
        }
    }
    @catch (NSException *exception) {
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        [HUD setHidden:YES];
        NSLog(@" ecxeption in service call %@",exception);
        
    }
    @finally {
        
    }
}

#pragma -mark start of handling service call reponses

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getStockReceiptDetailsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 */

-(void)getStockReceiptDetailsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        updateStockReceiptDic = [NSMutableDictionary new];
        nextActivitiesArr = [NSMutableArray new];
        updateStockReceiptDic = [[successDictionary valueForKey:ITEM_DETAILS][0]mutableCopy];
        
        NSDictionary * details =[successDictionary valueForKey:kReceipt];
        
//        if ([[details allKeys] containsObject:kgoodsReqRef] && ![[details valueForKey:kgoodsReqRef] isKindOfClass:[NSNull class]]) {
//            issueRefTxt.text = [details valueForKey:kgoodsReqRef];
//        }
        
        if ([details.allKeys containsObject:kShippedFrom] && ![[details valueForKey:kShippedFrom] isKindOfClass:[NSNull class]]) {
            locationTxt.text = [details valueForKey:kShippedFrom];
            
        }
        
        if ([details.allKeys containsObject:RECEIVED_by] && ![[details valueForKey:RECEIVED_by] isKindOfClass:[NSNull class]]) {
            receivedByTxt.text = [details valueForKey:RECEIVED_by];
        }
        
        if ([details.allKeys containsObject:DELIVERED_BY] && ![[details valueForKey:DELIVERED_BY] isKindOfClass:[NSNull class]]) {
            deliveredByTxt.text = [details valueForKey:DELIVERED_BY];
        }
        
        if ([details.allKeys containsObject:kGoodsReceiptRef] && ![[details valueForKey:kGoodsReceiptRef] isKindOfClass:[NSNull class]]) {
            receiptRefTxt.text = [details valueForKey:kGoodsReceiptRef];
        }

        if ([details.allKeys containsObject:kgoodsReqRef] && ![[details valueForKey:kgoodsReqRef] isKindOfClass:[NSNull class]]) {
            requestRefTxt.text = [details valueForKey:kgoodsReqRef];
        }
        
        if ([details.allKeys containsObject:kReceiptLocation] && ![[details valueForKey:kReceiptLocation] isKindOfClass:[NSNull class]]) {
            toOutletTxt.text = [details valueForKey:kReceiptLocation];
        }
        
        if ([details.allKeys containsObject:inspected_By] && ![[details valueForKey:inspected_By] isKindOfClass:[NSNull class]]) {
            inspectedByTxt.text = [details valueForKey:inspected_By];
        }
        
        if ([details.allKeys containsObject:kShipmentMode] && ![[details valueForKey:kShipmentMode] isKindOfClass:[NSNull class]]) {
            shipmentModeTxt.text = [details valueForKey:kShipmentMode];
        }
        
        if ([details.allKeys containsObject:kCreatedDateStr] && ![[details valueForKey:kCreatedDateStr] isKindOfClass:[NSNull class]]) {
            dateTxt.text = [details valueForKey:kCreatedDateStr];
        }
        
        if ([details.allKeys containsObject:kIssueReferenceNo] && ![[details valueForKey:kIssueReferenceNo] isKindOfClass:[NSNull class]]) {
            issueRefTxt.text = [details valueForKey:kIssueReferenceNo];
        }
        
        if ([details.allKeys containsObject:STATUS] && ![[details valueForKey:STATUS] isKindOfClass:[NSNull class]]) {
           
            presentStatus = [[details valueForKey:STATUS]copy];
        }
        
        if ([details.allKeys containsObject:ID_GOODS_RECEIPT] && ![[details valueForKey:ID_GOODS_RECEIPT] isKindOfClass:[NSNull class]]) {
            
            goodsReceiptInt = [[[details valueForKey:ID_GOODS_RECEIPT]copy] intValue];
        }


        for (NSDictionary * dic in [successDictionary valueForKey:ITEM_DETAILS]) {
            
            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc]init];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kItem] defaultReturn:@""] forKey:kItem];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@""] forKey:iTEM_PRICE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@""] forKey:kPrice];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@""] forKey:ITEM_PRICE];

            
            //added by Srinivasulu on 18/04/2017.....
            //setting this property eliminate the crash....
            //setting --------- quantity-----used as requested/indented Qty....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@""] forKey:QUANTITY];

            //setting supplied quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kMaxQuantity] defaultReturn:@""] forKey:kMaxQuantity];
            
            //setting supplied quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kSupplied] defaultReturn:@""] forKey:kSupplied];
            
            //setting weighted quantity....
            [itemDetailsDic  setValue:[NSString stringWithFormat:@"%d",0] forKey:WEIGHTED_QTY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kReceived] defaultReturn:@""] forKey:ACCEPTED_QTY];

            //setting received quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kReceived] defaultReturn:@""] forKey:kReceived];

            //setting rejected quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kRejected] defaultReturn:@""] forKey:kRejected];
            
            //upto here on 18/04/2017....
            //[itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kSNo] defaultReturn:@"1"] forKey:kSNo];
            
            //newly added keys....
            //added by  Bhargav.v on  14/04/2017....
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:EAN] defaultReturn:@""] forKey:EAN];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kProductSubCategory] defaultReturn:@""] forKey:kProductSubCategory];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
            
            [itemDetailsDic setValue:EMPTY_STRING forKey:kPrimaryDepartment];
            
            [itemDetailsDic setValue:EMPTY_STRING forKey:SECONDARY_DEPARTMENT];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];

            //upto here on 13/04/2017.....
            
            [rawMaterialDetails addObject:itemDetailsDic];
        }
      
        // showing the next activities
        if([[details valueForKey:NEXT_ACTIVITIES] count] || [[details valueForKey:NEXT_WORK_FLOW_STATES] count]){
            
            [nextActivitiesArr addObject:NSLocalizedString(@"select", nil)];
            
            for(NSString * str in [details valueForKey:NEXT_ACTIVITIES])
                [nextActivitiesArr addObject:str];
            
            for(NSString * str in [details valueForKey:NEXT_WORK_FLOW_STATES])
                [nextActivitiesArr addObject:str];
        }
        
        //upto here.....
        if(nextActivitiesArr.count == 0) {
           
            [nextActivitiesArr addObject:NSLocalizedString(@"--no_activities--", nil)];
            
            if (presentStatus != nil && [presentStatus caseInsensitiveCompare:DRAFT] == NSOrderedSame) {
                // frame for the UIButtons...
                submitBtn.frame = CGRectMake(searchItemTxt.frame.origin.x,stockReceiptView.frame.size.height-45,110, 40);
                
                saveButton.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+20,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
                
                cancelButton.frame = CGRectMake(saveButton.frame.origin.x + saveButton.frame.size.width + 20,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
                
            }
            else {
                
                submitBtn.hidden = YES;
                saveButton.hidden = YES;
                cancelButton.frame = CGRectMake(searchItemTxt.frame.origin.x,stockReceiptView.frame.size.height-45,110, 40);

            }
        }
        
        
        UIImage * workArrowImg = [UIImage imageNamed:@"workflow_arrow.png"];
        
        UIImageView * workFlowImageView = [[UIImageView alloc] init];
        
        workFlowImageView.image = workArrowImg;
        
        [workFlowView addSubview: workFlowImageView];
        
        CGRectMake(0,searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height + 20,stockReceiptView.frame.size.width,50);
        
        NSArray *workFlowArr;
        
        workFlowArr = [details valueForKey:PREVIOUS_STATES];
        
        //workFlowActivities
        
        workFlowImageView.frame = CGRectMake(workFlowView.frame.origin.x+3,5,workFlowView.frame.size.height+30 , workFlowView.frame.size.height-10);
        
        float label_x_origin = workFlowImageView.frame.origin.x+workFlowImageView.frame.size.width;
        float label_y_origin = workFlowImageView.frame.origin.y;
        
        float labelWidth =  (workFlowView.frame.size.width-workFlowImageView.frame.size.width)/((workFlowArr.count*2));
        
        if( workFlowArr.count <= 3 )
            
            //taking max as 5 labels.....
            labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width)/ 8;
        
        float labelHeight = workFlowImageView.frame.size.height;
        
        for(NSString * str1  in workFlowArr){
            
            //need to changed.... written by Srinivasulu on 28/09/2017....
            
            NSString * str = @"--";
            
            if(![str isKindOfClass:[NSNull class]]){
                
                str = str1;
            }
            
            //upto her eon 28/09/2017....
            
            UILabel *workFlowNameLbl;
            UILabel *workFlowLineLbl;
            
            workFlowNameLbl = [[UILabel alloc] init];
            workFlowNameLbl.layer.masksToBounds = YES;
            workFlowNameLbl.numberOfLines = 2;
            workFlowNameLbl.textAlignment = NSTextAlignmentCenter;
            workFlowNameLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            workFlowNameLbl.text = str;
            
            [workFlowView addSubview:workFlowNameLbl];
            
            workFlowNameLbl.frame = CGRectMake(label_x_origin,label_y_origin,labelWidth,labelHeight);
            
            label_x_origin = workFlowNameLbl.frame.origin.x + workFlowNameLbl.frame.size.width;
            
            if(![str isEqualToString:workFlowArr.lastObject]){
                workFlowLineLbl = [[UILabel alloc] init];
                workFlowLineLbl.backgroundColor = [UIColor lightGrayColor];
                
                [workFlowView addSubview:workFlowLineLbl];
                
                workFlowLineLbl.frame = CGRectMake(label_x_origin,(labelHeight + 8)/2,labelWidth, 2);
                label_x_origin = workFlowLineLbl.frame.origin.x + workFlowLineLbl.frame.size.width;
            }
            
            NSLog(@"---------%@",str);
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [cartTable reloadData];
        [HUD setHidden:YES];
    }
}

//itemDetails = (
//                   {
//                       "S_No" = 7;
//                       cost = 790;
//                       costPrice = 0;
//                       description = "LUX AQUA SPARK 4*125G";
//                       item = 001236;
//                       "max_quantity" = 0;
//                       price = 79;
//                       quantity = 10;
//                       "reciept_id" = SSRID1612051308456;
//                       recieved = 10;
//                       rejected = 0;
//                       skuId = 001236;
//                       supplied = 0;
//                   },
//                   {
//                       "S_No" = 8;
//                       cost = 3100;
//                       costPrice = 0;
//                       description = "JHONSON B SHAMP 500ML";
//                       item = 003340;
//                       "max_quantity" = 0;
//                       price = 310;
//                       quantity = 10;
//                       "reciept_id" = SSRID1612051308456;
//                       recieved = 10;
//                       rejected = 0;
//                       skuId = 003340;
//                       supplied = 0;
//                   }
//                   );
//receipt =     {
//    "Delivery_date" = "Dec 6, 2016 12:00:00 AM";
//    InspectedBy = "";
//    "Received_by" = sai;
//    createdDate = "Dec 5, 2016 1:08:45 PM";
//    createdDateStr = "05/12/2016";
//    "delivered_by" = Ajith;
//    deliveryDate = "06/12/2016";
//    "goods_receipt_ref_num" = SSRID1612051308456;
//    "id_goods_receipt" = 4;
//    issueReferenceNo = SSIID201611231228354;
//    nextActivities =         (
//                              Inspected
//                              );
//    outletAll = 0;
//    "receipt_location" = "Jubilee Hills - Hyderabad";
//    "receipt_total" = 3890;
//    "receipt_total_qty" = 0;
//    shipmentMode = Express;
//    status = Received;
//    warehouseAll = 0;
//};
//responseHeader =     {
//    responseCode = 0;
//    responseMessage = "Getting Recipt Details Successfully";
//};
//}


/**
 * @description  here we are handling the error response from the service.......
 * @date         21/09/2016
 * @method       getStockReceiptDetailsErrorResponse
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getStockReceiptDetailsErrorResponse:(NSString *)errorResponse {
    @try {
        
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       searchProductsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    
    @try {
        
        //checking searchItemsFieldTag.......
        if (successDictionary != nil && (searchItemTxt.tag == (searchItemTxt.text).length) ) {
            
            
            //checking searchItemsFieldTag.......
            if (![successDictionary[PRODUCTS_LIST] isKindOfClass:[NSNull class]]  && [successDictionary.allKeys containsObject:PRODUCTS_LIST]) {
                
                
                for(NSDictionary *dic in [successDictionary valueForKey:PRODUCTS_LIST]){
                    
                    [productListArr addObject:dic];
                }
            }
            
            if(productListArr.count){
                float tableHeight = productListArr.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = productListArr.count * 33;
                
                if(productListArr.count > 5)
                    tableHeight = (tableHeight/productListArr.count) * 5;
                
                [self showPopUpForTables:skListTable popUpWidth:searchItemTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItemTxt  showViewIn:stockReceiptView];
                
            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            searchItemTxt.tag = 0;
            [HUD setHidden:YES];
        }
        
        else if ( (((searchItemTxt.text).length >= 3) && (searchItemTxt.tag != 0)) && (searchItemTxt.tag != (searchItemTxt.text).length)) {
            
            searchItemTxt.tag = 0;
            
            [self textFieldDidChange:searchItemTxt];
            
        }
        else  if(catPopOver.popoverVisible || (searchItemTxt.tag == (searchItemTxt.text).length)){
            [catPopOver dismissPopoverAnimated:YES];
            searchItemTxt.tag = 0;
            [HUD setHidden:YES];
            
        }
        else {
            
            [catPopOver dismissPopoverAnimated:YES];
            searchItemTxt.tag = 0;
            [HUD setHidden:YES];
        }
    }
    @catch (NSException * exception) {
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        searchItemTxt.tag = 0;
        [HUD setHidden:YES];
        
    }
    @finally {
        
        
    }
}



/**
 * @description  here we are handling the Error resposne received from services.......
 * @date         20/0/2016
 * @method       searchProductsErrorResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsErrorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];

        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        
    }
}



/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getSkuDetailsSuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    //NSLog(@"---printing the discription of SuccessDictionary---%@",successDictionary );
    
    @try {
        
        if (successDictionary != nil) {
            
            priceDic = [[NSMutableArray alloc]init];
            NSArray *price_arr = [successDictionary valueForKey:kSkuLists];
            
            for (int i=0; i<price_arr.count; i++) {
                
                NSDictionary *json = price_arr[i];
                [priceDic addObject:json];
            }
            if (((NSArray *)[successDictionary valueForKey:kSkuLists]).count>1) {
                
                if (priceDic.count>0) {
                    [HUD setHidden:YES];
                    transparentView.hidden = NO;
                    [priceTable reloadData];
                    SystemSoundID    soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"popup_tune" withExtension: @"mp3"];
                    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                    
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                }
            }
            else  {
                
                BOOL status = FALSE;
                
                int i=0;
                NSMutableDictionary *dic;
                
                for ( i=0; i<rawMaterialDetails.count;i++) {
                    NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        dic = rawMaterialDetails[i];
                        if ([[dic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                           
                            
                            //setting supplied quantity....
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kMaxQuantity] intValue] + 1] forKey:kMaxQuantity];
                            
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kSupplied] intValue] + 1] forKey:kSupplied];
                            
                            //setting accepted quantity....
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:ACCEPTED_QTY] intValue] + 1] forKey:ACCEPTED_QTY];
                            
                            //setting received quantity....
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kReceived] intValue] + 1] forKey:kReceived];
                            
                            rawMaterialDetails[i] = dic;
                            
                            status = TRUE;
                            break;
                        }
                    }
                }
                
                if (!status) {
                    
                    NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary *itemdic = itemArray[0];
                        
                        NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
                        
                        //setting skuId....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                        
                        
                        //setting plucode....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PLU_CODE] defaultReturn:[itemDetailsDic valueForKey:ITEM_SKU]] forKey:PLU_CODE];
                        
                        //setting itemDescription....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];

                        //setting itemPrice as salePrice...  SALE_PRICE .... costPrice
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                        
                        //setting itemPrice as salePrice...  SALE_PRICE .... costPrice
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:ITEM_UNIT_PRICE] floatValue]] forKey:iTEM_PRICE];
                        
                        
                        //added by Srinivasulu on 18/04/2017.....
                        //setting this property eliminate the crash....
                        
                        [itemDetailsDic setValue:@"1" forKey:kSupplied];
                        
                        //upto here on 18/04/2017....
                        
                        //setting --------- quantity-----used as requested/indented Qty....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        
                        //setting supplied quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kSupplied];
                        //setting weighted quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:WEIGHTED_QTY];
                        //setting accepted quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ACCEPTED_QTY];
                        
                        //setting received quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kReceived];
                        //setting rejected quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kRejected];
                        

                        
                        
                        //added by Srinivasulu on 13/04/2017.....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductCategory] defaultReturn:@""] forKey:kProductCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductSubCategory] defaultReturn:@""] forKey:kProductSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductRange] defaultReturn:@""] forKey:kProductRange];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        //Newly Added Keys on 2/08/2017...By Bhargav as per the service modifications...
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                        
                        // added by roja on 18-07-2018...
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:cost_Price] defaultReturn:@"0"] forKey:cost_Price];
                        
                        
                        //upto here on 13/04/2017.....
                        [rawMaterialDetails addObject:itemDetailsDic];

                    }
                    
                    cartTable.hidden = NO;
                }
            }
        }
    }
    @catch (NSException * exception) {
        NSLog(@"---exception will reading.-------%@",exception);
    }
    @finally{
        [HUD setHidden:YES];
        [cartTable reloadData];
        
    }
}


/**
 * @description  in this method we will call the services....
 * @method       getSkuDetailsErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments && added new field in items level....
 *
 */

- (void)getSkuDetailsErrorResponse:(NSString *)failureString{
    @try {
        
        //added by Srinivasulu on 13/04/2017....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",failureString];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       upDateStockReceiptSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)upDateStockReceiptSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_receipt_updated_successfully",nil),@"\n", [successDictionary valueForKey:RECEIPT_ID]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 450)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:450 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:3];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       upDateStockReceiptErrorResponse:
 * @author       Bhargav Ram
 * @param        NSString
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)upDateStockReceiptErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to enable user internation if we get the error response after servcie call to proceed furthur...
        
        submitBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 450)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:3];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  handling the success response received from server side....
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

-(void)getCategoriesByLocationSuccessResponse:(NSDictionary *)sucessDictionary {
    @try {
        
        for (NSDictionary * categoryDic in [sucessDictionary valueForKey:CATEGORY_LIST]) {
            
            [categoriesArr addObject:categoryDic];
            [checkBoxArr addObject:@"0"];
       
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@---exception in handling the response",exception);
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
        if(categoriesArr.count){
            [self displayCategoriesList:nil];
            [categoriesTbl reloadData];
            
        }
    }
}


/**
 * @description  handling the service call error resposne....
 * @date         03/04/2017
 * @method       getCategoryErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getCategoriesByLocationErrorResponse:(NSString*)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma -mark actions with service calls

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         21/09/2016
 * @method       getPriceLists
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceLists:(NSString *)category {
    
    AudioServicesPlaySystemSound(soundFileObject);
    @try {
        
        [HUD setHidden:NO];
        
        NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
        
        priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        priceListDic[START_INDEX] = NEGATIVE_ONE;
        priceListDic[PRODUCT_CATEGORY] = category;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:priceListDic options:0 error:&err];
        
        NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductsJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.skuServiceDelegate = self;
        [webServiceController getPriceListSkuDetails:getProductsJsonString];
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"no_products_found", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
}


#pragma -mark actions with service calls response

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getPriceListSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        if (successDictionary != nil) {
            
            int  totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_SKUS]  defaultReturn:@"0"]intValue];

            for(NSDictionary * newSkuItemDic in [successDictionary valueForKey:SKU_LIST]) {
                
                //checking priceList is existing or not....
                if([[newSkuItemDic valueForKey:SKU_PRICE_LIST] count]){
                    
                    for(NSDictionary * newSkuPriceListDic in [newSkuItemDic valueForKey:SKU_PRICE_LIST]){
                        
                        BOOL isExistingItem = false;
                        NSDictionary * existItemdic;
                        int i = 0;
                        
                        for ( i=0; i < rawMaterialDetails.count; i++) {
                            
                            //reading the existing cartItem....
                            existItemdic = rawMaterialDetails[i];
                            
                            if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuPriceListDic valueForKey:PLU_CODE]] ) {
                                
                                //&& [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuPriceListDic valueForKey:PLU_CODE]]
                                
                                [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                                
                                rawMaterialDetails[i] = existItemdic;
                                
                                isExistingItem = true;
                                
                                break;
                            }
                        }
                        
//                        if(isExistingItem) {
//
//                            [rawMaterialDetails replaceObjectAtIndex:i withObject:existItemdic];
//                        }
//                        else{
                        
                        if(!isExistingItem) {

                        
                            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                            
                            [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                            
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.0"] forKey:iTEM_PRICE];
                            
                            //setting costPrice for price....
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                            
                            //setting weighted quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:WEIGHTED_QTY];
                            
                            //setting accepted quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ACCEPTED_QTY];
                            
                            //setting quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                            
                            //setting received quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kReceived];
                            
                            //setting rejected quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kRejected];
                            
                            //setting max_quantity quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                            
                            //setting supplied quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kSupplied];
                            
                            //setting productRange....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                            
                            //setting measure Range....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                            
                            //setting Category....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kcategory] defaultReturn:@""] forKey:kcategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                            
                            //reading from superList....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                            
                            //Newly Added Keys on 13/07/2018...By Bhargav as per the service modifications...
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];

                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kPrimaryDepartment] defaultReturn:@""] forKey:kPrimaryDepartment];

                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:SECONDARY_DEPARTMENT] defaultReturn:@""] forKey:SECONDARY_DEPARTMENT];

                            
                            [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

                            [rawMaterialDetails addObject:itemDetailsDic];
                        }
                    }
                }
                else{
                    
                    BOOL isExistingItem = false;
                    NSDictionary * existItemdic;
                    int i = 0;
                    
                    for ( i=0; i < rawMaterialDetails.count; i++) {
                        
                        //reading the existing cartItem....
                        existItemdic = rawMaterialDetails[i];
                        
                        if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuItemDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuItemDic valueForKey:PLU_CODE]]) {
                            
                            [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            
                            rawMaterialDetails[i] = existItemdic;
                            
                            isExistingItem = true;
                            
                            break;
                        }
                    }
                    
                    
//                    if(isExistingItem) {
//
//                        [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
//
//                        [rawMaterialDetails replaceObjectAtIndex:i withObject:existItemdic];
//                    }
//                    else {

                    if(!isExistingItem) {

                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.0"] forKey:iTEM_PRICE];
                        
                        //setting costPrice for price....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                        
                        //setting weighted quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:WEIGHTED_QTY];
                        
                        //setting accepted quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ACCEPTED_QTY];
                        
                        //setting quantity....
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        
                        //setting received quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kReceived];
                        
                        //setting rejected quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kRejected];
                        
                        //setting max_quantity quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                        
                        //setting supplied quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kSupplied];
                        
                        //setting productRange....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        //setting measure Range....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                        
                        //setting Category....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kcategory] defaultReturn:@""] forKey:kcategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        //reading from superList....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                        
                        //Newly Added Keys on 2/08/2017...By Bhargav as per the service modifications...
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kPrimaryDepartment] defaultReturn:@""] forKey:kPrimaryDepartment];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:SECONDARY_DEPARTMENT] defaultReturn:@""] forKey:SECONDARY_DEPARTMENT];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

                        // added by roja on 27-07-2018....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:EAN] defaultReturn:@""] forKey:EAN];

                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                }
            }
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItemTxt.isEditing)
                y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,NSLocalizedString(@"records_are_added_to_the_cart_successfully", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"cart_records", nil) conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

            [self calculateTotal];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [cartTable reloadData];
        [categoriesPopOver dismissPopoverAnimated:YES];
        
    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getSkuDetailsFailureResponse:
 * @author       Bhargav Ram
 * @param       NSString
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSKuDetailsErrorResponse:(NSString *)errorResponse {
    @try {
        [HUD setHidden:YES];
        
        //added by Srinivasulu on 13/04/2017....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
    }
}
#pragma -mark showing next Activities..


/**
 * @description  here we are displaying the popOver to show nextActivities.......
 * @date         20/0/2016
 * @method       showNextAcivities
 * @author       Bhargav.v
 * @param        UIButton
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showNextAcivities:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);

    
    @try {
        int count = 5;
        
        if ((int)nextActivitiesArr.count < count) {
            count = (int) nextActivitiesArr.count;
        }
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, actionReqTxt.frame.size.width, count * 40)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        nextActivityTbl = [[UITableView alloc] init];
        nextActivityTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        nextActivityTbl.dataSource = self;
        nextActivityTbl.delegate = self;
        (nextActivityTbl.layer).borderWidth = 1.0f;
        nextActivityTbl.layer.cornerRadius = 3;
        nextActivityTbl.layer.borderColor = [UIColor grayColor].CGColor;
        nextActivityTbl.separatorColor = [UIColor grayColor];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            nextActivityTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
        }
        
        
        [customView addSubview:nextActivityTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:actionReqTxt.frame inView:stockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver = popover;
            
        }
        
        else {
            
            customerInfoPopUp.preferredContentSize = CGSizeMake(160.0, 250.0);
            
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
        
        [nextActivityTbl reloadData];
        
    }
    @catch (NSException *exception) {
        
        
        
    }
    @finally {
        
    }
    
    
    
}


/**
 * @description  here we are displaying the popOver to show shipmentMode.......
 * @date         20/0/2016
 * @method       getShipmentModes
 * @author       Bhargav.v
 * @param        UIButton
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getShipmentModes {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        shipModesArr = [NSMutableArray new];
        [shipModesArr addObject:NSLocalizedString(@"rail", nil) ];
        [shipModesArr addObject:NSLocalizedString(@"flight", nil) ];
        [shipModesArr addObject:NSLocalizedString(@"express", nil) ];
        [shipModesArr addObject:NSLocalizedString(@"ordinary", nil) ];
        
        int count  = 5 ;
        
        if (shipModesArr.count < count) {
            count = (int) shipModesArr.count;
        }
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, shipmentModeTxt.frame.size.width,count * 45)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        shipModeTable = [[UITableView alloc] init];
        shipModeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        shipModeTable.dataSource = self;
        shipModeTable.delegate = self;
        (shipModeTable.layer).borderWidth = 1.0f;
        shipModeTable.layer.cornerRadius = 3;
        shipModeTable.layer.borderColor = [UIColor grayColor].CGColor;
        shipModeTable.separatorColor = [UIColor grayColor];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            shipModeTable.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
        }
        
        [customView addSubview:shipModeTable];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:shipmentModeTxt.frame inView:stockReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
        }
        
        else {
            
            customerInfoPopUp.preferredContentSize = CGSizeMake(160.0, 250.0);
            
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
        
        [shipModeTable reloadData];
        
    } @catch (NSException *exception) {
        
    }
    
    
}





/**
 * @description  navigating to the super class.......
 * @date         20/0/2016
 * @method       cancelButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)cancelButtonPressed:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self backAction];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}






#pragma mark textField delegates:
/**
 * @description  it is textfiled delegate method it will executed first.......
 * @date         26/09/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @return       BOOL
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



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.frame.origin.x == receivedQtyTxt.frame.origin.x || textField.frame.origin.x == acceptedQtyTxt.frame.origin.x || textField.frame.origin.x == diffQtyText.frame.origin.x || textField.frame.origin.x == scanCodeText.frame.origin.x);
        reloadTableData = false;
    
    return YES;
}


/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav Ram
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
        
        @try {
            
            if(textField == searchItemTxt){
                
                offSetViewTo = 120;
            }
            
            else if (textField.frame.origin.x == receivedQtyTxt.frame.origin.x  || textField.frame.origin.x == acceptedQtyTxt.frame.origin.x ||textField.frame.origin.x == diffQtyText.frame.origin.x || textField.frame.origin.x == scanCodeText.frame.origin.x) {
                
                reloadTableData = true;

                [textField selectAll:nil];
                [UIMenuController sharedMenuController].menuVisible = NO;
                
                int count = (int)textField.tag;
                
                if(textField.tag > 7)
                    
                    count = 7;
                
                offSetViewTo = (textField.frame.origin.y + textField.frame.size.height) * count + cartTable.frame.origin.y + 35;
            }
            
            [self keyboardWillShow];
            
        } @catch (NSException *exception) {
            
        }
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  it is textfiled delegate method it will to enable the numerical characters  shouldChangeCharactersInRange .......
 * @date         26/09/2016
 * @method       shouldChangeCharactersInRange:
 * @author       Bhargav Ram
 * @param        UITextField
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.frame.origin.x == receivedQtyTxt.frame.origin.x || textField.frame.origin.x == acceptedQtyTxt.frame.origin.x ||  textField.frame.origin.x == diffQtyText.frame.origin.x ) {
        
        @try {
            
            NSString * newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
            NSError  * error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
            return numberOfMatches != 0;
            
        } @catch (NSException *exception) {
            
            NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            
            return  YES;
        }
    }
    return  YES;
}



/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
 * @date         26/09/2016
 * @method       textFieldDidChange:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @return       BOOL
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 * @return
 * @return
 * @verified By
 * @verified On
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchItemTxt) {
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                if (searchItemTxt.tag == 0) {
                    
                    searchItemTxt.tag = (textField.text).length;
                    
                    productListArr = [[NSMutableArray alloc]init];
                    
                    [self callRawMaterials:textField.text];
                }
                
                else {
                    
                    [HUD setHidden:YES];
                    [catPopOver dismissPopoverAnimated:YES];
                }
                
            } @catch (NSException *exception) {
                
            }
        }
        
        else {
            [HUD setHidden:YES];
            searchItemTxt.tag = 0;
            [catPopOver dismissPopoverAnimated:YES];
        }
    }
    else if(textField.frame.origin.x == receivedQtyTxt.frame.origin.x){
        
        @try {
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            float issuedQty = [[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
            float receivedQty = (textField.text).floatValue;

            [temp setValue:[NSString stringWithFormat:@"%.2f",(issuedQty - receivedQty)] forKey:kRejected];
            [temp setValue:textField.text  forKey:kReceived];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
    }
    
    else if(textField.frame.origin.x == acceptedQtyTxt.frame.origin.x){
        
        @try {
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:ACCEPTED_QTY];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    else if (textField.frame.origin.x == diffQtyText.frame.origin.x) {
        
        @try {
            
            //NSMutableDictionary * temp = [[rawMaterialDetails objectAtIndex:textField.tag]  mutableCopy];
            //[temp setValue:textField.text  forKey:kReceived];
            //[temp setValue:[NSString stringWithFormat:@"%.2f", ([textField.text floatValue] - [[temp valueForKey:ACCEPTED_QTY] floatValue])] forKey:kRejected];
            //[rawMaterialDetails replaceObjectAtIndex:textField.tag withObject:temp];
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:kRejected];
            
            rawMaterialDetails[textField.tag] = temp;
            
        }
        @catch (NSException *exception) {
            
        }
    }
    else if(textField.frame.origin.x == scanCodeText.frame.origin.x) {
        
        @try {
            NSMutableDictionary * dic =  [rawMaterialDetails[textField.tag] mutableCopy];
            
            [dic setValue:textField.text  forKey:ITEM_SCAN_CODE];
            rawMaterialDetails[textField.tag] = dic;
        }
        @catch(NSException * exception) {
            
        }
    }
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
 * @date         26/09/2016
 * @method       textFieldDidEndEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    offSetViewTo = 0;
    
    if (textField.frame.origin.x == receivedQtyTxt.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            float issuedQty = [[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
            float receivedQty = (textField.text).floatValue;
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",(issuedQty - receivedQty)] forKey:kRejected];
            [temp setValue:textField.text  forKey:kReceived];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        
        @catch (NSException *exception) {
       
        }
        @finally {
            
            if(reloadTableData)
                [cartTable reloadData];
            [self calculateTotal];
        }
    }
    
    else if (textField.frame.origin.x == acceptedQtyTxt.frame.origin.x){
        
        @try {
            
            //NSMutableDictionary *temp = [[rawMaterialDetails objectAtIndex:textField.tag]  mutableCopy];
            //[temp setValue:textField.text  forKey:ACCEPTED_QTY];
            //[temp setValue:[NSString stringWithFormat:@"%.2f", ([[temp valueForKey:kReceived] floatValue] - [textField.text floatValue])] forKey:kRejected];
            //[rawMaterialDetails replaceObjectAtIndex:textField.tag withObject:temp];
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:ACCEPTED_QTY];
            
            rawMaterialDetails[textField.tag] = temp;

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            if(reloadTableData)
                [cartTable reloadData];
            [self calculateTotal];
            
        }
    }
    else if (textField.frame.origin.x == diffQtyText.frame.origin.x){
        
        @try {
            
            //NSMutableDictionary *temp = [[rawMaterialDetails objectAtIndex:textField.tag]  mutableCopy];
            //[temp setValue:textField.text  forKey:kReceived];
            //[temp setValue:[NSString stringWithFormat:@"%.2f", ( [textField.text floatValue] - [[temp valueForKey:ACCEPTED_QTY] floatValue] )] forKey:kRejected];
            //[rawMaterialDetails replaceObjectAtIndex:textField.tag withObject:temp];
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:kRejected];
            
            rawMaterialDetails[textField.tag] = temp;

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            if(reloadTableData)
                [cartTable reloadData];
            [self calculateTotal];
        }
    }
    
    else if(textField.frame.origin.x == scanCodeText.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary * dic =  [rawMaterialDetails[textField.tag] mutableCopy];
            [dic setValue:textField.text  forKey:ITEM_SCAN_CODE];
            rawMaterialDetails[textField.tag] = dic;
            
        }
        @catch(NSException * exception) {
            
        }
        
        if(reloadTableData)
            [cartTable reloadData];
    }
}



/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldShouldReturn:
 * @author       Bhargav
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


#pragma mark TableView Delegates:

/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (tableView == cartTable || tableView == priceTable ||  tableView == skListTable  ||tableView == nextActivityTbl || tableView == shipModeTable || tableView == categoriesTbl) {
        return 40;
    }
    else
        return 55;
}


/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date         26/09/2016
 * @method       numberOfRowsInSection:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == cartTable) {
        
        
        @try {
            
            [self calculateTotal];
            
        } @catch (NSException * exception) {
            NSLog( @"---%@",exception);
        }
        
        return  rawMaterialDetails.count;
    }
    else if (tableView == skListTable){
        return productListArr.count;
    }
    
    else if (tableView == nextActivityTbl){
        return nextActivitiesArr.count;
    }
    else if (tableView == shipModeTable){
        return shipModesArr.count;
    }
    else if (tableView == priceTable) {
        return priceDic.count;
    }
    else if (tableView == categoriesTbl) {
        return categoriesArr.count;
    }
    return false;
}


/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         26/09/2016
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 * @return       UITableViewCell
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section and populating the data into labels....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == skListTable) {
        
        //changed by Bhargav.v  on 12/2/2018....
        UITableViewCell * hlcell;
        
        @try {
            
            static NSString * hlCellID = @"hlCellID";
            
            hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
            
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
            
            //  NSDictionary *dic = [priceDic objectAtIndex:indexPath.row];
            
            UILabel * itemDescLbl;
            UILabel * itemPriceLbl;
            UILabel * itemQtyInHandLbl;
            UILabel * itemColorLbl;
            UILabel * itemSizeLbl;
            UILabel * itemMeasurementLbl;
            
            itemDescLbl = [[UILabel alloc] init] ;
            itemDescLbl.layer.borderWidth = 1.5;
            itemDescLbl.font = [UIFont systemFontOfSize:13.0];
            itemDescLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemDescLbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemDescLbl.textColor = [UIColor blackColor];
            itemDescLbl.textAlignment=NSTextAlignmentLeft;
            
            itemPriceLbl = [[UILabel alloc] init] ;
            itemPriceLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemPriceLbl.layer.borderWidth = 1.5;
            itemPriceLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemPriceLbl.textAlignment = NSTextAlignmentCenter;
            itemPriceLbl.numberOfLines = 2;
            itemPriceLbl.textColor = [UIColor blackColor];
            
            itemQtyInHandLbl = [[UILabel alloc] init] ;
            itemQtyInHandLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemQtyInHandLbl.layer.borderWidth = 1.5;
            itemQtyInHandLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemQtyInHandLbl.textAlignment = NSTextAlignmentCenter;
            itemQtyInHandLbl.numberOfLines = 2;
            itemQtyInHandLbl.textColor = [UIColor blackColor];
            
            itemColorLbl = [[UILabel alloc] init] ;
            itemColorLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemColorLbl.layer.borderWidth = 1.5;
            itemColorLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemColorLbl.textAlignment = NSTextAlignmentCenter;
            itemColorLbl.numberOfLines = 2;
            itemColorLbl.textColor = [UIColor blackColor];
            
            itemSizeLbl = [[UILabel alloc] init] ;
            itemSizeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemSizeLbl.layer.borderWidth = 1.5;
            itemSizeLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemSizeLbl.textAlignment = NSTextAlignmentCenter;
            itemSizeLbl.numberOfLines = 2;
            itemSizeLbl.textColor = [UIColor blackColor];
            
            itemMeasurementLbl = [[UILabel alloc] init] ;
            itemMeasurementLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemMeasurementLbl.layer.borderWidth = 1.5;
            itemMeasurementLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemMeasurementLbl.textAlignment = NSTextAlignmentCenter;
            itemMeasurementLbl.numberOfLines = 2;
            itemMeasurementLbl.textColor = [UIColor blackColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (productListArr.count > indexPath.row){
                NSDictionary * dic = productListArr[indexPath.row];
                
                
                if([dic isKindOfClass:[NSDictionary class]]){
                    
                    itemDescLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                    itemPriceLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]];
                    
                    itemQtyInHandLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]];
                    itemColorLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@"--"];
                    itemSizeLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""];
                    itemMeasurementLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""];
                }
            }
            
            
            else {
                
                itemDescLbl.text = @"";
                itemPriceLbl.text = @"";
                itemQtyInHandLbl.text = @"";
                itemColorLbl.text = @"";
                itemSizeLbl.text = @"";
                itemMeasurementLbl.text = @"";
            }
            
            if(!(itemQtyInHandLbl.text).length)
                itemQtyInHandLbl.text = @"--";
            if(!(itemColorLbl.text).length)
                itemColorLbl.text = @"--";
            if(!(itemSizeLbl.text).length)
                itemSizeLbl.text = @"--";
            if(!(itemMeasurementLbl.text).length)
                itemMeasurementLbl.text = @"--";
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                itemDescLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemPriceLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemQtyInHandLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemColorLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemSizeLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemMeasurementLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                }
                else {
                    
                }
                
                itemDescLbl.frame = CGRectMake(0, 0, 300, 50);
                itemPriceLbl.frame = CGRectMake( itemDescLbl.frame.origin.x + itemDescLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemQtyInHandLbl.frame = CGRectMake( itemPriceLbl.frame.origin.x + itemPriceLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemColorLbl.frame = CGRectMake( itemQtyInHandLbl.frame.origin.x + itemQtyInHandLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemSizeLbl.frame = CGRectMake( itemColorLbl.frame.origin.x + itemColorLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemMeasurementLbl.frame = CGRectMake( itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width, 0, searchItemTxt.frame.size.width - (itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width), itemDescLbl.frame.size.height);
            }
            else {
                
                itemDescLbl.frame = CGRectMake(5, 0, 130, 34);
                itemPriceLbl.frame = CGRectMake(135, 0, 70, 34);
            }
            
            
            //[hlcell setBackgroundColor:[UIColor clearColor]];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemPriceLbl];
            [hlcell.contentView addSubview:itemQtyInHandLbl];
            [hlcell.contentView addSubview:itemColorLbl];
            [hlcell.contentView addSubview:itemSizeLbl];
            [hlcell.contentView addSubview:itemMeasurementLbl];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        @finally{
            
            return hlcell;
        }
    }
    else if (tableView == cartTable) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        CAGradientLayer * layer_1;
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            @try {
                layer_1 = [CAGradientLayer layer];
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_1.frame = CGRectMake(sNoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(sNoLbl.frame.origin.x), 1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException * exception) {
                
            }
        }
        
        @try {
            
            
            //labels used in table row....
            UILabel * itemNoLbl;
            UILabel * itemSkuIdLbl;
            UILabel * itemDescLbl;
            UILabel * itemUomLbl;
            UILabel * requested_QtyLbl;
            UILabel * issueQty_Lbl;
            
            
            
            itemNoLbl = [[UILabel alloc] init];
            itemNoLbl.backgroundColor = [UIColor clearColor];
            itemNoLbl.layer.borderWidth = 0;
            itemNoLbl.textAlignment = NSTextAlignmentCenter;
            itemNoLbl.numberOfLines = 2;
            itemNoLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemSkuIdLbl = [[UILabel alloc] init];
            itemSkuIdLbl.backgroundColor = [UIColor clearColor];
            itemSkuIdLbl.layer.borderWidth = 0;
            itemSkuIdLbl.textAlignment = NSTextAlignmentCenter;
            itemSkuIdLbl.numberOfLines = 1;
            itemSkuIdLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemDescLbl = [[UILabel alloc] init];
            itemDescLbl.backgroundColor = [UIColor clearColor];
            itemDescLbl.layer.borderWidth = 0;
            itemDescLbl.textAlignment = NSTextAlignmentCenter;
            itemDescLbl.numberOfLines = 1;
            itemDescLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemUomLbl = [[UILabel alloc] init];
            itemUomLbl.backgroundColor = [UIColor clearColor];
            itemUomLbl.layer.borderWidth = 0;
            itemUomLbl.textAlignment = NSTextAlignmentCenter;
            itemUomLbl.numberOfLines = 1;
            itemUomLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            requested_QtyLbl = [[UILabel alloc] init];
            requested_QtyLbl.backgroundColor = [UIColor clearColor];
            requested_QtyLbl.layer.borderWidth = 0;
            requested_QtyLbl.textAlignment = NSTextAlignmentCenter;
            requested_QtyLbl.numberOfLines = 1;
            requested_QtyLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            issueQty_Lbl = [[UILabel alloc] init];
            issueQty_Lbl.backgroundColor = [UIColor clearColor];
            issueQty_Lbl.layer.borderWidth = 0;
            issueQty_Lbl.textAlignment = NSTextAlignmentCenter;
            issueQty_Lbl.numberOfLines = 1;
            issueQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            receivedQtyTxt = [[UITextField alloc] init];
            receivedQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            receivedQtyTxt.textColor = [UIColor blackColor];
            receivedQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            receivedQtyTxt.layer.borderWidth = 1.0;
            receivedQtyTxt.textAlignment = NSTextAlignmentCenter;
            receivedQtyTxt.backgroundColor = [UIColor clearColor];
            receivedQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            receivedQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            receivedQtyTxt.returnKeyType = UIReturnKeyDone;
            receivedQtyTxt.tag = indexPath.row;
            receivedQtyTxt.delegate = self;
            [receivedQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            acceptedQtyTxt = [[UITextField alloc] init];
            acceptedQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            acceptedQtyTxt.textColor = [UIColor blackColor];
            acceptedQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            acceptedQtyTxt.layer.borderWidth = 1.0;
            acceptedQtyTxt.textAlignment = NSTextAlignmentCenter;
            acceptedQtyTxt.backgroundColor = [UIColor clearColor];
            acceptedQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            acceptedQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            acceptedQtyTxt.returnKeyType = UIReturnKeyDone;
            acceptedQtyTxt.tag = indexPath.row;
            acceptedQtyTxt.delegate = self;
            acceptedQtyTxt.userInteractionEnabled = NO;
            [acceptedQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            diffQtyText = [[UITextField alloc] init];
            diffQtyText.borderStyle = UITextBorderStyleRoundedRect;
            diffQtyText.textColor = [UIColor blackColor];
            diffQtyText.keyboardType = UIKeyboardTypeNumberPad;
            diffQtyText.layer.borderWidth = 1.0;
            diffQtyText.textAlignment = NSTextAlignmentCenter;
            diffQtyText.backgroundColor = [UIColor clearColor];
            diffQtyText.autocorrectionType = UITextAutocorrectionTypeNo;
            diffQtyText.clearButtonMode = UITextFieldViewModeWhileEditing;
            diffQtyText.returnKeyType = UIReturnKeyDone;
            diffQtyText.tag = indexPath.row;
            diffQtyText.delegate = self;
            [diffQtyText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            
            scanCodeText = [[UITextField alloc] init];
            scanCodeText.borderStyle = UITextBorderStyleRoundedRect;
            scanCodeText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            scanCodeText.keyboardType = UIKeyboardTypeNumberPad;
            scanCodeText.layer.borderWidth = 1.0;
            scanCodeText.backgroundColor = [UIColor clearColor];
            scanCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
            scanCodeText.clearButtonMode = UITextFieldViewModeWhileEditing;
            scanCodeText.returnKeyType = UIReturnKeyDone;
            scanCodeText.delegate = self;
            scanCodeText.textAlignment = NSTextAlignmentCenter;
            scanCodeText.tag = indexPath.row;
            scanCodeText.userInteractionEnabled = YES;
            scanCodeText.placeholder = NSLocalizedString(@"item_code",nil);
            scanCodeText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:scanCodeText.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
            
            [scanCodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

            
            moreBtn = [[UIButton alloc] init];
            //moreBtn.backgroundColor = [UIColor blackColor];
            moreBtn.titleLabel.textColor = [UIColor whiteColor];
            moreBtn.tag = indexPath.row;
            [moreBtn addTarget:self action:@selector(showMoreInfoPopUp:) forControlEvents:UIControlEventTouchUpInside];
            
            delrowbtn = [[UIButton alloc] init];
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            if([submitBtn.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ){
            
                receivedQtyTxt.userInteractionEnabled = NO;
                
                diffQtyText.userInteractionEnabled = NO;
                scanCodeText.userInteractionEnabled = NO;
               
                delrowbtn.userInteractionEnabled = NO;
                moreBtn.userInteractionEnabled = NO;
                
            }
            else {
                
                receivedQtyTxt.userInteractionEnabled = YES;
               
                if(isHubLevel) {
                    
                    acceptedQtyTxt.userInteractionEnabled = YES;
                }

                diffQtyText.userInteractionEnabled  = YES;
                scanCodeText.userInteractionEnabled = YES;

                delrowbtn.userInteractionEnabled = YES;
                moreBtn.userInteractionEnabled = YES;
            }
            
            itemNoLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemSkuIdLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemDescLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemUomLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            requested_QtyLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            issueQty_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            
            receivedQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            acceptedQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            diffQtyText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            scanCodeText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemNoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemSkuIdLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemDescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemUomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            requested_QtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            issueQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            receivedQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            acceptedQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            diffQtyText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            scanCodeText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

            
            //added by Srinivasulu on 27/05/2017....
            
            [moreBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
            
            //upto here on 27/05/2017....
            
            
            [hlcell.contentView addSubview:itemNoLbl];
            [hlcell.contentView addSubview:itemSkuIdLbl];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemUomLbl];
            [hlcell.contentView addSubview:requested_QtyLbl];
            [hlcell.contentView addSubview:issueQty_Lbl];
            [hlcell.contentView addSubview:receivedQtyTxt];
            [hlcell.contentView addSubview:acceptedQtyTxt];
            [hlcell.contentView addSubview:diffQtyText];
            [hlcell.contentView addSubview:scanCodeText];

            
            //added by Srinivasulu on 27/05/2017....
            [hlcell.contentView addSubview:moreBtn];
            
            [hlcell.contentView addSubview:delrowbtn];
            
            //upto here on 27/05/2017....
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                itemNoLbl.frame = CGRectMake(sNoLbl.frame.origin.x, 0, sNoLbl.frame.size.width, hlcell.frame.size.height);
                
                itemSkuIdLbl.frame = CGRectMake(sKuidLbl.frame.origin.x, 0, sKuidLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemDescLbl.frame = CGRectMake(descLbl.frame.origin.x, 0, descLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemUomLbl.frame = CGRectMake(uomLbl.frame.origin.x, 0,uomLbl.frame.size.width,  hlcell.frame.size.height);
                
                requested_QtyLbl.frame = CGRectMake(requestedQtyLbl.frame.origin.x, 0,requestedQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                issueQty_Lbl.frame = CGRectMake(issuedQtyLbl.frame.origin.x, 0,issuedQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                receivedQtyTxt.frame = CGRectMake(receivedQtyLabel.frame.origin.x,2,receivedQtyLabel.frame.size.width - 2,36);
                
                acceptedQtyTxt.frame = CGRectMake(acceptedQtyLbl.frame.origin.x,2,acceptedQtyLbl.frame.size.width - 2,36);
                
                diffQtyText.frame = CGRectMake(diffQtyLabel.frame.origin.x,2,diffQtyLabel.frame.size.width - 2,36);
               
                scanCodeText.frame = CGRectMake(itemScanCodeLabel.frame.origin.x,2,itemScanCodeLabel.frame.size.width - 2,36);

                moreBtn.frame =CGRectMake(actionLbl.frame.origin.x,0,actionLbl.frame.size.width-45,40);
                
                delrowbtn.frame =CGRectMake(actionLbl.frame.origin.x + actionLbl.frame.size.width-45,5,35,35);
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];

                //upto here on 27/05/2017....
            }
            else {
                
            }
            @try {
                
                [moreBtn setTitle:NSLocalizedString(@"more", nil) forState:UIControlStateNormal];
                
                if(rawMaterialDetails.count > indexPath.row){
                    
                    NSMutableDictionary * temp = [rawMaterialDetails[indexPath.row] mutableCopy];
                    
                    itemNoLbl.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1) ];
                    
                    itemSkuIdLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SKU]  defaultReturn:@""];
                    
                    itemDescLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_DESCRIPTION]  defaultReturn:@""];
                    
                    itemUomLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:SELL_UOM]  defaultReturn:@""];
                    
                    //commented as per the UIModifications..
                    //itemPriceLbl.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_UNIT_PRICE]  defaultReturn:@"0.00"] floatValue])];
                    
                    //populating the quantities into textFields....
                    requested_QtyLbl.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY]  defaultReturn:@"0.00"] floatValue])];
                    
                    issueQty_Lbl.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY]  defaultReturn:@"0.00"] floatValue])];
                    
                    receivedQtyTxt.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:kReceived]  defaultReturn:@"0.00"] floatValue])];
                    
                    acceptedQtyTxt.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:ACCEPTED_QTY]  defaultReturn:@"0.00"] floatValue])];
                    
                    //[temp setObject:[NSString stringWithFormat:@"%.2f", ([issueQty_Lbl.text floatValue] - [receivedQtyTxt.text floatValue])]  forKey:kRejected];
                    //[rawMaterialDetails replaceObjectAtIndex:indexPath.row withObject:temp];
                    
                    diffQtyText.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:kRejected]  defaultReturn:@"0.00"] floatValue])];
                    
                    scanCodeText.text  = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SCAN_CODE] defaultReturn:@"--"];

                    
                }
            }
            @catch (NSException * exception) {
                
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
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
            [HUD setHidden:YES];
            NSDictionary *dic = priceDic[indexPath.row];
            
            UILabel *skid = [[UILabel alloc] init] ;
            skid.layer.borderWidth = 1.5;
            skid.font = [UIFont systemFontOfSize:13.0];
            skid.font = [UIFont fontWithName:TEXT_FONT_NAME size:13];
            skid.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            skid.backgroundColor = [UIColor blackColor];
            skid.textColor = [UIColor whiteColor];
            skid.text = [dic valueForKey:kDescription];
            skid.textAlignment=NSTextAlignmentCenter;
            //            skid.adjustsFontSizeToFitWidth = YES;
            
            UILabel *mrpPrice = [[UILabel alloc] init] ;
            mrpPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            mrpPrice.layer.borderWidth = 1.5;
            mrpPrice.backgroundColor = [UIColor blackColor];
            mrpPrice.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:SALE_PRICE] floatValue]];
            mrpPrice.textAlignment = NSTextAlignmentCenter;
            mrpPrice.numberOfLines = 2;
            mrpPrice.textColor = [UIColor whiteColor];
            
            UILabel *price = [[UILabel alloc] init] ;
            price.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            price.layer.borderWidth = 1.5;
            price.backgroundColor = [UIColor blackColor];
            price.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kPrice] floatValue]];
            price.textAlignment = NSTextAlignmentCenter;
            price.numberOfLines = 2;
            price.textColor = [UIColor whiteColor];
            // name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:skid];
            [hlcell.contentView addSubview:price];
            [hlcell.contentView addSubview:mrpPrice];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                
                skid.frame = CGRectMake( 0, 0, descLabl.frame.size.width + 1, hlcell.frame.size.height);
                
                skid.font = [UIFont systemFontOfSize:22];
                
                mrpPrice.frame = CGRectMake(skid.frame.origin.x + skid.frame.size.width, 0, mrpLbl.frame.size.width + 2,  hlcell.frame.size.height);
                
                mrpPrice.font = [UIFont systemFontOfSize:22];
                
                price.font = [UIFont systemFontOfSize:22];
                price.frame = CGRectMake(mrpPrice.frame.origin.x + mrpPrice.frame.size.width, 0, priceLbl.frame.size.width+2, hlcell.frame.size.height);
                
            }
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        }
        return hlcell;
    }

    else if(tableView == nextActivityTbl) {
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
            hlcell.textLabel.text = nextActivitiesArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } @catch (NSException *exception) {
        
        }
        
        return hlcell;
    }
    else if (tableView == shipModeTable) {
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
            hlcell.textLabel.text = shipModesArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;

        } @catch (NSException *exception) {
        }
        return hlcell;
        
    }
    else if (tableView == categoriesTbl) {
        @try {
            
            static NSString * hlCellID = @"hlCellID";
            UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
            
            
            if ((hlcell.contentView).subviews){
                
                for (UIView * subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
                hlcell.accessoryType = UITableViewCellAccessoryNone;
            }
            tableView.separatorColor = [UIColor clearColor];
            
            checkBoxsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage * checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
            [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            
            if( checkBoxArr.count && categoriesArr.count){
                if([checkBoxArr[indexPath.row] integerValue])
                    checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                checkBoxsBtn.userInteractionEnabled = YES;
            }
            
            [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            checkBoxsBtn.tag = indexPath.row;
            
            [checkBoxsBtn addTarget:self action:@selector(changeCheckBoxImages:) forControlEvents:UIControlEventTouchUpInside];
            
            [hlcell.contentView addSubview:checkBoxsBtn];
            
            checkBoxsBtn.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x, 7, 30 , 30);
            
            //upto here on 07/03/2017....
            
            UILabel * categoryLbl = [[UILabel alloc] init];
            categoryLbl.backgroundColor = [UIColor clearColor];
            categoryLbl.numberOfLines = 1;
            categoryLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            categoryLbl.textColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                categoryLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                categoryLbl.frame = CGRectMake(checkBoxsBtn.frame.origin.x+checkBoxsBtn.frame.size.width+15, checkBoxsBtn.frame.origin.y-5,280,40);
            }
            
            categoryLbl.textAlignment = NSTextAlignmentLeft;
            categoryLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
            
            [hlcell.contentView addSubview:checkBoxsBtn];
            [hlcell.contentView addSubview:categoryLbl];
            
            @try {
                
                if( categoriesArr.count > indexPath.row){
                    categoryLbl.text  = categoriesArr[indexPath.row];
                }
            } @catch (NSException *exception) {
                
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Play Audio for Button touch....
    AudioServicesPlaySystemSound (soundFileObject);
   
    //dismiss popver after selectoion...
    [catPopOver dismissPopoverAnimated:YES];
    
     @try {
        if (tableView == skListTable) {
            
            //Changes Made Bhargav.v on 11/05/2018...
            //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
            //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
            
            NSDictionary * detailsDic = productListArr[indexPath.row];
            
            NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[SKUID]];
            
            if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
                
                inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
            }
            
            [self callRawMaterialDetails:inputServiceStr];
            
            searchItemTxt.text = @"";
            [searchItemTxt resignFirstResponder];
        }
        
        else if(tableView == nextActivityTbl){
            
            
            @try {
                if(indexPath.row == 0)
                    actionReqTxt.text = @"";
                else
                    actionReqTxt.text = nextActivitiesArr[indexPath.row];
                
            } @catch (NSException *exception) {
                
                NSLog(@"----exception changing the textField text in didSelectRowAtIndexPath:----%@",exception);
            }
        }
        
        else if (tableView == shipModeTable) {
            
            shipmentModeTxt.text = shipModesArr[indexPath.row];
            
            [catPopOver dismissPopoverAnimated:YES];
        }
//        else if (tableView == categoriesTbl) {
//            
//            [categoriesPopOver dismissPopoverAnimated:YES];
//            
//            @try {
//                
//                NSString * categoryStr = [categoriesArr objectAtIndex:indexPath.row];
//                
//                [HUD show:YES];
//                
//                [HUD setHidden:NO];
//                HUD.labelText = @"Loading Please Wait..";
//                [self getPriceLists:categoryStr];
//            }
//            @catch (NSException *exception) {
//                
//            }
//            @finally {
//                
//            }
//        }
        
        else if (tableView == priceTable) {
            
            //added by Srinivasulu on 14/04/2017....
            //added exception handling....
            @try {
                
                transparentView.hidden = YES;
                
                NSDictionary *detailsDic = priceDic[indexPath.row];
                
                
                BOOL status = FALSE;
                
                int i=0;
                NSMutableDictionary *dic;
                
                for ( i=0; i<rawMaterialDetails.count;i++) {
                    
                    dic = rawMaterialDetails[i];
                    if ([[dic valueForKey:ITEM_SKU] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]]) {
                        
                        //setting supplied quantity....
                        [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kMaxQuantity] intValue] + 1] forKey:kMaxQuantity];
                        
                        [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kSupplied] intValue] + 1] forKey:kSupplied];
                        
                        //setting accepted quantity....
                        [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:ACCEPTED_QTY] intValue] + 1] forKey:ACCEPTED_QTY];
                        
                        //setting received quantity....
                        [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kReceived] intValue] + 1] forKey:kReceived];
                        
                        rawMaterialDetails[i] = dic;
                        
                        status = TRUE;
                        break;
                    }
                }
                
                if (!status) {
                    NSDictionary *itemdic = detailsDic;
                    
                    NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
                    
                    //setting skuId....
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                    
                    [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                    
                    
                    //setting plucode....
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PLU_CODE] defaultReturn:[itemDetailsDic valueForKey:ITEM_SKU]] forKey:PLU_CODE];
                    
                    //setting itemDescription....
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                    
                    //setting itemPrice as salePrice...  SALE_PRICE .... costPrice
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                    
                    //setting itemPrice as salePrice...  SALE_PRICE .... costPrice
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:ITEM_UNIT_PRICE] floatValue]] forKey:iTEM_PRICE];
                    
                    
                    //setting --------- quantity-----used as requested/indented Qty....
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                    
                    //setting supplied quantity....
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kSupplied];
                    
                    //added by Srinivasulu on 18/04/2017.....
                    //setting this property eliminate the crash....
                    
                    [itemDetailsDic setValue:@"1" forKey:kSupplied];
                    
                    //upto here on 18/04/2017....
                    
                    
                    //setting weighted quantity....
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:WEIGHTED_QTY];
                    
                    //setting accepted quantity....
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ACCEPTED_QTY];
                    
                    //setting received quantity....
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kReceived];
                    
                    //setting rejected quantity....
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kRejected];
                    
                    
                    
                    //added by Srinivasulu on 13/04/2017.....
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductSubCategory] defaultReturn:@""] forKey:kProductSubCategory];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductRange] defaultReturn:@""] forKey:kProductRange];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                    
                    
                    //newly added keys....
                    //added by  Srinivasulu on  14/04/2017....
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                    
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                    
                    
                    //upto here on 13/04/2017.....
                    
                    
                    [rawMaterialDetails addObject:itemDetailsDic];
                    
                }
                
                else
                    rawMaterialDetails[i] = dic;
                
                cartTable.hidden = NO;
                
                [cartTable reloadData];
                
                [self calculateTotal];
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}


#pragma -mark calculationTotal

/**
 * @description  here we are calculating the Totalprice of order..........
 * @date         27/09/2016
 * @method       calculateTotal
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * Changes made on 1/11/2017...
 */

-(void)calculateTotal{
    
    @try {
        float reqQuantity = 0.0;
        float issueQty    = 0.0;
        float receivedQty = 0.0;
        float aceptedQty  = 0.0;
        float diffQty     = 0.0;
        
        for(NSDictionary * dic in rawMaterialDetails){
            
            reqQuantity += [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]floatValue];
            issueQty    += [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]floatValue];
            receivedQty += [[self checkGivenValueIsNullOrNil:[dic valueForKey:kReceived] defaultReturn:@"0.00"]floatValue];
            aceptedQty  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:ACCEPTED_QTY] defaultReturn:@"0.00"]floatValue];
            diffQty     += [[self checkGivenValueIsNullOrNil:[dic valueForKey:kRejected] defaultReturn:@"0.00"]floatValue];
        }
        
        requestQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",reqQuantity];
        issueQtyValueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@"",issueQty];
        receivedQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",receivedQty];
        acceptedQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",aceptedQty];
        diffQtyValueLabel.text   = [NSString stringWithFormat:@"%@%.2f",@"",diffQty];
        
    } @catch (NSException * exception) {
        
        NSLog(@"---exception in while calculating the totalValue--%@",exception);
        
    } @finally {
        
    }
}

/**
 * @description  here we are deleting the item from list....
 * @date
 * @method       delRow:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On

 */

- (void)delRow:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
   
    @try {
        
        if(rawMaterialDetails.count >= sender.tag){
            
            
            [rawMaterialDetails removeObjectAtIndex:sender.tag];
            [cartTable reloadData];
            
        }
        
    } @catch (NSException *exception) {
        NSLog(@"-----exception is --------%@",exception);
    } @finally {
        
    }
    
}


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
 * @description  here we are calling the showMOreInfoPopUP:
 * @date         31/06/2017....
 * @method       showMoreInfoPopUp:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showMoreInfoPopUp:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

        
    } @catch (NSException *exception) {
        
    }
}



#pragma mark key board methods:

/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       setViewMovedUp
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)setViewMovedUp:(BOOL)movedUp {
    
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
    }
}




/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       keyboardWillShow
 * @author       Bhargav
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
 * @author       Bhargav
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

#pragma -mark reusableMethods.......
/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         21/09/2016
 * @method       showPopUpForTables:-- popUpWidth:-- popUpHeight:-- presentPopUpAt:-- showViewIn:--
 * @author       Srinivasulu
 * @param        UITableView
 * @param        float
 * @param        float
 * @param        id
 * @param        id
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view {
    
    @try {
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height > height) ){
            catPopOver.popoverContentSize =  CGSizeMake(width, height);
            
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
        
        
        //tableName = [[UITableView alloc]init];
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
            
            [popover presentPopoverFromRect:textView.frame inView:view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            customerInfoPopUp.preferredContentSize = CGSizeMake(160.0, 250.0);
            
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines{
    
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
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame || [messageType isEqualToString:@"CART_RECORDS"]) {
            
            if([messageType isEqualToString:@"CART_RECORDS"]) {
                
                userAlertMessageLbl.tag = 2;
                
            }
            else
                
                userAlertMessageLbl.tag = 4;
            
            userAlertMessageLbl.textColor = [UIColor blackColor];
            
           
            if(soundStatus) {
                
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        else {
            
            userAlertMessageLbl.textColor = [UIColor blackColor];
            
            if(soundStatus){
                SystemSoundID    soundFileObject1;
                NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if(searchItemTxt.isEditing)
                yPosition = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
            
            
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

/*
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

-(void)removeAlertMessages {
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

#pragma -mark action used to hide the price list view....


/**
 * @description  here we are hidding the transperentView....
 * @date
 * @method       closePriceView:
 * @author
 * @param        UIButton
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 15/04/2017...
 * @reason      added comments && added the expansion handling....
 *
 */

-(void)closePriceView:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);

    @try {
        
        transparentView.hidden = YES;
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"---- exception in closePriceView () -- in EditStockReceipt ----");
        NSLog(@"----%@",exception);
    }
}


#pragma -mark superClass methods....


/**
 * @description  here we are navigating to homePage....
 * @date
 * @method       homeButonClicked
 * @author
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 15/04/2017...
 * @reason      added comments && added the expansion handling....
 *
 */

-(void)homeButonClicked {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);

    @try {
        
        OmniHomePage *home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:YES];
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception in homeButonclicked () -- in EditStockReceipt ----");
        NSLog(@"----%@",exception);
        
    }
}

/**
 * @description  here we are calling backAction()....
 * @date
 * @method       goToHome()
 * @author
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 15/04/2017...
 * @reason      added comments && added the expansion handling....
 *
 */

-(void)goToHome {
    
    @try {
        
        [self backAction];
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception in goToHome () -- in EditStockReceipt ----");
        NSLog(@"----%@",exception);
        
    }
}

/**
 * @description  here we are calling backAction()....
 * @date
 * @method       goToHome()
 * @author
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 15/04/2017...
 * @reason      added comments && added the expansion handling....
 *
 */

- (void)backAction {

    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception in backAction () -- in EditStockReceipt ----");
        NSLog(@"----%@",exception);
        
    }
}



/**
 * @description        here we are displaying the popOver for the CategoriesList ...
 * @requestDteFld      27/09/2016
 * @method             displayCategoriesList
 * @author             Bhargav.v
 * @param              UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */




-(void)displayCategoriesList:(UIButton*)sender{
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        PopOverViewController * categoriesPopover = [[PopOverViewController alloc] init];
        
        categoriesView = [[UIView alloc] initWithFrame:CGRectMake(selectCategoriesBtn.frame.origin.x,searchItemTxt.frame.origin.y,300,350)];
        categoriesView.opaque = NO;
        categoriesView.backgroundColor = [UIColor blackColor];
        categoriesView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6].CGColor;
        categoriesView.layer.borderWidth =2.0f;
        [categoriesView setHidden:NO];
        
        /*Creation of UILabel for headerDisplay.......*/
        //creating line  UILabel which will display at topOfThe  billingView.......
        
        UILabel  * headerNameLbl;
        CALayer  * bottomBorder;
        UIImage  * checkBoxImg;
        UILabel  * selectAllLbl;
        UIButton * okButton;
        UIButton * cancelBtn;
        
        headerNameLbl = [[UILabel alloc] init];
        headerNameLbl.layer.cornerRadius = 10.0f;
        headerNameLbl.layer.masksToBounds = YES;
        headerNameLbl.text = NSLocalizedString(@"categories_list", nil);
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        headerNameLbl.textAlignment = NSTextAlignmentCenter;
        headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
        
        //it is regard's to the view borderwidth and color setting....
        bottomBorder = [CALayer layer];
        bottomBorder.opacity = 5.0f;
        bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
        [headerNameLbl.layer addSublayer:bottomBorder];
        
        /*Creation of table header's*/
        selectAllCheckBoxBtn = [[UIButton alloc] init];
        checkBoxImg = [UIImage imageNamed:@"checkbox_off_background.png"];
        
        selectAllCheckBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
        [selectAllCheckBoxBtn addTarget:self
                                 action:@selector(changeSelectAllCheckBoxButtonImage:) forControlEvents:UIControlEventTouchDown];
        selectAllCheckBoxBtn.tag = 2;
        
        selectAllLbl = [[UILabel alloc] init];
        selectAllLbl.layer.cornerRadius = 10.0f;
        selectAllLbl.layer.masksToBounds = YES;
        selectAllLbl.text = NSLocalizedString(@"select_all", nil);
        selectAllLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        selectAllLbl.textAlignment = NSTextAlignmentCenter;
        selectAllLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        //creation of Product menu  table...
        categoriesTbl = [[UITableView alloc] init];
        categoriesTbl.backgroundColor  = [UIColor blackColor];
        categoriesTbl.layer.cornerRadius = 4.0;
        categoriesTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        categoriesTbl.dataSource = self;
        categoriesTbl.delegate = self;
        
        okButton = [[UIButton alloc] init] ;
        [okButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
        okButton.backgroundColor = [UIColor grayColor];
        okButton.layer.masksToBounds = YES;
        okButton.userInteractionEnabled = YES;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        okButton.layer.cornerRadius = 5.0f;
        [okButton addTarget:self action:@selector(multipleCategriesSelection:) forControlEvents:UIControlEventTouchDown];
        
        
        
        cancelBtn = [[UIButton alloc] init] ;
        [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor grayColor];
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.userInteractionEnabled = YES;
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        cancelBtn.layer.cornerRadius = 5.0f;
        [cancelBtn addTarget:self action:@selector(dismissCategoryPopOver:) forControlEvents:UIControlEventTouchDown];
        
        [categoriesView addSubview:headerNameLbl];
        [categoriesView addSubview:selectAllLbl];
        [categoriesView addSubview:selectAllCheckBoxBtn];
        [categoriesView addSubview:categoriesTbl];
        [categoriesView addSubview:okButton];
        [categoriesView addSubview:cancelBtn];
        
        
        headerNameLbl.frame = CGRectMake(0,0,categoriesView.frame.size.width,50);
        
        selectAllCheckBoxBtn.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+10,30,30);
        
        selectAllLbl.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x+selectAllCheckBoxBtn.frame.size.width+10,selectAllCheckBoxBtn.frame.origin.y-5,95,40);
        
        categoriesTbl.frame = CGRectMake(0,selectAllCheckBoxBtn.frame.origin.y+selectAllCheckBoxBtn.frame.size.height+10,categoriesView.frame.size.width,200);
        
        okButton.frame = CGRectMake(selectAllLbl.frame.origin.x,categoriesTbl.frame.origin.y+categoriesTbl.frame.size.height+5,100,40);
        cancelBtn.frame = CGRectMake(okButton.frame.origin.x+okButton.frame.size.width+20,categoriesTbl.frame.origin.y+categoriesTbl.frame.size.height+5,100,40);
        
        categoriesPopover.view = categoriesView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            categoriesPopover.preferredContentSize =  CGSizeMake(categoriesView.frame.size.width, categoriesView.frame.size.height);
            
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:categoriesPopover];
            
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:stockReceiptView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
            categoriesPopOver = popOver;
            
        }
        
        else {
            
            categoriesPopover.preferredContentSize = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:categoriesPopover];
            
            popOver.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            
            categoriesPopOver = popOver;
            
        }
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


#pragma  -mark action used to change checkBoxs images....

/**
 * @description  we are sending the request to get items for the selected multiple categories.......
 * @date         20/0/2016
 * @method       multipleCategriesSelected
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)multipleCategriesSelection:(UIButton *)sender {
    @try {
        NSMutableArray * catArr = [NSMutableArray new];
        Boolean * selectCategory = true;
        
        if (sender.tag != 2) {
            
            for(int i = 0; i < checkBoxArr.count; i++){
                
                if([checkBoxArr[i] integerValue]){
                    
                    selectCategory = false;
                    
                    NSDictionary * locDic = categoriesArr[i];
                    [catArr addObject:locDic];
                }
                
            }
            
            if (selectCategory) {
                [HUD setHidden:YES];
                [self displayAlertMessage:NSLocalizedString(@"please_select_atleast_one_category", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 250  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return;
            }
            
        }
        
        @try {
            [HUD setHidden:NO];
            NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
            
            priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            priceListDic[START_INDEX] = NEGATIVE_ONE;
            priceListDic[CATEGORY_LIST] = catArr;
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:priceListDic options:0 error:&err];
            
            NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@--json product Categories String--",getProductsJsonString);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.skuServiceDelegate = self;
            [webServiceController getPriceListSkuDetails:getProductsJsonString];
            
        }
        @catch (NSException * exception) {
            [HUD setHidden:YES];
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"no_products_found", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Here we are dismissing the popOver when cancelButton pressed...
 * @date         29/07/2017
 * @method       dismissCategoryPopOver
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)dismissCategoryPopOver:(UIButton*)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        [categoriesPopOver dismissPopoverAnimated:YES];
    } @catch (NSException *exception) {
        
    }
}



/**
 * @description  here we are showing the list of requestedItems.......
 * @date         20/09/2016
 * @method       changeCheckBoxImages:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)changeCheckBoxImages:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if( [checkBoxArr[sender.tag] integerValue])
            checkBoxArr[sender.tag] = @"0";
        
        else
            checkBoxArr[sender.tag] = @"1";
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [categoriesTbl reloadData];
        
    }
    
    
    
}


/**
 * @description  here we are showing the list of requestedItems.......
 * @date         20/09/2016
 * @method       changeCheckBoxImage;
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)changeSelectAllCheckBoxButtonImage:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(categoriesArr.count){
            
            UIImage * checkBoxImg = [UIImage imageNamed:@"checkbox_off_background.png"];
            
            
            if(selectAllCheckBoxBtn.tag == 2){
                
                for(int i = 0; i < checkBoxArr.count; i++){
                    
                    checkBoxArr[i] = @"1";
                }
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                
                [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                selectAllCheckBoxBtn.tag = 4;
                
            }
            else{
                
                for(int i = 0; i < checkBoxArr.count; i++){
                    
                    checkBoxArr[i] = @"0";
                }
                
                [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
                selectAllCheckBoxBtn.tag = 2;
            }
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [categoriesTbl reloadData];
        
    }
    
}



@end
