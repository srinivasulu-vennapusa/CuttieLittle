//
//  DayStart.m
//  OmniRetailer
//
//  Created by Bhargav.v on 3/13/18.


#import "DayStart.h"
#import "OfflineBillingServices.h"
#import "OmniHomePage.h"

@interface DayStart ()

@end

@implementation DayStart

//this properties are used for generating the sounds....
@synthesize soundFileURLRef,soundFileObject;

#pragma - mark start of ViewLifeCycle mehods...

/**
 * @description  ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         13/03/2018
 * @method       ViewDidLoad
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //reading the DeviceVersion....
    version = [[[UIDevice currentDevice]systemVersion] floatValue];
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [[UIDevice currentDevice] orientation];
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
   
    //creating the stockRequestView which will displayed completed Screen...
    dayStartView = [[UIView alloc] init];
    dayStartView.backgroundColor = [UIColor blackColor];
    dayStartView.layer.borderWidth = 1.0f;
    dayStartView.layer.cornerRadius = 10.0f;
    dayStartView.layer.borderColor = [UIColor lightGrayColor].CGColor;

    /*Creation of UILabel for headerDisplay.......*/
    //creating  UILabel as a line which will display at topOfThe DayStartView...
    UILabel * headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    
    //CALayer for borderwidth and color setting....
    CALayer * bottomBorder = [CALayer layer];
    bottomBorder.opacity = 5.0f;
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    [headerNameLbl.layer addSublayer:bottomBorder];
    
    UILabel * locationValueLabel;
    
    locationLabel = [[UILabel alloc] init];
    locationLabel.layer.cornerRadius = 4;
    locationLabel.layer.masksToBounds = YES;
    locationLabel.numberOfLines = 1;
    [locationLabel setTextAlignment:NSTextAlignmentLeft];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    
    locationValueLabel = [[UILabel alloc] init];
    locationValueLabel.layer.cornerRadius = 4;
    locationValueLabel.layer.masksToBounds = YES;
    locationValueLabel.numberOfLines = 1;
    [locationValueLabel setTextAlignment:NSTextAlignmentLeft];
    locationValueLabel.backgroundColor = [UIColor clearColor];
    locationValueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    UILabel * floatingCashLabel;
   
    floatingCashLabel = [[UILabel alloc] init];
    floatingCashLabel.layer.cornerRadius = 4;
    floatingCashLabel.layer.masksToBounds = YES;
    floatingCashLabel.numberOfLines = 1;
    [floatingCashLabel setTextAlignment:NSTextAlignmentLeft];
    floatingCashLabel.backgroundColor = [UIColor clearColor];
    floatingCashLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];

    floatingCashValueLabel = [[UILabel alloc] init];
    floatingCashValueLabel.layer.cornerRadius = 4;
    floatingCashValueLabel.layer.masksToBounds = YES;
    floatingCashValueLabel.numberOfLines = 1;
    [floatingCashValueLabel setTextAlignment:NSTextAlignmentLeft];
    floatingCashValueLabel.backgroundColor = [UIColor clearColor];
    floatingCashValueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];

    UILabel * loginNameValueLabel;
    
    loginNameLabel = [[UILabel alloc] init];
    loginNameLabel.layer.cornerRadius = 4;
    loginNameLabel.layer.masksToBounds = YES;
    loginNameLabel.numberOfLines = 1;
    [loginNameLabel setTextAlignment:NSTextAlignmentLeft];
    loginNameLabel.backgroundColor = [UIColor clearColor];
    loginNameLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    
    loginNameValueLabel = [[UILabel alloc] init];
    loginNameValueLabel.layer.cornerRadius = 4;
    loginNameValueLabel.layer.masksToBounds = YES;
    loginNameValueLabel.numberOfLines = 1;
    [locationValueLabel setTextAlignment:NSTextAlignmentLeft];
    loginNameValueLabel.backgroundColor = [UIColor clearColor];
    loginNameValueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    
    UILabel * dateValueLabel;
    
    dateLabel = [[UILabel alloc] init];
    dateLabel.layer.cornerRadius = 4;
    dateLabel.layer.masksToBounds = YES;
    dateLabel.numberOfLines = 1;
    [dateLabel setTextAlignment:NSTextAlignmentLeft];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    
    dateValueLabel = [[UILabel alloc] init];
    dateValueLabel.layer.cornerRadius = 4;
    dateValueLabel.layer.masksToBounds = YES;
    dateValueLabel.numberOfLines = 1;
    [dateValueLabel setTextAlignment:NSTextAlignmentLeft];
    dateValueLabel.backgroundColor = [UIColor clearColor];
    dateValueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    UILabel * closedByLabel;
    
    closedByLabel = [[UILabel alloc] init];
    closedByLabel.layer.cornerRadius = 4;
    closedByLabel.layer.masksToBounds = YES;
    closedByLabel.numberOfLines = 1;
    [closedByLabel setTextAlignment:NSTextAlignmentLeft];
    closedByLabel.backgroundColor = [UIColor clearColor];
    closedByLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    
    closedByValueLabel = [[UILabel alloc] init];
    closedByValueLabel.layer.cornerRadius = 4;
    closedByValueLabel.layer.masksToBounds = YES;
    closedByValueLabel.numberOfLines = 1;
    [closedByValueLabel setTextAlignment:NSTextAlignmentLeft];
    closedByValueLabel.backgroundColor = [UIColor clearColor];
    closedByValueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];

    //setting the titleName for the Page....
    self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
    HUD.labelText = NSLocalizedString(@"please_wait..", nil);
    
    headerNameLbl.text = NSLocalizedString(@"day_opening", nil);
    
    locationLabel.text  = NSLocalizedString(@"location_", nil);
    loginNameLabel.text = NSLocalizedString(@"login_name", nil);
    floatingCashLabel.text = NSLocalizedString(@"floating_cash", nil);
    dateLabel.text      = NSLocalizedString(@"date_", nil);
    floatingCashValueLabel.text = NSLocalizedString(@"0_00",nil);
    closedByLabel.text = NSLocalizedString(@"closed_by",nil);
    

    @try {
        
        locationValueLabel.text = presentLocation;
        loginNameValueLabel.text = firstName;
        closedByValueLabel.text = firstName;

        NSDate * todayDate = [NSDate date];
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        [requiredDateFormat setDateFormat:@"dd/MM/yyyy"];
        
        dateValueLabel.text = [requiredDateFormat stringFromDate:todayDate];

    }
    @catch(NSException * exception) {
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
        }
        else{
            
        }
        
        //setting frame for the dayStartView....
        dayStartView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake( 0, 0, dayStartView.frame.size.width, 45);
        
        // frames for the UIElements Under the dayStart View...
        float labelHeight = 30;
        
        locationLabel.frame = CGRectMake(10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10,80,labelHeight);
        locationValueLabel.frame = CGRectMake(locationLabel.frame.origin.x + locationLabel.frame.size.width + 5,locationLabel.frame.origin.y ,200, labelHeight);
        
        loginNameLabel.frame = CGRectMake(locationLabel.frame.origin.x, locationLabel.frame.origin.y + locationLabel.frame.size.height, 110, labelHeight);
        
        loginNameValueLabel.frame = CGRectMake(loginNameLabel.frame.origin.x + loginNameLabel.frame.size.width + 5,loginNameLabel.frame.origin.y ,200, labelHeight);
        
        dateLabel.frame = CGRectMake(locationValueLabel.frame.origin.x + locationValueLabel.frame.size.width + 150, locationLabel.frame.origin.y,60,labelHeight);
        
        dateValueLabel.frame = CGRectMake(dateLabel.frame.origin.x + dateLabel.frame.size.width + 5 , dateLabel.frame.origin.y, 100, labelHeight);
        
        floatingCashLabel.frame = CGRectMake(dateLabel.frame.origin.x, loginNameLabel.frame.origin.y,120, labelHeight);
        
        floatingCashValueLabel.frame = CGRectMake(floatingCashLabel.frame.origin.x + floatingCashLabel.frame.size.width + 5 ,floatingCashLabel.frame.origin.y ,200, labelHeight);
        
        closedByLabel.frame = CGRectMake(dateValueLabel.frame.origin.x + dateValueLabel.frame.size.width + 100,dateLabel.frame.origin.y,100, labelHeight);
        
        closedByValueLabel.frame = CGRectMake(closedByLabel.frame.origin.x + closedByLabel.frame.size.width + 5 ,closedByLabel.frame.origin.y ,200, labelHeight);
        
    }
    
    //Adding the subviews to the main view
    [dayStartView addSubview:headerNameLbl];
    
    [dayStartView addSubview:locationLabel];
    [dayStartView addSubview:locationValueLabel];
    
    [dayStartView addSubview:dateLabel];
    [dayStartView addSubview:dateValueLabel];
    
    [dayStartView addSubview:loginNameLabel];
    [dayStartView addSubview:loginNameValueLabel];
    
    [dayStartView addSubview:floatingCashLabel];
    [dayStartView addSubview:floatingCashValueLabel];
    
    [dayStartView addSubview:closedByLabel];
    [dayStartView addSubview:closedByValueLabel];
    
    [self.view addSubview:dayStartView];
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
    
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    
    [self populateDenominations];

}


