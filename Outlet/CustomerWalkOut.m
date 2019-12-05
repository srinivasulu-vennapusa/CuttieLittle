//
//  CustomerWalkOut.m
//  OmniRetailer
//
//  Created by Bhargav on 10/4/16.
//
//

#import "CustomerWalkOut.h"
#import "OmniHomePage.h"
#import "WalkoutDetails.h"
#import "CheckWifi.h"
#import "CustomerServiceSvc.h"
#import <QuartzCore/QuartzCore.h>



@interface CustomerWalkOut ()

@end

@implementation CustomerWalkOut


BOOL customerStats = false;



-(void)viewDidAppear:(BOOL)animated{
    
    @try {
        
        genderArr = [NSMutableArray new];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = NSLocalizedString(@"HUD_LABEL", nil);
    
    //main view bakground setting...
    self.view.backgroundColor = [UIColor blackColor];
    self.titleLabel.text = NSLocalizedString(@"CUSTOMER WALKOUT", nil);
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (_soundFileURLRef,&_soundFileObject);
    
    //    CUSTOMER WALK OUT GUI
    
    
    
    
    walkOutView = [[UIView alloc] init];
    walkOutView.backgroundColor = [UIColor blackColor];
    walkOutView.layer.borderWidth = 1.0f;
    walkOutView.layer.cornerRadius = 10.0f;
    walkOutView.layer.borderColor = [UIColor clearColor].CGColor;
    
    phoneLbl = [[UILabel alloc] init];
    phoneLbl.text = @"Phone";
    phoneLbl.backgroundColor = [UIColor clearColor];
    phoneLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    firstNameLbl = [[UILabel alloc] init];
    firstNameLbl.text = @"First Name";
    firstNameLbl.backgroundColor = [UIColor clearColor];
    firstNameLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    emailLbl = [[UILabel alloc] init];
    emailLbl.text = @"Email";
    emailLbl.backgroundColor = [UIColor clearColor];
    emailLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    lastNameLbl = [[UILabel alloc] init];
    lastNameLbl.text = @"Last Name";
    lastNameLbl.backgroundColor = [UIColor clearColor];
    lastNameLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    professionLbl = [[UILabel alloc] init];
    professionLbl.text = @"Profession";
    professionLbl.backgroundColor = [UIColor clearColor];
    professionLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    professionLbl.textAlignment = NSTextAlignmentRight;
    
    
    ageLbl = [[UILabel alloc] init];
    ageLbl.text = @"Age";
    ageLbl.backgroundColor = [UIColor clearColor];
    ageLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    dobLbl = [[UILabel alloc] init];
    dobLbl.text = @"DOB";
    dobLbl.backgroundColor = [UIColor clearColor];
    dobLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    genderLbl = [[UILabel alloc] init];
    genderLbl.text = @"Gender";
    genderLbl.backgroundColor = [UIColor clearColor];
    genderLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    verticalLbl = [[UILabel alloc] init];
    verticalLbl.text = @"";
    verticalLbl.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    verticalLbl.textColor = [UIColor whiteColor];
    
    
    
    horiaontalLbl = [[UILabel alloc] init];
    horiaontalLbl.text = @"";
    horiaontalLbl.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
    horiaontalLbl.textColor = [UIColor whiteColor];
    
    
    horizntal1 = [[UILabel alloc] init];
    horizntal1.text = @"";
    horizntal1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    horizntal1.textColor = [UIColor whiteColor];
    
    
    custmerRjections = [[UILabel alloc] init];
    custmerRjections.text = @"Customer Rejections";
    custmerRjections.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6 ];
    
    
    custmrRqrment = [[UILabel alloc] init];
    custmrRqrment.text = @"Customer Requirement";
    custmrRqrment.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    
    reasonLbl  = [[UILabel alloc] init];
    reasonLbl.text = @"Reason";
    reasonLbl.backgroundColor = [UIColor clearColor];
    reasonLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    
    streetLbl  = [[UILabel alloc] init];
    streetLbl.text = @"Street";
    streetLbl.backgroundColor = [UIColor clearColor];
    streetLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    localityLbl  = [[UILabel alloc] init];
    localityLbl.text = @"Locality";
    localityLbl.backgroundColor = [UIColor clearColor];
    localityLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    cityLbl  = [[UILabel alloc] init];
    cityLbl.text = @"City";
    cityLbl.backgroundColor = [UIColor clearColor];
    cityLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    pinLbl  = [[UILabel alloc] init];
    pinLbl.text = @"Pin";
    pinLbl.backgroundColor = [UIColor clearColor];
    pinLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    departmentLbl  = [[UILabel alloc] init];
    departmentLbl.text = @"Department";
    departmentLbl.backgroundColor = [UIColor clearColor];
    departmentLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    brandLbl  = [[UILabel alloc] init];
    brandLbl.text = @"Brand";
    brandLbl.backgroundColor = [UIColor clearColor];
    brandLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    colour  = [[UILabel alloc] init];
    colour.text = @"Color";
    colour.backgroundColor = [UIColor clearColor];
    colour.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    size  = [[UILabel alloc] init];
    size.text = @"Size";
    size.backgroundColor = [UIColor clearColor];
    size.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    categoryLbl  = [[UILabel alloc] init];
    categoryLbl.text = @"Category";
    categoryLbl.backgroundColor = [UIColor clearColor];
    categoryLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    priceRngLbl  = [[UILabel alloc] init];
    priceRngLbl.text = @"Price";
    priceRngLbl.backgroundColor = [UIColor clearColor];
    priceRngLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    brandLbl1  = [[UILabel alloc] init];
    brandLbl1.text = @"Brand";
    brandLbl1.backgroundColor = [UIColor clearColor];
    brandLbl1.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    colorLbl1  = [[UILabel alloc] init];
    colorLbl1.text = @"Color";
    colorLbl1.backgroundColor = [UIColor clearColor];
    colorLbl1.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    sizeLbl1  = [[UILabel alloc] init];
    sizeLbl1.text = @"Size";
    sizeLbl1.backgroundColor = [UIColor clearColor];
    sizeLbl1.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    dlvryDteLbl  = [[UILabel alloc] init];
    dlvryDteLbl.text = @"Delivery Date";
    dlvryDteLbl.backgroundColor = [UIColor clearColor];
    dlvryDteLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    inTimeLbl  = [[UILabel alloc] init];
    inTimeLbl.text = @"In Time";
    inTimeLbl.backgroundColor = [UIColor clearColor];
    inTimeLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    outTimeLbl  = [[UILabel alloc] init];
    outTimeLbl.text = @"Out Time";
    outTimeLbl.backgroundColor = [UIColor clearColor];
    outTimeLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    
    
    phoneNoFld = [[UITextField alloc] init];
    phoneNoFld.borderStyle = UITextBorderStyleRoundedRect;
    phoneNoFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    phoneNoFld.font = [UIFont systemFontOfSize:18.0];
    phoneNoFld.backgroundColor = [UIColor clearColor];
    phoneNoFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNoFld.autocorrectionType = UITextAutocorrectionTypeNo;
    phoneNoFld.layer.borderWidth = 1.0f;
    phoneNoFld.delegate = self;
    phoneNoFld.userInteractionEnabled = YES;
    [phoneNoFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    phoneNoFld.keyboardType = UIKeyboardTypeNumberPad;
    
    phoneNoFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    phoneNoFld.placeholder = NSLocalizedString(@" Phone", nil);
    phoneNoFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phoneNoFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    firstNameFld = [[UITextField alloc] init];
    firstNameFld.borderStyle = UITextBorderStyleRoundedRect;
    firstNameFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    firstNameFld.font = [UIFont systemFontOfSize:18.0];
    firstNameFld.backgroundColor = [UIColor clearColor];
    firstNameFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstNameFld.autocorrectionType = UITextAutocorrectionTypeNo;
    firstNameFld.layer.borderWidth = 1.0f;
    firstNameFld.delegate = self;
    firstNameFld.userInteractionEnabled = YES;
    
    firstNameFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    firstNameFld.placeholder = NSLocalizedString(@" First Name", nil);
    firstNameFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:firstNameFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    emailFld = [[UITextField alloc] init];
    emailFld.borderStyle = UITextBorderStyleRoundedRect;
    emailFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    emailFld.font = [UIFont systemFontOfSize:18.0];
    emailFld.backgroundColor = [UIColor clearColor];
    emailFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailFld.autocorrectionType = UITextAutocorrectionTypeNo;
    emailFld.layer.borderWidth = 1.0f;
    emailFld.delegate = self;
    emailFld.userInteractionEnabled = YES;
    
    emailFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    emailFld.placeholder = NSLocalizedString(@" Email", nil);
    emailFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:emailFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    lastNameFld = [[UITextField alloc] init];
    lastNameFld.borderStyle = UITextBorderStyleRoundedRect;
    lastNameFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    lastNameFld.font = [UIFont systemFontOfSize:18.0];
    lastNameFld.backgroundColor = [UIColor clearColor];
    lastNameFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastNameFld.autocorrectionType = UITextAutocorrectionTypeNo;
    lastNameFld.layer.borderWidth = 1.0f;
    lastNameFld.delegate = self;
    lastNameFld.userInteractionEnabled = YES;
    
    lastNameFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    lastNameFld.placeholder = NSLocalizedString(@" Last Name", nil);
    lastNameFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:lastNameFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    profsnlFld = [[UITextField alloc] init];
    profsnlFld.borderStyle = UITextBorderStyleRoundedRect;
    profsnlFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    profsnlFld.font = [UIFont systemFontOfSize:18.0];
    profsnlFld.backgroundColor = [UIColor clearColor];
    profsnlFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    profsnlFld.autocorrectionType = UITextAutocorrectionTypeNo;
    profsnlFld.layer.borderWidth = 1.0f;
    profsnlFld.delegate = self;
    profsnlFld.userInteractionEnabled = YES;
    
    profsnlFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    profsnlFld.placeholder = NSLocalizedString(@" Profession", nil);
    profsnlFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:profsnlFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    ageFld = [[UITextField alloc] init];
    ageFld.borderStyle = UITextBorderStyleRoundedRect;
    ageFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    ageFld.font = [UIFont systemFontOfSize:18.0];
    ageFld.backgroundColor = [UIColor clearColor];
    ageFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    ageFld.autocorrectionType = UITextAutocorrectionTypeNo;
    ageFld.layer.borderWidth = 1.0f;
    ageFld.delegate = self;
    ageFld.userInteractionEnabled = NO;
    
    ageFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    ageFld.placeholder = NSLocalizedString(@" Age", nil);
    ageFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:ageFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    dobFld = [[UITextField alloc] init];
    dobFld.borderStyle = UITextBorderStyleRoundedRect;
    dobFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    dobFld.font = [UIFont systemFontOfSize:18.0];
    dobFld.backgroundColor = [UIColor clearColor];
    dobFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    dobFld.autocorrectionType = UITextAutocorrectionTypeNo;
    dobFld.layer.borderWidth = 1.0f;
    dobFld.delegate = self;
    dobFld.userInteractionEnabled = NO;
    
    dobFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    dobFld.placeholder = NSLocalizedString(@" Birth Date", nil);
    dobFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dobFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    genderFld = [[UITextField alloc] init];
    genderFld.borderStyle = UITextBorderStyleRoundedRect;
    genderFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    genderFld.font = [UIFont systemFontOfSize:18.0];
    genderFld.backgroundColor = [UIColor clearColor];
    genderFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    genderFld.autocorrectionType = UITextAutocorrectionTypeNo;
    genderFld.layer.borderWidth = 1.0f;
    genderFld.delegate = self;
    genderFld.userInteractionEnabled = NO;
    
    genderFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    genderFld.placeholder = NSLocalizedString(@" Gender", nil);
    genderFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:genderFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    streetFld = [[UITextField alloc] init];
    streetFld.borderStyle = UITextBorderStyleRoundedRect;
    streetFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    streetFld.font = [UIFont systemFontOfSize:18.0];
    streetFld.backgroundColor = [UIColor clearColor];
    streetFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    streetFld.autocorrectionType = UITextAutocorrectionTypeNo;
    streetFld.layer.borderWidth = 1.0f;
    streetFld.delegate = self;
    streetFld.userInteractionEnabled = YES;
    
    streetFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    streetFld.placeholder = NSLocalizedString(@" Street", nil);
    streetFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:streetFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    
    localityFld = [[UITextField alloc] init];
    localityFld.borderStyle = UITextBorderStyleRoundedRect;
    localityFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    localityFld.font = [UIFont systemFontOfSize:18.0];
    localityFld.backgroundColor = [UIColor clearColor];
    localityFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    localityFld.autocorrectionType = UITextAutocorrectionTypeNo;
    localityFld.layer.borderWidth = 1.0f;
    localityFld.delegate = self;
    localityFld.userInteractionEnabled = YES;
    
    localityFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    localityFld.placeholder = NSLocalizedString(@" Locality", nil);
    localityFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:localityFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    cityFld = [[UITextField alloc] init];
    cityFld.borderStyle = UITextBorderStyleRoundedRect;
    cityFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    cityFld.font = [UIFont systemFontOfSize:18.0];
    cityFld.backgroundColor = [UIColor clearColor];
    cityFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    cityFld.autocorrectionType = UITextAutocorrectionTypeNo;
    cityFld.layer.borderWidth = 1.0f;
    cityFld.delegate = self;
    cityFld.userInteractionEnabled = YES;
    
    cityFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    cityFld.placeholder = NSLocalizedString(@" City", nil);
    cityFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:cityFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    pinFld = [[UITextField alloc] init];
    pinFld.borderStyle = UITextBorderStyleRoundedRect;
    pinFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    pinFld.font = [UIFont systemFontOfSize:18.0];
    pinFld.backgroundColor = [UIColor clearColor];
    pinFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    pinFld.autocorrectionType = UITextAutocorrectionTypeNo;
    pinFld.layer.borderWidth = 1.0f;
    pinFld.delegate = self;
    pinFld.userInteractionEnabled = YES;
    
    pinFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    pinFld.placeholder = NSLocalizedString(@" Pin No", nil);
    pinFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:pinFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    deprtmntFld = [[UITextField alloc] init];
    deprtmntFld.borderStyle = UITextBorderStyleRoundedRect;
    deprtmntFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    deprtmntFld.font = [UIFont systemFontOfSize:18.0];
    deprtmntFld.backgroundColor = [UIColor clearColor];
    deprtmntFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    deprtmntFld.autocorrectionType = UITextAutocorrectionTypeNo;
    deprtmntFld.layer.borderWidth = 1.0f;
    deprtmntFld.delegate = self;
    deprtmntFld.userInteractionEnabled = NO;
    
    deprtmntFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    deprtmntFld.placeholder = NSLocalizedString(@" Department", nil);
    deprtmntFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:deprtmntFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    brandFld = [[UITextField alloc] init];
    brandFld.borderStyle = UITextBorderStyleRoundedRect;
    brandFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    brandFld.font = [UIFont systemFontOfSize:18.0];
    brandFld.backgroundColor = [UIColor clearColor];
    brandFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    brandFld.autocorrectionType = UITextAutocorrectionTypeNo;
    brandFld.layer.borderWidth = 1.0f;
    brandFld.delegate = self;
    brandFld.userInteractionEnabled = NO;
    
    brandFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    brandFld.placeholder = NSLocalizedString(@" Brand", nil);
    brandFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:brandFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    colourFld = [[UITextField alloc] init];
    colourFld.borderStyle = UITextBorderStyleRoundedRect;
    colourFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    colourFld.font = [UIFont systemFontOfSize:18.0];
    colourFld.backgroundColor = [UIColor clearColor];
    colourFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    colourFld.autocorrectionType = UITextAutocorrectionTypeNo;
    colourFld.layer.borderWidth = 1.0f;
    colourFld.delegate = self;
    colourFld.userInteractionEnabled = NO;
    
    colourFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    colourFld.placeholder = NSLocalizedString(@" Color", nil);
    colourFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:colourFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    sizeFld = [[UITextField alloc] init];
    sizeFld.borderStyle = UITextBorderStyleRoundedRect;
    sizeFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    sizeFld.font = [UIFont systemFontOfSize:18.0];
    sizeFld.backgroundColor = [UIColor clearColor];
    sizeFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    sizeFld.autocorrectionType = UITextAutocorrectionTypeNo;
    sizeFld.layer.borderWidth = 1.0f;
    sizeFld.delegate = self;
    sizeFld.userInteractionEnabled = NO;
    
    sizeFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    sizeFld.placeholder = NSLocalizedString(@" Size", nil);
    sizeFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:sizeFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    reasonFld = [[UITextField alloc] init];
    reasonFld.borderStyle = UITextBorderStyleRoundedRect;
    reasonFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    reasonFld.font = [UIFont systemFontOfSize:18.0];
    reasonFld.backgroundColor = [UIColor clearColor];
    reasonFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    reasonFld.autocorrectionType = UITextAutocorrectionTypeNo;
    reasonFld.layer.borderWidth = 1.0f;
    reasonFld.delegate = self;
    reasonFld.userInteractionEnabled = NO;
    
    reasonFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    reasonFld.placeholder = NSLocalizedString(@" Reason", nil);
    reasonFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:reasonFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    UIImage *reasnImg = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * reasonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [reasonBtn setBackgroundImage:reasnImg forState:UIControlStateNormal];
    [reasonBtn addTarget:self
                  action:@selector(populateReason) forControlEvents:UIControlEventTouchDown];
    
    
    
    categoryFld = [[UITextField alloc] init];
    categoryFld.borderStyle = UITextBorderStyleRoundedRect;
    categoryFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    categoryFld.font = [UIFont systemFontOfSize:18.0];
    categoryFld.backgroundColor = [UIColor clearColor];
    categoryFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    categoryFld.autocorrectionType = UITextAutocorrectionTypeNo;
    categoryFld.layer.borderWidth = 1.0f;
    categoryFld.delegate = self;
    categoryFld.userInteractionEnabled = NO;
    
    categoryFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    categoryFld.placeholder = NSLocalizedString(@" Category", nil);
    categoryFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:categoryFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    priceFld = [[UITextField alloc] init];
    priceFld.borderStyle = UITextBorderStyleRoundedRect;
    priceFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    priceFld.font = [UIFont systemFontOfSize:18.0];
    priceFld.backgroundColor = [UIColor clearColor];
    priceFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    priceFld.autocorrectionType = UITextAutocorrectionTypeNo;
    priceFld.layer.borderWidth = 1.0f;
    priceFld.delegate = self;
    priceFld.userInteractionEnabled = NO;
    
    priceFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    priceFld.placeholder = NSLocalizedString(@" Price Range", nil);
    priceFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:priceFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    brandFld1 = [[UITextField alloc] init];
    brandFld1.borderStyle = UITextBorderStyleRoundedRect;
    brandFld1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    brandFld1.font = [UIFont systemFontOfSize:18.0];
    brandFld1.backgroundColor = [UIColor clearColor];
    brandFld1.clearButtonMode = UITextFieldViewModeWhileEditing;
    brandFld1.autocorrectionType = UITextAutocorrectionTypeNo;
    brandFld1.layer.borderWidth = 1.0f;
    brandFld1.delegate = self;
    brandFld1.userInteractionEnabled = NO;
    
    brandFld1.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    brandFld1.placeholder = NSLocalizedString(@" Brand", nil);
    brandFld1.attributedPlaceholder = [[NSAttributedString alloc]initWithString:brandFld1.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    
    colorFld1 = [[UITextField alloc] init];
    colorFld1.borderStyle = UITextBorderStyleRoundedRect;
    colorFld1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    colorFld1.font = [UIFont systemFontOfSize:18.0];
    colorFld1.backgroundColor = [UIColor clearColor];
    colorFld1.clearButtonMode = UITextFieldViewModeWhileEditing;
    colorFld1.autocorrectionType = UITextAutocorrectionTypeNo;
    colorFld1.layer.borderWidth = 1.0f;
    colorFld1.delegate = self;
    colorFld1.userInteractionEnabled = NO;
    
    colorFld1.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    colorFld1.placeholder = NSLocalizedString(@" Color", nil);
    colorFld1.attributedPlaceholder = [[NSAttributedString alloc]initWithString:colorFld1.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    
    
    sizeFld1 = [[UITextField alloc] init];
    sizeFld1.borderStyle = UITextBorderStyleRoundedRect;
    sizeFld1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    sizeFld1.font = [UIFont systemFontOfSize:18.0];
    sizeFld1.backgroundColor = [UIColor clearColor];
    sizeFld1.clearButtonMode = UITextFieldViewModeWhileEditing;
    sizeFld1.autocorrectionType = UITextAutocorrectionTypeNo;
    sizeFld1.layer.borderWidth = 1.0f;
    sizeFld1.delegate = self;
    sizeFld1.userInteractionEnabled = NO;
    
    sizeFld1.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    sizeFld1.placeholder = NSLocalizedString(@" Size", nil);
    sizeFld1.attributedPlaceholder = [[NSAttributedString alloc]initWithString:sizeFld1.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    
    dlvryDteFld = [[UITextField alloc] init];
    dlvryDteFld.borderStyle = UITextBorderStyleRoundedRect;
    dlvryDteFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    dlvryDteFld.font = [UIFont systemFontOfSize:18.0];
    dlvryDteFld.backgroundColor = [UIColor clearColor];
    dlvryDteFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    dlvryDteFld.autocorrectionType = UITextAutocorrectionTypeNo;
    dlvryDteFld.layer.borderWidth = 1.0f;
    dlvryDteFld.delegate = self;
    dlvryDteFld.userInteractionEnabled = NO;
    
    dlvryDteFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    dlvryDteFld.placeholder = NSLocalizedString(@" Delivery Date", nil);
    dlvryDteFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dlvryDteFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @" HH:mm:ss";
    NSString* currentTime = [f stringFromDate:today];
    
    inTimeFld = [[UITextField alloc] init];
    inTimeFld.borderStyle = UITextBorderStyleRoundedRect;
    inTimeFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    inTimeFld.font = [UIFont systemFontOfSize:18.0];
    inTimeFld.backgroundColor = [UIColor clearColor];
    inTimeFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    inTimeFld.autocorrectionType = UITextAutocorrectionTypeNo;
    inTimeFld.layer.borderWidth = 1.0f;
    inTimeFld.delegate = self;
    inTimeFld.userInteractionEnabled = NO;
    inTimeFld.text = currentTime;
    inTimeFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    inTimeFld.placeholder = NSLocalizedString(@" In Time ", nil);
    inTimeFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:inTimeFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    UIImage *inTmeImg = [UIImage imageNamed:@"arrow_1.png"];
    
    inTmeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [inTmeBtn setBackgroundImage:inTmeImg forState:UIControlStateNormal];
    [inTmeBtn addTarget:self
                 action:@selector(selectTime:) forControlEvents:UIControlEventTouchDown];
    inTmeBtn.tag = 1;
    
    
    
    
    
    outTimeFld = [[UITextField alloc] init];
    outTimeFld.borderStyle = UITextBorderStyleRoundedRect;
    outTimeFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    outTimeFld.font = [UIFont systemFontOfSize:18.0];
    outTimeFld.backgroundColor = [UIColor clearColor];
    outTimeFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    outTimeFld.autocorrectionType = UITextAutocorrectionTypeNo;
    outTimeFld.layer.borderWidth = 1.0f;
    outTimeFld.delegate = self;
    outTimeFld.userInteractionEnabled = NO;
    
    outTimeFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    outTimeFld.placeholder = NSLocalizedString(@" Out Time ", nil);
    outTimeFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:outTimeFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    UIImage *outTmeImg = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * outTmeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [outTmeBtn setBackgroundImage:outTmeImg forState:UIControlStateNormal];
    [outTmeBtn addTarget:self
                  action:@selector(selectTime:) forControlEvents:UIControlEventTouchDown];
    
    
    
    UIImage *indentsImg = [UIImage imageNamed:@"summaryInfo.png"];
    
    UIButton * indentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [indentsBtn setBackgroundImage:indentsImg forState:UIControlStateNormal];
    [indentsBtn addTarget:self
                   action:@selector(summaryInfo) forControlEvents:UIControlEventTouchDown];
    
    UIImage *dobImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    dobBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [dobBtn setBackgroundImage:dobImg forState:UIControlStateNormal];
    [dobBtn addTarget:self
               action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
    dobBtn.tag = 1;
    
    
    UIImage *age = [UIImage imageNamed:@"arrow_1.png"];
    
     ageBttn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [ageBttn setBackgroundImage:age forState:UIControlStateNormal];
    [ageBttn addTarget:self
                action:@selector(CustomerAge) forControlEvents:UIControlEventTouchDown];
    
    
    UIImage *gender = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * gndrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [gndrBtn setBackgroundImage:gender forState:UIControlStateNormal];
    [gndrBtn addTarget:self
                action:@selector(CustomerGender) forControlEvents:UIControlEventTouchDown];
    
    UIImage *dprtmnt = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * dprtmntBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [dprtmntBtn setBackgroundImage:dprtmnt forState:UIControlStateNormal];
    [dprtmntBtn addTarget:self
                   action:@selector(populateCstmrDprtmnt) forControlEvents:UIControlEventTouchDown];
    
    UIImage *brand = [UIImage imageNamed:@"arrow_1.png"];
    
    brandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [brandBtn setBackgroundImage:brand forState:UIControlStateNormal];
    [brandBtn addTarget:self
                 action:@selector(populateBrand:) forControlEvents:UIControlEventTouchDown];
    
    brandBtn.tag  = 1;
    
    UIImage *clr = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * clrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [clrBtn setBackgroundImage:clr forState:UIControlStateNormal];
    [clrBtn addTarget:self
               action:@selector(populateBrandColor:) forControlEvents:UIControlEventTouchDown];
    clrBtn.tag = 2;
    
    UIImage *sizeImg = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * sizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sizeBtn setBackgroundImage:sizeImg forState:UIControlStateNormal];
    [sizeBtn addTarget:self
                action:@selector(populateSize:) forControlEvents:UIControlEventTouchDown];
    sizeBtn.tag = 2;
    
    UIImage *ctgryImg = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * ctgryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [ctgryBtn setBackgroundImage:ctgryImg forState:UIControlStateNormal];
    [ctgryBtn addTarget:self
                 action:@selector(populateCategory) forControlEvents:UIControlEventTouchDown];
    
    UIImage *prceImg = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * pricBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [pricBtn setBackgroundImage:prceImg forState:UIControlStateNormal];
    [pricBtn addTarget:self
                action:@selector(populatePriceRange) forControlEvents:UIControlEventTouchDown];
    
    
    UIImage *brnd1Img = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * brnd1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [brnd1Btn setBackgroundImage:brnd1Img forState:UIControlStateNormal];
    [brnd1Btn addTarget:self
                 action:@selector(populateBrand:) forControlEvents:UIControlEventTouchDown];
    
    UIImage *clrImg = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * clr1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [clr1Btn setBackgroundImage:clrImg forState:UIControlStateNormal];
    [clr1Btn addTarget:self
                action:@selector(populateBrandColor:) forControlEvents:UIControlEventTouchDown];
    clr1Btn.tag = 4;
    
    
    UIImage *sizeImg1 = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * sizeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sizeBtn1 setBackgroundImage:sizeImg1 forState:UIControlStateNormal];
    [sizeBtn1 addTarget:self
                 action:@selector(populateSize:) forControlEvents:UIControlEventTouchDown];
    sizeBtn1.tag = 4;
    
    UIImage *dteImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * dteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [dteBtn setBackgroundImage:dteImg forState:UIControlStateNormal];
    [dteBtn addTarget:self
               action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
    
    
    submitBtn = [[UIButton alloc] init] ;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPresed) forControlEvents:UIControlEventTouchDown];
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    submitBtn.userInteractionEnabled = YES;
    cancelButton.userInteractionEnabled = YES;
    
    
    [walkOutView addSubview:phoneLbl];
    [walkOutView addSubview:phoneNoFld];
    
    [walkOutView addSubview:firstNameLbl];
    [walkOutView addSubview:firstNameFld];
    
    [walkOutView addSubview:emailLbl];
    [walkOutView addSubview:emailFld];
    
    [walkOutView addSubview:lastNameLbl];
    [walkOutView addSubview:lastNameFld];
    
    [walkOutView addSubview:professionLbl];
    [walkOutView addSubview:profsnlFld];
    
    [walkOutView addSubview:ageLbl];
    [walkOutView addSubview:ageFld];
    
    [walkOutView addSubview:dobLbl];
    [walkOutView addSubview:dobFld];
    
    [walkOutView addSubview:genderLbl];
    [walkOutView addSubview:genderFld];
    
    [walkOutView addSubview:verticalLbl];
    
    [walkOutView addSubview:horiaontalLbl];
    [walkOutView addSubview:horizntal1];
    
    [walkOutView addSubview:custmerRjections];
    [walkOutView addSubview:custmrRqrment];
    
    [walkOutView addSubview:streetLbl];
    [walkOutView addSubview:streetFld];
    
    [walkOutView addSubview:localityLbl];
    [walkOutView addSubview:localityFld];
    
    [walkOutView addSubview:cityLbl];
    [walkOutView addSubview:cityFld];
    
    [walkOutView addSubview:pinLbl];
    [walkOutView addSubview:pinFld];
    
    [walkOutView addSubview:departmentLbl];
    [walkOutView addSubview:deprtmntFld];
    
    [walkOutView addSubview:brandLbl];
    [walkOutView addSubview:brandFld];
    
    [walkOutView addSubview:colour];
    [walkOutView addSubview:colourFld];
    
    [walkOutView addSubview:inTimeLbl];
    [walkOutView addSubview:inTimeFld];
    
    
    [walkOutView addSubview:outTimeLbl];
    [walkOutView addSubview:outTimeFld];
    
    
    [walkOutView addSubview:size];
    [walkOutView addSubview:sizeFld];
    
    [walkOutView addSubview:reasonLbl];
    [walkOutView addSubview:reasonFld];
    
    [walkOutView addSubview:categoryLbl];
    [walkOutView addSubview:categoryFld];
    
    [walkOutView addSubview:priceRngLbl];
    [walkOutView addSubview:priceFld];
    
    [walkOutView addSubview:brandLbl1];
    [walkOutView addSubview:brandFld1];
    
    [walkOutView addSubview:colorLbl1];
    [walkOutView addSubview:colorFld1];
    
    [walkOutView addSubview:sizeLbl1];
    [walkOutView addSubview:sizeFld1];
    
    [walkOutView addSubview:dlvryDteLbl];
    [walkOutView addSubview:dlvryDteFld];
    
    [walkOutView addSubview:submitBtn];
    [walkOutView addSubview:cancelButton];
    
    [walkOutView addSubview:indentsBtn];
    [walkOutView addSubview:ageBttn];
    [walkOutView addSubview:gndrBtn];
    [walkOutView addSubview:dprtmntBtn];
    [walkOutView addSubview:brandBtn];
    [walkOutView addSubview:ageBttn];
    [walkOutView addSubview:clrBtn];
    [walkOutView addSubview:sizeBtn];
    [walkOutView addSubview:ctgryBtn];
    [walkOutView addSubview:pricBtn];
    [walkOutView addSubview:brnd1Btn];
    [walkOutView addSubview:clr1Btn];
    [walkOutView addSubview:sizeBtn1];
    [walkOutView addSubview:dteBtn];
    [walkOutView addSubview:inTmeBtn];
    [walkOutView addSubview:outTmeBtn];
    [walkOutView addSubview:reasonBtn];
    
    
    [walkOutView addSubview:dobBtn];
    
    
    
    //    [self.view addSubview:scrollView];
    [self.view addSubview:walkOutView];
    
    
    
    
#pragma mark view frame :
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
       
        
        walkOutView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        verticalLbl.frame = CGRectMake(walkOutView.frame.origin.x+650, walkOutView.frame.origin.y-22, 1, 580);
        
        
        horiaontalLbl.frame = CGRectMake(walkOutView.frame.origin.x+10, walkOutView.frame.origin.y+220, 980, 1);
        
        
        horizntal1.frame = CGRectMake(walkOutView.frame.origin.x+10, walkOutView.frame.origin.y+260, 980, 1);
        
        custmerRjections.frame = CGRectMake(walkOutView.frame.origin.x+130, walkOutView.frame.origin.y+220, 270, 40);
        custmerRjections.font = [UIFont systemFontOfSize:25.0];
        
        
        custmrRqrment.frame = CGRectMake(verticalLbl.frame.origin.x+10, walkOutView.frame.origin.y+220, 300, 40);
        custmrRqrment.font = [UIFont systemFontOfSize:25.0];
        
        
        indentsBtn.frame = CGRectMake(walkOutView.frame.origin.x+955, 5, 40, 40);
        
        phoneLbl.frame = CGRectMake(10, indentsBtn.frame.origin.y+indentsBtn.frame.size.height+5, 120, 40);
        phoneLbl.font = [UIFont systemFontOfSize:20.0];
        
        phoneNoFld.font = [UIFont systemFontOfSize:20];
        phoneNoFld.frame = CGRectMake(phoneLbl.frame.origin.x+phoneLbl.frame.size.width-10, phoneLbl.frame.origin.y, 200, 40);
        
        emailLbl .frame = CGRectMake(phoneLbl.frame.origin.x, phoneLbl.frame.origin.y+phoneLbl.frame.size.height+20, phoneLbl.frame.size.width+10, 40);
        emailLbl.font = [UIFont systemFontOfSize:20.0];
        
        emailFld.font = [UIFont systemFontOfSize:20];
        emailFld.frame = CGRectMake(emailLbl.frame.origin.x+emailLbl.frame.size.width-20, phoneNoFld.frame.origin.y+phoneNoFld.frame.size.height+20, 200, 40);
        
        professionLbl.frame = CGRectMake((emailLbl.frame.origin.x-45), emailLbl.frame.origin.y+emailLbl.frame.size.height+20, emailLbl.frame.size.width+10, 40);
        professionLbl.font = [UIFont systemFontOfSize:20.0];
        
        profsnlFld.font = [UIFont systemFontOfSize:20];
        profsnlFld.frame = CGRectMake(professionLbl.frame.origin.x+professionLbl.frame.size.width+15, emailFld.frame.origin.y+emailFld.frame.size.height+20, 200, 40);
        
        
        dobLbl.frame = CGRectMake(professionLbl.frame.origin.x+45, phoneLbl.frame.origin.y+180, professionLbl.frame.size.width+10, 40);
        dobLbl.font = [UIFont systemFontOfSize:20.0];
        
        dobFld.font = [UIFont systemFontOfSize:20];
        dobFld.frame = CGRectMake(dobLbl.frame.origin.x+dobLbl.frame.size.width-40, profsnlFld.frame.origin.y+profsnlFld.frame.size.height+20, 200, 40);
        
        
        firstNameLbl.frame = CGRectMake((phoneNoFld.frame.origin.x+phoneNoFld.frame.size.width+10), phoneLbl.frame.origin.y, 120, 40);
        firstNameLbl.font = [UIFont systemFontOfSize:20.0];
        
        firstNameFld.font = [UIFont systemFontOfSize:20];
        firstNameFld.frame = CGRectMake(firstNameLbl.frame.origin.x+firstNameLbl.frame.size.width-20, phoneLbl.frame.origin.y, 200, 40);
        
        
        lastNameLbl.frame = CGRectMake((emailFld.frame.origin.x+emailFld.frame.size.width+10),firstNameLbl.frame.origin.y+firstNameLbl.frame.size.height+20, 120, 40);
        lastNameLbl.font = [UIFont systemFontOfSize:20.0];
        
        lastNameFld.font = [UIFont systemFontOfSize:20];
        lastNameFld.frame = CGRectMake((lastNameLbl.frame.origin.x+lastNameLbl.frame.size.width-20), firstNameFld.frame.origin.y+firstNameFld.frame.size.height+20, 200, 40);
        
        
        ageLbl.frame = CGRectMake((profsnlFld.frame.origin.x+profsnlFld.frame.size.width+10), lastNameLbl.frame.origin.y+lastNameLbl.frame.size.height+20, 120, 40);
        ageLbl.font = [UIFont systemFontOfSize:20.0];
        
        ageFld.font = [UIFont systemFontOfSize:20];
        ageFld.frame = CGRectMake((ageLbl.frame.origin.x+ageLbl.frame.size.width-20), lastNameFld.frame.origin.y+lastNameFld.frame.size.height+20, 160, 40);
        
        genderLbl.frame = CGRectMake((dobFld.frame.origin.x+dobFld.frame.size.width+10), ageLbl.frame.origin.y+ageLbl.frame.size.height+20, 160, 40);
        genderLbl.font =[UIFont systemFontOfSize:20];
        
        genderFld.font = [UIFont systemFontOfSize:20];
        genderFld.frame = CGRectMake((genderLbl.frame.origin.x+genderLbl.frame.size.width-60), ageFld.frame.origin.y+ageFld.frame.size.height+20, 160, 40);
        
        departmentLbl.frame = CGRectMake((phoneLbl.frame.origin.x), phoneLbl.frame.origin.y+300, 150, 40);
        departmentLbl.font = [UIFont systemFontOfSize:20.0];
        
        deprtmntFld.font = [UIFont systemFontOfSize:20];
        deprtmntFld.frame = CGRectMake((departmentLbl.frame.origin.x+departmentLbl.frame.size.width-40), phoneLbl.frame.origin.y+300, 200, 40);
        
        brandLbl.frame = CGRectMake((phoneLbl.frame.origin.x), phoneLbl.frame.origin.y+360, 150, 40);
        brandLbl.font = [UIFont systemFontOfSize:20.0];
        
        brandFld.font = [UIFont systemFontOfSize:20];
        brandFld.frame = CGRectMake((brandLbl.frame.origin.x+brandLbl.frame.size.width-40), phoneLbl.frame.origin.y+360, 200, 40);
        
        colour.frame = CGRectMake((phoneLbl.frame.origin.x), phoneLbl.frame.origin.y+420, 150, 40);
        colour.font = [UIFont systemFontOfSize:20.0];
        
        colourFld.font = [UIFont systemFontOfSize:20];
        colourFld.frame = CGRectMake((colour.frame.origin.x+colour.frame.size.width-40), phoneLbl.frame.origin.y+420, 200, 40);
        
        inTimeLbl.frame = CGRectMake(phoneLbl.frame.origin.x, colour.frame.origin.y+colour.frame.size.height+15, 120, 40);
        
        inTimeLbl.font = [UIFont systemFontOfSize:20.0];
        
        inTimeFld.font = [UIFont systemFontOfSize:20];
        inTimeFld.frame = CGRectMake((inTimeLbl.frame.origin.x+inTimeLbl.frame.size.width-10), colourFld.frame.origin.y+colourFld.frame.size.height+15, 200, 40);
        
        
        categoryLbl.frame = CGRectMake((deprtmntFld.frame.origin.x+deprtmntFld.frame.size.width+10), phoneLbl.frame.origin.y+300, 120, 40);
        categoryLbl.font = [UIFont systemFontOfSize:20.0];
        
        categoryFld.font = [UIFont systemFontOfSize:20];
        categoryFld.frame = CGRectMake((categoryLbl.frame.origin.x+categoryLbl.frame.size.width-20), deprtmntFld.frame.origin.y, 200, 40);
        
        
        priceRngLbl.frame = CGRectMake((brandFld.frame.origin.x+brandFld.frame.size.width+10), categoryLbl.frame.origin.y+categoryLbl.frame.size.height+20, 120, 40);
        priceRngLbl.font = [UIFont systemFontOfSize:20.0];
        
        priceFld.font = [UIFont systemFontOfSize:20];
        priceFld.frame = CGRectMake((priceRngLbl.frame.origin.x+priceRngLbl.frame.size.width-20), categoryFld.frame.origin.y+categoryFld.frame.size.height+20, 200, 40);
        
        size.frame = CGRectMake((colourFld.frame.origin.x+colourFld.frame.size.width+10), colour.frame.origin.y, 120, 40);
        size.font = [UIFont systemFontOfSize:20.0];
        
        sizeFld.font = [UIFont systemFontOfSize:20];
        sizeFld.frame = CGRectMake((size.frame.origin.x+size.frame.size.width-20),colourFld.frame.origin.y, 200, 40);
        
        
        
        outTimeLbl.frame = CGRectMake(inTimeFld.frame.origin.x+inTimeFld.frame.size.width+10,inTimeLbl.frame.origin.y , 120, 40);
        
        outTimeLbl.font = [UIFont systemFontOfSize:20.0];
        
        outTimeFld.font = [UIFont systemFontOfSize:20];
        outTimeFld.frame = CGRectMake((outTimeLbl.frame.origin.x+outTimeLbl.frame.size.width-20),inTimeFld.frame.origin.y , 200, 40);
        
        
        
        reasonLbl.frame = CGRectMake((phoneLbl.frame.origin.x), inTimeLbl.frame.origin.y+inTimeLbl.frame.size.height+15, 120, 40);
        reasonLbl.font = [UIFont systemFontOfSize:20.0];
        
        reasonFld.font = [UIFont systemFontOfSize:20];
        reasonFld.frame = CGRectMake((reasonLbl.frame.origin.x+reasonLbl.frame.size.width-10), inTimeFld.frame.origin.y+inTimeFld.frame.size.height+15,(outTimeFld.frame.origin.x +outTimeFld.frame.size.width) - inTimeLbl.frame.origin.x-110,45);
        
        streetLbl.frame = CGRectMake((verticalLbl.frame.origin.x+15), phoneLbl.frame.origin.y, 120, 40);
        streetLbl.font = [UIFont systemFontOfSize:20];
        
        
        streetFld.font = [UIFont systemFontOfSize:20];
        streetFld.frame = CGRectMake((streetLbl.frame.origin.x+streetLbl.frame.size.width+5), phoneLbl.frame.origin.y, 200, 40);
        
        localityLbl.frame = CGRectMake((verticalLbl.frame.origin.x+15), phoneLbl.frame.origin.y+60, 120, 40);
        localityLbl.font = [UIFont systemFontOfSize:20];
        
        localityFld.font = [UIFont systemFontOfSize:20];
        localityFld.frame = CGRectMake((localityLbl.frame.origin.x+125), lastNameFld.frame.origin.y, 200, 40);
        
        cityLbl.frame = CGRectMake((verticalLbl.frame.origin.x+15), ageFld.frame.origin.y, 120, 40);
        cityLbl.font = [UIFont systemFontOfSize:20.0];
        
        cityFld.font = [UIFont systemFontOfSize:20];
        cityFld.frame = CGRectMake((cityLbl.frame.origin.x+cityLbl.frame.size.width+5), phoneLbl.frame.origin.y+120, 200, 40);
        
        pinLbl.frame = CGRectMake((verticalLbl.frame.origin.x+15), phoneLbl.frame.origin.y+180, 120, 40);
        pinLbl.font = [UIFont systemFontOfSize:20.0];
        
        pinFld.font = [UIFont systemFontOfSize:20];
        pinFld.frame = CGRectMake((pinLbl.frame.origin.x+pinLbl.frame.size.width+5), phoneLbl.frame.origin.y+180, 200, 40);
        
        brandLbl1.frame = CGRectMake((verticalLbl.frame.origin.x+15), categoryLbl.frame.origin.y, 120, 40);
        brandLbl1.font = [UIFont systemFontOfSize:20.0];
        
        brandFld1.font = [UIFont systemFontOfSize:20];
        brandFld1.frame = CGRectMake((brandLbl1.frame.origin.x+125), categoryFld.frame.origin.y, 200, 40);
        
        
        colorLbl1.frame = CGRectMake((verticalLbl.frame.origin.x+15), priceRngLbl.frame.origin.y, 120, 40);
        colorLbl1.font = [UIFont systemFontOfSize:20.0];
        
        colorFld1.font = [UIFont systemFontOfSize:20];
        colorFld1.frame = CGRectMake((colorLbl1.frame.origin.x+colorLbl1.frame.size.width+5), priceRngLbl.frame.origin.y, 200, 40);
        
        
        sizeLbl1.frame = CGRectMake((verticalLbl.frame.origin.x+15), size.frame.origin.y, 120, 40);
        sizeLbl1.font = [UIFont systemFontOfSize:20.0];
        
        sizeFld1.font = [UIFont systemFontOfSize:20];
        sizeFld1.frame = CGRectMake((sizeLbl1.frame.origin.x+sizeLbl1.frame.size.width+5), sizeFld.frame.origin.y, 200, 40);
        
        
        dlvryDteLbl.frame = CGRectMake((verticalLbl.frame.origin.x+15), outTimeLbl.frame.origin.y, 120, 40);
        dlvryDteLbl.font = [UIFont systemFontOfSize:20.0];
        
        dlvryDteFld.font = [UIFont systemFontOfSize:20];
        dlvryDteFld.frame = CGRectMake((dlvryDteLbl.frame.origin.x+dlvryDteLbl.frame.size.width+5), outTimeLbl.frame.origin.y, 200, 40);
        
        submitBtn.frame = CGRectMake(walkOutView.frame.origin.x+220, reasonFld.frame.origin.y+reasonFld.frame.size.height+20,200.0f, 45);
        submitBtn.layer.cornerRadius = 4.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:26.0];
        
        cancelButton.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+220, reasonFld.frame.origin.y+reasonFld.frame.size.height+20,200, 45);
        cancelButton.layer.cornerRadius = 4.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:26.0];
        
        ageBttn.frame = CGRectMake((ageFld.frame.origin.x+ageFld.frame.size.width-45), ageFld.frame.origin.y-8, 50, 55);
        
        gndrBtn.frame = CGRectMake((genderFld.frame.origin.x+genderFld.frame.size.width-45), genderFld.frame.origin.y-8, 50, 55);
        
        dprtmntBtn.frame = CGRectMake((deprtmntFld.frame.origin.x+deprtmntFld.frame.size.width-45), deprtmntFld.frame.origin.y-8, 50, 55);
        
        
        brandBtn.frame = CGRectMake((brandFld.frame.origin.x+brandFld.frame.size.width-45), brandFld.frame.origin.y-8, 50, 55);
        
        clrBtn.frame = CGRectMake((colourFld.frame.origin.x+colourFld.frame.size.width-45), colourFld.frame.origin.y-8, 50, 55);
        
        sizeBtn.frame = CGRectMake((sizeFld.frame.origin.x+sizeFld.frame.size.width-45), sizeFld.frame.origin.y-8, 50, 55);
        
        ctgryBtn.frame = CGRectMake((categoryFld.frame.origin.x+categoryFld.frame.size.width-45), categoryFld.frame.origin.y-8, 50, 55);
        pricBtn.frame = CGRectMake((priceFld.frame.origin.x+priceFld.frame.size.width-45), priceFld.frame.origin.y-8, 50, 55);
        
        brnd1Btn.frame = CGRectMake((brandFld1.frame.origin.x+brandFld1.frame.size.width-45), brandFld1.frame.origin.y-8, 50, 55);
        clr1Btn.frame = CGRectMake((colorFld1.frame.origin.x+colorFld1.frame.size.width-45), colorFld1.frame.origin.y-8, 50, 55);
        
        sizeBtn1.frame = CGRectMake((sizeFld1.frame.origin.x+sizeFld1.frame.size.width-45), sizeFld1.frame.origin.y-8, 50, 55);
        
        dteBtn.frame = CGRectMake((dlvryDteFld.frame.origin.x+dlvryDteFld.frame.size.width-45), dlvryDteFld.frame.origin.y+2, 40, 35);
        
        dobBtn.frame = CGRectMake((dobFld.frame.origin.x+dobFld.frame.size.width-45), dobFld.frame.origin.y+2, 40, 35);
        
        
        inTmeBtn.frame = CGRectMake((inTimeFld.frame.origin.x+inTimeFld.frame.size.width-45), inTimeFld.frame.origin.y-8, 50, 55);
        
        
        outTmeBtn.frame = CGRectMake((outTimeFld.frame.origin.x+outTimeFld.frame.size.width-45), outTimeFld.frame.origin.y-8, 50, 55);
        
        
        reasonBtn.frame = CGRectMake((reasonFld.frame.origin.x+reasonFld.frame.size.width-45), reasonFld.frame.origin.y-8, 50, 55);
        
    }
    else {
        
    }

    sizeTbl = [[UITableView alloc] init];
    sizeTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    sizeTbl.dataSource = self;
    sizeTbl.delegate = self;
    (sizeTbl.layer).borderWidth = 1.0f;
    sizeTbl.layer.cornerRadius = 3;
    sizeTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    colorTbl = [[UITableView alloc] init];
    colorTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    colorTbl.dataSource = self;
    colorTbl.delegate = self;
    (colorTbl.layer).borderWidth = 1.0f;
    colorTbl.layer.cornerRadius = 3;
    colorTbl.layer.borderColor = [UIColor grayColor].CGColor;
    

}








