//
//  ShowLowyalty.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 1/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewGiftVoucher.h"
#import "Global.h"
#import "RequestHeader.h"
#import "OmniHomePage.h"
//#import "SDZLoyaltycardService.h"
#import "GiftVoucherServices.h"
#ifndef ZXQR
#define ZXQR 1
#endif


//#if ZXQR
//#import "MultiFormatOneDReader.h"
//#endif


#ifndef ZXAZ
#define ZXAZ 0
#endif


@implementation ViewGiftVoucher

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
    
    self.titleLabel.text = @"Gift Voucher Details";
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
    barcodeBtn.enabled = FALSE;
    
    loyaltyNumtxt = [[UITextField alloc] init];
    loyaltyNumtxt.borderStyle = UITextBorderStyleRoundedRect;
    loyaltyNumtxt.textColor = [UIColor colorWithRed:78.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0];
    loyaltyNumtxt.placeholder = @"Scan or enter Voucher no or Mobile No.";  //place holder
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
    label.text = @" Please Enter Voucher Number or Mobile No.";
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont fontWithName:@"Arial-Italic" size:16];
    label1.textColor = [UIColor colorWithRed:0.0/255.0 green:158.0/255.0 blue:187.0/255.0 alpha:1.0];
    label1.text = @"Scan";
    
    submitBtn = [[UIButton alloc] init];
    [submitBtn addTarget:self
                  action:@selector(orderButtonPressed:) forControlEvents:UIControlEventTouchDown];
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
    
    usernameData = [[UILabel alloc] init];
    usernameData.textColor = [UIColor whiteColor];
    usernameData.textAlignment = NSTextAlignmentLeft;
    usernameData.backgroundColor = [UIColor clearColor];
    
    phNoData = [[UILabel alloc] init];
    phNoData.textColor = [UIColor whiteColor];
    phNoData.textAlignment = NSTextAlignmentLeft;
    phNoData.backgroundColor = [UIColor clearColor];
    
    emailData = [[UILabel alloc] init];
    emailData.numberOfLines = 2;
    emailData.lineBreakMode = NSLineBreakByWordWrapping;
    emailData.textAlignment = NSTextAlignmentLeft;
    emailData.backgroundColor = [UIColor clearColor];
    emailData.textColor = [UIColor whiteColor];
    
    
    idNo = [[UILabel alloc] init];
    idNo.textColor = [UIColor whiteColor];
    idNo.textAlignment = NSTextAlignmentLeft;
    idNo.backgroundColor = [UIColor clearColor];
    
    validFromData = [[UILabel alloc] init];
    validFromData.textColor = [UIColor whiteColor];
    validFromData.textAlignment = NSTextAlignmentLeft;
    validFromData.backgroundColor = [UIColor clearColor];
    
    validThruData = [[UILabel alloc] init];
    validThruData.textColor = [UIColor whiteColor];
    validThruData.textAlignment = NSTextAlignmentLeft;
    validThruData.backgroundColor = [UIColor clearColor];
    
    pointsData = [[UILabel alloc] init];
    pointsData.textColor = [UIColor whiteColor];
    pointsData.textAlignment = NSTextAlignmentLeft;
    pointsData.backgroundColor = [UIColor clearColor];
    
    amountData = [[UILabel alloc] init];
    amountData.textColor = [UIColor whiteColor];
    amountData.textAlignment = NSTextAlignmentLeft;
    amountData.backgroundColor = [UIColor clearColor];
    
    selectGiftVoucherTable = [[UITableView alloc] init];
    selectGiftVoucherTable.backgroundColor = [UIColor clearColor];
    selectGiftVoucherTable.layer.borderColor = [UIColor blackColor].CGColor;
    selectGiftVoucherTable.layer.cornerRadius = 4.0f;
    selectGiftVoucherTable.layer.borderWidth = 1.0f;
    selectGiftVoucherTable.dataSource = self;
    selectGiftVoucherTable.delegate = self;
    selectGiftVoucherTable.hidden = YES;

    snoLbl = [[UILabel alloc]init];
    snoLbl.text = @"S No";
    snoLbl.layer.cornerRadius = 14;
    snoLbl.textAlignment = NSTextAlignmentCenter;
    snoLbl.layer.masksToBounds = YES;
    snoLbl.font = [UIFont boldSystemFontOfSize:20.0];
    snoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    snoLbl.textColor = [UIColor whiteColor];
    
    cashValueLbl = [[UILabel alloc]init];
    cashValueLbl.text = @"Voucher Code";
    cashValueLbl.layer.cornerRadius = 14;
    cashValueLbl.textAlignment = NSTextAlignmentCenter;
    cashValueLbl.layer.masksToBounds = YES;
    cashValueLbl.font = [UIFont boldSystemFontOfSize:20.0];
    cashValueLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cashValueLbl.textColor = [UIColor whiteColor];
    
    noOfVouchersLbl = [[UILabel alloc]init];
    noOfVouchersLbl.text = @"Voucher Id";
    noOfVouchersLbl.layer.cornerRadius = 14;
    noOfVouchersLbl.textAlignment = NSTextAlignmentCenter;
    noOfVouchersLbl.layer.masksToBounds = YES;
    noOfVouchersLbl.font = [UIFont boldSystemFontOfSize:20.0];
    noOfVouchersLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    noOfVouchersLbl.textColor = [UIColor whiteColor];
    
    expiryDateLbl = [[UILabel alloc]init];
    expiryDateLbl.text = @"Voucher Value";
    expiryDateLbl.layer.cornerRadius = 14;
    expiryDateLbl.textAlignment = NSTextAlignmentCenter;
    expiryDateLbl.layer.masksToBounds = YES;
    expiryDateLbl.font = [UIFont boldSystemFontOfSize:20.0];
    expiryDateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    expiryDateLbl.textColor = [UIColor whiteColor];

    voucherNumberLbl = [[UILabel alloc]init];
    voucherNumberLbl.text = @"Voucher No.";
    voucherNumberLbl.layer.cornerRadius = 14;
    voucherNumberLbl.textAlignment = NSTextAlignmentCenter;
    voucherNumberLbl.layer.masksToBounds = YES;
    voucherNumberLbl.font = [UIFont boldSystemFontOfSize:20.0];
    voucherNumberLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    voucherNumberLbl.textColor = [UIColor whiteColor];

    expiryDateStatus = [[UILabel alloc]init];
    expiryDateStatus.text = @"Expiry Date";
    expiryDateStatus.layer.cornerRadius = 14;
    expiryDateStatus.textAlignment = NSTextAlignmentCenter;
    expiryDateStatus.layer.masksToBounds = YES;
    expiryDateStatus.font = [UIFont boldSystemFontOfSize:20.0];
    expiryDateStatus.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    expiryDateStatus.textColor = [UIColor whiteColor];

    noVouchersLbl = [[UILabel alloc]init];
    noVouchersLbl.text = @"No Unclaimed Vouchers for this Customer";
    noVouchersLbl.layer.cornerRadius = 14;
    noVouchersLbl.textAlignment = NSTextAlignmentCenter;
    noVouchersLbl.layer.masksToBounds = YES;
    noVouchersLbl.font = [UIFont boldSystemFontOfSize:20.0];
    noVouchersLbl.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    snoLbl.frame = CGRectMake(10.0, 530.0, 100.0, 50.0);
    cashValueLbl.frame = CGRectMake(115.0, 530.0, 180.0, 50.0);
    noOfVouchersLbl.frame = CGRectMake(300.0, 530.0, 150.0, 50.0);
    expiryDateLbl.frame = CGRectMake(455.0, 530.0, 200.0, 50.0);
    voucherNumberLbl.frame = CGRectMake(660.0, 530.0, 180.0, 50.0);
    expiryDateStatus.frame = CGRectMake(845.0, 530.0, 170.0, 50.0);
    selectGiftVoucherTable.frame = CGRectMake(20.0, 580.0, 900.0, 200.0);
    noOfVouchersLbl.frame = CGRectMake(300.0, 650.0, 1000.0, 60.0);
    searchBarcodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD2 = [UIImage imageNamed:@"searchImage.png"];
    [searchBarcodeBtn setBackgroundImage:buttonImageDD2 forState:UIControlStateNormal];
    [searchBarcodeBtn addTarget:self
                         action:@selector(searchVoucherDetails:) forControlEvents:UIControlEventTouchDown];
    searchBarcodeBtn.tag = 1;
    searchBarcodeBtn.hidden = NO;

    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet ;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.frame = CGRectMake(5, 5, 220, 40);
        //        label.font = [UIFont boldSystemFontOfSize:25];
        //        backbutton.frame = CGRectMake(690.0, 5.0, 40.0, 40.0);
        showLoyaltyView.frame = CGRectMake(20, 60, 738, 900);
        // img1.frame = CGRectMake(0, 0, 738, 900);
        //view.frame = CGRectMake(0, 0, 738, 200);
        // img2.frame = CGRectMake(20, 30, 90, 70);
        
        loyaltyNumtxt.frame = CGRectMake(270, 90.0, 360, 50);
        loyaltyNumtxt.font = [UIFont systemFontOfSize:20.0];
        label1.frame = CGRectMake(670, 40, 80, 80);
        label1.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0];
        barcodeBtn.frame = CGRectMake(660, 80, 80, 80);
        searchBarcodeBtn.frame = CGRectMake(585.0, 95.0, 40.0, 40.0);
