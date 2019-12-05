//
//  ServiceOrders.m
//  OmniRetailer
//
//  Created by Sonali on 2/23/15.
//
//

#import "ServiceOrders.h"
#import "CellView_ServiceOrder.h"
// commented by roja
//#import "OrderDatails.h"
//#import "OrderService.h"
#import "Global.h"
#import "OmniHomePage.h"
#import "NewRestBooking.h"



@implementation ServiceOrders
@synthesize soundFileObject,soundFileURLRef,orderType;


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
////    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)viewDidLoad {
    
    [super viewDidLoad];
    pending_order_no = 0;
    past_order_no = 1;
    orderStartIndex = 0;
    version = [[[UIDevice currentDevice]systemVersion] floatValue];
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    currentOrientation = [[UIDevice currentDevice] orientation];
//    self.titleLabel.text = @"BOOKINGS";
    
    self.titleLabel.text = @"Table Booking";

    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    version =  [[[UIDevice currentDevice] systemVersion] floatValue];
    
    NSArray *segmentLabels = [NSArray arrayWithObjects:NSLocalizedString(@"Booking View", nil),NSLocalizedString(@"Table View", nil), nil];
    
    pastorder_date = [[NSMutableArray alloc] init];
    
    mainSegmentedControl = [[UISegmentedControl alloc] initWithItems:segmentLabels];
    mainSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    mainSegmentedControl.backgroundColor = [UIColor lightGrayColor];
    mainSegmentedControl.selectedSegmentIndex = 0;
    [mainSegmentedControl addTarget:self action:@selector(segmentAction1:) forControlEvents:UIControlEventValueChanged];
    
    // assigning a value to check the bill finished ..
    mainSegmentedControl.tag = 0;
    
    pendingOrdersView = [[UIView alloc] init];
    pendingOrdersView.frame = CGRectMake(0.0, 125.0, self.view.frame.size.width, self.view.frame.size.height);
    pendingOrdersView.backgroundColor = [UIColor clearColor];
    pendingOrdersView.hidden = NO;
    
    pastOrdersView = [[UIView alloc] init];
    pastOrdersView.frame = CGRectMake(0.0, 125.0, self.view.frame.size.width, self.view.frame.size.height);
    pastOrdersView.backgroundColor = [UIColor clearColor];
    pastOrdersView.hidden = YES;
    
    salesIdTable = [[UITableView alloc] init];
    salesIdTable.layer.borderWidth = 1.0;
    salesIdTable.layer.cornerRadius = 4.0;
    salesIdTable.layer.borderColor = [UIColor grayColor].CGColor;
    salesIdTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [salesIdTable setDataSource:self];
    [salesIdTable setDelegate:self];
    salesIdTable.hidden = YES;

    
    searchTxt = [[UITextField alloc] init];
    searchTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchTxt.textColor = [UIColor blackColor];
    searchTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    searchTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTxt.backgroundColor = [UIColor whiteColor];
    searchTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    // pastBillField.backgroundColor = [UIColor whiteColor];
    searchTxt.returnKeyType = UIReturnKeyDone;
    searchTxt.keyboardType = UIKeyboardTypeNumberPad;
    searchTxt.placeholder  = @"Mobile no";
    [searchTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    searchTxt.delegate = self;
    
    todayLbl = [[UILabel alloc] init];
    todayLbl.textColor = [UIColor whiteColor];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
    NSString* currentdate = [f stringFromDate:today];
    
    todayLbl.text = currentdate;
    
    slotTextField = [[UITextField alloc] init];
    slotTextField.borderStyle = UITextBorderStyleRoundedRect;
    slotTextField.textColor = [UIColor blackColor];
    slotTextField.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    slotTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    slotTextField.backgroundColor = [UIColor whiteColor];
    slotTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    // pastBillField.backgroundColor = [UIColor whiteColor];
    slotTextField.returnKeyType = UIReturnKeyDone;
    slotTextField.delegate = self;
    slotTextField.placeholder = @"Select slot";
    slotTextField.userInteractionEnabled = NO;
    
    selectSlotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    

    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [selectSlotBtn setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectSlotBtn addTarget:self
                        action:@selector(selectSlotBtnAction:) forControlEvents:UIControlEventTouchDown];
//    selectSlotBtn.tag =100;
    
    endDate = [[UITextField alloc] init];
    endDate.borderStyle = UITextBorderStyleRoundedRect;
    endDate.textColor = [UIColor blackColor];
    endDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    endDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    endDate.backgroundColor = [UIColor whiteColor];
    endDate.autocorrectionType = UITextAutocorrectionTypeNo;
    // pastBillField.backgroundColor = [UIColor whiteColor];
    endDate.returnKeyType = UIReturnKeyDone;
    endDate.delegate = self;
    
    selectEndDate = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    UIImage *buttonImageDD1 = [UIImage imageNamed:@"combo.png"];
    [selectEndDate setBackgroundImage:buttonImageDD1 forState:UIControlStateNormal];
    [selectEndDate addTarget:self
                      action:@selector(selectEndDate:) forControlEvents:UIControlEventTouchDown];
    selectEndDate.tag = 1;
    

    goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goButton addTarget:self action:@selector(gobuttonPressed:) forControlEvents:UIControlEventTouchDown];
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor grayColor];
//    goButton.tag =100;
    
    
    // added by roja on 18/02/2019...
    firstNameTF = [[UITextField alloc] init];
    firstNameTF.borderStyle = UITextBorderStyleRoundedRect;
    firstNameTF.textColor = [UIColor blackColor];
    firstNameTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    firstNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstNameTF.backgroundColor = [UIColor whiteColor];
    firstNameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    firstNameTF.returnKeyType = UIReturnKeyDone;
    firstNameTF.delegate = self;
    firstNameTF.placeholder = @"First Name";
    firstNameTF.userInteractionEnabled = YES;
    
    lastNameTF = [[UITextField alloc] init];
    lastNameTF.borderStyle = UITextBorderStyleRoundedRect;
    lastNameTF.textColor = [UIColor blackColor];
    lastNameTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    lastNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastNameTF.backgroundColor = [UIColor whiteColor];
    lastNameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    lastNameTF.returnKeyType = UIReturnKeyDone;
    lastNameTF.delegate = self;
    lastNameTF.placeholder = @"Last Name";
    lastNameTF.userInteractionEnabled = YES;
    
    startDateTF = [[UITextField alloc] init];
    startDateTF.borderStyle = UITextBorderStyleRoundedRect;
    startDateTF.textColor = [UIColor blackColor];
    startDateTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    startDateTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    startDateTF.backgroundColor = [UIColor whiteColor];
    startDateTF.autocorrectionType = UITextAutocorrectionTypeNo;
    startDateTF.returnKeyType = UIReturnKeyDone;
    startDateTF.delegate = self;
    startDateTF.placeholder = @"Start Date";
    startDateTF.userInteractionEnabled = NO;
    
    UIButton * startDateBtn;
    startDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDateBtn setBackgroundImage:[UIImage imageNamed:@"Calandar_Icon.png"] forState:UIControlStateNormal];
    [startDateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    startDateBtn.tag = 2;

    endDateTF = [[UITextField alloc] init];
    endDateTF.borderStyle = UITextBorderStyleRoundedRect;
    endDateTF.textColor = [UIColor blackColor];
    endDateTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    endDateTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    endDateTF.backgroundColor = [UIColor whiteColor];
    endDateTF.autocorrectionType = UITextAutocorrectionTypeNo;
    endDateTF.returnKeyType = UIReturnKeyDone;
    endDateTF.delegate = self;
    endDateTF.placeholder = @"End Date";
    endDateTF.userInteractionEnabled = NO;
    
    UIButton * endDateBtn;
    endDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDateBtn setBackgroundImage:[UIImage imageNamed:@"Calandar_Icon.png"] forState:UIControlStateNormal];
    [endDateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    statusTF = [[UITextField alloc] init];
    statusTF.borderStyle = UITextBorderStyleRoundedRect;
    statusTF.textColor = [UIColor blackColor];
    statusTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    statusTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    statusTF.backgroundColor = [UIColor whiteColor];
    statusTF.autocorrectionType = UITextAutocorrectionTypeNo;
    statusTF.returnKeyType = UIReturnKeyDone;
    statusTF.delegate = self;
    statusTF.placeholder = @"Status";
    statusTF.userInteractionEnabled = NO;
    
    statusPopUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [statusPopUpBtn setBackgroundImage:[UIImage imageNamed:@"down_gray_arrow.png"] forState:UIControlStateNormal];
    [statusPopUpBtn addTarget:self action:@selector(selectStatusBtnAction:)  forControlEvents:UIControlEventTouchUpInside];
    
    
    bookingChannelTF = [[UITextField alloc] init];
    bookingChannelTF.borderStyle = UITextBorderStyleRoundedRect;
    bookingChannelTF.textColor = [UIColor blackColor];
    bookingChannelTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    bookingChannelTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    bookingChannelTF.backgroundColor = [UIColor whiteColor];
    bookingChannelTF.autocorrectionType = UITextAutocorrectionTypeNo;
    bookingChannelTF.returnKeyType = UIReturnKeyDone;
    bookingChannelTF.delegate = self;
    bookingChannelTF.placeholder = @"Booking Channel";
    bookingChannelTF.userInteractionEnabled = YES;
    
    
    bookingChannelPopUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookingChannelPopUpBtn setBackgroundImage:[UIImage imageNamed:@"down_gray_arrow.png"] forState:UIControlStateNormal];
    [bookingChannelPopUpBtn addTarget:self action:@selector(selectBookingChannelBtnAction:)  forControlEvents:UIControlEventTouchUpInside];
    
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton addTarget:self action:@selector(searchBookingDetailsAction:) forControlEvents:UIControlEventTouchDown];
    searchButton.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    searchButton.layer.cornerRadius = 10.f;
    

    UIButton * clearButton;
    clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearButton.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    clearButton.layer.cornerRadius = 10.f;
    
    searchOrdersText = [[UITextField alloc] init];
    searchOrdersText.delegate = self;
    searchOrdersText.borderStyle = UITextBorderStyleRoundedRect;
    searchOrdersText.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchOrdersText.textAlignment = NSTextAlignmentCenter;
    searchOrdersText.autocorrectionType = UITextAutocorrectionTypeNo;
    searchOrdersText.textColor = [UIColor blackColor];
    searchOrdersText.layer.borderColor = [UIColor clearColor].CGColor;
    searchOrdersText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [searchOrdersText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    searchOrdersText.placeholder = @"Search Bookings";
    searchOrdersText.backgroundColor = [UIColor whiteColor];
    
    newTableOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newTableOrderBtn addTarget:self action:@selector(newOrder:) forControlEvents:UIControlEventTouchUpInside];
    newTableOrderBtn.layer.cornerRadius = 10.f;
    newTableOrderBtn.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [newTableOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newTableOrderBtn setTitle:@"New Booking" forState:UIControlStateNormal];
    newTableOrderBtn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
//    newTableOrderBtn.tag =100;
    
    
    UILabel * totalBookingTopBackGroundLbl = [[UILabel alloc] init];
    totalBookingTopBackGroundLbl.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * totalBookingsLbl = [[UILabel alloc] init];
    totalBookingsLbl.text = @"Total Bookings:";
    totalBookingsLbl.textAlignment = NSTextAlignmentLeft;
    totalBookingsLbl.backgroundColor = [UIColor blackColor];
    totalBookingsLbl.textColor = [UIColor lightGrayColor];
    totalBookingsLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22];
    
    totalBookingsValueTF = [[UITextField alloc] init];
    totalBookingsValueTF.borderStyle = UITextBorderStyleNone; //UITextBorderStyleRoundedRect
    totalBookingsValueTF.textColor = [UIColor lightGrayColor];
    totalBookingsValueTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22];
    totalBookingsValueTF.backgroundColor = [UIColor blackColor];
    totalBookingsValueTF.returnKeyType = UIReturnKeyDone;
    totalBookingsValueTF.userInteractionEnabled = NO;
    totalBookingsValueTF.delegate = self;
    
    //Allocation of CustomTextField.... for Displaying the Pagenation Data....
    pagenationText = [[CustomTextField alloc] init];
    pagenationText.userInteractionEnabled = NO;
    pagenationText.textAlignment = NSTextAlignmentCenter;
    pagenationText.delegate = self;
    //    [pagenationText awakeFromNib];
    // or
    pagenationText.backgroundColor = [UIColor clearColor];
    pagenationText.borderStyle = UITextBorderStyleNone;
    pagenationText.layer.borderWidth = 1.0f;
    pagenationText.layer.borderColor = [[UIColor whiteColor] CGColor];
    pagenationText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    pagenationText.layer.cornerRadius = 3.0f;
    pagenationText.layer.masksToBounds = YES;
    pagenationText.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
    
    UIButton * dropDownBtn;
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:[UIImage imageNamed:@"down_gray_arrow.png"] forState:UIControlStateNormal];
    [dropDownBtn addTarget:self action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    //    dropDownBtn.tag =100;

    //creating the UIButton which are used to show pagenationData popUp...
    UIButton * goBtnForPagenation;
    goBtnForPagenation = [UIButton buttonWithType:UIButtonTypeCustom];
    goBtnForPagenation.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    goBtnForPagenation.userInteractionEnabled = YES;
    [goBtnForPagenation addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
    goBtnForPagenation.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [goBtnForPagenation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goBtnForPagenation setTitle:@"GO" forState:UIControlStateNormal];
    goBtnForPagenation.layer.cornerRadius = 10;
    goBtnForPagenation.layer.masksToBounds = YES;

    // Status Drop down table..
    statusDropDownTbl = [[UITableView alloc] init];
    statusDropDownTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [statusDropDownTbl setDataSource:self];
    [statusDropDownTbl setDelegate:self];
    [statusDropDownTbl.layer setBorderWidth:1.0f];
    statusDropDownTbl.layer.cornerRadius = 3;
    statusDropDownTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    // Booking channel Drop down table..
    bookingChannelDropDownTbl = [[UITableView alloc] init];
    bookingChannelDropDownTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [bookingChannelDropDownTbl setDataSource:self];
    [bookingChannelDropDownTbl setDelegate:self];
    [bookingChannelDropDownTbl.layer setBorderWidth:1.0f];
    bookingChannelDropDownTbl.layer.cornerRadius = 3;
    bookingChannelDropDownTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    //Framings added by roja on 18/03/2019..
    searchTxt.frame = CGRectMake(10, 10, 200, 40);
    searchTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
    
    slotTextField.frame = CGRectMake(searchTxt.frame.origin.x, searchTxt.frame.origin.y + searchTxt.frame.size.height + 10, 160, searchTxt.frame.size.height);
    slotTextField.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
    selectSlotBtn.frame = CGRectMake(slotTextField.frame.origin.x + slotTextField.frame.size.width - 31, slotTextField.frame.origin.y-5, 40, slotTextField.frame.size.height+14);

    firstNameTF.frame = CGRectMake(searchTxt.frame.origin.x + searchTxt.frame.size.width + 30, searchTxt.frame.origin.y, 175, searchTxt.frame.size.height);
    
    lastNameTF.frame = CGRectMake(firstNameTF.frame.origin.x, slotTextField.frame.origin.y, firstNameTF.frame.size.width, searchTxt.frame.size.height);

    startDateTF.frame = CGRectMake(firstNameTF.frame.origin.x + firstNameTF.frame.size.width + 30, searchTxt.frame.origin.y, firstNameTF.frame.size.width, searchTxt.frame.size.height);
    startDateBtn.frame = CGRectMake(startDateTF.frame.origin.x + startDateTF.frame.size.width - 42, startDateTF.frame.origin.y + 2, 40, startDateTF.frame.size.height - 4);

    endDateTF.frame = CGRectMake(startDateTF.frame.origin.x, slotTextField.frame.origin.y, firstNameTF.frame.size.width, searchTxt.frame.size.height);
    endDateBtn.frame = CGRectMake(endDateTF.frame.origin.x + endDateTF.frame.size.width - 42, endDateTF.frame.origin.y + 2, 40, endDateTF.frame.size.height - 4);
    
    statusTF.frame = CGRectMake(startDateTF.frame.origin.x + startDateTF.frame.size.width + 30, searchTxt.frame.origin.y, firstNameTF.frame.size.width, searchTxt.frame.size.height);
    statusPopUpBtn.frame = CGRectMake(statusTF.frame.origin.x + statusTF.frame.size.width - 30, statusTF.frame.origin.y + 8, 23, 23);

    bookingChannelTF.frame = CGRectMake(statusTF.frame.origin.x, slotTextField.frame.origin.y, firstNameTF.frame.size.width, searchTxt.frame.size.height);
    bookingChannelPopUpBtn.frame = CGRectMake(bookingChannelTF.frame.origin.x + bookingChannelTF.frame.size.width - 30, bookingChannelTF.frame.origin.y + 8, 23, 23);

    searchButton.frame = CGRectMake(statusTF.frame.origin.x + statusTF.frame.size.width + 30, searchTxt.frame.origin.y, 160, searchTxt.frame.size.height);
    clearButton.frame = CGRectMake(searchButton.frame.origin.x, slotTextField.frame.origin.y, searchButton.frame.size.width, searchTxt.frame.size.height);
    
    searchOrdersText.frame = CGRectMake(searchTxt.frame.origin.x, lastNameTF.frame.origin.y + lastNameTF.frame.size.height + 25, bookingChannelTF.frame.origin.x + bookingChannelTF.frame.size.width - 10, 40);
 
    //Allocation UIButton to navigate to the new Order Creation screen....
    newTableOrderBtn.frame = CGRectMake(searchButton.frame.origin.x, searchOrdersText.frame.origin.y, 160, 40);
    
    // Pagenation related framings...
    pagenationText.frame = CGRectMake(10, self.view.frame.size.height - 180, 90, 40);
    
    dropDownBtn.frame = CGRectMake((pagenationText.frame.origin.x + pagenationText.frame.size.width - 30), pagenationText.frame.origin.y + 9, 23, 21);
    
    goBtnForPagenation.frame = CGRectMake(pagenationText.frame.origin.x+pagenationText.frame.size.width + 15,pagenationText.frame.origin.y, 80, 40);
    
    // No of table bookings related framings..
    totalBookingTopBackGroundLbl.frame = CGRectMake(self.view.frame.size.width - 260, self.view.frame.size.height - 180, 250, 1);
    
    totalBookingsLbl.frame = CGRectMake(totalBookingTopBackGroundLbl.frame.origin.x, totalBookingTopBackGroundLbl.frame.origin.y + totalBookingTopBackGroundLbl.frame.size.height + 5, 170, 40);

    totalBookingsValueTF.frame = CGRectMake(totalBookingsLbl.frame.origin.x + totalBookingsLbl.frame.size.width + 5, totalBookingsLbl.frame.origin.y, 80, 40);
    
  
    [pendingOrdersView addSubview:searchTxt];
    [pendingOrdersView addSubview:slotTextField];
    [pendingOrdersView addSubview:selectSlotBtn];
    [pendingOrdersView addSubview:firstNameTF];
    [pendingOrdersView addSubview:lastNameTF];
    [pendingOrdersView addSubview:startDateTF];
    [pendingOrdersView addSubview:startDateBtn];
    [pendingOrdersView addSubview:endDateTF];
    [pendingOrdersView addSubview:endDateBtn];
    [pendingOrdersView addSubview:statusTF];
    [pendingOrdersView addSubview:statusPopUpBtn];
    [pendingOrdersView addSubview:bookingChannelTF];
    [pendingOrdersView addSubview:bookingChannelPopUpBtn];
    [pendingOrdersView addSubview:searchOrdersText];
    [pendingOrdersView addSubview:searchButton];
    [pendingOrdersView addSubview:clearButton];
    [pendingOrdersView addSubview:newTableOrderBtn];
    [pendingOrdersView addSubview:totalBookingTopBackGroundLbl];
    [pendingOrdersView addSubview:totalBookingsLbl];
    [pendingOrdersView addSubview:totalBookingsValueTF];
    [pendingOrdersView addSubview:pagenationText];
    [pendingOrdersView addSubview:dropDownBtn];
    [pendingOrdersView addSubview:goBtnForPagenation];

    //Upto here added by roja on 18/03/2019...

    
    //    [pendingOrdersView addSubview:todayLbl];
    //    [pendingOrdersView addSubview:endDate];
    //    [pendingOrdersView addSubview:selectEndDate];
    //    [pendingOrdersView addSubview:goButton];
    
    
    // commented by roja ...
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
    
//            searchTxt.frame = CGRectMake(10, 10, 220, 40);
//            searchTxt.font = [UIFont systemFontOfSize:20.0];
//
//            todayLbl.frame = CGRectMake(300, 10, 250, 40);
//            todayLbl.font = [UIFont systemFontOfSize:20.0];
//
//            slotTextField.frame = CGRectMake(550, 10, 180, 40);
//            slotTextField.font = [UIFont systemFontOfSize:20.0];
//            selectSlotBtn.frame = CGRectMake(720,4, 40, 55);
    
//            endDate.frame = CGRectMake(490, 10, 220, 40);
//            endDate.font = [UIFont systemFontOfSize:25.0];
//            selectEndDate.frame = CGRectMake(690, 8, 50, 66);
//
//            goButton.frame = CGRectMake(770, 10, 50, 40);
//            goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
//            goButton.layer.cornerRadius = 15.0f;
    
//            salesIdTable.frame = CGRectMake(searchTxt.frame.origin.x, searchTxt.frame.origin.y+searchTxt.frame.size.height, 360, 280);
    
//        }
//        else {
//            searchTxt.frame = CGRectMake(0, 0, 768, 50);
//        }
        
//    }
//    else {
//
//        searchTxt.frame = CGRectMake(0, 0, 320, 50);
//    }
    //Upto here commented by roja ...


    pendingHeaderView = [[UIView alloc] init];
    
    UILabel *order_Id = [[UILabel alloc] init];
    order_Id.layer.cornerRadius = 14;
    [order_Id setTextAlignment:NSTextAlignmentCenter];
    order_Id.layer.masksToBounds = YES;
    order_Id.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18]; //[UIFont boldSystemFontOfSize:14.0]
    order_Id.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    order_Id.textColor = [UIColor whiteColor];
    order_Id.text = @"Booking Id";
    
    UILabel *customerPhnNoLbl = [[UILabel alloc] init] ;
    customerPhnNoLbl.layer.cornerRadius = 14;
    [customerPhnNoLbl setTextAlignment:NSTextAlignmentCenter];
    customerPhnNoLbl.layer.masksToBounds = YES;
    customerPhnNoLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:14.0]
    customerPhnNoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    customerPhnNoLbl.textColor = [UIColor whiteColor];
    customerPhnNoLbl.text = @"Phone No";
    
    UILabel *customerNameLbl = [[UILabel alloc] init];
    customerNameLbl.layer.cornerRadius = 12;
    [customerNameLbl setTextAlignment:NSTextAlignmentCenter];
    customerNameLbl.layer.masksToBounds = YES;
    customerNameLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:14.0]
    customerNameLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    customerNameLbl.textColor = [UIColor whiteColor];
    customerNameLbl.text = @"Name";
    
    UILabel *orderdOn = [[UILabel alloc] init];
    orderdOn.layer.cornerRadius = 12;
    [orderdOn setTextAlignment:NSTextAlignmentCenter];
    orderdOn.layer.masksToBounds = YES;
    orderdOn.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:14.0]
    orderdOn.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    orderdOn.textColor = [UIColor whiteColor];
    orderdOn.text = @"Updated On";
    
    UILabel *occasionLbl = [[UILabel alloc] init];
    occasionLbl.layer.cornerRadius = 14;
    [occasionLbl setTextAlignment:NSTextAlignmentCenter];
    occasionLbl.layer.masksToBounds = YES;
    occasionLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:14.0]
    occasionLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    occasionLbl.textColor = [UIColor whiteColor];
    occasionLbl.text = @"Occasion";
    
    UILabel *slotId = [[UILabel alloc] init];
    slotId.layer.cornerRadius = 14;
    [slotId setTextAlignment:NSTextAlignmentCenter];
    slotId.layer.masksToBounds = YES;
    slotId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:14.0]
    slotId.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    slotId.textColor = [UIColor whiteColor];
    slotId.text = @"Slot";
    
    UILabel *tableNoLbl = [[UILabel alloc] init];
    tableNoLbl.layer.cornerRadius = 14;
    [tableNoLbl setTextAlignment:NSTextAlignmentCenter];
    tableNoLbl.layer.masksToBounds = YES;
    tableNoLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:14.0]
    tableNoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    tableNoLbl.textColor = [UIColor whiteColor];
    tableNoLbl.text = @"Table No";
    
    
    // added by roja on 23/02/2019..
    UILabel * statusLbl = [[UILabel alloc] init];
    statusLbl.layer.cornerRadius = 14;
    [statusLbl setTextAlignment:NSTextAlignmentCenter];
    statusLbl.layer.masksToBounds = YES;
    statusLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:20]
    statusLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    statusLbl.textColor = [UIColor whiteColor];
    statusLbl.text = @"Status";
    
    UILabel * orderChannelLbl = [[UILabel alloc] init];
    orderChannelLbl.layer.cornerRadius = 12;
    [orderChannelLbl setTextAlignment:NSTextAlignmentCenter];
    orderChannelLbl.layer.masksToBounds = YES;
    orderChannelLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:14.0]
    orderChannelLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    orderChannelLbl.textColor = [UIColor whiteColor];
    orderChannelLbl.text = @"Order Channel";
    
    UILabel * actionLbl = [[UILabel alloc] init];
    actionLbl.layer.cornerRadius = 14;
    [actionLbl setTextAlignment:NSTextAlignmentCenter];
    actionLbl.layer.masksToBounds = YES;
    actionLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];//[UIFont boldSystemFontOfSize:20]
    actionLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    actionLbl.textColor = [UIColor whiteColor];
    actionLbl.text = @"Action";
    // upto here added by roja..

    // added by roja on  23/02/2019..
    order_Id.frame = CGRectMake(10, 300 , 155, 30); // y-190   280
    customerPhnNoLbl.frame = CGRectMake(order_Id.frame.origin.x + order_Id.frame.size.width + 1.5, order_Id.frame.origin.y, 130, order_Id.frame.size.height);
    customerNameLbl.frame = CGRectMake(customerPhnNoLbl.frame.origin.x + customerPhnNoLbl.frame.size.width + 1.5, order_Id.frame.origin.y, 110, order_Id.frame.size.height);
    orderChannelLbl.frame = CGRectMake(customerNameLbl.frame.origin.x + customerNameLbl.frame.size.width + 1.5, order_Id.frame.origin.y, 140, order_Id.frame.size.height);
    occasionLbl.frame = CGRectMake(orderChannelLbl.frame.origin.x + orderChannelLbl.frame.size.width + 1.5, order_Id.frame.origin.y, 140, order_Id.frame.size.height);
    slotId.frame = CGRectMake(occasionLbl.frame.origin.x + occasionLbl.frame.size.width + 1.5, order_Id.frame.origin.y, 75, order_Id.frame.size.height);
    tableNoLbl.frame = CGRectMake((slotId.frame.origin.x+slotId.frame.size.width)+ 1.5, order_Id.frame.origin.y, 90, order_Id.frame.size.height);
    statusLbl.frame = CGRectMake(tableNoLbl.frame.origin.x + tableNoLbl.frame.size.width + 1.5, order_Id.frame.origin.y, 80, order_Id.frame.size.height);
    actionLbl.frame = CGRectMake(statusLbl.frame.origin.x + statusLbl.frame.size.width + 1.5, order_Id.frame.origin.y, 75, order_Id.frame.size.height);
    
    
    //    [pendingHeaderView addSubview:searchBar1];
    [pendingHeaderView addSubview:order_Id];
