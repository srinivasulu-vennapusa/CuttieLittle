//
//  WalkoutDetails.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 10/12/16.
//


#import "WalkoutDetails.h"
#import "ViewWalkoutCustomer.h"
#import "CustomerServiceSvc.h"
#import "OmniHomePage.h"



@interface WalkoutDetails ()

@end

@implementation WalkoutDetails

float version;
//NSString *FinalWalkoutID = @"";

//-(id) initWithWalkoutID:(NSString *)walkOutID{
//
//    FinalWalkoutID = [walkOutID copy];
//
//    return self;
//}

-(void)viewDidAppear:(BOOL)animated{
    
    @try {
        
        [self getCustomerWalkout];
        
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
    self.titleLabel.text = NSLocalizedString(@"CUSTOMER WALKOUT DETAILS", nil);
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
    reasonFld.userInteractionEnabled = YES;
    
    reasonFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    reasonFld.placeholder = NSLocalizedString(@" Reason", nil);
    reasonFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:reasonFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    categoryFld = [[UITextField alloc] init];
    categoryFld.borderStyle = UITextBorderStyleRoundedRect;
    categoryFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
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
    priceFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    priceFld.font = [UIFont systemFontOfSize:18.0];
    priceFld.backgroundColor = [UIColor clearColor];
    priceFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    priceFld.autocorrectionType = UITextAutocorrectionTypeNo;
    priceFld.layer.borderWidth = 1.0f;
    priceFld.delegate = self;
    priceFld.userInteractionEnabled = NO;
    
    priceFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    priceFld.placeholder = NSLocalizedString(@" Price", nil);
    priceFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:priceFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    brandFld1 = [[UITextField alloc] init];
    brandFld1.borderStyle = UITextBorderStyleRoundedRect;
    brandFld1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
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
    colorFld1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
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
    sizeFld1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
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
    dlvryDteFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    dlvryDteFld.font = [UIFont systemFontOfSize:18.0];
    dlvryDteFld.backgroundColor = [UIColor clearColor];
    dlvryDteFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    dlvryDteFld.autocorrectionType = UITextAutocorrectionTypeNo;
    dlvryDteFld.layer.borderWidth = 1.0f;
    dlvryDteFld.delegate = self;
    dlvryDteFld.userInteractionEnabled = NO;
    
    dlvryDteFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
//    dlvryDteFld.placeholder = NSLocalizedString(@" Delivery Date", nil);
//    dlvryDteFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dlvryDteFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//    
//    
    inTimeFld = [[UITextField alloc] init];
    inTimeFld.borderStyle = UITextBorderStyleRoundedRect;
    inTimeFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    inTimeFld.font = [UIFont systemFontOfSize:18.0];
    inTimeFld.backgroundColor = [UIColor clearColor];
    inTimeFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    inTimeFld.autocorrectionType = UITextAutocorrectionTypeNo;
    inTimeFld.layer.borderWidth = 1.0f;
    inTimeFld.delegate = self;
    inTimeFld.userInteractionEnabled = NO;
    
    inTimeFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
//    inTimeFld.placeholder = NSLocalizedString(@" In Time ", nil);
//    inTimeFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:inTimeFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//    
    
    outTimeFld = [[UITextField alloc] init];
    outTimeFld.borderStyle = UITextBorderStyleRoundedRect;
    outTimeFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    outTimeFld.font = [UIFont systemFontOfSize:18.0];
    outTimeFld.backgroundColor = [UIColor clearColor];
    outTimeFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    outTimeFld.autocorrectionType = UITextAutocorrectionTypeNo;
    outTimeFld.layer.borderWidth = 1.0f;
    outTimeFld.delegate = self;
    outTimeFld.userInteractionEnabled = NO;
    
    outTimeFld.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
//    outTimeFld.placeholder = NSLocalizedString(@" Out Time ", nil);
//    outTimeFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:outTimeFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    UIImage *indentsImg = [UIImage imageNamed:@"summaryInfo.png"];
    
    UIButton * indentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [indentsBtn setBackgroundImage:indentsImg forState:UIControlStateNormal];
    [indentsBtn addTarget:self
                   action:@selector(summaryInfo) forControlEvents:UIControlEventTouchDown];
    indentsBtn.hidden = YES;
    

    
    
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
    
    
    
    
    [self.view addSubview:walkOutView];
    
    
    
    
#pragma mark view frame :
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        walkOutView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        verticalLbl.frame = CGRectMake(walkOutView.frame.origin.x+650, walkOutView.frame.origin.y-25, 1, 580);
        
        
        horiaontalLbl.frame = CGRectMake(walkOutView.frame.origin.x+10, walkOutView.frame.origin.y+220, 980, 1);
        
        
        horizntal1.frame = CGRectMake(walkOutView.frame.origin.x+10, walkOutView.frame.origin.y+260, 980, 1);
        
        custmerRjections.frame = CGRectMake(walkOutView.frame.origin.x+130, walkOutView.frame.origin.y+220, 270, 40);
        custmerRjections.font = [UIFont systemFontOfSize:25.0];
        
        
        custmrRqrment.frame = CGRectMake(verticalLbl.frame.origin.x+10, walkOutView.frame.origin.y+220, 300, 40);
        custmrRqrment.font = [UIFont systemFontOfSize:25.0];
        
        
        indentsBtn.frame = CGRectMake(walkOutView.frame.origin.x+950, 5, 40, 40);
        
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
        //
        categoryFld.font = [UIFont systemFontOfSize:20];
        categoryFld.frame = CGRectMake((categoryLbl.frame.origin.x+categoryLbl.frame.size.width-20), phoneLbl.frame.origin.y+300, 200, 40);
        
        
        priceRngLbl.frame = CGRectMake((brandFld.frame.origin.x+brandFld.frame.size.width+10), phoneLbl.frame.origin.y+360, 120, 40);
        priceRngLbl.font = [UIFont systemFontOfSize:20.0];
        
        priceFld.font = [UIFont systemFontOfSize:20];
        priceFld.frame = CGRectMake((priceRngLbl.frame.origin.x+priceRngLbl.frame.size.width-20), categoryFld.frame.origin.y+categoryFld.frame.size.height+15, 200, 40);
        
        
        size.frame = CGRectMake((colourFld.frame.origin.x+colourFld.frame.size.width+10), colour.frame.origin.y, 120, 40);
        size.font = [UIFont systemFontOfSize:20.0];
        
        sizeFld.font = [UIFont systemFontOfSize:20];
        sizeFld.frame = CGRectMake((size.frame.origin.x+size.frame.size.width-20),colourFld.frame.origin.y, 200, 40);
        
        outTimeLbl.frame = CGRectMake(inTimeFld.frame.origin.x+inTimeFld.frame.size.width+10, inTimeLbl.frame.origin.y, 120, 40);
        
        outTimeLbl.font = [UIFont systemFontOfSize:20.0];
        
        outTimeFld.font = [UIFont systemFontOfSize:20];
        outTimeFld.frame = CGRectMake((outTimeLbl.frame.origin.x+outTimeLbl.frame.size.width-20), inTimeFld.frame.origin.y , 200, 40);
        
        
        
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
        
      
           }
    else {
        
        
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCustomerWalkout {
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        
        
        NSMutableDictionary *walkoutDetails = [[NSMutableDictionary alloc] init];
        walkoutDetails[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        walkoutDetails[@"slno"] = _walkoutID;
        walkoutDetails[START_INDEX] = @"-1";
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:walkoutDetails options:0 error:&err];
        NSString * walkoutJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.customerWalkoutDelegate = self;
        [webServiceController getCustomerWalkout:walkoutJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    
}

-(void)getCustomerWalkOutSuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        
        NSDictionary *dictionary = sucessDictionary[@"walkoutsObj"][@"customerObj"];
        
        NSDictionary * temp =  sucessDictionary[@"walkoutsObj"];
        
        
        if (![dictionary[CUSTOMER_PHONE] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_PHONE] length] > 0) {
            phoneNoFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_PHONE]];
        }
        else{
            phoneNoFld.text = @"";
            phoneNoFld.placeholder = nil;
        }
        
        
        if (![temp[CUSTOMER_MAIL] isKindOfClass:[NSNull class]]&& [temp[CUSTOMER_MAIL] length] > 0) {
            emailFld.text = [NSString stringWithFormat:@"%@",temp[CUSTOMER_MAIL]];
        }
        else{
            emailFld.text = @"";
            emailFld.placeholder = nil;
        }
        
        
        
        if (![dictionary[@"name"] isKindOfClass:[NSNull class]]&& [dictionary[@"name"] length] > 0) {
            firstNameFld.text = [NSString stringWithFormat:@"%@",dictionary[@"name"]];
        }
        else {
            firstNameFld.text =  @"";
            firstNameFld.placeholder = nil;
            
        }
        
        if (![dictionary[CUSTOMER_LAST_NAME] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_LAST_NAME] length] > 0) {
            lastNameFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_LAST_NAME]];
        }
        else {
            lastNameFld.text =  @"";
            lastNameFld.placeholder = nil;
            
        }
        
        
        if (![dictionary[CUSTOMER_STREET] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_STREET] length] > 0) {
            streetFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_STREET]];
        }
        else {
            streetFld.text =  @"";
            streetFld.placeholder = nil;
            
        }
        
        if (![dictionary[CUSTOMER_LOCALITY] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_LOCALITY] length] > 0) {
            localityFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_LOCALITY]];
        }
        else {
            localityFld.text =  @"";
            localityFld.placeholder = nil;
            
        }
        
        if (![dictionary[CUSTOMER_CITY] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_CITY] length] > 0) {
            cityFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_CITY]];
        }
        else {
            cityFld.text =  @"";
            cityFld.placeholder = nil;
            
        }
        
        
        if (![dictionary[CUSTOMER_PIN_NO] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_PIN_NO] length] > 0) {
            pinFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_PIN_NO]];
        }
        
        else {
            pinFld.text =  @"";
            pinFld.placeholder = nil;
            
        }
        
        
        if (![dictionary[CUSTOMER_AGE] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_AGE] integerValue]!=  0) {
            
            ageFld.text = [NSString stringWithFormat:@"%i",[[dictionary valueForKey:@"age"] integerValue]];
        }
        else {
            ageFld.text =  @"";
            ageFld.placeholder = nil;
            
        }
        
        
        if (![dictionary[CUSTOMER_DESIGNATION] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_DESIGNATION] length] > 0) {
            profsnlFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_DESIGNATION]];
        }
        else{
            profsnlFld.text = @"";
            profsnlFld.placeholder = nil;
        }
        
        
        if (![dictionary[CUSTOMER_GENDER] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_GENDER] length] > 0) {
            genderFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_GENDER]];
        }
        else{
            genderFld.text = @"";
            genderFld.placeholder = nil;
        }
        
        
        if (![dictionary[CUSTOMER_DOB] isKindOfClass:[NSNull class]]&& [dictionary[CUSTOMER_DOB] length] > 0) {
            dobFld.text = [NSString stringWithFormat:@"%@",dictionary[CUSTOMER_DOB]];
        }
        else{
            dobFld.text = @"";
            dobFld.placeholder = nil;
        }
        
        if (![temp[CUSTOMER_DEPARTMENT] isKindOfClass:[NSNull class]]&& [temp[CUSTOMER_DEPARTMENT] length] > 0) {
            deprtmntFld.text = [NSString stringWithFormat:@"%@",temp[CUSTOMER_DEPARTMENT]];
        }
        else{
            deprtmntFld.text = @"";
            deprtmntFld.placeholder = nil;
        }
        
        
        if (![temp[CUSTOMER_CATEGORY] isKindOfClass:[NSNull class]]&& [temp[CUSTOMER_CATEGORY] length] > 0) {
            categoryFld.text = [NSString stringWithFormat:@"%@",temp[CUSTOMER_CATEGORY]];
        }
        else{
            categoryFld.text = @"";
            categoryFld.placeholder = nil;
        }
        
        
        if (![temp[CUSTOMER_BRAND] isKindOfClass:[NSNull class]]&& [temp[CUSTOMER_BRAND] length] > 0) {
            brandFld.text = [NSString stringWithFormat:@"%@",temp[CUSTOMER_BRAND]];
        }
        else{
            brandFld.text = @"";
            brandFld.placeholder = nil;
        }
        
        if (![temp[kRequiredBrand] isKindOfClass:[NSNull class]]&& [temp[kRequiredBrand] length] > 0) {
            brandFld1.text = [NSString stringWithFormat:@"%@",temp[kRequiredBrand]];
        }
        else{
            brandFld1.text = @"";
            brandFld1.placeholder = nil;
        }
        
        
        if (![temp[@""] isKindOfClass:[NSNull class]]&& [dictionary[@""] length] > 0) {
            priceFld.text = [NSString stringWithFormat:@"%@",dictionary[@""]];
        }
        else{
            priceFld.text = @"";
            priceFld.placeholder = nil;
        }
        
        
        if (![temp[CUSTOMER_COLOR] isKindOfClass:[NSNull class]]&& [temp[CUSTOMER_COLOR] length] > 0) {
            colourFld.text = [NSString stringWithFormat:@"%@",temp[CUSTOMER_COLOR]];
            
        }
        else{
            colourFld.text = @"";
            colourFld.placeholder = nil;
            
            
        }
        
        if (![temp[kRequiredColor] isKindOfClass:[NSNull class]]&& [temp[kRequiredColor] length] > 0) {
            colorFld1.text = [NSString stringWithFormat:@"%@",temp[kRequiredColor]];
            
        }
        else{
            colorFld1.text = @"";
            colorFld1.placeholder = nil;
            
            
        }
        
        
        if (![temp[CUSTOMER_REASON] isKindOfClass:[NSNull class]]&& [temp[CUSTOMER_REASON] length] > 0) {
            reasonFld.text = [NSString stringWithFormat:@"%@",temp[CUSTOMER_REASON]];
        }
        else{
            reasonFld.text = @"";
            reasonFld.placeholder = nil;
        }
        
        if (![temp[CUSTOMER_SIZE] isKindOfClass:[NSNull class]]&& [temp[CUSTOMER_SIZE] length] > 0) {
            sizeFld.text = [NSString stringWithFormat:@"%@",temp[CUSTOMER_SIZE]];
            
        }
        else{
            sizeFld.text = @"";
            sizeFld.placeholder = nil;
            
        }
        
        if (![temp[kRequiredSize] isKindOfClass:[NSNull class]]&& [temp[kRequiredSize] length] > 0) {
            sizeFld1.text = [NSString stringWithFormat:@"%i",[[temp valueForKey:kRequiredSize] integerValue]];
            
        }
        else{
            sizeFld1.text = @"";
            sizeFld1.placeholder = nil;
            
            
        }
        
        if (![temp[@"customerWalkInTime"] isKindOfClass:[NSNull class]]&& [temp[@"customerWalkInTime"] length] > 0) {
            inTimeFld .text = [NSString stringWithFormat:@"%@",temp[@"customerWalkInTime"]];
            
        }
        else{
            inTimeFld.text = @"";
            inTimeFld.placeholder = nil;
            
            
        }
        
        if (![temp[@"customerWalkOutTime"] isKindOfClass:[NSNull class]]&& [temp[@"customerWalkOutTime"] length] > 0) {
            outTimeFld .text = [NSString stringWithFormat:@"%@",temp[@"customerWalkOutTime"]];
            
        }
        else{
            outTimeFld.text = @"";
            outTimeFld.placeholder = nil;
            
            
        }
        if (![temp[@"createdDateStr"] isKindOfClass:[NSNull class]]&& [temp[@"createdDateStr"] length] > 0) {
            dlvryDteFld .text = [NSString stringWithFormat:@"%@",temp[@"createdDateStr"]];
            
        }
        else{
            dlvryDteFld.text = @"";
            dlvryDteFld.placeholder = nil;
            
            
        }
        
        
        
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        
        [HUD setHidden: YES];
    }
    
}

-(void)getCustomerWalkOutErrorResponse:(NSString*)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to load data" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    [HUD setHidden:YES];
    
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





@end
