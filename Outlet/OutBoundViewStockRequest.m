//
//  OutBoundViewStockRequest.m
//  OmniRetailer
//
//  Created by Technolabs on 5/21/18.
//

#import "OutBoundViewStockRequest.h"
#import "PopOverViewController.h"
#import "OmniHomePage.h"
#import "Global.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

@interface OutBoundViewStockRequest ()

@end

@implementation OutBoundViewStockRequest
@synthesize soundFileURLRef,soundFileObject;
@synthesize requestID;
@synthesize selectIndex;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         21/09/2016
 * @method       ViewDidLoad
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
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
    
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef)tapSound;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    
    self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
    
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
    
    //creating the stockRequestView which will displayed completed Screen.......
    stockRequestView = [[UIView alloc] init];
    stockRequestView.backgroundColor = [UIColor blackColor];
    stockRequestView.layer.borderWidth = 1.0f;
    stockRequestView.layer.cornerRadius = 10.0f;
    stockRequestView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  stockRequest View...
    
    UILabel * headerNameLbl;
    CALayer * bottomBorder;
    
    UIButton *summaryInfoBtn;
    UIImage *summaryImage;
    
    headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
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
    
    
    /*Creation of UIButton for providing user to select the requestDteFlds.......*/
    
    summaryImage = [UIImage imageNamed:@"summaryInfo.png"];
    
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self
                       action:@selector(populatesummaryInfo) forControlEvents:UIControlEventTouchDown];
    summaryInfoBtn.hidden = YES;
    
    //   column 1
    
    UILabel * requestDteLbl;
    UILabel * requestIdLbl;
    
    toLocationLbl = [[UILabel alloc] init];
    toLocationLbl.text = NSLocalizedString(@"toLocation", nil);
    toLocationLbl.layer.cornerRadius = 14;
    toLocationLbl.layer.masksToBounds = YES;
    toLocationLbl.numberOfLines = 2;
    toLocationLbl.textAlignment = NSTextAlignmentLeft;
    toLocationLbl.backgroundColor = [UIColor clearColor];
    toLocationLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    requestDteLbl = [[UILabel alloc] init];
    requestDteLbl.text = NSLocalizedString(@"request_date", nil);
    requestDteLbl.layer.cornerRadius = 14;
    requestDteLbl.layer.masksToBounds = YES;
    requestDteLbl.numberOfLines = 2;
    requestDteLbl.textAlignment = NSTextAlignmentLeft;
    requestDteLbl.backgroundColor = [UIColor clearColor];
    requestDteLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5  ];
    
    requestIdLbl = [[UILabel alloc] init];
    requestIdLbl.text = NSLocalizedString(@"request_ref_no", nil);
    requestIdLbl.layer.cornerRadius = 14;
    requestIdLbl.layer.masksToBounds = YES;
    requestIdLbl.numberOfLines = 2;
    requestIdLbl.textAlignment = NSTextAlignmentLeft;
    requestIdLbl.backgroundColor = [UIColor clearColor];
    requestIdLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    //    end of column 1
    
    //    column 2
    
    
    UILabel * storeIdLbl;
    UILabel * deliveryDteLbl;
    UILabel * priorityLbl;
    
    storeIdLbl = [[UILabel alloc] init];
    storeIdLbl.text = NSLocalizedString(@"to_store_code", nil);
    storeIdLbl.layer.cornerRadius = 14;
    storeIdLbl.layer.masksToBounds = YES;
    storeIdLbl.numberOfLines = 2;
    storeIdLbl.textAlignment = NSTextAlignmentLeft;
    storeIdLbl.backgroundColor = [UIColor clearColor];
    storeIdLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    deliveryDteLbl = [[UILabel alloc] init];
    deliveryDteLbl.text = NSLocalizedString(@"delivery_Date", nil);
    deliveryDteLbl.layer.cornerRadius = 14;
    deliveryDteLbl.layer.masksToBounds = YES;
    deliveryDteLbl.numberOfLines = 2;
    deliveryDteLbl.textAlignment = NSTextAlignmentLeft;
    deliveryDteLbl.backgroundColor = [UIColor clearColor];
    deliveryDteLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    priorityLbl = [[UILabel alloc] init];
    priorityLbl.text = NSLocalizedString(@"priority_level", nil);
    priorityLbl.layer.cornerRadius = 14;
    priorityLbl.layer.masksToBounds = YES;
    priorityLbl.numberOfLines = 2;
    priorityLbl.textAlignment = NSTextAlignmentLeft;
    priorityLbl.backgroundColor = [UIColor clearColor];
    priorityLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    // end of column  2
    
    //   column 3
    
    UILabel * locationLbl;
    UILabel * shipmentLbl;
    
    
    locationLbl = [[UILabel alloc] init];
    locationLbl.text = NSLocalizedString(@"fromLocation", nil);
    locationLbl.layer.cornerRadius = 14;
    locationLbl.layer.masksToBounds = YES;
    locationLbl.numberOfLines = 2;
    locationLbl.textAlignment = NSTextAlignmentLeft;
    locationLbl.backgroundColor = [UIColor clearColor];
    locationLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    shipmentLbl = [[UILabel alloc] init];
    shipmentLbl.text = NSLocalizedString(@"shipment_mode", nil);
    shipmentLbl.layer.cornerRadius = 14;
    shipmentLbl.layer.masksToBounds = YES;
    shipmentLbl.numberOfLines = 2;
    shipmentLbl.textAlignment = NSTextAlignmentLeft;
    shipmentLbl.backgroundColor = [UIColor clearColor];
    shipmentLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    // end of column 3
    
    //    column 4
    
    UILabel * requestdByLbl;
    UILabel * submittedByLbl;
    UILabel * actionReqLbl;
    
    requestdByLbl = [[UILabel alloc] init];
    requestdByLbl.text = NSLocalizedString(@"requested_by", nil);
    requestdByLbl.layer.cornerRadius = 14;
    requestdByLbl.layer.masksToBounds = YES;
    requestdByLbl.numberOfLines = 2;
    requestdByLbl.textAlignment = NSTextAlignmentLeft;
    requestdByLbl.backgroundColor = [UIColor clearColor];
    requestdByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    submittedByLbl = [[UILabel alloc] init];
    submittedByLbl.text = NSLocalizedString(@"submitted_by", nil);
    submittedByLbl.layer.cornerRadius = 14;
    submittedByLbl.layer.masksToBounds = YES;
    submittedByLbl.numberOfLines = 2;
    submittedByLbl.textAlignment = NSTextAlignmentLeft;
    submittedByLbl.backgroundColor = [UIColor clearColor];
    submittedByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6 ];
    
    
    actionReqLbl = [[UILabel alloc] init];
    actionReqLbl.text = NSLocalizedString(@"action_required", nil);
    actionReqLbl.layer.cornerRadius = 14;
    actionReqLbl.layer.masksToBounds = YES;
    actionReqLbl.numberOfLines = 2;
    actionReqLbl.textAlignment = NSTextAlignmentLeft;
    actionReqLbl.backgroundColor = [UIColor clearColor];
    actionReqLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
    
    //     newly added Labels in Edit Stock Request:
    
    UILabel * zoneIdLbl;
    UILabel * outletid_Lbl;
    
    zoneIdLbl = [[UILabel alloc] init];
    zoneIdLbl.text = NSLocalizedString(@"zone", nil);
    zoneIdLbl.layer.cornerRadius = 14;
    zoneIdLbl.layer.masksToBounds = YES;
    zoneIdLbl.numberOfLines = 2;
    zoneIdLbl.textAlignment = NSTextAlignmentLeft;
    zoneIdLbl.backgroundColor = [UIColor clearColor];
    zoneIdLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    outletid_Lbl = [[UILabel alloc] init];
    outletid_Lbl.text = NSLocalizedString(@"fromLocation", nil);
    outletid_Lbl.layer.cornerRadius = 14;
    outletid_Lbl.layer.masksToBounds = YES;
    outletid_Lbl.numberOfLines = 2;
    outletid_Lbl.textAlignment = NSTextAlignmentLeft;
    outletid_Lbl.backgroundColor = [UIColor clearColor];
    outletid_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    //    toStoreLocTxt = [[CustomTextField alloc] init];
    //    toStoreLocTxt.borderStyle = UITextBorderStyleRoundedRect;
    //    toStoreLocTxt.font = [UIFont systemFontOfSize:18.0];
    //    toStoreLocTxt.layer.cornerRadius = 10.0;
    //    toStoreLocTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    toStoreLocTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    //    toStoreLocTxt.delegate = self;
    //
    //    toStoreLocTxt.userInteractionEnabled = NO;
    //    toStoreLocTxt.placeholder = @" To Store Code";
    //    [toStoreLocTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //    [toStoreLocTxt awakeFromNib];
    //    toStoreLocTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:toStoreLocTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //    toStoreLocTxt.userInteractionEnabled = false;
    
    
    toLocationTxt = [[CustomTextField alloc] init];
    toLocationTxt.borderStyle = UITextBorderStyleRoundedRect;
    toLocationTxt.font = [UIFont systemFontOfSize:18.0];
    toLocationTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    toLocationTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    toLocationTxt.delegate = self;
    toLocationTxt.userInteractionEnabled = NO;
    toLocationTxt.placeholder = NSLocalizedString(@"toLocation", nil);
    [toLocationTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [toLocationTxt awakeFromNib];
    
    toLocationTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:toLocationTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    toLocationTxt.userInteractionEnabled = false;
    
    
    
    requestIdTxt = [[CustomTextField alloc] init];
    requestIdTxt.borderStyle = UITextBorderStyleRoundedRect;
    requestIdTxt.font = [UIFont systemFontOfSize:18.0];
    requestIdTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    requestIdTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    requestIdTxt.delegate = self;
    requestIdTxt.layer.cornerRadius = 10.0;
    
    requestIdTxt.userInteractionEnabled = NO;
    requestIdTxt.placeholder = NSLocalizedString(@"request_id", nil);
    [requestIdTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [requestIdTxt awakeFromNib];
    requestIdTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:requestIdTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    submittedByTxt = [[CustomTextField alloc] init];
    submittedByTxt.borderStyle = UITextBorderStyleRoundedRect;
    submittedByTxt.font = [UIFont systemFontOfSize:18.0];
    submittedByTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    submittedByTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    submittedByTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    submittedByTxt.layer.cornerRadius = 10.0;
    submittedByTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    submittedByTxt.delegate = self;
    submittedByTxt.placeholder = NSLocalizedString(@"submitted_by", nil);
    [submittedByTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [submittedByTxt awakeFromNib];
    submittedByTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:submittedByTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    RequestedBy = [[CustomTextField alloc] init];
    RequestedBy.borderStyle = UITextBorderStyleRoundedRect;
    RequestedBy.font = [UIFont systemFontOfSize:18.0];
    RequestedBy.clearButtonMode = UITextFieldViewModeWhileEditing;
    RequestedBy.autocorrectionType = UITextAutocorrectionTypeNo;
    RequestedBy.delegate = self;
    RequestedBy.layer.cornerRadius = 10.0;
    
    RequestedBy.placeholder = NSLocalizedString(@"requested_by", nil);
    [RequestedBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [RequestedBy awakeFromNib];
    RequestedBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:RequestedBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    RequestedBy.clearButtonMode = UITextFieldViewModeWhileEditing;
    RequestedBy.autocorrectionType = UITextAutocorrectionTypeNo;
    
    deliveryDateTxt = [[CustomTextField alloc] init];
    deliveryDateTxt.borderStyle = UITextBorderStyleRoundedRect;
    deliveryDateTxt.font = [UIFont systemFontOfSize:18.0];
    deliveryDateTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    deliveryDateTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    deliveryDateTxt.placeholder = NSLocalizedString(@"delivery_Date", nil);
    deliveryDateTxt.layer.cornerRadius = 10.0;
    deliveryDateTxt.userInteractionEnabled = NO;
    [deliveryDateTxt setEnabled:FALSE];
    deliveryDateTxt.delegate = self;
    deliveryDateTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:deliveryDateTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    [deliveryDateTxt awakeFromNib];
    
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy/MM/dd";
    NSString* currentdate = [f stringFromDate:today];
    
    RequestDteTxt = [[CustomTextField alloc] init];
    RequestDteTxt.borderStyle = UITextBorderStyleRoundedRect;
    RequestDteTxt.font = [UIFont systemFontOfSize:18.0];
    RequestDteTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    RequestDteTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    RequestDteTxt.delegate = self;
    RequestDteTxt.layer.cornerRadius = 10.0;
    
    RequestDteTxt.placeholder = NSLocalizedString(@"request_date", nil);
    RequestDteTxt.text = currentdate;
    [RequestDteTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [RequestDteTxt awakeFromNib];
    RequestDteTxt.userInteractionEnabled = NO;
    
    shipmentModeTxt = [[CustomTextField alloc] init];
    shipmentModeTxt.borderStyle = UITextBorderStyleRoundedRect;
    shipmentModeTxt.textColor = [UIColor blackColor];
    shipmentModeTxt.font = [UIFont systemFontOfSize:18.0];
    shipmentModeTxt.backgroundColor = [UIColor whiteColor];
    shipmentModeTxt.layer.cornerRadius = 10;
    shipmentModeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentModeTxt.backgroundColor = [UIColor whiteColor];
    shipmentModeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentModeTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentModeTxt.backgroundColor = [UIColor whiteColor];
    shipmentModeTxt.delegate = self;
    shipmentModeTxt.userInteractionEnabled = NO;
    shipmentModeTxt.placeholder = NSLocalizedString(@"shipping_mode", nil);
    [shipmentModeTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [shipmentModeTxt awakeFromNib];
    shipmentModeTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipmentModeTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    priorityTxt = [[CustomTextField alloc] init];
    priorityTxt.borderStyle = UITextBorderStyleRoundedRect;
    priorityTxt.textColor = [UIColor blackColor];
    priorityTxt.font = [UIFont systemFontOfSize:18.0];
    priorityTxt.layer.cornerRadius = 10;
    
    priorityTxt.backgroundColor = [UIColor whiteColor];
    priorityTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    priorityTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    priorityTxt.delegate = self;
    priorityTxt.placeholder = NSLocalizedString(@"priority", nil);
    priorityTxt .userInteractionEnabled = NO;
    [priorityTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [priorityTxt awakeFromNib];
    priorityTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    priorityTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    priorityTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:priorityTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    actionRequiredTxt = [[CustomTextField alloc] init];
    actionRequiredTxt.borderStyle = UITextBorderStyleRoundedRect;
    actionRequiredTxt.textColor = [UIColor blackColor];
    actionRequiredTxt.font = [UIFont systemFontOfSize:18.0];
    actionRequiredTxt.layer.cornerRadius = 10;
    
    actionRequiredTxt.backgroundColor = [UIColor whiteColor];
    actionRequiredTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    actionRequiredTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    actionRequiredTxt.delegate = self;
    actionRequiredTxt.placeholder = NSLocalizedString(@"action_required", nil);
    actionRequiredTxt .userInteractionEnabled = NO;
    [actionRequiredTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [actionRequiredTxt awakeFromNib];
    actionRequiredTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    actionRequiredTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    actionRequiredTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:actionRequiredTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    outletIdTxt = [[CustomTextField alloc] init];
    outletIdTxt.delegate = self;
    
    outletIdTxt.placeholder = NSLocalizedString(@"fromLocation", nil);
    outletIdTxt.userInteractionEnabled  = NO;
    [outletIdTxt awakeFromNib];
    
    
    zoneIdTxt = [[CustomTextField alloc] init];
    zoneIdTxt.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneIdTxt.delegate = self;
    zoneIdTxt.userInteractionEnabled  = NO;
    [zoneIdTxt awakeFromNib];
    
    
    if (isHubLevel) {
        zoneIdTxt.text = zoneID;
    }
    else
        zoneIdTxt.text  = zone;
    
    
    //    @try {
    //        outletIdTxt.text = [NSString stringWithFormat:@"%@%@",@"  ",presentLocation ];;
    //    }
    //    @catch (NSException *exception) {
    //
    //    }
    
    UIImage * productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
    selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self  action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    
    //  creation of UIButton for selecting the location....
    
    
    UIImage  * loctnImg;
    UIImage  * buttonImageDD;
    
    UIButton * selectLoctn ;
    UIButton * selctWareHouse;
    UIButton * selectDate;
    UIButton * selectdelvry;
    UIButton * shipModeButton;
    
    loctnImg  = [UIImage imageNamed:@"arrow_1.png"];
    buttonImageDD = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    
    selectLoctn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectLoctn setBackgroundImage:loctnImg forState:UIControlStateNormal];
    [selectLoctn addTarget:self
                    action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    
    selectLoctn.tag = 2;
    selectLoctn.hidden =YES;
    
    selctWareHouse = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selctWareHouse setBackgroundImage:loctnImg forState:UIControlStateNormal];
    [selctWareHouse addTarget:self
                       action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    [selctWareHouse setHidden: YES];
    selctWareHouse.tag = 4;
    
    
    selectDate = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectDate setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectDate addTarget:self
                   action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    selectDate.tag = 4;
    
    
    selectdelvry = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectdelvry setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    
    [selectdelvry addTarget:self
                     action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    
    
    shipModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"arrow_1.png"];
    [shipModeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [shipModeButton addTarget:self action:@selector(getShipmentModes:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * priortyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *priorityImg = [UIImage imageNamed:@"arrow_1.png"];
    [priortyBtn setBackgroundImage:priorityImg forState:UIControlStateNormal];
    [priortyBtn addTarget:self action:@selector(populatePriorityList:) forControlEvents:UIControlEventTouchUpInside];
    
    //used for identification purpose....
    //selectrequestDteBtn.tag = 2;
    //selectdelvryBtn.tag = 1;
    
    
    selectdelvry.tag = 1;
    selectDate.tag = 2;
    
    actionbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionbtn setBackgroundImage:loctnImg forState:UIControlStateNormal];
    [actionbtn addTarget:self action:@selector(populateActionRequiredList:) forControlEvents:UIControlEventTouchUpInside];
    
    
    searchItemTxt = [[CustomTextField alloc] init];
    searchItemTxt.placeholder = NSLocalizedString(@"Search_Sku_Here", nil);
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
    
    /*creation of UILable's*/
    S_No  = [[CustomLabel alloc] init];
    [S_No awakeFromNib];
    
    skuId = [[CustomLabel alloc] init];
    [skuId awakeFromNib];
    
    descriptionLbl = [[CustomLabel alloc] init];
    [descriptionLbl awakeFromNib];
    
    uomLbl = [[CustomLabel alloc] init];
    [uomLbl awakeFromNib];
    
    gradeLbl = [[CustomLabel alloc] init];
    [gradeLbl awakeFromNib];
    
    priceLbl = [[CustomLabel alloc] init];
    [priceLbl awakeFromNib];
    
    qohLbl = [[CustomLabel alloc] init];
    [qohLbl awakeFromNib];
    
    prvIndentQtyLbl = [[CustomLabel alloc] init];
    [prvIndentQtyLbl awakeFromNib];
    
    projQtyLbl = [[CustomLabel alloc] init];
    [projQtyLbl awakeFromNib];
    
    qtyLbl = [[CustomLabel alloc] init];
    [qtyLbl awakeFromNib];
    
    appQtyLbl = [[CustomLabel alloc] init];
    [appQtyLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    productListTbl = [[UITableView alloc] init];
    
    //creation of scroll view
    stockRequestScrollView = [[UIScrollView alloc] init];
    
    //stockRequestScrollView.backgroundColor = [UIColor lightGrayColor];
    
    // Table for storing the items ..
    requestedItemsTbl = [[UITableView alloc] init];
    requestedItemsTbl.backgroundColor = [UIColor blackColor];
    requestedItemsTbl.dataSource = self;
    requestedItemsTbl.delegate = self;
    requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //requestedItemsTbl.userInteractionEnabled = TRUE;
    requestedItemsTbl.bounces = TRUE;
    
    //Added By Bhargav on 25/10/2017...To Display the  total values of quantities in cart...
    
    quantityOnHandValueLbl = [[UILabel alloc] init];
    quantityOnHandValueLbl.layer.cornerRadius = 5;
    quantityOnHandValueLbl.layer.masksToBounds = YES;
    quantityOnHandValueLbl.backgroundColor = [UIColor blackColor];
    quantityOnHandValueLbl.layer.borderWidth = 2.0f;
    quantityOnHandValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    quantityOnHandValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    quantityOnHandValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    previousQtyValueLbl = [[UILabel alloc] init];
    previousQtyValueLbl.layer.cornerRadius = 5;
    previousQtyValueLbl.layer.masksToBounds = YES;
    previousQtyValueLbl.backgroundColor = [UIColor blackColor];
    previousQtyValueLbl.layer.borderWidth = 2.0f;
    previousQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    previousQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    previousQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    projectedQtyValueLbl = [[UILabel alloc] init];
    projectedQtyValueLbl.layer.cornerRadius = 5;
    projectedQtyValueLbl.layer.masksToBounds = YES;
    projectedQtyValueLbl.backgroundColor = [UIColor blackColor];
    projectedQtyValueLbl.layer.borderWidth = 2.0f;
    projectedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    projectedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    projectedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    requestedQtyvalueLbl = [[UILabel alloc] init];
    requestedQtyvalueLbl.layer.cornerRadius = 5;
    requestedQtyvalueLbl.layer.masksToBounds = YES;
    requestedQtyvalueLbl.backgroundColor = [UIColor blackColor];
    requestedQtyvalueLbl.layer.borderWidth = 2.0f;
    requestedQtyvalueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    requestedQtyvalueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    requestedQtyvalueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    approvedQtyValueLbl = [[UILabel alloc] init];
    approvedQtyValueLbl.layer.cornerRadius = 5;
    approvedQtyValueLbl.layer.masksToBounds = YES;
    approvedQtyValueLbl.backgroundColor = [UIColor blackColor];
    approvedQtyValueLbl.layer.borderWidth = 2.0f;
    approvedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    approvedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    approvedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    quantityOnHandValueLbl.textAlignment = NSTextAlignmentCenter;
    previousQtyValueLbl.textAlignment    = NSTextAlignmentCenter;
    projectedQtyValueLbl.textAlignment   = NSTextAlignmentCenter;
    requestedQtyvalueLbl.textAlignment   = NSTextAlignmentCenter;
    approvedQtyValueLbl.textAlignment    = NSTextAlignmentCenter;
    
    
    quantityOnHandValueLbl.text = @"0.00";
    previousQtyValueLbl.text    = @"0.00";
    projectedQtyValueLbl.text   = @"0.00";
    requestedQtyvalueLbl.text   = @"0.00";
    approvedQtyValueLbl.text    = @"0.00";
    
    
    
    
    
    
    submitBtn = [[UIButton alloc] init] ;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.userInteractionEnabled = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButonPressed:) forControlEvents:UIControlEventTouchDown];
    
    saveBtn = [[UIButton alloc] init] ;
    saveBtn.backgroundColor = [UIColor grayColor];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.userInteractionEnabled = YES;
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    saveBtn.layer.cornerRadius = 5.0f;
    [saveBtn addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchDown];
    saveBtn.tag = 2;
    
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.userInteractionEnabled = YES;
    
    priceTable = [[UITableView alloc] init];
    priceTable.backgroundColor = [UIColor blackColor];
    priceTable.dataSource = self;
    priceTable.delegate = self;
    priceTable.layer.cornerRadius = 3;
    
    closeBtn = [[UIButton alloc] init] ;
    [closeBtn addTarget:self action:@selector(closePriceView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 11;
    
    UIImage * image = [UIImage imageNamed:@"delete.png"];
    [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
    
    priceView = [[UIView alloc] init];
    priceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    priceView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7].CGColor;
    priceView.layer.borderWidth = 1.0;
    
    transparentView = [[UIView alloc]init];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    descLabl = [[CustomLabel alloc]init];
    [descLabl awakeFromNib];
    
    mrpLbl = [[CustomLabel alloc]init];
    [mrpLbl awakeFromNib];
    
    priceLabl = [[CustomLabel alloc]init];
    [priceLabl awakeFromNib];
    
    
    @try {
        headerNameLbl.text = NSLocalizedString(@"editStock_request_outbound", nil);
        S_No.text = NSLocalizedString(@"S No", nil);
        skuId.text = NSLocalizedString(@"sku_id", nil);
        descriptionLbl.text = NSLocalizedString(@"Desc", nil);
        uomLbl.text = NSLocalizedString(@"uom", nil);
        gradeLbl.text = NSLocalizedString(@"grade", nil);
        priceLbl.text = NSLocalizedString(@"Price", nil);
        qohLbl.text = NSLocalizedString(@"qoh", nil);
        prvIndentQtyLbl.text = NSLocalizedString(@"prv_indent_qty", nil);
        projQtyLbl.text = NSLocalizedString(@"proj_qty_lbl", nil);
        qtyLbl.text = NSLocalizedString(@"Req Qty",nil);
        appQtyLbl.text = NSLocalizedString(@"App Qty",nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        
        [submitBtn setTitle:NSLocalizedString(@"edit",nil) forState:UIControlStateNormal];
        [saveBtn setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
        [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
        
        //priceList Labels...
        
        descLabl.text = NSLocalizedString(@"description", nil);
        mrpLbl.text = NSLocalizedString(@"mrp_rps", nil);
        priceLabl.text = NSLocalizedString(@"price", nil);
        
        [submitBtn setTitle:NSLocalizedString(@"edit", nil) forState:UIControlStateNormal];
        
        
    } @catch (NSException * exception) {
        
    }
    
    
    
    workFlowView = [[UIView alloc] init];
    
    [stockRequestView addSubview:headerNameLbl];
    [stockRequestView addSubview:summaryInfoBtn];
    
    [stockRequestView addSubview:toLocationLbl];
    [stockRequestView addSubview:toLocationTxt];
    
    [stockRequestView addSubview:requestDteLbl];
    [stockRequestView addSubview:RequestDteTxt];
    
    [stockRequestView addSubview:requestIdLbl];
    [stockRequestView addSubview:requestIdTxt];
    
    [stockRequestView addSubview:deliveryDteLbl];
    [stockRequestView addSubview:deliveryDateTxt];
    
    [stockRequestView addSubview:priorityLbl];
    [stockRequestView addSubview:priorityTxt];
    
    [stockRequestView addSubview:shipmentLbl];
    [stockRequestView addSubview:shipmentModeTxt];
    
    [stockRequestView addSubview:locationLbl];
    
    [stockRequestView addSubview:RequestedBy];
    [stockRequestView addSubview:requestdByLbl];
    
    [stockRequestView addSubview:submittedByLbl];
    [stockRequestView addSubview:submittedByTxt];
    
    [stockRequestView addSubview:actionReqLbl];
    [stockRequestView addSubview:actionRequiredTxt];
    [stockRequestView addSubview:actionbtn];
    
    [stockRequestView addSubview:selectLoctn];
    
    [stockRequestView addSubview:selctWareHouse];
    [stockRequestView addSubview:selectDate];
    [stockRequestView addSubview:shipModeButton];
    [stockRequestView addSubview:selectdelvry];
    [stockRequestView addSubview:priortyBtn];
    
    [stockRequestView addSubview:outletid_Lbl];
    [stockRequestView addSubview:outletIdTxt];
    
    [stockRequestView addSubview:zoneIdLbl];
    [stockRequestView addSubview:zoneIdTxt];
    
    [stockRequestView addSubview:workFlowView];
    [stockRequestView addSubview:searchItemTxt];
    
    [stockRequestView addSubview:selectCategoriesBtn];
    
    [stockRequestScrollView addSubview:S_No];
    [stockRequestScrollView addSubview:skuId];
    [stockRequestScrollView addSubview:descriptionLbl];
    [stockRequestScrollView addSubview:uomLbl];
    [stockRequestScrollView addSubview:gradeLbl];
    [stockRequestScrollView addSubview:priceLbl];
    [stockRequestScrollView addSubview:qohLbl];
    [stockRequestScrollView addSubview:prvIndentQtyLbl];
    [stockRequestScrollView addSubview:projQtyLbl];
    [stockRequestScrollView addSubview:qtyLbl];
    [stockRequestScrollView addSubview:appQtyLbl];
    [stockRequestScrollView addSubview:actionLbl];
    
    [stockRequestScrollView addSubview:requestedItemsTbl];
    
    [stockRequestView addSubview:submitBtn];
    [stockRequestView addSubview:saveBtn];
    [stockRequestView addSubview:cancelButton];
    
    // UILabel For Displaying Totals Values...
    
    [stockRequestView addSubview:quantityOnHandValueLbl];
    [stockRequestView addSubview:previousQtyValueLbl];
    [stockRequestView addSubview:projectedQtyValueLbl];
    [stockRequestView addSubview:requestedQtyvalueLbl];
    [stockRequestView addSubview:approvedQtyValueLbl];
    
    [stockRequestView addSubview:stockRequestScrollView];
    
    [stockRequestView addSubview:productListTbl];
    
    [self.view addSubview:stockRequestView];
    
    //Modified By prabhu
    
    [priceView addSubview:priceLabl];
    [priceView addSubview:mrpLbl];
    [priceView addSubview:descLabl];
    [priceView addSubview:priceTable];
    [transparentView addSubview:priceView];
    [transparentView addSubview:closeBtn];
    [self.view addSubview:transparentView];
    
    //////-----End------///
    
    if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //  frame for the stockRequestView
            stockRequestView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            //  frame for the headerNameLbl
            
            headerNameLbl.frame = CGRectMake( 0, 0, stockRequestView.frame.size.width, 45);
            
            // frame for the summaryInfoBtn
            
            summaryInfoBtn.frame = CGRectMake(stockRequestView.frame.size.width - 45, headerNameLbl.frame.origin.y +  headerNameLbl.frame.size.height+5 , 35, 30);
            
            //setting below labe's frame.......
            float labelWidth =  200;
            float labelHeight = 40;
            
            float textFieldWidth =  190;
            float textFieldHeight = 40;
            float horizontalWidth = 20;
            
            //first Column.......
            toLocationLbl.frame =  CGRectMake(10, headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height,labelWidth, labelHeight);
            
            toLocationTxt.frame =  CGRectMake(toLocationLbl.frame.origin.x,toLocationLbl.frame.origin.y + toLocationLbl.frame.size.height-10,300,textFieldHeight);
            
            zoneIdLbl.frame = CGRectMake(toLocationLbl.frame.origin.x+toLocationLbl.frame.size.width+horizontalWidth+140,toLocationLbl.frame.origin.y,labelWidth,labelHeight);
            
            zoneIdTxt.frame = CGRectMake(zoneIdLbl.frame.origin.x,toLocationTxt.frame.origin.y,textFieldWidth, textFieldHeight);
            
            requestIdLbl.frame =  CGRectMake( zoneIdLbl.frame.origin.x+zoneIdLbl.frame.size.width+horizontalWidth,zoneIdLbl.frame.origin.y,labelWidth, labelHeight);
            
            
            requestIdTxt.frame =  CGRectMake( requestIdLbl.frame.origin.x, toLocationTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            requestdByLbl.frame =  CGRectMake(requestIdLbl.frame.origin.x+requestIdLbl.frame.size.width+horizontalWidth+5,toLocationLbl.frame.origin.y,labelWidth, labelHeight);
            
            RequestedBy.frame =  CGRectMake(requestdByLbl.frame.origin.x,requestIdTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            //column 2
            
            requestDteLbl.frame =  CGRectMake(toLocationLbl.frame.origin.x, toLocationTxt.frame.origin.y+toLocationTxt.frame.size.height+0,labelWidth, labelHeight);
            
            RequestDteTxt.frame =  CGRectMake( toLocationTxt.frame.origin.x, requestDteLbl.frame.origin.y + requestDteLbl.frame.size.height-10,140,textFieldHeight);
            
            deliveryDteLbl.frame =  CGRectMake(requestDteLbl.frame.origin.x+requestDteLbl.frame.size.width-40, requestDteLbl.frame.origin.y,labelWidth, labelHeight);
            
            deliveryDateTxt.frame =  CGRectMake(deliveryDteLbl.frame.origin.x, RequestDteTxt.frame.origin.y, RequestDteTxt.frame.size.width,textFieldHeight);
            
            
            outletid_Lbl.frame = CGRectMake(zoneIdLbl.frame.origin.x,deliveryDteLbl.frame.origin.y,labelWidth,labelHeight);
            outletIdTxt.frame = CGRectMake(outletid_Lbl.frame.origin.x, deliveryDateTxt.frame.origin.y, textFieldWidth,textFieldHeight);
            
            shipmentLbl.frame =  CGRectMake(requestIdLbl.frame.origin.x,outletid_Lbl.frame.origin.y,labelWidth, labelHeight);
            
            shipmentModeTxt.frame =  CGRectMake(shipmentLbl.frame.origin.x, outletIdTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            priorityLbl.frame =  CGRectMake(requestdByLbl.frame.origin.x, shipmentLbl.frame.origin.y,labelWidth, labelHeight);
            
            priorityTxt.frame =  CGRectMake(priorityLbl.frame.origin.x,shipmentModeTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            actionRequiredTxt.frame = CGRectMake(priorityLbl.frame.origin.x,priorityTxt.frame.origin.y+priorityTxt.frame.size.height+10,textFieldWidth,textFieldHeight);
            
            //assigining  frame for the  UIButtons...
            selectDate.frame = CGRectMake((RequestDteTxt.frame.origin.x+RequestDteTxt.frame.size.width-35), RequestDteTxt.frame.origin.y+4, 30, 30);
            
            selectdelvry.frame = CGRectMake((deliveryDateTxt.frame.origin.x+deliveryDateTxt.frame.size.width-35), deliveryDateTxt.frame.origin.y+4, 30, 30);
            
            shipModeButton.frame = CGRectMake((shipmentModeTxt.frame.origin.x+shipmentModeTxt.frame.size.width-45), shipmentModeTxt.frame.origin.y-8, 55, 60);
            
            priortyBtn.frame = CGRectMake((priorityTxt.frame.origin.x+priorityTxt.frame.size.width-45), priorityTxt.frame.origin.y-8, 55, 60);
            
            actionbtn.frame = CGRectMake((actionRequiredTxt.frame.origin.x+actionRequiredTxt.frame.size.width-45), actionRequiredTxt.frame.origin.y-8, 55, 60);
            
            workFlowView.frame = CGRectMake(0,actionRequiredTxt.frame.origin.y,shipmentModeTxt.frame.origin.x + shipmentModeTxt.frame.size.width - (RequestDteTxt.frame.origin.x-20),textFieldHeight);
            
            searchItemTxt.frame = CGRectMake(toLocationLbl.frame.origin.x, workFlowView.frame.origin.y+workFlowView.frame.size.height+10 ,stockRequestView.frame.size.width -105,40);
            
            selectCategoriesBtn.frame = CGRectMake((searchItemTxt.frame.origin.x + searchItemTxt.frame.size.width + 5), searchItemTxt.frame.origin.y,75, 40);
            
            //productListTbl.frame = CGRectMake( searchItemTxt.frame.origin.x, searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height , searchItemTxt.frame.size.width, 250);
            
            
            //Setting frame for the header labels...
            // frame for the header Section Labels...
            
            S_No.frame = CGRectMake(0,0,60,35);
            
            skuId.frame = CGRectMake(S_No.frame.origin.x+S_No.frame.size.width+2,S_No.frame.origin.y,110,S_No.frame.size.height);
            
            descriptionLbl.frame = CGRectMake(skuId.frame.origin.x+skuId.frame.size.width+2,skuId.frame.origin.y,150,skuId.frame.size.height);
            
            uomLbl.frame = CGRectMake( descriptionLbl.frame.origin.x + descriptionLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,70, descriptionLbl.frame.size.height);
            
            gradeLbl.frame = CGRectMake( uomLbl.frame.origin.x + uomLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,80, descriptionLbl.frame.size.height);
            
            //priceLbl.frame = CGRectMake( gradeLbl.frame.origin.x + gradeLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,70, descriptionLbl.frame.size.height);
            
            qohLbl.frame = CGRectMake( gradeLbl.frame.origin.x + gradeLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,70, descriptionLbl.frame.size.height);
            
            prvIndentQtyLbl.frame = CGRectMake( qohLbl.frame.origin.x + qohLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,80, descriptionLbl.frame.size.height);
            
            projQtyLbl.frame = CGRectMake( prvIndentQtyLbl.frame.origin.x + prvIndentQtyLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,70, descriptionLbl.frame.size.height);
            
            qtyLbl.frame = CGRectMake(projQtyLbl.frame.origin.x+projQtyLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,90, descriptionLbl.frame.size.height);
            
            appQtyLbl.frame = CGRectMake(qtyLbl.frame.origin.x+qtyLbl.frame.size.width+2,qtyLbl.frame.origin.y ,100,qtyLbl.frame.size.height);
            
            actionLbl.frame = CGRectMake(appQtyLbl.frame.origin.x +appQtyLbl.frame.size.width+2 , appQtyLbl.frame.origin.y,98,appQtyLbl.frame.size.height);
            
            stockRequestScrollView.frame = CGRectMake(searchItemTxt.frame.origin.x,searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height+5,searchItemTxt.frame.size.width+120,340);
            
            
            requestedItemsTbl.frame = CGRectMake(stockRequestView.frame.origin.x, S_No.frame.origin.y +  S_No.frame.size.height, actionLbl.frame.origin.x + actionLbl.frame.size.width + 50,  stockRequestScrollView.frame.size.height - (S_No.frame.origin.y +  S_No.frame.size.height));
            
            //stockRequestScrollView.contentSize = CGSizeMake(requestedItemsTbl.frame.size.width,stockRequestScrollView.frame.size.height);
            
            submitBtn.frame = CGRectMake(searchItemTxt.frame.origin.x,stockRequestView.frame.size.height-45,140, 40);
            cancelButton.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+30,submitBtn.frame.origin.y,140,40);
            
            
            //saveBtn.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+30,submitBtn.frame.origin.y,140,40);
            
            
            // for calculating the totalItems & total Quantity...
            
            quantityOnHandValueLbl.frame = CGRectMake(qohLbl.frame.origin.x + 8,submitBtn.frame.origin.y, qohLbl.frame.size.width,qohLbl.frame.size.height);
            
            previousQtyValueLbl.frame = CGRectMake(prvIndentQtyLbl.frame.origin.x + 8,quantityOnHandValueLbl.frame.origin.y, prvIndentQtyLbl.frame.size.width,prvIndentQtyLbl.frame.size.height);
            
            projectedQtyValueLbl.frame = CGRectMake(projQtyLbl.frame.origin.x + 8,quantityOnHandValueLbl.frame.origin.y, projQtyLbl.frame.size.width,projQtyLbl.frame.size.height);
            
            requestedQtyvalueLbl.frame = CGRectMake(qtyLbl.frame.origin.x + 8,quantityOnHandValueLbl.frame.origin.y, qtyLbl.frame.size.width,qtyLbl.frame.size.height);
            
            approvedQtyValueLbl.frame = CGRectMake(appQtyLbl.frame.origin.x + 8,quantityOnHandValueLbl.frame.origin.y, appQtyLbl.frame.size.width,appQtyLbl.frame.size.height);
            
            // upto here on 26/10/2017 By Bhargav.v
            
            
            //frame for the Transparent view:
            
            transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            priceView.frame = CGRectMake(200, 400, 490,300);
            
            descLabl.frame = CGRectMake(0,5,180, 35);
            mrpLbl.frame = CGRectMake(descLabl.frame.origin.x+descLabl.frame.size.width+2,descLabl.frame.origin.y, 150, 35);
            priceLabl.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, descLabl.frame.origin.y, 150, 35);
            
            priceTable.frame = CGRectMake(descLabl.frame.origin.x,descLabl.frame.origin.y+descLabl.frame.size.height+5, priceLabl.frame.origin.x+priceLabl.frame.size.width - (descLabl.frame.origin.x), priceView.frame.size.height - (descLabl.frame.origin.y + descLabl.frame.size.height+20));
            
            closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38, 40, 40);
        }
        
        @try {
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
            headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            saveBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            cancelButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
        } @catch (NSException *exception) {
            NSLog(@"---- exception while setting the fontSize to subViews ----%@",exception);
        }
    }
    
    else{
        
    }
    
    @try {
        
        for (id view in stockRequestView.subviews) {
            [view setUserInteractionEnabled:NO];
        }
        
        stockRequestScrollView.userInteractionEnabled = YES;
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        cancelButton.userInteractionEnabled = YES;
        
    }
    @catch (NSException *exception) {
        
    }
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
 *
 * @modified BY
 * @reason
 * * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    @try {
        
        if (rawMaterialDetails  == nil) {
            [HUD setHidden:NO];
            rawMaterialDetails = [NSMutableArray new];
            [self callStockRequestDetails];
        }
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
    }
    @finally {
        
    }
    
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidAppear.......
 * @date         21/09/2016
 * @method       viewWillAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
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
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  -mark  start of service calls

/**
 * @description  here we are calling searchSku.......
 * @date         21/09/2016
 * @method       callStockRequestDetails
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       hiding the HUD in catch block....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callStockRequestDetails {
    @try {
        [HUD setHidden:NO];
        
        NSMutableDictionary * stockRequestDetailsDic = [[NSMutableDictionary alloc] init];
        
        stockRequestDetailsDic[IS_DRAFT_REQUIRED] = [NSNumber numberWithBool:true];
        stockRequestDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        stockRequestDetailsDic[STOCK_REQUEST_ID] = requestID;
        stockRequestDetailsDic[kLocation] = presentLocation;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:stockRequestDetailsDic options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockRequestDelegate = self;
        [webServiceController getAllStockRequest:quoteRequestJsonString];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"----exception in service Call------%@",exception);
    }
    
}



/**
 * @description  here we are sending the request for getting products.......
 * @date         20/0/2016
 * @method       callRawMaterials:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void) callRawMaterials:(NSString *)searchString {
    
    @try {
        
        [HUD setHidden:NO];
        
        NSMutableDictionary * searchProductDic = [[NSMutableDictionary alloc] init];
        
        searchProductDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        searchProductDic[START_INDEX] = @"0";
        searchProductDic[kSearchCriteria] = searchItemTxt.text;
        searchProductDic[kStoreLocation] = presentLocation;
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:searchProductDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.searchProductDelegate = self;
        [webServiceController searchProductsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
}


/**
 * @description  sending the request for getting skuList based on the item....
 * @date         20/0/2016
 * @method       callRawMaterialDetails:
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 *
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
//        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        [webServiceController getSKUStockInformation: salesReportJsonString];

    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"failed_to_get_the_details", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [HUD hide:YES afterDelay:1.0];
    
}

/**
 * @description  this method is used to get the locations based on bussinessActivty...
 * @date         21/09/2016
 * @method       getLocations
 * @author       Bhargav Ram
 * @param        int
 * @param        NSString
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       hiding the HUD in catch block....
 *
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getLocations:(int)selectIndex businessActivity:(NSString *)businessActivity{
    
    @try {
        
        
        NSArray *loyaltyKeys = @[START_INDEX,REQUEST_HEADER,BUSSINESS_ACTIVITY];
        
        NSArray *loyaltyObjects = @[@"0",[RequestHeader getRequestHeader],businessActivity];
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.utilityMasterDelegate = self;
        [webServiceController getAllLocationDetailsData:loyaltyString];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
}


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
        if(categoriesArr == nil){
            categoriesArr  = [NSMutableArray new];
            checkBoxArr    = [NSMutableArray new];
        }
        NSMutableDictionary * locationWiseCategoryDictionary = [[NSMutableDictionary alloc]init];
        
        [locationWiseCategoryDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [locationWiseCategoryDictionary setValue:presentLocation forKey:kStoreLocation];
        
        
        [locationWiseCategoryDictionary setValue:@"-1" forKey:START_INDEX_STR];
        
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
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling callingCategories List ServicesCall ----%@",exception);
    } @finally {
        
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

-(void)getCategoriesByLocationSuccessResponse:(NSDictionary*)sucessDictionary {
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





#pragma -mark action used in this page with service calls

/**
 * @description  here we are sending the requestfor Update StockRequest...
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


- (void)submitButonPressed:(UIButton *)sender {
    @try {
        
        //paly audio for the button touch...
        AudioServicesPlaySystemSound(soundFileObject);
        
        Boolean isZeroQty = false;
        
        for(NSDictionary * dic in rawMaterialDetails){
            
            if([[dic valueForKey:QUANTITY] floatValue] <= 0.00)
                isZeroQty = true;
            
        }
        
        if([sender.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ){
            
            @try {
                
                for (id view in stockRequestView.subviews) {
                    [view setUserInteractionEnabled:YES];
                }
                
                //toStoreLocTxt.userInteractionEnabled = NO;
                toLocationTxt.userInteractionEnabled = NO;
                requestIdTxt.userInteractionEnabled   = NO;
                RequestDteTxt.userInteractionEnabled  = NO;
                deliveryDateTxt.userInteractionEnabled= NO;
                shipmentModeTxt.userInteractionEnabled= NO;
                outletIdTxt.userInteractionEnabled    = NO;
                zoneIdTxt.userInteractionEnabled      = NO;
                priorityTxt.userInteractionEnabled    = NO;
                actionRequiredTxt.userInteractionEnabled = NO;
                
            }
            @catch (NSException *exception) {
                
            }
            
            [requestedItemsTbl reloadData];
            [submitBtn setTitle:NSLocalizedString(@"submit", nil) forState:UIControlStateNormal];
            
        }
        
        else if (isZeroQty && (saveBtn.tag != submitBtn.tag)){
            
            //
            conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"please_verify_zeroQty_items_are_available", nil) message:nil delegate:self cancelButtonTitle:@"CONTINUE" otherButtonTitles:@"NO", nil];
            conformationAlert.tag = sender.tag;
            [conformationAlert show];
        }
        
        else if (!isZeroQty && (saveBtn.tag != submitBtn.tag)){
            
            // added by roja on 06-07-2018....
            if ( (actionRequiredTxt.text).length > 0 ) {
                
                conformationAlert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat:NSLocalizedString(@"do you want to %@ this indent ", nil),actionRequiredTxt.text ]  message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
                actionRequiredTxt.placeholder = actionRequiredTxt.text;
                conformationAlert.tag = sender.tag;
                [conformationAlert show];
            }
            else {
                
                    conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_you_want_to_submit_this_indent", nil)  message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
                    conformationAlert.tag = sender.tag;
                    [conformationAlert show];
            }
        }
        
        
        else {
            
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user interaction after servcie calls...
            
            submitBtn.userInteractionEnabled = NO;
            saveBtn.userInteractionEnabled = NO;
            
            //upto here on 02/05/2018....
            
            [HUD show: YES];
            [HUD setHidden:NO];
            
            float  totalRequestAmount  = 0;
            // added by roja on 04-07-2018....
            float requestedNoOfItems = 0;
            requestedNoOfItems = rawMaterialDetails.count;

            
            NSMutableArray    * tempArr = [NSMutableArray new];
            
            for(NSDictionary * locDic  in rawMaterialDetails){
                
                NSMutableDictionary * temp = [locDic mutableCopy];
                
                float  totalAmount  = 0;
                float estimatedCost = 0;
              
                totalAmount = [[locDic  valueForKey:iTEM_PRICE] floatValue] * [[locDic  valueForKey:kApprovedQty] floatValue];
                totalRequestAmount = totalRequestAmount + totalAmount;
                [temp setValue:[NSString stringWithFormat:@"%.2f",totalAmount ] forKey:TOTAL_COST];

                estimatedCost = [[locDic  valueForKey:iTEM_PRICE] floatValue] * [[locDic  valueForKey:QUANTITY] floatValue];
                [temp setValue:[NSString stringWithFormat:@"%.2f",estimatedCost ] forKey:ESTIMATED_COST];

                [tempArr addObject:temp];
                
            }
            
            NSMutableDictionary * updateStockRequestDic = [[NSMutableDictionary alloc]init];
            
            updateStockRequestDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            
            updateStockRequestDic[STOCK_REQUEST_ID] = requestIdTxt.text;
            updateStockRequestDic[FROM_STORE_CODE] = outletIdTxt.text;
            
            if ((toLocationTxt.text).length > 0)
              
                updateStockRequestDic[TO_STORE_CODE] = toLocationTxt.text;

            //if ([[requestViewReceiptJSON valueForKey:TO_WARE_HOUSE_ID] isEqualToString:@""]) {
            
            //}
            
            //else {
            //[updateStockRequestDic setObject:[self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:TO_WARE_HOUSE_ID] defaultReturn:@""] forKey:TO_WARE_HOUSE_ID];
            //}
            
            updateStockRequestDic[REQUEST_DATE_STR] = RequestDteTxt.text;
            
            NSString * deliveryDteStr = deliveryDateTxt.text;
            
            if(deliveryDteStr.length > 1)
                deliveryDteStr = [NSString stringWithFormat:@"%@", deliveryDateTxt.text];
            
            updateStockRequestDic[DELIVERY_DATE_STR] = deliveryDteStr;
            updateStockRequestDic[REQUESTED_USER_NAME] = RequestedBy.text;
            updateStockRequestDic[SHIPPING_MODE] = shipmentModeTxt.text;
            updateStockRequestDic[SHIPPING_COST] = @200.00f;
            updateStockRequestDic[REMARKS] = @"";
            updateStockRequestDic[TOTAL_STOCK_REQUEST_VALUE] = @(totalRequestAmount);

            
            //changed by Srinivasulu on 18/01/2017....
            NSString * updateStatuStr = [requestViewReceiptJSON  valueForKey:STATUS];
            
            //            if(!([actionRequiredTxt.text isEqualToString:NSLocalizedString(@"action_required", nil)] && ![actionRequiredTxt.text isEqualToString:@""]) && [actionRequiredTxt.text length] > 0);
            if ((actionRequiredTxt.text).length > 0)
                updateStatuStr = actionRequiredTxt.text;
            
            //upto here on 18/01/2017....
            
            updateStockRequestDic[STATUS] = updateStatuStr;
            
            updateStockRequestDic[PRIORITY] = priorityTxt.text;
            updateStockRequestDic[STOCK_REQUEST_ITEMS] = tempArr;
            
            //changed by Srinivaslulu on 19/01/2017...
            if ([requestViewReceiptJSON.allKeys containsObject:REQUEST_APPROVED_BY] &&  ![[requestViewReceiptJSON valueForKey:REQUEST_APPROVED_BY] isKindOfClass:[NSNull class]])
                updateStockRequestDic[REQUEST_APPROVED_BY] = [requestViewReceiptJSON valueForKey:REQUEST_APPROVED_BY];
            
            if ([requestViewReceiptJSON.allKeys containsObject:REASON] &&  ![[requestViewReceiptJSON valueForKey:REASON] isKindOfClass:[NSNull class]])
                updateStockRequestDic[REASON] = [requestViewReceiptJSON valueForKey:REASON];
            
            //upto here on 19/01/2017...
            
            // added by roja on 04-07-2018....
            updateStockRequestDic[NO_OF_ITEMS] = @(requestedNoOfItems);

            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:updateStockRequestDic options:0 error:&err];
            //NSString * updateString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController *webServiceController = [WebServiceController new];
            webServiceController.stockRequestDelegate = self;
            [webServiceController updateStockRequest:jsonData];
        }
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in service Call------%@",exception);
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
    }
    @finally {
        
    }
    
}



/**
 * @description  here we are sending the requestfor StockRequest Creation...
 * @date         10/11/2017
 * @method       didDismissWithButtonIndex:
 * @author       Bhargav Ram
 * @param        UIAlertView
 * @param        NSInteger
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    
    if (alertView == conformationAlert) {
        
        if (buttonIndex == 0) {
            
            saveBtn.tag = conformationAlert.tag;
            
            [self submitButonPressed:saveBtn];
        }
        else {
            
            saveBtn.tag = 2;
            
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
        }
    }
    else if (alertView == delItemAlert) {
        
        if (buttonIndex == 0) {
            
            delItemAlert.tag = 4;
            
            [self delRow:delrowbtn];
            
        }
        else {
            
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
        }
    }
}


#pragma -mark start of handling service call reponses

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getStockRequestsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @modified By  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 * @return
 * @verified By
 * @verified On
 */

- (void)getStockRequestsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        nextActivitiesArr = [NSMutableArray new];
        
        NSArray * requestsArr = [successDictionary valueForKey:STOCK_REQUESTS];
        
        for (NSDictionary * receiptDic in requestsArr) {
            if ([[receiptDic valueForKey:STOCK_REQUEST_ID] isEqualToString:requestID]) {
                
                requestViewReceiptJSON = [receiptDic copy];
            }
            
            // showing the next activities
            if([[receiptDic valueForKey:NEXT_ACTIVITIES] count] || [[receiptDic valueForKey:NEXT_WORK_FLOW_STATES] count]){
                
                [nextActivitiesArr addObject:NSLocalizedString(@"--select--", nil)];
                for(NSString * str in [receiptDic valueForKey:NEXT_ACTIVITIES])
                    [nextActivitiesArr addObject:str];
                
                for(NSString * str in [receiptDic valueForKey:NEXT_WORK_FLOW_STATES])
                    [nextActivitiesArr addObject:str];
            }
            //upto here.....
            
            if(nextActivitiesArr.count == 0){
                [nextActivitiesArr addObject:NSLocalizedString(@"no_more_activities", nil)];
                
                submitBtn.hidden = YES;
                saveBtn.hidden = YES;
                
                cancelButton.frame = CGRectMake(stockRequestView.frame.size.width/2.5 -cancelButton.frame.size.width/2, cancelButton.frame.origin.y,cancelButton.frame.size.width,cancelButton.frame.size.height);
            }
            
            //changed by Srinivasulu on 14/04/2017....
            
            if(([requestViewReceiptJSON.allKeys containsObject:DELIVERY_DATE_STR]) &&  (![[requestViewReceiptJSON valueForKey:DELIVERY_DATE_STR] isKindOfClass: [NSNull class]]) && ([[requestViewReceiptJSON valueForKey:DELIVERY_DATE_STR] componentsSeparatedByString:@" "].count) )
                deliveryDateTxt.text =  [[requestViewReceiptJSON valueForKey:DELIVERY_DATE_STR] componentsSeparatedByString:@" "][0];
            
            if(([requestViewReceiptJSON.allKeys containsObject:REQUEST_DATE_STR]) &&  (![[requestViewReceiptJSON valueForKey:REQUEST_DATE_STR] isKindOfClass: [NSNull class]]) && ([[requestViewReceiptJSON valueForKey:REQUEST_DATE_STR] componentsSeparatedByString:@" "].count) )
                RequestDteTxt.text = [[requestViewReceiptJSON valueForKey:REQUEST_DATE_STR] componentsSeparatedByString:@" "][0];
           
            //if ([[requestViewReceiptJSON valueForKey:TO_WARE_HOUSE_ID] isEqualToString:@""]) {

                toLocationTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:TO_STORE_CODE] defaultReturn:@""];

            //}
            //else {
                
              //  toLocationLbl.text = NSLocalizedString(@"to_warehouse", nil);
              //  toLocationTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:TO_WARE_HOUSE_ID] defaultReturn:@""];

            //}

            requestIdTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:STOCK_REQUEST_ID] defaultReturn:@""];
            RequestedBy.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:REQUESTED_USER_NAME] defaultReturn:@""];
            shipmentModeTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:SHIPPING_MODE] defaultReturn:@""];
           
            outletIdTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:FROM_STORE_CODE] defaultReturn:@""];
            priorityTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:kPriority] defaultReturn:@""];
            
            //totalQtyValueLbl.text = [NSString stringWithFormat:@"%.2f",[[requestViewReceiptJSON objectForKey:TOTAL_STOCK_REQUEST_VALUE] floatValue]];
            
            NSArray * items = requestViewReceiptJSON[STOCK_REQUEST_ITEMS];
            float quantityOnHand    = 0.0;
            float previousIndentQty = 0.0;
            float projectedQty      = 0.0;
            float requestedQuantity = 0.0;
            float approvedQty       = 0.0;
            
            for (int i = 0; i < items.count; i++) {
                NSDictionary * itemDic = items[i];
                
                quantityOnHand    += [[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:AVL_QTY] defaultReturn:@"0.00"] intValue];
                previousIndentQty += [[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] intValue];
                projectedQty      += ([[itemDic valueForKey:AVL_QTY] floatValue] + [[itemDic valueForKey:kPrvIndentQty] floatValue]);
                requestedQuantity += [[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] intValue];
                approvedQty       += [[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kApprovedQty] defaultReturn:@"0.00"] intValue];
                
                // adding Keys...
                // added by roja on 04-07-2018....
                
                NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc]init];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_DESC] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue]] forKey:kApprovedQty];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:AVL_QTY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:MEASUREMENT_RANGE] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:kBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:kProductId];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ESTIMATED_COST] defaultReturn:@"0.00"] floatValue]] forKey:ESTIMATED_COST];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:iTEM_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:iTEM_PRICE];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:EAN] defaultReturn:EMPTY_STRING] forKey:EAN];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:QOH] defaultReturn:EMPTY_STRING] forKey:QOH];
                
                [rawMaterialDetails addObject:itemDetailsDic];
            }
                
                
            
            quantityOnHandValueLbl.text = [NSString stringWithFormat:@"%.2f",quantityOnHand];
            previousQtyValueLbl.text    = [NSString stringWithFormat:@"%.2f",previousIndentQty];
            projectedQtyValueLbl.text   = [NSString stringWithFormat:@"%.2f",projectedQty];
            requestedQtyvalueLbl.text   = [NSString stringWithFormat:@"%.2f",requestedQuantity];
            approvedQtyValueLbl.text    = [NSString stringWithFormat:@"%.2f",approvedQty];
            
            [requestedItemsTbl reloadData];
            
            UIImage *workArrowImg = [UIImage imageNamed:@"workflow_arrow.png"];
            
            UIImageView *workFlowImageView = [[UIImageView alloc] init];
            
            workFlowImageView.image = workArrowImg;
            
            [workFlowView addSubview:workFlowImageView];
            
            NSArray * workFlowArr;
            
            workFlowArr = [receiptDic valueForKey:PREVIOUS_STATES];
            
            workFlowImageView.frame = CGRectMake(workFlowView.frame.origin.x,5,workFlowView.frame.size.height + 30 , workFlowView.frame.size.height - 10);
            
            float label_x_origin = workFlowImageView.frame.origin.x + workFlowImageView.frame.size.width;
            float label_y_origin = workFlowImageView.frame.origin.y;
            
            float labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width)/ ((workFlowArr.count * 2 ) - 1)   ;
            float labelHeight = workFlowImageView.frame.size.height;
            
            if( workFlowArr.count <= 3 )
                //taking max as 5 labels.....
                labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width - 380)/4;
            
            for(NSString *str  in workFlowArr){
                
                UILabel *workFlowNameLbl;
                UILabel *workFlowLineLbl;
                
                workFlowNameLbl = [[UILabel alloc] init];
                workFlowNameLbl.layer.masksToBounds = YES;
                workFlowNameLbl.numberOfLines = 2;
                workFlowNameLbl.textAlignment = NSTextAlignmentCenter;
                workFlowNameLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
                //            workFlowNameLbl.text = @"Closed-----Cancelled";
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
            
            isInEditableState = false;
            
            if([[self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:STATUS] defaultReturn:@""] caseInsensitiveCompare:SUBMITTED]  == NSOrderedSame){
                
                isInEditableState = true;
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD hide: YES];
    }
}



