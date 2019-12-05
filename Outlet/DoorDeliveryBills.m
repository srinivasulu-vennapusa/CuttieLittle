//
//  DoorDeliveryBills.m
//  OmniRetailer
//
//  Created by MACPC on 9/1/15.
//
//

#import "DoorDeliveryBills.h"
#import "PastBilling.h"
#import "OmniHomePage.h"
#import "Global.h"
#import "CellView_TakeAwayOrder.h"
#import "WebServiceConstants.h"
#import "RequestHeader.h"


@interface DoorDeliveryBills ()

@end

@implementation DoorDeliveryBills
@synthesize soundFileURLRef,soundFileObject;
int billNo = 0;


#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
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
    NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self. soundFileURLRef = (__bridge CFURLRef) tapSound ;
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
    
    /*Creation of UIButton for providing user to get th info.......*/
    UIButton * summaryInfoBtn;
    
    UIImage * summaryImage;
    
    summaryImage = [UIImage imageNamed:@"summaryInfo.png"];
    
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self
                       action:@selector(showSummaryInfo:) forControlEvents:UIControlEventTouchDown];
    
    summaryInfoBtn.hidden = YES;
    
    pastBillField = [[UITextField alloc] init];
    pastBillField.borderStyle = UITextBorderStyleRoundedRect;
    pastBillField.textColor = [UIColor blackColor];
    pastBillField.font = [UIFont systemFontOfSize:18.0];
    pastBillField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pastBillField.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    pastBillField.autocorrectionType = UITextAutocorrectionTypeNo;
    // pastBillField.backgroundColor = [UIColor whiteColor];
    pastBillField.returnKeyType = UIReturnKeyDone;
    [pastBillField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    pastBillField.delegate = self;
    
    
    startDteField = [[UITextField alloc] init];
    startDteField.borderStyle = UITextBorderStyleRoundedRect;
    startDteField.textColor = [UIColor blackColor];
    startDteField.font = [UIFont systemFontOfSize:18.0];
    startDteField.backgroundColor = [UIColor clearColor];
    //    startDteField.text = currentdate;
    startDteField.userInteractionEnabled = NO;
    startDteField.clearButtonMode = UITextFieldViewModeWhileEditing;
    startDteField.autocorrectionType = UITextAutocorrectionTypeNo;
    startDteField.layer.borderWidth = 1.0f;
    startDteField.layer.cornerRadius = 10.0f;
    startDteField.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    startDteField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    startDteField.delegate = self;
    startDteField.placeholder = NSLocalizedString(@"Start Date", nil);
    [startDteField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    startDteField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:startDteField.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    UIImage  * billImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * billDteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [billDteButton setBackgroundImage:billImg forState:UIControlStateNormal];
    [billDteButton addTarget:self
                      action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    billDteButton.userInteractionEnabled = YES;
    billDteButton.tag = 2;
    
    endDteField = [[UITextField alloc] init];
    endDteField.borderStyle = UITextBorderStyleRoundedRect;
    endDteField.textColor = [UIColor blackColor];
    endDteField.font = [UIFont systemFontOfSize:18.0];
    endDteField.backgroundColor = [UIColor clearColor];
    endDteField.clearButtonMode = UITextFieldViewModeWhileEditing;
    endDteField.autocorrectionType = UITextAutocorrectionTypeNo;
    endDteField.layer.borderWidth = 1.0f;
    endDteField.layer.cornerRadius = 10.0f;
    endDteField.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    endDteField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    endDteField.userInteractionEnabled = NO;
    endDteField.delegate = self;
    endDteField.placeholder = NSLocalizedString(@"End Date", nil);
    [endDteField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    endDteField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:endDteField.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    UIButton * endDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [endDateButton setBackgroundImage:billImg forState:UIControlStateNormal];
    [endDateButton addTarget:self
                      action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    endDateButton.userInteractionEnabled = YES;
    
    
    
    customerMoblFld = [[UITextField alloc] init];
    customerMoblFld.borderStyle = UITextBorderStyleRoundedRect;
    customerMoblFld.textColor = [UIColor blackColor];
    customerMoblFld.font = [UIFont systemFontOfSize:18.0];
    customerMoblFld.backgroundColor = [UIColor clearColor];
    customerMoblFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerMoblFld.autocorrectionType = UITextAutocorrectionTypeNo;
    customerMoblFld.layer.borderWidth = 1.0f;
    customerMoblFld.layer.cornerRadius = 10.0f;
    customerMoblFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    customerMoblFld.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    customerMoblFld.delegate = self;
    customerMoblFld.placeholder = NSLocalizedString(@"Mobile Number", nil);
    [customerMoblFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    customerMoblFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerMoblFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    submitBtn = [[UIButton alloc] init] ;
    [submitBtn setTitle:@"Go" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    submitBtn.userInteractionEnabled = YES;
    submitBtn.layer.cornerRadius = 6.0f;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    submitBtn.tag = 2;
    
    //added by Srinivasulu on 06/08/2017....

    //creation of UIScrollView....
    itemsScrollView = [[UIScrollView alloc] init];
    
    //itemsScrollView.backgroundColor = [UIColor lightGrayColor];
    
    syncStatusLbl = [[UILabel alloc] init];
    syncStatusLbl.layer.cornerRadius = 5;
    syncStatusLbl.layer.masksToBounds = YES;
    syncStatusLbl.numberOfLines = 1;
    syncStatusLbl.textAlignment = NSTextAlignmentCenter;
    syncStatusLbl.font = [UIFont boldSystemFontOfSize:14.0];
    syncStatusLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    syncStatusLbl.textColor = [UIColor whiteColor];
    syncStatusLbl.text = NSLocalizedString(@"sync_status", nil);
    syncStatusLbl.font = [UIFont boldSystemFontOfSize:20];
    
    billAmountLbl = [[UILabel alloc] init];
    billAmountLbl.layer.cornerRadius = 5;
    billAmountLbl.layer.masksToBounds = YES;
    billAmountLbl.numberOfLines = 1;
    billAmountLbl.textAlignment = NSTextAlignmentCenter;
    billAmountLbl.font = [UIFont boldSystemFontOfSize:14.0];
    billAmountLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billAmountLbl.textColor = [UIColor whiteColor];
    billAmountLbl.text = NSLocalizedString(@"bill_amt", nil);
    billAmountLbl.font = [UIFont boldSystemFontOfSize:20];
    
    //upto here on 06/08/2017....
    
    /*Creation of UILabels used on top of the Table as headers*/
    SnoLbl = [[UILabel alloc] init];
    SnoLbl.layer.cornerRadius = 5;
    SnoLbl.textAlignment = NSTextAlignmentCenter;
    SnoLbl.layer.masksToBounds = YES;
    SnoLbl.font = [UIFont boldSystemFontOfSize:14.0];
    SnoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    SnoLbl.textColor = [UIColor whiteColor];
    
    order_Id = [[UILabel alloc] init];
    order_Id.layer.cornerRadius = 5;
    order_Id.textAlignment = NSTextAlignmentCenter;
    order_Id.layer.masksToBounds = YES;
    order_Id.font = [UIFont boldSystemFontOfSize:14.0];
    order_Id.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    order_Id.textColor = [UIColor whiteColor];
    
    
    orderdOn = [[UILabel alloc] init];
    orderdOn.layer.cornerRadius = 5;
    orderdOn.textAlignment = NSTextAlignmentCenter;
    orderdOn.layer.masksToBounds = YES;
    orderdOn.font = [UIFont boldSystemFontOfSize:14.0];
    orderdOn.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    orderdOn.textColor = [UIColor whiteColor];
    
    cost = [[UILabel alloc] init];
    cost.layer.cornerRadius = 5;
    cost.textAlignment = NSTextAlignmentCenter;
    cost.layer.masksToBounds = YES;
    cost.font = [UIFont boldSystemFontOfSize:14.0];
    cost.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cost.textColor = [UIColor whiteColor];
    
    
    counter = [[UILabel alloc] init];
    counter.layer.cornerRadius = 5;
    counter.textAlignment = NSTextAlignmentCenter;
    counter.layer.masksToBounds = YES;
    counter.font = [UIFont boldSystemFontOfSize:14.0];
    counter.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    counter.textColor = [UIColor whiteColor];
    
    billDoneBy = [[UILabel alloc] init];
    billDoneBy.layer.cornerRadius = 5;
    billDoneBy.textAlignment = NSTextAlignmentCenter;
    billDoneBy.layer.masksToBounds = YES;
    billDoneBy.font = [UIFont boldSystemFontOfSize:14.0];
    billDoneBy.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billDoneBy.textColor = [UIColor whiteColor];
    
    
    statusLbl = [[UILabel alloc] init];
    statusLbl.layer.cornerRadius = 5;
    statusLbl.textAlignment = NSTextAlignmentCenter;
    statusLbl.layer.masksToBounds = YES;
    statusLbl.font = [UIFont boldSystemFontOfSize:14.0];
    statusLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    statusLbl.textColor = [UIColor whiteColor];
    
    //added by Srinivasulu on 16/10/2017....
    
    billDoneModeLbl = [[UILabel alloc] init];
    billDoneModeLbl.layer.cornerRadius = 5;
    billDoneModeLbl.layer.masksToBounds = YES;
    billDoneModeLbl.numberOfLines = 1;
    billDoneModeLbl.textAlignment = NSTextAlignmentCenter;
    billDoneModeLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billDoneModeLbl.textColor = [UIColor whiteColor];
    
    //upto here on 16/10/2017....
    
    
    /** Table Creation*/
    pendingBills = [[UITableView alloc] init];
    pendingBills.separatorColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    pendingBills.dataSource = self;
    pendingBills.delegate = self;
    pendingBills.backgroundColor = [UIColor blackColor];
    pendingBills.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
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
    
    
    //up to here...
    
    
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
    

    //added by Srinivasulu on 13/06/2017....
    //populating data into respective fields....
    @try {
    
        self.titleLabel.text = NSLocalizedString(@"Door_Delivery_Bills", nil);
        
        pastBillField.placeholder = NSLocalizedString(@"search_bill", nil);
        
        //populating from localized stirng into the label used on top of the table....
        SnoLbl.text = NSLocalizedString(@"S_NO",nil);
        order_Id.text = NSLocalizedString(@"bill_id",nil);
        orderdOn.text = NSLocalizedString(@"date", nil);
        counter.text = NSLocalizedString(@"counter",nil);
        billDoneBy.text = NSLocalizedString(@"name",nil);
        cost.text = NSLocalizedString(@"bill_due",nil);
        statusLbl.text = NSLocalizedString(@"status", nil);
        billDoneModeLbl.text = NSLocalizedString(@"bill_mode", nil);
        
        totalRecordsLabel.text =  NSLocalizedString(@"total_records_", nil);
        totalRecordsValueLabel.text = @"0";


    } @catch (NSException *exception) {
        
    }
    //upto here on 13/06/2017....
    
    
    [self.view addSubview:summaryInfoBtn];
    [self.view addSubview:pastBillField];
    [self.view addSubview:customerMoblFld];
    [self.view addSubview:startDteField];
    [self.view addSubview:billDteButton];
    [self.view addSubview:endDteField];
    [self.view addSubview:endDateButton];
    [self.view addSubview:submitBtn];
    
    
    //changed by Srinivasulu on 06/08/2017....
    
//    [self.view addSubview:SnoLbl];
//    [self.view addSubview:order_Id];
//    [self.view addSubview:orderdOn];
//    [self.view addSubview:cost];
//    [self.view addSubview:counter];
//    [self.view addSubview:statusLbl];
//    [self.view addSubview:billDoneBy];
//    
//    [self.view addSubview:pendingBills];
    
    
    [itemsScrollView addSubview:SnoLbl];
    [itemsScrollView addSubview:order_Id];
    [itemsScrollView addSubview:orderdOn];
    [itemsScrollView addSubview:counter];
    [itemsScrollView addSubview:billDoneBy];
    [itemsScrollView addSubview:statusLbl];
    [itemsScrollView addSubview:cost];
    
//    if(isOfflineService){

    [itemsScrollView addSubview:billAmountLbl];
    [itemsScrollView addSubview:syncStatusLbl];
//    }
    
    
    //added by Srinivasulu on 16/10/2017....
    
    [itemsScrollView addSubview:billDoneModeLbl];
    
    //upto here on 16/10/2017....
    
    [itemsScrollView addSubview:pendingBills];
    
    [self.view addSubview:pagenationTxt];
    [self.view addSubview:dropDownBtn];
    [self.view addSubview:goButton];
    [self.view addSubview:goButton];
   
    [self.view addSubview:totalRecordsView];
    [totalRecordsView addSubview:totalRecordsLabel];
    [totalRecordsView addSubview:totalRecordsValueLabel];

    [self.view addSubview:itemsScrollView];

    //upto here on 06/08/2017....
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            
            summaryInfoBtn.frame = CGRectMake(self.view.frame.size.width-60, 80, 35, 30);
            
            pastBillField.font = [UIFont boldSystemFontOfSize:20];
            pastBillField.frame = CGRectMake(self.view.frame.origin.x + 10, summaryInfoBtn.frame.origin.y+40, 250, 40);
            
            customerMoblFld.font = [UIFont boldSystemFontOfSize:20];
            customerMoblFld.frame = CGRectMake(pastBillField.frame.origin.x+pastBillField.frame.size.width+65 , pastBillField.frame.origin.y, 180, 40);
            
            
            startDteField.font = [UIFont boldSystemFontOfSize:20];
            
            startDteField.frame = CGRectMake(customerMoblFld.frame.origin.x+customerMoblFld.frame.size.width+15 , pastBillField.frame.origin.y, 180, 40);
            
            billDteButton.frame = CGRectMake((startDteField.frame.origin.x+startDteField.frame.size.width-45), startDteField.frame.origin.y+2, 40, 35);
            
            endDteField.font = [UIFont boldSystemFontOfSize:20];
            
            endDteField.frame = CGRectMake(startDteField.frame.origin.x+startDteField.frame.size.width+15 , pastBillField.frame.origin.y, 180, 40);
            
            endDateButton.frame = CGRectMake((endDteField.frame.origin.x+endDteField.frame.size.width-45), endDteField.frame.origin.y+2, 40, 35);
            
            submitBtn.frame  = CGRectMake( self.view.frame.size.width - 90, endDteField.frame.origin.y, 80, 40);
            
            
            //changed by Srinivasulu on 06/08/2017....

            //changed by Srinivasulu on 006/08/2017....
            itemsScrollView.frame = CGRectMake( pastBillField.frame.origin.x, pastBillField.frame.origin.y + pastBillField.frame.size.height + 10, (submitBtn.frame.origin.x + submitBtn.frame.size.width) - pastBillField.frame.origin.x, self.view.frame.size.height - ( pastBillField.frame.origin.y + pastBillField.frame.size.height + 70));
            

            SnoLbl.frame = CGRectMake( 0, 0, 50, 38);
            
            order_Id.frame = CGRectMake((SnoLbl.frame.origin.x + SnoLbl.frame.size.width + 2), SnoLbl.frame.origin.y, 180, SnoLbl.frame.size.height);
            
            orderdOn.frame = CGRectMake((order_Id.frame.origin.x + order_Id.frame.size.width + 2), order_Id.frame.origin.y, 100, SnoLbl.frame.size.height);
            
            counter.frame = CGRectMake((orderdOn.frame.origin.x + orderdOn.frame.size.width + 2), orderdOn.frame.origin.y, 75, SnoLbl.frame.size.height);
            
            billDoneBy.frame = CGRectMake((counter.frame.origin.x + counter.frame.size.width + 2), counter.frame.origin.y, 110, SnoLbl.frame.size.height);
            
            statusLbl.frame = CGRectMake((billDoneBy.frame.origin.x + billDoneBy.frame.size.width + 2), billDoneBy.frame.origin.y, 120, SnoLbl.frame.size.height);
            
            
            
            //added by Srinivasulu on 09/08/2017....
            
             billAmountLbl.frame = CGRectMake((statusLbl.frame.origin.x + statusLbl.frame.size.width + 2), statusLbl.frame.origin.y, 100, 40.0);

            cost.frame = CGRectMake((billAmountLbl.frame.origin.x + billAmountLbl.frame.size.width + 2), cost.frame.origin.y, 100, SnoLbl.frame.size.height);

            syncStatusLbl.frame = CGRectMake(( cost.frame.origin.x + cost.frame.size.width + 2), cost.frame.origin.y, itemsScrollView.frame.size.width - ( cost.frame.origin.x + cost.frame.size.width + 2), SnoLbl.frame.size.height);

            


            
            float completeWidth = ( cost.frame.origin.x + cost.frame.size.width) - SnoLbl.frame.origin.x;
            
//            if(isOfflineService){
            
            //changed by Srinivasulu on 09/08/2017....

            billDoneModeLbl.frame = CGRectMake((syncStatusLbl.frame.origin.x + syncStatusLbl.frame.size.width + 5), cost.frame.origin.y, 100, SnoLbl.frame.size.height);

            //completeWidth = ( syncStatusLbl.frame.origin.x + syncStatusLbl.frame.size.width + 10) - SnoLbl.frame.origin.x;

            completeWidth = ( billDoneModeLbl.frame.origin.x + billDoneModeLbl.frame.size.width + 10) - SnoLbl.frame.origin.x;

            //upto here on 17/10/2017....
                
            //}
            
            //setting frame for UITableView....
            pendingBills.frame = CGRectMake( pendingBills.frame.origin.x, SnoLbl.frame.origin.y + SnoLbl.frame.size.height + 4, completeWidth, itemsScrollView.frame.size.height - (SnoLbl.frame.origin.y + SnoLbl.frame.size.height + 4));
            
            itemsScrollView.contentSize = CGSizeMake( completeWidth, itemsScrollView.frame.size.height);
            
            
            // Added By Bhargav.v on 21/02/2018.....
            pagenationTxt.frame = CGRectMake(pastBillField.frame.origin.x,itemsScrollView.frame.origin.y + itemsScrollView.frame.size.height + 10,90,40);
            
            dropDownBtn.frame = CGRectMake((pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width - 45), pagenationTxt.frame.origin.y - 5, 45, 50);
            
            goButton.frame  = CGRectMake(pagenationTxt.frame.origin.x+pagenationTxt.frame.size.width + 15,pagenationTxt.frame.origin.y,80, 40);

            // Added By Bhargav.v on 12/02/2018...
            // Reason: Assiging the frame for the totalRecordsView and the labels within the  view...
            totalRecordsView.frame = CGRectMake(endDteField.frame.origin.x + 60, pagenationTxt.frame.origin.y,submitBtn.frame.origin.x + submitBtn.frame.size.width - (endDteField.frame.origin.x + 60),pagenationTxt.frame.size.height);
            
            totalRecordsLabel.frame =  CGRectMake(5,0,140,40);
            totalRecordsValueLabel.frame = CGRectMake(totalRecordsLabel.frame.origin.x + totalRecordsLabel.frame.size.width - 60 , totalRecordsLabel.frame.origin.y, 120,40);

            //SnoLbl.font = [UIFont boldSystemFontOfSize:18];
            //order_Id.font = [UIFont boldSystemFontOfSize:18];
            //orderdOn.font = [UIFont boldSystemFontOfSize:18];
            //counter.font = [UIFont boldSystemFontOfSize:18];
            //billDoneBy.font = [UIFont boldSystemFontOfSize:18];
            //statusLbl.font = [UIFont boldSystemFontOfSize:18];
            //cost.font = [UIFont boldSystemFontOfSize:18];
            //billAmountLbl.font = [UIFont boldSystemFontOfSize:18];
            //syncStatusLbl.font = [UIFont boldSystemFontOfSize:18];
            //billDoneModeLbl.font = [UIFont boldSystemFontOfSize:18];
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:18.0f cornerRadius:0];
            
        }
        else {
            order_Id.font = [UIFont boldSystemFontOfSize:20];
            order_Id.frame = CGRectMake(30, 160, 150, 45);
            orderdOn .font = [UIFont boldSystemFontOfSize:20];
            orderdOn.frame = CGRectMake(285, 160, 150, 45);
            cost.font = [UIFont boldSystemFontOfSize:20];
            cost.frame = CGRectMake(550, 160, 150, 45);
        }
        
    }
    else {
        
        order_Id.font = [UIFont boldSystemFontOfSize:15];
        order_Id.frame = CGRectMake(0, 35, 70, 30);
        orderdOn .font = [UIFont boldSystemFontOfSize:15];
        orderdOn.frame = CGRectMake(135, 35, 70, 30);
        cost.font = [UIFont boldSystemFontOfSize:15];
        cost.frame = CGRectMake(245, 35, 70, 30);
        
    }

    
   
    
//    firstOrders = [UIButton buttonWithType:UIButtonTypeCustom];
//    [firstOrders addTarget:self action:@selector(loadFirstPage:) forControlEvents:UIControlEventTouchDown];
//    [firstOrders setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
//    firstOrders.layer.cornerRadius = 3.0f;
//    firstOrders.enabled = NO;
//    
//    lastOrders = [UIButton buttonWithType:UIButtonTypeCustom];
//    [lastOrders addTarget:self action:@selector(loadLastPage:) forControlEvents:UIControlEventTouchDown];
//    [lastOrders setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
//    lastOrders.layer.cornerRadius = 3.0f;
//    
//    /** Create PreviousButton */
//    previousOrders = [UIButton buttonWithType:UIButtonTypeCustom];
//    [previousOrders addTarget:self
//                       action:@selector(loadPreviousPage:) forControlEvents:UIControlEventTouchDown];
//    [previousOrders setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
//    previousOrders.enabled =  NO;
//    
//    /** Create NextButton */
//    nextOrders = [UIButton buttonWithType:UIButtonTypeCustom];
//    [nextOrders addTarget:self
//                   action:@selector(loadNextPage:) forControlEvents:UIControlEventTouchDown];
//    [nextOrders setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
//    
//    //bottom label1...
//    orderStart = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
//    orderStart.text = @"";
//    orderStart.textAlignment = NSTextAlignmentLeft;
//    orderStart.backgroundColor = [UIColor clearColor];
//    orderStart.textColor = [UIColor whiteColor];
//    
//    //bottom label_2...
//    label1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
//    label1.text = @"-";
//    label1.textAlignment = NSTextAlignmentLeft;
//    label1.backgroundColor = [UIColor clearColor];
//    label1.textColor = [UIColor whiteColor];
//    
//    //bottom label2...
//    orderEnd = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
//    orderEnd.text = @"";
//    orderEnd.textAlignment = NSTextAlignmentLeft;
//    orderEnd.backgroundColor = [UIColor clearColor];
//    orderEnd.textColor = [UIColor whiteColor];
//    
//    //bottom label_3...
//    label2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
//    label2.text = @"of";
//    label2.textAlignment = NSTextAlignmentLeft;
//    label2.backgroundColor = [UIColor clearColor];
//    label2.textColor = [UIColor whiteColor];
//    
//    //bottom label3...
//    totalOrder = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
//    totalOrder.textAlignment = NSTextAlignmentLeft;
//    totalOrder.backgroundColor = [UIColor clearColor];
//    totalOrder.textColor = [UIColor whiteColor];
//    
////    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
////        
////        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
////            
////            mainSegmentedControl.frame = CGRectMake(-2, 65, 770, 60);
////            mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
////            mainSegmentedControl.backgroundColor = [UIColor clearColor];
////            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
////                                        [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
////                                        nil];
////            [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
////            
////            
////            //            salesIdTable.frame = CGRectMake(300, 117, 360, 280);
////            
////            //            firstOrders.frame = CGRectMake(162, 700, 50, 50);
////            //            firstOrders.layer.cornerRadius = 25.0f;
////            //            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
////            //
////            //            lastOrders.frame = CGRectMake(705, 700, 50, 50);
////            //            lastOrders.layer.cornerRadius = 25.0f;
////            //            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
////            //
////            //            previousOrders.frame = CGRectMake(290, 700, 50, 50);
////            //            previousOrders.layer.cornerRadius = 22.0f;
////            //            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
////            //
////            //            nextOrders.frame = CGRectMake(580, 700, 50, 50);
////            //            nextOrders.layer.cornerRadius = 22.0f;
////            //            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
////            //
////            //
////            //            orderStart.frame = CGRectMake(375, 700, 100, 50);
////            //            label1.frame = CGRectMake(415, 700, 30, 50);
////            //            orderEnd.frame = CGRectMake(440, 700, 100, 50);
////            //            label2.frame = CGRectMake(480, 700, 30, 50);
////            //            totalOrder.frame = CGRectMake(515, 700, 100, 50);
////            //
////            //            orderStart.font = [UIFont systemFontOfSize:25.0];
////            //            label1.font = [UIFont systemFontOfSize:25.0];
////            //            orderEnd.font = [UIFont systemFontOfSize:25.0];
////            //            label2.font = [UIFont systemFontOfSize:25.0];
////            //            totalOrder.font = [UIFont systemFontOfSize:25.0];
////            
////            
////        }
////        else {
////            mainSegmentedControl.frame = CGRectMake(-2, 65, 770, 60);
////            mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
////            mainSegmentedControl.backgroundColor = [UIColor clearColor];
////            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
////                                        [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
////                                        nil];
////            [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
////            
////            pastBillField.font = [UIFont boldSystemFontOfSize:30];
////            pastBillField.frame = CGRectMake(180, 75, 360, 52);
////
////            
////            pendingBills.frame = CGRectMake(0, 210, 778, 700);
////            
////            
////            firstOrders.frame = CGRectMake(82, 940, 50, 50);
////            firstOrders.layer.cornerRadius = 25.0f;
////            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
////            
////            lastOrders.frame = CGRectMake(625, 940, 50, 50);
////            lastOrders.layer.cornerRadius = 25.0f;
////            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
////            
////            previousOrders.frame = CGRectMake(210, 940, 50, 50);
////            previousOrders.layer.cornerRadius = 22.0f;
////            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
////            
////            nextOrders.frame = CGRectMake(500, 940, 50, 50);
////            nextOrders.layer.cornerRadius = 22.0f;
////            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
////            
////            
////            orderStart.frame = CGRectMake(295, 940, 100, 50);
////            label1.frame = CGRectMake(335, 940, 30, 50);
////            orderEnd.frame = CGRectMake(360, 940, 100, 50);
////            label2.frame = CGRectMake(400, 940, 30, 50);
////            totalOrder.frame = CGRectMake(435, 940, 100, 50);
////            
////            orderStart.font = [UIFont systemFontOfSize:25.0];
////            label1.font = [UIFont systemFontOfSize:25.0];
////            orderEnd.font = [UIFont systemFontOfSize:25.0];
////            label2.font = [UIFont systemFontOfSize:25.0];
////            totalOrder.font = [UIFont systemFontOfSize:25.0];
////            
////            
////        }
////        
////    }
////    else {
////        if (version >= 8.0) {
////            
////            mainSegmentedControl.backgroundColor = [UIColor clearColor];
////            mainSegmentedControl.frame = CGRectMake(-2, 0.0, 324, 47);
////            
////            order_Id.font = [UIFont boldSystemFontOfSize:15];
////            order_Id.frame = CGRectMake(10, 70, 70, 30);
////            orderdOn .font = [UIFont boldSystemFontOfSize:15];
////            orderdOn.frame = CGRectMake(135, 70, 70, 30);
////            cost.font = [UIFont boldSystemFontOfSize:15];
////            cost.frame = CGRectMake(245, 70, 70, 30);
////            
////            pendingBills.frame = CGRectMake(0, 105, 320, self.view.frame.size.height-180);
////            
////            firstOrders.frame = CGRectMake(10, self.view.frame.size.height-45, 40, 40);
////            firstOrders.layer.cornerRadius = 15.0f;
////            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
////            
////            
////            lastOrders.frame = CGRectMake(273, self.view.frame.size.height-45, 40, 40);
////            lastOrders.layer.cornerRadius = 15.0f;
////            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
////            
////            previousOrders.frame = CGRectMake(70, self.view.frame.size.height-45, 40, 40);
////            previousOrders.layer.cornerRadius = 15.0f;
////            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
////            
////            nextOrders.frame = CGRectMake(210, self.view.frame.size.height-45, 40, 40);
////            nextOrders.layer.cornerRadius = 15.0f;
////            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
////            
////            orderStart.frame = CGRectMake(122, self.view.frame.size.height-45, 20, 30);
////            label1.frame = CGRectMake(140, self.view.frame.size.height-45, 20, 30);
////            orderEnd.frame = CGRectMake(148, self.view.frame.size.height-45, 20, 30);
////            label2.frame = CGRectMake(167, self.view.frame.size.height-45, 20, 30);
////            totalOrder.frame = CGRectMake(183, self.view.frame.size.height-45, 20, 30);
////            
////            orderStart.font = [UIFont systemFontOfSize:14.0];
////            label1.font = [UIFont systemFontOfSize:14.0];
////            orderEnd.font = [UIFont systemFontOfSize:14.0];
////            label2.font = [UIFont systemFontOfSize:14.0];
////            totalOrder.font = [UIFont systemFontOfSize:14.0];
////        }
////        else{
////            pastBillField.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
////            pastBillField.frame = CGRectMake(80, 0, 160, 30);
////
////            
////            pendingBills.frame = CGRectMake(0, 65, self.view.frame.size.width, 300);
////            
////            firstOrders.frame = CGRectMake(10, 375, 40, 40);
////            firstOrders.layer.cornerRadius = 15.0f;
////            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
////            
////            
////            lastOrders.frame = CGRectMake(273, 375, 40, 40);
////            lastOrders.layer.cornerRadius = 15.0f;
////            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
////            
////            previousOrders.frame = CGRectMake(80, 375, 40, 40);
////            previousOrders.layer.cornerRadius = 15.0f;
////            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
////            
////            nextOrders.frame = CGRectMake(210, 375, 40, 40);
////            nextOrders.layer.cornerRadius = 15.0f;
////            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
////            
////            orderStart.frame = CGRectMake(122, 375, 20, 30);
////            label1.frame = CGRectMake(140, 375, 20, 30);
////            orderEnd.frame = CGRectMake(148, 375, 20, 30);
////            label2.frame = CGRectMake(167, 375, 20, 30);
////            totalOrder.frame = CGRectMake(183, 375, 20, 30);
////            
////            orderStart.font = [UIFont systemFontOfSize:14.0];
////            label1.font = [UIFont systemFontOfSize:14.0];
////            orderEnd.font = [UIFont systemFontOfSize:14.0];
////            label2.font = [UIFont systemFontOfSize:14.0];
////            totalOrder.font = [UIFont systemFontOfSize:14.0];
////        }
////        
////        
////    }
//
//    [self.view addSubview:pendingBills];
//    [self.view  addSubview:firstOrders];
//    [self.view  addSubview:lastOrders];
//    [self.view  addSubview:previousOrders];
//    [self.view  addSubview:nextOrders];
//    [self.view  addSubview:orderStart];
//    [self.view  addSubview:label1];
//    [self.view  addSubview:orderEnd];
//    [self.view  addSubview:label2];
//    [self.view  addSubview:totalOrder];
    
    // initalize the arrays ..
    orderId = [[NSMutableArray alloc] init];
    counterArr = [[NSMutableArray alloc] init];
    billDue = [[NSMutableArray alloc] init];
    billDone = [[NSMutableArray alloc]init];
    order_date = [[NSMutableArray alloc]init];
    
    
    
    /*Creation of UITableView used in the popUps*/
    
    //salesIdTable Creation....
    salesIdTable = [[UITableView alloc] init];
    salesIdTable.layer.borderWidth = 1.0;
    salesIdTable.layer.cornerRadius = 4.0;
    salesIdTable.layer.borderColor = [UIColor grayColor].CGColor;
    salesIdTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    salesIdTable.dataSource = self;
    salesIdTable.delegate = self;
    
    //added by Srinivasulu on 08/06/2017....
    //this is used while calling the servcies....
    submitBtn.tag = 2;
    pastBillField.tag = 2;
    
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:YES];
//    //ProgressBar creation...
//
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
//    HUD.mode = MBProgressHUDModeCustomView;
//    [HUD setLabelText:@"Please wait..."];
//    [self.navigationController.view addSubview:HUD];
//    // Regiser for HUD callbacks so we can remove it from the window at the right time
//    HUD.delegate = self;
//
////    // Show the HUD
//    [HUD show:YES];
//    [HUD setHidden:NO];
//
//    billNo = 0;
//
//    [self getDoorDeliveryBills];
//}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidLoad.......
 * @date
 * @method       viewDidAppear
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 13/06/2017 && on 13/12/2017....
 * @reason      added the comments and added offline new offline DB call  .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //ProgressBar creation...
    
    //
    
    @try {
        if (doorDeliveryBillsArr ==  nil && doorDeliveryBillsArr.count == 0) {
            [HUD setHidden:NO];

            totalNumberOfRecords = 0;
            billNo  = 0;
            doorDeliveryBillsArr = [NSMutableArray new];
            
            if(!isOfflineService)
                 [self getDoorDeliveryBills];
            else
                [self getDoorDeliveryBillsinOffline];
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

//-(void)getDoorDeliveryBills {
//
//    if (!isOfflineService) {
//
//
//        WebServiceController *service = [[WebServiceController alloc] init];
//        [service setGetBillsDelegate:self];
//        [service getBills:billNo deliveryType:@"HD" status:@"tobedelivered"];
//
//
//    }
//    else {
//
//        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
//        NSMutableArray *result = [offline getDoorDeliveryBills:@""];
//        [HUD setHidden:YES];
//        if ([result count]>0) {
//
//            totalOrder.text = [result lastObject];
//            orderStart.text = [NSString stringWithFormat:@"%d",billNo+1];
//            orderEnd.text = [NSString stringWithFormat:@"%d",[orderStart.text intValue] + 9];
//
//            if ([totalOrder.text intValue] <= 10) {
//
//                orderEnd.text = [NSString stringWithFormat:@"%d",[totalOrder.text intValue]];
//                nextOrders.enabled =  NO;
//                previousOrders.enabled = NO;
//                firstOrders.enabled = NO;
//                lastOrders.enabled = NO;
//            }
//            else{
//
////                if (billNo == 0) {
////
////                    previousOrders.enabled = NO;
////                    firstOrders.enabled = NO;
////                    nextOrders.enabled = YES;
////                    lastOrders.enabled = YES;
////                }
//                orderEnd.text = totalOrder.text;
//
////                else if (([[result lastObject] intValue] -  (billNo+1)) < 10) {
////
////                    nextOrders.enabled = NO;
////                    lastOrders.enabled = NO;
////                    orderEnd.text = totalOrder.text;
////                }
//            }
//
//
//
//
//            NSDictionary *temp;
//
//            if ([orderId count]!=0) {
//
//                [orderId removeAllObjects];
//                [counterArr removeAllObjects];
//                [billDue removeAllObjects];
//                [billDone removeAllObjects];
//                [order_date removeAllObjects];
//
//            }
//
//            for (int i=0; i< [result count]-1 ; i++) {
//
//                temp = [result objectAtIndex:i];
//
//                [orderId addObject:[temp objectForKey:@"billId"]];
//                [billDue addObject:[temp objectForKey:@"dueAmount"]];
//                [order_date addObject:[temp objectForKey:@"dateAndTime"]];
//                [counterArr addObject:[temp objectForKey:COUNTER]];
//                if (![[temp objectForKey:CUSTOMER_NAME] isKindOfClass:[NSNull class]]) {
//
//                    [billDone addObject:[temp objectForKey:CUSTOMER_NAME]];
//
//                }
//                else {
//                    [billDone addObject:@"-"];
//
//                }
//            }
//
//            [pendingBills reloadData];
//
//            firstOrders.enabled = false;
//            nextOrders.enabled = false;
//            previousOrders.enabled = false;
//            lastOrders.enabled = false;
//
//        }
//        else {
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Bills not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }
//
//}

#pragma -mark methods used in service call....

/**
 * @description  here we are calling the getbills method.......
 * @date         13/12/2017....
 * @method       getDoorDeliveryBills
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


-(void)getDoorDeliveryBills{
    
    
//NSLog(@"---getPastBills---%d",billNo);
    
//if (!isOfflineService) {
        @try {
            
            [HUD setHidden:NO];
            
            if(doorDeliveryBillsArr == nil && billNo == 0){
                
                totalNumberOfRecords = 0;
                
                doorDeliveryBillsArr = [NSMutableArray new];
            }
            else if(doorDeliveryBillsArr.count) {
                
                [doorDeliveryBillsArr removeAllObjects];
            }
            
            WebServiceController * service = [[WebServiceController alloc] init];
            service.getBillsDelegate = self;
            [service getBills:billNo deliveryType:@"HD" status:@"tobedelivered"];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception.name);
            [HUD setHidden:NO];
            
            float y_axis = self.view.frame.size.height - 450;
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"door_delivery_bills_are_not_availabe", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 420)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:420 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    
    //}
    //else {
    //
    //@try {
    //OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
    //NSMutableArray *result = [offline getDoorDeliveryBills:@""];
    //[HUD setHidden:YES];
    //if ([result count]>0) {
    //
    //
    ////changed by Srinivasulu on 21/04/2017.....
    //if( [[result lastObject] isKindOfClass: [NSNumber class]]){
    //
    //NSLog(@"---------");
    //}
    //
    //totalNumberOfRecords = (int)[result count] ;
    //
    //
    //
    ////upto here on 21/04/2017....
    //
    //totalOrder.text = [result lastObject];
    //orderStart.text = [NSString stringWithFormat:@"%d",billNo+1];
    //orderEnd.text = [NSString stringWithFormat:@"%d",[orderStart.text intValue] + 9];
    //
    //if ([totalOrder.text intValue] <= 10) {
    //
    //orderEnd.text = [NSString stringWithFormat:@"%d",[totalOrder.text intValue]];
    //nextOrders.enabled =  NO;
    //previousOrders.enabled = NO;
    //firstOrders.enabled = NO;
    //lastOrders.enabled = NO;
    //}
    //else{
    //
    ////if (billNo == 0) {
    ////
    ////previousOrders.enabled = NO;
    ////firstOrders.enabled = NO;
    ////nextOrders.enabled = YES;
    ////lastOrders.enabled = YES;
    ////}
    //orderEnd.text = totalOrder.text;
    //
    ////else if (([[result lastObject] intValue] -  (billNo+1)) < 10) {
    ////
    ////nextOrders.enabled = NO;
    ////lastOrders.enabled = NO;
    ////orderEnd.text = totalOrder.text;
    ////}
    //}
    //
    //
    //
    //
    //NSDictionary *temp;
    //
    //if ([orderId count]!=0) {
    //
    //[orderId removeAllObjects];
    //[counterArr removeAllObjects];
    //[billDue removeAllObjects];
    //[billDone removeAllObjects];
    //[order_date removeAllObjects];
    //
    //}
    //
    //for (int i=0; i< [result count]-1 ; i++) {
    //
    //temp = [result objectAtIndex:i];
    //
    ////[orderId addObject:[temp objectForKey:@"billId"]];
    ////[billDue addObject:[temp objectForKey:@"dueAmount"]];
    ////[order_date addObject:[temp objectForKey:@"dateAndTime"]];
    ////[counterArr addObject:[temp objectForKey:COUNTER]];
    ////if (![[temp objectForKey:CUSTOMER_NAME] isKindOfClass:[NSNull class]]) {
    ////
    ////[billDone addObject:[temp objectForKey:CUSTOMER_NAME]];
    ////
    ////}
    ////else {
    ////[billDone addObject:@"-"];
    ////
    ////}
    //
    //
    //
    //[doorDeliveryBillsArr addObject:temp];
    //
    //}
    //
    //[pendingBills reloadData];
    //
    //firstOrders.enabled = false;
    //nextOrders.enabled = false;
    //previousOrders.enabled = false;
    //lastOrders.enabled = false;
    //
    //}
    //else {
    //[HUD setHidden:YES];
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Bills not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alert show];
    //}
    //} @catch (NSException *exception) {
    //
    //} @finally {
    //
    //}
    
    //}
}


#pragma -mark getBillingDelegateMethods

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
        
        [pendingBills setUserInteractionEnabled: YES];
  
        if (![[successDictionary valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
            
            totalNumberOfRecords = [[successDictionary valueForKey:@"totalRecords"] intValue];
            
            for(NSDictionary *dic in [successDictionary valueForKey:@"billsList"]){
                
                
                [doorDeliveryBillsArr addObject:dic];
            }
        }
        
        //added by bhargava on --/--/----.. inorder  to  display total complete bills Count...
        totalRecordsValueLabel.text = [NSString stringWithFormat:@"%@%.f",@"",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS] defaultReturn:@"0.00"] floatValue]];
       
        // Calling the Method to display pagenation.....
        [self pagenationHandler];
        
        //upto here on --/--/----....

    }
    @catch (NSException *exception) {
        NSLog(@"exception in service call %@",exception);
    }
    @finally {
        
        
        [HUD  setHidden:YES];
        [pendingBills reloadData];
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
    float y_axis;
    
    @try {
        BOOL isShowAlert = NO;
        
        [HUD setHidden:YES];
        
        
        
        //    nextOrders.enabled =  NO;
        //    previousOrders.enabled = NO;
        //    firstOrders.enabled = NO;
        //    lastOrders.enabled = NO;
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:failureString message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        
        if(pastBillField.tag == 2){
        
            isShowAlert = YES;
        }
        else{
            
            pastBillField.tag = 2;
            isShowAlert = YES;
        }
    
        
        if( isShowAlert){
            
            y_axis = self.view.frame.size.height - 450;
            
            mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",failureString];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 420)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:420 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
        totalRecordsValueLabel.text = @"0";

        
    } @catch (NSException *exception) {
        
        mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 420)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:420 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        
        //added by bhargava on --/--/----.. inorder  to  display total complete bills Count....
        
        if( billNo == 0 || doorDeliveryBillsArr.count == 0 ) {
            
            pagenationTxt.text = @"1";
            totalNumberOfRecords = 0;
            [self pagenationHandler];
        }
        //upto here on --/--/----....
    }
}

#pragma -mark method used in offline to retrive data....

/**
 * @description  get all the offline bills details....
 * @date
 * @method       getDoorDeliveryBillsinOffline
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

-(void)getDoorDeliveryBillsinOffline {
    
    [HUD setHidden:NO];
    
    NSString * mesg;
    float y_axis  = self.view.frame.size.height - 450;
    
    @try {
        
        if(doorDeliveryBillsArr == nil && billNo == 0){
            
            totalNumberOfRecords = 0;
            
            doorDeliveryBillsArr = [NSMutableArray new];
        }
        else if(doorDeliveryBillsArr.count) {
            
            [doorDeliveryBillsArr removeAllObjects];
        }

        
        NSString * startDteStr = startDteField.text;
        NSString * endDteStr  = endDteField.text;
        
        
        OfflineBillingServices * offline = [[OfflineBillingServices alloc] init];
        NSMutableDictionary * successDictionary = [offline getBillInfo:TO_BE_DELIVERED searchInfo:@""  mobileNo:customerMoblFld.text startingDate:startDteStr endDate:endDteStr startIndex:billNo maxRecords:13];
        
        if([[successDictionary valueForKey:BILL_LIST] count]){
            
            totalNumberOfRecords = [[successDictionary valueForKey:TOTAL_SKUS] intValue];
            
            for(NSDictionary *dic in [successDictionary valueForKey:BILL_LIST]){
                
                [doorDeliveryBillsArr addObject:dic];
            }
            
            //Displaying the  Total Records Count...
            totalRecordsValueLabel.text = [NSString stringWithFormat:@"%@%.2f",@"",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS] defaultReturn:@"0.00"] floatValue]];
            
            // Calling the Method to display pagenation.....
            [self pagenationHandler];
        }
        
    } @catch (NSException *exception) {
        
        mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"door_delivery_bills_are_not_availabe", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 420)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:420 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @finally {
        if(!doorDeliveryBillsArr.count){
            
            mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"door_delivery_bills_are_not_availabe", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 420)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:420 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
        [pendingBills reloadData];
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
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && exception handling....
 *
 * @return
 * @return
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
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && exception handling....
 *
 * @return
 * @return
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
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && exception handling....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    @try {
        if(textField == pastBillField) {
            
            @try {
                
                NSString * value = [pastBillField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                saleId = pastBillField.text;
                
                if (saleId.length == 3 && value.length != 0) {
                    
                    if (!isOfflineService) {
                        
                        //added by Srinivasulu on 13/06/2017....
                        pastBillField.tag = 4;
                        //upto here on 13/06/2017....
                        
                        WebServiceController *controller = [[WebServiceController alloc] init];
                        controller.getBillsDelegate = self;
                        [controller getBillIds:0 deliveryType:@"HD" status:@"tobedelivered" searchCriteria:saleId];
                        
                    }
                    else {
                        
                        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
                        NSMutableArray *result = [offline getDoorDeliveryBills:pastBillField.text];
                        [HUD setHidden:YES];
                        filteredSkuArrayList = nil;
                        filteredSkuArrayList = [result mutableCopy];
                        
                        
                    }
                }
                else if(saleId.length > 3){
                    
                    filteredSkuArrayList = [[NSMutableArray alloc] init];
                    if (!isOfflineService) {
                        
                        @try {
                            
                            for (NSString *product in salesIdArray)
                            {
                                NSComparisonResult result = [product compare:pastBillField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, (pastBillField.text).length)];
                                
                                if (result == NSOrderedSame)
                                {
                                    [filteredSkuArrayList addObject:product];
                                }
                            }
                        }
                        @catch (NSException *exception) {
                            
                            
                        }
                    }
                    
                    else
                        
                    {
                        
                        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
                        NSMutableArray *result = [offline getDoorDeliveryBills:pastBillField.text];
                        [HUD setHidden:YES];
                        filteredSkuArrayList = nil;
                        filteredSkuArrayList = [result mutableCopy];
                        
                    }
                    
                }
                else if(saleId.length == 2){
                    
                    //salesIdTable.hidden =YES;
                }
                else{
                    //salesIdTable.hidden =YES;
                    //return NO;
                }
                
                
            } @catch (NSException *exception) {
                
            } @finally {
                
                if(filteredSkuArrayList.count && (saleId.length >= 3)){
                    float tableHeight = filteredSkuArrayList.count * 50;
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                        tableHeight = filteredSkuArrayList.count * 33;
                    
                    if(filteredSkuArrayList.count > 5)
                        tableHeight = (tableHeight/filteredSkuArrayList.count) * 5;
                    
                    
                    
                    [self showPopUpForTables:salesIdTable  popUpWidth:pastBillField.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pastBillField  showViewIn:self.view permittedArrowDirections:UIPopoverArrowDirectionUp];
                }
                else
                    [catPopOver dismissPopoverAnimated:YES];
                
            }
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
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
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 */

-(void)getBillIdsSuccessResponse:(NSDictionary *)successDic{
    
    @try {
        
        //added by Srinivasulu on 08/06/2017....
        pastBillField.tag = 2;
        
        [self getExistedSaleIDHandler:successDic];

    } @catch (NSException *exception) {
        
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
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 08/06/2017....
 * @reason      added the comments and     .... not completed....
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
            
            salesIdTable.hidden = NO;
            [self.view bringSubviewToFront:salesIdTable];
            
            [salesIdTable reloadData];
        }
        else{
            
            [HUD setHidden:YES];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        
        if(filteredSkuArrayList.count){
            float tableHeight = filteredSkuArrayList.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = filteredSkuArrayList.count * 33;
            
            if(filteredSkuArrayList.count > 5)
                tableHeight = (tableHeight/filteredSkuArrayList.count) * 5;
            
            
            
            [self showPopUpForTables:salesIdTable  popUpWidth:pastBillField.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pastBillField  showViewIn:self.view permittedArrowDirections:UIPopoverArrowDirectionUp];
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
 * @return       NSInteger
 *
 * @modified BY  Srinivasulu on 08/06/201477....
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == salesIdTable) {
        
        return filteredSkuArrayList.count;
    }
    else if (tableView == pagenationTbl) {
        return pagenationArr.count;
        
    }
    
    else {
        return doorDeliveryBillsArr.count;
        
    }
}

/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date
 * @method       tableView: heightForRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 38;
    }
    else {
        return 50.0;
    }
    
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
 * @modified BY  Srinivasulu on 13/06/2017 && on 13/12/2017....
 * @reason       changed the comment's section && added offline service call....
 *
 * @verified By
 * @verified On
 */

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    if(tableView == pendingBills) {
        
        @try {
            
            //changed by Srinivasulu on 13/06/2017....
            
            
//            if (!isOfflineService){
//
//                if((indexPath.row == ([doorDeliveryBillsArr count] - 1))  && ([doorDeliveryBillsArr count] < totalNumberOfRecords)){
//                    [HUD show: YES];
//                    [HUD setHidden:NO];
//                    billNo = billNo + 10;
//                    if(submitBtn.tag == 2 )
//                        [self getDoorDeliveryBills];
//                    else if (submitBtn.tag  == 4)
//                        [self callingSearchBills];
//
//                }
//
//
//            }
//            else{
            
//                if((indexPath.row == ([doorDeliveryBillsArr count] - 1))  && ([doorDeliveryBillsArr count] < (totalNumberOfRecords - 1))){
//                    [HUD show: YES];
//                    [HUD setHidden:NO];
//                    billNo = billNo + 10;
//                    
//                    if(!isOfflineService)
//                    {
//                        if(submitBtn.tag == 2 )
            
//                            [self getDoorDeliveryBills];
//                        else if (submitBtn.tag  == 4)
//                            [self callingSearchBills];
//                    }
//                    else{
//                        
//                        [self getDoorDeliveryBillsinOffline];
//                    }
//                    
//                }
            
//            }
            
            //upto here on 13/06/2017....
            
        } @catch (NSException *exception) {
            NSLog(@"----exception in servicecall----%@",exception);
            [HUD setHidden:YES];
            
        } @finally {
            
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
 * @return       UITableViewCell
 *
 * @modified BY  Srinivasulu on 13/06/2017....
 * @reason       changed the comment's section and populating the data into labels....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == salesIdTable) {
        
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
    
    //added by Srinivasulu on 06/08/2017....
    
    else if(tableView == pendingBills){
        
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
            UILabel * bill_status_Lbl;
            UILabel * billDue_Lbl;
            UILabel * bill_amount_Lbl;
            UILabel * sync_status_Lbl;
            //added by Srinivasulu on 16/10/2017....
            
            UILabel * bill_Done_Mode_Lbl;
            
            //upto here on 16/10/2017....
            
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
            
            bill_status_Lbl = [[UILabel alloc] init];
            bill_status_Lbl.backgroundColor =  [UIColor clearColor];
            bill_status_Lbl.textAlignment = NSTextAlignmentCenter;
            bill_status_Lbl.numberOfLines = 2;
            
            billDue_Lbl = [[UILabel alloc] init];
            billDue_Lbl.backgroundColor =  [UIColor clearColor];
            billDue_Lbl.textAlignment = NSTextAlignmentCenter;
            billDue_Lbl.numberOfLines = 2;
            
            bill_amount_Lbl = [[UILabel alloc] init];
            bill_amount_Lbl.backgroundColor = [UIColor clearColor];
            bill_amount_Lbl.textAlignment = NSTextAlignmentCenter;
            bill_amount_Lbl.numberOfLines = 1;
            bill_amount_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            sync_status_Lbl = [[UILabel alloc] init];
            sync_status_Lbl.backgroundColor = [UIColor clearColor];
            sync_status_Lbl.textAlignment = NSTextAlignmentCenter;
            sync_status_Lbl.numberOfLines = 1;
            sync_status_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            //added by Srinivasulu on 16/10/2017....
            
            bill_Done_Mode_Lbl = [[UILabel alloc] init];
            bill_Done_Mode_Lbl.backgroundColor = [UIColor clearColor];
            bill_Done_Mode_Lbl.textAlignment = NSTextAlignmentCenter;
            bill_Done_Mode_Lbl.numberOfLines = 1;
            bill_Done_Mode_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            //upto here on 16/10/2017....
            
            /* assiginig the font and color of the labels  */
            
            s_no_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0];
            bill_Id_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            returnBill_Date_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            counter_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            userName_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            bill_status_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            billDue_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            bill_amount_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            sync_status_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            bill_Done_Mode_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

            s_no_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            bill_Id_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            returnBill_Date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            counter_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            userName_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            bill_status_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];
            billDue_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];
            sync_status_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];
            bill_amount_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];
            bill_Done_Mode_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7f];

            //creation on  UILabels....
            CAGradientLayer * layer_1;
            CAGradientLayer * layer_2;
            CAGradientLayer * layer_3;
            CAGradientLayer * layer_4;
            CAGradientLayer * layer_5;
            CAGradientLayer * layer_6;
            CAGradientLayer * layer_7;
            CAGradientLayer * layer_8;
            CAGradientLayer * layer_9;
            CAGradientLayer * layer_10;

            
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
            
            layer_7 = [CAGradientLayer layer];
            layer_7.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            layer_8 = [CAGradientLayer layer];
            layer_8.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            layer_9 = [CAGradientLayer layer];
            layer_9.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            layer_10 = [CAGradientLayer layer];
            layer_10.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            
            [s_no_Lbl.layer addSublayer:layer_1];
            [bill_Id_Lbl.layer addSublayer:layer_2];
            [returnBill_Date_Lbl.layer addSublayer:layer_3];
            [counter_Lbl.layer addSublayer:layer_4];
            [userName_Lbl.layer addSublayer:layer_5];
            [bill_status_Lbl.layer addSublayer:layer_6];
            [billDue_Lbl.layer addSublayer:layer_7];
            [bill_amount_Lbl.layer addSublayer:layer_8];
            [sync_status_Lbl.layer addSublayer:layer_9];
            [bill_Done_Mode_Lbl.layer addSublayer:layer_10];

            //added subViews to cell contentView....
            [hlcell.contentView addSubview:s_no_Lbl];
            [hlcell.contentView addSubview:bill_Id_Lbl];
            [hlcell.contentView addSubview:returnBill_Date_Lbl];
            [hlcell.contentView addSubview:counter_Lbl];
            [hlcell.contentView addSubview:userName_Lbl];
            [hlcell.contentView addSubview:bill_status_Lbl];
            [hlcell.contentView addSubview:billDue_Lbl];
            
//            if(isOfflineService){
            
                [hlcell.contentView addSubview:sync_status_Lbl];
                [hlcell.contentView addSubview:bill_amount_Lbl];
//            }
            
            [hlcell.contentView addSubview:bill_Done_Mode_Lbl];

            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                }
                else{
                }
                
                
                //setting frame....
                s_no_Lbl.frame = CGRectMake( SnoLbl.frame.origin.x, 0, SnoLbl.frame.size.width, hlcell.frame.size.height);
                bill_Id_Lbl.frame = CGRectMake( order_Id.frame.origin.x, 0, order_Id.frame.size.width,  hlcell.frame.size.height);
                returnBill_Date_Lbl.frame = CGRectMake( orderdOn.frame.origin.x, 0, orderdOn.frame.size.width,  hlcell.frame.size.height);
                counter_Lbl.frame = CGRectMake( counter.frame.origin.x, 0, counter.frame.size.width,  hlcell.frame.size.height);
                userName_Lbl.frame = CGRectMake( billDoneBy.frame.origin.x, 0, billDoneBy.frame.size.width,  hlcell.frame.size.height);
                bill_status_Lbl.frame = CGRectMake( statusLbl.frame.origin.x, 0, statusLbl.frame.size.width,  hlcell.frame.size.height);
                billDue_Lbl.frame = CGRectMake( cost.frame.origin.x, 0, cost.frame.size.width,  hlcell.frame.size.height);
                
                //added by Srinivasulu 27/07/2017....
                
