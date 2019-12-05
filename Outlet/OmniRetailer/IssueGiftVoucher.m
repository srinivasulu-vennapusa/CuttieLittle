//
//  IssueLowyalty.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 1/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "IssueGiftVoucher.h"
//#import "SDZLoyaltycardService.h"
#import "LoyaltycardServiceSvc.h"
//#import "GiftVoucherServices.h" // commented by roja
#import "DataBaseConnection.h"
#import "sqlite3.h"
#import "NKDUPCEBarcode.h"
#import "NKDBarcodeFramework.h"
//#import <MailCore/MailCore.h>
#import "ShowLowyalty.h"
#import "Global.h"
#import "RequestHeader.h"
#import "OmniHomePage.h"
#import "CustomerServiceSvc.h"
#import "BillingHome.h"

@implementation IssueGiftVoucher

static sqlite3 *database = nil;
static sqlite3_stmt *selectStmt = nil;


@synthesize aTimer,loadingLabel,spinner;
@synthesize bgimage;
@synthesize soundFileURLRef,soundFileObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) goHomePage {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //[self.navigationController popViewControllerAnimated:YES];
    [UIView  transitionWithView:self.navigationController.view duration:0.8  options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^(void) {
                         BOOL oldState = [UIView areAnimationsEnabled];
                         [UIView setAnimationsEnabled:NO];
                         [self.navigationController popViewControllerAnimated:YES];
                         [UIView setAnimationsEnabled:oldState];
                     }
                     completion:nil];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       viewDidLoad
 * @author
 * @param
 * @param
 * @return       void
 *
 * @modified BY  Roja on 06/03/2019....
 * @reason       As per latest GUI added some more fields and set there frames....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {

    [super viewDidLoad];
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    self.titleLabel.text = @"Issue Gift Voucher";
    
    //main view bakgroung setting...
//    self.view.backgroundColor = [UIColor colorWithRed:99.0/255.0 green:132.0/255.0 blue:14.0/255.0 alpha:1.0];

    
//    self.view.backgroundColor = [UIColor darkGrayColor];

    self.view.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
    scrollView.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];


    // BackGround color on top of the view ..
    //UILabel *topbar = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 31)] autorelease];
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plain-background-home-send-ecard-leatherholes-color-border-font-2210890" ofType:@"jpg"];
    //UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images2.jpg"]];
    //    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    //
    //    // label header on top of the view...
    //    UILabel *label = [[UILabel alloc] init] ;
    //    label.text = @"Issue Loyalty";
    //    label.font = [UIFont boldSystemFontOfSize:17];
    //    label.textColor = [UIColor whiteColor];
    //    label.textColor = [UIColor whiteColor];
    //    label.textAlignment = NSTextAlignmentLeft;
    //    label.backgroundColor = [UIColor clearColor];
    //
    //    // login button on top of the view...
    //    UIButton *backbutton = [[UIButton alloc] init] ;
    //    [backbutton addTarget:self action:@selector(goHomePage) forControlEvents:UIControlEventTouchUpInside];
    //    backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    //    UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
    //    [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
    
    //    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    //    backImage.image = [UIImage imageNamed:@"omni_home_bg.png"];
    //    [self.view addSubview:backImage];
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    //scrollView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = FALSE;
    
    // allocation of selected gift voucher arrary
    selectGiftVoucherArr = [[NSMutableArray alloc]init];

    
    
    UIImageView *userImage=[[UIImageView alloc] init]; // Set frame as per space required around icon
    userImage.image = [UIImage imageNamed:@"user.png"];
    //
    //    [userImage setContentMode:UIViewContentModeCenter];// Set content mode centre
    
    usernametxt = [[CustomTextField alloc] init];
    usernametxt.borderStyle = UITextBorderStyleRoundedRect;
    usernametxt.textColor = [UIColor blackColor];
    usernametxt.font = [UIFont systemFontOfSize:17.0];
    usernametxt.placeholder = @"     Customer Name";  //place holder
    usernametxt.backgroundColor = [UIColor whiteColor];
    usernametxt.autocorrectionType = UITextAutocorrectionTypeNo;
    usernametxt.backgroundColor = [UIColor whiteColor];
    usernametxt.keyboardType = UIKeyboardTypeDefault;
    usernametxt.returnKeyType = UIReturnKeyDone;
    usernametxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernametxt.delegate = self;
    // usernametxt.leftView = userImage;
    usernametxt.leftViewMode = UITextFieldViewModeAlways;
    [usernametxt awakeFromNib];
    
    UIImageView *phoneImage=[[UIImageView alloc] init]; // Set frame as per space required around icon
    phoneImage.image = [UIImage imageNamed:@"phone.png"];
    //
    //    [phoneImage setContentMode:UIViewContentModeCenter];// Set content mode centre
    
    phNotxt = [[CustomTextField alloc] init];
    phNotxt.borderStyle = UITextBorderStyleRoundedRect;
    phNotxt.textColor = [UIColor blackColor];
    phNotxt.font = [UIFont systemFontOfSize:17.0];
    phNotxt.placeholder = @"Mobile Number";    //place holder
    phNotxt.backgroundColor = [UIColor whiteColor];
    phNotxt.autocorrectionType = UITextAutocorrectionTypeNo;
    phNotxt.backgroundColor = [UIColor whiteColor];
    //    phNotxt.keyboardType = UIKeyboardTypeDefault;
    phNotxt.returnKeyType = UIReturnKeyDone;
    phNotxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    // phNotxt.leftView = phoneImage;
    phNotxt.leftViewMode = UITextFieldViewModeAlways;
    [phNotxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar1 sizeToFit];
    phNotxt.inputAccessoryView = numberToolbar1;
    phNotxt.keyboardType = UIKeyboardTypeNumberPad;
    phNotxt.delegate = self;
//    [phNotxt awakeFromNib];
    
    
    UIImageView *mailImage=[[UIImageView alloc] init]; // Set frame as per space required around icon
    mailImage.image = [UIImage imageNamed:@"mail.png"];
    //
    //    [mailImage setContentMode:UIViewContentModeCenter];// Set content mode centre
    
    emiltxt = [[CustomTextField alloc] init];
    emiltxt.borderStyle = UITextBorderStyleRoundedRect;
    emiltxt.textColor = [UIColor blackColor];
    emiltxt.font = [UIFont systemFontOfSize:17.0];
    emiltxt.placeholder = @"Email ID";  //place holder
    emiltxt.backgroundColor = [UIColor whiteColor];
    emiltxt.autocorrectionType = UITextAutocorrectionTypeNo;
    emiltxt.backgroundColor = [UIColor whiteColor];
    emiltxt.keyboardType = UIKeyboardTypeDefault;
    emiltxt.returnKeyType = UIReturnKeyDone;
    emiltxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    emiltxt.delegate = self;
    //emiltxt.leftView = mailImage;
    emiltxt.leftViewMode = UITextFieldViewModeAlways;
//    [emiltxt awakeFromNib];
    
    UIImageView *id_Type=[[UIImageView alloc] init]; // Set frame as per space required around icon
    id_Type.image = [UIImage imageNamed:@"Id_type.png"];
    
    idTypetxt = [[CustomTextField alloc] init];
    idTypetxt.borderStyle = UITextBorderStyleRoundedRect;
    idTypetxt.textColor = [UIColor blackColor];
    idTypetxt.font = [UIFont systemFontOfSize:17.0];
    idTypetxt.placeholder = @"Select Value";  //@"Select Voucher Value"
    idTypetxt.backgroundColor = [UIColor whiteColor];
    idTypetxt.autocorrectionType = UITextAutocorrectionTypeNo;
    idTypetxt.backgroundColor = [UIColor whiteColor];
    idTypetxt.keyboardType = UIKeyboardTypeDefault;
    idTypetxt.returnKeyType = UIReturnKeyDone;
    idTypetxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    idTypetxt.userInteractionEnabled = NO;
    idTypetxt.delegate = self;
    [idTypetxt awakeFromNib];
    
    UIButton *selectGiftVocherBtn = [[UIButton alloc] init] ;
    UIImage *buttonImageDD1 = [UIImage imageNamed:@"down_gray_arrow.png"]; //combo.png
    [selectGiftVocherBtn setBackgroundImage:buttonImageDD1 forState:UIControlStateNormal];
    [selectGiftVocherBtn addTarget:self
               action:@selector(giftVoucherDetailsPopOver:) forControlEvents:UIControlEventTouchUpInside];
    selectGiftVocherBtn.backgroundColor = [UIColor clearColor];
    
    
    
    UIImageView *id_No=[[UIImageView alloc] init]; // Set frame as per space required around icon
    id_No.image = [UIImage imageNamed:@"Id_type.png"];
    
    idNotxt = [[CustomTextField alloc] init];
    idNotxt.borderStyle = UITextBorderStyleRoundedRect;
    idNotxt.textColor = [UIColor blackColor];
    idNotxt.font = [UIFont systemFontOfSize:17.0];
    idNotxt.placeholder = @"Id Number";  //place holder
    idNotxt.backgroundColor = [UIColor whiteColor];
    idNotxt.autocorrectionType = UITextAutocorrectionTypeNo;
    idNotxt.backgroundColor = [UIColor whiteColor];
    idNotxt.keyboardType = UIKeyboardTypeDefault;
    idNotxt.returnKeyType = UIReturnKeyDone;
    idNotxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    idNotxt.delegate = self;
    [idNotxt awakeFromNib];
    
    UIImageView *loyalcard=[[UIImageView alloc] init]; // Set frame as per space required around icon
    loyalcard.image = [UIImage imageNamed:@"Credit_card.png"];
    
    
    loyaltyTypetxt = [[CustomTextField alloc] init];
    loyaltyTypetxt.borderStyle = UITextBorderStyleRoundedRect;
    loyaltyTypetxt.textColor = [UIColor blackColor];
    loyaltyTypetxt.font = [UIFont systemFontOfSize:17.0];
    loyaltyTypetxt.placeholder = @"No.Of Vouchers";  //place holder
    loyaltyTypetxt.backgroundColor = [UIColor whiteColor];
    loyaltyTypetxt.autocorrectionType = UITextAutocorrectionTypeNo;
    loyaltyTypetxt.backgroundColor = [UIColor whiteColor];
    loyaltyTypetxt.keyboardType = UIKeyboardTypeDefault;
    loyaltyTypetxt.returnKeyType = UIReturnKeyDone;
    loyaltyTypetxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    loyaltyTypetxt.userInteractionEnabled = NO;
    loyaltyTypetxt.delegate = self;
    [loyaltyTypetxt awakeFromNib];
    
    //    UIButton *selectVoucherValueBtn = [[UIButton alloc] init] ;
    //    [selectVoucherValueBtn setImage:[UIImage imageNamed:@"combo.png"] forState:UIControlStateNormal];
    //    selectVoucherValueBtn.backgroundColor = [UIColor clearColor];
    //    [selectVoucherValueBtn addTarget:self action:@selector(giftVoucherValuePopUp:) forControlEvents:UIControlEventTouchDown];
    
    selectVoucherValueBtn = [[UIButton alloc] init] ;
    UIImage *buttonImageDD = [UIImage imageNamed:@"down_gray_arrow.png"]; //
    [selectVoucherValueBtn setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectVoucherValueBtn addTarget:self
                        action:@selector(giftVoucherValuePopUp:) forControlEvents:UIControlEventTouchDown];
    selectVoucherValueBtn.backgroundColor = [UIColor clearColor];
    selectVoucherValueBtn.tag = 1;
    
    selectVoucherValueBtn.userInteractionEnabled = NO;
    
    submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    (submitBtn.titleLabel).font = [UIFont boldSystemFontOfSize:22.0];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 10.0f;
//    submitBtn.layer.borderWidth = 1.0f;
//    submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [submitBtn addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
  
    cancelButton = [[UIButton alloc] init];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 10.0f;
    cancelButton.layer.masksToBounds = YES;
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    (cancelButton.titleLabel).font = [UIFont boldSystemFontOfSize:22.0];

    
    addGVButton = [[UIButton alloc] init] ;
    [addGVButton setTitle:@"ADD" forState:UIControlStateNormal];
    addGVButton.backgroundColor = [UIColor grayColor];
    addGVButton.layer.masksToBounds = YES;
    addGVButton.layer.cornerRadius = 5.0f;// 10.0f
    (addGVButton.titleLabel).font = [UIFont boldSystemFontOfSize:22.0];
//    [addGVButton addTarget:self action:@selector(addGVButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [addGVButton addTarget:self action:@selector(addGiftVoucherDetailsBtn:) forControlEvents:UIControlEventTouchUpInside];


    // NSMutableArray initialization.....
    idslist = [[NSMutableArray alloc] init];
    
    // NSMutableArray initialization.....
    loyalTypeList = [[NSMutableArray alloc] init];
    //    [loyalTypeList addObject:@"Platinum"];
    //    [loyalTypeList addObject:@"Diamond"];
    //    [loyalTypeList addObject:@"Gold"];
    //    [loyalTypeList addObject:@"Silver"];
    //    [loyalTypeList addObject:@"Bronze"];
    
    //selection Country for giftVoucherDetailsTable creation...
    giftVoucherDetailsTable = [[UITableView alloc] init];
    giftVoucherDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
    giftVoucherDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
    giftVoucherDetailsTable.layer.cornerRadius = 4.0f;
    giftVoucherDetailsTable.layer.borderWidth = 1.0f;
    giftVoucherDetailsTable.dataSource = self;
    giftVoucherDetailsTable.delegate = self;
    
    selectGiftVoucherTable = [[UITableView alloc] init];
    selectGiftVoucherTable.backgroundColor = [UIColor clearColor];
//    selectGiftVoucherTable.layer.borderColor = [UIColor blackColor].CGColor;
//    selectGiftVoucherTable.layer.cornerRadius = 4.0f;
//    selectGiftVoucherTable.layer.borderWidth = 1.0f;
    selectGiftVoucherTable.dataSource = self;
    selectGiftVoucherTable.delegate = self;
    selectGiftVoucherTable.hidden = YES;

    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet ;
    
       //selected lowaltytype table creation....
//    loyaltyTypeTable = [[UITableView alloc] init];
//    loyaltyTypeTable.backgroundColor = [UIColor whiteColor];
//    loyaltyTypeTable.layer.borderColor = [UIColor blackColor].CGColor;
//    loyaltyTypeTable.layer.cornerRadius = 4.0f;
//    loyaltyTypeTable.layer.borderWidth = 1.0f;
//    loyaltyTypeTable.dataSource = self;
//    loyaltyTypeTable.delegate = self;
    
    // added by roja on 06/03/2019...
    giftVoucherCodeDetailsTable = [[UITableView alloc] init];
    giftVoucherCodeDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
    giftVoucherCodeDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
    giftVoucherCodeDetailsTable.layer.cornerRadius = 4.0f;
    giftVoucherCodeDetailsTable.layer.borderWidth = 1.0f;
    giftVoucherCodeDetailsTable.dataSource = self;
    giftVoucherCodeDetailsTable.delegate = self;
    
    UILabel * currentSchemeLbl;
    currentSchemeLbl = [[UILabel alloc] init];
    currentSchemeLbl.text = @"Current Schemes";
    currentSchemeLbl.font = [UIFont boldSystemFontOfSize:17];
    currentSchemeLbl.textColor = [UIColor whiteColor];
    currentSchemeLbl.textAlignment = NSTextAlignmentLeft;
    currentSchemeLbl.backgroundColor = [UIColor clearColor];
    
    UILabel * voucherValueLbl;
    voucherValueLbl = [[UILabel alloc] init];
    voucherValueLbl.text = @"Voucher Value";
    voucherValueLbl.font = [UIFont boldSystemFontOfSize:17];
    voucherValueLbl.textColor = [UIColor whiteColor];
    voucherValueLbl.textAlignment = NSTextAlignmentLeft;
    voucherValueLbl.backgroundColor = [UIColor clearColor];
    
    
    UILabel * voucherCodeLbl;
    voucherCodeLbl = [[UILabel alloc] init];
    voucherCodeLbl.text = @"Voucher Code";
    voucherCodeLbl.font = [UIFont boldSystemFontOfSize:17];
    voucherCodeLbl.textColor = [UIColor whiteColor];
    voucherCodeLbl.textAlignment = NSTextAlignmentLeft;
    voucherCodeLbl.backgroundColor = [UIColor clearColor];
    
    
    customerIdTF = [[UITextField alloc]init];
    customerIdTF.borderStyle = UITextBorderStyleRoundedRect;
    customerIdTF.textColor = [UIColor blackColor];
    customerIdTF.font = [UIFont systemFontOfSize:17.0];
    customerIdTF.placeholder = @"Customer Id";
    customerIdTF.backgroundColor = [UIColor whiteColor];
    customerIdTF.autocorrectionType = UITextAutocorrectionTypeNo;
    customerIdTF.keyboardType = UIKeyboardTypeDefault;
    customerIdTF.returnKeyType = UIReturnKeyDone;
    customerIdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerIdTF.userInteractionEnabled = YES;
    customerIdTF.delegate = self;
    
    firstNameTF = [[UITextField alloc]init];
    firstNameTF.borderStyle = UITextBorderStyleRoundedRect;
    firstNameTF.textColor = [UIColor blackColor];
    firstNameTF.font = [UIFont systemFontOfSize:17.0];
    firstNameTF.placeholder = @"First Name";
    firstNameTF.backgroundColor = [UIColor whiteColor];
    firstNameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    firstNameTF.keyboardType = UIKeyboardTypeDefault;
    firstNameTF.returnKeyType = UIReturnKeyDone;
    firstNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstNameTF.userInteractionEnabled = YES;
    firstNameTF.delegate = self;
    
    lastNameTF = [[UITextField alloc]init];
    lastNameTF.borderStyle = UITextBorderStyleRoundedRect;
    lastNameTF.textColor = [UIColor blackColor];
    lastNameTF.font = [UIFont systemFontOfSize:17.0];
    lastNameTF.placeholder = @"Last Name";
    lastNameTF.backgroundColor = [UIColor whiteColor];
    lastNameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    lastNameTF.keyboardType = UIKeyboardTypeDefault;
    lastNameTF.returnKeyType = UIReturnKeyDone;
    lastNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastNameTF.userInteractionEnabled = YES;
    lastNameTF.delegate = self;
    
    
    localityTF = [[UITextField alloc]init];
    localityTF.borderStyle = UITextBorderStyleRoundedRect;
    localityTF.textColor = [UIColor blackColor];
    localityTF.font = [UIFont systemFontOfSize:17.0];
    localityTF.placeholder = @"Locality";
    localityTF.backgroundColor = [UIColor whiteColor];
    localityTF.autocorrectionType = UITextAutocorrectionTypeNo;
    localityTF.keyboardType = UIKeyboardTypeDefault;
    localityTF.returnKeyType = UIReturnKeyDone;
    localityTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    localityTF.userInteractionEnabled = YES;
    localityTF.delegate = self;
    
    customerAddressTF = [[UITextField alloc]init];
    customerAddressTF.borderStyle = UITextBorderStyleRoundedRect;
    customerAddressTF.textColor = [UIColor blackColor];
    customerAddressTF.font = [UIFont systemFontOfSize:17.0];
    customerAddressTF.placeholder = @"Address";
    customerAddressTF.backgroundColor = [UIColor whiteColor];
    customerAddressTF.autocorrectionType = UITextAutocorrectionTypeNo;
    customerAddressTF.keyboardType = UIKeyboardTypeDefault;
    customerAddressTF.returnKeyType = UIReturnKeyDone;
    customerAddressTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerAddressTF.userInteractionEnabled = YES;
    customerAddressTF.delegate = self;
    
    customerCityTF = [[UITextField alloc]init];
    customerCityTF.borderStyle = UITextBorderStyleRoundedRect;
    customerCityTF.textColor = [UIColor blackColor];
    customerCityTF.font = [UIFont systemFontOfSize:17.0];
    customerCityTF.placeholder = @"City";
    customerCityTF.backgroundColor = [UIColor whiteColor];
    customerCityTF.autocorrectionType = UITextAutocorrectionTypeNo;
    customerCityTF.keyboardType = UIKeyboardTypeDefault;
    customerCityTF.returnKeyType = UIReturnKeyDone;
    customerCityTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerCityTF.userInteractionEnabled = YES;
    customerCityTF.delegate = self;
    
    
    customerCategoryTF = [[UITextField alloc]init];
    customerCategoryTF.borderStyle = UITextBorderStyleRoundedRect;
    customerCategoryTF.textColor = [UIColor blackColor];
    customerCategoryTF.font = [UIFont systemFontOfSize:17.0];
    customerCategoryTF.placeholder = @"Customer Category";
    customerCategoryTF.backgroundColor = [UIColor whiteColor];
    customerCategoryTF.autocorrectionType = UITextAutocorrectionTypeNo;
    customerCategoryTF.keyboardType = UIKeyboardTypeDefault;
    customerCategoryTF.returnKeyType = UIReturnKeyDone;
    customerCategoryTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerCategoryTF.userInteractionEnabled = YES;
    customerCategoryTF.delegate = self;
    
    giftVoucherTF = [[UITextField alloc]init];
    giftVoucherTF.borderStyle = UITextBorderStyleRoundedRect;
    giftVoucherTF.textColor = [UIColor blackColor];
    giftVoucherTF.font = [UIFont systemFontOfSize:17.0];
    giftVoucherTF.placeholder = @"Select Gift Voucher";
    giftVoucherTF.backgroundColor = [UIColor whiteColor];
    giftVoucherTF.autocorrectionType = UITextAutocorrectionTypeNo;
    giftVoucherTF.keyboardType = UIKeyboardTypeDefault;
    giftVoucherTF.returnKeyType = UIReturnKeyDone;
    giftVoucherTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    giftVoucherTF.userInteractionEnabled = NO;
    giftVoucherTF.delegate = self;
    
    giftVoucherValueTF = [[UITextField alloc]init];
    giftVoucherValueTF.borderStyle = UITextBorderStyleRoundedRect;
    giftVoucherValueTF.textColor = [UIColor blackColor];
    giftVoucherValueTF.font = [UIFont systemFontOfSize:17.0];
    giftVoucherValueTF.placeholder = @"Select Value"; //@"Select Voucher Value"
    giftVoucherValueTF.backgroundColor = [UIColor whiteColor];
    giftVoucherValueTF.autocorrectionType = UITextAutocorrectionTypeNo;
    giftVoucherValueTF.keyboardType = UIKeyboardTypeDefault;
    giftVoucherValueTF.returnKeyType = UIReturnKeyDone;
    giftVoucherValueTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    giftVoucherValueTF.userInteractionEnabled = NO;
    giftVoucherValueTF.delegate = self;
    
    giftVoucherCodeTF = [[UITextField alloc]init];
    giftVoucherCodeTF.borderStyle = UITextBorderStyleRoundedRect;
    giftVoucherCodeTF.textColor = [UIColor blackColor];
    giftVoucherCodeTF.font = [UIFont systemFontOfSize:17.0];
    giftVoucherCodeTF.placeholder = @"Enter Voucher Code";
    giftVoucherCodeTF.backgroundColor = [UIColor whiteColor];
    giftVoucherCodeTF.autocorrectionType = UITextAutocorrectionTypeNo;
    giftVoucherCodeTF.keyboardType = UIKeyboardTypeDefault;
    giftVoucherCodeTF.returnKeyType = UIReturnKeyDone;
    giftVoucherCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    giftVoucherCodeTF.userInteractionEnabled = YES;
    giftVoucherCodeTF.delegate = self;
    [giftVoucherCodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    // Framings...
    float textToTextSpacing = 20;
    scrollView.frame = CGRectMake(0, 51, self.view.frame.size.width, self.view.frame.size.height);
//    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    phNotxt.frame = CGRectMake(10, 10, 235, 40);
    
    customerIdTF.frame = CGRectMake(phNotxt.frame.origin.x, (phNotxt.frame.origin.y + phNotxt.frame.size.height + textToTextSpacing), (self.view.frame.size.width-65)/4, phNotxt.frame.size.height);
    
    firstNameTF.frame = CGRectMake(customerIdTF.frame.origin.x + customerIdTF.frame.size.width + 15, customerIdTF.frame.origin.y, customerIdTF.frame.size.width, phNotxt.frame.size.height);
    
    lastNameTF.frame = CGRectMake(firstNameTF.frame.origin.x + firstNameTF.frame.size.width + 15, customerIdTF.frame.origin.y, customerIdTF.frame.size.width, phNotxt.frame.size.height);
    
    localityTF.frame = CGRectMake(lastNameTF.frame.origin.x + lastNameTF.frame.size.width + 15, customerIdTF.frame.origin.y, customerIdTF.frame.size.width, phNotxt.frame.size.height);

    customerCategoryTF.frame = CGRectMake(customerIdTF.frame.origin.x, (customerIdTF.frame.origin.y + customerIdTF.frame.size.height + textToTextSpacing), customerIdTF.frame.size.width, phNotxt.frame.size.height);
    
    customerAddressTF.frame = CGRectMake(customerCategoryTF.frame.origin.x + customerCategoryTF.frame.size.width + 15, customerCategoryTF.frame.origin.y, customerIdTF.frame.size.width, phNotxt.frame.size.height);
    
    customerCityTF.frame =  CGRectMake(customerAddressTF.frame.origin.x + customerAddressTF.frame.size.width + 15, customerCategoryTF.frame.origin.y, customerIdTF.frame.size.width, phNotxt.frame.size.height);
    
    emiltxt.frame =  CGRectMake(customerCityTF.frame.origin.x + customerCityTF.frame.size.width + 15, customerCategoryTF.frame.origin.y, customerIdTF.frame.size.width, phNotxt.frame.size.height);


    currentSchemeLbl.frame =  CGRectMake(phNotxt.frame.origin.x, customerCategoryTF.frame.origin.y + customerCategoryTF.frame.size.height + 20, 283, 22); // w-220
    
    voucherValueLbl.frame =  CGRectMake(currentSchemeLbl.frame.origin.x + currentSchemeLbl.frame.size.width + 5, currentSchemeLbl.frame.origin.y, 140, currentSchemeLbl.frame.size.height); //270
    
    voucherCodeLbl.frame =  CGRectMake(voucherValueLbl.frame.origin.x + voucherValueLbl.frame.size.width + 5, currentSchemeLbl.frame.origin.y, 427, currentSchemeLbl.frame.size.height);
    
    giftVoucherTF.frame =  CGRectMake(currentSchemeLbl.frame.origin.x, currentSchemeLbl.frame.origin.y + currentSchemeLbl.frame.size.height, currentSchemeLbl.frame.size.width, 40);
    
    giftVoucherValueTF.frame =  CGRectMake(voucherValueLbl.frame.origin.x, voucherValueLbl.frame.origin.y + voucherValueLbl.frame.size.height, voucherValueLbl.frame.size.width, giftVoucherTF.frame.size.height);

    giftVoucherCodeTF.frame = CGRectMake(voucherCodeLbl.frame.origin.x, voucherCodeLbl.frame.origin.y + voucherCodeLbl.frame.size.height, voucherCodeLbl.frame.size.width, giftVoucherTF.frame.size.height);

    addGVButton.frame = CGRectMake(self.view.frame.size.width - 148, giftVoucherCodeTF.frame.origin.y, 135, 40);
    
    selectGiftVocherBtn.frame = CGRectMake((giftVoucherTF.frame.origin.x + giftVoucherTF.frame.size.width - 32), (giftVoucherTF.frame.origin.y + 13), 22, 15);

    selectVoucherValueBtn.frame = CGRectMake((giftVoucherValueTF.frame.origin.x + giftVoucherValueTF.frame.size.width - 32), (giftVoucherValueTF.frame.origin.y + 13), 22, 15);

    
    // Setting attributedPlaceholder for UITextFields....
    emiltxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:emiltxt.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    customerCityTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerCityTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];

    customerAddressTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerAddressTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];

    customerCategoryTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerCategoryTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    localityTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:localityTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    lastNameTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:lastNameTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    firstNameTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:firstNameTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    customerIdTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerIdTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    phNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];

    giftVoucherTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:giftVoucherTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    giftVoucherValueTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:giftVoucherValueTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];

    giftVoucherCodeTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:giftVoucherCodeTF.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];


    // added by roja on 06/03/2019
    [scrollView addSubview:phNotxt];
    [scrollView addSubview:customerIdTF];
    [scrollView addSubview:firstNameTF];
    [scrollView addSubview:lastNameTF];
    [scrollView addSubview:localityTF];
    [scrollView addSubview:customerCategoryTF];
    [scrollView addSubview:customerAddressTF];
    [scrollView addSubview:customerCityTF];
    [scrollView addSubview:emiltxt];
    
    [scrollView addSubview:currentSchemeLbl];
    [scrollView addSubview:voucherValueLbl];
    [scrollView addSubview:voucherCodeLbl];
    [scrollView addSubview:giftVoucherTF];
    [scrollView addSubview:giftVoucherValueTF];
    [scrollView addSubview:giftVoucherCodeTF];

    [scrollView addSubview:selectGiftVocherBtn];
    [scrollView addSubview:selectVoucherValueBtn];
    [scrollView addSubview:addGVButton];
    [scrollView addSubview:submitBtn];
    [scrollView addSubview:cancelButton];
    [scrollView addSubview:giftVoucherDetailsTable];
