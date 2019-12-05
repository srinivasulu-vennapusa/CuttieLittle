//
//  PastBillsList.m
//  OmniRetailer
//
//  Created by Bhargav Ram on 11/18/16.
//
//

#import "Global.h"
#import "OfflineBillingServices.h"
#import "OmniHomePage.h"
#import "PastBillsList.h"
#import "PendingBills.h"

int past_bill_no = 0;


@interface PastBillsList ()

@end

@implementation PastBillsList
@synthesize soundFileURLRef,soundFileObject;

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
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {
    
    //calling super call method....
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
    //it was commented before itself.... written by Srinivsulu on 09/06/2017....
    
    // [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    
    //setting the background colour of the self.view....
    self.view.backgroundColor = [UIColor blackColor];
    
    //reading os version of the build installed device and storing....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    
    //ProgressBar creation...
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
    
    //    Desigining the main view:
    self.titleLabel.text = NSLocalizedString(@"past_bill", nil);
    
    pastBillView = [[UIView alloc] init];
    pastBillView.backgroundColor = [UIColor blackColor];
    pastBillView.layer.borderWidth = 1.0f;
    pastBillView.layer.cornerRadius = 10.0f;
    pastBillView.layer.borderColor = [UIColor clearColor].CGColor;
    
    /*Creation of UIButton for providing user to get th info.......*/
    UIButton *summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *summaryImage = [UIImage imageNamed:@"summaryInfo.png"];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self
                       action:@selector(displaySummaryInfo:) forControlEvents:UIControlEventTouchDown];
    
    
    /*Creation of UITextFields for providing user to search the fields.......*/
    
    pastBillField = [[UITextField alloc] init];
    pastBillField.borderStyle = UITextBorderStyleRoundedRect;
    pastBillField.textColor = [UIColor blackColor];
    pastBillField.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7 ];
    pastBillField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pastBillField.autocorrectionType = UITextAutocorrectionTypeNo;
    pastBillField.returnKeyType = UIReturnKeyDone;
    [pastBillField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    pastBillField.delegate = self;
    pastBillField.placeholder = @"Search Bills";
    
    
    
    startDateField = [[CustomTextField alloc] init];
    startDateField.borderStyle = UITextBorderStyleRoundedRect;
    startDateField.textColor = [UIColor blackColor];
    startDateField.font = [UIFont systemFontOfSize:18.0];
    startDateField.backgroundColor = [UIColor clearColor];
    //    startDateField.text = currentdate;
    startDateField.userInteractionEnabled = NO;
    startDateField.clearButtonMode = UITextFieldViewModeWhileEditing;
    startDateField.autocorrectionType = UITextAutocorrectionTypeNo;
    startDateField.layer.borderWidth = 1.0f;
    startDateField.layer.cornerRadius = 10.0f;
    startDateField.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    startDateField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    startDateField.delegate = self;
    startDateField.placeholder = NSLocalizedString(@"Start Date", nil);
    [startDateField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    startDateField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:startDateField.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    startDateField.tag = 2;
    
    
    UIImage *billImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * billDteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [billDteButton setBackgroundImage:billImg forState:UIControlStateNormal];
    [billDteButton addTarget:self
                      action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    billDteButton.userInteractionEnabled = YES;
    billDteButton.tag = 2;
    
    endDateField = [[CustomTextField alloc] init];
    endDateField.borderStyle = UITextBorderStyleRoundedRect;
    endDateField.textColor = [UIColor blackColor];
    endDateField.font = [UIFont systemFontOfSize:18.0];
    endDateField.backgroundColor = [UIColor clearColor];
    //    startDateField.text = currentdate;
    endDateField.userInteractionEnabled = NO;
    endDateField.clearButtonMode = UITextFieldViewModeWhileEditing;
    endDateField.autocorrectionType = UITextAutocorrectionTypeNo;
    endDateField.layer.borderWidth = 1.0f;
    endDateField.layer.cornerRadius = 10.0f;
    endDateField.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    endDateField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    endDateField.delegate = self;
    endDateField.placeholder = NSLocalizedString(@"End Date", nil);
    [endDateField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    endDateField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:endDateField.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    UIButton * endDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [endDateButton setBackgroundImage:billImg forState:UIControlStateNormal];
    [endDateButton addTarget:self
                      action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    endDateButton.userInteractionEnabled = YES;
    
    
    
    userMobileNoFld = [[CustomTextField alloc] init];
    userMobileNoFld.borderStyle = UITextBorderStyleRoundedRect;
    userMobileNoFld.textColor = [UIColor blackColor];
    userMobileNoFld.font = [UIFont systemFontOfSize:18.0];
    userMobileNoFld.backgroundColor = [UIColor clearColor];
    userMobileNoFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    userMobileNoFld.autocorrectionType = UITextAutocorrectionTypeNo;
    userMobileNoFld.layer.borderWidth = 1.0f;
    userMobileNoFld.layer.cornerRadius = 10.0f;
    userMobileNoFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    userMobileNoFld.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    userMobileNoFld.delegate = self;
    userMobileNoFld.placeholder = NSLocalizedString(@"Mobile Number", nil);
    [userMobileNoFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    userMobileNoFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:userMobileNoFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    
    submitBtn = [[UIButton alloc] init] ;
    [submitBtn setTitle:@"Go" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    [submitBtn addTarget:self action:@selector(submitBtnPressed:) forControlEvents:UIControlEventTouchDown];
    submitBtn.userInteractionEnabled = YES;
    submitBtn.layer.cornerRadius = 6.0f;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    submitBtn.tag = 2;
    
    
    
    /* creation of header label: */
    
    sNoLbl = [[UILabel alloc] init];
    sNoLbl.layer.cornerRadius = 5;
    sNoLbl.layer.masksToBounds = YES;
    sNoLbl.numberOfLines = 1;
    sNoLbl.textAlignment = NSTextAlignmentCenter;
    sNoLbl.font = [UIFont boldSystemFontOfSize:14.0];
    sNoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    sNoLbl.textColor = [UIColor whiteColor];
    
    
    billIdLbl = [[UILabel alloc] init];
    billIdLbl.layer.cornerRadius = 5;
    billIdLbl.layer.masksToBounds = YES;
    billIdLbl.numberOfLines = 1;
    billIdLbl.textAlignment = NSTextAlignmentCenter;
    billIdLbl.font = [UIFont boldSystemFontOfSize:14.0];
    billIdLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billIdLbl.textColor = [UIColor whiteColor];
    
    
    dateLbl = [[UILabel alloc] init];
    dateLbl.layer.cornerRadius = 5;
    dateLbl.layer.masksToBounds = YES;
    dateLbl.numberOfLines = 1;
    dateLbl.textAlignment = NSTextAlignmentCenter;
    dateLbl.font = [UIFont boldSystemFontOfSize:14.0];
    dateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    dateLbl.textColor = [UIColor whiteColor];
    
    
    
    counterLbl = [[UILabel alloc] init];
    counterLbl.layer.cornerRadius = 5;
    counterLbl.layer.masksToBounds = YES;
    counterLbl.numberOfLines = 1;
    counterLbl.textAlignment = NSTextAlignmentCenter;
    counterLbl.font = [UIFont boldSystemFontOfSize:14.0];
    counterLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    counterLbl.textColor = [UIColor whiteColor];
    
    userNameLbl = [[UILabel alloc] init];
    userNameLbl.layer.cornerRadius = 5;
    userNameLbl.layer.masksToBounds = YES;
    userNameLbl.numberOfLines = 1;
    userNameLbl.textAlignment = NSTextAlignmentCenter;
    userNameLbl.font = [UIFont boldSystemFontOfSize:14.0];
    userNameLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    userNameLbl.textColor = [UIColor whiteColor];
    
    
    billDueLbl = [[UILabel alloc] init];
    billDueLbl.layer.cornerRadius = 5;
    billDueLbl.layer.masksToBounds = YES;
    billDueLbl.numberOfLines = 1;
    billDueLbl.textAlignment = NSTextAlignmentCenter;
    billDueLbl.font = [UIFont boldSystemFontOfSize:14.0];
    billDueLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billDueLbl.textColor = [UIColor whiteColor];
    
    
    //added by Srinivasulu on 26/07/2017....
    
    //creation of UIScrollView....
    itemsScrollView = [[UIScrollView alloc] init];
    
    syncStatusLbl = [[UILabel alloc] init];
    syncStatusLbl.layer.cornerRadius = 5;
    syncStatusLbl.layer.masksToBounds = YES;
    syncStatusLbl.numberOfLines = 1;
    syncStatusLbl.textAlignment = NSTextAlignmentCenter;
    syncStatusLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    syncStatusLbl.textColor = [UIColor whiteColor];
    
    
    
    //added by Srinivasulu on 06/08/2017....
    
    billAmountLbl = [[UILabel alloc] init];
    billAmountLbl.layer.cornerRadius = 5;
    billAmountLbl.layer.masksToBounds = YES;
    billAmountLbl.numberOfLines = 1;
    billAmountLbl.textAlignment = NSTextAlignmentCenter;
    billAmountLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billAmountLbl.textColor = [UIColor whiteColor];
    
    //upto here on 06/08/2017....
    
    //upto here on 26/07/2017....
    
    
    //added by Srinivasulu on 16/10/2017....
    
    billDoneModeLbl = [[UILabel alloc] init];
    billDoneModeLbl.layer.cornerRadius = 5;
    billDoneModeLbl.layer.masksToBounds = YES;
    billDoneModeLbl.numberOfLines = 1;
    billDoneModeLbl.textAlignment = NSTextAlignmentCenter;
    billDoneModeLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billDoneModeLbl.textColor = [UIColor whiteColor];
    
    //upto here on 16/10/2017....
    
    
    
    // Added By Bhargav.v on 20/02/2018....
    // Allocation of UIElements for the pagenation
    
    UIImage * buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];
    
    pagenationTxt = [[CustomTextField alloc] init];
    pagenationTxt.userInteractionEnabled = NO;
    pagenationTxt.textAlignment = NSTextAlignmentCenter;
    pagenationTxt.delegate = self;
    [pagenationTxt awakeFromNib];
    
    UIButton * dropDownBtn;
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
    [dropDownBtn addTarget:self
                    action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    
    //creating the UIButton which are used to show CustomerInfo popUp.......
    UIButton * goButton;
    
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressed:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    
    // pagenationTbl  allocation...
    pagenationTbl = [[UITableView alloc] init];
    
    
    //Allocation of UIView....
    totalRecordsView = [[UIView alloc]init];
    totalRecordsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalRecordsView.layer.borderWidth =3.0f;
    
    UILabel * totalRecordsLabel;
    
    totalRecordsLabel = [[UILabel alloc] init];
    totalRecordsLabel.layer.masksToBounds = YES;
    totalRecordsLabel.numberOfLines = 1;

    totalRecordsLabel.textColor = [UIColor whiteColor];
    
    totalRecordsValueLabel = [[UILabel alloc] init];
    totalRecordsValueLabel.layer.masksToBounds = YES;
    totalRecordsValueLabel.numberOfLines = 1;
    totalRecordsValueLabel.textColor = [UIColor whiteColor];
    
    totalRecordsLabel.textColor      = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalRecordsValueLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalRecordsLabel.textAlignment = NSTextAlignmentLeft;
    totalRecordsValueLabel.textAlignment = NSTextAlignmentRight;
    
    //up to here on 20/02/2018....
    
    
    // localised strings:
    
    //added by Srinivasulu on 16/10/2017....
    //added the expection handling.. -----
    
    @try {
        
        
        sNoLbl.text = NSLocalizedString(@"S_NO",nil);
        billIdLbl.text = NSLocalizedString(@"bill_id",nil);
        dateLbl.text = NSLocalizedString(@"date", nil);
        counterLbl.text = NSLocalizedString(@"counter",nil);
        userNameLbl.text = NSLocalizedString(@"name",nil);
        billDueLbl.text = NSLocalizedString(@"bill_due",nil);
        
        syncStatusLbl.text = NSLocalizedString(@"sync_status", nil);
        billAmountLbl.text = NSLocalizedString(@"bill_amt", nil);
        
        billDoneModeLbl.text = NSLocalizedString(@"bill_mode", nil);
        
        //    font for the labels:
        
        //        sNoLbl.font = [UIFont boldSystemFontOfSize:20];
        //        billIdLbl.font = [UIFont boldSystemFontOfSize:20];
        //        dateLbl.font = [UIFont boldSystemFontOfSize:20];
        //        counterLbl.font = [UIFont boldSystemFontOfSize:20];
        //        userNameLbl.font = [UIFont boldSystemFontOfSize:20];
        //        billDueLbl.font = [UIFont boldSystemFontOfSize:20];
        //        syncStatusLbl.font = [UIFont boldSystemFontOfSize:20.0];
        //        billAmountLbl.font = [UIFont boldSystemFontOfSize:20];
        //        billDoneModeLbl.font = [UIFont boldSystemFontOfSize:20.0];
        
        sNoLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        billIdLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        dateLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        counterLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        userNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        billDueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        syncStatusLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        billAmountLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        billDoneModeLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        // Added By Bhargav.v on 20/02/2018....
        
        totalRecordsLabel.text =  NSLocalizedString(@"total_records_", nil);
        totalRecordsValueLabel.text = @"0";
        
        totalRecordsLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        totalRecordsValueLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        pagenationTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        //up to here on 20/02/2018....--
        
    } @catch (NSException *exception) {
        
    }
    
    
    
    
    // creation of UItableView:
    
    pastBillsTbl = [[UITableView alloc] init];
    pastBillsTbl.dataSource = self;
    pastBillsTbl.delegate = self;
    pastBillsTbl.backgroundColor = [UIColor clearColor];
    pastBillsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    salesIdTable = [[UITableView alloc] init];
    salesIdTable.layer.borderWidth = 1.0;
    salesIdTable.layer.cornerRadius = 4.0;
    salesIdTable.layer.borderColor = [UIColor grayColor].CGColor;
    salesIdTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    salesIdTable.dataSource = self;
    salesIdTable.delegate = self;
    salesIdTable.hidden = YES;
    
    
    
    
    
    [pastBillView addSubview:summaryInfoBtn];
    [pastBillView addSubview:pastBillField];
    [pastBillView addSubview:startDateField];
    [pastBillView addSubview:billDteButton];
    [pastBillView addSubview:endDateField];
    [pastBillView addSubview:endDateButton];
    [pastBillView addSubview:userMobileNoFld];
    [pastBillView addSubview: submitBtn];
    
    
    //    adding labels to the return bill view:
    
    //changed by Srinivasulu on 26/07/2017....
    
    //    [pastBillView addSubview:sNoLbl];
    //    [pastBillView addSubview:billIdLbl];
    //    [pastBillView addSubview:dateLbl];
    //    [pastBillView addSubview:counterLbl];
    //    [pastBillView addSubview:userNameLbl];
    //    [pastBillView addSubview:billDueLbl];
    //
    //    [pastBillView addSubview:pastBillsTbl];
    //    [pastBillView addSubview:salesIdTable];
    
    //itemsScrollView
    
    [itemsScrollView addSubview:sNoLbl];
    [itemsScrollView addSubview:billIdLbl];
    [itemsScrollView addSubview:dateLbl];
    [itemsScrollView addSubview:counterLbl];
    [itemsScrollView addSubview:userNameLbl];
    [itemsScrollView addSubview:billDueLbl];
    
    
    //    if(isOfflineService){
    [itemsScrollView addSubview:syncStatusLbl];
    
    //added by Srinivasulu on 06/08/2017....
    
    [itemsScrollView addSubview:billAmountLbl];
    
    //upto here on 06/08/2017....
    
    //    }
    
    //added by Srinivasulu on 16/10/2017....
    
    [itemsScrollView addSubview:billDoneModeLbl];
    
    //upto here on 16/10/2017....
    
    [itemsScrollView addSubview:pastBillsTbl];
    
    [pastBillView addSubview:itemsScrollView];
    
    //upto here on 26/07/2017....
    
    // Added By Bhargav.v on 20/02/2018.....
    
    [pastBillView addSubview:pagenationTxt];
    [pastBillView addSubview:dropDownBtn];
    [pastBillView addSubview:goButton];
    
    [totalRecordsView addSubview:totalRecordsLabel];
    [totalRecordsView addSubview:totalRecordsValueLabel];
    [pastBillView addSubview:totalRecordsView];
    
    //upto here on 20/02/2018....
    
    [self.view addSubview:pastBillView];
    
    //    frame for the view:
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            @try {
                
                
                pastBillView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
                summaryInfoBtn.frame = CGRectMake(pastBillView.frame.size.width - 58,10, 40, 30);
                
                pastBillField  .font = [UIFont boldSystemFontOfSize:20];
                pastBillField.frame = CGRectMake(pastBillView.frame.origin.x+20, summaryInfoBtn.frame.origin.y+40, 250, 40);
                salesIdTable.frame = CGRectMake(pastBillField.frame.origin.x, pastBillField.frame.origin.y+pastBillField.frame.size.height, pastBillField.frame.size.width, 280);
                
                
                
                userMobileNoFld.font = [UIFont boldSystemFontOfSize:20];
                userMobileNoFld.frame = CGRectMake(pastBillField.frame.origin.x+pastBillField.frame.size.width+65 , pastBillField.frame.origin.y, 180, 40);
                
                
                startDateField.font = [UIFont boldSystemFontOfSize:20];
                
                startDateField.frame = CGRectMake(userMobileNoFld.frame.origin.x+userMobileNoFld.frame.size.width+15 , pastBillField.frame.origin.y, 180, 40);
                
                
                billDteButton.frame = CGRectMake((startDateField.frame.origin.x+startDateField.frame.size.width-45), startDateField.frame.origin.y+  2, 40, 35);
                
                endDateField.font = [UIFont boldSystemFontOfSize:20];
                
                endDateField.frame = CGRectMake(startDateField.frame.origin.x+startDateField.frame.size.width+15 , pastBillField.frame.origin.y, 180, 40);
                
                endDateButton .frame = CGRectMake((endDateField.frame.origin.x+endDateField.frame.size.width-45), endDateField.frame.origin.y+2, 40, 35);
                
                submitBtn.frame  = CGRectMake(endDateField.frame.origin.x+endDateField.frame.size.width+10, endDateField.frame.origin.y, 80, 40);
                
                //changed by Srinivasulu on 27/07/2017....
                itemsScrollView.frame = CGRectMake( pastBillField.frame.origin.x, pastBillField.frame.origin.y+pastBillField.frame.size.height+10, (summaryInfoBtn.frame.origin.x + summaryInfoBtn.frame.size.width) - pastBillField.frame.origin.x, pastBillView.frame.size.height - (pastBillField.frame.origin.y + pastBillField.frame.size.height  +  60));
                
                //                itemsScrollView.backgroundColor = [UIColor redColor];
                
                sNoLbl.frame = CGRectMake( 0, 0, 60, 38);
                
                billIdLbl.frame = CGRectMake((sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 210, sNoLbl.frame.size.height);
                
                dateLbl.frame = CGRectMake((billIdLbl.frame.origin.x + billIdLbl.frame.size.width + 2), billIdLbl.frame.origin.y, 110, sNoLbl.frame.size.height);
                
                counterLbl.frame = CGRectMake((dateLbl.frame.origin.x + dateLbl.frame.size.width + 2), dateLbl.frame.origin.y, 90, sNoLbl.frame.size.height);
                
                userNameLbl.frame = CGRectMake((counterLbl.frame.origin.x + counterLbl.frame.size.width + 2), counterLbl.frame.origin.y, 140, sNoLbl.frame.size.height);
                
                
                
                //added by Srinivasulu on 06/08/2017....
                //changed by Srinivasulu on 06/08/2017....
                
                billAmountLbl.frame = CGRectMake((userNameLbl.frame.origin.x + userNameLbl.frame.size.width + 2), userNameLbl.frame.origin.y, 120, sNoLbl.frame.size.height);
                
                
                billDueLbl.frame = CGRectMake((billAmountLbl.frame.origin.x + billAmountLbl.frame.size.width + 2), billDueLbl.frame.origin.y, 90, sNoLbl.frame.size.height);
                
                syncStatusLbl.frame = CGRectMake((billDueLbl.frame.origin.x + billDueLbl.frame.size.width + 2), billDueLbl.frame.origin.y, (itemsScrollView.frame.size.width - (billDueLbl.frame.origin.x + billDueLbl.frame.size.width + 2)), sNoLbl.frame.size.height);
                
                //upto here on 06/08/2017....
                
                //added by Srinivasulu on 16/10/2017....
                
                billDoneModeLbl.frame = CGRectMake((syncStatusLbl.frame.origin.x + syncStatusLbl.frame.size.width + 2), billDueLbl.frame.origin.y, 120, sNoLbl.frame.size.height);
                
                //upto here on 16/10/2017....
                
                float completeWidth = (billDueLbl.frame.origin.x + billDueLbl.frame.size.width) - sNoLbl.frame.origin.x;
                
                
                //                if(isOfflineService){
                
                completeWidth = ( billDoneModeLbl.frame.origin.x + billDoneModeLbl.frame.size.width + 10) - sNoLbl.frame.origin.x;
                
                //                }
                
                
                
                //setting frame for UITableView....
                pastBillsTbl.frame = CGRectMake( sNoLbl.frame.origin.x, sNoLbl.frame.origin.y + sNoLbl.frame.size.height + 4, completeWidth, itemsScrollView.frame.size.height - (sNoLbl.frame.origin.y + sNoLbl.frame.size.height + 4));
                
                
                itemsScrollView.contentSize = CGSizeMake( completeWidth, itemsScrollView.frame.size.height);
                
                
                
                //                sNoLbl.frame = CGRectMake( pastBillField.frame.origin.x, pastBillField.frame.origin.y+pastBillField.frame.size.height+10, 90, 40);
                //
                //                billIdLbl.frame = CGRectMake((sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 5), sNoLbl.frame.origin.y, 220, 40.0);
                //
                //                dateLbl.frame = CGRectMake((billIdLbl.frame.origin.x + billIdLbl.frame.size.width + 5), billIdLbl.frame.origin.y, 180, 40.0);
                //
                //                counterLbl.frame = CGRectMake((dateLbl.frame.origin.x + dateLbl.frame.size.width + 5), dateLbl.frame.origin.y, 160, 40.0);
                //
                //                userNameLbl.frame = CGRectMake((counterLbl.frame.origin.x + counterLbl.frame.size.width + 5), counterLbl.frame.origin.y, 180, 40.0);
                //
                //                billDueLbl.frame = CGRectMake((userNameLbl.frame.origin.x + userNameLbl.frame.size.width + 5), userNameLbl.frame.origin.y, 120, 40.0);
                //
                //                pastBillsTbl.frame = CGRectMake(sNoLbl.frame.origin.x, sNoLbl.frame.origin.y+sNoLbl.frame.size.height+2, 970, pastBillView.frame.size.height - (sNoLbl.frame.origin.y + sNoLbl.frame.size.height  +  20));
                
                
                
                // Added By Bhargav.v on 12/02/2018....
                // Reason: Assiging the frame for the totalRecordsView and the labels within the  view....
                
                pagenationTxt.frame = CGRectMake(pastBillField.frame.origin.x,itemsScrollView.frame.origin.y + itemsScrollView.frame.size.height + 10,90,40);
                
                dropDownBtn.frame   = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width - 45), pagenationTxt.frame.origin.y - 5, 45, 50);
                
                goButton.frame      = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width + 15,pagenationTxt.frame.origin.y,80, 40);
                
                totalRecordsView.frame = CGRectMake(endDateField.frame.origin.x + 60, pagenationTxt.frame.origin.y,submitBtn.frame.origin.x + submitBtn.frame.size.width - (endDateField.frame.origin.x + 50),pagenationTxt.frame.size.height);
                
                totalRecordsLabel.frame =  CGRectMake(5,0,140,40);
                totalRecordsValueLabel.frame = CGRectMake(totalRecordsLabel.frame.origin.x + totalRecordsLabel.frame.size.width - 60, totalRecordsLabel.frame.origin.y, 120,40);
                
                //upto here on 12/02/2018....
                
            }
            @catch (NSException *exception) {
                
            }
            
        }
        else{
            //frame's has to give for portrait....
            
            
        }
    }
    else{
        //need to give frame's for iPhone....
        
    }
    
}

/**
 * @description  it is one of viewWillAppear Method which will be executed after execution of
 viewDidLoad.......
 * @date
 * @method       viewDidAppear
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017 & on 12/12/2017....
 * @reason      added the comments and     .... not completed.... offline service calls.
 *
 * @verified By
 * @verified On
 *
 */

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //ProgressBar creation...
    
    
    @try {
        if (pastBillsArr ==  nil && pastBillsArr.count == 0) {
            [HUD setHidden:NO];

            totalNumberOfRecords = 0;
            past_bill_no  = 0;
            pastBillsArr = [NSMutableArray new];
            
            if(!isOfflineService){
                
                if(submitBtn.tag == 2 )
                    [self getPastBills];
                else if (submitBtn.tag  == 4)
                    [self callingSearchBills];
            }
            else
                [self getPastBillsinOffline];
        }
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
    }
    
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
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark Service call used for getting all ExchangeBillss....

/**
 * @description  get all the list of cleared bills
 * @date
 * @method       getPastBills
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and exception handling    .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)getPastBills {
    
    
    @try {
        [HUD setHidden:NO];
        
        if( pastBillsArr == nil && past_bill_no == 0){
            
            totalNumberOfRecords = 0;
            
            pastBillsArr = [NSMutableArray new];
        }
        else if(pastBillsArr.count){
            
            [pastBillsArr removeAllObjects];
        }
        
        WebServiceController *service = [[WebServiceController alloc] init];
        service.getBillsDelegate = self;
        [service getBills:past_bill_no deliveryType:@"" status:@"completed"];
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        NSLog(@"%@",exception.name);
        
        float y_axis = self.view.frame.size.height - 350;
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"completed_bills_not_availabe", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 550)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:550 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    
}

#pragma -mark handling the response received from the service for getBill service call

/**
 * @description  here we are handling the service call success response.......
 * @date
 * @method       getBillsSuccesResponse:
 * @author
 * @param        NSDictionary
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)getBillsSuccesResponse:(NSDictionary *)successDictionary {
    @try {
        
        [pastBillsTbl setUserInteractionEnabled: YES];
        if (![[successDictionary valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
            
            
            totalNumberOfRecords = [[successDictionary valueForKey:@"totalRecords"] intValue];
            
            for(NSDictionary *dic in [successDictionary valueForKey:@"billsList"]){
                
                [pastBillsArr addObject:dic];
            }
            
            
            //added by bhargava on --/--/----.. inorder  to  display total complete bills Count...
            totalRecordsValueLabel.text = [NSString stringWithFormat:@"%@%.f",@"",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS] defaultReturn:@"0.00"] floatValue]];
            // Calling the Method to display pagenation.....
            [self pagenationHandler];
            
            //upto here on --/--/----....
        }
    }
    @catch (NSException *exception) {
        NSLog(@"exception in service call %@",exception);
    }
    @finally {
        
        
        [pastBillsTbl reloadData];
        [HUD setHidden:YES];
    }
}

/**
 * @description  here we are handling the service call error response.......
 * @date
 * @method       getBillsFailureResponse:
 * @author
 * @param        NSString
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and exception handling  .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)getBillsFailureResponse:(NSString *)failureString {
    
    NSString * mesg;
    float y_axis  = self.view.frame.size.height - 350;
    
    @try {
        
        BOOL isShowAlert = NO;
        
        if(pastBillField.tag == 2){
            
            if(!pastBillsArr.count)
                isShowAlert = YES;
        }
        else {
            
            isShowAlert = YES;
        }
        
        pastBillField.tag = 2;
        
        if( isShowAlert){
            
            
            mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",failureString];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 550)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:550 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
    }
    @catch (NSException *exception) {
        
        mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        
        //added by bhargava on --/--/----.. inorder  to  display total complete bills Count....
        
        if( past_bill_no == 0 || pastBillsArr.count == 0 ) {
            
            pagenationTxt.text = @"1";
            totalNumberOfRecords = 0;
            [self pagenationHandler];
        }
        //upto here on --/--/----....
        
        [pastBillsTbl reloadData];
        [HUD setHidden:YES];
    }
}

#pragma -mark method used in offline to retrive data....

/**
 * @description  get all the offline bills details....
 * @date
 * @method       getPastBillsinOffline
 * @author       Srinivasulu
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

-(void)getPastBillsinOffline {
    
    [HUD setHidden:NO];
    
    NSString * mesg;
    float y_axis  = self.view.frame.size.height - 350;
    
    @try {
        
        if( pastBillsArr == nil && past_bill_no == 0){
            
            totalNumberOfRecords = 0;
            pastBillsArr = [NSMutableArray new];
        }
        else if(pastBillsArr.count){
            
            totalNumberOfRecords = 0;
            [pastBillsArr removeAllObjects];
        }
        
        NSString * startDteStr = startDateField.text;
        NSString * endDteStr  = endDateField.text;//pastBillField.text
        
        
        OfflineBillingServices * offline = [[OfflineBillingServices alloc] init];
        NSMutableDictionary * successDictionary = [offline getBillInfo:COMPLETED searchInfo:@""  mobileNo:userMobileNoFld.text startingDate:startDteStr endDate:endDteStr startIndex:past_bill_no maxRecords:13];
        
        if([[successDictionary valueForKey:BILL_LIST] count]){
            
            totalNumberOfRecords = [[successDictionary valueForKey:TOTAL_SKUS] intValue];
            
            for(NSDictionary *dic in [successDictionary valueForKey:BILL_LIST]){
                
                [pastBillsArr addObject:dic];
            }
        }
        
        
        //added by bhargava on --/--/----.. inorder  to  display total complete bills Count...
        totalRecordsValueLabel.text = [NSString stringWithFormat:@"%@%.f",@"",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS] defaultReturn:@"0.00"] floatValue]];
        // Calling the Method to display pagenation.....
        [self pagenationHandler];
        
        //upto here on --/--/----....
        
        
        
        //        else{
        //
        //            mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"completed_bills_not_availabe", nil)];
        //
        //            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        //        }
        
    } @catch (NSException *exception) {
        
        mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"completed_bills_not_availabe", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 550)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:550 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @finally {
        if(!pastBillsArr.count){
            
            mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"completed_bills_not_availabe", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 550)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:550 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
        [pastBillsTbl reloadData];
        [HUD setHidden:YES];
    }
    
}
#pragma -mark start of textField delegate methods....

/**
 * @description  it is textfield delegate method it will executed after execution of textFieldDidChange.......
 * @date
 * @method       textFieldShouldEndEditing:
 * @author
 * @param        UITextField
 * @param
 *
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && exception handling....
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    @try {
        
        [pastBillField resignFirstResponder];
        return YES;
        
    } @catch (NSException *exception) {
        return YES;
        
    } @finally {
        
    }
    
}

/**
 * @description  it is textfield delegate method it will executed after execution of textFieldShouldEndEditing .......
 * @date
 * @method       textFieldDidChange:
 * @author
 * @param        UITextField
 * @param
 *
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && exception handling....
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    @try {
        
        [textField resignFirstResponder];
        return YES;
        
    } @catch (NSException *exception) {
        
        return YES;
    } @finally {
        
    }
    
}

/**
 * @description  it is textfield delegate method it will executed forever character change....
 * @date
 * @method       textFieldDidChange:
 * @author
 * @param        UITextField
 * @param
 *
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && exception handling....
 *
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidChange:(UITextField *)textField {
    @try {
        if(textField == pastBillField) {
            
            @try {
                
                NSString *value = [pastBillField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                saleId = [pastBillField.text copy];
                
                if (saleId.length == 3 && value.length != 0) {
                    
                    // web services calling....
                    // Create the service
                    //            SDZSalesService* service = [SDZSalesService service];
                    //            service.logging = YES;
                    //
                    //            // Returns NSString*.
                    //            [service getExistedSaleID:self action:@selector(getExistedSaleIDHandler:) saleID: saleId];
                    
                    if (!isOfflineService) {
                        
                        WebServiceController *controller = [[WebServiceController alloc] init];
                        controller.getBillsDelegate = self;
                        [controller getBillIds:-1 deliveryType:@"" status:@"completed" searchCriteria:saleId];
                    }
                    else {
                        
                        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
                        NSMutableArray *result = [offline geCompletedBillsList:pastBillField.text];
                        
                        //                        [offline getBillInfo:@"completed" searchInfo:pastBillField.text  mobileNo:userMobileNoFld.text startingDate:@"" endDate:@"" startIndex:1 maxRecords:2];
                        
                        [HUD setHidden:YES];
                        filteredSkuArrayList = [result mutableCopy];
                        
                        //added by Srinivasulu on 21/10/2017....
                        //reason -- in offline also similar logic has to work....
                        salesIdArray = [result mutableCopy];
                        
                        //upto here on 21/10/2017....
                        
                    }
                    
                    
                    
                }
                else if(saleId.length > 3){
                    
                    filteredSkuArrayList = [[NSMutableArray alloc] init];
                    
                    //commented && changed by Srinivasulu on 21/10/2017....
                    //reason -- no need to change the logic/hit the bata base. it work same for both offline and online....
                    
                    //                    if (!isOfflineService) {
                    
                    @try {
                        
                        for (NSString *product in salesIdArray)
                        {
                            
                            //changed by Srinivasulu on 21/10/2017....
                            //reason -- existing code will not working if we are trying to search the last characters in bill id....
                            
                            //                                NSComparisonResult result = [product compare:pastBillField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [pastBillField.text length])];
                            
                            //                                if (result == NSOrderedSame)
                            if ([product rangeOfString:pastBillField.text  options:NSCaseInsensitiveSearch].location != NSNotFound)
                            {
                                [filteredSkuArrayList addObject:product];
                            }
                        }
                    }
                    @catch (NSException *exception) {
                        
                        
                    }
                    //                    }
                    //
                    //                    else
                    //
                    //                    {
                    //
                    //                        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
                    //                        NSMutableArray *result = [offline getPendingBills:pastBillField.text];
                    //                        [HUD setHidden:YES];
                    //                        filteredSkuArrayList = nil;
                    //                        filteredSkuArrayList = [result mutableCopy];
                    //
                    //                    }
                    
                    //upto here on 21/10/2017....
                    
                }
                else if(saleId.length == 2){
                    
                }
                else{
                }
            } @catch (NSException *exception) {
                
            } @finally {
                
                if(filteredSkuArrayList.count && (saleId.length >= 3)){
                    float tableHeight = filteredSkuArrayList.count * 50;
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                        tableHeight = filteredSkuArrayList.count * 33;
                    
                    if(filteredSkuArrayList.count > 5)
                        tableHeight = (tableHeight/filteredSkuArrayList.count) * 5;
                    
                    [self showPopUpForTables:salesIdTable  popUpWidth:pastBillField.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pastBillField  showViewIn:pastBillView permittedArrowDirections:UIPopoverArrowDirectionUp];
                }
                else
                    [catPopOver dismissPopoverAnimated:YES];
                
            }
            
            
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

#pragma -mark we are handling the service call response of getBillIds....

/**
 * @description  here we are handling the service call success response.......
 * @date
 * @method       getBillIdsSuccessResponse:
 * @author
 * @param        NSDictionary
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)getBillIdsSuccessResponse:(NSDictionary *)successDic{
    
    @try {
        
        pastBillField.tag = 2;
        [self getExistedSaleIDHandler:successDic];
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
    
}

#pragma - mark handling of success response and dislaying ids in popUp....

/**
 * @description  here we are handling the getBillIds resposne   && showing table in popUp.......
 * @date
 * @method       getExistedSaleIDHandler:
 * @author
 * @param        NSDictionary
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 08/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void) getExistedSaleIDHandler: (NSDictionary *) value {
    
    @try {
        
        NSArray *temp = value[@"billIds"];
        
        if (temp.count > 0 ){
            salesIdArray = nil;
            salesIdArray = [[NSMutableArray alloc] init];
            
            salesIdArray = [temp copy];
            
            filteredSkuArrayList = nil;
            filteredSkuArrayList = salesIdArray;
            
        }
        else{
            
            //[HUD setHidden:YES];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        if(filteredSkuArrayList.count){
            float tableHeight = filteredSkuArrayList.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = filteredSkuArrayList.count * 33;
            
            if(filteredSkuArrayList.count > 5)
                tableHeight = (tableHeight/filteredSkuArrayList.count) * 5;
            
            
            
            [self showPopUpForTables:salesIdTable  popUpWidth:pastBillField.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pastBillField  showViewIn:pastBillView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    }
    
}

#pragma -mark start of UITableViewDelegateMethods

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
 * @modified BY  Srinivasulu on 08/06/201477....
 * @reason       changed the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    @try {
        
        if (tableView == pastBillsTbl) {
            return pastBillsArr.count;
        }
        else if (tableView == salesIdTable) {
            
            return filteredSkuArrayList.count;
        }
        
        //Added By Bhargav.v on 20/02/2018....
        
        else if (tableView == pagenationTbl) {
            
            return pagenationArr.count;
        }
        
        //upto here on 20/02/2018....
        else
            return false;
    }
    
    @catch (NSException *exception) {
        
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
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == pastBillsTbl){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 38;
        }
        else
            return 45;
    }
    else if (tableView == salesIdTable) {
        return 50;
    }
    else
        return 45;
}

/**
 * @description  it is tableview delegate method it will be called after heightForRowAtIndexPath.......
 * @date
 * @method       tableView: willDisplayCell: forRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        UITableViewCell
 *
 * @return       NSIndexPath
 *
 * @modified BY  Srinivasulu on 13/06/2017....
 * @reason       changed the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    @try {
    
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && version >= 8.0 )|| (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
        
        // Remove seperator inset....
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        // Prevent the cell from inheriting the Table View's margin settings....
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            cell.preservesSuperviewLayoutMargins = NO;
        }
        
        // Explictly set cell's layout margins....
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
    }
    
    //    if(tableView == pastBillsTbl){
    //
    //        @try {
    //
    //            if((indexPath.row == ([pastBillsArr count] - 1))  && ([pastBillsArr count] < totalNumberOfRecords)){
    //                [HUD show: YES];
    //                [HUD setHidden:NO];
    //                past_bill_no = past_bill_no + 10;
    //
    //                //chaned by   Srinivasulu on 11/12/2017....
    //                //reason added the offline condition....
    //                if(!isOfflineService){
    //
    //                    if(submitBtn.tag == 2 )
    //                        [self getPastBills];
    //                    else if (submitBtn.tag  == 4)
    //                        [self callingSearchBills];
    //                }
    //                else{
    //
    //                    [self getPastBillsinOffline];
    //                }
    //            }
    //
    //        } @catch (NSException *exception) {
    //            NSLog(@"----exception in servicecall----%@",exception);
    //            [HUD setHidden:YES];
    //        } @finally {
    //
    //        }
    //
    //    }
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date
 * @method       tableView: cellForRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        UITableViewCell
 *
 * @return       UITableViewCell
 *
 * @modified BY  Srinivasulu on 13/06/2017....
 * @reason       changed the comment's section and populating the data into labels && labels declearations....
 *
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == pastBillsTbl) {
        
        @try {
            
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
            
            
            UILabel * s_no_Lbl;
            UILabel * bill_Id_Lbl;
            UILabel * returnBill_Date_Lbl;
            UILabel * counter_Lbl;
            UILabel * userName_Lbl;
            UILabel * billDue_Lbl;
            
            //added by Srinivasulu 27/07/2017....
            
            UILabel * sync_status_Lbl;
            
            //added by Srinivasulu on 16/10/2017....
            
            UILabel * bill_Done_Mode_Lbl;
            
            bill_Done_Mode_Lbl = [[UILabel alloc] init];
            bill_Done_Mode_Lbl.backgroundColor = [UIColor clearColor];
            bill_Done_Mode_Lbl.textAlignment = NSTextAlignmentCenter;
            bill_Done_Mode_Lbl.numberOfLines = 1;
            bill_Done_Mode_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            //upto here on 16/10/2017....
            
            sync_status_Lbl = [[UILabel alloc] init];
            sync_status_Lbl.backgroundColor = [UIColor clearColor];
            sync_status_Lbl.textAlignment = NSTextAlignmentCenter;
            sync_status_Lbl.numberOfLines = 1;
            sync_status_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            //added by Srinivasulu on 06/08/2017....
            
            UILabel * bill_amount_Lbl;
            
            bill_amount_Lbl = [[UILabel alloc] init];
            bill_amount_Lbl.backgroundColor = [UIColor clearColor];
            bill_amount_Lbl.textAlignment = NSTextAlignmentCenter;
            bill_amount_Lbl.numberOfLines = 1;
            bill_amount_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            //upto here on 06/08/2017....
            //upto here on27/07/2017....
            
            s_no_Lbl = [[UILabel alloc] init];
            s_no_Lbl.backgroundColor = [UIColor clearColor];
            s_no_Lbl.textAlignment = NSTextAlignmentCenter;
            s_no_Lbl.numberOfLines = 2;
            s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            bill_Id_Lbl = [[UILabel alloc] init];
            bill_Id_Lbl.backgroundColor = [UIColor clearColor];
            bill_Id_Lbl.textAlignment = NSTextAlignmentCenter;
            bill_Id_Lbl.numberOfLines = 1;
            bill_Id_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            returnBill_Date_Lbl = [[UILabel alloc] init];
            returnBill_Date_Lbl.backgroundColor = [UIColor clearColor];
            returnBill_Date_Lbl.textAlignment = NSTextAlignmentCenter;
            returnBill_Date_Lbl.numberOfLines = 2;
            returnBill_Date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            counter_Lbl = [[UILabel alloc] init];
            counter_Lbl.backgroundColor =  [UIColor clearColor];
            counter_Lbl.textAlignment = NSTextAlignmentCenter;
            counter_Lbl.numberOfLines = 1;
            
            userName_Lbl = [[UILabel alloc] init];
            userName_Lbl.backgroundColor =  [UIColor clearColor];
            userName_Lbl.textAlignment = NSTextAlignmentCenter;
            userName_Lbl.numberOfLines = 2;
            
            billDue_Lbl = [[UILabel alloc] init];
            billDue_Lbl.backgroundColor =  [UIColor clearColor];
            billDue_Lbl.textAlignment = NSTextAlignmentCenter;
            billDue_Lbl.numberOfLines = 2;
            
            /* assiginig the font and color of the labels  */
            
            s_no_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0];
            bill_Id_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
            
            returnBill_Date_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            counter_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            userName_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            billDue_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
            
            s_no_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            bill_Id_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            returnBill_Date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            counter_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            userName_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            billDue_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];
            
            //added by Srinivasulu 27/07/2017....
            
            sync_status_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            bill_amount_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            bill_Done_Mode_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
            sync_status_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];
            bill_amount_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];
            bill_Done_Mode_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];
            
            //upto here on 06/08/2017....
            
            //upto here on27/07/2017....
            
            CAGradientLayer * layer_1;
            CAGradientLayer * layer_2;
            CAGradientLayer * layer_3;
            CAGradientLayer * layer_4;
            CAGradientLayer * layer_5;
            CAGradientLayer * layer_6;
            
            
            
            //added by Srinivasulu 27/07/2017....
            
            CAGradientLayer * layer_7;
            
            layer_7 = [CAGradientLayer layer];
            layer_7.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            [sync_status_Lbl.layer addSublayer:layer_7];
            
            
            //added by Srinivasulu on 06/08/2017....
            
            CAGradientLayer * layer_8;
            
            layer_8 = [CAGradientLayer layer];
            layer_8.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            [bill_amount_Lbl.layer addSublayer:layer_8];
            
            //upto here on 06/08/2017....
            
            //added by Srinivasulu on 16/10/2017....
            
            CAGradientLayer * layer_9;
            
            layer_9 = [CAGradientLayer layer];
            layer_9.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            [bill_Done_Mode_Lbl.layer addSublayer:layer_9];
            
            //upto here on 16/10/2017....
            
            layer_1 = [CAGradientLayer layer];
            layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            
            layer_2 = [CAGradientLayer layer];
            layer_2.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            
            layer_3 = [CAGradientLayer layer];
            layer_3.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            
            layer_4 = [CAGradientLayer layer];
            layer_4.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            layer_5 = [CAGradientLayer layer];
            layer_5.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            
            layer_6 = [CAGradientLayer layer];
            layer_6.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            
            [s_no_Lbl.layer addSublayer:layer_1];
            [bill_Id_Lbl.layer addSublayer:layer_2];
            [returnBill_Date_Lbl.layer addSublayer:layer_3];
            [counter_Lbl.layer addSublayer:layer_4];
            [userName_Lbl.layer addSublayer:layer_5];
            [billDue_Lbl.layer addSublayer:layer_6];
            
            //added subViews to cell contentView....
            [hlcell.contentView addSubview:s_no_Lbl];
            [hlcell.contentView addSubview:bill_Id_Lbl];
            [hlcell.contentView addSubview:returnBill_Date_Lbl];
            [hlcell.contentView addSubview:counter_Lbl];
            [hlcell.contentView addSubview:userName_Lbl];
            [hlcell.contentView addSubview:billDue_Lbl];
            [hlcell.contentView addSubview:bill_Done_Mode_Lbl];
            
            //added by Srinivasulu 27/07/2017....
            
            //            if(isOfflineService){
            [hlcell.contentView addSubview:sync_status_Lbl];
            
            [hlcell.contentView addSubview:bill_amount_Lbl];
            
            //            }
            //upto here on27/07/2017....
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                }
                else{
                }
                
                
                //setting frame....
                s_no_Lbl.frame = CGRectMake( sNoLbl.frame.origin.x, 0, sNoLbl.frame.size.width, hlcell.frame.size.height);
                bill_Id_Lbl.frame = CGRectMake( billIdLbl.frame.origin.x, 0, billIdLbl.frame.size.width,  hlcell.frame.size.height);
                returnBill_Date_Lbl.frame = CGRectMake( dateLbl.frame.origin.x, 0, dateLbl.frame.size.width,  hlcell.frame.size.height);
                counter_Lbl.frame = CGRectMake( counterLbl.frame.origin.x, 0, counterLbl.frame.size.width,  hlcell.frame.size.height);
                userName_Lbl.frame = CGRectMake( userNameLbl.frame.origin.x, 0, userNameLbl.frame.size.width,  hlcell.frame.size.height);
                billDue_Lbl.frame = CGRectMake( billDueLbl.frame.origin.x, 0, billDueLbl.frame.size.width,  hlcell.frame.size.height);
                
                //added by Srinivasulu 27/07/2017....
                
                //                if(isOfflineService){
                
                sync_status_Lbl.frame = CGRectMake( syncStatusLbl.frame.origin.x, 0, syncStatusLbl.frame.size.width,  hlcell.frame.size.height);
                layer_7.frame = CGRectMake( 0, hlcell.frame.size.height - 2, sync_status_Lbl.frame.size.width, 2);
                
                bill_amount_Lbl.frame = CGRectMake( billAmountLbl.frame.origin.x, 0, billAmountLbl.frame.size.width,  hlcell.frame.size.height);
                layer_8.frame = CGRectMake( 0, hlcell.frame.size.height - 2, billAmountLbl.frame.size.width, 2);
                
                bill_Done_Mode_Lbl.frame = CGRectMake( billDoneModeLbl.frame.origin.x, 0, billDoneModeLbl.frame.size.width,  hlcell.frame.size.height);
                layer_9.frame = CGRectMake( 0, hlcell.frame.size.height - 2, billDoneModeLbl.frame.size.width, 2);
                
                //                }
                //upto here on27/07/2017....
                
                layer_1.frame = CGRectMake( 0, hlcell.frame.size.height - 2, s_no_Lbl.frame.size.width, 2);
                layer_2.frame = CGRectMake( 0, hlcell.frame.size.height - 2, bill_Id_Lbl.frame.size.width, 2);
                layer_3.frame = CGRectMake( 0, hlcell.frame.size.height - 2, returnBill_Date_Lbl.frame.size.width, 2);
                layer_4.frame = CGRectMake( 0, hlcell.frame.size.height - 2, counter_Lbl.frame.size.width, 2);
                layer_5.frame = CGRectMake( 0, hlcell.frame.size.height - 2, userName_Lbl.frame.size.width, 2);
                layer_6.frame = CGRectMake( 0, hlcell.frame.size.height - 2, billDue_Lbl.frame.size.width, 2);
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell.contentView andSubViews:YES fontSize:16.0f cornerRadius:0];
            }
            else{
                //need to give frame's for iPhone....
                
            }
            
            
            
            
            
            //setting frame and font..........
            
            @try {
                
//                s_no_Lbl.text = [NSString stringWithFormat:@"%ld", (indexPath.row + 1)];
                s_no_Lbl.text = [NSString stringWithFormat:@"%ld", (indexPath.row + 1) + past_bill_no];

                
                NSDictionary *dic = pastBillsArr[indexPath.row];
                if (!isOfflineService) {
                    
                    //changed by Srinivasulu on 08/07/2017....
                    //undo the commented code on 10/07/2017....
                    
                    if (!isCustomerBillId) {
                        bill_Id_Lbl.text = [[dic valueForKey:BILL_ID] componentsSeparatedByString:@" "][0];
                    }
                    else {
                        
                        
                        bill_Id_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"serialBillId"] defaultReturn:@"--"] ;
                        
                    }
                    
                    //upto here on 08/07/2017....
                    
                    returnBill_Date_Lbl.text = [[dic valueForKey:BUSSINESS_DATE] componentsSeparatedByString:@" "][0];
                    counter_Lbl.text = [dic valueForKey:COUNTER];
                    
                    if (![dic[CUSTOMER_NAME] isKindOfClass:[NSNull class]]&& [dic[CUSTOMER_NAME] length] > 0) {
                        
                        userName_Lbl.text = [NSString stringWithFormat:@"%@",dic[CUSTOMER_NAME]];
                    }
                    else {
                        
                        userName_Lbl.text =  @"-";
                    }
                    
                    billDue_Lbl.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:BILL_DUE] floatValue]];
                    
                    
                    //added by Srinivasulu 09/08/2017....
                    
                    bill_amount_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:TOTAL_BILL_AMT] defaultReturn:@"0.00"] floatValue]];
                    sync_status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SYNC_STATUS] defaultReturn:@"--"];
                    
                    
                    if([dic.allKeys containsObject:OFFLINE_BILL] && (![[dic valueForKey:OFFLINE_BILL] isKindOfClass:[NSNull class]])){
                        
                        if([[dic valueForKey:OFFLINE_BILL] intValue]){
                            
                            bill_Done_Mode_Lbl.text = NSLocalizedString(@"offline", nil);
                        }
                        else{
                            
                            bill_Done_Mode_Lbl.text = NSLocalizedString(@"online", nil);
                        }
                        
                    }
                    else{
                        
                        bill_Done_Mode_Lbl.text = @"--";
                    }
                    
                    
                    //upto here on 09/08/2017....
                }
                else {
                    
                    //changed by Srinivasulu on 08/07/2017....
                    //undo by Srinivasulu on10/07/2017.... reason service modification are done....
                    
                    if (!isCustomerBillId) {
                        bill_Id_Lbl.text = [dic valueForKey:BILL_ID] ;
                    }
                    else {
                        bill_Id_Lbl.text = [dic valueForKey:kSerialBillId] ;
                    }
                    
                    //upto here on 08/07/2017....
                    
                    returnBill_Date_Lbl.text = [[dic valueForKey:BUSSINESS_DATE] componentsSeparatedByString:@" "][0] ;
                    counter_Lbl.text = [dic valueForKey:COUNTER];
                    
                    //                    if (![[dic objectForKey:CUSTOMER_NAME] isKindOfClass:[NSNull class]]&& [[dic objectForKey:CUSTOMER_NAME] length] > 0) {
                    //                        userName_Lbl.text = [NSString stringWithFormat:@"%@",[dic objectForKey:CUSTOMER_NAME]];
                    //                    }
                    //                    else {
                    userName_Lbl.text =  @"-";
                    
                    //  }
                    
                    billDue_Lbl.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:BILL_DUE] floatValue]];
                    
                    
                    //added by Srinivasulu 09/07/2017....
                    
                    sync_status_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SYNC_STATUS] defaultReturn:@"--"];
                    
                    bill_amount_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:TOTAL_BILL_AMT] defaultReturn:@"0.00"] floatValue]];
                    
                    
                    
                    if([dic.allKeys containsObject:OFFLINE_BILL] && (![[dic valueForKey:OFFLINE_BILL] isKindOfClass:[NSNull class]])){
                        
                        if([[dic valueForKey:OFFLINE_BILL] intValue]){
                            
                            bill_Done_Mode_Lbl.text = NSLocalizedString(@"offline", nil);
                        }
                        else{
                            
                            bill_Done_Mode_Lbl.text = NSLocalizedString(@"online", nil);
                        }
                        
                    }
                    else{
                        
                        bill_Done_Mode_Lbl.text = @"--";
                    }
                    //upto here on 09/07/2017....
                    
                }
                
            }
            @catch (NSException *exception) {
                
            }
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        
        @catch (NSException *exception) {
            
        }
        
    }
    
    else if (tableView == salesIdTable)  {
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if ((cell.contentView).subviews){
            for (UIView *subview in (cell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.frame = CGRectZero;
        }
        
        @try {
            
            cell.textLabel.text = filteredSkuArrayList[indexPath.row];
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception.name);
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        }
        else{
            cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        }
        
        return cell;
        
    }
    
    else if (tableView == pagenationTbl){
        
        static NSString *CellIdentifier = @"pagenationCell";
        
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
            
            hlcell.textLabel.text = pagenationArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        }
        @catch (NSException *exception) {
        }
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return hlcell;
        
    }
}