//                if(isOfflineService){
                
                    bill_amount_Lbl.frame = CGRectMake( billAmountLbl.frame.origin.x, 0, billAmountLbl.frame.size.width,  hlcell.frame.size.height);
                    layer_8.frame = CGRectMake( 0, hlcell.frame.size.height - 2, billAmountLbl.frame.size.width, 2);
                    
                    sync_status_Lbl.frame = CGRectMake( syncStatusLbl.frame.origin.x, 0, syncStatusLbl.frame.size.width,  hlcell.frame.size.height);
                    layer_9.frame = CGRectMake( 0, hlcell.frame.size.height - 2, sync_status_Lbl.frame.size.width, 2);
//                }
                //upto here on27/07/2017....
                
                bill_Done_Mode_Lbl.frame = CGRectMake( billDoneModeLbl.frame.origin.x, 0, billDoneModeLbl.frame.size.width,  hlcell.frame.size.height);
                layer_10.frame = CGRectMake( 0, hlcell.frame.size.height - 2, bill_Done_Mode_Lbl.frame.size.width, 2);
                
                layer_1.frame = CGRectMake( 0, hlcell.frame.size.height - 2, s_no_Lbl.frame.size.width, 2);
                layer_2.frame = CGRectMake( 0, hlcell.frame.size.height - 2, bill_Id_Lbl.frame.size.width, 2);
                layer_3.frame = CGRectMake( 0, hlcell.frame.size.height - 2, returnBill_Date_Lbl.frame.size.width, 2);
                layer_4.frame = CGRectMake( 0, hlcell.frame.size.height - 2, counter_Lbl.frame.size.width, 2);
                layer_5.frame = CGRectMake( 0, hlcell.frame.size.height - 2, userName_Lbl.frame.size.width, 2);
                layer_6.frame = CGRectMake( 0, hlcell.frame.size.height - 2, bill_status_Lbl.frame.size.width, 2);
                layer_7.frame = CGRectMake( 0, hlcell.frame.size.height - 2, billDue_Lbl.frame.size.width, 2);
                
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell.contentView andSubViews:YES fontSize:16.0f cornerRadius:0];

            }
            else{
                //need to give frame's for iPhone....
                
            }
            
            
            
            
            
            //setting frame and font..........
            
            @try {

                s_no_Lbl.text = [NSString stringWithFormat:@"%ld", (indexPath.row + 1) + billNo];
                
                NSDictionary * cancelledBIllDetails  = doorDeliveryBillsArr[indexPath.row];
                
                if (!isCustomerBillId) {
                    bill_Id_Lbl.text = [cancelledBIllDetails valueForKey:BILL_ID] ;
                }
                else {
                    bill_Id_Lbl.text = [self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:kSerialBillId] defaultReturn:@"--"];
                }
            
                returnBill_Date_Lbl.text = [[self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:BUSSINESS_DATE] defaultReturn:@"--"] componentsSeparatedByString:@" "][0];
                
                counter_Lbl.text = [self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:COUNTER] defaultReturn:@"--"];
                userName_Lbl.text =[self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:CUSTOMER_NAME] defaultReturn:@"--"];
                bill_status_Lbl.text = [self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:STATUS] defaultReturn:@""];
                billDue_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:BILL_DUE] defaultReturn:@"0.00"] floatValue]];
                
                    bill_amount_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:TOTAL_BILL_AMT] defaultReturn:@"0.00"] floatValue]];
                
                    sync_status_Lbl.text = [self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:SYNC_STATUS] defaultReturn:@"--"];
                