#pragma mark getCustomerDetails Method :

// Commented by roja on 17/10/2019.. // reason getCustomerDetails method contains SOAP Service call .. so taken new method with same(getCustomerDetails) method name which contains REST service call....
// At the time of converting SOAP call's to REST
//-(void)getCustomerDetails {
//
//    // PhoNumber validation...
//    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
//    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
//    BOOL isNumber = [decimalTest evaluateWithObject:phoneNoFld.text];
//
//    if((phoneNoFld.text).length <= 9 || (phoneNoFld.text).length >= 12 || !isNumber) {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        return;
//
//    }
//
//
//    @try {
//
//        BOOL status = FALSE;
//
//        CheckWifi *wifi = [CheckWifi new];
//
//        status = [wifi checkWifi];
//
//
//        if (status) {
//
//
//            // showing the HUD ..
//            [HUD show:YES];
//            [HUD setHidden:NO];
//
//            //checking for deals & offers...
//            CustomerServiceSoapBinding *custBindng =  [CustomerServiceSvc CustomerServiceSoapBinding] ;
//            CustomerServiceSvc_getCustomerDetails *aParameters = [[CustomerServiceSvc_getCustomerDetails alloc] init];
//
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:[RequestHeader getRequestHeader] options:0 error:&err];
//            NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//
//            NSArray *loyaltyKeys = @[CUSTOMER_EMAIL, @"mobileNumber",REQUEST_HEADER];
//
//            NSArray *loyaltyObjects = @[@"",phoneNoFld.text,requestHeaderString];
//            NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
//            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//            aParameters.phone = loyaltyString;
//
//
//            CustomerServiceSoapBindingResponse *response = [custBindng getCustomerDetailsUsingParameters:(CustomerServiceSvc_getCustomerDetails *)aParameters];
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[CustomerServiceSvc_getCustomerDetailsResponse class]]) {
//                    CustomerServiceSvc_getCustomerDetailsResponse *body = (CustomerServiceSvc_getCustomerDetailsResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    NSError *e;
//
//                    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                          options: NSJSONReadingMutableContainers
//                                                                            error: &e];
//
//                    NSDictionary *dictionary = [JSON1 valueForKey:RESPONSE_HEADER];
//
//                    if ([[dictionary valueForKey:RESPONSE_CODE] intValue] == -1) {
//
//                        emailFld.text = @"";
//                        firstNameFld.text = @"";
//                        streetFld.text = @"";
//                        localityFld.text = @"";
//                        cityFld.text = @"";
//                        pinFld.text = @"";
//                        profsnlFld.text = @"";
//
//
//                    }
//
//                    else {
//
//                        if (![JSON1[CUSTOMER_PHONE] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_PHONE] length] > 0) {
//                            phoneNoFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_PHONE]];
//                        }
//                        else{
//                            phoneNoFld.text = @"";
//                        }
//                        if (![JSON1[CUSTOMER_MAIL] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_MAIL] length] > 0) {
//                            emailFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_MAIL]];
//
//                        }
//                        else {
//                            emailFld.text = @"";
//
//                        }
//                        if (![JSON1[@"name"] isKindOfClass:[NSNull class]]&& [JSON1[@"name"] length] > 0) {
//                            firstNameFld.text = [NSString stringWithFormat:@"%@",JSON1[@"name"]];
//                        }
//                        else {
//                            firstNameFld.text = @"";
//                        }
//                        if (![JSON1[CUSTOMER_STREET] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_STREET] length] > 0) {
//                            streetFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_STREET]];
//                        }
//                        else{
//                            streetFld.text = @"";
//                        }
//                        if (![JSON1[CUSTOMER_LOCALITY] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_LOCALITY] length] > 0) {
//                            localityFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_LOCALITY]];
//                        }
//                        else {
//                            localityFld.text = @"";
//
//                        }
//                        if (![JSON1[CUSTOMER_CITY] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_CITY] length] > 0) {
//                            cityFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_CITY]];
//                        }
//                        else {
//
//                            cityFld.text = @"";
//                        }
//                        if (![JSON1[CUSTOMER_PIN_NO] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_PIN_NO] length] > 0) {
//                            pinFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_PIN_NO]];
//                        }
//                        else {
//
//                            pinFld.text = @"";
//                        }
//
//                        if (![JSON1[CUSTOMER_AGE] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_AGE] integerValue]!=  0) {
//
//                            ageFld.text = [NSString stringWithFormat:@"%i",[[JSON1 valueForKey:CUSTOMER_AGE] integerValue]];
//                        }
//                        else {
//
//                            ageFld.text = @"";
//                        }
//
//
//                        if (![JSON1[CUSTOMER_DESIGNATION] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_DESIGNATION] length] > 0) {
//                            profsnlFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_DESIGNATION]];
//                        }
//                        else {
//
//                            profsnlFld.text = @"";
//                        }
//
//
//                        if (![JSON1[CUSTOMER_GENDER] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_GENDER] length] > 0) {
//                            genderFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_GENDER]];
//                        }
//                        else {
//
//                            genderFld.text = @"";
//                        }
//                        if (![JSON1[CUSTOMER_LAST_NAME] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_LAST_NAME] length] > 0) {
//                            lastNameFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_LAST_NAME]];
//                        }
//                        else {
//
//                            lastNameFld.text = @"";
//                        }
//
//                        if (![JSON1[CUSTOMER_REASON] isKindOfClass:[NSNull class]]&& [JSON1[CUSTOMER_REASON] length] > 0) {
//                            reasonFld.text = [NSString stringWithFormat:@"%@",JSON1[CUSTOMER_REASON]];
//                        }
//                        else {
//
//                            reasonFld.text = @"";
//                        }
//
//
//                    }
//
//
//                }
//
//                [HUD setHidden:YES];
//            }
//        }
//    } @catch (NSException *exception) {
//
//        NSLog(@"%@",exception);
//
//    } @finally {
//
//
//    }
//
//
//}


//getCustomerDetails method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

-(void)getCustomerDetails {
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:phoneNoFld.text];
    
    if((phoneNoFld.text).length <= 9 || (phoneNoFld.text).length >= 12 || !isNumber) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    
    @try {
        
        BOOL status = FALSE;
        
        CheckWifi *wifi = [CheckWifi new];
        status = [wifi checkWifi];
        
        if (status) {
            
            // showing the HUD ..
            [HUD show:YES];
            [HUD setHidden:NO];
            
            //checking for deals & offers...
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:[RequestHeader getRequestHeader] options:0 error:&err];
            NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            
            NSArray *loyaltyKeys = @[CUSTOMER_EMAIL, @"mobileNumber",REQUEST_HEADER];
            
            NSArray *loyaltyObjects = @[@"",phoneNoFld.text,requestHeaderString];
            NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController *services = [[WebServiceController alloc] init];
            services.customerServiceDelegate = self;
            [services getCustomerDetails:loyaltyString];
            
        }
    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // Old code only added here...
- (void)getCustomerDetailsSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        if (![sucessDictionary[CUSTOMER_PHONE] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_PHONE] length] > 0) {
            phoneNoFld.text = [NSString stringWithFormat:@"%@",sucessDictionary[CUSTOMER_PHONE]];
        }
        else{
            phoneNoFld.text = @"";
        }
        if (![sucessDictionary[CUSTOMER_MAIL] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_MAIL] length] > 0) {
            emailFld.text = [NSString stringWithFormat:@"%@",sucessDictionary[CUSTOMER_MAIL]];
            
        }
        else {
            emailFld.text = @"";
            
        }
        if (![sucessDictionary[@"name"] isKindOfClass:[NSNull class]]&& [sucessDictionary[@"name"] length] > 0) {
            firstNameFld.text = [NSString stringWithFormat:@"%@",sucessDictionary[@"name"]];
        }
        else {
            firstNameFld.text = @"";
        }
        if (![sucessDictionary[CUSTOMER_STREET] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_STREET] length] > 0) {
            streetFld.text = [NSString stringWithFormat:@"%@",sucessDictionary[CUSTOMER_STREET]];
        }
        else{
            streetFld.text = @"";
        }
        if (![sucessDictionary[CUSTOMER_LOCALITY] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_LOCALITY] length] > 0) {
            localityFld.text = [NSString stringWithFormat:@"%@", sucessDictionary[CUSTOMER_LOCALITY]];
        }
        else {
            localityFld.text = @"";
            
        }
        if (![sucessDictionary[CUSTOMER_CITY] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_CITY] length] > 0) {
            cityFld.text = [NSString stringWithFormat:@"%@", sucessDictionary[CUSTOMER_CITY]];
        }
        else {
            
            cityFld.text = @"";
        }
        if (![sucessDictionary[CUSTOMER_PIN_NO] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_PIN_NO] length] > 0) {
            pinFld.text = [NSString stringWithFormat:@"%@", sucessDictionary[CUSTOMER_PIN_NO]];
        }
        else {
            
            pinFld.text = @"";
        }
        
        if (![sucessDictionary[CUSTOMER_AGE] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_AGE] integerValue]!=  0) {
            
            ageFld.text = [NSString stringWithFormat:@"%li",(long)[[sucessDictionary valueForKey:CUSTOMER_AGE] integerValue]];
        }
        else {
            
            ageFld.text = @"";
        }
        
        
        if (![sucessDictionary[CUSTOMER_DESIGNATION] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_DESIGNATION] length] > 0) {
            profsnlFld.text = [NSString stringWithFormat:@"%@",sucessDictionary[CUSTOMER_DESIGNATION]];
        }
        else {
            
            profsnlFld.text = @"";
        }
        
        
        if (![sucessDictionary[CUSTOMER_GENDER] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_GENDER] length] > 0) {
            genderFld.text = [NSString stringWithFormat:@"%@", sucessDictionary[CUSTOMER_GENDER]];
        }
        else {
            
            genderFld.text = @"";
        }
        if (![sucessDictionary[CUSTOMER_LAST_NAME] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_LAST_NAME] length] > 0) {
            lastNameFld.text = [NSString stringWithFormat:@"%@",sucessDictionary[CUSTOMER_LAST_NAME]];
        }
        else {
            
            lastNameFld.text = @"";
        }
        
        if (![sucessDictionary[CUSTOMER_REASON] isKindOfClass:[NSNull class]]&& [sucessDictionary[CUSTOMER_REASON] length] > 0) {
            reasonFld.text = [NSString stringWithFormat:@"%@", sucessDictionary[CUSTOMER_REASON]];
        }
        else {
            
            reasonFld.text = @"";
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}

