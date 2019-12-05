//
//  IssueLowyalty.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 1/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "IssueGiftCoupon.h"
//#import "SDZLoyaltycardService.h"
#import "LoyaltycardServiceSvc.h"
#import "GiftCouponServicesSvc.h"
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

@implementation IssueGiftCoupon

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
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    self.titleLabel.text = @"Issue Gift Coupon";
    
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
    phNotxt.placeholder = @"     Mobile No";    //place holder
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
    
    UIImageView *id_Type=[[UIImageView alloc] init]; // Set frame as per space required around icon
    id_Type.image = [UIImage imageNamed:@"Id_type.png"];
    
    idTypetxt = [[CustomTextField alloc] init];
    idTypetxt.borderStyle = UITextBorderStyleRoundedRect;
    idTypetxt.textColor = [UIColor blackColor];
    idTypetxt.font = [UIFont systemFontOfSize:17.0];
    idTypetxt.placeholder = @"Select Coupon Value";  //place holder
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
    loyaltyTypetxt.placeholder = @"No.Of Coupons";  //place holder
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
    
    addGVButton = [[UIButton alloc] init] ;
    [addGVButton setTitle:@"ADD" forState:UIControlStateNormal];
    addGVButton.backgroundColor = [UIColor grayColor];
    addGVButton.layer.masksToBounds = YES;
    addGVButton.layer.cornerRadius = 5.0f;
    [addGVButton addTarget:self action:@selector(addGVButton:) forControlEvents:UIControlEventTouchDown];
    
    // NSMutableArray initialization.....
    idslist = [[NSMutableArray alloc] init];
    
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
    
    selectGiftVoucherTable = [[UITableView alloc] init];
    selectGiftVoucherTable.backgroundColor = [UIColor clearColor];
    selectGiftVoucherTable.layer.borderColor = [UIColor blackColor].CGColor;
    selectGiftVoucherTable.layer.cornerRadius = 4.0f;
    selectGiftVoucherTable.layer.borderWidth = 1.0f;
    selectGiftVoucherTable.dataSource = self;
    selectGiftVoucherTable.delegate = self;
    selectGiftVoucherTable.hidden = YES;
    
    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet ;
    
    //    //selected lowaltytype table creation....
    loyaltyTypeTable = [[UITableView alloc] init];
    //    loyaltyTypeTable.backgroundColor = [UIColor colorWithRed:139.0/255.0 green:179.0/255.0 blue:129.0/255.0 alpha:1.0];
    loyaltyTypeTable.backgroundColor = [UIColor whiteColor];
    loyaltyTypeTable.layer.borderColor = [UIColor blackColor].CGColor;
    loyaltyTypeTable.layer.cornerRadius = 4.0f;
    loyaltyTypeTable.layer.borderWidth = 1.0f;
    loyaltyTypeTable.dataSource = self;
    loyaltyTypeTable.delegate = self;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.font = [UIFont boldSystemFontOfSize:25];
        //        label.frame = CGRectMake(10, 0, 200, 50);
        //        backbutton.frame = CGRectMake(710.0, 5.0, 40.0, 40.0);
        scrollView.frame = CGRectMake(0, 51, self.view.frame.size.width, self.view.frame.size.height);
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
        //issueLoyaltyView.frame = CGRectMake(20, 22, 738, 800);
        //img1.frame = CGRectMake(0, 0, 738, 200);
        userImage.frame = CGRectMake(60, 30, 50, 50);
        phoneImage.frame = CGRectMake(60, 115.0, 50, 50);
        mailImage.frame = CGRectMake(40, 180, 90, 100);
        id_Type.frame = CGRectMake(60, 300, 50, 60);
        id_No.frame = CGRectMake(60, 400, 50, 60);
        loyalcard.frame = CGRectMake(60, 495, 50, 70);
        
        username.font = [UIFont systemFontOfSize:30];
        username.frame = CGRectMake(30, 10, 300, 50);
        phNo.text = @"Phone No.";
        phNo.font = [UIFont systemFontOfSize:30];
        phNo.frame = CGRectMake(30, 100, 300, 50);
        email.font = [UIFont systemFontOfSize:30];
        email.frame = CGRectMake(30, 170, 300, 50);
        idType.font = [UIFont systemFontOfSize:30];
        idType.frame = CGRectMake(30, 240, 300, 50);
        idNo.font = [UIFont systemFontOfSize:30];
        idNo.frame = CGRectMake(30, 310, 300, 50);
        loyaltyType.font = [UIFont systemFontOfSize:30];
        loyaltyType.frame = CGRectMake(15, 370, 200, 50);
        
        usernametxt.font = [UIFont systemFontOfSize:25];
        usernametxt.frame = CGRectMake(80, 85, 450, 60);
        phNotxt.font = [UIFont systemFontOfSize:25];
        phNotxt.frame = CGRectMake(80, 10, 450, 60);
        emiltxt.font = [UIFont systemFontOfSize:25];
        emiltxt.frame = CGRectMake(540, 85, 450, 60);
        idTypetxt.font = [UIFont systemFontOfSize:20];
        idTypetxt.frame = CGRectMake(80, 210.0, 300, 60);
        lisbtn.frame = CGRectMake(370.0, 204.0, 50, 77);
        
        //        idNotxt.font = [UIFont systemFontOfSize:30];
        //        idNotxt.frame = CGRectMake(130, 350, 520, 60);
        loyaltyTypetxt.font = [UIFont systemFontOfSize:20];
        loyaltyTypetxt.frame = CGRectMake(540.0, 210.0, 300, 60);
        
        loyaltyTypelist.frame = CGRectMake(820.0, 204.0,50, 77);
        
        addGVButton.frame = CGRectMake(880.0f, 210.0,100.0f, 55.0f);
        addGVButton.layer.cornerRadius = 25.0f;
        addGVButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        submitBtn.frame = CGRectMake(150.0f, 600.0f,300.0f, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelButton.frame = CGRectMake(600.0f, 600.0f,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        idlistTableView.frame = CGRectMake(130, 360,idNotxt.frame.size.width, 200);
        loyaltyTypeTable.frame = CGRectMake(130, 560,loyaltyTypetxt.frame.size.width, 300);
        
        usernametxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:usernametxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        idNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        idTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:idTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        emiltxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:emiltxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        phNotxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNotxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        loyaltyTypetxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:loyaltyTypetxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
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
            lisbtn.frame = CGRectMake(240.0f, 147.0f,25.0f, 37.0f);
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
            lisbtn.frame = CGRectMake(240.0f, 147.0f,25.0f, 37.0f);
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
    [scrollView addSubview:usernametxt];
    [scrollView addSubview:emiltxt];
    [scrollView addSubview:phNotxt];
    [scrollView addSubview:idTypetxt];
    [scrollView addSubview:idNotxt];
    [scrollView addSubview:loyaltyTypetxt];
    [scrollView addSubview:loyaltyTypelist];
    [scrollView addSubview:submitBtn];
    [scrollView addSubview:cancelButton];
    [scrollView addSubview:addGVButton];
    [scrollView addSubview:idlistTableView];
    idlistTableView.hidden = YES;
    loyaltyTypeTable.hidden = YES;
    [scrollView addSubview:loyaltyTypeTable];
    //scrollView.hidden = YES;
    [scrollView addSubview:lisbtn];
    // mailview initialization....
    mailView = [[UIView alloc] init];
    // mailView.hidden = YES;
    [self.view addSubview:scrollView];
    
    
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
    selectGiftVoucherArr = [[NSMutableArray alloc] init];
    
    snoLbl = [[UILabel alloc]init];
    snoLbl.text = @"S No";
    snoLbl.layer.cornerRadius = 14;
    snoLbl.textAlignment = NSTextAlignmentCenter;
    snoLbl.layer.masksToBounds = YES;
    snoLbl.font = [UIFont boldSystemFontOfSize:20.0];
    snoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    snoLbl.textColor = [UIColor whiteColor];
    
    cashValueLbl = [[UILabel alloc]init];
    cashValueLbl.text = @"Coupon Value";
    cashValueLbl.layer.cornerRadius = 14;
    cashValueLbl.textAlignment = NSTextAlignmentCenter;
    cashValueLbl.layer.masksToBounds = YES;
    cashValueLbl.font = [UIFont boldSystemFontOfSize:20.0];
    cashValueLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cashValueLbl.textColor = [UIColor whiteColor];
    
    noOfVouchersLbl = [[UILabel alloc]init];
    noOfVouchersLbl.text = @"Coupon Number";
    noOfVouchersLbl.layer.cornerRadius = 14;
    noOfVouchersLbl.textAlignment = NSTextAlignmentCenter;
    noOfVouchersLbl.layer.masksToBounds = YES;
    noOfVouchersLbl.font = [UIFont boldSystemFontOfSize:20.0];
    noOfVouchersLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    noOfVouchersLbl.textColor = [UIColor whiteColor];
    
    expiryDateLbl = [[UILabel alloc]init];
    expiryDateLbl.text = @"Expiry Date";
    expiryDateLbl.layer.cornerRadius = 14;
    expiryDateLbl.textAlignment = NSTextAlignmentCenter;
    expiryDateLbl.layer.masksToBounds = YES;
    expiryDateLbl.font = [UIFont boldSystemFontOfSize:20.0];
    expiryDateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    expiryDateLbl.textColor = [UIColor whiteColor];
    
    snoLbl.frame = CGRectMake(80.0, 300.0, 150.0, 50.0);
    cashValueLbl.frame = CGRectMake(240.0, 300.0, 200.0, 50.0);
    noOfVouchersLbl.frame = CGRectMake(450.0, 300.0, 200.0, 50.0);
    expiryDateLbl.frame = CGRectMake(660.0, 300.0, 200.0, 50.0);
    selectGiftVoucherTable.frame = CGRectMake(80.0, 350.0, 900.0, 200.0);
    
    [scrollView addSubview:cashValueLbl];
    [scrollView addSubview:noOfVouchersLbl];
    [scrollView addSubview:snoLbl];
    [scrollView addSubview:expiryDateLbl];
    [scrollView addSubview:selectGiftVoucherTable];
    
    [self provideCustomerRatingfor:nil];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [HUD setHidden:NO];
    HUD.labelText = @"Loading Data..";
    //    [HUD setHidden:YES];
    [self getAllAvailableVouchers];
}

-(void)getAllAvailableVouchers {
    GiftCouponServicesSoapBinding *skuService = [GiftCouponServicesSvc GiftCouponServicesSoapBinding] ;
    
    GiftCouponServicesSvc_getGiftCouponsMaster *voucher = [[GiftCouponServicesSvc_getGiftCouponsMaster alloc] init];
    
    
    NSArray *loyaltyKeys = @[@"requestHeader", @"storeLocation", @"locations",@"availableCoupons"];
    
    NSArray *loyaltyObjects = @[[RequestHeader getRequestHeader],presentLocation, presentLocation,@"yes"];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    
    voucher.giftCouponDetails = loyaltyString;
    @try {
        
        GiftCouponServicesSoapBindingResponse *response = [skuService getGiftCouponsMasterUsingParameters:voucher];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[GiftCouponServicesSvc_getGiftCouponsMasterResponse class]]) {
                GiftCouponServicesSvc_getGiftCouponsMasterResponse *body = (GiftCouponServicesSvc_getGiftCouponsMasterResponse *)bodyPart;
                printf("\nresponse=%s",(body.return_).UTF8String);
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                idslist = [[NSMutableArray alloc] initWithArray:[JSON valueForKey:@"giftCouponsList"]];
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

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == phNotxt) {
        if (textField.text.length == 10) {
            [phNotxt resignFirstResponder];
            [self getCustomerDetailsForOffers];
        }
    }
}
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