//    [pendingHeaderView addSubview:orderdOn];
    [pendingHeaderView addSubview:customerPhnNoLbl];
    [pendingHeaderView addSubview:customerNameLbl];
    [pendingHeaderView addSubview:orderChannelLbl];
    [pendingHeaderView addSubview:occasionLbl];
    [pendingHeaderView addSubview:slotId];
    [pendingHeaderView addSubview:tableNoLbl];
    [pendingHeaderView addSubview:statusLbl];
    [pendingHeaderView addSubview:actionLbl];
    [self.view addSubview:pendingHeaderView];
    
    pendingOrdersTbl.tableHeaderView = pendingHeaderView;
    
    /** Table Creation*/
    pendingOrdersTbl = [[UITableView alloc] init];
    [pendingOrdersTbl setSeparatorColor:[[UIColor grayColor] colorWithAlphaComponent:0.4]];
    [pendingOrdersTbl setDataSource:self];
    [pendingOrdersTbl setDelegate:self];
    pendingOrdersTbl.backgroundColor = [UIColor clearColor];
    pendingOrdersTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    pastOrders = [[UITableView alloc] init];
    [pastOrders setSeparatorColor:[[UIColor grayColor] colorWithAlphaComponent:0.4]];
    [pastOrders setDataSource:self];
    [pastOrders setDelegate:self];
    pastOrders.backgroundColor = [UIColor clearColor];
    pastOrders.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //  pastOrders.hidden = YES;
    
    
    firstOrders = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstOrders addTarget:self action:@selector(loadFirstPage:) forControlEvents:UIControlEventTouchDown];
    [firstOrders setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    firstOrders.layer.cornerRadius = 3.0f;
    firstOrders.enabled = NO;
    
    lastOrders = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastOrders addTarget:self action:@selector(loadLastPage:) forControlEvents:UIControlEventTouchDown];
    [lastOrders setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    lastOrders.layer.cornerRadius = 3.0f;
    lastOrders.enabled = NO;
    
    /** Create PreviousButton */
    previousOrders = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousOrders addTarget:self
                       action:@selector(loadPreviousPage:) forControlEvents:UIControlEventTouchDown];
    [previousOrders setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    
    previousOrders.enabled =  NO;
    
    
    /** Create NextButton */
    nextOrders = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextOrders addTarget:self
                   action:@selector(loadNextPage:) forControlEvents:UIControlEventTouchDown];
    [nextOrders setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    nextOrders.enabled =  NO;
    
    // take away order buttons...
    
    firstOrders_takeaway = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstOrders_takeaway addTarget:self action:@selector(loadFirstPage:) forControlEvents:UIControlEventTouchDown];
    [firstOrders_takeaway setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    firstOrders_takeaway.layer.cornerRadius = 3.0f;
    firstOrders_takeaway.enabled = NO;
    //  firstOrders_takeaway.hidden = YES;
    
    lastOrders_takeaway = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastOrders_takeaway addTarget:self action:@selector(loadLastPage:) forControlEvents:UIControlEventTouchDown];
    [lastOrders_takeaway setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    lastOrders_takeaway.layer.cornerRadius = 3.0f;
    //  lastOrders_takeaway.hidden = YES;
    
    
    /** Create PreviousButton */
    previousOrders_takeaway = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousOrders_takeaway addTarget:self
                                action:@selector(loadPreviousPage:) forControlEvents:UIControlEventTouchDown];
    [previousOrders_takeaway setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    
    previousOrders_takeaway.enabled =  NO;
    //  previousOrders_takeaway.hidden = YES;
    
    
    /** Create NextButton */
    nextOrders_takeaway = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextOrders_takeaway addTarget:self
                            action:@selector(loadNextPage:) forControlEvents:UIControlEventTouchDown];
    [nextOrders_takeaway setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    // nextOrders_takeaway.hidden = YES;
    
    
    //bottom label1...
    orderStart = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    orderStart.text = @"";
    orderStart.textAlignment = NSTextAlignmentLeft;
    orderStart.backgroundColor = [UIColor clearColor];
    orderStart.textColor = [UIColor whiteColor];
    
    //bottom label_2...
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label1.text = @"-";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor whiteColor];
    
    //bottom label2...
    orderEnd = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    orderEnd.text = @"";
    orderEnd.textAlignment = NSTextAlignmentLeft;
    orderEnd.backgroundColor = [UIColor clearColor];
    orderEnd.textColor = [UIColor whiteColor];
    
    //bottom label_3...
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label2.text = @"of";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor whiteColor];
    
    //bottom label3...
    totalOrder = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    totalOrder.textAlignment = NSTextAlignmentLeft;
    totalOrder.backgroundColor = [UIColor clearColor];
    totalOrder.textColor = [UIColor whiteColor];
    
    orderStart_takeaway = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    orderStart_takeaway.text = @"";
    orderStart_takeaway.textAlignment = NSTextAlignmentLeft;
    orderStart_takeaway.backgroundColor = [UIColor clearColor];
    orderStart_takeaway.textColor = [UIColor whiteColor];
    
    //bottom label_2...
    label11 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label11.text = @"Level";
    label11.textAlignment = NSTextAlignmentLeft;
    label11.backgroundColor = [UIColor clearColor];
    label11.textColor = [UIColor whiteColor];
    
    //bottom label2...
    orderEnd_takeaway = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    orderEnd_takeaway.text = @"";
    orderEnd_takeaway.textAlignment = NSTextAlignmentLeft;
    orderEnd_takeaway.backgroundColor = [UIColor clearColor];
    orderEnd_takeaway.textColor = [UIColor whiteColor];
    
    //bottom label_3...
    label22 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label22.text = @"of";
    label22.textAlignment = NSTextAlignmentLeft;
    label22.backgroundColor = [UIColor clearColor];
    label22.textColor = [UIColor whiteColor];
    
    //bottom label3...
    totalOrder_takeaway = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    totalOrder_takeaway.textAlignment = NSTextAlignmentLeft;
    totalOrder_takeaway.backgroundColor = [UIColor clearColor];
    totalOrder_takeaway.textColor = [UIColor whiteColor];
    
    
        mainSegmentedControl.tintColor=[UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont boldSystemFontOfSize:22], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                    nil];
        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
    
    
        firstOrders_takeaway.layer.cornerRadius = 25.0f;
        firstOrders_takeaway.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        
        lastOrders_takeaway.layer.cornerRadius = 25.0f;
        lastOrders_takeaway.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        
        previousOrders_takeaway.layer.cornerRadius = 22.0f;
        previousOrders_takeaway.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        
        nextOrders_takeaway.layer.cornerRadius = 22.0f;
        nextOrders_takeaway.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
    
        orderStart_takeaway.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        label11.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        orderEnd_takeaway.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        label22.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        totalOrder_takeaway.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
    
    
    // Start Of framings....
    mainSegmentedControl.frame = CGRectMake(-2, 65, self.view.frame.size.width, 60);
    pendingOrdersTbl.frame = CGRectMake(0, 210, self.view.frame.size.width, self.view.frame.size.height-410);//198
    pastOrders.frame = CGRectMake(0, 110,  self.view.frame.size.width-50, self.view.frame.size.height-300);
    // frame changes made by roja on 05/03/2019 ....
    firstOrders_takeaway.frame = CGRectMake(10, self.view.frame.size.height-200, 50, 50);// 82 --- X-Axis
    previousOrders_takeaway.frame = CGRectMake(110, self.view.frame.size.height-200, 50, 50);//210
    label11.frame = CGRectMake(180, self.view.frame.size.height-200, 120, 50);// 285
    
    orderStart_takeaway.frame = CGRectMake(260, self.view.frame.size.height-200, 80, 50);//365
    orderEnd_takeaway.frame = CGRectMake(260, self.view.frame.size.height-200, 80, 50);//365
    
    label22.frame = CGRectMake(320, self.view.frame.size.height-200, 30, 50);//420
    totalOrder_takeaway.frame = CGRectMake(360, self.view.frame.size.height-200, 80, 50);//455
    
    nextOrders_takeaway.frame = CGRectMake(410, self.view.frame.size.height-200, 50, 50);//512
    lastOrders_takeaway.frame = CGRectMake(510, self.view.frame.size.height-200, 50, 50);//645
    
    
    
    // added by roja on 05/03/2019,....
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 0); //(10,10,9,10)
//    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumInteritemSpacing = 0;//10
    layout.minimumLineSpacing = 20.0;
    
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,60, pastOrdersView.frame.size.width, pastOrdersView.frame.size.height-380) collectionViewLayout:layout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Collection_cell"];
    collectionView.backgroundColor = [UIColor blackColor];
    
    
    UIView * tableDetailsView;
    tableDetailsView = [[UIView alloc]init];
    tableDetailsView.backgroundColor = [UIColor lightGrayColor];
    
    levelsDisplayView = [[UIView alloc]init];
    levelsDisplayView.backgroundColor = [UIColor blackColor];
    
    UIView * levelsBackgroundView;
    levelsBackgroundView = [[UIView alloc]init];
    levelsBackgroundView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * totalSeatsLbl = [[UILabel alloc] init];
    totalSeatsLbl.text = @"Total Seats:";
    totalSeatsLbl.textAlignment = NSTextAlignmentLeft;
    totalSeatsLbl.backgroundColor = [UIColor blackColor];
    totalSeatsLbl.textColor = [UIColor whiteColor];
    totalSeatsLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    
    UILabel * bookedSeatsLbl = [[UILabel alloc] init];
    bookedSeatsLbl.text = @"Booked:";
    bookedSeatsLbl.textAlignment = NSTextAlignmentLeft;
    bookedSeatsLbl.backgroundColor = [UIColor blackColor];
    bookedSeatsLbl.textColor = [UIColor whiteColor];
    bookedSeatsLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    
    UILabel * occupiedSeatsLbl = [[UILabel alloc] init];
    occupiedSeatsLbl.text = @"Occupied:";
    occupiedSeatsLbl.textAlignment = NSTextAlignmentLeft;
    occupiedSeatsLbl.backgroundColor = [UIColor blackColor];
    occupiedSeatsLbl.textColor = [UIColor whiteColor];
    occupiedSeatsLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];

    
    totalSeatsValueTF = [[UITextField alloc] init];
    totalSeatsValueTF.borderStyle = UITextBorderStyleNone;//UITextBorderStyleRoundedRect
    totalSeatsValueTF.textColor = [UIColor whiteColor];
    totalSeatsValueTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    totalSeatsValueTF.backgroundColor = [UIColor blackColor];
    totalSeatsValueTF.returnKeyType = UIReturnKeyDone;
    totalSeatsValueTF.userInteractionEnabled = NO;
    totalSeatsValueTF.delegate = self;
    
    bookedSeatsValueTF = [[UITextField alloc] init];
    bookedSeatsValueTF.borderStyle = UITextBorderStyleNone;
    bookedSeatsValueTF.textColor = [UIColor whiteColor];
    bookedSeatsValueTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    bookedSeatsValueTF.backgroundColor = [UIColor blackColor];
    bookedSeatsValueTF.returnKeyType = UIReturnKeyDone;
    bookedSeatsValueTF.userInteractionEnabled = NO;
    bookedSeatsValueTF.delegate = self;
    
    occupiedSeatsValueTF = [[UITextField alloc] init];
    occupiedSeatsValueTF.borderStyle = UITextBorderStyleNone;
    occupiedSeatsValueTF.textColor = [UIColor whiteColor];
    occupiedSeatsValueTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    occupiedSeatsValueTF.backgroundColor = [UIColor blackColor];
    occupiedSeatsValueTF.returnKeyType = UIReturnKeyDone;
    occupiedSeatsValueTF.userInteractionEnabled = NO;
    occupiedSeatsValueTF.delegate = self;
    
  
    
    float levelsViewWidth = 150;//150
    // Framings ....
    levelsDisplayView.frame = CGRectMake((pastOrdersView.frame.size.width - levelsViewWidth), 20, levelsViewWidth, 530);
    levelsBackgroundView.frame = CGRectMake((levelsDisplayView.frame.origin.x - 1), levelsDisplayView.frame.origin.y, 1, levelsDisplayView.frame.size.height);
    tableDetailsView.frame = CGRectMake((pastOrdersView.frame.size.width - (2*levelsViewWidth)), levelsDisplayView.frame.origin.y + levelsDisplayView.frame.size.height, 2*levelsViewWidth, 92);//
    collectionView.frame = CGRectMake(0, 20, levelsBackgroundView.frame.origin.x-2, levelsBackgroundView.frame.size.height);
    
    totalSeatsLbl.frame = CGRectMake(0, 0.5, levelsViewWidth - 1, 30);
    bookedSeatsLbl.frame = CGRectMake(totalSeatsLbl.frame.origin.x, totalSeatsLbl.frame.origin.y + totalSeatsLbl.frame.size.height + 0.5, totalSeatsLbl.frame.size.width, totalSeatsLbl.frame.size.height);
    occupiedSeatsLbl.frame = CGRectMake(totalSeatsLbl.frame.origin.x, bookedSeatsLbl.frame.origin.y + bookedSeatsLbl.frame.size.height + 0.5, totalSeatsLbl.frame.size.width, totalSeatsLbl.frame.size.height - 0.5);
    
    totalSeatsValueTF.frame = CGRectMake(totalSeatsLbl.frame.origin.x + totalSeatsLbl.frame.size.width + 1.2, totalSeatsLbl.frame.origin.y, levelsViewWidth, totalSeatsLbl.frame.size.height);
    bookedSeatsValueTF.frame = CGRectMake(bookedSeatsLbl.frame.origin.x + bookedSeatsLbl.frame.size.width + 1.2, bookedSeatsLbl.frame.origin.y, totalSeatsValueTF.frame.size.width, bookedSeatsLbl.frame.size.height);
    occupiedSeatsValueTF.frame = CGRectMake(occupiedSeatsLbl.frame.origin.x + occupiedSeatsLbl.frame.size.width + 1.2, occupiedSeatsLbl.frame.origin.y, levelsViewWidth, occupiedSeatsLbl.frame.size.height);
    

    [tableDetailsView addSubview:totalSeatsLbl];
    [tableDetailsView addSubview:bookedSeatsLbl];
    [tableDetailsView addSubview:occupiedSeatsLbl];
    [tableDetailsView addSubview:totalSeatsValueTF];
    [tableDetailsView addSubview:bookedSeatsValueTF];
    [tableDetailsView addSubview:occupiedSeatsValueTF];

    [pastOrdersView addSubview:collectionView];
    [pastOrdersView addSubview:tableDetailsView];
    [pastOrdersView addSubview:levelsDisplayView];
    [pastOrdersView addSubview:levelsBackgroundView];
    // upto here added by roja on 05/03/2019,....
    
    [pendingOrdersView addSubview:pendingOrdersTbl];
