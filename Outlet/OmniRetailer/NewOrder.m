//
//  NewOrder.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "OmniRetailerViewController.h"
#import "NewOrder.h"
#import <QuartzCore/QuartzCore.h>
#import "BarcodeType.h"
#import "Global.h"
#import "CheckWifi.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"
#import "CustomerServiceSvc.h"


@interface NewOrder ()

@end

@implementation NewOrder

@synthesize soundFileURLRef,soundFileObject;



#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         21/09/2016
 * @method       ViewDidLoad
 * @author       Bhargav Ram (Old GUI...)
 * @param
 * @param
 * @return
 * @modified BY  Roja on 12-09-2018... && on 13/02/2019...
 * @reason       Changing UI part as per latest updates also adding mandetory(*) labels...
 * @verified By
 * @verified On
 */

//- (void)viewDidLoad {
//
//    //calling super call method....
//    [super viewDidLoad];
//
//    // Do any additional setup after loading the view.
//
//    //reading the DeviceVersion....
//    version = [UIDevice currentDevice].systemVersion.floatValue;
//
//    //here we reading the DeviceOrientaion....
//    currentOrientation = [UIDevice currentDevice].orientation;
//
//    // Audio Sound load url......
//    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
//    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
//
//    //setting the backGroundColor to view...
//    self.view.backgroundColor = [UIColor blackColor];
//
//    //ProgressBar creation...
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    // Regiser for HUD callbacks so we can remove it from the window at the right time
//    HUD.delegate = self;
//    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
//    HUD.mode = MBProgressHUDModeCustomView;
//
//    //creating the stockRequestView which will displayed completed Screen...
//    createOrderView = [[UIView alloc] init];
//    createOrderView.backgroundColor = [UIColor blackColor];
//    createOrderView.layer.borderWidth = 1.0f;
//    createOrderView.layer.cornerRadius = 10.0f;
//    createOrderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//
//    /*Creation of UILabel for headerDisplay.......*/
//    //creating  UILabel as a line which will display at topOfThe DayStartView...
//    UILabel * headerNameLabel = [[UILabel alloc] init];
//    headerNameLabel.layer.cornerRadius = 10.0f;
//    headerNameLabel.layer.masksToBounds = YES;
//    headerNameLabel.textAlignment = NSTextAlignmentCenter;
//    headerNameLabel.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
//    headerNameLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
//
//    //CALayer for borderwidth and color setting....
//    CALayer * bottomBorder = [CALayer layer];
//    bottomBorder.opacity = 5.0f;
//    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
//    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLabel.frame.size.width, 1.0f);
//    [headerNameLabel.layer addSublayer:bottomBorder];
//
//    //Allocation of createOrderScrollView...
//
//    createOrderScrollView = [[UIScrollView alloc] init];
//    createOrderScrollView.hidden = NO;
//    createOrderScrollView.backgroundColor = [UIColor blackColor];
//    createOrderScrollView.bounces = FALSE;
//    createOrderScrollView.scrollEnabled = YES;
//
//    UILabel * orderDetailsLabel;
//
//    orderDetailsLabel = [[UILabel alloc] init];
//    orderDetailsLabel.layer.cornerRadius = 5.0f;
//    orderDetailsLabel.layer.masksToBounds = YES;
//    orderDetailsLabel.numberOfLines = 1;
//    orderDetailsLabel.textAlignment = NSTextAlignmentLeft;
//    orderDetailsLabel.backgroundColor = [UIColor blackColor];
//    orderDetailsLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    UIButton * submitButton;
//    UIButton * saveButton;
//    UIButton * backButton;
//
//    // Creation of UIButton....
//    submitButton = [[UIButton alloc] init];
//    submitButton.layer.cornerRadius = 3.0f;
//    submitButton.backgroundColor = [UIColor grayColor];
//    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    saveButton = [[UIButton alloc] init];
//    saveButton.layer.cornerRadius = 3.0f;
//    saveButton.backgroundColor = [UIColor grayColor];
//    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    backButton = [[UIButton alloc] init];
//    backButton.layer.cornerRadius = 3.0f;
//    backButton.backgroundColor = [UIColor grayColor];
//    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    [submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
//    [saveButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
//    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
//
//    UILabel * separationLabel;
//
//    separationLabel = [[UILabel alloc] init];
//    separationLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2 ];
//    separationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2 ];
//
//
//    //Allocation & Creation of of UILabels...
//    // Row 1......
//
//    UILabel * orderDateLabel;
//    UILabel * orderDateStarLabel;
//    UILabel * deliveryDateLabel;
//    UILabel * deliveryDateStarLabel;
//    UILabel * paymentModeLabel;
//    UILabel * paymentModeStarLabel;
//    UILabel * paymentTypeLabel;
//    UILabel * paymentTypeStarLabel;
//
//
//    orderDateLabel = [[UILabel alloc] init];
//    orderDateLabel.layer.cornerRadius = 5.0f;
//    orderDateLabel.layer.masksToBounds = YES;
//    orderDateLabel.numberOfLines = 1;
//    orderDateLabel.textAlignment = NSTextAlignmentLeft;
//    orderDateLabel.backgroundColor = [UIColor blackColor];
//    orderDateLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//
//    orderDateStarLabel = [[UILabel alloc] init];
//    orderDateStarLabel.textAlignment = NSTextAlignmentLeft;
//    orderDateStarLabel.backgroundColor = [UIColor blackColor];
//    orderDateStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    orderDateStarLabel.font = [UIFont systemFontOfSize:30];
//
//    deliveryDateLabel = [[UILabel alloc] init];
//    deliveryDateLabel.layer.cornerRadius = 5.0f;
//    deliveryDateLabel.layer.masksToBounds = YES;
//    deliveryDateLabel.numberOfLines = 1;
//    deliveryDateLabel.textAlignment = NSTextAlignmentLeft;
//    deliveryDateLabel.backgroundColor = [UIColor blackColor];
//    deliveryDateLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    deliveryDateStarLabel = [[UILabel alloc] init];
//    deliveryDateStarLabel.textAlignment = NSTextAlignmentLeft;
//    deliveryDateStarLabel.backgroundColor = [UIColor blackColor];
//    deliveryDateStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    deliveryDateStarLabel.font = [UIFont systemFontOfSize:30];
//
//    paymentModeLabel = [[UILabel alloc] init];
//    paymentModeLabel.layer.cornerRadius = 5.0f;
//    paymentModeLabel.layer.masksToBounds = YES;
//    paymentModeLabel.numberOfLines = 1;
//    paymentModeLabel.textAlignment = NSTextAlignmentLeft;
//    paymentModeLabel.backgroundColor = [UIColor blackColor];
//    paymentModeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    paymentModeStarLabel = [[UILabel alloc] init];
//    paymentModeStarLabel.textAlignment = NSTextAlignmentLeft;
//    paymentModeStarLabel.backgroundColor = [UIColor blackColor];
//    paymentModeStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    paymentModeStarLabel.font = [UIFont systemFontOfSize:30];
//
//    paymentTypeLabel = [[UILabel alloc] init];
//    paymentTypeLabel.layer.cornerRadius = 5.0f;
//    paymentTypeLabel.layer.masksToBounds = YES;
//    paymentTypeLabel.numberOfLines = 1;
//    paymentTypeLabel.textAlignment = NSTextAlignmentLeft;
//    paymentTypeLabel.backgroundColor = [UIColor blackColor];
//    paymentTypeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    paymentTypeStarLabel = [[UILabel alloc] init];
//    paymentTypeStarLabel.textAlignment = NSTextAlignmentLeft;
//    paymentTypeStarLabel.backgroundColor = [UIColor blackColor];
//    paymentTypeStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    paymentTypeStarLabel.font = [UIFont systemFontOfSize:30];
//
//    // Row 1.....
//
//    // getting present date & time ..
//    NSDate * today = [NSDate date];
//    NSDateFormatter *f = [[NSDateFormatter alloc] init];
//    f.dateFormat = @"dd/MM/yyyy";
//    NSString * currentdate = [f stringFromDate:today];
//
//    orderDateText = [[CustomTextField alloc] init];
//    orderDateText.delegate = self;
//    orderDateText.userInteractionEnabled  = NO;
//    orderDateText.text = currentdate;
//    [orderDateText awakeFromNib];
//
//    deliveryDateText = [[CustomTextField alloc] init];
//    deliveryDateText.delegate = self;
//    deliveryDateText.userInteractionEnabled  = NO;
//    deliveryDateText.placeholder = NSLocalizedString(@"dd/mm/yyyy", nil);
//    [deliveryDateText awakeFromNib];
//    //    [deliveryDateText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    paymentModeText = [[CustomTextField alloc] init];
//    paymentModeText.delegate = self;
//    paymentModeText.userInteractionEnabled  = NO;
//    paymentModeText.placeholder = NSLocalizedString(@"payment_mode",nil);
//    [paymentModeText awakeFromNib];
//    //    [paymentModeText addTarget:self action:@selector(textFieldDidChange:)  forControlEvents:UIControlEventEditingChanged];
//
//    paymentTypeText = [[CustomTextField alloc] init];
//    paymentTypeText.delegate = self;
//    paymentTypeText.userInteractionEnabled  = NO;
//    paymentTypeText.placeholder = NSLocalizedString(@"payment_type",nil);
//    [paymentTypeText awakeFromNib];
//    //    [paymentTypeText addTarget:self action:@selector(textFieldDidChange:)  forControlEvents:UIControlEventEditingChanged];
//
//
//    /*Creation of UIImage used for buttons*/
//    UIImage * downArrowImage = [UIImage imageNamed:@"arrow_1.png"];
//    UIImage * calendarIconImage = [UIImage imageNamed:@"Calandar_Icon.png"];
//
//
//    UIButton * orderDateButton;
//    UIButton * deliveryDateButton;
//    UIButton * paymentModeButton;
//    UIButton * paymentTypeButton;
//
//    orderDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [orderDateButton setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
//
//    deliveryDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [deliveryDateButton setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
//
//    paymentModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [paymentModeButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//
//    paymentTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [paymentTypeButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//
//    [orderDateButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
//    [deliveryDateButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
//    [paymentModeButton addTarget:self action:@selector(showPaymentMode:) forControlEvents:UIControlEventTouchDown];
//    [paymentTypeButton addTarget:self action:@selector(showPaymentType:) forControlEvents:UIControlEventTouchDown];
//
//
//    //Row2....
//
//    UILabel * locationLabel;
//    UILabel * locationStarLabel;
//    UILabel * customerEmailIdLabel;
//    UILabel * customerEmailIdStarLabel;
//    UILabel * customerMobileNoLabel;
//    UILabel * customerMobileNoStarLabel;
//    UILabel * paymentRefLabel;
//    UILabel * paymentRefStarLabel;
//
//
//    locationLabel = [[UILabel alloc] init];
//    locationLabel.layer.cornerRadius = 5.0f;
//    locationLabel.layer.masksToBounds = YES;
//    locationLabel.numberOfLines = 1;
//    locationLabel.textAlignment = NSTextAlignmentLeft;
//    locationLabel.backgroundColor = [UIColor blackColor];
//    locationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    locationStarLabel = [[UILabel alloc] init];
//    locationStarLabel.textAlignment = NSTextAlignmentLeft;
//    locationStarLabel.backgroundColor = [UIColor blackColor];
//    locationStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    locationStarLabel.font = [UIFont systemFontOfSize:30];
//
//    customerEmailIdLabel = [[UILabel alloc] init];
//    customerEmailIdLabel.layer.cornerRadius = 5.0f;
//    customerEmailIdLabel.layer.masksToBounds = YES;
//    customerEmailIdLabel.numberOfLines = 1;
//    customerEmailIdLabel.textAlignment = NSTextAlignmentLeft;
//    customerEmailIdLabel.backgroundColor = [UIColor blackColor];
//    customerEmailIdLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    customerEmailIdStarLabel = [[UILabel alloc] init];
//    customerEmailIdStarLabel.textAlignment = NSTextAlignmentLeft;
//    customerEmailIdStarLabel.backgroundColor = [UIColor blackColor];
//    customerEmailIdStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    customerEmailIdStarLabel.font = [UIFont systemFontOfSize:30];
//
//    customerMobileNoLabel = [[UILabel alloc] init];
//    customerMobileNoLabel.layer.cornerRadius = 5.0f;
//    customerMobileNoLabel.layer.masksToBounds = YES;
//    customerMobileNoLabel.numberOfLines = 1;
//    customerMobileNoLabel.textAlignment = NSTextAlignmentLeft;
//    customerMobileNoLabel.backgroundColor = [UIColor blackColor];
//    customerMobileNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    customerMobileNoStarLabel = [[UILabel alloc] init];
//    customerMobileNoStarLabel.textAlignment = NSTextAlignmentLeft;
//    customerMobileNoStarLabel.backgroundColor = [UIColor blackColor];
//    customerMobileNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    customerMobileNoStarLabel.font = [UIFont systemFontOfSize:30];
//
//    paymentRefLabel = [[UILabel alloc] init];
//    paymentRefLabel.layer.cornerRadius = 5.0f;
//    paymentRefLabel.layer.masksToBounds = YES;
//    paymentRefLabel.numberOfLines = 1;
//    paymentRefLabel.textAlignment = NSTextAlignmentLeft;
//    paymentRefLabel.backgroundColor = [UIColor blackColor];
//    paymentRefLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    paymentRefStarLabel = [[UILabel alloc] init];
//    paymentRefStarLabel.textAlignment = NSTextAlignmentLeft;
//    paymentRefStarLabel.backgroundColor = [UIColor blackColor];
//    paymentRefStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    paymentRefStarLabel.font = [UIFont systemFontOfSize:30];
//
//
//    locationText = [[CustomTextField alloc] init];
//    locationText.userInteractionEnabled  = NO;
//    locationText.text = presentLocation;
//    [locationText awakeFromNib];
//    locationText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    locationText.delegate = self;
//    locationText.placeholder = NSLocalizedString(@"location", nil);
//
//    customerEmailIdText = [[CustomTextField alloc] init];
//    customerEmailIdText.delegate = self;
//    customerEmailIdText.userInteractionEnabled  = YES;
//    customerEmailIdText.keyboardType = UIKeyboardTypeEmailAddress;
//    customerEmailIdText.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    customerEmailIdText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    customerEmailIdText.placeholder = NSLocalizedString(@"enter_email_address", nil);
//    [customerEmailIdText awakeFromNib];
//    //    [customerEmailIdText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    customerMobileNoText = [[CustomTextField alloc] init];
//    customerMobileNoText.delegate = self;
//    customerMobileNoText.userInteractionEnabled  = YES;
//    customerMobileNoText.keyboardType = UIKeyboardTypeNumberPad;
//    customerMobileNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    customerMobileNoText.placeholder = NSLocalizedString(@"enter_contact_no", nil);
//    [customerMobileNoText awakeFromNib];
//    [customerMobileNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    paymentRefText = [[CustomTextField alloc] init];
//    paymentRefText.delegate = self;
//    paymentRefText.userInteractionEnabled  = YES;
//    paymentRefText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    paymentRefText.placeholder = NSLocalizedString(@"cheque_approval_no", nil);
//    [paymentRefText awakeFromNib];
//
//    UIButton * locationButton;
//
//    locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [locationButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//    [locationButton addTarget:self action:@selector(showAllLocations:) forControlEvents:UIControlEventTouchDown];
//
//
//    // Row 3
//    UILabel * customerAddressLabel;
//    UILabel * streetLabel;
//    UILabel * streetStarLabel;
//    UILabel * customerLocationLabel;
//    UILabel * customerLocationStarLabel;
//    UILabel * cityLabel;
//    UILabel * cityStarLabel;
//
//
//    customerAddressLabel = [[UILabel alloc] init];
//    customerAddressLabel.layer.cornerRadius = 3.0f;
//    customerAddressLabel.layer.masksToBounds = YES;
//    customerAddressLabel.numberOfLines = 1;
//    customerAddressLabel.textAlignment = NSTextAlignmentLeft;
//    customerAddressLabel.backgroundColor = [UIColor grayColor];
//    customerAddressLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    streetLabel = [[UILabel alloc] init];
//    streetLabel.layer.cornerRadius = 5.0f;
//    streetLabel.layer.masksToBounds = YES;
//    streetLabel.numberOfLines = 1;
//    streetLabel.textAlignment = NSTextAlignmentLeft;
//    streetLabel.backgroundColor = [UIColor blackColor];
//    streetLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    streetStarLabel = [[UILabel alloc] init];
//    streetStarLabel.textAlignment = NSTextAlignmentLeft;
//    streetStarLabel.backgroundColor = [UIColor blackColor];
//    streetStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    streetStarLabel.font = [UIFont systemFontOfSize:30];
//
//    customerLocationLabel = [[UILabel alloc] init];
//    customerLocationLabel.layer.cornerRadius = 5.0f;
//    customerLocationLabel.layer.masksToBounds = YES;
//    customerLocationLabel.numberOfLines = 1;
//    customerLocationLabel.textAlignment = NSTextAlignmentLeft;
//    customerLocationLabel.backgroundColor = [UIColor blackColor];
//    customerLocationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    customerLocationStarLabel = [[UILabel alloc] init];
//    customerLocationStarLabel.textAlignment = NSTextAlignmentLeft;
//    customerLocationStarLabel.backgroundColor = [UIColor blackColor];
//    customerLocationStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    customerLocationStarLabel.font = [UIFont systemFontOfSize:30];
//
//    cityLabel = [[UILabel alloc] init];
//    cityLabel.layer.cornerRadius = 5.0f;
//    cityLabel.layer.masksToBounds = YES;
//    cityLabel.numberOfLines = 1;
//    cityLabel.textAlignment = NSTextAlignmentLeft;
//    cityLabel.backgroundColor = [UIColor blackColor];
//    cityLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    cityStarLabel = [[UILabel alloc] init];
//    cityStarLabel.textAlignment = NSTextAlignmentLeft;
//    cityStarLabel.backgroundColor = [UIColor blackColor];
//    cityStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    cityStarLabel.font = [UIFont systemFontOfSize:30];
//
//    streetText = [[CustomTextField alloc] init];
//    streetText.delegate = self;
//    streetText.userInteractionEnabled  = YES;
//    streetText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    streetText.placeholder = NSLocalizedString(@"enter_street", nil);
//    [streetText awakeFromNib];
//    [streetText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    customerLocationText = [[CustomTextField alloc] init];
//    customerLocationText.delegate = self;
//    customerLocationText.userInteractionEnabled  = YES;
//    customerLocationText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    customerLocationText.placeholder = NSLocalizedString(@"enter_landmark", nil);
//    [customerLocationText awakeFromNib];
//    [customerLocationText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//    customerCityText = [[CustomTextField alloc] init];
//    customerCityText.delegate = self;
//    customerCityText.userInteractionEnabled  = YES;
//    customerCityText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    customerCityText.placeholder = NSLocalizedString(@"enter_city", nil);
//    [customerCityText awakeFromNib];
//    [customerCityText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//
//    //Row 4
//    UILabel * doorNoLabel;
//    UILabel * doorNoStarLabel;
//    UILabel * contactNoLabel;
//    UILabel * contactNoStarLabel;
//    UILabel * googleMapLinkLabel;
//    UILabel * pinLabel;
//
//    doorNoLabel = [[UILabel alloc] init];
//    doorNoLabel.layer.cornerRadius = 5.0f;
//    doorNoLabel.layer.masksToBounds = YES;
//    doorNoLabel.numberOfLines = 1;
//    doorNoLabel.textAlignment = NSTextAlignmentLeft;
//    doorNoLabel.backgroundColor = [UIColor blackColor];
//    doorNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    doorNoStarLabel = [[UILabel alloc] init];
//    doorNoStarLabel.textAlignment = NSTextAlignmentLeft;
//    doorNoStarLabel.backgroundColor = [UIColor blackColor];
//    doorNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    doorNoStarLabel.font = [UIFont systemFontOfSize:30];
//
//    contactNoLabel = [[UILabel alloc] init];
//    contactNoLabel.layer.cornerRadius = 5.0f;
//    contactNoLabel.layer.masksToBounds = YES;
//    contactNoLabel.numberOfLines = 1;
//    contactNoLabel.textAlignment = NSTextAlignmentLeft;
//    contactNoLabel.backgroundColor = [UIColor blackColor];
//    contactNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    contactNoStarLabel = [[UILabel alloc] init];
//    contactNoStarLabel.textAlignment = NSTextAlignmentLeft;
//    contactNoStarLabel.backgroundColor = [UIColor blackColor];
//    contactNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    contactNoStarLabel.font = [UIFont systemFontOfSize:30];
//
//    googleMapLinkLabel = [[UILabel alloc] init];
//    googleMapLinkLabel.layer.cornerRadius = 5.0f;
//    googleMapLinkLabel.layer.masksToBounds = YES;
//    googleMapLinkLabel.numberOfLines = 1;
//    googleMapLinkLabel.textAlignment = NSTextAlignmentLeft;
//    googleMapLinkLabel.backgroundColor = [UIColor blackColor];
//    googleMapLinkLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    pinLabel = [[UILabel alloc] init];
//    pinLabel.layer.cornerRadius = 5.0f;
//    pinLabel.layer.masksToBounds = YES;
//    pinLabel.numberOfLines = 1;
//    pinLabel.textAlignment = NSTextAlignmentLeft;
//    pinLabel.backgroundColor = [UIColor blackColor];
//    pinLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//
//    doorNoText = [[CustomTextField alloc] init];
//    doorNoText.delegate = self;
//    doorNoText.userInteractionEnabled  = YES;
//    doorNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    doorNoText.placeholder = NSLocalizedString(@"enter_doorNo", nil);
//    [doorNoText awakeFromNib];
//    [doorNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    contactNoText = [[CustomTextField alloc] init];
//    contactNoText.delegate = self;
//    contactNoText.userInteractionEnabled  = YES;
//    contactNoText.placeholder = NSLocalizedString(@"enter_contact_no", nil);
//    contactNoText.keyboardType = UIKeyboardTypeNumberPad;
//    contactNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [contactNoText awakeFromNib];
//    [contactNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    googleMapLinkText = [[CustomTextField alloc] init];
//    googleMapLinkText.delegate = self;
//    googleMapLinkText.userInteractionEnabled  = YES;
//    googleMapLinkText.placeholder = NSLocalizedString(@"enter_google_map_link", nil);
//    googleMapLinkText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [googleMapLinkText awakeFromNib];
//    [googleMapLinkText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//    pinNoText = [[CustomTextField alloc] init];
//    pinNoText.delegate = self;
//    pinNoText.userInteractionEnabled  = YES;
//    pinNoText.placeholder = NSLocalizedString(@"enter_pin", nil);
//    pinNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    pinNoText.keyboardType = UIKeyboardTypePhonePad;
//    [pinNoText awakeFromNib];
//    [pinNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//    // Row5....
//
//    UILabel * billingAddressLabel;
//    UILabel * billingStreetLabel;
//    //    UILabel * billingStreetStarLabel;
//    UILabel * billingLocationLabel;
//    //    UILabel * billingLocationStarLabel;
//    UILabel * billingCityLabel;
//    //    UILabel * billingCityStarLabel;
//
//
//    billingAddressLabel = [[UILabel alloc] init];
//    billingAddressLabel.layer.cornerRadius = 3.0f;
//    billingAddressLabel.layer.masksToBounds = YES;
//    billingAddressLabel.numberOfLines = 1;
//    billingAddressLabel.textAlignment = NSTextAlignmentLeft;
//    billingAddressLabel.backgroundColor = [UIColor grayColor];
//    billingAddressLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    billingStreetLabel = [[UILabel alloc] init];
//    billingStreetLabel.layer.cornerRadius = 5.0f;
//    billingStreetLabel.layer.masksToBounds = YES;
//    billingStreetLabel.numberOfLines = 1;
//    billingStreetLabel.textAlignment = NSTextAlignmentLeft;
//    billingStreetLabel.backgroundColor = [UIColor blackColor];
//    billingStreetLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    //    billingStreetStarLabel = [[UILabel alloc] init];
//    //    billingStreetStarLabel.textAlignment = NSTextAlignmentLeft;
//    //    billingStreetStarLabel.backgroundColor = [UIColor blackColor];
//    //    billingStreetStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    //    billingStreetStarLabel.font = [UIFont systemFontOfSize:30];
//
//    billingLocationLabel = [[UILabel alloc] init];
//    billingLocationLabel.layer.cornerRadius = 5.0f;
//    billingLocationLabel.layer.masksToBounds = YES;
//    billingLocationLabel.numberOfLines = 1;
//    billingLocationLabel.textAlignment = NSTextAlignmentLeft;
//    billingLocationLabel.backgroundColor = [UIColor blackColor];
//    billingLocationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    //    billingLocationStarLabel = [[UILabel alloc] init];
//    //    billingLocationStarLabel.textAlignment = NSTextAlignmentLeft;
//    //    billingLocationStarLabel.backgroundColor = [UIColor blackColor];
//    //    billingLocationStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    //    billingLocationStarLabel.font = [UIFont systemFontOfSize:30];
//
//    billingCityLabel = [[UILabel alloc] init];
//    billingCityLabel.layer.cornerRadius = 5.0f;
//    billingCityLabel.layer.masksToBounds = YES;
//    billingCityLabel.numberOfLines = 1;
//    billingCityLabel.textAlignment = NSTextAlignmentLeft;
//    billingCityLabel.backgroundColor = [UIColor blackColor];
//    billingCityLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    //    billingCityStarLabel = [[UILabel alloc] init];
//    //    billingCityStarLabel.textAlignment = NSTextAlignmentLeft;
//    //    billingCityStarLabel.backgroundColor = [UIColor blackColor];
//    //    billingCityStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    //    billingCityStarLabel.font = [UIFont systemFontOfSize:30];
//
//    //
//    billingStreetText = [[CustomTextField alloc] init];
//    billingStreetText.delegate = self;
//    billingStreetText.userInteractionEnabled  = YES;
//    billingStreetText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    billingStreetText.placeholder = NSLocalizedString(@"enter_street", nil);
//    [billingStreetText awakeFromNib];
//
//    billingLocationText = [[CustomTextField alloc] init];
//    billingLocationText.delegate = self;
//    billingLocationText.userInteractionEnabled  = YES;
//    billingLocationText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    billingLocationText.placeholder = NSLocalizedString(@"enter_landmark", nil);
//    [billingLocationText awakeFromNib];
//
//    billingCityText = [[CustomTextField alloc] init];
//    billingCityText.delegate = self;
//    billingCityText.userInteractionEnabled  = YES;
//    billingCityText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    billingCityText.placeholder = NSLocalizedString(@"enter_city", nil);
//    [billingCityText awakeFromNib];
//
//    // Row6....
//
//    UILabel * billingDoorNoLabel;
//    //    UILabel * billingDoorNoStarLabel;
//    UILabel * billingContactNoLabel;
//    //    UILabel * billingContactNoStarLabel;
//    UILabel * billingGoogleMapLinkLabel;
//    UILabel * billingPinCodeLabel;
//
//    billingDoorNoLabel = [[UILabel alloc] init];
//    billingDoorNoLabel.layer.cornerRadius = 5.0f;
//    billingDoorNoLabel.layer.masksToBounds = YES;
//    billingDoorNoLabel.numberOfLines = 1;
//    billingDoorNoLabel.textAlignment = NSTextAlignmentLeft;
//    billingDoorNoLabel.backgroundColor = [UIColor blackColor];
//    billingDoorNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    //    billingDoorNoStarLabel = [[UILabel alloc] init];
//    //    billingDoorNoStarLabel.textAlignment = NSTextAlignmentLeft;
//    //    billingDoorNoStarLabel.backgroundColor = [UIColor blackColor];
//    //    billingDoorNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    //    billingDoorNoStarLabel.font = [UIFont systemFontOfSize:30];
//    //
//    billingContactNoLabel = [[UILabel alloc] init];
//    billingContactNoLabel.layer.cornerRadius = 5.0f;
//    billingContactNoLabel.layer.masksToBounds = YES;
//    billingContactNoLabel.numberOfLines = 1;
//    billingContactNoLabel.textAlignment = NSTextAlignmentLeft;
//    billingContactNoLabel.backgroundColor = [UIColor blackColor];
//    billingContactNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    //    billingContactNoStarLabel = [[UILabel alloc] init];
//    //    billingContactNoStarLabel.textAlignment = NSTextAlignmentLeft;
//    //    billingContactNoStarLabel.backgroundColor = [UIColor blackColor];
//    //    billingContactNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    //    billingContactNoStarLabel.font = [UIFont systemFontOfSize:30];
//
//    billingGoogleMapLinkLabel = [[UILabel alloc] init];
//    billingGoogleMapLinkLabel.layer.cornerRadius = 5.0f;
//    billingGoogleMapLinkLabel.layer.masksToBounds = YES;
//    billingGoogleMapLinkLabel.numberOfLines = 1;
//    billingGoogleMapLinkLabel.textAlignment = NSTextAlignmentLeft;
//    billingGoogleMapLinkLabel.backgroundColor = [UIColor blackColor];
//    billingGoogleMapLinkLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    billingPinCodeLabel = [[UILabel alloc] init];
//    billingPinCodeLabel.layer.cornerRadius = 5.0f;
//    billingPinCodeLabel.layer.masksToBounds = YES;
//    billingPinCodeLabel.numberOfLines = 1;
//    billingPinCodeLabel.textAlignment = NSTextAlignmentLeft;
//    billingPinCodeLabel.backgroundColor = [UIColor blackColor];
//    billingPinCodeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//
//    billingDoorNoText = [[CustomTextField alloc] init];
//    billingDoorNoText.delegate = self;
//    billingDoorNoText.userInteractionEnabled  = YES;
//    billingDoorNoText.placeholder = NSLocalizedString(@"enter_doorNo", nil);
//    billingDoorNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [billingDoorNoText awakeFromNib];
//
//    billingContactNoText = [[CustomTextField alloc] init];
//    billingContactNoText.delegate = self;
//    billingContactNoText.userInteractionEnabled  = YES;
//    billingContactNoText.keyboardType = UIKeyboardTypeNumberPad;
//    billingContactNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    billingContactNoText.placeholder = NSLocalizedString(@"enter_contact_no", nil);
//    [billingContactNoText awakeFromNib];
//    [billingContactNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//    billingGoogleMapLinkText = [[CustomTextField alloc] init];
//    billingGoogleMapLinkText.delegate = self;
//    billingGoogleMapLinkText.userInteractionEnabled  = YES;
//    billingGoogleMapLinkText.placeholder = NSLocalizedString(@"enter_google_map_link", nil);
//    billingGoogleMapLinkText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [billingGoogleMapLinkText awakeFromNib];
//
//    billingPinNoText = [[CustomTextField alloc] init];
//    billingPinNoText.delegate = self;
//    billingPinNoText.userInteractionEnabled  = YES;
//    billingPinNoText.placeholder = NSLocalizedString(@"enter_pin", nil);
//    billingPinNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    billingPinNoText.keyboardType = UIKeyboardTypePhonePad;
//    [billingPinNoText awakeFromNib];
//
//    //row7.....
//    UILabel * shipmentAddressLabel;
//    UILabel * shipmentContactNoLabel;
//    UILabel * shipmentContactNoStarLabel;
//    UILabel * shipmentDoorNoLabel;
//    UILabel * shipmentDoorNoStarLabel;
//    UILabel * shipmentStreetNoLabel;
//    UILabel * shipmentStreetNoStarLabel;
//
//
//    shipmentAddressLabel = [[UILabel alloc] init];
//    shipmentAddressLabel.layer.cornerRadius = 3.0f;
//    shipmentAddressLabel.layer.masksToBounds = YES;
//    shipmentAddressLabel.numberOfLines = 1;
//    shipmentAddressLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentAddressLabel.backgroundColor = [UIColor grayColor];
//    shipmentAddressLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shipmentContactNoLabel = [[UILabel alloc] init];
//    shipmentContactNoLabel.layer.cornerRadius = 5.0f;
//    shipmentContactNoLabel.layer.masksToBounds = YES;
//    shipmentContactNoLabel.numberOfLines = 1;
//    shipmentContactNoLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentContactNoLabel.backgroundColor = [UIColor blackColor];
//    shipmentContactNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shipmentContactNoStarLabel = [[UILabel alloc] init];
//    shipmentContactNoStarLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentContactNoStarLabel.backgroundColor = [UIColor blackColor];
//    shipmentContactNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    shipmentContactNoStarLabel.font = [UIFont systemFontOfSize:30];
//
//    shipmentDoorNoLabel = [[UILabel alloc] init];
//    shipmentDoorNoLabel.layer.cornerRadius = 5.0f;
//    shipmentDoorNoLabel.layer.masksToBounds = YES;
//    shipmentDoorNoLabel.numberOfLines = 1;
//    shipmentDoorNoLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentDoorNoLabel.backgroundColor = [UIColor blackColor];
//    shipmentDoorNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shipmentDoorNoStarLabel = [[UILabel alloc] init];
//    shipmentDoorNoStarLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentDoorNoStarLabel.backgroundColor = [UIColor blackColor];
//    shipmentDoorNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    shipmentDoorNoStarLabel.font = [UIFont systemFontOfSize:30];
//
//    shipmentStreetNoLabel = [[UILabel alloc] init];
//    shipmentStreetNoLabel.layer.cornerRadius = 5.0f;
//    shipmentStreetNoLabel.layer.masksToBounds = YES;
//    shipmentStreetNoLabel.numberOfLines = 1;
//    shipmentStreetNoLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentStreetNoLabel.backgroundColor = [UIColor blackColor];
//    shipmentStreetNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shipmentStreetNoStarLabel = [[UILabel alloc] init];
//    shipmentStreetNoStarLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentStreetNoStarLabel.backgroundColor = [UIColor blackColor];
//    shipmentStreetNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    shipmentStreetNoStarLabel.font = [UIFont systemFontOfSize:30];
//
//
//    shipmentContactNoText = [[CustomTextField alloc] init];
//    shipmentContactNoText.delegate = self;
//    shipmentContactNoText.userInteractionEnabled  = YES;
//    shipmentContactNoText.placeholder = NSLocalizedString(@"enter_contact_no", nil);
//    shipmentContactNoText.keyboardType = UIKeyboardTypeNumberPad;
//    shipmentContactNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [shipmentContactNoText awakeFromNib];
//    [shipmentContactNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//    shipmentDoorNoText = [[CustomTextField alloc] init];
//    shipmentDoorNoText.delegate = self;
//    shipmentDoorNoText.userInteractionEnabled  = YES;
//    shipmentDoorNoText.placeholder = NSLocalizedString(@"enter_doorNo", nil);
//    shipmentDoorNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [shipmentDoorNoText awakeFromNib];
//
//    shipmentStreetNoText = [[CustomTextField alloc] init];
//    shipmentStreetNoText.delegate = self;
//    shipmentStreetNoText.userInteractionEnabled  = YES;
//    shipmentStreetNoText.placeholder = NSLocalizedString(@"enter_street", nil);
//    shipmentStreetNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [shipmentStreetNoText awakeFromNib];
//
//    //row8
//
//    UILabel * shipmentNameLabel;
//    UILabel * shipmentNameStarLabel;
//    UILabel * shipmentLocationLabel;
//    UILabel * shipmentLocationStarLabel;
//    UILabel * shipmentCityLabel;
//    UILabel * shipmentCityStarLabel;
//    UILabel * shipmentStateLabel;
//    UILabel * shipmentStateStarLabel;
//
//
//    shipmentNameLabel = [[UILabel alloc] init];
//    shipmentNameLabel.layer.cornerRadius = 5.0f;
//    shipmentNameLabel.layer.masksToBounds = YES;
//    shipmentNameLabel.numberOfLines = 1;
//    shipmentNameLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentNameLabel.backgroundColor = [UIColor blackColor];
//    shipmentNameLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shipmentNameStarLabel = [[UILabel alloc] init];
//    shipmentNameStarLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentNameStarLabel.backgroundColor = [UIColor blackColor];
//    shipmentNameStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    shipmentNameStarLabel.font = [UIFont systemFontOfSize:30];
//
//    shipmentLocationLabel = [[UILabel alloc] init];
//    shipmentLocationLabel.layer.cornerRadius = 5.0f;
//    shipmentLocationLabel.layer.masksToBounds = YES;
//    shipmentLocationLabel.numberOfLines = 1;
//    shipmentLocationLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentLocationLabel.backgroundColor = [UIColor blackColor];
//    shipmentLocationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shipmentLocationStarLabel = [[UILabel alloc] init];
//    shipmentLocationStarLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentLocationStarLabel.backgroundColor = [UIColor blackColor];
//    shipmentLocationStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    shipmentLocationStarLabel.font = [UIFont systemFontOfSize:30];
//
//    shipmentCityLabel = [[UILabel alloc] init];
//    shipmentCityLabel.layer.cornerRadius = 5.0f;
//    shipmentCityLabel.layer.masksToBounds = YES;
//    shipmentCityLabel.numberOfLines = 1;
//    shipmentCityLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentCityLabel.backgroundColor = [UIColor blackColor];
//    shipmentCityLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shipmentCityStarLabel = [[UILabel alloc] init];
//    shipmentCityStarLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentCityStarLabel.backgroundColor = [UIColor blackColor];
//    shipmentCityStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    shipmentCityStarLabel.font = [UIFont systemFontOfSize:30];
//
//    shipmentStateLabel = [[UILabel alloc] init];
//    shipmentStateLabel.layer.cornerRadius = 5.0f;
//    shipmentStateLabel.layer.masksToBounds = YES;
//    shipmentStateLabel.numberOfLines = 1;
//    shipmentStateLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentStateLabel.backgroundColor = [UIColor blackColor];
//    shipmentStateLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shipmentStateStarLabel = [[UILabel alloc] init];
//    shipmentStateStarLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentStateStarLabel.backgroundColor = [UIColor blackColor];
//    shipmentStateStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    shipmentStateStarLabel.font = [UIFont systemFontOfSize:30];
//
//
//    shipmentNameText = [[CustomTextField alloc] init];
//    shipmentNameText.delegate = self;
//    shipmentNameText.userInteractionEnabled  = YES;
//    shipmentNameText.placeholder = NSLocalizedString(@"enter_name", nil);
//    shipmentNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [shipmentNameText awakeFromNib];
//
//    shipmentLocationText = [[CustomTextField alloc] init];
//    shipmentLocationText.delegate = self;
//    shipmentLocationText.userInteractionEnabled  = YES;
//    shipmentLocationText.placeholder = NSLocalizedString(@"enter_landmark", nil);
//    shipmentLocationText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [shipmentLocationText awakeFromNib];
//
//    shipmentCityText = [[CustomTextField alloc] init];
//    shipmentCityText.delegate = self;
//    shipmentCityText.userInteractionEnabled  = YES;
//    shipmentCityText.placeholder = NSLocalizedString(@"enter_city", nil);
//    shipmentCityText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [shipmentCityText awakeFromNib];
//
//    shipmentStateText = [[CustomTextField alloc] init];
//    shipmentStateText.delegate = self;
//    shipmentStateText.userInteractionEnabled  = YES;
//    shipmentStateText.placeholder = NSLocalizedString(@"enter_state", nil);
//    shipmentStateText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [shipmentStateText awakeFromNib];
//
//    //row9
//
//    UILabel * otherDetailsLabel;
//
//    UILabel * orderChannelLabel;
//    UILabel * orderChannelStarLabel;
//    UILabel * shipmentTypeLabel;
//    UILabel * salesIdExecutiveNameLabel;
//
//    UILabel * refferredByLabel;
//
//    otherDetailsLabel = [[UILabel alloc] init];
//    otherDetailsLabel.layer.cornerRadius = 3.0f;
//    otherDetailsLabel.layer.masksToBounds = YES;
//    otherDetailsLabel.numberOfLines = 1;
//    otherDetailsLabel.textAlignment = NSTextAlignmentLeft;
//    otherDetailsLabel.backgroundColor = [UIColor grayColor];
//    otherDetailsLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    orderChannelLabel = [[UILabel alloc] init];
//    orderChannelLabel.layer.cornerRadius = 5.0f;
//    orderChannelLabel.layer.masksToBounds = YES;
//    orderChannelLabel.numberOfLines = 1;
//    orderChannelLabel.textAlignment = NSTextAlignmentLeft;
//    orderChannelLabel.backgroundColor = [UIColor blackColor];
//    orderChannelLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    orderChannelStarLabel = [[UILabel alloc] init];
//    orderChannelStarLabel.textAlignment = NSTextAlignmentLeft;
//    orderChannelStarLabel.backgroundColor = [UIColor blackColor];
//    orderChannelStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    orderChannelStarLabel.font = [UIFont systemFontOfSize:30];
//
//    shipmentTypeLabel = [[UILabel alloc] init];
//    shipmentTypeLabel.layer.cornerRadius = 5.0f;
//    shipmentTypeLabel.layer.masksToBounds = YES;
//    shipmentTypeLabel.numberOfLines = 1;
//    shipmentTypeLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentTypeLabel.backgroundColor = [UIColor blackColor];
//    shipmentTypeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    salesIdExecutiveNameLabel = [[UILabel alloc] init];
//    salesIdExecutiveNameLabel.layer.cornerRadius = 5.0f;
//    salesIdExecutiveNameLabel.layer.masksToBounds = YES;
//    salesIdExecutiveNameLabel.numberOfLines = 1;
//    salesIdExecutiveNameLabel.textAlignment = NSTextAlignmentLeft;
//    salesIdExecutiveNameLabel.backgroundColor = [UIColor blackColor];
//    salesIdExecutiveNameLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    refferredByLabel = [[UILabel alloc] init];
//    refferredByLabel.layer.cornerRadius = 5.0f;
//    refferredByLabel.layer.masksToBounds = YES;
//    refferredByLabel.numberOfLines = 1;
//    refferredByLabel.textAlignment = NSTextAlignmentLeft;
//    refferredByLabel.backgroundColor = [UIColor blackColor];
//    refferredByLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//
//    orderChannelText = [[CustomTextField alloc] init];
//    orderChannelText.delegate = self;
//    orderChannelText.userInteractionEnabled  = NO;
//    //    orderChannelText.text = NSLocalizedString(@"online",nil);
//    orderChannelText.placeholder = NSLocalizedString(@"order_channel", nil);
//    [orderChannelText awakeFromNib];
//
//    shipmentTypeText = [[CustomTextField alloc] init];
//    shipmentTypeText.delegate = self;
//    shipmentTypeText.userInteractionEnabled  = NO;
//    //    shipmentTypeText.text = NSLocalizedString(@"normal",nil);
//    shipmentTypeText.placeholder = NSLocalizedString(@"shipment_type", nil);
//    [shipmentTypeText awakeFromNib];
//
//    UIButton * orderChannelButton;
//    UIButton * shipmentTypeButton;
//
//    orderChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [orderChannelButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//    [orderChannelButton addTarget:self action:@selector(showOrderChannel:) forControlEvents:UIControlEventTouchDown];
//
//
//    shipmentTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shipmentTypeButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//    [shipmentTypeButton addTarget:self action:@selector(showShipmentType:) forControlEvents:UIControlEventTouchDown];
//
//
//    salesExecutiveIdText = [[CustomTextField alloc] init];
//    salesExecutiveIdText.delegate = self;
//    salesExecutiveIdText.userInteractionEnabled  = NO;
//    //    salesExecutiveIdText.placeholder = NSLocalizedString(@"id", nil);
//    salesExecutiveIdText.text = cashierId;
//    [salesExecutiveIdText awakeFromNib];
//
//    salesExecutiveNameText = [[CustomTextField alloc] init];
//    salesExecutiveNameText.delegate = self;
//    salesExecutiveNameText.userInteractionEnabled  = NO;
//    //    salesExecutiveNameText.placeholder = NSLocalizedString(@"enter_sales_executive_name", nil);
//    salesExecutiveNameText.text =  firstName;
//    [salesExecutiveNameText awakeFromNib];
//
//    refferedByText = [[CustomTextField alloc] init];
//    refferedByText.delegate = self;
//    refferedByText.userInteractionEnabled  = YES;
//    refferedByText.placeholder = NSLocalizedString(@" ", nil);
//    [refferedByText awakeFromNib];
//
//
//    //row10
//    UILabel * deliveryTypeLabel;
//    UILabel * deliveryTypeStarLabel;
//    UILabel * shipmentModeLabel;
//    UILabel * otherDiscountLabel;
//
//    deliveryTypeLabel = [[UILabel alloc] init];
//    deliveryTypeLabel.layer.cornerRadius = 5.0f;
//    deliveryTypeLabel.layer.masksToBounds = YES;
//    deliveryTypeLabel.numberOfLines = 1;
//    deliveryTypeLabel.textAlignment = NSTextAlignmentLeft;
//    deliveryTypeLabel.backgroundColor = [UIColor blackColor];
//    deliveryTypeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    deliveryTypeStarLabel = [[UILabel alloc] init];
//    deliveryTypeStarLabel.textAlignment = NSTextAlignmentLeft;
//    deliveryTypeStarLabel.backgroundColor = [UIColor blackColor];
//    deliveryTypeStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
//    deliveryTypeStarLabel.font = [UIFont systemFontOfSize:30];
//
//    shipmentModeLabel = [[UILabel alloc] init];
//    shipmentModeLabel.layer.cornerRadius = 5.0f;
//    shipmentModeLabel.layer.masksToBounds = YES;
//    shipmentModeLabel.numberOfLines = 1;
//    shipmentModeLabel.textAlignment = NSTextAlignmentLeft;
//    shipmentModeLabel.backgroundColor = [UIColor blackColor];
//    shipmentModeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    otherDiscountLabel = [[UILabel alloc] init];
//    otherDiscountLabel.layer.cornerRadius = 5.0f;
//    otherDiscountLabel.layer.masksToBounds = YES;
//    otherDiscountLabel.numberOfLines = 1;
//    otherDiscountLabel.textAlignment = NSTextAlignmentLeft;
//    otherDiscountLabel.backgroundColor = [UIColor blackColor];
//    otherDiscountLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    deliveryTypeText = [[CustomTextField alloc] init];
//    deliveryTypeText.delegate = self;
//    deliveryTypeText.userInteractionEnabled  = NO;
//    //    deliveryTypeText.text = NSLocalizedString(@"door_delivery_bills",nil);
//    deliveryTypeText.placeholder = NSLocalizedString(@"delivery_type", nil);
//    [deliveryTypeText awakeFromNib];
//
//    shipmentModeText = [[CustomTextField alloc] init];
//    shipmentModeText.delegate = self;
//    shipmentModeText.userInteractionEnabled  = NO;
//    //    shipmentModeText.text = NSLocalizedString(@"road",nil);
//    shipmentModeText.placeholder = NSLocalizedString(@"shipment_mode", nil);
//    [shipmentModeText awakeFromNib];
//
//
//    UIButton * deliveryTypeButton;
//    UIButton * shipmentModeButton;
//
//    deliveryTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [deliveryTypeButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//    [deliveryTypeButton addTarget:self action:@selector(showDeliveryType:) forControlEvents:UIControlEventTouchDown];
//
//
//    shipmentModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shipmentModeButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//    [shipmentModeButton addTarget:self action:@selector(showShipmentMode:) forControlEvents:UIControlEventTouchDown];
//
//    otherDiscPercentageTxt = [[CustomTextField alloc] init];
//    otherDiscPercentageTxt.userInteractionEnabled  = YES;
//    otherDiscPercentageTxt.placeholder = NSLocalizedString(@"enter_discount", nil);
//    otherDiscPercentageTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
//    otherDiscPercentageTxt.keyboardType = UIKeyboardTypeNumberPad;
//    otherDiscPercentageTxt.delegate = self;
//    [otherDiscPercentageTxt awakeFromNib];
//    [otherDiscPercentageTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    otherDiscAmountTxt = [[CustomTextField alloc] init];
//    otherDiscAmountTxt.userInteractionEnabled  = YES;
//    otherDiscAmountTxt.text= @"0.0";
//    otherDiscAmountTxt.placeholder = NSLocalizedString(@"discount_amount", nil);
//    otherDiscAmountTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
//    otherDiscAmountTxt.keyboardType = UIKeyboardTypeNumberPad;
//    [otherDiscAmountTxt awakeFromNib];
//    otherDiscAmountTxt.delegate = self;
//    [otherDiscAmountTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//    //End of Custom TextFields....
//
//    //Creation of Search Text to Search deals...
//    searchItemsText = [[CustomTextField alloc]init];
//    searchItemsText.borderStyle = UITextBorderStyleRoundedRect;
//    searchItemsText.placeholder = NSLocalizedString(@"search_items_here", nil);
//    searchItemsText.autocorrectionType = UITextAutocorrectionTypeNo;
//    searchItemsText.backgroundColor = [UIColor lightGrayColor];
//    searchItemsText.keyboardType = UIKeyboardTypeDefault;
//    searchItemsText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    searchItemsText.userInteractionEnabled = YES;
//    searchItemsText.delegate = self;
//    [searchItemsText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//
//    //Creation of scroll view
//    orderItemsScrollView = [[UIScrollView alloc] init];
//    //orderItemsScrollView.backgroundColor = [UIColor lightGrayColor];
//
//    /*Creation of UILabels used in this page*/
//    snoLabel = [[CustomLabel alloc] init];
//    [snoLabel awakeFromNib];
//
//    itemIdLabel = [[CustomLabel alloc] init];
//    [itemIdLabel awakeFromNib];
//
//    itemNameLabel = [[CustomLabel alloc] init];
//    [itemNameLabel awakeFromNib];
//
//    makeLabel = [[CustomLabel alloc] init];
//    [makeLabel awakeFromNib];
//
//    modelLabel = [[CustomLabel alloc] init];
//    [modelLabel awakeFromNib];
//
//    colorLabel = [[CustomLabel alloc] init];
//    [colorLabel awakeFromNib];
//
//    sizeLabel = [[CustomLabel alloc] init];
//    [sizeLabel awakeFromNib];
//
//    mrpLabel = [[CustomLabel alloc] init];
//    [mrpLabel awakeFromNib];
//
//    salePriceLabel = [[CustomLabel alloc] init];
//    [salePriceLabel awakeFromNib];
//
//    quantityLabel = [[CustomLabel alloc] init];
//    [quantityLabel awakeFromNib];
//
//    costLabel = [[CustomLabel alloc] init];
//    [costLabel awakeFromNib];
//
//    taxRateLabel = [[CustomLabel alloc] init];
//    [taxRateLabel awakeFromNib];
//
//    taxLabel = [[CustomLabel alloc] init];
//    [taxLabel awakeFromNib];
//
//    // added by roja on 10-09-2019...
//    promoIdLbl = [[CustomLabel alloc]init];
//    [promoIdLbl awakeFromNib];
//
//    discountLbl = [[CustomLabel alloc]init];
//    [discountLbl awakeFromNib];
//
//    uomLbl = [[CustomLabel alloc]init];
//    [uomLbl awakeFromNib];
//
//    offerLbl = [[CustomLabel alloc]init];
//    [offerLbl awakeFromNib];
//
//    // upto here added by roja on 10-09-2018..
//
//    actionLabel = [[CustomLabel alloc] init];
//    [actionLabel awakeFromNib];
//
//    //orderItemsTable creation...
//    orderItemsTable = [[UITableView alloc] init];
//    orderItemsTable.backgroundColor  = [UIColor blackColor];
//    orderItemsTable.layer.cornerRadius = 4.0;
//    orderItemsTable.bounces = TRUE;
//    orderItemsTable.dataSource = self;
//    orderItemsTable.delegate = self;
//    orderItemsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    //upto Here....
//
//    // table for drop down list to show the skuid's ..
//    productListTable = [[UITableView alloc] init];
//    productListTable.backgroundColor = [UIColor blackColor];
//    productListTable.dataSource = self;
//    productListTable.delegate = self;
//    productListTable.layer.cornerRadius = 3;
//
//
//    // Label Allocation for the taxes and other Tax Calculations.....
//    //
//    UILabel * subTotalLabel;
//
//    subTotalLabel = [[UILabel alloc] init];
//    subTotalLabel.layer.cornerRadius = 5.0f;
//    subTotalLabel.layer.masksToBounds = YES;
//    subTotalLabel.numberOfLines = 1;
//    subTotalLabel.textAlignment = NSTextAlignmentLeft;
//    subTotalLabel.backgroundColor = [UIColor blackColor];
//    subTotalLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//
//    subTotalText = [[CustomTextField alloc] init];
//    subTotalText.delegate = self;
//    subTotalText.userInteractionEnabled  = NO;
//    [subTotalText awakeFromNib];
//
//    // added by roja on 10-09-2018...
//    UILabel * totalTaxLbl;
//    UILabel * shippingCostLabel;
//
//    // added by roja on 10-09-2018...
//    totalTaxLbl = [[UILabel alloc] init];
//    totalTaxLbl.layer.cornerRadius = 5.0f;
//    totalTaxLbl.layer.masksToBounds = YES;
//    totalTaxLbl.numberOfLines = 1;
//    totalTaxLbl.textAlignment = NSTextAlignmentLeft;
//    totalTaxLbl.backgroundColor = [UIColor blackColor];
//    totalTaxLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    shippingCostLabel = [[UILabel alloc] init];
//    shippingCostLabel.layer.cornerRadius = 5.0f;
//    shippingCostLabel.layer.masksToBounds = YES;
//    shippingCostLabel.numberOfLines = 1;
//    shippingCostLabel.textAlignment = NSTextAlignmentLeft;
//    shippingCostLabel.backgroundColor = [UIColor blackColor];
//    shippingCostLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//
//    // added by roja on 10-09-2018..
//    totalTaxTxt = [[CustomTextField alloc] init];
//    totalTaxTxt.delegate = self;
//    totalTaxTxt.userInteractionEnabled  = NO;
//    [totalTaxTxt awakeFromNib];
//
//    shippingCostText = [[CustomTextField alloc] init];
//    shippingCostText.delegate = self;
//    shippingCostText.userInteractionEnabled  = YES;
//    shippingCostText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [shippingCostText awakeFromNib];
//    [shippingCostText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//
//    otherDiscountText = [[CustomTextField alloc] init];
//    otherDiscountText.delegate = self;
//    otherDiscountText.userInteractionEnabled  = NO;
//    [otherDiscountText awakeFromNib];
//    [otherDiscountText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    orderTotalsView = [[UIView alloc]init];
//    orderTotalsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
//    orderTotalsView.layer.borderWidth =3.0f;
//
//
//    UILabel * totalCostLabel;
//    UILabel * amountPaidLabel;
//    UILabel * amountDueLabel;
//
//    totalCostLabel = [[UILabel alloc] init];
//    totalCostLabel.layer.masksToBounds = YES;
//    totalCostLabel.numberOfLines = 1;
//
//
//    amountPaidLabel = [[UILabel alloc] init];
//    amountPaidLabel.layer.masksToBounds = YES;
//    amountPaidLabel.numberOfLines = 1;
//
//    amountDueLabel = [[UILabel alloc] init];
//    amountDueLabel.layer.masksToBounds = YES;
//    amountDueLabel.numberOfLines = 1;
//
//
//
//    totalCostLabel.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//    amountPaidLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//    amountDueLabel.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    totalCostLabel.textAlignment  = NSTextAlignmentLeft;
//    amountPaidLabel.textAlignment = NSTextAlignmentLeft;
//    amountDueLabel.textAlignment  = NSTextAlignmentLeft;
//
//
//    //
//
//    totalCostText = [[UITextField alloc] init];
//    totalCostText.borderStyle = UITextBorderStyleRoundedRect;
//    totalCostText.keyboardType = UIKeyboardTypeNumberPad;
//    totalCostText.layer.borderWidth = 1;
//    totalCostText.backgroundColor = [UIColor blackColor];
//    totalCostText.autocorrectionType = UITextAutocorrectionTypeNo;
//    totalCostText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    totalCostText.returnKeyType = UIReturnKeyDone;
//    totalCostText.userInteractionEnabled  = NO;
//    totalCostText.delegate = self;
//
//
//    amountDueText = [[UITextField alloc] init];
//    amountDueText.borderStyle = UITextBorderStyleRoundedRect;
//    amountDueText.keyboardType = UIKeyboardTypeNumberPad;
//    amountDueText.layer.borderWidth = 1;
//    amountDueText.backgroundColor = [UIColor blackColor];
//    amountDueText.autocorrectionType = UITextAutocorrectionTypeNo;
//    amountDueText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    amountDueText.returnKeyType = UIReturnKeyDone;
//    amountDueText.userInteractionEnabled  = NO;
//    amountDueText.delegate = self;
//
//
//    amountPaidText = [[UITextField alloc] init];
//    amountPaidText.borderStyle = UITextBorderStyleRoundedRect;
//    amountPaidText.keyboardType = UIKeyboardTypeNumberPad;
//    amountPaidText.layer.borderWidth = 1;
//    amountPaidText.backgroundColor = [UIColor blackColor];
//    amountPaidText.autocorrectionType = UITextAutocorrectionTypeNo;
//    amountPaidText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    amountPaidText.returnKeyType = UIReturnKeyDone;
//    amountPaidText.delegate = self;
//    [amountPaidText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    totalCostText.textAlignment      = NSTextAlignmentLeft;
//    amountDueText.textAlignment      = NSTextAlignmentLeft;
//    amountPaidText.textAlignment     = NSTextAlignmentLeft;
//
//    totalCostText.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//    amountDueText.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//    amountPaidText.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//
//    totalCostText.text  = @"0.00";
//    amountDueText.text  = @"0.00";
//    amountPaidText.text = @"0.00";
//    shippingCostText.text = @"0.00";
//    totalTaxTxt.text = @"0.00";
//    subTotalText.text = @"0.00";
//    otherDiscountText.text = @"0.00";
//
//    UIButton * submitButton2;
//    UIButton * saveButton2;
//    UIButton * backButton2;
//
//    // Creation of UIButton....
//    submitButton2 = [[UIButton alloc] init];
//    submitButton2.layer.cornerRadius = 3.0f;
//    submitButton2.backgroundColor = [UIColor grayColor];
//    [submitButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    saveButton2 = [[UIButton alloc] init];
//    saveButton2.layer.cornerRadius = 3.0f;
//    saveButton2.backgroundColor = [UIColor grayColor];
//    [saveButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    backButton2 = [[UIButton alloc] init];
//    backButton2.layer.cornerRadius = 3.0f;
//    backButton2.backgroundColor = [UIColor grayColor];
//    [backButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    [submitButton2 addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
//    [saveButton2 addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
//    [backButton2 addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
//
//    if(isManualDiscounts){
//        // otherDiscountText.userInteractionEnabled  = YES;
//
//    }
//
//
//#pragma mark UITableView..
//
//    //UITableView Creation for the popup's
//    paymentModeTable  = [[UITableView alloc] init];
//    paymentTypeTable  = [[UITableView alloc] init];
//    virtualStoreTable = [[UITableView alloc] init];
//    orderChannelTable = [[UITableView alloc] init];
//    shipmentTypeTable = [[UITableView alloc] init];
//    deliveryTypeTable = [[UITableView alloc] init];
//    shipmentModeTable = [[UITableView alloc] init];
//
//
//    //setting the titleName for the Page....
//    self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
//
//    headerNameLabel.text = NSLocalizedString(@"new_order", nil);
//
//    orderDetailsLabel.text = NSLocalizedString(@"order_details",nil);
//
//    [submitButton setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
//    [saveButton setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
//    [backButton setTitle:NSLocalizedString(@"back_",nil) forState:UIControlStateNormal];
//
//    orderDateLabel.text = NSLocalizedString(@"order_date", nil);
//    orderDateStarLabel.text = NSLocalizedString(@"*", nil);
//    deliveryDateLabel.text = NSLocalizedString(@"delivery_Date", nil);
//    deliveryDateStarLabel.text = NSLocalizedString(@"*", nil);
//    paymentModeLabel.text = NSLocalizedString(@"payment_mode", nil);
//    paymentModeStarLabel.text = NSLocalizedString(@"*", nil);
//    paymentTypeLabel.text = NSLocalizedString(@"payment_type", nil);
//    paymentTypeStarLabel.text = NSLocalizedString(@"*", nil);
//    locationLabel.text = NSLocalizedString(@"location",nil);
//    locationStarLabel.text = NSLocalizedString(@"*", nil);
//    customerEmailIdLabel.text = NSLocalizedString(@"customer_email_id",nil);
//    customerEmailIdStarLabel.text = NSLocalizedString(@"*", nil);
//    customerMobileNoLabel.text = NSLocalizedString(@"customer_mobile_no",nil);
//    customerMobileNoStarLabel.text = NSLocalizedString(@"*",nil);
//    paymentRefLabel.text = NSLocalizedString(@"payment_ref",nil);
//
//    customerAddressLabel.text = NSLocalizedString(@"customer_address",nil);
//    streetLabel.text = NSLocalizedString(@"street",nil);
//    streetStarLabel.text = NSLocalizedString(@"*", nil);
//    customerLocationLabel.text = NSLocalizedString(@"location",nil);
//    customerLocationStarLabel.text = NSLocalizedString(@"*", nil);
//    cityLabel.text = NSLocalizedString(@"city",nil);
//    cityStarLabel.text = NSLocalizedString(@"*", nil);
//
//    doorNoLabel.text = NSLocalizedString(@"door_no",nil);
//    doorNoStarLabel.text = NSLocalizedString(@"*", nil);
//    contactNoLabel.text = NSLocalizedString(@"contact_no",nil);
//    contactNoStarLabel.text = NSLocalizedString(@"*", nil);
//    googleMapLinkLabel.text = NSLocalizedString(@"google_map_link",nil);
//    pinLabel.text = NSLocalizedString(@"pin_code",nil);
//
//    billingAddressLabel.text = NSLocalizedString(@"billing_adderess",nil);
//    billingStreetLabel.text = NSLocalizedString(@"street",nil);
//    //    billingStreetStarLabel.text = NSLocalizedString(@"*", nil);
//    billingLocationLabel.text = NSLocalizedString(@"location",nil);
//    //    billingLocationStarLabel.text = NSLocalizedString(@"*", nil);
//    billingCityLabel.text = NSLocalizedString(@"city",nil);
//    //    billingCityStarLabel.text = NSLocalizedString(@"*", nil);
//
//    billingDoorNoLabel.text = NSLocalizedString(@"door_no",nil);
//    //    billingDoorNoStarLabel.text = NSLocalizedString(@"*", nil);
//    billingContactNoLabel.text = NSLocalizedString(@"contact_no",nil);
//    //    billingContactNoStarLabel.text = NSLocalizedString(@"*", nil);
//    billingGoogleMapLinkLabel.text = NSLocalizedString(@"google_map_link",nil);
//    billingPinCodeLabel.text = NSLocalizedString(@"pin_code",nil);
//
//    shipmentAddressLabel.text = NSLocalizedString(@"shipment_address",nil);
//
//    shipmentContactNoLabel.text = NSLocalizedString(@"contact_no",nil);
//    shipmentContactNoStarLabel.text = NSLocalizedString(@"*", nil);
//    shipmentDoorNoLabel.text = NSLocalizedString(@"door_no",nil);
//    shipmentDoorNoStarLabel.text = NSLocalizedString(@"*", nil);
//    shipmentStreetNoLabel.text = NSLocalizedString(@"street",nil);
//    shipmentStreetNoStarLabel.text = NSLocalizedString(@"*", nil);
//
//
//    shipmentNameLabel.text = NSLocalizedString(@"name",nil);
//    shipmentNameStarLabel.text = NSLocalizedString(@"*", nil);
//    shipmentLocationLabel.text = NSLocalizedString(@"location",nil);
//    shipmentLocationStarLabel.text = NSLocalizedString(@"*", nil);
//    shipmentCityLabel.text = NSLocalizedString(@"city",nil);
//    shipmentCityStarLabel.text = NSLocalizedString(@"*", nil);
//    shipmentStateLabel.text = NSLocalizedString(@"state",nil);
//    shipmentStateStarLabel.text = NSLocalizedString(@"*", nil);
//
//    otherDetailsLabel.text = NSLocalizedString(@"other_details",nil);
//
//    orderChannelLabel.text = NSLocalizedString(@"Oder_channel",nil);
//    orderChannelStarLabel.text = NSLocalizedString(@"*", nil);
//    shipmentTypeLabel.text = NSLocalizedString(@"shipment_type",nil);
//    salesIdExecutiveNameLabel.text = NSLocalizedString(@"sales_executive_name",nil);
//    refferredByLabel.text = NSLocalizedString(@"referred_by",nil);
//
//    deliveryTypeLabel.text = NSLocalizedString(@"delivery_type",nil);
//    deliveryTypeStarLabel.text = NSLocalizedString(@"*", nil);
//    shipmentModeLabel.text = NSLocalizedString(@"shipment_mode",nil);
//    otherDiscountLabel.text = NSLocalizedString(@"other_Disc_(%)",nil);
//
//    //NSLocalized Strings for the CustomLabels...
//
//    snoLabel.text = NSLocalizedString(@"s_no",nil);
//    itemIdLabel.text = NSLocalizedString(@"item_id",nil);
//    itemNameLabel.text = NSLocalizedString(@"item_name",nil);
//    makeLabel.text = NSLocalizedString(@"make",nil);
//    modelLabel.text = NSLocalizedString(@"model",nil);
//    colorLabel.text = NSLocalizedString(@"color",nil);
//    sizeLabel.text = NSLocalizedString(@"size",nil);
//    mrpLabel.text = NSLocalizedString(@"mrp",nil);
//    salePriceLabel.text = NSLocalizedString(@"sale_price",nil);
//    quantityLabel.text = NSLocalizedString(@"qty",nil);
//    costLabel.text = NSLocalizedString(@"cost",nil);
//    taxRateLabel.text = NSLocalizedString(@"tax_rate",nil);
//    taxLabel.text = NSLocalizedString(@"tax",nil);
//
//    // added by roja on 10-09-2018...
//    promoIdLbl.text = NSLocalizedString(@"promo_id", nil);
//    uomLbl.text = NSLocalizedString(@"uom", nil);
//    offerLbl.text = NSLocalizedString(@"offer", nil);
//    discountLbl.text = NSLocalizedString(@"discount", "");
//    actionLabel.text = NSLocalizedString(@"action",nil);
//
//
//    //NSLocalized Strings for the Tax Calculation Labels...
//    subTotalLabel.text = NSLocalizedString(@"sub_total",nil);
//
//    // added by roja on 10-09-2018...
//    totalTaxLbl.text     = NSLocalizedString(@"total_tax",nil);
//
//    shippingCostLabel.text   = NSLocalizedString(@"shipping_cost",nil);
//
//    totalCostLabel.text  = NSLocalizedString(@"total_cost:",nil);
//    amountPaidLabel.text  = NSLocalizedString(@"amount_paid",nil);
//    amountDueLabel.text  = NSLocalizedString(@"amount_due",nil);
//
//    [submitButton2 setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
//    [saveButton2 setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
//    [backButton2 setTitle:NSLocalizedString(@"back_",nil) forState:UIControlStateNormal];
//
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
//
//        }
//        else {
//
//        }
//
//        //setting frame for the createOrderView....
//        createOrderView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
//
//        //seting frame for headerNameLbl....
//        headerNameLabel.frame = CGRectMake( 0, 0, createOrderView.frame.size.width, 45);
//
//        //frame for the CreateOrderScrollView....
//        createOrderScrollView.frame = CGRectMake(headerNameLabel.frame.origin.x, headerNameLabel.frame.origin.y + headerNameLabel.frame.size.height,createOrderView.frame.size.width,createOrderView.frame.size.height - 45);
//
//        orderDetailsLabel.frame = CGRectMake(10,10,200,40);
//
//        submitButton.frame = CGRectMake(((createOrderScrollView.frame.size.width)/2) + 155, 10, 110, 40);
//
//        saveButton.frame = CGRectMake(submitButton.frame.origin.x + submitButton.frame.size.width + 10, submitButton.frame.origin.y, 110, 40);
//
//        backButton.frame = CGRectMake(saveButton.frame.origin.x + saveButton.frame.size.width + 10, submitButton.frame.origin.y, 110, 40);
//
//        separationLabel.frame = CGRectMake(headerNameLabel.frame.origin.x,submitButton.frame.origin.y + submitButton.frame.size.height + 5,headerNameLabel.frame.size.width,0.5);
//
//        float labelHeight  = 30;
//        float horizontaGap = 154;
//
//        //Row1
//        //        orderDateStarLabel.frame  = CGRectMake(orderDateLabel.frame.origin.x + orderDateLabel.frame.size.width + 2, orderDateLabel.frame.origin.y, 40, labelHeight);
//
//        orderDateLabel.frame  = CGRectMake(orderDetailsLabel.frame.origin.x, separationLabel.frame.origin.y + separationLabel.frame.size.height + 10, 120, labelHeight);
//        orderDateStarLabel.frame  = CGRectMake((orderDateLabel.frame.origin.x + orderDateLabel.frame.size.width - 25), orderDateLabel.frame.origin.y, 30, labelHeight);
//        orderDateText.frame   = CGRectMake(orderDateLabel.frame.origin.x, orderDateLabel.frame.origin.y + orderDateLabel.frame.size.height - 5,180, 40);
//        orderDateButton.frame = CGRectMake ((orderDateText.frame.origin.x + orderDateText.frame.size.width - 45), orderDateText.frame.origin.y + 2, 40, 35);
//
//
//        deliveryDateLabel.frame  = CGRectMake(orderDateLabel.frame.origin.x + orderDateLabel.frame.size.width + horizontaGap, orderDateLabel.frame.origin.y , 110, labelHeight);
//        deliveryDateStarLabel.frame  = CGRectMake(deliveryDateLabel.frame.origin.x + deliveryDateLabel.frame.size.width + 2, deliveryDateLabel.frame.origin.y, 30, labelHeight);
//        deliveryDateText.frame   = CGRectMake(deliveryDateLabel.frame.origin.x, orderDateText.frame.origin.y,180, 40);
//        deliveryDateButton.frame = CGRectMake ((deliveryDateText.frame.origin.x + deliveryDateText.frame.size.width - 45), deliveryDateText.frame.origin.y + 2, 40, 35);
//
//        paymentTypeLabel.frame  = CGRectMake(deliveryDateLabel.frame.origin.x + deliveryDateLabel.frame.size.width + horizontaGap, orderDateLabel.frame.origin.y , 120, labelHeight);
//        paymentTypeStarLabel.frame = CGRectMake(paymentTypeLabel.frame.origin.x + paymentTypeLabel.frame.size.width - 6, deliveryDateLabel.frame.origin.y, 30, labelHeight);
//        paymentTypeText.frame   = CGRectMake(paymentTypeLabel.frame.origin.x, orderDateText.frame.origin.y, 180, 40);
//
//        paymentTypeButton.frame = CGRectMake ((paymentTypeText.frame.origin.x + paymentTypeText.frame.size.width - 45), paymentTypeText.frame.origin.y - 8,  55, 60);
//
//        paymentModeLabel.frame  = CGRectMake(paymentTypeLabel.frame.origin.x + paymentTypeLabel.frame.size.width + horizontaGap, orderDateLabel.frame.origin.y , 120, labelHeight);
//        paymentModeStarLabel.frame = CGRectMake(paymentModeLabel.frame.origin.x + paymentModeLabel.frame.size.width - 6, deliveryDateLabel.frame.origin.y, 30, labelHeight);
//        paymentModeText.frame   = CGRectMake(paymentModeLabel.frame.origin.x, orderDateText.frame.origin.y ,180, 40);
//        paymentModeButton.frame = CGRectMake ((paymentModeText.frame.origin.x + paymentModeText.frame.size.width - 45), paymentModeText.frame.origin.y - 8,  55, 60);
//
//
//        //Row2...
//
//        locationLabel.frame  = CGRectMake(orderDateLabel.frame.origin.x, orderDateText.frame.origin.y + orderDateText.frame.size.height + 15, 120, labelHeight);
//        locationStarLabel.frame  = CGRectMake(locationLabel.frame.origin.x + locationLabel.frame.size.width - 44, locationLabel.frame.origin.y, 30, labelHeight);
//        locationText.frame   = CGRectMake(locationLabel.frame.origin.x, locationLabel.frame.origin.y + locationLabel.frame.size.height - 5,180, 40);
//        locationButton.frame = CGRectMake ((locationText.frame.origin.x + locationText.frame.size.width - 45), locationText.frame.origin.y - 8,  55, 60);
//
//        customerEmailIdLabel.frame  = CGRectMake(deliveryDateLabel.frame.origin.x, locationLabel.frame.origin.y, 160, labelHeight);
//        customerEmailIdStarLabel.frame  = CGRectMake(customerEmailIdLabel.frame.origin.x + customerEmailIdLabel.frame.size.width, customerEmailIdLabel.frame.origin.y, 30, labelHeight);
//        customerEmailIdText.frame   = CGRectMake(customerEmailIdLabel.frame.origin.x, locationText.frame.origin.y,200, 40);
//
//
//        customerMobileNoLabel.frame  = CGRectMake(paymentTypeLabel.frame.origin.x, locationLabel.frame.origin.y, 160, labelHeight);
//        customerMobileNoStarLabel.frame = CGRectMake(customerMobileNoLabel.frame.origin.x + customerMobileNoLabel.frame.size.width + 2, locationLabel.frame.origin.y, 30, labelHeight);
//        customerMobileNoText.frame   = CGRectMake(customerMobileNoLabel.frame.origin.x, locationText.frame.origin.y,180, 40);
//
//        paymentRefLabel.frame  = CGRectMake(paymentModeLabel.frame.origin.x, locationLabel.frame.origin.y, 160, labelHeight);
//        paymentRefText.frame   = CGRectMake(paymentRefLabel.frame.origin.x, locationText.frame.origin.y,180, 40);
//
//        customerAddressLabel.frame = CGRectMake(orderDateLabel.frame.origin.x, locationText.frame.origin.y + locationText.frame.size.height + 50,220, 55);
//
//        streetLabel.frame = CGRectMake(deliveryDateLabel.frame.origin.x,customerAddressLabel.frame.origin.y - 3, 160, 20);
//        streetStarLabel.frame = CGRectMake(streetLabel.frame.origin.x + streetLabel.frame.size.width - 103, streetLabel.frame.origin.y, 30, labelHeight);
//        streetText.frame  = CGRectMake(streetLabel.frame.origin.x,streetLabel.frame.origin.y + streetLabel.frame.size.height,210,40);
//
//        customerLocationLabel.frame = CGRectMake(customerMobileNoLabel.frame.origin.x,streetLabel.frame.origin.y,160,20);
//        customerLocationStarLabel.frame = CGRectMake(customerLocationLabel.frame.origin.x + customerLocationLabel.frame.size.width - 84, customerLocationLabel.frame.origin.y, 30, labelHeight);
//        customerLocationText.frame  = CGRectMake(customerLocationLabel.frame.origin.x,streetText.frame.origin.y ,210,40);
//
//        cityLabel.frame = CGRectMake(paymentRefLabel.frame.origin.x,streetLabel.frame.origin.y,160,20);
//        cityStarLabel.frame = CGRectMake(cityLabel.frame.origin.x + cityLabel.frame.size.width - 122, cityLabel.frame.origin.y, 30, labelHeight);
//        customerCityText.frame  = CGRectMake(cityLabel.frame.origin.x,streetText.frame.origin.y ,180,40);
//
//        doorNoLabel.frame = CGRectMake(customerAddressLabel.frame.origin.x,customerAddressLabel.frame.origin.y + customerAddressLabel.frame.size.height + 15,160,20);
//        doorNoStarLabel.frame = CGRectMake(doorNoLabel.frame.origin.x + doorNoLabel.frame.size.width - 94, doorNoLabel.frame.origin.y, 30, labelHeight);
//        doorNoText.frame  = CGRectMake(doorNoLabel.frame.origin.x,doorNoLabel.frame.origin.y + doorNoLabel.frame.size.height ,220,40);
//
//        contactNoLabel.frame = CGRectMake(streetLabel.frame.origin.x,doorNoLabel.frame.origin.y,160,20);
//        contactNoStarLabel.frame = CGRectMake(contactNoLabel.frame.origin.x + contactNoLabel.frame.size.width - 65, contactNoLabel.frame.origin.y, 30, labelHeight);
//        contactNoText.frame  = CGRectMake(contactNoLabel.frame.origin.x,doorNoText.frame.origin.y ,streetText.frame.size.width, 40);
//
//        googleMapLinkLabel.frame = CGRectMake(customerLocationLabel.frame.origin.x,doorNoLabel.frame.origin.y,160,20);
//        googleMapLinkText.frame  = CGRectMake(googleMapLinkLabel.frame.origin.x,doorNoText.frame.origin.y ,customerLocationText.frame.size.width, 40);
//
//        pinLabel.frame = CGRectMake(cityLabel.frame.origin.x,doorNoLabel.frame.origin.y,160,20);
//        pinNoText.frame  = CGRectMake(pinLabel.frame.origin.x,doorNoText.frame.origin.y ,customerCityText.frame.size.width, 40);
//
//
//        //
//        billingAddressLabel.frame = CGRectMake(orderDateLabel.frame.origin.x, doorNoText.frame.origin.y + doorNoText.frame.size.height + 50,220, 55);
//
//        billingStreetLabel.frame = CGRectMake(deliveryDateLabel.frame.origin.x,billingAddressLabel.frame.origin.y - 3,160,20);
//        //        billingStreetStarLabel.frame = CGRectMake(streetStarLabel.frame.origin.x, billingStreetLabel.frame.origin.y, 30, labelHeight);
//        billingStreetText.frame  = CGRectMake(billingStreetLabel.frame.origin.x,billingStreetLabel.frame.origin.y + billingStreetLabel.frame.size.height,210,40);
//
//        billingLocationLabel.frame = CGRectMake(customerMobileNoLabel.frame.origin.x,billingStreetLabel.frame.origin.y,160,20);
//        //        billingLocationStarLabel.frame = CGRectMake(customerLocationStarLabel.frame.origin.x, billingLocationLabel.frame.origin.y, 30, labelHeight);
//        billingLocationText.frame  = CGRectMake(billingLocationLabel.frame.origin.x,billingStreetText.frame.origin.y ,210,40);
//
//        billingCityLabel.frame = CGRectMake(paymentRefLabel.frame.origin.x,billingStreetLabel.frame.origin.y,160,20);
//        //        billingCityStarLabel.frame = CGRectMake(cityStarLabel.frame.origin.x, billingCityLabel.frame.origin.y, 30, labelHeight);
//        billingCityText.frame  = CGRectMake(billingCityLabel.frame.origin.x,billingStreetText.frame.origin.y ,180,40);
//
//
//        billingDoorNoLabel.frame = CGRectMake(customerAddressLabel.frame.origin.x,billingAddressLabel.frame.origin.y + billingAddressLabel.frame.size.height + 15,160,20);
//        //        billingDoorNoStarLabel.frame = CGRectMake(doorNoStarLabel.frame.origin.x, billingDoorNoLabel.frame.origin.y, 30, labelHeight);
//        billingDoorNoText.frame  = CGRectMake(billingDoorNoLabel.frame.origin.x,billingDoorNoLabel.frame.origin.y + billingDoorNoLabel.frame.size.height ,220,40);
//
//        billingContactNoLabel.frame = CGRectMake(streetLabel.frame.origin.x,billingDoorNoLabel.frame.origin.y,160,20);
//        //        billingContactNoStarLabel.frame = CGRectMake(contactNoStarLabel.frame.origin.x, billingContactNoLabel.frame.origin.y, 30, labelHeight);
//        billingContactNoText.frame  = CGRectMake(contactNoLabel.frame.origin.x,billingDoorNoText.frame.origin.y ,streetText.frame.size.width, 40);
//
//        billingGoogleMapLinkLabel.frame = CGRectMake(customerLocationLabel.frame.origin.x,billingDoorNoLabel.frame.origin.y,160,20);
//        billingGoogleMapLinkText.frame  = CGRectMake(billingGoogleMapLinkLabel.frame.origin.x,billingDoorNoText.frame.origin.y ,customerLocationText.frame.size.width, 40);
//
//        billingPinCodeLabel.frame = CGRectMake(cityLabel.frame.origin.x,billingDoorNoLabel.frame.origin.y,160,20);
//        billingPinNoText.frame  = CGRectMake(billingPinCodeLabel.frame.origin.x,billingDoorNoText.frame.origin.y ,customerCityText.frame.size.width, 40);
//
//        //frames for row7.....
//        shipmentAddressLabel.frame = CGRectMake(orderDateLabel.frame.origin.x, billingDoorNoText.frame.origin.y + billingDoorNoText.frame.size.height + 50,220, 55);
//
//        shipmentContactNoLabel.frame = CGRectMake(deliveryDateLabel.frame.origin.x,shipmentAddressLabel.frame.origin.y - 3,160,20);
//        shipmentContactNoStarLabel.frame = CGRectMake(contactNoStarLabel.frame.origin.x, shipmentContactNoLabel.frame.origin.y, 30, labelHeight);
//        shipmentContactNoText.frame  = CGRectMake(shipmentContactNoLabel.frame.origin.x,shipmentContactNoLabel.frame.origin.y + shipmentContactNoLabel.frame.size.height,210,40);
//
//        shipmentDoorNoLabel.frame = CGRectMake(customerMobileNoLabel.frame.origin.x,shipmentContactNoLabel.frame.origin.y,160,20);
//        shipmentDoorNoStarLabel.frame = CGRectMake(shipmentDoorNoLabel.frame.origin.x + shipmentDoorNoLabel.frame.size.width - 94, shipmentDoorNoLabel.frame.origin.y, 30, labelHeight);
//        shipmentDoorNoText.frame  = CGRectMake(shipmentDoorNoLabel.frame.origin.x,shipmentContactNoText.frame.origin.y ,210,40);
//
//        shipmentStreetNoLabel.frame = CGRectMake(paymentRefLabel.frame.origin.x,shipmentContactNoLabel.frame.origin.y,160,20);
//        shipmentStreetNoStarLabel.frame = CGRectMake(shipmentStreetNoLabel.frame.origin.x + shipmentStreetNoLabel.frame.size.width - 103, shipmentStreetNoLabel.frame.origin.y, 30, labelHeight);
//        shipmentStreetNoText.frame  = CGRectMake(shipmentStreetNoLabel.frame.origin.x,shipmentContactNoText.frame.origin.y ,180,40);
//
//        //row8
//        shipmentNameLabel.frame = CGRectMake(customerAddressLabel.frame.origin.x,shipmentAddressLabel.frame.origin.y + shipmentAddressLabel.frame.size.height + 15,160,20);
//        shipmentNameStarLabel.frame = CGRectMake(shipmentNameLabel.frame.origin.x + shipmentNameLabel.frame.size.width - 110, shipmentNameLabel.frame.origin.y, 30, labelHeight);
//        shipmentNameText.frame  = CGRectMake(shipmentNameLabel.frame.origin.x,shipmentNameLabel.frame.origin.y + shipmentNameLabel.frame.size.height ,220,40);
//
//        shipmentLocationLabel.frame = CGRectMake(streetLabel.frame.origin.x,shipmentNameLabel.frame.origin.y,160,20);
//        shipmentLocationStarLabel.frame = CGRectMake(shipmentLocationLabel.frame.origin.x + shipmentLocationLabel.frame.size.width - 84, shipmentLocationLabel.frame.origin.y, 30, labelHeight);
//        shipmentLocationText.frame  = CGRectMake(shipmentLocationLabel.frame.origin.x,shipmentNameText.frame.origin.y ,streetText.frame.size.width, 40);
//
//        shipmentCityLabel.frame = CGRectMake(customerLocationLabel.frame.origin.x,shipmentNameLabel.frame.origin.y,160,20);
//        shipmentCityStarLabel.frame = CGRectMake(shipmentCityLabel.frame.origin.x + shipmentCityLabel.frame.size.width - 122, shipmentCityLabel.frame.origin.y, 30, labelHeight);
//        shipmentCityText.frame  = CGRectMake(shipmentCityLabel.frame.origin.x,shipmentNameText.frame.origin.y ,customerLocationText.frame.size.width, 40);
//
//        shipmentStateLabel.frame = CGRectMake(cityLabel.frame.origin.x,shipmentNameLabel.frame.origin.y,160,20);
//        shipmentStateStarLabel.frame = CGRectMake(shipmentStateLabel.frame.origin.x + shipmentStateLabel.frame.size.width - 112, shipmentStateLabel.frame.origin.y, 30, labelHeight);
//        shipmentStateText.frame  = CGRectMake(shipmentStateLabel.frame.origin.x,shipmentNameText.frame.origin.y ,customerCityText.frame.size.width, 40);
//
//        //row9
//
//        //frames for row9.....
//        otherDetailsLabel.frame = CGRectMake(orderDateLabel.frame.origin.x, shipmentStateText.frame.origin.y + shipmentStateText.frame.size.height + 50,220, 55);
//
//        orderChannelLabel.frame = CGRectMake(deliveryDateLabel.frame.origin.x, otherDetailsLabel.frame.origin.y - 3, 160, 20);
//        orderChannelStarLabel.frame = CGRectMake(orderChannelLabel.frame.origin.x + orderChannelLabel.frame.size.width - 36, orderChannelLabel.frame.origin.y, 15, 20);
//        orderChannelText.frame  = CGRectMake(orderChannelLabel.frame.origin.x,orderChannelLabel.frame.origin.y +orderChannelLabel.frame.size.height, 210, 40);
//        orderChannelButton.frame = CGRectMake ((orderChannelText.frame.origin.x + orderChannelText.frame.size.width - 45), orderChannelText.frame.origin.y - 8,  55, 60);
//
//        deliveryTypeLabel.frame = CGRectMake(customerMobileNoLabel.frame.origin.x, orderChannelLabel.frame.origin.y,160,20 );
//        deliveryTypeStarLabel.frame = CGRectMake(deliveryTypeLabel.frame.origin.x + deliveryTypeLabel.frame.size.width - 40, deliveryTypeLabel.frame.origin.y, 15, 20);
//        deliveryTypeText.frame = CGRectMake(deliveryTypeLabel.frame.origin.x,deliveryTypeLabel.frame.origin.y + deliveryTypeLabel.frame.size.height,orderChannelText.frame.size.width, 40);
//        deliveryTypeButton.frame = CGRectMake ((deliveryTypeText.frame.origin.x + deliveryTypeText.frame.size.width - 45), deliveryTypeText.frame.origin.y - 8,  55, 60);
//
//        shipmentTypeLabel.frame = CGRectMake(paymentRefLabel.frame.origin.x, orderChannelLabel.frame.origin.y, 160, 20);
//        shipmentTypeText.frame = CGRectMake(shipmentTypeLabel.frame.origin.x, orderChannelText.frame.origin.y, 180, 40);
//        shipmentTypeButton.frame = CGRectMake ((shipmentTypeText.frame.origin.x + shipmentTypeText.frame.size.width - 45), shipmentTypeText.frame.origin.y - 8, 55, 60);
//
//        shipmentModeLabel.frame = CGRectMake(otherDetailsLabel.frame.origin.x, otherDetailsLabel.frame.origin.y + otherDetailsLabel.frame.size.height + 15, 160,20);
//        shipmentModeText.frame = CGRectMake(shipmentModeLabel.frame.origin.x,shipmentModeLabel.frame.origin.y + shipmentModeLabel.frame.size.height ,otherDetailsLabel.frame.size.width, 40);
//        shipmentModeButton.frame = CGRectMake ((shipmentModeText.frame.origin.x + shipmentModeText.frame.size.width - 45), shipmentModeText.frame.origin.y - 8,  55, 60);
//
//        salesIdExecutiveNameLabel.frame = CGRectMake(streetLabel.frame.origin.x, shipmentModeLabel.frame.origin.y ,190,20);
//        salesExecutiveIdText.frame = CGRectMake(salesIdExecutiveNameLabel.frame.origin.x,shipmentModeText.frame.origin.y,100,40 );
//        salesExecutiveNameText.frame  = CGRectMake(salesExecutiveIdText.frame.origin.x + salesExecutiveIdText.frame.size.width + 10, salesExecutiveIdText.frame.origin.y,100,40);
//
//        otherDiscountLabel.frame = CGRectMake(deliveryTypeLabel.frame.origin.x, salesIdExecutiveNameLabel.frame.origin.y,140,20);
//        otherDiscPercentageTxt.frame = CGRectMake(otherDiscountLabel.frame.origin.x,salesExecutiveIdText.frame.origin.y,100,40 );
//        otherDiscAmountTxt.frame = CGRectMake(otherDiscPercentageTxt.frame.origin.x + otherDiscPercentageTxt.frame.size.width + 5, otherDiscPercentageTxt.frame.origin.y, 120, otherDiscPercentageTxt.frame.size.height);
//
//        searchItemsText.frame = CGRectMake(orderDateLabel.frame.origin.x, otherDiscPercentageTxt.frame.origin.y + otherDiscPercentageTxt.frame.size.height + 50,backButton.frame.origin.x + backButton.frame.size.width - (orderDateLabel.frame.origin.x),40);
//
//        orderItemsScrollView.frame = CGRectMake( searchItemsText.frame.origin.x, searchItemsText.frame.origin.y + searchItemsText.frame.size.height + 5, searchItemsText.frame.size.width, 350);
//
//
//        //frames for the CustomLabels....
//
//        snoLabel.frame = CGRectMake(0,0,40,40);
//
//        itemIdLabel.frame = CGRectMake(snoLabel.frame.origin.x + snoLabel.frame.size.width + 2, snoLabel.frame.origin.y,100, snoLabel.frame.size.height);
//
//        itemNameLabel.frame = CGRectMake(itemIdLabel.frame.origin.x + itemIdLabel.frame.size.width + 2, snoLabel.frame.origin.y,120, snoLabel.frame.size.height);
//
//        makeLabel.frame = CGRectMake(itemNameLabel.frame.origin.x + itemNameLabel.frame.size.width + 2, snoLabel.frame.origin.y,80, snoLabel.frame.size.height);
//
//        modelLabel.frame = CGRectMake(makeLabel.frame.origin.x + makeLabel.frame.size.width + 2, snoLabel.frame.origin.y,70, snoLabel.frame.size.height);
//
//        colorLabel.frame = CGRectMake(modelLabel.frame.origin.x + modelLabel.frame.size.width + 2, snoLabel.frame.origin.y,80, snoLabel.frame.size.height);
//
//        sizeLabel.frame = CGRectMake(colorLabel.frame.origin.x + colorLabel.frame.size.width + 2, snoLabel.frame.origin.y,70, snoLabel.frame.size.height);
//
//        // added by roja on 10-09-2018...
//        promoIdLbl.frame = CGRectMake(sizeLabel.frame.origin.x + sizeLabel.frame.size.width + 2, snoLabel.frame.origin.y,100, snoLabel.frame.size.height);
//
//        uomLbl.frame = CGRectMake(promoIdLbl.frame.origin.x + promoIdLbl.frame.size.width + 2, snoLabel.frame.origin.y,50, snoLabel.frame.size.height);
//
//        mrpLabel.frame = CGRectMake(uomLbl.frame.origin.x + uomLbl.frame.size.width + 2, snoLabel.frame.origin.y,60, snoLabel.frame.size.height);
//
//        quantityLabel.frame = CGRectMake(mrpLabel.frame.origin.x + mrpLabel.frame.size.width + 2, snoLabel.frame.origin.y, 60, snoLabel.frame.size.height);
//
//        offerLbl.frame = CGRectMake(quantityLabel.frame.origin.x + quantityLabel.frame.size.width + 2, snoLabel.frame.origin.y,70, snoLabel.frame.size.height);
//
//        discountLbl.frame = CGRectMake(offerLbl.frame.origin.x + offerLbl.frame.size.width + 2, snoLabel.frame.origin.y,100, snoLabel.frame.size.height);
//
//        salePriceLabel.frame = CGRectMake(discountLbl.frame.origin.x + discountLbl.frame.size.width + 2, snoLabel.frame.origin.y,90, snoLabel.frame.size.height);
//
//        costLabel.frame = CGRectMake(salePriceLabel.frame.origin.x + salePriceLabel.frame.size.width + 2, snoLabel.frame.origin.y,70, snoLabel.frame.size.height);
//
//        taxRateLabel.frame = CGRectMake(costLabel.frame.origin.x + costLabel.frame.size.width + 2, snoLabel.frame.origin.y,90, snoLabel.frame.size.height);
//
//        taxLabel.frame = CGRectMake(taxRateLabel.frame.origin.x + taxRateLabel.frame.size.width + 2, snoLabel.frame.origin.y,60, snoLabel.frame.size.height);
//
//        actionLabel.frame = CGRectMake(taxLabel.frame.origin.x + taxLabel.frame.size.width + 2, snoLabel.frame.origin.y,60, snoLabel.frame.size.height);
//
//        // changed by roja on 10-09-2018....
//        orderItemsScrollView.contentSize = CGSizeMake( (snoLabel.frame.origin.x + actionLabel.frame.origin.x + actionLabel.frame.size.width), orderItemsScrollView.frame.size.height);
//
//        orderItemsTable.frame = CGRectMake( 0, snoLabel.frame.origin.y + snoLabel.frame.size.height, orderItemsScrollView.contentSize.width, orderItemsScrollView.frame.size.height - (snoLabel.frame.origin.y + snoLabel.frame.size.height));
//
//
//        //Frames For the tax Calculations....
//        subTotalLabel.frame = CGRectMake(submitButton.frame.origin.x - 40,orderItemsScrollView.frame.origin.y + orderItemsScrollView.frame.size.height + 20, 80,30);
//        subTotalText.frame = CGRectMake(subTotalLabel.frame.origin.x + subTotalLabel.frame.size.width + 5 ,subTotalLabel.frame.origin.y, 80, 30);
//
//        totalTaxLbl.frame = CGRectMake(subTotalLabel.frame.origin.x, subTotalLabel.frame.origin.y + subTotalLabel.frame.size.height + 5, 80 , 30);
//        totalTaxTxt.frame = CGRectMake(totalTaxLbl.frame.origin.x + totalTaxLbl.frame.size.width + 5, totalTaxLbl.frame.origin.y, 80 , 30);
//
//
//        shippingCostLabel.frame = CGRectMake(totalTaxTxt.frame.origin.x + totalTaxTxt.frame.size.width + 10, totalTaxLbl.frame.origin.y, 130 , 30);
//        shippingCostText.frame = CGRectMake(shippingCostLabel.frame.origin.x + shippingCostLabel.frame.size.width + 5, shippingCostLabel.frame.origin.y, 80 , 30);
//
//        totalCostLabel.frame = CGRectMake(5, 10, 110, 30);
//        totalCostText.frame = CGRectMake(totalCostLabel.frame.origin.x + totalCostLabel.frame.size.width + 50, totalCostLabel.frame.origin.y, 200,totalCostLabel.frame.size.height );
//
//        amountPaidLabel.frame = CGRectMake(totalCostLabel.frame.origin.x , totalCostLabel.frame.origin.y + totalCostLabel.frame.size.height + 10, totalCostLabel.frame.size.width, totalCostLabel.frame.size.height);
//        amountPaidText.frame = CGRectMake(totalCostText.frame.origin.x ,totalCostText.frame.origin.y + totalCostText.frame.size.height + 10, totalCostText.frame.size.width ,totalCostLabel.frame.size.height );
//
//        amountDueLabel.frame = CGRectMake(totalCostLabel.frame.origin.x ,amountPaidLabel.frame.origin.y + amountPaidLabel.frame.size.height + 10, totalCostLabel.frame.size.width ,totalCostLabel.frame.size.height );
//        amountDueText.frame = CGRectMake(totalCostText.frame.origin.x ,amountPaidText.frame.origin.y + amountPaidText.frame.size.height + 10, totalCostText.frame.size.width ,totalCostLabel.frame.size.height );
//
//        orderTotalsView.frame = CGRectMake(subTotalLabel.frame.origin.x, shippingCostLabel.frame.origin.y + shippingCostLabel.frame.size.height + 10, 390, amountDueLabel.frame.origin.y + amountDueLabel.frame.size.height + 10);
//
//
//        submitButton2.frame = CGRectMake(searchItemsText.frame.origin.x, (orderTotalsView.frame.origin.y + orderTotalsView.frame.size.height - 45),115,40);
//        saveButton2.frame = CGRectMake(submitButton2.frame.origin.x + submitButton2.frame.size.width + 20, submitButton2.frame.origin.y, 115, 40);
//        backButton2.frame = CGRectMake(saveButton2.frame.origin.x + saveButton2.frame.size.width + 20, submitButton2.frame.origin.y, 115, 40);
//
//        //        createOrderScrollView.contentSize = CGSizeMake(550, 1680);
//        createOrderScrollView.contentSize = CGSizeMake(550, orderTotalsView.frame.origin.y + orderTotalsView.frame.size.height + 10);
//
//        // upto here changed by roja on 10-09-2018...
//    }
//
//    [createOrderView addSubview: headerNameLabel];
//    [createOrderView addSubview:createOrderScrollView];
//
//    [createOrderScrollView addSubview:orderDetailsLabel];
//
//    [createOrderScrollView addSubview:submitButton];
//    [createOrderScrollView addSubview:saveButton];
//    [createOrderScrollView addSubview:backButton];
//
//    [createOrderScrollView addSubview:separationLabel];
//
//    [createOrderScrollView addSubview:orderDateLabel];
//    [createOrderScrollView addSubview:orderDateStarLabel];
//    [createOrderScrollView addSubview:orderDateText];
//    [createOrderScrollView addSubview:orderDateButton];
//
//    [createOrderScrollView addSubview:deliveryDateLabel];
//    [createOrderScrollView addSubview:deliveryDateStarLabel];
//    [createOrderScrollView addSubview:deliveryDateText];
//    [createOrderScrollView addSubview:deliveryDateButton];
//
//    [createOrderScrollView addSubview:paymentModeLabel];
//    [createOrderScrollView addSubview:paymentModeStarLabel];
//    [createOrderScrollView addSubview:paymentModeText];
//    [createOrderScrollView addSubview:paymentModeButton];
//
//    [createOrderScrollView addSubview:paymentTypeLabel];
//    [createOrderScrollView addSubview:paymentTypeStarLabel];
//    [createOrderScrollView addSubview:paymentTypeText];
//    [createOrderScrollView addSubview:paymentTypeButton];
//
//    // row2
//
//    [createOrderScrollView addSubview:locationLabel];
//    [createOrderScrollView addSubview:locationStarLabel];
//    [createOrderScrollView addSubview:locationText];
//    [createOrderScrollView addSubview:locationButton];
//
//    [createOrderScrollView addSubview:customerEmailIdLabel];
//    [createOrderScrollView addSubview:customerEmailIdStarLabel];
//    [createOrderScrollView addSubview:customerEmailIdText];
//
//    [createOrderScrollView addSubview:customerMobileNoLabel];
//    [createOrderScrollView addSubview:customerMobileNoStarLabel];
//    [createOrderScrollView addSubview:customerMobileNoText];
//
//    [createOrderScrollView addSubview:paymentRefLabel];
//    [createOrderScrollView addSubview:paymentRefText];
//
//    [createOrderScrollView addSubview:customerAddressLabel];
//
//    [createOrderScrollView addSubview:streetLabel];
//    [createOrderScrollView addSubview:streetStarLabel];
//    [createOrderScrollView addSubview:streetText];
//
//    [createOrderScrollView addSubview:customerLocationLabel];
//    [createOrderScrollView addSubview:customerLocationStarLabel];
//    [createOrderScrollView addSubview:customerLocationText];
//
//    [createOrderScrollView addSubview:cityLabel];
//    [createOrderScrollView addSubview:cityStarLabel];
//    [createOrderScrollView addSubview:customerCityText];
//
//    [createOrderScrollView addSubview:doorNoLabel];
//    [createOrderScrollView addSubview:doorNoStarLabel];
//    [createOrderScrollView addSubview:doorNoText];
//
//    [createOrderScrollView addSubview:contactNoLabel];
//    [createOrderScrollView addSubview:contactNoStarLabel];
//    [createOrderScrollView addSubview:contactNoText];
//
//    [createOrderScrollView addSubview:googleMapLinkLabel];
//    [createOrderScrollView addSubview:googleMapLinkText];
//
//    [createOrderScrollView addSubview:pinLabel];
//    [createOrderScrollView addSubview:pinNoText];
//
//    [createOrderScrollView addSubview:billingAddressLabel];
//
//    [createOrderScrollView addSubview:billingStreetLabel];
//    //    [createOrderScrollView addSubview:billingStreetStarLabel];
//    [createOrderScrollView addSubview:billingStreetText];
//
//    [createOrderScrollView addSubview:billingLocationLabel];
//    //    [createOrderScrollView addSubview:billingLocationStarLabel];
//    [createOrderScrollView addSubview:billingLocationText];
//
//    [createOrderScrollView addSubview:billingCityLabel];
//    //    [createOrderScrollView addSubview:billingCityStarLabel];
//    [createOrderScrollView addSubview:billingCityText];
//
//    [createOrderScrollView addSubview:billingDoorNoLabel];
//    //    [createOrderScrollView addSubview:billingDoorNoStarLabel];
//    [createOrderScrollView addSubview:billingDoorNoText];
//
//    [createOrderScrollView addSubview:billingContactNoLabel];
//    //    [createOrderScrollView addSubview:billingContactNoStarLabel];
//    [createOrderScrollView addSubview:billingContactNoText];
//
//    [createOrderScrollView addSubview:billingGoogleMapLinkLabel];
//    [createOrderScrollView addSubview:billingGoogleMapLinkText];
//
//    [createOrderScrollView addSubview:billingPinCodeLabel];
//    [createOrderScrollView addSubview:billingPinNoText];
//
//    [createOrderScrollView addSubview:shipmentAddressLabel];
//
//    [createOrderScrollView addSubview:shipmentContactNoLabel];
//    [createOrderScrollView addSubview:shipmentContactNoStarLabel];
//    [createOrderScrollView addSubview:shipmentContactNoText];
//
//    [createOrderScrollView addSubview:shipmentDoorNoLabel];
//    [createOrderScrollView addSubview:shipmentDoorNoStarLabel];
//    [createOrderScrollView addSubview:shipmentDoorNoText];
//
//    [createOrderScrollView addSubview:shipmentStreetNoLabel];
//    [createOrderScrollView addSubview:shipmentStreetNoStarLabel];
//    [createOrderScrollView addSubview:shipmentStreetNoText];
//
//    [createOrderScrollView addSubview:shipmentNameLabel];
//    [createOrderScrollView addSubview:shipmentNameStarLabel];
//    [createOrderScrollView addSubview:shipmentNameText];
//
//    [createOrderScrollView addSubview:shipmentLocationLabel];
//    [createOrderScrollView addSubview:shipmentLocationStarLabel];
//    [createOrderScrollView addSubview:shipmentLocationText];
//
//    [createOrderScrollView addSubview:shipmentCityLabel];
//    [createOrderScrollView addSubview:shipmentCityStarLabel];
//    [createOrderScrollView addSubview:shipmentCityText];
//
//    [createOrderScrollView addSubview:shipmentStateLabel];
//    [createOrderScrollView addSubview:shipmentStateStarLabel];
//    [createOrderScrollView addSubview:shipmentStateText];
//
//    [createOrderScrollView addSubview:otherDetailsLabel];
//
//    [createOrderScrollView addSubview:orderChannelLabel];
//    [createOrderScrollView addSubview:orderChannelStarLabel];
//    [createOrderScrollView addSubview:orderChannelText];
//    [createOrderScrollView addSubview:orderChannelButton];
//
//    [createOrderScrollView addSubview:shipmentTypeLabel];
//    [createOrderScrollView addSubview:shipmentTypeText];
//    [createOrderScrollView addSubview:shipmentTypeButton];
//
//    [createOrderScrollView addSubview:salesIdExecutiveNameLabel];
//    [createOrderScrollView addSubview:salesExecutiveIdText];
//    [createOrderScrollView addSubview:salesExecutiveNameText];
//
//    [createOrderScrollView addSubview:deliveryTypeLabel];
//    [createOrderScrollView addSubview:deliveryTypeStarLabel];
//    [createOrderScrollView addSubview:deliveryTypeText];
//    [createOrderScrollView addSubview:deliveryTypeButton];
//
//    [createOrderScrollView addSubview:shipmentModeLabel];
//    [createOrderScrollView addSubview:shipmentModeText];
//    [createOrderScrollView addSubview:shipmentModeButton];
//
//    [createOrderScrollView addSubview:otherDiscountLabel];
//    [createOrderScrollView addSubview:otherDiscPercentageTxt];
//    [createOrderScrollView addSubview:otherDiscAmountTxt];
//
//
//    // End for the Custom TextFields and UILabels....
//
//    [createOrderScrollView addSubview:searchItemsText];
//
//    [createOrderScrollView addSubview:orderItemsScrollView];
//
//    [orderItemsScrollView addSubview:snoLabel];
//    [orderItemsScrollView addSubview:itemIdLabel];
//    [orderItemsScrollView addSubview:itemNameLabel];
//    [orderItemsScrollView addSubview:makeLabel];
//    [orderItemsScrollView addSubview:modelLabel];
//    [orderItemsScrollView addSubview:colorLabel];
//    [orderItemsScrollView addSubview:sizeLabel];
//    [orderItemsScrollView addSubview:mrpLabel];
//    [orderItemsScrollView addSubview:salePriceLabel];
//    [orderItemsScrollView addSubview:quantityLabel];
//    [orderItemsScrollView addSubview:costLabel];
//    [orderItemsScrollView addSubview:taxRateLabel];
//    [orderItemsScrollView addSubview:taxLabel];
//    // added by roja on 10-09-2018...
//    [orderItemsScrollView addSubview:promoIdLbl];
//    [orderItemsScrollView addSubview:discountLbl];
//    [orderItemsScrollView addSubview:uomLbl];
//    [orderItemsScrollView addSubview:offerLbl];
//    // upto here added by roja on 10-09-2018...
//    [orderItemsScrollView addSubview:actionLabel];
//
//    [orderItemsScrollView addSubview:orderItemsTable];
//
//    [createOrderScrollView addSubview:productListTable];
//
//    [createOrderScrollView addSubview:subTotalLabel];
//    [createOrderScrollView addSubview:subTotalText];
//
//    // added by roja on 10-09-2018...
//    [createOrderScrollView addSubview:totalTaxLbl];
//    [createOrderScrollView addSubview:totalTaxTxt];
//    // upto here added by roja on 10-09-2018...
//    [createOrderScrollView addSubview:shippingCostLabel];
//    [createOrderScrollView addSubview:shippingCostText];
//    [createOrderScrollView addSubview:otherDiscountText];
//
//    [createOrderScrollView addSubview:orderTotalsView];
//
//    [orderTotalsView addSubview:totalCostLabel];
//    [orderTotalsView addSubview:amountPaidLabel];
//    [orderTotalsView addSubview:amountDueLabel];
//
//    [orderTotalsView addSubview:totalCostText];
//    [orderTotalsView addSubview:amountPaidText];
//    [orderTotalsView addSubview:amountDueText];
//
//    [createOrderScrollView addSubview:submitButton2];
//    [createOrderScrollView addSubview:saveButton2];
//    [createOrderScrollView addSubview:backButton2];
//
//
//    [self.view addSubview: createOrderView];
//
//    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
//
//    headerNameLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
//
//    orderDetailsLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
//
//    submitButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
//    saveButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
//    backButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
//
//    customerAddressLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
//    billingAddressLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
//    shipmentAddressLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
//
//    otherDetailsLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
//
//    submitButton2.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
//    saveButton2.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
//    backButton2.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
//
//    //used for identification propous....
//    orderDateButton.tag = 2;
//    deliveryDateButton.tag = 4;
//
//    submitButton.tag =  2;
//    submitButton2.tag = 2;
//
//}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         13/02/2016
 * @method       ViewDidLoad
 * @author       Created by Roja as per Latest GUI
 * @param
 * @param
 * @return       void
 * @modified BY
 * @reason
 * @verified By
 * @verified On
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
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);

    //setting the backGroundColor to view...
    self.view.backgroundColor = [UIColor blackColor];

    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;

    //creating the stockRequestView which will displayed completed Screen...
    createOrderView = [[UIView alloc] init];
    createOrderView.backgroundColor = [UIColor blackColor];
    createOrderView.layer.borderWidth = 1.0f;
    createOrderView.layer.cornerRadius = 10.0f;
    createOrderView.layer.borderColor = [UIColor lightGrayColor].CGColor;

    /*Creation of UILabel for headerDisplay.......*/
    //creating  UILabel as a line which will display at topOfThe DayStartView...
    UILabel * headerNameLabel = [[UILabel alloc] init];
    headerNameLabel.layer.cornerRadius = 10.0f;
    headerNameLabel.layer.masksToBounds = YES;
    headerNameLabel.textAlignment = NSTextAlignmentCenter;
    headerNameLabel.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];

    //CALayer for borderwidth and color setting....
    CALayer * bottomBorder = [CALayer layer];
    bottomBorder.opacity = 5.0f;
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLabel.frame.size.width, 1.0f);
    [headerNameLabel.layer addSublayer:bottomBorder];

    //Allocation of createOrderScrollView...

    createOrderScrollView = [[UIScrollView alloc] init];
    createOrderScrollView.hidden = NO;
    createOrderScrollView.backgroundColor = [UIColor blackColor];
    createOrderScrollView.bounces = FALSE;
    createOrderScrollView.scrollEnabled = YES;

    UILabel * orderDetailsLabel;

    orderDetailsLabel = [[UILabel alloc] init];
    orderDetailsLabel.layer.cornerRadius = 5.0f;
    orderDetailsLabel.layer.masksToBounds = YES;
    orderDetailsLabel.numberOfLines = 1;
    orderDetailsLabel.textAlignment = NSTextAlignmentLeft;
    orderDetailsLabel.backgroundColor = [UIColor blackColor];
    orderDetailsLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    UIButton * submitButton;
    UIButton * saveButton;
    UIButton * backButton;

    // Creation of UIButton....
    submitButton = [[UIButton alloc] init];
    submitButton.layer.cornerRadius = 3.0f;
    submitButton.backgroundColor = [UIColor grayColor];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    saveButton = [[UIButton alloc] init];
    saveButton.layer.cornerRadius = 3.0f;
    saveButton.backgroundColor = [UIColor grayColor];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    backButton = [[UIButton alloc] init];
    backButton.layer.cornerRadius = 3.0f;
    backButton.backgroundColor = [UIColor grayColor];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [saveButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];

    UILabel * separationLabel;

    separationLabel = [[UILabel alloc] init];
    separationLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2 ];
    separationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2 ];


    //Allocation & Creation of of UILabels...

    //added by roja on 07/01/2019...
    // reason latest GUI..
    // Row 1......
    UILabel * firstNameLbl;
    UILabel * lastNameLbl;
    UILabel * startTimeLbl;
    UILabel * startTimeLblStarLabel;
    UILabel * endTimeLbl;
    UILabel * endTimeLblStarLabel;
    UILabel * deliveryModelLbl;


    UILabel * orderDateLabel;
    UILabel * orderDateStarLabel;
    UILabel * deliveryDateLabel;
    UILabel * deliveryDateStarLabel;
    UILabel * paymentModeLabel;
    UILabel * paymentTypeLabel;


    firstNameLbl = [[UILabel alloc] init];
    firstNameLbl.layer.cornerRadius = 5.0f;
    firstNameLbl.layer.masksToBounds = YES;
    firstNameLbl.numberOfLines = 1;
    firstNameLbl.textAlignment = NSTextAlignmentLeft;
    firstNameLbl.backgroundColor = [UIColor blackColor];
    firstNameLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    lastNameLbl = [[UILabel alloc] init];
    lastNameLbl.layer.cornerRadius = 5.0f;
    lastNameLbl.layer.masksToBounds = YES;
    lastNameLbl.numberOfLines = 1;
    lastNameLbl.textAlignment = NSTextAlignmentLeft;
    lastNameLbl.backgroundColor = [UIColor blackColor];
    lastNameLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];


    startTimeLbl = [[UILabel alloc] init];
    startTimeLbl.layer.cornerRadius = 5.0f;
    startTimeLbl.layer.masksToBounds = YES;
    startTimeLbl.numberOfLines = 1;
    startTimeLbl.textAlignment = NSTextAlignmentLeft;
    startTimeLbl.backgroundColor = [UIColor blackColor];
    startTimeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    startTimeLblStarLabel = [[UILabel alloc] init];
    startTimeLblStarLabel.textAlignment = NSTextAlignmentLeft;
    startTimeLblStarLabel.backgroundColor = [UIColor blackColor];
    startTimeLblStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    startTimeLblStarLabel.font = [UIFont systemFontOfSize:30];

    endTimeLbl = [[UILabel alloc] init];
    endTimeLbl.layer.cornerRadius = 5.0f;
    endTimeLbl.layer.masksToBounds = YES;
    endTimeLbl.numberOfLines = 1;
    endTimeLbl.textAlignment = NSTextAlignmentLeft;
    endTimeLbl.backgroundColor = [UIColor blackColor];
    endTimeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];


    endTimeLblStarLabel = [[UILabel alloc] init];
    endTimeLblStarLabel.textAlignment = NSTextAlignmentLeft;
    endTimeLblStarLabel.backgroundColor = [UIColor blackColor];
    endTimeLblStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    endTimeLblStarLabel.font = [UIFont systemFontOfSize:30];


    deliveryModelLbl = [[UILabel alloc] init];
    deliveryModelLbl.layer.cornerRadius = 5.0f;
    deliveryModelLbl.layer.masksToBounds = YES;
    deliveryModelLbl.numberOfLines = 1;
    deliveryModelLbl.textAlignment = NSTextAlignmentLeft;
    deliveryModelLbl.backgroundColor = [UIColor blackColor];
    deliveryModelLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    orderDateLabel = [[UILabel alloc] init];
    orderDateLabel.layer.cornerRadius = 5.0f;
    orderDateLabel.layer.masksToBounds = YES;
    orderDateLabel.numberOfLines = 1;
    orderDateLabel.textAlignment = NSTextAlignmentLeft;
    orderDateLabel.backgroundColor = [UIColor blackColor];
    orderDateLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    orderDateStarLabel = [[UILabel alloc] init];
    orderDateStarLabel.textAlignment = NSTextAlignmentLeft;
    orderDateStarLabel.backgroundColor = [UIColor blackColor];
    orderDateStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    orderDateStarLabel.font = [UIFont systemFontOfSize:30];

    deliveryDateLabel = [[UILabel alloc] init];
    deliveryDateLabel.layer.cornerRadius = 5.0f;
    deliveryDateLabel.layer.masksToBounds = YES;
    deliveryDateLabel.numberOfLines = 1;
    deliveryDateLabel.textAlignment = NSTextAlignmentLeft;
    deliveryDateLabel.backgroundColor = [UIColor blackColor];
    deliveryDateLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    deliveryDateStarLabel = [[UILabel alloc] init];
    deliveryDateStarLabel.textAlignment = NSTextAlignmentLeft;
    deliveryDateStarLabel.backgroundColor = [UIColor blackColor];
    deliveryDateStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    deliveryDateStarLabel.font = [UIFont systemFontOfSize:30];

    paymentModeLabel = [[UILabel alloc] init];
    paymentModeLabel.layer.cornerRadius = 5.0f;
    paymentModeLabel.layer.masksToBounds = YES;
    paymentModeLabel.numberOfLines = 1;
    paymentModeLabel.textAlignment = NSTextAlignmentLeft;
    paymentModeLabel.backgroundColor = [UIColor blackColor];
    paymentModeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    paymentTypeLabel = [[UILabel alloc] init];
    paymentTypeLabel.layer.cornerRadius = 5.0f;
    paymentTypeLabel.layer.masksToBounds = YES;
    paymentTypeLabel.numberOfLines = 1;
    paymentTypeLabel.textAlignment = NSTextAlignmentLeft;
    paymentTypeLabel.backgroundColor = [UIColor blackColor];
    paymentTypeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];


    // Row 1.....

    // getting present date & time ..
    NSDate * today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString * currentdate = [f stringFromDate:today];

    // added by roja on 12/02/2019..
    firstNameTF = [[CustomTextField alloc] init];
    firstNameTF.delegate = self;
    firstNameTF.userInteractionEnabled  = YES;
    firstNameTF.text = @"";
    firstNameTF.placeholder = @"First Name";
    firstNameTF.borderStyle = UITextBorderStyleRoundedRect;


    lastNameTF = [[CustomTextField alloc] init];
    lastNameTF.delegate = self;
    lastNameTF.userInteractionEnabled = YES;
    lastNameTF.text = @"";
    lastNameTF.placeholder = @"Last Name";
    lastNameTF.borderStyle = UITextBorderStyleRoundedRect;


    startTimeTF = [[CustomTextField alloc] init];
    startTimeTF.delegate = self;
    startTimeTF.userInteractionEnabled  = NO;
    startTimeTF.text = @"";
    startTimeTF.placeholder = @"Start Time";
    startTimeTF.borderStyle = UITextBorderStyleRoundedRect;
    
    endTimeTF = [[CustomTextField alloc] init];
    endTimeTF.delegate = self;
    endTimeTF.userInteractionEnabled  = NO;
    endTimeTF.text = @"";
    endTimeTF.placeholder = @"End Name";
    endTimeTF.borderStyle = UITextBorderStyleRoundedRect;

    deliveryModelTF = [[CustomTextField alloc] init];
    deliveryModelTF.delegate = self;
    deliveryModelTF.userInteractionEnabled  = NO;
    deliveryModelTF.text = @"Immediate";  // setting default
    deliveryModelTF.placeholder = @"Delivery Model";
    deliveryModelTF.borderStyle = UITextBorderStyleRoundedRect;
    // upto here added by roja on 12/02/2019..

    orderDateText = [[CustomTextField alloc] init];
    orderDateText.delegate = self;
    orderDateText.userInteractionEnabled  = NO;
    orderDateText.text = currentdate;//currentdate
    orderDateText.placeholder = @"Order Date";
    orderDateText.borderStyle = UITextBorderStyleRoundedRect;

    deliveryDateText = [[CustomTextField alloc] init];
    deliveryDateText.delegate = self;
    deliveryDateText.userInteractionEnabled  = NO;
    deliveryDateText.placeholder = @"Delivery Date";
    deliveryDateText.borderStyle = UITextBorderStyleRoundedRect;

    paymentModeText = [[CustomTextField alloc] init];
    paymentModeText.delegate = self;
    paymentModeText.userInteractionEnabled  = NO;
    paymentModeText.placeholder = NSLocalizedString(@"payment_mode",nil);
    paymentModeText.borderStyle = UITextBorderStyleRoundedRect;
    paymentModeText.text = @"Debit Card"; // setting default

    paymentTypeText = [[CustomTextField alloc] init];
    paymentTypeText.delegate = self;
    paymentTypeText.userInteractionEnabled = NO;
    paymentTypeText.placeholder = NSLocalizedString(@"payment_type",nil);
    paymentTypeText.borderStyle = UITextBorderStyleRoundedRect;
    paymentTypeText.text = @"On Delivery";// setting default


    /*Creation of UIImage used for buttons*/
    UIImage * downArrowImage = [UIImage imageNamed:@"down_gray_arrow.png"]; // arrow_1.png
    UIImage * calendarIconImage = [UIImage imageNamed:@"Calandar_Icon.png"];


    UIButton * orderDateButton;
    UIButton * deliveryDateButton;
    UIButton * paymentModeButton;
    UIButton * paymentTypeButton;

    // added by roja on 09/04/2019..
    UIButton * startTimeBtn;
    UIButton * endTimeBtn;


    orderDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderDateButton setBackgroundImage:calendarIconImage forState:UIControlStateNormal];

    deliveryDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliveryDateButton setBackgroundImage:calendarIconImage forState:UIControlStateNormal];

    paymentModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [paymentModeButton setBackgroundImage:[UIImage imageNamed:@"down_gray_arrow"] forState:UIControlStateNormal]; //arrow_down.png

    paymentTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [paymentTypeButton setBackgroundImage:[UIImage imageNamed:@"down_gray_arrow"] forState:UIControlStateNormal]; //downArrowImage

    startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startTimeBtn setBackgroundImage:calendarIconImage forState:UIControlStateNormal];

    endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endTimeBtn setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
    
    [orderDateButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    [deliveryDateButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    [startTimeBtn addTarget:self action:@selector(showTimeInPopUp:) forControlEvents:UIControlEventTouchDown];
    [endTimeBtn addTarget:self action:@selector(showTimeInPopUp:) forControlEvents:UIControlEventTouchDown];

    [paymentModeButton addTarget:self action:@selector(showPaymentMode:) forControlEvents:UIControlEventTouchDown];
    [paymentTypeButton addTarget:self action:@selector(showPaymentType:) forControlEvents:UIControlEventTouchDown];


    //Row2....

    UILabel * locationLabel;
    UILabel * customerEmailIdLabel;
    UILabel * customerMobileNoLabel;
    UILabel * customerMobileNoStarLabel;
    UILabel * paymentRefLabel;
    UILabel * paymentRefStarLabel;


    locationLabel = [[UILabel alloc] init];
    locationLabel.layer.cornerRadius = 5.0f;
    locationLabel.layer.masksToBounds = YES;
    locationLabel.numberOfLines = 1;
    locationLabel.textAlignment = NSTextAlignmentLeft;
    locationLabel.backgroundColor = [UIColor blackColor];
    locationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    customerEmailIdLabel = [[UILabel alloc] init];
    customerEmailIdLabel.layer.cornerRadius = 5.0f;
    customerEmailIdLabel.layer.masksToBounds = YES;
    customerEmailIdLabel.numberOfLines = 1;
    customerEmailIdLabel.textAlignment = NSTextAlignmentLeft;
    customerEmailIdLabel.backgroundColor = [UIColor blackColor];
    customerEmailIdLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    customerMobileNoLabel = [[UILabel alloc] init];
    customerMobileNoLabel.layer.cornerRadius = 5.0f;
    customerMobileNoLabel.layer.masksToBounds = YES;
    customerMobileNoLabel.numberOfLines = 1;
    customerMobileNoLabel.textAlignment = NSTextAlignmentLeft;
    customerMobileNoLabel.backgroundColor = [UIColor blackColor];
    customerMobileNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    customerMobileNoStarLabel = [[UILabel alloc] init];
    customerMobileNoStarLabel.textAlignment = NSTextAlignmentLeft;
    customerMobileNoStarLabel.backgroundColor = [UIColor blackColor];
    customerMobileNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    customerMobileNoStarLabel.font = [UIFont systemFontOfSize:30];

    paymentRefLabel = [[UILabel alloc] init];
    paymentRefLabel.layer.cornerRadius = 5.0f;
    paymentRefLabel.layer.masksToBounds = YES;
    paymentRefLabel.numberOfLines = 1;
    paymentRefLabel.textAlignment = NSTextAlignmentLeft;
    paymentRefLabel.backgroundColor = [UIColor blackColor];
    paymentRefLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    paymentRefStarLabel = [[UILabel alloc] init];
    paymentRefStarLabel.textAlignment = NSTextAlignmentLeft;
    paymentRefStarLabel.backgroundColor = [UIColor blackColor];
    paymentRefStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    paymentRefStarLabel.font = [UIFont systemFontOfSize:30];


    locationText = [[CustomTextField alloc] init];
    locationText.userInteractionEnabled  = NO;
    locationText.text = presentLocation;
    locationText.clearButtonMode = UITextFieldViewModeWhileEditing;
    locationText.delegate = self;
    locationText.placeholder = NSLocalizedString(@"location", nil);
    locationText.borderStyle = UITextBorderStyleRoundedRect;

    customerEmailIdText = [[CustomTextField alloc] init];
    customerEmailIdText.delegate = self;
    customerEmailIdText.userInteractionEnabled  = YES;
    customerEmailIdText.keyboardType = UIKeyboardTypeEmailAddress;
    customerEmailIdText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    customerEmailIdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerEmailIdText.placeholder = NSLocalizedString(@"enter_email_address", nil);
    customerEmailIdText.borderStyle = UITextBorderStyleRoundedRect;
    //    [customerEmailIdText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    customerMobileNoText = [[CustomTextField alloc] init];
    customerMobileNoText.delegate = self;
    customerMobileNoText.userInteractionEnabled  = YES;
    customerMobileNoText.keyboardType = UIKeyboardTypeNumberPad;
    customerMobileNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerMobileNoText.placeholder = NSLocalizedString(@"enter_contact_no", nil);
    customerMobileNoText.borderStyle = UITextBorderStyleRoundedRect;
    [customerMobileNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    paymentRefText = [[CustomTextField alloc] init];
    paymentRefText.delegate = self;
    paymentRefText.userInteractionEnabled  = YES;
    paymentRefText.clearButtonMode = UITextFieldViewModeWhileEditing;
    paymentRefText.placeholder = NSLocalizedString(@"cheque_approval_no", nil);
    paymentRefText.borderStyle = UITextBorderStyleRoundedRect;

    UIButton * locationButton;

    locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setBackgroundImage:[UIImage imageNamed:@"down_gray_arrow"] forState:UIControlStateNormal]; // downArrowImage
    [locationButton addTarget:self action:@selector(showAllLocations:) forControlEvents:UIControlEventTouchDown];


    // added by roja on 13/02/2019.. && 09/04/2019...
    UIButton * deliveryMdlDropDownBtn;

    deliveryMdlDropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliveryMdlDropDownBtn setBackgroundImage:[UIImage imageNamed:@"down_gray_arrow"] forState:UIControlStateNormal];
    [deliveryMdlDropDownBtn addTarget:self action:@selector(showDeliveryModel:) forControlEvents:UIControlEventTouchDown];

    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:[UIImage imageNamed:@"Up_arrow.png"] forState:UIControlStateNormal];
    //     down_arrow.png
    [dropDownBtn addTarget:self action:@selector(customerDetailsViewDropDownBtnAction:) forControlEvents:UIControlEventTouchDown];
    [dropDownBtn setBackgroundColor:[UIColor clearColor]];
    dropDownBtn.tag = 2;


    customerDetailsScrollView = [[UIScrollView alloc]init];
    customerDetailsScrollView.backgroundColor = [UIColor blackColor];
    customerDetailsScrollView.bounces = FALSE;
    customerDetailsScrollView.scrollEnabled = NO;

    customerAddressView = [[UIView alloc]init];
    customerAddressView.backgroundColor = [UIColor darkGrayColor]; //darkGrayColor

    billingAddressView = [[UIView alloc]init];
    billingAddressView.backgroundColor = [UIColor darkGrayColor];

    shipmentAddressView = [[UIView alloc]init];
    shipmentAddressView.backgroundColor = [UIColor darkGrayColor];

    otherDetailsView = [[UIView alloc]init];
    otherDetailsView.backgroundColor = [UIColor darkGrayColor];

    // upto here added by roja on 13/02/2019..


    // Row 3
    UILabel * customerAddressLabel;
    UILabel * streetLabel;
    UILabel * streetStarLabel;
    UILabel * customerLocationLabel;
    UILabel * customerLocationStarLabel;
    UILabel * cityLabel;
    UILabel * cityStarLabel;


    customerAddressLabel = [[UILabel alloc] init];
    customerAddressLabel.layer.cornerRadius = 3.0f;
    customerAddressLabel.layer.masksToBounds = YES;
    customerAddressLabel.numberOfLines = 1;
    customerAddressLabel.textAlignment = NSTextAlignmentLeft;
    customerAddressLabel.backgroundColor = [UIColor clearColor];
    customerAddressLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    streetLabel = [[UILabel alloc] init];
    streetLabel.layer.cornerRadius = 5.0f;
    streetLabel.layer.masksToBounds = YES;
    streetLabel.numberOfLines = 1;
    streetLabel.textAlignment = NSTextAlignmentLeft;
    streetLabel.backgroundColor = [UIColor clearColor];
    streetLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    streetStarLabel = [[UILabel alloc] init];
    streetStarLabel.textAlignment = NSTextAlignmentLeft;
    streetStarLabel.backgroundColor = [UIColor clearColor];
    streetStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    streetStarLabel.font = [UIFont systemFontOfSize:30];

    customerLocationLabel = [[UILabel alloc] init];
    customerLocationLabel.layer.cornerRadius = 5.0f;
    customerLocationLabel.layer.masksToBounds = YES;
    customerLocationLabel.numberOfLines = 1;
    customerLocationLabel.textAlignment = NSTextAlignmentLeft;
    customerLocationLabel.backgroundColor = [UIColor clearColor];
    customerLocationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    customerLocationStarLabel = [[UILabel alloc] init];
    customerLocationStarLabel.textAlignment = NSTextAlignmentLeft;
    customerLocationStarLabel.backgroundColor = [UIColor clearColor];
    customerLocationStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    customerLocationStarLabel.font = [UIFont systemFontOfSize:30];

    cityLabel = [[UILabel alloc] init];
    cityLabel.layer.cornerRadius = 5.0f;
    cityLabel.layer.masksToBounds = YES;
    cityLabel.numberOfLines = 1;
    cityLabel.textAlignment = NSTextAlignmentLeft;
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    cityStarLabel = [[UILabel alloc] init];
    cityStarLabel.textAlignment = NSTextAlignmentLeft;
    cityStarLabel.backgroundColor = [UIColor clearColor];
    cityStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    cityStarLabel.font = [UIFont systemFontOfSize:30];

    streetText = [[CustomTextField alloc] init];
    streetText.delegate = self;
    streetText.userInteractionEnabled  = YES;
    streetText.clearButtonMode = UITextFieldViewModeWhileEditing;
    streetText.placeholder = NSLocalizedString(@"enter_street", nil);
    [streetText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    streetText.backgroundColor = [UIColor whiteColor];
    streetText.textColor = [UIColor blackColor];
    streetText.borderStyle = UITextBorderStyleRoundedRect;

    customerLocationText = [[CustomTextField alloc] init];
    customerLocationText.delegate = self;
    customerLocationText.userInteractionEnabled  = YES;
    customerLocationText.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerLocationText.placeholder = NSLocalizedString(@"enter_landmark", nil);
    [customerLocationText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    customerLocationText.backgroundColor = [UIColor whiteColor];
    customerLocationText.textColor = [UIColor blackColor];
    customerLocationText.borderStyle = UITextBorderStyleRoundedRect;


    customerCityText = [[CustomTextField alloc] init];
    customerCityText.delegate = self;
    customerCityText.userInteractionEnabled  = YES;
    customerCityText.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerCityText.placeholder = NSLocalizedString(@"enter_city", nil);
    [customerCityText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    customerCityText.backgroundColor = [UIColor whiteColor];
    customerCityText.textColor = [UIColor blackColor];
    customerCityText.borderStyle = UITextBorderStyleRoundedRect;



    //Row 4
    UILabel * doorNoLabel;
    UILabel * doorNoStarLabel;
    UILabel * contactNoLabel;
    UILabel * contactNoStarLabel;
    UILabel * googleMapLinkLabel;
    UILabel * pinLabel;

    doorNoLabel = [[UILabel alloc] init];
    doorNoLabel.layer.cornerRadius = 5.0f;
    doorNoLabel.layer.masksToBounds = YES;
    doorNoLabel.numberOfLines = 1;
    doorNoLabel.textAlignment = NSTextAlignmentLeft;
    doorNoLabel.backgroundColor = [UIColor clearColor];
    doorNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    doorNoStarLabel = [[UILabel alloc] init];
    doorNoStarLabel.textAlignment = NSTextAlignmentLeft;
    doorNoStarLabel.backgroundColor = [UIColor clearColor];
    doorNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    doorNoStarLabel.font = [UIFont systemFontOfSize:30];

    contactNoLabel = [[UILabel alloc] init];
    contactNoLabel.layer.cornerRadius = 5.0f;
    contactNoLabel.layer.masksToBounds = YES;
    contactNoLabel.numberOfLines = 1;
    contactNoLabel.textAlignment = NSTextAlignmentLeft;
    contactNoLabel.backgroundColor = [UIColor clearColor];
    contactNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    contactNoStarLabel = [[UILabel alloc] init];
    contactNoStarLabel.textAlignment = NSTextAlignmentLeft;
    contactNoStarLabel.backgroundColor = [UIColor clearColor];
    contactNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    contactNoStarLabel.font = [UIFont systemFontOfSize:30];

    googleMapLinkLabel = [[UILabel alloc] init];
    googleMapLinkLabel.layer.cornerRadius = 5.0f;
    googleMapLinkLabel.layer.masksToBounds = YES;
    googleMapLinkLabel.numberOfLines = 1;
    googleMapLinkLabel.textAlignment = NSTextAlignmentLeft;
    googleMapLinkLabel.backgroundColor = [UIColor clearColor];
    googleMapLinkLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    pinLabel = [[UILabel alloc] init];
    pinLabel.layer.cornerRadius = 5.0f;
    pinLabel.layer.masksToBounds = YES;
    pinLabel.numberOfLines = 1;
    pinLabel.textAlignment = NSTextAlignmentLeft;
    pinLabel.backgroundColor = [UIColor clearColor];
    pinLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];


    doorNoText = [[CustomTextField alloc] init];
    doorNoText.delegate = self;
    doorNoText.userInteractionEnabled  = YES;
    doorNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    doorNoText.placeholder = NSLocalizedString(@"enter_doorNo", nil);
    [doorNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    doorNoText.backgroundColor = [UIColor whiteColor];
    doorNoText.textColor = [UIColor blackColor];
    doorNoText.borderStyle = UITextBorderStyleRoundedRect;

    contactNoText = [[CustomTextField alloc] init];
    contactNoText.delegate = self;
    contactNoText.userInteractionEnabled  = YES;
    contactNoText.placeholder = NSLocalizedString(@"enter_contact_no", nil);
    contactNoText.keyboardType = UIKeyboardTypeNumberPad;
    contactNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [contactNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    contactNoText.backgroundColor = [UIColor whiteColor];
    contactNoText.textColor = [UIColor blackColor];
    contactNoText.borderStyle = UITextBorderStyleRoundedRect;

    googleMapLinkText = [[CustomTextField alloc] init];
    googleMapLinkText.delegate = self;
    googleMapLinkText.userInteractionEnabled  = YES;
    googleMapLinkText.placeholder = NSLocalizedString(@"enter_google_map_link", nil);
    googleMapLinkText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [googleMapLinkText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    googleMapLinkText.backgroundColor = [UIColor whiteColor];
    googleMapLinkText.textColor = [UIColor blackColor];
    googleMapLinkText.borderStyle = UITextBorderStyleRoundedRect;

    pinNoText = [[CustomTextField alloc] init];
    pinNoText.delegate = self;
    pinNoText.userInteractionEnabled  = YES;
    pinNoText.placeholder = NSLocalizedString(@"enter_pin", nil);
    pinNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    pinNoText.keyboardType = UIKeyboardTypePhonePad;
    [pinNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    pinNoText.backgroundColor = [UIColor whiteColor];
    pinNoText.textColor = [UIColor blackColor];
    pinNoText.borderStyle = UITextBorderStyleRoundedRect;

    // Row5....

    UILabel * billingAddressLabel;
    UILabel * billingStreetLabel;
    //    UILabel * billingStreetStarLabel;
    UILabel * billingLocationLabel;
    //    UILabel * billingLocationStarLabel;
    UILabel * billingCityLabel;
    //    UILabel * billingCityStarLabel;


    billingAddressLabel = [[UILabel alloc] init];
    billingAddressLabel.layer.cornerRadius = 3.0f;
    billingAddressLabel.layer.masksToBounds = YES;
    billingAddressLabel.numberOfLines = 1;
    billingAddressLabel.textAlignment = NSTextAlignmentLeft;
    billingAddressLabel.backgroundColor = [UIColor clearColor];
    billingAddressLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    billingStreetLabel = [[UILabel alloc] init];
    billingStreetLabel.layer.cornerRadius = 5.0f;
    billingStreetLabel.layer.masksToBounds = YES;
    billingStreetLabel.numberOfLines = 1;
    billingStreetLabel.textAlignment = NSTextAlignmentLeft;
    billingStreetLabel.backgroundColor = [UIColor clearColor];
    billingStreetLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    //    billingStreetStarLabel = [[UILabel alloc] init];
    //    billingStreetStarLabel.textAlignment = NSTextAlignmentLeft;
    //    billingStreetStarLabel.backgroundColor = [UIColor clearColor];
    //    billingStreetStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    //    billingStreetStarLabel.font = [UIFont systemFontOfSize:30];

    billingLocationLabel = [[UILabel alloc] init];
    billingLocationLabel.layer.cornerRadius = 5.0f;
    billingLocationLabel.layer.masksToBounds = YES;
    billingLocationLabel.numberOfLines = 1;
    billingLocationLabel.textAlignment = NSTextAlignmentLeft;
    billingLocationLabel.backgroundColor = [UIColor clearColor];
    billingLocationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    //    billingLocationStarLabel = [[UILabel alloc] init];
    //    billingLocationStarLabel.textAlignment = NSTextAlignmentLeft;
    //    billingLocationStarLabel.backgroundColor = [UIColor clearColor];
    //    billingLocationStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    //    billingLocationStarLabel.font = [UIFont systemFontOfSize:30];

    billingCityLabel = [[UILabel alloc] init];
    billingCityLabel.layer.cornerRadius = 5.0f;
    billingCityLabel.layer.masksToBounds = YES;
    billingCityLabel.numberOfLines = 1;
    billingCityLabel.textAlignment = NSTextAlignmentLeft;
    billingCityLabel.backgroundColor = [UIColor clearColor];
    billingCityLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    //    billingCityStarLabel = [[UILabel alloc] init];
    //    billingCityStarLabel.textAlignment = NSTextAlignmentLeft;
    //    billingCityStarLabel.backgroundColor = [UIColor clearColor];
    //    billingCityStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    //    billingCityStarLabel.font = [UIFont systemFontOfSize:30];

    //
    billingStreetText = [[CustomTextField alloc] init];
    billingStreetText.delegate = self;
    billingStreetText.userInteractionEnabled  = YES;
    billingStreetText.clearButtonMode = UITextFieldViewModeWhileEditing;
    billingStreetText.placeholder = NSLocalizedString(@"enter_street", nil);
    billingStreetText.backgroundColor = [UIColor whiteColor];
    billingStreetText.textColor = [UIColor blackColor];
    billingStreetText.borderStyle = UITextBorderStyleRoundedRect;

    billingLocationText = [[CustomTextField alloc] init];
    billingLocationText.delegate = self;
    billingLocationText.userInteractionEnabled  = YES;
    billingLocationText.clearButtonMode = UITextFieldViewModeWhileEditing;
    billingLocationText.placeholder = NSLocalizedString(@"enter_landmark", nil);
    billingLocationText.backgroundColor = [UIColor whiteColor];
    billingLocationText.textColor = [UIColor blackColor];
    billingLocationText.borderStyle = UITextBorderStyleRoundedRect;

    billingCityText = [[CustomTextField alloc] init];
    billingCityText.delegate = self;
    billingCityText.userInteractionEnabled  = YES;
    billingCityText.clearButtonMode = UITextFieldViewModeWhileEditing;
    billingCityText.placeholder = NSLocalizedString(@"enter_city", nil);
    billingCityText.backgroundColor = [UIColor whiteColor];
    billingCityText.textColor = [UIColor blackColor];
    billingCityText.borderStyle = UITextBorderStyleRoundedRect;

    // Row6....

    UILabel * billingDoorNoLabel;
    //    UILabel * billingDoorNoStarLabel;
    UILabel * billingContactNoLabel;
    //    UILabel * billingContactNoStarLabel;
    UILabel * billingGoogleMapLinkLabel;
    UILabel * billingPinCodeLabel;

    billingDoorNoLabel = [[UILabel alloc] init];
    billingDoorNoLabel.layer.cornerRadius = 5.0f;
    billingDoorNoLabel.layer.masksToBounds = YES;
    billingDoorNoLabel.numberOfLines = 1;
    billingDoorNoLabel.textAlignment = NSTextAlignmentLeft;
    billingDoorNoLabel.backgroundColor = [UIColor clearColor];
    billingDoorNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    //    billingDoorNoStarLabel = [[UILabel alloc] init];
    //    billingDoorNoStarLabel.textAlignment = NSTextAlignmentLeft;
    //    billingDoorNoStarLabel.backgroundColor = [UIColor clearColor];
    //    billingDoorNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    //    billingDoorNoStarLabel.font = [UIFont systemFontOfSize:30];
    //
    billingContactNoLabel = [[UILabel alloc] init];
    billingContactNoLabel.layer.cornerRadius = 5.0f;
    billingContactNoLabel.layer.masksToBounds = YES;
    billingContactNoLabel.numberOfLines = 1;
    billingContactNoLabel.textAlignment = NSTextAlignmentLeft;
    billingContactNoLabel.backgroundColor = [UIColor clearColor];
    billingContactNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    //    billingContactNoStarLabel = [[UILabel alloc] init];
    //    billingContactNoStarLabel.textAlignment = NSTextAlignmentLeft;
    //    billingContactNoStarLabel.backgroundColor = [UIColor clearColor];
    //    billingContactNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    //    billingContactNoStarLabel.font = [UIFont systemFontOfSize:30];

    billingGoogleMapLinkLabel = [[UILabel alloc] init];
    billingGoogleMapLinkLabel.layer.cornerRadius = 5.0f;
    billingGoogleMapLinkLabel.layer.masksToBounds = YES;
    billingGoogleMapLinkLabel.numberOfLines = 1;
    billingGoogleMapLinkLabel.textAlignment = NSTextAlignmentLeft;
    billingGoogleMapLinkLabel.backgroundColor = [UIColor clearColor];
    billingGoogleMapLinkLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    billingPinCodeLabel = [[UILabel alloc] init];
    billingPinCodeLabel.layer.cornerRadius = 5.0f;
    billingPinCodeLabel.layer.masksToBounds = YES;
    billingPinCodeLabel.numberOfLines = 1;
    billingPinCodeLabel.textAlignment = NSTextAlignmentLeft;
    billingPinCodeLabel.backgroundColor = [UIColor clearColor];
    billingPinCodeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];


    billingDoorNoText = [[CustomTextField alloc] init];
    billingDoorNoText.delegate = self;
    billingDoorNoText.userInteractionEnabled  = YES;
    billingDoorNoText.placeholder = NSLocalizedString(@"enter_doorNo", nil);
    billingDoorNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    billingDoorNoText.backgroundColor = [UIColor whiteColor];
    billingDoorNoText.textColor = [UIColor blackColor];
    billingDoorNoText.borderStyle = UITextBorderStyleRoundedRect;

    billingContactNoText = [[CustomTextField alloc] init];
    billingContactNoText.delegate = self;
    billingContactNoText.userInteractionEnabled  = YES;
    billingContactNoText.keyboardType = UIKeyboardTypeNumberPad;
    billingContactNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    billingContactNoText.placeholder = NSLocalizedString(@"enter_contact_no", nil);
    [billingContactNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    billingContactNoText.backgroundColor = [UIColor whiteColor];
    billingContactNoText.textColor = [UIColor blackColor];
    billingContactNoText.borderStyle = UITextBorderStyleRoundedRect;


    billingGoogleMapLinkText = [[CustomTextField alloc] init];
    billingGoogleMapLinkText.delegate = self;
    billingGoogleMapLinkText.userInteractionEnabled  = YES;
    billingGoogleMapLinkText.placeholder = NSLocalizedString(@"enter_google_map_link", nil);
    billingGoogleMapLinkText.clearButtonMode = UITextFieldViewModeWhileEditing;
    billingGoogleMapLinkText.backgroundColor = [UIColor whiteColor];
    billingGoogleMapLinkText.textColor = [UIColor blackColor];
    billingGoogleMapLinkText.borderStyle = UITextBorderStyleRoundedRect;

    billingPinNoText = [[CustomTextField alloc] init];
    billingPinNoText.delegate = self;
    billingPinNoText.userInteractionEnabled  = YES;
    billingPinNoText.placeholder = NSLocalizedString(@"enter_pin", nil);
    billingPinNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    billingPinNoText.keyboardType = UIKeyboardTypePhonePad;
    billingPinNoText.backgroundColor = [UIColor whiteColor];
    billingPinNoText.textColor = [UIColor blackColor];
    billingPinNoText.borderStyle = UITextBorderStyleRoundedRect;

    //row7.....
    UILabel * shipmentAddressLabel;
    UILabel * shipmentContactNoLabel;
    UILabel * shipmentContactNoStarLabel;
    UILabel * shipmentDoorNoLabel;
    UILabel * shipmentDoorNoStarLabel;
    UILabel * shipmentStreetNoLabel;
    UILabel * shipmentStreetNoStarLabel;


    shipmentAddressLabel = [[UILabel alloc] init];
    shipmentAddressLabel.layer.cornerRadius = 3.0f;
    shipmentAddressLabel.layer.masksToBounds = YES;
    shipmentAddressLabel.numberOfLines = 1;
    shipmentAddressLabel.textAlignment = NSTextAlignmentLeft;
    shipmentAddressLabel.backgroundColor = [UIColor clearColor];
    shipmentAddressLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    shipmentContactNoLabel = [[UILabel alloc] init];
    shipmentContactNoLabel.layer.cornerRadius = 5.0f;
    shipmentContactNoLabel.layer.masksToBounds = YES;
    shipmentContactNoLabel.numberOfLines = 1;
    shipmentContactNoLabel.textAlignment = NSTextAlignmentLeft;
    shipmentContactNoLabel.backgroundColor = [UIColor clearColor];
    shipmentContactNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    shipmentContactNoStarLabel = [[UILabel alloc] init];
    shipmentContactNoStarLabel.textAlignment = NSTextAlignmentLeft;
    shipmentContactNoStarLabel.backgroundColor = [UIColor clearColor];
    shipmentContactNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    shipmentContactNoStarLabel.font = [UIFont systemFontOfSize:30];

    shipmentDoorNoLabel = [[UILabel alloc] init];
    shipmentDoorNoLabel.layer.cornerRadius = 5.0f;
    shipmentDoorNoLabel.layer.masksToBounds = YES;
    shipmentDoorNoLabel.numberOfLines = 1;
    shipmentDoorNoLabel.textAlignment = NSTextAlignmentLeft;
    shipmentDoorNoLabel.backgroundColor = [UIColor clearColor];
    shipmentDoorNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    shipmentDoorNoStarLabel = [[UILabel alloc] init];
    shipmentDoorNoStarLabel.textAlignment = NSTextAlignmentLeft;
    shipmentDoorNoStarLabel.backgroundColor = [UIColor clearColor];
    shipmentDoorNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    shipmentDoorNoStarLabel.font = [UIFont systemFontOfSize:30];

    shipmentStreetNoLabel = [[UILabel alloc] init];
    shipmentStreetNoLabel.layer.cornerRadius = 5.0f;
    shipmentStreetNoLabel.layer.masksToBounds = YES;
    shipmentStreetNoLabel.numberOfLines = 1;
    shipmentStreetNoLabel.textAlignment = NSTextAlignmentLeft;
    shipmentStreetNoLabel.backgroundColor = [UIColor clearColor];
    shipmentStreetNoLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    shipmentStreetNoStarLabel = [[UILabel alloc] init];
    shipmentStreetNoStarLabel.textAlignment = NSTextAlignmentLeft;
    shipmentStreetNoStarLabel.backgroundColor = [UIColor clearColor];
    shipmentStreetNoStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    shipmentStreetNoStarLabel.font = [UIFont systemFontOfSize:30];


    shipmentContactNoText = [[CustomTextField alloc] init];
    shipmentContactNoText.delegate = self;
    shipmentContactNoText.userInteractionEnabled  = YES;
    shipmentContactNoText.placeholder = NSLocalizedString(@"enter_contact_no", nil);
    shipmentContactNoText.keyboardType = UIKeyboardTypeNumberPad;
    shipmentContactNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [shipmentContactNoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    shipmentContactNoText.backgroundColor = [UIColor whiteColor];
    shipmentContactNoText.textColor = [UIColor blackColor];
    shipmentContactNoText.borderStyle = UITextBorderStyleRoundedRect;


    shipmentDoorNoText = [[CustomTextField alloc] init];
    shipmentDoorNoText.delegate = self;
    shipmentDoorNoText.userInteractionEnabled  = YES;
    shipmentDoorNoText.placeholder = NSLocalizedString(@"enter_doorNo", nil);
    shipmentDoorNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentDoorNoText.backgroundColor = [UIColor whiteColor];
    shipmentDoorNoText.textColor = [UIColor blackColor];
    shipmentDoorNoText.borderStyle = UITextBorderStyleRoundedRect;

    shipmentStreetNoText = [[CustomTextField alloc] init];
    shipmentStreetNoText.delegate = self;
    shipmentStreetNoText.userInteractionEnabled  = YES;
    shipmentStreetNoText.placeholder = NSLocalizedString(@"enter_street", nil);
    shipmentStreetNoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentStreetNoText.backgroundColor = [UIColor whiteColor];
    shipmentStreetNoText.textColor = [UIColor blackColor];
    shipmentStreetNoText.borderStyle = UITextBorderStyleRoundedRect;

    //row8

    UILabel * shipmentNameLabel;
    UILabel * shipmentNameStarLabel;
    UILabel * shipmentLocationLabel;
    UILabel * shipmentLocationStarLabel;
    UILabel * shipmentCityLabel;
    UILabel * shipmentCityStarLabel;
    UILabel * shipmentStateLabel;
    UILabel * shipmentStateStarLabel;
    UILabel * shipmentPinLabel;

    shipmentNameLabel = [[UILabel alloc] init];
    shipmentNameLabel.layer.cornerRadius = 5.0f;
    shipmentNameLabel.layer.masksToBounds = YES;
    shipmentNameLabel.numberOfLines = 1;
    shipmentNameLabel.textAlignment = NSTextAlignmentLeft;
    shipmentNameLabel.backgroundColor = [UIColor clearColor];
    shipmentNameLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    shipmentNameStarLabel = [[UILabel alloc] init];
    shipmentNameStarLabel.textAlignment = NSTextAlignmentLeft;
    shipmentNameStarLabel.backgroundColor = [UIColor clearColor];
    shipmentNameStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    shipmentNameStarLabel.font = [UIFont systemFontOfSize:30];

    shipmentLocationLabel = [[UILabel alloc] init];
    shipmentLocationLabel.layer.cornerRadius = 5.0f;
    shipmentLocationLabel.layer.masksToBounds = YES;
    shipmentLocationLabel.numberOfLines = 1;
    shipmentLocationLabel.textAlignment = NSTextAlignmentLeft;
    shipmentLocationLabel.backgroundColor = [UIColor clearColor];
    shipmentLocationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    shipmentLocationStarLabel = [[UILabel alloc] init];
    shipmentLocationStarLabel.textAlignment = NSTextAlignmentLeft;
    shipmentLocationStarLabel.backgroundColor = [UIColor clearColor];
    shipmentLocationStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    shipmentLocationStarLabel.font = [UIFont systemFontOfSize:30];

    shipmentCityLabel = [[UILabel alloc] init];
    shipmentCityLabel.layer.cornerRadius = 5.0f;
    shipmentCityLabel.layer.masksToBounds = YES;
    shipmentCityLabel.numberOfLines = 1;
    shipmentCityLabel.textAlignment = NSTextAlignmentLeft;
    shipmentCityLabel.backgroundColor = [UIColor clearColor];
    shipmentCityLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    shipmentCityStarLabel = [[UILabel alloc] init];
    shipmentCityStarLabel.textAlignment = NSTextAlignmentLeft;
    shipmentCityStarLabel.backgroundColor = [UIColor clearColor];
    shipmentCityStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    shipmentCityStarLabel.font = [UIFont systemFontOfSize:30];

    shipmentStateLabel = [[UILabel alloc] init];
    shipmentStateLabel.layer.cornerRadius = 5.0f;
    shipmentStateLabel.layer.masksToBounds = YES;
    shipmentStateLabel.numberOfLines = 1;
    shipmentStateLabel.textAlignment = NSTextAlignmentLeft;
    shipmentStateLabel.backgroundColor = [UIColor clearColor];
    shipmentStateLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    shipmentStateStarLabel = [[UILabel alloc] init];
    shipmentStateStarLabel.textAlignment = NSTextAlignmentLeft;
    shipmentStateStarLabel.backgroundColor = [UIColor clearColor];
    shipmentStateStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    shipmentStateStarLabel.font = [UIFont systemFontOfSize:30];


    shipmentPinLabel = [[UILabel alloc] init];
    shipmentPinLabel.textAlignment = NSTextAlignmentLeft;
    shipmentPinLabel.backgroundColor = [UIColor clearColor];
    shipmentPinLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];


    shipmentNameText = [[CustomTextField alloc] init];
    shipmentNameText.delegate = self;
    shipmentNameText.userInteractionEnabled  = YES;
    shipmentNameText.placeholder = NSLocalizedString(@"enter_name", nil);
    shipmentNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentNameText.backgroundColor = [UIColor whiteColor];
    shipmentNameText.textColor = [UIColor blackColor];
    shipmentNameText.borderStyle = UITextBorderStyleRoundedRect;

    shipmentLocationText = [[CustomTextField alloc] init];
    shipmentLocationText.delegate = self;
    shipmentLocationText.userInteractionEnabled  = YES;
    shipmentLocationText.placeholder = NSLocalizedString(@"enter_landmark", nil);
    shipmentLocationText.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentLocationText.backgroundColor = [UIColor whiteColor];
    shipmentLocationText.textColor = [UIColor blackColor];
    shipmentLocationText.borderStyle = UITextBorderStyleRoundedRect;

    shipmentCityText = [[CustomTextField alloc] init];
    shipmentCityText.delegate = self;
    shipmentCityText.userInteractionEnabled  = YES;
    shipmentCityText.placeholder = NSLocalizedString(@"enter_city", nil);
    shipmentCityText.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentCityText.backgroundColor = [UIColor whiteColor];
    shipmentCityText.textColor = [UIColor blackColor];
    shipmentCityText.borderStyle = UITextBorderStyleRoundedRect;

    shipmentStateText = [[CustomTextField alloc] init];
    shipmentStateText.delegate = self;
    shipmentStateText.userInteractionEnabled  = YES;
    shipmentStateText.placeholder = NSLocalizedString(@"enter_state", nil);
    shipmentStateText.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentStateText.backgroundColor = [UIColor whiteColor];
    shipmentStateText.textColor = [UIColor blackColor];
    shipmentStateText.borderStyle = UITextBorderStyleRoundedRect;

    // added by roja on 13/02/2019.. as per latest GUI
    shipmentPinText = [[CustomTextField alloc] init];
    shipmentPinText.delegate = self;
    shipmentPinText.userInteractionEnabled  = YES;
    shipmentPinText.placeholder = NSLocalizedString(@"enter_pin", nil);
    shipmentPinText.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentPinText.backgroundColor = [UIColor whiteColor];
    shipmentPinText.textColor = [UIColor blackColor];
    shipmentPinText.borderStyle = UITextBorderStyleRoundedRect;

    //row9

    UILabel * otherDetailsLabel;
    UILabel * orderChannelLabel;
    UILabel * orderChannelStarLabel;
    UILabel * shipmentTypeLabel;
    UILabel * salesIdExecutiveNameLabel;

    UILabel * refferredByLabel;

    otherDetailsLabel = [[UILabel alloc] init];
    otherDetailsLabel.layer.cornerRadius = 3.0f;
    otherDetailsLabel.layer.masksToBounds = YES;
    otherDetailsLabel.numberOfLines = 1;
    otherDetailsLabel.textAlignment = NSTextAlignmentLeft;
    otherDetailsLabel.backgroundColor = [UIColor clearColor];
    otherDetailsLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    orderChannelLabel = [[UILabel alloc] init];
    orderChannelLabel.layer.cornerRadius = 5.0f;
    orderChannelLabel.layer.masksToBounds = YES;
    orderChannelLabel.numberOfLines = 1;
    orderChannelLabel.textAlignment = NSTextAlignmentLeft;
    orderChannelLabel.backgroundColor = [UIColor clearColor];
    orderChannelLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    orderChannelStarLabel = [[UILabel alloc] init];
    orderChannelStarLabel.textAlignment = NSTextAlignmentLeft;
    orderChannelStarLabel.backgroundColor = [UIColor clearColor];
    orderChannelStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    orderChannelStarLabel.font = [UIFont systemFontOfSize:30];

    shipmentTypeLabel = [[UILabel alloc] init];
    shipmentTypeLabel.layer.cornerRadius = 5.0f;
    shipmentTypeLabel.layer.masksToBounds = YES;
    shipmentTypeLabel.numberOfLines = 1;
    shipmentTypeLabel.textAlignment = NSTextAlignmentLeft;
    shipmentTypeLabel.backgroundColor = [UIColor clearColor];
    shipmentTypeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    salesIdExecutiveNameLabel = [[UILabel alloc] init];
    salesIdExecutiveNameLabel.layer.cornerRadius = 5.0f;
    salesIdExecutiveNameLabel.layer.masksToBounds = YES;
    salesIdExecutiveNameLabel.numberOfLines = 1;
    salesIdExecutiveNameLabel.textAlignment = NSTextAlignmentLeft;
    salesIdExecutiveNameLabel.backgroundColor = [UIColor clearColor];
    salesIdExecutiveNameLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    refferredByLabel = [[UILabel alloc] init];
    refferredByLabel.layer.cornerRadius = 5.0f;
    refferredByLabel.layer.masksToBounds = YES;
    refferredByLabel.numberOfLines = 1;
    refferredByLabel.textAlignment = NSTextAlignmentLeft;
    refferredByLabel.backgroundColor = [UIColor clearColor];
    refferredByLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];


    orderChannelText = [[CustomTextField alloc] init];
    orderChannelText.delegate = self;
    orderChannelText.userInteractionEnabled  = NO;
    //    orderChannelText.text = NSLocalizedString(@"online",nil);
    orderChannelText.placeholder = NSLocalizedString(@"order_channel", nil);
    orderChannelText.backgroundColor = [UIColor whiteColor];
    orderChannelText.textColor = [UIColor blackColor];
    orderChannelText.borderStyle = UITextBorderStyleRoundedRect;

    shipmentTypeText = [[CustomTextField alloc] init];
    shipmentTypeText.delegate = self;
    shipmentTypeText.userInteractionEnabled  = NO;
    //    shipmentTypeText.text = NSLocalizedString(@"normal",nil);
    shipmentTypeText.placeholder = NSLocalizedString(@"shipment_type", nil);
    shipmentTypeText.backgroundColor = [UIColor whiteColor];
    shipmentTypeText.textColor = [UIColor blackColor];
    shipmentTypeText.borderStyle = UITextBorderStyleRoundedRect;

    UIButton * orderChannelButton;
    UIButton * shipmentTypeButton;

    orderChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderChannelButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    [orderChannelButton addTarget:self action:@selector(showOrderChannel:) forControlEvents:UIControlEventTouchDown];


    shipmentTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shipmentTypeButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    [shipmentTypeButton addTarget:self action:@selector(showShipmentType:) forControlEvents:UIControlEventTouchDown];

    salesExecutiveIdText = [[CustomTextField alloc] init];
    salesExecutiveIdText.delegate = self;
    salesExecutiveIdText.userInteractionEnabled  = NO;
    //    salesExecutiveIdText.placeholder = NSLocalizedString(@"id", nil);
    salesExecutiveIdText.text = cashierId;
    salesExecutiveIdText.backgroundColor = [UIColor whiteColor];
    salesExecutiveIdText.textColor = [UIColor blackColor];
    salesExecutiveIdText.borderStyle = UITextBorderStyleRoundedRect;
    salesExecutiveIdText.font = [UIFont boldSystemFontOfSize:11];
    [salesExecutiveIdText setAdjustsFontSizeToFitWidth:YES];


    salesExecutiveNameText = [[CustomTextField alloc] init];
    salesExecutiveNameText.delegate = self;
    salesExecutiveNameText.userInteractionEnabled  = NO;
    //    salesExecutiveNameText.placeholder = NSLocalizedString(@"enter_sales_executive_name", nil);
    salesExecutiveNameText.text =  firstName;
    salesExecutiveNameText.backgroundColor = [UIColor whiteColor];
    salesExecutiveNameText.textColor = [UIColor blackColor];
    salesExecutiveNameText.borderStyle = UITextBorderStyleRoundedRect;


    refferedByText = [[CustomTextField alloc] init];
    refferedByText.delegate = self;
    refferedByText.userInteractionEnabled  = YES;
    refferedByText.placeholder = NSLocalizedString(@" ", nil);
    refferedByText.backgroundColor = [UIColor whiteColor];
    refferedByText.textColor = [UIColor blackColor];
    refferedByText.borderStyle = UITextBorderStyleRoundedRect;


    //row10
    UILabel * deliveryTypeLabel;
    UILabel * deliveryTypeStarLabel;
    UILabel * shipmentModeLabel;
    UILabel * otherDiscountLabel;

    deliveryTypeLabel = [[UILabel alloc] init];
    deliveryTypeLabel.layer.cornerRadius = 5.0f;
    deliveryTypeLabel.layer.masksToBounds = YES;
    deliveryTypeLabel.numberOfLines = 1;
    deliveryTypeLabel.textAlignment = NSTextAlignmentLeft;
    deliveryTypeLabel.backgroundColor = [UIColor clearColor];
    deliveryTypeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    deliveryTypeStarLabel = [[UILabel alloc] init];
    deliveryTypeStarLabel.textAlignment = NSTextAlignmentLeft;
    deliveryTypeStarLabel.backgroundColor = [UIColor clearColor];
    deliveryTypeStarLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.7];
    deliveryTypeStarLabel.font = [UIFont systemFontOfSize:30];

    shipmentModeLabel = [[UILabel alloc] init];
    shipmentModeLabel.layer.cornerRadius = 5.0f;
    shipmentModeLabel.layer.masksToBounds = YES;
    shipmentModeLabel.numberOfLines = 1;
    shipmentModeLabel.textAlignment = NSTextAlignmentLeft;
    shipmentModeLabel.backgroundColor = [UIColor clearColor];
    shipmentModeLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    otherDiscountLabel = [[UILabel alloc] init];
    otherDiscountLabel.layer.cornerRadius = 5.0f;
    otherDiscountLabel.layer.masksToBounds = YES;
    otherDiscountLabel.numberOfLines = 1;
    otherDiscountLabel.textAlignment = NSTextAlignmentLeft;
    otherDiscountLabel.backgroundColor = [UIColor clearColor];
    otherDiscountLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];

    deliveryTypeText = [[CustomTextField alloc] init];
    deliveryTypeText.delegate = self;
    deliveryTypeText.userInteractionEnabled  = NO;
    //    deliveryTypeText.text = NSLocalizedString(@"door_delivery_bills",nil);
    deliveryTypeText.placeholder = NSLocalizedString(@"delivery_type", nil);
    deliveryTypeText.backgroundColor = [UIColor whiteColor];
    deliveryTypeText.textColor = [UIColor blackColor];
    deliveryTypeText.borderStyle = UITextBorderStyleRoundedRect;

    shipmentModeText = [[CustomTextField alloc] init];
    shipmentModeText.delegate = self;
    shipmentModeText.userInteractionEnabled  = NO;
    //    shipmentModeText.text = NSLocalizedString(@"road",nil);
    shipmentModeText.placeholder = NSLocalizedString(@"shipment_mode", nil);
    shipmentModeText.backgroundColor = [UIColor whiteColor];
    shipmentModeText.textColor = [UIColor blackColor];
    shipmentModeText.borderStyle = UITextBorderStyleRoundedRect;

    UIButton * deliveryTypeButton;
    UIButton * shipmentModeButton;

    deliveryTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliveryTypeButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    [deliveryTypeButton addTarget:self action:@selector(showDeliveryType:) forControlEvents:UIControlEventTouchDown];

    shipmentModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shipmentModeButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    [shipmentModeButton addTarget:self action:@selector(showShipmentMode:) forControlEvents:UIControlEventTouchDown];

    otherDiscPercentageTxt = [[CustomTextField alloc] init];
    otherDiscPercentageTxt.userInteractionEnabled  = YES;
    otherDiscPercentageTxt.placeholder = NSLocalizedString(@"enter_discount", nil);
    otherDiscPercentageTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    otherDiscPercentageTxt.keyboardType = UIKeyboardTypeNumberPad;
    otherDiscPercentageTxt.delegate = self;
    otherDiscPercentageTxt.backgroundColor = [UIColor whiteColor];
    otherDiscPercentageTxt.textColor = [UIColor blackColor];
    [otherDiscPercentageTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    otherDiscPercentageTxt.borderStyle = UITextBorderStyleRoundedRect;

    otherDiscAmountTxt = [[CustomTextField alloc] init];
    otherDiscAmountTxt.userInteractionEnabled  = YES;
    otherDiscAmountTxt.text= @"0.0";
    otherDiscAmountTxt.placeholder = NSLocalizedString(@"discount_amount", nil);
    otherDiscAmountTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    otherDiscAmountTxt.keyboardType = UIKeyboardTypeNumberPad;
    otherDiscAmountTxt.delegate = self;
    otherDiscAmountTxt.backgroundColor = [UIColor whiteColor];
    otherDiscAmountTxt.textColor = [UIColor blackColor];
    [otherDiscAmountTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    otherDiscAmountTxt.borderStyle = UITextBorderStyleRoundedRect;


    //End of Custom TextFields....

    //Creation of Search Text to Search deals...
    searchItemsText = [[CustomTextField alloc]init];
    searchItemsText.borderStyle = UITextBorderStyleRoundedRect;
    searchItemsText.placeholder = NSLocalizedString(@"search_items_here", nil);
    searchItemsText.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItemsText.backgroundColor = [UIColor lightGrayColor];
    searchItemsText.keyboardType = UIKeyboardTypeDefault;
    searchItemsText.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItemsText.userInteractionEnabled = YES;
    searchItemsText.delegate = self;
    [searchItemsText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];



    //Creation of scroll view
    orderItemsScrollView = [[UIScrollView alloc] init];
    //orderItemsScrollView.backgroundColor = [UIColor lightGrayColor];

    /*Creation of UILabels used in this page*/
    snoLabel = [[CustomLabel alloc] init];
    [snoLabel awakeFromNib];

    itemIdLabel = [[CustomLabel alloc] init];
    [itemIdLabel awakeFromNib];

    itemNameLabel = [[CustomLabel alloc] init];
    [itemNameLabel awakeFromNib];

    makeLabel = [[CustomLabel alloc] init];
    [makeLabel awakeFromNib];

    modelLabel = [[CustomLabel alloc] init];
    [modelLabel awakeFromNib];

    colorLabel = [[CustomLabel alloc] init];
    [colorLabel awakeFromNib];

    sizeLabel = [[CustomLabel alloc] init];
    [sizeLabel awakeFromNib];

    mrpLabel = [[CustomLabel alloc] init];
    [mrpLabel awakeFromNib];

    salePriceLabel = [[CustomLabel alloc] init];
    [salePriceLabel awakeFromNib];

    quantityLabel = [[CustomLabel alloc] init];
    [quantityLabel awakeFromNib];

    costLabel = [[CustomLabel alloc] init];
    [costLabel awakeFromNib];

    taxRateLabel = [[CustomLabel alloc] init];
    [taxRateLabel awakeFromNib];

    taxLabel = [[CustomLabel alloc] init];
    [taxLabel awakeFromNib];

    // added by roja on 10-09-2019...
    promoIdLbl = [[CustomLabel alloc]init];
    [promoIdLbl awakeFromNib];

    discountLbl = [[CustomLabel alloc]init];
    [discountLbl awakeFromNib];

    uomLbl = [[CustomLabel alloc]init];
    [uomLbl awakeFromNib];

    offerLbl = [[CustomLabel alloc]init];
    [offerLbl awakeFromNib];

    // upto here added by roja on 10-09-2018..

    actionLabel = [[CustomLabel alloc] init];
    [actionLabel awakeFromNib];

    //orderItemsTable creation...
    orderItemsTable = [[UITableView alloc] init];
    orderItemsTable.backgroundColor  = [UIColor blackColor];
    orderItemsTable.layer.cornerRadius = 4.0;
    orderItemsTable.bounces = TRUE;
    orderItemsTable.dataSource = self;
    orderItemsTable.delegate = self;
    orderItemsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //upto Here....

    // table for drop down list to show the skuid's ..
    productListTable = [[UITableView alloc] init];
    productListTable.backgroundColor = [UIColor blackColor];
    productListTable.dataSource = self;
    productListTable.delegate = self;
    productListTable.layer.cornerRadius = 3;


    // Label Allocation for the taxes and other Tax Calculations.....
    // added by roja on 10-09-2018...

    subTotalLabel = [[UILabel alloc] init];
    subTotalLabel.textAlignment = NSTextAlignmentLeft;
    subTotalLabel.backgroundColor = [UIColor blackColor];
    subTotalLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    subTotalLabel.textAlignment = NSTextAlignmentCenter;
    subTotalLabel.font = [UIFont boldSystemFontOfSize:18];

    totalTaxLbl = [[UILabel alloc] init];
    totalTaxLbl.textAlignment = NSTextAlignmentCenter;
    totalTaxLbl.backgroundColor = [UIColor clearColor];
    totalTaxLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    totalTaxLbl.font = [UIFont boldSystemFontOfSize:18];

    shippingCostLabel = [[UILabel alloc] init];
    shippingCostLabel.textAlignment = NSTextAlignmentLeft;
    shippingCostLabel.backgroundColor = [UIColor clearColor];
    shippingCostLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    shippingCostLabel.font = [UIFont boldSystemFontOfSize:18];

    otherDiscountsLbl = [[UILabel alloc] init];
    otherDiscountsLbl.textAlignment = NSTextAlignmentCenter;
    otherDiscountsLbl.backgroundColor = [UIColor clearColor];
    otherDiscountsLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    otherDiscountsLbl.font = [UIFont boldSystemFontOfSize:18];

    netValueLabel = [[UILabel alloc] init];
    netValueLabel.textAlignment = NSTextAlignmentCenter;
    netValueLabel.backgroundColor = [UIColor clearColor];
    netValueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    netValueLabel.font = [UIFont boldSystemFontOfSize:18];

    totalCostLabel = [[UILabel alloc] init];
    totalCostLabel.textAlignment = NSTextAlignmentCenter;
    totalCostLabel.backgroundColor = [UIColor clearColor];
    totalCostLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    totalCostLabel.font = [UIFont boldSystemFontOfSize:18];

    amountPaidLabel = [[UILabel alloc] init];
    amountPaidLabel.textAlignment = NSTextAlignmentCenter;
    amountPaidLabel.backgroundColor = [UIColor clearColor];
    amountPaidLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    amountPaidLabel.font = [UIFont boldSystemFontOfSize:18];

    amountDueLabel = [[UILabel alloc] init];
    amountDueLabel.textAlignment = NSTextAlignmentCenter;
    amountDueLabel.backgroundColor = [UIColor clearColor];
    amountDueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    amountDueLabel.font = [UIFont boldSystemFontOfSize:18];

    backGroudLbl1 = [[UILabel alloc] init];
    backGroudLbl1.backgroundColor = [UIColor darkGrayColor];

    backGroudLbl2 = [[UILabel alloc] init];
    backGroudLbl2.backgroundColor = [UIColor darkGrayColor];

    backGroudLbl3 = [[UILabel alloc] init];
    backGroudLbl3.backgroundColor = [UIColor darkGrayColor];

    backGroudLbl4 = [[UILabel alloc] init];
    backGroudLbl4.backgroundColor = [UIColor darkGrayColor];

    // added by roja on 10-09-2018..

    subTotalText = [[CustomTextField alloc] init];
    subTotalText.delegate = self;
    subTotalText.userInteractionEnabled  = NO;
    subTotalText.borderStyle = UITextBorderStyleNone;
    subTotalText.backgroundColor = [UIColor darkGrayColor];
    subTotalText.textAlignment  = NSTextAlignmentCenter;
    subTotalText.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    subTotalText.font = [UIFont boldSystemFontOfSize:18];

    totalTaxTxt = [[CustomTextField alloc] init];
    totalTaxTxt.delegate = self;
    totalTaxTxt.userInteractionEnabled  = NO;
    totalTaxTxt.borderStyle = UITextBorderStyleNone;
    totalTaxTxt.backgroundColor = [UIColor darkGrayColor];
    totalTaxTxt.textAlignment  = NSTextAlignmentCenter;
    totalTaxTxt.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    totalTaxTxt.font = [UIFont boldSystemFontOfSize:18];

    shippingCostText = [[CustomTextField alloc] init];
    shippingCostText.delegate = self;
    shippingCostText.userInteractionEnabled  = YES;
    shippingCostText.clearButtonMode = UITextFieldViewModeWhileEditing;
    shippingCostText.borderStyle = UITextBorderStyleRoundedRect; // UITextBorderStyleNone
    shippingCostText.backgroundColor = [UIColor clearColor]; //darkGrayColor
    shippingCostText.keyboardType = UIKeyboardTypeNumberPad;
    shippingCostText.autocorrectionType = UITextAutocorrectionTypeNo;
    shippingCostText.returnKeyType = UIReturnKeyDone;
    shippingCostText.layer.borderWidth = 2;
    shippingCostText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    shippingCostText.textAlignment  = NSTextAlignmentCenter;
    shippingCostText.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    shippingCostText.font = [UIFont boldSystemFontOfSize:18];
    [shippingCostText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    otherDiscountText = [[CustomTextField alloc] init];
    otherDiscountText.delegate = self;
    otherDiscountText.userInteractionEnabled  = NO;
    [otherDiscountText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    otherDiscountText.borderStyle = UITextBorderStyleNone;
    otherDiscountText.backgroundColor = [UIColor darkGrayColor];
    otherDiscountText.textAlignment  = NSTextAlignmentCenter;
    otherDiscountText.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    otherDiscountText.font = [UIFont boldSystemFontOfSize:18];

    netValueTF = [[CustomTextField alloc] init];
    netValueTF.delegate = self;
    netValueTF.userInteractionEnabled  = NO;
    netValueTF.borderStyle = UITextBorderStyleNone;
    netValueTF.backgroundColor = [UIColor darkGrayColor];
    netValueTF.textAlignment  = NSTextAlignmentCenter;
    netValueTF.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    netValueTF.font = [UIFont boldSystemFontOfSize:18];

    totalCostText = [[UITextField alloc] init];
    totalCostText.keyboardType = UIKeyboardTypeNumberPad;
    totalCostText.layer.borderWidth = 1;
    totalCostText.autocorrectionType = UITextAutocorrectionTypeNo;
    totalCostText.clearButtonMode = UITextFieldViewModeWhileEditing;
    totalCostText.returnKeyType = UIReturnKeyDone;
    totalCostText.userInteractionEnabled  = NO;
    totalCostText.delegate = self;
    totalCostText.borderStyle = UITextBorderStyleNone;
    totalCostText.backgroundColor = [UIColor darkGrayColor];
    totalCostText.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    totalCostText.textAlignment  = NSTextAlignmentCenter;
    totalCostText.font = [UIFont boldSystemFontOfSize:18];

    amountDueText = [[UITextField alloc] init];
    amountDueText.keyboardType = UIKeyboardTypeNumberPad;
    amountDueText.layer.borderWidth = 1;
    amountDueText.autocorrectionType = UITextAutocorrectionTypeNo;
    amountDueText.clearButtonMode = UITextFieldViewModeWhileEditing;
    amountDueText.returnKeyType = UIReturnKeyDone;
    amountDueText.userInteractionEnabled  = NO;
    amountDueText.delegate = self;
    amountDueText.borderStyle = UITextBorderStyleNone;
    amountDueText.backgroundColor = [UIColor darkGrayColor];
    amountDueText.textColor  = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    amountDueText.textAlignment  = NSTextAlignmentCenter;
    amountDueText.font = [UIFont boldSystemFontOfSize:18];

    amountPaidText = [[UITextField alloc] init];
    amountPaidText.keyboardType = UIKeyboardTypeNumberPad;
    amountPaidText.autocorrectionType = UITextAutocorrectionTypeNo;
    amountPaidText.clearButtonMode = UITextFieldViewModeWhileEditing;
    amountPaidText.returnKeyType = UIReturnKeyDone;
    amountPaidText.delegate = self;
    [amountPaidText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    amountPaidText.borderStyle = UITextBorderStyleRoundedRect;  //UITextBorderStyleNone
    amountPaidText.backgroundColor = [UIColor clearColor]; //darkGrayColor
    amountPaidText.userInteractionEnabled  = YES;
    amountPaidText.keyboardType = UIKeyboardTypeNumberPad;
    amountPaidText.layer.borderWidth = 2;
    amountPaidText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    amountPaidText.textAlignment  = NSTextAlignmentCenter;
    amountPaidText.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    amountPaidText.font = [UIFont boldSystemFontOfSize:18];

    totalCostText.text  = @"0.00";
    amountDueText.text  = @"0.00";
    amountPaidText.text = @"0.00";
    shippingCostText.text = @"0.00";
    totalTaxTxt.text = @"0.00";
    subTotalText.text = @"0.00";
    otherDiscountText.text = @"0.00";
    netValueTF.text = @"0.00";

//    UIButton * submitButton2;
//    UIButton * saveButton2;
//    UIButton * backButton2;

    // Creation of UIButton....
    submitButton2 = [[UIButton alloc] init];
    submitButton2.layer.cornerRadius = 3.0f;
    submitButton2.backgroundColor = [UIColor grayColor];
    [submitButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    saveButton2 = [[UIButton alloc] init];
    saveButton2.layer.cornerRadius = 3.0f;
    saveButton2.backgroundColor = [UIColor grayColor];
    [saveButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    backButton2 = [[UIButton alloc] init];
    backButton2.layer.cornerRadius = 3.0f;
    backButton2.backgroundColor = [UIColor grayColor];
    [backButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [submitButton2 addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [saveButton2 addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [backButton2 addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];

    if(isManualDiscounts){

        // otherDiscountText.userInteractionEnabled  = YES;
    }


#pragma mark UITableView..

    //UITableView Creation for the popup's
    paymentModeTable  = [[UITableView alloc] init];
    paymentTypeTable  = [[UITableView alloc] init];
    virtualStoreTable = [[UITableView alloc] init];
    orderChannelTable = [[UITableView alloc] init];
    shipmentTypeTable = [[UITableView alloc] init];
    deliveryTypeTable = [[UITableView alloc] init];
    shipmentModeTable = [[UITableView alloc] init];
    deliveryModelTable = [[UITableView alloc]init];

    //setting the titleName for the Page....
    self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);

    headerNameLabel.text = NSLocalizedString(@"new_order", nil);

    orderDetailsLabel.text = NSLocalizedString(@"order_details",nil);

    [submitButton setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
    [saveButton setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
    [backButton setTitle:NSLocalizedString(@"back_",nil) forState:UIControlStateNormal];


    firstNameLbl.text = NSLocalizedString(@"first_name", nil);
    lastNameLbl.text = NSLocalizedString(@"last_name", nil);
    startTimeLbl.text = NSLocalizedString(@"Start Time", nil);//time_slot
    startTimeLblStarLabel.text = NSLocalizedString(@"*", nil);
    endTimeLbl.text = NSLocalizedString(@"End Time", nil);
    endTimeLblStarLabel.text = NSLocalizedString(@"*", nil);
    deliveryModelLbl.text = NSLocalizedString(@"Delivery Model", nil);


    orderDateLabel.text = NSLocalizedString(@"order_date", nil);
    orderDateStarLabel.text = NSLocalizedString(@"*", nil);
    deliveryDateLabel.text = NSLocalizedString(@"delivery_Date", nil);
    deliveryDateStarLabel.text = NSLocalizedString(@"*", nil);
    paymentModeLabel.text = NSLocalizedString(@"payment_mode", nil);
    paymentTypeLabel.text = NSLocalizedString(@"payment_type", nil);
    locationLabel.text = NSLocalizedString(@"location",nil);
    customerEmailIdLabel.text = NSLocalizedString(@"customer_email_id",nil);
    customerMobileNoLabel.text = NSLocalizedString(@"Mobile No.",nil); //customer_mobile_no
    customerMobileNoStarLabel.text = NSLocalizedString(@"*",nil);
    paymentRefLabel.text = NSLocalizedString(@"payment_ref",nil);

    customerAddressLabel.text = NSLocalizedString(@"customer_address",nil);
    streetLabel.text = NSLocalizedString(@"street",nil);
    streetStarLabel.text = NSLocalizedString(@"*", nil);
    customerLocationLabel.text = NSLocalizedString(@"location",nil);
    customerLocationStarLabel.text = NSLocalizedString(@"*", nil);
    cityLabel.text = NSLocalizedString(@"city",nil);
    cityStarLabel.text = NSLocalizedString(@"*", nil);

    doorNoLabel.text = NSLocalizedString(@"door_no",nil);
    doorNoStarLabel.text = NSLocalizedString(@"*", nil);
    contactNoLabel.text = NSLocalizedString(@"contact_no",nil);
    contactNoStarLabel.text = NSLocalizedString(@"*", nil);
    googleMapLinkLabel.text = NSLocalizedString(@"google_map_link",nil);
    pinLabel.text = NSLocalizedString(@"pin_code",nil);

    billingAddressLabel.text = NSLocalizedString(@"billing_adderess",nil);
    billingStreetLabel.text = NSLocalizedString(@"street",nil);
    //    billingStreetStarLabel.text = NSLocalizedString(@"*", nil);
    billingLocationLabel.text = NSLocalizedString(@"location",nil);
    //    billingLocationStarLabel.text = NSLocalizedString(@"*", nil);
    billingCityLabel.text = NSLocalizedString(@"city",nil);
    //    billingCityStarLabel.text = NSLocalizedString(@"*", nil);

    billingDoorNoLabel.text = NSLocalizedString(@"door_no",nil);
    //    billingDoorNoStarLabel.text = NSLocalizedString(@"*", nil);
    billingContactNoLabel.text = NSLocalizedString(@"contact_no",nil);
    //    billingContactNoStarLabel.text = NSLocalizedString(@"*", nil);
    billingGoogleMapLinkLabel.text = NSLocalizedString(@"google_map_link",nil);
    billingPinCodeLabel.text = NSLocalizedString(@"pin_code",nil);

    shipmentAddressLabel.text = NSLocalizedString(@"shipment_address",nil);

    shipmentContactNoLabel.text = NSLocalizedString(@"contact_no",nil);
    shipmentContactNoStarLabel.text = NSLocalizedString(@"*", nil);
    shipmentDoorNoLabel.text = NSLocalizedString(@"door_no",nil);
    shipmentDoorNoStarLabel.text = NSLocalizedString(@"*", nil);
    shipmentStreetNoLabel.text = NSLocalizedString(@"street",nil);
    shipmentStreetNoStarLabel.text = NSLocalizedString(@"*", nil);


    shipmentNameLabel.text = NSLocalizedString(@"name",nil);
    shipmentNameStarLabel.text = NSLocalizedString(@"*", nil);
    shipmentLocationLabel.text = NSLocalizedString(@"location",nil);
    shipmentLocationStarLabel.text = NSLocalizedString(@"*", nil);
    shipmentCityLabel.text = NSLocalizedString(@"city",nil);
    shipmentCityStarLabel.text = NSLocalizedString(@"*", nil);
    shipmentStateLabel.text = NSLocalizedString(@"state",nil);
    shipmentStateStarLabel.text = NSLocalizedString(@"*", nil);

    otherDetailsLabel.text = NSLocalizedString(@"other_details",nil);

    orderChannelLabel.text = NSLocalizedString(@"Oder_channel",nil);
    orderChannelStarLabel.text = NSLocalizedString(@"*", nil);
    shipmentTypeLabel.text = NSLocalizedString(@"shipment_type",nil);
    salesIdExecutiveNameLabel.text = NSLocalizedString(@"sales_executive_name",nil);
    refferredByLabel.text = NSLocalizedString(@"referred_by",nil);

    deliveryTypeLabel.text = NSLocalizedString(@"delivery_type",nil);
    deliveryTypeStarLabel.text = NSLocalizedString(@"*", nil);
    shipmentModeLabel.text = NSLocalizedString(@"shipment_mode",nil);
    otherDiscountLabel.text = NSLocalizedString(@"other_Disc_(%)",nil);

    //NSLocalized Strings for the CustomLabels...

    snoLabel.text = NSLocalizedString(@"s_no",nil);
    itemIdLabel.text = NSLocalizedString(@"item_id",nil);
    itemNameLabel.text = NSLocalizedString(@"item_name",nil);
    makeLabel.text = NSLocalizedString(@"make",nil);
    modelLabel.text = NSLocalizedString(@"model",nil);
    colorLabel.text = NSLocalizedString(@"color",nil);
    sizeLabel.text = NSLocalizedString(@"size",nil);
    mrpLabel.text = NSLocalizedString(@"mrp",nil);
    salePriceLabel.text = NSLocalizedString(@"sale_price",nil);
    quantityLabel.text = NSLocalizedString(@"qty",nil);
    costLabel.text = NSLocalizedString(@"cost",nil);
    taxRateLabel.text = NSLocalizedString(@"tax_rate",nil);
    taxLabel.text = NSLocalizedString(@"tax",nil);

    // added by roja on 10-09-2018...
    promoIdLbl.text = NSLocalizedString(@"promo_id", nil);
    uomLbl.text = NSLocalizedString(@"uom", nil);
//    offerLbl.text = NSLocalizedString(@"offer", nil);
//    discountLbl.text = NSLocalizedString(@"discount", "");
    offerLbl.text = NSLocalizedString(@"Offer Disc", nil);
    discountLbl.text = NSLocalizedString(@"Manual Disc", "");

    actionLabel.text = NSLocalizedString(@"action",nil);


    //NSLocalized Strings for the Tax Calculation Labels...
    subTotalLabel.text = NSLocalizedString(@"sub_total",nil);
    // added by roja on 10-09-2018...
    totalTaxLbl.text     = NSLocalizedString(@"Taxes",nil);//total_tax
    shippingCostLabel.text   = NSLocalizedString(@"Ship Charges",nil);//shipping_cost
    totalCostLabel.text  = NSLocalizedString(@"total_cost",nil);
    otherDiscountsLbl.text  = NSLocalizedString(@"Other Discount",nil);
    netValueLabel.text  = NSLocalizedString(@"Net Value",nil);
    amountPaidLabel.text  = NSLocalizedString(@"Paid Amount",nil);//amount_paid
    amountDueLabel.text  = NSLocalizedString(@"Amount Due",nil);


    [submitButton2 setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
    [saveButton2 setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
    [backButton2 setTitle:NSLocalizedString(@"back_",nil) forState:UIControlStateNormal];

    // added by roja on 08/02/2019...
    //Row1....

    firstNameTF.backgroundColor = [UIColor whiteColor];
    customerMobileNoText.backgroundColor = [UIColor whiteColor];
    orderDateText.backgroundColor = [UIColor whiteColor];
    startTimeTF.backgroundColor = [UIColor whiteColor];
    endTimeTF.backgroundColor = [UIColor whiteColor];
    paymentTypeText.backgroundColor = [UIColor whiteColor];

    lastNameTF.backgroundColor = [UIColor whiteColor];
    customerEmailIdText.backgroundColor = [UIColor whiteColor];
    deliveryDateText.backgroundColor = [UIColor whiteColor];
    locationText.backgroundColor = [UIColor whiteColor];
    deliveryModelTF.backgroundColor = [UIColor whiteColor];
    paymentModeText.backgroundColor = [UIColor whiteColor];


    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {

        }
        else {

        }

        //setting frame for the createOrderView....
        createOrderView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);

        //seting frame for headerNameLbl....
        headerNameLabel.frame = CGRectMake( 0, 0, createOrderView.frame.size.width, 45);

        //frame for the CreateOrderScrollView....
        createOrderScrollView.frame = CGRectMake(headerNameLabel.frame.origin.x, headerNameLabel.frame.origin.y + headerNameLabel.frame.size.height,createOrderView.frame.size.width,createOrderView.frame.size.height - 45);

        orderDetailsLabel.frame = CGRectMake(10,10,200,40);

        submitButton.frame = CGRectMake(((createOrderScrollView.frame.size.width)/2) + 155, 10, 110, 40);

        saveButton.frame = CGRectMake(submitButton.frame.origin.x + submitButton.frame.size.width + 10, submitButton.frame.origin.y, 110, 40);

        backButton.frame = CGRectMake(saveButton.frame.origin.x + saveButton.frame.size.width + 10, submitButton.frame.origin.y, 110, 40);

        separationLabel.frame = CGRectMake(headerNameLabel.frame.origin.x,submitButton.frame.origin.y + submitButton.frame.size.height + 5,headerNameLabel.frame.size.width,0.5);



        float labelHeight  = 20;
        float horizontaGap = 154;

        float labelToLabelWidth = 10;//15
        float dropDownButtonWidth = 50;

        // some extra features added by roja as per latest GUI on 13/02/2019... && 09/04/2019.
        //((self.view.frame.size.width-dropDownButtonWidth) - (labelToLabelWidth*5))/5
        firstNameLbl.frame = CGRectMake(orderDetailsLabel.frame.origin.x, separationLabel.frame.origin.y + separationLabel.frame.size.height + 10, 120, labelHeight);
        firstNameTF.frame = CGRectMake(firstNameLbl.frame.origin.x, firstNameLbl.frame.origin.y + firstNameLbl.frame.size.height, ((self.view.frame.size.width-dropDownButtonWidth) - (labelToLabelWidth*5))/6, 40);

        customerMobileNoLabel.frame = CGRectMake(firstNameTF.frame.origin.x + firstNameTF.frame.size.width + labelToLabelWidth, firstNameLbl.frame.origin.y, firstNameTF.frame.size.width, labelHeight);
        customerMobileNoStarLabel.frame = CGRectMake(customerMobileNoLabel.frame.origin.x + customerMobileNoLabel.frame.size.width/2 + 10, customerMobileNoLabel.frame.origin.y, 10, labelHeight);
        customerMobileNoText.frame = CGRectMake(customerMobileNoLabel.frame.origin.x, firstNameTF.frame.origin.y,firstNameTF.frame.size.width, firstNameTF.frame.size.height);

        orderDateLabel.frame = CGRectMake(customerMobileNoText.frame.origin.x + customerMobileNoText.frame.size.width + labelToLabelWidth, firstNameLbl.frame.origin.y, 120, labelHeight);
        orderDateStarLabel.frame = CGRectMake(((orderDateLabel.frame.origin.x + orderDateLabel.frame.size.width/2) + 30), orderDateLabel.frame.origin.y, 10, labelHeight);
        orderDateText.frame = CGRectMake(orderDateLabel.frame.origin.x, firstNameTF.frame.origin.y,firstNameTF.frame.size.width, firstNameTF.frame.size.height);
        orderDateButton.frame = CGRectMake ((orderDateText.frame.origin.x + orderDateText.frame.size.width - 45), orderDateText.frame.origin.y + 2, 40, 35);

        startTimeLbl.frame  = CGRectMake(orderDateText.frame.origin.x + orderDateText.frame.size.width + labelToLabelWidth, firstNameLbl.frame.origin.y, 120, labelHeight);
        startTimeTF.frame = CGRectMake(startTimeLbl.frame.origin.x, firstNameTF.frame.origin.y,firstNameTF.frame.size.width, firstNameTF.frame.size.height);
        startTimeBtn.frame = CGRectMake ((startTimeTF.frame.origin.x + startTimeTF.frame.size.width - 45), startTimeTF.frame.origin.y + 2, 40, 35);
        startTimeLblStarLabel.frame = CGRectMake(startTimeLbl.frame.origin.x + (startTimeLbl.frame.size.width/2) + 20, customerMobileNoLabel.frame.origin.y, 10, labelHeight);

        endTimeLbl.frame  = CGRectMake(startTimeTF.frame.origin.x + startTimeTF.frame.size.width + labelToLabelWidth, firstNameLbl.frame.origin.y, 120, labelHeight);
        endTimeTF.frame  = CGRectMake(endTimeLbl.frame.origin.x, firstNameTF.frame.origin.y,firstNameTF.frame.size.width, firstNameTF.frame.size.height);
        endTimeBtn.frame = CGRectMake ((endTimeTF.frame.origin.x + endTimeTF.frame.size.width - 45), endTimeTF.frame.origin.y + 2, 40, 35);
        endTimeLblStarLabel.frame = CGRectMake(endTimeLbl.frame.origin.x + (endTimeLbl.frame.size.width/2) + 15, customerMobileNoLabel.frame.origin.y, 10, labelHeight);


        paymentTypeLabel.frame  = CGRectMake(endTimeTF.frame.origin.x + endTimeTF.frame.size.width + labelToLabelWidth, firstNameLbl.frame.origin.y, 120, labelHeight);
        paymentTypeText.frame   = CGRectMake(paymentTypeLabel.frame.origin.x, firstNameTF.frame.origin.y,firstNameTF.frame.size.width, firstNameTF.frame.size.height);
        paymentTypeButton.frame = CGRectMake ((paymentTypeText.frame.origin.x + paymentTypeText.frame.size.width - 35), paymentTypeText.frame.origin.y + 10, 23, (paymentTypeText.frame.size.height-20));


        // Row 2..

        lastNameLbl.frame = CGRectMake(firstNameLbl.frame.origin.x, firstNameTF.frame.origin.y + firstNameTF.frame.size.height + 15, 120, labelHeight);
        lastNameTF.frame  = CGRectMake(lastNameLbl.frame.origin.x, lastNameLbl.frame.origin.y + lastNameLbl.frame.size.height, firstNameTF.frame.size.width, firstNameTF.frame.size.height);

        customerEmailIdLabel.frame = CGRectMake(customerMobileNoLabel.frame.origin.x, lastNameLbl.frame.origin.y, firstNameTF.frame.size.width, labelHeight);
        customerEmailIdText.frame = CGRectMake(customerEmailIdLabel.frame.origin.x, lastNameTF.frame.origin.y, firstNameTF.frame.size.width, firstNameTF.frame.size.height);

        deliveryDateLabel.frame = CGRectMake(orderDateLabel.frame.origin.x, lastNameLbl.frame.origin.y, 120, labelHeight);
        deliveryDateStarLabel.frame  = CGRectMake((deliveryDateLabel.frame.origin.x + deliveryDateLabel.frame.size.width)-15, deliveryDateLabel.frame.origin.y, 10, labelHeight);
        deliveryDateText.frame = CGRectMake(deliveryDateLabel.frame.origin.x, lastNameTF.frame.origin.y, firstNameTF.frame.size.width, firstNameTF.frame.size.height);
        deliveryDateButton.frame = CGRectMake ((deliveryDateText.frame.origin.x + deliveryDateText.frame.size.width - 45), deliveryDateText.frame.origin.y + 2, 40, 35);

        locationLabel.frame = CGRectMake(startTimeLbl.frame.origin.x, lastNameLbl.frame.origin.y, 120, labelHeight);
        locationText.frame = CGRectMake(locationLabel.frame.origin.x, lastNameTF.frame.origin.y, firstNameTF.frame.size.width, firstNameTF.frame.size.height);
        locationButton.frame = CGRectMake ((locationText.frame.origin.x + locationText.frame.size.width - 35), locationText.frame.origin.y + 10, 23, (locationText.frame.size.height-20));//60

        deliveryModelLbl.frame = CGRectMake(endTimeLbl.frame.origin.x, lastNameLbl.frame.origin.y, 120, labelHeight);
        deliveryModelTF.frame = CGRectMake(deliveryModelLbl.frame.origin.x, lastNameTF.frame.origin.y, firstNameTF.frame.size.width, firstNameTF.frame.size.height);
        deliveryMdlDropDownBtn.frame = CGRectMake ((deliveryModelTF.frame.origin.x + deliveryModelTF.frame.size.width - 35), deliveryModelTF.frame.origin.y + 10, 23, (deliveryModelTF.frame.size.height-20));//60

        paymentModeLabel.frame = CGRectMake(paymentTypeLabel.frame.origin.x, lastNameLbl.frame.origin.y , 120, labelHeight);
        paymentModeText.frame = CGRectMake(paymentModeLabel.frame.origin.x, lastNameTF.frame.origin.y, firstNameTF.frame.size.width - 30, firstNameTF.frame.size.height);
        paymentModeButton.frame = CGRectMake ((paymentModeText.frame.origin.x + paymentModeText.frame.size.width - 35), paymentModeText.frame.origin.y + 10, 23, (paymentModeText.frame.size.height-20));//60


        dropDownBtn.frame = CGRectMake ((self.view.frame.size.width - 50), (paymentModeText.frame.origin.y +5), dropDownButtonWidth-10, 40);


        float labelToLabelWidth2 = 30;

        float viewsWidth = (dropDownBtn.frame.origin.x - 10);

        // <...............Start of Customer_Address_View.............>
        //  Row 1 Customer Address view.....
        customerAddressLabel.frame = CGRectMake(5, 30, (viewsWidth - (labelToLabelWidth2 * 4))/4, 40);//150

        streetLabel.frame = CGRectMake((customerAddressLabel.frame.origin.x + customerAddressLabel.frame.size.width + labelToLabelWidth2), 10, customerAddressLabel.frame.size.width, labelHeight);
        streetText.frame = CGRectMake(streetLabel.frame.origin.x, streetLabel.frame.origin.y + streetLabel.frame.size.height, customerAddressLabel.frame.size.width, 40);
        streetStarLabel.frame = CGRectMake((streetLabel.frame.origin.x + streetLabel.frame.size.width/4), streetLabel.frame.origin.y, 10, labelHeight);

        customerLocationLabel.frame = CGRectMake((streetLabel.frame.origin.x + streetLabel.frame.size.width + labelToLabelWidth2), streetLabel.frame.origin.y, customerAddressLabel.frame.size.width, labelHeight);
        customerLocationText.frame = CGRectMake(customerLocationLabel.frame.origin.x, (customerLocationLabel.frame.origin.y + customerLocationLabel.frame.size.height), streetText.frame.size.width, streetText.frame.size.height);
        customerLocationStarLabel.frame = CGRectMake((customerLocationLabel.frame.origin.x + customerLocationLabel.frame.size.width/4) + 22, customerLocationLabel.frame.origin.y, 10, labelHeight);

        cityLabel.frame = CGRectMake((customerLocationLabel.frame.origin.x + customerLocationLabel.frame.size.width + labelToLabelWidth2), customerLocationLabel.frame.origin.y, customerAddressLabel.frame.size.width, labelHeight);
        customerCityText.frame = CGRectMake(cityLabel.frame.origin.x, cityLabel.frame.origin.y + cityLabel.frame.size.height, streetText.frame.size.width, streetText.frame.size.height);
        cityStarLabel.frame = CGRectMake((cityLabel.frame.origin.x + cityLabel.frame.size.width/4) - 15, cityLabel.frame.origin.y, 10, labelHeight);

        //  Row 2 Customer Address view.....
        doorNoLabel.frame = CGRectMake(customerAddressLabel.frame.origin.x, (customerAddressLabel.frame.origin.y + customerAddressLabel.frame.size.height + 15), customerAddressLabel.frame.size.width, labelHeight);
        doorNoText.frame = CGRectMake(doorNoLabel.frame.origin.x, doorNoLabel.frame.origin.y + doorNoLabel.frame.size.height, streetText.frame.size.width, streetText.frame.size.height);
        doorNoStarLabel.frame = CGRectMake((doorNoLabel.frame.origin.x + doorNoLabel.frame.size.width/4) + 15, doorNoLabel.frame.origin.y, 10, labelHeight);

        contactNoLabel.frame = CGRectMake(streetLabel.frame.origin.x, doorNoLabel.frame.origin.y, customerAddressLabel.frame.size.width, labelHeight);
        contactNoText.frame = CGRectMake(contactNoLabel.frame.origin.x, doorNoText.frame.origin.y, streetText.frame.size.width, streetText.frame.size.height);
        contactNoStarLabel.frame = CGRectMake((contactNoLabel.frame.origin.x + contactNoLabel.frame.size.width/2)- 15, contactNoLabel.frame.origin.y, 10, labelHeight);


        googleMapLinkLabel.frame = CGRectMake(customerLocationLabel.frame.origin.x,doorNoLabel.frame.origin.y,customerAddressLabel.frame.size.width,labelHeight);
        googleMapLinkText.frame = CGRectMake(googleMapLinkLabel.frame.origin.x,doorNoText.frame.origin.y ,streetText.frame.size.width, streetText.frame.size.height);

        pinLabel.frame = CGRectMake(cityLabel.frame.origin.x,doorNoLabel.frame.origin.y,customerAddressLabel.frame.size.width,labelHeight);
        pinNoText.frame  = CGRectMake(pinLabel.frame.origin.x,doorNoText.frame.origin.y ,streetText.frame.size.width, streetText.frame.size.height);


        customerAddressView.frame = CGRectMake (0, 0, viewsWidth, doorNoText.frame.origin.y + doorNoText.frame.size.height + 10);
        // <...............End of Customer_Address_View...............>


        // <...............Start of Customer_Address_View...............>
        //  Row 1 Billing Address view.....
        billingAddressLabel.frame = CGRectMake(5, 30, (viewsWidth - (labelToLabelWidth2 * 4))/4, 40);

        billingStreetLabel.frame = CGRectMake((billingAddressLabel.frame.origin.x + billingAddressLabel.frame.size.width + labelToLabelWidth2), 10, billingAddressLabel.frame.size.width, labelHeight);
        //        billingStreetStarLabel.frame = CGRectMake(streetStarLabel.frame.origin.x, billingStreetLabel.frame.origin.y, 10, labelHeight);
        billingStreetText.frame  = CGRectMake(billingStreetLabel.frame.origin.x, billingStreetLabel.frame.origin.y + billingStreetLabel.frame.size.height, billingAddressLabel.frame.size.width, 40);

        billingLocationLabel.frame = CGRectMake((billingStreetLabel.frame.origin.x + billingStreetLabel.frame.size.width + labelToLabelWidth2), billingStreetLabel.frame.origin.y, billingAddressLabel.frame.size.width, labelHeight);
        //        billingLocationStarLabel.frame = CGRectMake(customerLocationStarLabel.frame.origin.x, billingLocationLabel.frame.origin.y, 10, labelHeight);
        billingLocationText.frame  = CGRectMake(billingLocationLabel.frame.origin.x, (billingLocationLabel.frame.origin.y + billingLocationLabel.frame.size.height), billingStreetText.frame.size.width, billingStreetText.frame.size.height);

        billingCityLabel.frame = CGRectMake((billingLocationLabel.frame.origin.x + billingLocationLabel.frame.size.width + labelToLabelWidth2), billingLocationLabel.frame.origin.y, billingAddressLabel.frame.size.width, labelHeight);
        //        billingCityStarLabel.frame = CGRectMake(cityStarLabel.frame.origin.x, billingCityLabel.frame.origin.y, 10, labelHeight);
        billingCityText.frame  = CGRectMake(billingCityLabel.frame.origin.x, billingCityLabel.frame.origin.y + billingCityLabel.frame.size.height, billingStreetText.frame.size.width, billingStreetText.frame.size.height);

        //  Row 2 Billing Address view.....
        billingDoorNoLabel.frame = CGRectMake(billingAddressLabel.frame.origin.x, (billingAddressLabel.frame.origin.y + billingAddressLabel.frame.size.height + 15), billingAddressLabel.frame.size.width, labelHeight);
        //        billingDoorNoStarLabel.frame = CGRectMake(doorNoStarLabel.frame.origin.x, billingDoorNoLabel.frame.origin.y, 10, labelHeight);
        billingDoorNoText.frame  = CGRectMake(billingDoorNoLabel.frame.origin.x, billingDoorNoLabel.frame.origin.y + billingDoorNoLabel.frame.size.height, billingStreetText.frame.size.width, billingStreetText.frame.size.height);

        billingContactNoLabel.frame = CGRectMake(billingStreetLabel.frame.origin.x, billingDoorNoLabel.frame.origin.y, billingAddressLabel.frame.size.width, labelHeight);
        //        billingContactNoStarLabel.frame = CGRectMake(contactNoStarLabel.frame.origin.x, billingContactNoLabel.frame.origin.y, 10, labelHeight);
        billingContactNoText.frame  = CGRectMake(billingContactNoLabel.frame.origin.x, billingDoorNoText.frame.origin.y, billingStreetText.frame.size.width, billingStreetText.frame.size.height);

        billingGoogleMapLinkLabel.frame = CGRectMake(billingLocationLabel.frame.origin.x,billingDoorNoLabel.frame.origin.y,billingAddressLabel.frame.size.width,labelHeight);
        billingGoogleMapLinkText.frame  = CGRectMake(billingGoogleMapLinkLabel.frame.origin.x,billingDoorNoText.frame.origin.y ,billingStreetText.frame.size.width, billingStreetText.frame.size.height);

        billingPinCodeLabel.frame = CGRectMake(billingCityLabel.frame.origin.x,billingDoorNoLabel.frame.origin.y,billingAddressLabel.frame.size.width,labelHeight);
        billingPinNoText.frame  = CGRectMake(billingPinCodeLabel.frame.origin.x,billingDoorNoText.frame.origin.y ,billingStreetText.frame.size.width, billingStreetText.frame.size.height);

        billingAddressView.frame = CGRectMake (customerAddressView.frame.origin.x, customerAddressView.frame.origin.y + customerAddressView.frame.size.height + 20, customerAddressView.frame.size.width, billingDoorNoText.frame.origin.y + billingDoorNoText.frame.size.height + 10);
        // <...............End of Billing_Address_View...............>


        // <...............Start of Customer_Address_View...............>
        //  Row 1 Billing Address view.....

        shipmentAddressLabel.frame = CGRectMake(5, 30, (viewsWidth - (labelToLabelWidth2 * 4))/4, 40);

        shipmentContactNoLabel.frame = CGRectMake((shipmentAddressLabel.frame.origin.x + shipmentAddressLabel.frame.size.width + labelToLabelWidth2), 10, shipmentAddressLabel.frame.size.width, labelHeight);
        shipmentContactNoStarLabel.frame = CGRectMake((shipmentContactNoLabel.frame.origin.x + shipmentContactNoLabel.frame.size.width/2) - 15, shipmentContactNoLabel.frame.origin.y, 10, labelHeight);
        shipmentContactNoText.frame  = CGRectMake(shipmentContactNoLabel.frame.origin.x, shipmentContactNoLabel.frame.origin.y + shipmentContactNoLabel.frame.size.height, shipmentContactNoLabel.frame.size.width, 40);

        shipmentDoorNoLabel.frame = CGRectMake((shipmentContactNoLabel.frame.origin.x + shipmentContactNoLabel.frame.size.width + labelToLabelWidth2), shipmentContactNoLabel.frame.origin.y, shipmentAddressLabel.frame.size.width, labelHeight);
        shipmentDoorNoStarLabel.frame = CGRectMake(shipmentDoorNoLabel.frame.origin.x + shipmentDoorNoLabel.frame.size.width/4 + 15, shipmentDoorNoLabel.frame.origin.y, 10, labelHeight);
        shipmentDoorNoText.frame  = CGRectMake(shipmentDoorNoLabel.frame.origin.x, (shipmentDoorNoLabel.frame.origin.y + shipmentDoorNoLabel.frame.size.height), shipmentContactNoText.frame.size.width, shipmentContactNoText.frame.size.height);

        shipmentStreetNoLabel.frame = CGRectMake((shipmentDoorNoLabel.frame.origin.x + shipmentDoorNoLabel.frame.size.width + labelToLabelWidth2), shipmentContactNoLabel.frame.origin.y, shipmentAddressLabel.frame.size.width, labelHeight);
        shipmentStreetNoStarLabel.frame = CGRectMake(shipmentStreetNoLabel.frame.origin.x + shipmentStreetNoLabel.frame.size.width/4, shipmentStreetNoLabel.frame.origin.y, 10, labelHeight);
        shipmentStreetNoText.frame  = CGRectMake(shipmentStreetNoLabel.frame.origin.x, shipmentStreetNoLabel.frame.origin.y + shipmentStreetNoLabel.frame.size.height, shipmentContactNoText.frame.size.width, shipmentContactNoText.frame.size.height);


        //  Row 2 Shipment Address view.....
        shipmentNameLabel.frame = CGRectMake(shipmentAddressLabel.frame.origin.x, (shipmentAddressLabel.frame.origin.y + shipmentAddressLabel.frame.size.height + 15), shipmentAddressLabel.frame.size.width, labelHeight);
        shipmentNameStarLabel.frame = CGRectMake(shipmentNameLabel.frame.origin.x + shipmentNameLabel.frame.size.width/4 - 5, shipmentNameLabel.frame.origin.y, 10, labelHeight);
        shipmentNameText.frame  = CGRectMake(shipmentNameLabel.frame.origin.x, shipmentNameLabel.frame.origin.y + shipmentNameLabel.frame.size.height, shipmentContactNoText.frame.size.width, shipmentContactNoText.frame.size.height);

        shipmentLocationLabel.frame = CGRectMake(shipmentContactNoLabel.frame.origin.x, shipmentNameLabel.frame.origin.y, shipmentAddressLabel.frame.size.width, labelHeight);
        shipmentLocationStarLabel.frame = CGRectMake(shipmentLocationLabel.frame.origin.x + shipmentLocationLabel.frame.size.width/4 + 22, shipmentLocationLabel.frame.origin.y, 10, labelHeight);
        shipmentLocationText.frame  = CGRectMake(shipmentLocationLabel.frame.origin.x, shipmentNameText.frame.origin.y, shipmentContactNoText.frame.size.width, shipmentContactNoText.frame.size.height);

        shipmentCityLabel.frame = CGRectMake(shipmentDoorNoLabel.frame.origin.x,shipmentNameLabel.frame.origin.y,shipmentAddressLabel.frame.size.width,labelHeight);
        shipmentCityStarLabel.frame = CGRectMake(shipmentCityLabel.frame.origin.x + shipmentCityLabel.frame.size.width/4 - 15, shipmentCityLabel.frame.origin.y, 10, labelHeight);
        shipmentCityText.frame  = CGRectMake(shipmentCityLabel.frame.origin.x,shipmentNameText.frame.origin.y ,shipmentContactNoText.frame.size.width, shipmentContactNoText.frame.size.height);

        shipmentStateLabel.frame = CGRectMake(shipmentStreetNoLabel.frame.origin.x,shipmentNameLabel.frame.origin.y,shipmentAddressLabel.frame.size.width,labelHeight);
        shipmentStateStarLabel.frame = CGRectMake(shipmentStateLabel.frame.origin.x + shipmentStateLabel.frame.size.width/4 - 11, shipmentStateLabel.frame.origin.y, 10, labelHeight);
        shipmentStateText.frame  = CGRectMake(shipmentStateLabel.frame.origin.x,shipmentNameText.frame.origin.y ,shipmentContactNoText.frame.size.width, shipmentContactNoText.frame.size.height);

        shipmentAddressView.frame = CGRectMake (customerAddressView.frame.origin.x, billingAddressView.frame.origin.y + billingAddressView.frame.size.height + 20, customerAddressView.frame.size.width, shipmentNameText.frame.origin.y + shipmentNameText.frame.size.height + 10);
        // <...............End of Shipment_Address_View...............>

        // <...............Start of Other_Details_view...............>

        //frames for Row 1.....
        otherDetailsLabel.frame =CGRectMake(5, 30, (viewsWidth - (labelToLabelWidth2 * 4))/4, 40);

        orderChannelLabel.frame =  CGRectMake((otherDetailsLabel.frame.origin.x + otherDetailsLabel.frame.size.width + labelToLabelWidth2), 10, otherDetailsLabel.frame.size.width, labelHeight);
        orderChannelStarLabel.frame = CGRectMake(orderChannelLabel.frame.origin.x + orderChannelLabel.frame.size.width/2 + 13, orderChannelLabel.frame.origin.y, 10, 20);
        orderChannelText.frame  = CGRectMake(orderChannelLabel.frame.origin.x,orderChannelLabel.frame.origin.y +orderChannelLabel.frame.size.height, orderChannelLabel.frame.size.width, 40);
        orderChannelButton.frame = CGRectMake((orderChannelText.frame.origin.x + orderChannelText.frame.size.width - 35), orderChannelText.frame.origin.y + 10, 23, (orderChannelText.frame.size.height-20));

        shipmentTypeLabel.frame = CGRectMake((orderChannelLabel.frame.origin.x + orderChannelLabel.frame.size.width + labelToLabelWidth2), orderChannelLabel.frame.origin.y, orderChannelLabel.frame.size.width, labelHeight);
        shipmentTypeText.frame = CGRectMake(shipmentTypeLabel.frame.origin.x, (shipmentTypeLabel.frame.origin.y + shipmentTypeLabel.frame.size.height), orderChannelText.frame.size.width, orderChannelText.frame.size.height);
        shipmentTypeButton.frame = CGRectMake ((shipmentTypeText.frame.origin.x + shipmentTypeText.frame.size.width - 35), shipmentTypeText.frame.origin.y + 10, 23, (shipmentTypeText.frame.size.height-20));

        salesIdExecutiveNameLabel.frame = CGRectMake((shipmentTypeLabel.frame.origin.x + shipmentTypeLabel.frame.size.width + labelToLabelWidth2), shipmentTypeLabel.frame.origin.y, shipmentTypeLabel.frame.size.width, labelHeight);

        salesExecutiveIdText.frame = CGRectMake(salesIdExecutiveNameLabel.frame.origin.x, salesIdExecutiveNameLabel.frame.origin.y + salesIdExecutiveNameLabel.frame.size.height, 80, orderChannelText.frame.size.height);

        salesExecutiveNameText.frame  = CGRectMake(salesExecutiveIdText.frame.origin.x + salesExecutiveIdText.frame.size.width + 5, salesExecutiveIdText.frame.origin.y, salesIdExecutiveNameLabel.frame.size.width - 85, salesExecutiveIdText.frame.size.height);

        // Framing for Row2....
        deliveryTypeLabel.frame = CGRectMake(otherDetailsLabel.frame.origin.x, (otherDetailsLabel.frame.origin.y + otherDetailsLabel.frame.size.height + 15), otherDetailsLabel.frame.size.width, labelHeight);
        deliveryTypeStarLabel.frame = CGRectMake(deliveryTypeLabel.frame.origin.x + deliveryTypeLabel.frame.size.width/2 + 5, deliveryTypeLabel.frame.origin.y, 10, labelHeight);
        deliveryTypeText.frame = CGRectMake(deliveryTypeLabel.frame.origin.x, deliveryTypeLabel.frame.origin.y + deliveryTypeLabel.frame.size.height, orderChannelText.frame.size.width, orderChannelText.frame.size.height);
        deliveryTypeButton.frame = CGRectMake ((deliveryTypeText.frame.origin.x + deliveryTypeText.frame.size.width - 35), deliveryTypeText.frame.origin.y + 10, 23, (deliveryTypeText.frame.size.height-20));

        shipmentModeLabel.frame = CGRectMake(orderChannelLabel.frame.origin.x, deliveryTypeLabel.frame.origin.y, otherDetailsLabel.frame.size.width, labelHeight);
        shipmentModeText.frame = CGRectMake(shipmentModeLabel.frame.origin.x, deliveryTypeText.frame.origin.y, deliveryTypeText.frame.size.width, deliveryTypeText.frame.size.height);
        shipmentModeButton.frame = CGRectMake ((shipmentModeText.frame.origin.x + shipmentModeText.frame.size.width - 35), shipmentModeText.frame.origin.y + 10, 23, (deliveryModelTF.frame.size.height-20));


        otherDiscountLabel.frame = CGRectMake(shipmentTypeLabel.frame.origin.x, deliveryTypeLabel.frame.origin.y, otherDetailsLabel.frame.size.width, 20);
        otherDiscPercentageTxt.frame = CGRectMake(otherDiscountLabel.frame.origin.x,shipmentModeText.frame.origin.y,(otherDetailsLabel.frame.size.width - 5)/2, 40);
        otherDiscAmountTxt.frame = CGRectMake(otherDiscPercentageTxt.frame.origin.x + otherDiscPercentageTxt.frame.size.width + 5, otherDiscPercentageTxt.frame.origin.y, (otherDetailsLabel.frame.size.width - otherDiscPercentageTxt.frame.size.width)-5, otherDiscPercentageTxt.frame.size.height);

        otherDetailsView.frame = CGRectMake (customerAddressView.frame.origin.x, shipmentAddressView.frame.origin.y + shipmentAddressView.frame.size.height + 20, customerAddressView.frame.size.width, deliveryTypeText.frame.origin.y + deliveryTypeText.frame.size.height + 10);
        // <...............End of Other_Details_view...............>

        // On selection of Drop Down Btn we need to Hide & UnHide customerDetailsScrollView. So from customerDetailsScroolView to till Submit btn framings are given in "setOrderDetailsViewFrame" method
        // Here we are calling setOrderDetailsViewFrame method
        [self setOrderDetailsViewFrame];

    }

    [createOrderView addSubview: headerNameLabel];
    [createOrderView addSubview:createOrderScrollView];

    [createOrderScrollView addSubview:orderDetailsLabel];

    // commented by roja on 08/04/2019....
    //    [createOrderScrollView addSubview:submitButton];
    //    [createOrderScrollView addSubview:saveButton];
    //    [createOrderScrollView addSubview:backButton];

    [createOrderScrollView addSubview:separationLabel];

    // added by roja on 13/02/2019.. && 09/04/2019...
    [createOrderScrollView addSubview:firstNameLbl];
    [createOrderScrollView addSubview:firstNameTF];

    [createOrderScrollView addSubview:customerMobileNoLabel];
    [createOrderScrollView addSubview:customerMobileNoStarLabel];
    [createOrderScrollView addSubview:customerMobileNoText];

    [createOrderScrollView addSubview:orderDateLabel];
    [createOrderScrollView addSubview:orderDateStarLabel];
    [createOrderScrollView addSubview:orderDateText];
    [createOrderScrollView addSubview:orderDateButton];

    [createOrderScrollView addSubview:startTimeLbl];
    [createOrderScrollView addSubview:startTimeTF];
    [createOrderScrollView addSubview:startTimeBtn];
    [createOrderScrollView addSubview:startTimeLblStarLabel];

    [createOrderScrollView addSubview:endTimeLbl];
    [createOrderScrollView addSubview:endTimeTF];
    [createOrderScrollView addSubview:endTimeBtn];
    [createOrderScrollView addSubview:endTimeLblStarLabel];

    [createOrderScrollView addSubview:paymentTypeLabel];
    [createOrderScrollView addSubview:paymentTypeText];
    [createOrderScrollView addSubview:paymentTypeButton];
    //upto here added by roja on 13/02/2019..


    // row2
    // added by roja on 13/02/2019.. && 09/04/2019...
    [createOrderScrollView addSubview:lastNameLbl];
    [createOrderScrollView addSubview:lastNameTF];

    [createOrderScrollView addSubview:customerEmailIdLabel];
    [createOrderScrollView addSubview:customerEmailIdText];

    [createOrderScrollView addSubview:deliveryDateLabel];
    [createOrderScrollView addSubview:deliveryDateStarLabel];
    [createOrderScrollView addSubview:deliveryDateText];
    [createOrderScrollView addSubview:deliveryDateButton];

    [createOrderScrollView addSubview:locationLabel];
    [createOrderScrollView addSubview:locationText];
    [createOrderScrollView addSubview:locationButton];

    [createOrderScrollView addSubview:deliveryModelLbl];
    [createOrderScrollView addSubview:deliveryModelTF];
    [createOrderScrollView addSubview:deliveryMdlDropDownBtn];

    [createOrderScrollView addSubview:paymentModeLabel];
    [createOrderScrollView addSubview:paymentModeText];
    [createOrderScrollView addSubview:paymentModeButton];

    [createOrderScrollView addSubview:paymentRefLabel];
    [createOrderScrollView addSubview:paymentRefText];

    [createOrderScrollView addSubview:dropDownBtn];


    // start of customerDetailsScrollView...
    [createOrderScrollView addSubview:customerDetailsScrollView];

    [customerDetailsScrollView addSubview:customerAddressView];
    [customerDetailsScrollView addSubview:billingAddressView];
    [customerDetailsScrollView addSubview:shipmentAddressView];
    [customerDetailsScrollView addSubview:otherDetailsView];


    [customerAddressView addSubview:customerAddressLabel];
    [customerAddressView addSubview:streetLabel];
    [customerAddressView addSubview:streetStarLabel];
    [customerAddressView addSubview:streetText];

    [customerAddressView addSubview:customerLocationLabel];
    [customerAddressView addSubview:customerLocationStarLabel];
    [customerAddressView addSubview:customerLocationText];

    [customerAddressView addSubview:cityLabel];
    [customerAddressView addSubview:cityStarLabel];
    [customerAddressView addSubview:customerCityText];

    [customerAddressView addSubview:doorNoLabel];
    [customerAddressView addSubview:doorNoStarLabel];
    [customerAddressView addSubview:doorNoText];

    [customerAddressView addSubview:contactNoLabel];
    [customerAddressView addSubview:contactNoStarLabel];
    [customerAddressView addSubview:contactNoText];

    [customerAddressView addSubview:googleMapLinkLabel];
    [customerAddressView addSubview:googleMapLinkText];

    [customerAddressView addSubview:pinLabel];
    [customerAddressView addSubview:pinNoText];

    [billingAddressView addSubview:billingAddressLabel];

    [billingAddressView addSubview:billingStreetLabel];
    //    [billingAddressView addSubview:billingStreetStarLabel];
    [billingAddressView addSubview:billingStreetText];

    [billingAddressView addSubview:billingLocationLabel];
    //    [createOrderScrollView addSubview:billingLocationStarLabel];
    [billingAddressView addSubview:billingLocationText];

    [billingAddressView addSubview:billingCityLabel];
    //    [createOrderScrollView addSubview:billingCityStarLabel];
    [billingAddressView addSubview:billingCityText];

    [billingAddressView addSubview:billingDoorNoLabel];
    //    [createOrderScrollView addSubview:billingDoorNoStarLabel];
    [billingAddressView addSubview:billingDoorNoText];

    [billingAddressView addSubview:billingContactNoLabel];
    //    [createOrderScrollView addSubview:billingContactNoStarLabel];
    [billingAddressView addSubview:billingContactNoText];

    [billingAddressView addSubview:billingGoogleMapLinkLabel];
    [billingAddressView addSubview:billingGoogleMapLinkText];

    [billingAddressView addSubview:billingPinCodeLabel];
    [billingAddressView addSubview:billingPinNoText];

    [shipmentAddressView addSubview:shipmentAddressLabel];

    [shipmentAddressView addSubview:shipmentContactNoLabel];
    [shipmentAddressView addSubview:shipmentContactNoStarLabel];
    [shipmentAddressView addSubview:shipmentContactNoText];

    [shipmentAddressView addSubview:shipmentDoorNoLabel];
    [shipmentAddressView addSubview:shipmentDoorNoStarLabel];
    [shipmentAddressView addSubview:shipmentDoorNoText];

    [shipmentAddressView addSubview:shipmentStreetNoLabel];
    [shipmentAddressView addSubview:shipmentStreetNoStarLabel];
    [shipmentAddressView addSubview:shipmentStreetNoText];

    [shipmentAddressView addSubview:shipmentNameLabel];
    [shipmentAddressView addSubview:shipmentNameStarLabel];
    [shipmentAddressView addSubview:shipmentNameText];

    [shipmentAddressView addSubview:shipmentLocationLabel];
    [shipmentAddressView addSubview:shipmentLocationStarLabel];
    [shipmentAddressView addSubview:shipmentLocationText];

    [shipmentAddressView addSubview:shipmentCityLabel];
    [shipmentAddressView addSubview:shipmentCityStarLabel];
    [shipmentAddressView addSubview:shipmentCityText];

    [shipmentAddressView addSubview:shipmentStateLabel];
    [shipmentAddressView addSubview:shipmentStateStarLabel];
    [shipmentAddressView addSubview:shipmentStateText];

    [shipmentAddressView addSubview:shipmentPinLabel];
    [shipmentAddressView addSubview:shipmentPinText];

    [otherDetailsView addSubview:otherDetailsLabel];

    [otherDetailsView addSubview:orderChannelLabel];
    [otherDetailsView addSubview:orderChannelText];
    [otherDetailsView addSubview:orderChannelStarLabel];
    [otherDetailsView addSubview:orderChannelButton];

    [otherDetailsView addSubview:shipmentTypeLabel];
    [otherDetailsView addSubview:shipmentTypeText];
    [otherDetailsView addSubview:shipmentTypeButton];

    [otherDetailsView addSubview:salesIdExecutiveNameLabel];
    [otherDetailsView addSubview:salesExecutiveIdText];
    [otherDetailsView addSubview:salesExecutiveNameText];

    [otherDetailsView addSubview:deliveryTypeLabel];
    [otherDetailsView addSubview:deliveryTypeText];
    [otherDetailsView addSubview:deliveryTypeButton];
    [otherDetailsView addSubview:deliveryTypeStarLabel];

    [otherDetailsView addSubview:shipmentModeLabel];
    [otherDetailsView addSubview:shipmentModeText];
    [otherDetailsView addSubview:shipmentModeButton];

    [otherDetailsView addSubview:otherDiscountLabel];
    [otherDetailsView addSubview:otherDiscPercentageTxt];
    [otherDetailsView addSubview:otherDiscAmountTxt];

    // upto here added by roja on 13/02/2019.. as per latest GUI....


    // End for the Custom TextFields and UILabels....

    [createOrderScrollView addSubview:searchItemsText];

    [createOrderScrollView addSubview:orderItemsScrollView];

    [orderItemsScrollView addSubview:snoLabel];
    [orderItemsScrollView addSubview:itemIdLabel];
    [orderItemsScrollView addSubview:itemNameLabel];
    [orderItemsScrollView addSubview:makeLabel];
    [orderItemsScrollView addSubview:modelLabel];
    [orderItemsScrollView addSubview:colorLabel];
    [orderItemsScrollView addSubview:sizeLabel];
    [orderItemsScrollView addSubview:mrpLabel];
    [orderItemsScrollView addSubview:salePriceLabel];
    [orderItemsScrollView addSubview:quantityLabel];
    [orderItemsScrollView addSubview:costLabel];
    [orderItemsScrollView addSubview:taxRateLabel];
    [orderItemsScrollView addSubview:taxLabel];
    // added by roja on 10-09-2018...
    [orderItemsScrollView addSubview:promoIdLbl];
    [orderItemsScrollView addSubview:discountLbl];
    [orderItemsScrollView addSubview:uomLbl];
    [orderItemsScrollView addSubview:offerLbl];
    // upto here added by roja on 10-09-2018...
    [orderItemsScrollView addSubview:actionLabel];

    [orderItemsScrollView addSubview:orderItemsTable];
    [createOrderScrollView addSubview:productListTable];

    // Order Total related ...
    [createOrderScrollView addSubview:subTotalLabel];
    [createOrderScrollView addSubview:subTotalText];

    [createOrderScrollView addSubview:totalTaxLbl];
    [createOrderScrollView addSubview:totalTaxTxt];

    [createOrderScrollView addSubview:shippingCostLabel];
    [createOrderScrollView addSubview:shippingCostText];

    [createOrderScrollView addSubview:backGroudLbl1];
    [createOrderScrollView addSubview:backGroudLbl2];

    [createOrderScrollView addSubview:totalCostLabel];
    [createOrderScrollView addSubview:totalCostText];

    [createOrderScrollView addSubview:otherDiscountsLbl];
    [createOrderScrollView addSubview:otherDiscountText];

    [createOrderScrollView addSubview:netValueLabel];
    [createOrderScrollView addSubview:netValueTF];

    [createOrderScrollView addSubview:amountPaidLabel];
    [createOrderScrollView addSubview:amountPaidText];

    [createOrderScrollView addSubview:backGroudLbl3];
    [createOrderScrollView addSubview:backGroudLbl4];

    [createOrderScrollView addSubview:amountDueLabel];
    [createOrderScrollView addSubview:amountDueText];

    [createOrderScrollView addSubview:submitButton2];
    [createOrderScrollView addSubview:saveButton2];
    [createOrderScrollView addSubview:backButton2];


    [self.view addSubview: createOrderView];

    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];

    headerNameLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

    orderDetailsLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

    submitButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    saveButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    backButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];

    customerAddressLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    billingAddressLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    shipmentAddressLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

    otherDetailsLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

    submitButton2.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    saveButton2.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    backButton2.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];

    //used for identification propous....
    orderDateButton.tag = 2;
    deliveryDateButton.tag = 4;
    
    startTimeBtn.tag = 2;
    endTimeBtn.tag = 4;

    submitButton.tag = 2;
    submitButton2.tag = 2;

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

-(void)viewDidAppear:(BOOL)animated{
    
    //calling super call.....
    [super viewDidAppear:YES];
    
    @try {
        if (orderItemListArray == nil)
            orderItemListArray = [NSMutableArray new];
        
        otherDiscPercentageValue = 0;
        reloadTableData = true;
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Here we are setting framings from customerDetailsScrollView to till end of payment details
 * @date         12/14/2019
 * @method       setOrderDetailsViewFrame
 * @author       Roja
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * * @return
 * @verified By
 * @verified On
 *
 */
-(void)setOrderDetailsViewFrame{

    // Customer_Details Scroll View ....
    customerDetailsScrollView.frame = CGRectMake(10,(dropDownBtn.frame.origin.y + dropDownBtn.frame.size.height + 20), customerAddressView.frame.size.width, otherDetailsView.frame.origin.y + otherDetailsView.frame.size.height);

    if (dropDownBtn.tag == 2) {

        searchItemsText.frame = CGRectMake(firstNameTF.frame.origin.x, (customerDetailsScrollView.frame.origin.y + customerDetailsScrollView.frame.size.height + 50), dropDownBtn.frame.origin.x + dropDownBtn.frame.size.width - (firstNameTF.frame.origin.x),40);// customerDetailsScrollView.frame.size.width
    }
    else if (dropDownBtn.tag == 4){

        searchItemsText.frame = CGRectMake(firstNameTF.frame.origin.x, (dropDownBtn.frame.origin.y + dropDownBtn.frame.size.height + 50), dropDownBtn.frame.origin.x + dropDownBtn.frame.size.width - (firstNameTF.frame.origin.x),40);// customerDetailsScrollView.frame.size.width
    }

    orderItemsScrollView.frame = CGRectMake(searchItemsText.frame.origin.x, searchItemsText.frame.origin.y + searchItemsText.frame.size.height + 5, searchItemsText.frame.size.width, 350);

    //frames for the CustomLabels....
    snoLabel.frame = CGRectMake(0,0,40,40);

    itemIdLabel.frame = CGRectMake(snoLabel.frame.origin.x + snoLabel.frame.size.width + 2, snoLabel.frame.origin.y,100, snoLabel.frame.size.height);

    itemNameLabel.frame = CGRectMake(itemIdLabel.frame.origin.x + itemIdLabel.frame.size.width + 2, snoLabel.frame.origin.y,120, snoLabel.frame.size.height);

    makeLabel.frame = CGRectMake(itemNameLabel.frame.origin.x + itemNameLabel.frame.size.width + 2, snoLabel.frame.origin.y,80, snoLabel.frame.size.height);

    modelLabel.frame = CGRectMake(makeLabel.frame.origin.x + makeLabel.frame.size.width + 2, snoLabel.frame.origin.y,70, snoLabel.frame.size.height);

    colorLabel.frame = CGRectMake(modelLabel.frame.origin.x + modelLabel.frame.size.width + 2, snoLabel.frame.origin.y,80, snoLabel.frame.size.height);

    sizeLabel.frame = CGRectMake(colorLabel.frame.origin.x + colorLabel.frame.size.width + 2, snoLabel.frame.origin.y,70, snoLabel.frame.size.height);

    promoIdLbl.frame = CGRectMake(sizeLabel.frame.origin.x + sizeLabel.frame.size.width + 2, snoLabel.frame.origin.y,100, snoLabel.frame.size.height);

    uomLbl.frame = CGRectMake(promoIdLbl.frame.origin.x + promoIdLbl.frame.size.width + 2, snoLabel.frame.origin.y,50, snoLabel.frame.size.height);

    mrpLabel.frame = CGRectMake(uomLbl.frame.origin.x + uomLbl.frame.size.width + 2, snoLabel.frame.origin.y,60, snoLabel.frame.size.height);

    quantityLabel.frame = CGRectMake(mrpLabel.frame.origin.x + mrpLabel.frame.size.width + 2, snoLabel.frame.origin.y, 60, snoLabel.frame.size.height);

    offerLbl.frame = CGRectMake(quantityLabel.frame.origin.x + quantityLabel.frame.size.width + 2, snoLabel.frame.origin.y, 85, snoLabel.frame.size.height);// w-70

    discountLbl.frame = CGRectMake(offerLbl.frame.origin.x + offerLbl.frame.size.width + 2, snoLabel.frame.origin.y, 105, snoLabel.frame.size.height);//w-100

    salePriceLabel.frame = CGRectMake(discountLbl.frame.origin.x + discountLbl.frame.size.width + 2, snoLabel.frame.origin.y,90, snoLabel.frame.size.height);

    costLabel.frame = CGRectMake(salePriceLabel.frame.origin.x + salePriceLabel.frame.size.width + 2, snoLabel.frame.origin.y,70, snoLabel.frame.size.height);

    taxRateLabel.frame = CGRectMake(costLabel.frame.origin.x + costLabel.frame.size.width + 2, snoLabel.frame.origin.y,90, snoLabel.frame.size.height);

    taxLabel.frame = CGRectMake(taxRateLabel.frame.origin.x + taxRateLabel.frame.size.width + 2, snoLabel.frame.origin.y,60, snoLabel.frame.size.height);

    actionLabel.frame = CGRectMake(taxLabel.frame.origin.x + taxLabel.frame.size.width + 2, snoLabel.frame.origin.y,60, snoLabel.frame.size.height);

    orderItemsScrollView.contentSize = CGSizeMake( (snoLabel.frame.origin.x + actionLabel.frame.origin.x + actionLabel.frame.size.width), orderItemsScrollView.frame.size.height);

    orderItemsTable.frame = CGRectMake( 0, snoLabel.frame.origin.y + snoLabel.frame.size.height, orderItemsScrollView.contentSize.width, orderItemsScrollView.frame.size.height - (snoLabel.frame.origin.y + snoLabel.frame.size.height));


    // Framings For Order Total Calculations ....
    subTotalLabel.frame = CGRectMake(self.view.frame.size.width - 490 ,orderItemsScrollView.frame.origin.y + orderItemsScrollView.frame.size.height + 20, 130, 30);
    subTotalText.frame = CGRectMake(subTotalLabel.frame.origin.x + subTotalLabel.frame.size.width, subTotalLabel.frame.origin.y, 100, 30);

    totalTaxLbl.frame = CGRectMake(subTotalLabel.frame.origin.x ,subTotalLabel.frame.origin.y + subTotalLabel.frame.size.height + 5, subTotalLabel.frame.size.width, subTotalLabel.frame.size.height);
    totalTaxTxt.frame = CGRectMake(subTotalText.frame.origin.x, totalTaxLbl.frame.origin.y, subTotalText.frame.size.width, subTotalText.frame.size.height);

    shippingCostLabel.frame = CGRectMake(subTotalLabel.frame.origin.x ,totalTaxLbl.frame.origin.y + totalTaxLbl.frame.size.height + 5, subTotalLabel.frame.size.width, subTotalLabel.frame.size.height);
    shippingCostText.frame = CGRectMake(subTotalText.frame.origin.x, shippingCostLabel.frame.origin.y, subTotalText.frame.size.width, subTotalText.frame.size.height);

    backGroudLbl1.frame = CGRectMake(subTotalLabel.frame.origin.x, shippingCostLabel.frame.origin.y + shippingCostLabel.frame.size.height + 5, 230, 1.5);

    totalCostLabel.frame = CGRectMake(subTotalLabel.frame.origin.x ,backGroudLbl1.frame.origin.y + backGroudLbl1.frame.size.height + 5, subTotalLabel.frame.size.width, subTotalLabel.frame.size.height);
    totalCostText.frame = CGRectMake(subTotalText.frame.origin.x, totalCostLabel.frame.origin.y, subTotalText.frame.size.width, subTotalText.frame.size.height);

    backGroudLbl2.frame = CGRectMake(backGroudLbl1.frame.origin.x, totalCostLabel.frame.origin.y + totalCostLabel.frame.size.height + 5, backGroudLbl1.frame.size.width, 1.5);

    otherDiscountsLbl.frame = CGRectMake(subTotalText.frame.origin.x + subTotalText.frame.size.width + 20, subTotalLabel.frame.origin.y, 130, 30);
    otherDiscountText.frame = CGRectMake(otherDiscountsLbl.frame.origin.x + otherDiscountsLbl.frame.size.width, otherDiscountsLbl.frame.origin.y, 100, 30);

    netValueLabel.frame = CGRectMake(otherDiscountsLbl.frame.origin.x, otherDiscountsLbl.frame.origin.y + otherDiscountsLbl.frame.size.height + 5, otherDiscountsLbl.frame.size.width, otherDiscountsLbl.frame.size.height);
    netValueTF.frame = CGRectMake(otherDiscountText.frame.origin.x, netValueLabel.frame.origin.y, otherDiscountText.frame.size.width, otherDiscountText.frame.size.height);

    amountPaidLabel.frame = CGRectMake(otherDiscountsLbl.frame.origin.x, netValueLabel.frame.origin.y + netValueLabel.frame.size.height + 8, otherDiscountsLbl.frame.size.width, otherDiscountsLbl.frame.size.height);
    amountPaidText.frame = CGRectMake(otherDiscountText.frame.origin.x, amountPaidLabel.frame.origin.y, otherDiscountText.frame.size.width, otherDiscountText.frame.size.height);

    backGroudLbl3.frame = CGRectMake(otherDiscountsLbl.frame.origin.x, amountPaidLabel.frame.origin.y + amountPaidLabel.frame.size.height + 5, 230, 1.5);

    amountDueLabel.frame = CGRectMake(otherDiscountsLbl.frame.origin.x ,backGroudLbl3.frame.origin.y + backGroudLbl3.frame.size.height + 5, otherDiscountsLbl.frame.size.width, otherDiscountsLbl.frame.size.height);
    amountDueText.frame = CGRectMake(otherDiscountText.frame.origin.x, amountDueLabel.frame.origin.y, otherDiscountText.frame.size.width, otherDiscountText.frame.size.height);

    backGroudLbl4.frame = CGRectMake(backGroudLbl3.frame.origin.x, amountDueLabel.frame.origin.y + amountDueLabel.frame.size.height + 5, backGroudLbl3.frame.size.width, 1.5);

    submitButton2.frame = CGRectMake(searchItemsText.frame.origin.x, (totalCostText.frame.origin.y), 115, 40);
    saveButton2.frame = CGRectMake(submitButton2.frame.origin.x + submitButton2.frame.size.width + 20, submitButton2.frame.origin.y, 115, 40);
    backButton2.frame = CGRectMake(saveButton2.frame.origin.x + saveButton2.frame.size.width + 20, submitButton2.frame.origin.y, 115, 40);

    createOrderScrollView.contentSize = CGSizeMake(550, backGroudLbl2.frame.origin.y + backGroudLbl2.frame.size.height + 30);

}

-(void)customerDetailsViewDropDownBtnAction:(UIButton *)sender{

    if (sender.tag == 2) {

        dropDownBtn.tag = 4;
        [dropDownBtn setBackgroundImage:[UIImage imageNamed:@"down_arrow.png"] forState:UIControlStateNormal];
        [customerDetailsScrollView setHidden:YES];

        [self setOrderDetailsViewFrame];
    }
    else{

        dropDownBtn.tag = 2;
        [dropDownBtn setBackgroundImage:[UIImage imageNamed:@"Up_arrow.png"] forState:UIControlStateNormal];
        //  Up_arrow.png
        [customerDetailsScrollView setHidden:NO];
        [self setOrderDetailsViewFrame];
    }
}

#pragma mark service calls


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

-(void)callingGetStores {
    
    @try {
        
        [HUD show: YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        if(virtualStoresArray == nil)
            virtualStoresArray = [NSMutableArray new];
        
        //Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSMutableDictionary * storesDictionary  = [[NSMutableDictionary alloc]init];
        
        [storesDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [storesDictionary setValue:@0 forKey:START_INDEX];
        [storesDictionary setValue:@0 forKey:STORE_STATUS];
        [storesDictionary setValue:@"" forKey:LOCATION_ID];
        [storesDictionary setValue:@"" forKey:kLocation];
        
        
        NSError * err_;
        NSData  * jsonData_ = [NSJSONSerialization dataWithJSONObject:storesDictionary options:0 error:&err_];
        NSString * storesjsonStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.storeServiceDelegate = self;
        [webServiceController getStores:storesjsonStr];
        
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getZones ServicesCall ----%@",exception);
        
    } @finally {
        
    }
}




/**
 * @description  here we are calling searchSku.......
 * @date         21/09/2016
 * @method       callRawMaterials
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

-(void)callRawMaterials:(NSString *)searchString {
    
    @try {
        [HUD show:YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        if (productListArray.count!= 0) {
            [productListArray removeAllObjects];
        }
        
        NSMutableDictionary * searchProductDic = [[NSMutableDictionary alloc] init];
        
        searchProductDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        searchProductDic[START_INDEX] = @"0";
        searchProductDic[kSearchCriteria] = searchItemsText.text;
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
 * @description  this method is used to call skuList.......
 * @date         21/09/2016
 * @method       callRawMaterialDetails
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       hiding the HUD in catch block....
 *
 *
 * @modified BY  Roja on 10/09/2018
 * @reason       Adding ApplyCampaigns to the request string to get deals ad offers...
 *
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)callRawMaterialDetails:(NSString *)pluCodeStr {
    
    
    @try {
        [HUD show:YES];
        [HUD setHidden: NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        NSDictionary * campaigndictionary_;
        
        if(isToCallApplyCampaigns){
            
            NSMutableArray *skuIdList = [[NSMutableArray alloc]init];
            NSMutableArray *pluCodeList = [[NSMutableArray alloc]init];
            NSMutableArray *unitPriceList = [[NSMutableArray alloc]init];
            NSMutableArray *qtyList = [[NSMutableArray alloc]init];
            NSMutableArray *totalPriceList = [[NSMutableArray alloc]init];
            NSMutableArray *itemStatusList = [NSMutableArray new];
            NSMutableArray *itemDiscountList = [NSMutableArray new];
            
            for (int i = 0; i < orderItemListArray.count; i++) {
                
                NSDictionary *itemDetailsDic = [orderItemListArray objectAtIndex:i];
                [skuIdList addObject:[itemDetailsDic valueForKey:ITEM_SKU]];
                [pluCodeList addObject:[itemDetailsDic valueForKey:PLU_CODE]];
                [unitPriceList addObject:[NSString stringWithFormat:@"%.2f",[[itemDetailsDic valueForKey:Item_Price]floatValue]] ];
                [qtyList addObject: [NSString stringWithFormat:@"%.2f",[[itemDetailsDic valueForKey:ORDERED_QUANTITY]floatValue] ] ];
                [totalPriceList addObject: [NSString stringWithFormat:@"%.2f", [[itemDetailsDic valueForKey:Item_Price] floatValue] * [[itemDetailsDic valueForKey:ORDERED_QUANTITY]floatValue]] ];
                
                [itemStatusList addObject:@""];
                //[itemDiscountList addObject:@([itemDiscountArr[i] floatValue])];
                [itemDiscountList addObject:[itemDetailsDic valueForKey:DISCOUNT]];
            }
            
            NSArray *loyaltyKeys = @[STORELOCATION, REQUEST_HEADER, SKU_ID_ARR_LIST, PLU_CODE_ARR_LIST, UNIT_PRICE_ARR_LIST, QTY_ARR_LIST, TOTAL_PRICE_ARR_LIST, ITME_STATUS_ARR_LIST, PRODUCT_OPTIONAL_DISCOUNT_ARR, TOTAL_BILL_AMOUNT, QUANTITY, PHONE_NUMBER, PURCHASE_CHANNEL, EMPLOYEE_CODE, LATEST_CAMPAIGNS];
            
            NSString *empCodeStr = @"";
            
            NSArray *loyaltyObjects = @[presentLocation,[RequestHeader getRequestHeader],skuIdList,pluCodeList,unitPriceList,qtyList,totalPriceList,itemStatusList, itemDiscountList, totalCostText.text,@"1",customerMobileNoText.text,POS,empCodeStr,@(applyLatestCampaigns)];
            
            campaigndictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        }
        else{
            campaigndictionary_ = [[NSDictionary alloc]init];
            
        }
        
        Boolean isCampaignsRequired = false;
        
        if (isToCallApplyCampaigns) {
            isCampaignsRequired = true;
        }
        
        // NSDictionary * productDetailsDic = [[NSDictionary alloc] init];
        
        NSDictionary * productDetailsDic  = [NSDictionary dictionaryWithObjectsAndKeys:presentLocation,kStoreLocation,[RequestHeader getRequestHeader],REQUEST_HEADER,pluCodeStr,ITEM_SKU,NEGATIVE_ONE,START_INDEX,[NSNumber numberWithBool:TRUE],kIsApplyCampaigns,campaigndictionary_,CART_DETAILS,[NSNumber numberWithBool:TRUE],kZeroStockBillCheck,[NSNumber numberWithBool: isCampaignsRequired],IS_CAMPAIGNS_REQUIRED, nil];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
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
 * @description   Here we are creating a new order....
 * @date
 * @method        submitButtonPressed
 * @author        Bhargav.v
 * @param         UIButton
 * @param
 * @return        void
 *
 * @Modified By   Roja
 * @Modified Date 21-09-2018
 * @Reason        Checking wheather necessary fields are selected(star fileds), and adding taxes and discounts in the request string...
 *
 * @verified By
 * @verified On
 *
 */

-(void)submitButtonPressed:(UIButton *)sender {
    
    //  added by roja on 14-09-2018... && 16/04/2019...
    if ((orderDateText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 120;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_order_date",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        UIButton * orderBtn  = [[UIButton alloc]init];
        orderBtn.tag = 2;
        [self showCalenderInPopUp:orderBtn];
    }
    
    else if ((deliveryDateText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 120;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_order_delivery_date",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        UIButton * locDeliveryBtn  = [[UIButton alloc]init];
        locDeliveryBtn.tag = 4;
        [self showCalenderInPopUp:locDeliveryBtn];
    }
    else if ((customerMobileNoText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_customer_mobile_number",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [customerMobileNoText becomeFirstResponder];
    }
    else if (customerMobileNoText.text.length > 10) {
        
        float y_axis = self.view.frame.size.height - 450;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_valid_mobile_number",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [customerMobileNoText becomeFirstResponder];
    }
    else if ((customerEmailIdText.text).length > 0 && ([self validateEmail:customerEmailIdText.text] == FALSE)) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_valid_email_id",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [customerEmailIdText becomeFirstResponder];
    }
    else if ((streetText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_street",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [streetText becomeFirstResponder];
    }
    else if ((customerLocationText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_location",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [customerLocationText becomeFirstResponder];
    }
    else if ((customerCityText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_city",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [customerCityText becomeFirstResponder];
    }
    else if ((doorNoText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_door_number",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [doorNoText becomeFirstResponder];
    }
    else if ((contactNoText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_contact_number",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [contactNoText becomeFirstResponder];
    }
    else if (contactNoText.text.length > 10) {
        
        float y_axis = self.view.frame.size.height - 450;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_valid_mobile_number",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [contactNoText becomeFirstResponder];
    }
    else if ((shipmentContactNoText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_shipment_contact_number",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [shipmentContactNoText becomeFirstResponder];
    }
    else if (shipmentContactNoText.text.length > 10) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_valid_mobile_number",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [shipmentContactNoText becomeFirstResponder];
    }
    else if ((shipmentDoorNoText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_shipment_door_number",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [shipmentDoorNoText becomeFirstResponder];
    }
    else if ((shipmentStreetNoText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;
 
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_shipment_street",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [shipmentStreetNoText becomeFirstResponder];
    }
    else if ((shipmentNameText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;

        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_name",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [shipmentNameText becomeFirstResponder];
    }
    else if ((shipmentLocationText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_Shipment_location",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [shipmentLocationText becomeFirstResponder];
    }
    else if ((shipmentCityText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_Shipment_city",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [shipmentCityText becomeFirstResponder];
    }
    else if ((shipmentStateText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_state",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [shipmentStateText becomeFirstResponder];
    }
    else if ((orderChannelText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_order_channel",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        //        [orderChannelText becomeFirstResponder];
        UIButton *orderChannelBtn = [[UIButton alloc]init];
        [self showOrderChannel:orderChannelBtn];
    }
    else if ((deliveryTypeText.text).length == 0) {
        
        float y_axis = self.view.frame.size.height - 450;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_delivery_type",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        //        [deliveryTypeText becomeFirstResponder];
        UIButton *deliveryTypeBtn = [[UIButton alloc]init];
        [self showDeliveryType:deliveryTypeBtn];
    }
    
    else if ( orderItemListArray.count == 0) {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_add_items_to_the_cart",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    else if( (amountPaidText.text.floatValue > netValueTF.text.floatValue) ){ //totalCostText.text.floatValue
    
            float y_axis = self.view.frame.size.height - 120;
    
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"paid_amount_exceeding_the_net_bill_amount",nil)];
    
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            [amountPaidText becomeFirstResponder];
    }
    else if( [deliveryModelTF.text length] && [deliveryModelTF.text isEqualToString:@"Any Time"] && ([startTimeTF.text length] == 0 || [endTimeTF.text length] == 0) ){
        
        if ([startTimeTF.text length] == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_delivery_start_time",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            UIButton * startTimeBtn = [[UIButton alloc]init];
            startTimeBtn.tag = 2;
            [self showTimeInPopUp: startTimeBtn];
        }
        else if ([endTimeTF.text length] == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_delivery_end_time",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

            UIButton * endTimeBtn = [[UIButton alloc]init];
            endTimeBtn.tag = 4;
            [self showTimeInPopUp: endTimeBtn];
        }
        // upto here added by roja on 14-09-2018... && 16/04/2019...
    }
    else {
        
        @try{
            [HUD show: YES];
            [HUD setHidden: NO];
            [HUD setLabelText:NSLocalizedString(@"Placing Order..",nil)];
            
            NSString * orderCreatedDateStr = orderDateText.text;
            NSString * orderDeliveryDateStr = deliveryDateText.text;
            
            if(orderDeliveryDateStr.length > 1)
                orderDeliveryDateStr = [NSString stringWithFormat:@"%@", deliveryDateText.text];
            
            NSMutableDictionary * createOrderDic = [[NSMutableDictionary alloc] init];
            
            //Order Details...
            createOrderDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            createOrderDic[Order_Date] = orderCreatedDateStr;
            createOrderDic[DELIVERY_DATE] = orderDeliveryDateStr;
            
            createOrderDic[PAYMENT_TYPE] = paymentTypeText.text;
            createOrderDic[PAYMENT_MODE] = paymentModeText.text;
            createOrderDic[SALE_LOCATION] = locationText.text;
            createOrderDic[EMAIL_ID] = customerEmailIdText.text;
            createOrderDic[MOBILE_NUM] = customerMobileNoText.text;
            createOrderDic[PAYMENT_REF] = paymentRefText.text;
            
            //Customer Address..
            createOrderDic[CUSTOMER_ADDRESS_STREET] = streetText.text;
            createOrderDic[CUSTOMER_ADDRESS_LOCATION] = customerLocationText.text;
            createOrderDic[CUSTOMER_ADDRESS_CITY] = customerCityText.text;
            createOrderDic[CUSTOMER_ADDRESS_DOOR_NO] = doorNoText.text;
            createOrderDic[CUSTOMER_CONTACT_NUM] = contactNoText.text;
            createOrderDic[CUSTOMER_MAP_LINK] = googleMapLinkText.text;
            createOrderDic[customer_pinNo] = pinNoText.text;
            
            //Billing Address...
            createOrderDic[BILLING_ADDRESS_STREET] = billingStreetText.text;
            createOrderDic[BILLING_ADDRESS_LOCATION] = billingLocationText.text;
            createOrderDic[BILLING_ADDRESS_CITY] = billingCityText.text;
            createOrderDic[BILLING_ADDRESS_DOOR_NO] = billingDoorNoText.text;
            createOrderDic[BILLING_CONTACT_NUM] = billingContactNoText.text;
            createOrderDic[BILLING_MAP_LINK] = billingGoogleMapLinkText.text;
            createOrderDic[billing_pinNo] = billingPinNoText.text;
            
            //Shipment Address...
            createOrderDic[SHIPMENT_CONTACT_NUM] = shipmentContactNoText.text;
            createOrderDic[SHIPMENT_DOOR_NO] = shipmentDoorNoText.text;
            createOrderDic[SHIPMENT_STREET] = shipmentStreetNoText.text;
            createOrderDic[SHIPMENT_NAME] = shipmentNameText.text;
            createOrderDic[SHIPMENT_LOCATION] = shipmentLocationText.text;
            createOrderDic[SHIPMENT_CITY] = shipmentCityText.text;
            createOrderDic[SHIPMENT_STATE] = shipmentStateText.text;
            
            //Other Details...
            
            createOrderDic[ORDER_CHANNEL] = orderChannelText.text;
            createOrderDic[SHIPPER_ID] = shipmentTypeText.text;
            createOrderDic[SALES_EXECUTIVE_ID] = salesExecutiveIdText.text;
            createOrderDic[SALES_EXECUTIVE_NAME] = salesExecutiveNameText.text;
            //createOrderDic[REFERRED_BY] = refferedByText.text;
            createOrderDic[ORDER_DELIVERY_TYPE] = deliveryTypeText.text;
            createOrderDic[kShipmentMode] = shipmentModeText.text;
            
            //itemDetails
            if (sender.tag == 2) {
                
                createOrderDic[ORDER_STATUS] = ORDERED;
            }
            else
                createOrderDic[ORDER_STATUS] = DRAFT;
            
            //Discount Level Calulations....
            //Appending it Statically temporarly....
            createOrderDic[SPECIAL_DISCOUNT] = @0.0f;
            createOrderDic[OTHER_TAX_AMT] = @0.0f;
            if(![otherDiscAmountTxt.text length])
                otherDiscAmountTxt.text = @"0.00";
            createOrderDic[OTHER_DISCOUNTS] = otherDiscAmountTxt.text;
            createOrderDic[IS_GST_AMOUNT] = @0.0f;
            
            createOrderDic[SUB_TOTAL] = subTotalText.text;
            createOrderDic[ORDER_TOTAL_COST] = totalCostText.text;
            createOrderDic[TOTAL_ORDER_AMOUNT] = totalCostText.text;
            
            createOrderDic[BILL_DUE] = amountDueText.text;
            createOrderDic[PAID_AMT] = amountPaidText.text;
            
            // item Dictionary....
            NSMutableArray * orderItemTaxesListArr = [[NSMutableArray alloc]init];
            NSMutableDictionary * orderItemTaxesListDic;
            
            NSMutableArray * orderDiscountsArr = [[NSMutableArray alloc]init];
            NSMutableDictionary * orderDiscountsDic;
            
            // added by roja on 14-09-2018...
            
            @try{
                for (int i=0; i< orderItemListArray.count; i++) {
                    
                    NSMutableDictionary *orderItemsDic = [[orderItemListArray objectAtIndex:i] mutableCopy];
                    
                    // setting Sale_price after discounts to Item_Price Key...
                    [orderItemsDic setValue:[orderItemsDic valueForKey:SALE_PRICE_AFTER_DISCOUNT] forKey:Item_Price];
                    [orderItemListArray replaceObjectAtIndex:i withObject:orderItemsDic];
                    
                    
                    if ( !( [[orderItemsDic valueForKey:TAX] isKindOfClass:[NSNull class]] ) && [[orderItemsDic valueForKey:TAX] count] ) {
                        
                        for (NSDictionary *taxDic in [orderItemsDic valueForKey:TAX] ){
                            
                            orderItemTaxesListDic = [[NSMutableDictionary alloc] init];
                            [orderItemTaxesListDic setValue:[orderItemsDic valueForKey:ITEM_SKU] forKey:SKU_ID];
                            [orderItemTaxesListDic setValue:[orderItemsDic valueForKey:PLU_CODE] forKey:plu_code_];
                            [orderItemTaxesListDic setValue:[taxDic valueForKey:Tax_Category] forKey:TAX_CATEGORY];
                            [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_CODE] forKey:Tax_code];
                            [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_TYPE] forKey:Tax_Type];
                            [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_RATE] forKey:Tax_rate];
                            
                            [orderItemTaxesListDic setValue:[self checkGivenValueIsNullOrNil:[orderItemsDic valueForKey:[taxDic valueForKey:TAX_CODE]]  defaultReturn:@"0.00"] forKey:Tax_value];
                            
                            [orderItemTaxesListArr addObject:orderItemTaxesListDic];
                        }
                    }else if([[orderItemsDic valueForKey:TAX] count] == 0){
                        
                        orderItemTaxesListDic = [[NSMutableDictionary alloc]init];
                        [orderItemTaxesListArr addObject:orderItemTaxesListDic];
                    }
                    
                    if(dealOffersDic != nil && ([[orderItemsDic valueForKey:DISCOUNT_PRICE]floatValue] > 0) ){
                        
                        orderDiscountsDic = [[NSMutableDictionary alloc]init];
                        
                        [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_TYPE] forKey:DISCOUNT_TYPE];
                        [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_ID] forKey:DISCOUNT_ID];
                        [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_PRICE] forKey:DISCOUNT_PRICE];
                        [orderDiscountsDic setValue:[orderItemsDic valueForKey:ITEM_SKU] forKey:ITEM_SKU];
                        [orderDiscountsDic setValue:[orderItemsDic valueForKey:SALE_PRICE] forKey:iTEM_PRICE];
                        [orderDiscountsDic setValue:[orderItemsDic valueForKey:PLU_CODE] forKey:PLU_CODE];
                        
                        [orderDiscountsArr addObject:orderDiscountsDic];
                    }
                    //                    else
                    //                        [orderDiscountsArr addObject:orderDiscountsDic];
                }
            }
            @catch(NSException *exception){
                NSLog(@"exception while creating an order ----%@",exception);
            }
            
            NSMutableArray * orderTransactionArr = [[NSMutableArray alloc]init];
            NSMutableDictionary * orderTransactionDic = [[NSMutableDictionary alloc]init];
            
            [orderTransactionDic setValue:@"" forKey:ORDER_ID];
            [orderTransactionDic setValue:amountPaidText.text forKey:PAID_AMT];
            [orderTransactionDic setValue:amountPaidText.text forKey:RECEIVED_AMOUNT];
            [orderTransactionDic setValue:paymentModeText.text forKey:MODE_OF_PAY];
            [orderTransactionDic setValue:paymentTypeText.text forKey:PAYMENT_STATUS];
            [orderTransactionDic setValue:@"" forKey:CARD_TYPE];
            [orderTransactionDic setValue:@"" forKey:COUPON_NO];
            [orderTransactionDic setValue:@"" forKey:BANK_NAME];
            [orderTransactionDic setValue:@"" forKey:APPROVAL_CODE];
            [orderTransactionDic setValue:@"0" forKey:CHANGE_RETURN];
            [orderTransactionDic setValue:@"" forKey:CARD_INFO];
            [orderTransactionDic setValue:@"" forKey:DATE];
            
            [orderTransactionArr addObject:orderTransactionDic];
            
            createOrderDic[ORDER_DISCOUNTS_LIST] = orderDiscountsArr;
            createOrderDic[kItemDetails] = orderItemListArray;
            createOrderDic[ORDER_ITEM_TAXES_LIST] = orderItemTaxesListArr;
            createOrderDic[ORDER_TRANSACTIONS] = orderTransactionArr;
            
            [createOrderDic setValue:totalTaxTxt.text forKey:ORDER_TAX];
            [createOrderDic setValue:shippingCostText.text forKey:SHIPMENT_CHARGES];
            createOrderDic[ORDERED_ITEMSLIST] = orderItemListArray;
            
            createOrderDic[no_of_items] = [NSNumber numberWithInteger:orderItemListArray.count];
            
            createOrderDic[DELIVERY_SLOT_START_TIME] = startTimeTF.text;
            createOrderDic[DELIVERY_SLOT_END_TIME] = endTimeTF.text;
            createOrderDic[DELIVERY_MODEL] = deliveryModelTF.text;
            // upto here changed by roja on 14-09-2018.. && on 16/04/2019.
            
            NSError  * err;
            NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:createOrderDic options:0 error:&err];
            
            NSString * createOrderJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"New Order -- Create Order request String: ----%@",createOrderJsonStr);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.outletOrderServiceDelegate = self;
            [webServiceController  createOutletOrder:createOrderJsonStr];
            
        }
        @catch(NSException * exception){
            
            [HUD setHidden:YES];
            
            float y_axis = self.view.frame.size.height - 120;
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            NSLog(@"-------exception will reading.-------%@",exception);
        }
        
        @finally {
            
        }
        
    }
}

/*
 //    else if ((paymentTypeText.text).length == 0) {
 //
 //        float y_axis = self.view.frame.size.height - 450;
 //
 //        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_payment_type",nil)];
 //
 //        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
 //
 //        UIButton * paymentTypeBtn  = [[UIButton alloc]init];
 //        [self showPaymentType:paymentTypeBtn];
 //
 //        //  [paymentTypeText becomeFirstResponder];
 //    }
 //    else if ((paymentModeText.text).length == 0) {
 //
 //        float y_axis = self.view.frame.size.height - 450;
 //
 //        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_payment_mode",nil)];
 //
 //        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
 //
 //        UIButton * paymentModeBtn  = [[UIButton alloc]init];
 //        [self showPaymentMode:paymentModeBtn];
 //
 //        // [paymentModeText becomeFirstResponder];
 //    }
 
 */


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

-(void)getStoresSuccessResponse:(NSDictionary *)successDictionary {
    @try{
        
        for(NSDictionary * storesDic in [successDictionary valueForKey:@"outlets"] ) {
            
            int virtualStore = [[self checkGivenValueIsNullOrNil:[storesDic valueForKey:@"isVirtualStore"]  defaultReturn:@"0"]intValue];
            
            if (virtualStore == 1) {
                
                [virtualStoresArray addObject:[storesDic valueForKey:LOCATION]];
            }
            else {
                
                [HUD setHidden:YES];
                
                float y_axis = self.view.frame.size.height - 120;
                
                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"No Virtual Stores are available",nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
                
            }
        }
    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
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
-(void)getStoreErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:(mesg.length)*10 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
    }
    
    
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         27/03/2018
 * @method       searchProductsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        
        [HUD setHidden:YES];
        
        
        if (![successDictionary[@"productsList"] isKindOfClass:[NSNull class]]) {
            
            NSArray * list = successDictionary[@"productsList"];
            
            [ productListArray addObjectsFromArray:list];
        }
        //        for (NSDictionary *product in productListArray)   {
        //
        //            if ([product objectForKey:@"ean"]!=nil || [[product objectForKey:@"ean"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
        //
        //                [filteredSkuArrayList addObject:[product objectForKey:@"description"]];
        //                if (!isOfflineService) {
        //
        //                    [filteredPriceArr addObject:[[product objectForKey:@"price"] stringValue]];
        //
        //                }
        //                else {
        //                    [filteredPriceArr addObject:[product objectForKey:@"price"] ];
        //
        //                }
        //                [skuArrayList addObject:product];
        //
        //            }
        //            else  {
        //
        //                [filteredSkuArrayList addObject:[product objectForKey:@"description"]];
        //                [filteredPriceArr addObject:[product objectForKey:@"price"] ];
        //                [skuArrayList addObject:product];
        //            }
        //
        //
        //        }
        if (productListArray.count > 0) {
            
            //changeed By Srinivasulu on 17/08/2016
            
            float cell_height = 45;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                cell_height = 28;
            }
            
            float table_height = (productListArray.count + 1) * cell_height;
            
            if(table_height > ( (subTotalText.frame.origin.y - 10) - (searchItemsText.frame.origin.y + searchItemsText.frame.size.height))){
                
                table_height = (subTotalText.frame.origin.y - 10) - (searchItemsText.frame.origin.y + searchItemsText.frame.size.height);
            }
            
            productListTable.frame =  CGRectMake(searchItemsText.frame.origin.x, (searchItemsText.frame.origin.y + searchItemsText.frame.size.height), searchItemsText.frame.size.width, table_height);
            
            productListTable.hidden = NO;
            [self.view bringSubviewToFront:productListTable];
            [productListTable reloadData];
            
        }
        
        else {
            
            productListTable.hidden = YES;
        }
        
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid product" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    @finally{
        
        [productListTable reloadData];
    }
    
}

/**
 * @description  here we are handling the error resposne received from services.......
 * @date         27/03/2018
 * @method       searchProductsErrorResponse:
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsErrorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [productListTable reloadData];
        
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         27/03/2018
 * @method       getSkuDetailsSuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016 and Roja on 18-09-2018..
 * @Reason       calculating minimum quantity based on item "packed" flag. Also sending Apply Campaign as input to
 getDealsAndOffersSuccessResponse.
 * @return
 * @verified By
 * @verified On
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        if([[successDictionary allKeys] containsObject:kSkuLists] && ![[successDictionary valueForKey:kSkuLists] isKindOfClass:[NSNull class]]){
            
            if([[successDictionary valueForKey:kSkuLists] count] > 0){
                
                NSDictionary * itemdic = [[successDictionary valueForKey:kSkuLists] objectAtIndex:0];
                
                BOOL isNewItem = TRUE;
                int i = 0;
                NSMutableDictionary * existingDic;
                
                for(NSDictionary * tempDic in orderItemListArray){
                    
                    if ([[tempDic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[tempDic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                        
                        existingDic = [tempDic mutableCopy];
                        isNewItem = FALSE;
                        break;
                    }
                    i++;
                }
                
                Boolean  showAlert = false;
                Boolean  isToAllowZeroStock = true;
                
                float minimumQty = 0;
                
                if(!isNewItem)
                    minimumQty = [[existingDic valueForKey:ORDERED_QUANTITY] floatValue];
                
                bool isPacked = false;
                
                if(!zeroStockCheckAtOutletLevel ||  (zeroStockCheckAtOutletLevel && ![[itemdic valueForKey:kZeroStock] boolValue])){
                    isToAllowZeroStock = false;
                    float availQty = [[itemdic valueForKey:QUANTITY] floatValue];
                    
                    if ([[itemdic valueForKey:kPackagedType]boolValue]) {
                        
                        minimumQty = minimumQty + 1;
                        isPacked = true;
                    }
                    
                    if ( (minimumQty > availQty) || (minimumQty == availQty  && !isPacked) ){
                        
                        showAlert = true;
                    }
                    else if(!isPacked){
                        
                        availQty = availQty - minimumQty;
                        
                        if(availQty < 1 && availQty > 0)
                            minimumQty = minimumQty + availQty;
                        else
                            minimumQty = minimumQty + 1;
                    }
                }
                else{
                    
                    minimumQty = minimumQty + 1;
                }
                
                
                if(showAlert){
                    
                    SystemSoundID    soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                    
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"out_of_stock", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil];
                    [alert show];
                    return;
                }
                else if(!isNewItem){
                    
                    [existingDic setValue: [NSString stringWithFormat:@"%.2f",minimumQty] forKey:ORDERED_QUANTITY];
                }
                
                
                if (isNewItem) {
                    
                    NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:iTEM_ID];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_NAME];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOUR];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:UOM] defaultReturn:@"--"] forKey:UOM];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_CLASS] defaultReturn:@""] forKey:PRODUCT_CLASS];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SUB_CLASS] defaultReturn:@""] forKey:SUB_CLASS];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:STYLE] defaultReturn:@""] forKey:STYLE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
                    
                    //Setting price as mrp(Max Retail Price).
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:MAX_RETAIL_PRICE];
                    
                    //setting Sale Price...
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
                    
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:Item_Price];
                    
                    //                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ORDERED_QUANTITY];
                    
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f", minimumQty] forKey:ORDERED_QUANTITY];

                    
                    float totalCost = [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:ORDERED_QUANTITY] defaultReturn:@"0.00"] floatValue];
                    
                    //For Getting the Total Cost..
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",totalCost] forKey:ITEM_TOTAL_COST];
                    
                    // For Getting The TaxRate Value...
                    
                    // added by roja on 11-09-2018...
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TAX_CODE] defaultReturn:@""] forKey:TAX_CODE];
                    [itemDetailsDic setValue:@0.0f forKey:TAXX_VALUE];
                    [itemDetailsDic setValue:@0.0f forKey:TAX_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:TAX_VALUE];
                    
                    [itemDetailsDic setValue:[itemdic valueForKey:TAX] forKey:TAX];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemTaxExclusive] defaultReturn:ZERO_CONSTANT] forKey:kItemTaxExclusive];
                    
                    [itemDetailsDic setValue: [self checkGivenValueIsNullOrNil:[itemdic valueForKey:TAXATION_ON_DISCOUNT_PRICE] defaultReturn:ZERO_CONSTANT]  forKey:TAXATION_ON_DISCOUNT_PRICE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kIsManuFacturedItem] defaultReturn:ZERO_CONSTANT] forKey:kIsManuFacturedItem];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kPackagedType] defaultReturn:ZERO_CONSTANT] forKey:kPackagedType];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                    
                    [itemDetailsDic setValue:[NSNumber numberWithBool:isToAllowZeroStock] forKey:ZERO_STOCK_FLAG];
                    
                    [itemDetailsDic setValue:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EDITABLE] defaultReturn:ZERO_CONSTANT] boolValue]] forKey:EDITABLE];
                    
                    
                    [itemDetailsDic setValue:[NSNumber numberWithBool:false] forKey:EDIT_PRICE_FLAG];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:true] forKey:EDIT_TABLE_FLAG];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:false] forKey:VOID_STATUS_FLAG];
                    
                    
                    [itemDetailsDic setValue:@0.0f forKey:ISGST_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:IS_GST_VALUE];
                    [itemDetailsDic setValue:@0.0f forKey:OTHER_TAX_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:OTHER_TAX_VALUE];
                    [itemDetailsDic setValue:@0.0f forKey:DISCOUNT];
                    [itemDetailsDic setValue:@"--" forKey:DISCOUNT_ID];
                    
                    // extra keys
                    [itemDetailsDic setValue:@0.0f forKey:SALE_PRICE_AFTER_DISCOUNT];
                    [itemDetailsDic setValue:@0.0f forKey:ITEM_COST_BEFORE_OTHER_DISCOUNT];
                    
                    [itemDetailsDic setValue:@0.0f forKey:ITEM_SPECIAL_DISCOUNT];
                    [itemDetailsDic setValue:@0.0f forKey:MANUAL_DISCOUNT];
                    
                    [itemDetailsDic setValue:@0.0f forKey:CGST_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:CGST_VALUE];
                    [itemDetailsDic setValue:@0.0f forKey:SGST_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:SGST_VALUE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:HSN_CODE] defaultReturn:@""] forKey:HSN_CODE];
                    
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:QUANTITY] defaultReturn:@"0"] floatValue]] forKey:MAX_QUANTITY];
                    
                    
                    [orderItemListArray addObject:itemDetailsDic];
                }
                else{
                    
                    [orderItemListArray replaceObjectAtIndex:i withObject:existingDic];
                }
            }
            else{
                //pricelist handling has to be done....
                
            }
        }
        
    }
    @catch (NSException * exception) {
        NSLog(@"-------exception will reading.-------%@",exception);
    }
    @finally{
        
        if([[successDictionary allKeys] containsObject:Apply_Campaigns] && ![[successDictionary valueForKey:Apply_Campaigns] isKindOfClass:[NSNull class]]){
            [self getDealsAndOffersSuccessResponse:[successDictionary valueForKey:Apply_Campaigns]];
        }else{
            
            [self calculateTotal];
        }
        [HUD setHidden:YES];
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

- (void)getSkuDetailsErrorResponse:(NSString*)failureString {
    @try {
        
        //added by Srinivasulu on 13/04/2017....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",failureString];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:(mesg.length)*10 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)createOutletOrderSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsText.isEditing)
            y_axis = searchItemsText.frame.origin.y + searchItemsText.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"order_generated_successfully",nil),@"\n", [successDictionary valueForKey:@"orderId"]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil) conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
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
-(void)createOutletOrderErrorResponse:(NSString * )errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    }
    @catch(NSException * exception){
        
    }
    @finally {
        
    }
    
}




#pragma -mark method used for gettting getting customer deatils....

/**
 * @description  here we are accessing service and getting the customer information if exists.....
 * @date
 * @method       getCustomerDetails
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 11/08/2017....
 * @reason      added the comments.... hidding HUD in catch block.... showing the error message....  not completed....
 *
 * @verified By
 * @verified On
 *
 */


// Commented by roja on 17/10/2019.. // reason getCustomerDetails method contains SOAP Service call .. so taken new method with same(getCustomerDetails) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getCustomerDetails {
//
//    @try {
//
//        [HUD show: YES];
//        [HUD setHidden:NO];
//        [HUD setLabelText:NSLocalizedString(@"Fetching Customer details..",nil)];
//
//
//        //checking for deals & offers...
//        CustomerServiceSoapBinding *custBindng =  [CustomerServiceSvc CustomerServiceSoapBinding] ;
//        CustomerServiceSvc_getCustomerDetails *aParameters = [[CustomerServiceSvc_getCustomerDetails alloc] init];
//
//        @try {
//
//            NSError  * err;
//            NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:[RequestHeader getRequestHeader] options:0 error:&err];
//            NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//            NSArray  * loyaltyKeys = @[@"email", @"mobileNumber",@"requestHeader"];
//
//            NSArray  * loyaltyObjects = @[@"",customerMobileNoText.text,requestHeaderString];
//            NSDictionary * dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError  * err_;
//            NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
//            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//            aParameters.phone = loyaltyString;
//
//            CustomerServiceSoapBindingResponse *response = [custBindng getCustomerDetailsUsingParameters:(CustomerServiceSvc_getCustomerDetails *)aParameters];
//
//            NSArray * responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//
//                if ([bodyPart isKindOfClass:[CustomerServiceSvc_getCustomerDetailsResponse class]]) {
//                    CustomerServiceSvc_getCustomerDetailsResponse *body = (CustomerServiceSvc_getCustomerDetailsResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    NSError *e;
//
//                    NSDictionary * JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers
//                                                                             error: &e];
//
//                    if ((customerMobileNoText.text).length >= 10) {
//
//                        customerInfoDic = [JSON1 copy];
//
//                        //Customer Email ID...
//                        customerEmailIdText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_MAIL] defaultReturn:customerEmailIdText.text];
//
//                        //Customer Address
//                        streetText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_STREET] defaultReturn:streetText.text];
//
//                        customerLocationText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_LOCALITY] defaultReturn:customerLocationText.text];
//
//                        customerCityText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_CITY] defaultReturn:customerCityText.text];
//
//                        doorNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:HOUSE_NO] defaultReturn:doorNoText.text];
//
//                        contactNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PHONE] defaultReturn:contactNoText.text];
//
//                        pinNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PIN_NO] defaultReturn:pinNoText.text];
//
//                        //Billing Address
//                        billingStreetText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_STREET]defaultReturn:billingStreetText.text];
//
//                        billingLocationText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_LOCALITY] defaultReturn:billingLocationText.text];
//
//                        billingCityText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_CITY] defaultReturn:billingCityText.text];
//
//                        billingDoorNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:HOUSE_NO] defaultReturn:billingDoorNoText.text];
//
//                        billingContactNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PHONE]defaultReturn:billingContactNoText.text];
//
//                        billingPinNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PIN_NO] defaultReturn:billingPinNoText.text];
//
//                        //Shipment Address
//
//                        shipmentContactNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PHONE] defaultReturn:shipmentContactNoText.text];
//
//                        shipmentDoorNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:HOUSE_NO] defaultReturn:shipmentDoorNoText.text];
//
//                        shipmentStreetNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_STREET]defaultReturn:shipmentStreetNoText.text];
//
//                        shipmentNameText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:kFirstName] defaultReturn:shipmentNameText.text];
//
//                        shipmentLocationText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_LOCALITY] defaultReturn:shipmentLocationText.text];
//
//                        shipmentCityText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_CITY] defaultReturn:shipmentCityText.text];
//
//                        shipmentStateText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:STATE] defaultReturn:shipmentStateText.text];
//
//                        firstNameTF.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:kFirstName] defaultReturn:@""];
//
//                        lastNameTF.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:LAST_NAME] defaultReturn:@""];
//                    }
//
//                    [HUD setHidden:YES];
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            NSLog(@"%@",exception);
//        }
//        @finally {
//            [HUD setHidden:YES];
//        }
//
//
//    } @catch (NSException *exception) {
//
//    } @finally {
//
//    }
//
//}


//getCustomerDetails method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getCustomerDetails {
    
    @try {
        
        [HUD show: YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"Fetching Customer details..",nil)];
        
        //checking for deals & offers...
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:[RequestHeader getRequestHeader] options:0 error:&err];
        NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSArray  * loyaltyKeys = @[@"email", @"mobileNumber",@"requestHeader"];
        NSArray  * loyaltyObjects = @[@"",customerMobileNoText.text,requestHeaderString];
        NSDictionary * dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError  * err_;
        NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController * services = [[WebServiceController alloc] init];
        services.customerServiceDelegate = self;
        [services getCustomerDetails:loyaltyString];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
    }
    
}

// added by Roja on 17/10/2019…. // old code pasted below..
- (void)getCustomerDetailsSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        if ((customerMobileNoText.text).length >= 10) {
            
            customerInfoDic = [sucessDictionary copy];
            
            //Customer Email ID...
            customerEmailIdText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_MAIL] defaultReturn:customerEmailIdText.text];
            
            //Customer Address
            streetText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_STREET] defaultReturn:streetText.text];
            
            customerLocationText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_LOCALITY] defaultReturn:customerLocationText.text];
            
            customerCityText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_CITY] defaultReturn:customerCityText.text];
            
            doorNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:HOUSE_NO] defaultReturn:doorNoText.text];
            
            contactNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PHONE] defaultReturn:contactNoText.text];
            
            pinNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PIN_NO] defaultReturn:pinNoText.text];
            
            //Billing Address
            billingStreetText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_STREET]defaultReturn:billingStreetText.text];
            
            billingLocationText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_LOCALITY] defaultReturn:billingLocationText.text];
            
            billingCityText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_CITY] defaultReturn:billingCityText.text];
            
            billingDoorNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:HOUSE_NO] defaultReturn:billingDoorNoText.text];
            
            billingContactNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PHONE]defaultReturn:billingContactNoText.text];
            
            billingPinNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PIN_NO] defaultReturn:billingPinNoText.text];
            
            //Shipment Address
            
            shipmentContactNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_PHONE] defaultReturn:shipmentContactNoText.text];
            
            shipmentDoorNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:HOUSE_NO] defaultReturn:shipmentDoorNoText.text];
            
            shipmentStreetNoText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_STREET]defaultReturn:shipmentStreetNoText.text];
            
            shipmentNameText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:kFirstName] defaultReturn:shipmentNameText.text];
            
            shipmentLocationText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_LOCALITY] defaultReturn:shipmentLocationText.text];
            
            shipmentCityText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:CUSTOMER_CITY] defaultReturn:shipmentCityText.text];
            
            shipmentStateText.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:STATE] defaultReturn:shipmentStateText.text];
            
            firstNameTF.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:kFirstName] defaultReturn:@""];
            
            lastNameTF.text = [self checkGivenValueIsNullOrNil:[customerInfoDic valueForKey:LAST_NAME] defaultReturn:@""];
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // Old code pasted below
- (void)getCustomerDetailsErrorResponse:(NSString *)errorResponse{
 
    @try {
        
        NSLog(@"errorResponse in NewOrder for getCustomerGetails method : %@", errorResponse);
        
        UIAlertView * alert =  [[UIAlertView alloc] initWithTitle:@"" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }

}

/**
 * @description  displaying popOver for the paymentMode options....
 * @date         26/03/2018
 * @method       showPaymentMode:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showPaymentMode:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        paymentModeArray = [NSMutableArray new];
        
        [paymentModeArray addObject:@"Debit Card"];
        [paymentModeArray addObject:@"Credit Card"];
        [paymentModeArray addObject:@"Net Banking"];
        [paymentModeArray addObject:@"Pay Cash"];
        
        [paymentModeArray addObject:@"POD"]; // added by roja on 16/04/2019...

        float tableHeight = paymentModeArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = paymentModeArray.count * 33;
        
        if(paymentModeArray.count>5)
            tableHeight = (tableHeight/paymentModeArray.count) * 5;
        
        [self showPopUpForTables:paymentModeTable  popUpWidth:(paymentModeText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:paymentModeText  showViewIn:createOrderScrollView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  displaying popOver for the paymentType options....
 * @date         26/03/2018
 * @method       showPaymentType:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)showPaymentType:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        paymentTypeArray = [NSMutableArray new];
        
        [paymentTypeArray addObject:@"On Delivery"];
        [paymentTypeArray addObject:@"Prepaid"];
        
        float tableHeight = paymentTypeArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = paymentTypeArray.count * 33;
        
        if(paymentTypeArray.count>5)
            tableHeight = (tableHeight/paymentTypeArray.count) * 5;
        
        [self showPopUpForTables:paymentTypeTable  popUpWidth:(paymentTypeText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:paymentTypeText  showViewIn:createOrderScrollView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  displaying popOver for the showOrderChannel options....
 * @date         26/03/2018
 * @method       showOrderChannel:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showOrderChannel:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        orderChannelArray = [NSMutableArray new];
        
        [orderChannelArray addObject:@"Online"];
        [orderChannelArray addObject:@"Mobile"];
        [orderChannelArray addObject:@"Telephone"];
        
        float tableHeight = orderChannelArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = orderChannelArray.count * 33;
        
        if(orderChannelArray.count>5)
            tableHeight = (tableHeight/orderChannelArray.count) * 5;
        
        [self showPopUpForTables:orderChannelTable  popUpWidth:(orderChannelText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:orderChannelText  showViewIn:otherDetailsView permittedArrowDirections:UIPopoverArrowDirectionUp ]; //createOrderScrollView
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  displaying popOver for the showShipmentType options....
 * @date         26/03/2018
 * @method       showShipmentType:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return       void
 * @return
 *
 * modified By   Roja on 05-10-2018..
 * Reason On     Allowing the ShipmentType popUp only for "Door Delivery"..
 *
 * @verified By
 * @verified On
 *
 */


-(void)showShipmentType:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if([deliveryTypeText.text isEqualToString:@"Door Delivery"] || [deliveryTypeText.text isEqualToString:@""]){
            
            shipmentTypeArray = [NSMutableArray new];
            
            [shipmentTypeArray addObject:@"Normal"];
            [shipmentTypeArray addObject:@"Express"];
            
            float tableHeight = shipmentTypeArray.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = shipmentTypeArray.count * 33;
            
            if(shipmentTypeArray.count>5)
                tableHeight = (tableHeight/shipmentTypeArray.count) * 5;
            
            [self showPopUpForTables:shipmentTypeTable  popUpWidth:(shipmentTypeText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:shipmentTypeText  showViewIn:otherDetailsView permittedArrowDirections:UIPopoverArrowDirectionUp ]; //createOrderScrollView
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"shipment_type_is_for_door_delivery_orders", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  displaying popOver for the showDeliveryType options....
 * @date         26/03/2018
 * @method       showDeliveryType:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showDeliveryType:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
            deliveryTypeArray = [NSMutableArray new];
            
            [deliveryTypeArray addObject:@"Pick Up"];
            [deliveryTypeArray addObject:@"Door Delivery"];
            
            float tableHeight = deliveryTypeArray.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = deliveryTypeArray.count * 33;
            
            if(deliveryTypeArray.count>5)
                tableHeight = (tableHeight/deliveryTypeArray.count) * 5;
      
            [self showPopUpForTables:deliveryTypeTable  popUpWidth:(deliveryTypeText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:deliveryTypeText  showViewIn:otherDetailsView permittedArrowDirections:UIPopoverArrowDirectionUp ]; // createOrderScrollView
      
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  displaying popOver for the showShipmentMode options....
 * @date         26/03/2018
 * @method       showDeliveryType:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 *
 * modified By   Roja on 05-10-2018..
 * Reason On     Allowing the ShipmentMode popUp only for "Door Delivery"..
 *
 * @verified By
 * @verified On
 *
 */

-(void)showShipmentMode:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if([deliveryTypeText.text isEqualToString:@"Door Delivery"] || [deliveryTypeText.text isEqualToString:@""]){
        
        shipmentModeArray = [NSMutableArray new];
        
        [shipmentModeArray addObject:@"Road"];
        [shipmentModeArray addObject:@"Rail"];
        [shipmentModeArray addObject:@"Courier"];
        [shipmentModeArray addObject:@"Direct Person"];
        
        float tableHeight = shipmentModeArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = shipmentModeArray.count * 33;
        
        if(shipmentModeArray.count>5)
            tableHeight = (tableHeight/shipmentModeArray.count) * 5;
        
            [self showPopUpForTables:shipmentModeTable  popUpWidth:(shipmentModeText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:shipmentModeText  showViewIn:otherDetailsView permittedArrowDirections:UIPopoverArrowDirectionUp ]; // createOrderScrollView
            
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"shipment_mode_is_for_door_delivery_orders", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  displaying popOver for the show delivery Model options....
 * @date         12/04/2019
 * @method       showDeliveryModel:
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @return
 *
 * modified By
 * Reason On
 *
 * @verified By
 * @verified On
 *
 */

-(void)showDeliveryModel:(UIButton *)sender {

    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);

    @try {
            deliveryModelArray = [NSMutableArray new];
            [deliveryModelArray addObject:@"Immediate"];
            [deliveryModelArray addObject:@"Any Time"];
        //        [deliveryModelArray addObject:@"Road"];
        //        [deliveryModelArray addObject:@"Rail"];
        //        [deliveryModelArray addObject:@"Courier"];
        //        [deliveryModelArray addObject:@"Direct Person"];
            float tableHeight = deliveryModelArray.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = deliveryModelArray.count * 33;

            if(deliveryModelArray.count>5)
                tableHeight = (tableHeight/deliveryModelArray.count) * 5;

            [self showPopUpForTables:deliveryModelTable  popUpWidth:(deliveryModelTF.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:deliveryModelTF  showViewIn:createOrderScrollView permittedArrowDirections:UIPopoverArrowDirectionUp];

    } @catch (NSException *exception) {

    }
}



/**
 * @description  here we are showing the all availiable Locations.......
 * @date         27/03/2018
 * @method       showAllLocations(virtualStores)
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showAllLocations:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(virtualStoresArray == nil ||  virtualStoresArray.count == 0){
            
            
            [HUD setHidden:NO];
            
            //changed on 27/03/2018....
            [self callingGetStores];
        }
        [HUD setHidden:YES];
        
        if(virtualStoresArray.count){
            float tableHeight = virtualStoresArray.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = virtualStoresArray.count * 33;
            
            if(virtualStoresArray.count > 5)
                tableHeight = (tableHeight/virtualStoresArray.count) * 5;
            
            
            [self showPopUpForTables:virtualStoreTable  popUpWidth:(locationText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:locationText  showViewIn:createOrderScrollView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the stockReceiptView in showAllZonesId:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
}

/**
 * @description  .......
 * @date         16/04/2019
 * @method       showTimeInPopUp
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)showTimeInPopUp:(UIButton *)sender {
    
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
        pickView.frame = CGRectMake( 15, orderDateText.frame.origin.y + orderDateText.frame.size.height, 320, 320);
        pickView.backgroundColor = [UIColor colorWithRed:(119/255.0) green:(136/255.0) blue:(153/255.0) alpha:0.8f];
        pickView.layer.masksToBounds = YES;
        pickView.layer.cornerRadius = 12.0f;
        
        //pickerframe creation...
        CGRect pickerFrame = CGRectMake(0,50,0,0);
        myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
        myPicker.backgroundColor = [UIColor whiteColor];
        myPicker.datePickerMode = UIDatePickerModeTime;
        
        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(populateTimeToTextField:) forControlEvents:UIControlEventTouchUpInside];
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        customerInfoPopUp.view = customView;
        
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        if(sender.tag == 2)
            [popover presentPopoverFromRect:startTimeTF.frame inView:createOrderScrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        else
            [popover presentPopoverFromRect:endTimeTF.frame inView:createOrderScrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        catPopOver= popover;
        
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
 * @description  clear the Time from textField
 * @date         16/04/2019
 * @method       clearDate:
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)clearTime:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        if(sender.tag == 2){
            if((startTimeTF.text).length)
                startTimeTF.text = @"";
        }
        else{
            if((endTimeTF.text).length)
                endTimeTF.text = @"";
        }
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
    }
}

/**
 * @description
 * @date         16/04/2019
 * @method       populateTimeToTextField:
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)populateTimeToTextField:(UIButton *)sender {

    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        [requiredDateFormat setDateFormat:@"hh:mm a"];
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSString * selectedTimeString = [requiredDateFormat stringFromDate:myPicker.date];
    
        if (sender.tag == 2) {
            startTimeTF.text = selectedTimeString;
        }
        else{
            endTimeTF.text = selectedTimeString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma -mark action used to display calender in popUP....

/**
 * @description  here we are showing the calender in popUp view....
 * @date         26/09/2016
 * @method       showCalenderInPopUp:
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
            
            pickView.frame = CGRectMake( 15, orderDateText.frame.origin.y + orderDateText.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:orderDateText.frame inView:createOrderScrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:deliveryDateText.frame inView:createOrderScrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @date         01/03/2017
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
    
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(sender.tag == 2){
            if((orderDateText.text).length)
                //                callServices = true;
                
                
                deliveryDateText.text = @"";
        }
        else{
            if((deliveryDateText.text).length)
                //                callServices = true;
                
                deliveryDateText.text = @"";
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
        
        NSLog(@"---- exception in newOrderView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}

/**
 * @description  we are populating the Selected Date to current TextField
 * @date         01/03/2017
 * @method       populateDateToTextField
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)populateDateToTextField:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        //[requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        // getting present date & time ..
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        //[f release];
        today = [f dateFromString:currentdate];
        
        NSDate * existingDateString;
        
        if( sender.tag == 2) {
            if ((deliveryDateText.text).length != 0 && (![deliveryDateText.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:deliveryDateText.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"order_date_should_be_earlier_than_delivery_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:370 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    return;
                    
                }
            }
            
            orderDateText.text = dateString;
        }
        else {
            
            if ((orderDateText.text).length != 0 && ( ![orderDateText.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:orderDateText.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivery_date_can't_be_less_than_order_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:370 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            
            deliveryDateText.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma mark textField delegates:


/**
 * @description  it is textfiled delegate method it will executed first.......
 * @date         16/04/2019
 * @method       textFieldShouldBeginEditing:
 * @author       Roja
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
    
    if (textField.frame.origin.x == orderQuantityText.frame.origin.x || textField.frame.origin.x == itemSalePriceTxt.frame.origin.x){
        
        reloadTableData = false;
    }
    if (textField == shippingCostText){
        
    }
    
    if(textField == otherDiscPercentageTxt || textField == otherDiscAmountTxt) {
        
        @try{
            
            if(orderItemListArray.count){
                
                if(isManualDiscounts){
                    
                }
                else{
                    float y_axis = self.view.frame.size.height - 350;
                    
                    NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"sorry", nil),@"\n",NSLocalizedString(@"discount_is_not_applicable", nil)];
                    
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return NO;
                }
            }
            else{
                
                float y_axis = self.view.frame.size.height - 350;
                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_add_items_to_cart", nil)];
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:70  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return NO;
            }
        }
        @catch(NSException *exception){
            
            NSLog(@"Discount exception....%@",exception);
        }
    }
    
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
 * @modified BY  Roja on 18/09/2018
 * @reason       orderQuantityText,itemSalePriceTxt,otherDiscPercentageTxt,otherDiscAmountTxt and shippingCostText added here.
 *
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField*)textField {
    
    @try {
        
        if(textField == searchItemsText){
            
            //            offSetViewTo = 120;
        }
        else if(textField == amountDueText || textField == amountPaidText) {
            
            [textField selectAll:nil];
            [UIMenuController sharedMenuController].menuVisible = NO;
            
            offSetViewTo = 360;
        }
        else if (textField.frame.origin.x == orderQuantityText.frame.origin.x || textField.frame.origin.x == itemSalePriceTxt.frame.origin.x) {
            
            [textField selectAll:nil];
            [UIMenuController sharedMenuController].menuVisible = NO;
            
            int count = (int)textField.tag;
            reloadTableData = true;
            
            if(textField.tag > 4)
                count = 4;
            
            offSetViewTo = (textField.frame.origin.y + textField.frame.size.height) * count + orderItemsTable.frame.origin.y;
        }
        else if(textField == shippingCostText) {
            
            [textField selectAll:nil];
            offSetViewTo = 300;
        }
        
        else if(textField == otherDiscPercentageTxt || textField == otherDiscAmountTxt) {
            
            if(orderItemListArray.count){
                
                [textField selectAll:nil];
                offSetViewTo = 250;
            }
        }
        
        [self keyboardWillShow];
        
    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
 * @date         28/03/2018
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
 * @modified BY  Roja on 18/09/2018
 * @reason       checking item "packed" flag in orderQuantityText field also Added shouldChangeCharactersInRange for
 itemSalePriceTxt, shippingCostText, otherDiscAmountTxt,otherDiscPercentageTxt,customerMobileNoText....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.frame.origin.x == orderQuantityText.frame.origin.x ) {
        
        @try {
            NSDictionary *dic = [orderItemListArray objectAtIndex: textField.tag];
            
            if ([[dic valueForKey:kPackagedType] boolValue] ) {
                
                NSUInteger lengthOfString = string.length;
                
                for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                    unichar character = [string characterAtIndex:loopIndex];
                    if (character < 48) return NO; // 48 unichar for 0
                    if (character > 57) return NO; // 57 unichar for 9
                }
            }
            else{
                
                NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
                NSError  *error = nil;
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
                return numberOfMatches != 0;
            }
            
        } @catch (NSException * exception) {
            
            NSLog(@"-exception in texField:shouldChangeCharactersInRange:replalcement----%@",exception);
            
            return YES;
        }
    }
    
    else if(textField.frame.origin.x == itemSalePriceTxt.frame.origin.x || textField.frame.origin.x == shippingCostText.frame.origin.x || textField == amountDueText){
        
        @try {
            
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString *expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
            return numberOfMatches != 0;
            
        } @catch (NSException *exception) {
            
            NSLog(@"-exception in texField:shouldChangeCharactersInRange:Item SalePrice Text----%@",exception);
            return  YES;
        }
    }
    // added by roja on 03-10-2018..
    else if (textField == otherDiscAmountTxt|| textField == otherDiscPercentageTxt) {
        
        @try {
            
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString *expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
            return numberOfMatches != 0;
            
        } @catch (NSException *exception) {
            
            return  YES;
        }
    }
    
    else if (textField == customerMobileNoText || textField == billingContactNoText || textField == shipmentContactNoText || textField == contactNoText) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        
    }
    else if (textField == pinNoText || textField == billingPinNoText) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
    }
    // upto here added by roja on 03-10-2018..
    
    return  YES;
}

/**
 * @description  ----
 * @date         27/03/2018
 * @method       textFieldDidChange
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 *
 * @modified BY  Roja on 18/09/2018
 * @reason       adding didChange text for itemSalePriceTxt,otherDiscPercentageTxt,otherDiscAmountTxt & amountPaidText.
 *
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == customerMobileNoText) {
        if (textField.text.length == 10) {
            [customerMobileNoText resignFirstResponder];
            [self getCustomerDetails];
        }
    }
    else if (textField == searchItemsText) {
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                productListArray = [[NSMutableArray alloc]init];
                
                [self callRawMaterials:textField.text];
                
                if ((textField.text).length == 0) {
                    productListTable.hidden = YES;
                }
            }
            @catch (NSException *exception) {
                
            }
        }
        else {
            
            [HUD setHidden:YES];
            productListTable.hidden = YES;
        }
    }
    else if(textField.frame.origin.x == orderQuantityText.frame.origin.x || textField.frame.origin.x == itemSalePriceTxt.frame.origin.x) {
        
        reloadTableData = true;
    }
    else if(textField == shippingCostText){
        
    }
    
    else if(textField == otherDiscPercentageTxt){
        
        if (orderItemListArray.count==0) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"please_add_items_to_cart", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
            otherDiscPercentageTxt.text = @"0.00";
            otherDiscAmountTxt.text = @"0.00";
        }
        
        else{
            otherDiscAmountTxt.text = [NSString stringWithFormat:@"%.2f",(totalCostBeforeDisc * otherDiscPercentageTxt.text.floatValue)/100] ;
        }
        
        totalCostText.text = [NSString stringWithFormat:@"%.2f", (totalCostBeforeDisc - otherDiscAmountTxt.text.floatValue)] ;
        amountDueText.text = [NSString stringWithFormat:@"%.2f",totalCostText.text.floatValue];
    }
    else if(textField == otherDiscAmountTxt){
        
        if (orderItemListArray.count==0) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"please_add_items_to_cart", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
            otherDiscPercentageTxt.text = @"0.00";
            otherDiscAmountTxt.text = @"0.00";
        }
        else{
            
            otherDiscPercentageTxt.text = [NSString stringWithFormat:@"%.2f",(otherDiscAmountTxt.text.floatValue * 100)/ totalCostBeforeDisc];
        }
        
        totalCostText.text = [NSString stringWithFormat:@"%.2f", (totalCostBeforeDisc - otherDiscAmountTxt.text.floatValue)] ;
        amountDueText.text = [NSString stringWithFormat:@"%.2f",totalCostText.text.floatValue];
    }
    
    else if(textField == amountPaidText){
        
        if (orderItemListArray.count==0) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"please_add_items_to_cart", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
            amountPaidText.text = @"0.00";
        }
        else if( (amountPaidText.text.floatValue > totalCostText.text.floatValue) ){
            
            amountPaidText.text = @"0.0";
            amountDueText.text = totalCostText.text;
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"alert", nil) message:NSLocalizedString(@"paid_amount_exceeding_the_total_cost", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
//    if(textField == customerEmailIdText){
//        
//        [customerEmailIdText resignFirstResponder];
//    }
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
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @modified BY  Roja on 18/09/2018
 * @reason       zeroQty check for orderQuantityText and adding didEndEditing for shippingCostText,amountPaidText,otherDiscAmountTxt
                ,otherDiscPercentageTxt,streetText...
 *
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    
    offSetViewTo = 0;
    
    if(textField.frame.origin.x == orderQuantityText.frame.origin.x && textField.frame.origin.y == orderQuantityText.frame.origin.y) {
        
        Boolean isValidQty = true;
        
        @try{
            NSMutableDictionary * locDic = [orderItemListArray[textField.tag] mutableCopy];
            
            float presentQty  = (textField.text).floatValue;
            
            if ( ![[locDic valueForKey:ZERO_STOCK_FLAG] boolValue]) {
                
                if ( presentQty > [[locDic valueForKey:MAX_QUANTITY] floatValue] ) {
                    
                    isValidQty = false;
                    
                    float y_axis = self.view.frame.size.height - 450;
                    NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"ordering_quantity_should_not_exceed_the_available_quantity", nil)];
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:45  isSoundRequired:YES timming:2.0 noOfLines:2];
                }
                if(presentQty == 0) {
                    
                    isValidQty = false;
                    
                    float y_axis = self.view.frame.size.height - 450;
                    NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"minimum_quantity_required_to_make_an_order", nil)];
                    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:45  isSoundRequired:YES timming:2.0 noOfLines:2];
                }
            }
            
            if(isValidQty){
                
                amountPaidText.text = @"0.0";
                amountDueText.text = totalCostText.text;
                [locDic setValue:textField.text  forKey:ORDERED_QUANTITY];
                
                orderItemListArray[textField.tag] = locDic;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"---------%@",exception);
        }
        @finally {
            
            [self calculateTotal];
            if(reloadTableData && isValidQty && isToCallApplyCampaigns){
                [self callDealsAndOffersForItem];
            }
        }
    }
    // added by roja on 18/09/2018..
    else if(textField.frame.origin.x == itemSalePriceTxt.frame.origin.x) {
        
        @try
        {
            NSMutableDictionary * locDic = [orderItemListArray[textField.tag]  mutableCopy];
            
            [locDic setValue: (textField.text) forKey:SALE_PRICE];
            orderItemListArray[textField.tag] = locDic;
            
        }
        @catch(NSException *exception){
            NSLog(@"---------%@",exception);
        }
        @finally{
            
            amountPaidText.text = @"0.0";
            amountDueText.text = totalCostText.text;
            
            [self calculateTotal];
            if(reloadTableData && isToCallApplyCampaigns){
                [self callDealsAndOffersForItem];
            }
        }
    }
    
    else if(textField == otherDiscPercentageTxt) {
        
        if (otherDiscPercentageTxt.text.floatValue > 100) {
            
            float y_axis = self.view.frame.size.height - 450;
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_valid_input", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:45  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            otherDiscPercentageTxt.text = [NSString stringWithFormat:@"%.2f",otherDiscPercentageValue];
            otherDiscAmountTxt.text = [NSString stringWithFormat:@"%.2f",(totalCostBeforeDisc * otherDiscPercentageValue)/100];
        }
        else{
            
            otherDiscAmountTxt.text = [NSString stringWithFormat:@"%.2f",(totalCostBeforeDisc * otherDiscPercentageTxt.text.floatValue)/100] ;
            otherDiscPercentageValue = otherDiscPercentageTxt.text.floatValue;
            
            amountPaidText.text = @"0.0";
            amountDueText.text = totalCostText.text;
        }
        
        [self callDealsAndOffersForItem];
    }
    
    else if(textField == otherDiscAmountTxt) {
        
        if (otherDiscAmountTxt.text.floatValue > totalCostBeforeDisc ){
            
            float y_axis = self.view.frame.size.height - 450;
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"discount_amount_exceeding_the_total_amount", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:45  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            otherDiscPercentageTxt.text = [NSString stringWithFormat:@"%.2f",otherDiscPercentageValue];
            otherDiscAmountTxt.text = [NSString stringWithFormat:@"%.2f",( totalCostBeforeDisc * otherDiscPercentageValue)/100];
        }
        else{
            
            otherDiscPercentageTxt.text = [NSString stringWithFormat:@"%f",(otherDiscAmountTxt.text.floatValue * 100)/ totalCostBeforeDisc];
            otherDiscPercentageValue = otherDiscPercentageTxt.text.floatValue;
            
            amountPaidText.text = @"0.0";
            amountDueText.text = totalCostText.text;
        }
        
        [self callDealsAndOffersForItem];
    }
    
    
    else if(textField == amountPaidText) {
        
        float paidAmount = 0;
        paidAmount = (amountPaidText.text).floatValue;
        
        [self calculateTotal];
    }
    
    else if(textField == shippingCostText){
        
        if (orderItemListArray.count==0) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"please_add_items_to_cart", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
            shippingCostText.text = @"0.00";
        }
        else
            
            amountPaidText.text = @"0.0";
        amountDueText.text = totalCostText.text;
        [self calculateTotal];
    }
    
    else if(textField == streetText){
        
        if(billingStreetText.text.length == 0){
            
            billingStreetText.text = streetText.text;
        }
        if(shipmentStreetNoText.text.length == 0){
            
            shipmentStreetNoText.text = streetText.text;
        }
    }
    else if(textField == customerLocationText){
        
        if(billingLocationText.text.length == 0){
            
            billingLocationText.text = customerLocationText.text;
        }
        if(shipmentLocationText.text.length == 0){
            
            shipmentLocationText.text = customerLocationText.text;
        }
    }
    else if(textField == customerCityText){
        
        if(billingCityText.text.length == 0){
            
            billingCityText.text = customerCityText.text;
        }
        if(shipmentCityText.text.length == 0){
            
            shipmentCityText.text = customerCityText.text;
        }
    }
    else if(textField == doorNoText){
        
        if(billingDoorNoText.text.length == 0){
            
            billingDoorNoText.text = doorNoText.text;
        }
        if(shipmentDoorNoText.text.length == 0){
            
            shipmentDoorNoText.text = doorNoText.text;
        }
    }
    else if(textField == contactNoText){
        
        if(billingContactNoText.text.length == 0){
            
            billingContactNoText.text = contactNoText.text;
        }
        if(shipmentContactNoText.text.length == 0){
            
            shipmentContactNoText.text = contactNoText.text;
        }
    }
    else if(textField == googleMapLinkText){
        
        if(billingGoogleMapLinkText.text.length == 0){
            
            billingGoogleMapLinkText.text = googleMapLinkText.text;
        }
    }
    else if(textField == pinNoText){
        
        if(billingPinNoText.text.length == 0){
            
            billingPinNoText.text = pinNoText.text;
        }
    }
    // upto here added by roja on 18/09/2018..
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

#pragma mark Tableview Delegates....

/**
 * @description  ----------
 * @date         20/03/2018
 * @method       numberOfRowsInSection
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @verified By
 * @verified On
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView ==  productListTable) {
        
        return productListArray.count;
    }
    
    else if(tableView == orderItemsTable){
        
        @try {
            
            return orderItemListArray.count;
        }
        @catch(NSException * exception){
            
        }
    }
    
    else if(tableView == paymentModeTable) {
        
        return paymentModeArray.count;
    }
    else if(tableView == paymentTypeTable) {
        
        return paymentTypeArray.count;
    }
    else if(tableView == virtualStoreTable) {
        
        return virtualStoresArray.count;
    }
    else if(tableView == orderChannelTable) {
        
        return orderChannelArray.count;
    }
    else if(tableView == shipmentTypeTable) {
        
        return shipmentTypeArray.count;
    }
    else if(tableView == deliveryTypeTable) {
        
        return deliveryTypeArray.count;
    }
    else if(tableView == shipmentModeTable) {
        
        return shipmentModeArray.count;
    }
    else if(tableView == deliveryModelTable){

        return deliveryModelArray.count;
    }
    
    return 0;
}


/**
 * @description  ----------
 * @date         21/03/2018
 * @method       heightForRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if(tableView == orderItemsTable){
            
            return  38;
        }
        else if (tableView == productListTable||tableView == paymentModeTable || tableView == paymentTypeTable || tableView == virtualStoreTable || tableView == orderChannelTable || tableView == shipmentTypeTable || tableView == deliveryTypeTable || tableView == shipmentModeTable || deliveryModelTable) {
            
            return 35;
        }
    }
    
    else {
        // Set cell Height for the iPhone And other compatable Devices....
    }
    return 30;
}



/**
 * @description  description
 * @date         date
 * @method       name
 * @author       Bhargav.v
 * @param
 * @param
 * @return       UITableViewCell
 *
 * @modified BY  Roja on 18-09-2018..
 * @Reason       Adding some extra fields in orderItemTable and assiging values to them.
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == productListTable) {
        //changed by Srinivasulu on 12/10/2017....
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
            
            
            if (productListArray.count > indexPath.row){
                NSDictionary * dic = productListArray[indexPath.row];
                
                
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
                itemMeasurementLbl.frame = CGRectMake( itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width, 0, searchItemsText.frame.size.width - (itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width), itemDescLbl.frame.size.height);
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
    
    else if(tableView == orderItemsTable) {
        
        static NSString * cellIdentifier = @"orderSummaryCell";
        
        UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ((hlcell.contentView).subviews){
            
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        tableView.separatorColor = [UIColor clearColor];
        
        CAGradientLayer *layer_1;
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            @try {
                layer_1 = [CAGradientLayer layer];
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_1.frame = CGRectMake( snoLabel.frame.origin.x, hlcell.frame.size.height - 2, orderItemsTable.contentSize.width - snoLabel.frame.origin.x , 1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException *exception) {
                
            }
        }
        
        @try {
            
            UILabel * itemSnoLabel;
            UILabel * item_idLabel;
            UILabel * item_nameLabel;
            UILabel * itemMakeLabel;
            UILabel * itemModelLabel;
            UILabel * itemColorLabel;
            UILabel * itemSizeLabel;
            UILabel * itemMrpLabel;
            UILabel * itemTaxRateLabel;
            UILabel * itemTaxLabel;
            // added by roja on 10-09-2018...
            UILabel * itemDiscountLabel;
            UILabel * itemPromoIdLabel;
            UILabel * uomValueLbl;
            UILabel * itemOfferValueLbl;
            // upto here added by roja on 10-09-2018...
            
            itemSnoLabel = [[UILabel alloc] init];
            itemSnoLabel.backgroundColor = [UIColor clearColor];
            itemSnoLabel.layer.borderWidth = 0;
            itemSnoLabel.textAlignment = NSTextAlignmentCenter;
            itemSnoLabel.numberOfLines = 1;
            itemSnoLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_idLabel = [[UILabel alloc] init];
            item_idLabel.backgroundColor = [UIColor clearColor];
            item_idLabel.layer.borderWidth = 0;
            item_idLabel.textAlignment = NSTextAlignmentCenter;
            item_idLabel.numberOfLines = 1;
            item_idLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_nameLabel = [[UILabel alloc] init];
            item_nameLabel.backgroundColor = [UIColor clearColor];
            item_nameLabel.layer.borderWidth = 0;
            item_nameLabel.textAlignment = NSTextAlignmentCenter;
            item_nameLabel.numberOfLines = 1;
            item_nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
            item_nameLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            
            itemMakeLabel = [[UILabel alloc] init];
            itemMakeLabel.backgroundColor = [UIColor clearColor];
            itemMakeLabel.layer.borderWidth = 0;
            itemMakeLabel.textAlignment = NSTextAlignmentCenter;
            itemMakeLabel.numberOfLines = 1;
            itemMakeLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemModelLabel = [[UILabel alloc] init];
            itemModelLabel.backgroundColor = [UIColor clearColor];
            itemModelLabel.layer.borderWidth = 0;
            itemModelLabel.textAlignment = NSTextAlignmentCenter;
            itemModelLabel.numberOfLines = 1;
            itemModelLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemColorLabel = [[UILabel alloc] init];
            itemColorLabel.backgroundColor = [UIColor clearColor];
            itemColorLabel.layer.borderWidth = 0;
            itemColorLabel.textAlignment = NSTextAlignmentCenter;
            itemColorLabel.numberOfLines = 1;
            itemColorLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemSizeLabel = [[UILabel alloc] init];
            itemSizeLabel.backgroundColor = [UIColor clearColor];
            itemSizeLabel.layer.borderWidth = 0;
            itemSizeLabel.textAlignment = NSTextAlignmentCenter;
            itemSizeLabel.numberOfLines = 1;
            itemSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemMrpLabel = [[UILabel alloc] init];
            itemMrpLabel.backgroundColor = [UIColor clearColor];
            itemMrpLabel.layer.borderWidth = 0;
            itemMrpLabel.textAlignment = NSTextAlignmentCenter;
            itemMrpLabel.numberOfLines = 1;
            itemMrpLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            orderQuantityText = [[UITextField alloc] init];
            orderQuantityText.clearButtonMode = UITextFieldViewModeWhileEditing;
            orderQuantityText.autocorrectionType = UITextAutocorrectionTypeNo;
            orderQuantityText.borderStyle = UITextBorderStyleRoundedRect;
            orderQuantityText.keyboardType = UIKeyboardTypeNumberPad;
            orderQuantityText.backgroundColor = [UIColor clearColor];
            orderQuantityText.textAlignment = NSTextAlignmentCenter;
            orderQuantityText.textColor = [UIColor blackColor];
            orderQuantityText.returnKeyType = UIReturnKeyDone;
            orderQuantityText.userInteractionEnabled = YES;
            orderQuantityText.layer.borderWidth = 2;
            orderQuantityText.tag = indexPath.row;
            orderQuantityText.delegate = self;
            [orderQuantityText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            
            itemSalePriceTxt = [[UITextField alloc] init];
            itemSalePriceTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            itemSalePriceTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            itemSalePriceTxt.borderStyle = UITextBorderStyleRoundedRect;
            itemSalePriceTxt.keyboardType = UIKeyboardTypeNumberPad;
            itemSalePriceTxt.backgroundColor = [UIColor clearColor];
            itemSalePriceTxt.textAlignment = NSTextAlignmentCenter;
            itemSalePriceTxt.textColor = [UIColor blackColor];
            itemSalePriceTxt.returnKeyType = UIReturnKeyDone;
            itemSalePriceTxt.layer.borderWidth = 2;
            itemSalePriceTxt.tag = indexPath.row;
            itemSalePriceTxt.delegate = self;
            [itemSalePriceTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            itemCostLabel = [[UILabel alloc] init];
            itemCostLabel.backgroundColor = [UIColor clearColor];
            itemCostLabel.layer.borderWidth = 0;
            itemCostLabel.textAlignment = NSTextAlignmentCenter;
            itemCostLabel.numberOfLines = 1;
            itemCostLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemTaxRateLabel = [[UILabel alloc] init];
            itemTaxRateLabel.backgroundColor = [UIColor clearColor];
            itemTaxRateLabel.layer.borderWidth = 0;
            itemTaxRateLabel.textAlignment = NSTextAlignmentCenter;
            itemTaxRateLabel.numberOfLines = 1;
            itemTaxRateLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemTaxLabel = [[UILabel alloc] init];
            itemTaxLabel.backgroundColor = [UIColor clearColor];
            itemTaxLabel.layer.borderWidth = 0;
            itemTaxLabel.textAlignment = NSTextAlignmentCenter;
            itemTaxLabel.numberOfLines = 1;
            itemTaxLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            // added by roja on 10-09-2018...
            itemDiscountLabel = [[UILabel alloc] init];
            itemDiscountLabel.backgroundColor = [UIColor clearColor];
            itemDiscountLabel.layer.borderWidth = 0;
            itemDiscountLabel.textAlignment = NSTextAlignmentCenter;
            itemDiscountLabel.numberOfLines = 1;
            itemDiscountLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemPromoIdLabel = [[UILabel alloc] init];
            itemPromoIdLabel.backgroundColor = [UIColor clearColor];
            itemPromoIdLabel.layer.borderWidth = 0;
            itemPromoIdLabel.textAlignment = NSTextAlignmentCenter;
            itemPromoIdLabel.numberOfLines = 1;
            itemPromoIdLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            uomValueLbl = [[UILabel alloc] init];
            uomValueLbl.backgroundColor = [UIColor clearColor];
            uomValueLbl.layer.borderWidth = 0;
            uomValueLbl.textAlignment = NSTextAlignmentCenter;
            uomValueLbl.numberOfLines = 1;
            uomValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemOfferValueLbl = [[UILabel alloc] init];
            itemOfferValueLbl.backgroundColor = [UIColor clearColor];
            itemOfferValueLbl.layer.borderWidth = 0;
            itemOfferValueLbl.textAlignment = NSTextAlignmentCenter;
            itemOfferValueLbl.numberOfLines = 1;
            itemOfferValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            // upto here added by roja on 10-09-2018...
            
            UIButton * deleteRowButton;
            deleteRowButton = [[UIButton alloc] init];
            [deleteRowButton setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [deleteRowButton addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            deleteRowButton.tag = indexPath.row;
            deleteRowButton.backgroundColor = [UIColor clearColor];
            
            
            itemSnoLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_idLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemMakeLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemModelLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemColorLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemSizeLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemMrpLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            orderQuantityText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemCostLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemTaxRateLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemTaxLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemSalePriceTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            // added by roja on 10-09-2018...
            itemPromoIdLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemDiscountLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            uomValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemOfferValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            // upto here added by roja on 10-09-2018...
            
            orderQuantityText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
//            itemSalePriceTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            [hlcell.contentView addSubview:itemSnoLabel];
            [hlcell.contentView addSubview:item_idLabel];
            [hlcell.contentView addSubview:item_nameLabel];
            [hlcell.contentView addSubview:itemMakeLabel];
            [hlcell.contentView addSubview:itemModelLabel];
            [hlcell.contentView addSubview:itemColorLabel];
            [hlcell.contentView addSubview:itemSizeLabel];
            [hlcell.contentView addSubview:itemMrpLabel];
            [hlcell.contentView addSubview:orderQuantityText];
            [hlcell.contentView addSubview:itemSalePriceTxt];
            [hlcell.contentView addSubview:itemCostLabel];
            [hlcell.contentView addSubview:itemTaxRateLabel];
            [hlcell.contentView addSubview:itemTaxLabel];
            // added by roja on 10-09-2018...
            [hlcell.contentView addSubview:itemPromoIdLabel];
            [hlcell.contentView addSubview:itemDiscountLabel];
            [hlcell.contentView addSubview:uomValueLbl];
            [hlcell.contentView addSubview:itemOfferValueLbl];
            // upto here added by roja on 10-09-2018...
            
            [hlcell.contentView addSubview:deleteRowButton];
            
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                //changed by Srinivasulu on 14/04/2017.....
                
                itemSnoLabel.frame = CGRectMake(snoLabel.frame.origin.x, 0, snoLabel.frame.size.width, hlcell.frame.size.height);
                
                item_idLabel.frame = CGRectMake(itemIdLabel.frame.origin.x, 0, itemIdLabel.frame.size.width, hlcell.frame.size.height);
                
                item_nameLabel.frame = CGRectMake(itemNameLabel.frame.origin.x, 0, itemNameLabel.frame.size.width, hlcell.frame.size.height);
                
                itemMakeLabel.frame = CGRectMake(makeLabel.frame.origin.x, 0, makeLabel.frame.size.width, hlcell.frame.size.height);
                
                itemModelLabel.frame = CGRectMake(modelLabel.frame.origin.x, 0, modelLabel.frame.size.width, hlcell.frame.size.height);
                
                itemColorLabel.frame = CGRectMake(colorLabel.frame.origin.x, 0, colorLabel.frame.size.width, hlcell.frame.size.height);
                
                itemSizeLabel.frame = CGRectMake(sizeLabel.frame.origin.x, 0, sizeLabel.frame.size.width, hlcell.frame.size.height);
                
                itemMrpLabel.frame = CGRectMake(mrpLabel.frame.origin.x, 0, mrpLabel.frame.size.width, hlcell.frame.size.height);
                
                orderQuantityText.frame = CGRectMake(quantityLabel.frame.origin.x, 2, quantityLabel.frame.size.width, 36);
                
                itemSalePriceTxt.frame = CGRectMake(salePriceLabel.frame.origin.x, 2, salePriceLabel.frame.size.width, 36);
                
                itemCostLabel.frame = CGRectMake(costLabel.frame.origin.x, 0, costLabel.frame.size.width, hlcell.frame.size.height);
                
                itemTaxRateLabel.frame = CGRectMake(taxRateLabel.frame.origin.x, 0, taxRateLabel.frame.size.width, hlcell.frame.size.height);
                
                itemTaxLabel.frame = CGRectMake(taxLabel.frame.origin.x, 0, taxLabel.frame.size.width, hlcell.frame.size.height);
                
                // added by roja on 10-09-2018...
                itemPromoIdLabel.frame = CGRectMake(promoIdLbl.frame.origin.x, 0, promoIdLbl.frame.size.width, hlcell.frame.size.height);
                
                itemDiscountLabel.frame = CGRectMake(discountLbl.frame.origin.x, 0, discountLbl.frame.size.width, hlcell.frame.size.height);
                
                uomValueLbl.frame = CGRectMake(uomLbl.frame.origin.x, 0, uomLbl.frame.size.width, hlcell.frame.size.height);
                
                itemOfferValueLbl.frame = CGRectMake(offerLbl.frame.origin.x, 0, offerLbl.frame.size.width, hlcell.frame.size.height);
                
                // upto here added by roja on 10-09-2018...
                
                deleteRowButton.frame= CGRectMake(actionLabel.frame.origin.x + 15,5,35,35);
                //setting font size....
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView: hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            }
            
            NSDictionary * localDictionary = orderItemListArray[indexPath.row];
            
            itemSnoLabel.text   = [NSString stringWithFormat:@"%li",(indexPath.row + 1)];
            
            item_idLabel.text   = [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:iTEM_ID] defaultReturn:@"--"];//ITEM_SKU
            
            item_nameLabel.text =  [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:ITEM_NAME] defaultReturn:@"--"];
            
            if ([[localDictionary valueForKey:MAKE]isKindOfClass:[NSNull class]]|| (![[localDictionary valueForKey:MAKE]isEqualToString:@""])) {
                
                itemMakeLabel.text  =  [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:MAKE] defaultReturn:@"--"];
            }
            else
                
                itemMakeLabel.text = @"--";
            
            if ([[localDictionary valueForKey:MODEL]isKindOfClass:[NSNull class]]|| (![[localDictionary valueForKey:MODEL]isEqualToString:@""])) {
                
                itemModelLabel.text  =  [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:MODEL] defaultReturn:@"--"];
            }
            else
                itemModelLabel.text = @"--";
            
            if ([[localDictionary valueForKey:COLOR]isKindOfClass:[NSNull class]]|| (![[localDictionary valueForKey:COLOR]isEqualToString:@""])) {
                
                itemColorLabel.text =  [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:COLOR] defaultReturn:@"--"];
            }
            else
                itemColorLabel.text = @"--";
            
            if ([[localDictionary valueForKey:SIZE]isKindOfClass:[NSNull class]]|| (![[localDictionary valueForKey:SIZE]isEqualToString:@""])) {
                
                itemSizeLabel.text =  [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:SIZE] defaultReturn:@"--"];
            }
            else
                itemSizeLabel.text = @"--";
            
            itemMrpLabel.text       =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:MAX_RETAIL_PRICE] defaultReturn:@"0.0"] floatValue]];
            
            itemSalePriceTxt.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:SALE_PRICE_AFTER_DISCOUNT] defaultReturn:@"0.0"] floatValue]];
            
            orderQuantityText.text  =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:ORDERED_QUANTITY] defaultReturn:@"0.0"] floatValue]];
            
            itemTaxRateLabel.text   =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:TAX_RATE] defaultReturn:@"0.0"] floatValue]];
            
            itemTaxLabel.text       =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:TAX_VALUE] defaultReturn:@"0.0"] floatValue]];
            
            itemCostLabel.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:ITEM_TOTAL_COST] defaultReturn:@"0.0"] floatValue] ];
            
            // added by roja on 10-09-2018 && 18-09-2018..
            itemPromoIdLabel.text = @"--";
            itemOfferValueLbl.text = @"0.0";
            
            if(dealOffersDic != nil){

                if ( ![ [dealOffersDic valueForKey:APPLIED_DEAL_ID_LIST] [indexPath.row] isEqualToString:@"" ] ||  [[dealOffersDic valueForKey:DEAL_DISCOUNT][indexPath.row] floatValue] > 0)  {

                    itemPromoIdLabel.text = [NSString stringWithFormat:@"%@", [self checkGivenValueIsNullOrNil:[dealOffersDic valueForKey:APPLIED_DEAL_ID_LIST] [indexPath.row] defaultReturn:@"--"]];
                                             
                    itemOfferValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dealOffersDic valueForKey:DEAL_DISCOUNT] [indexPath.row] defaultReturn:@"0.00"] floatValue]];
                    }

                if ( ![ [dealOffersDic valueForKey:DISCOUNT_ID_ARRAY_LIST] [indexPath.row] isEqualToString:@"" ] || [[dealOffersDic valueForKey:mPRODUCT_OFFER_PRICE][indexPath.row] floatValue] > 0){

                    itemPromoIdLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[dealOffersDic valueForKey:DISCOUNT_ID_ARRAY_LIST] [indexPath.row] defaultReturn:@"--"]];
                                             
                    itemOfferValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dealOffersDic valueForKey:mPRODUCT_OFFER_PRICE] [indexPath.row] defaultReturn:@"0.00"] floatValue]];
                }
        }
            
            bool status = false;
            
            if(dealOffersDic != nil){
                
                if( ![([dealOffersDic valueForKey:APPLIED_DEAL_ID_LIST] [indexPath.row]) isEqualToString:@""]  || ![([dealOffersDic valueForKey:DISCOUNT_ID_ARRAY_LIST] [indexPath.row]) isEqualToString:@"" ] || [[dealOffersDic valueForKey:DEAL_DISCOUNT][indexPath.row] floatValue] > 0 || [[dealOffersDic valueForKey:mPRODUCT_OFFER_PRICE][indexPath.row] floatValue] > 0) {
                
                    status = TRUE;
                }
            }
            
            if (status) {
                item_nameLabel.textColor = [UIColor greenColor];
                CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
                basic.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.08, 1.08, 1.08)];
                [basic setAutoreverses:YES];
                [basic setRepeatCount:MAXFLOAT];
                basic.duration = 0.35;
                [item_nameLabel.layer addAnimation:basic forKey:@"transform"];
            }
            
            if(allowItemPriceEdit && [[localDictionary valueForKey:EDITABLE] boolValue]){
                
                itemSalePriceTxt.userInteractionEnabled = NO; // YES
            }
            else{
                
                itemSalePriceTxt.userInteractionEnabled = NO;
            }
            
            uomValueLbl.text = [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:UOM] defaultReturn:@"--"];
            
            itemDiscountLabel.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:ITEM_SPECIAL_DISCOUNT] defaultReturn:@"0.0"] floatValue] ];
            
            // upto here added by roja on 10-09-2018 && 18-09-2018...
        }
        @catch(NSException * exception) {
            
        }
        @finally {
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
        
    }
    
    else if(tableView == paymentModeTable)  {
        
        static NSString * CellIdentifier = @"paymentTypeCell";
        
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
            
            hlcell.textLabel.text = paymentModeArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if(tableView == paymentTypeTable){
        
        static NSString * CellIdentifier = @"paymentTypeCell";
        
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
            
            hlcell.textLabel.text = paymentTypeArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if(tableView == virtualStoreTable)  {
        
        static NSString * CellIdentifier = @"virtualStoreCell";
        
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
            
            hlcell.textLabel.text = virtualStoresArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    else if(tableView == orderChannelTable)  {
        
        static NSString * CellIdentifier = @"orderChannelCell";
        
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
            
            hlcell.textLabel.text = orderChannelArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if(tableView == shipmentTypeTable)  {
        
        static NSString * CellIdentifier = @"shipmentTypeCell";
        
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
            
            hlcell.textLabel.text = shipmentTypeArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if(tableView == deliveryTypeTable)  {
        
        static NSString * CellIdentifier = @"deliveryTypeCell";
        
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
            
            hlcell.textLabel.text = deliveryTypeArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if(tableView == shipmentModeTable)  {
        
        static NSString * CellIdentifier = @"deliveryTypeCell";
        
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
            
            hlcell.textLabel.text = shipmentModeArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    else if(tableView == deliveryModelTable)  {

        static NSString * CellIdentifier = @"deliveryTypeCell";

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

            hlcell.textLabel.text = deliveryModelArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {

        }
        return hlcell;
    }
    return 0;
}


/**
 * @description  TableViewDelegate method executes. When a cell is selected in Table..
 * @date         21/03/2018
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return       void\
 *
 * @modified By  Roja
 * @reason       changes done for deliveryTypeTable bcoz for "pickUp" delivery.No need of shipmentTypeText and shipmentModeText
 *
 * @verified By
 * @verified On
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //dismissing the catPopOver....
    [catPopOver dismissPopoverAnimated:YES];
    
    @try {
        
        if (tableView == paymentModeTable) {
            
            paymentModeText.text = paymentModeArray[indexPath.row];
        }
        else if (tableView == paymentTypeTable) {
            
            paymentTypeText.text = paymentTypeArray[indexPath.row];
        }
        else if (tableView == virtualStoreTable) {
            
            locationText.text = virtualStoresArray[indexPath.row];
        }
        
        else if (tableView == orderChannelTable) {
            
            orderChannelText.text = orderChannelArray[indexPath.row];
        }
        else if (tableView == shipmentTypeTable) {
            
            shipmentTypeText.text = shipmentTypeArray[indexPath.row];
        }
        else if (tableView == deliveryTypeTable) {
            
            deliveryTypeText.text = deliveryTypeArray[indexPath.row];
            
            if([deliveryTypeText.text isEqualToString:@"Pick Up"]){
                
                shipmentTypeText.text = @"";
                shipmentModeText.text = @"";
            }
        }
        else if (tableView == shipmentModeTable) {
            
            shipmentModeText.text = shipmentModeArray[indexPath.row];
        }
        else if (tableView == deliveryModelTable) {

            deliveryModelTF.text = deliveryModelArray[indexPath.row];
        }
        
        else if (tableView == productListTable) {
            
            @try {
                
                NSDictionary * detailsDic = productListArray[indexPath.row];
                
                NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[@"skuID"]];
                
                if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
                    
                    inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
                }
                
                [self callRawMaterialDetails:inputServiceStr];
                
                searchItemsText.text = @"";
                [searchItemsText resignFirstResponder];
                productListTable.hidden = YES;
                
            }
            @catch(NSException * exception) {
                
            }
            
        }
    }
    @catch(NSException * exception){
        
    }
}


/**
 * @description  here we are calculating the Totalprice for items in the cart..........
 * @date         12-09-2018...
 *
 * @method       calculateTotal
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)calculateTotal {
    
    float totalCost      = 0;
    float subTotalAmount = 0;
    float amountDue      = 0;
    float amountPaid     = 0;
    float totItemDiscountVal = 0;
    float subTotBeforeDiscount = 0;
    float netValue = 0;

    totalCostBeforeDisc = 0;
    
    @try {
        
        amountPaid = (amountPaidText.text).floatValue;
        
        float calculatedTaxValue = 0;
        
        for(int i=0; i< [orderItemListArray count]; i++) {
            
            NSMutableDictionary *orderItemListDic = [[orderItemListArray objectAtIndex:i] mutableCopy];
            
            float dealOfferAmount = 0;
            float rangeCheckPrice = 0;
            float itemDiscValue  = 0;
            
            
            NSString * discountTypeStr = @"";
            NSString * discountIdStr = @"";
            // dealOfferAmount is the offer amount,we get it from applyCampaign service call...
            if (dealOffersDic != nil) {
                
                if ([[[dealOffersDic valueForKey:DEAL_DISCOUNT] objectAtIndex:i] floatValue] > 0) {
                    
                    dealOfferAmount = [[[dealOffersDic valueForKey:DEAL_DISCOUNT] objectAtIndex:i]floatValue];
                    discountTypeStr = NSLocalizedString(@"deal", nil);
                    discountIdStr =[[dealOffersDic valueForKey:APPLIED_DEAL_ID_LIST] objectAtIndex:i];
                    
//                    if(![[[dealOffersDic valueForKey:GROUP_TURN_OVER_OFFER] objectAtIndex:i] isEqualToString:@""])
//                        discountIdStr = [[[dealOffersDic valueForKey:GROUP_TURN_OVER_OFFER] objectAtIndex:i] componentsSeparatedByString:@"="][0];
                }
                
                if([[[dealOffersDic valueForKey:mPRODUCT_OFFER_PRICE] objectAtIndex:i] floatValue] > 0){
                    
                    dealOfferAmount += [[[dealOffersDic valueForKey:mPRODUCT_OFFER_PRICE] objectAtIndex:i]floatValue];
                    discountTypeStr = NSLocalizedString(@"offer", nil);
                    discountIdStr =[[dealOffersDic valueForKey:DISCOUNT_ID_ARRAY_LIST] objectAtIndex:i];
                }
            }
            
            //itemDiscValue it is other discount amount calculated based on present entered percentage value...
            if (otherDiscPercentageValue > 0){
                
//                itemDiscValue = (([[orderItemListDic valueForKey:SALE_PRICE]floatValue] * otherDiscPercentageValue)/100);
                
                itemDiscValue = (((([[orderItemListDic valueForKey:SALE_PRICE]floatValue] * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue]) - dealOfferAmount) * otherDiscPercentageValue)/100);

            }
            // ITEM_SPECIAL_DISCOUNT is used for item level other discounts...
//            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",itemDiscValue * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue] ] forKey:ITEM_SPECIAL_DISCOUNT];
            
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",itemDiscValue] forKey:ITEM_SPECIAL_DISCOUNT];
            
            totItemDiscountVal += [[orderItemListDic valueForKey:ITEM_SPECIAL_DISCOUNT]floatValue];
            
            rangeCheckPrice = [[orderItemListDic valueForKey:SALE_PRICE] floatValue];
            
            float itemTotalPrice =  [[orderItemListDic valueForKey:SALE_PRICE] floatValue] * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue] - (dealOfferAmount + [[orderItemListDic valueForKey:ITEM_SPECIAL_DISCOUNT] floatValue]);
            
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",(itemTotalPrice / [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue])] forKey:SALE_PRICE_AFTER_DISCOUNT];
            
            if ([[orderItemListDic valueForKey:TAXATION_ON_DISCOUNT_PRICE]boolValue]) {
                
                rangeCheckPrice = [[orderItemListDic valueForKey:SALE_PRICE_AFTER_DISCOUNT] floatValue];
            }
            
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:ITEM_TOTAL_COST];
            
            bool isInclusiveType = ![[orderItemListDic valueForKey:kItemTaxExclusive] boolValue];
            
            if((discCalcOn.length > 0 && [discCalcOn caseInsensitiveCompare:ORIGINAL_PRICE] == NSOrderedSame)){
                
                itemTotalPrice = ( [[orderItemListDic valueForKey:SALE_PRICE] floatValue] * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue] );
            }
            else if(dealOfferAmount > 0){ //dealOffer Amt is checking and then inclusive/Exclusive is taking from  outlet level..
                if (discTaxation.length > 0 && [discTaxation caseInsensitiveCompare:INCLUSIVE] == NSOrderedSame)
                    isInclusiveType = true;
                else if (discTaxation.length > 0 && [discTaxation caseInsensitiveCompare:EXCLUSIVE] == NSOrderedSame)
                    isInclusiveType = false;
            }
            
            if(otherDiscPercentageValue < 100){
                
                [self calculateItemTax:orderItemListDic totalPrice:itemTotalPrice rangeCheckAmount:rangeCheckPrice taxType:isInclusiveType];
            }
            
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",( [[orderItemListDic valueForKey:SALE_PRICE] floatValue] * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue] ) ] forKey:ITEM_COST_BEFORE_OTHER_DISCOUNT];

            subTotBeforeDiscount += ([[orderItemListDic valueForKey:ITEM_COST_BEFORE_OTHER_DISCOUNT] floatValue] - [[orderItemListDic valueForKey:TAX_VALUE] floatValue] - dealOfferAmount);
            
            subTotalAmount += ([[orderItemListDic valueForKey:ITEM_TOTAL_COST] floatValue] - [[orderItemListDic valueForKey:TAX_VALUE] floatValue]);
            
            calculatedTaxValue += [[orderItemListDic valueForKey:TAX_VALUE]floatValue];
            
            [orderItemListDic setValue:discountTypeStr forKey:DISCOUNT_TYPE];
            [orderItemListDic setValue:discountIdStr forKey:DISCOUNT_ID];
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f", dealOfferAmount] forKey:DISCOUNT_PRICE];
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f", dealOfferAmount] forKey:DISCOUNT];
            [orderItemListDic setValue:[orderItemListDic valueForKey:ITEM_SPECIAL_DISCOUNT] forKey:MANUAL_DISCOUNT];
            [orderItemListArray replaceObjectAtIndex:i withObject:orderItemListDic];
        }
        
        totalCostBeforeDisc = ( subTotBeforeDiscount + calculatedTaxValue +(shippingCostText.text).floatValue );
        
        totalCost = ( subTotalAmount + calculatedTaxValue +(shippingCostText.text).floatValue );
        netValue = (totalCost - totItemDiscountVal);
        amountDue = (netValue - amountPaid); //(totalCost - amountPaid)
        
        subTotalText.text = [NSString stringWithFormat:@"%.2f",subTotalAmount];
        totalCostText.text = [NSString stringWithFormat:@"%.2f",totalCost];
        amountDueText.text = [NSString stringWithFormat:@"%.2f",amountDue];
        totalTaxTxt.text = [NSString stringWithFormat:@"%.2f",calculatedTaxValue];
        netValueTF.text =  [NSString stringWithFormat:@"%.2f", netValue];

    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
        if(otherDiscPercentageValue > 0){
            
            otherDiscAmountTxt.text = [NSString stringWithFormat:@"%.2f", totItemDiscountVal];
            otherDiscPercentageTxt.text = [NSString stringWithFormat:@"%.2f", otherDiscPercentageValue];
            
            otherDiscountText.text =  [NSString stringWithFormat:@"%.2f", totItemDiscountVal];
        }
        
        if(reloadTableData)
            [orderItemsTable reloadData];
        
        if(subTotalText.text.floatValue < 0){
            subTotalText.text = @"0.00";
        }
        if(totalCostText.text.floatValue < 0){
            totalCostText.text = @"0.00";
        }
        if(amountDueText.text.floatValue < 0){
            amountDueText.text = @"0.00";
        }
        if(netValueTF.text.floatValue < 0){
            netValueTF.text = @"0.00";
        }
    }
}


/**
 * @description  here we are calculating the tax
 * @date         11/09/2018
 * @method       calculateItemTax:-- totalPrice:-- rangeCheckAmount:-- taxType:--
 * @author       Roja
 * @param        NSMutableDictionary
 * @param        float
 * @param        float
 * @param        Boolean
 *
 * @return       void
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)calculateItemTax:(NSMutableDictionary *)itemDetailsDic totalPrice:(float)itemTotalCost rangeCheckAmount:(float)rangeCheckPrice taxType:(Boolean)isTaxInclusive {
    
    float totalTaxRateValue = 0;
    float taxValue = 0;
    NSString *taxCodeStr = @"";
    NSMutableArray * taxDispalyArr;
    taxDispalyArr = [[NSMutableArray alloc]init];
    
    @try{
        
        for (NSDictionary * taxdic in [itemDetailsDic valueForKey:TAX]) {
            
            float specifiedTaxValue = 0;
            float taxRateValue = [[taxdic valueForKey:TAX_RATE]floatValue];
            
            taxCodeStr = [taxdic valueForKey: TAX_CODE];
            
            for (NSDictionary * saleRangeListDic in [taxdic valueForKey:SALE_RANGES_LIST]) {
                
                if ( ([[saleRangeListDic valueForKey:SALE_VALUE_FROM]floatValue] <= rangeCheckPrice) && (rangeCheckPrice <= [[saleRangeListDic valueForKey:SALE_VALUE_TO]floatValue]) ) {
                    
                    taxRateValue = [[saleRangeListDic valueForKey:TAX_RATE] floatValue];
                    break;
                }
            }
            
            if ([[taxdic valueForKey:TAX_TYPE] caseInsensitiveCompare:Percentage] == NSOrderedSame) {
                
                if (isTaxInclusive) {
                    
                    specifiedTaxValue = ( itemTotalCost - (itemTotalCost / (100 + taxRateValue * 2) * 100 ) ) / 2;
                }
                else{
                    
                    specifiedTaxValue = (itemTotalCost * taxRateValue)/100;
                    
                    float itemTotalPrice = [[itemDetailsDic valueForKey:ITEM_TOTAL_COST] floatValue];
                    itemTotalPrice+= ((itemTotalCost * taxRateValue)/100);
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:ITEM_TOTAL_COST];
                }
            }
            else{
                
                specifiedTaxValue = (taxRateValue * [[itemDetailsDic valueForKey:ORDERED_QUANTITY]floatValue]);
            }
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",specifiedTaxValue] forKey:taxCodeStr];
            taxValue += specifiedTaxValue;
            totalTaxRateValue += taxRateValue;
        }
        
        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",totalTaxRateValue] forKey:TAX_RATE];
        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",taxValue] forKey:TAX_VALUE];
        
    }
    @catch(NSException * exception){
        NSLog(@"%@",exception.name);
    }
    
    @finally{
        
    }
    
}


/**
 * @description  This method is used to call apply campaigns...
 * @date         17/09/2018
 * @method       callDealsAndOffersForItem
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 */

-(void)callDealsAndOffersForItem {
    
    @try {
        
        if(isToCallApplyCampaigns){
            
            [HUD setHidden:NO];
            
            NSMutableArray *skuIdList = [[NSMutableArray alloc]init];
            NSMutableArray *pluCodeList = [[NSMutableArray alloc]init];
            NSMutableArray *unitPriceList = [[NSMutableArray alloc]init];
            NSMutableArray *qtyList = [[NSMutableArray alloc]init];
            NSMutableArray *totalPriceList = [[NSMutableArray alloc]init];
            NSMutableArray *itemStatusList = [NSMutableArray new];
            NSMutableArray *itemDiscountList = [NSMutableArray new];
            
            for (int i = 0; i < orderItemListArray.count; i++) {
                
                NSDictionary * detailsDic = [orderItemListArray objectAtIndex:i];
                [skuIdList addObject:[detailsDic valueForKey:ITEM_SKU]];
                [pluCodeList addObject:[detailsDic valueForKey:PLU_CODE]];
                [unitPriceList addObject:[NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:Item_Price]floatValue]] ];
                [qtyList addObject: [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:ORDERED_QUANTITY]floatValue] ] ];
                [totalPriceList addObject: [NSString stringWithFormat:@"%.2f", [[detailsDic valueForKey:Item_Price] floatValue] * [[detailsDic valueForKey:ORDERED_QUANTITY]floatValue]] ];
                
                [itemStatusList addObject:@""];
                [itemDiscountList addObject:@"0.00"];
            }
            
            NSString *quantity = @"1";
            
            NSArray *loyaltyKeys = @[STORELOCATION, REQUEST_HEADER, SKU_ID_ARR_LIST, PLU_CODE_ARR_LIST, UNIT_PRICE_ARR_LIST, QTY_ARR_LIST, TOTAL_PRICE_ARR_LIST, ITME_STATUS_ARR_LIST, PRODUCT_OPTIONAL_DISCOUNT_ARR, TOTAL_BILL_AMOUNT, QUANTITY, PHONE_NUMBER, PURCHASE_CHANNEL, EMPLOYEE_CODE, LATEST_CAMPAIGNS];
            
            NSString *empCodeStr = @"";
            
            NSArray *loyaltyObjects = @[presentLocation,[RequestHeader getRequestHeader],skuIdList,pluCodeList,unitPriceList,qtyList,totalPriceList,itemStatusList, itemDiscountList, totalCostText.text,quantity,customerMobileNoText.text,POS,empCodeStr,@(applyLatestCampaigns)];
            
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController *serviceController = [WebServiceController new];
            serviceController.getDealsAndOffersDelegate = self;
            [serviceController getDealsAndOffersWithData:loyaltyString];
        }
        else{
            [self calculateTotal];
        }
    }
    @catch (NSException *exception) {
        [self calculateTotal];
        [HUD setHidden:YES];
    }
}



/**
 * @description  Here we are handling the success response received from service....
 * @date         17/09/2018
 * @method       getDealsAndOffersSuccessResponse
 * @author       Roja
 * @param        NSDictionary
 * @param
 * @return       void
 * @verified By
 * @verified On
 */

- (void)getDealsAndOffersSuccessResponse:(NSDictionary *)successDictionary {
    
    @try{
        
        dealOffersDic = [[NSMutableDictionary alloc]init];
        
        [dealOffersDic setValue:[successDictionary valueForKey:APPLIED_DEAL_ID_LIST] forKey:APPLIED_DEAL_ID_LIST];
        [dealOffersDic setValue:[successDictionary valueForKey:DEAL_DISCOUNT] forKey:DEAL_DISCOUNT];
        [dealOffersDic setValue:[successDictionary valueForKey:DISCOUNT_ID_ARRAY_LIST] forKey:DISCOUNT_ID_ARRAY_LIST];
        [dealOffersDic setValue:[successDictionary valueForKey:mPRODUCT_OFFER_PRICE] forKey:mPRODUCT_OFFER_PRICE];
        [dealOffersDic setValue:[successDictionary valueForKey:TURN_OVER_OFFER_DISCOUNT] forKey:TURN_OVER_OFFER_DISCOUNT];
        [dealOffersDic setValue:[successDictionary valueForKey:GROUP_TURN_OVER_OFFER] forKey:GROUP_TURN_OVER_OFFER];

        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception.name);
    }
    @finally {
        
        [self calculateTotal];
        [HUD setHidden:YES];
    }
}

/**
 * @description  Here we are handling the error response received from service....
 * @date         17/09/2018
 * @method       getDealsAndOffersErrorResponse
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 */

- (void)getDealsAndOffersErrorResponse {
    
    [self calculateTotal];
    [HUD setHidden:YES];
    
}

/**
 * @description  Deleting the item from the cart based on the index position..
 * @date         22/12/2017
 * @method       delRow
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @modified BY  Roja on 18-09-2018
 * @Reason
 * @return
 * @verified By
 * @verified On
 */

- (void)delRow:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(orderItemListArray.count >= sender.tag) {
            
            [orderItemListArray removeObjectAtIndex:sender.tag];
        }
        if(orderItemListArray.count == 0){
            
            otherDiscPercentageValue = 0;
            otherDiscPercentageTxt.text = @"0.00";
            otherDiscAmountTxt.text = @"0.00";
        }
    } @catch (NSException * exception) {
        
    } @finally {
        amountPaidText.text = @"0.0";
        shippingCostText.text = @"0.0";
        
        [self  callDealsAndOffersForItem];
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
            
            [popover presentPopoverFromRect:textView.frame inView:view permittedArrowDirections:arrowDirections animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            //customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines {
    
    
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
            
            if(searchItemsText.isEditing)
                yPosition = searchItemsText.frame.origin.y + searchItemsText.frame.size.height;
            
            
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
 * @date         18/11/2016
 * @method       removeAlertMessages
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)removeAlertMessages{
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



#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         21/03/2018..
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav.v
 * @param        NSString
 * @param        id
 * @return       id
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


#pragma -mark used to move the slef.view when keyBoard apperace

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
        NSLog(@"----exception while changing frame self.view-----%@",exception);
    } @finally {
        
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


/**
 * @description  here we are validating the Email-Id.......
 * @date         03/10/2018
 * @method       validateEmail:--- emailID:---
 * @author       Roja
 * @param        NSString
 * @param
 * @param
 * @return       BOOL
 * @return
 * @verified By
 * @verified On
 *
 */

- (BOOL) validateEmail: (NSString *) emailID {
    NSString *regex1 = @"\\A[a-z0-9]+([-._][a-z0-9]+)*@([a-z0-9]+(-[a-z0-9]+)*\\.)+[a-z]{2,4}\\z";
    NSString *regex2 = @"^(?=.{1,64}@.{4,64}$)(?=.{6,100}$).*";
    NSPredicate *test1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
    NSPredicate *test2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [test1 evaluateWithObject:emailID] && [test2 evaluateWithObject:emailID];
}

@end