/**
 * @description  it is one of ViewLifeCylce  which will be executed after execution of  viewDidLoad.......
 * @date         21/09/2016
 * @method       viewDidAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated {
    //calling super method....
    [super viewDidAppear:YES];
    
    @try {
        
        [self callingGetDayClosureSummary];
        
    } @catch (NSException *exception) {
        NSLog(@"--exception in serviceCall--%@",exception);
    } @finally {
        
    }
}


/**
 * @description  Displaying the denominations screen....
 * @date         14/03/2018
 * @method       populateDenominations
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)populateDenominations {
   
    @try {
        
        denominationDic = [[NSMutableDictionary alloc] init];
        
        denomValTxtArr = [NSMutableArray new];
        denomCountArr = [NSMutableArray new];
        
        denomCountCoinsArr = [NSMutableArray new];
        denomValCoinsTxtArr = [NSMutableArray new];
        
        OfflineBillingServices  * offline = [[OfflineBillingServices alloc] init];
        NSArray * denominations = [offline getDenominationDetails:@"INR"];
        
        //added by Srinivasulu on 05/05/2017....
        
        @try {
            
            if(![denominations count]){
                [HUD setHidden:NO];
                [HUD setLabelText:@"Getting denominations..."];
                
                if([offline getDenominationsDetails:-1 totalRecords:DOWNLOAD_RATE]){
                    
                    denominations = [offline getDenominationDetails:@"INR"];
                    
                }
                [HUD setHidden:YES];
            }
            
        } @catch (NSException *exception) {
            [HUD setHidden:YES];
        }
        
        //upto here on 05/05/2017....
        
        if ([denominations count]) {

            denominationDic = [[NSMutableDictionary alloc]init];
            denominationCoinDic = [NSMutableDictionary new];
            
            denominationView    = [[UIView alloc] init];
            denominationView.backgroundColor = [UIColor blackColor];
            denominationView.hidden = false;
            
            UILabel * addDenomLbl;
            
            UIScrollView * denomNotesScrollView;
            denomNotesScrollView = [[UIScrollView alloc]init];
            denomNotesScrollView.hidden = NO;
            denomNotesScrollView.backgroundColor = [UIColor clearColor];
            denomNotesScrollView.bounces = FALSE;
            denomNotesScrollView.scrollEnabled = YES;
            
            UIScrollView * denomCoinsScrollView;
            denomCoinsScrollView = [[UIScrollView alloc]init];
            denomCoinsScrollView.hidden = NO;
            denomCoinsScrollView.backgroundColor = [UIColor clearColor];
            denomCoinsScrollView.bounces = FALSE;
            denomCoinsScrollView.scrollEnabled = YES;
            
            denomScrollView = [[UIScrollView alloc] init];
            denomScrollView.hidden = NO;
            denomScrollView.backgroundColor = [UIColor clearColor];
            denomScrollView.bounces = FALSE;
            denomScrollView.scrollEnabled = YES;

            NSArray  * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString * documentsDirectory = [[paths objectAtIndex:0] stringByAppendingString:@"/DenominationImagesFolder"];
            
            int index = 1;
            
            float yPosition = 20;
            float xPosition = 10;
            
            float textYposition = 50;
            
            NSMutableArray * notesArr = [NSMutableArray new];
            NSMutableArray * coinsArr = [NSMutableArray new];
            
            for (NSDictionary *infoDic in denominations) {
                
                if (![[infoDic valueForKey:kDenomType] boolValue]) {
                    
                    [coinsArr addObject:infoDic];
                }
                else {
                    [notesArr addObject:infoDic];
                }
            }
            
            NSSortDescriptor * sortDescriptor;
            
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kDenomValue ascending:NO];
            
            //upto here on 16/08/2017....
            
            NSArray * sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            notesArr = [[notesArr sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
            coinsArr = [[coinsArr sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
            
            denominationView.frame = CGRectMake(locationLabel.frame.origin.x,floatingCashValueLabel.frame.origin.y +   floatingCashValueLabel.frame.size.height ,(dayStartView.frame.size.width - (locationLabel.frame.origin.x) - 5), dayStartView.frame.size.height-(floatingCashValueLabel.frame.origin.y+floatingCashValueLabel.frame.size.height) - 5);
            
            UILabel * declaredCashLabel;
            
            UILabel * verticalLabel;
            
            declaredCashLabel = [[UILabel alloc] init];
            declaredCashLabel.layer.cornerRadius = 4;
            declaredCashLabel.layer.masksToBounds = YES;
            declaredCashLabel.numberOfLines = 1;
            [declaredCashLabel setTextAlignment:NSTextAlignmentCenter];
            declaredCashLabel.backgroundColor = [UIColor clearColor];
            declaredCashLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
            
            declaredCashLabel.text = NSLocalizedString(@"declared_cash", nil);
            declaredCashLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            
            separationLabel = [[UILabel alloc] init];
            separationLabel.text = @"";
            separationLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
            separationLabel.textColor = [UIColor whiteColor];
            
            verticalLabel = [[UILabel alloc] init];
            verticalLabel.text = @"";
            verticalLabel.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
            verticalLabel.textColor = [UIColor whiteColor];

            UILabel * openingCashLabel;
            
            openingCashLabel = [[UILabel alloc] init];
            openingCashLabel.layer.cornerRadius = 4;
            openingCashLabel.layer.masksToBounds = YES;
            openingCashLabel.numberOfLines = 1;
            [openingCashLabel setTextAlignment:NSTextAlignmentCenter];
            openingCashLabel.backgroundColor = [UIColor clearColor];
            openingCashLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
            openingCashLabel.text = NSLocalizedString(@"open_cash", nil);
            openingCashLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            
            UILabel * separationLabel2;
            UILabel * verticalLabel2;
            
            separationLabel2 = [[UILabel alloc] init];
            separationLabel2.text = @"";
            separationLabel2.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
            separationLabel2.textColor = [UIColor whiteColor];
            
            verticalLabel2 = [[UILabel alloc] init];
            verticalLabel2.text = @"";
            verticalLabel2.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
            verticalLabel2.textColor = [UIColor whiteColor];
            
            UILabel * separationLabel3;
            UILabel * separationLabel4;
            
            separationLabel3 = [[UILabel alloc] init];
            separationLabel3.text = @"";
            separationLabel3.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
            separationLabel3.textColor = [UIColor whiteColor];

            separationLabel4 = [[UILabel alloc] init];
            separationLabel4.text = @"";
            separationLabel4.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
            separationLabel4.textColor = [UIColor whiteColor];
            
            declaredCashValueLabel = [[UILabel alloc] init];
            declaredCashValueLabel.layer.cornerRadius = 4;
            declaredCashValueLabel.layer.masksToBounds = YES;
            declaredCashValueLabel.numberOfLines = 1;
            [declaredCashValueLabel setTextAlignment:NSTextAlignmentCenter];
            declaredCashValueLabel.backgroundColor = [UIColor clearColor];
            declaredCashValueLabel.text = @"0.00";
            declaredCashValueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
            declaredCashValueLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

            UILabel * separationLabel5;
           
            UILabel * separationLabel6;
            
            separationLabel5 = [[UILabel alloc] init];
            separationLabel5.text = @"";
            separationLabel5.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
            separationLabel5.textColor = [UIColor whiteColor];

            openingCashValueLabel = [[UILabel alloc] init];
            openingCashValueLabel.layer.cornerRadius = 4;
            openingCashValueLabel.layer.masksToBounds = YES;
            openingCashValueLabel.numberOfLines = 1;
            [openingCashValueLabel setTextAlignment:NSTextAlignmentCenter];
            openingCashValueLabel.backgroundColor = [UIColor clearColor];
            openingCashValueLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
            openingCashValueLabel.text = @"0.00";
            openingCashValueLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            
            separationLabel6 = [[UILabel alloc] init];
            separationLabel6.text = @"";
            separationLabel6.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
            separationLabel6.textColor = [UIColor whiteColor];

            UIButton * skipButton;
            UIButton * submitButton;
            
            skipButton = [[UIButton alloc] init];
            skipButton.layer.cornerRadius = 3.0f;
            skipButton.backgroundColor = [UIColor grayColor];
            [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            submitButton = [[UIButton alloc] init];
            submitButton.layer.cornerRadius = 3.0f;
            submitButton.backgroundColor = [UIColor grayColor];
            [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [skipButton addTarget:self action:@selector(skipButtonPressed:) forControlEvents:UIControlEventTouchDown];
            [submitButton addTarget:self action:@selector(callingDayOpenSummary) forControlEvents:UIControlEventTouchDown];
            
            [skipButton setTitle:NSLocalizedString(@"skip_", nil) forState:UIControlStateNormal];
            [submitButton setTitle:NSLocalizedString(@"submit", nil) forState:UIControlStateNormal];

            submitButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
            skipButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
            
            //Assigining frame for the DenomScrollView...
            denomNotesScrollView.frame = CGRectMake(0,0, (dateLabel.frame.origin.x + dateLabel.frame.size.width - (locationLabel.frame.origin.x) - 80),400);
            
            denomCoinsScrollView.frame = CGRectMake(0,420,denomNotesScrollView.frame.size.width,140);
            denomCoinsScrollView.contentSize = CGSizeMake(200, 250);

            denomScrollView.frame = CGRectMake(dateLabel.frame.origin.x - 10, 0, 570, denominationView.frame.size.height - 125);
            
            declaredCashLabel.frame = CGRectMake(0, 5, 220,30);
            
            separationLabel.frame   = CGRectMake(declaredCashLabel.frame.origin.x,declaredCashLabel.frame.origin.y + declaredCashLabel.frame.size.height + 5,270,0.5);
            
            verticalLabel.frame = CGRectMake(separationLabel.frame.origin.x + separationLabel.frame.size.width + 10,declaredCashLabel.frame.origin.y - 10,1, 35);
            
            openingCashLabel.frame = CGRectMake(verticalLabel.frame.origin.x + 10, declaredCashLabel.frame.origin.y,220,30);
            
            separationLabel2.frame = CGRectMake(verticalLabel.frame.origin.x + 10,separationLabel.frame.origin.y,270,0.5);
            
            verticalLabel2.frame  = CGRectMake(verticalLabel.frame.origin.x,textYposition,1,370);
            
            separationLabel3.frame = CGRectMake(denomScrollView.frame.origin.x,denomScrollView.frame.origin.y + denomScrollView.frame.size.height + 10,270,0.5);
            
            declaredCashValueLabel.frame = CGRectMake((separationLabel3.frame.origin.x + 100),separationLabel3.frame.origin.y + separationLabel3.frame.size.height + 10, 220,30);

            separationLabel4.frame = CGRectMake(separationLabel3.frame.origin.x,declaredCashValueLabel.frame.origin.y + declaredCashValueLabel.frame.size.height + 10,270,0.5);

            separationLabel5.frame = CGRectMake(separationLabel3.frame.origin.x + separationLabel3.frame.size.width  + 25,separationLabel3.frame.origin.y,270,0.5);

            openingCashValueLabel.frame = CGRectMake((separationLabel5.frame.origin.x + 100),declaredCashValueLabel.frame.origin.y , 220,30);
            
            separationLabel6.frame = CGRectMake(separationLabel5.frame.origin.x,separationLabel4.frame.origin.y,270,0.5);
            
            submitButton.frame = CGRectMake(separationLabel6.frame.origin.x , separationLabel6.frame.origin.y + separationLabel6.frame.size.height + 20 , 130, 40);
            
            skipButton.frame = CGRectMake(submitButton.frame.origin.x + submitButton.frame.size.width + 10,submitButton.frame.origin.y, submitButton.frame.size.width,submitButton.frame.size.height);
            
            for (NSDictionary * dic in notesArr) {
                
                NSString * savedImagePath = [documentsDirectory stringByAppendingPathComponent:[dic valueForKey:kDenomImage]];
                
                UIImageView * denomImg = [[UIImageView alloc] init];
                denomImg.backgroundColor = [UIColor clearColor];
                denomImg.image = [UIImage imageWithContentsOfFile:savedImagePath];
                
                UIButton * addDenom = [[UIButton alloc] init];
                addDenom.backgroundColor = [UIColor clearColor];
                addDenom.tag = [[dic valueForKey:kDenomValue] integerValue];
                [addDenom addTarget:self action:@selector(addDenominations:) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton * removeDenom = [[UIButton alloc] init];
                removeDenom.backgroundColor = [UIColor clearColor];
                removeDenom.tag = [[dic valueForKey:kDenomValue] integerValue];
                [removeDenom addTarget:self action:@selector(removeDenominations:) forControlEvents:UIControlEventTouchUpInside];
                
                addDenomLbl = [[UILabel alloc] init];
                addDenomLbl.text = @"+";
                addDenomLbl.textColor = [UIColor whiteColor];
                
                UILabel * removeDenomLbl = [[UILabel alloc] init];
                removeDenomLbl.text = @"-";
                removeDenomLbl.textColor = [UIColor whiteColor];
                
                UILabel * denomValueMultiply = [[UILabel alloc]init];
                denomValueMultiply.textColor = [UIColor whiteColor];
                denomValueMultiply.text = [NSString stringWithFormat:@"%@",[[dic valueForKey:kDenomValue] stringValue]];
                denomValueMultiply.textAlignment = NSTextAlignmentCenter;
                
                UILabel * multiplyLabel = [[UILabel alloc]init];
                multiplyLabel.textColor = [UIColor whiteColor];
                multiplyLabel.text = @"X";
                multiplyLabel.textAlignment = NSTextAlignmentCenter;
                
                
                UILabel  * denomValue = [[UILabel alloc]init];
                denomValue.textColor = [UIColor whiteColor];
                denomValue.text = @"0.00";
                denomValue.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                denomValueTxt = [[UITextField alloc]init];
                denomValueTxt.borderStyle = UITextBorderStyleRoundedRect;
                denomValueTxt.textColor = [UIColor blackColor];
                denomValueTxt.font = [UIFont systemFontOfSize:18.0];
                denomValueTxt.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
                denomValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.keyboardType = UIKeyboardTypeNumberPad;
                denomValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
                denomValueTxt.layer.borderColor = [UIColor whiteColor].CGColor;
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.delegate = self;
                denomValueTxt.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    removeDenomLbl.frame = CGRectMake(xPosition , yPosition, 60, 30);
                    removeDenomLbl.font = [UIFont boldSystemFontOfSize:22];
                    
                    denomImg.frame = CGRectMake(xPosition, yPosition + removeDenomLbl.frame.size.height, 140, 60);
                    
                    addDenomLbl.frame = CGRectMake(xPosition + denomImg.frame.size.width - 20, yPosition, 60, 30);
                    addDenomLbl.font = [UIFont boldSystemFontOfSize:22];
                    
                    removeDenom.frame = CGRectMake(denomImg.frame.origin.x, denomImg.frame.origin.y, denomImg.frame.size.width/2, denomImg.frame.size.height);
                    addDenom.frame = CGRectMake(denomImg.frame.origin.x + (denomImg.frame.size.width/2), denomImg.frame.origin.y, denomImg.frame.size.width/2, denomImg.frame.size.height);
                    
                    denomValueMultiply.frame = CGRectMake(separationLabel2.frame.origin.x, textYposition, 80, 25);
                    denomValueMultiply.font = [UIFont boldSystemFontOfSize:20];
                    
                    multiplyLabel.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width - 6, denomValueMultiply.frame.origin.y,12,25);
                    multiplyLabel.font = [UIFont boldSystemFontOfSize:20];
                    
                    denomValueTxt.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width + 20,textYposition, 80, 25);
                    
                    denomValue.frame = CGRectMake(denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 10,textYposition, denomScrollView.frame.size.width - (denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 20), 25);
                    
                    //upto here on 29/08/2017....
                    denomValue.font = [UIFont systemFontOfSize:20.0];
                }
                
                xPosition = xPosition + denomImg.frame.size.width + 50;
                
                textYposition = textYposition + 38;
                
                if (index != 0 && (index%2) == 0) {
                    
                    yPosition = yPosition + denomImg.frame.size.height + addDenomLbl.frame.size.height + 10;
                    
                    xPosition = 10;
                }
                
                [denomNotesScrollView addSubview:addDenomLbl];
                [denomNotesScrollView addSubview:removeDenomLbl];
                [denomNotesScrollView addSubview:denomImg];
                [denomNotesScrollView addSubview:addDenom];
                [denomNotesScrollView addSubview:removeDenom];

                [denomScrollView addSubview:denomValueMultiply];
                [denomScrollView addSubview:multiplyLabel];
                [denomScrollView addSubview:denomValue];
                [denomScrollView addSubview:denomValueTxt];
                
                index++;
                
                [denomValTxtArr addObject:denomValueTxt];
                [denomCountArr addObject:denomValue];
            }
            
            index = 1;
            
            float coinsYPosition = 0;
            float coinsXPosition = loginNameLabel.frame.origin.x;
            
            for (NSDictionary * dic in coinsArr) {
                
                NSString * savedImagePath = [documentsDirectory stringByAppendingPathComponent:[dic valueForKey:kDenomImage]];
                
                UIImageView * denomImg = [[UIImageView alloc] init];
                denomImg.backgroundColor = [UIColor clearColor];
                denomImg.image = [UIImage imageWithContentsOfFile:savedImagePath];
                
                UIButton *addDenom = [[UIButton alloc] init];
                addDenom.backgroundColor = [UIColor clearColor];
                addDenom.tag = [[dic valueForKey:kDenomValue] integerValue];
                [addDenom addTarget:self action:@selector(addCoinsDenominations:) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton * removeDenom = [[UIButton alloc] init];
                removeDenom.backgroundColor = [UIColor clearColor];
                removeDenom.tag = [[dic valueForKey:kDenomValue] integerValue];
                [removeDenom addTarget:self action:@selector(removeCoinDenominations:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *addDenomLbl = [[UILabel alloc] init];
                addDenomLbl.text = @"+";
                addDenomLbl.textColor = [UIColor whiteColor];
                
                UILabel *removeDenomLbl = [[UILabel alloc] init];
                removeDenomLbl.text = @"-";
                removeDenomLbl.textColor = [UIColor whiteColor];
                
                UILabel  *denomValueMultiply = [[UILabel alloc]init];
                denomValueMultiply.textColor = [UIColor whiteColor];
                denomValueMultiply.text = [NSString stringWithFormat:@"%@",[[dic valueForKey:kDenomValue] stringValue]];
                denomValueMultiply.textAlignment = NSTextAlignmentCenter;
                
                UILabel * multiplyLabel = [[UILabel alloc]init];
                multiplyLabel.textColor = [UIColor whiteColor];
                multiplyLabel.text = @"X";
                multiplyLabel.textAlignment = NSTextAlignmentCenter;
                
                UILabel  *denomValue = [[UILabel alloc]init];
                denomValue.textColor = [UIColor whiteColor];
                denomValue.text = @"0.00";
                denomValue.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                denomValueTxt = [[UITextField alloc]init];
                denomValueTxt.borderStyle = UITextBorderStyleRoundedRect;
                denomValueTxt.textColor = [UIColor blackColor];
                denomValueTxt.font = [UIFont systemFontOfSize:18.0];
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.keyboardType = UIKeyboardTypeNumberPad;
                denomValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
                denomValueTxt.layer.borderColor = [UIColor whiteColor].CGColor;
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.delegate = self;
                denomValueTxt.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    removeDenomLbl.frame = CGRectMake(coinsXPosition ,coinsYPosition, 60, 30);
                    removeDenomLbl.font = [UIFont boldSystemFontOfSize:22];
                    
                    denomImg.frame = CGRectMake(coinsXPosition, coinsYPosition + removeDenomLbl.frame.size.height, 95, 85);
                    
                    addDenomLbl.frame = CGRectMake(coinsXPosition + denomImg.frame.size.width - 20, coinsYPosition, 60, 30);
                    addDenomLbl.font = [UIFont boldSystemFontOfSize:22];
                    
                    removeDenom.frame = CGRectMake(denomImg.frame.origin.x, denomImg.frame.origin.y, denomImg.frame.size.width/2, denomImg.frame.size.height);
                    
                    addDenom.frame = CGRectMake(denomImg.frame.origin.x + (denomImg.frame.size.width/2), denomImg.frame.origin.y, denomImg.frame.size.width/2, denomImg.frame.size.height);
                    
                    denomValueMultiply.frame = CGRectMake(separationLabel2.frame.origin.x, textYposition, 80, 25);
                    denomValueMultiply.font = [UIFont boldSystemFontOfSize:20];
                    
                    multiplyLabel.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width -6, denomValueMultiply.frame.origin.y,12,25);
                    multiplyLabel.font = [UIFont boldSystemFontOfSize:20];
                    
                    denomValueTxt.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width + 20,textYposition, 80, 25);
                    
                    denomValue.frame = CGRectMake( denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 10,textYposition, denomScrollView.frame.size.width - (denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 20), 25);
                    denomValue.font = [UIFont systemFontOfSize:20.0];
                    
                }
                
                coinsXPosition = coinsXPosition + denomImg.frame.size.height+addDenomLbl.frame.size.height ;
                textYposition = textYposition + 38;
                
                if (index != 0 && (index%3) == 0) {
                    
                    coinsYPosition = coinsYPosition + denomImg.frame.size.height+addDenomLbl.frame.size.height ;
                    
                    coinsXPosition = 10;
                }
                
                [denomCoinsScrollView addSubview:addDenomLbl];
                [denomCoinsScrollView addSubview:removeDenomLbl];
                [denomCoinsScrollView addSubview:denomImg];
                [denomCoinsScrollView addSubview:addDenom];
                [denomCoinsScrollView addSubview:removeDenom];
                
                [denomScrollView addSubview:denomValueMultiply];
                [denomScrollView addSubview:multiplyLabel];
                [denomScrollView addSubview:denomValue];
                [denomScrollView addSubview:denomValueTxt];
                
                index++;
                
                [denomValCoinsTxtArr addObject:denomValueTxt];
                [denomCountCoinsArr addObject:denomValue];
            }
            
            CGRect contentRect = CGRectZero;
            for (UIView *view in denomScrollView.subviews) {
                contentRect = CGRectUnion(contentRect, view.frame);
            }
            denomScrollView.contentSize = contentRect.size;
            
            textYposition = denomScrollView.frame.size.height + denomScrollView.frame.origin.y + 30;
            
            
            [denomScrollView addSubview:declaredCashLabel];
            [denomScrollView addSubview:separationLabel];
            [denomScrollView addSubview:verticalLabel];
            [denomScrollView addSubview:openingCashLabel];
            [denomScrollView addSubview:separationLabel2];
            [denomScrollView addSubview:verticalLabel2];
            
            [denominationView addSubview:separationLabel3];
            [denominationView addSubview:declaredCashValueLabel];
            [denominationView addSubview:separationLabel4];
            [denominationView addSubview:separationLabel5];
            [denominationView addSubview:openingCashValueLabel];
            [denominationView addSubview:separationLabel6];
            [denominationView addSubview:submitButton];
            [denominationView addSubview:skipButton];
           
            [denominationView addSubview:denomNotesScrollView];
            [denominationView addSubview:denomCoinsScrollView];
            [denominationView addSubview:denomScrollView];

            [dayStartView addSubview:denominationView];
        }
        else {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Denominations are not available" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}




/**
 * @description  here we are adding the denomination amount....
 * @date
 * @method       addDenominations:
 * @author
 * @param
 * @param
 * @param
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 18/11/2017....
 * @reason       added the comments....
 *
 * @verified By
 * @verified On
 *
 */

