//
//  IssueLowyalty.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 1/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "IssueLowyalty.h"
//#import "SDZLoyaltycardService.h"
#import "LoyaltycardServiceSvc.h"
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

@implementation IssueLowyalty

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

- (void)dealloc
{
    
    
    username = nil;
    phNo = nil;
    email = nil;
    idType = nil;
    idNo = nil;
    loyaltyTypetxt = nil;
    
    
    usernametxt = nil;
    phNotxt = nil;
    emiltxt = nil;
    idTypetxt = nil;
    idNotxt = nil;
    
    
    resultId = nil;
    
    //[loyaltyTypeTable release];
    loyalTypeList = nil;
    
    randomNum = nil;
    

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

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 16/12/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    version = [UIDevice currentDevice].systemVersion.floatValue;

    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);

    self.navigationController.navigationBarHidden = NO;
    
    self.titleLabel.text = @"Issue Loyalty Card";
    
    //main view bakgroung setting...
    //self.view.backgroundColor = [UIColor colorWithRed:99.0/255.0 green:132.0/255.0 blue:14.0/255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor blackColor];
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

    
//    username = [[UILabel alloc] init];
//    username.text = @"UserName";
//    username.font = [UIFont boldSystemFontOfSize:17];
//    username.textColor = [UIColor blackColor];
//    username.textAlignment = NSTextAlignmentLeft;
//    username.backgroundColor = [UIColor clearColor];
//    
//    phNo = [[UILabel alloc] init];
//    phNo.text = @"Phone Number";
//    phNo.font = [UIFont boldSystemFontOfSize:17];
//    phNo.textColor = [UIColor blackColor];
//    phNo.textAlignment = NSTextAlignmentLeft;
//    phNo.backgroundColor = [UIColor clearColor];
//    
//    email = [[UILabel alloc] init];
//    email.text = @"Email";
//    email.font = [UIFont boldSystemFontOfSize:17];
//    email.textColor = [UIColor blackColor];
//    email.textAlignment = NSTextAlignmentLeft;
//    email.backgroundColor = [UIColor clearColor];
//    
//    idType = [[UILabel alloc] init];
//    idType.text = @"IDType";
//    idType.font = [UIFont boldSystemFontOfSize:17];
//    idType.textColor = [UIColor blackColor];
//    idType.textAlignment = NSTextAlignmentLeft;
//    idType.backgroundColor = [UIColor clearColor];
//    
//    idNo = [[UILabel alloc] init];
//    idNo.text = @"IDNumber";
//    idNo.font = [UIFont boldSystemFontOfSize:17];
//    idNo.textColor = [UIColor blackColor];
//    idNo.textAlignment = NSTextAlignmentLeft;
//    idNo.backgroundColor = [UIColor clearColor];
//    
//    loyaltyType = [[UILabel alloc] init];
//    loyaltyType.text = @"Loyalty Type";
//    loyaltyType.font = [UIFont boldSystemFontOfSize:17];
//    loyaltyType.textColor = [UIColor blackColor];
//    loyaltyType.textAlignment = NSTextAlignmentLeft;
//    loyaltyType.backgroundColor = [UIColor clearColor];
//
    
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
    phNotxt.placeholder = @"     Phone No";    //place holder
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
    [phNotxt awakeFromNib];
    
    
    UIImageView *mailImage=[[UIImageView alloc] init]; // Set frame as per space required around icon
    mailImage.image = [UIImage imageNamed:@"mail.png"];
//
//    [mailImage setContentMode:UIViewContentModeCenter];// Set content mode centre
    
    emiltxt = [[CustomTextField alloc] init];
    emiltxt.borderStyle = UITextBorderStyleRoundedRect;
    emiltxt.textColor = [UIColor blackColor]; 
    emiltxt.font = [UIFont systemFontOfSize:17.0]; 
    emiltxt.placeholder = @"     Email ID";  //place holder
    emiltxt.backgroundColor = [UIColor whiteColor]; 
    emiltxt.autocorrectionType = UITextAutocorrectionTypeNo;   
    emiltxt.backgroundColor = [UIColor whiteColor];
    emiltxt.keyboardType = UIKeyboardTypeDefault;  
    emiltxt.returnKeyType = UIReturnKeyDone;  
    emiltxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    emiltxt.delegate = self;
    //emiltxt.leftView = mailImage;
    emiltxt.leftViewMode = UITextFieldViewModeAlways;
    [emiltxt awakeFromNib];
    
    UIButton *dateOfBirthBtn = [[UIButton alloc] init] ;
    UIImage *buttonImageDD2 = [UIImage imageNamed:@"combo.png"];
    [dateOfBirthBtn setBackgroundImage:buttonImageDD2 forState:UIControlStateNormal];
    [dateOfBirthBtn addTarget:self
               action:@selector(selectDateOfBirth:) forControlEvents:UIControlEventTouchDown];
    dateOfBirthBtn.backgroundColor = [UIColor clearColor];
    
    dateOfBirthTxt = [[CustomTextField alloc] init];
    dateOfBirthTxt.borderStyle = UITextBorderStyleRoundedRect;
    dateOfBirthTxt.textColor = [UIColor blackColor];
    dateOfBirthTxt.font = [UIFont systemFontOfSize:17.0];
    dateOfBirthTxt.placeholder = @"     Date of Birth";  //place holder
    dateOfBirthTxt.backgroundColor = [UIColor whiteColor];
    dateOfBirthTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    dateOfBirthTxt.backgroundColor = [UIColor whiteColor];
    dateOfBirthTxt.keyboardType = UIKeyboardTypeDefault;
    dateOfBirthTxt.returnKeyType = UIReturnKeyDone;
    dateOfBirthTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    dateOfBirthTxt.delegate = self;
    // usernametxt.leftView = userImage;
    dateOfBirthTxt.leftViewMode = UITextFieldViewModeAlways;
    [dateOfBirthTxt awakeFromNib];

    streetNameTxt = [[CustomTextField alloc] init];
    streetNameTxt.borderStyle = UITextBorderStyleRoundedRect;
    streetNameTxt.textColor = [UIColor blackColor];
    streetNameTxt.font = [UIFont systemFontOfSize:17.0];
    streetNameTxt.placeholder = @"     Street Name";  //place holder
    streetNameTxt.backgroundColor = [UIColor whiteColor];
    streetNameTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    streetNameTxt.backgroundColor = [UIColor whiteColor];
    streetNameTxt.keyboardType = UIKeyboardTypeDefault;
    streetNameTxt.returnKeyType = UIReturnKeyDone;
    streetNameTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    streetNameTxt.delegate = self;
    // usernametxt.leftView = userImage;
    streetNameTxt.leftViewMode = UITextFieldViewModeAlways;
    [streetNameTxt awakeFromNib];

    localityTxt = [[CustomTextField alloc] init];
    localityTxt.borderStyle = UITextBorderStyleRoundedRect;
    localityTxt.textColor = [UIColor blackColor];
    localityTxt.font = [UIFont systemFontOfSize:17.0];
    localityTxt.placeholder = @"     Locality";  //place holder
    localityTxt.backgroundColor = [UIColor whiteColor];
    localityTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    localityTxt.backgroundColor = [UIColor whiteColor];
    localityTxt.keyboardType = UIKeyboardTypeDefault;
    localityTxt.returnKeyType = UIReturnKeyDone;
    localityTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    localityTxt.delegate = self;
    // usernametxt.leftView = userImage;
    localityTxt.leftViewMode = UITextFieldViewModeAlways;
    [localityTxt awakeFromNib];

    cityTxt = [[CustomTextField alloc] init];
    cityTxt.borderStyle = UITextBorderStyleRoundedRect;
    cityTxt.textColor = [UIColor blackColor];
    cityTxt.font = [UIFont systemFontOfSize:17.0];
    cityTxt.placeholder = @"     City";  //place holder
    cityTxt.backgroundColor = [UIColor whiteColor];
    cityTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    cityTxt.backgroundColor = [UIColor whiteColor];
    cityTxt.keyboardType = UIKeyboardTypeDefault;
    cityTxt.returnKeyType = UIReturnKeyDone;
    cityTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    cityTxt.delegate = self;
    // usernametxt.leftView = userImage;
    cityTxt.leftViewMode = UITextFieldViewModeAlways;
    [cityTxt awakeFromNib];

    zipCodeTxt = [[CustomTextField alloc] init];
    zipCodeTxt.borderStyle = UITextBorderStyleRoundedRect;
    zipCodeTxt.textColor = [UIColor blackColor];
    zipCodeTxt.font = [UIFont systemFontOfSize:17.0];
    zipCodeTxt.placeholder = @"     Zip Code";  //place holder
    zipCodeTxt.backgroundColor = [UIColor whiteColor];
    zipCodeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    zipCodeTxt.backgroundColor = [UIColor whiteColor];
    zipCodeTxt.keyboardType = UIKeyboardTypeDefault;
    zipCodeTxt.returnKeyType = UIReturnKeyDone;
    zipCodeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    zipCodeTxt.delegate = self;
    // usernametxt.leftView = userImage;
    zipCodeTxt.leftViewMode = UITextFieldViewModeAlways;
    [zipCodeTxt awakeFromNib];
    
    professiontxt = [[CustomTextField alloc] init];
    professiontxt.borderStyle = UITextBorderStyleRoundedRect;
    professiontxt.textColor = [UIColor blackColor];
    professiontxt.font = [UIFont systemFontOfSize:17.0];
    professiontxt.placeholder = @"     Profession";  //place holder
    professiontxt.backgroundColor = [UIColor whiteColor];
    professiontxt.autocorrectionType = UITextAutocorrectionTypeNo;
    professiontxt.backgroundColor = [UIColor whiteColor];
    professiontxt.keyboardType = UIKeyboardTypeDefault;
    professiontxt.returnKeyType = UIReturnKeyDone;
    professiontxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    professiontxt.delegate = self;
    // usernametxt.leftView = userImage;
    professiontxt.leftViewMode = UITextFieldViewModeAlways;
    [professiontxt awakeFromNib];

    qualificationtxt = [[CustomTextField alloc] init];
    qualificationtxt.borderStyle = UITextBorderStyleRoundedRect;
    qualificationtxt.textColor = [UIColor blackColor];
    qualificationtxt.font = [UIFont systemFontOfSize:17.0];
    qualificationtxt.placeholder = @"     Qualification";  //place holder
    qualificationtxt.backgroundColor = [UIColor whiteColor];
    qualificationtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    qualificationtxt.backgroundColor = [UIColor whiteColor];
    qualificationtxt.keyboardType = UIKeyboardTypeDefault;
    qualificationtxt.returnKeyType = UIReturnKeyDone;
    qualificationtxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    qualificationtxt.delegate = self;
    // usernametxt.leftView = userImage;
    qualificationtxt.leftViewMode = UITextFieldViewModeAlways;
    [qualificationtxt awakeFromNib];

    gendertxt = [[CustomTextField alloc] init];
    gendertxt.borderStyle = UITextBorderStyleRoundedRect;
    gendertxt.textColor = [UIColor blackColor];
    gendertxt.font = [UIFont systemFontOfSize:17.0];
    gendertxt.placeholder = @"     Gender";  //place holder
    gendertxt.backgroundColor = [UIColor whiteColor];
    gendertxt.autocorrectionType = UITextAutocorrectionTypeNo;
    gendertxt.backgroundColor = [UIColor whiteColor];
    gendertxt.keyboardType = UIKeyboardTypeDefault;
    gendertxt.returnKeyType = UIReturnKeyDone;
    gendertxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    gendertxt.delegate = self;
    // usernametxt.leftView = userImage;
    gendertxt.leftViewMode = UITextFieldViewModeAlways;
    [gendertxt awakeFromNib];

    UIImageView *id_Type=[[UIImageView alloc] init]; // Set frame as per space required around icon
    id_Type.image = [UIImage imageNamed:@"Id_type.png"];
    
    idTypetxt = [[CustomTextField alloc] init];
    idTypetxt.borderStyle = UITextBorderStyleRoundedRect;
    idTypetxt.textColor = [UIColor blackColor]; 
    idTypetxt.font = [UIFont systemFontOfSize:17.0]; 
    idTypetxt.placeholder = @"Select Loyalty Type";  //place holder
    idTypetxt.backgroundColor = [UIColor whiteColor]; 
    idTypetxt.autocorrectionType = UITextAutocorrectionTypeNo;   
    idTypetxt.backgroundColor = [UIColor whiteColor];
    idTypetxt.keyboardType = UIKeyboardTypeDefault;  
    idTypetxt.returnKeyType = UIReturnKeyDone;  
    idTypetxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    idTypetxt.userInteractionEnabled = NO;
    idTypetxt.delegate = self;
    [idTypetxt awakeFromNib];
    
    UIButton *lisbtn = [[UIButton alloc] init] ;
    UIImage *buttonImageDD1 = [UIImage imageNamed:@"combo.png"];
    [lisbtn setBackgroundImage:buttonImageDD1 forState:UIControlStateNormal];
    [lisbtn addTarget:self
               action:@selector(idTypeSelectionPressed:) forControlEvents:UIControlEventTouchDown];
    lisbtn.backgroundColor = [UIColor clearColor];

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
    loyaltyTypetxt.placeholder = @"Select Loyalty Type";  //place holder
    loyaltyTypetxt.backgroundColor = [UIColor whiteColor]; 
    loyaltyTypetxt.autocorrectionType = UITextAutocorrectionTypeNo;   
    loyaltyTypetxt.backgroundColor = [UIColor whiteColor];
    loyaltyTypetxt.keyboardType = UIKeyboardTypeDefault;  
    loyaltyTypetxt.returnKeyType = UIReturnKeyDone;  
    loyaltyTypetxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    loyaltyTypetxt.userInteractionEnabled = NO;
    loyaltyTypetxt.delegate = self;
    [loyaltyTypetxt awakeFromNib];
    
