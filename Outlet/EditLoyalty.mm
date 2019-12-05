//
//  ShowLowyalty.m
//  OmniRetailer
//
//  Created by Sonali on 1/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "EditLoyalty.h"
#import "ShowLowyalty.h"
#import "Global.h"
#import "RequestHeader.h"
//#import "SDZLoyaltycardService.h"
#import "LoyaltycardServiceSvc.h"
#import "OmniHomePage.h"
#ifndef ZXQR
#define ZXQR 1
#endif


//#if ZXQR
//#import "MultiFormatOneDReader.h"
//#endif


#ifndef ZXAZ
#define ZXAZ 0
#endif


@implementation EditLoyalty

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
    
    loyaltyNumtxt = nil;
    
    username =nil;
    phNo = nil;
    email = nil;
    idType = nil;
    validFrom = nil;
    validThru =nil;
    availPoints = nil;
    amount = nil;
    
    
    usernameData =nil;
    phNoData = nil;
    emailData = nil;
    idNo = nil;
    validFromData = nil;
    validThruData =nil;
    phNoData = nil;
    amountData = nil;
    
    
    
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
    
    // [self.navigationController popViewControllerAnimated:YES];
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
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(150.0, 0.0, 45.0, 45.0);
    
    [logoView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *sinleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeButonClicked)];
    [logoView addGestureRecognizer:sinleTap];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(200.0, -13.0, 300.0, 70.0)];
    titleLbl.text = @"Edit Loyalty Card";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(20.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(55.0, -12.0, 200.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    }
    
    self.navigationItem.titleView = titleView;
    
    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    float  version1 =  [UIDevice currentDevice].systemVersion.floatValue;
    
    
    count = 16;
    
    // BackGround color on top of the view ..
    //UILabel *topbar = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 31)] autorelease];
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plain-background-home-send-ecard-leatherholes-color-border-font-2210890" ofType:@"jpg"];
    //UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images2.jpg"]];
    //    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    //
    //    // label header on top of the view...
    //    UILabel *label = [[UILabel alloc] init] ;
    //    label.text = @"Show Loyalty";
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
    
    // IssueLowaltyView Design....
    //    showLoyaltyView = [[UIView  alloc] init];
    //    showLoyaltyView.backgroundColor = [UIColor colorWithRed:188.0/255.0 green:233.0/255.0 blue:84.0/255.0 alpha:1.0];
    //    showLoyaltyView.layer.borderColor = [UIColor colorWithRed:5.0/255.0 green:77.0/255.0 blue:119.0/255.0 alpha:1.0].CGColor;
    //    showLoyaltyView.layer.borderWidth = 3.0f;
    //    showLoyaltyView.layer.cornerRadius = 15.0f;
    
    //    //Backgroud layer creation...
    //    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"showlayaltybackground" ofType:@"jpg"];
    //    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath1]];
    //    img1.layer.cornerRadius = 15.0f;
    //    img1.layer.masksToBounds = YES;
    //
    //    // layer header view....
    //    UIView *view = [[UIView  alloc] init];
    //    view.backgroundColor = [UIColor colorWithRed:107.0/255.0 green:105.0/255.0 blue:104.0/255.0 alpha:1.0];
    //    view.layer.cornerRadius = 15.0f;
    //    view.layer.masksToBounds = YES;
    //
    //    // layer header image setting...
    //    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"showlpyabackgd" ofType:@"png"];
    //    UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath2]];
    //    img2.layer.masksToBounds = YES;
    //    img2.layer.cornerRadius = 15.0f;
    
    // Scanner Button for barcode scannig ..
    
    self.view.backgroundColor =  [UIColor blackColor];
    
    //    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    //    backImage.image = [UIImage imageNamed:@"omni_home_bg.png"];
    //    [self.view addSubview:backImage];
    
    barcodeBtn  = [[UIButton alloc] init] ;
    [barcodeBtn setImage:[UIImage imageNamed:@"scan_icon.png"] forState:UIControlStateNormal];
    [barcodeBtn addTarget:self action:@selector(barcodeScanner:) forControlEvents:UIControlEventTouchUpInside];
    barcodeBtn.tag = 1;
    barcodeBtn.enabled = YES;
    
    loyaltyNumtxt = [[UITextField alloc] init];
    loyaltyNumtxt.borderStyle = UITextBorderStyleRoundedRect;
    loyaltyNumtxt.textColor = [UIColor colorWithRed:78.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0];
    loyaltyNumtxt.placeholder = @"Please Enter Loyalty No";  //place holder
    loyaltyNumtxt.backgroundColor = [UIColor whiteColor];
    loyaltyNumtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    loyaltyNumtxt.backgroundColor = [UIColor whiteColor];
    loyaltyNumtxt.keyboardType = UIKeyboardTypeDefault;
    loyaltyNumtxt.returnKeyType = UIReturnKeyDone;
    loyaltyNumtxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    loyaltyNumtxt.delegate = self;
    
    label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Arial-Italic" size:16];
    label.textColor = [UIColor redColor];
    label.text = @" Please Enter Loyalty Number";
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont fontWithName:@"Arial-Italic" size:16];
    label1.textColor = [UIColor colorWithRed:0.0/255.0 green:158.0/255.0 blue:187.0/255.0 alpha:1.0];
    label1.text = @"Scan";
    
    
    submitBtn = [[UIButton alloc] init];
    [submitBtn addTarget:self
                  action:@selector(editLoyalty:) forControlEvents:UIControlEventTouchDown];
    [submitBtn setTitle:@"Update" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 3.0f;
    submitBtn.backgroundColor = [UIColor grayColor];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    username = [[UILabel alloc] init];
    username.font = [UIFont boldSystemFontOfSize:16];
    username.textColor = [UIColor whiteColor];
    username.textAlignment = NSTextAlignmentLeft;
    username.backgroundColor = [UIColor clearColor];
    
    phNo = [[UILabel alloc] init];
    phNo.font = [UIFont boldSystemFontOfSize:16];
    phNo.textColor = [UIColor whiteColor];
    phNo.textAlignment = NSTextAlignmentLeft;
    phNo.backgroundColor = [UIColor clearColor];
    
    email = [[UILabel alloc] init];
    email.font = [UIFont boldSystemFontOfSize:16];
    email.textColor = [UIColor whiteColor];
    email.textAlignment = NSTextAlignmentLeft;
    email.backgroundColor = [UIColor clearColor];
    
    idType = [[UILabel alloc] init];
    idType.font = [UIFont boldSystemFontOfSize:16];
    idType.textColor = [UIColor whiteColor];
    idType.textAlignment = NSTextAlignmentLeft;
    idType.backgroundColor = [UIColor clearColor];
    
    idNoLbl = [[UILabel alloc] init];
    idNoLbl.font = [UIFont boldSystemFontOfSize:16];
    idNoLbl.textColor = [UIColor whiteColor];
    idNoLbl.textAlignment = NSTextAlignmentLeft;
    idNoLbl.backgroundColor = [UIColor clearColor];
    
    loyaltyPgm = [[UILabel alloc] init];
    loyaltyPgm.font = [UIFont boldSystemFontOfSize:16];
    loyaltyPgm.textColor = [UIColor whiteColor];
    loyaltyPgm.textAlignment = NSTextAlignmentLeft;
    loyaltyPgm.backgroundColor = [UIColor clearColor];
    
    
    idTypeTxt = [[CustomTextField alloc] init];
    idTypeTxt.borderStyle = UITextBorderStyleRoundedRect;
    idTypeTxt.textColor = [UIColor blackColor];
    idTypeTxt.font = [UIFont systemFontOfSize:17.0];
    idTypeTxt.placeholder = @"Select Loyalty Type";  //place holder
    idTypeTxt.backgroundColor = [UIColor whiteColor];
    idTypeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    idTypeTxt.backgroundColor = [UIColor whiteColor];
    idTypeTxt.keyboardType = UIKeyboardTypeDefault;
    idTypeTxt.returnKeyType = UIReturnKeyDone;
    idTypeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    idTypeTxt.userInteractionEnabled = NO;
    idTypeTxt.delegate = self;
    [idTypeTxt awakeFromNib];
    
    validFrom = [[UILabel alloc] init];
    validFrom.font = [UIFont boldSystemFontOfSize:16];
    validFrom.textColor = [UIColor whiteColor];
    validFrom.textAlignment = NSTextAlignmentLeft;
    validFrom.backgroundColor = [UIColor clearColor];
    
    validThru = [[UILabel alloc] init];
    validThru.font = [UIFont boldSystemFontOfSize:16];
    validThru.textColor = [UIColor whiteColor];
    validThru.textAlignment = NSTextAlignmentLeft;
    validThru.backgroundColor = [UIColor clearColor];
    
    availPoints = [[UILabel alloc] init];
    availPoints.font = [UIFont boldSystemFontOfSize:16];
    availPoints.textColor = [UIColor whiteColor];
    availPoints.textAlignment = NSTextAlignmentLeft;
    availPoints.backgroundColor = [UIColor clearColor];
    
    amount = [[UILabel alloc] init];
    amount.font = [UIFont boldSystemFontOfSize:16];
    amount.textColor = [UIColor whiteColor];
    amount.textAlignment = NSTextAlignmentLeft;
    amount.backgroundColor = [UIColor clearColor];
    
    usernameData = [[CustomTextField alloc] init];
    usernameData.textColor = [UIColor whiteColor];
    usernameData.textAlignment = NSTextAlignmentLeft;
    usernameData.backgroundColor = [UIColor clearColor];
    [usernameData awakeFromNib];
    
    phNoData = [[CustomTextField alloc] init];
    phNoData.textColor = [UIColor whiteColor];
    phNoData.textAlignment = NSTextAlignmentLeft;
    phNoData.backgroundColor = [UIColor clearColor];
    [phNoData awakeFromNib];
    
    emailData = [[CustomTextField alloc] init];
    //    emailData.numberOfLines = 2;
    //    emailData.lineBreakMode = NSLineBreakByWordWrapping;
    emailData.textAlignment = NSTextAlignmentLeft;
    emailData.backgroundColor = [UIColor clearColor];
    emailData.textColor = [UIColor whiteColor];
    [emailData awakeFromNib];
    
    
    idNo = [[CustomTextField alloc] init];
    idNo.textColor = [UIColor whiteColor];
    idNo.textAlignment = NSTextAlignmentLeft;
    idNo.backgroundColor = [UIColor clearColor];
    [idNo awakeFromNib];
    
    validFromData = [[CustomTextField alloc] init];
    validFromData.textColor = [UIColor whiteColor];
    validFromData.textAlignment = NSTextAlignmentLeft;
    validFromData.backgroundColor = [UIColor clearColor];
    [validFromData awakeFromNib];
    [validFromData setUserInteractionEnabled:NO];
    
    
    validThruData = [[CustomTextField alloc] init];
    validThruData.textColor = [UIColor whiteColor];
    validThruData.textAlignment = NSTextAlignmentLeft;
    validThruData.backgroundColor = [UIColor clearColor];
    [validThruData awakeFromNib];
    [validThruData setUserInteractionEnabled:NO];
    
    pointsData = [[CustomTextField alloc] init];
    pointsData.textColor = [UIColor whiteColor];
    pointsData.textAlignment = NSTextAlignmentLeft;
    pointsData.backgroundColor = [UIColor clearColor];
    [pointsData awakeFromNib];
    [pointsData setUserInteractionEnabled:NO];
    
    amountData = [[CustomTextField alloc] init];
    amountData.textColor = [UIColor whiteColor];
    amountData.textAlignment = NSTextAlignmentLeft;
    amountData.backgroundColor = [UIColor clearColor];
    [amountData awakeFromNib];
    [amountData setUserInteractionEnabled:NO];
    
    lisbtn = [[UIButton alloc] init] ;
    UIImage *buttonImageDD1 = [UIImage imageNamed:@"combo.png"];
    [lisbtn setBackgroundImage:buttonImageDD1 forState:UIControlStateNormal];
    [lisbtn addTarget:self
               action:@selector(idTypeSelectionPressed:) forControlEvents:UIControlEventTouchDown];
    lisbtn.backgroundColor = [UIColor clearColor];
    lisbtn.tag = 0;
    
    UIImageView *id_No=[[UIImageView alloc] init]; // Set frame as per space required around icon
    id_No.image = [UIImage imageNamed:@"Id_type.png"];
    UIButton *loyaltyTypelist = [[UIButton alloc] init] ;
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [loyaltyTypelist setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [loyaltyTypelist addTarget:self
                        action:@selector(lyaltyTypeSelectionPressed:) forControlEvents:UIControlEventTouchDown];
    loyaltyTypelist.backgroundColor = [UIColor clearColor];
    
    idslist = [[NSMutableArray alloc] init];
    [idslist addObject:@"PAN Card"];
    [idslist addObject:@"Voter Card"];
    [idslist addObject:@"DrivingLicence"];
    
    // NSMutableArray initialization.....
    loyalTypeList = [[NSMutableArray alloc] init];
    [loyalTypeList addObject:@"Platinum"];
    [loyalTypeList addObject:@"Diamond"];
    [loyalTypeList addObject:@"Gold"];
    [loyalTypeList addObject:@"Silver"];
    [loyalTypeList addObject:@"Bronze"];
    
    //selection Country for IdlistTableView creation...
    idlistTableView = [[UITableView alloc] init];
    idlistTableView.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
    idlistTableView.layer.borderColor = [UIColor blackColor].CGColor;
    idlistTableView.layer.cornerRadius = 4.0f;
    idlistTableView.layer.borderWidth = 1.0f;
    idlistTableView.dataSource = self;
    idlistTableView.delegate = self;
    idlistTableView.bounces = FALSE;
    idlistTableView.hidden = YES;
    
    
    
    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet;
    
    //    //selected lowaltytype table creation....
    loyaltyTypeTable = [[UITableView alloc] init];
    loyaltyTypeTable.backgroundColor = [UIColor colorWithRed:139.0/255.0 green:179.0/255.0 blue:129.0/255.0 alpha:1.0];
    loyaltyTypeTable.layer.borderColor = [UIColor blackColor].CGColor;
    loyaltyTypeTable.layer.cornerRadius = 4.0f;
    loyaltyTypeTable.layer.borderWidth = 1.0f;
    loyaltyTypeTable.dataSource = self;
    loyaltyTypeTable.delegate = self;
    loyaltyTypeTable.bounces = FALSE;
    
    
    [amountData setHidden:YES];
    [usernameData setHidden:YES];
    [phNoData setHidden:YES];
    [emailData setHidden:YES];
    [idNo setHidden:YES];
    [validFromData setHidden:YES];
    [validThruData setHidden:YES];
    [pointsData setHidden:YES];
    [idTypeTxt setHidden:YES];
    [lisbtn setHidden:YES];
    
    
    [submitBtn setHidden:YES];
    
    
    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.frame = CGRectMake(5, 5, 220, 40);
        //        label.font = [UIFont boldSystemFontOfSize:25];
        //        backbutton.frame = CGRectMake(690.0, 5.0, 40.0, 40.0);
        showLoyaltyView.frame = CGRectMake(20, 60, 738, 900);
        // img1.frame = CGRectMake(0, 0, 738, 900);
        //view.frame = CGRectMake(0, 0, 738, 200);
        // img2.frame = CGRectMake(20, 30, 90, 70);
        
        loyaltyNumtxt.frame = CGRectMake(130, 130, 360, 50);
        loyaltyNumtxt.font = [UIFont systemFontOfSize:30.0];
        submitBtn.frame = CGRectMake(510.0f, 130,45.0f, 45.0f);
        barcodeBtn.frame = CGRectMake(520, 120, 80, 80);
        label.frame = CGRectMake(180, 180, 250, 50);
        
        label1.frame = CGRectMake(530, 70, 80, 80);
        label1.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0];
        [self.view addSubview:label1];
        
        username.font = [UIFont boldSystemFontOfSize:30];
        username.frame = CGRectMake(80, 220, 250, 50);
        phNo.font = [UIFont boldSystemFontOfSize:30];
        phNo.frame = CGRectMake(80, 290, 250, 50);
        email.font = [UIFont boldSystemFontOfSize:30];
        email.frame = CGRectMake(80, 360, 250, 50);
        idType.font = [UIFont boldSystemFontOfSize:30];
        idType.frame = CGRectMake(80, 440, 250, 50);
        
        idTypeTxt.font = [UIFont systemFontOfSize:30];
        idTypeTxt.frame = CGRectMake(380, 440, 250, 50);
        lisbtn.frame = CGRectMake(630, 430, 50, 70);
        idlistTableView.frame = CGRectMake(380, 490,480, 200);
        
        idNoLbl.font = [UIFont systemFontOfSize:30];
        idNoLbl.frame = CGRectMake(80, 510,300,50);
        
        idNo.font = [UIFont boldSystemFontOfSize:30];
        idNo.frame = CGRectMake(380, 510,300,50);
        
        validFrom.font = [UIFont boldSystemFontOfSize:30];
        validFrom.frame = CGRectMake(80, 580, 250, 50);
        validThru.font = [UIFont boldSystemFontOfSize:30];
        validThru.frame = CGRectMake(80, 650, 250, 50);
        availPoints.font = [UIFont boldSystemFontOfSize:30];
        availPoints.frame = CGRectMake(80, 720, 250, 50);
        amount.font = [UIFont boldSystemFontOfSize:30];
        amount.frame = CGRectMake(80, 790, 250, 50);
        
        usernameData.font = [UIFont systemFontOfSize:30];
        usernameData.frame = CGRectMake(380, 220, 300, 50);
        phNoData.font = [UIFont systemFontOfSize:30];
        phNoData.frame = CGRectMake(380, 290, 300, 50);
        emailData.font = [UIFont systemFontOfSize:30];
        emailData.frame = CGRectMake(380, 360, 500, 50);
        validFromData.font = [UIFont systemFontOfSize:30];
        validFromData.frame = CGRectMake(380, 580, 300, 50);
        validThruData.font = [UIFont systemFontOfSize:30];
        validThruData.frame = CGRectMake(380, 650, 300, 50);
        pointsData.font = [UIFont systemFontOfSize:30];
        pointsData.frame = CGRectMake(380, 720, 300, 50);
        amountData.font = [UIFont systemFontOfSize:30];
        amountData.frame = CGRectMake(380, 790, 300, 50);
        submitBtn.frame = CGRectMake(210.0f, 900,350.0f, 50.0f);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
        
        
        
    }
    else {
        
        if (version1 >= 8.0) {
            showLoyaltyView.frame = CGRectMake(8, 39, 305, 400);
            // img1.frame = CGRectMake(0, 0, 305, 400);
            // view.frame = CGRectMake(0, 0, 305, 68);
            // img2.frame = CGRectMake(10, 5, 60, 55);
            
            loyaltyNumtxt.frame = CGRectMake(20, 80, 200, 30);
            loyaltyNumtxt.font = [UIFont systemFontOfSize:17.0];
            barcodeBtn.frame = CGRectMake(268, 80, 40, 40);
            label.frame = CGRectMake(20, 120, 250, 30);
            label.backgroundColor = [UIColor clearColor];
            
            username.frame = CGRectMake(20, 140, 130, 30);
            phNo.frame = CGRectMake(20, 175, 130, 30);
            email.frame = CGRectMake(20, 210, 130, 30);
            idType.frame = CGRectMake(20, 245, 130, 30);
            validFrom.frame = CGRectMake(20, 280, 130, 30);
            validThru.frame = CGRectMake(20, 315, 130, 30);
            availPoints.frame = CGRectMake(20, 350, 130, 30);
            amount.frame = CGRectMake(20, 385, 130, 30);
            
            usernameData.frame = CGRectMake(140, 140, 150, 30);
            phNoData.frame = CGRectMake(140, 175, 150, 30);
            emailData.frame = CGRectMake(140, 210, 150, 30);
            idNo.frame = CGRectMake(140, 245, 150, 30);
            validFromData.frame = CGRectMake(140, 280, 150, 30);
            validThruData.frame = CGRectMake(140, 315, 150, 30);
            pointsData.frame = CGRectMake(140, 350, 150, 30);
            amountData.frame = CGRectMake(140, 385, 150, 30);
            
            
            usernameData.font = [UIFont systemFontOfSize:16];
            phNoData.font = [UIFont systemFontOfSize:16];
            emailData.font = [UIFont systemFontOfSize:16];
            idNo.font = [UIFont systemFontOfSize:16];
            validFromData.font = [UIFont systemFontOfSize:16];
            validThruData.font = [UIFont systemFontOfSize:16];
            pointsData.font = [UIFont systemFontOfSize:16];
            amountData.font = [UIFont systemFontOfSize:16];
            
            submitBtn.frame = CGRectMake(80,470,150.0f, 30.0f);

            
        }
        else{
            showLoyaltyView.frame = CGRectMake(8, 39, 305, 400);
            // img1.frame = CGRectMake(0, 0, 305, 400);
            // view.frame = CGRectMake(0, 0, 305, 68);
            // img2.frame = CGRectMake(10, 5, 60, 55);
            
            loyaltyNumtxt.frame = CGRectMake(20, 10, 200, 30);
            loyaltyNumtxt.font = [UIFont systemFontOfSize:17.0];
            submitBtn.frame = CGRectMake(226.0f, 6.0f,36.0f, 36.0f);
            barcodeBtn.frame = CGRectMake(268, 4, 40, 40);
            label.frame = CGRectMake(20, 40, 250, 30);
            label.backgroundColor = [UIColor clearColor];
            
            username.frame = CGRectMake(20, 50, 130, 30);
            phNo.frame = CGRectMake(20, 85, 130, 30);
            email.frame = CGRectMake(20, 120, 130, 30);
            idType.frame = CGRectMake(20, 155, 130, 30);
            validFrom.frame = CGRectMake(20, 190, 130, 30);
            validThru.frame = CGRectMake(20, 225, 130, 30);
            availPoints.frame = CGRectMake(20, 260, 130, 30);
            amount.frame = CGRectMake(20, 295, 130, 30);
            
            usernameData.frame = CGRectMake(140, 50, 130, 30);
            phNoData.frame = CGRectMake(140, 85, 130, 30);
            emailData.frame = CGRectMake(140, 120, 200, 30);
            idNo.frame = CGRectMake(140, 155, 130, 30);
            validFromData.frame = CGRectMake(140, 190, 130, 30);
            validThruData.frame = CGRectMake(140, 225, 130, 30);
            pointsData.frame = CGRectMake(140, 260, 130, 30);
            amountData.frame = CGRectMake(140, 295, 130, 30);
            
            
            usernameData.font = [UIFont systemFontOfSize:16];
            phNoData.font = [UIFont systemFontOfSize:16];
            emailData.font = [UIFont systemFontOfSize:16];
            idNo.font = [UIFont systemFontOfSize:16];
            validFromData.font = [UIFont systemFontOfSize:16];
            validThruData.font = [UIFont systemFontOfSize:16];
            pointsData.font = [UIFont systemFontOfSize:16];
            amountData.font = [UIFont systemFontOfSize:16];
            
        }
    }
    
    //[topbar addSubview:img];
    //    [self.view addSubview:img];
    //    [self.view addSubview:label];
    //    [self.view addSubview:backbutton];
    //    [showLoyaltyView addSubview:img1];
    //    [showLoyaltyView addSubview:view];
    //    [showLoyaltyView addSubview:img2];
    [self.view addSubview:barcodeBtn];
    [self.view addSubview:loyaltyNumtxt];
    [self.view addSubview:label];
    [self.view addSubview:username];
    [self.view addSubview:phNo];
    [self.view addSubview:email];
    [self.view addSubview:idType];
    [self.view addSubview:validFrom];
    [self.view addSubview:validThru];
    [self.view addSubview:availPoints];
    [self.view addSubview:amount];
    [self.view addSubview:usernameData];
    [self.view addSubview:phNoData];
    [self.view addSubview:emailData];
    [self.view addSubview:idNo];
    [self.view addSubview:validFromData];
    [self.view addSubview:validThruData];
    [self.view addSubview:pointsData];
    [self.view addSubview:amountData];
    [self.view addSubview:showLoyaltyView];
    [self.view addSubview:submitBtn];
    [self.view addSubview:idNoLbl];
    [self.view addSubview:idTypeTxt];
    [self.view addSubview:lisbtn];
    [self.view addSubview:idlistTableView];
    
    
    
    
    
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
    
}