//                if(isOfflineService)
//                    bill_Done_Mode_Lbl.text = NSLocalizedString(@"offline", nil);
//                else{
                
                    if([cancelledBIllDetails.allKeys containsObject:OFFLINE_BILL] && (![[cancelledBIllDetails valueForKey:OFFLINE_BILL] isKindOfClass:[NSNull class]])){
                        
                        if([[cancelledBIllDetails valueForKey:OFFLINE_BILL] intValue]){
                            
                            bill_Done_Mode_Lbl.text = NSLocalizedString(@"offline", nil);
                        }
                        else{
                            
                            bill_Done_Mode_Lbl.text = NSLocalizedString(@"online", nil);
                        }
                        
                    }
                    else{
                        
                        bill_Done_Mode_Lbl.text = NSLocalizedString(@"online", nil);
                    }
                                        
//                }
                
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
    
    else if (tableView == pagenationTbl){
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
            hlcell.textLabel.text = pagenationArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
        }
    }
    
    
    //upto here on 06/08/2017....

    
    else {
        
        static NSString *MyIdentifier = @"OrderCell";
        
        CellView_TakeAwayOrder *cell;
        
        tableView.separatorColor = [UIColor clearColor];
        
        cell = (CellView_TakeAwayOrder *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
        
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CellView_TakeAwayOrder" owner:self options:nil][0];
        }
        
        @try {
            //            cell.SNo.text  = [NSString stringWithFormat:@"%i", (indexPath.row + 1)];
            //            cell.orderId.text = [orderId objectAtIndex:indexPath.row];
            //            // cell.tableNo.text = [tableId objectAtIndex:indexPath.row];
            //            //  cell.waiterName.text = [billDue objectAtIndex:indexPath.row];
            //            cell.totalBill.text = [NSString stringWithFormat:@"%.2f",[[billDue objectAtIndex:indexPath.row] floatValue]];
            //
            //
            //            if ([order_date count]!=0) {
            //                cell.orderDate.text = [[[order_date objectAtIndex:indexPath.row] componentsSeparatedByString:@" "] objectAtIndex:0];
            //            }
            //            else {
            //                cell.orderDate.text = @"";
            //
            //            }
            //            cell.counter.text = [counterArr objectAtIndex:indexPath.row];
            //            cell.billDone.text =[billDone objectAtIndex:indexPath.row];
            
            
            NSDictionary * cancelledBIllDetails  = doorDeliveryBillsArr[indexPath.row];
            
            cell.SNo.text = [NSString stringWithFormat:@"%i", (int)(indexPath.row + 1)];
            
            //changed by Srinivasulu on 08/07/2017....
            //undo by Srinivasulu on 10/07/2017....
            
            if (!isCustomerBillId) {
               
                cell.orderId.text = [cancelledBIllDetails valueForKey:BILL_ID] ;
            }
            else {
                
                cell.orderId.text = [self checkGivenValueIsNullOrNil:[cancelledBIllDetails valueForKey:kSerialBillId] defaultReturn:@"--"];
            }
     
            
            //upto here on 08/07/2017....
            
            
            cell.orderDate.text = [[cancelledBIllDetails valueForKey:BUSSINESS_DATE] componentsSeparatedByString:@" "][0];
            
            cell.counter.text = [cancelledBIllDetails valueForKey:COUNTER];
            
            if (![cancelledBIllDetails[CUSTOMER_NAME] isKindOfClass:[NSNull class]]&& [cancelledBIllDetails[CUSTOMER_NAME] length] > 0) {
                cell.billDone.text = [NSString stringWithFormat:@"%@",cancelledBIllDetails[CUSTOMER_NAME]];
            }
            else {
                cell.billDone.text =  @"-";
                
            }
            cell.totalBill.text = [NSString stringWithFormat:@"%.f",[[cancelledBIllDetails valueForKey:BILL_DUE] floatValue]];
            cell.status.text = [cancelledBIllDetails valueForKey:STATUS];
            
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception.name);
        }
        
        cell.backgroundColor = [UIColor blackColor];
        //  cell.waiterName.textColor = [UIColor whiteColor];
        //  cell.tableNo.textColor = [UIColor whiteColor];
        cell.totalBill.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        cell.orderDate.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        cell.orderId.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
        cell.orderId.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        cell.orderId.backgroundColor = [UIColor clearColor] ;
        cell.ticketTotal.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            cell.frame = CGRectMake(0, 0,200, 45);
            cell.orderId.frame = CGRectMake(5,16,120,20);
            cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0];
            //cell.orderId.backgroundColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            cell.orderId.layer.cornerRadius = 10.0f;
            cell.orderId.layer.masksToBounds = YES;
            cell.orderId.textColor = [UIColor whiteColor];
            cell.orderDate.frame = CGRectMake(130,16,150 ,20);
            cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            cell.totalBill.frame = CGRectMake(255,16,130 ,20);
            cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            
            cell.counter.hidden = YES;
            
            if (version >= 8.0) {
                cell.totalBill.frame = CGRectMake(255.0,16,130 ,20);
            }
            
        }
        else {
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
                cell.frame = CGRectMake(SnoLbl.frame.origin.x, 0,970, 50);
                
                cell.SNo.frame = CGRectMake( 0, 0, SnoLbl.frame.size.width, cell.frame.size.height);
                cell.SNo.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                
                cell.orderId.frame = CGRectMake(cell.SNo.frame.origin.x + cell.SNo.frame.size.width+5, 0, order_Id.frame.size.width,  cell.frame.size.height);
                cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                
                
                cell.orderDate.frame = CGRectMake(cell.orderId.frame.origin.x + cell.orderId.frame.size.width+5, 0, orderdOn.frame.size.width,  cell.frame.size.height);
                cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                
                cell.counter.frame = CGRectMake(cell.orderDate.frame.origin.x + cell.orderDate.frame.size.width+5, 0, counter.frame.size.width + 5,  cell.frame.size.height);
                cell.counter.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                
                
                cell.billDone.frame = CGRectMake(cell.counter.frame.origin.x + cell.counter.frame.size.width, 0, billDoneBy.frame.size.width + 5,  cell.frame.size.height);
                cell.billDone.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                
                cell.status.frame = CGRectMake( cell.billDone.frame.origin.x + cell.billDone.frame.size.width, 0, statusLbl.frame.size.width + 5,  cell.frame.size.height);
                cell.status.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                
                
                
                
                cell.totalBill.frame = CGRectMake( cell.status.frame.origin.x + cell.status.frame.size.width, 0, cost.frame.size.width + 5,  cell.frame.size.height);
                cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                
                
                
                CAGradientLayer *layer_1 = [CAGradientLayer layer];
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                [cell.SNo.layer addSublayer:layer_1];
                
                CAGradientLayer *layer_2 = [CAGradientLayer layer];
                layer_2.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                [cell.orderId.layer addSublayer:layer_2];
                
                CAGradientLayer *layer_3 = [CAGradientLayer layer];
                layer_3.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                [cell.orderDate.layer addSublayer:layer_3];
                
                CAGradientLayer *layer_4 = [CAGradientLayer layer];
                layer_4.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                [cell.counter.layer addSublayer:layer_4];
                
                
                CAGradientLayer *layer_5 = [CAGradientLayer layer];
                layer_5.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                [cell.billDone.layer addSublayer:layer_5];
                
                
                CAGradientLayer *layer_6 = [CAGradientLayer layer];
                layer_6.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                [cell.status.layer addSublayer:layer_6];
                
                
                CAGradientLayer *layer_7 = [CAGradientLayer layer];
                layer_7.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                [cell.totalBill.layer addSublayer:layer_7];
                
                layer_1.frame = CGRectMake( 0, cell.frame.size.height - 2, cell.SNo.frame.size.width - 5,2);
                layer_2.frame = CGRectMake( 1, cell.frame.size.height - 2, cell.orderId.frame.size.width - 5,2);
                layer_3.frame = CGRectMake( 1, cell.frame.size.height - 2, cell.orderDate.frame.size.width - 5, 2);
                layer_4.frame = CGRectMake( 1, cell.frame.size.height - 2, cell.counter.frame.size.width - 5, 2);
                layer_5.frame = CGRectMake( 1, cell.frame.size.height - 2, cell.billDone.frame.size.width - 5, 2);
                layer_6.frame = CGRectMake( 1, cell.frame.size.height - 2, cell.status.frame.size.width - 5, 2);
                layer_7.frame = CGRectMake( 1, cell.frame.size.height - 2, cell.totalBill.frame.size.width - 5, 2);
                
                
            }
            else {
                cell.orderId.frame = CGRectMake(33,12,150,40);
                cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                //cell.orderId.backgroundColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
                cell.orderId.layer.cornerRadius = 10.0f;
                cell.orderId.layer.masksToBounds = YES;
                cell.orderId.textColor = [UIColor whiteColor];
                cell.orderDate.frame = CGRectMake(315,12,220 ,28);
                cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                cell.totalBill.frame = CGRectMake(570,18,202 ,34);
                cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            }
        }
        return cell;
    }
}