-(void)provideCustomerRatingfor:(NSString *)category
{
    [starRat removeFromSuperview];
    starRat = [[UIImageView alloc] init];
    starRat.backgroundColor = [UIColor clearColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        starRat.frame = CGRectMake(540.0, 20.0, 130.0, 30.0);
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
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *editPriceView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, idTypetxt.frame.size.width, 300)];
    editPriceView.opaque = NO;
    editPriceView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    editPriceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    editPriceView.layer.borderWidth = 2.0f;
    [editPriceView setHidden:NO];
    
    idlistTableView = [[UITableView alloc] init];
    idlistTableView.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
    idlistTableView.layer.borderColor = [UIColor blackColor].CGColor;
    idlistTableView.layer.cornerRadius = 4.0f;
    idlistTableView.layer.borderWidth = 1.0f;
    idlistTableView.dataSource = self;
    idlistTableView.delegate = self;
    idlistTableView.bounces = FALSE;
    idlistTableView.frame = CGRectMake(0.0, 0.0, editPriceView.frame.size.width, editPriceView.frame.size.height);
    
    [editPriceView addSubview:idlistTableView];
    customerInfoPopUp.view = editPriceView;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(editPriceView.frame.size.width, editPriceView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:idTypetxt.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
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
            
            [popover presentPopoverFromRect:loyaltyTypetxt.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            
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
        @try {
            
            GiftCouponServicesSoapBinding *skuService = [GiftCouponServicesSvc GiftCouponServicesSoapBinding] ;
            
            GiftCouponServicesSvc_issueGiftCouponToCustomer *voucher = [[GiftCouponServicesSvc_issueGiftCouponToCustomer alloc] init];
            
            NSArray *customerInfoKeys = @[@"phone", @"name",@"email"];
            
            NSArray *customerInfoObjects = @[phNotxt.text,usernametxt.text,emiltxt.text];
            NSDictionary *customerDic = [NSDictionary dictionaryWithObjects:customerInfoObjects forKeys:customerInfoKeys];
            
            
            NSArray *loyaltyKeys = @[@"requestHeader", @"customerObj", @"couponsList", @"locations"];
            
            NSArray *loyaltyObjects = @[[RequestHeader getRequestHeader], customerDic, selectGiftVoucherArr,presentLocation];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            
            voucher.issueCoupon = loyaltyString;
            
            GiftCouponServicesSoapBindingResponse *response = [skuService issueGiftCouponToCustomerUsingParameters:voucher];
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[GiftCouponServicesSvc_issueGiftCouponToCustomerResponse class]]) {
                    GiftCouponServicesSvc_issueGiftCouponToCustomerResponse *body = (GiftCouponServicesSvc_issueGiftCouponToCustomerResponse *)bodyPart;
                    printf("\nresponse=%s",(body.return_).UTF8String);
                    NSError *e;
                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options: NSJSONReadingMutableContainers
                                                                           error: &e];
                    NSLog(@"%@",JSON);
                    if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0 && [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] isEqualToString:@"Success"]) {
                        UIAlertView *returnSuccessAlert = [[UIAlertView alloc] initWithTitle:@"Gift Coupon Issued Successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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


- (void) cancelButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [self.navigationController popViewControllerAnimated:YES];
}
// Handle the response from getloyaltyCardNumber.

- (void) getloyaltyCardNumberHandler: (NSString *) value {
    
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


// KeyBoard hidden handler...
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

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == loyaltyTypeTable) {
        return numberOfVouchers;
    }
    else if (tableView == selectGiftVoucherTable) {
        return selectGiftVoucherArr.count;
    }
    else{
        return idslist.count;
    }
}