//    [pendingOrdersView addSubview:firstOrders];
//    [pendingOrdersView addSubview:lastOrders];
//    [pendingOrdersView addSubview:previousOrders];
//    [pendingOrdersView addSubview:nextOrders];
//    [pendingOrdersView addSubview:orderStart];
//    [pendingOrdersView addSubview:label1];
//    [pendingOrdersView addSubview:orderEnd];
//    [pendingOrdersView addSubview:label2];
//    [pendingOrdersView addSubview:totalOrder];
    [pastOrdersView addSubview:pastOrders];
    [pastOrdersView addSubview:firstOrders_takeaway];
    [pastOrdersView addSubview:lastOrders_takeaway];
    [pastOrdersView addSubview:nextOrders_takeaway];
    [pastOrdersView addSubview:previousOrders_takeaway];
    [pastOrdersView addSubview:totalOrder_takeaway];
    [pastOrdersView addSubview:orderStart_takeaway];
    [pastOrdersView addSubview:orderEnd_takeaway];
    [pastOrdersView addSubview:label11];
    [pastOrdersView addSubview:label22];
    
   
    [self.view addSubview:mainSegmentedControl];
    [self.view addSubview:pendingOrdersView];
    [self.view addSubview:pastOrdersView];
    [self.view addSubview:salesIdTable];
   
    // initalize the arrays ..
    orderId = [[NSMutableArray alloc] init];
    tableId = [[NSMutableArray alloc] init];
    waiterList = [[NSMutableArray alloc] init];
    totalCost = [[NSMutableArray alloc]init];
    order_date = [[NSMutableArray alloc]init];
    
    orderId_pastOrders = [[NSMutableArray alloc] init];
    tableId_pastOrders = [[NSMutableArray alloc] init];
    waiterList_pastOrders = [[NSMutableArray alloc] init];
    totalCost_pastOrders = [[NSMutableArray alloc]init];
    
    //adding status array...
    statusArr = [[NSMutableArray alloc] init];
    
// NSString *strColor =  [WebServiceUtility NSStringFromUIColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1.0]];
    
    tableStatusArr = [[NSMutableArray alloc] initWithObjects:@"Booked",@"Available", nil];
    slotIdsArr = [[NSMutableArray alloc] initWithObjects:@"All",@"Lunch",@"Dinner", nil];
    bookingChannelPopUpArr = [[NSMutableArray alloc] initWithObjects:@"All",@"WalkIn",@"Telephone", nil];
    
    slotIdStr = @"";
    statusStr = @"";
    bookingChannelStr = @"";

    pagenationTable = [[UITableView alloc]init];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    //ProgressBar creation...
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD setLabelText:@"Please wait..."];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    

    
    isRefresh = FALSE;
    pending_order_no = 0;
    
    buttonTitleIndex = 0;
    messageStartIndex = 0;
    buttonIndex = 0;
    pageIndex = 0;
    
    orderStartIndex = 0;
    @try {
      dateTimer =   [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];

    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
//    [self getPendingOrders];
//    [self generateAcessToken];
    [self callingWorkFlowStatusDetails];
    [self getAllBookings];
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    UIView *buttonsView = [[UIView alloc] init];
    buttonsView.backgroundColor = [UIColor clearColor];
    
    popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(refreshBookings:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton  *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        buttonsView.frame = CGRectMake(0.0, 0.0, 260.0, 40.0);
        popButton.frame = CGRectMake(140.0, -3, 45, 45);
        backButton.frame = CGRectMake(200.0,3, 60, 30);
        
    }
    else{
        if (version>=8.0) {
            
            buttonsView.frame = CGRectMake(0.0, 0.0, 120.0, 40.0);
            popButton.frame = CGRectMake(90, 5, 25, 25);
           
            // button3.frame = CGRectMake(0, 3, 25, 25);
        }
        else {
            buttonsView.frame = CGRectMake(0.0, 0.0, 120.0, 40.0);
            popButton.frame = CGRectMake(80.0, 0, 25, 25);
        }
        
    }
    
    [buttonsView addSubview:popButton];
   
    [buttonsView addSubview:backButton];
    
    UIBarButtonItem *button =[[UIBarButtonItem alloc]init];
    button.customView = buttonsView;
    button.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = button;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [dateTimer invalidate];
    dateTimer = nil;
}