/**
 * @description  it is tableview delegate method it will be called after cellForRowIndexPath.......
 * @date
 * @method       tableView: didSelectRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        NSIndexPath
 *
 * @return       void
 *
 * @modified BY  Srinivasulu on 13/06/2017....
 * @reason       changed the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [salesIdTable setHidden:YES];
        
        PastBilling *past_bill;
        
        if (tableView == salesIdTable) {
            
            [catPopOver dismissPopoverAnimated:YES];
            
            past_bill = [[PastBilling alloc] initWithBillType:filteredSkuArrayList[indexPath.row]];
            
            
        }
        
        else if (tableView == pagenationTbl) {
            
            @try {
                
                //dismissing teh catPopOver.......
                [catPopOver dismissPopoverAnimated:YES];
                
                past_bill_no = 0;
                pagenationTxt.text = pagenationArr[indexPath.row];
                int pageValue = (pagenationTxt.text).intValue;
                past_bill_no = past_bill_no + (pageValue * 13) - 13;
            } @catch (NSException * exception) {
                
            }
        }
        
        else {
            
            NSDictionary *detailsDic = pastBillsArr[indexPath.row];
            
            past_bill = [[PastBilling alloc] initWithBillType:@""];
            
            
            //changed by Srinivasulu on 08/07/2017....
            //undo by Srinivasulu on10/07/2017.... reason service modification are done....
            
            if (isCustomerBillId) {
                
                past_bill.pastBillId = [[detailsDic valueForKey:kSerialBillId] copy];
            }
            else {
                
                past_bill.pastBillId = [[detailsDic valueForKey:BILL_ID] copy];
            }
            
            //upto here on 08/07/2017.....
        }
        
        billTypeStatus = TRUE;
        typeBilling = @"past";
        past_bill.billingType = @"past";
        past_bill.isBillSummery = false;
        pastBillField.text = @"";
        
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
        
        
        past_bill.billTypeStr = NSLocalizedString(@"completed_bill", nil);
        
        [self.navigationController pushViewController:past_bill animated:YES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


#pragma - mark action used for search in this page....

/**
 * @description  ..
 * @date
 * @method       submitBtnPressed:
 * @author
 * @param        UIButton
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 08/06/2017....
 * @reason      added the comments and exception handling.... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)submitBtnPressed:(UIButton *)sender {
    NSLog(@"responsePrinted");
    
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        if (!isOfflineService) {
            
            submitBtn.tag = 4;
            past_bill_no = 0;
            
            [self callingSearchBills];
        }
        else{
            
            submitBtn.tag = 4;
            past_bill_no = 0;
            
            [self getPastBillsinOffline];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
    }
}


#pragma - mark method used for  calling search service....

/**
 * @description  here we are calling service in order to get the pending bills.......
 * @date
 * @method       callingSearchBills
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)callingSearchBills {
    @try {
        
        
        [HUD setHidden:NO];
        
        
        NSLog(@"---getPastBills---%d",past_bill_no);
        
        if( pastBillsArr == nil && past_bill_no == 0){
            
            totalNumberOfRecords = 0;
            
            pastBillsArr = [NSMutableArray new];
        }
        else if(pastBillsArr.count){
            
            [pastBillsArr removeAllObjects];
        }
        
        NSString * startDteStr = startDateField.text;
        NSString * endDteStr  = endDateField.text;
        
        if((startDateField.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@", startDateField.text,@" 00:00:00"];
        
        
        if ((endDateField.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateField.text,@" 00:00:00"];
        }
        
        NSArray * headerKeys_ = @[REQUEST_HEADER,STORE_LOCATION,START_INDEX,MOBILE_NO,kReportDate,kReportEndDate,BILL_STATUS,kMaxRecords];
        
        NSArray * headerObjects_ = @[[RequestHeader getRequestHeader],presentLocation,[NSString stringWithFormat:@"%d",past_bill_no],userMobileNoFld.text,startDteStr,endDteStr,@"completed",THIRTEEN];
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * getSearchJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"printing json string %@",getSearchJsonString);
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getBillsDelegate = self;
        [webServiceController searchBills:getSearchJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma -mark handling of response received for service call search bill ids....

/**
 * @description  here we are handling the service call success response.......
 * @date
 * @method       searchBillsSuccesssResponse:
 * @author
 * @param        NSDictionary
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)searchBillsSuccesssResponse:(NSDictionary *)successDictionary {
    @try {
        
        //        NSLog(@"---searchBillsSuccesssResponse---%i",[successDictionary count]);
        
        
        if  (![[successDictionary valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
            
            totalNumberOfRecords = [[successDictionary valueForKey:@"totalRecords"] intValue];
            
            for(NSDictionary *dic in [successDictionary valueForKey:@"billsList"]){
                
                [pastBillsArr addObject:dic];
            }
            
        }
        
        //added by bhargava on --/--/----.. inorder  to  display total complete bills Count...
        totalRecordsValueLabel.text = [NSString stringWithFormat:@"%@%.f",@"",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS] defaultReturn:@"0.00"] floatValue]];
        // Calling the Method to display pagenation.....
        [self pagenationHandler];
        
        //upto here on --/--/----....
        
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [pastBillsTbl reloadData];
    }
    
}

/**
 * @description  here we are handling the service call error response.......
 * @date
 * @method       searchBillsErrorResponse:
 * @author
 * @param        NSString
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)searchBillsErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        //        NSLog(@"---searchBillsErrorResponse---%@",errorResponse);
        
        if(!pastBillsArr.count){
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorResponse message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
            float y_axis = self.view.frame.size.height - 120;

            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 550)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:550 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
    }
    @catch (NSException *exception) {
    }
    @finally {
        //added by bhargava on --/--/----.. inorder  to  display total complete bills Count....
        
        if( past_bill_no == 0 || pastBillsArr.count == 0 ) {
            
            pagenationTxt.text = @"1";
            totalNumberOfRecords = 0;
            [self pagenationHandler];
        }
        
        //upto here on --/--/----...
        
        [pastBillsTbl reloadData];
    }
    
}


#pragma mark methods used to disaply calendar and populate data into textfields....

/**
 * @description  here we are showing the calender in popUp view....
 * @date
 * @method       showCalenderInPopUp:
 * @author
 * @param        UIButton
 * @param
 *
 * @return
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && add clear button and its functionality....
 *
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
            
            pickView.frame = CGRectMake( 15, startDateField.frame.origin.y+startDateField.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:startDateField.frame inView:pastBillView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateField.frame inView:pastBillView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @description  here we are populating dates into textFields when user choosend he ok button....
 * @date
 * @method       populateDateToTextField:
 * @author
 * @param        UIButton
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and exception handling.... not completed....
 *
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
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        
        // getting present date & time ..
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        //        [f release];
        today = [f dateFromString:currentdate];
        
        
        
        if( [today compare:selectedDateString] == NSOrderedAscending ){
            
            [self displayAlertMessage:NSLocalizedString(@"billed_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
            
        }
        
        NSDate *existingDateString;
        
        
        if(  sender.tag == 2){
            if ((endDateField.text).length != 0 && ( ![endDateField.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateField.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                }
            }
            
            startDateField.text = dateString;
            
        }
        else{
            
            if ((startDateField.text).length != 0 && ( ![startDateField.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateField.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                }
            }
            
            endDateField.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

/**
 * @description  clear the date from textField and calling services.......
 * @date         13/06/2017
 * @method       clearDate:
 * @author       Srinivasulu
 * @param        UIButton
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

-(void)clearDate:(UIButton *)sender{
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        if(  sender.tag == 2){
            if((startDateField.text).length)
                
                startDateField.text = @"";
        }
        else{
            if((endDateField.text).length)
                
                endDateField.text = @"";
        }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
    
}


#pragma mark methods need to be implemented:

/**
 * @description  ..
 * @date
 * @method       displaySummaryInfo
 * @author
 * @param        UIButton
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and exception handling.... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)displaySummaryInfo:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma -mark superClass methods....

/**
 * @description  ..
 * @date
 * @method       backAction
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and exception handling.... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void) goToHome {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        OmniHomePage *homePage = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:homePage animated:YES];
    } @catch (NSException *exception) {
        NSLog(@"-----exception in goToHome() of RequestForQuotation----------%@",exception);
    }
    
}

#pragma -mark reuseable methods used in this page....

/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         10/05/2017
 * @method       showPopUpForTables:-- popUpWidth:-- popUpHeight:-- presentPopUpAt:-- showViewIn:-- permittedArrowDirections:--
 * @author       Srinivasulu
 * @param        UITableView
 * @param        float
 * @param        float
 * @param        id
 * @param        id
 * @param        permittedArrowDirections
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

-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections{
    
    @try {
        
        //        if ( [catPopOver isPopoverVisible]){
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height >= height) ){
            
            catPopOver.popoverContentSize =  CGSizeMake(width, height);
            
            //            catPopOver.contentViewController.preferredContentSize = CGSizeMake(width, height);
            //CGRectMake( tableName.frame.origin.x, tableName.frame.origin.x, tableName.frame.size.width, tableName.frame.size.height);
            
            //                        if (tableName.frame.size.height < height)
            tableName.frame = CGRectMake( tableName.frame.origin.x, tableName.frame.origin.x, tableName.frame.size.width, tableName.frame.size.height);
            
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
            
            [popover presentPopoverFromRect:textView.frame inView:view permittedArrowDirections:arrowDirections animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            //            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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



/**
 * @description  adding the  alertMessage's based on input
 * @date         13/06/2017
 * @method       displayAlertMessage
 * @author       Srinivasulu
 * @param        NSString
 * @param        float
 * @param        float
 * @param        NSString
 * @param        float
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines{
    
    
    //    [self displayAlertMessage: @"No Products Avaliable" horizontialAxis:segmentedControl.frame.origin.x   verticalAxis:segmentedControl.frame.origin.y  msgType:@"warning" timming:2.0];
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
            
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
        userAlertMessageLbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        userAlertMessageLbl.layer.cornerRadius = 5.0f;
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
            
            //            if(searchItemsTxt.isEditing)
            //                yPosition = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
            
            
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
        fadOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in displayAlertMessage---------%@",exception);
        NSLog(@"----exception while creating the useralertMesssageLbl------------%@",exception);
        
    }
}


/**
 * @description  removing alertMessage add in the  disPlayAlertMessage method
 * @date         09/05/2017
 * @method       removeAlertMessages
 * @author       Srinivasulu
 * @param
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

-(void)removeAlertMessages{
    @try {
        
        if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
    }
}



/**
 * @description  here we are checking whether the object is null or not
 * @date         10/07/2017
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav
 * @param
 * @param
 *
 * @return       id
 *
 * @modified By
 * @reason
 *
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


#pragma -mark methods added by Bhargav for pagenation....

/**
 * @description  Handling the Response for pagenation.....
 * @date
 * @method       pagenationHandler
 * @author       Bhargav.v
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 19/03/2018....
 * @reason       changed comments....
 *
 * @verified By
 * @verified On
 *
 */