//    [scrollView addSubview:loyaltyTypeTable];
    [scrollView addSubview:giftVoucherCodeDetailsTable];

    mailView = [[UIView alloc] init];
    [self.view addSubview:scrollView];
    
    giftVoucherDetailsTable.hidden = YES;
//    loyaltyTypeTable.hidden = YES;
    
    snoLbl = [[UILabel alloc]init];
    snoLbl.text = @"S.No.";
    snoLbl.layer.cornerRadius = 5.0f; //14
    snoLbl.textAlignment = NSTextAlignmentCenter;
    snoLbl.layer.masksToBounds = YES;
    snoLbl.font = [UIFont boldSystemFontOfSize:15];
    snoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    snoLbl.textColor = [UIColor whiteColor];
    snoLbl.numberOfLines = 2;
    snoLbl.lineBreakMode = NSLineBreakByTruncatingTail;

    cashValueLbl = [[UILabel alloc]init];
    cashValueLbl.text = @"Voucher Value";
    cashValueLbl.layer.cornerRadius = 5.0f;
    cashValueLbl.textAlignment = NSTextAlignmentCenter;
    cashValueLbl.layer.masksToBounds = YES;
    cashValueLbl.font = [UIFont boldSystemFontOfSize:15];
    cashValueLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cashValueLbl.textColor = [UIColor whiteColor];
    cashValueLbl.numberOfLines = 2;
    cashValueLbl.lineBreakMode = NSLineBreakByTruncatingTail;

    noOfVouchersLbl = [[UILabel alloc]init];
    noOfVouchersLbl.text = @"Voucher Number";
    noOfVouchersLbl.layer.cornerRadius = 5.0f;
    noOfVouchersLbl.textAlignment = NSTextAlignmentCenter;
    noOfVouchersLbl.layer.masksToBounds = YES;
    noOfVouchersLbl.font = [UIFont boldSystemFontOfSize:15];
    noOfVouchersLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    noOfVouchersLbl.textColor = [UIColor whiteColor];
    noOfVouchersLbl.numberOfLines = 2;
    noOfVouchersLbl.lineBreakMode = NSLineBreakByTruncatingTail;

    expiryDateLbl = [[UILabel alloc]init];
    expiryDateLbl.text = @"Expiry Date";
    expiryDateLbl.layer.cornerRadius = 5.0f;
    expiryDateLbl.textAlignment = NSTextAlignmentCenter;
    expiryDateLbl.layer.masksToBounds = YES;
    expiryDateLbl.font = [UIFont boldSystemFontOfSize:15];
    expiryDateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    expiryDateLbl.textColor = [UIColor whiteColor];
    expiryDateLbl.numberOfLines = 2;
    expiryDateLbl.lineBreakMode = NSLineBreakByTruncatingTail;

    
    // added by roja on 06/03/2019
    issuedDateLbl = [[UILabel alloc]init];
    issuedDateLbl.text = @"Issued Date";
    issuedDateLbl.layer.cornerRadius = 5.0f;
    issuedDateLbl.textAlignment = NSTextAlignmentCenter;
    issuedDateLbl.layer.masksToBounds = YES;
    issuedDateLbl.font = [UIFont boldSystemFontOfSize:15];
    issuedDateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    issuedDateLbl.textColor = [UIColor whiteColor];
    issuedDateLbl.numberOfLines = 2;
    issuedDateLbl.lineBreakMode = NSLineBreakByTruncatingTail;

    statusLbl  = [[UILabel alloc]init];
    statusLbl.text = @"Status";
    statusLbl.layer.cornerRadius = 5.0f;
    statusLbl.textAlignment = NSTextAlignmentCenter;
    statusLbl.layer.masksToBounds = YES;
    statusLbl.font = [UIFont boldSystemFontOfSize:15];
    statusLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    statusLbl.textColor = [UIColor whiteColor];
    statusLbl.numberOfLines = 2;
    statusLbl.lineBreakMode = NSLineBreakByTruncatingTail;

    actionLbl  = [[UILabel alloc]init];
    actionLbl.text = @"Action";
    actionLbl.layer.cornerRadius = 5.0f;
    actionLbl.textAlignment = NSTextAlignmentCenter;
    actionLbl.layer.masksToBounds = YES;
    actionLbl.font = [UIFont boldSystemFontOfSize:15];
    actionLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    actionLbl.textColor = [UIColor whiteColor];
    actionLbl.numberOfLines = 2;
    actionLbl.lineBreakMode = NSLineBreakByTruncatingTail;

    
    snoLbl.frame = CGRectMake(10, giftVoucherTF.frame.origin.y + giftVoucherTF.frame.size.height + 5, (self.view.frame.size.width - 26)/7, 35);
    
    cashValueLbl.frame = CGRectMake((snoLbl.frame.origin.x + snoLbl.frame.size.width + 1), snoLbl.frame.origin.y, snoLbl.frame.size.width, snoLbl.frame.size.height);
    
    noOfVouchersLbl.frame = CGRectMake((cashValueLbl.frame.origin.x + cashValueLbl.frame.size.width + 1), snoLbl.frame.origin.y, snoLbl.frame.size.width, snoLbl.frame.size.height);
    
    issuedDateLbl.frame = CGRectMake((noOfVouchersLbl.frame.origin.x + noOfVouchersLbl.frame.size.width + 1), snoLbl.frame.origin.y, snoLbl.frame.size.width, snoLbl.frame.size.height);
    
    expiryDateLbl.frame = CGRectMake((issuedDateLbl.frame.origin.x + issuedDateLbl.frame.size.width + 1), snoLbl.frame.origin.y, snoLbl.frame.size.width, snoLbl.frame.size.height);
    
    statusLbl.frame = CGRectMake((expiryDateLbl.frame.origin.x + expiryDateLbl.frame.size.width + 1), snoLbl.frame.origin.y, snoLbl.frame.size.width, snoLbl.frame.size.height);
    
    actionLbl.frame = CGRectMake((statusLbl.frame.origin.x + statusLbl.frame.size.width + 1), snoLbl.frame.origin.y, snoLbl.frame.size.width, snoLbl.frame.size.height);
    
    
    selectGiftVoucherTable.frame = CGRectMake(0, (snoLbl.frame.origin.y + snoLbl.frame.size.height+2), self.view.frame.size.width, 270);
    
    submitBtn.frame = CGRectMake(130, (selectGiftVoucherTable.frame.origin.y + selectGiftVoucherTable.frame.size.height + 20), 150, 50);
    
    cancelButton.frame = CGRectMake(submitBtn.frame.origin.x + submitBtn.frame.size.width + 100, (selectGiftVoucherTable.frame.origin.y + selectGiftVoucherTable.frame.size.height + 20), submitBtn.frame.size.width , submitBtn.frame.size.height);
    
    
    [scrollView addSubview:cashValueLbl];
    [scrollView addSubview:noOfVouchersLbl];
    [scrollView addSubview:snoLbl];
    [scrollView addSubview:expiryDateLbl];
    [scrollView addSubview:selectGiftVoucherTable];
    
    [scrollView addSubview:issuedDateLbl];
    [scrollView addSubview:statusLbl];
    [scrollView addSubview:actionLbl];
    
    [self provideCustomerRatingfor:nil];
    resultId = [[UILabel alloc] init];

    
    // Commented by roja on 06/03/2019...
    // Reason given lastest GUI no need of this.....
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        //        img.frame = CGRectMake(0, 0, 778, 50);
    //        //        label.font = [UIFont boldSystemFontOfSize:25];
    //        //        label.frame = CGRectMake(10, 0, 200, 50);
    //        //        backbutton.frame = CGRectMake(710.0, 5.0, 40.0, 40.0);
    //        scrollView.frame = CGRectMake(0, 51, self.view.frame.size.width, self.view.frame.size.height);
    //        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    //        //issueLoyaltyView.frame = CGRectMake(20, 22, 738, 800);
    //        //img1.frame = CGRectMake(0, 0, 738, 200);
    //        userImage.frame = CGRectMake(60, 30, 50, 50);
    //        phoneImage.frame = CGRectMake(60, 115.0, 50, 50);
    //        mailImage.frame = CGRectMake(40, 180, 90, 100);
    //        id_Type.frame = CGRectMake(60, 300, 50, 60);
    //        id_No.frame = CGRectMake(60, 400, 50, 60);
    //        loyalcard.frame = CGRectMake(60, 495, 50, 70);
    //
    
    //        username.font = [UIFont systemFontOfSize:30];
    //        username.frame = CGRectMake(30, 10, 300, 50);
    //        phNo.text = @"Phone No.";
    //        phNo.font = [UIFont systemFontOfSize:30];
    //        phNo.frame = CGRectMake(30, 100, 300, 50);
    //        email.font = [UIFont systemFontOfSize:30];
    //        email.frame = CGRectMake(30, 170, 300, 50);
    //        idType.font = [UIFont systemFontOfSize:30];
    //        idType.frame = CGRectMake(30, 240, 300, 50);
    //        idNo.font = [UIFont systemFontOfSize:30];
    //        idNo.frame = CGRectMake(30, 310, 300, 50);
    //        loyaltyType.font = [UIFont systemFontOfSize:30];
    //        loyaltyType.frame = CGRectMake(15, 370, 200, 50);
    //
    //        usernametxt.font = [UIFont systemFontOfSize:25];
    //        usernametxt.frame = CGRectMake(80, 85, 450, 60);
    ////        phNotxt.font = [UIFont systemFontOfSize:25];
    ////        phNotxt.frame = CGRectMake(80, 10, 450, 60);
    //        emiltxt.font = [UIFont systemFontOfSize:25];
    //        emiltxt.frame = CGRectMake(540, 85, 450, 60);
    //        idTypetxt.font = [UIFont systemFontOfSize:20];
    //        idTypetxt.frame = CGRectMake(80, 210.0, 300, 60);
    //        selectGiftVocherBtn.frame = CGRectMake(370.0, 204.0, 50, 77);
    //
    ////        idNotxt.font = [UIFont systemFontOfSize:30];
    ////        idNotxt.frame = CGRectMake(130, 350, 520, 60);
    //        loyaltyTypetxt.font = [UIFont systemFontOfSize:20];
    //        loyaltyTypetxt.frame = CGRectMake(540.0, 210.0, 300, 60);
    //
    //        selectVoucherValueBtn.frame = CGRectMake(820.0, 204.0,50, 77);
    //
    //        addGVButton.frame = CGRectMake(880.0f, 210.0,100.0f, 55.0f);
    //        addGVButton.layer.cornerRadius = 25.0f;
    //        addGVButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    //
    //        submitBtn.frame = CGRectMake(150.0f, 600.0f,300.0f, 55.0f);
    //        submitBtn.layer.cornerRadius = 25.0f;
    //        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    //        cancelButton.frame = CGRectMake(600.0f, 600.0f,300.0f, 55.0f);
    //        cancelButton.layer.cornerRadius = 25.0f;
    //        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    //        giftVoucherDetailsTable.frame = CGRectMake(130, 360,idNotxt.frame.size.width, 200);
    //        loyaltyTypeTable.frame = CGRectMake(130, 560,loyaltyTypetxt.frame.size.width, 300);
    //
    //        usernametxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:usernametxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //        idNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //
    //        idTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //
    //        emiltxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:emiltxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //        phNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //        loyaltyTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:loyaltyTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //    }
    //    else {
    //
    //        if (version>8.0) {
    //
    //            scrollView.frame = CGRectMake(0, 0, 320, 600);
    //            scrollView.contentSize = CGSizeMake(320, 770);
    //
    //            userImage.frame = CGRectMake(40, 30, 30, 30);
    //            phoneImage.frame = CGRectMake(40, 70.0, 30, 30);
    //            mailImage.frame = CGRectMake(27, 95, 60, 60);
    //            id_Type.frame = CGRectMake(40, 148, 30, 30);
    //            id_No.frame = CGRectMake(40, 188, 30, 30);
    //            loyalcard.frame = CGRectMake(40, 230, 30, 30);
    //
    //            username.frame = CGRectMake(5, 30, 120, 30);
    //            phNo.frame = CGRectMake(5, 70, 130, 30);
    //            email.frame = CGRectMake(5, 110, 120, 30);
    //            idType.frame = CGRectMake(5, 150, 120, 30);
    //            idNo.frame = CGRectMake(5, 190, 120, 30);
    //            loyaltyType.frame = CGRectMake(5, 260, 120, 30);
    //
    //            usernametxt.frame = CGRectMake(80, 30, 160, 30);
    //            phNotxt.frame = CGRectMake(80, 70, 160, 30);
    //            emiltxt.frame = CGRectMake(80, 110, 160, 30);
    //            idTypetxt.frame = CGRectMake(80, 150, 160, 28);
    //            selectGiftVocherBtn.frame = CGRectMake(240.0f, 147.0f,25.0f, 37.0f);
    //            idNotxt.frame = CGRectMake(80, 190, 160, 30);
    //            loyaltyTypetxt.frame = CGRectMake(80, 230.0, 160, 29);
    //            selectVoucherValueBtn.frame = CGRectMake(240.0, 225.0,25.0f, 37.0f);
    //            submitBtn.frame = CGRectMake(20.0f, 360.0f,280.0f, 35.0f);
    //            submitBtn.layer.cornerRadius = 15.0f;
    //            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    //            giftVoucherDetailsTable.frame = CGRectMake(80, 177,160, 90);
    //            loyaltyTypeTable.frame = CGRectMake(55, 115.0,180, 180);
    //
    //            usernametxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:usernametxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //            idNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //
    //            idTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //
    //            emiltxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:emiltxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //            phNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //            loyaltyTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:loyaltyTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    //
    //
    //
    //        }
    //        else {
    //
    //            scrollView.frame = CGRectMake(0, 0, 320, 600);
    //            scrollView.contentSize = CGSizeMake(320, 770);
    //
    //            userImage.frame = CGRectMake(40, 30, 30, 30);
    //            phoneImage.frame = CGRectMake(40, 70.0, 30, 30);
    //            mailImage.frame = CGRectMake(27, 95, 60, 60);
    //            id_Type.frame = CGRectMake(40, 148, 30, 30);
    //            id_No.frame = CGRectMake(40, 188, 30, 30);
    //            loyalcard.frame = CGRectMake(40, 230, 30, 30);
    //
    //            username.frame = CGRectMake(5, 30, 120, 30);
    //            phNo.frame = CGRectMake(5, 70, 130, 30);
    //            email.frame = CGRectMake(5, 110, 120, 30);
    //            idType.frame = CGRectMake(5, 150, 120, 30);
    //            idNo.frame = CGRectMake(5, 190, 120, 30);
    //            loyaltyType.frame = CGRectMake(5, 260, 120, 30);
    //
    //            usernametxt.frame = CGRectMake(80, 30, 160, 30);
    //            phNotxt.frame = CGRectMake(80, 70, 160, 30);
    //            emiltxt.frame = CGRectMake(80, 110, 160, 30);
    //            idTypetxt.frame = CGRectMake(80, 150, 160, 28);
    //            selectGiftVocherBtn.frame = CGRectMake(240.0f, 147.0f,25.0f, 37.0f);
    //            idNotxt.frame = CGRectMake(80, 190, 160, 30);
    //            loyaltyTypetxt.frame = CGRectMake(80, 230.0, 160, 29);
    //            selectVoucherValueBtn.frame = CGRectMake(240.0, 225.0,25.0f, 37.0f);
    //            submitBtn.frame = CGRectMake(20.0f, 300.0f,280.0f, 35.0f);
    //            submitBtn.layer.cornerRadius = 15.0f;
    //            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    //            giftVoucherDetailsTable.frame = CGRectMake(80, 177,160, 90);
    //            loyaltyTypeTable.frame = CGRectMake(55, 115.0,180, 180);
    //
    //
    //        }
    //        img.frame = CGRectMake(0, 0, 320, 31);
    //        label.frame = CGRectMake(3, 1, 120, 30);
    //        backbutton.frame = CGRectMake(285.0, 2.0, 27.0, 27.0);
    
    
    //  }
    //upto here Commented by roja on 06/03/2019...
    
    
    
    
    // mailview initialization....
    //scrollView.hidden = YES;
    // mailView.hidden = YES;

    
    //[topbar addSubview:img];
    //    [self.view addSubview:img];
    //    [self.view addSubview:label];
    //    [self.view addSubview:backbutton];
    //[self.view addSubview:scrollView];
    
    //    [scrollView addSubview:userImage];
    //    [scrollView addSubview:phoneImage];
    //    [scrollView addSubview:mailImage];
    //    [scrollView addSubview:id_Type];
    //    [scrollView addSubview:id_No];
    //    [scrollView addSubview:loyalcard];
    //[scrollView addSubview:loyaltyType];
    //    [scrollView addSubview:usernametxt];
    //    [scrollView addSubview:emiltxt];
    //    [scrollView addSubview:idTypetxt];
    //    [scrollView addSubview:idNotxt];
    //    [scrollView addSubview:loyaltyTypetxt];
    //    [scrollView addSubview:selectVoucherValueBtn];
    //    [scrollView addSubview:submitBtn];
    //    [scrollView addSubview:cancelButton];
    //    [scrollView addSubview:addGVButton];
    //    [scrollView addSubview:giftVoucherDetailsTable];
    //
    //    [scrollView addSubview:loyaltyTypeTable];
    //    [scrollView addSubview:selectGiftVocherBtn];
    
    