-(void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchTxt ) {
        
        if ([searchTxt.text length]==10) {
            
            // added by roja on 13/02/2019...
            @try {
                // added by roja
                buttonTitleIndex = 0;
                [self getAllBookings];

            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            

            // commented by roja on 13/02/2019...
            // reason we have a existing service call (getAllBokkings) no need to write service call again here...

//            @try {
            
//                NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
//                [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
//                [orderDetails setObject:presentLocation forKey:@"storeLocation"];
//                [orderDetails setObject:[NSString stringWithFormat:@"%d",pending_order_no] forKey:@"startIndex"];
//                [orderDetails setObject:searchTxt.text forKey:@"phoneNumber"];
//                [orderDetails setObject:slotTextField.text forKey:@"slot"];
//
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//                [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
//                NSDate *startDate1 = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
//
//                NSString *dateStr = [formatter stringFromDate:startDate1];
//                NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",[[dateStr componentsSeparatedByString:@" "] objectAtIndex:0],@" ",@"00:00:00"];
//                [orderDetails setObject:timeStr forKey:@"dateStr"];
//                //            [orderDetails setObject:timeStr forKey:@"endDateStr"];
//
//                [orderDetails setObject:[WebServiceUtility getPropertyFromProperties:@"maxResult"] forKey:@"maxRecords"]; //  added by roja
//
//                NSError * err;
//                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
//                NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//                WebServiceController *controller = [[WebServiceController alloc] init];
//                [controller setRestaurantBookingServiceDelegate:self];
//                [controller getListOfBookings:getBookingJsonStr];
                
//
//            }
//            @catch (NSException *exception) {
//
//                NSLog(@"%@",exception);
//            }
            
            // upto here commented by roja on 13/02/2019...

        }
        else if ([searchTxt.text length]>=3){
            
            // added by roja on 13/02/2019...
            @try {
                
                [self getPhoneNumberDetails];
                
            } @catch (NSException *exception) {
                
                NSLog(@"%@",exception);
            } @finally {
                
            }
                // commented by roja on 13/02/2019...
//            @try {
//
//                NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
//                [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
//                [orderDetails setObject:presentLocation forKey:@"storeLocation"];
//                [orderDetails setObject:[NSString stringWithFormat:@"%d",pending_order_no] forKey:@"startIndex"];
//                [orderDetails setObject:searchTxt.text forKey:@"phoneNumber"];
//                [orderDetails setObject:slotTextField.text forKey:@"slot"];
//
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//                [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
//                NSDate *startDate1 = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
//
//                NSString *dateStr = [formatter stringFromDate:startDate1];
//                NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",[[dateStr componentsSeparatedByString:@" "] objectAtIndex:0],@" ",@"00:00:00"];
//                [orderDetails setObject:timeStr forKey:@"dateStr"];
//                //            [orderDetails setObject:timeStr forKey:@"endDateStr"];
//
//                NSError * err;
//                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
//                NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//                if (!isOfflineService) {
//                    [HUD setHidden:NO];
//                    WebServiceController *controller = [[WebServiceController alloc] init];
//                    [controller setRestaurantBookingServiceDelegate:self];
//                    [controller getPhoneNos:getBookingJsonStr];
//                }
//                else {
//                }
//            }
//            @catch (NSException *exception) {
//                NSLog(@"%@",exception);
//            }
            // upto here commented by roja on 13/02/2019...

        }
        else if (textField == searchTxt && [searchTxt.text length]<3){
//            if(popOver != nil)
//                if(popOver.popoverVisible)
//                    [popOver dismissPopoverAnimated:YES];
            // added by roja on 22/01/2019...
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else if(textField == searchOrdersText){
        
        @try {
                if ((textField.text).length >= 3 || ((searchOrdersText.text).length == 0 )) {
                    
                    @try {
                        [self getAllBookings];
                    } @catch (NSException *exception) {
                        NSLog(@"---- exception while calling ServicesCall ----%@",exception);
                    }
                }
//                else if ((searchOrdersText.text).length == 0 ) {
//                    [self getAllBookings];
//                }
                else{
                    [HUD setHidden:YES];
                }
        } @catch (NSException * exception) {
            
        } @finally {
            
        }
    }
}


/**
 * @description
 * @date         13/02/2019
 * @method       textFieldShouldClear:
 * @author       Roja
 * @param        UITextField
 * @param
 * @return       BOOL
 * @return
 * @verified By
 * @verified On
 *
 */
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    if (textField == searchTxt) {
        
        searchTxt.text = @"";
        isRefresh = true;
        buttonTitleIndex = 0;
        
        [self getAllBookings];
    }

    return YES;
}


/**
 * @description  Service call to get searched phone numbers..
 * @date         13/02/2019
 * @method       getPhoneNumberDetails:
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPhoneNumberDetails{
    
    @try {
        
        NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
        [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [orderDetails setObject:presentLocation forKey:@"storeLocation"];
        [orderDetails setObject:[NSString stringWithFormat:@"%d",orderStartIndex] forKey:@"startIndex"]; //pending_order_no
        [orderDetails setObject:searchTxt.text forKey:@"phoneNumber"];
        [orderDetails setObject:slotIdStr forKey:@"slot"];
        
        // uncomment after getting service support...
//        [orderDetails setObject:statusStr forKey:@"status"];
//        [orderDetails setObject:bookingChannelStr forKey:--];//


        

        // Commented by roja on 21/03/2019..
        // reason for below code we get present(today) date phone nos list..
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        //        [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        //        NSDate *startDate1 = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
        //
        //        NSString *dateStr = [formatter stringFromDate:startDate1];
        //        NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",[[dateStr componentsSeparatedByString:@" "] objectAtIndex:0],@" ",@"00:00:00"];
//        [orderDetails setObject:timeStr forKey:@"dateStr"];
        //        [orderDetails setObject:timeStr forKey:@"endDateStr"];

        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        if (!isOfflineService) {
            [HUD setHidden:NO];
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setRestaurantBookingServiceDelegate:self];
            [controller getPhoneNos:getBookingJsonStr];
        }
        else {
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
}

-(void)getPendingOrders {
    
    NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
    [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
    [orderDetails setObject:@"pending" forKey:@"status"];
    [orderDetails setObject:orderType forKey:@"orderType"];
    [orderDetails setObject:[NSString stringWithFormat:@"%d",pending_order_no] forKey:@"startIndex"];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
    NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    WebServiceController *controller = [[WebServiceController alloc] init];
    [controller setFbOrderServiceDelegate:self];
    [controller getOrdersByPage:orderJsonString];
    
    
//    @try {
//
//        OrderServiceSoapBinding *param =  [OrderService OrderServiceSoapBinding];
//
//        OrderService_getOrdersByPage *orderString = [[OrderService_getOrdersByPage alloc]init];
//        orderString.arg0 = orderJsonString;
//
//
//        NSString *status;
//
//        OrderServiceSoapBindingResponse *response = [param getOrdersByPageUsingParameters:orderString];
//        NSArray *responseBodyParts1 = response.bodyParts;
//
//        for (id bodyPart in responseBodyParts1) {
//
//            if ([bodyPart isKindOfClass:[OrderService_getOrdersByPageResponse class]]) {
//
//                OrderService_getOrdersByPageResponse *body = (OrderService_getOrdersByPageResponse *)bodyPart;
//                printf("\nresponse=%s",[body.return_ UTF8String]);
//
//                status = body.return_;
//                NSError *e;
//                JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                       options: NSJSONReadingMutableContainers
//                                                         error: &e];
//
//            }
//
//        }
//
//        // NSString *response_arr1 = [JSON valueForKey:@"response"];
//
//        NSDictionary  *json1 = [JSON objectForKey:RESPONSE_HEADER];
//
//        if ([[[json1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
//
//            if ([[JSON objectForKey:@"totalOrders"] isEqualToString:@""] || [[JSON objectForKey:@"totalOrders"] isEqualToString:@"0"]) {
//
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Pending orders not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//
//            }
//            else {
//
//                totalOrder.text = [JSON objectForKey:@"totalOrders"];
//                orderStart.text = [NSString stringWithFormat:@"%d",pending_order_no+1];
//                orderEnd.text = [NSString stringWithFormat:@"%d",[orderStart.text intValue] + 9];
//
//                if ([totalOrder.text intValue] <= 10) {
//
//                    orderEnd.text = [NSString stringWithFormat:@"%d",[totalOrder.text intValue]];
//                    nextOrders.enabled =  NO;
//                    previousOrders.enabled = NO;
//                    firstOrders.enabled = NO;
//                    lastOrders.enabled = NO;
//                }
//                else{
//
//                    if (pending_order_no == 0) {
//
//                        previousOrders.enabled = NO;
//                        firstOrders.enabled = NO;
//                        nextOrders.enabled = YES;
//                        lastOrders.enabled = YES;
//                    }
//                    else if (([[JSON objectForKey:@"totalOrders"] intValue] -  (pending_order_no+1)) < 10) {
//
//                        nextOrders.enabled = NO;
//                        lastOrders.enabled = NO;
//                        orderEnd.text = totalOrder.text;
//                    }
//                }
//
//                NSArray *response_arr = [JSON valueForKey:@"ordersList"];
//                NSDictionary *temp;
//
//                if ([orderId count]!=0) {
//
//                    [orderId removeAllObjects];
//                    [tableId removeAllObjects];
//                    [waiterList removeAllObjects];
//                    [totalCost removeAllObjects];
//                    [order_date removeAllObjects];
//                }
//
//                for (int i=0; i< [response_arr count] ; i++) {
//
//                    temp = [response_arr objectAtIndex:i];
//
//                    if (![[NSString stringWithFormat:@"%@",[temp valueForKey:@"date"]] isEqualToString:@"(null)"]) {
//
//                        [orderId addObject:[temp objectForKey:ORDER_REFERENCE]];
//                        [waiterList addObject:[temp objectForKey:@"salesExecutive"]];
//                        [tableId addObject:[temp objectForKey:@"salesLocation"]];
//                        [totalCost addObject:[temp objectForKey:@"grandTotal"]];
//                        [order_date addObject:[temp objectForKey:@"date"]];
//                    }
//                    else {
//                        [orderId addObject:[temp objectForKey:@"orderReference"]];
//                        [waiterList addObject:[temp objectForKey:@"salesExecutive"]];
//                        [tableId addObject:[temp objectForKey:@"salesLocation"]];
//                        [totalCost addObject:[temp objectForKey:@"grandTotal"]];
//                    }
//                }
//            }
//            // totalOrder.text = [json1 objectForKey:@"totalOrders"];
//
//            [HUD setHidden:YES];
//            [pendingOrdersTbl reloadData];
//
//        }
//        else {
//
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Pending orders not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//
//    }
//    @catch (NSException *exception) {
//
//        [HUD setHidden:YES];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Could not connect to the server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
    
}

-(void)getPastOrders {
    
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    
    NSArray *str = [time componentsSeparatedByString:@" "];
    
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"Store Mobile APP",mail_,@"-",[NSString stringWithFormat:@"%@ %@",[[str[0] componentsSeparatedByString:@","] objectAtIndex:0],str[1]], nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
    [orderDetails setObject:dictionary_ forKey:@"requestHeader"];
    [orderDetails setObject:@"closed" forKey:@"status"];
    [orderDetails setObject:orderType forKey:@"orderType"];
    [orderDetails setObject:[NSString stringWithFormat:@"%d",past_order_no] forKey:@"startIndex"];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
    NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    WebServiceController *controller = [[WebServiceController alloc] init];
    [controller setFbOrderServiceDelegate:self];
    [controller getOrdersByPage:orderJsonString];
    
    
//    @try {
//
//        OrderServiceSoapBinding *param =  [[OrderService OrderServiceSoapBinding] retain];
//
//        OrderService_getOrdersByPage *orderString = [[OrderService_getOrdersByPage alloc]init];
//        orderString.arg0 = orderJsonString;
//
//
//        NSString *status;
//
//        [HUD setHidden:NO];
//        [HUD show:YES];
//
//        OrderServiceSoapBindingResponse *response = [param getOrdersByPageUsingParameters:orderString];
//        NSArray *responseBodyParts1 = response.bodyParts;
//
//        for (id bodyPart in responseBodyParts1) {
//
//            if ([bodyPart isKindOfClass:[OrderService_getOrdersByPageResponse class]]) {
//
//                OrderService_getOrdersByPageResponse *body = (OrderService_getOrdersByPageResponse *)bodyPart;
//                printf("\nresponse=%s",[body.return_ UTF8String]);
//
//                status = body.return_;
//                NSError *e;
//                JSON_pastOrders = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                  options: NSJSONReadingMutableContainers
//                                                                    error: &e];
//
//            }
//
//        }
//
//        // NSString *response_arr1 = [JSON valueForKey:@"response"];
//
//        NSDictionary  *json1 = [JSON_pastOrders objectForKey:@"responseHeader"];
//
//        if ([[json1 objectForKey:@"responseMessage"] isEqualToString:@"Success"] && [[json1 valueForKey:@"responseCode"]isEqualToString:@"0"]) {
//
//            if ([[JSON_pastOrders objectForKey:@"totalOrders"] isEqualToString:@""] || [[JSON_pastOrders objectForKey:@"totalOrders"] isEqualToString:@"0"]) {
//
//                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Pending orders not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                //                [alert show];

    //                //                [orderId_pastOrders addObject:@""];
//                //                [waiterList_pastOrders addObject:@""];
//                //                [tableId_pastOrders addObject:@""];
//                //                [totalCost_pastOrders addObject:@""];
//                //                [pastorder_date addObject:@""];
//
//            }
//            else {
//
//                totalOrder_takeaway.text = [JSON_pastOrders objectForKey:@"totalOrders"];
//                orderStart_takeaway.text = [NSString stringWithFormat:@"%d",past_order_no+1];
//                orderEnd_takeaway.text = [NSString stringWithFormat:@"%d",[orderStart_takeaway.text intValue] + 9];
//
//                if ([totalOrder_takeaway.text intValue] <= 10) {
//
//                    orderEnd_takeaway.text = [NSString stringWithFormat:@"%d",[totalOrder_takeaway.text intValue]];
//                    nextOrders_takeaway.enabled =  NO;
//                    previousOrders_takeaway.enabled = NO;
//                    firstOrders_takeaway.enabled = NO;
//                    lastOrders_takeaway.enabled = NO;
//                    NSLog(@"%@%@",totalOrder_takeaway.text,orderEnd_takeaway.text);
//                }
//                else{
//
//                    if (past_order_no == 0) {
//
//                        previousOrders_takeaway.enabled = NO;
//                        firstOrders_takeaway.enabled = NO;
//                        nextOrders_takeaway.enabled = YES;
//                        lastOrders_takeaway.enabled = YES;
//                    }
//                    else if (([[JSON_pastOrders objectForKey:@"totalOrders"] intValue] -  past_order_no+1) < 10) {
//
//                        nextOrders_takeaway.enabled = NO;
//                        lastOrders_takeaway.enabled = NO;
//                        orderEnd_takeaway.text = totalOrder_takeaway.text;
//                    }
//                }
//
//                NSArray *response_arr = [JSON_pastOrders valueForKey:@"ordersList"];
//                //                NSMutableArray  *response_Arr = [NSJSONSerialization JSONObjectWithData: [response_arr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &err];
//
//                NSDictionary *temp;
//
//                if ([orderId count]!=0) {
//
//                    [orderId_pastOrders removeAllObjects];
//                    [tableId_pastOrders removeAllObjects];
//                    [waiterList_pastOrders removeAllObjects];
//                    [totalCost_pastOrders removeAllObjects];
//
//                }
//
//                for (int i=0; i< [response_arr count] ; i++) {
//
//                    temp = [response_arr objectAtIndex:i];
//                    [orderId_pastOrders addObject:[temp objectForKey:@"orderReference"]];
//                    [waiterList_pastOrders addObject:[temp objectForKey:@"salesExecutive"]];
//                    [tableId_pastOrders addObject:[temp objectForKey:@"salesLocation"]];
//                    [totalCost_pastOrders addObject:[temp objectForKey:@"grandTotal"]];
//                    if (![[NSString stringWithFormat:@"%@",[temp valueForKey:@"date"]] isEqualToString:@"(null)"]) {
//
//                        [pastorder_date addObject:[temp objectForKey:@"date"]];
//                    }
//                    else {
//                        [pastorder_date addObject:@""];
//                    }
//                }
//            }
//            // totalOrder_takeaway.text = [json1 objectForKey:@"totalOrders"];
//
//            [HUD setHidden:YES];
//            [pastOrders reloadData];
//
//        }
//        else {
//
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"past orders not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//
//    }
//    @catch (NSException *exception) {
//
//        [HUD setHidden:YES];
//        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Could not connect to the server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        //        [alert show];
//
//    }
    
}

- (void) segmentAction1: (id) sender  {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    mainSegmentedControl = (UISegmentedControl *)sender;
    segmentIndex = mainSegmentedControl.selectedSegmentIndex;
    
    
    //[mainSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    switch (segmentIndex) {
        case 0:
        {
            pendingOrdersView.hidden = NO;
            pastOrdersView.hidden = YES;
            pendingHeaderView.hidden = NO;
            pending_order_no = 0;
            orderStartIndex = 0;
            if ([bookingDetails count] == 0) {
               
                float y_axis = self.view.frame.size.height - 120;
                NSString * msg = @"Bookings not available";
                [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:70  isSoundRequired:YES timming:2.0 noOfLines:2];
            }
            [pendingOrdersTbl reloadData];
            
            break;
        }
        case 1:
        {
            pendingHeaderView.hidden = YES;
            pendingOrdersView.hidden = YES;
            pastOrdersView.hidden = NO;
            past_order_no = 1;
            
            [self getAllLevels];
            break;
        }
            
    }
}
-(void)loadFirstPage:(id)sender {
    @try {
        
        AudioServicesPlaySystemSound (soundFileObject);
        
        if (sender == firstOrders) {
            [orderId removeAllObjects];
            [tableId removeAllObjects];
            [waiterList removeAllObjects];
            [totalCost removeAllObjects];
            [order_date removeAllObjects];
            
//            orderStartIndex = 0;
            pending_order_no = 0;
            //    cellcount = 10;
            
            //[HUD setHidden:NO];
            [HUD show:YES];
            [self getAllBookings];
        }
        else if (sender == firstOrders_takeaway){
            
            past_order_no = 1;
            //    cellcount = 10;
            
            //[HUD setHidden:NO];
            [self populateTableView:[levelsArr objectAtIndex:0]];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


-(void)loadLastPage:(id)sender {
    
    @try {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        if (sender == lastOrders) {
            
            [orderId removeAllObjects];
            [tableId removeAllObjects];
            [waiterList removeAllObjects];
            [totalCost removeAllObjects];
            [order_date removeAllObjects];
            
            //float a = [rec_total.text intValue]/5;
            //float t = ([rec_total.text floatValue]/5);
            
            // NSLog(@"%@",totalOrder.text);
            
            // NSLog(@"%f",([totalOrder.text floatValue]/10));
            //
            if ([totalOrder.text intValue]/10 == ([totalOrder.text floatValue]/10)) {
                pending_order_no = (([totalOrder.text intValue]/10)*10)-10;
            }
            else{
                pending_order_no = ([totalOrder.text intValue]/10) * 10;
            }
            
            
            //changeID = ([rec_total.text intValue]/5) - 1;
            
            //previousButton.backgroundColor = [UIColor grayColor];
            previousOrders.enabled = YES;
            
            
            //frstButton.backgroundColor = [UIColor grayColor];
            firstOrders.enabled = YES;
            
            [HUD setHidden:NO];
            [HUD show:YES];
            [self getAllBookings];
        }
        else if (sender == lastOrders_takeaway) {
            
            past_order_no = (int)[levelsArr count];
            
            [self populateTableView:[levelsArr lastObject]];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)loadPreviousPage:(id)sender {
    
    @try {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        if (sender == previousOrders) {
            
            [orderId removeAllObjects];
            [tableId removeAllObjects];
            [waiterList removeAllObjects];
            [totalCost removeAllObjects];
            [order_date removeAllObjects];
            
            if (pending_order_no > 0){
                
                pending_order_no = pending_order_no-10;
                
                [self getAllBookings];
                
                if ([orderEnd.text isEqualToString:totalOrder.text]) {
                    
                    lastOrders.enabled = NO;
                }
                else {
                    lastOrders.enabled = YES;
                }
                nextOrders.enabled =  YES;
                
                [HUD setHidden:NO];
                [HUD setHidden:YES];
                
            }
            else{
                //previousButton.backgroundColor = [UIColor lightGrayColor];
                previousOrders.enabled =  NO;
                
                //nextButton.backgroundColor = [UIColor grayColor];
                nextOrders.enabled =  YES;
            }
            
        }
        else if (sender == previousOrders_takeaway){
            
            [orderId_pastOrders removeAllObjects];
            [tableId_pastOrders removeAllObjects];
            [waiterList_pastOrders removeAllObjects];
            [totalCost_pastOrders removeAllObjects];
            [pastorder_date removeAllObjects];
            
            if (past_order_no > 0){
                
                past_order_no = past_order_no-1;
                
                [self populateTableView:[levelsArr objectAtIndex:(past_order_no-1)]];
                
                if ([orderEnd_takeaway.text isEqualToString:totalOrder_takeaway.text]) {
                    
                    lastOrders_takeaway.enabled = NO;
                }
                else {
                    lastOrders_takeaway.enabled = YES;
                }
                nextOrders_takeaway.enabled =  YES;
                
                [HUD setHidden:NO];
                [HUD setHidden:YES];
            }
            else{
                //previousButton.backgroundColor = [UIColor lightGrayColor];
                previousOrders_takeaway.enabled =  NO;
                
                //nextButton.backgroundColor = [UIColor grayColor];
                nextOrders_takeaway.enabled =  YES;
            }
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)loadNextPage:(id)sender {
    @try {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        if (sender == nextOrders) {
            //previousButton.backgroundColor = [UIColor grayColor];
            previousOrders.enabled =  YES;
            
            pending_order_no = pending_order_no+10;
            
            [orderId removeAllObjects];
            [tableId removeAllObjects];
            [waiterList removeAllObjects];
            [totalCost removeAllObjects];
            [order_date removeAllObjects];
            
            [HUD setHidden:NO];
            
            // nextOrders.enabled =  NO;
            //nextButton.backgroundColor = [UIColor lightGrayColor];
            
            // Getting the required from webServices ..
            // Create the service
            
            firstOrders.enabled = YES;
            
            [self getAllBookings];
        }
        else if (sender == nextOrders_takeaway){
            //previousButton.backgroundColor = [UIColor grayColor];
            previousOrders_takeaway.enabled =  YES;
            
            past_order_no = past_order_no+1;
            
            [self populateTableView:[levelsArr objectAtIndex:(past_order_no-1)]];
            
            firstOrders_takeaway.enabled = YES;
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
#pragma -mark tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == pendingOrdersTbl) {
        return [bookingDetails count];
    }
    else if (tableView == slotIdsTbl) {
        return [slotIdsArr count];
    }
    else if (tableView == statusDropDownTbl) {
        return [statusPopUpArr count];
    }
    else if (tableView == bookingChannelDropDownTbl) {
        return [bookingChannelPopUpArr count];
    }
    else if (tableView == levelsTbl) {
        return [levelsArr count];
    }
    else if (tableView == mobilesTbl) {
        return [mobileNosArr count];
    }
    else if (tableView == pagenationTable){
        
        return pagenationArray.count;
    }
    else {
        return [orderId_pastOrders count];
    }
}

//heigth for tableviewcell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (tableView == levelsTbl || tableView == slotIdsTbl || tableView == mobilesTbl || statusDropDownTbl || bookingChannelDropDownTbl) {
            
            return 40.0;
        }
        else if(tableView == pendingOrdersTbl){
            
            return 40;
        }
        else if(tableView == pagenationTable){

            return 35;
        }
        else{
            return 0;
        }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"OrderCell";
    
    CellView_ServiceOrder *cell;
    
    cell = (CellView_ServiceOrder *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CellView_ServiceOrder" owner:self options:nil] objectAtIndex:0];
    }
    
    if (tableView == pendingOrdersTbl) {
        
        @try {
            
            NSDictionary *temp = [bookingDetails objectAtIndex:indexPath.row];
            if (![[temp valueForKey:ORDER_REFERENCE] isKindOfClass:[NSNull class]]) {
                cell.orderId.text = [NSString stringWithFormat:@"%@",[temp valueForKey:ORDER_REFERENCE]];
            }
            else {
                cell.orderId.text = @"-";
                
            }
            if (![[temp valueForKey:SALES_LOCATION] isKindOfClass:[NSNull class]] && [[temp valueForKey:SALES_LOCATION] length]>0) {
                cell.tableNo.text = [NSString stringWithFormat:@"%@",[temp valueForKey:SALES_LOCATION]];
            }
            else {
                cell.tableNo.text = @"    -   ";
                
            }
            if (![[temp valueForKey:CUSTOMER_NAME] isKindOfClass:[NSNull class]]) {
                cell.waiterName.text = [NSString stringWithFormat:@"%@",[temp valueForKey:CUSTOMER_NAME]];
            }
            else {
                cell.waiterName.text = @"-";
                
            }
            if (![[temp valueForKey:OCCASION_DESC] isKindOfClass:[NSNull class]]) {
                cell.totalBill.text = [NSString stringWithFormat:@"%@",[temp valueForKey:OCCASION_DESC]];
            }
            else {
                cell.totalBill.text = @"-";
            }
            
            if (![[temp valueForKey:MOBILE_NUMBER] isKindOfClass:[NSNull class]]) {
                cell.orderDate.text = [NSString stringWithFormat:@"%@",[temp valueForKey:MOBILE_NUMBER]];
            }
            else {
                cell.orderDate.text = @"    -   ";
            }
            
            
            if (![[temp valueForKey:SLOT_ID] isKindOfClass:[NSNull class]]) {
                cell.slotId.text = [NSString stringWithFormat:@"%@",[temp valueForKey:SLOT_ID]];
            }
            else {
                cell.slotId.text = @"-";
            }
            
            cell.orderChannelLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:@"reservationTypeId"] defaultReturn:@""];
         
            cell.statusBtn.tag = indexPath.row;
            
            [cell.statusBtn addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
            
            
            // added by roja on 23/02/2019..
            cell.openBtn.tag = indexPath.row;
            [cell.openBtn addTarget:self action:@selector(openBookingDetailsView:) forControlEvents:UIControlEventTouchUpInside];

            
            if ([statusArr count]>=indexPath.row) {
                
                [cell.statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [cell.statusBtn setTitle:[[[statusArr objectAtIndex:indexPath.row] substringToIndex:1] uppercaseString] forState:UIControlStateNormal] ;
                cell.statusBtn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
                
                if ([[statusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"booked"] == NSOrderedSame) {
                    
                    [cell.statusBtn setTitle:[[@"Reserved" substringToIndex:1] uppercaseString] forState:UIControlStateNormal] ;
                    
                    cell.statusBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:252.0/255.0 blue:72.0/255.0 alpha:1.0];
                }
                //                else if ([[statusArr objectAtIndex:indexPath.row] isEqualToString:@"R"]) {
                //
                //                    cell.statusBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:201.0/255.0 blue:14.0/255.0 alpha:1.0];
                //                }
                else  if ([[statusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"Arrived"]==NSOrderedSame) {
                    
                    cell.statusBtn.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:39.0/255.0 alpha:1.0];
                }
                else  if ([[statusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"Seated"]==NSOrderedSame) {
                    
                    cell.statusBtn.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:177.0/255.0 blue:76.0/255.0 alpha:1.0];
                }
                else  if ([[statusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"Billed"]==NSOrderedSame) {
                    
                    UIColor *color = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:@"Billed"]];
                    cell.statusBtn.backgroundColor = color;
                }
                else  if ([[statusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"Vacated"]==NSOrderedSame) {
                    
                    cell.statusBtn.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:72.0/255.0 blue:204.0/255.0 alpha:1.0];
                }
                else   if ([[statusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"Cancel"] == NSOrderedSame) {
                    
                    cell.statusBtn.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:28.0/255.0 blue:36.0/255.0 alpha:1.0];
                }
                else {
                    cell.statusBtn.backgroundColor = [UIColor colorWithRed:112.0/255.0 green:146.0/255.0 blue:190.0/255.0 alpha:1.0];
                }
            }
            
            cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            cell.waiterName.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            cell.orderChannelLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            cell.slotId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            cell.tableNo.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            cell.statusBtn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            
            cell.frame = CGRectMake(0, 0,self.view.frame.size.width+180, 40);
            
            cell.orderId.frame = CGRectMake(10, 5, 155, 30);

            cell.orderDate.frame = CGRectMake(cell.orderId.frame.origin.x + cell.orderId.frame.size.width + 1.5,cell.frame.origin.y,130, cell.frame.size.height);
            
            cell.waiterName.frame = CGRectMake(cell.orderDate.frame.origin.x + cell.orderDate.frame.size.width + 1.5, cell.frame.origin.y, 110, cell.frame.size.height);
            
            cell.orderChannelLbl.frame = CGRectMake(cell.waiterName.frame.origin.x + cell.waiterName.frame.size.width + 1.5, cell.frame.origin.y,140, cell.frame.size.height);
            
            cell.totalBill.frame = CGRectMake(cell.orderChannelLbl.frame.origin.x + cell.orderChannelLbl.frame.size.width + 1.5, cell.frame.origin.y, 140, cell.frame.size.height);
            
            cell.slotId.frame = CGRectMake(cell.totalBill.frame.origin.x + cell.totalBill.frame.size.width + 1.5, cell.frame.origin.y, 75, cell.frame.size.height);
            
            cell.tableNo.frame = CGRectMake(cell.slotId.frame.origin.x + cell.slotId.frame.size.width + 1.5, cell.frame.origin.y, 90, cell.frame.size.height);
            
            cell.statusBtn.frame = CGRectMake(cell.tableNo.frame.origin.x + cell.tableNo.frame.size.width + 21.5, 2.5, 35, 35);

            cell.openBtn.frame = CGRectMake(cell.statusBtn.frame.origin.x + cell.statusBtn.frame.size.width + 23.5, cell.frame.origin.y, 75, cell.frame.size.height);

            // Upto here changes done by roja on 12/02/2019...
            
            
            [cell setBackgroundColor:[UIColor blackColor]];
            cell.waiterName.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            cell.tableNo.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            cell.totalBill.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            cell.orderChannelLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            cell.orderDate.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            [cell.orderId setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5f]];
            
            cell.orderId.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
            cell.orderId.layer.cornerRadius = 10.0f;
            cell.orderId.layer.masksToBounds = YES;
            cell.orderId.textAlignment = NSTextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.statusBtn.layer.cornerRadius = cell.statusBtn.frame.size.height/2;
            
            
            
            // added by roja on 12/02/2019...
            cell.tableNo.textAlignment = NSTextAlignmentCenter;
            cell.waiterName.textAlignment = NSTextAlignmentCenter;
            cell.totalBill.textAlignment = NSTextAlignmentCenter;
            cell.slotId.textAlignment = NSTextAlignmentCenter;
            cell.orderDate.textAlignment = NSTextAlignmentCenter;
            cell.orderChannelLbl.textAlignment = NSTextAlignmentCenter;

            
            //            cell.orderDate.hidden = YES;
            return cell;
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            return cell;
        }
        
    }
    else if (tableView == mobilesTbl) {
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            }
        }
        hlcell.frame = CGRectMake(0, 0, mobilesTbl.frame.size.width, 40);
        
        @try {
            
            
            NSDictionary *temp = [mobileNosArr objectAtIndex:indexPath.row];
            
            hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[temp valueForKey:MOBILE_NUMBER]];
        } @catch (NSException *exception) {
            
        }
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
    else if (tableView == slotIdsTbl) {
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[slotIdsArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
    else if (tableView == levelsTbl) {
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell = [[UITableViewCell alloc]
                      initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[levelsArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
    
    else if (tableView == pagenationTable) {
        @try {
            static NSString * CellIdentifier = @"pagenationCell";
            
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
            
            hlcell.textLabel.text = pagenationArray[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
        }
    }
    else if(tableView == statusDropDownTbl){ // added by roja on 21/09/2019...
        
        static NSString *hlCellID = @"hlCellID";
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[statusPopUpArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
    else if(tableView == bookingChannelDropDownTbl){
        
        static NSString *hlCellID = @"hlCellID";
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[bookingChannelPopUpArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
    else {
        
        cell.orderId.text = [orderId_pastOrders objectAtIndex:indexPath.row];
        cell.tableNo.text = [tableId_pastOrders objectAtIndex:indexPath.row];
        cell.waiterName.text = [waiterList_pastOrders objectAtIndex:indexPath.row];
        cell.totalBill.text = [NSString stringWithFormat:@"%.2f",[[totalCost_pastOrders objectAtIndex:indexPath.row] floatValue]];
        if ([pastorder_date count]!=0) {
            cell.orderDate.text = [pastorder_date objectAtIndex:indexPath.row];
            
        }
        else {
            cell.orderDate.text = @"";
        }
        [cell setBackgroundColor:[UIColor blackColor]];
        cell.waiterName.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        cell.tableNo.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        cell.totalBill.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        cell.orderDate.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            cell.frame = CGRectMake(0, 0,320, 45);
            cell.orderId.frame = CGRectMake(0,16,70, 20);
            cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMT" size:12.0];
            cell.tableNo.frame = CGRectMake(70,16,60, 20);
            cell.tableNo.font = [UIFont fontWithName:@"ArialRoundedMT" size:12.0];
            cell.waiterName.frame = CGRectMake(125,16,60, 20);
            cell.waiterName.font = [UIFont fontWithName:@"ArialRoundedMT" size:12.0];
            cell.orderDate.frame = CGRectMake(180,16,80, 20);
            cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMT" size:12.0];
            cell.totalBill.frame = CGRectMake(265,16,60, 20);
            cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMT" size:12.0];
            
        }
        else {
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
                cell.frame = CGRectMake(0, 0,self.view.frame.size.width, 60);
                cell.orderId.frame = CGRectMake(10,16,170, 40);
                cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMT" size:20.0];
                cell.tableNo.frame = CGRectMake(220,16,170, 40);
                cell.tableNo.font = [UIFont fontWithName:@"ArialRoundedMT" size:20.0];
                cell.waiterName.frame = CGRectMake(410,16,170, 40);
                cell.waiterName.font = [UIFont fontWithName:@"ArialRoundedMT" size:20.0];
                cell.orderDate.frame = CGRectMake(580,16,170, 40);
                cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMT" size:20.0];
                cell.totalBill.frame = CGRectMake(800,16,170, 40);
                cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMT" size:20.0];
                cell.slotId.frame = CGRectMake(800,16,170, 40);
                cell.slotId.font = [UIFont fontWithName:@"ArialRoundedMT" size:20.0];
            }
        }
        [cell.orderId setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5f]];
        cell.orderId.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        cell.orderId.layer.cornerRadius = 10.0f;
        cell.orderId.layer.masksToBounds = YES;
        cell.orderId.textAlignment = NSTextAlignmentCenter;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (tableView == levelsTbl) {
        @try {
            
//            [popOver dismissPopoverAnimated:YES];
            // added by roja on 22/01/2019...
            [self dismissViewControllerAnimated:YES completion:nil];
            
            levelTxt.text = [levelsArr objectAtIndex:indexPath.row];
            [self populateTableView:[levelsArr objectAtIndex:indexPath.row]];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
//            [popOver dismissPopoverAnimated:YES];
            // added by roja on 22/01/2019...
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    else if (tableView == mobilesTbl) {
        
        @try {
//            [popOver dismissPopoverAnimated:YES];
            
            NSDictionary *temp = [self checkGivenValueIsNullOrNil:[mobileNosArr objectAtIndex:indexPath.row] defaultReturn:@""];
            searchTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:@"mobileNumber"] defaultReturn:@""];
            // added by roja on 22/01/2019...
            [self dismissViewControllerAnimated:YES completion:nil];

            
            // commented by roja on 11/03/2019...
//            searchTxt.text = @"";
            // Reason on selection of number no need to go to bookings page...
//            NSDictionary *temp = [mobileNosArr objectAtIndex:indexPath.row];
//            BookingWorkFlow *workFlow = [[BookingWorkFlow alloc] init];
//            workFlow.orderRef = [temp valueForKey:ORDER_REFERENCE];
//            [self.navigationController pushViewController:workFlow animated:YES];
        }
        @catch (NSException *exception) {
         
            NSLog(@"%@",exception);
        }
      
    }
    else if (tableView == pagenationTable){ // added by roja on 20/03/2019...
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            orderStartIndex = 0;
            pagenationText.text = pagenationArray[indexPath.row];
            int pageValue = (pagenationText.text).intValue;
            orderStartIndex = orderStartIndex + (pageValue * 10) - 10;
            [catPopOver dismissPopoverAnimated:YES];

        } @catch (NSException * exception) {
            
        }
    }
    else if (tableView == slotIdsTbl) {
        
        slotTextField.text = [NSString stringWithFormat:@"%@",[slotIdsArr objectAtIndex:indexPath.row]];
        slotIdStr = slotTextField.text;
        
        // added by roja on 21/02/2019...
        if (indexPath.row == 0) {
            slotIdStr = @"";
        }
//        [popOver dismissPopoverAnimated:YES];
        // added by roja on 22/01/2019...
        [self dismissViewControllerAnimated:YES completion:nil];
        
        @try {
            // commented by roja on 22/03/2019...
            // Reason Now we have implemented search button.. need to get bookings directly on sellection of slot..
//            buttonTitleIndex = 0;
//            if (!isOfflineService) {
//                [self getAllBookings];
//            }
            // Upto here commented by roja on 22/03/2019...

            
            
            // don't delete...
            // commented by roja on 10/01/2019..
            // reason Offline work need to work out.
            //            else {
            //
            //                RestBookingServices *service = [[RestBookingServices alloc] init];
            //                NSMutableDictionary *result = [service getBookingDetailsByFilters:orderDetails orderId:@""];
            //                if ([result count]) {
            //
            //                    totalOrder.text = [[result objectForKey:@"totalRecords"] stringValue];
            //                    bookingDetails = [NSMutableArray new];
            //                    statusArr = [NSMutableArray new];
            //
            //                    NSArray *array = [result valueForKey:kBookingsList];
            //
            //                    for (NSDictionary *dic in array) {
            //                        if(![[dic valueForKey:STATUS] isKindOfClass:[NSNull class]]) {
            //                            [statusArr addObject:[dic valueForKey:STATUS]];
            //                        }
            //                        else {
            //                            [statusArr addObject:@""];
            //                        }
            //                        NSArray *objects = [NSArray arrayWithObjects:[dic valueForKey:CUSTOMER_NAME],[dic valueForKey:MOBILE_NUMBER],[dic valueForKey:ORDER_REFERENCE],[dic valueForKey:OCCASION_DESC],[dic valueForKey:SLOT_ID],[dic valueForKey:SALES_LOCATION], nil];
            //                        NSArray *keys = [NSArray arrayWithObjects:CUSTOMER_NAME,MOBILE_NUMBER,ORDER_REFERENCE,OCCASION_DESC,SLOT_ID,SALES_LOCATION, nil];
            //
            //                        [bookingDetails addObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
            //                    }
            //                    [HUD setHidden:YES];
            //                    [pendingOrdersTbl reloadData];
            //                    //                [self addPaginationButtons:[totalOrder.text intValue]];
            //
            //                }
            //                else {
            //                    [HUD setHidden:YES];
            //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NoBookingsAvailable", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                    [alert show];
            //                    if ([bookingDetails count]) {
            //
            //                        [bookingDetails removeAllObjects];
            //                    }
            //
            //                    [pendingOrdersTbl reloadData];
            //
            //                }
            //            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    else if (tableView == statusDropDownTbl){ // added by roja on 21/03/2019...
        
        @try {
            statusTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[statusPopUpArr objectAtIndex:indexPath.row] defaultReturn:@""]];
            
            statusStr = statusTF.text;
            
            if (indexPath.row == 0) {
                statusStr = @"";
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            
            // commented by roja on 22/03/2019...
            // Reason Now we have implemented search button.. need to get bookings directly on sellection of Status..

//                if (!isOfflineService) {
//                    [self getAllBookings];
//                }
            //Upto here commented by roja on 22/03/2019...
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    else if (tableView == bookingChannelDropDownTbl){ // added by roja on 21/03/2019...
        
        @try {
            bookingChannelTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[bookingChannelPopUpArr objectAtIndex:indexPath.row] defaultReturn:@""]];
            
              bookingChannelStr = bookingChannelTF.text;
            
            if (indexPath.row == 0) {
              bookingChannelStr  = @"";
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            
            // commented by roja on 22/03/2019...
            // Reason Now we have implemented search button.. need to get bookings directly on sellection of Booking channel here..
//                if (!isOfflineService) {
//                    [self getAllBookings];
//                }
            //Upto here commented by roja on 22/03/2019...
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    // commented by roja on 01/03/2019
    // reason the order has to be opened on selection of "open" button...
//    else {
//        BookingWorkFlow *workFlow = [[BookingWorkFlow alloc] init];
//        workFlow.orderRef = [[bookingDetails objectAtIndex:indexPath.row] valueForKey:ORDER_REFERENCE];
//        [self.navigationController pushViewController:workFlow animated:YES];
//    }
    
    //    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] ;
    //
    //    OrderDatails *order_details = [[OrderDatails alloc] init];
    //    order_details.orderType = @"immediate";
    //
    //    if (tableView == pendingOrdersTbl) {
    //
    //        order_details.orderRef = [orderId objectAtIndex:indexPath.row];
    //        order_details.orderStatus = @"pending";
    //    }
    //    else {
    //        order_details.orderRef = [orderId_pastOrders objectAtIndex:indexPath.row];
    //        order_details.orderStatus = @"past";
    //
    //    }
    //
    //   // mainSegmentedControl.selectedSegmentIndex = 0;
    //
    //    [self.navigationController pushViewController:order_details animated:YES];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}
#pragma mark end of tableview methods

-(void)goToHome {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}

// Added by roja on 19/03/2019...
-(void)backAction {

    //Play audio for button touch...
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
            [self goToHome];

//        [self.navigationController popViewControllerAnimated:YES];
        
        //[self.navigationController popToRootViewControllerAnimated:YES];
        
//        [self.navigationController popToViewController:viewControllerObject animated:YES];
        
    } @catch (NSException *exception) {
        
    }
}



/**
 * @description      get the avilable levels based on the location
 * @date            14/12/15
 * @method          getAllLevels
 * @author           Sonali
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getAllLevels {

    UILabel *labelTxt = [[UILabel alloc] init];
    labelTxt.backgroundColor = [UIColor clearColor];
    labelTxt.textColor = [UIColor whiteColor];
    labelTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    labelTxt.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:0];
    
    UILabel *labelColor = [[UILabel alloc] init];
    labelColor.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt.text]];
    
    
    UILabel *labelTxt1 = [[UILabel alloc] init];
    labelTxt1.backgroundColor = [UIColor clearColor];
    labelTxt1.textColor = [UIColor whiteColor];
    labelTxt1.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    labelTxt1.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:1];
    
    UILabel *labelColor1 = [[UILabel alloc] init];
    labelColor1.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt1.text]];
    
    
    UILabel *labelTxt2 = [[UILabel alloc] init];
    labelTxt2.backgroundColor = [UIColor clearColor];
    labelTxt2.textColor = [UIColor whiteColor];
    labelTxt2.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    labelTxt2.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:2];
    
    UILabel *labelColor2 = [[UILabel alloc] init];
    labelColor2.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt2.text]];
    
    
    UILabel *labelTxt3 = [[UILabel alloc] init];
    labelTxt3.backgroundColor = [UIColor clearColor];
    labelTxt3.textColor = [UIColor whiteColor];
    labelTxt3.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    labelTxt3.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:3];
    
    UILabel *labelColor3 = [[UILabel alloc] init];
    labelColor3.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt3.text]];
    
    // added by roja on 23/02/2019...
    UILabel *labelTxt4 = [[UILabel alloc] init];
    labelTxt4.backgroundColor = [UIColor clearColor];
    labelTxt4.textColor = [UIColor whiteColor];
    labelTxt4.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    labelTxt4.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:4];
    
    UILabel *labelColor4 = [[UILabel alloc] init];
    labelColor4.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt4.text]];
    //upto here added by roja on 23/02/2019...


    
    levelTxt = [[UITextField alloc] init];
    levelTxt.borderStyle = UITextBorderStyleRoundedRect;
    levelTxt.textColor = [UIColor blackColor];
    levelTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    levelTxt.backgroundColor = [UIColor clearColor];
    levelTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    levelTxt.backgroundColor = [UIColor whiteColor];
    levelTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    levelTxt.returnKeyType = UIReturnKeyDone;
    levelTxt.placeholder  = @"Select level";
    levelTxt.delegate = self;
    
    selectLevels = [[UIButton alloc] init];
    UIImage *buttonImageDD = [UIImage imageNamed:@"down.png"];
    [selectLevels setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectLevels addTarget:self
                     action:@selector(selectLevel:) forControlEvents:UIControlEventTouchDown];
    selectLevels.tag = 1;
    
    
    levelTxt.frame = CGRectMake(10,20,200, 45);
    levelTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22];
    selectLevels.frame = CGRectMake(160, 20, 45, 45);
    
    
     // framing changed by roja on 12/02/2019..
    // reason framing setting to dynamically.....
    // 1st color code framing....
    labelColor.frame = CGRectMake(10, 20, 25, 25);
    labelTxt.frame = CGRectMake(labelColor.frame.origin.x + labelColor.frame.size.width + 15, labelColor.frame.origin.y, 150, 30);
    
    // 2nd color code framing....
    labelColor1.frame = CGRectMake(labelColor.frame.origin.x, labelColor.frame.origin.y + labelColor.frame.size.height + 10, labelColor.frame.size.width, 25);
    labelTxt1.frame = CGRectMake(labelColor1.frame.origin.x + labelColor1.frame.size.width + 15, labelColor1.frame.origin.y, 150, 30);
    
    // 3rd color code framing....
    labelColor2.frame = CGRectMake(labelColor.frame.origin.x, labelColor1.frame.origin.y + labelColor1.frame.size.height + 10, labelColor.frame.size.width, 25);
    labelTxt2.frame = CGRectMake(labelColor2.frame.origin.x + labelColor2.frame.size.width + 15, labelColor2.frame.origin.y, 150, 30);
    
    // 4th color code framing....
    labelColor3.frame = CGRectMake(labelColor.frame.origin.x, labelColor2.frame.origin.y + labelColor2.frame.size.height + 10, labelColor.frame.size.width, 25);
    labelTxt3.frame = CGRectMake(labelColor3.frame.origin.x + labelColor3.frame.size.width + 15, labelColor3.frame.origin.y, 150, 30);
    
    // 5th color code framing....
    labelColor4.frame = CGRectMake(labelColor.frame.origin.x, labelColor3.frame.origin.y + labelColor3.frame.size.height + 10, labelColor.frame.size.width, 25);
    labelTxt4.frame = CGRectMake(labelColor4.frame.origin.x + labelColor4.frame.size.width + 15, labelColor4.frame.origin.y, 150, 30);
    
    
////    [pastOrdersView addSubview:levelTxt];
////    [pastOrdersView addSubview:selectLevels];
//    [pastOrdersView addSubview:labelTxt];
//    [pastOrdersView addSubview:labelColor];
//    [pastOrdersView addSubview:labelTxt1];
//    [pastOrdersView addSubview:labelColor1];
//    [pastOrdersView addSubview:labelTxt2];
//    [pastOrdersView addSubview:labelColor2];
//    [pastOrdersView addSubview:labelTxt3];
//    [pastOrdersView addSubview:labelColor3];
//
//    [pastOrdersView addSubview:labelTxt4];
//    [pastOrdersView addSubview:labelColor4];

    
    // added by roja on  05/03/2019...
    [levelsDisplayView addSubview:labelTxt];
    [levelsDisplayView addSubview:labelColor];
    [levelsDisplayView addSubview:labelTxt1];
    [levelsDisplayView addSubview:labelColor1];
    [levelsDisplayView addSubview:labelTxt2];
    [levelsDisplayView addSubview:labelColor2];
    [levelsDisplayView addSubview:labelTxt3];
    [levelsDisplayView addSubview:labelColor3];
    [levelsDisplayView addSubview:labelTxt4];
    [levelsDisplayView addSubview:labelColor4];
    //upto here added by roja on  05/03/2019...
    
//    [self populateTableView];
    
    @try {
        
        if (!isOfflineService) {
            
            [HUD setHidden:NO];
            NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:presentLocation,@"-1",[RequestHeader getRequestHeader], nil] forKeys:[NSArray arrayWithObjects:@"location",START_INDEX,REQUEST_HEADER, nil]];
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
            NSString * getLevelsJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setOutletServiceDelegate:self];
            [controller getTheAvailableLevelsWithRestFullService:getLevelsJsonStr];
            
        }
        // Commented by roja on 09/01/2019
        // reason Offline work need to be done.
//        else {
//
//          RestBookingServices  *offlineService = [[RestBookingServices alloc] init];
//            levelsArr = [offlineService getAllTheLevelsInRest];
//            if ([levelsArr count]) {
//
//
//                totalOrder_takeaway.text = [NSString stringWithFormat:@"%d",[levelsArr count]];
//                orderStart_takeaway.text = [NSString stringWithFormat:@"%d",past_order_no];
//
//                pending_order_no = 0;
//                [self populateTableView:[levelsArr objectAtIndex:0]];
//
//
//            }
//
//        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
}

/**
 * @description     tableview layout
 * @date            3/12/15
 * @method          populateTableView
 * @author           Sonali
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
-(void)populateTableView:(NSString*)level {
    
    
    @try {
        [HUD setHidden:NO];

        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:presentLocation,@"-1",[RequestHeader getRequestHeader],level, nil] forKeys:[NSArray arrayWithObjects:@"location",START_INDEX,REQUEST_HEADER,LEVEL, nil]];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        if (!isOfflineService) {
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setStoreServiceDelegate:self];
            [controller getLayoutDetails:getBookingJsonStr];
            
        }
        
        // commented by roja on 10/01/2019..
        // reason offline work need to be done.
//        else {
//           RestBookingServices *offlineService = [[RestBookingServices alloc] init];
//            NSMutableDictionary *successDic = [offlineService getTablesInLevel:reqDic];
//            if ([successDic count]) {
//
//                [self getOutletDetailsSuccessResponse:successDic];
//            }
//        }
 
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];

        NSLog(@"Exception %@",exception);
    }
}

// added by roja on 11/01/2019..
-(void)getAllLayoutTablesSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        tableDetails = [NSMutableArray new];
        tableStatusArr = [NSMutableArray new];

        NSArray *array = [successDictionary valueForKey:TABLES_LIST];
        
        for (NSDictionary * tableDetailsDic in array) {
            
            NSString * dateTimeStr = @"";
            NSString * tableallocatioDateTime = @"";
            
            int adultPax = 0;
            int childPax = 0;
            int noOfSeatsOccupied = 0;
            
            if( ([tableDetailsDic.allKeys containsObject:@"order"] && ![[tableDetailsDic valueForKey:@"order"]  isKindOfClass: [NSNull class]]) && [tableDetailsDic valueForKey:@"order"] != nil){
                
                dateTimeStr =  [self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"reservationDateTime"] defaultReturn:@""]; //  reservationDateTime is for booking time
                
                tableallocatioDateTime = [self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"date"] defaultReturn:@""];
                
                adultPax = [[self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"adultPax"] defaultReturn:@"0"] intValue];
                
                childPax = [[self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"childPax"] defaultReturn:@"0"] intValue];
            }
            
            
//            dateTimeStr =  [self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"reservationDateTime"] defaultReturn:@""]; //  reservationDateTime is for booking time
//            tableallocatioDateTime = [self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"date"] defaultReturn:@""];
//            adultPax = [[self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"adultPax"] defaultReturn:@""] intValue];
//            childPax = [[self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"childPax"] defaultReturn:@""] intValue];

            noOfSeatsOccupied = adultPax + childPax;
            
            [tableDetails addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[tableDetailsDic valueForKey:LEVEL],[tableDetailsDic valueForKey:TABLE_NUMBER],[tableDetailsDic valueForKey:kNoOfChairs],dateTimeStr,tableallocatioDateTime,[NSNumber numberWithInt:noOfSeatsOccupied], nil] forKeys:[NSArray arrayWithObjects:LEVEL,TABLE_NUMBER,kNoOfChairs,@"reservationDateTime",@"startDateTime",@"noOfOccupiedSeats", nil]]];
            
            [tableStatusArr addObject:[self checkGivenValueIsNullOrNil:[tableDetailsDic valueForKey:STATUS]  defaultReturn:@""]];
        }
        orderStart_takeaway.text = [NSString stringWithFormat:@"%d",past_order_no];
        
        if (past_order_no == [levelsArr count]) {
            
            firstOrders_takeaway.enabled = YES;
            previousOrders_takeaway.enabled = YES;
            nextOrders_takeaway.enabled = NO;
            lastOrders_takeaway.enabled = NO;
        }
        else if (past_order_no == 1) {
            firstOrders_takeaway.enabled = NO;
            previousOrders_takeaway.enabled = NO;
            nextOrders_takeaway.enabled = YES;
            lastOrders_takeaway.enabled = YES;
            
        }
//            [pastOrdersView addSubview:collectionView];
            [collectionView setHidden:NO];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    @finally{
        
        [HUD setHidden:YES];
        [collectionView reloadData];

        // added by roja on 08/03/2019...
        int totalSeatsCount = 0;
        int totalSeatsOccupiedCount = 0;
        
        for (NSDictionary * orderDetailsDic in tableDetails) {
            
            totalSeatsCount += [[self checkGivenValueIsNullOrNil:[orderDetailsDic valueForKey:kNoOfChairs] defaultReturn:@"0"] intValue];
            totalSeatsOccupiedCount += [[self checkGivenValueIsNullOrNil:[orderDetailsDic valueForKey:@"noOfOccupiedSeats"] defaultReturn:@"0"] intValue];
        }
        totalSeatsValueTF.text = [NSString stringWithFormat:@"%@%d",@"  ",totalSeatsCount];
        occupiedSeatsValueTF.text = [NSString stringWithFormat:@"%@%d",@"  ",totalSeatsOccupiedCount];
        bookedSeatsValueTF.text = [NSString stringWithFormat:@"%@%@",@"  ",@"0"];
        //upto here added by roja on 08/03/2019...
    }
}


-(void)getAllLayoutTablesErrorResponse:(NSString *)errorResponse{
    
    [HUD setHidden:YES];
    
    orderStart_takeaway.text = [NSString stringWithFormat:@"%d",past_order_no];
    
    if (past_order_no == [levelsArr count]) {
        
        firstOrders_takeaway.enabled = YES;
        previousOrders_takeaway.enabled = YES;
        nextOrders_takeaway.enabled = NO;
        lastOrders_takeaway.enabled = NO;
    }
    else if (past_order_no == 1) {
        firstOrders_takeaway.enabled = NO;
        previousOrders_takeaway.enabled = NO;
        nextOrders_takeaway.enabled = YES;
        lastOrders_takeaway.enabled = YES;
        
    }
    
    float y_axis = self.view.frame.size.height - 120;

    [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
    
    [collectionView setHidden:YES];
}




-(void)selectLevel:(UIButton*)sender {
   
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, 250)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    levelsTbl = [[UITableView alloc] init];
    levelsTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [levelsTbl setDataSource:self];
    [levelsTbl setDelegate:self];
    [levelsTbl.layer setBorderWidth:1.0f];
    levelsTbl.layer.cornerRadius = 3;
    levelsTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        levelsTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
    }
    
    [customView addSubview:levelsTbl];
    
    customerInfoPopUp.view = customView;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:levelTxt.frame inView:pastOrdersView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver= popover;
        
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        CGRect temp = levelTxt.frame;
        temp.origin.y = temp.origin.y + temp.size.height/2;
        
        presentationPopOverController.sourceView = customerInfoPopUp.view;
        presentationPopOverController.sourceRect = temp;
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
    }
    
    else {
     
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [levelsTbl reloadData];
}

#pragma mark service delegates
-(void)getLoginServiceFailureResponse:(NSString *)failureString {
    
    float y_axis = self.view.frame.size.height - 120;
    [self displayAlertMessage:failureString horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
    
    [HUD setHidden:YES];
}

/**
 * @description     get all the bookings
 * @date            1/12/15
 * @method          getAllBookings
 * @author          Sonali
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By     Roja
 * @modified On     20/03/2019
 * @reason          Changed the request string as per latest GUI
 */

-(void)getAllBookings {
    
    @try {
        
        if(bookingDetails == nil && orderStartIndex == 0){
            totalOrders = 0;
//            bookingDetails = [NSMutableArray new];
        }
        
        NSString * startDateStr = startDateTF.text;
        NSString * endDateStr  = endDateTF.text;
        NSString * searchOrderStr = @"";
        NSString * firstNameStr = @"";

        if((startDateTF.text).length > 0)
            startDateStr =  [NSString stringWithFormat:@"%@%@",startDateTF.text,@" 00:00:00"];
        
        if ((endDateTF.text).length > 0) {
            endDateStr = [NSString stringWithFormat:@"%@%@",endDateTF.text,@" 00:00:00"];
        }
        if ((firstNameTF.text).length > 0) {
            firstNameStr = firstNameTF.text;
        }
        if ((lastNameTF.text).length > 0) {
            firstNameStr = lastNameTF.text; // should change this after adding the last name field..
        }
       
        if((searchOrdersText.text).length > 3)
            searchOrderStr = searchOrdersText.text;
        
        NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
        [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [orderDetails setObject:presentLocation forKey:@"storeLocation"]; //@"storeLocation"
        [orderDetails setObject:[NSString stringWithFormat:@"%d",orderStartIndex] forKey:START_INDEX]; //pending_order_no
        [orderDetails setObject:[WebServiceUtility getPropertyFromProperties:@"maxResult"] forKey:@"maxRecords"];
        [orderDetails setObject:[NSNumber numberWithBool:isRefresh] forKey:IS_REFRESH];
        // added by roja
        [orderDetails setObject:slotIdStr forKey:@"slot"];
        [orderDetails setObject:searchTxt.text forKey:@"phoneNumber"];
        [orderDetails setValue:startDateStr forKey:@"startDateStr"];
        [orderDetails setValue:endDateStr forKey:@"endDateStr"];
        [orderDetails setValue:searchOrderStr forKey:kSearchCriteria];
        [orderDetails setObject:statusStr forKey:@"status"];
        [orderDetails setObject:bookingChannelStr forKey:@"orderChannel"];
        [orderDetails setValue:firstNameStr forKey:@"firstName"];
        // need to uncomment after adding last name in new order flow...
       // [orderDetails setValue:lastNameStr forKey:@"lastName"];

        [HUD setHidden:NO];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        if (!isOfflineService) {
            
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setRestaurantBookingServiceDelegate:self];
            [controller getListOfBookings:getBookingJsonStr];
        }
        
        // Dont Delete the code..
        // commented by roja on 10/01/2019, reason Offline work need to work out.
        
        //        else {
        //
        //            RestBookingServices *service = [[RestBookingServices alloc] init];
        //            NSMutableDictionary *result = [service getBookingDetailsByFilters:orderDetails orderId:@""];
        //            if ([result count]) {
        //
        //                totalOrder.text = [[result objectForKey:@"totalRecords"] stringValue];
        //                bookingDetails = [NSMutableArray new];
        //                statusArr = [NSMutableArray new];
        //
        //                NSArray *array = [result valueForKey:kBookingsList];
        //
        //                for (NSDictionary *dic in array) {
        //                    if(![[dic valueForKey:STATUS] isKindOfClass:[NSNull class]]) {
        //                        [statusArr addObject:[dic valueForKey:STATUS]];
        //                    }
        //                    else {
        //                        [statusArr addObject:@""];
        //                    }
        //                    NSArray *objects = [NSArray arrayWithObjects:[dic valueForKey:CUSTOMER_NAME],[dic valueForKey:MOBILE_NUMBER],[dic valueForKey:ORDER_REFERENCE],[dic valueForKey:OCCASION_DESC],[dic valueForKey:SLOT_ID],[dic valueForKey:SALES_LOCATION], nil];
        //                    NSArray *keys = [NSArray arrayWithObjects:CUSTOMER_NAME,MOBILE_NUMBER,ORDER_REFERENCE,OCCASION_DESC,SLOT_ID,SALES_LOCATION, nil];
        //
        //                    [bookingDetails addObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
        //                }
        //                [HUD setHidden:YES];
        //                [pendingOrdersTbl reloadData];
        ////                [self addPaginationButtons:[totalOrder.text intValue]];
        //
        //            }
        //            else {
        //                [HUD setHidden:YES];
        //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NoBookingsAvailable", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //                [alert show];
        //                if ([bookingDetails count]) {
        //
        //                    [bookingDetails removeAllObjects];
        //                }
        //
        //                [pendingOrdersTbl reloadData];
        //
        //            }
        //        }
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
}


-(void)getAllBookingsFailure:(NSString *)failureString {
    
    [HUD setHidden:YES];
    NSString *msgStr = @"";
    if ([failureString isKindOfClass:[NSNull class]]) {
        
        msgStr = NSLocalizedString(@"Data not found", nil);
    }
    else {
        msgStr = failureString;
    }
  
    float y_axis = self.view.frame.size.height - 200;
    
    [self displayAlertMessage:msgStr horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    
    if ([bookingDetails count]) {
        
        [bookingDetails removeAllObjects];
    }
    
//    [popOver dismissPopoverAnimated:YES];
    // added by roja on 22/01/2019...
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    [pendingOrdersTbl reloadData];

}
-(void)getAllBookingsSuccess:(NSDictionary *)successDictionary {
    
    if ([successDictionary count]) {
        
        @try {
            if(![[successDictionary objectForKey:TOTAL_BILLS] isKindOfClass:[NSNull class]]) {
                if ( [[successDictionary objectForKey:TOTAL_BILLS] intValue]==0) {
               
                    float y_axis = self.view.frame.size.height - 120;
                    NSString * msg = @"Bookings not available";
                    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
                }
                else {

                    totalOrder.text = [[successDictionary objectForKey:TOTAL_BILLS] stringValue];
                    bookingDetails = [NSMutableArray new];
                    statusArr = [NSMutableArray new];
                    
                    
                    totalOrders = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"]intValue];
                    totalBookingsValueTF.text = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"] stringValue];

                    NSArray *array = [successDictionary valueForKey:ORDERS_LIST];
                    for (NSDictionary *dic in array) {
                        if(![[dic valueForKey:STATUS] isKindOfClass:[NSNull class]]) {
                            [statusArr addObject:[dic valueForKey:STATUS]];
                        }
                        else {
                            [statusArr addObject:@""];
                        }
                        
                        NSArray *objects = [NSArray arrayWithObjects:[self checkGivenValueIsNullOrNil:[dic valueForKey:CUSTOMER_NAME] defaultReturn:@""],[self checkGivenValueIsNullOrNil:[dic valueForKey:MOBILE_NUMBER] defaultReturn:@""],[self checkGivenValueIsNullOrNil:[dic valueForKey:ORDER_REFERENCE] defaultReturn:@""],[self checkGivenValueIsNullOrNil:[dic valueForKey:OCCASION_DESC] defaultReturn:@""],[self checkGivenValueIsNullOrNil:[dic valueForKey:SLOT_ID] defaultReturn:@""],[self checkGivenValueIsNullOrNil:[dic valueForKey:SALES_LOCATION] defaultReturn:@""],[self checkGivenValueIsNullOrNil:[dic valueForKey:@"reservationTypeId"] defaultReturn:@""], nil];
                        
                        NSArray *keys = [NSArray arrayWithObjects:CUSTOMER_NAME,MOBILE_NUMBER,ORDER_REFERENCE,OCCASION_DESC,SLOT_ID,SALES_LOCATION,@"reservationTypeId", nil];
                        
                        [bookingDetails addObject:[NSDictionary dictionaryWithObjects:objects forKeys:keys]];
                    }
                    [HUD setHidden:YES];
                    [pendingOrdersTbl reloadData];
                    // added by roja o 19/03/2019..
                    // Reason below line of code is written as per latest GUI..
                    [self pagenationHandler];

                    // Commented by roja on 19/03/2019..
                    // Reason below line of code is for old GUI...
//                    [self addPaginationButtons:[totalOrder.text intValue]];
                }
            }
            else {
                float y_axis = self.view.frame.size.height - 120;
                NSString * msg = @"Bookings not available";
                [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            pendingOrdersView.hidden = NO;
            pastOrdersView.hidden = YES;
            pendingHeaderView.hidden = NO;
            [pendingOrdersTbl reloadData];
            newTableOrderBtn.hidden = NO;

            [HUD setHidden:YES];
        }
    }
}


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
#pragma -mark collection view delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [tableDetails count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    @try {
        static NSString *identifier = @"Collection_cell";
        
        UICollectionViewCell *cell = [collectionView1 dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        //    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
        if ([cell.contentView subviews]){
            for (UIView *subview in [cell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if (!cell) {
            
            cell = [[UICollectionViewCell alloc] init];
        }
        
        
        tableLayout = [[UIView alloc] init];
        
        UIColor *color ;
        
        if (![[tableStatusArr objectAtIndex:indexPath.row] isKindOfClass:[NSNull class]] && [tableStatusArr objectAtIndex:indexPath.row]!=nil) {
            
        color = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:[tableStatusArr objectAtIndex:indexPath.row]]];
            

        }
        else {
               color = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:@"Vacant"]];
        }
        
        tableLayout.backgroundColor = color;
        
        
        
        // Create the colors
        UIColor *darkOp =
        [UIColor colorWithRed:82.0/255.0 green:237.0/255.0 blue:199.0/255.0 alpha:1.0];
        UIColor *lightOp =
        [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:251.0/255.0 alpha:1.0];
        
        // Create the gradient
        CAGradientLayer *gradient = [CAGradientLayer layer];
        
        // Set colors
        gradient.colors = [NSArray arrayWithObjects:
                           (id)lightOp.CGColor,
                           (id)darkOp.CGColor,
                           nil];
        
        // Set bounds
        
        // Add the gradient to the view
        //    [tableLayout.layer insertSublayer:gradient atIndex:0];
        
        
        UILabel * noOfOccupiedChairs = [[UILabel alloc] init]; //tableNoLbl
        noOfOccupiedChairs.textColor = [UIColor blackColor];
        noOfOccupiedChairs.textAlignment = NSTextAlignmentCenter;
        noOfOccupiedChairs.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        
        UILabel *noOfAvailChairs = [[UILabel alloc] init];
        noOfAvailChairs.textColor = [UIColor blackColor];
        noOfAvailChairs.textAlignment = NSTextAlignmentCenter;
        noOfAvailChairs.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];

        
        // added by roja on 05/03/2019...
        UITextField * tableNoTF = [[UITextField alloc] init];
        tableNoTF.textColor = [UIColor blackColor];
        tableNoTF.textAlignment = NSTextAlignmentCenter;
        //        tableNoTF.text = @"T12";
        tableNoTF.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        tableNoTF.backgroundColor = [UIColor clearColor];
        [tableNoTF setDelegate:self];
        tableNoTF.userInteractionEnabled = NO;
        tableNoTF.borderStyle = UITextBorderStyleRoundedRect;
        tableNoTF.layer.borderWidth = 1;
        tableNoTF.layer.borderColor = [[UIColor blackColor] CGColor];
        
        UILabel * startTimeLbl = [[UILabel alloc] init];
        startTimeLbl.textColor = [UIColor blackColor];
        startTimeLbl.textAlignment = NSTextAlignmentLeft;
        startTimeLbl.text = @"St Time:";
        startTimeLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14] ;
        
        UILabel * startTimeValueLbl = [[UILabel alloc] init];
        startTimeValueLbl.textColor = [UIColor blackColor];
        startTimeValueLbl.textAlignment = NSTextAlignmentLeft;
        startTimeValueLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        
        
        UILabel * bookingTimeLbl = [[UILabel alloc] init];
        bookingTimeLbl.textColor = [UIColor blackColor];
        bookingTimeLbl.textAlignment = NSTextAlignmentLeft;
        bookingTimeLbl.text = @"Book Time:";
        bookingTimeLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14] ;
        
        UILabel * bookingTimeValueLbl = [[UILabel alloc] init];
        bookingTimeValueLbl.textColor = [UIColor blackColor];
        bookingTimeValueLbl.textAlignment = NSTextAlignmentLeft;
        bookingTimeValueLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
        
        @try {
            if ([tableDetails count] && tableDetails!=nil) {
                
                NSDictionary * temp = [tableDetails objectAtIndex:indexPath.row];
                
                tableNoTF.text = [NSString stringWithFormat:@"%@%@",@"T", [self checkGivenValueIsNullOrNil:[temp valueForKey:TABLE_NUMBER] defaultReturn:@"0"]];
                
                noOfAvailChairs.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:kNoOfChairs] defaultReturn:@""];
                
                noOfOccupiedChairs.text = [NSString stringWithFormat:@"%d",[[self checkGivenValueIsNullOrNil:[temp valueForKey:@"noOfOccupiedSeats"] defaultReturn:@""] intValue]];//TABLE_NUMBER

                
                NSString * startDateTimeStr = [self checkGivenValueIsNullOrNil:[temp valueForKey:@"startDateTime"] defaultReturn:@""];
                
                NSString * reservedDateTimeStr = [self checkGivenValueIsNullOrNil:[temp valueForKey:@"reservationDateTime"] defaultReturn:@""]; //reservationDateTime
                
                if([startDateTimeStr isEqualToString: @""]){
                    startTimeValueLbl.text = @"-";
                }
                else{
                    startTimeValueLbl.text = [startDateTimeStr componentsSeparatedByString:@" "][1];
                }
                
                if([startDateTimeStr isEqualToString: @""]){
                    bookingTimeValueLbl.text = @"-";
                }
                else{
                    bookingTimeValueLbl.text = [reservedDateTimeStr componentsSeparatedByString:@" "][1];
                }
            }

        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
        // upto here added by roja on 05/03/2019...
        // framings...
//        tableLayout.frame = CGRectMake(5, 0, 130, 130);
        
        tableLayout.frame = CGRectMake(0, 0, 135, [[UIScreen mainScreen] bounds].size.height/4-70);//(collectionView.frame.size.width - 180)/6

        noOfOccupiedChairs.frame = CGRectMake(tableLayout.frame.size.width/2-40, tableLayout.frame.size.height/2-10, 80, 30);
        noOfAvailChairs.frame = CGRectMake(tableLayout.frame.size.width-60,20,60, 30);
        tableNoTF.frame = CGRectMake(5, 8, 45, 22);// w-65
        
        bookingTimeLbl.frame = CGRectMake(2, noOfOccupiedChairs.frame.origin.y + noOfOccupiedChairs.frame.size.height+3, 80, 20);
        bookingTimeValueLbl.frame = CGRectMake(bookingTimeLbl.frame.origin.x + bookingTimeLbl.frame.size.width, bookingTimeLbl.frame.origin.y, tableLayout.frame.size.width - (bookingTimeLbl.frame.origin.x + bookingTimeLbl.frame.size.width), bookingTimeLbl.frame.size.height);

        
        startTimeLbl.frame = CGRectMake(2, tableLayout.frame.size.height - 20, 58, 20);//55
        startTimeValueLbl.frame = CGRectMake(startTimeLbl.frame.origin.x + startTimeLbl.frame.size.width, startTimeLbl.frame.origin.y, tableLayout.frame.size.width - (startTimeLbl.frame.origin.x + startTimeLbl.frame.size.width), startTimeLbl.frame.size.height);
        
//        startTimeLbl.frame = CGRectMake(5, tableLayout.frame.size.height - 30, 55, 20);
//        startTimeValueLbl.frame = CGRectMake(startTimeLbl.frame.origin.x + startTimeLbl.frame.size.width, startTimeLbl.frame.origin.y, tableLayout.frame.size.width - (startTimeLbl.frame.origin.x + startTimeLbl.frame.size.width), startTimeLbl.frame.size.height);
//
        gradient.frame = tableLayout.bounds;
        tableLayout.layer.cornerRadius = 10.0f;
        
       
        [tableLayout addSubview:tableNoTF];
        [tableLayout addSubview:noOfOccupiedChairs];
        [tableLayout addSubview:noOfAvailChairs];
        [tableLayout addSubview:startTimeLbl];
        [tableLayout addSubview:startTimeValueLbl];
        [tableLayout addSubview:startTimeLbl];
        [tableLayout addSubview:bookingTimeLbl];
        [tableLayout addSubview:bookingTimeValueLbl];

        [cell.contentView addSubview:tableLayout];
//        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;

    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
   
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize s;
    
        // commented by roja o 06/03/2019..

//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
    
//    s = CGSizeMake((collectionView.frame.size.width-35)/6, [[UIScreen mainScreen] bounds].size.height/4-70);
    
    s = CGSizeMake(130, [[UIScreen mainScreen] bounds].size.height/4-70);

//        }
//        else {
//            s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/4 - 130, [[UIScreen mainScreen] bounds].size.height/4-150);
//        }
//    }
//    else {
//        if (version >=8.0) {
//            s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/5 - 50, [[UIScreen mainScreen] bounds].size.height/4-100);
//
//
//        }
//        else {
//            s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/4 - 50, [[UIScreen mainScreen] bounds].size.height/4-50);
//        }
//    }
    // Upto here commented by roja o 06/03/2019..
    
    return s;
    
}