/**
 * @description  it is tableview delegate method it will be called after cellForRowIndexPath.......
 * @date
 * @method       tableView: didSelectRowAtIndexPath:
 * @author
 * @param        UITableView
 * @param        NSIndexPath
 * @param
 * @return       void
 *
 * @modified BY  Srinivasulu on 13/06/2017....
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //dismissing the catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];

    
    @try {
        PastBilling *past_bill;
        
        if (tableView == pendingBills) {
            
            
            NSDictionary *detailsDic = doorDeliveryBillsArr[indexPath.row];
            
            past_bill = [[PastBilling alloc] initWithBillType:@""];
            
            past_bill.pastBillId = [[detailsDic valueForKey:BILL_ID] copy];
            
            //changed by Srinivasulu on 08/07/2017....
            //undo by Srinivasulu on10/07/2017.... reason service modification are done....

            if (isCustomerBillId) {
                past_bill.pastBillId = [[detailsDic valueForKey:kSerialBillId] copy];
            }
            else {
                past_bill.pastBillId = [[detailsDic valueForKey:BILL_ID] copy];
                
            }
            
            //upto here on 08/07/2017....

            
            billTypeStatus = TRUE;
            typeBilling = @"past";
            past_bill.billingType = @"past";
            past_bill.isBillSummery=false;
            // pastBillField.text = @"";
            //      self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            //        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
             past_bill.billTypeStr = NSLocalizedString(@"door_delivery_bill", nil);
            
            [self.navigationController pushViewController:past_bill animated:YES];
        }
        else if (tableView == salesIdTable) {
            
            
            @try {
                
                [catPopOver dismissPopoverAnimated:YES];
                
                past_bill = [[PastBilling alloc]initWithBillType:filteredSkuArrayList[indexPath.row]];
                
                
                billTypeStatus = TRUE;
                typeBilling = @"past";
                past_bill.billingType = @"past";
                past_bill.isBillSummery=false;
                
                [self.navigationController pushViewController:past_bill animated:YES];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
          
        }
        else if (tableView == pagenationTbl) {
            
            @try {
                
                billNo = 0;
                pagenationTxt.text = pagenationArr[indexPath.row];
                int pageValue = (pagenationTxt.text).intValue;
                billNo = billNo + (pageValue * 13) - 13;
                
            } @catch (NSException * exception) {
                
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    //    [salesIdTable setHidden:YES];
    //
    //    PastBilling *past_bill;
    //
    //    if (tableView == salesIdTable) {
    //
    //        past_bill = [[PastBilling alloc]initWithBillType:[filteredSkuArrayList objectAtIndex:indexPath.row]];
    //
    //    }
    //    else {
    //
    //        past_bill = [[PastBilling alloc]initWithBillType:[orderId objectAtIndex:indexPath.row]];
    //
    //    }
    //
    //    billTypeStatus = TRUE;
    //    typeBilling = @"past";
    //    past_bill.billingType = @"past";
    //    pastBillField.text = @"";
    //
    //    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    //    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
    //
    //    [self.navigationController pushViewController:past_bill animated:YES];
    
}

#pragma -mark end of UITableViewDelegateMethods


//-(void)loadFirstPage:(id)sender {
//
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    [orderId removeAllObjects];
//    [billDue removeAllObjects];
//    [order_date removeAllObjects];
//
//
//    billNo = 0;
//    //    cellcount = 10;
//
//    //[HUD setHidden:NO];
//    [HUD show:YES];
//    [self getDoorDeliveryBills];
//
//}
//
//-(void)loadLastPage:(id)sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    [orderId removeAllObjects];
//    [billDue removeAllObjects];
//    [order_date removeAllObjects];
//
//    //float a = [rec_total.text intValue]/5;
//    //float t = ([rec_total.text floatValue]/5);
//
//    // NSLog(@"%@",totalOrder.text);
//
//    // NSLog(@"%f",([totalOrder.text floatValue]/10));
//    //
//    if ([totalOrder.text intValue]/10 == ([totalOrder.text floatValue]/10)) {
//
//        billNo = (([totalOrder.text intValue]/10)*10)-10;
//    }
//    else{
//        billNo = ([totalOrder.text intValue]/10) * 10;
//    }
//
//
//    //changeID = ([rec_total.text intValue]/5) - 1;
//
//    //previousButton.backgroundColor = [UIColor grayColor];
//    previousOrders.enabled = YES;
//
//
//    //frstButton.backgroundColor = [UIColor grayColor];
//    firstOrders.enabled = YES;
//
//    [HUD setHidden:NO];
//    [HUD show:YES];
//    [self getDoorDeliveryBills];
//
//}
//-(void)loadPreviousPage:(id)sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//
//    [orderId removeAllObjects];
//    [billDue removeAllObjects];
//    [order_date removeAllObjects];
//
//    if (billNo > 0){
//        billNo = billNo-10;
//
//        [self getDoorDeliveryBills];
//
//        if ([orderEnd.text isEqualToString:totalOrder.text]) {
//
//            lastOrders.enabled = NO;
//        }
//        else {
//            lastOrders.enabled = YES;
//        }
//        nextOrders.enabled =  YES;
//
//        [HUD setHidden:NO];
//        [HUD setHidden:YES];
//
//    }
//    else{
//        //previousButton.backgroundColor = [UIColor lightGrayColor];
//        previousOrders.enabled =  NO;
//
//        //nextButton.backgroundColor = [UIColor grayColor];
//        nextOrders.enabled =  YES;
//    }
//
//}
//
//-(void)loadNextPage:(id)sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//    //previousButton.backgroundColor = [UIColor grayColor];
//    previousOrders.enabled =  YES;
//
//    billNo = billNo+10;
//
//    [orderId removeAllObjects];
//    [billDue removeAllObjects];
//    [order_date removeAllObjects];
//
//    [HUD setHidden:NO];
//
//    // nextOrders.enabled =  NO;
//    //nextButton.backgroundColor = [UIColor lightGrayColor];
//
//    // Getting the required from webServices ..
//    // Create the service
//
//    firstOrders.enabled = YES;
//
//    [self getDoorDeliveryBills];
//
//}

#pragma - mark action used for search in this page....

/**
 * @description  ..
 * @date
 * @method       goButtonPressed:
 * @author
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 08/06/2017....
 * @reason      added the comments and exception handling.... not completed....
 *
 */