-(void)pagenationHandler {
    
    @try {
        
        //Reason: To Display the Records in pagination mode based on the Total Records..
        int strTotalRecords = totalNumberOfRecords/13;
        int remainder = totalNumberOfRecords % 13;
        
        
        if(remainder == 0) {
            
            strTotalRecords = strTotalRecords;
        }
        else {
            
            strTotalRecords = strTotalRecords + 1;
        }
        
        pagenationArr = [NSMutableArray new];
        
        if(strTotalRecords < 1){
            
            [pagenationArr addObject:@"1"];
            
            if(totalNumberOfRecords == 0)
                totalRecordsValueLabel.text = @"0";
        }
        else{
            
            for(int i = 1;i<= strTotalRecords; i++) {
                
                [pagenationArr addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        if(past_bill_no == 0) {
            pagenationTxt.text = @"1";
        }
    }
}

/**
 * @description   Making the service call to get the records..
 * @date          20/02/2018
 * @method        goButtonPressesd:--
 * @author        Bhargav.v
 * @param         UIButton
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 19/03/2018....
 * @reason       changed comments....
 *
 * @verified By
 * @verified On
 *
 */

-(void)goButtonPressed:(UIButton *)sender {
    
    //Play Audio for Button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if(!isOfflineService){
            
            if(submitBtn.tag == 2)
                
                [self getPastBills];
            
            else if(submitBtn.tag == 4)
                
                [self callingSearchBills];
        }
        else {
            
            [self getPastBillsinOffline];
        }
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
    }
}

/**
 * @description
 * @date         17/10/2017
 * @method       showPaginationData:--
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 19/03/2018....
 * @reason       changed comments....
 *
 * @verified By
 * @verified On
 *
 */

-(void)showPaginationData:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(pagenationArr.count == 0 || pastBillsArr.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        float tableHeight = pagenationArr.count * 38;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArr.count * 33;
        
        if(pagenationArr.count> 5)
            tableHeight = (tableHeight/pagenationArr.count) * 5;
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:pastBillView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
    } @catch (NSException * exception) {
        
    }
    @finally{
        
        [HUD setHidden:YES];
    }
}

@end