//        label.frame = CGRectMake(270.0, 130.0, 350.0, 50);
        
        username.font = [UIFont boldSystemFontOfSize:20];
        username.frame = CGRectMake(250.0, 150, 250, 50);
        phNo.font = [UIFont boldSystemFontOfSize:20];
        phNo.frame = CGRectMake(250.0, 205, 250, 50);
        email.font = [UIFont boldSystemFontOfSize:20];
        email.frame = CGRectMake(250.0, 260, 250, 50);
        idType.font = [UIFont boldSystemFontOfSize:20];
        idType.frame = CGRectMake(250.0, 315, 250, 50);
        validFrom.font = [UIFont boldSystemFontOfSize:20];
        validFrom.frame = CGRectMake(250.0, 315, 250, 50);
        validThru.font = [UIFont boldSystemFontOfSize:20];
        validThru.frame = CGRectMake(250.0, 370, 250, 50);
        availPoints.font = [UIFont boldSystemFontOfSize:20];
        availPoints.frame = CGRectMake(250.0, 425, 250, 50);
        amount.font = [UIFont boldSystemFontOfSize:20];
        amount.frame = CGRectMake(250.0, 480, 250, 50);
        
        usernameData.font = [UIFont systemFontOfSize:20];
        usernameData.frame = CGRectMake(550.0, 150, 300, 50);
        phNoData.font = [UIFont systemFontOfSize:20];
        phNoData.frame = CGRectMake(550.0, 205, 300, 50);
        emailData.font = [UIFont systemFontOfSize:20];
        emailData.frame = CGRectMake(550.0, 260, 500, 50);
        validFromData.font = [UIFont systemFontOfSize:20];
        validFromData.frame = CGRectMake(550.0, 315, 300, 50);
        validThruData.font = [UIFont systemFontOfSize:20];
        validThruData.frame = CGRectMake(550.0, 370, 300, 50);
        pointsData.font = [UIFont systemFontOfSize:20];
        pointsData.frame = CGRectMake(550.0, 425, 300, 50);
        amountData.font = [UIFont systemFontOfSize:20];
        amountData.frame = CGRectMake(550.0, 480, 300, 50);
        
        submitBtn.frame = CGRectMake(350.0f, 800,450.0f, 50.0f);
        
        
    }
    else {
        
        if (version1 >= 8.0) {
            showLoyaltyView.frame = CGRectMake(8, 39, 305, 400);
            // img1.frame = CGRectMake(0, 0, 305, 400);
            // view.frame = CGRectMake(0, 0, 305, 68);
            // img2.frame = CGRectMake(10, 5, 60, 55);
            
            loyaltyNumtxt.frame = CGRectMake(20, 80, 200, 30);
            loyaltyNumtxt.font = [UIFont systemFontOfSize:17.0];
            submitBtn.frame = CGRectMake(226.0f, 80,36.0f, 36.0f);
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
            
            usernameData.frame = CGRectMake(140, 140, 130, 30);
            phNoData.frame = CGRectMake(140, 175, 130, 30);
            emailData.frame = CGRectMake(140, 210, 200, 30);
            idNo.frame = CGRectMake(140, 245, 130, 30);
            validFromData.frame = CGRectMake(140, 280, 130, 30);
            validThruData.frame = CGRectMake(140, 315, 130, 30);
            pointsData.frame = CGRectMake(140, 350, 130, 30);
            amountData.frame = CGRectMake(140, 385, 130, 30);
            
            
            usernameData.font = [UIFont systemFontOfSize:16];
            phNoData.font = [UIFont systemFontOfSize:16];
            emailData.font = [UIFont systemFontOfSize:16];
            idNo.font = [UIFont systemFontOfSize:16];
            validFromData.font = [UIFont systemFontOfSize:16];
            validThruData.font = [UIFont systemFontOfSize:16];
            pointsData.font = [UIFont systemFontOfSize:16];
            amountData.font = [UIFont systemFontOfSize:16];
            
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
    //    [self.view addSubview:submitBtn];
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
    [self.view addSubview:label1];
    [self.view addSubview:snoLbl];
    [self.view addSubview:cashValueLbl];
    [self.view addSubview:noOfVouchersLbl];
    [self.view addSubview:expiryDateLbl];
    [self.view addSubview:voucherNumberLbl];
    [self.view addSubview:expiryDateStatus];
    [self.view addSubview:selectGiftVoucherTable];
    [self.view addSubview:searchBarcodeBtn];
    [self.view addSubview:noVouchersLbl];
    
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
    
    snoLbl.hidden = YES;
    cashValueLbl.hidden = YES;
    noOfVouchersLbl.hidden = YES;
    expiryDateLbl.hidden = YES;
    voucherNumberLbl.hidden = YES;
    expiryDateStatus.hidden = YES;
    selectGiftVoucherTable.hidden = YES;
    noVouchersLbl.hidden = YES;

}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
//{
//    
//    if ([textField.text isEqualToString:loyaltyNumtxt.text]) {
//        
//        if ([characters isEqualToString:@""]) {
//            label.text = [NSString  stringWithFormat:@" %d characters left", ++count];
//        }
//        else {
//            
//            label.text = [NSString  stringWithFormat:@" %d characters left", --count];
//            
//        }
//        if (count == 0 ) {
//            
//            label.hidden = YES;
//        }
//        else{
//            
//            label.hidden = NO;
//        }
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
//        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
//    }
//    else{
//        
//        return YES;
//    }
//}

- (void)searchVoucherDetails:(UIButton *)sender {
    [self submitButtonPressed:submitBtn];
}

-(void)textChange:(NSNotification *)notification {
    
    UITextField *textfield = notification.object;
    
    
    if (textfield == loyaltyNumtxt) {
        
        if (loyaltyNumtxt.text.length == 16 || loyaltyNumtxt.text.length == 5) {
            [loyaltyNumtxt resignFirstResponder];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
            [self submitButtonPressed:submitBtn];
            
        }
    }
    
}

// Commented by roja on 17/10/2019.. // reason :- submitButtonPressed: method contains SOAP Service call .. so taken new method with same name(submitButtonPressed:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

// previousButtonPressed handing...
//- (void) submitButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    NSString *value = [loyaltyNumtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    [HUD setHidden:NO];
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
//        [HUD setHidden:YES];
//    }
//
//    else {
//        NSString * loyaltyString;
//
//        if (loyaltyNumtxt.text.length == 16 || loyaltyNumtxt.text.length == 5) {
//
//            NSArray *loyaltyKeys = @[@"voucherCode", @"requestHeader", @"mobileNumber", @"locations"];
//
//            NSArray *loyaltyObjects = @[loyaltyNumtxt.text,[RequestHeader getRequestHeader],@"", presentLocation];
//            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//            loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        }
//        else {
//            NSArray *loyaltyKeys = @[@"voucherCode", @"requestHeader", @"mobileNumber", @"locations"];
//
//            NSArray *loyaltyObjects = @[@"",[RequestHeader getRequestHeader],loyaltyNumtxt.text, presentLocation];
//            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//            loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        }
//        GiftVoucherServicesSoapBinding *skuService = [GiftVoucherServices GiftVoucherServicesSoapBinding] ;
//
//        GiftVoucherServices_getGiftVoucherDetails *voucher = [[GiftVoucherServices_getGiftVoucherDetails alloc] init];
//
//
//
//        voucher.giftVoucherDetails = loyaltyString;
//        @try {
//
//            GiftVoucherServicesSoapBindingResponse *response = [skuService getGiftVoucherDetailsUsingParameters:voucher];
//            NSArray *responseBodyParts = response.bodyParts;
//            if (responseBodyParts == nil) {
//                [HUD setHidden:YES];
//                UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Failed to get Information" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [validalert show];
//
//            }
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[GiftVoucherServices_getGiftVoucherDetailsResponse class]]) {
//                    GiftVoucherServices_getGiftVoucherDetailsResponse *body = (GiftVoucherServices_getGiftVoucherDetailsResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    [self getissuedLoyaltycardHandler:body.return_];
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            NSLog(@"Exception %@",exception.name);
//        }
//        @finally {
//        }
//    }
//}

//submitButtonPressed: method changed by roja on 17/10/2019.. // reason :- removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
- (void) submitButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    NSString *value = [loyaltyNumtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [HUD setHidden:NO];
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
        [HUD setHidden:YES];
    }
    
    else {
        NSString * loyaltyString;
        
        if (loyaltyNumtxt.text.length == 16 || loyaltyNumtxt.text.length == 5) {
            
            NSArray *loyaltyKeys = @[@"voucherCode", @"requestHeader", @"mobileNumber", @"locations"];
            
            NSArray *loyaltyObjects = @[loyaltyNumtxt.text,[RequestHeader getRequestHeader],@"", presentLocation];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
        }
        else {
            NSArray *loyaltyKeys = @[@"voucherCode", @"requestHeader", @"mobileNumber", @"locations"];
            
            NSArray *loyaltyObjects = @[@"",[RequestHeader getRequestHeader],loyaltyNumtxt.text, presentLocation];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
        }
        
        WebServiceController * services =  [[WebServiceController alloc] init];
        services.giftVoucherServicesDelegate =  self;
        [services getGiftVoucherDetails:loyaltyString];

    }
}