// 3
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
//    float collectionViewWidth = (collectionView.frame.size.width);
//
//    float cellWidth = 100;
//    float noOfCellsPerRow = 6;
//    float totalCellWidth = cellWidth * noOfCellsPerRow;
//    float cellToCellSpacing = 10;
//    float totalCellsSpacing = cellToCellSpacing * (noOfCellsPerRow -1);
//
//    NSLog(@"cellWidthFraming -----%f",(collectionViewWidth - (totalCellWidth + totalCellsSpacing))/2);
//
//    NSInteger leftInset = (collectionViewWidth - (totalCellWidth + totalCellsSpacing))/2;
//
//    NSInteger rightInset = leftInset;
    
    return UIEdgeInsetsMake(5, 5, 5, 0);//(t,l,b,r)
//    return UIEdgeInsetsMake(0, leftInset, 0, rightInset);//(t,l,b,r)

}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 3;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)
indexPath
{
    @try {
        
        selectedCollectionCell = (int)indexPath.row;
        
        if ([[tableStatusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"vacant"]!=NSOrderedSame) {
            
            @try {
                NSDictionary *details = [NSDictionary new];
                
                // commented by roja on 10/01/2019
                // reason Offline work need to be done...
//                if (isOfflineService) {
//                    RestBookingServices *service = [[RestBookingServices alloc] init];
//                    details = [service getTableInfoOf:[[tableDetails objectAtIndex:indexPath.row]valueForKey:TABLE_NUMBER]];
//                }
                
                 if(![[[tableDetails objectAtIndex:indexPath.row] valueForKey:ORDER]  isKindOfClass:[NSNull class]] && [[tableDetails objectAtIndex:indexPath.row] valueForKey:ORDER]!=nil){
                    
                    details = [[[tableDetails objectAtIndex:indexPath.row] valueForKey:ORDER] copy];
                }
                
                if ([details count]) {
                    
                    [self populateCustomerInfoPopUp:details];
                }
            }
            @catch (NSException *exception) {
                
            }
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma -mark end of collection view methods

/**
 * @description   select the start date
 * @date          10/11/15
 * @method        selectSlotBtnAction
 * @author        Sonali
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
    // name changed by roja on 22/01/2019...

- (void)selectSlotBtnAction:(UIButton *)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);

    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    float tableHt = 0;
    if([slotIdsArr count] && [slotIdsArr count] <= 5) {
        tableHt = [slotIdsArr count] * 40;
    }
    else if([slotIdsArr count] && [slotIdsArr count] > 5){
        tableHt = 5 * 40;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHt)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    slotIdsTbl = [[UITableView alloc] init];
    slotIdsTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [slotIdsTbl setDataSource:self];
    [slotIdsTbl setDelegate:self];
    [slotIdsTbl.layer setBorderWidth:1.0f];
    slotIdsTbl.layer.cornerRadius = 3;
    slotIdsTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        slotIdsTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
    }
    
    [customView addSubview:slotIdsTbl];
    
    customerInfoPopUp.view = customView;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:startDate.frame inView:pendingOrdersView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver= popover;
        
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        
//        CGRect temp = slotTextField.frame;
//        temp.origin.y = (pendingOrdersView.frame.origin.y) + temp.origin.y;
        
        presentationPopOverController.sourceView = pendingOrdersView;
        presentationPopOverController.sourceRect = slotTextField.frame;
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
    }
    
    else {
      
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [slotIdsTbl reloadData];
    
    
}
-(IBAction)getStartDate:(id)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Date Formate Setting...
    
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    [sdayFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    dateString = [sdayFormat stringFromDate:myPicker.date];
    
    NSDateFormatter *compDateFormat = [[NSDateFormatter alloc] init];
    [compDateFormat setDateFormat:@"dd/MM/yyyy"];
    
    slotTextField.text = dateString;
    
//    [catPopOver dismissPopoverAnimated:YES];
    // added by roja on 22/01/2019...
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    //    NSDate *selectedDate = [compDateFormat dateFromString:dateString];
    //    NSDate *currentDate = [compDateFormat dateFromString:[compDateFormat stringFromDate:[NSDate date]]];
    //
    //    if ([currentDate compare:selectedDate] == NSOrderedAscending) {
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select proper date" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //        startDate.text = @"";
    //    }
    //
    
}
/**
 * @description selectEndDate
 * @date       10/11/15
 * @method     selectEndDate
 * @author    Sonali
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (IBAction)selectEndDate:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([slotTextField.text length]==0) {
        
        float y_axis = self.view.frame.size.height - 120;
        NSString * msg = NSLocalizedString(@"enter_start_date", nil);
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
        return;
    }
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    
    selectSlotBtn.tag = 1;
    
    pickView = [[UIView alloc] init];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(endDate.frame.origin.x, endDate.frame.origin.y+endDate.frame.size.height, 320, 320);
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
    [myPicker setBackgroundColor:[UIColor whiteColor]];
    
    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
    pickButton.frame = CGRectMake(85, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getEndDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    //pickButton.layer.masksToBounds = YES;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    
    
    customerInfoPopUp.view = customView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:endDate.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        catPopOver= popover;
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        categoryPopOverController = [customerInfoPopUp popoverPresentationController];
        categoryPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        CGRect temp = endDate.frame;
        temp.origin.y = temp.origin.y + temp.size.height/2;
        
        categoryPopOverController.sourceView = customerInfoPopUp.view;
        categoryPopOverController.sourceRect = temp;
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
        
    }
    
    else {
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
  
}


-(IBAction)getEndDate:(id)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Date Formate Setting...
    
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    [sdayFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    dateString = [sdayFormat stringFromDate:myPicker.date];
    
    NSDateFormatter *compDateFormat = [[NSDateFormatter alloc] init];
    [compDateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [compDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    
    endDate.text = dateString;
    
//    [catPopOver dismissPopoverAnimated:YES];
    
    // added by roja on 22/01/2019...
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    NSDate *startDateDat = [compDateFormat dateFromString:slotTextField.text];
    NSDate *endDateDat = [compDateFormat dateFromString:dateString];
    //
    //
    if ([endDateDat compare:startDateDat]==NSOrderedAscending) {
       
        float y_axis = self.view.frame.size.height - 120;
        NSString * msg = @"End date cannot be earlier than start date";
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:70  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        endDate.text = @"";
    }
    //
    
}

- (void) gobuttonPressed:(id) sender {
    AudioServicesPlaySystemSound (soundFileObject);
    //    if ([startDate.text length] ==0 || [endDate.text length]==0) {
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"provide_startdate_enddate", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
    //        [alert show];
    //    }
    //    else {
    [self getAllBookings];
    //    }
    
}

#pragma - mark adding pagination methods
/**
 * @description  adding pagination buttons based on the totalRecords
 * @date         17/11/15
 * @method       addPaginationButtons
 * @author       Chandhu
 * @param        totalRecords
 * @param
 * @modified By  Sonali
 * @modified On  28/12/15
 * @return
 * @verified By
 * @verified On
 */
- (void)addPaginationButtons:(int)totalRecords {
    
    for (UIView *btn in pendingOrdersView.subviews) {
        if ([btn isKindOfClass:[UIButton class]] && btn.tag!=100) {
            [btn removeFromSuperview];
        }
    }
    
    float btnXposition;
    
     btnXposition = 250.0;
    int totalPages = [WebServiceUtility getTotalNumberOfPages:totalRecords];
    if (totalPages<5) {
        btnXposition = 400.0;
    }

    int presentPages;
//    if (pending_order_no==0) {
         presentPages = [WebServiceUtility getTotalNumberOfPages:messageStartIndex];

//    }
//    else {
//         presentPages = [WebServiceUtility getTotalNumberOfPages:pending_order_no-1];
//
//    }
  
    if (presentPages > 0) {
        UIButton *paginationButton = [[UIButton alloc] init];
        
        [paginationButton setBackgroundImage:[UIImage imageNamed:@"Button1.png"] forState:UIControlStateNormal] ;
        
        paginationButton.backgroundColor = [UIColor clearColor];
        [paginationButton setFrame:CGRectMake(btnXposition, self.view.frame.size.height-180, 50.0, 50.0)];
        paginationButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        [paginationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        paginationButton.layer.cornerRadius = paginationButton.frame.size.height/2.0;
        [paginationButton addTarget:self action:@selector(showNextMessages:) forControlEvents:UIControlEventTouchUpInside];
        [paginationButton setEnabled:TRUE];
        paginationButton.tag = -2;
        [paginationButton setTitle:@"<<" forState:UIControlStateNormal];
        [pendingOrdersView addSubview:paginationButton];
        btnXposition = btnXposition + 80.0;
    }
    for (int i = 0; i < totalPages - presentPages; i++) {
        
        UIButton *paginationButton = [[UIButton alloc] init];
        
        [paginationButton setBackgroundImage:[UIImage imageNamed:@"Button1.png"] forState:UIControlStateNormal] ;
        
        paginationButton.backgroundColor = [UIColor clearColor];
        [paginationButton setTitle:[NSString stringWithFormat:@"%d",buttonTitleIndex + 1] forState:UIControlStateNormal];
        [paginationButton setFrame:CGRectMake(btnXposition,self.view.frame.size.height-180, 50.0, 50.0)];
        paginationButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        [paginationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        paginationButton.layer.cornerRadius = paginationButton.frame.size.height/2.0;
        [paginationButton addTarget:self action:@selector(showNextMessages:) forControlEvents:UIControlEventTouchUpInside];
        [paginationButton setEnabled:TRUE];
        if (i >= BUTTONS_PER_PAGE) {
            paginationButton.tag = -1;
            [paginationButton setTitle:@">>" forState:UIControlStateNormal];
            [pendingOrdersView addSubview:paginationButton];
            break;
        }
        paginationButton.tag = i;
        
        [pendingOrdersView addSubview:paginationButton];
        buttonTitleIndex++;
        btnXposition = btnXposition + 80.0;
    }
    
}

/**
 * @description  getting the next page messages and displaying in table
 * @date         17/11/15
 * @method       showNextMessages
 * @author       Chandhu
 * @param        UIButton(sender)
 * @param
 * @return
 * @verified By
 * @verified On
 */
- (void) showNextMessages :(UIButton *) sender {
    [sender setSelected:YES];
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender.tag == -1) {
        pageIndex++;
        buttonIndex++;
        buttonTitleIndex = buttonIndex * 5;
        messageStartIndex = pageIndex * kRecordsPerPage;
        pending_order_no = (buttonTitleIndex*kRecordsPerPage);
        [self getAllBookings];
//        [self getMessageDetails];
    }
    else if (sender.tag == -2) {
        pageIndex--;
        buttonIndex--;
        buttonTitleIndex = buttonIndex * 5;
        messageStartIndex = pageIndex * kRecordsPerPage;
        pending_order_no = messageStartIndex;
        [self getAllBookings];
//        [self getMessageDetails];
    }
    else {
        
        if ([sender.titleLabel.text intValue]==1) {
            pending_order_no = 0;
            buttonTitleIndex = 0;
            [self getAllBookings];
        }
        else {
            pending_order_no = (sender.tag*kRecordsPerPage);
            buttonTitleIndex = 0;
            [self getAllBookings];
        }
       
        
        //        messagesPerPageArr = [WebServiceUtility getMessagesFromPositon:(int)sender.tag fromArray:messageDetailsArr];
        //        [messageTable reloadData];
    }
}


#pragma -mark layout delegates

- (IBAction)changeStatus:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    BookingWorkFlow *workFlow = [[BookingWorkFlow alloc] init];
    workFlow.orderRef = [[bookingDetails objectAtIndex:sender.tag] valueForKey:ORDER_REFERENCE];
    [self.navigationController pushViewController:workFlow animated:YES];
}

#pragma -mark getLevels service delegates
-(void)getOutletLevelsSuccessResponse:(NSDictionary *)successDictionary {
   
    @try {
     
        levelsArr = [[NSMutableArray alloc] init];
        levelsArr = [[successDictionary valueForKey:kAvailableLevels] copy];
        if ([levelsArr count]) {
            
            pending_order_no = 0;

            totalOrder_takeaway.text = [[successDictionary objectForKey:@"totalRecords"] stringValue];
            orderStart_takeaway.text = [NSString stringWithFormat:@"%d",past_order_no+1];
            
            [self populateTableView:[levelsArr objectAtIndex:0]];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
    }
    
}
-(void)getOutletLevelsFailureResponse:(NSString *)failureString {
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        NSString *mesg = failureString;
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }

    
}


-(void)changeTime {
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
    NSString* currentdate = [f stringFromDate:today];
    
    todayLbl.text = currentdate;
}

#pragma -mark service delegates
-(void)getPhoneNosSuccess:(NSDictionary *)successDictionary {
    @try {
        NSArray *array = [successDictionary valueForKey:@"tableBookings"];
        
        mobileNosArr = [NSMutableArray new];
        for (NSDictionary *dic in array) {
            
            [mobileNosArr addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[dic valueForKey:MOBILE_NUMBER],[dic valueForKey:ORDER_REFERENCE], nil] forKeys:[NSArray arrayWithObjects:MOBILE_NUMBER,ORDER_REFERENCE,nil]]];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [self populateCustomerMobileNumbersList];
        [mobilesTbl reloadData];
    }
}


-(void)populateCustomerMobileNumbersList{
    
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    float tableHeight=0.0;
    
    if([mobileNosArr count] < 5){
        
        tableHeight = [mobileNosArr count] * 40;
    }
    else{
        tableHeight = 5 * 40;
    }
    
    // UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, 250)];
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, searchTxt.frame.size.width, tableHeight)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    mobilesTbl = [[UITableView alloc] init];
    mobilesTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [mobilesTbl setDataSource:self];
    [mobilesTbl setDelegate:self];
    [mobilesTbl.layer setBorderWidth:1.0f];
    mobilesTbl.layer.cornerRadius = 3;
    mobilesTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        mobilesTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
    }
    
    [customView addSubview:mobilesTbl];
    customerInfoPopUp.view = customView;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:searchTxt.frame inView:pendingOrdersView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver= popover;
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
//        CGRect temp = searchTxt.frame;
//        temp.origin.y = temp.origin.y + temp.size.height/2;
        presentationPopOverController.sourceView = pendingOrdersView;
        presentationPopOverController.sourceRect = searchTxt.frame;
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

-(void)getPhoneNosFailure:(NSString *)failureString {
    
    [HUD setHidden:YES];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:failureString message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
    
}

-(void)refreshBookings:(id)sender {
    
    if (!isOfflineService) {
        refreshAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirmation for reload", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil), nil];
        [refreshAlert show];

    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Feature not available", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
#pragma -mark alertview delegates
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex1 {
    if (alertView == refreshAlert) {
        if (buttonIndex1 ==0) {
            pending_order_no = 0;
            
            buttonTitleIndex = 0;
            messageStartIndex = 0;
            buttonIndex = 0;
            pageIndex = 0;
            isRefresh = YES;
            [HUD setHidden:NO];
            [self getAllBookings];

        }
        else {
            [alertView dismissWithClickedButtonIndex:YES animated:YES];
        }
    }
}

/**
 * @discussion Add popup showing the customer info
 * @date   16/10/15
 * @method populateCustomerInfoPopUp
 * @author Sonali
 * @param customer information of type NSDictionary
 */

-(void)populateCustomerInfoPopUp:(NSDictionary*)custInfo {
    
    AudioServicesPlaySystemSound (soundFileObject);

    @try {
        NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:selectedCollectionCell inSection:0];
        selectedCell = [collectionView cellForItemAtIndexPath:selectedRow];
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 350, 200)];
        customerView.opaque = NO;
        customerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customerView.layer.borderWidth = 2.0f;
        [customerView setHidden:NO];
        
        UILabel *custType = [[UILabel alloc] init];
        custType.textColor = [UIColor blackColor];
        custType.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        custType.text  = @"Customer Type";
        
        UILabel *custTypeVal = [[UILabel alloc] init];
        custTypeVal.textColor = [UIColor blackColor];
        custTypeVal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        if (![custInfo objectForKey:@"category"]&&[[custInfo objectForKey:@"category"] length] > 0) {
            custTypeVal.text  = [custInfo objectForKey:@"category"];
        }
        else {
            custTypeVal.text  = @"--";
            
        }
        
        
        UILabel *customerName = [[UILabel alloc] init];
        customerName.textColor = [UIColor blackColor];
        customerName.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        customerName.text  = @"Customer Name";
        
        UILabel *custNameVal = [[UILabel alloc] init];
        custNameVal.textColor = [UIColor blackColor];
        custNameVal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        if ([custInfo objectForKey:CUSTOMER_NAME]!=nil && [[custInfo objectForKey:CUSTOMER_NAME] length] > 0) {
            custNameVal.text  = [custInfo objectForKey:CUSTOMER_NAME];
        }
        else {
            custNameVal.text  = @"--";
            
        }
        
        
        UILabel *custPhoneLbl = [[UILabel alloc] init];
        custPhoneLbl.textColor = [UIColor blackColor];
        custPhoneLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        custPhoneLbl.text  = @"Customer Phone";
        
        UILabel *custPhoneVal = [[UILabel alloc] init];
        custPhoneVal.textColor = [UIColor blackColor];
        custPhoneVal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        if ([[custInfo objectForKey:MOBILE_NUMBER] length] > 0) {
            custPhoneVal.text  = [custInfo objectForKey:MOBILE_NUMBER];
        }
        else {
            custPhoneVal.text  = @"--";
            
        }
        
        UILabel *custEmailLbl = [[UILabel alloc] init];
        custEmailLbl.textColor = [UIColor blackColor];
        custEmailLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        custEmailLbl.text  = @"Customer Email";
        
        UILabel *custEmailVal = [[UILabel alloc] init];
        custEmailVal.textColor = [UIColor blackColor];
        custEmailVal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        custEmailVal.lineBreakMode = NSLineBreakByWordWrapping;
        custEmailVal.numberOfLines = 0;
        if ([[custInfo objectForKey:CUSTOMER_MAIL] length] > 0) {
            custEmailVal.text  = [custInfo objectForKey:CUSTOMER_MAIL];
        }
        else {
            custEmailVal.text   = @"--";
            
        }
        
        
        UILabel *adults = [[UILabel alloc] init];
        adults.textColor = [UIColor blackColor];
        adults.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        adults.text  = @"Adults";
        
        UILabel *adultsVal = [[UILabel alloc] init];
        adultsVal.textColor = [UIColor blackColor];
        adultsVal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        if ([[custInfo objectForKey:ADULT_PAX] integerValue] > 0) {
            adultsVal.text  = [[custInfo objectForKey:ADULT_PAX] stringValue];
        }
        else {
            adultsVal.text    = @"--";
            
        }
        
        UILabel *childCount = [[UILabel alloc] init];
        childCount.textColor = [UIColor blackColor];
        childCount.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        childCount.text  = @"Childrens";
        
        UILabel *childCountVal = [[UILabel alloc] init];
        childCountVal.textColor = [UIColor blackColor];
        childCountVal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        if ([[custInfo objectForKey:CHILD_PAX] integerValue] > 0) {
            childCountVal.text  = [[custInfo objectForKey:CHILD_PAX] stringValue];
        }
        else {
            childCountVal.text    = @"--";
            
        }
        
        UILabel *city = [[UILabel alloc] init];
        city.textColor = [UIColor blackColor];
        city.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        city.text  = @"City";
        
        UILabel *cityVal = [[UILabel alloc] init];
        cityVal.textColor = [UIColor blackColor];
        cityVal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        if ([[custInfo objectForKey:@"city"] length] > 0) {
            cityVal.text  = [custInfo objectForKey:@"city"];
        }
        else {
            cityVal.text    = @"--";
            
        }
        
        UILabel *pin = [[UILabel alloc] init];
        pin.textColor = [UIColor blackColor];
        pin.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        pin.text  = @"Pin No";
        
        UILabel *pinVal = [[UILabel alloc] init];
        pinVal.textColor = [UIColor blackColor];
        pinVal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        if ([[custInfo objectForKey:@"pin_no"] length] > 0) {
            pinVal.text  = [custInfo objectForKey:@"pin_no"];
        }
        else {
            pinVal.text   =  @"--";
            
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
                
                custType.frame =  CGRectMake(10, 5, 150, 30);
                custTypeVal.frame =  CGRectMake(230, 5, 200, 30);
                
                customerName.frame =  CGRectMake(10, 5, 150, 30);
                custNameVal.frame =  CGRectMake(170, 5, 150, 30);
                custPhoneLbl.frame =  CGRectMake(10, 30, 150, 30);
                custPhoneVal.frame =  CGRectMake(170, 30, 200, 30);
                custEmailLbl.frame =  CGRectMake(10, 55, 150, 30);
                custEmailVal.frame =  CGRectMake(170, 55, 400, 30);
                
                adults.frame =  CGRectMake(10, 80, 150, 30);
                adultsVal.frame =  CGRectMake(170, 80, 200, 30);
                childCount.frame =  CGRectMake(10, 105, 120, 30);
                childCountVal.frame =  CGRectMake(170, 105, 200, 30);
                city.frame =  CGRectMake(10, 215, 150, 30);
                cityVal.frame =  CGRectMake(230, 215, 400, 30);
                
                pin.frame =  CGRectMake(10, 250, 170, 30);
                pinVal.frame =  CGRectMake(230, 250, 400, 30);
            }
        }
        
//        [customerView addSubview:custType];
//        [customerView addSubview:custTypeVal];
        [customerView addSubview:customerName];
        [customerView addSubview:custNameVal];
        [customerView addSubview:custPhoneLbl];
        [customerView addSubview:custPhoneVal];
        [customerView addSubview:custEmailLbl];
        [customerView addSubview:custEmailVal];
        [customerView addSubview:adults];
        [customerView addSubview:adultsVal];
        [customerView addSubview:childCount];
        [customerView addSubview:childCountVal];
//        [customerView addSubview:city];
//        [customerView addSubview:cityVal];
//        [customerView addSubview:pin];
//        [customerView addSubview:pinVal];
        
        customerInfoPopUp.view = customerView;
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customerView.frame.size.width, customerView.frame.size.height);
//
//            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//            [popover presentPopoverFromRect:tableLayout.frame inView:selectedCell permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//            popover= popover;
            
            // added by roja on 22/01/2019...
            customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
            
            presentationPopOverController = [customerInfoPopUp popoverPresentationController];
            presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
            
            CGRect temp = searchTxt.frame;
            temp.origin.y = temp.origin.y + temp.size.height/2;
            
            presentationPopOverController.sourceView = customerInfoPopUp.view;
            presentationPopOverController.sourceRect = temp;
            [self presentViewController:customerInfoPopUp animated:YES completion:nil];
            // upto here added by roja on 22/01/2019...
            
        }
        
        else {
          
        }
        
        UIGraphicsBeginImageContext(customerView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customerView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customerView.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
  
}