/**
 * @description  here we are handling the error response from the service.......
 * @date         21/09/2016
 * @method       getStockRequestsErrorResponse
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getStockRequestsErrorResponse:(NSString *)errorResponse{
    
    @try {
        [HUD setHidden:YES];
        
        
        float y_axis = self.view.frame.size.height - 200;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
        
    } @catch (NSException *exception) {
        NSLog(@"---------%@",exception );
        
    } @finally {
        
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
                    
                    [productList addObject:dic];
                }
            }
            
            if(productList.count){
                float tableHeight = productList.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = productList.count * 33;
                
                if(productList.count > 5)
                    tableHeight = (tableHeight/productList.count) * 5;
                
                [self showPopUpForTables:productListTbl  popUpWidth:searchItemTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItemTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp];
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
    
    @catch (NSException *exception) {
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        searchItemTxt.tag = 0;
        [HUD setHidden:YES];
        
    }
    @finally {
        
    }
}

/**
 * @description  here we are handling the error resposne received from services.......
 * @date         20/0/2016
 * @method       searchProductsErrorResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsErrorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        
        float y_axis = self.view.frame.size.height - 200;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
    }
    
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getSkuDetailsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
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
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kApprovedQty] intValue] + 1] forKey:kApprovedQty];

                            rawMaterialDetails[i] = dic;
                            
                            status = TRUE;
                            break;
                        }
                    }
                }
                
                
                // adding keys....
                // added by roja on 04/07/2018....
                
                if (!status) {
                    
                    NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary *itemdic = itemArray[0];
                        
                        NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:iTEM_PRICE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kApprovedQty];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QOH];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:EMPTY_STRING] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:kProductId];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];

              

             
                        //Checking is isPacked item based on the Boolean value
                        
                        float qty = 0;
                        
                        if (qty == 0) {
                            
                            BOOL isPackedItem = false;
                            
                            int minimumQty = 0;
                            
                            if ([itemdic.allKeys containsObject:kPackagedType] && ![itemdic[kPackagedType] isKindOfClass:[NSNull class]]) {
                                
                                if([itemdic[kPackagedType] boolValue]){
                                    minimumQty = 1;
                                    isPackedItem = true;
                                }
                            }
                        }
                        
                        if ([itemdic.allKeys containsObject:kPackagedType] && ![itemdic[kPackagedType] isKindOfClass:[NSNull class]]) {
                            
                            [isPacked addObject:@([itemdic[kPackagedType] boolValue])];
                        }
                        else {
                            
                            [isPacked addObject:[NSNumber numberWithBool:FALSE]];
                        }
                        
                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                    else
                        
                        rawMaterialDetails[i] = dic;
                }
                
                [self calculateTotal];
            }
        }
    }
    
    @catch (NSException * exception) {
        NSLog(@"-------exception will reading.-------%@",exception);
    }
    @finally{
        [HUD setHidden:YES];
        [requestedItemsTbl reloadData];
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getSkuDetailsErrorResponse:
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


- (void)getSkuDetailsErrorResponse {
    [HUD setHidden:YES];
    UIAlertView * alert=  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"sorry", nil) message:NSLocalizedString(@"product_not_available", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

/**
 * @description  here we are handling the error response from the service....
 * @method       getSkuDetailsErrorResponse
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSkuDetailsErrorResponse:(NSString*)failureString{
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 350;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",failureString];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        
    }
    
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       updateStockRequestsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)updateStockRequestsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        [HUD setHidden:YES];
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_request_updated_Successfully",nil),@"\n", [successDictionary valueForKey:REQUEST_ID]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       updateStockRequestsErrorResponse:
 * @author       Bhargav Ram
 * @param        NSString
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

-(void)updateStockRequestsErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
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
 * @method       getLocationSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocationSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        for(NSDictionary *dic in [successDictionary valueForKey:LOCATIONS_DETAILS]){
            
            [locationArr addObject: dic];
            
        }
        
    } @catch (NSException *exception) {
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    @finally {
        [HUD setHidden:YES];
    }
}



/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getLocationErrorResponse:
 * @author       Bhargav Ram
 * @param        NSString
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

-(void)getLocationErrorResponse:(NSString *)errorResponse{
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
    
}


#pragma -mark actions used in this page....
/**
 * @description  displaying popOver for the shipment Mode.......
 * @date         20/0/2016
 * @method       getShipmentModes::
 * @author       Bhargav Ram
 * @param        UIButton
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


-(void)getShipmentModes:(UIButton*)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    shipModesArr = [NSMutableArray new];
    [shipModesArr addObject:NSLocalizedString(@"rail", nil)];
    [shipModesArr addObject:NSLocalizedString(@"flight", nil)];
    [shipModesArr addObject:NSLocalizedString(@"express", nil)];
    [shipModesArr addObject:NSLocalizedString(@"ordinary", nil)];
    
    int count  = 5 ;
    
    if (shipModesArr.count < count) {
        count = (int)shipModesArr.count;
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
        
        [popover presentPopoverFromRect:shipmentModeTxt.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
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
    
}

/**
 * @description  displaying popOver for the priority List.......
 * @date         20/0/2016
 * @method       populatePriorityList:
 * @author       Bhargav Ram
 * @param        UIButton
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
-(void) populatePriorityList:(UIButton *)sender {
    
    
    AudioServicesPlaySystemSound(soundFileObject);
    @try {
        priorityArr = [NSMutableArray new];
        [priorityArr addObject:NSLocalizedString(@"normal", nil)];
        [priorityArr addObject:NSLocalizedString(@"low", nil)];
        [priorityArr addObject:NSLocalizedString(@"medium", nil)];
        [priorityArr addObject:NSLocalizedString(@"high", nil)];
        
        int count = 5;
        
        
        if (priorityArr.count < count) {
            count = (int)priorityArr.count;
        }
        
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, shipmentModeTxt.frame.size.width, count * 45)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        priorityTbl = [[UITableView alloc] init];
        priorityTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        priorityTbl.dataSource = self;
        priorityTbl.delegate = self;
        (priorityTbl.layer).borderWidth = 1.0f;
        priorityTbl.layer.cornerRadius = 3;
        priorityTbl.layer.borderColor = [UIColor grayColor].CGColor;
        priorityTbl.separatorColor = [UIColor grayColor];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            priorityTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
        }
        
        
        [customView addSubview:priorityTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:priorityTxt.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        [priorityTbl reloadData];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       populateActionRequiredList
 * @author       Bhargav.v
 * @param        UIButton
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)populateActionRequiredList:(UIButton * )sender {
    
    
    AudioServicesPlaySystemSound(soundFileObject);
    @try {
        
        int count = 5;
        if (nextActivitiesArr.count < count) {
            count = (int)nextActivitiesArr.count;
        }
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, shipmentModeTxt.frame.size.width, count * 40)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        nextActivitiesTbl = [[UITableView alloc] init];
        nextActivitiesTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        nextActivitiesTbl.dataSource = self;
        nextActivitiesTbl.delegate = self;
        (nextActivitiesTbl.layer).borderWidth = 1.0f;
        nextActivitiesTbl.layer.cornerRadius = 3;
        nextActivitiesTbl.layer.borderColor = [UIColor grayColor].CGColor;
        nextActivitiesTbl.separatorColor = [UIColor grayColor];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            nextActivitiesTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
        }
        
        [customView addSubview:nextActivitiesTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:actionRequiredTxt.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        [nextActivitiesTbl reloadData];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  we are navigating the super class.......
 * @date         20/0/2016
 * @method       cancelButtonPressed:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)cancelButtonPressed:(UIButton *)sender {
    @try {
        AudioServicesPlaySystemSound(soundFileObject);
        
        [self backAction];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}

/**
 * @description  here we are deleting an item.......
 * @date         20/0/2016
 * @method       delRow:
 * @author       Bhargav Ram
 * @param        UIButton
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

- (void)delRow:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if (delItemAlert == nil || (delItemAlert.tag == 2)) {
            
            if (delItemAlert == nil)
                delItemAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"remove_this_item_from_the_list", nil) message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
            
            delrowbtn = sender;
            
            delItemAlert.tag = 2;
            [delItemAlert show];
        }
        
        else {
            
            delItemAlert.tag = 2;
            
            if(rawMaterialDetails.count >= sender.tag) {
                
                [rawMaterialDetails removeObjectAtIndex:sender.tag];
                
                [requestedItemsTbl reloadData];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [self  calculateTotal];
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
        
        UILabel * headerNameLbl;
        CALayer * bottomBorder;
        UIImage * checkBoxImg;
        UILabel * selectAllLbl;
        UIButton * okButton;
        UIButton * cancelBtn;
        
        headerNameLbl = [[UILabel alloc] init];
        headerNameLbl.layer.cornerRadius = 10.0f;
        headerNameLbl.layer.masksToBounds = YES;
        headerNameLbl.text = NSLocalizedString(@"categories_list", nil);
        
        headerNameLbl.textAlignment = NSTextAlignmentCenter;
        headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        
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
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
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
            
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
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
    
    
    if (textField.frame.origin.x == qtyChangeTxt.frame.origin.x || textField.frame.origin.x  == appQtyField.frame.origin.x)
        
        reloadTableData = false;
    
    return YES;
    
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldShouldBeginEditing .......
 * @date         26/09/2016
 * @method       textFieldDidBeginEditing:
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    @try {
        
        @try {
            
            if(textField == searchItemTxt){
                
                offSetViewTo = 120;
            }
            
            else if (textField.frame.origin.x == qtyChangeTxt.frame.origin.x || textField.frame.origin.x  == appQtyField.frame.origin.x) {
                
                [textField selectAll:nil];
                [UIMenuController sharedMenuController].menuVisible = NO;
                
                int count = (int)textField.tag;
                
                if(textField.tag > 9)
                    
                    count = 9;
                
                offSetViewTo = (textField.frame.origin.y + textField.frame.size.height) * count + requestedItemsTbl.frame.origin.y+15;
                
            }
            
            [self keyboardWillShow];
            
        } @catch (NSException *exception) {
            
        }
        
    } @catch (NSException *exception) {
        
    }
    
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
 * @date         26/09/2016
 * @method       shouldChangeCharactersInRange:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (textField.frame.origin.x == qtyChangeTxt.frame.origin.x || textField.frame.origin.x  == appQtyField.frame.origin.x) {
        
        @try {
            
            if ([isPacked[textField.tag] boolValue]) {
                
                NSUInteger lengthOfString = string.length;
                
                for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                    unichar character = [string characterAtIndex:loopIndex];
                    if (character < 48) return NO; // 48 unichar for 0
                    if (character > 57) return NO; // 57 unichar for 9
                }
            }
            
            else {
                
                NSString * newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
                NSError  * error = nil;
                NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
                return numberOfMatches != 0;
            }
            
        } @catch (NSException *exception) {
            
            //            NSLog(@"----exception in GoodsReceiptNoteView ----");
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

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchItemTxt){
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                if (searchItemTxt.tag == 0) {
                    
                    searchItemTxt.tag = (textField.text).length;
                    
                    productList = [[NSMutableArray alloc]init];
                    
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
    
    else if (textField.frame.origin.x == qtyChangeTxt.frame.origin.x|| textField.frame.origin.x == appQtyField.frame.origin.x) {
        reloadTableData = true;
        
        NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString * trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
        
        @try {
            NSString * qtyKey = QUANTITY;
            
            if(textField.frame.origin.x == appQtyField.frame.origin.x)
                
                qtyKey = kApprovedQty;
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            [temp setValue:textField.text  forKey:qtyKey];
            
            if([qtyKey isEqualToString:QUANTITY]) {
                
                [temp setValue:textField.text  forKey:kApprovedQty];
                
            }
            
            if( (textField.text).integerValue >[[temp valueForKey:QUANTITY] integerValue] ){
                
                NSString *mesg = NSLocalizedString(@"approved_qty_should_be_less_then_or_equal_to_requested_qty", nil);
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:(searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height + 100)   msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:120  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return;
            }
            
            if (trimmedString.length == 0)
                trimmedString = @"0";
            
            [temp setValue:trimmedString forKey:kApprovedQty];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException * exception) {
            NSLog(@"---%@",exception);
        }
        @finally {
            
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
 */

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    offSetViewTo = 0;
    
    if (textField.frame.origin.x== qtyChangeTxt.frame.origin.x||textField.frame.origin.x == appQtyField.frame.origin.x ) {
        
        NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString * trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
        
        @try {
            if ((textField.text).integerValue == 0) {
                
            }
            else{
                
                NSString * qtyKey = QUANTITY;
                
                if(textField.frame.origin.x == appQtyField.frame.origin.x)
                    qtyKey = kApprovedQty;
                
                NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
                [temp setValue:textField.text  forKey:qtyKey];
                
                if([qtyKey isEqualToString: QUANTITY]) {
                    
                    [temp setValue:textField.text  forKey:kApprovedQty];
                }
                
                if( (textField.text).integerValue > [[temp valueForKey:QUANTITY] integerValue] ){
                    
                    NSString * mesg = NSLocalizedString(@"approved_qty_should_be_less_then_or_equal_to_requested_qty", nil);
                    
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:(searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height + 100)   msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:120  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
                
                if (trimmedString.length == 0)
                    trimmedString = @"0";
                
                [temp setValue:trimmedString forKey:kApprovedQty];
                rawMaterialDetails[textField.tag] = temp;
                
            }
        }
        @catch (NSException *exception) {
            NSLog(@"---------%@",exception);
        }
        @finally {
            if(reloadTableData)
                [requestedItemsTbl reloadData];
            [self calculateTotal];
            
        }
    }
    
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
 * @date         26/09/2016
 * @method       textFieldShouldReturn:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma -mark start of UITableViewDelegateMethods

/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date         26/09/2016
 * @method       showCompleteStockRequestInfo: numberOfRowsInSection:
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
    if (tableView == productListTbl) {
        
        return productList.count;
    }
    
    else if (tableView == requestedItemsTbl) {
        
        @try {
            
            [self calculateTotal];
            
        } @catch (NSException * exception) {
            NSLog( @"-----exception in changing the frame sizes..----%@",exception);
        }
        
        
        return  rawMaterialDetails.count;
    }
    
    else if (tableView == shipModeTable) {
        return shipModesArr.count;
    }
    
    else if (tableView == priorityTbl) {
        return priorityArr.count;
    }
    
    //else if (tableView == locationTable) {
    
    //if (toStoreLocTxt.tag == 2  ) {
    //return [locationArr count];
    
    //}
    //else{
    
    //return [warehouseLocationArr count];
    //}
    //}
    
    else if (tableView == nextActivitiesTbl) {
        return nextActivitiesArr.count;
    }
    
    else if (tableView == priceTable) {
        return priceDic.count;
    }
    
    else if (tableView == categoriesTbl ) {
        
        return categoriesArr.count;
        
    }
    
    
    
    else
        return false;
}

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
    
    if (tableView == productListTbl || tableView == locationTable ||tableView == shipModeTable || tableView == priorityTbl || tableView == nextActivitiesTbl  || tableView == priceTable || tableView == categoriesTbl ) {
        return 40;
    }
    else if (tableView == requestedItemsTbl){
        
        return 38;
        
    }
    
    else
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
    
    
    if (tableView == productListTbl) {
        
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
            
            if (productList.count > indexPath.row){
                NSDictionary * dic = productList[indexPath.row];
                
                
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
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                    
                    skid.frame = CGRectMake( 0, 0, descLabl.frame.size.width + 1, hlcell.frame.size.height);
                    
                    skid.font = [UIFont systemFontOfSize:22];
                    
                    mrpPrice.frame = CGRectMake(skid.frame.origin.x + skid.frame.size.width, 0, mrpLbl.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    mrpPrice.font = [UIFont systemFontOfSize:22];
                    
                    price.font = [UIFont systemFontOfSize:22];
                    price.frame = CGRectMake(mrpPrice.frame.origin.x + mrpPrice.frame.size.width, 0, priceLabl.frame.size.width+2, hlcell.frame.size.height);
                }
                
            }
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        }
        return hlcell;
    }
    
    else if (tableView == requestedItemsTbl) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
                
                layer_1.frame = CGRectMake(S_No.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(S_No.frame.origin.x),1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException * exception) {
                
            }
        }
        
        @try {
            
            UILabel * itemNoLbl;
            UILabel * itemSkuIdLbl ;
            UILabel * itemDescLbl;
            //added by Srinivasulu on 11/05/2017...
            UILabel * itemUomLbl;
            UILabel * itemGradeLbl;
            
            UILabel * itemPriceLbl;
            UILabel * qoh_Lbl;
            UILabel * prv_Indent_Qty_Lbl;
            UILabel * proj_Qty_Lbl;
            
            
            
            UIButton * viewStockRequestBtn;
            
            UILabel * itemsCostLbl;
            
            
            
            itemsCostLbl = [[UILabel alloc] init];
            itemsCostLbl.backgroundColor = [UIColor clearColor];
            itemsCostLbl.layer.borderWidth = 0;
            itemsCostLbl.textAlignment = NSTextAlignmentCenter;
            itemsCostLbl.numberOfLines = 1;
            itemsCostLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            /*Creation of UIButton's used in this cell*/
            viewStockRequestBtn = [[UIButton alloc] init];
            //viewStockRequestBtn.backgroundColor = [UIColor blackColor];
            viewStockRequestBtn.titleLabel.textColor = [UIColor whiteColor];
            viewStockRequestBtn.userInteractionEnabled = YES;
            viewStockRequestBtn.tag = indexPath.row;
            
            //populating text into textFields....
            [viewStockRequestBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
            [viewStockRequestBtn setTitle:NSLocalizedString(@"more", nil) forState:UIControlStateNormal];
            viewStockRequestBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
            [viewStockRequestBtn addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            //upto here on 11/05//2017....
            
            
            
            itemNoLbl = [[UILabel alloc] init];
            itemNoLbl.backgroundColor = [UIColor clearColor];
            itemNoLbl.layer.borderWidth = 0;
            itemNoLbl.textAlignment = NSTextAlignmentCenter;
            itemNoLbl.numberOfLines = 1;
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
//            itemDescLbl.lineBreakMode = NSLineBreakByWordWrapping;
            itemDescLbl.lineBreakMode = NSLineBreakByTruncatingTail;

            
            itemUomLbl = [[UILabel alloc] init];
            itemUomLbl.backgroundColor = [UIColor clearColor];
            itemUomLbl.layer.borderWidth = 0;
            itemUomLbl.textAlignment = NSTextAlignmentCenter;
            itemUomLbl.numberOfLines = 1;
            itemUomLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemGradeLbl = [[UILabel alloc] init];
            itemGradeLbl.backgroundColor = [UIColor clearColor];
            itemGradeLbl.layer.borderWidth = 0;
            itemGradeLbl.textAlignment = NSTextAlignmentCenter;
            itemGradeLbl.numberOfLines = 1;
//            itemGradeLbl.lineBreakMode = NSLineBreakByWordWrapping;
            itemGradeLbl.lineBreakMode = NSLineBreakByTruncatingTail;

            itemPriceLbl = [[UILabel alloc] init];
            itemPriceLbl.backgroundColor = [UIColor clearColor];
            itemPriceLbl.layer.borderWidth = 0;
            itemPriceLbl.textAlignment = NSTextAlignmentCenter;
            itemPriceLbl.numberOfLines = 1;
            itemPriceLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            qoh_Lbl = [[UILabel alloc] init];
            qoh_Lbl.backgroundColor = [UIColor clearColor];
            qoh_Lbl.layer.borderWidth = 0;
            qoh_Lbl.textAlignment = NSTextAlignmentCenter;
            qoh_Lbl.numberOfLines = 1;
            qoh_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            prv_Indent_Qty_Lbl = [[UILabel alloc] init];
            prv_Indent_Qty_Lbl.backgroundColor = [UIColor clearColor];
            prv_Indent_Qty_Lbl.layer.borderWidth = 0;
            prv_Indent_Qty_Lbl.textAlignment = NSTextAlignmentCenter;
            prv_Indent_Qty_Lbl.numberOfLines = 1;
            prv_Indent_Qty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            proj_Qty_Lbl = [[UILabel alloc] init];
            proj_Qty_Lbl.backgroundColor = [UIColor clearColor];
            proj_Qty_Lbl.layer.borderWidth = 0;
            proj_Qty_Lbl.textAlignment = NSTextAlignmentCenter;
            proj_Qty_Lbl.numberOfLines = 1;
            proj_Qty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            qtyChangeTxt = [[UITextField alloc] init];
            qtyChangeTxt.borderStyle = UITextBorderStyleRoundedRect;
            qtyChangeTxt.textColor = [UIColor blackColor];
            qtyChangeTxt.keyboardType = UIKeyboardTypeNumberPad;
            qtyChangeTxt.layer.borderWidth = 2;
            qtyChangeTxt.backgroundColor = [UIColor clearColor];
            qtyChangeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            qtyChangeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            qtyChangeTxt.returnKeyType = UIReturnKeyDone;
            qtyChangeTxt.delegate = self;
            [qtyChangeTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            qtyChangeTxt.textAlignment = NSTextAlignmentCenter;
            qtyChangeTxt.keyboardType = UIKeyboardTypeNumberPad;
            qtyChangeTxt.tag = indexPath.row;
            
            
            appQtyField = [[UITextField alloc] init];
            appQtyField.borderStyle = UITextBorderStyleRoundedRect;
            appQtyField.textColor = [UIColor blackColor];
            appQtyField.keyboardType = UIKeyboardTypeNumberPad;
            appQtyField.layer.borderWidth = 2;
            appQtyField.backgroundColor = [UIColor clearColor];
            appQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
            appQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
            appQtyField.returnKeyType = UIReturnKeyDone;
            appQtyField.delegate = self;
            [appQtyField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            appQtyField.textAlignment = NSTextAlignmentCenter;
            appQtyField.keyboardType = UIKeyboardTypeNumberPad;
            appQtyField.tag = indexPath.row;
            
            qtyChangeTxt.userInteractionEnabled = YES;
            
            appQtyField.userInteractionEnabled = NO;
            
            if(isInEditableState && isHubLevel ) {
                
                appQtyField.userInteractionEnabled = YES;
            }
            
            if([submitBtn.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)]){
                
                qtyChangeTxt.userInteractionEnabled = NO;
                appQtyField.userInteractionEnabled  = NO;
            }
            
            delrowbtn = [[UIButton alloc] init];
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            itemNoLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemSkuIdLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemDescLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemUomLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemGradeLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemPriceLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            qoh_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            prv_Indent_Qty_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            proj_Qty_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            qtyChangeTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            appQtyField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemNoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemSkuIdLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemDescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemUomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemGradeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemPriceLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            qoh_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            prv_Indent_Qty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            proj_Qty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            qtyChangeTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            appQtyField.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            //upto here on 11/05//2017....
            
            [hlcell.contentView addSubview:itemNoLbl];
            [hlcell.contentView addSubview:itemSkuIdLbl];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemUomLbl];
            [hlcell.contentView addSubview:itemGradeLbl];
            [hlcell.contentView addSubview:itemPriceLbl];
            [hlcell.contentView addSubview:qoh_Lbl];
            [hlcell.contentView addSubview:prv_Indent_Qty_Lbl];
            [hlcell.contentView addSubview:proj_Qty_Lbl];
            
            [hlcell.contentView addSubview:qtyChangeTxt];
            [hlcell.contentView addSubview:appQtyField];
            
            [hlcell.contentView addSubview:delrowbtn];
            [hlcell.contentView addSubview:viewStockRequestBtn];
            
            @try {
                
                NSDictionary * temp = rawMaterialDetails[indexPath.row];
                
                itemNoLbl.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1) ];
                
                itemSkuIdLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SKU] defaultReturn:@"--"];//ITEM_SKU
                
                itemDescLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_DESC] defaultReturn:@"--"];
                
                if ([[temp valueForKey:SELL_UOM]isKindOfClass:[NSNull class]]|| (![[temp valueForKey:SELL_UOM]isEqualToString:@""])) {
                    
                    itemUomLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:SELL_UOM] defaultReturn:@"--"];
                }
                else
                    itemUomLbl.text = @"--";
                
                if ([[temp valueForKey:PRODUCT_RANGE]isKindOfClass:[NSNull class]]|| (![[temp valueForKey:PRODUCT_RANGE]isEqualToString:@""])) {
                    
                    itemGradeLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
                }
                else
                    itemGradeLbl.text = @"--";
                
                itemPriceLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue]];
                
                qoh_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[temp valueForKey:AVL_QTY] defaultReturn:@"0.00"] floatValue]];
                
                prv_Indent_Qty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[temp valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]];
                
                proj_Qty_Lbl.text = [NSString stringWithFormat:@"%.2f",(qoh_Lbl.text).floatValue + (prv_Indent_Qty_Lbl.text).floatValue];
                
                qtyChangeTxt.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                appQtyField.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue]];
                
            }
            @catch (NSException *exception) {
                
            }
            
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                
                if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                    itemNoLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    itemSkuIdLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    itemDescLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    itemUomLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    itemGradeLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    itemPriceLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    qoh_Lbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    prv_Indent_Qty_Lbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    proj_Qty_Lbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    
                    qtyChangeTxt.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    appQtyField.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    
                }
                else{
                    
                }
                
                //changed by Srinivasulu on 14/04/2017.....
                
                itemNoLbl.frame = CGRectMake( S_No.frame.origin.x, 0, S_No.frame.size.width, hlcell.frame.size.height);
                
                itemSkuIdLbl.frame = CGRectMake( skuId.frame.origin.x, 0, skuId.frame.size.width,  hlcell.frame.size.height);
                
                itemDescLbl.frame = CGRectMake( descriptionLbl.frame.origin.x, 0, descriptionLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemUomLbl.frame= CGRectMake( uomLbl.frame.origin.x, 0, uomLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemGradeLbl.frame= CGRectMake( gradeLbl.frame.origin.x, 0, gradeLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemPriceLbl.frame = CGRectMake( priceLbl.frame.origin.x, 0, priceLbl.frame.size.width,  hlcell.frame.size.height);
                
                qoh_Lbl.frame = CGRectMake( qohLbl.frame.origin.x, 0, qohLbl.frame.size.width,  hlcell.frame.size.height);
                
                prv_Indent_Qty_Lbl.frame = CGRectMake( prvIndentQtyLbl.frame.origin.x, 0, prvIndentQtyLbl.frame.size.width,  hlcell.frame.size.height);
                proj_Qty_Lbl.frame = CGRectMake(projQtyLbl.frame.origin.x, 0, projQtyLbl.frame.size.width,  hlcell.frame.size.height);
                qtyChangeTxt.frame = CGRectMake( qtyLbl.frame.origin.x + 2, 2, qtyLbl.frame.size.width - 4,  36);
                
                appQtyField.frame = CGRectMake( appQtyLbl.frame.origin.x + 2, 2, appQtyLbl.frame.size.width - 4,  36);
                
                viewStockRequestBtn.frame = CGRectMake(actionLbl.frame.origin.x,0,actionLbl.frame.size.width-30,  hlcell.frame.size.height-5);
                delrowbtn.frame= CGRectMake(viewStockRequestBtn.frame.origin.x+viewStockRequestBtn.frame.size.width,5,35,35);
                
            }
            else{
                
            }
            
            
        } @catch (NSException *exception) {
            
            
        } @finally {
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
        
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
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:shipModesArr[indexPath.row]  defaultReturn:@"--"];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:18];
        
        return hlcell;
    }
    
    else if (tableView == priorityTbl) {
        
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
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:priorityArr[indexPath.row]  defaultReturn:@""];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:18];
        
        return hlcell;
    }
    
    else if(tableView == nextActivitiesTbl){
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
            hlcell.textLabel.text = nextActivitiesArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
    }
    
    
    else if (tableView == categoriesTbl){
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
            
            //added by Bhargav.v on 07/03/2017....
            
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
            
//            // added by roja on 06-07-2018...
//            if ( [[checkBoxArr objectAtIndex: ALL] integerValue] ) {
//
//                if (selectAllCheckBoxBtn.tag == 4 ) {
//                     checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
//                    [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
//                }
//            }
            

            
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
                
            } @finally {
                
            }
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    
    return false;
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
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //dismissing the catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
    
    if (tableView == productListTbl) {
        //Changes Made Bhargav.v
        //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
        //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
        
        NSDictionary * detailsDic = productList[indexPath.row];
        
        NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[sku_ID]];
        
        if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
            
            inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
        }
        
        [self callRawMaterialDetails:inputServiceStr];
        
        searchItemTxt.text = @"";
        
    }
    
    else if (tableView == shipModeTable) {
        AudioServicesPlaySystemSound (soundFileObject);
        
        shipmentModeTxt.text = shipModesArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    else if (tableView == priorityTbl) {
        AudioServicesPlaySystemSound (soundFileObject);
        
        priorityTxt.text = priorityArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    
    //    else if (tableView == locationTable){
    //        AudioServicesPlaySystemSound (soundFileObject);
    //
    //
    //        if (toStoreLocTxt.tag == 2  ) {
    //            toStoreLocTxt.text = [[locationArr objectAtIndex:indexPath.row] valueForKey:LOCATION_ID];
    //            [catPopOver dismissPopoverAnimated:YES];
    //        }
    //        else{
    //            toLocationTxt.text = [[warehouseLocationArr objectAtIndex:indexPath.row] valueForKey:LOCATION_ID];
    //            [catPopOver dismissPopoverAnimated: YES];
    //        }
    //    }
    
    else if(tableView == nextActivitiesTbl){
        
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            if(indexPath.row == 0)
                actionRequiredTxt.text = @"";
            else
                actionRequiredTxt.text = nextActivitiesArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
            NSLog(@"----exception changing the textField text in didSelectRowAtIndexPath:----%@",exception);
        }
        
    }
    
    else if (tableView == priceTable){
        
        //added by Srinisulu on 14/04/2017 expansion handling....
        
        @try {
            
            transparentView.hidden = YES;
            
            NSDictionary *detailsDic = priceDic[indexPath.row];
            
            BOOL status = FALSE;
            
            int i=0;
            NSMutableDictionary *dic;
            
            for ( i=0; i<rawMaterialDetails.count;i++) {
                
                dic = rawMaterialDetails[i];
                if ([[dic valueForKey:ITEM_SKU] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]]) {
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kApprovedQty] intValue] + 1] forKey:kApprovedQty];
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                    
                    
                    rawMaterialDetails[i] = dic;
                    
                    status = TRUE;
                    break;
                }
            }
            
            if (!status) {
                
                
                NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
                
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_SKU] defaultReturn:@"--"] forKey:ITEM_SKU];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PLU_CODE] defaultReturn:@"--"] forKey:PLU_CODE];
                
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"] forKey:ITEM_DESC];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_PRICE];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:QUANTITY];
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kApprovedQty];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                
                //newly added keys....
                //added by  Srinivasulu on  14/04/2017....
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:AVAILABLE_QTY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kMeasureRange] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kProductBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                
                //upto here on 13/04/2017.....
                
                [rawMaterialDetails addObject:itemDetailsDic];
            }
            else
                rawMaterialDetails[i] = dic;
            
            // [requestedItemsTbl reloadData];
            
            //        requestedItemsTbl.hidden=NO;
            
            [self calculateTotal];
            
            [requestedItemsTbl reloadData];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    //    else if (tableView == categoriesTbl) {
    //
    //        [categoriesPopOver dismissPopoverAnimated:YES];
    //
    //        @try {
    //
    //            NSString * categoryStr = [categoriesArr objectAtIndex:indexPath.row];
    //
    //            [HUD show:YES];
    //            [HUD setHidden:NO];
    //            HUD.labelText = @"Loading Please Wait..";
    //
    //            [self getPriceLists:categoryStr];
    //
    //        }
    //        @catch (NSException *exception) {
    //            [HUD setHidden:YES];
    //        }
    //        @finally {
    //
    //        }
    //    }
    //    [self calculateTotal];
    //    [requestedItemsTbl reloadData];
    
}