- (void) idTypeSelectionPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (lisbtn.tag == 0) {
        
        [idType resignFirstResponder];
        [emailData resignFirstResponder];
        [usernameData resignFirstResponder];
        [phNoData resignFirstResponder];
        [idNo resignFirstResponder];
        [idlistTableView reloadData];
        idlistTableView.hidden = NO;
        lisbtn.tag = 1;
    }
    else {
        idlistTableView.hidden = YES;
        lisbtn.tag = 0;
        
    }
}

// previousButtonPressed handing...
- (void) lyaltyTypeSelectionPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [loyaltyTypeTable reloadData];
    loyaltyTypeTable.hidden = NO;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    
    if ([textField.text isEqualToString:loyaltyNumtxt.text]) {
        
        if ([characters isEqualToString:@""]) {
            label.text = [NSString  stringWithFormat:@" %d characters left", ++count];
        }
        else {
            
            label.text = [NSString  stringWithFormat:@" %d characters left", --count];
            
        }
        if (count == 0 ) {
            
            label.hidden = YES;
        }
        else{
            
            label.hidden = NO;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
    }
    else{
        
        return YES;
    }
}



-(void)textChange:(NSNotification *)notification {
    
    UITextField *textfield = notification.object;
    
    
    if (textfield == loyaltyNumtxt) {
        
        if (loyaltyNumtxt.text.length == 16) {
            [loyaltyNumtxt resignFirstResponder];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
            
            //changed by Srinivasulu on 19/09/2017....
            //reason in ARC -- NSInterger can not typeCasted to UIButton....
            
//            [self submitButtonPressed:(UIButton *)submitBtn.tag];
            [self submitButtonPressed:submitBtn];
            
            //upto here on 19/09/2017....
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
//    NSString *value = [loyaltyNumtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    if (value.length == 0){
//
//        username.text = @"";
//        phNo.text = @"";
//        email.text = @"";
//        validFrom.text = @"";
//        validThru.text = @"";
//        availPoints.text = @"";
//        amount.text = @"";
//
//        usernameData.text = @"";
//        phNoData.text = @"";
//        emailData.text = @"";
//        idType.text = @"";
//        idNo.text = @"";
//        validFromData.text = @"";
//        validThruData.text = @"";
//        pointsData.text = @"";
//        amountData.text = @"";
//
//        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [validalert show];
//    }
//
//    else {
//
//        // Create the service
//        //        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
//        //        service.logging = YES;
//        //
//        //        // showing HUD ..
//        //        [HUD setHidden:NO];
//        //
//        //        // Returns NSString*.
//        //        [service getissuedLoyaltycard:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber: loyaltyNumtxt.text];
//
//        [HUD setHidden:NO];
//
//        LoyaltycardServiceSoapBinding *skuService = [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding];
//
//        LoyaltycardServiceSvc_getissuedLoyaltycard *getSkuid = [[LoyaltycardServiceSvc_getissuedLoyaltycard alloc] init];
//
//
//        NSArray *loyaltyKeys = @[@"loyaltyCardNumber", @"requestHeader"];
//
//        NSArray *loyaltyObjects = @[loyaltyNumtxt.text,[RequestHeader getRequestHeader]];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        getSkuid.loyaltyCardNumber = loyaltyString;
//        @try {
//
//            LoyaltycardServiceSoapBindingResponse *response = [skuService getissuedLoyaltycardUsingParameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)getSkuid];
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_getissuedLoyaltycardResponse class]]) {
//                    LoyaltycardServiceSvc_getissuedLoyaltycardResponse *body = (LoyaltycardServiceSvc_getissuedLoyaltycardResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    if (body.return_ != nil) {
//                        [self getissuedLoyaltycardHandler:body.return_];
//                    }
//                    else {
//                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Invalid loyalty number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                        [alert show];
//                    }
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Invalid loyalty number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//
//    }
//
//}


//submitButtonPressed method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

// previousButtonPressed handing...
- (void) submitButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    NSString *value = [loyaltyNumtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (value.length == 0){
        
        username.text = @"";
        phNo.text = @"";
        email.text = @"";
        validFrom.text = @"";
        validThru.text = @"";
        availPoints.text = @"";
        amount.text = @"";
        
        usernameData.text = @"";
        phNoData.text = @"";
        emailData.text = @"";
        idType.text = @"";
        idNo.text = @"";
        validFromData.text = @"";
        validThruData.text = @"";
        pointsData.text = @"";
        amountData.text = @"";
        
        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [validalert show];
    }
    
    else {
        
        [HUD setHidden:NO];

        NSArray *loyaltyKeys = @[@"loyaltyCardNumber", @"requestHeader"];
        NSArray *loyaltyObjects = @[loyaltyNumtxt.text,[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * services  =  [[WebServiceController alloc] init];
        services.loyaltycardServicesDelegate = self;
        [services getLoyaltycardDetails:loyaltyString];
        
    }
}

// added by Roja on 17/10/2019….
- (void)getLoyaltycardDetailsSuccessReponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        [self getissuedLoyaltycardHandler:sucessDictionary];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}

// added by Roja on 17/10/2019….
- (void)getLoyaltycardDetailsErrorResponse:(NSString *)error{
    
    @try {
        
        username.text = @"";
        phNo.text = @"";
        email.text = @"";
        validFrom.text = @"";
        validThru.text = @"";
        availPoints.text = @"";
        amount.text = @"";
        
        usernameData.text = @"";
        phNoData.text = @"";
        emailData.text = @"";
        idType.text = @"";
        idNo.text = @"";
        validFromData.text = @"";
        validThruData.text = @"";
        pointsData.text = @"";
        amountData.text = @"";
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Invalid loyalty number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}





// Commented by roja on 17/10/2019... // REASON: below method definition is used for sumbitButton(SOAP service call)
//- (void) getissuedLoyaltycardHandler: (NSString *) value {
//
//    [HUD setHidden:YES];
//
//    label.text = @"";
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
//    //
//    //        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    //        [validalert show];
//    //        [validalert release];
//    //        return;
//    //    }
//
//    // hiding the HUD ..
//    [HUD setHidden:YES];
//
//    // Do something with the NSString* result
//    NSString* result = (NSString*)value;
//    //NSLog(@"getissuedLoyaltycard returned the value: %@", result);
//    NSError *e;
//    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &e];
//    [self.view resignFirstResponder];
//    if (![[NSString stringWithFormat:@"%@",JSON[@"loyaltyCardNumber"]] isEqualToString:@"<null>"]) {
//
//        // NSArray *temp = [result componentsSeparatedByString:@"#"];
//
//        //loyaltyNumtxt.text = nil;
//
//        username.text = @"User Name";
//        phNo.text = @"Phone Number";
//        email.text = @"Email";
//        validFrom.text = @"Valid From";
//        validThru.text = @"Valid To";
//        availPoints.text = @"Avail Points";
//        amount.text = @"Amount";
//        idType.text = @"ID Type";
//        idNoLbl.text = @"ID No";
//
//        //idType.text = @"Id Card";
//
//        [amountData setHidden:NO];
//        [usernameData setHidden:NO];
//        [phNoData setHidden:NO];
//        [emailData setHidden:NO];
//        [idNo setHidden:NO];
//        [validFromData setHidden:NO];
//        [validThruData setHidden:NO];
//        [pointsData setHidden:NO];
//        [submitBtn setHidden:NO];
//        [lisbtn setHidden:NO];
//        [idTypeTxt setHidden:NO];
//
//
//
//
//        SystemSoundID    soundFileObject1;
//        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
//    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//        AudioServicesPlaySystemSound (soundFileObject1);
//
//        usernameData.text = [NSString stringWithFormat:@"%@",JSON[@"customerName"]];
//        phNoData.text = [NSString stringWithFormat:@"%@",JSON[@"phoneNum"]];
//        emailData.text = [NSString stringWithFormat:@"%@",JSON[@"email"]];
//        loyaltyNumtxt.text = [NSString stringWithFormat:@"%@",JSON[@"loyaltyCardNumber"]];
//        NSString *id_card = [NSString stringWithFormat:@"%@",JSON[@"idCardType"]];
//        loyaltyPgm.text = [NSString stringWithFormat:@"%@",JSON[@"loyaltyProgramNumber"]];
//        if (![id_card isEqualToString:@"<null>"]) {
//
//            idTypeTxt.text = [NSString stringWithFormat:@"%@",JSON[@"idCardType"]];
//            idNo.text = [NSString stringWithFormat:@"%@",JSON[@"idCardNumber"]];
//        }
//        else {
//            idTypeTxt.text = @"-";
//            idNo.text = @"-";
//        }
//
//
//        //        if ([[temp objectAtIndex:7] isEqualToString:@"null"]) {
//        //            validFromData.text = @"-";
//        //        }
//        //        else{
//        validFromData.text = [NSString stringWithFormat:@"%@",[JSON[@"validFrom"] componentsSeparatedByString:@" "][0]];
//        //        }
//        //         if ([[temp objectAtIndex:6] isEqualToString:@"null"]) {
//        //
//        //             validThruData.text = @"-";
//        //        }
//        //        else{
//        validThruData.text = [NSString stringWithFormat:@"%@",[JSON[@"validTo"] componentsSeparatedByString:@" "][0]];
//        //        }
//        if ([[NSString stringWithFormat:@"%@",JSON[@"pointsRemaining"]] isEqualToString:@"<null>"]) {
//
//            pointsData.text = @"0.0";
//
//        }
//        else {
//            pointsData.text = [NSString stringWithFormat:@"%@",JSON[@"pointsRemaining"]];
//
//        }
//        if ([[NSString stringWithFormat:@"%@",JSON[@"cash"]] isEqualToString:@"<null>"]) {
//
//            amountData.text = @"0.00";
//
//        }
//        else {
//            amountData.text = [NSString stringWithFormat:@"%@",JSON[@"cash"]];
//
//        }
//
//
//    }
//    else{
//
//        username.text = @"";
//        phNo.text = @"";
//        email.text = @"";
//        validFrom.text = @"";
//        validThru.text = @"";
//        availPoints.text = @"";
//        amount.text = @"";
//
//        usernameData.text = @"";
//        phNoData.text = @"";
//        emailData.text = @"";
//        idType.text = @"";
//        idNo.text = @"";
//        validFromData.text = @"";
//        validThruData.text = @"";
//        pointsData.text = @"";
//        amountData.text = @"";
//
//        SystemSoundID    soundFileObject1;
//        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
//    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//        AudioServicesPlaySystemSound (soundFileObject1);
//
//        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [validalert show];
//    }
//
//}



//getissuedLoyaltycardHandler method changed by roja on 17/10/2019.. // reason : AFter converting SOAP to REST service call (in submitButton:), THE
// At the time of converting SOAP call's to REST
- (void) getissuedLoyaltycardHandler: (NSDictionary *) successResponse {
    
    [HUD setHidden:YES];
    label.text = @"";
    [self.view resignFirstResponder];
    
    if(successResponse != nil){
        
        username.text = @"User Name";
        phNo.text = @"Phone Number";
        email.text = @"Email";
        validFrom.text = @"Valid From";
        validThru.text = @"Valid To";
        availPoints.text = @"Avail Points";
        amount.text = @"Amount";
        idType.text = @"ID Type";
        idNoLbl.text = @"ID No";
        
        [amountData setHidden:NO];
        [usernameData setHidden:NO];
        [phNoData setHidden:NO];
        [emailData setHidden:NO];
        [idNo setHidden:NO];
        [validFromData setHidden:NO];
        [validThruData setHidden:NO];
        [pointsData setHidden:NO];
        [submitBtn setHidden:NO];
        [lisbtn setHidden:NO];
        [idTypeTxt setHidden:NO];
        
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        usernameData.text = [NSString stringWithFormat:@"%@",successResponse[@"customerName"]];
        phNoData.text = [NSString stringWithFormat:@"%@",successResponse[@"phoneNum"]];
        emailData.text = [NSString stringWithFormat:@"%@",successResponse[@"email"]];
        loyaltyNumtxt.text = [NSString stringWithFormat:@"%@",successResponse[@"loyaltyCardNumber"]];
        NSString *id_card = [NSString stringWithFormat:@"%@",successResponse[@"idCardType"]];
        loyaltyPgm.text = [NSString stringWithFormat:@"%@",successResponse[@"loyaltyProgramNumber"]];
        if (![id_card isEqualToString:@"<null>"]) {
            
            idTypeTxt.text = [NSString stringWithFormat:@"%@",successResponse[@"idCardType"]];
            idNo.text = [NSString stringWithFormat:@"%@",successResponse[@"idCardNumber"]];
        }
        else {
            idTypeTxt.text = @"-";
            idNo.text = @"-";
        }
        
        
        //        if ([[temp objectAtIndex:7] isEqualToString:@"null"]) {
        //            validFromData.text = @"-";
        //        }
        //        else{
        validFromData.text = [NSString stringWithFormat:@"%@",[successResponse[@"validFrom"] componentsSeparatedByString:@" "][0]];
        //        }
        //         if ([[temp objectAtIndex:6] isEqualToString:@"null"]) {
        //
        //             validThruData.text = @"-";
        //        }
        //        else{
        validThruData.text = [NSString stringWithFormat:@"%@",[successResponse[@"validTo"] componentsSeparatedByString:@" "][0]];
        //        }
        if ([[NSString stringWithFormat:@"%@",successResponse[@"pointsRemaining"]] isEqualToString:@"<null>"]) {
            
            pointsData.text = @"0.0";
            
        }
        else {
            pointsData.text = [NSString stringWithFormat:@"%@",successResponse[@"pointsRemaining"]];
            
        }
        if ([[NSString stringWithFormat:@"%@",successResponse[@"cash"]] isEqualToString:@"<null>"]) {
            
            amountData.text = @"0.00";
        }
        else {
            amountData.text = [NSString stringWithFormat:@"%@",successResponse[@"cash"]];
        }
        
        
    }
    else{
        
        username.text = @"";
        phNo.text = @"";
        email.text = @"";
        validFrom.text = @"";
        validThru.text = @"";
        availPoints.text = @"";
        amount.text = @"";
        
        usernameData.text = @"";
        phNoData.text = @"";
        emailData.text = @"";
        idType.text = @"";
        idNo.text = @"";
        validFromData.text = @"";
        validThruData.text = @"";
        pointsData.text = @"";
        amountData.text = @"";
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [validalert show];
    }
    
}



// BarcodeScanner handler....
- (void) barcodeScanner:(id) sender {
    
    [loyaltyNumtxt resignFirstResponder];
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //    // ADD: present a barcode reader that scans from the camera feed
    //    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    //    reader.readerDelegate = self;
    //    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    //
    //    ZBarImageScanner *scanner = reader.scanner;
    //    reader.showsZBarControls = NO;
    //
    //    [scanner setSymbology: ZBAR_I25
    //                   config: ZBAR_CFG_ENABLE
    //                       to: 0];
    //    // present and release the controller
    //    [self presentModalViewController: reader
    //                            animated: YES];
    //    reader.cameraOverlayView = [self CommomOverlay];
    //    [reader release];
    
    
    //    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:YES];
    //
    //    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    //
    //#if ZXQR
    //    //QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    //    //[readers addObject:qrcodeReader];
    //    //[qrcodeReader release];
    //    MultiFormatOneDReader *reader = [[MultiFormatOneDReader alloc] init];
    //    [readers addObject:reader];
    //    [reader release];
    //#endif
    //
    //    widController.readers = readers;
    //    [readers release];
    //
    //    NSBundle *mainBundle = [NSBundle mainBundle];
    //    widController.soundToPlay =
    //    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    //    [self presentModalViewController:widController animated:YES];   // deprecated in ios 6.0
    //    //[self presentViewController:widController animated:YES completion:nil];
    //    [widController release];
    
    //    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self theFrame:[UIScreen mainScreen].bounds showCancel:YES OneDMode:YES];
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
    //    [self presentModalViewController:widController animated:YES];
//    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:YES];
//    NSMutableSet *readers = [[NSMutableSet alloc ] init];
//    
//    MultiFormatOneDReader *reader;
//#if ZXQR
//    //QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
//    //[readers addObject:qrcodeReader];
//    //[qrcodeReader release];
//    reader = [[[MultiFormatOneDReader alloc] init] autorelease];
//    [readers addObject:reader];
//    //[reader release];
//#endif
//    
//    widController.readers = readers;
//    // [readers release];
//    
//    //    NSBundle *mainBundle = [NSBundle mainBundle];
//    //    widController.soundToPlay =
//    //    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
//    //[self presentModalViewController:widController animated:YES];   // deprecated in ios 6.0
//    //    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:widController];
//    //    nc.navigationBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
//    [self presentViewController:widController animated:YES completion:nil];
}


#pragma mark -
#pragma mark ScanDelegateMethods
//
//- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    if ([result length] > 0) {
//        
//        loyaltyNumtxt.text = result;
//        
//        username.text = @"";
//        phNo.text = @"";
//        email.text = @"";
//        validFrom.text = @"";
//        validThru.text = @"";
//        availPoints.text = @"";
//        amount.text = @"";
//        
//        usernameData.text = @"";
//        phNoData.text = @"";
//        emailData.text = @"";
//        idType.text = @"";
//        idNo.text = @"";
//        validFromData.text = @"";
//        validThruData.text = @"";
//        pointsData.text = @"";
//        amountData.text = @"";
//        
//        HUD.labelText = @"Searching..";
//        [HUD setHidden:NO];
//        
//        //        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
//        //        service.logging = YES;
//        //        // Returns NSString*.
//        //        [service getissuedLoyaltycard:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber:result];
//        LoyaltycardServiceSoapBinding *skuService = [[LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] retain];
//        
//        LoyaltycardServiceSvc_getissuedLoyaltycard *getSkuid = [[LoyaltycardServiceSvc_getissuedLoyaltycard alloc] init];
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
//        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"loyaltyCardNumber", @"requestHeader", nil];
//        
//        NSArray *loyaltyObjects = [NSArray arrayWithObjects:loyaltyNumtxt.text,dictionary, nil];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//        
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//        
//        getSkuid.loyaltyCardNumber = loyaltyString;
//        LoyaltycardServiceSoapBindingResponse *response = [skuService getissuedLoyaltycardUsingParameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)getSkuid];
//        NSArray *responseBodyParts = response.bodyParts;
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_getissuedLoyaltycardResponse class]]) {
//                LoyaltycardServiceSvc_getissuedLoyaltycardResponse *body = (LoyaltycardServiceSvc_getissuedLoyaltycardResponse *)bodyPart;
//                printf("\nresponse=%s",[body.return_ UTF8String]);
//                [self getissuedLoyaltycardHandler:body.return_];
//            }
//        }
//        
//    }
//    
//}
//
//- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}

//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    // ADD: get the decode results
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//
//    // EXAMPLE: do something useful with the barcode data
//    //resultText.text = symbol.data;
//
//    // EXAMPLE: do something useful with the barcode image
//    //resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
//
//    // ADD: dismiss the controller (NB dismiss from the *reader*!)
//    [reader dismissViewControllerAnimated:YES completion:nil];
//
//    if ([symbol.data length] > 0) {
//
//        loyaltyNumtxt.text = symbol.data;
//
//        username.text = @"";
//        phNo.text = @"";
//        email.text = @"";
//        validFrom.text = @"";
//        validThru.text = @"";
//        availPoints.text = @"";
//        amount.text = @"";
//
//        usernameData.text = @"";
//        phNoData.text = @"";
//        emailData.text = @"";
//        idType.text = @"";
//        idNo.text = @"";
//        validFromData.text = @"";
//        validThruData.text = @"";
//        pointsData.text = @"";
//        amountData.text = @"";
//
//        HUD.labelText = @"Searching";
//        [HUD setHidden:NO];
//
//        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
//        service.logging = YES;
//        // Returns NSString*.
////        [service getLoyalcardDetails:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber: symbol.data];
//        [service getissuedLoyaltycard:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber:symbol.data];
//
//    }
//
//}

-(UIView*)CommomOverlay{
    UIView* view = [[UIView alloc] init];
    UIImageView *FrameImg = [[UIImageView alloc] init];
    FrameImg.image = [UIImage imageNamed:@"technolabslogo.png"];
    
    UIButton *cancelButton  = [[UIButton alloc] init];
    [cancelButton setImage:[UIImage imageNamed:@"closebutton.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(closeBarcodeView) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *technolabsLabel = [[UIImageView alloc] init];
    technolabsLabel.image = [UIImage imageNamed:@"technolabslogo1.png"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        view.frame = CGRectMake(0,0,760.0,1024);
        FrameImg.frame = CGRectMake(670.0,20.0,60.0,190.0);
        cancelButton.frame = CGRectMake(670.0, 900.0, 50.0, 50.0);
        technolabsLabel.frame = CGRectMake(-90.0, 20.0, 300.0, 300.0);
    }
    else{
        view.frame = CGRectMake(0,0,320,480);
        FrameImg.frame = CGRectMake(260.0,10.0,50.0,130.0);
        cancelButton.frame = CGRectMake(270.0, 415.0, 40.0, 40.0);
        technolabsLabel.frame = CGRectMake(-60.0, 10.0, 180.0, 200.0);
    }
    [view addSubview:FrameImg];
    [view addSubview:technolabsLabel];
    [view addSubview:cancelButton];
    return view;
}

-(void)closeBarcodeView{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// KeyBoard hidden handler...
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [loyaltyNumtxt resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}

//viewDid load handler...
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


// Commented by roja on 17/10/2019.. // reason : editLoyalty method contains SOAP Service call .. so taken new method with same name(editLoyalty) method name which contains REST service call....
// At the time of converting SOAP call's to REST
//-(void)editLoyalty:(UIButton *)sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//    NSString *value = [loyaltyNumtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//
//    LoyaltycardServiceSoapBinding *skuService = [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding];
//    LoyaltycardServiceSvc_updateIssuedLoyaltyCards *aParameters = [[LoyaltycardServiceSvc_updateIssuedLoyaltyCards alloc] init];
//
//
//    NSArray *loyaltyKeys = @[@"idCardNumber", @"customerName",@"idCardType",@"loyaltyProgramNumber",@"phoneNum",@"email",@"requestHeader",@"loyaltyCardNumber"];
//
//    NSArray *loyaltyObjects = @[idNo.text,usernameData.text,idTypeTxt.text,loyaltyPgm.text,phNoData.text,emailData.text,[RequestHeader getRequestHeader],value];
//    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//    NSError * err_;
//    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//    aParameters.loyaltyCardDetails = normalStockString;
//    @try {
//        [HUD setHidden:NO];
//        LoyaltycardServiceSoapBindingResponse *response = [skuService updateIssuedLoyaltyCardsUsingParameters:aParameters];
//        NSArray *responseBodyParts = response.bodyParts;
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_updateIssuedLoyaltyCardsResponse class]]) {
//                LoyaltycardServiceSvc_updateIssuedLoyaltyCardsResponse *body = (LoyaltycardServiceSvc_updateIssuedLoyaltyCardsResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//                if (body.return_ != nil) {
//                    [HUD setHidden:YES];
//                    NSError *e;
//                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                         options: NSJSONReadingMutableContainers
//                                                                           error: &e];
//
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:[NSString stringWithFormat:@"%@",[[JSON valueForKey:@"responseHeader"] valueForKey:@"responseMessage"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//                else {
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Invalid loyalty number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//            }
//        }
//    }
//    @catch (NSException *exception) {
//
//        [HUD setHidden:YES];
//        NSLog(@"%@",exception.name);
//
//    }
//
//}


//editLoyalty method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)editLoyalty:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *value = [loyaltyNumtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *loyaltyKeys = @[@"idCardNumber", @"customerName",@"idCardType",@"loyaltyProgramNumber",@"phoneNum",@"email",@"requestHeader",@"loyaltyCardNumber"];
    
    NSArray *loyaltyObjects = @[idNo.text,usernameData.text,idTypeTxt.text,loyaltyPgm.text,phNoData.text,emailData.text,[RequestHeader getRequestHeader],value];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    WebServiceController * services =  [[WebServiceController alloc] init];
    services.loyaltycardServicesDelegate = self;
    [services updateIssuedLoyaltyCard:normalStockString];

}

// added by Roja on 17/10/2019…. // Old Code only pasted below...
- (void)updateIssuedLoyaltyCardSuccessReponse:(NSDictionary *)sucessDictionary{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:[NSString stringWithFormat:@"%@",[[sucessDictionary valueForKey:@"responseHeader"] valueForKey:@"responseMessage"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // Old Code only pasted below...
- (void)updateIssuedLoyaltyCardErrorResponse:(NSString *)error{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == loyaltyTypeTable) {
        return loyalTypeList.count;
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


//Customize HeightForHeaderInSection ...
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

//Table HeaderImage for Cancel view settting....
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
            label1.frame = CGRectMake(2, 2, 160, 35);
            closeBtn.frame = CGRectMake(200, 10, 30, 30);
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
// Customize the appearance of table view cells.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (tableView == loyaltyTypeTable) {
        
        //        loya.text = [loyalTypeList objectAtIndex:indexPath.row];
        //        loyaltyTypeTable.hidden = YES;
    }
    else{
        idTypeTxt.text = idslist[indexPath.row];
        idlistTableView.hidden = YES;
    }
    
}
-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