/**
 * @description  Navigating to the New Order Page to create the Orders...
 * @date         23/02/2019
 * @method       newOrder;
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By
 * @reason
 */

-(void)newOrder:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        NewRestBooking * controller = [[NewRestBooking alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  Navigating to Booking View Page to show the details of order...
 * @date         23/02/2019
 * @method       newOrder;
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By
 * @reason
 */

-(void)navigateToBookingsView:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
   
        if(bookingDetails.count > sender.tag) {
            
            BookingWorkFlow * bookingWorkFlowObj  = [[BookingWorkFlow alloc] init];
            bookingWorkFlowObj.orderRef = [[bookingDetails objectAtIndex:sender.tag] valueForKey:ORDER_REFERENCE];
            [self.navigationController pushViewController:bookingWorkFlowObj animated:YES];
        }
       
    } @catch (NSException * exception) {
        
    }
}


/**
 * @description  Navigating to Booking View Page to show the details of order...
 * @date         23/02/2019
 * @method       openBookingDetailsView
 * @author       Roja
 * @param        id
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By
 * @reason
 */

- (IBAction)openBookingDetailsView:(id)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if(bookingDetails.count > [sender tag]) {
            
            BookingWorkFlow * bookingWorkFlowObj  = [[BookingWorkFlow alloc] init];
            bookingWorkFlowObj.orderRef = [[bookingDetails objectAtIndex:[sender tag]] valueForKey:ORDER_REFERENCE];
            [self.navigationController pushViewController:bookingWorkFlowObj animated:YES];
        }
        
    } @catch (NSException * exception) {
        
    }
    
}