#pragma -mark calculationTotal

/**
 * @description  here we are calculating the Totalprice of order..........
 * @date         27/09/2016
 * @method       calculateTotal
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)calculateTotal{
    
    float quantityOnHand    = 0.0;
    float previousIndentQty = 0.0;
    float projectedQty      = 0.0;
    float requestedQuantity = 0.0;
    float approvedQty       = 0.0;
    
    for(NSDictionary * dic in rawMaterialDetails){
        
        quantityOnHand    += [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVL_QTY] defaultReturn:@"0.00"]floatValue];
        
        previousIndentQty += [[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrvIndentQty] defaultReturn:@"0.00"]floatValue];
        
        projectedQty      += ([[dic valueForKey:AVL_QTY] floatValue] + [[dic valueForKey:kPrvIndentQty] floatValue]);
        
        requestedQuantity +=  [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]floatValue];
        
        approvedQty       +=  [[self checkGivenValueIsNullOrNil:[dic valueForKey:kApprovedQty] defaultReturn:@"0.00"]floatValue];
    }
    
    quantityOnHandValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@" ",quantityOnHand];
    previousQtyValueLbl.text     = [NSString stringWithFormat:@"%@%.2f",@" ",previousIndentQty];
    projectedQtyValueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@" ",projectedQty];
    requestedQtyvalueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@" ",requestedQuantity];
    approvedQtyValueLbl.text     = [NSString stringWithFormat:@"%@%.2f",@" ",approvedQty];
}

#pragma  -mark here moved slef.view

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

/**
 * @description  method to move the view up/down whenever the keyboard is shown/dismissed
 * @date         04/06/2016
 * @method       setViewMovedUp
 * @author       Bhargav
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines {
    
    
    //    [self displayAlertMessage: @"No Products Avaliable" horizontialAxis:segmentedControl.frame.origin.x   verticalAxis:segmentedControl.frame.origin.y  msgType:@"warning" timming:2.0];
    
    @try {
        
        //Play Audio for button touch....
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


/**
 * @description  we are removing the alert messages from the view...
 * @date         15/03/2017
 * @method       removeAlertMessages
 * @author       Srinivasulu
 
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)removeAlertMessages{
    @try {
        
        if(userAlertMessageLbl.tag == 4){
            
            [self backAction];
            //            stockRequest * home = [[stockRequest alloc]init];
            //            [self.navigationController pushViewController:home animated:YES];
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
        
        if (catPopOver.popoverVisible && (tableName.frame.size.height > height)){
            catPopOver.popoverContentSize =  CGSizeMake(width, height);
            
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
        [tableName reloadData];
        
    }
    
}





/**
 * @description  here we are displaying the popOver to intimate the feature is not available...
 * @date         20/06/2017
 * @method       moreButtonPressed
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

-(void)moreButtonPressed:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float y_axis = self.view.frame.size.height - 200;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 320)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are displaying the popOver to intimate the feature is not available...
 * @date         20/06/2017
 * @method       moreButtonPressed
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

-(void)saveButtonPressed:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float y_axis = self.view.frame.size.height - 200;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 320)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}




#pragma -mark methods added by Srinivasulu from 17/01/2016
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
 * @description  navigating  to the previous class OmniHomePage...
 * @createdDate  06/08/2016
 * @method       closePriceView
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 *
 * @modified By Srinivalsulu
 * @reson       added the exception handling....
 *
 */