-(void)addDenominations:(UIButton *)sender {
  
    //Play Audio For Button touch...
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if ([[denominationDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
            
            NSString * str = [denominationDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            oneCount = (int)[str integerValue];
        }
        else {
            oneCount = 0;
        }
        oneCount++;
        oneQty.text = [NSString stringWithFormat:@"%d",(int)oneCount];
        if (oneCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            for (UITextField *text in denomValTxtArr) {
                
                if (text.tag == sender.tag) {
                    text.text = [NSString stringWithFormat:@"%d",oneCount];
                }
            }
            
            for (UILabel *text in denomCountArr) {
                
                if (text.tag == sender.tag) {
                    text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * sender.tag)];
                    
                }
            }
        }
        
        [self openCashAmount];

    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  here we are adding the denomination coins amount....
 * @date
 * @method       addCoinsDenominations:
 * @author
 * @param
 * @param
 * @param
 * @param
 * @param
 * @return       void
 * @modified By  Srinivasulu on 18/11/2017....
 * @reason       added the comments....
 * @verified By
 * @verified On
 *
 */

-(void)addCoinsDenominations:(UIButton*)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        
            if ([[denominationCoinDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
                
                NSString *str = [denominationCoinDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
                oneCount = (int)[str integerValue];
            }
            else {
                oneCount = 0;
            }
            oneCount++;
        oneQty.text = [NSString stringWithFormat:@"%d",oneCount];
            if (oneCount > 0) {
                [denominationCoinDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                
                for (UITextField *text in denomValCoinsTxtArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%d",oneCount];
                    }
                }
                
                for (UILabel *text in denomCountCoinsArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * sender.tag)];
                        
                    }
                }
            }
        
        [self openCashAmount];

    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  here we are removing the denomination note amount from the paid amount....
 * @date
 * @method       removeDenominations:
 * @author
 * @param
 * @param
 * @param
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 18/11/2017....
 * @reason       added the comments....
 *
 * @verified By
 * @verified On
 *
 */

-(void)removeDenominations:(UIButton*)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        if ([[denominationDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
            
            NSString *str = [denominationDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            oneCount = (int)[str integerValue];
        }
        else {
            oneCount = 0;
        }
        if (oneCount != 0) {
            oneCount--;
        }
        if (oneCount>=0) {
            if ([denominationDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
                for (UITextField *text in denomValTxtArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%d",oneCount];
                    }
                }
                
                for (UILabel *text in denomCountArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * sender.tag)];
                        
                    }
                }
            }
            if (oneCount == 0) {
                [denominationDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }
            else {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }
        }
        [self openCashAmount];
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  here we are removing the denomination coin amount from the paid amount....
 * @date
 * @method       removeCoinDenominations:
 * @author
 * @param
 * @param
 * @param
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 18/11/2017....
 * @reason       added the comments....
 *
 * @verified By
 * @verified On
 *
 */

-(void)removeCoinDenominations:(UIButton*)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        if ([[denominationCoinDic allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
            
            NSString *str = [denominationCoinDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            oneCount = (int)[str integerValue];
        }
        else {
            oneCount = 0;
        }
        if (oneCount != 0) {
            oneCount--;
        }
        if (oneCount>=0) {
            if ([denominationCoinDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
                for (UITextField *text in denomValCoinsTxtArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%d",oneCount];
                    }
                }
                
                for (UILabel *text in denomCountCoinsArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * sender.tag)];
                        
                    }
                }
            }
            if (oneCount == 0) {
                [denominationCoinDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }
            else {
                [denominationCoinDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }
        }
        [self openCashAmount];

    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  We are forming a denomination string...
 * @date         09/08/2018
 * @method       prepareDenominationString
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(NSArray *)prepareDenominationString {
    
    NSMutableArray * tempArr = [[NSMutableArray alloc]init];
    NSArray *keys = [NSArray arrayWithObjects:DENOMINATION_TYPE,DENOMINATION_VALUE,DENOMINATION_COUNT,TOTAL_VALUE,nil];
    
    @try {
        
        for (int i=0; i<[[denominationDic allKeys] count]; i++) {
            
            NSArray *objects = [NSArray arrayWithObjects:@"1",[[denominationDic allKeys] objectAtIndex:i],[denominationDic valueForKey:[[denominationDic allKeys] objectAtIndex:i]],[NSString stringWithFormat:@"%.2f",[[[denominationDic allKeys] objectAtIndex:i] floatValue]*[[denominationDic valueForKey:[[denominationDic allKeys] objectAtIndex:i]] intValue]], nil];
            
            NSDictionary * dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [tempArr addObject:dic];
            
        }
        for (int i=0; i<[[denominationCoinDic allKeys] count]; i++) {
            
            NSArray *objects = [NSArray arrayWithObjects:@"0",[[denominationCoinDic allKeys] objectAtIndex:i],[denominationCoinDic valueForKey:[[denominationCoinDic allKeys] objectAtIndex:i]],[NSString stringWithFormat:@"%.2f",[[[denominationCoinDic allKeys] objectAtIndex:i] floatValue]*[[denominationCoinDic valueForKey:[[denominationCoinDic allKeys] objectAtIndex:i]] intValue]], nil];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [tempArr addObject:dic];
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    
    return tempArr;
}


/**
 * @description  Forming the Request To create Day Open Summary
 * @date         09/05/2018
 * @method       callingDayOpenSummary..
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)callingDayOpenSummary {
    
    //Play Audio For Button Touch..
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if ([openingCashValueLabel.text floatValue] == 0) {
            
            float y_axis = self.view.frame.size.height - 120;

            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_enter_the_cash_before_you_submit",nil)];

            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];

        }
        
        else {
            [HUD show:YES];
            [HUD setHidden:NO];
            [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
            
            NSDate * today = [NSDate date];
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            NSString* currentdate = [f stringFromDate:today];
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            
            NSString * businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",[[currentdate componentsSeparatedByString:@" "] objectAtIndex:1]];
            
            //In future we can use this line of code to get build number....
            //NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
            
            //If we are expected to Read both version-ID and build number...
            //NSString * versionBuildString = [NSString stringWithFormat:@"Version: %@ (%@)", appVersionString, appBuildString];
            
            //To get the version Number....
            NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

            NSMutableDictionary * createDayOpenDictionary = [NSMutableDictionary new];
            
            [createDayOpenDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
            [createDayOpenDictionary setValue:presentLocation forKey:STORELOCATION];
            [createDayOpenDictionary setObject:NEGATIVE_ONE forKey:START_INDEX];
            [createDayOpenDictionary setValue:cashierId forKey:EMPLOYEE_ID];
            [createDayOpenDictionary setValue:mail_ forKey:USER_NAME];
            [createDayOpenDictionary setValue:counterIdStr forKey:COUNTER];
            [createDayOpenDictionary setObject:@"10" forKey:MAX_RECORDS];
            [createDayOpenDictionary setValue:shiftId forKey:SHIFT_ID];
            [createDayOpenDictionary setValue:roleName forKey:ROLE_NAME];
            [createDayOpenDictionary setValue:[NSString stringWithFormat:@"%@",currentdate] forKey:CREATED_Date];
            [createDayOpenDictionary setValue:[NSString stringWithFormat:@"%@",businessDate] forKey:BUSSINESS_DATE];
            [createDayOpenDictionary setValue:EMPTY_STRING forKey:kComments];
            
            [createDayOpenDictionary setValue:[NSNumber numberWithFloat:[openingCashValueLabel.text floatValue]] forKey:ACTUAL_AMT];
            [createDayOpenDictionary setValue:[NSNumber numberWithInt:0] forKey:ACTUAL_NOTE_COUNT];
            [createDayOpenDictionary setValue:[NSNumber numberWithFloat:0] forKey:CARRY_FORWARD_AMT];
            [createDayOpenDictionary setValue:[NSNumber numberWithInt:0] forKey:CARRY_FORWARD_NOTE_COUNT];
            
            [createDayOpenDictionary setValue:appVersionString forKey:VERSION_ID];
            
            NSArray * denomination_req = [self prepareDenominationString];
            
            [createDayOpenDictionary setValue:denomination_req forKey:DENOMINATION_LIST];

            NSError  * err;
            NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:createDayOpenDictionary options:0 error:&err];
            NSString * createJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController *webServiceController = [WebServiceController new];
            [webServiceController setDayOpenServiceDelegate:self];
            [webServiceController createDayOpenSummary:createJsonStr];
            
        }
    }
    @catch(NSException * exception){
        
    }
    @finally {
        
    }
}

/**
 * @description  Handling the Success Response...
 * @date         10/05/2018
 * @method       createDayOpenSummarySuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createDayOpenSummarySuccessResponse:(NSDictionary *)successDictionary {
 
    @try {
        
        [HUD setHidden: YES];
        
        //float y_axis = self.view.frame.size.height - 120;
        
        //Sound File Object after the Success Response.....
        SystemSoundID    soundFileObject1;
        NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);


        NSDictionary * successDic = [successDictionary valueForKey:RESPONSE_HEADER];
        
        NSString * message = [NSString stringWithFormat:@"%@",[successDic valueForKey:RESPONSE_MESSAGE]];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",message,@"\n",[successDictionary valueForKey:DAY_OPEN_ID]];

        conformationAlert =  [[UIAlertView alloc] initWithTitle:mesg message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [conformationAlert show];
        
        //[self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@"SUCCESS"  conentWidth:400 contentHeight:80  isSoundRequired:YES timing:8.0 noOfLines:3];

    }
    @catch(NSException * exception){
        
    }
    @finally {
        
        //Added By Bhargav.v on 13/08/2018..
        NSUserDefaults * dayOpenDefaults = [NSUserDefaults standardUserDefaults];
        [dayOpenDefaults setBool:YES forKey:IS_DAY_OPEN];
        [dayOpenDefaults synchronize];
        
    }
}

/**
 * @description  Handling the Error Response
 * @date         10/05/2018
 * @method       createDayOpenSummaryErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createDayOpenSummaryErrorResponse:(NSString *)errorResponse{
   
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];

    }
    @catch(NSException * exception){
        
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
            
            [self backAction];
        }


    }
}

#pragma mark   End of returning amount calculations -

/**
 * @description  here we are changing the value for paid amount through denominations....
 * @date
 * @method       openCashAmount
 * @author       Bhargav.v
 * @param
 * @param
 * @param
 * @param
 * @param
 * @return       void
 * @modified By  Srinivasulu on 18/11/2017....
 * @reason       added the comments....
 * @verified By
 * @verified On
 *
 */

- (void)openCashAmount {
    
    @try {
        
        NSMutableArray * count = [[denominationDic allValues] mutableCopy];
        NSMutableArray * denom = [[denominationDic allKeys] mutableCopy];
        
        [count addObjectsFromArray:[denominationCoinDic allValues]];
        [denom addObjectsFromArray:[denominationCoinDic allKeys]];
        
        float total = 0;
        
        for (int i=0; i<[denom count]; i++) {
            
            total += [[count objectAtIndex:i] floatValue] * [[denom objectAtIndex:i] floatValue];
        }
        
        openingCashValueLabel.text = [NSString stringWithFormat:@"%.2f",total];
        
    }
    @catch (NSException *exception) {
        
    }
}



/**
 * @description  dayClos
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
-(void)callingGetDayClosureSummary {
    
    @try {
        
        //Show the HUD
        [HUD show:YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];

        //NSDate * today = [NSDate date];
        //NSDateFormatter *f = [[NSDateFormatter alloc] init];
        //[f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        //NSString* currentdate = [f stringFromDate:today];
        
        NSMutableDictionary * dayClosureDic = [[NSMutableDictionary alloc] init];
        
        [dayClosureDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [dayClosureDic setValue:presentLocation forKey:STORELOCATION];
        [dayClosureDic setValue:cashierId forKey:EMPLOYEE_ID];
        [dayClosureDic setValue:counterName forKey:COUNTER];
        [dayClosureDic setValue:firstName forKey:USERNAME];
        [dayClosureDic setValue:roleName forKey:kUserRole];
        [dayClosureDic setValue:shiftId forKey:SHIFT_ID];
        [dayClosureDic setValue:@"1" forKey:kMaxRecords];
        [dayClosureDic setValue:@"0" forKey:TOTAL_BILLS];

        [dayClosureDic setValue:ZERO_CONSTANT forKey:START_INDEX];
        
        [dayClosureDic setValue:EMPTY_STRING forKey:kStartDate];
        [dayClosureDic setValue:EMPTY_STRING forKey:END_DATE];
      
        //[dayClosureDic setValue:currentdate forKey:BUSSINESS_DATE];
        
        //[dayClosureDic setValue:[NSNumber numberWithInt:0] forKey:DECLARED_AMT];
        //[dayClosureDic setValue:[NSNumber numberWithInt:0] forKey:EST_NOTE_COUNT];
        //[dayClosureDic setValue:[NSNumber numberWithFloat:0] forKey:CARRY_FORWARD_AMT];
        //[dayClosureDic setValue:[NSNumber numberWithInt:0] forKey:DECLARED_NOTE_COUNT];
        //[dayClosureDic setValue:[NSNumber numberWithInt:0] forKey:CARRY_FORWARD_NOTE_COUNT];

        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:dayClosureDic options:0 error:&err];
        NSString * dayClosureJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        [webServiceController setDayOpenServiceDelegate:self];
        [webServiceController getDayClosureSummary:dayClosureJsonStr];

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

-(void)getDayClosureSummarySuccessResponse:(NSDictionary*)successDictionary {
   
    @try {
        
        NSMutableArray * dayClosureCoinsArr = [NSMutableArray new];
        NSMutableArray * dayClosureNotesArr = [NSMutableArray new];
        
        NSMutableArray *   declardDenomValTxtArr = [NSMutableArray new];
        NSMutableArray *   declaredDenomCountArr = [NSMutableArray new];
        
        NSMutableArray *   declaredDenomCountCoinsArr = [NSMutableArray new];
        NSMutableArray *   declaredDenomValCoinsTxtArr = [NSMutableArray new];

        NSSortDescriptor * sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kDenomValue ascending:NO];
        
        //upto here on 16/08/2017....
        
        float declaredNoteCashValue = 0;
        float declaredCoinCashValue = 0;
        
        NSArray * dayClosure = [successDictionary objectForKey:DAY_CLOSURE];
        
        for (NSDictionary * infoDic in [[dayClosure objectAtIndex:0] valueForKey:DAY_CLOSURE_DENOMINATIONS]) {
            
            if (![[infoDic valueForKey:kDenomType] boolValue]) {
                
                [dayClosureCoinsArr addObject:infoDic];
            }
            else {
                
                [dayClosureNotesArr addObject:infoDic];
            }
        }
        
        NSArray * sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        dayClosureNotesArr = [[dayClosureNotesArr sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        dayClosureCoinsArr = [[dayClosureCoinsArr sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        
        int index = 1;
        float textYposition = 50;
        
        for (NSDictionary * dic in dayClosureNotesArr) {
            
            UILabel * denomValueMultiply = [[UILabel alloc]init];
            denomValueMultiply.textColor = [UIColor whiteColor];
            denomValueMultiply.text = [NSString stringWithFormat:@"%@",[[dic valueForKey:kDenomValue] stringValue]];
            denomValueMultiply.textAlignment = NSTextAlignmentCenter;
            
            UILabel * multiplyLabel = [[UILabel alloc]init];
            multiplyLabel.textColor = [UIColor whiteColor];
            multiplyLabel.text = @"X";
            multiplyLabel.textAlignment = NSTextAlignmentCenter;

            UILabel  * denomValue = [[UILabel alloc]init];
            denomValue.textColor = [UIColor whiteColor];
            denomValue.text = @"0.00";
            denomValue.tag = [[dic valueForKey:kDenomValue] integerValue];
            
            declaredDenomValueTxt = [[UITextField alloc]init];
            declaredDenomValueTxt.borderStyle = UITextBorderStyleRoundedRect;
            declaredDenomValueTxt.textColor = [UIColor blackColor];
            declaredDenomValueTxt.font = [UIFont systemFontOfSize:18.0];
            declaredDenomValueTxt.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            declaredDenomValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
            declaredDenomValueTxt.keyboardType = UIKeyboardTypeNumberPad;
            declaredDenomValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            declaredDenomValueTxt.layer.borderColor = [UIColor whiteColor].CGColor;
            declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
            declaredDenomValueTxt.userInteractionEnabled = NO;

            declaredDenomValueTxt.delegate = self;
            declaredDenomValueTxt.tag = [[dic valueForKey:kDenomValue] integerValue];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                denomValueMultiply.frame = CGRectMake(separationLabel.frame.origin.x, textYposition, 80, 25);
                denomValueMultiply.font = [UIFont boldSystemFontOfSize:20];
                
                multiplyLabel.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width - 6, denomValueMultiply.frame.origin.y,12,25);
                multiplyLabel.font = [UIFont boldSystemFontOfSize:20];

                declaredDenomValueTxt.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width + 20,textYposition, 80, 25);
                
                denomValue.frame = CGRectMake(declaredDenomValueTxt.frame.origin.x + declaredDenomValueTxt.frame.size.width + 10,textYposition, denomScrollView.frame.size.width - (declaredDenomValueTxt.frame.origin.x + declaredDenomValueTxt.frame.size.width + 20), 25);
                
                denomValue.font = [UIFont systemFontOfSize:20.0];
                
            }
            
            textYposition = textYposition + 38;
            
            [denomScrollView addSubview:denomValueMultiply];
            [denomScrollView addSubview:multiplyLabel];
            [denomScrollView addSubview:denomValue];
            
            [denomScrollView addSubview:declaredDenomValueTxt];
            
            index++;
            
            [declardDenomValTxtArr addObject:declaredDenomValueTxt];
            [declaredDenomCountArr addObject:denomValue];
            
            @try {
                
                
                declaredDenomValueTxt.text = [NSString stringWithFormat:@"%ld",(long)[[self checkGivenValueIsNullOrNil:[dic valueForKey:CARRY_FORWARD_COUNT] defaultReturn:@"0"] integerValue]];
                
                float carryForwardCount  = [[self checkGivenValueIsNullOrNil:[dic valueForKey:CARRY_FORWARD_COUNT] defaultReturn:@"0.00"] floatValue];
                float denominationValue  = [[self checkGivenValueIsNullOrNil:[dic valueForKey:kDenomValue] defaultReturn:@"0.00"] floatValue];
                
                denomValue.text =[NSString stringWithFormat:@"%.2f",(carryForwardCount * denominationValue)];
                
                declaredNoteCashValue += [denomValue.text  floatValue];
                
            }
            @catch(NSException * exception) {
                
            }
            @finally {
                
            }
        }
        
        for (NSDictionary * dic in dayClosureCoinsArr) {
            
            UILabel  *denomValueMultiply = [[UILabel alloc]init];
            denomValueMultiply.textColor = [UIColor whiteColor];
            denomValueMultiply.text = [NSString stringWithFormat:@"%@",[[dic valueForKey:kDenomValue] stringValue]];
            denomValueMultiply.textAlignment = NSTextAlignmentCenter;
            
            UILabel * multiplyLabel = [[UILabel alloc]init];
            multiplyLabel.textColor = [UIColor whiteColor];
            multiplyLabel.text = @"X";
            multiplyLabel.textAlignment = NSTextAlignmentCenter;

            UILabel * denomValue = [[UILabel alloc]init];
            denomValue.textColor = [UIColor whiteColor];
            denomValue.text = @"0.00";
            denomValue.tag = [[dic valueForKey:kDenomValue] integerValue];
            
            declaredDenomValueTxt = [[UITextField alloc]init];
            declaredDenomValueTxt.borderStyle = UITextBorderStyleRoundedRect;
            declaredDenomValueTxt.textColor = [UIColor blackColor];
            declaredDenomValueTxt.font = [UIFont systemFontOfSize:18.0];
            declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
            declaredDenomValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
            declaredDenomValueTxt.keyboardType = UIKeyboardTypeNumberPad;
            declaredDenomValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            declaredDenomValueTxt.layer.borderColor = [UIColor whiteColor].CGColor;
            declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
            declaredDenomValueTxt.userInteractionEnabled = NO;
            declaredDenomValueTxt.delegate = self;
            declaredDenomValueTxt.tag = [[dic valueForKey:kDenomValue] integerValue];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                denomValueMultiply.frame = CGRectMake(separationLabel.frame.origin.x, textYposition, 80, 25);
                denomValueMultiply.font = [UIFont boldSystemFontOfSize:20];
                
                multiplyLabel.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width - 6, denomValueMultiply.frame.origin.y,12,25);
                multiplyLabel.font = [UIFont boldSystemFontOfSize:20];

                declaredDenomValueTxt.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width + 20,textYposition, 80, 25);
                
                denomValue.frame = CGRectMake(declaredDenomValueTxt.frame.origin.x + declaredDenomValueTxt.frame.size.width + 10,textYposition, denomScrollView.frame.size.width - (declaredDenomValueTxt.frame.origin.x + declaredDenomValueTxt.frame.size.width + 20), 25);
                
                denomValue.font = [UIFont systemFontOfSize:20.0];
            
            }
            textYposition = textYposition + 38;
            
            [denomScrollView addSubview:denomValueMultiply];
            [denomScrollView addSubview:multiplyLabel];
            [denomScrollView addSubview:denomValue];
            [denomScrollView addSubview:declaredDenomValueTxt];
            
            index++;

            [declaredDenomValCoinsTxtArr addObject:declaredDenomValueTxt];
            [declaredDenomCountCoinsArr addObject:denomValue];
            
            @try {
                
                declaredDenomValueTxt.text = [NSString stringWithFormat:@"%ld",(long)[[self checkGivenValueIsNullOrNil:[dic valueForKey:CARRY_FORWARD_COUNT] defaultReturn:@"0"] integerValue]];
                
                float carryForwardCount  = [[self checkGivenValueIsNullOrNil:[dic valueForKey:CARRY_FORWARD_COUNT] defaultReturn:@"0.00"] floatValue];
                float denominationValue  = [[self checkGivenValueIsNullOrNil:[dic valueForKey:kDenomValue] defaultReturn:@"0.00"] floatValue];
                
                denomValue.text =[NSString stringWithFormat:@"%.2f",(carryForwardCount * denominationValue)];
                
                declaredCoinCashValue += [denomValue.text  floatValue];

            }
            @catch(NSException * exception) {
                
            }
            @finally {
            }
        }
        
        declaredCashValueLabel.text = [NSString stringWithFormat:@"%.2f",(declaredNoteCashValue + declaredCoinCashValue)];
       
        floatingCashValueLabel.text = [NSString stringWithFormat:@"%.2f",[declaredCashValueLabel.text floatValue]];
    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
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
-(void)getDayClosureSummaryErrorResponse:(NSString*)errorResponse {
 
    
            [HUD setHidden:YES];

    @try {
        
        
        NSMutableArray * denomValArr = [NSMutableArray new];
        NSMutableArray * denomArr = [NSMutableArray new];
        
        NSMutableArray *  denomCountArr = [NSMutableArray new];
        NSMutableArray *  denomCoinsTxtArr = [NSMutableArray new];
        
        int index = 1;
        float textYposition = 50;
        
        NSMutableArray * notesArr = [NSMutableArray new];
        NSMutableArray * coinsArr = [NSMutableArray new];
        
        OfflineBillingServices  * offline = [[OfflineBillingServices alloc] init];
        NSArray * denominations = [offline getDenominationDetails:@"INR"];
        
        if ([denominations count]) {
            
            for (NSDictionary * infoDic in denominations) {
                
                if (![[infoDic valueForKey:kDenomType] boolValue]) {
                    
                    [coinsArr addObject:infoDic];
                }
                else {
                    [notesArr addObject:infoDic];
                }
            }
            
            NSSortDescriptor * sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kDenomValue ascending:NO];
            
            for (NSDictionary * dic in notesArr) {
                
                UILabel * denomValueMultiply = [[UILabel alloc]init];
                denomValueMultiply.textColor = [UIColor whiteColor];
                denomValueMultiply.text = [NSString stringWithFormat:@"%@",[[dic valueForKey:kDenomValue] stringValue]];
                denomValueMultiply.textAlignment = NSTextAlignmentCenter;
                
                UILabel * multiplyLabel = [[UILabel alloc]init];
                multiplyLabel.textColor = [UIColor whiteColor];
                multiplyLabel.text = @"X";
                multiplyLabel.textAlignment = NSTextAlignmentCenter;

                
                UILabel  * denomValue = [[UILabel alloc]init];
                denomValue.textColor = [UIColor whiteColor];
                denomValue.text = @"0.00";
                denomValue.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                declaredDenomValueTxt = [[UITextField alloc]init];
                declaredDenomValueTxt.borderStyle = UITextBorderStyleRoundedRect;
                declaredDenomValueTxt.textColor = [UIColor blackColor];
                declaredDenomValueTxt.font = [UIFont systemFontOfSize:18.0];
                declaredDenomValueTxt.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
                declaredDenomValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
                declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
                declaredDenomValueTxt.keyboardType = UIKeyboardTypeNumberPad;
                declaredDenomValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
                declaredDenomValueTxt.layer.borderColor = [UIColor whiteColor].CGColor;
                declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
                declaredDenomValueTxt.userInteractionEnabled = NO;
                declaredDenomValueTxt.delegate = self;
                declaredDenomValueTxt.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    denomValueMultiply.frame = CGRectMake(separationLabel.frame.origin.x, textYposition, 80, 25);
                    denomValueMultiply.font = [UIFont boldSystemFontOfSize:20];
                    
                    multiplyLabel.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width - 6, denomValueMultiply.frame.origin.y,12,25);
                    multiplyLabel.font = [UIFont boldSystemFontOfSize:20];

                    declaredDenomValueTxt.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width + 20,textYposition, 80, 25);
                    
                    denomValue.frame = CGRectMake(declaredDenomValueTxt.frame.origin.x + declaredDenomValueTxt.frame.size.width + 10,textYposition, denomScrollView.frame.size.width - (declaredDenomValueTxt.frame.origin.x + declaredDenomValueTxt.frame.size.width + 20), 25);
                    
                    denomValue.font = [UIFont systemFontOfSize:20.0];
                    
                }
                
                textYposition = textYposition + 38;
                
                [denomScrollView addSubview:denomValueMultiply];
                [denomScrollView addSubview:multiplyLabel];
                [denomScrollView addSubview:denomValue];
                [denomScrollView addSubview:declaredDenomValueTxt];
                
                index++;
                
                [denomValArr addObject:declaredDenomValueTxt];
                [denomArr addObject:denomValue];
                
            }
            
            for (NSDictionary * dic in coinsArr) {
                
                UILabel * denomValueMultiply = [[UILabel alloc]init];
                denomValueMultiply.textColor = [UIColor whiteColor];
                denomValueMultiply.text = [NSString stringWithFormat:@"%@",[[dic valueForKey:kDenomValue] stringValue]];
                denomValueMultiply.textAlignment = NSTextAlignmentCenter;
                
                UILabel * multiplyLabel = [[UILabel alloc]init];
                multiplyLabel.textColor = [UIColor whiteColor];
                multiplyLabel.text = @"X";
                multiplyLabel.textAlignment = NSTextAlignmentCenter;

                UILabel  *denomValue = [[UILabel alloc]init];
                denomValue.textColor = [UIColor whiteColor];
                denomValue.text = @"0.00";
                denomValue.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                declaredDenomValueTxt = [[UITextField alloc]init];
                declaredDenomValueTxt.borderStyle = UITextBorderStyleRoundedRect;
                declaredDenomValueTxt.textColor = [UIColor blackColor];
                declaredDenomValueTxt.font = [UIFont systemFontOfSize:18.0];
                declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
                declaredDenomValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
                declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
                declaredDenomValueTxt.keyboardType = UIKeyboardTypeNumberPad;
                declaredDenomValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
                declaredDenomValueTxt.layer.borderColor = [UIColor whiteColor].CGColor;
                declaredDenomValueTxt.backgroundColor = [UIColor whiteColor];
                declaredDenomValueTxt.userInteractionEnabled = NO;
                
                declaredDenomValueTxt.delegate = self;
                declaredDenomValueTxt.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    denomValueMultiply.frame = CGRectMake(separationLabel.frame.origin.x, textYposition, 80, 25);
                    denomValueMultiply.font = [UIFont boldSystemFontOfSize:20];
                    
                    multiplyLabel.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width - 6, denomValueMultiply.frame.origin.y,12,25);
                    multiplyLabel.font = [UIFont boldSystemFontOfSize:20];

                    declaredDenomValueTxt.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width + 20,textYposition, 80, 25);
                    
                    denomValue.frame = CGRectMake( declaredDenomValueTxt.frame.origin.x + declaredDenomValueTxt.frame.size.width + 10,textYposition, denomScrollView.frame.size.width - (declaredDenomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 20), 25);
                    
                    denomValue.font = [UIFont systemFontOfSize:20.0];
                    
                }
                textYposition = textYposition + 38;
                
                [denomScrollView addSubview:denomValueMultiply];
                [denomScrollView addSubview:multiplyLabel];
                [denomScrollView addSubview:denomValue];
                [denomScrollView addSubview:declaredDenomValueTxt];
                
                index++;
                
                [denomCountArr addObject:declaredDenomValueTxt];
                [denomCoinsTxtArr addObject:denomValue];
                
            }
        }
    }
    @catch(NSException * exception) {
    
    }
    
    @finally {
    
    }
}


#pragma -mark Start of TextFieldDelegates.......

/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date
 * @method       textFieldShouldBeginEditing:
 * @author
 * @param        UITextField
 * @param
 * @param
 * @return
 * @modified By  Srinivasulu on 30/08/2017....
 * @reason       added the comment's....
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
    
}


/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date
 * @method       textFieldDidBeginEditing:
 * @author
 * @param        UITextField
 * @param
 * @param
 * @return
 *
 * @modified By  Srinivasulu on 30/08/2017 && on 22/03/2018....
 * @reason       added the comment's added deminations handling....
 *
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
     if(textField.frame.origin.x == denomValueTxt.frame.origin.x){
        
        @try {
            offSetViewTo = textField.frame.origin.y;
            
            [self keyboardWillShow];
            
        } @catch (NSException *exception) {
            
        }
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    @try {
        
        if(textField.frame.origin.x == denomValueTxt.frame.origin.x){
            @try {
                
                NSUInteger lengthOfString = string.length;
                for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                    unichar character = [string characterAtIndex:loopIndex];
                    if (character < 48) return NO; // 48 unichar for 0
                    if (character > 57) return NO; // 57 unichar for 9
                }
                
            } @catch (NSException *exception) {
                return  YES;
                
                NSLog(@"----exception in homepage ----");
                NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            }
        }
        
        
        return  YES;
    }
    @catch (NSException *exception) {
    }
}
        

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    @try {
        
        [self keyboardWillHide];
        offSetViewTo =  0;
    } @catch (NSException *exception) {
        
    }
    
    if(textField.frame.origin.x == denomValueTxt.frame.origin.x){
        
        float textFieldCount = textField.frame.origin.y/95;
        
        if(textFieldCount > [denomCountCoinsArr count]){
            
            oneCount = 0;
            oneCount = [textField.text intValue];
            
            //here we are checking whether user entered any text or not....
            
            if (oneCount > 0) {
                
                [denominationCoinDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
                
            }
            else{
                
                if ([[denominationCoinDic allKeys] containsObject:[NSString stringWithFormat:@"%d",(int)textField.tag]]) {
                    [denominationCoinDic removeObjectForKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
                }
            }
            
            for (UITextField *text in denomValCoinsTxtArr) {
                
                if (text.tag == textField.tag) {
                    text.text = [NSString stringWithFormat:@"%d",oneCount];
                    
                    break;
                }
            }
            
            for (UILabel *text in denomCountCoinsArr) {
                
                if (text.tag == textField.tag) {
                    text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * textField.tag)];
                    break;
                    
                }
            }
        }
        else{
            
            
            oneCount = 0;
            oneCount = [textField.text intValue];
            tensQty.text = [NSString stringWithFormat:@"%d",tensCount];
            if (oneCount > 0) {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
                
            }
            else{
                tenValue.text = [NSString stringWithFormat:@"%.2f",(tensCount * 10.00)];
                if ([[denominationDic allKeys] containsObject:[NSString stringWithFormat:@"%d",(int)textField.tag]]) {
                    [denominationDic removeObjectForKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
                }
            }
            
            for (UITextField *text in denomValTxtArr) {
                
                if (text.tag == textField.tag) {
                    text.text = [NSString stringWithFormat:@"%d",oneCount];
                    
                }
            }
            
            for (UILabel *text in denomCountArr) {
                
                if (text.tag == textField.tag) {
                    text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * textField.tag)];
                    
                }
            }
        }
    }
    
    [self openCashAmount];
}


/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input.........
 * @date
 * @method       textFieldShouldReturn:
 * @author
 * @param        UITextField
 * @param
 * @param
 * @return
 *
 * @modified By  Srinivasulu on 30/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
 
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma -mark keyboard notification methods

/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       keyboardWillShow
 * @author       Srinivasulu
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
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  called when keyboard is dismissed
 * @date         04/06/2016
 * @method       keyboardWillHide
 * @author       Srinivasulu
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
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  method to move the view up/down whenever the keyboard is shown/dismissed
 * @date         04/06/2016
 * @method       setViewMovedUp
 * @author       Srinivasulu
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
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
    
}

/**
 * @description  
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
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timing:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines {
    
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
            
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
        userAlertMessageLbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        userAlertMessageLbl.layer.cornerRadius = 0.0f;
        userAlertMessageLbl.layer.borderWidth = 2.70f;
        userAlertMessageLbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        userAlertMessageLbl.text =  message;
        userAlertMessageLbl.textAlignment = NSTextAlignmentCenter;
        userAlertMessageLbl.numberOfLines = noOfLines;
        
        
        
        userAlertMessageLbl.tag = 2;
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame) {
            userAlertMessageLbl.tag = 4;
            
            userAlertMessageLbl.textColor = [UIColor colorWithRed:114.0/255.0 green:203.0/255.0 blue:158.0/255.0 alpha:1.0];
            
            if(soundStatus){
                
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        else{
            userAlertMessageLbl.textColor = [UIColor redColor];
            
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
            if (version > 8.0) {
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                
            }
            else{
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                
            }
            
        }
        
        //added by Srinivasulu on 11/12/2017....
        
        userAlertMessageLbl.backgroundColor = [UIColor whiteColor];
        userAlertMessageLbl.textColor = [UIColor blackColor];
        
        //upto here on 11/12/2017....
        
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


/**
 * @description
 * @date
 * @method       cancelRequest
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)skipButtonPressed:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        NSUserDefaults * dayOpenDefaults = [NSUserDefaults standardUserDefaults];
        [dayOpenDefaults setBool:YES forKey:IS_DAY_OPEN];
        [dayOpenDefaults synchronize];
        [self backAction];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         07/05/2017....
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (id)checkGivenValueIsNullOrNil:(id)inputValue defaultReturn:(NSString *)returnStirng {
    
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