/**
 * @description  here we are sending the Request through searchTheProducts to filter the Records .......
 * @date         20/03/2019
 * @method       searchBookingDetailsAction
 * @author       Roja
 * @param        UIButton
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)searchBookingDetailsAction:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {

        if ((searchTxt.text).length == 0 && (firstNameTF.text).length == 0 && (lastNameTF.text).length == 0 && (startDateTF.text).length== 0 && (endDateTF.text).length == 0 && (slotTextField.text).length== 0  && (statusTF.text).length == 0 && (bookingChannelTF.text).length == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_above_fields_before_proceeding",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        else{
            [HUD setHidden:NO];
            orderStartIndex = 0;
            [self getAllBookings];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  Clearing the All Data in  searchTheProducts to get All The Records...
 * @date         20/03/2019
 * @method       clearAllFilterInSearch
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)clearAllFilterInSearch:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        searchTxt.text = @"";
        slotTextField.text   = @"";
        firstNameTF.text    = @"";
        lastNameTF.text = @"";
        startDateTF.text   = @"";
        endDateTF.text = @"";
        statusTF.text = @"";
        bookingChannelTF.text = @"";
        slotIdStr = @"";
        orderStartIndex = 0;
        statusStr = @"";
        bookingChannelStr = @"";
        [self getAllBookings];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description
 * @date         20/03/2019
 * @method       showPaginationData
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showPaginationData:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [HUD setHidden:YES];
        
        if(pagenationArray.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        float tableHeight = pagenationArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArray.count * 33;
        
        if(pagenationArray.count> 5)
            tableHeight = (tableHeight/pagenationArray.count) * 5;
        
        [self showPopUpForTables:pagenationTable  popUpWidth:pagenationText.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationText  showViewIn:pendingOrdersView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         15/03/2017
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
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height > height) ){
            catPopOver.popoverContentSize =  CGSizeMake(width, height);
            
            //catPopOver.contentViewController.preferredContentSize = CGSizeMake(width, height);
            //CGRectMake( tableName.frame.origin.x, tableName.frame.origin.x, tableName.frame.size.width, tableName.frame.size.height);
            
            //if (tableName.frame.size.height < height)
            //tableName.frame = CGRectMake( tableName.frame.origin.x, tableName.frame.origin.x, tableName.frame.size.width, tableName.frame.size.height);
            
            [tableName reloadData];
            return;
            
        }
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        
        
        UITextView * textView = displayFrame;
        
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
 * @description  Handling the Response for pagenation.....
 * @date         20/03/2019..
 * @method       pagenationHandler
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */
-(void)pagenationHandler {
    
    @try {
        
        int strTotalRecords = totalOrders/10; // gives Quotient before point
        
        int remainder = totalOrders % 10;
        
        if(remainder == 0) {
            strTotalRecords = strTotalRecords;
        }
        
        else {
            strTotalRecords = strTotalRecords + 1;
        }
        
        pagenationArray = [NSMutableArray new]; 
        
        if(strTotalRecords < 1){
            
            [pagenationArray addObject:@"1"];
        }
        else {
            
            for(int i = 1;i<= strTotalRecords; i++) {
                
                [pagenationArray addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        if(orderStartIndex == 0) {
            pagenationText.text = @"1";
        }
    }
}

/**
 * @description  here we are navigation from current page to ViewBookings.......
 * @date         20/03/2019
 * @method       goButtonPressesd:
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @modified BY
 * @reason
 
 * @return
 * @return
 * @verified By
 * @verified On
 
 */

-(void)goButtonPressesd:(UIButton *)sender {
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self getAllBookings];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
    }
}


#pragma mark methods used to disaply calendar and populate data into textfields....

/**
 * @description  here we are showing the calender in popUp view....
 * @date         20/09/2019
 * @method       showCalenderInPopUp:
 * @author       Roja
 * @param        UIButton
 * @param
 *
 * @return       void
 *
 * @modified BY
 * @reason
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
            
            pickView.frame = CGRectMake( 15, startDateTF.frame.origin.y + startDateTF.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:startDateTF.frame inView:pendingOrdersView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTF.frame inView:pendingOrdersView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @description  Populating dates into textFields Based On the user Selection....
 * @date         20/03/2019...
 * @method       populateDateToTextField:
 * @author       Roja
 * @param        UIButton
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
        //[requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        // getting present date & time ..
        NSDate * today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        //[f release];
        today = [f dateFromString:currentdate];
        
        if( [today compare:selectedDateString] == NSOrderedAscending ){
            
            [self displayAlertMessage:NSLocalizedString(@"ordered_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
        }
        
        NSDate *existingDateString;
        
        if( sender.tag == 2){
            if ((endDateTF.text).length != 0 && ( ![endDateTF.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTF.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 390)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            startDateTF.text = dateString;
        }
        else{
            
            if ((startDateTF.text).length != 0 && ( ![startDateTF.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTF.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 390)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            endDateTF.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  clearing the date from textField and calling services.......
 * @date         21/03/2018
 * @method       clearDate:
 * @author       Roja
 * @param        UIButton
 * @verified By
 * @verified On
 *
 */

-(void)clearDate:(UIButton *)sender{
    
    @try {
        //Dismissing the pop over....
        [catPopOver dismissPopoverAnimated:YES];
        
        if(sender.tag == 2){
            if((startDateTF.text).length)
                
                startDateTF.text = @"";
        }
        else{
            if((endDateTF.text).length)
                
                endDateTF.text = @"";
        }
        
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}



#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         20/03/2019
 * @method       displayAlertMessage
 * @author       Roja
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

-(void)displayAlertMessage:(NSString *)message horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType conentWidth:(float)labelWidth contentHeight:(float)labelHeight isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay noOfLines:(int)noOfLines {
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
        }
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        userAlertMessageLbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
            if(searchOrdersText.isEditing)
                yPosition = searchOrdersText.frame.origin.y + searchOrdersText.frame.size.height;
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
 * @date         20/03/2019
 * @method       removeAlertMessages
 * @author       Roja
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
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
    }
}