//    loyaltyPgm = [[NSMutableArray alloc]init];
    
   
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [HUD setHidden:NO];
//    HUD.labelText = @"Loading Data..";
//    [HUD setHidden:YES];
    
    voucherPromoCodeStr = @"";
    [self getGiftVoucherDetails];
}

/**
 * @description  Here we are calling 'GiftVouchersServices' to get available getGiftVouchers....
 * @date         06/03/2019
 * @method       getGiftVoucherDetails
 * @author       Roja
 * @param
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getGiftVoucherDetails{
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        NSArray * giftVoucherKeys = @[@"requestHeader",@"startIndex"];//STATUS
        
        NSArray * giftVoucherObjects = @[[RequestHeader getRequestHeader],ZERO_CONSTANT];//@"active"
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:giftVoucherObjects forKeys:giftVoucherKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * giftvoucherRequestStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceContr = [WebServiceController new];
        webServiceContr.giftVoucherSrvcDelegate = self;
        [webServiceContr getAvailableGiftVouchers:giftvoucherRequestStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];

    } @finally {
        
    }
}

/**
 * @description  Here we are handling success response of gift voucher
 * @date         06/03/2019
 * @method       getGiftVouchersSuccessResponse
 * @author       Roja
 * @param
 * @param        NSDictionary
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getGiftVouchersSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        /*
         {
             claimStatus = 0;
             giftVouchersChildList =     (
                         {
                     assignedStatus = 1;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000013;
                     voucherId = 20639;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 },
                         {
                     assignedStatus = 1;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000016;
                     voucherId = 18596;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 },
                         {
                     assignedStatus = 1;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000014;
                     voucherId = 27232;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 },
                         {
                     assignedStatus = 1;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000017;
                     voucherId = 13720;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 },
                         {
                     assignedStatus = 1;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000015;
                     voucherId = 27733;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 }
             );
             responseHeader =     {
                 responseCode = 0;
                 responseMessage = Success;
             };
             totalRecords = 5;
         }

         */
        
        NSArray * giftVouchersArray = [self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"giftVouchersList"] defaultReturn:@""];
        
        giftVoucherDetailsArr = [[NSMutableArray alloc]init];
        
        for (NSDictionary * dic in giftVouchersArray) {
            
            if([[dic valueForKey:@"status"] isEqualToString:@"Active"]){
                
                NSMutableDictionary * giftVoucherDetailsDic = [[NSMutableDictionary alloc]init];
                
                [giftVoucherDetailsDic setValue:[dic valueForKey:@"promoName"] forKey:@"promoName"];
                [giftVoucherDetailsDic setValue:[dic valueForKey:@"unitCashValue"] forKey:@"unitCashValue"];
                [giftVoucherDetailsDic setValue:[dic valueForKey:@"status"] forKey:@"status"];
                [giftVoucherDetailsDic setValue:[dic valueForKey:@"createdOn"] forKey:@"createdOn"];
                [giftVoucherDetailsDic setValue:[dic valueForKey:@"expiryDate"] forKey:@"expiryDate"];
                [giftVoucherDetailsDic setValue:[dic valueForKey:@"voucherProgramCode"] forKey:@"voucherProgramCode"];
                [giftVoucherDetailsDic setValue:[dic valueForKey:@"isPaid"] forKey:@"isPaid"];

                
                [giftVoucherDetailsArr addObject:giftVoucherDetailsDic];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];

    }

}