// added by Roja on 17/10/2019…. // Old code only added here..
- (void)getCustomerDetailsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        emailFld.text = @"";
        firstNameFld.text = @"";
        streetFld.text = @"";
        localityFld.text = @"";
        cityFld.text = @"";
        pinFld.text = @"";
        profsnlFld.text = @"";
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}



#pragma mark getCategories :

-(void)getCategories {
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        categoriesArr = [NSMutableArray new];

        NSArray *keys = @[@"requestHeader",@"startIndex",@"categoryName",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",@"",[NSNumber numberWithBool:true]];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * categoriesJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getProductCategory:categoriesJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    
}


-(void)getCategorySuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        for(NSDictionary *dic in [sucessDictionary valueForKey:@"categories"]){
            
            [categoriesArr addObject:dic];
        }
        
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        [HUD setHidden: YES];
    }
    
    
    
    
}
-(void)getCategoryErrorResponse:(NSString*)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Categories Found" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    [HUD setHidden:YES];
}


#pragma mark getDepartmentList :

-(void)callingDepartmentList {
    @try {
        [HUD show: YES];
        
        [HUD setHidden:NO];
        
        departmentArr = [NSMutableArray new];

        NSArray *keys = @[@"requestHeader",@"startIndex",@"noOfSubDepartments",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",[NSNumber numberWithBool:true],[NSNumber numberWithBool:true]];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * departmentJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getDepartmentList:departmentJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}

-(void)getDepartmentSuccessResponse:(NSDictionary*)sucessDictionary{
    @try {
        
        for (NSDictionary * department in  [sucessDictionary valueForKey: @"departments" ]) {
            
            
            [departmentArr addObject:department];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden: YES];
    }
    
    
}
-(void)getDepartmentErrorResponse:(NSString*)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Departments Found" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    [HUD setHidden:YES];
    
}


#pragma mark getBrandList :

-(void)callingBrandList {
    @try {
        [HUD show: YES];
        
        [HUD setHidden:NO];
        
        brandListArr  = [NSMutableArray new];
        NSArray *keys = @[@"requestHeader",@"startIndex",@"bName",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",@"", [NSNumber numberWithBool:true]];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * brandListJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getBrandList:brandListJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}

-(void)getBrandMasterSuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        
        for (NSDictionary * brand in  [sucessDictionary valueForKey: @"brandDetails" ]) {
            
            
            [brandListArr addObject:brand];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
    
    
}
-(void)getBrandMasterErrorResponse:(NSString*)error {
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Products Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
    
    [HUD setHidden:YES];
    
}







-(void)summaryInfo {
    @try {
        AudioServicesPlaySystemSound(_soundFileObject);
        
        NSLog(@"Click Button" );
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(void)CustomerAge {
    
    @try {
        AudioServicesPlaySystemSound(_soundFileObject);
        ageArr = [[NSMutableArray alloc] init];
        for (int i=1; i<=100; i++){
            [ageArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 140,100)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        ageTbl = [[UITableView alloc] init];
        ageTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        ageTbl.dataSource = self;
        ageTbl.delegate = self;
        (ageTbl.layer).borderWidth = 1.0f;
        ageTbl.layer.cornerRadius = 3;
        ageTbl.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            ageTbl.frame = CGRectMake(0, 0, ageFld.frame.size.width+30, ageFld.frame.size.height+60);
            
        }
        [customView addSubview:ageTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:ageBttn.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            
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
        
        [ageTbl reloadData];
        
        
    }
    @catch (NSException *exception) {
        
    }
    
}

-(void)CustomerGender {
    
    @try {
        AudioServicesPlaySystemSound(_soundFileObject);
        
        genderArr = [[NSMutableArray alloc]init];
        [genderArr addObject:@"Male"];
        [genderArr addObject:@"Female"];
        

        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 180,120)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        genderTbl = [[UITableView alloc] init];
        genderTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        genderTbl.dataSource = self;
        genderTbl.delegate = self;
        (genderTbl.layer).borderWidth = 1.0f;
        genderTbl.layer.cornerRadius = 3;
        genderTbl.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            genderTbl.frame = CGRectMake(0, 0, genderFld.frame.size.width+40, genderFld.frame.size.height+80);

        }
        [customView addSubview:genderTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:genderFld.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        [genderTbl reloadData];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        
        [genderTbl reloadData];
    }
}

-(void)populateCstmrDprtmnt {
    @try {
        
        AudioServicesPlaySystemSound(_soundFileObject);
        
        [self callingDepartmentList];
        
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200,120)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        deprtmntTbl = [[UITableView alloc] init];
        deprtmntTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        deprtmntTbl.dataSource = self;
        deprtmntTbl.delegate = self;
        (deprtmntTbl.layer).borderWidth = 1.0f;
        deprtmntTbl.layer.cornerRadius = 3;
        deprtmntTbl.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            deprtmntTbl.frame = CGRectMake(0, 0, deprtmntFld.frame.size.width+40, deprtmntFld.frame.size.height+100);
            
        }
        
        
        [customView addSubview:deprtmntTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:deprtmntFld.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [deprtmntTbl reloadData];
    }
    
    
}


-(void)populateBrand:(UIButton *)sender  {
    
    @try {
        AudioServicesPlaySystemSound(_soundFileObject);
        
        
        [self callingBrandList];
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200,120)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        brandTbl = [[UITableView alloc] init];
        brandTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        brandTbl.dataSource = self;
        brandTbl.delegate = self;
        (brandTbl.layer).borderWidth = 1.0f;
        brandTbl.layer.cornerRadius = 3;
        brandTbl.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            brandTbl.frame = CGRectMake(0, 0, brandFld.frame.size.width+40, brandFld.frame.size.height+100);
            
            
        }
        
        
        [customView addSubview:brandTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            
            if (sender.tag == 1) {
                brandFld.tag = sender.tag;
                brandFld1.tag = 0;
                
                [popover presentPopoverFromRect:brandFld.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
                
            } else {
                brandFld1.tag = sender.tag;
                brandFld.tag = 0;
                
                [popover presentPopoverFromRect:brandFld1.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
                
            }
            catPopOver = popover;
            
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
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [brandTbl reloadData];
        
    }
    
}



-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view {
    
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
            
            [popover presentPopoverFromRect:textView.frame inView:view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            
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
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [tableName reloadData];
        
    }
    
}





-(void)populateSize:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(_soundFileObject);
    
    @try {
        
        
        colourFld.tag = 0;
        colorFld1.tag = 0;
        
        sizeFld.tag = sender.tag;
        sizeFld1.tag = sender.tag;
        
        //        if (![catPopOver isPopoverVisible]){
        if(sizeArr == nil ||  sizeArr.count == 0){
            [HUD setHidden:NO];
            [self callingSizeAndColors];
            
        }
        
        
        if(sizeArr.count){
            float tableHeight = sizeArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = sizeArr.count * 30;
            
            if(sizeArr.count < 5)
                tableHeight = (tableHeight/sizeArr.count) * 3;
            
            
            if(sender.tag == 2){
                [self showPopUpForTables:sizeTbl  popUpWidth:sizeFld.frame.size.width  popUpHeight:tableHeight presentPopUpAt:sizeFld  showViewIn:walkOutView];
            }
            else{
                [self showPopUpForTables:sizeTbl  popUpWidth:sizeFld1.frame.size.width  popUpHeight:tableHeight presentPopUpAt:sizeFld1  showViewIn:walkOutView];
                
                
            }
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the stockReceiptView in showAllOutletId:----%@",exception);
        
    }
}

-(void)populateBrandColor:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(_soundFileObject);
    
    @try {
        
        
        colourFld.tag = sender.tag;
        colorFld1.tag = sender.tag;
        
        sizeFld.tag = 0;
        sizeFld1.tag = 0;
        
        //        if (![catPopOver isPopoverVisible]){
        if(colorArr == nil ||  colorArr.count == 0){
            [HUD setHidden:NO];
            [self callingSizeAndColors];
            
        }
        
        
        if(colorArr.count){
            float tableHeight = colorArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = colorArr.count * 30;
            
            if(colorArr.count < 5)
                tableHeight = (tableHeight/colorArr.count) * 5;
            
            
            if(sender.tag == 2){
                [self showPopUpForTables:colorTbl  popUpWidth:colourFld.frame.size.width  popUpHeight:tableHeight presentPopUpAt:colourFld  showViewIn:walkOutView];
            }
            else{
                [self showPopUpForTables:colorTbl  popUpWidth:colorFld1.frame.size.width  popUpHeight:tableHeight presentPopUpAt:colorFld1  showViewIn:walkOutView];
                
                
            }
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the stockReceiptView in showAllOutletId:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
}

-(void)populateCategory {
    
    @try {
        
        [self getCategories];
        
        AudioServicesPlaySystemSound(_soundFileObject);
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 190,120)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        categoryTbl = [[UITableView alloc] init];
        categoryTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        categoryTbl.dataSource = self;
        categoryTbl.delegate = self;
        (categoryTbl.layer).borderWidth = 1.0f;
        categoryTbl.layer.cornerRadius = 3;
        categoryTbl.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            categoryTbl.frame = CGRectMake(0, 0, genderFld.frame.size.width+40, genderFld.frame.size.height+100);
            
            
        }
        
        
        [customView addSubview:categoryTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:categoryFld.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        [categoryTbl reloadData];
     }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
-(void)populatePriceRange {
    @try {
        AudioServicesPlaySystemSound(_soundFileObject);
        
        NSLog(@"Click Button" );
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}

-(void)populateReason {
    @try {
        AudioServicesPlaySystemSound(_soundFileObject);
        
        reasonArr = [[NSMutableArray alloc]init];
        [reasonArr addObject:@" No Matching Size"];
        [reasonArr addObject:@" No Matching Color"];
        [reasonArr addObject:@" No Matching Product"];
        [reasonArr addObject:@" No Matching Brand"];
        [reasonArr addObject:@" Price High"];
        [reasonArr addObject:@" Casual WalkIn"];
        [reasonArr addObject:@" Willing to shop Later"];

        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200,180)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        reasonTbl = [[UITableView alloc] init];
        reasonTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        reasonTbl.dataSource = self;
        reasonTbl.delegate = self;
        (reasonTbl.layer).borderWidth = 1.0f;
        reasonTbl.layer.cornerRadius = 3;
        reasonTbl.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            reasonTbl.frame = CGRectMake(0, 0, reasonFld.frame.size.width-20, reasonFld.frame.size.height+140);
            
            
        }
        
        
        [customView addSubview:reasonTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:reasonFld.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            // popover.contentViewController.view.alpha = 0.0;
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            catPopOver = popover;
            
        }
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        [reasonTbl reloadData];

        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}



-(void) selectDate:(UIButton *) sender{
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (_soundFileObject);
    
    [catPopOver dismissPopoverAnimated:YES];
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    
    pickView = [[UIView alloc] init];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(15, dlvryDteFld.frame.origin.y+dlvryDteFld.frame.size.height, 320, 320);
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
    myPicker.datePickerMode = UIDatePickerModeDate;
    
    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
    pickButton.frame = CGRectMake(110, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        if (sender.tag == 1) {
            [popover presentPopoverFromRect:dobBtn.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            
            dlvryDteFld.tag = 0;
            
        } else {
            
            [popover presentPopoverFromRect:dlvryDteFld.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
            dlvryDteFld.tag = 2;
            
            
        }
        catPopOver = popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        catPopOver = popover;
        
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
}

-(void)getDate:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (_soundFileObject);
    
    [catPopOver dismissPopoverAnimated:YES];
    //Date Formate Setting...
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    sdayFormat.dateFormat = @"dd/MM/yyyy";
    NSString *dateString1 = [sdayFormat stringFromDate:myPicker.date];
    
    NSComparisonResult result = [myPicker.date compare:[NSDate date]];
    
    if (dlvryDteFld.tag == 2) {
        
        if(result == NSOrderedAscending) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Date Selection" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    else {
        
        if(result == NSOrderedDescending) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Date Selection" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    
    
    
    if(dlvryDteFld.tag == 2)    {
        
        dlvryDteFld.text = dateString1;
    }
    else
        dobFld.text = dateString1;
    
}


- (void)selectTime:(UIButton *)sender {
    @try {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (_soundFileObject);
        
        [catPopOver dismissPopoverAnimated:YES];
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        
        pickView = [[UIView alloc] init];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            pickView.frame = CGRectMake(15, dlvryDteFld.frame.origin.y+dlvryDteFld.frame.size.height, 320, 320);
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
        
        pickButton.frame = CGRectMake(110, 269, 100, 45);
        pickButton.backgroundColor = [UIColor clearColor];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(getTime) forControlEvents:UIControlEventTouchUpInside];
        pickButton.layer.borderColor = [UIColor blackColor].CGColor;
        pickButton.layer.borderWidth = 0.5f;
        pickButton.layer.cornerRadius = 12;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            if (sender.tag == 1) {
                [popover presentPopoverFromRect:inTimeFld.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
                
                inTimeFld.tag = 1;
                
            } else {
                
                [popover presentPopoverFromRect:outTimeFld.frame inView:walkOutView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
                
                inTimeFld.tag = 2;
                
                
            }
            catPopOver = popover;
            
        }
        
        else {
            
            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            catPopOver = popover;
            
        }
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}


- (void)getTime {
    @try {
        
        AudioServicesPlaySystemSound (_soundFileObject);
        
        [catPopOver dismissPopoverAnimated:YES];
        //Date Formate Setting...
        NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
        sdayFormat.dateFormat = @"HH:mm:ss";
        NSString *dateString = [sdayFormat stringFromDate:myPicker.date];
        
        NSComparisonResult result = [myPicker.date compare:[NSDate date]];
        
        if(result == NSOrderedAscending) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Invalid Time Selection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        if(inTimeFld.tag == 1)    {
            
            inTimeFld.text = dateString;
        }
        else
            outTimeFld.text = dateString;
 
        
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        
        
    }
    
}



- (void)submitButtonPresed {
    @try {
        AudioServicesPlaySystemSound(_soundFileObject);
        
        
        if  ((reasonFld.text).length == 0 || (phoneNoFld.text).length==0)  {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please fill required data  " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            
        }
        
        
        else {
            [HUD setHidden: NO];
            
            NSMutableDictionary * customerDic = [NSMutableDictionary new];
            
            NSString *dobStr = dobFld.text;
            
            if((dobFld.text).length > 0)
                dobStr =  [NSString stringWithFormat:@"%@%@", dobFld.text,@" 00:00:00"];
            
            NSString * deliveryDteStr  = dlvryDteFld.text;
            
            if ((dlvryDteFld.text).length>0) {
                deliveryDteStr = [NSString stringWithFormat:@"%@%@",dlvryDteFld.text,@" 00:00:00"];
            }
            
            [customerDic   setValue:[NSNumber numberWithInt:(ageFld.text).integerValue] forKey:CUSTOMER_AGE];
            [customerDic   setValue:cityFld.text forKey:CUSTOMER_CITY];
//            [customerDic   setValue:dobFld.text forKey:CUSTOMER_DOB];
            [customerDic   setValue:emailFld.text forKey:CUSTOMER_EMAIL];
            [customerDic   setValue:lastNameFld.text forKey:CUSTOMER_LAST_NAME];
            [customerDic   setValue:firstNameFld.text forKey:@"name"];
            
            [customerDic   setValue:localityFld.text forKey:CUSTOMER_LOCALITY];
            [customerDic   setValue:@NO forKey:CUSTOMER_NOTIFICATIONS];
            [customerDic   setValue:pinFld.text
                             forKey:CUSTOMER_PIN_NO];
            [customerDic   setValue:@NO forKey:CUSTOMER_STATUS];
            [customerDic   setValue:streetFld.text forKey:CUSTOMER_STREET];
            [customerDic   setValue:@" " forKey:CUSTOMER_REFERAL];
            [customerDic   setValue:phoneNoFld.text forKey:CUSTOMER_PHONE];
            
            [NSNumber numberWithInt:(ageFld.text).integerValue];
            
            
            NSArray *keys = @[CUSTOMER_CUSTOMEROBJ,REQUEST_HEADER,CUSTOMER_DELIVERYDATE,CUSTOMER_DEPARTMENT,CUSTOMER_BRAND,CUSTOMER_CATEGORY,CUSTOMER_COLOR,CUSTOMER_SIZE,CUSTOMER_REASON,kWalkInTime,kWalkOutTime,CUSTOMER_DOB,kRequiredColor,kRequiredSize,kRequiredBrand];
            NSArray *objects = @[customerDic, [RequestHeader getRequestHeader],deliveryDteStr,deprtmntFld.text,brandFld.text,categoryFld.text,colourFld.text,sizeFld.text,reasonFld.text,inTimeFld.text,outTimeFld.text,dobStr,colorFld1.text,sizeFld1.text,brandFld1.text];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            
            
            NSString * walkOutJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"------%@",walkOutJsonString);
            WebServiceController *webServiceController = [WebServiceController new];
            webServiceController.customerWalkoutDelegate = self;
            [webServiceController createCustomerWalkOutWithData:jsonData];
            
            
        }
        
        
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:ERROR delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    @finally {
        
        
    }
    
}


-(void)CreateCustomerWalkOutSuccessResponse:(NSDictionary*)sucessDictionary{
    
    @try {
        
    
      
        if (sucessDictionary!=NULL) {
        
        if (![sucessDictionary[RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[sucessDictionary[RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
            

    
//    NSString *walkOut = [sucessDictionary
//                           objectForKey:@"slno"];
//    walkout = [walkOut copy];
    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
    successAlertView.delegate = self;
    successAlertView.title = @"Walkout Created Successfully";
//    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"slno: ",walkOut]];
    [successAlertView addButtonWithTitle:@" NEW "];
    
    [successAlertView show];
    
    [HUD setHidden:YES];
    SystemSoundID    soundFileObject1;
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (_soundFileURLRef,&soundFileObject1);
    AudioServicesPlaySystemSound (soundFileObject1);
            
            emailFld.text = @"";
            firstNameFld.text = @"";
            lastNameFld.text = @"";
            genderFld.text = @"";
            streetFld.text = @"";
            localityFld.text = @"";
            ageFld.text = @"";
            brandFld.text = @"";
            cityFld.text = @"";
            pinFld.text = @"";
            profsnlFld.text = @"";
            phoneNoFld.text = @"";
            deprtmntFld.text = @"";
            reasonFld.text = @"";
            categoryFld.text = @"";
            outTimeFld.text = @"";
            dlvryDteFld.text = @"";
    
}
else {
    SystemSoundID    soundFileObject1;
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (_soundFileURLRef,&soundFileObject1);
    AudioServicesPlaySystemSound (soundFileObject1);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Walkout Submission Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

}
else{
    SystemSoundID    soundFileObject1;
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (_soundFileURLRef,&soundFileObject1);
    AudioServicesPlaySystemSound (soundFileObject1);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Walkout submission Faield" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
}

@catch (NSException *exception) {
    
    SystemSoundID    soundFileObject1;
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (_soundFileURLRef,&soundFileObject1);
    AudioServicesPlaySystemSound (soundFileObject1);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Weceipt Submission Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}


}
-(void)createCustomerWalkOutErrorResponse:(NSString*)error {
    @try {
        
        [HUD setHidden:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
    }
}

- (void)cancelButtonPressed {
    @try {
        AudioServicesPlaySystemSound(_soundFileObject);
        
        
        OmniHomePage *home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:YES];
        
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}




#pragma mark text field delegates

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
    
    
    if (textField == phoneNoFld) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
            
        }
        
    }
    
    
    return  YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == phoneNoFld) {
        if (textField.text.length == 10) {
            [phoneNoFld resignFirstResponder];
            [self getCustomerDetails];
        }
        else if (textField.text.length == 0) {
            emailFld.text = @"";
            firstNameFld.text = @"";
            streetFld.text = @"";
            localityFld.text = @"";
            cityFld.text = @"";
            pinFld.text = @"";
            ageFld.text = @"";
            genderFld.text = @"";
            
            
        }
        
    }
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == reasonFld)
        [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == reasonFld)
        [self animateTextField: textField up: NO];
}

- (void) animateTextField:(UITextField*) textField up:(BOOL)up {
    const int movementDistance = 290; // tweak as needed
    const float movementDuration = 0.1f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView animateWithDuration:movementDuration animations:^ {
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self resignFirstResponder];
    
    
    return YES;
    
}

#pragma mark table View Delegates delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (tableView == genderTbl ) {
        return  genderArr.count;
    }
    
    else if(tableView == categoryTbl){
        
        return  categoriesArr.count;
    }
    else if(tableView == deprtmntTbl){
        
        return  departmentArr.count;
    }
    
    else if(tableView == brandTbl){
        
        return  brandListArr.count;
    }
    else if(tableView == reasonTbl){
        
        return  reasonArr.count;
    }
    
    else if(tableView == ageTbl){
        
        return  ageArr.count;
    }
    
    else if (tableView == sizeTbl) {
        return  sizeArr.count;
    }
    else if (tableView == colorTbl) {
        return  colorArr.count;
    }

    
    
    else
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
    if (tableView == genderTbl || tableView == deprtmntTbl ||tableView == categoryTbl || tableView == brandTbl || tableView == reasonTbl  || tableView == ageTbl ) {
        return 50;
    }
    else
        return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == genderTbl) {
        
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
        
        
        hlcell.textLabel.numberOfLines = 2;
        
        hlcell.textLabel.text = genderArr[indexPath.row];
        hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return hlcell;
        
    }
    
    
    else if (tableView == categoryTbl) {
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
            
            
            hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = [categoriesArr[indexPath.row] valueForKey:@"categoryDescription"];
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    
    
    else if (tableView == ageTbl) {
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
            
            
            hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = ageArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
//            hlcell.textLabel.textAlignment = UITextAlignmentCenter;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }
    else if (tableView == deprtmntTbl) {
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
            
            
            hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = [departmentArr[indexPath.row] valueForKey:@"departmentDescription"];
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    
 else if (tableView == reasonTbl) {
 
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
            
            
            hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = reasonArr[indexPath.row] ;
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    
    else if (tableView == brandTbl) {
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
            
            
            hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = [brandListArr[indexPath.row] valueForKey:@"bDescription"];
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        return false;
    }
    
    else if (tableView == colorTbl) {
        
        @try {
            static NSString * CellIdentifier = @"Cell";
            
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
            
            
            hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:colorArr[indexPath.row]  defaultReturn:@""] ;
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException * exception) {
            
        }
        @finally {
            
        }
        
    }
    
    else if (tableView == sizeTbl) {
        UITableViewCell *hlcell;
        @try {
            static NSString *CellIdentifier = @"Cell";
            
            hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (hlcell == nil) {
                hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                hlcell.frame = CGRectZero;
            }
            if ((hlcell.contentView).subviews){
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = [NSString stringWithFormat:@"%i",  [sizeArr[indexPath.row] integerValue]] ;
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            return hlcell;
        }
        return false;
    }


}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == genderTbl) {
        
        genderFld.text = genderArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
    }
    
    else if (tableView == deprtmntTbl) {
        
        deprtmntFld.text = [departmentArr[indexPath.row] valueForKey:@"departmentDescription"];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    
    else if (tableView == brandTbl) {
        
        
        if(brandFld.tag == 1)    {
            
            
            [catPopOver dismissPopoverAnimated:YES];
            
            brandFld.text = [brandListArr[indexPath.row] valueForKey:@"bDescription"];
        }
        else
            brandFld1.text = [brandListArr[indexPath.row] valueForKey:@"bDescription"];
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
    }
    else if (tableView == categoryTbl) {
        
        categoryFld.text = [categoriesArr[indexPath.row] valueForKey:@"categoryDescription"];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    
    else if (tableView == reasonTbl) {
        
        reasonFld.text = reasonArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    
    else if (tableView == ageTbl) {
        
        ageFld.text = ageArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    
    else if (tableView == sizeTbl) {
        
        if(sizeFld.tag == 2) {
            sizeFld.text = [NSString stringWithFormat:@"%i",[sizeArr[indexPath.row] integerValue]];
            [catPopOver dismissPopoverAnimated:YES];
            
        }
        
        else
            sizeFld1.text = [NSString stringWithFormat:@"%i",[sizeArr[indexPath.row] integerValue]];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    
    else if (tableView == colorTbl) {
        
        if(colourFld.tag == 4) {
            colorFld1.text = colorArr[indexPath.row];
            [catPopOver dismissPopoverAnimated:YES];
            
        }
        
        else
            colourFld.text = colorArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    

    
}

-(void)backAction {
    
            
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goToHome {
    
    
    [self backAction];
}
-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}

#pragma mark sizeAndColors ServiceCall

-(void)callingSizeAndColors {
    @try {
        
        [HUD setHidden:NO];
        colorArr = [NSMutableArray new];
        sizeArr = [NSMutableArray new];
        
        NSArray *keys = @[@"requestHeader",@"startIndex"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1"];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * sizeAndColorsString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSizeAndColorsDelegate = self;
        [webServiceController getSizeAndColors:sizeAndColorsString];
        
    }
    @catch (NSException * exception) {
        
    }
    @finally {
    }
}

-(void)getSizeAndColorsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        if (successDictionary != nil) {
            
            //reading the colors into array.......
            for (NSDictionary * colors in  [successDictionary valueForKey: @"colors" ])
                [colorArr addObject:colors];
            
            //reading the sizes into array.......
            for (NSDictionary * colors in  [successDictionary valueForKey: @"sizes" ])
                [sizeArr addObject:colors];
            
            //            if(sizeFld.tag == 0){
            //                for (NSDictionary * colors in  [successDictionary valueForKey: @"colors" ]) {
            //
            //                    [colorArr addObject:colors];
            //                }
            //            }
            //            else{
            //                for (NSDictionary * colors in  [successDictionary valueForKey: @"sizes" ]) {
            //
            //                    [sizeArr addObject:colors];
            //                }
            //
            //
            //            }
            
            
            
            
        }
        
    }
    
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
        
    }
}

-(void)getSizeAndColorsErrorResponse:(NSString *)errorResponse {
    @try {
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Records  Found" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
        
        [HUD setHidden:YES];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}




#pragma -mark methods added by Srinivasulu from 17/01/2016
#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         07/05/2017....
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


@end