/**
 * @description  Pop up for selected Status button
 * @date         20/03/2019
 * @method       selectStatusBtnAction
 * @author       Roja
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
-(void)selectStatusBtnAction:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    float tableHt = 0;
    if([statusPopUpArr count] && [statusPopUpArr count] <= 5) {
        tableHt = [statusPopUpArr count] * 40;
    }
    else if([statusPopUpArr count] && [statusPopUpArr count] > 5){
        tableHt = 5 * 40;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHt)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        statusDropDownTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
    }
    
    [customView addSubview:statusDropDownTbl];
    
    customerInfoPopUp.view = customView;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        //        CGRect temp = statusTF.frame;
        //        temp.origin.y = (pendingOrdersView.frame.origin.y) + temp.origin.y;
        presentationPopOverController.sourceView = pendingOrdersView;
        presentationPopOverController.sourceRect = statusTF.frame;
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
    }
    
    else {
        
    }
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [statusDropDownTbl reloadData];
}



/**
 * @description  Pop up for selected Booking channel button
 * @date         20/03/2019
 * @method       selectBookingChannelBtnAction
 * @author       Roja
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
-(void)selectBookingChannelBtnAction:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    float tableHt = 0;
    
    if([bookingChannelPopUpArr count] && [bookingChannelPopUpArr count] <= 5) {
        tableHt = [bookingChannelPopUpArr count] * 40;
    }
    else if([bookingChannelPopUpArr count] && [bookingChannelPopUpArr count] > 5){
        tableHt = 5 * 40;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHt)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        bookingChannelDropDownTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
    }
    
    [customView addSubview:bookingChannelDropDownTbl];
    
    customerInfoPopUp.view = customView;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        //        CGRect temp = statusTF.frame;
        //        temp.origin.y = (pendingOrdersView.frame.origin.y) + temp.origin.y;
        presentationPopOverController.sourceView = pendingOrdersView;
        presentationPopOverController.sourceRect = bookingChannelTF.frame;
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
    }
    
    else {
        
    }
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [bookingChannelDropDownTbl reloadData];
}

/**
 * @description  Here we are calling work flow service...
 * @date         22/03/2019
 * @method       callingWorkFlowStatusDetails
 * @author       Roja
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
-(void)callingWorkFlowStatusDetails{
    
    @try {
        [HUD setHidden:NO];
        [HUD setLabelText:@"please wait.."];
        
        NSArray *keys = [NSArray arrayWithObjects:REQUEST_HEADER,@"businessFlow",@"startIndex",@"serialNum",@"inventoryFlag",@"actionFlag", nil];
        
        NSArray *objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader], @"Booking",@"-1",ZERO_CONSTANT,ZERO_CONSTANT,ZERO_CONSTANT, nil];
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err];
        NSString * getWorkFlowStatusStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *controller = [[WebServiceController alloc] init];
        [controller setRolesServiceDelegate:self];
        [controller getWorkFlows:getWorkFlowStatusStr];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
    }
}

/**
 * @description  Here we are handling work flow service success response..
 * @date         22/03/2019
 * @method       getWorkFlowsSuccessResponse
 * @author       Roja
 * @param        NSDictionary
 * @param
 * @return       void
 * @verified By
 * @verified On
 */
-(void)getWorkFlowsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        statusPopUpArr = [[NSMutableArray alloc]init];
        
        if ([successDictionary valueForKey:@"workFlowList"]) {
            
            [statusPopUpArr addObject:@"All"];
            
            for (NSDictionary *workFlowDic in [successDictionary valueForKey:@"workFlowList"]) {
                
                [statusPopUpArr addObject:[workFlowDic valueForKey:@"statusName"]];
            }
        }
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  Here we are handling work flow service error response..
 * @date         22/03/2019
 * @method       gerWorkFlowsErrorResponse
 * @author       Roja
 * @param        NSString
 * @param
 * @return       void
 * @verified By
 * @verified On
 */
-(void)gerWorkFlowsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        float y_axis = self.view.frame.size.height - 200;
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


@end