//

// added by Roja on 17/10/2019…. // OLD code pasted here...
- (void)getGiftVoucherDetailsSuccessReponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        [self getissuedLoyaltycardHandler:sucessDictionary];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // OLD code pasted here...
- (void)getGiftVoucherDetailsErrorResponse:(NSString *)error{
    
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}




// Commented by roja on 17/10/2019... // Reason: As per Latest REST service call below method handling also changes..
// so, latest changes done in another method with same method name(getPreviousOrdersHandler:)

// Handle the response from getissuedLoyaltycard.
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
//    [loyaltyNumtxt resignFirstResponder];
//
//    if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0 && [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] isEqualToString:@"Success"]) {
//
//        // NSArray *temp = [result componentsSeparatedByString:@"#"];
//
//        loyaltyNumtxt.text = nil;
//
//        username.text = @"Voucher Prg Code";
//        phNo.text = @"Voucher Code";
//        email.text = @"Voucher ID";
//        validFrom.text = @"Valid From";
//        validThru.text = @"Valid To";
//        availPoints.text = @"Voucher Value";
//        amount.text = @"Claimed Status";
//        //idType.text = @"Id Card";
//
//        SystemSoundID    soundFileObject1;
//        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
//        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//        AudioServicesPlaySystemSound (soundFileObject1);
//
//        if ([[JSON valueForKey:@"customerGiftVouchers"] isKindOfClass:[NSNull class]]) {
//
//            validFrom.hidden = NO;
//            validThru.hidden = NO;
//            availPoints.hidden = NO;
//            amount.hidden = NO;
//            validFromData.hidden = NO;
//            validThruData.hidden = NO;
//            pointsData.hidden = NO;
//            amountData.hidden = NO;
//            snoLbl.hidden = YES;
//            cashValueLbl.hidden = YES;
//            noOfVouchersLbl.hidden = YES;
//            expiryDateLbl.hidden = YES;
//            voucherNumberLbl.hidden = YES;
//            expiryDateStatus.hidden = YES;
//            selectGiftVoucherTable.hidden = YES;
//            noVouchersLbl.hidden = YES;
//
//            NSDictionary *gvDic = [JSON valueForKey:@"giftvouchers"];
//
//            if ([[gvDic valueForKey:@"voucherProgramCode"] isKindOfClass:[NSNull class]]) {
//                usernameData.text = @"--";
//            }
//            else {
//                usernameData.text = [NSString stringWithFormat:@"%@",gvDic[@"voucherProgramCode"]];
//            }
//
//            if ([[gvDic valueForKey:@"voucherCode"] isKindOfClass:[NSNull class]]) {
//                phNoData.text = @"--";
//            }
//            else {
//                phNoData.text = [NSString stringWithFormat:@"%@",gvDic[@"voucherCode"]];
//            }
//
//            if ([[gvDic valueForKey:@"voucherId"] isKindOfClass:[NSNull class]]) {
//                emailData.text = @"--";
//            }
//            else {
//                emailData.text = [NSString stringWithFormat:@"%@",gvDic[@"voucherId"]];
//            }
//
//            NSDictionary *gvDetailsDic = [JSON valueForKey:@"giftvoucherDetails"];
//
//            if ([[gvDetailsDic valueForKey:@"createdOn"] isKindOfClass:[NSNull class]]) {
//                validFromData.text = @"--";
//            }
//            else {
//                NSString *createdOn = [gvDetailsDic[@"createdOn"] componentsSeparatedByString:@" "][0];
//                validFromData.text = [NSString stringWithFormat:@"%@",createdOn];
//            }
//
//            if ([[gvDetailsDic valueForKey:@"expiryDate"] isKindOfClass:[NSNull class]]) {
//                validThruData.text = @"--";
//            }
//            else {
//                NSString *expiryDate = [gvDetailsDic[@"expiryDate"] componentsSeparatedByString:@" "][0];
//                validThruData.text = [NSString stringWithFormat:@"%@",expiryDate];
//            }
//            if ([[gvDetailsDic valueForKey:@"unitCashValue"] isKindOfClass:[NSNull class]]) {
//                pointsData.text = @"--";
//            }
//            else {
//                pointsData.text = [NSString stringWithFormat:@"%.2f",[[gvDetailsDic valueForKey:@"unitCashValue"] floatValue]];
//            }
//            if ([[JSON valueForKey:@"claimStatus"] boolValue]) {
//                amountData.text = @"YES";
//            }
//            else {
//                amountData.text = @"NO";
//            }
//
//
//        }
//        else {
//            NSArray *customerGiftVouchers = [JSON valueForKey:@"customerGiftVouchers"];
//
//            if (customerGiftVouchers.count > 0) {
//                NSDictionary *custGVInfoDic = customerGiftVouchers[0];
//                username.text = @"Customer Name";
//                phNo.text = @"Mobile Number";
//                email.text = @"Email ID";
//
//                validFrom.hidden = YES;
//                validThru.hidden = YES;
//                availPoints.hidden = YES;
//                amount.hidden = YES;
//                validFromData.hidden = YES;
//                validThruData.hidden = YES;
//                pointsData.hidden = YES;
//                amountData.hidden = YES;
//
//                snoLbl.hidden = NO;
//                cashValueLbl.hidden = NO;
//                noOfVouchersLbl.hidden = NO;
//                expiryDateLbl.hidden = NO;
//                voucherNumberLbl.hidden = NO;
//                expiryDateStatus.hidden = NO;
//                selectGiftVoucherTable.hidden = NO;
//
//                noVouchersLbl.hidden = YES;
//
//                if ([[custGVInfoDic valueForKey:@"customerName"] isKindOfClass:[NSNull class]]) {
//                    usernameData.text = @"--";
//                }
//                else {
//                    usernameData.text = [NSString stringWithFormat:@"%@",custGVInfoDic[@"customerName"]];
//                }
//
//                if ([[custGVInfoDic valueForKey:@"customerMobile"] isKindOfClass:[NSNull class]]) {
//                    phNoData.text = @"--";
//                }
//                else {
//                    phNoData.text = [NSString stringWithFormat:@"%@",custGVInfoDic[@"customerMobile"]];
//                }
//
//                if ([[custGVInfoDic valueForKey:@"customerEmail"] isKindOfClass:[NSNull class]]) {
//                    emailData.text = @"--";
//                }
//                else {
//                    emailData.text = [NSString stringWithFormat:@"%@",custGVInfoDic[@"customerEmail"]];
//                }
//
//                snoLbl.frame = CGRectMake(10.0, 310.0, 100.0, 50.0);
//                cashValueLbl.frame = CGRectMake(115.0, 310.0, 180.0, 50.0);
//                noOfVouchersLbl.frame = CGRectMake(300.0, 310.0, 150.0, 50.0);
//                expiryDateLbl.frame = CGRectMake(455.0, 310.0, 200.0, 50.0);
//                voucherNumberLbl.frame = CGRectMake(660.0, 310.0, 180.0, 50.0);
//                expiryDateStatus.frame = CGRectMake(845.0, 310.0, 170.0, 50.0);
//                selectGiftVoucherTable.frame = CGRectMake(10.0, 360.0, 1000.0, 400.0);
//
//                custGiftVoucherArr = [[NSMutableArray alloc] initWithArray:customerGiftVouchers];
//                selectGiftVoucherTable.hidden = NO;
//
//                [selectGiftVoucherTable reloadData];
//
//                [self.view addSubview:snoLbl];
//                [self.view addSubview:cashValueLbl];
//                [self.view addSubview:noOfVouchersLbl];
//                [self.view addSubview:expiryDateLbl];
//                [self.view addSubview:voucherNumberLbl];
//                [self.view addSubview:expiryDateStatus];
//
//            }
//            else {
//                noVouchersLbl.hidden = NO;
//            }
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
//        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//        AudioServicesPlaySystemSound (soundFileObject1);
//
//        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [validalert show];
//    }
//
//}