-(void)submitButtonPressed:(UIButton *) sender {
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
  
        if (!isOfflineService) {
  
            submitBtn.tag = 4;
            //billNo = 0;
            
            [self callingSearchBills];
        }
        else{
         
            //billNo = 0;
            [self getDoorDeliveryBillsinOffline];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
}



#pragma mark getSearchBills:

/**
 * @description  here we are calling service in order to get the pending bills.......
 * @date
 * @method       callingSearchBills
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and hided the hud in catch block    .... not completed....
 *
 */

-(void)callingSearchBills {
    @try {
        
        
        [HUD setHidden:NO];
        
        
        NSLog(@"---getPastBills---%d",billNo);
        
        if( doorDeliveryBillsArr == nil && billNo == 0){
            
            totalNumberOfRecords = 0;
            
            doorDeliveryBillsArr = [NSMutableArray new];
        }
        else if(doorDeliveryBillsArr.count ){
            
            [doorDeliveryBillsArr removeAllObjects];
        }
        
        
        NSString *startDteStr = startDteField.text;
        
        if((startDteField.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@", startDteField.text,@" 00:00:00"];
        
        NSString * endDteStr  = endDteField.text;
        
        if ((endDteField.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDteField.text,@" 00:00:00"];
        }
        
        NSArray * headerKeys_ = @[REQUEST_HEADER,STORE_LOCATION,START_INDEX,kSearchCriteria,kReportDate,kReportEndDate,BILL_STATUS,kMaxRecords];
        
        NSArray * headerObjects_ = @[[RequestHeader getRequestHeader],presentLocation,[NSString stringWithFormat:@"%d",billNo],customerMoblFld.text,startDteStr,endDteStr,@"tobedelivered",@"13"];
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
        
        [HUD setHidden:YES];
    }
    @finally {
        
    }
}


#pragma -mark handling of the searchBillId response....

/**
 * @description  here we are handling the service call sucess response.......
 * @date
 * @method       searchBillsSuccesssResponse:
 * @author
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 */


-(void)searchBillsSuccesssResponse:(NSDictionary *)successDictionary {
    @try {
        
//        NSLog(@"---searchBillsSuccesssResponse---%i",[successDictionary count]);
        
        
        if  (![[successDictionary valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[successDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
            
            totalNumberOfRecords = [[successDictionary valueForKey:@"totalRecords"] intValue];
            
            for(NSDictionary *dic in [successDictionary valueForKey:@"billsList"]){
                
                [doorDeliveryBillsArr addObject:dic];
            }
            
        }
        
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
        [self pagenationHandler];

        
        [HUD setHidden:YES];
        [pendingBills reloadData];
    }
    
}

/**
 * @description  here we are handling the service call error response.......
 * @date
 * @method       searchBillsErrorResponse:
 * @author
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 */

-(void)searchBillsErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
//        NSLog(@"---searchBillsErrorResponse---%@",errorResponse);
        
        if(!doorDeliveryBillsArr.count){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorResponse message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }
    @catch (NSException *exception) {
    }
    @finally {
        [pendingBills reloadData];
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
 * @return
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && add clear button and its functionality....
 *
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
            
            pickView.frame = CGRectMake( 15, startDteField.frame.origin.y+startDteField.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:startDteField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDteField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and exception handling.... not completed....
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
            if ((endDteField.text).length != 0 && ( ![endDteField.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDteField.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    
                    
                    return;
                    
                }
            }
            
            startDteField.text = dateString;
            
        }
        else{
            
            if ((startDteField.text).length != 0 && ( ![startDteField.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDteField.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                }
            }
            
            
            
            endDteField.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
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
    //    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(  sender.tag == 2){
            if((startDteField.text).length)
                //                callServices = true;
                
                
                startDteField.text = @"";
        }
        else{
            if((endDteField.text).length)
                //                callServices = true;
                
                endDteField.text = @"";
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
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
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
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 08/06/2017....
 * @reason      added the comments and exception handling.... not completed....
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
 * @date         13/06/2017
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
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height >= height) ){
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
 * @return
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
 * @return
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



#pragma -mark method should need to be removed....

/**
 * @description  ..
 * @date
 * @method       deviceOrientationDidChange:
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and this method needs to be removed because it was not in use .... not completed....
 *
 */

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if ((UIDeviceOrientationIsPortrait(orientation) ||UIDeviceOrientationIsPortrait(orientation)) ||
        (UIDeviceOrientationIsLandscape(orientation) || UIDeviceOrientationIsLandscape(orientation))) {
        //still saving the current orientation
        currentOrientation = orientation;
    }
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            order_Id.font = [UIFont boldSystemFontOfSize:20];
            order_Id.frame = CGRectMake(60, 160, 180, 45);
            orderdOn .font = [UIFont boldSystemFontOfSize:20];
            orderdOn.frame = CGRectMake(365, 160, 180, 45);
            cost.font = [UIFont boldSystemFontOfSize:20];
            cost.frame = CGRectMake(620, 160, 180, 45);
            
            pastBillField.font = [UIFont boldSystemFontOfSize:25];
            pastBillField.frame = CGRectMake(300, 75, 360, 52);
            
            pendingBills.frame = CGRectMake(0, 210, self.view.frame.size.width, self.view.frame.size.height-290);
            
            firstOrders.frame = CGRectMake(162, 700, 50, 50);
            firstOrders.layer.cornerRadius = 25.0f;
            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            lastOrders.frame = CGRectMake(705, 700, 50, 50);
            lastOrders.layer.cornerRadius = 25.0f;
            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            previousOrders.frame = CGRectMake(290, 700, 50, 50);
            previousOrders.layer.cornerRadius = 22.0f;
            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            nextOrders.frame = CGRectMake(580, 700, 50, 50);
            nextOrders.layer.cornerRadius = 22.0f;
            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            orderStart.frame = CGRectMake(375, 700, 100, 50);
            label1.frame = CGRectMake(415, 700, 30, 50);
            orderEnd.frame = CGRectMake(440, 700, 100, 50);
            label2.frame = CGRectMake(480, 700, 30, 50);
            totalOrder.frame = CGRectMake(515, 700, 100, 50);
            
            orderStart.font = [UIFont systemFontOfSize:25.0];
            label1.font = [UIFont systemFontOfSize:25.0];
            orderEnd.font = [UIFont systemFontOfSize:25.0];
            label2.font = [UIFont systemFontOfSize:25.0];
            totalOrder.font = [UIFont systemFontOfSize:25.0];
            
        }
        else {
            order_Id.font = [UIFont boldSystemFontOfSize:20];
            order_Id.frame = CGRectMake(30, 160, 150, 45);
            orderdOn .font = [UIFont boldSystemFontOfSize:20];
            orderdOn.frame = CGRectMake(285, 160, 150, 45);
            cost.font = [UIFont boldSystemFontOfSize:20];
            cost.frame = CGRectMake(550, 160, 150, 45);
            
            pastBillField.font = [UIFont boldSystemFontOfSize:30];
            pastBillField.frame = CGRectMake(180, 75, 360, 52);

            
            pendingBills.frame = CGRectMake(0, 210, 778, 700);
            
            
            firstOrders.frame = CGRectMake(82, 940, 50, 50);
            firstOrders.layer.cornerRadius = 25.0f;
            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            lastOrders.frame = CGRectMake(625, 940, 50, 50);
            lastOrders.layer.cornerRadius = 25.0f;
            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            previousOrders.frame = CGRectMake(210, 940, 50, 50);
            previousOrders.layer.cornerRadius = 22.0f;
            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            nextOrders.frame = CGRectMake(500, 940, 50, 50);
            nextOrders.layer.cornerRadius = 22.0f;
            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            orderStart.frame = CGRectMake(295, 940, 100, 50);
            label1.frame = CGRectMake(335, 940, 30, 50);
            orderEnd.frame = CGRectMake(360, 940, 100, 50);
            label2.frame = CGRectMake(400, 940, 30, 50);
            totalOrder.frame = CGRectMake(435, 940, 100, 50);
            
            orderStart.font = [UIFont systemFontOfSize:25.0];
            label1.font = [UIFont systemFontOfSize:25.0];
            orderEnd.font = [UIFont systemFontOfSize:25.0];
            label2.font = [UIFont systemFontOfSize:25.0];
            totalOrder.font = [UIFont systemFontOfSize:25.0];
            
        }
        
        
        
    }
    
    [pendingBills reloadData];
    
}


/**
 * @description  here we are checking whether the object is null or not
 * @date         10/07/2017
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav
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
    
        
        int strTotalRecords = totalNumberOfRecords/13;
        int remainder = totalNumberOfRecords % 13;
    
        
        if(remainder == 0)
        {
            strTotalRecords = strTotalRecords;
        }
        else
        {
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
        
        if(billNo == 0) {
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
                
                [self getDoorDeliveryBills];
            else if(submitBtn.tag == 4)
                
                [self callingSearchBills];
        }
        else {
            
            [self getDoorDeliveryBillsinOffline];
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
        
        [HUD setHidden:YES];
        
        if(pagenationArr.count == 0){
            
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
        
        [self showPopUpForTables:pagenationTbl  popUpWidth:pagenationTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationTxt  showViewIn:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


@end