/**
 * @description  Here we are handling error response of gift voucher
 * @date         06/03/2019
 * @method       getGiftVouchersFailureResponse
 * @author       Roja
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getGiftVouchersFailureResponse:(NSString *)failureString{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:failureString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }

}

/**
 * @description  It is one of the TextField delegate method. This method fired when we change the text..
 * @date         06/03/2019
 * @method       textFieldDidChange
 * @author       Roja
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)textFieldDidChange:(UITextField *)textField {
    
    //    if (textField == phNotxt) {
    //        if (textField.text.length == 10) {
    //            [phNotxt resignFirstResponder];
    //            [self getCustomerDetailsForOffers];
    //        }
    //    }
    if (textField == phNotxt) {
        
        if ([phNotxt.text length]==10) {
            //AudioServicesPlaySystemSound(soundFileObject);
            [self getCustomerDetails];
        }
    }
    else if(textField == giftVoucherCodeTF){
        
        if([giftVoucherCodeTF.text length] >= 3){
            [self getGiftVoucherCodeDetailsList];
        }
    }
}


/**
 * @description  It is one of the TextField delegate method. This method fired when we change the text..
 * @date         06/03/2019
 * @method       shouldChangeCharactersInRange
 * @author       Roja
 * @param        UITextField
 * @param        NSRange
 * @return       BOOL
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    
    if ([textField.text isEqualToString:emiltxt.text]) {
        
        return YES;
    }
    
    //    else if (textField == phNotxt) {
    //
    //        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    //        for (int i = 0; i < [characters length]; i++) {
    //            unichar c = [characters characterAtIndex:i];
    //            if (![myCharSet characterIsMember:c]) {
    //                return NO;
    //            }
    //        }
    //
    //    }
//    else if (range.location == textField.text.length && [characters isEqualToString:@" "]) {
//        // ignore replacement string and add your own
//        textField.text = [textField.text stringByAppendingString:@"\u00a0"];
//        return NO;
//    }
//    else {
//        
//        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
//    }
    
    return 1;
}


/**
 * @description  Here we are calling 'customerService' to get Customer Details..
 * @date         06/03/2019
 * @method       getCustomerDetails
 * @author       Roja
 * @param
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getCustomerDetails{
    
    @try{
        [HUD setHidden:NO];
        
        NSArray * customerDetailsKeys = [NSArray arrayWithObjects:@"email",@"mobileNumber",REQUEST_HEADER, nil];
        NSArray *customerDetailsObjects = [NSArray arrayWithObjects:@"",phNotxt.text,[RequestHeader getRequestHeader], nil];
        
        NSDictionary *requestDic = [NSDictionary dictionaryWithObjects:customerDetailsObjects forKeys:customerDetailsKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&err_];
        NSString * RequestString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * controller = [WebServiceController new];
        [controller setCustomerServiceDelegate:self];
        [controller getCustomerDetails:RequestString];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}

/**
 * @description  Here we are handling success response of get customer details
 * @date         06/03/2019
 * @method       getCustomerDetailsSuccessResponse
 * @author       Roja
 * @param
 * @param        NSDictionary
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getCustomerDetailsSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        emiltxt.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"email"] defaultReturn:@""]];
        firstNameTF.text =  [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"name"] defaultReturn:@""]];//
        customerIdTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"customerId"] defaultReturn:@""]];
        lastNameTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"lastName"] defaultReturn:@""]];
        localityTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"locality"] defaultReturn:@""]];
        customerAddressTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"street"] defaultReturn:@""]];
        customerCityTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"city"] defaultReturn:@""]];
        
        if ([[sucessDictionary valueForKey:@"phone"] isKindOfClass:[NSNull class]] || [[sucessDictionary valueForKey:@"phone"] isEqualToString:@""]) { // email may also need to check
            if ((phNotxt.text).length >= 10) {
                [self provideCustomerRatingfor:NEW_CUSTOMER];
                return;
            }
        }
        else{
            if ((phNotxt.text).length >= 10) {
                
                if (!([[sucessDictionary valueForKey:@"category"] isKindOfClass:[NSNull class]]) && ![[sucessDictionary valueForKey:@"category"] isEqualToString:@""]) {
                    
                    [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@",[sucessDictionary valueForKey:@"category"]]];
                    return;
                }
                else {
                    [self provideCustomerRatingfor:EXISTING_CUSTOMER];
                    return;
                }
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}



/**
 * @description  Here we are handling error response of get customer details
 * @date         06/03/2019
 * @method       getCustomerDetailsErrorResponse
 * @author       Roja
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getCustomerDetailsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"New Customer" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

/**
 * @description  Here we are providing the customer ratings..
 * @date
 * @method       provideCustomerRatingfor
 * @author
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)provideCustomerRatingfor:(NSString *)category
{
    [starRat removeFromSuperview];
    starRat = [[UIImageView alloc] init];
    starRat.backgroundColor = [UIColor clearColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        starRat.frame = CGRectMake(280, 8, 180, 40); //540.0 // H-30.0
    }
    [scrollView addSubview:starRat];
    if ([category isEqualToString:PREMIUM])
    {
        [self ratingView:5.0 outOf:5.0 imageView:starRat];
    }
    else if ([category isEqualToString:GENERIC])
    {
        [self ratingView:4.0 outOf:5.0 imageView:starRat];
    }
    else if ([category isEqualToString:PLUS])
    {
        [self ratingView:3.0 outOf:5.0 imageView:starRat];
    }
    else if ([category isEqualToString:BASIC])
    {
        [self ratingView:2.5 outOf:5.0 imageView:starRat];
    }
    else if ([category isEqualToString:NORMAL])
    {
        [self ratingView:2.0 outOf:5.0 imageView:starRat];
    }
    else
    {
        [self ratingView:0.0 outOf:5.0 imageView:starRat];
    }
}

/**
 * @description
 * @date
 * @method       ratingView:-- imageView:--
 * @author
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void )ratingView:(double)ratingValue outOf:(NSUInteger)totalValue imageView:(UIImageView *)view

{
    NSUInteger xPos = view.frame.origin.x;
    if (ratingValue >= 5) {
        
        ratingValue = 5;
    }
    double tempRatingValue = ratingValue;
    UIImageView *starImageView ;
    for (NSUInteger currentStar=0; currentStar<totalValue; currentStar++) { // Looping for each star(imageView) in the KDRatingView
        
        starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, view.frame.origin.y, view.frame.size.width/totalValue, view.frame.size.height)];
        
        if (tempRatingValue-1>=0) {
            tempRatingValue--;
            // place one complete star
            starImageView.image = [UIImage imageNamed:@"1_star"];
            
        } else {
            if ((tempRatingValue>=0)&&(tempRatingValue<0.25)) {
                // place 0 star
                starImageView.image = [UIImage imageNamed:@"grey_star@2x"];
                
            } else if ((tempRatingValue>=0.25)&&(tempRatingValue<0.50)) {
                // place 1/4 star
                starImageView.image = [UIImage imageNamed:@"14_star"];
                
            } else if ((tempRatingValue>=0.50)&&(tempRatingValue<0.75)) {
                // place 1/2 star
                starImageView.image = [UIImage imageNamed:@"12_star"];
                
            } else if ((tempRatingValue>=0.75)&&(tempRatingValue<1.0)) {
                // place 3/4 star
                starImageView.image = [UIImage imageNamed:@"34_star"];
            }
            
            tempRatingValue=0;
        }
        
        // set tag starImageView which will allow to identify and differentiate it individually in calling class.
        // Add starImageView to view as a subView
        starImageView.tag = currentStar;
        [scrollView addSubview:starImageView];
        
        // calculate new xPos and yPos
        xPos = xPos + starImageView.frame.size.width + 10;
    }
    
    
}

//Number pad close...
-(void)doneWithNumberPad{
    
    // NSString *numberFromTheKeyboard = phNo.text;
    [phNotxt resignFirstResponder];
}

/**
 * @description  Here we are displaying the pop up view on selection of gift vouchers
 * @date         06/03/2019
 * @method       giftVoucherDetailsPopOver
 * @author
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY  Roja
 * @reason       Pop up need to display only when giftVoucherDetailsArr has count.
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)giftVoucherDetailsPopOver:(id) sender {
    
    @try {
        
        // added by roja on 06/03/2019...
        float voucherTblHeight = 0;
        
        if ([giftVoucherDetailsArr count] && giftVoucherDetailsArr != nil) {
            
            voucherTblHeight =  [giftVoucherDetailsArr count] * 40;
            
            if ([giftVoucherDetailsArr count] >= 3) {
                
                voucherTblHeight = 3 * 40;
            }
        }
        //upto here added by roja on 06/03/2019...

        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *editPriceView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, giftVoucherTF.frame.size.width, voucherTblHeight)];//
        editPriceView.opaque = NO;
        editPriceView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        editPriceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        editPriceView.layer.borderWidth = 2.0f;
        [editPriceView setHidden:NO];
        
        giftVoucherDetailsTable = [[UITableView alloc] init];
        giftVoucherDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
        giftVoucherDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
        giftVoucherDetailsTable.layer.cornerRadius = 4.0f;
        giftVoucherDetailsTable.layer.borderWidth = 1.0f;
        giftVoucherDetailsTable.dataSource = self;
        giftVoucherDetailsTable.delegate = self;
        giftVoucherDetailsTable.bounces = FALSE;
        giftVoucherDetailsTable.frame = CGRectMake(0.0, 0.0, editPriceView.frame.size.width, editPriceView.frame.size.height);
        
        [editPriceView addSubview:giftVoucherDetailsTable];
        customerInfoPopUp.view = editPriceView;
        
//        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(editPriceView.frame.size.width, editPriceView.frame.size.height);
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            [popover presentPopoverFromRect:giftVoucherTF.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            editPricePopOver= popover;
//        }
        
//        else {
//
//            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
//
//            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//            // popover.contentViewController.view.alpha = 0.0;
//            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
//            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//            editPricePopOver = popover;
//
//        }
        
//        [usernametxt resignFirstResponder];
//        [idTypetxt resignFirstResponder];
//        [idNotxt resignFirstResponder];

        [giftVoucherTF resignFirstResponder];
        [emiltxt resignFirstResponder];
        [phNotxt resignFirstResponder];
        [firstNameTF resignFirstResponder];
        [lastNameTF resignFirstResponder];
        [localityTF resignFirstResponder];
        [customerIdTF resignFirstResponder];
        [customerCategoryTF resignFirstResponder];
        [customerAddressTF resignFirstResponder];
        [customerCityTF resignFirstResponder];
        [giftVoucherCodeTF resignFirstResponder];

        [giftVoucherDetailsTable reloadData];
        giftVoucherDetailsTable.hidden = NO;
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
   
}






- (void)cancelButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [self.navigationController popViewControllerAnimated:YES];
}


//runScheduledTask handler..
- (void) runScheduledTask:(NSTimer*)theTimer {
    
    if([(NSString*)theTimer.userInfo isEqualToString:@"mailView"]) {
        
        if (mailView.subviews){
            for (UIView *subview in mailView.subviews) {
                [subview removeFromSuperview];
            }
        }
        
        mailView.hidden = YES;
        [mailView removeFromSuperview];
    }
    
    aTimer = nil;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"Loyalty Card Issued. Your Loyalty No. is %@", resultId.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    usernametxt.text = @"";
    phNotxt.text = @"";
    emiltxt.text = @"";
    idNotxt.text = @"";
    idTypetxt.text = @"";
    loyaltyTypetxt.text = @"";
}


/**
 * @description  It is one of the UITextField delegate method used to hide the keyboard..
 * @date         06/03/2019
 * @method       textFieldShouldReturn
 * @author       roja
 * @param
 * @param        UITextField
 * @return       BOOL
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}



#pragma mark Start of Table view methods

// Customize the number of rows in the table view.
/**
 * @description  It is one of the UITableView delegate method used to Customize the number of rows in the table view...
 * @date         06/03/2019
 * @method       tableView:-- numberOfRowsInSection:--
 * @author       roja
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (tableView == loyaltyTypeTable) {
//        return numberOfVouchers;
//    }
    
    if (tableView == selectGiftVoucherTable) {
        return selectGiftVoucherArr.count;
    }
    else if(tableView == giftVoucherDetailsTable){
        return giftVoucherDetailsArr.count;
    }
    else if(tableView == giftVoucherCodeDetailsTable){
        return giftVoucherCodeDetailsArray.count;
    }
    else{
        return 0;
    }
}


//Customize HeightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 40;
}



// Customize the appearance of table view cells.
/**
 * @description  It is one of the UITableView delegate method used to Customize the appearance of table view cells.
 * @date         06/03/2019...
 * @method       tableView:--  cellForRowAtIndexPath:--
 * @author       roja
 * @param        UITableView
 * @param        NSIndexPath
 * @return       UITableViewCell
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        cell.frame = CGRectZero;
    }
    
    
//    if (tableView == loyaltyTypeTable) {
//
//        @try {
//            cell.textLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row + 1)];
//        } @catch (NSException *exception) {
//            NSLog(@"%@",exception);
//
//        } @finally {
//
//        }
//    }
    
    
    if (tableView == selectGiftVoucherTable) {
        
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
        
        hlcell.backgroundColor = [UIColor clearColor];
//        [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
        
        @try {
            UILabel *sno = [[UILabel alloc] init] ;
            sno.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            sno.backgroundColor = [UIColor clearColor];
            sno.textColor = [UIColor whiteColor];
            sno.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
            sno.textAlignment=NSTextAlignmentCenter;
            
//            sno.layer.borderWidth = 1.5;
//            sno.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;


            UILabel *voucherValLbl = [[UILabel alloc] init] ;
            voucherValLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            voucherValLbl.backgroundColor = [UIColor clearColor];
            voucherValLbl.textColor = [UIColor whiteColor];
            voucherValLbl.textAlignment=NSTextAlignmentCenter;

            UILabel *noOfVoucherLbl = [[UILabel alloc] init] ;
            noOfVoucherLbl.backgroundColor = [UIColor clearColor];
            noOfVoucherLbl.textAlignment = NSTextAlignmentCenter;
//            noOfVoucherLbl.numberOfLines = 2;
            noOfVoucherLbl.textColor = [UIColor whiteColor];
            noOfVoucherLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];

            UILabel * issuedDateLabel = [[UILabel alloc] init] ;
            issuedDateLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            issuedDateLabel.backgroundColor = [UIColor clearColor];
            issuedDateLabel.textColor = [UIColor whiteColor];
            issuedDateLabel.textAlignment=NSTextAlignmentCenter;
            issuedDateLabel.text = @"-";
            issuedDateLabel.numberOfLines = 2;

            UILabel *expiryDateLabel = [[UILabel alloc] init] ;
            expiryDateLabel.backgroundColor = [UIColor clearColor];
            expiryDateLabel.textAlignment = NSTextAlignmentCenter;
            expiryDateLabel.numberOfLines = 2;
            expiryDateLabel.textColor = [UIColor whiteColor];
            expiryDateLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];

            
            UILabel * statusLabel = [[UILabel alloc] init] ;
            statusLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            statusLabel.backgroundColor = [UIColor clearColor];
            statusLabel.textColor = [UIColor whiteColor];
            statusLabel.textAlignment=NSTextAlignmentCenter;
            statusLabel.text = @"-";
            
            
            UIButton *delrowbtn = [[UIButton alloc] init] ;
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];

            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
         // Setting values from dic
            if ([selectGiftVoucherArr count] && selectGiftVoucherArr != nil) {
                
                NSDictionary * tempDic = selectGiftVoucherArr[indexPath.row];

                voucherValLbl.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"unitCashValue"] defaultReturn:@"0"]];
                //[NSString stringWithFormat:@"%.1f",[[dic valueForKey:@"voucherValue"] floatValue]]
                noOfVoucherLbl.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"voucherCode"] defaultReturn:@"0"]];// voucherProgramCode
                //[NSString stringWithFormat:@"%d",[[dic valueForKey:@"noOfVouchers"] intValue]]
                expiryDateLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"expiryDate"] defaultReturn:@"-"]];
                issuedDateLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"createdOn"] defaultReturn:@"-"]];
                statusLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"status"] defaultReturn:@"-"]];
            }
            

//            sno.frame = CGRectMake(5, 0, 150.0, 60.0);
//            voucherValLbl.frame = CGRectMake(155, 0, 210.0, 60);
//            noOfVoucherLbl.frame = CGRectMake(365.0, 0, 210.0, 60);
//            expiryDateLbl.frame = CGRectMake(575.0, 0, 210.0, 60);
//            delrowbtn.frame = CGRectMake(800.0, 5, 50, 50);
//
            
            sno.frame = CGRectMake(snoLbl.frame.origin.x, 0, snoLbl.frame.size.width, snoLbl.frame.size.height);
            
            voucherValLbl.frame = CGRectMake(cashValueLbl.frame.origin.x, 0, cashValueLbl.frame.size.width, cashValueLbl.frame.size.height);
            
            noOfVoucherLbl.frame = CGRectMake(noOfVouchersLbl.frame.origin.x, 0, noOfVouchersLbl.frame.size.width, noOfVouchersLbl.frame.size.height);
            
            issuedDateLabel.frame = CGRectMake(issuedDateLbl.frame.origin.x, 0, issuedDateLbl.frame.size.width, issuedDateLbl.frame.size.height);
            
            expiryDateLabel.frame = CGRectMake(expiryDateLbl.frame.origin.x, 0, expiryDateLbl.frame.size.width, expiryDateLbl.frame.size.height);
            
            statusLabel.frame = CGRectMake(statusLbl.frame.origin.x, 0, statusLbl.frame.size.width, statusLbl.frame.size.height);
            
            delrowbtn.frame = CGRectMake((actionLbl.frame.origin.x + (actionLbl.frame.size.width/2))-15 , 0, 35, 35);

            
            [hlcell.contentView addSubview:sno];
            [hlcell.contentView addSubview:voucherValLbl];
            [hlcell.contentView addSubview:delrowbtn];
            [hlcell.contentView addSubview:noOfVoucherLbl];
            [hlcell.contentView addSubview:expiryDateLabel];
            [hlcell.contentView addSubview:statusLabel];
            [hlcell.contentView addSubview:issuedDateLabel];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        @finally {
        }
        return hlcell;

    }
    else if(tableView == giftVoucherDetailsTable){
        
        @try {
            
            cell.textLabel.textColor= [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];

            if([giftVoucherDetailsArr count] && giftVoucherDetailsArr != nil){
                
                NSDictionary * giftVoucherDetailsDic = giftVoucherDetailsArr[indexPath.row];
                cell.textLabel.text = [self checkGivenValueIsNullOrNil:[giftVoucherDetailsDic valueForKey:@"promoName"] defaultReturn:@"-"];
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);

        } @finally {
            
        }
    }
    
    else if(tableView == giftVoucherCodeDetailsTable){
        
        @try {
            cell.textLabel.textColor= [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];

            if([giftVoucherCodeDetailsArray count] && giftVoucherCodeDetailsArray != nil){
                
                NSDictionary * giftVoucherCodeDetailsDic = giftVoucherCodeDetailsArray[indexPath.row];
                cell.textLabel.text = [self checkGivenValueIsNullOrNil:[giftVoucherCodeDetailsDic valueForKey:@"voucherCode"] defaultReturn:@"-"];
            }
            
        } @catch (NSException *exception) {
            
            NSLog(@"%@",exception);

        } @finally {
            
        }
    }
    
    return cell;
}



/**
 * @description  It is one of the UITableView delegate method
 * @date         06/03/2019...
 * @method       tableView:--  didSelectRowAtIndexPath:--
 * @author       roja
 * @param        UITableView
 * @param        NSIndexPath
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
//    if (tableView == loyaltyTypeTable) {
//
//        [editPricePopOver dismissPopoverAnimated:YES];
//        loyaltyTypeTable.hidden = YES;
//        loyaltyTypetxt.text = [NSString stringWithFormat:@"%ld",(indexPath.row + 1)];
//    }

     if (tableView == giftVoucherDetailsTable){
    
        @try {
            
            // added by roja on 06/03/2019 ...
            if([selectGiftVoucherArr count]){
                
                NSString * errMsg = @"Only 1 voucher can be issued at a time.";
                
                float y_axis = self.view.frame.size.height - 150;

                [self displayAlertMessage:errMsg horizontialAxis:(self.view.frame.size.width-200)/2 verticalAxis:y_axis msgType:@"" conentWidth:200 contentHeight:40 isSoundRequired:YES timming:2.0 noOfLines:2];

            }
            else{
                
            NSDictionary * giftVoucherDetailsDic = giftVoucherDetailsArr[indexPath.row];
            
            selectedVoucherNoPosition = (int)indexPath.row;
            
            giftVoucherTF.text =  [self checkGivenValueIsNullOrNil:[giftVoucherDetailsDic valueForKey:@"promoName"] defaultReturn:@""];
            
            giftVoucherValueTF.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[giftVoucherDetailsDic valueForKey:@"unitCashValue"] defaultReturn:@"0.00"] floatValue]];
            
            voucherPromoCodeStr = [self checkGivenValueIsNullOrNil:[giftVoucherDetailsDic valueForKey:@"voucherProgramCode"] defaultReturn:@""];
            
            if ([giftVoucherCodeTF.text length] != 0) {
                giftVoucherCodeTF.text = @"";
            }
            
            [editPricePopOver dismissPopoverAnimated:YES];
                
            }
            
            // added by roja on 06/03/2019..
            // commented by roja on 06/03/2019... // reason old code
            
            //        NSDictionary *gvInfoDic = idslist[indexPath.row];
            //        selectCashValuePosition = (int)indexPath.row;
            //        numberOfVouchers = [[gvInfoDic valueForKey:@"totalVouchers"] intValue];
            //        idTypetxt.text = [NSString stringWithFormat:@"%.1f",[[gvInfoDic valueForKey:@"unitCashValue"] floatValue]];
            //        giftVoucherDetailsTable.hidden = YES;
            //        [editPricePopOver dismissPopoverAnimated:YES];
            //        [self giftVoucherValuePopUp:selectVoucherValueBtn];
            
            
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
   else if (tableView == giftVoucherCodeDetailsTable) {
       
       @try {
           
           NSDictionary * giftVoucherCodeDetailsDic = giftVoucherCodeDetailsArray[indexPath.row];
           
           giftVoucherCodeTF.text =  [self checkGivenValueIsNullOrNil:[giftVoucherCodeDetailsDic valueForKey:@"voucherCode"] defaultReturn:@""];
           
           [editPricePopOver dismissPopoverAnimated:YES];
           
       } @catch (NSException *exception) {
           
       } @finally {
           
       }
    }
    
}

#pragma mark End of Table view methods

-(void)backAction {
    if ((usernametxt.text).length>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


/**
 * @description  In this method we are delete the row on selection of delete(action) button
 * @date         06/03/2019...
 * @method       delRow
 * @author       roja
 * @param
 * @param        UIButton
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)delRow:(UIButton *)sender {
    [selectGiftVoucherArr removeObjectAtIndex:sender.tag];
    [selectGiftVoucherTable reloadData];
}



-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}
- (void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 * @description  Here we are checkings null values.. if input is Null or nill we will return default.
 * @date         06/03/2019...
 * @method       checkGivenValueIsNullOrNil:--   defaultReturn:--
 * @author       roja
 * @param        NSString
 * @param        id
 * @return       id
 *
 * @modified BY
 * @reason
 *
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
 * @description  Here we are displaying the Pop up view on selection of gift voucher details button..
 * @date
 * @method       giftVoucherCodeDetailsPopUp
 * @author
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified BY  Roja
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)giftVoucherCodeDetailsPopUp{
    
    // added by roja on 13/03/2019..
    float voucherCodeTblHeight = 0;
    
    if ([giftVoucherCodeDetailsArray count] && giftVoucherCodeDetailsArray != nil) {
        
        voucherCodeTblHeight =  [giftVoucherCodeDetailsArray count] * 40;
        
        if ([giftVoucherCodeDetailsArray count] >= 3) {
            
            voucherCodeTblHeight = 3 * 40;
        }
        // upto here added by roja on 13/03/2019..

        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *editPriceView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, giftVoucherCodeTF.frame.size.width, voucherCodeTblHeight)];
        editPriceView.opaque = NO;
        editPriceView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        editPriceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        editPriceView.layer.borderWidth = 2.0f;
        [editPriceView setHidden:NO];
        
        giftVoucherCodeDetailsTable = [[UITableView alloc] init];
        giftVoucherCodeDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
        giftVoucherCodeDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
        giftVoucherCodeDetailsTable.layer.cornerRadius = 4.0f;
        giftVoucherCodeDetailsTable.layer.borderWidth = 1.0f;
        giftVoucherCodeDetailsTable.dataSource = self;
        giftVoucherCodeDetailsTable.delegate = self;
        giftVoucherCodeDetailsTable.bounces = FALSE;
        giftVoucherCodeDetailsTable.frame = CGRectMake(0.0, 0.0, editPriceView.frame.size.width, editPriceView.frame.size.height);
        
        [editPriceView addSubview:giftVoucherCodeDetailsTable];
        customerInfoPopUp.view = editPriceView;
        
        
        customerInfoPopUp.preferredContentSize =  CGSizeMake(editPriceView.frame.size.width, editPriceView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:giftVoucherCodeTF.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        editPricePopOver= popover;
        
        //    giftVoucherCodeDetailsTable.hidden = NO;
    }
    
}



/**
 * @description  Here we are calling 'GiftVouchersServices' to get Gift Vouchers By Search Criteria....
 * @date         06/03/2019
 * @method       getGiftVoucherCodeDetailsList
 * @author       Roja
 * @param
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getGiftVoucherCodeDetailsList{
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        NSArray * giftVoucherCodeKeys = @[@"requestHeader",@"searchCriteria",@"startIndex",@"voucherProgramCode"];
        
        NSArray * giftVoucherCodeObj = @[[RequestHeader getRequestHeader],giftVoucherCodeTF.text,ZERO_CONSTANT,voucherPromoCodeStr];
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:giftVoucherCodeObj forKeys:giftVoucherCodeKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * giftvoucherCodeRequestStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceContr = [WebServiceController new];
        webServiceContr.giftVoucherSrvcDelegate = self;
        [webServiceContr getGiftVouchersBySearchCriteria:giftvoucherCodeRequestStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
}


/**
 * @description  Here we are handling success response of gift voucher by search criteria..
 * @date         06/03/2019
 * @method       getGiftVoucherBySearchCriteriaSuccessResponse
 * @author       Roja
 * @param
 * @param        NSDictionary
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getGiftVoucherBySearchCriteriaSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        /*
         
         {
             claimStatus = 0;
             giftVouchersChildList =     (
                         {
                     assignedStatus = 0;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000013;
                     voucherId = 20639;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 },
                         {
                     assignedStatus = 0;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000016;
                     voucherId = 18596;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 },
                         {
                     assignedStatus = 0;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000014;
                     voucherId = 27232;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 },
                         {
                     assignedStatus = 0;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000017;
                     voucherId = 13720;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 },
                         {
                     assignedStatus = 0;
                     maxRecords = 0;
                     saveGiftVoucherFlag = 0;
                     voucherCode = VC10000000000015;
                     voucherId = 27733;
                     voucherProgramCode = GV10005;
                     voucherStatus = 1;
                 }
             );
             responseHeader =     {
                 responseCode = 0;
                 responseMessage = Success;
             };
             totalRecords = 5;
         }

         */
        
        NSArray * giftVouchersArray = [self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"giftVouchersChildList"] defaultReturn:@""];
        
        giftVoucherCodeDetailsArray = [[NSMutableArray alloc]init];
        
        for (NSDictionary * dic in giftVouchersArray) {
            
            NSMutableDictionary * giftVoucherDetailsDic = [[NSMutableDictionary alloc]init];
            
            if([[dic valueForKey:@"assignedStatus"] boolValue] == 0){
                
                [giftVoucherDetailsDic setValue:[dic valueForKey:@"voucherCode"] forKey:@"voucherCode"];
                [giftVoucherCodeDetailsArray addObject:giftVoucherDetailsDic];
            }
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        
        [self giftVoucherCodeDetailsPopUp];
        [giftVoucherCodeDetailsTable reloadData];
    }
}