// Changed by roja on 17/10/2019...
- (void) getissuedLoyaltycardHandler: (NSDictionary *) successResponse {
    
    [HUD setHidden:YES];
    label.text = @"";
 
    [loyaltyNumtxt resignFirstResponder];
    
//    if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0 && [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] isEqualToString:@"Success"]) {
    
    if(successResponse != nil){
        
        loyaltyNumtxt.text = nil;
        username.text = @"Voucher Prg Code";
        phNo.text = @"Voucher Code";
        email.text = @"Voucher ID";
        validFrom.text = @"Valid From";
        validThru.text = @"Valid To";
        availPoints.text = @"Voucher Value";
        amount.text = @"Claimed Status";
        //idType.text = @"Id Card";
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        if ([[successResponse valueForKey:@"customerGiftVouchers"] isKindOfClass:[NSNull class]]) {
            
            validFrom.hidden = NO;
            validThru.hidden = NO;
            availPoints.hidden = NO;
            amount.hidden = NO;
            validFromData.hidden = NO;
            validThruData.hidden = NO;
            pointsData.hidden = NO;
            amountData.hidden = NO;
            snoLbl.hidden = YES;
            cashValueLbl.hidden = YES;
            noOfVouchersLbl.hidden = YES;
            expiryDateLbl.hidden = YES;
            voucherNumberLbl.hidden = YES;
            expiryDateStatus.hidden = YES;
            selectGiftVoucherTable.hidden = YES;
            noVouchersLbl.hidden = YES;
            
            NSDictionary *gvDic = [successResponse valueForKey:@"giftvouchers"];
            
            if ([[gvDic valueForKey:@"voucherProgramCode"] isKindOfClass:[NSNull class]]) {
                usernameData.text = @"--";
            }
            else {
                usernameData.text = [NSString stringWithFormat:@"%@",gvDic[@"voucherProgramCode"]];
            }
            
            if ([[gvDic valueForKey:@"voucherCode"] isKindOfClass:[NSNull class]]) {
                phNoData.text = @"--";
            }
            else {
                phNoData.text = [NSString stringWithFormat:@"%@",gvDic[@"voucherCode"]];
            }
            
            if ([[gvDic valueForKey:@"voucherId"] isKindOfClass:[NSNull class]]) {
                emailData.text = @"--";
            }
            else {
                emailData.text = [NSString stringWithFormat:@"%@",gvDic[@"voucherId"]];
            }
            
            NSDictionary *gvDetailsDic = [successResponse valueForKey:@"giftvoucherDetails"];
            
            if ([[gvDetailsDic valueForKey:@"createdOn"] isKindOfClass:[NSNull class]]) {
                validFromData.text = @"--";
            }
            else {
                NSString *createdOn = [gvDetailsDic[@"createdOn"] componentsSeparatedByString:@" "][0];
                validFromData.text = [NSString stringWithFormat:@"%@",createdOn];
            }
            
            if ([[gvDetailsDic valueForKey:@"expiryDate"] isKindOfClass:[NSNull class]]) {
                validThruData.text = @"--";
            }
            else {
                NSString *expiryDate = [gvDetailsDic[@"expiryDate"] componentsSeparatedByString:@" "][0];
                validThruData.text = [NSString stringWithFormat:@"%@",expiryDate];
            }
            if ([[gvDetailsDic valueForKey:@"unitCashValue"] isKindOfClass:[NSNull class]]) {
                pointsData.text = @"--";
            }
            else {
                pointsData.text = [NSString stringWithFormat:@"%.2f",[[gvDetailsDic valueForKey:@"unitCashValue"] floatValue]];
            }
            if ([[successResponse valueForKey:@"claimStatus"] boolValue]) {
                amountData.text = @"YES";
            }
            else {
                amountData.text = @"NO";
            }
            
            
        }
        else {
            NSArray *customerGiftVouchers = [successResponse valueForKey:@"customerGiftVouchers"];
            
            if (customerGiftVouchers.count > 0) {
                NSDictionary *custGVInfoDic = customerGiftVouchers[0];
                username.text = @"Customer Name";
                phNo.text = @"Mobile Number";
                email.text = @"Email ID";
                
                validFrom.hidden = YES;
                validThru.hidden = YES;
                availPoints.hidden = YES;
                amount.hidden = YES;
                validFromData.hidden = YES;
                validThruData.hidden = YES;
                pointsData.hidden = YES;
                amountData.hidden = YES;
                
                snoLbl.hidden = NO;
                cashValueLbl.hidden = NO;
                noOfVouchersLbl.hidden = NO;
                expiryDateLbl.hidden = NO;
                voucherNumberLbl.hidden = NO;
                expiryDateStatus.hidden = NO;
                selectGiftVoucherTable.hidden = NO;
                
                noVouchersLbl.hidden = YES;
                
                if ([[custGVInfoDic valueForKey:@"customerName"] isKindOfClass:[NSNull class]]) {
                    usernameData.text = @"--";
                }
                else {
                    usernameData.text = [NSString stringWithFormat:@"%@",custGVInfoDic[@"customerName"]];
                }
                
                if ([[custGVInfoDic valueForKey:@"customerMobile"] isKindOfClass:[NSNull class]]) {
                    phNoData.text = @"--";
                }
                else {
                    phNoData.text = [NSString stringWithFormat:@"%@",custGVInfoDic[@"customerMobile"]];
                }
                
                if ([[custGVInfoDic valueForKey:@"customerEmail"] isKindOfClass:[NSNull class]]) {
                    emailData.text = @"--";
                }
                else {
                    emailData.text = [NSString stringWithFormat:@"%@",custGVInfoDic[@"customerEmail"]];
                }
                
                snoLbl.frame = CGRectMake(10.0, 310.0, 100.0, 50.0);
                cashValueLbl.frame = CGRectMake(115.0, 310.0, 180.0, 50.0);
                noOfVouchersLbl.frame = CGRectMake(300.0, 310.0, 150.0, 50.0);
                expiryDateLbl.frame = CGRectMake(455.0, 310.0, 200.0, 50.0);
                voucherNumberLbl.frame = CGRectMake(660.0, 310.0, 180.0, 50.0);
                expiryDateStatus.frame = CGRectMake(845.0, 310.0, 170.0, 50.0);
                selectGiftVoucherTable.frame = CGRectMake(10.0, 360.0, 1000.0, 400.0);
                
                custGiftVoucherArr = [[NSMutableArray alloc] initWithArray:customerGiftVouchers];
                selectGiftVoucherTable.hidden = NO;
                
                [selectGiftVoucherTable reloadData];
                
                [self.view addSubview:snoLbl];
                [self.view addSubview:cashValueLbl];
                [self.view addSubview:noOfVouchersLbl];
                [self.view addSubview:expiryDateLbl];
                [self.view addSubview:voucherNumberLbl];
                [self.view addSubview:expiryDateStatus];
                
            }
            else {
                noVouchersLbl.hidden = NO;
            }
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
        
//        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:[[successResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Unable to get gift voucher details" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
////        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
////        service.logging = YES;
////        // Returns NSString*.
////        [service getissuedLoyaltycard:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber:result];
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
-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == selectGiftVoucherTable) {
        return custGiftVoucherArr.count;
    }
    else {
        return 0;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
        
        NSDictionary *dic = custGiftVoucherArr[indexPath.row];
        
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
        if ([[dic valueForKey:@"voucherCode"] isKindOfClass:[NSNull class]]) {
            skid.text = @"--";
        }
        else {
            skid.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"voucherCode"]];
        }
        skid.textAlignment=NSTextAlignmentCenter;
        //            skid.adjustsFontSizeToFitWidth = YES;
        
        UILabel *mrpPrice = [[UILabel alloc] init] ;
        mrpPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        mrpPrice.layer.borderWidth = 1.5;
        mrpPrice.backgroundColor = [UIColor blackColor];
        if ([[dic valueForKey:@"voucherId"] isKindOfClass:[NSNull class]]) {
            mrpPrice.text = @"--";
        }
        else {
            mrpPrice.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"voucherId"]];
        }
        mrpPrice.textAlignment = NSTextAlignmentCenter;
        mrpPrice.numberOfLines = 2;
        mrpPrice.textColor = [UIColor whiteColor];
        
        UILabel *price = [[UILabel alloc] init] ;
        price.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        price.layer.borderWidth = 1.5;
        price.backgroundColor = [UIColor blackColor];
        if ([[dic valueForKey:@"voucherValue"] isKindOfClass:[NSNull class]]) {
            price.text = @"--";
        }
        else {
            price.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:@"voucherValue"] floatValue]];
        }
        price.textAlignment = NSTextAlignmentCenter;
        price.numberOfLines = 2;
        price.textColor = [UIColor whiteColor];

        UILabel *expiryDateval = [[UILabel alloc] init] ;
        expiryDateval.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        expiryDateval.layer.borderWidth = 1.5;
        expiryDateval.backgroundColor = [UIColor blackColor];
        expiryDateval.text = [NSString stringWithFormat:@"%@",@"1"];
        expiryDateval.textAlignment = NSTextAlignmentCenter;
        expiryDateval.numberOfLines = 2;
        expiryDateval.textColor = [UIColor whiteColor];

        UILabel *voucherNumLbl = [[UILabel alloc] init] ;
        voucherNumLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        voucherNumLbl.layer.borderWidth = 1.5;
        voucherNumLbl.backgroundColor = [UIColor blackColor];
        if ([[dic valueForKey:@"validityDate"] isKindOfClass:[NSNull class]]) {
            voucherNumLbl.text = @"--";
        }
        else {
            voucherNumLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"validityDate"]];
        }
        voucherNumLbl.textAlignment = NSTextAlignmentCenter;
        voucherNumLbl.numberOfLines = 2;
        voucherNumLbl.textColor = [UIColor whiteColor];