//    UIButton *loyaltyTypelist = [[UIButton alloc] init] ;
//    [loyaltyTypelist setImage:[UIImage imageNamed:@"combo.png"] forState:UIControlStateNormal];
//    loyaltyTypelist.backgroundColor = [UIColor clearColor];
//    [loyaltyTypelist addTarget:self action:@selector(lyaltyTypeSelectionPressed:) forControlEvents:UIControlEventTouchDown];
   
    loyaltyTypelist = [[UIButton alloc] init] ;
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [loyaltyTypelist setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [loyaltyTypelist addTarget:self
               action:@selector(lyaltyTypeSelectionPressed:) forControlEvents:UIControlEventTouchDown];
    loyaltyTypelist.backgroundColor = [UIColor clearColor];
    loyaltyTypelist.tag = 1;
    
    submitBtn = [[UIButton alloc] init] ;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    viewPurchasesBtn = [[UIButton alloc] init];
    [viewPurchasesBtn addTarget:self
                     action:@selector(viewPurchasesBtnPressed:) forControlEvents:UIControlEventTouchDown];
    [viewPurchasesBtn setTitle:@"View Purchases" forState:UIControlStateNormal];
    viewPurchasesBtn.layer.cornerRadius = 3.0f;
    viewPurchasesBtn.backgroundColor = [UIColor grayColor];
    [viewPurchasesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // NSMutableArray initialization.....
    idslist = [[NSMutableArray alloc] init];
    [idslist addObject:@"PAN Card"];
    [idslist addObject:@"Voter Card"];    
    [idslist addObject:@"DrivingLicence"];

    // NSMutableArray initialization.....
    loyalTypeList = [[NSMutableArray alloc] init];
//    [loyalTypeList addObject:@"Platinum"];
//    [loyalTypeList addObject:@"Diamond"];    
//    [loyalTypeList addObject:@"Gold"];
//    [loyalTypeList addObject:@"Silver"];    
//    [loyalTypeList addObject:@"Bronze"];

    //selection Country for IdlistTableView creation...
    idlistTableView = [[UITableView alloc] init];
    idlistTableView.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
    idlistTableView.layer.borderColor = [UIColor blackColor].CGColor;
    idlistTableView.layer.cornerRadius = 4.0f;
    idlistTableView.layer.borderWidth = 1.0f;
    idlistTableView.dataSource = self;
    idlistTableView.delegate = self;
    idlistTableView.bounces = FALSE;

    
    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet;
    
//    //selected lowaltytype table creation....
    loyaltyTypeTable = [[UITableView alloc] init];
//    loyaltyTypeTable.backgroundColor = [UIColor colorWithRed:139.0/255.0 green:179.0/255.0 blue:129.0/255.0 alpha:1.0];
     loyaltyTypeTable.backgroundColor = [UIColor whiteColor];
    loyaltyTypeTable.layer.borderColor = [UIColor blackColor].CGColor;
    loyaltyTypeTable.layer.cornerRadius = 4.0f;
    loyaltyTypeTable.layer.borderWidth = 1.0f;
    loyaltyTypeTable.dataSource = self;
    loyaltyTypeTable.delegate = self;
    loyaltyTypeTable.bounces = FALSE;
    

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.font = [UIFont boldSystemFontOfSize:25];
        //        label.frame = CGRectMake(10, 0, 200, 50);
        //        backbutton.frame = CGRectMake(710.0, 5.0, 40.0, 40.0);
        scrollView.frame = CGRectMake(0, 51, 778, 1200);
        scrollView.contentSize = CGSizeMake(778, 1300);
        //issueLoyaltyView.frame = CGRectMake(20, 22, 738, 800);
        //img1.frame = CGRectMake(0, 0, 738, 200);
        userImage.frame = CGRectMake(60, 30, 50, 50);
        phoneImage.frame = CGRectMake(60, 115.0, 50, 50);
        mailImage.frame = CGRectMake(40, 180, 90, 100);
        id_Type.frame = CGRectMake(60, 300, 50, 60);
        id_No.frame = CGRectMake(60, 400, 50, 60);
        loyalcard.frame = CGRectMake(60, 495, 50, 70);
        
        username.font = [UIFont systemFontOfSize:30];
        username.frame = CGRectMake(30, 30, 300, 50);
        phNo.text = @"Phone No.";
        phNo.font = [UIFont systemFontOfSize:30];
        phNo.frame = CGRectMake(30, 120, 300, 50);
        email.font = [UIFont systemFontOfSize:30];
        email.frame = CGRectMake(30, 200, 300, 50);
        idType.font = [UIFont systemFontOfSize:30];
        idType.frame = CGRectMake(30, 300, 300, 50);
        idNo.font = [UIFont systemFontOfSize:30];
        idNo.frame = CGRectMake(30, 400, 300, 50);
        loyaltyType.font = [UIFont systemFontOfSize:30];
        loyaltyType.frame = CGRectMake(15, 655, 200, 50);
        
        usernametxt.font = [UIFont systemFontOfSize:25];
        usernametxt.frame = CGRectMake(370, 80, 350.0, 50);
        phNotxt.font = [UIFont systemFontOfSize:25];
        phNotxt.frame = CGRectMake(10, 80, 350.0, 50);
        emiltxt.font = [UIFont systemFontOfSize:25];
        emiltxt.frame = CGRectMake(10, 150, 350.0, 50);
        dateOfBirthBtn.frame = CGRectMake(700.0, 145.0, 50, 60);
        dateOfBirthTxt.font = [UIFont systemFontOfSize:25];
        dateOfBirthTxt.frame = CGRectMake(370, 150, 350.0, 50);
        streetNameTxt.font = [UIFont systemFontOfSize:25];
        streetNameTxt.frame = CGRectMake(10, 290.0, 350.0, 50);
        localityTxt.font = [UIFont systemFontOfSize:25];
        localityTxt.frame = CGRectMake(10, 220.0, 350.0, 50.0);
        cityTxt.font = [UIFont systemFontOfSize:25];
        cityTxt.frame = CGRectMake(370, 220.0, 350.0, 50.0);
        zipCodeTxt.font = [UIFont systemFontOfSize:25];
        zipCodeTxt.frame = CGRectMake(370, 290.0, 350.0, 50.0);
        professiontxt.font = [UIFont systemFontOfSize:25];
        professiontxt.frame = CGRectMake(10, 360.0, 350.0, 50.0);
        qualificationtxt.font = [UIFont systemFontOfSize:25];
        qualificationtxt.frame = CGRectMake(370, 360.0, 350.0, 50.0);
        gendertxt.font = [UIFont systemFontOfSize:25];
        gendertxt.frame = CGRectMake(10, 430.0, 350.0, 50.0);
        idTypetxt.font = [UIFont systemFontOfSize:25];
        idTypetxt.frame = CGRectMake(730.0, 290.0, 300.0, 50);
        loyaltyTypelist.frame = CGRectMake(980.0, 283, 50, 73);
        
//        idNotxt.font = [UIFont systemFontOfSize:30];
//        idNotxt.frame = CGRectMake(130, 400, 520, 60);
//        loyaltyTypetxt.font = [UIFont systemFontOfSize:30];
//        loyaltyTypetxt.frame = CGRectMake(130, 500, 520, 60);
//        
//        loyaltyTypelist.frame = CGRectMake(645, 494,50, 77);
        submitBtn.frame = CGRectMake(200.0f, 700.0,300.0f, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelButton.frame = CGRectMake(550.0f, 700.0,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        viewPurchasesBtn.frame = CGRectMake(750.0, 450.0,250.0, 55.0f);
        viewPurchasesBtn.layer.cornerRadius = 25.0f;
        viewPurchasesBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        idlistTableView.frame = CGRectMake(130, 360,480, 200);
        loyaltyTypeTable.frame = CGRectMake(730, 340,300.0, 300);
        
        usernametxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:usernametxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        idNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        idTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
           emiltxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:emiltxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
           phNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
           loyaltyTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:loyaltyTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        dateOfBirthTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dateOfBirthTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        streetNameTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:streetNameTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        localityTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:localityTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        cityTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:cityTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        zipCodeTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:zipCodeTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        professiontxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:professiontxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        qualificationtxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:qualificationtxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        gendertxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:gendertxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    }
    else {
        
        if (version>8.0) {
            
            scrollView.frame = CGRectMake(0, 0, 320, 600);
            scrollView.contentSize = CGSizeMake(320, 770);
            
            userImage.frame = CGRectMake(40, 30, 30, 30);
            phoneImage.frame = CGRectMake(40, 70.0, 30, 30);
            mailImage.frame = CGRectMake(27, 95, 60, 60);
            id_Type.frame = CGRectMake(40, 148, 30, 30);
            id_No.frame = CGRectMake(40, 188, 30, 30);
            loyalcard.frame = CGRectMake(40, 230, 30, 30);
            
            username.frame = CGRectMake(5, 30, 120, 30);
            phNo.frame = CGRectMake(5, 70, 130, 30);
            email.frame = CGRectMake(5, 110, 120, 30);
            idType.frame = CGRectMake(5, 150, 120, 30);
            idNo.frame = CGRectMake(5, 190, 120, 30);
            loyaltyType.frame = CGRectMake(5, 260, 120, 30);
            
            usernametxt.frame = CGRectMake(80, 30, 160, 30);
            phNotxt.frame = CGRectMake(80, 70, 160, 30);
            emiltxt.frame = CGRectMake(80, 110, 160, 30);
            idTypetxt.frame = CGRectMake(80, 150, 160, 28);
            dateOfBirthBtn.frame = CGRectMake(240.0f, 147.0f,25.0f, 37.0f);
            idNotxt.frame = CGRectMake(80, 190, 160, 30);
            loyaltyTypetxt.frame = CGRectMake(80, 230.0, 160, 29);
            loyaltyTypelist.frame = CGRectMake(240.0, 225.0,25.0f, 37.0f);
            submitBtn.frame = CGRectMake(20.0f, 360.0f,280.0f, 35.0f);
            submitBtn.layer.cornerRadius = 15.0f;
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            idlistTableView.frame = CGRectMake(80, 177,160, 90);
            loyaltyTypeTable.frame = CGRectMake(55, 115.0,180, 180);
            
            usernametxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:usernametxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            idNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            
            idTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            
            emiltxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:emiltxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            phNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            loyaltyTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:loyaltyTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            

            
        }
        else {
            
            scrollView.frame = CGRectMake(0, 0, 320, 600);
            scrollView.contentSize = CGSizeMake(320, 770);
            
            userImage.frame = CGRectMake(40, 30, 30, 30);
            phoneImage.frame = CGRectMake(40, 70.0, 30, 30);
            mailImage.frame = CGRectMake(27, 95, 60, 60);
            id_Type.frame = CGRectMake(40, 148, 30, 30);
            id_No.frame = CGRectMake(40, 188, 30, 30);
            loyalcard.frame = CGRectMake(40, 230, 30, 30);
            
            username.frame = CGRectMake(5, 30, 120, 30);
            phNo.frame = CGRectMake(5, 70, 130, 30);
            email.frame = CGRectMake(5, 110, 120, 30);
            idType.frame = CGRectMake(5, 150, 120, 30);
            idNo.frame = CGRectMake(5, 190, 120, 30);
            loyaltyType.frame = CGRectMake(5, 260, 120, 30);
            
            usernametxt.frame = CGRectMake(80, 30, 160, 30);
            phNotxt.frame = CGRectMake(80, 70, 160, 30);
            emiltxt.frame = CGRectMake(80, 110, 160, 30);
            idTypetxt.frame = CGRectMake(80, 150, 160, 28);
            dateOfBirthBtn.frame = CGRectMake(240.0f, 147.0f,25.0f, 37.0f);
            idNotxt.frame = CGRectMake(80, 190, 160, 30);
            loyaltyTypetxt.frame = CGRectMake(80, 230.0, 160, 29);
            loyaltyTypelist.frame = CGRectMake(240.0, 225.0,25.0f, 37.0f);
            submitBtn.frame = CGRectMake(20.0f, 300.0f,280.0f, 35.0f);
            submitBtn.layer.cornerRadius = 15.0f;
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            idlistTableView.frame = CGRectMake(80, 177,160, 90);
            loyaltyTypeTable.frame = CGRectMake(55, 115.0,180, 180);
            

        }
            //        img.frame = CGRectMake(0, 0, 320, 31);
            //        label.frame = CGRectMake(3, 1, 120, 30);
            //        backbutton.frame = CGRectMake(285.0, 2.0, 27.0, 27.0);
        
        
    }
    
    
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
    [self.view addSubview:usernametxt];
    [self.view addSubview:emiltxt];
    [self.view addSubview:phNotxt];
    [self.view addSubview:idTypetxt];
    [self.view addSubview:idNotxt];
    [self.view addSubview:dateOfBirthBtn];
    [self.view addSubview:dateOfBirthTxt];
    [self.view addSubview:streetNameTxt];
    [self.view addSubview:localityTxt];
    [self.view addSubview:cityTxt];
    [self.view addSubview:zipCodeTxt];
    [self.view addSubview:professiontxt];
    [self.view addSubview:qualificationtxt];
    [self.view addSubview:gendertxt];
    [self.view addSubview:loyaltyTypetxt];
    [self.view addSubview:loyaltyTypelist];
    [self.view addSubview:submitBtn];
    [self.view addSubview:cancelButton];
    [self.view addSubview:viewPurchasesBtn];
    [self.view addSubview:idlistTableView];
    idlistTableView.hidden = YES;
    loyaltyTypeTable.hidden = YES;
     [self.view addSubview:loyaltyTypeTable];
    //scrollView.hidden = YES;
    [self.view addSubview:dateOfBirthBtn];
   // mailview initialization....
    mailView = [[UIView alloc] init];
   // mailView.hidden = YES;
    
    
    resultId = [[UILabel alloc] init];
    
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
    
    loyaltyPgm = [[NSMutableArray alloc]init];
    [self provideCustomerRatingfor:nil];
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed at end to view unloaded....
 * @date
 * @method       viewDidAppear
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 16/12/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date
 * @method       didReceiveMemoryWarning
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 16/12/2017....
 * @reason      added the comments....
 *
 * @verified By
 * @verified On
 *
 */

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma -mark start of textFields delegates...

/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date         16/12/2017....
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         16/12/2017....
 * @method       textFieldDidBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
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

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date
 * @method       textField:  shouldChangeCharactersInRange:  replacementString:
 * @author
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 *
 * @return       BOOL
 *
 * @modified By  Srinivasulu by on 16/12/2017...
 * @reason       added the comments and need to change more
 *
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
    else if (range.location == textField.text.length && [characters isEqualToString:@" "]) {
        // ignore replacement string and add your own
        textField.text = [textField.text stringByAppendingString:@"\u00a0"];
        return NO;
    }
    else {
        
        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
    }
    
    return 1;
}


/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date
 * @method       textFieldDidChange:
 * @author
 * @param        UITextField
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By  Srinivasulu by on 16/12/2017...
 * @reason       added the comments and need to change more
 *
 * @verified By
 * @verified On
 *
 */
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == phNotxt) {
        if (textField.text.length == 10) {
            [phNotxt resignFirstResponder];
            [self getCustomerDetailsForOffers];
        }
    }
}