//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 50.0;
    }
    else {
        return 30.0;
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        cell.frame = CGRectZero;
    }
    if (tableView == loyaltyTypeTable) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row + 1)];
    }
    else if (tableView == selectGiftVoucherTable) {
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
            
            NSDictionary *dic = selectGiftVoucherArr[indexPath.row];
            
            UILabel *sno = [[UILabel alloc] init] ;
            sno.layer.borderWidth = 1.5;
            sno.font = [UIFont systemFontOfSize:13.0];
            sno.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            sno.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            sno.backgroundColor = [UIColor blackColor];
            sno.textColor = [UIColor whiteColor];
            sno.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
            sno.textAlignment=NSTextAlignmentCenter;
            
            UILabel *skid = [[UILabel alloc] init] ;
            skid.layer.borderWidth = 1.5;
            skid.font = [UIFont systemFontOfSize:13.0];
            skid.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            skid.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            skid.backgroundColor = [UIColor blackColor];
            skid.textColor = [UIColor whiteColor];
            skid.text = [NSString stringWithFormat:@"%.1f",[[dic valueForKey:@"couponValue"] floatValue]];
            skid.textAlignment=NSTextAlignmentCenter;
            //            skid.adjustsFontSizeToFitWidth = YES;
            
            UILabel *mrpPrice = [[UILabel alloc] init] ;
            mrpPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            mrpPrice.layer.borderWidth = 1.5;
            mrpPrice.backgroundColor = [UIColor blackColor];
            mrpPrice.text = [NSString stringWithFormat:@"%d",[[dic valueForKey:@"noOfCoupons"] intValue]];
            mrpPrice.textAlignment = NSTextAlignmentCenter;
            mrpPrice.numberOfLines = 2;
            mrpPrice.textColor = [UIColor whiteColor];
            
            UILabel *price = [[UILabel alloc] init] ;
            price.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            price.layer.borderWidth = 1.5;
            price.backgroundColor = [UIColor blackColor];
            price.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"expiryDate"]];
            price.textAlignment = NSTextAlignmentCenter;
            price.numberOfLines = 2;
            price.textColor = [UIColor whiteColor];
            // name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            UIButton *delrowbtn = [[UIButton alloc] init] ;
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                sno.font = [UIFont systemFontOfSize:18];
                sno.frame = CGRectMake(5, 0, 150.0, 60.0);
                skid.font = [UIFont systemFontOfSize:18];
                skid.frame = CGRectMake(155, 0, 210.0, 60);
                mrpPrice.font = [UIFont systemFontOfSize:18];
                mrpPrice.frame = CGRectMake(365.0, 0, 210.0, 60);
                price.font = [UIFont systemFontOfSize:18];
                price.frame = CGRectMake(575.0, 0, 210.0, 60);
                
                delrowbtn.frame = CGRectMake(800.0, 5, 50, 50);
                
            }
            else {
                
                skid.frame = CGRectMake(10, 0, 100, 34);
                price.frame = CGRectMake(120, 0, 90, 34);
                
                
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:sno];
            [hlcell.contentView addSubview:skid];
            [hlcell.contentView addSubview:delrowbtn];
            [hlcell.contentView addSubview:mrpPrice];
            [hlcell.contentView addSubview:price];
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        }
        @finally {
            
            
        }
        return hlcell;
        
    }
    else{
        NSDictionary *gvinfoDic = idslist[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%.1f",[[gvinfoDic valueForKey:@"unitCashValue"] floatValue]];
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.textLabel.font = [UIFont systemFontOfSize:25.0];
    }
    else {
        cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (tableView == loyaltyTypeTable) {
        
        [editPricePopOver dismissPopoverAnimated:YES];
        loyaltyTypeTable.hidden = YES;
        loyaltyTypetxt.text = [NSString stringWithFormat:@"%ld",(indexPath.row + 1)];
    }
    else{
        @try {
            NSDictionary *gvInfoDic = idslist[indexPath.row];
            selectCashValuePosition = indexPath.row;
            numberOfVouchers = [[gvInfoDic valueForKey:@"totalCoupons"] intValue];
            idTypetxt.text = [NSString stringWithFormat:@"%.1f",[[gvInfoDic valueForKey:@"unitCashValue"] floatValue]];
            idlistTableView.hidden = YES;
            [editPricePopOver dismissPopoverAnimated:YES];
            [self lyaltyTypeSelectionPressed:loyaltyTypelist];

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
}



-(IBAction) loyaltyTypeTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    loyaltyTypeTable.hidden = YES;
    
}

/**
 * @description  here we are
 * @date
 * @method       addGVButton:
 * @author
 * @param        UIButton
 * @param
 *
 * @return       void
 *
 * @modified By Srinivasulu on 16/12/2017....
 * @reason      added the comments and exception handling  .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void)addGVButton:(UIButton *)sender {
    @try {
    
        NSDictionary *gvInfoDic = idslist[selectCashValuePosition];
        
        if (selectGiftVoucherArr.count) {
            BOOL existingStatus = FALSE;
            int changePosition;
            NSMutableDictionary *existingGVDic = [NSMutableDictionary new];
            
            for (int i = 0; i < selectGiftVoucherArr.count; i++) {
                NSMutableDictionary *GVDic = selectGiftVoucherArr[i];
                if ([[GVDic valueForKey:@"couponProgramCode"] isEqualToString:[gvInfoDic valueForKey:@"couponProgramCode"]]) {
                    [GVDic setValue:loyaltyTypetxt.text forKey:@"noOfCoupons"];
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
                [selectGVDic setValue:idTypetxt.text forKey:@"couponValue"];
                [selectGVDic setValue:[gvInfoDic valueForKey:@"couponProgramCode"] forKey:@"couponProgramCode"];
                [selectGVDic setValue:loyaltyTypetxt.text forKey:@"noOfCoupons"];
                [selectGVDic setValue:[gvInfoDic valueForKey:@"expiryDate"] forKey:@"expiryDate"];
                [selectGiftVoucherArr addObject:selectGVDic];
                
            }
            [selectGiftVoucherTable setHidden:NO];
        }
        else {
            if ((idTypetxt.text).length != 0 && (loyaltyTypetxt.text).length !=0) {
                NSMutableDictionary *selectGVDic = [NSMutableDictionary new];
                [selectGVDic setValue:idTypetxt.text forKey:@"couponValue"];
                [selectGVDic setValue:[gvInfoDic valueForKey:@"couponProgramCode"] forKey:@"couponProgramCode"];
                [selectGVDic setValue:loyaltyTypetxt.text forKey:@"noOfCoupons"];
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
    else if ([alertView.title isEqualToString:@"Gift Coupon Issued Successfully"]){
        [self cancelButtonPressed:cancelButton];
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

-(void)delRow:(UIButton *)sender {
    [selectGiftVoucherArr removeObjectAtIndex:sender.tag];
    [selectGiftVoucherTable reloadData];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


// Commented by roja on 17/10/2019.. // reason : getLoyaltyPrograms method contains SOAP Service call .. so taken new method with same name(getLoyaltyPrograms) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getLoyaltyPrograms {
//
//    [HUD setHidden:NO];
//    loyalTypeList = [[NSMutableArray alloc]init];
//    loyaltyPgm = [[NSMutableArray alloc]init];
//
//    LoyaltycardServiceSoapBinding *offerBindng =  [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] ;
//    LoyaltycardServiceSvc_getAvailableLoyaltyPrograms *aParameters =  [[LoyaltycardServiceSvc_getAvailableLoyaltyPrograms alloc] init];
//
//    RequestHeader *header = [[RequestHeader alloc]init];
//    NSDictionary *dictionary = [RequestHeader getRequestHeader];
//
//    NSArray *loyaltyKeys = @[@"requestHeader", @"storeLocation"];
//
//    NSArray *loyaltyObjects = @[dictionary, presentLocation];
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
//                // [self getloyaltyCardNumberHandler:body.return_];
//            }
//            else {
//                [HUD setHidden:YES];
//            }
//        }
//    }
//    @catch (NSException *exception) {
//        [HUD setHidden:YES];
//    }
//}


//getLoyaltyPrograms method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getLoyaltyPrograms {
    
    [HUD setHidden:NO];
    loyalTypeList = [[NSMutableArray alloc]init];
    loyaltyPgm = [[NSMutableArray alloc]init];

    NSDictionary *dictionary = [RequestHeader getRequestHeader];
    
    NSArray *loyaltyKeys = @[@"requestHeader", @"storeLocation"];
    NSArray *loyaltyObjects = @[dictionary, presentLocation];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];

    WebServiceController * services =  [[WebServiceController alloc] init];
    services.loyaltycardServicesDelegate = self;
    [services getAvailableLoyaltyPrograms:normalStockString];
}


// added by Roja on 17/10/2019…. OLd code only pasted below
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

// added by Roja on 17/10/2019…. OLd code only pasted below
- (void)getAvailableLoyaltyProgramsErrorResponse:(NSString *)error{
    
    @try {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