/**
 * @description  Here we are handling error response of gift voucher by search criteria..
 * @date         06/03/2019
 * @method       getGiftVoucherBySearchCriteriaFailureResponse
 * @author       Roja
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getGiftVoucherBySearchCriteriaFailureResponse:(NSString *)failureString{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:failureString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}


/**
 * @description  Here we are adding the selected gift voucher to the row
 * @date         06/03/2019
 * @method       addGiftVoucherDetailsBtn
 * @author       Roja
 * @param
 * @param        UIButton
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)addGiftVoucherDetailsBtn:(UIButton *)sender {
    
    @try {
        
        if ([giftVoucherTF.text length] == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select any gift voucher" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if ([giftVoucherCodeTF.text length] == 0 || [giftVoucherCodeTF.text length] != 16) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter voucher code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else {
            
            if ([giftVoucherDetailsArr count]) {
                
                NSMutableDictionary * tempDic = [[NSMutableDictionary alloc]init];
                NSDictionary * selectedGiftVoucherDic = [giftVoucherDetailsArr objectAtIndex:selectedVoucherNoPosition];
                
                BOOL voucherCodeExists = false;
                
                for (NSDictionary * existingGiftVouchersDic in selectGiftVoucherArr) {
                    
                    if ([[existingGiftVouchersDic valueForKey:@"voucherCode"] isEqualToString:giftVoucherCodeTF.text]) {
                        
                        voucherCodeExists = true;
                    }

                }
                
                if (voucherCodeExists) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Voucher already used" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                
                else{
                    [tempDic setValue:[selectedGiftVoucherDic valueForKey:@"createdOn"] forKey:@"createdOn"];
                    [tempDic setValue:[selectedGiftVoucherDic valueForKey:@"expiryDate"] forKey:@"expiryDate"];
                    [tempDic setValue:[selectedGiftVoucherDic valueForKey:@"status"] forKey:@"status"];
                    [tempDic setValue:[selectedGiftVoucherDic valueForKey:@"promoName"] forKey:@"promoName"];
                    [tempDic setValue:[selectedGiftVoucherDic valueForKey:@"unitCashValue"] forKey:@"unitCashValue"];
                    [tempDic setValue:[selectedGiftVoucherDic valueForKey:@"voucherProgramCode"] forKey:@"voucherProgramCode"];
                    [tempDic setValue:[selectedGiftVoucherDic valueForKey:@"voucherProgramCode"] forKey:@"voucherPrgCode"];
                    [tempDic setValue:giftVoucherCodeTF.text forKey:@"voucherCode"];
                    [tempDic setValue:[selectedGiftVoucherDic valueForKey:@"isPaid"] forKey:@"isPaid"];
                    
                    [selectGiftVoucherArr addObject:tempDic];
                    
                    
                    /*
                     
                     <__NSArrayM 0x600002021290>(
                     {
                         createdOn = "Dec 3, 2019 12:00:00 AM";
                         expiryDate = "Dec 7, 2019 12:00:00 AM";
                         isPaid = 1;
                         promoName = "Pay_Voucher";
                         status = Active;
                         unitCashValue = 100;
                         voucherCode = VC10000000000016;
                         voucherPrgCode = GV10005;
                         voucherProgramCode = GV10005;
                     }
                     )

                     
                     */
                }
                
                [selectGiftVoucherTable reloadData];
                [selectGiftVoucherTable setHidden:NO];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        giftVoucherCodeTF.text = @"";
        giftVoucherValueTF.text = @"";
        giftVoucherTF.text = @"";
    }
}