/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing....
 * @date         16/12/2017
 * @method       textFieldDidEndEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         16/12/2017....
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [usernametxt resignFirstResponder];
    [phNotxt resignFirstResponder];
    [emiltxt resignFirstResponder];
    [idTypetxt resignFirstResponder];
    [idNotxt resignFirstResponder];
    [loyaltyTypetxt resignFirstResponder];
    
    return YES;
}

#pragma mark Table view methods

/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date
 * @method       tableView: numberOfRowsInSection:
 * @author
 * @param        UITableView
 * @param        NSInteger
 *
 * @return       NSInteger
 *
 * @modified BY  Srinivasulu on 16/12/2017....
 * @reason       added the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == loyaltyTypeTable) {
        return loyalTypeList.count;
    }
    else if (tableView == purchaseHistoryTable){
        return purchasesHistory.count;
    }
    else{
        return idslist.count;
    }
}


/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date
 * @method       tableView: heightForRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        NSIndexPath
 *
 * @return       CGFloat
 *
 * @modified BY  Srinivasulu on 16/12/2017....
 * @reason       added the comment's section....
 *
 * @verified By
 * @verified On
 *
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 50.0;
    }
    else {
        return 30.0;
    }
    
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date
 * @method       tableView: cellForRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 *
 * @return       UITableViewCell
 *
 * @modified BY  Srinivasulu on 16/12/2017....
 * @reason       changed the comment's section and populating the data into labels....
 *
 * @verified By
 * @verified On
 *
 */

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (tableView == loyaltyTypeTable) {
            return 50.0;
        }else{
            return NO;
        }
    }
    else {
        if (tableView == loyaltyTypeTable) {
            return 30.0;
            
        }else{
            return NO;
        }
    }
    
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date
 * @method       tableView: cellForRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 *
 * @return       UITableViewCell
 *
 * @modified BY  Srinivasulu on 16/12/2017....
 * @reason       changed the comment's section and populating the data into labels....
 *
 * @verified By
 * @verified On
 *
 */

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == loyaltyTypeTable) {
        
        UIView* headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:163.0/255.0 blue:23.0/255.0 alpha:1.0];
        
        UILabel *label1 = [[UILabel alloc] init] ;
        label1.font = [UIFont boldSystemFontOfSize:17.0];
        label1.backgroundColor = [UIColor clearColor];
        label1.text = @"Select LoyaltyType";
        label1.textColor = [UIColor whiteColor];
        
        UIButton *closeBtn = [[UIButton alloc] init] ;
        [closeBtn addTarget:self action:@selector(loyaltyTypeTableCancel:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
        [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            headerView.frame = CGRectMake(0.0, 0.0, 250.0, 75.0);
            label1.font = [UIFont boldSystemFontOfSize:22.0];
            label1.frame = CGRectMake(2, 2, 220, 35);
            closeBtn.frame = CGRectMake(250, 10, 30, 30);
        }
        else {
            headerView.frame = CGRectMake(0.0, 0.0, 320.0, 69.0);
            label1.font = [UIFont boldSystemFontOfSize:17.0];
            label1.frame = CGRectMake(2, 2, 160, 25);
            closeBtn.frame = CGRectMake(157, 3, 22, 26);
        }
        
        [headerView addSubview:label1];
        [headerView addSubview:closeBtn];
        
        return headerView;
    }
    else{
        
        return NO;
    }
    
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date
 * @method       tableView: cellForRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 *
 * @return       UITableViewCell
 *
 * @modified BY  Srinivasulu on 16/12/2017....
 * @reason       changed the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.frame = CGRectZero;
    }
    if (tableView == loyaltyTypeTable) {
        
        cell.textLabel.text = loyalTypeList[indexPath.row];
    }
    else if (tableView == purchaseHistoryTable) {
        
        tableView.separatorColor = [UIColor clearColor];
        NSDictionary *itemDic = purchasesHistory[indexPath.row];
        
        UILabel *billID = [[UILabel alloc] init] ;
        billID.layer.borderWidth = 1.5;
        billID.font = [UIFont systemFontOfSize:13.0];
        billID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        billID.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        billID.backgroundColor = [UIColor clearColor];
        billID.textColor = [UIColor whiteColor];
        
        
        UILabel *skuID = [[UILabel alloc] init] ;
        skuID.layer.borderWidth = 1.5;
        skuID.font = [UIFont systemFontOfSize:13.0];
        skuID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        skuID.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        skuID.backgroundColor = [UIColor clearColor];
        skuID.textColor = [UIColor whiteColor];
        
        UILabel *itemName = [[UILabel alloc] init] ;
        itemName.layer.borderWidth = 1.5;
        itemName.font = [UIFont systemFontOfSize:13.0];
        itemName.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        itemName.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        itemName.backgroundColor = [UIColor clearColor];
        itemName.textColor = [UIColor whiteColor];
        
        UILabel *qty = [[UILabel alloc] init] ;
        qty.layer.borderWidth = 1.5;
        qty.font = [UIFont systemFontOfSize:13.0];
        qty.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        qty.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        qty.backgroundColor = [UIColor clearColor];
        qty.textColor = [UIColor whiteColor];
        
        UILabel *totalPrice = [[UILabel alloc] init] ;
        totalPrice.layer.borderWidth = 1.5;
        totalPrice.font = [UIFont systemFontOfSize:13.0];
        totalPrice.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        totalPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        totalPrice.backgroundColor = [UIColor clearColor];
        totalPrice.textColor = [UIColor whiteColor];
        
        billID.frame = CGRectMake(5.0, 5.0, 200.0, 50.0);
        skuID.frame = CGRectMake(210.0, 5.0, 100.0, 50.0);
        itemName.frame = CGRectMake(315.0, 5.0, 300.0, 50.0);
        qty.frame = CGRectMake(620.0, 5.0, 80.0, 50.0);
        totalPrice.frame = CGRectMake(705.0, 5.0, 140.0, 50.0);
        
        @try {
            billID.text = [itemDic valueForKey:@"billId"];
            skuID.text = [itemDic valueForKey:@"sku_id"];
            itemName.text = [itemDic valueForKey:@"item_name"];
            qty.text = [NSString stringWithFormat:@"%d",[[itemDic valueForKey:@"quantity"] intValue]];
            totalPrice.text = [NSString stringWithFormat:@"%.2f",[[itemDic valueForKey:@"item_total_price"] floatValue]];
            
            billID.textAlignment = NSTextAlignmentCenter;
            skuID.textAlignment = NSTextAlignmentCenter;
            itemName.textAlignment = NSTextAlignmentCenter;
            qty.textAlignment = NSTextAlignmentCenter;
            totalPrice.textAlignment = NSTextAlignmentCenter;
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.name);
        }
        @finally {
            
        }
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:billID];
        [cell.contentView addSubview:skuID];
        [cell.contentView addSubview:itemName];
        [cell.contentView addSubview:qty];
        [cell.contentView addSubview:totalPrice];
    }
    else{
        
        cell.textLabel.text = idslist[indexPath.row];
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.textLabel.font = [UIFont systemFontOfSize:25.0];
    }
    else {
        cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    }
    
    return cell;
}