-(void)closePriceView:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        transparentView.hidden = YES;
        
    } @catch (NSException *exception) {
        
    }
    
}



#pragma mark actions not yet implemented


/**
 * @description    here we are displaying the popOver for the sumary Info...
 * @date           27/09/2016
 * @method         populatesummaryInfo
 * @author         Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)populatesummaryInfo {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    
    @try {
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
    
}




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
            //Recently Added By Bhargav.v on 26/10/2017....
            
//            if ([rawMaterialDetails count]) {
//                [rawMaterialDetails removeAllObjects];
//            }
            //up to here By Bhargav.v on 26/10/2017....
        }
        @try {
            
            [HUD show:YES];
            [HUD setHidden:NO];
            NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
            
            priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            priceListDic[START_INDEX] = @"-1";
            priceListDic[CATEGORY_LIST] = catArr;
            priceListDic[kStoreLocation] = presentLocation;
            
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
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"no_products_found", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
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
 * @modified BY  Srinivasulu on 17/01/2016
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        if (successDictionary != nil) {
            
            int  totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_SKUS]  defaultReturn:@"0"]intValue];
            
            for(NSDictionary * newSkuItemDic in [successDictionary valueForKey:SKU_LIST]){
                
                //checking priceList is existing or not....
                if([[newSkuItemDic valueForKey:SKU_PRICE_LIST] count]){
                    
                    for(NSDictionary * newSkuPriceListDic in [newSkuItemDic valueForKey:SKU_PRICE_LIST]){
                        
                        BOOL isExistingItem = false;
                        
                        NSDictionary * existItemdic;
                        
                        int i = 0;
                        
                        for (i= 0; i < rawMaterialDetails.count; i++) {
                            
                            //reading the existing cartItem....
                            existItemdic = rawMaterialDetails[i];
                            
                            
                            if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuPriceListDic valueForKey:PLU_CODE]]) {

                                [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                                [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:kApprovedQty] intValue] + 1] forKey:kApprovedQty];

                                rawMaterialDetails[i] = existItemdic;
                                
                                isExistingItem = true;
                                
                                break;
                            }
                        }

                        
                        if(!isExistingItem) {
                            
                            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                            
                            // added keys....
                            // added by roja on 06/07/2018
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:iTEM_PRICE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kApprovedQty];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kMeasureRange] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kProductBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];
                            
                          
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QOH];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:EAN] defaultReturn:EMPTY_STRING] forKey:EAN];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:kProductId];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                            
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];

                            
                            //Checking is isPacked item based on the Boolean value
                            
                            float qty = 0;
                            
                            if (qty == 0) {
                                
                                BOOL isPackedItem = false;
                                
                                int minimumQty = 0;
                                
                                if ([newSkuPriceListDic.allKeys containsObject:kPackagedType] && ![newSkuPriceListDic[kPackagedType] isKindOfClass:[NSNull class]]) {
                                    
                                    if([newSkuPriceListDic[kPackagedType] boolValue]){
                                        minimumQty = 1;
                                        isPackedItem = true;
                                    }
                                }
                            }
                            
                            if ([newSkuPriceListDic.allKeys containsObject:kPackagedType] && ![newSkuPriceListDic[kPackagedType] isKindOfClass:[NSNull class]]) {
                                
                                [isPacked addObject:@([newSkuPriceListDic[kPackagedType] boolValue])];
                            }
                            else {
                                
                                [isPacked addObject:[NSNumber numberWithBool:FALSE]];
                            }
                            
                            [rawMaterialDetails addObject:itemDetailsDic];
                        }
                    }
                }
                else {
                    
                    BOOL isExistingItem = false;
                    NSDictionary * existItemdic;
                    int i = 0;
                    
                    for (i = 0; i < rawMaterialDetails.count; i++) {
                        
                        //reading the existing cartItem....
                        existItemdic = rawMaterialDetails[i];
                        
                        if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuItemDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuItemDic valueForKey:PLU_CODE]]) {
                            
                            [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:kApprovedQty] intValue] + 1] forKey:kApprovedQty];
                            
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
//                    else{
                    
                       if(! isExistingItem) {
                           
                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                           
                           // added keys....
                           // added by roja on 06/07/2018
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                           
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:iTEM_PRICE];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kApprovedQty];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kMeasureRange] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kProductBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];
                           
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QOH];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:EAN] defaultReturn:EMPTY_STRING] forKey:EAN];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:kProductId];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                           
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];

                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                }
            }
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItemTxt.isEditing)
                y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,NSLocalizedString(@"records_are_added_to_the_cart", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"cart_records", nil) conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            [self calculateTotal];
        }
        
        
        
        //        approvedQty = 1;
        //        avlQty = "0.00";
        //        brand = NA;
        //        category = Fruits;
        //        color = "";
        //        costPrice = "150.00";
        //        itemDesc = "APPLE WASHINGTON";
        //        measurementRange = "";
        //        model = NA;
        //        pluCode = 9000901;
        //        productRange = "";
        //        projectedQty = "0.00";
        //        prvIndentQty = "15.00";
        //        quantity = 1;
        //        size = "";
        //        skuId = 90009;
        //        subcategoryName = "--";
        //        uom = KG;
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [requestedItemsTbl reloadData];
        [categoriesPopOver dismissPopoverAnimated:YES];
        
    }
    
    
    
    
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getSkuDetailsFailureResponse:
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSKuDetailsErrorResponse:(NSString *)errorResponse {
    @try {
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [categoriesPopOver dismissPopoverAnimated:YES];
    }
}


#pragma  -mark action used to change checkBoxs images....

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
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        pickView = [[UIView alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            pickView.frame = CGRectMake( 15, RequestDteTxt.frame.origin.y+RequestDteTxt.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:RequestDteTxt.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:deliveryDateTxt.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @description  here we can clear the  date from the text field...
 * @date         26/09/2016
 * @method       clearDate:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)clearDate:(UIButton *)sender{
    //    BOOL callServices = false;
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(  sender.tag == 2){
            if((RequestDteTxt.text).length)
                //                callServices = true;
                
                
                RequestDteTxt.text = @"";
        }
        else{
            if((deliveryDateTxt.text).length)
                //                callServices = true;
                
                deliveryDateTxt.text = @"";
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
 * @description  here we can populate the date from the text field...
 * @date         26/09/2016
 * @method       populateDateToTextField:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)populateDateToTextField:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        //Dismissing the Calendar PopOver...
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter * requiredDateFormat = [[NSDateFormatter alloc] init];
        
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        // getting present date & time ..
        NSDate * today = [NSDate date];
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        //        [f release];
        today = [f dateFromString:currentdate];
        
        //if( [today compare:selectedDateString] == NSOrderedAscending && (![deliveryDateTxt.text length]) ){
        //[self displayAlertMessage:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType: NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        //return;
        //}
        
        NSDate *existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if(sender.tag == 2){
            if ((deliveryDateTxt.text).length != 0 && (![deliveryDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:deliveryDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"request_date_should_be_earlier_than_delivery_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
                    return;
                    
                }
            }
            
            RequestDteTxt.text = dateString;
        }
        else {
            
            if ((RequestDteTxt.text).length != 0 && (![RequestDteTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:RequestDteTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivery_date_should_not_be_earlier_than_request_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
                    
                    return;
                }
            }
            
            deliveryDateTxt.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
        
        //        NSDateComponents * dayComponent = [[NSDateComponents alloc] init];
        //        dayComponent.day = 1;
        //
        //        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        //        NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
        //
        //        NSLog(@"nextDate: %@ ...", nextDate);
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

@end