/**
 * @description  Here we are calling 'GiftVouchersServices' to issue the gift voucher..
 * @date         06/03/2019
 * @method       submitButtonAction
 * @author       Roja
 * @param
 * @param        UIButton
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)submitButtonAction:(UIButton *) sender{
    
    @try {
        
        if([phNotxt.text length] != 10){
            
            [phNotxt becomeFirstResponder];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter valid mobile number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if([firstNameTF.text length] == 0){
            
            [firstNameTF becomeFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter your name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if([emiltxt.text length] && ![WebServiceUtility validateEmail:emiltxt.text]){
            
            [emiltxt becomeFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter valid email id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if([selectGiftVoucherArr count] == 0 || selectGiftVoucherArr == nil){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please add atleast one gift voucher" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else{
            
            AudioServicesPlaySystemSound (soundFileObject);
            
            NSMutableDictionary * customerDetailsDic = [[NSMutableDictionary alloc]init];
            
            [customerDetailsDic setValue:firstNameTF.text forKey:@"name"];
            [customerDetailsDic setValue:phNotxt.text forKey:@"phone"];
            [customerDetailsDic setValue:emiltxt.text forKey:@"email"];
            [customerDetailsDic setValue:localityTF.text forKey:@"locality"];
            [customerDetailsDic setValue:customerCityTF.text forKey:@"city"];
            [customerDetailsDic setValue:lastNameTF.text forKey:@"lastName"];
            [customerDetailsDic setValue:customerAddressTF.text forKey:@"street"];
            // customerID && customer category has to send..
            
            NSArray * issueVoucherKeys = @[@"requestHeader",@"customerObj",@"locations",@"vouchersList"];
            
            NSArray * issueVoucherObjects = @[[RequestHeader getRequestHeader],customerDetailsDic,presentLocation,selectGiftVoucherArr];
            
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:issueVoucherObjects forKeys:issueVoucherKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * issueGiftVoucherStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            
            NSDictionary * selectedVoucherDic = [selectGiftVoucherArr objectAtIndex:0];
            
            
            if([selectedVoucherDic valueForKey:@"isPaid"]){
                
                NSMutableDictionary * voucherItemDic = [[NSMutableDictionary alloc] init];
                NSMutableArray * taxesList = [[NSMutableArray alloc] init];

                
                [voucherItemDic setValue:@"" forKey:@"UOM"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"availQty"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"balanceQty"];
                [voucherItemDic setValue:@"" forKey:@"batch"];
                [voucherItemDic setValue:@"" forKey:@"billId"];
                [voucherItemDic setValue:@"" forKey:@"billItems"];
                [voucherItemDic setValue:@"" forKey:@"bill_item_id"];
                [voucherItemDic setValue:@"" forKey:@"billedDate"];
                [voucherItemDic setValue:@"" forKey:@"brand"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"cgstTaxValue"];
                [voucherItemDic setValue:@"" forKey:@"color"];
                [voucherItemDic setValue:[NSNumber numberWithFloat:0] forKey:@"costPrice"];
                [voucherItemDic setValue:@"" forKey:@"department"];
                [voucherItemDic setValue:@"" forKey:@"discountId"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"discountPercentage"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"discountPrice"];
                [voucherItemDic setValue:@"0" forKey:@"discountPriceStr"];
                [voucherItemDic setValue:@"" forKey:@"discountType"];
                [voucherItemDic setValue:@"" forKey:@"ean"];
                [voucherItemDic setValue:@"" forKey:@"editPriceReason"];
                
                [voucherItemDic setValue:[NSNumber numberWithBool:0] forKey:@"editable"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"editedPrice"];
                [voucherItemDic setValue:@"" forKey:@"employeeName"];
                [voucherItemDic setValue:@"" forKey:@"employeeSaleId"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"exchangeQty"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"exchangecgstTaxValue"];
                [voucherItemDic setValue:[NSNumber numberWithFloat:0] forKey:@"exchangeitemCost"];
                [voucherItemDic setValue:@"" forKey:@"exchangeitemDiscountStr"];
                [voucherItemDic setValue:[NSNumber numberWithFloat:0] forKey:@"exchangenetCost"];
                
                
                [voucherItemDic setValue:[NSNumber numberWithFloat:0] forKey:@"exchangesgstTaxValue"];
                [voucherItemDic setValue:@"" forKey:@"expiryDate"];
                [voucherItemDic setValue:@"" forKey:@"expiryDateStr"];
                [voucherItemDic setValue:[NSNumber numberWithFloat:0] forKey:@"gross"];
                [voucherItemDic setValue:@"" forKey:@"hsnCode"];
                [voucherItemDic setValue:@"" forKey:@"itemDiscountDesc"];
                [voucherItemDic setValue:@"0" forKey:@"itemDiscountStr"];
                [voucherItemDic setValue:[NSNumber numberWithFloat:0] forKey:@"itemPriceWithoutTax"];
                [voucherItemDic setValue:[NSNumber numberWithBool:0] forKey:@"itemTaxExclusive"];
                [voucherItemDic setValue:[NSNumber numberWithBool:0] forKey:@"itemTaxable"];
                [voucherItemDic setValue:@"" forKey:@"model"];
                
                [voucherItemDic setValue:@"" forKey:@"pattern"];
                [voucherItemDic setValue:@"" forKey:@"productClass"];
                [voucherItemDic setValue:@"" forKey:@"productRange"];
                [voucherItemDic setValue:@"" forKey:@"productSubClass"];
                [voucherItemDic setValue:@"" forKey:@"promoDetail"];
                [voucherItemDic setValue:@"" forKey:@"promoDetails"];
                [voucherItemDic setValue:@"" forKey:@"promoItemFlag"];
                [voucherItemDic setValue:@"" forKey:@"returncgstTaxValue"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"returnitemCost"];
                [voucherItemDic setValue:@"" forKey:@"returnitemDiscountStr"];
                [voucherItemDic setValue:@"" forKey:@"returnnetCost"];
                [voucherItemDic setValue:@"" forKey:@"returnsgstTaxValue"];
                [voucherItemDic setValue:@"" forKey:@"row_updated_date"];
                [voucherItemDic setValue:@"" forKey:@"section"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"sequenceNum"];
                [voucherItemDic setValue:@"" forKey:@"sgstTaxValue"];
                [voucherItemDic setValue:@"" forKey:@"size"];
                [voucherItemDic setValue:@"" forKey:@"status"];
                [voucherItemDic setValue:@"" forKey:@"storeLocation"];
                [voucherItemDic setValue:@"" forKey:@"style"];
                [voucherItemDic setValue:@"" forKey:@"subCategory"];
                [voucherItemDic setValue:@"" forKey:@"subDepartment"];
                [voucherItemDic setValue:@"" forKey:@"taxCode"]; //""
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"taxCost"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"taxRate"]; //0
                [voucherItemDic setValue:[NSNumber numberWithBool:0] forKey:@"trackingRequired"];
                [voucherItemDic setValue:@"" forKey:@"utility"];
                [voucherItemDic setValue:@"" forKey:@"voidItemReason"];
                [voucherItemDic setValue:[NSNumber numberWithBool:1] forKey:@"zeroStock"];
                [voucherItemDic setValue:[NSNumber numberWithFloat:0] forKey:@"itemDiscount"];
                [voucherItemDic setValue:[NSNumber numberWithBool:0] forKey:@"manufacturedItem"];

                [voucherItemDic setValue:[NSNumber numberWithInt:1] forKey:@"measureRange"];
                [voucherItemDic setValue:[NSNumber numberWithInt:1] forKey:@"pack_size"];
                [voucherItemDic setValue:[NSNumber numberWithBool:0] forKey:@"packed"];
                
                [voucherItemDic setValue:@"" forKey:@"itemType"]; // ?
                [voucherItemDic setValue:@"" forKey:@"item_category"]; //??
                [voucherItemDic setValue:@"Gift Voucher" forKey:@"category"];

                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"unitCashValue"] forKey:@"itemCost"];
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"unitCashValue"] forKey:@"mrp"];
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"unitCashValue"] forKey:@"price"];
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"unitCashValue"] forKey:@"mrpPrice"];
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"unitCashValue"] forKey:@"netCost"];
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"unitCashValue"] forKey:@"item_total_price"];
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"unitCashValue"] forKey:@"itemUnitPrice"];
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"unitCashValue"] forKey:@"itemUnitPriceStr"];
                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"originalMRP"]; //0

                [voucherItemDic setValue:[NSNumber numberWithInt:0] forKey:@"returnQty"];

                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"voucherProgramCode"]  forKey:@"sku_id"]; //
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"voucherCode"] forKey:@"pluCode"];
                [voucherItemDic setValue:@"" forKey:@"itemScanCode"]; // sku ?
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"promoName"] forKey:@"itemName"];
                [voucherItemDic setValue:[selectedVoucherDic valueForKey:@"promoName"] forKey:@"item_name"];
                
                [voucherItemDic setValue:[NSNumber numberWithInt:1] forKey:@"quantity"];//1

                [voucherItemDic setValue:@"Gift Voucher" forKey:@"description"];//1

                
                
                [voucherItemDic setValue:taxesList  forKey:@"itemTaxesList"];
                [voucherItemDic setValue:taxesList forKey:@"tax"];

                
                /*
                 {
                     UOM = "";
                     availQty = 0;
                     balanceQty = 0;
                     batch = "";
                     billId = "";
                     billItems = "";
                     "bill_item_id" = "";
                     billedDate = "";
                     brand = "";
                     category = "Gift Voucher";
                     cgstTaxValue = 0;
                     color = "";
                     costPrice = 0;
                     department = "";
                     description = "Gift Voucher";
                     discountId = "";
                     discountPercentage = 0;
                     discountPrice = 0;
                     discountPriceStr = 0;
                     discountType = "";
                     ean = "";
                     editPriceReason = "";
                     editable = 0;
                     editedPrice = 0;
                     employeeName = "";
                     employeeSaleId = "";
                     exchangeQty = 0;
                     exchangecgstTaxValue = 0;
                     exchangeitemCost = 0;
                     exchangeitemDiscountStr = "";
                     exchangenetCost = 0;
                     exchangesgstTaxValue = 0;
                     expiryDate = "";
                     expiryDateStr = "";
                     gross = 0;
                     hsnCode = "";
                     itemCost = 100;
                     itemDiscount = 0;
                     itemDiscountDesc = "";
                     itemDiscountStr = 0;
                     itemName = "Pay_Voucher";
                     itemPriceWithoutTax = 0;
                     itemScanCode = "";
                     itemTaxExclusive = 0;
                     itemTaxable = 0;
                     itemTaxesList =     (
                     );
                     itemType = "";
                     itemUnitPrice = 100;
                     itemUnitPriceStr = 100;
                     "item_category" = "";
                     "item_name" = "Pay_Voucher";
                     "item_total_price" = 100;
                     manufacturedItem = 0;
                     measureRange = 1;
                     model = "";
                     mrp = 100;
                     mrpPrice = 100;
                     netCost = 100;
                     originalMRP = 0;
                     "pack_size" = 1;
                     packed = 0;
                     pattern = "";
                     pluCode = VC10000000000013;
                     price = 100;
                     productClass = "";
                     productRange = "";
                     productSubClass = "";
                     promoDetail = "";
                     promoDetails = "";
                     promoItemFlag = "";
                     quantity = 1;
                     returnQty = 0;
                     returncgstTaxValue = "";
                     returnitemCost = 0;
                     returnitemDiscountStr = "";
                     returnnetCost = "";
                     returnsgstTaxValue = "";
                     "row_updated_date" = "";
                     section = "";
                     sequenceNum = 0;
                     sgstTaxValue = "";
                     size = "";
                     "sku_id" = GV10005;
                     status = "";
                     storeLocation = "";
                     style = "";
                     subCategory = "";
                     subDepartment = "";
                     tax =     (
                     );
                     taxCode = "";
                     taxCost = 0;
                     taxRate = 0;
                     trackingRequired = 0;
                     utility = "";
                     voidItemReason = "";
                     zeroStock = 1;
                 }

                 */

                BillingHome * billingPageObj = [[BillingHome alloc] init];
                billingPageObj.isPaidVoucher = true;
                billingPageObj.issueVoucherDetailsStr = issueGiftVoucherStr;
                billingPageObj.paidVoucherItemDetailsDic = voucherItemDic;
                
                self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
                [self.navigationController pushViewController:billingPageObj animated:YES];

            }
            else{
                
                [HUD show: YES];
                [HUD setHidden:NO];
                [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];

                WebServiceController * webServContlr = [[WebServiceController alloc]init];
                webServContlr.giftVoucherSrvcDelegate = self;
                [webServContlr issueGiftVoucherToCustomer:issueGiftVoucherStr];
            }
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);

    } @finally {
        
    }
}