/**
 * @description  it is tableview delegate method it will be called when user is select/cilcked on tableview.......
 * @date
 * @method       tableView: didSelectRowAtIndexPath:
 * @author
 *
 * @param        UITableView
 * @param        NSIndexPath
 *
 * @return       void
 *
 * @modified BY  Srinivasulu on 16/12/2017....
 * @reason       changed the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (tableView == loyaltyTypeTable) {
        
        idTypetxt.text = loyalTypeList[indexPath.row];
        loyaltyTypeTable.hidden = YES;
        loyaltyProgram = loyaltyPgm[indexPath.row];
        
    }
    else{
        idTypetxt.text = idslist[indexPath.row];
        idlistTableView.hidden = YES;
    }
    
}

#pragma -mark actions used in the page...

// Commented by roja on 17/10/2019.. // reason getCustomerDetailsForOffers method contains SOAP Service call .. so taken new method with same(getCustomerDetailsForOffers) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getCustomerDetailsForOffers {
//
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    // Regiser for HUD callbacks so we can remove it from the window at the right time
//    HUD.delegate = self;
//    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
//    HUD.mode = MBProgressHUDModeCustomView;
//    // Show the HUD
//    [HUD show:YES];
//
//    // showing the HUD ..
//    [HUD setHidden:NO];
//
//    //checking for deals & offers...
//    CustomerServiceSoapBinding *custBindng =  [CustomerServiceSvc CustomerServiceSoapBinding] ;
//    CustomerServiceSvc_getCustomerDetails *aParameters = [[CustomerServiceSvc_getCustomerDetails alloc] init];
//
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:[RequestHeader getRequestHeader] options:0 error:&err];
//    NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//
//    NSArray *loyaltyKeys = @[@"email", @"mobileNumber",@"requestHeader"];
//
//    NSArray *loyaltyObjects = @[@"",phNotxt.text,requestHeaderString];
//    NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//    NSError * err_;
//    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
//    NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//    aParameters.phone = loyaltyString;
//
//    @try {
//
//        CustomerServiceSoapBindingResponse *response = [custBindng getCustomerDetailsUsingParameters:(CustomerServiceSvc_getCustomerDetails *)aParameters];
//        NSArray *responseBodyParts = response.bodyParts;
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[CustomerServiceSvc_getCustomerDetailsResponse class]]) {
//                CustomerServiceSvc_getCustomerDetailsResponse *body = (CustomerServiceSvc_getCustomerDetailsResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//                NSError *e;
//
//                NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                      options: NSJSONReadingMutableContainers
//                                                                        error: &e];
//
//                if ([[NSString stringWithFormat:@"%@",JSON1[@"phone"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",JSON1[@"email"]] isEqualToString:@"<null>"]) {
//
//                    if ((phNotxt.text).length >= 10) {
//                        [self provideCustomerRatingfor:NEW_CUSTOMER];
//                        return;
//                    }
//                }
//                else{
//                    if ((phNotxt.text).length >= 10) {
//
//                        if (!([[NSString stringWithFormat:@"%@",JSON1[@"category"]] isEqualToString:@"<null>"])) {
//                            if ([[JSON1 valueForKey:@"name"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"name"] == nil) {
//                                usernametxt.text = @"";
//                            }
//                            else {
//                                usernametxt.text = [JSON1 valueForKey:@"name"];
//                            }
//                            if ([[JSON1 valueForKey:@"email"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"email"] == nil) {
//                                emiltxt.text = @"";
//                            }
//                            else {
//                                emiltxt.text = [JSON1 valueForKey:@"email"];
//                            }
//                            if ([[JSON1 valueForKey:@"street"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"street"] == nil) {
//                                streetNameTxt.text = @"";
//                            }
//                            else {
//                                streetNameTxt.text = [JSON1 valueForKey:@"street"];
//                            }
//                            if ([[JSON1 valueForKey:@"locality"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"locality"] == nil) {
//                                localityTxt.text = @"";
//                            }
//                            else {
//                                localityTxt.text = [JSON1 valueForKey:@"locality"];
//                            }
//                            if ([[JSON1 valueForKey:@"city"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"city"] == nil) {
//                                cityTxt.text = @"";
//                            }
//                            else {
//                                cityTxt.text = [JSON1 valueForKey:@"city"];
//                            }
//                            if ([[JSON1 valueForKey:@"pin_no"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"pin_no"] == nil) {
//                                zipCodeTxt.text = @"";
//                            }
//                            else {
//                                if([[JSON1 valueForKey:@"pin_no"] isEqualToString:@"(null)"]){
//                                    zipCodeTxt.text = @"";
//                                }
//                                else{
//                                    zipCodeTxt.text = [JSON1 valueForKey:@"pin_no"];
//                                }
//                            }
//                            [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@",JSON1[@"category"]]];
//                            [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@",JSON1[@"category"]]];
//                            return;
//                        }
//                        else {
//                            if ([[JSON1 valueForKey:@"name"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"name"] == nil) {
//                                usernametxt.text = @"";
//                            }
//                            else {
//                                usernametxt.text = [JSON1 valueForKey:@"name"];
//                            }
//                            if ([[JSON1 valueForKey:@"email"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"email"] == nil) {
//                                emiltxt.text = @"";
//                            }
//                            else {
//                                emiltxt.text = [JSON1 valueForKey:@"email"];
//                            }
//                            if ([[JSON1 valueForKey:@"street"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"street"] == nil) {
//                                streetNameTxt.text = @"";
//                            }
//                            else {
//                                streetNameTxt.text = [JSON1 valueForKey:@"street"];
//                            }
//                            if ([[JSON1 valueForKey:@"locality"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"locality"] == nil) {
//                                localityTxt.text = @"";
//                            }
//                            else {
//                                localityTxt.text = [JSON1 valueForKey:@"locality"];
//                            }
//                            if ([[JSON1 valueForKey:@"city"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"city"] == nil) {
//                                cityTxt.text = @"";
//                            }
//                            else {
//                                cityTxt.text = [JSON1 valueForKey:@"city"];
//                            }
//                            if ([[JSON1 valueForKey:@"pin_no"] isKindOfClass:[NSNull class]] || [JSON1 valueForKey:@"pin_no"] == nil) {
//                                zipCodeTxt.text = @"";
//                            }
//                            else {
//                                zipCodeTxt.text = [JSON1 valueForKey:@"pin_no"];
//                            }
//                            [self provideCustomerRatingfor:EXISTING_CUSTOMER];
//                            return;
//                        }
//                    }
//
//                }
//
//                [HUD setHidden:YES];
//            }
//        }
//    }
//    @catch (NSException *exception) {
//
//        NSLog(@"%@",exception);
//    }
//    @finally {
//        [HUD setHidden:YES];
//
//    }
//}

//getCustomerDetailsForOffers method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getCustomerDetailsForOffers {
    
    @try {
        
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
        
        //checking for deals & offers...
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:[RequestHeader getRequestHeader] options:0 error:&err];
        NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSArray *loyaltyKeys = @[@"email", @"mobileNumber",@"requestHeader"];
        
        NSArray *loyaltyObjects = @[@"",phNotxt.text,requestHeaderString];
        NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController * services = [[WebServiceController alloc] init];
        services.customerServiceDelegate = self;
        [services getCustomerDetails:loyaltyString];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        [HUD setHidden:YES];

    }
   
}


// added by Roja on 17/10/2019…. // old code only added here
- (void)getCustomerDetailsSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        if ([[NSString stringWithFormat:@"%@",sucessDictionary[@"phone"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",sucessDictionary[@"email"]] isEqualToString:@"<null>"]) {
            
            if ((phNotxt.text).length >= 10) {
                [self provideCustomerRatingfor:NEW_CUSTOMER];
                return;
            }
        }
        else{
            if ((phNotxt.text).length >= 10) {
                
                if (!([[NSString stringWithFormat:@"%@",sucessDictionary[@"category"]] isEqualToString:@"<null>"])) {
                    if ([[sucessDictionary valueForKey:@"name"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"name"] == nil) {
                        usernametxt.text = @"";
                    }
                    else {
                        usernametxt.text = [sucessDictionary valueForKey:@"name"];
                    }
                    if ([[sucessDictionary valueForKey:@"email"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"email"] == nil) {
                        emiltxt.text = @"";
                    }
                    else {
                        emiltxt.text = [sucessDictionary valueForKey:@"email"];
                    }
                    if ([[sucessDictionary valueForKey:@"street"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"street"] == nil) {
                        streetNameTxt.text = @"";
                    }
                    else {
                        streetNameTxt.text = [sucessDictionary valueForKey:@"street"];
                    }
                    if ([[sucessDictionary valueForKey:@"locality"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"locality"] == nil) {
                        localityTxt.text = @"";
                    }
                    else {
                        localityTxt.text = [sucessDictionary valueForKey:@"locality"];
                    }
                    if ([[sucessDictionary valueForKey:@"city"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"city"] == nil) {
                        cityTxt.text = @"";
                    }
                    else {
                        cityTxt.text = [sucessDictionary valueForKey:@"city"];
                    }
                    if ([[sucessDictionary valueForKey:@"pin_no"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"pin_no"] == nil) {
                        zipCodeTxt.text = @"";
                    }
                    else {
                        if([[sucessDictionary valueForKey:@"pin_no"] isEqualToString:@"(null)"]){
                            zipCodeTxt.text = @"";
                        }
                        else{
                            zipCodeTxt.text = [sucessDictionary valueForKey:@"pin_no"];
                        }
                    }
                    [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@", sucessDictionary[@"category"]]];
                    [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@", sucessDictionary[@"category"]]];
                    return;
                }
                else {
                    if ([[sucessDictionary valueForKey:@"name"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"name"] == nil) {
                        usernametxt.text = @"";
                    }
                    else {
                        usernametxt.text = [sucessDictionary valueForKey:@"name"];
                    }
                    if ([[sucessDictionary valueForKey:@"email"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"email"] == nil) {
                        emiltxt.text = @"";
                    }
                    else {
                        emiltxt.text = [sucessDictionary valueForKey:@"email"];
                    }
                    if ([[sucessDictionary valueForKey:@"street"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"street"] == nil) {
                        streetNameTxt.text = @"";
                    }
                    else {
                        streetNameTxt.text = [sucessDictionary valueForKey:@"street"];
                    }
                    if ([[sucessDictionary valueForKey:@"locality"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"locality"] == nil) {
                        localityTxt.text = @"";
                    }
                    else {
                        localityTxt.text = [sucessDictionary valueForKey:@"locality"];
                    }
                    if ([[sucessDictionary valueForKey:@"city"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"city"] == nil) {
                        cityTxt.text = @"";
                    }
                    else {
                        cityTxt.text = [sucessDictionary valueForKey:@"city"];
                    }
                    if ([[sucessDictionary valueForKey:@"pin_no"] isKindOfClass:[NSNull class]] || [sucessDictionary valueForKey:@"pin_no"] == nil) {
                        zipCodeTxt.text = @"";
                    }
                    else {
                        zipCodeTxt.text = [sucessDictionary valueForKey:@"pin_no"];
                    }
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

// added by Roja on 17/10/2019…. // old code only added here
- (void)getCustomerDetailsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }

}


-(void)provideCustomerRatingfor:(NSString *)category
{
    [starRat removeFromSuperview];
    starRat = [[UIImageView alloc] init];
    starRat.backgroundColor = [UIColor clearColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        starRat.frame = CGRectMake(780.0, 85.0, 130.0, 30.0);
    }
    [self.view addSubview:starRat];
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
        [self.view addSubview:starImageView];
        
        // calculate new xPos and yPos
        xPos = xPos + starImageView.frame.size.width+5.0;
    }
    
    
}



//Number pad close...
-(void)doneWithNumberPad{
    
    // NSString *numberFromTheKeyboard = phNo.text;
    [phNotxt resignFirstResponder];
}


// previousButtonPressed handing...
- (void) idTypeSelectionPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [idTypetxt resignFirstResponder];
    [emiltxt resignFirstResponder];
    [usernametxt resignFirstResponder];
    [phNotxt resignFirstResponder];
    [emiltxt resignFirstResponder];
    [idNotxt resignFirstResponder];
    [idlistTableView reloadData];
    idlistTableView.hidden = NO;
}

// previousButtonPressed handing...
- (void) lyaltyTypeSelectionPressed:(UIButton *) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender == loyaltyTypelist) {
        
        if (sender.tag == 1) {
            
            [self getLoyaltyPrograms];
            if (loyalTypeList.count>0) {
                
                [loyaltyTypeTable reloadData];
                loyaltyTypeTable.hidden = NO;
            }
            else {
                
                loyaltyTypeTable.hidden = YES;
                HUD.hidden = YES;
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Loyalty programs not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
           
        }
        else {
            
            sender.tag = 1;
            loyaltyTypeTable.hidden = YES;
        }
    }
    
   
}

// Commented by roja on 17/10/2019.. // reason : submitButtonPressed method contains SOAP Service call .. so taken new method with same name(submitButtonPressed) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//// previousButtonPressed handing...
//- (void) submitButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    // PhoNumber validation...
//    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
//    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
//    BOOL isNumber = [decimalTest evaluateWithObject:phNotxt.text];
//
//
//    // Email validation...
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    BOOL isMail = [emailTest evaluateWithObject:emiltxt.text];
//
//
//
//    if ( (phNotxt.text).length == 0 ) {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter phone no" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//
//    }
//    else if ((idTypetxt.text).length == 0 ) {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter ID Type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else if((phNotxt.text).length <= 9 || (phNotxt.text).length >= 14 || !isNumber) {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//
//    }
//    else if ((emiltxt.text).length!=0) {
//    if(!isMail) {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Mail ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//
//      }
//    else {
//
//        [HUD setHidden:NO];
//
//        // Create the service
//        //        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
//        //        service.logging = YES;
//        //
//        //      // Returns NSString*.
//        //        [service getloyaltyCardNumber:self action:@selector(getloyaltyCardNumberHandler:)];
//
//        LoyaltycardServiceSoapBinding *offerBindng =  [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding];
//        LoyaltycardServiceSvc_issueLoyaltyCard *aParameters =  [[LoyaltycardServiceSvc_issueLoyaltyCard alloc] init];
//
//
//        NSArray *loyaltyKeys = @[@"idCardNumber", @"customerName",@"idCardType",@"loyaltyProgramNumber",@"phoneNum",@"email",@"requestHeader"];
//
//        NSArray *loyaltyObjects = @[idNotxt.text,usernametxt.text,idTypetxt.text,loyaltyProgram,phNotxt.text,emiltxt.text,[RequestHeader getRequestHeader]];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        aParameters.loyaltyCardDetails = normalStockString;
//        @try {
//
//            LoyaltycardServiceSoapBindingResponse *response = [offerBindng issueLoyaltyCardUsingParameters:aParameters];
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_issueLoyaltyCardResponse class]]) {
//                    LoyaltycardServiceSvc_issueLoyaltyCardResponse *body = (LoyaltycardServiceSvc_issueLoyaltyCardResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    [self getloyaltyCardNumberHandler:body.return_];
//                }
//                else {
//
//                    [HUD setHidden:YES];
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            NSLog(@"Exception occured %@",exception.name);
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        @finally {
//
//            [HUD setHidden:YES];
//        }
//
//
//
//    }
//    }
//    else{
//
//        [HUD setHidden:NO];
//
//        // Create the service
//        //        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
//        //        service.logging = YES;
//        //
//        //      // Returns NSString*.
//        //        [service getloyaltyCardNumber:self action:@selector(getloyaltyCardNumberHandler:)];
//
//        LoyaltycardServiceSoapBinding *offerBindng =  [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding];
//        LoyaltycardServiceSvc_issueLoyaltyCard *aParameters =  [[LoyaltycardServiceSvc_issueLoyaltyCard alloc] init];
//
//        NSArray *loyaltyKeys = @[@"idCardNumber", @"customerName",@"idCardType",@"loyaltyProgramNumber",@"phoneNum",@"email",@"requestHeader"];
//
//        NSArray *loyaltyObjects = @[idNotxt.text,usernametxt.text,idTypetxt.text,loyaltyProgram,phNotxt.text,emiltxt.text,[RequestHeader getRequestHeader]];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        aParameters.loyaltyCardDetails = normalStockString;
//        @try {
//
//            LoyaltycardServiceSoapBindingResponse *response = [offerBindng issueLoyaltyCardUsingParameters:aParameters];
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_issueLoyaltyCardResponse class]]) {
//                    LoyaltycardServiceSvc_issueLoyaltyCardResponse *body = (LoyaltycardServiceSvc_issueLoyaltyCardResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    [self getloyaltyCardNumberHandler:body.return_];
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            NSLog(@"Exception occured %@",exception.name);
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        @finally {
//
//            [HUD setHidden:YES];
//        }
//
//    }
//}






//submitButtonPressed method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

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
    else if ((idTypetxt.text).length == 0 ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter ID Type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if((phNotxt.text).length <= 9 || (phNotxt.text).length >= 14 || !isNumber) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if ((emiltxt.text).length!=0) {
        if(!isMail) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Mail ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
        else {
            
            [HUD setHidden:NO];
            
            NSArray *loyaltyKeys = @[@"idCardNumber", @"customerName",@"idCardType",@"loyaltyProgramNumber",@"phoneNum",@"email",@"requestHeader"];
            
            NSArray *loyaltyObjects = @[idNotxt.text,usernametxt.text,idTypetxt.text,loyaltyProgram,phNotxt.text,emiltxt.text,[RequestHeader getRequestHeader]];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * services  =  [[WebServiceController alloc] init];
            services.loyaltycardServicesDelegate =  self;
            [services issueLoyaltyCard:normalStockString];
            
        }
    }
    else{
        
        [HUD setHidden:NO];
        
        NSArray *loyaltyKeys = @[@"idCardNumber", @"customerName",@"idCardType",@"loyaltyProgramNumber",@"phoneNum",@"email",@"requestHeader"];
        
        NSArray *loyaltyObjects = @[idNotxt.text,usernametxt.text,idTypetxt.text,loyaltyProgram,phNotxt.text,emiltxt.text,[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController * services  =  [[WebServiceController alloc] init];
        services.loyaltycardServicesDelegate =  self;
        [services issueLoyaltyCard:normalStockString];
        
    }
}



// added by Roja on 17/10/2019….
- (void)issueLoyaltyCardSuccessReponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        [self getloyaltyCardNumberHandler:sucessDictionary];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019….
- (void)issueLoyaltyCardErrorResponse:(NSString *)error{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}




- (void) cancelButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewPurchasesBtnPressed:(UIButton *)sender {
    if ((phNotxt.text).length > 0) {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = @"Please wait...";
        [self.navigationController.view addSubview:HUD];
        // Regiser for HUD callbacks so we can remove it from the window at the right time
        HUD.delegate = self;
        
        // Show the HUD
        [HUD show:YES];
        [HUD setHidden:NO];
                
        [self getPendingBills];

    }
}

-(void)getPendingBills {
    
    if (!isOfflineService) {
        @try {
            @try {
                __block NSDictionary *JSON = [NSDictionary new];
                NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:@[[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%d",0],presentLocation,@"",@"customer", phNotxt.text] forKeys:@[REQUEST_HEADER,START_INDEX,STORE_LOCATION,DELIVERY_TYPE,STATUS,@"phoneNumber"]];
                
                NSError * err;
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
                NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                
                NSString *serviceUrl = [WebServiceUtility getURLFor:GET_BILLS];
                serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,orderJsonString];
                serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
                
                NSURL *url = [NSURL URLWithString:serviceUrl];
                NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
                request.HTTPMethod = @"POST";
                [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request setValue:[NSString stringWithFormat:@"%d", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
                
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response,
                                                           NSData *data, NSError *connectionError)
                 {
                     if (data.length > 0 && connectionError == nil)
                     {
                         JSON = [NSJSONSerialization JSONObjectWithData:data
                                                                options:0
                                                                  error:NULL];
                         NSLog(@"response :%@",JSON);
                         
                     }
                     else {
                         NSLog(@"Error %@",connectionError.localizedDescription);
                         
                     }
                     if (JSON.count) {
                         
                         if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                             
                             [self getBillsSuccesResponse:JSON];
                             
                         }
                         else {
                             [self getBillsFailureResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                         }
                     }
                     
                     else {
                         
                         [self getBillsFailureResponse:connectionError.localizedDescription];
                     }
                 }];
                
                
            }
            @catch (NSException *exception) {
                
                [self getBillsFailureResponse:exception.description];
                
            }
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception.name);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry failed to get data" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        @finally {
            [HUD setHidden:YES];
        }
    }
}

- (IBAction)selectDateOfBirth:(UIButton *)sender {
    
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
        
        pickView.frame = CGRectMake(dateOfBirthTxt.frame.origin.x, dateOfBirthTxt.frame.origin.y+dateOfBirthTxt.frame.size.height, 320, 320);
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
    myPicker.datePickerMode = UIDatePickerModeDate;
    
    //Current Date...
    NSDate *now = [NSDate date];
    [myPicker setDate:now animated:YES];
    myPicker.backgroundColor = [UIColor whiteColor];
    
    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
    pickButton.frame = CGRectMake(85, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDOB:) forControlEvents:UIControlEventTouchUpInside];
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
        
        [popover presentPopoverFromRect:dateOfBirthTxt.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
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
-(IBAction)getDOB:(id)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Date Formate Setting...
    
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    sdayFormat.dateFormat = @"dd/MM/yyyy";
    dateString = [sdayFormat stringFromDate:myPicker.date];
    
    NSDateFormatter *compDateFormat = [[NSDateFormatter alloc] init];
    compDateFormat.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    compDateFormat.dateFormat = @"dd/MM/yyyy";
    
    
    dateOfBirthTxt.text = dateString;
    
    [catPopOver dismissPopoverAnimated:YES];
    
    NSDate *startDate = [compDateFormat dateFromString:[compDateFormat stringFromDate:[NSDate date]]];
    NSDate *endDate = [compDateFormat dateFromString:dateString];
    
    
    if ([endDate compare:startDate]==NSOrderedDescending) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid_DOB", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
        dateOfBirthTxt.text = @"";
    }
    
    
}


#pragma -mark getBills delegate

-(void)getBillsSuccesResponse:(NSDictionary *)successDictionary {
    NSLog(@"%@",successDictionary);
    
    purchasesHistory = [[NSMutableArray alloc] init];
    NSArray *billsArray = [successDictionary valueForKey:@"billsList"];
    for (int i = 0; i < billsArray.count; i++) {
        NSArray *billItemsArray = [billsArray[i] valueForKey:@"billItems"];
        for (int j = 0; j < billItemsArray.count; j++) {
            [purchasesHistory addObject:billItemsArray[j]];
        }
    }

    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *editPriceView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1000.0, 1000.0)];
    editPriceView.opaque = NO;
    editPriceView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    editPriceView.layer.borderColor = [UIColor whiteColor].CGColor;
    editPriceView.layer.borderWidth = 3.0f;
    [editPriceView setHidden:NO];
    
    UILabel *billIDLbl = [[UILabel alloc] init] ;
    billIDLbl.layer.cornerRadius = 14;
    billIDLbl.textAlignment = NSTextAlignmentCenter;
    billIDLbl.layer.masksToBounds = YES;
    billIDLbl.font = [UIFont boldSystemFontOfSize:20.0];
    billIDLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billIDLbl.textColor = [UIColor whiteColor];
    billIDLbl.text = @"Bill ID";
    billIDLbl.frame = CGRectMake(5.0, 5.0, 200.0, 50.0);

    UILabel *skuIDLbl = [[UILabel alloc] init] ;
    skuIDLbl.layer.cornerRadius = 14;
    skuIDLbl.textAlignment = NSTextAlignmentCenter;
    skuIDLbl.layer.masksToBounds = YES;
    skuIDLbl.font = [UIFont boldSystemFontOfSize:20.0];
    skuIDLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    skuIDLbl.textColor = [UIColor whiteColor];
    skuIDLbl.text = @"Sku ID";
    skuIDLbl.frame = CGRectMake(210.0, 5.0, 100.0, 50.0);

    UILabel *itemLbl = [[UILabel alloc] init] ;
    itemLbl.layer.cornerRadius = 14;
    itemLbl.textAlignment = NSTextAlignmentCenter;
    itemLbl.layer.masksToBounds = YES;
    itemLbl.font = [UIFont boldSystemFontOfSize:20.0];
    itemLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    itemLbl.textColor = [UIColor whiteColor];
    itemLbl.text = @"Item Name";
    itemLbl.frame = CGRectMake(315.0, 5.0, 300.0, 50.0);

    UILabel *qtyLbl = [[UILabel alloc] init] ;
    qtyLbl.layer.cornerRadius = 14;
    qtyLbl.textAlignment = NSTextAlignmentCenter;
    qtyLbl.layer.masksToBounds = YES;
    qtyLbl.font = [UIFont boldSystemFontOfSize:20.0];
    qtyLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    qtyLbl.textColor = [UIColor whiteColor];
    qtyLbl.text = @"Qty";
    qtyLbl.frame = CGRectMake(620.0, 5.0, 80.0, 50.0);

    UILabel *priceLbl = [[UILabel alloc] init] ;
    priceLbl.layer.cornerRadius = 14;
    priceLbl.textAlignment = NSTextAlignmentCenter;
    priceLbl.layer.masksToBounds = YES;
    priceLbl.font = [UIFont boldSystemFontOfSize:20.0];
    priceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    priceLbl.textColor = [UIColor whiteColor];
    priceLbl.text = @"Total Price";
    priceLbl.frame = CGRectMake(705.0, 5.0, 140.0, 50.0);

    purchaseHistoryTable = [[UITableView alloc] init];
    purchaseHistoryTable.backgroundColor = [UIColor blackColor];
    purchaseHistoryTable.layer.borderColor = [UIColor blackColor].CGColor;
    purchaseHistoryTable.layer.cornerRadius = 4.0f;
    purchaseHistoryTable.layer.borderWidth = 1.0f;
    purchaseHistoryTable.dataSource = self;
    purchaseHistoryTable.delegate = self;
    purchaseHistoryTable.frame = CGRectMake(0.0, 55.0, editPriceView.frame.size.width, editPriceView.frame.size.height);

    [editPriceView addSubview:billIDLbl];
    [editPriceView addSubview:skuIDLbl];
    [editPriceView addSubview:itemLbl];
    [editPriceView addSubview:qtyLbl];
    [editPriceView addSubview:priceLbl];
    [editPriceView addSubview:purchaseHistoryTable];

    customerInfoPopUp.view = editPriceView;
    customerInfoPopUp.view.backgroundColor = [UIColor clearColor];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(editPriceView.frame.size.width, editPriceView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:viewPurchasesBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
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
-(void)getBillsFailureResponse:(NSString *)failureString {
    [HUD setHidden:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:failureString message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

// Commented by roja on 17/10/2019.. // reason : getloyaltyCardNumberHandler method contains SOAP Service call .. so taken new method with same name(getloyaltyCardNumberHandler) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//// Handle the response from getloyaltyCardNumber.
//- (void) getloyaltyCardNumberHandler: (NSString *) value {
//
//    // Handle errors
//    if([value isKindOfClass:[NSError class]]) {
//        NSLog(@"%@", value);
//        return;
//    }
//
//    // Handle faults
////    if([value isKindOfClass:[SoapFault class]]) {
////        NSLog(@"%@", value);
////        return;
////    }
//
//
//    // Do something with the NSString* result
//    NSString* result = (NSString*)value;
//
//    NSError *e;
//    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &e];
//
//    resultId.text = [NSString stringWithFormat:@"%@",JSON[@"loyaltyCardNumber"]];
//
//    if ([[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseCode"] intValue]==0) {
//
//    if (result.length >= 1) {
//
//        resultId.text = result;
//
//        [HUD setHidden:YES];
//
//        uiAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"Loyalty Card Issued. Your Loyalty No. is %@", [JSON valueForKey:@"loyaltyCardNumber"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [uiAlert show];
//
////        NSArray *temp = [result componentsSeparatedByString:@"#"];
////        randomNum = [temp objectAtIndex:1];
////
////        //send loyaltycard number format from selected option...
////        if ([loyaltyTypetxt.text isEqualToString:@"Platinum"]) {
////
////            loyaltyTypetxt.text = @"LP00000000000001";
////        }
////        else if([loyaltyTypetxt.text isEqualToString:@"Diamond"]){
////
////            loyaltyTypetxt.text = @"LP00000000000002";
////        }
////        else if([loyaltyTypetxt.text isEqualToString:@"Gold"]){
////
////            loyaltyTypetxt.text = @"LP00000000000003";
////        }
////        else if([loyaltyTypetxt.text isEqualToString:@"Silver"]){
////
////            loyaltyTypetxt.text = @"LP00000000000004";
////        }
////        else{
////            loyaltyTypetxt.text = @"LP00000000000005";
////        }
//
//        // Create the service
////        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
////        service.logging = YES;
////
////        // Returns NSString*.
////       // [service supplyLoyaltyCard:self action:@selector(supplyLoyaltyCardHandler:) customerName: usernametxt.text phone: phNotxt.text email: emiltxt.text idType: idTypetxt.text idCardNumber: idNotxt.text loyaltyProgramNumber: loyaltyTypetxt.text loyaltyCardNumber: randomNum];
////
////        NSLog(@"%@",loyaltyTypetxt.text);
////
////       [service supplyLoyaltyCard:self action:@selector(supplyLoyaltyCardHandler:) customerName: usernametxt.text phone: phNotxt.text email: emiltxt.text idType: idTypetxt.text idCardNumber: idNotxt.text loyaltyProgramNumber:loyaltyTypetxt.text loyaltyCardNumber: result];
////        {"idCardNumber":null,"customerName":null,"idType":null,"loyaltyProgramNumber":null,"phone":null,"email":null,"loyaltyCardNumber":null,"requestHeader":null}
//
//
////        LoyaltycardServiceSoapBinding *offerBindng =  [[LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] retain];
////        LoyaltycardServiceSvc_supplyLoyaltyCard *aParameters =  [[LoyaltycardServiceSvc_supplyLoyaltyCard alloc] init];
////
////        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
////        NSArray *str = [time componentsSeparatedByString:@" "];
////        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
////        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
////
////        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
////        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
////
////
////        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"idCardNumber", @"customerName",@"idType",@"loyaltyProgramNumber",@"phone",@"email",@"loyaltyCardNumber",@"requestHeader", nil];
////
////        NSArray *loyaltyObjects = [NSArray arrayWithObjects:idNotxt.text,usernametxt.text,idTypetxt.text,loyaltyTypetxt.text,phNotxt.text,emiltxt.text,[NSString stringWithFormat:@"%@",[JSON objectForKey:@"loyaltyCardNumber"]],dictionary, nil];
////        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
////
////        NSError * err_;
////        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
////        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//       // aParameters.loyaltyCardDetails = loyaltyString;
////        aParameters.customerName = usernametxt.text;
////        aParameters.phone = phNotxt.text;
////        aParameters.email = emiltxt.text;
////        aParameters.idType = idTypetxt.text;
////        aParameters.idCardNumber = idNotxt.text;
////        aParameters.loyaltyProgramNumber = loyaltyTypetxt.text;
////        aParameters.loyaltyCardNumber = result;
//
////        LoyaltycardServiceSoapBindingResponse *response = [offerBindng supplyLoyaltyCardUsingParameters:(LoyaltycardServiceSvc_supplyLoyaltyCard *)aParameters];
////        NSArray *responseBodyParts = response.bodyParts;
////        for (id bodyPart in responseBodyParts) {
////            if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_supplyLoyaltyCardResponse class]]) {
////                LoyaltycardServiceSvc_supplyLoyaltyCardResponse *body = (LoyaltycardServiceSvc_supplyLoyaltyCardResponse *)bodyPart;
////                printf("\nresponse=%s",[body.return_ UTF8String]);
////                [self supplyLoyaltyCardHandler:body.return_];
////            }
////        }
//    }
//}
//    else{
//
//        [HUD setHidden:YES];
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseMessage"]]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//
//
//    }
//
//}


// Commented by roja on 17/10/2019...

//// Handle the response from getloyaltyCardNumber.
//- (void) getloyaltyCardNumberHandler: (NSString *) value {
//
//    // Handle errors
//    if([value isKindOfClass:[NSError class]]) {
//        NSLog(@"%@", value);
//        return;
//    }
//
//    // Handle faults
//    //    if([value isKindOfClass:[SoapFault class]]) {
//    //        NSLog(@"%@", value);
//    //        return;
//    //    }
//
//
//    // Do something with the NSString* result
//    NSString* result = (NSString*)value;
//
//    NSError *e;
//    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &e];
//
//    resultId.text = [NSString stringWithFormat:@"%@",JSON[@"loyaltyCardNumber"]];
//
//    if ([[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseCode"] intValue]==0) {
//
//        if (result.length >= 1) {
//
//            resultId.text = result;
//
//            [HUD setHidden:YES];
//
//            uiAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"Loyalty Card Issued. Your Loyalty No. is %@", [JSON valueForKey:@"loyaltyCardNumber"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [uiAlert show];
//
//            //        NSArray *temp = [result componentsSeparatedByString:@"#"];
//            //        randomNum = [temp objectAtIndex:1];
//            //
//            //        //send loyaltycard number format from selected option...
//            //        if ([loyaltyTypetxt.text isEqualToString:@"Platinum"]) {
//            //
//            //            loyaltyTypetxt.text = @"LP00000000000001";
//            //        }
//            //        else if([loyaltyTypetxt.text isEqualToString:@"Diamond"]){
//            //
//            //            loyaltyTypetxt.text = @"LP00000000000002";
//            //        }
//            //        else if([loyaltyTypetxt.text isEqualToString:@"Gold"]){
//            //
//            //            loyaltyTypetxt.text = @"LP00000000000003";
//            //        }
//            //        else if([loyaltyTypetxt.text isEqualToString:@"Silver"]){
//            //
//            //            loyaltyTypetxt.text = @"LP00000000000004";
//            //        }
//            //        else{
//            //            loyaltyTypetxt.text = @"LP00000000000005";
//            //        }
//
//            // Create the service
//            //        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
//            //        service.logging = YES;
//            //
//            //        // Returns NSString*.
//            //       // [service supplyLoyaltyCard:self action:@selector(supplyLoyaltyCardHandler:) customerName: usernametxt.text phone: phNotxt.text email: emiltxt.text idType: idTypetxt.text idCardNumber: idNotxt.text loyaltyProgramNumber: loyaltyTypetxt.text loyaltyCardNumber: randomNum];
//            //
//            //        NSLog(@"%@",loyaltyTypetxt.text);
//            //
//            //       [service supplyLoyaltyCard:self action:@selector(supplyLoyaltyCardHandler:) customerName: usernametxt.text phone: phNotxt.text email: emiltxt.text idType: idTypetxt.text idCardNumber: idNotxt.text loyaltyProgramNumber:loyaltyTypetxt.text loyaltyCardNumber: result];
//            //        {"idCardNumber":null,"customerName":null,"idType":null,"loyaltyProgramNumber":null,"phone":null,"email":null,"loyaltyCardNumber":null,"requestHeader":null}
//
//
//            //        LoyaltycardServiceSoapBinding *offerBindng =  [[LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] retain];
//            //        LoyaltycardServiceSvc_supplyLoyaltyCard *aParameters =  [[LoyaltycardServiceSvc_supplyLoyaltyCard alloc] init];
//            //
//            //        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
//            //        NSArray *str = [time componentsSeparatedByString:@" "];
//            //        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
//            //        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
//            //
//            //        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
//            //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
//            //
//            //
//            //        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"idCardNumber", @"customerName",@"idType",@"loyaltyProgramNumber",@"phone",@"email",@"loyaltyCardNumber",@"requestHeader", nil];
//            //
//            //        NSArray *loyaltyObjects = [NSArray arrayWithObjects:idNotxt.text,usernametxt.text,idTypetxt.text,loyaltyTypetxt.text,phNotxt.text,emiltxt.text,[NSString stringWithFormat:@"%@",[JSON objectForKey:@"loyaltyCardNumber"]],dictionary, nil];
//            //        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//            //
//            //        NSError * err_;
//            //        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//            //        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//            // aParameters.loyaltyCardDetails = loyaltyString;
//            //        aParameters.customerName = usernametxt.text;
//            //        aParameters.phone = phNotxt.text;
//            //        aParameters.email = emiltxt.text;
//            //        aParameters.idType = idTypetxt.text;
//            //        aParameters.idCardNumber = idNotxt.text;
//            //        aParameters.loyaltyProgramNumber = loyaltyTypetxt.text;
//            //        aParameters.loyaltyCardNumber = result;
//
//            //        LoyaltycardServiceSoapBindingResponse *response = [offerBindng supplyLoyaltyCardUsingParameters:(LoyaltycardServiceSvc_supplyLoyaltyCard *)aParameters];
//            //        NSArray *responseBodyParts = response.bodyParts;
//            //        for (id bodyPart in responseBodyParts) {
//            //            if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_supplyLoyaltyCardResponse class]]) {
//            //                LoyaltycardServiceSvc_supplyLoyaltyCardResponse *body = (LoyaltycardServiceSvc_supplyLoyaltyCardResponse *)bodyPart;
//            //                printf("\nresponse=%s",[body.return_ UTF8String]);
//            //                [self supplyLoyaltyCardHandler:body.return_];
//            //            }
//            //        }
//        }
//    }
//    else{
//
//        [HUD setHidden:YES];
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseMessage"]]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//
//    }
//}


//getissuedLoyaltycardHandler method changed by roja on 17/10/2019.. // reason : AFter converting SOAP to REST service call (in submitButton:), THE
// At the time of converting SOAP call's to REST

// Handle the response from getloyaltyCardNumber.
- (void) getloyaltyCardNumberHandler: (NSDictionary *) successResponse {
    
    resultId.text = [NSString stringWithFormat:@"%@",successResponse[@"loyaltyCardNumber"]];
    
    if(successResponse != nil){
        
        [HUD setHidden:YES];
        uiAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"Loyalty Card Issued. Your Loyalty No. is %@", [successResponse valueForKey:@"loyaltyCardNumber"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [uiAlert show];
    }
    else{
        
        [HUD setHidden:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to Issue Loyalty Card" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    
    // Handle faults
//    if([value isKindOfClass:[SoapFault class]]) {
//        NSLog(@"%@", value);
//        return;
//    }                
    
    
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

- (NSString *) emailBill:(NSString *)uuid loyaltyNumber:(NSString *)loyaltyNumber name:(NSString *)name {
    
    NSString *str = [NSString stringWithFormat: @" <html><body><table style='border: solid #ccc 1px; border-radius: 15px; color: grey' align='center' width = '500px'><tbody><tr><td style='padding-left:10px;' colspan='2'><img src='cid:%@'></td></tr>",uuid];
    
        str = [NSString stringWithFormat:@"%@%@%@", str,@"<tr style='border-collapse: separate'><td align='center' style='padding-top: 0px; border-bottom: 1px solid grey; padding-bottom: 8px;padding-right:40px'colspan='2'><b style='font-family: monospace;font-size:20px; color: black;'>",loyaltyNumber];
    
       str = [NSString stringWithFormat:@"%@%@%@%@",str, @"</b></td></tr><tr height='25px'><td align='right'    style='padding-right: 10px;padding-left:-50px; font-weight: bold; font-family: sans-serif;'>Name</td><td style='font-weight: bold; font-family: sans-serif;'>",  name ,@"</td></tr><tr height='25px'><td align='right'    style='padding-right: 10px;padding-left:-50px; font-weight: bold; font-family: sans-serif;'>Points</td><td style='font-weight: bold; font-family: sans-serif;'>0</td></tr><tr height='25px'><td align='right'    style='padding-right: 10px;padding-left:-50px; font-weight: bold; font-family: sans-serif;'>Cash</td><td style='font-weight: bold; font-family: sans-serif;'>0</td></tr></tbody></table></body></html>"];
  
    return str;
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


//messageFailed handler...
-(void)messageFailed
{
    
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
-(void) closeSMSView{
    
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

//- (void) runScheduledTask:(NSTimer*)theTimer {
//
//    aTimer = nil;
//}

// MAIL METHODS END ..

-(IBAction) loyaltyTypeTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    loyaltyTypeTable.hidden = YES;
    
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
            [self.navigationController popViewControllerAnimated:YES];

        }
    }

}
-(void)backAction {
    if ((usernametxt.text).length>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

// Commented by roja on 17/10/2019.. // reason : getLoyaltyPrograms method contains SOAP Service call .. so taken new method with same name(getLoyaltyPrograms) method name which contains REST service call....
// At the time of converting SOAP call's to REST
////get loyalty pograms...
//-(void)getLoyaltyPrograms {
//
//    [HUD setHidden:NO];
//    loyalTypeList = [[NSMutableArray alloc]init];
//    loyaltyPgm = [[NSMutableArray alloc]init];
//
//    LoyaltycardServiceSoapBinding *offerBindng =  [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding];
//    LoyaltycardServiceSvc_getAvailableLoyaltyPrograms *aParameters =  [[LoyaltycardServiceSvc_getAvailableLoyaltyPrograms alloc] init];
//
////    RequestHeader *header = [[RequestHeader alloc]init];
//    NSDictionary *dictionary = [RequestHeader getRequestHeader];
//
//    NSArray *loyaltyKeys = @[@"requestHeader"];
//
//    NSArray *loyaltyObjects = @[dictionary];
//    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//    NSError * err_;
//    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//    aParameters.loyaltyCardDetails = normalStockString;
//    @try {
//
//        LoyaltycardServiceSoapBindingResponse *response = [offerBindng getAvailableLoyaltyProgramsUsingParameters:aParameters];
//        NSArray *bodyParts = response.bodyParts;
//
//        for (id bodyPart in bodyParts) {
//            if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse class]]) {
//                LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse *body = (LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//                [HUD setHidden:YES];
//
//                NSError *e;
//                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                     options: NSJSONReadingMutableContainers
//                                                                       error: &e];
//                if ([[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseCode"] intValue]==0) {
//
//                    NSArray *arr = [JSON valueForKey:@"availablePrograms"];
//                    if (arr.count>0) {
//                        for (int i=0; i<arr.count; i++) {
//
//                            NSDictionary *dic = arr[i];
//                            [loyalTypeList addObject:[dic valueForKey:@"loyaltyProgramName"]];
//                            [loyaltyPgm addObject:[dic valueForKey:@"loyaltyProgramNumber"]];
//
//                        }
//
//                    }
//
//
//                }
//
//               // [self getloyaltyCardNumberHandler:body.return_];
//            }
//            else {
//                [HUD setHidden:YES];
//            }
//        }
//
//    }
//    @catch (NSException *exception) {
//        [HUD setHidden:YES];
//    }
//}



//getLoyaltyPrograms method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
//get loyalty pograms...
-(void)getLoyaltyPrograms {
    
    [HUD setHidden:NO];
    loyalTypeList = [[NSMutableArray alloc]init];
    loyaltyPgm = [[NSMutableArray alloc]init];

    //    RequestHeader *header = [[RequestHeader alloc]init];
    NSDictionary *dictionary = [RequestHeader getRequestHeader];
    
    NSArray *loyaltyKeys = @[@"requestHeader"];
    
    NSArray *loyaltyObjects = @[dictionary];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    WebServiceController * services = [[WebServiceController alloc] init];
    services.loyaltycardServicesDelegate = self;
    [services getAvailableLoyaltyPrograms:normalStockString];
    
}


// added by Roja on 17/10/2019…. .. //Old code only pasted below
- (void)getAvailableLoyaltyProgramsSuccessReponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        NSArray *arr = [sucessDictionary valueForKey:@"availablePrograms"];
        
        if (arr.count>0) {
            
            for (int i=0; i<arr.count; i++) {
                
                NSDictionary *dic = arr[i];
                [loyalTypeList addObject:[dic valueForKey:@"loyaltyProgramName"]];
                [loyaltyPgm addObject:[dic valueForKey:@"loyaltyProgramNumber"]];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


// added by Roja on 17/10/2019…. .. //Old code only pasted below
- (void)getAvailableLoyaltyProgramsErrorResponse:(NSString *)error{
    
    @try {
        UIAlertView * alert  =  [[UIAlertView alloc] initWithTitle:@"" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}
- (void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