//        UILabel *expiryDateStatusval = [[UILabel alloc] init] ;
//        expiryDateStatusval.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
//        expiryDateStatusval.layer.borderWidth = 1.5;
//        expiryDateStatusval.backgroundColor = [UIColor blackColor];
//        expiryDateStatusval.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"expiryDate"]];
//        expiryDateStatusval.textAlignment = NSTextAlignmentCenter;
//        expiryDateStatusval.numberOfLines = 2;
//        expiryDateStatusval.textColor = [UIColor whiteColor];

        // name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
        
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            sno.font = [UIFont systemFontOfSize:18];
            sno.frame = CGRectMake(5, 0, 100.0, 60.0);
            skid.font = [UIFont systemFontOfSize:18];
            skid.frame = CGRectMake(105, 0, 180, 60);
            mrpPrice.font = [UIFont systemFontOfSize:18];
            mrpPrice.frame = CGRectMake(285, 0, 150, 60);
            price.font = [UIFont systemFontOfSize:18];
            price.frame = CGRectMake(445.0, 0, 200, 60);
            expiryDateval.font = [UIFont systemFontOfSize:18];
            expiryDateval.frame = CGRectMake(645.0, 0, 180.0, 60);
            voucherNumLbl.font = [UIFont systemFontOfSize:18];
            voucherNumLbl.frame = CGRectMake(825.0, 0, 170.0, 60);
            
            
        }
        else {
            
            skid.frame = CGRectMake(10, 0, 100, 34);
            price.frame = CGRectMake(120, 0, 90, 34);
            
            
        }
        
        hlcell.backgroundColor = [UIColor clearColor];
        [hlcell.contentView addSubview:sno];
        [hlcell.contentView addSubview:skid];
        [hlcell.contentView addSubview:mrpPrice];
        [hlcell.contentView addSubview:price];
        [hlcell.contentView addSubview:expiryDateval];
        [hlcell.contentView addSubview:voucherNumLbl];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        
        
    }
    return hlcell;
}
- (void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