/**
 * @description  Here we are handling success response of issue gift voucher to cutomer...
 * @date         06/03/2019
 * @method       issueGiftVoucherToCustomerSuccessResponse:-- successDictionary:--
 * @author       Roja
 * @param
 * @param        UIButton
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)issueGiftVoucherToCustomerSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        float y_axis = self.view.frame.size.height - 200;
        NSString * mesg = @"Voucher issued successfully";
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"SUCCESS"  conentWidth:350 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

- (void)issueGiftVoucherToCustomerFailureResponse:(NSString *)failureString{
    
    @try {
        float y_axis = self.view.frame.size.height - 150;
        
        [self displayAlertMessage:failureString horizontialAxis:(self.view.frame.size.width-200)/2 verticalAxis:y_axis msgType:@"" conentWidth:200 contentHeight:40 isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}




-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines {
    
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
            
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
//        userAlertMessageLbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        userAlertMessageLbl.backgroundColor = [UIColor whiteColor];
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
            
            
            userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
            
        }
        else{
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

// Commented by roja on 12/03/2019...
// Below commented methods are not neccessary as per Latest GUI ...


/*
 
//get loyalty pograms...
 
 -(void)getAllAvailableVouchers {
 
 
     GiftVoucherServicesSoapBinding *skuService = [GiftVoucherServices GiftVoucherServicesSoapBinding] ;
 
     GiftVoucherServices_getAvailableVouchers *voucher = [[GiftVoucherServices_getAvailableVouchers alloc] init];
 
 
     NSArray *loyaltyKeys = @[@"requestHeader", @"storeLocation", @"locations"];
 
     NSArray *loyaltyObjects = @[[RequestHeader getRequestHeader],presentLocation, presentLocation];
     NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
 
     NSError * err_;
     NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
     NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
 
 
     voucher.getVoucherDetails = loyaltyString;
     @try {
 
         GiftVoucherServicesSoapBindingResponse *response = [skuService getAvailableVouchersUsingParameters:voucher];
         NSArray *responseBodyParts = response.bodyParts;
         for (id bodyPart in responseBodyParts) {
             if ([bodyPart isKindOfClass:[GiftVoucherServices_getAvailableVouchersResponse class]]) {
                 GiftVoucherServices_getAvailableVouchersResponse *body = (GiftVoucherServices_getAvailableVouchersResponse *)bodyPart;
                 printf("\nresponse=%s",(body.return_).UTF8String);
                 NSError *e;
                 NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                      options: NSJSONReadingMutableContainers
                                                                        error: &e];
                 idslist = [[NSMutableArray alloc] initWithArray:[JSON valueForKey:@"vouchersList"]];
             }
         }
     }
     @catch (NSException *exception) {
 
         [HUD setHidden:YES];
         NSLog(@"Exception %@",exception.name);
     }
     @finally {
         [HUD setHidden:YES];
     }
 }
 
 
 
 -(void)getCustomerDetailsForOffers {
 
 HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
 [self.navigationController.view addSubview:HUD];
 // Regiser for HUD callbacks so we can remove it from the window at the right time
 HUD.delegate = self;
 HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
 HUD.mode = MBProgressHUDModeCustomView;
 // Show the HUD
 [HUD show:YES];
 
 // showing the HUD ..
 [HUD setHidden:NO];
 [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
 
 @try {
 
 //checking for deals & offers...
 CustomerServiceSoapBinding *custBindng =  [CustomerServiceSvc CustomerServiceSoapBinding] ;
 CustomerServiceSvc_getCustomerDetails *aParameters = [[CustomerServiceSvc_getCustomerDetails alloc] init];
 
 NSError * err;
 NSData * jsonData = [NSJSONSerialization dataWithJSONObject:[RequestHeader getRequestHeader] options:0 error:&err];
 NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 
 
 NSArray *loyaltyKeys = @[@"email", @"mobileNumber",@"requestHeader"];
 
 NSArray *loyaltyObjects = @[@"",phNotxt.text,requestHeaderString];
 NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
 
 NSError * err_;
 NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
 NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
 aParameters.phone = loyaltyString;
 
 
 CustomerServiceSoapBindingResponse *response = [custBindng getCustomerDetailsUsingParameters:(CustomerServiceSvc_getCustomerDetails *)aParameters];
 NSArray *responseBodyParts = response.bodyParts;
 for (id bodyPart in responseBodyParts) {
 if ([bodyPart isKindOfClass:[CustomerServiceSvc_getCustomerDetailsResponse class]]) {
 CustomerServiceSvc_getCustomerDetailsResponse *body = (CustomerServiceSvc_getCustomerDetailsResponse *)bodyPart;
 printf("\nresponse=%s",(body.return_).UTF8String);
 NSError *e;
 
 NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
 options: NSJSONReadingMutableContainers
 error: &e];
 
 if ([[NSString stringWithFormat:@"%@",JSON1[@"phone"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",JSON1[@"email"]] isEqualToString:@"<null>"]) {
 
 if ((phNotxt.text).length >= 10) {
 [self provideCustomerRatingfor:NEW_CUSTOMER];
 return;
 }
 }
 else{
 if ((phNotxt.text).length >= 10) {
 
 if (!([[NSString stringWithFormat:@"%@",JSON1[@"category"]] isEqualToString:@"<null>"])) {
 [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@",JSON1[@"category"]]];
 return;
 }
 else {
 [self provideCustomerRatingfor:EXISTING_CUSTOMER];
 return;
 }
 }
 
 }
 
 [HUD setHidden:YES];
 }
 }
 }
 @catch (NSException *exception) {
 
 NSLog(@"%@",exception);
 }
 @finally {
 [HUD setHidden:YES];
 
 }
 }
 
 
 
-(void)getLoyaltyPrograms {
    
    [HUD setHidden:NO];
    loyalTypeList = [[NSMutableArray alloc]init];
    loyaltyPgm = [[NSMutableArray alloc]init];
    
    LoyaltycardServiceSoapBinding *offerBindng =  [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] ;
    LoyaltycardServiceSvc_getAvailableLoyaltyPrograms *aParameters =  [[LoyaltycardServiceSvc_getAvailableLoyaltyPrograms alloc] init];
    
    NSDictionary *dictionary = [RequestHeader getRequestHeader];
    
    NSArray *loyaltyKeys = @[@"requestHeader", @"storeLocation"];
    
    NSArray *loyaltyObjects = @[dictionary, presentLocation];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    aParameters.loyaltyCardDetails = normalStockString;
    @try {
        
        LoyaltycardServiceSoapBindingResponse *response = [offerBindng getAvailableLoyaltyProgramsUsingParameters:aParameters];
        NSArray *bodyParts = response.bodyParts;
        
        for (id bodyPart in bodyParts) {
            if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse class]]) {
                LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse *body = (LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse *)bodyPart;
                printf("\nresponse=%s",(body.return_).UTF8String);
                [HUD setHidden:YES];
                
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                if ([[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseCode"] intValue]==0) {
                    
                    NSArray *arr = [JSON valueForKey:@"availablePrograms"];
                    if (arr.count>0) {
                        for (int i=0; i<arr.count; i++) {
                            
                            NSDictionary *dic = arr[i];
                            [loyalTypeList addObject:[dic valueForKey:@"loyaltyProgramName"]];
                            [loyaltyPgm addObject:[dic valueForKey:@"loyaltyProgramNumber"]];
                            
                        }
                    }
                }
                
                // [self getloyaltyCardNumberHandler:body.return_];
            }
            else {
                [HUD setHidden:YES];
            }
        }
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
    }
}
 
 
 
 // commented by roja on 12/03/2019...
 
 // previousButtonPressed handing...
 - (void) submitButtonPressed:(id) sender {
 
     //Play Audio for button touch....
     AudioServicesPlaySystemSound (soundFileObject);
 
     // PhoNumber validation...
     NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
     NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
     BOOL isNumber = [decimalTest evaluateWithObject:phNotxt.text];
 
 
     // Email validation...
     NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
     NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
     BOOL isMail = [emailTest evaluateWithObject:emiltxt.text];
 
 
 
     if ( (phNotxt.text).length == 0 ) {
 
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter phone no" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
 
     }
     else if (selectGiftVoucherArr.count == 0 ) {
 
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please select Any of Gift Vouchers" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }
     else if((phNotxt.text).length <= 9 || (phNotxt.text).length >= 14 || !isNumber) {
 
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
 
     }
     else {
 
         [HUD setHidden:NO];
 
         GiftVoucherServicesSoapBinding *skuService = [GiftVoucherServices GiftVoucherServicesSoapBinding] ;
 
         GiftVoucherServices_IssueVoucherToCustomer *voucher = [[GiftVoucherServices_IssueVoucherToCustomer alloc] init];
 
         NSArray *customerInfoKeys = @[@"phone", @"name",@"email"];
 
         NSArray *customerInfoObjects = @[phNotxt.text,usernametxt.text,emiltxt.text];
         NSDictionary *customerDic = [NSDictionary dictionaryWithObjects:customerInfoObjects forKeys:customerInfoKeys];
 
 
         NSArray *loyaltyKeys = @[@"requestHeader", @"customerObj", @"vouchersList", @"locations"];
 
         NSArray *loyaltyObjects = @[[RequestHeader getRequestHeader], customerDic, selectGiftVoucherArr,presentLocation];
         NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
 
         NSError * err_;
         NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
         NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
 
 
         voucher.createIssueDetails = loyaltyString;
         @try {
 
             GiftVoucherServicesSoapBindingResponse *response = [skuService IssueVoucherToCustomerUsingParameters:voucher];
             NSArray *responseBodyParts = response.bodyParts;
             for (id bodyPart in responseBodyParts) {
                 if ([bodyPart isKindOfClass:[GiftVoucherServices_IssueVoucherToCustomerResponse class]]) {
                     GiftVoucherServices_IssueVoucherToCustomerResponse *body = (GiftVoucherServices_IssueVoucherToCustomerResponse *)bodyPart;
                     printf("\nresponse=%s",(body.return_).UTF8String);
                     NSError *e;
                     NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                          options: NSJSONReadingMutableContainers
                                                                            error: &e];
                     NSLog(@"%@",JSON);
                     if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0 && [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] isEqualToString:@"Success"]) {
                         UIAlertView *returnSuccessAlert = [[UIAlertView alloc] initWithTitle:@"Gift Voucher Issued Successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [returnSuccessAlert show];
                     }
                     else {
                         UIAlertView *returnSuccessAlert = [[UIAlertView alloc] initWithTitle:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [returnSuccessAlert show];
                     }
                 }
             }
         }
         @catch (NSException *exception) {
 
             [HUD setHidden:YES];
             NSLog(@"Exception %@",exception.name);
         }
         @finally {
             [HUD setHidden:YES];
         }
 
     }
 }
 
 //Upto here commented by roja on 12/03/2019...

 
 
 // Handle the response from getloyaltyCardNumber.
 - (void)getloyaltyCardNumberHandler: (NSString *) value {
 
 // Handle errors
 if([value isKindOfClass:[NSError class]]) {
 NSLog(@"%@", value);
 return;
 }
 
 // Handle faults
 //    if([value isKindOfClass:[SoapFault class]]) {
 //        NSLog(@"%@", value);
 //        return;
 //    }
 
 
 // Do something with the NSString* result
 NSString* result = (NSString*)value;
 
 NSError *e;
 NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
 options: NSJSONReadingMutableContainers
 error: &e];
 
 resultId.text = [NSString stringWithFormat:@"%@",JSON[@"loyaltyCardNumber"]];
 
 if ([[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseCode"] intValue]==0) {
 
 if (result.length >= 1) {
 
 resultId.text = result;
 
 [HUD setHidden:YES];
 
 uiAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"Loyalty Card Issued. Your Loyalty No. is %@", [JSON valueForKey:@"loyaltyCardNumber"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [uiAlert show];
 
 //        NSArray *temp = [result componentsSeparatedByString:@"#"];
 //        randomNum = [temp objectAtIndex:1];
 //
 //        //send loyaltycard number format from selected option...
 //        if ([loyaltyTypetxt.text isEqualToString:@"Platinum"]) {
 //
 //            loyaltyTypetxt.text = @"LP00000000000001";
 //        }
 //        else if([loyaltyTypetxt.text isEqualToString:@"Diamond"]){
 //
 //            loyaltyTypetxt.text = @"LP00000000000002";
 //        }
 //        else if([loyaltyTypetxt.text isEqualToString:@"Gold"]){
 //
 //            loyaltyTypetxt.text = @"LP00000000000003";
 //        }
 //        else if([loyaltyTypetxt.text isEqualToString:@"Silver"]){
 //
 //            loyaltyTypetxt.text = @"LP00000000000004";
 //        }
 //        else{
 //            loyaltyTypetxt.text = @"LP00000000000005";
 //        }
 
 // Create the service
 //        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
 //        service.logging = YES;
 //
 //        // Returns NSString*.
 //       // [service supplyLoyaltyCard:self action:@selector(supplyLoyaltyCardHandler:) customerName: usernametxt.text phone: phNotxt.text email: emiltxt.text idType: idTypetxt.text idCardNumber: idNotxt.text loyaltyProgramNumber: loyaltyTypetxt.text loyaltyCardNumber: randomNum];
 //
 //        NSLog(@"%@",loyaltyTypetxt.text);
 //
 //       [service supplyLoyaltyCard:self action:@selector(supplyLoyaltyCardHandler:) customerName: usernametxt.text phone: phNotxt.text email: emiltxt.text idType: idTypetxt.text idCardNumber: idNotxt.text loyaltyProgramNumber:loyaltyTypetxt.text loyaltyCardNumber: result];
 //        {"idCardNumber":null,"customerName":null,"idType":null,"loyaltyProgramNumber":null,"phone":null,"email":null,"loyaltyCardNumber":null,"requestHeader":null}
 
 
 //        LoyaltycardServiceSoapBinding *offerBindng =  [[LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] retain];
 //        LoyaltycardServiceSvc_supplyLoyaltyCard *aParameters =  [[LoyaltycardServiceSvc_supplyLoyaltyCard alloc] init];
 //
 //        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
 //        NSArray *str = [time componentsSeparatedByString:@" "];
 //        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
 //        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
 //
 //        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
 //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
 //
 //
 //        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"idCardNumber", @"customerName",@"idType",@"loyaltyProgramNumber",@"phone",@"email",@"loyaltyCardNumber",@"requestHeader", nil];
 //
 //        NSArray *loyaltyObjects = [NSArray arrayWithObjects:idNotxt.text,usernametxt.text,idTypetxt.text,loyaltyTypetxt.text,phNotxt.text,emiltxt.text,[NSString stringWithFormat:@"%@",[JSON objectForKey:@"loyaltyCardNumber"]],dictionary, nil];
 //        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
 //
 //        NSError * err_;
 //        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
 //        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
 
 // aParameters.loyaltyCardDetails = loyaltyString;
 //        aParameters.customerName = usernametxt.text;
 //        aParameters.phone = phNotxt.text;
 //        aParameters.email = emiltxt.text;
 //        aParameters.idType = idTypetxt.text;
 //        aParameters.idCardNumber = idNotxt.text;
 //        aParameters.loyaltyProgramNumber = loyaltyTypetxt.text;
 //        aParameters.loyaltyCardNumber = result;
 
 //        LoyaltycardServiceSoapBindingResponse *response = [offerBindng supplyLoyaltyCardUsingParameters:(LoyaltycardServiceSvc_supplyLoyaltyCard *)aParameters];
 //        NSArray *responseBodyParts = response.bodyParts;
 //        for (id bodyPart in responseBodyParts) {
 //            if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_supplyLoyaltyCardResponse class]]) {
 //                LoyaltycardServiceSvc_supplyLoyaltyCardResponse *body = (LoyaltycardServiceSvc_supplyLoyaltyCardResponse *)bodyPart;
 //                printf("\nresponse=%s",[body.return_ UTF8String]);
 //                [self supplyLoyaltyCardHandler:body.return_];
 //            }
 //        }
 }
 }
 else{
 
 [HUD setHidden:YES];
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseMessage"]]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 
 }
 }
 
 
 // Handle the response from supplyLoyaltyCard.
 
 - (void) supplyLoyaltyCardHandler: (NSString *) value {
 
 // Handle errors
 if([value isKindOfClass:[NSError class]]) {
 NSLog(@"%@", value);
 return;
 }
 
 // Do something with the NSString* result
 NSString* result = (NSString*)value;
 [HUD setHidden:YES];
 
 if ([result isEqualToString:@"This loyalty Card Number is already issued"]) {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:result delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 }
 else{
 //[self sendSMS]; // send sms...
 //Mail Sending to user.....
 mailView    = [[UIView alloc] init];
 (mailView.layer).borderWidth = 1.0f;
 (mailView.layer).cornerRadius = 8.0f;
 mailView.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:mailView];
 
 // get the sender credentials from database ..
 NSString *emailText1 = NULL;
 NSString *password = NULL;
 NSString *mailHost = NULL;
 // NSString *portNumber = NULL;
 
 NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
 
 if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
 
 const char *sqlStatement = "select * from EmailCredentials";
 
 if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
 while (sqlite3_step(selectStmt) == SQLITE_ROW) {
 
 emailText1 = @((char *)sqlite3_column_text(selectStmt, 0));
 password = @((char *)sqlite3_column_text(selectStmt, 1));
 mailHost = @((char *)sqlite3_column_text(selectStmt, 2));
 //portNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 3)];
 }
 sqlite3_finalize(selectStmt);
 }
 }
 
 selectStmt = nil;
 sqlite3_close(database);
 
 //        if (emailText1 != NULL || password != NULL || mailHost != NULL) {
 //
 //            //  hud loading screen ..
 //            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
 //            [self.navigationController.view addSubview:HUD];
 //
 //            // Set the hud to display with a color
 //           // HUD = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
 //
 //            HUD.delegate = self;
 //            HUD.labelText = @"Sending Mail";
 //            [HUD show:YES];
 //
 //            NKDCode128Barcode *barcode = [[NKDCode128Barcode alloc]initWithContent:resultId.text printsCaption:NO];
 ////            [barcode calculateWidth];
 //            [barcode setWidth:250.0];
 //            [barcode description];
 //            [barcode setBarWidth:1.0];
 //            UIImage *image = [UIImage imageFromBarcode:barcode];
 //            NSData *imgdata = UIImagePNGRepresentation(image);
 //
 //            // NSString *documentdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
 //
 //           // NSString *imgFile = [documentdir stringByAppendingString:@"/loyalty.png"];
 //          //  NSString *base64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
 //
 //           // NSString *imgString = [NSString stringWithFormat:@"data:image/jpeg;base64,%@",base64];
 ////            [imageData writeToFile:imgFile atomically:YES];
 //
 ////            SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
 ////            testMsg.fromEmail = emailText1;
 ////            testMsg.relayHost = mailHost;
 ////            testMsg.toEmail = emiltxt.text;
 ////            NSArray *arry = [emailText1 componentsSeparatedByString:@"@"];
 ////            if ([[arry objectAtIndex:1] isEqualToString:@"technolabssoftware.com"]) {
 ////                testMsg.wantsSecure = NO;
 ////            }
 ////            else{
 ////                testMsg.wantsSecure = YES;
 ////            }
 ////
 ////            testMsg.requiresAuth = YES;
 ////
 ////            if (testMsg.requiresAuth) {
 ////                testMsg.login = emailText1;
 ////                testMsg.pass= password;
 ////
 ////            }
 ////            testMsg.subject = @"This is mail from OmniRetailer ..";
 ////            testMsg.delegate = self;
 //
 //            //email contents
 //
 ////            NKDUPCEBarcode * code = [[NKDUPCEBarcode alloc] initWithContent:result];
 ////            UIImage * generatedImage = [UIImage imageFromBarcode:code];  // ..or as a less accurate UIImage
 //
 ////            NSString * bodyMessage = [NSString stringWithFormat:@"%@%@%@%@",@"This is mail from OmniRetailer.",@"Your Loyalty ID is :",generatedImage,resultId.text];
 //
 ////            NSString *bodyMessage = [NSString stringWithFormat:@"%@",[self emailBill:imgString loyaltyNumber:resultId.text name:usernametxt.text]];
 ////
 ////            NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/html",kSKPSMTPPartContentTypeKey,
 ////                                       bodyMessage,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
 ////
 ////            //add attachment.....
 ////
 ////            NSDictionary *attachment = [NSDictionary dictionaryWithObjectsAndKeys:@"text/jpeg",kSKPSMTPPartContentTypeKey,@"inline",kSKPSMTPPartContentDispositionKey,imgString,kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey, nil];
 ////
 ////
 ////            testMsg.parts = [NSArray arrayWithObjects:plainPart,attachment,nil];
 ////
 ////            [testMsg send];
 //
 //
 //
 //            MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
 //            smtpSession.hostname = mailHost;
 //            smtpSession.port = 465;
 //            smtpSession.username = emailText1;
 //            smtpSession.password = password;
 //            smtpSession.authType = MCOAuthTypeSASLPlain;
 //            smtpSession.connectionType = MCOConnectionTypeTLS;
 //            [smtpSession setCheckCertificateEnabled:NO];
 //
 //            NSData *rfc822Data = NULL;
 //
 //            MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
 //            MCOAddress *from = [MCOAddress addressWithMailbox:emailText1];
 //            MCOAddress *to = [MCOAddress addressWithMailbox:[emiltxt.text copy]];
 //            [[builder header] setFrom:from];
 //            [[builder header] setTo:@[to]];
 //            [[builder header] setSubject:@"This  mail is from OmniRetailer ..."];
 //
 //
 //            MCOAttachment *attachment = [MCOAttachment attachmentWithData:imgdata filename:@"loyaltycard"];
 //            NSString *uuuid = [[NSUUID UUID] UUIDString];
 //            [attachment setContentID:uuuid];
 //            [attachment setInlineAttachment:YES];
 //            [builder addRelatedAttachment:attachment];
 //
 //
 //            [builder setHTMLBody:[self emailBill:uuuid loyaltyNumber:resultId.text name:usernametxt.text]];
 //            rfc822Data = [builder data];
 //
 //            MCOSMTPSendOperation *sendOperation =
 //            [smtpSession sendOperationWithData:rfc822Data];
 //            [sendOperation start:^(NSError *error) {
 //                if(error) {
 //                    NSLog(@"Error sending email: %@", error);
 //                    [HUD hide:YES];
 //                    [HUD release];
 //                    [self messageFailed];
 //
 //                }
 //
 //                else {
 //                    [self messageSent];
 //                }
 //            }];
 //
 //        }
 //        else {
 //
 //
 //            UILabel *label1 = [[UILabel alloc] init] ;
 //            label1.text = @"Please configure \nSender Mail";
 //            label1.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
 //            label1.backgroundColor = [UIColor clearColor];
 //            label1.numberOfLines = 2;
 //            label1.textAlignment = NSTextAlignmentCenter;
 //            label1.textColor = [UIColor blackColor];
 //
 //            mailView.hidden = NO;
 //
 //            //[self setSiblings:mailView enabled:TRUE];
 //            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
 //                label1.frame = CGRectMake(0, 10, 220, 70);
 //                mailView.frame = CGRectMake(220, 450, 250, 100);
 //            }
 //            else{
 //                label1.frame = CGRectMake(0, 10, 220, 70);
 //                mailView.frame = CGRectMake(50, 150, 220, 80);
 //            }
 //
 //
 //
 //            [mailView addSubview:label1];
 //
 //            aTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(runScheduledTask:) userInfo:@"mailView" repeats:NO];
 //
 ////
 ////                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please configure mail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 ////                    [alert show];
 ////                    [alert release];
 //        }
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"Loyalty Card Issued. Your Loyalty No. is %@", resultId.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 //        [alert release];
 
 }
 }
 
 //messageFailed handler...
 -(void)messageFailed {
 
 [HUD setHidden:YES];
 
 //[message release];
 
 UILabel *label1 = [[UILabel alloc] init] ;
 label1.text = @"Mail Failed";
 label1.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
 label1.backgroundColor = [UIColor clearColor];
 label1.textAlignment = NSTextAlignmentCenter;
 label1.textColor = [UIColor blackColor];
 
 mailView.hidden = NO;
 
 //[self setSiblings:mailView enabled:TRUE];
 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
 label1.frame = CGRectMake(10, 10, 120, 30);
 label1.textColor = [UIColor blueColor];
 mailView.frame = CGRectMake(300, 550, 170, 50);
 }
 else {
 
 label1.frame = CGRectMake(10, 10, 120, 30);
 mailView.frame = CGRectMake(100, 150, 120, 60);
 
 }
 //    label1.frame = CGRectMake(10, 10, 120, 30);
 //    mailView.frame = CGRectMake(100, 150, 120, 60);
 
 [mailView addSubview:label1];
 aTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:@"mailView" repeats:NO];
 }
 
 
 
  - (NSString *) emailBill:(NSString *)uuid loyaltyNumber:(NSString *)loyaltyNumber name:(NSString *)name {
 
 NSString *str = [NSString stringWithFormat: @" <html><body><table style='border: solid #ccc 1px; border-radius: 15px; color: grey' align='center' width = '500px'><tbody><tr><td style='padding-left:10px;' colspan='2'><img src='cid:%@'></td></tr>",uuid];
 
 str = [NSString stringWithFormat:@"%@%@%@", str,@"<tr style='border-collapse: separate'><td align='center' style='padding-top: 0px; border-bottom: 1px solid grey; padding-bottom: 8px;padding-right:40px'colspan='2'><b style='font-family: monospace;font-size:20px; color: black;'>",loyaltyNumber];
 
 str = [NSString stringWithFormat:@"%@%@%@%@",str, @"</b></td></tr><tr height='25px'><td align='right'    style='padding-right: 10px;padding-left:-50px; font-weight: bold; font-family: sans-serif;'>Name</td><td style='font-weight: bold; font-family: sans-serif;'>",  name ,@"</td></tr><tr height='25px'><td align='right'    style='padding-right: 10px;padding-left:-50px; font-weight: bold; font-family: sans-serif;'>Points</td><td style='font-weight: bold; font-family: sans-serif;'>0</td></tr><tr height='25px'><td align='right'    style='padding-right: 10px;padding-left:-50px; font-weight: bold; font-family: sans-serif;'>Cash</td><td style='font-weight: bold; font-family: sans-serif;'>0</td></tr></tbody></table></body></html>"];
 
 return str;
 }
 
 
 
 //messageSent handler...
 - (void) messageSent
 {
 
 [HUD setHidden:YES];
 
 //[message release];
 
 UILabel *label1 = [[UILabel alloc] init] ;
 label1.text = @"Mail Sent Successfully";
 label1.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
 label1.backgroundColor = [UIColor clearColor];
 label1.textAlignment = NSTextAlignmentCenter;
 label1.textColor = [UIColor blackColor];
 
 mailView.hidden = NO;
 
 //[self setSiblings:mailView enabled:TRUE];
 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
 label1.frame = CGRectMake(10, 10, 300, 30);
 label1.textColor = [UIColor blueColor];
 label1.font = [UIFont boldSystemFontOfSize:20];
 mailView.frame = CGRectMake(230, 850, 300, 50);
 }
 else {
 
 label1.frame = CGRectMake(10, 10, 120, 30);
 mailView.frame = CGRectMake(100, 150, 120, 60);
 
 }
 [mailView addSubview:label1];
 
 aTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(runScheduledTask:) userInfo:@"mailView" repeats:NO];
 
 usernametxt.text = nil;
 phNotxt.text = nil;
 emiltxt.text = nil;
 idTypetxt.text = nil;
 idNotxt.text = nil;
 loyaltyTypetxt.text = nil;
 randomNum = nil;
 }
 
 
 
 
 -(void) sendSMS {
 
 
 // get the sms credentials from database ..
 NSString *provider = NULL;
 NSString *username1 = NULL;
 NSString *password1 = NULL;
 
 NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
 
 if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
 
 const char *sqlStatement = "select * from SMSCredentials";
 
 if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
 while (sqlite3_step(selectStmt) == SQLITE_ROW) {
 
 username1 = @((char *)sqlite3_column_text(selectStmt, 0));
 password1 = @((char *)sqlite3_column_text(selectStmt, 1));
 provider = @((char *)sqlite3_column_text(selectStmt, 2));
 }
 sqlite3_finalize(selectStmt);
 }
 }
 
 selectStmt = nil;
 sqlite3_close(database);
 
 if (provider != NULL) {
 
 if ([provider isEqualToString:@"SIM Card"]){
 
 MFMessageComposeViewController *controller =
 [[MFMessageComposeViewController alloc] init];
 if([MFMessageComposeViewController canSendText])
 {
 NSString * bodyMessage = [NSString stringWithFormat:@"Test SMS"];
 controller.body = bodyMessage;
 controller.recipients = @[phNotxt.text];
 controller.recipients = @[smsField.text];
 controller.messageComposeDelegate = self;
 //[self presentViewController:controller animated:YES completion:nil];
 [self messageComposeViewController:controller didFinishWithResult:MessageComposeResultSent];
 }
 }
 else{
 
 if (username1 != NULL || password1 != NULL) {
 
 
 //                                //NSURL *url = http://ubaid.tk/sms/sms.aspx?uid=9966754187&pwd=08931246131&msg=Hello&phone=9966754187&provider=way2sms
 //
 //                                NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ubaid.tk/sms/sms.aspx?uid=9966754187&pwd=08931246131&msg=Hello&phone=9966754187&provider=way2sms"]];
 //
 //                                NSLog(@" %@",theRequest);
 //
 //                                NSError *error = nil;
 //                                NSHTTPURLResponse *responseCode = nil;
 //
 //                                NSData *oResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&responseCode error:&error];
 //
 //                                NSLog(@" %@",oResponseData);
 
 
 baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
 baseView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
 [self.view addSubview:baseView];
 baseView.hidden = NO;
 
 UIView *smsView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 130)];
 smsView1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];;
 smsView1.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3);
 smsView1.layer.cornerRadius = 3.0f;
 smsView1.layer.borderColor = [UIColor whiteColor].CGColor;
 smsView1.layer.borderWidth = 1;
 [baseView addSubview:smsView1];
 
 
 UILabel *smslbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 180, 30)];
 smslbl.text = @"SMS";
 smslbl.font = [UIFont boldSystemFontOfSize:18];
 smslbl.backgroundColor = [UIColor clearColor];
 smslbl.textColor = [UIColor whiteColor];
 smslbl.textAlignment = NSTextAlignmentCenter;
 [smsView1 addSubview:smslbl];
 
 
 
 UIButton *backbutton = [[UIButton alloc] init] ;
 [backbutton addTarget:self action:@selector(closeSMSView) forControlEvents:UIControlEventTouchUpInside];
 backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
 UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
 [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
 backbutton.frame = CGRectMake(170,2,30,30);
 [smsView1 addSubview:backbutton];
 
 smsField = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, 180, 30)];
 smsField.backgroundColor=[UIColor whiteColor];
 smsField.textAlignment = NSTextAlignmentCenter;
 smsField.layer.cornerRadius = 2.0f;
 smsField.placeholder=@"Mobile Number";
 smsField.delegate = self;
 smsField.keyboardType = UIKeyboardTypeNumberPad;
 [smsView1 addSubview:smsField];
 
 
 UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 button.frame = CGRectMake(60,80,80,30);
 button.layer.cornerRadius = 8.0f;
 [button setTitle:@"Send" forState:UIControlStateNormal];
 button.backgroundColor = [UIColor blackColor];
 [button addTarget:self
 action:@selector(handelSMS)
 forControlEvents:UIControlEventTouchUpInside];
 [smsView1 addSubview:button];
 
 [baseView bringSubviewToFront:smsView1];
 
 }
 else{
 NSLog(@"Put Alert for No SMS Configutarion.");
 }
 }
 }
 else{
 
 NSLog(@"Put Alert for No SMS Configutarion.");
 }
 }
 
 
 -(void)createWaitOverlay {
 
 // fade the overlay in
 loadingLabel.text = @"Sending Mail..";
 bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,480)];
 bgimage.image = [UIImage imageNamed:@"waitOverLay.png"];
 [self.view addSubview:bgimage];
 bgimage.alpha = 0;
 [bgimage addSubview:loadingLabel];
 loadingLabel.alpha = 0;
 
 
 [UIView beginAnimations: @"Fade In" context:nil];
 [UIView setAnimationDelay:0];
 [UIView setAnimationDuration:.5];
 bgimage.alpha = 1;
 loadingLabel.alpha = 1;
 [UIView commitAnimations];
 [self startSpinner];
 }
 
 
 
 -(void)removeWaitOverlay {
 
 //fade the overlay out
 
 [UIView beginAnimations: @"Fade Out" context:nil];
 [UIView setAnimationDelay:0];
 [UIView setAnimationDuration:.5];
 bgimage.alpha = 0;
 loadingLabel.alpha = 0;
 [UIView commitAnimations];
 [self stopSpinner];
 
 }
 
 
 // close SMSView....
 -(void)closeSMSView{
 
 //Play Audio for button touch....
 AudioServicesPlaySystemSound (soundFileObject);
 
 [smsField resignFirstResponder];
 [baseView setHidden:YES];
 }
 
 
 
 
 // If phone number is valid send sms to user...
 -(void) handelSMS{
 
 //Play Audio for button touch....
 AudioServicesPlaySystemSound (soundFileObject);
 
 // NSString *value = [smsField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 // PhoNumber validation...
 NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
 NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
 BOOL isNumber = [decimalTest evaluateWithObject:smsField.text];
 //int qty = [value intValue];
 
 if((smsField.text).length <= 9 || (smsField.text).length >= 12 || !isNumber) {
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 
 }
 else{
 
 [smsField resignFirstResponder];
 [baseView setHidden:YES];
 }
 }
 
 
 
 // SMS delegte handle.....
 - (void)messageComposeViewController:(MFMessageComposeViewController *)controller   didFinishWithResult:(MessageComposeResult)result
 {
 switch (result)
 {
 case MessageComposeResultCancelled:{
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SMS" message:@"MessageComposeResultCancelled"
 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
 [alert show];
 break;
 }
 
 case MessageComposeResultFailed:{
 UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"SMS" message:@"Message Failed"
 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
 [alert1 show];
 break;
 }
 
 case MessageComposeResultSent:{
 
 //            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"SMS" message:@"Message has been sent"
 //                                                            delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
 //            [alert1 show];
 break;
 }
 
 default:
 break;
 }
 [self dismissViewControllerAnimated:YES completion:nil];
 }
 
 
 
 
 -(void)startSpinner {
 
 spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
 spinner.hidden = FALSE;
 spinner.frame = CGRectMake(137, 160, 50, 50);
 [spinner setHidesWhenStopped:YES];
 [self.view addSubview:spinner];
 [self.view bringSubviewToFront:spinner];
 [spinner startAnimating];
 }
 
 
 -(void)stopSpinner {
 
 [spinner stopAnimating];
 [spinner removeFromSuperview];
 }
 
 
 -(IBAction) loyaltyTypeTableCancel:(id) sender{
 
 //Play Audio for button touch....
 AudioServicesPlaySystemSound (soundFileObject);
 
 loyaltyTypeTable.hidden = YES;
 }
 
 
 
 
// previousButtonPressed handing...
- (void) giftVoucherValuePopUp:(UIButton *) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender == selectVoucherValueBtn) {
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *editPriceView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, loyaltyTypetxt.frame.size.width, 300)];
        editPriceView.opaque = NO;
        editPriceView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        editPriceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        editPriceView.layer.borderWidth = 2.0f;
        [editPriceView setHidden:NO];
        
        loyaltyTypeTable = [[UITableView alloc] init];
        //    loyaltyTypeTable.backgroundColor = [UIColor colorWithRed:139.0/255.0 green:179.0/255.0 blue:129.0/255.0 alpha:1.0];
        loyaltyTypeTable.backgroundColor = [UIColor whiteColor];
        loyaltyTypeTable.layer.borderColor = [UIColor blackColor].CGColor;
        loyaltyTypeTable.layer.cornerRadius = 4.0f;
        loyaltyTypeTable.layer.borderWidth = 1.0f;
        loyaltyTypeTable.dataSource = self;
        loyaltyTypeTable.delegate = self;
        loyaltyTypeTable.bounces = FALSE;
        loyaltyTypeTable.frame = CGRectMake(0.0, 0.0, editPriceView.frame.size.width, editPriceView.frame.size.height);
        
        [editPriceView addSubview:loyaltyTypeTable];
        customerInfoPopUp.view = editPriceView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(editPriceView.frame.size.width, editPriceView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:giftVoucherValueTF.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            
            editPricePopOver= popover;
        }
        
        else {
            
            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            // popover.contentViewController.view.alpha = 0.0;
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            editPricePopOver = popover;
            
        }
    }
}

 
 

 - (void)addGVButton:(UIButton *)sender {
 
 @try {
 
 NSDictionary *gvInfoDic = idslist[selectCashValuePosition];
 
 if (selectGiftVoucherArr.count) {
 BOOL existingStatus = FALSE;
 int changePosition;
 NSMutableDictionary *existingGVDic = [NSMutableDictionary new];
 
 for (int i = 0; i < selectGiftVoucherArr.count; i++) {
 NSMutableDictionary *GVDic = selectGiftVoucherArr[i];
 if ([[GVDic valueForKey:@"voucherPrgCode"] isEqualToString:[gvInfoDic valueForKey:@"voucherProgramCode"]]) {
 [GVDic setValue:loyaltyTypetxt.text forKey:@"noOfVouchers"];
 existingGVDic = [GVDic mutableCopy];
 existingStatus = TRUE;
 changePosition = i;
 }
 }
 if (existingStatus) {
 selectGiftVoucherArr[changePosition] = existingGVDic;
 }
 else {
 NSMutableDictionary *selectGVDic = [NSMutableDictionary new];
 [selectGVDic setValue:idTypetxt.text forKey:@"voucherValue"];
 [selectGVDic setValue:[gvInfoDic valueForKey:@"voucherProgramCode"] forKey:@"voucherPrgCode"];
 [selectGVDic setValue:loyaltyTypetxt.text forKey:@"noOfVouchers"];
 [selectGVDic setValue:[gvInfoDic valueForKey:@"expiryDate"] forKey:@"expiryDate"];
 [selectGiftVoucherArr addObject:selectGVDic];
 
 }
 [selectGiftVoucherTable setHidden:NO];
 }
 else {
 if ((idTypetxt.text).length != 0 && (loyaltyTypetxt.text).length !=0) {
 NSMutableDictionary *selectGVDic = [NSMutableDictionary new];
 [selectGVDic setValue:idTypetxt.text forKey:@"voucherValue"];
 [selectGVDic setValue:[gvInfoDic valueForKey:@"voucherProgramCode"] forKey:@"voucherPrgCode"];
 [selectGVDic setValue:loyaltyTypetxt.text forKey:@"noOfVouchers"];
 [selectGVDic setValue:[gvInfoDic valueForKey:@"expiryDate"] forKey:@"expiryDate"];
 [selectGiftVoucherArr addObject:selectGVDic];
 [selectGiftVoucherTable setHidden:NO];
 }
 }
 [selectGiftVoucherTable reloadData];
 } @catch (NSException *exception) {
 
 }
 }
 
 
 
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
 
 //Play Audio for button touch....
 AudioServicesPlaySystemSound (soundFileObject);
 
 //    if (buttonIndex == 0) {
 //
 ////        ShowLowyalty *show = [[ShowLowyalty alloc] init];
 ////        [self.navigationController pushViewController:show animated:YES];
 //
 //    }
 
 if (alertView == warning) {
 
 if (buttonIndex == 0) {
 
 [self.navigationController popViewControllerAnimated:YES];
 
 }
 else {
 [alertView dismissWithClickedButtonIndex:0 animated:YES];
 }
 
 }
 else if (alertView == uiAlert) {
 
 if (buttonIndex == 0) {
 
 usernametxt.text = @"";
 phNotxt.text = @"";
 emiltxt.text = @"";
 idNotxt.text = @"";
 idTypetxt.text = @"";
 loyaltyTypetxt.text  = @"";
 
 
 }
 }
 else if ([alertView.title isEqualToString:@"Gift Voucher Issued Successfully"]){
 [self cancelButtonPressed:cancelButton];
 }
 
 }
 
 

 */



@end
