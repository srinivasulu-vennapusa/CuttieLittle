//
//  BookingWorkFlow.m
//  OmniRetailer
//
//  Created by MACPC on 12/4/15.
//
//

#import "BookingWorkFlow.h"


@interface BookingWorkFlow ()

@end

@implementation BookingWorkFlow


@synthesize segment,scollView,custNameTxt,phoneTxt,roomNoTxt,selectRoomBtn;
@synthesize statusTable;    
@synthesize soundFileObject,soundFileURLRef;
@synthesize billBtn,editBookingBtn,printBtn,cancelBtn,orderRef,scrollView,lastNameLbl;
@synthesize radioBtn1,radioBtn2,occasionTxt,lastNameTF;
@synthesize isDirectTableBooking;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _specialInstructionsTxtView.layer.cornerRadius = 10.0f;
    
    isVeg = FALSE;
    isDrinkReq = FALSE;
    
    currentOrientation = [UIDevice currentDevice].orientation;
    
    self.titleLabel.text = [@"Booking Details" capitalizedString];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:18.0 cornerRadius:8.0];
    
    
    custNameTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    phoneTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    roomNoTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.mobileNo.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.slotId.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.reservationModeTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.noOfCustTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.reservationStatusTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.custName.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    occasionTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.noOfAdultsTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.noOfChildsTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.specialInstrTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    self.customerEmailTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _bookingIdTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _vehicleNo.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _genderTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _reservationDate.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _vegCountTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _nonvegCountTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _alcoholCountTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _nonAlcoholCountTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _childrenVegCount.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    _childrenNonVegCount.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    lastNameTF.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    
    
    /** UIScrollView Design */
    workFlowScroll = [[UIScrollView alloc] init];
    workFlowScroll.hidden = NO;
    workFlowScroll.backgroundColor = [UIColor clearColor];
    workFlowScroll.bounces = FALSE;
    workFlowScroll.delegate = self;
    workFlowScroll.scrollEnabled = YES;

    
    //table view creation...
    
    pastOrdersView = [[UIView alloc] init];
    pastOrdersView.frame = CGRectMake(0.0, 125, self.view.frame.size.width, self.view.frame.size.height);
    pastOrdersView.backgroundColor = [UIColor clearColor];
    pastOrdersView.hidden = YES;
    
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

    segment.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    segment.backgroundColor = [UIColor clearColor];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:22], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                nil];
    [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    firstOrders_takeaway.layer.cornerRadius = 25.0f;
    firstOrders_takeaway.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    lastOrders_takeaway.layer.cornerRadius = 25.0f;
    lastOrders_takeaway.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    previousOrders_takeaway.layer.cornerRadius = 22.0f;
    previousOrders_takeaway.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    nextOrders_takeaway.layer.cornerRadius = 22.0f;
    nextOrders_takeaway.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    orderStart_takeaway.font = [UIFont systemFontOfSize:25.0];
    label11.font = [UIFont systemFontOfSize:25.0];
    orderEnd_takeaway.font = [UIFont systemFontOfSize:25.0];
    label22.font = [UIFont systemFontOfSize:25.0];
    totalOrder_takeaway.font = [UIFont systemFontOfSize:25.0];
    
    // Start Of framings.
    segment.frame = CGRectMake(-2, 65, self.view.frame.size.width+60, 60);

    // frame changes made by roja on 05/03/2019 ....
    firstOrders_takeaway.frame = CGRectMake(10, self.view.frame.size.height-270, 50, 50);// 82 --- X-Axis
    previousOrders_takeaway.frame = CGRectMake(110, self.view.frame.size.height-270, 50, 50);//210
    label11.frame = CGRectMake(180, self.view.frame.size.height-270, 120, 50);// 285
    
    orderStart_takeaway.frame = CGRectMake(260, self.view.frame.size.height-270, 80, 50);//365
    orderEnd_takeaway.frame = CGRectMake(260, self.view.frame.size.height-180, 80, 50);//365
    
    label22.frame = CGRectMake(320, self.view.frame.size.height-270, 30, 50);//420
    totalOrder_takeaway.frame = CGRectMake(360, self.view.frame.size.height-270, 80, 50);//455
    
    nextOrders_takeaway.frame = CGRectMake(410, self.view.frame.size.height-270, 50, 50);//512
    lastOrders_takeaway.frame = CGRectMake(510, self.view.frame.size.height-270, 50, 50);//645

   
    
    billBtn.layer.masksToBounds = YES;
    billBtn.layer.cornerRadius = 10.0f;
    editBookingBtn.layer.masksToBounds = YES;
    editBookingBtn.layer.cornerRadius = 10.0f;
    printBtn.layer.masksToBounds = YES;
    printBtn.layer.cornerRadius = 10.0f;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 10.0f;
    
    //status array initialization....
    
    [statusTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    past_order_no = 1;
    occasionsDic = [WebServiceUtility getPropertyFromProperties:@"Occasions"];
    
    isTableAllocated = FALSE;
    isCancellation = FALSE;
    // Do any additional setup after loading the view from its nib.
    
    
    
    // added by roja on 05/03/2019,....
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 9, 10);
    layout.itemSize = CGSizeMake(60, 60);
    layout.minimumInteritemSpacing = 10.0;
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
    totalSeatsLbl.font = [UIFont systemFontOfSize:18.0];
    
    UILabel * bookedSeatsLbl = [[UILabel alloc] init];
    bookedSeatsLbl.text = @"Booked:";
    bookedSeatsLbl.textAlignment = NSTextAlignmentLeft;
    bookedSeatsLbl.backgroundColor = [UIColor blackColor];
    bookedSeatsLbl.textColor = [UIColor whiteColor];
    bookedSeatsLbl.font = [UIFont systemFontOfSize:18.0];

    UILabel * occupiedSeatsLbl = [[UILabel alloc] init];
    occupiedSeatsLbl.text = @"Occupied:";
    occupiedSeatsLbl.textAlignment = NSTextAlignmentLeft;
    occupiedSeatsLbl.backgroundColor = [UIColor blackColor];
    occupiedSeatsLbl.textColor = [UIColor whiteColor];
    occupiedSeatsLbl.font = [UIFont systemFontOfSize:18.0];

    totalSeatsValueTF = [[UITextField alloc] init];
    totalSeatsValueTF.borderStyle = UITextBorderStyleNone; //UITextBorderStyleRoundedRect
    totalSeatsValueTF.textColor = [UIColor whiteColor];
    totalSeatsValueTF.font = [UIFont systemFontOfSize:18.0];
    totalSeatsValueTF.backgroundColor = [UIColor blackColor];
    totalSeatsValueTF.returnKeyType = UIReturnKeyDone;
    totalSeatsValueTF.userInteractionEnabled = NO;
    totalSeatsValueTF.delegate = self;
//    totalSeatsValueTF.textAlignment = NSTextAlignmentCenter;

    bookedSeatsValueTF = [[UITextField alloc] init];
    bookedSeatsValueTF.borderStyle = UITextBorderStyleNone; //UITextBorderStyleRoundedRect
    bookedSeatsValueTF.textColor = [UIColor whiteColor];
    bookedSeatsValueTF.font = [UIFont systemFontOfSize:18.0];
    bookedSeatsValueTF.backgroundColor = [UIColor blackColor];
    bookedSeatsValueTF.returnKeyType = UIReturnKeyDone;
    bookedSeatsValueTF.userInteractionEnabled = NO;
    bookedSeatsValueTF.delegate = self;
//    bookedSeatsValueTF.textAlignment = NSTextAlignmentCenter;

    occupiedSeatsValueTF = [[UITextField alloc] init];
    occupiedSeatsValueTF.borderStyle = UITextBorderStyleNone; //UITextBorderStyleRoundedRect
    occupiedSeatsValueTF.textColor = [UIColor whiteColor];
    occupiedSeatsValueTF.font = [UIFont systemFontOfSize:18.0];
    occupiedSeatsValueTF.backgroundColor = [UIColor blackColor];
    occupiedSeatsValueTF.returnKeyType = UIReturnKeyDone;
    occupiedSeatsValueTF.userInteractionEnabled = NO;
    occupiedSeatsValueTF.delegate = self;
//    occupiedSeatsValueTF.textAlignment = NSTextAlignmentCenter;

    float levelsViewWidth = 135;//150

    levelsDisplayView.frame = CGRectMake((pastOrdersView.frame.size.width - levelsViewWidth), 20, levelsViewWidth, 530);
    levelsBackgroundView.frame = CGRectMake((levelsDisplayView.frame.origin.x - 1), levelsDisplayView.frame.origin.y, 1, levelsDisplayView.frame.size.height);
    tableDetailsView.frame = CGRectMake((pastOrdersView.frame.size.width - (2*levelsViewWidth)), levelsDisplayView.frame.origin.y + levelsDisplayView.frame.size.height, 2*levelsViewWidth, 92);
    collectionView.frame = CGRectMake(0, 20, levelsBackgroundView.frame.origin.x-1, levelsBackgroundView.frame.size.height);
    
    // table details framings....
    totalSeatsLbl.frame = CGRectMake(0, 0.5, levelsViewWidth-1, 30);
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

    [pastOrdersView addSubview:firstOrders_takeaway];
    [pastOrdersView addSubview:lastOrders_takeaway];
    [pastOrdersView addSubview:nextOrders_takeaway];
    [pastOrdersView addSubview:previousOrders_takeaway];
    [pastOrdersView addSubview:totalOrder_takeaway];
    [pastOrdersView addSubview:orderStart_takeaway];
    [pastOrdersView addSubview:orderEnd_takeaway];
    [pastOrdersView addSubview:label11];
    [pastOrdersView addSubview:label22];
    [self.view addSubview:pastOrdersView];
    // upto here added by roja on 05/03/2019,....

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    @try {
        
        // added by roja on 02/03/2019.....
        if (isDirectTableBooking) {
            
            segment.selectedSegmentIndex = 1;
            [self segmentAction:segment];
        }

        [self getOrderDetails];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
}

-(void)getOrderDetails {
    
    @try {
        [HUD setHidden:NO];
        
        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],orderRef,presentLocation, nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,ORDER_ID,kStoreLocation, nil]];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString  *getRoomsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [HUD  setHidden:NO];
        
        
//        bool status = false;
//        CheckWifi * wifiStatus = [[CheckWifi alloc]init];
//        status = [wifiStatus checkWifi];
        
        if (!isOfflineService) {
            WebServiceController *service = [[WebServiceController alloc] init];
            [service setRestaurantBookingServiceDelegate:self];
            [service getRestBookingDetails:getRoomsJsonString];

        }
        
        // commented by roja on 09/01/2019...
        // reason related to Offline
//        else {
//
//            isOfflineService = YES;
//            offlineService = [[RestBookingServices alloc] init];
//            NSMutableDictionary *resultDic = [offlineService getBookingDetailsByFilters:reqDic orderId:orderRef];
//
//            [self getBookingDetailsSuccess:resultDic];
//        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
    }
    
    
}
#pragma -mark tableview methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == statusTable) {
        
        return [statusArr count];
    }

    return 3; // in your case, there are 3 cells
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == statusTable) {
        
        return 1;
    }
    return 1;
   
}

//heigth for tableviewcell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (tableView == statusTable) {
            return 60.0;
        }
        return 60.0;
        
    }
    else {
        return 45.0;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
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
            hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        }
        else {
            hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        }
    }

//    if (tableView == statusTable) {
//        NSLog(@"%d",indexPath.row);
//        status = [[UIButton alloc] init];
//        [status setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];//        [status setBackgroundColor:[UIColor grayColor]];
//        [status setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [status setTitle:[statusArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//        status.titleLabel.textColor = [UIColor blackColor];
//        status.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
//        status.titleLabel.textAlignment = NSTextAlignmentLeft;
//        status.layer.cornerRadius = 10.0f;
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            status.frame = CGRectMake(0,0,hlcell.frame.size.width, 80);
//        }
//        hlcell.textLabel.textAlignment = NSTextAlignmentLeft;
//        [hlcell.contentView addSubview:status];
//        
//    }
    return hlcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
     
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)viewDidUnload {
    [self setCustomerEmailLbl:nil];
    [self setCustomerNameLbl:nil];
    [self setMobileNoLbl:nil];
    [self setBookingIdLbl:nil];
}


- (IBAction)editBooking:(UIButton *)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);

    custNameTxt.userInteractionEnabled = YES;
    phoneTxt.userInteractionEnabled = YES;
    roomNoTxt.userInteractionEnabled = YES;
    self.mobileNo.userInteractionEnabled = YES;
    self.noOfCustTxt.userInteractionEnabled = YES;
    self.reservationStatusTxt.userInteractionEnabled = YES;
    self.custName.userInteractionEnabled = YES;
    self.noOfAdultsTxt.userInteractionEnabled = YES;
    self.noOfChildsTxt.userInteractionEnabled = YES;
    self.specialInstrTxt.userInteractionEnabled = YES;
    self.customerEmailTxt.userInteractionEnabled = YES;
    _vegCountTxt.userInteractionEnabled = YES;
    _nonvegCountTxt.userInteractionEnabled = YES;
    _alcoholCountTxt.userInteractionEnabled = YES;
    _nonAlcoholCountTxt.userInteractionEnabled = YES;
    _childrenVegCount.userInteractionEnabled = YES;
    _childrenNonVegCount.userInteractionEnabled = YES;
    _vehicleNo.userInteractionEnabled = YES;
    lastNameTF.userInteractionEnabled = YES;
    
    //    occasionTxt.userInteractionEnabled = YES;
    //    self.reservationModeTxt.userInteractionEnabled = YES;
    //    _bookingIdTxt.userInteractionEnabled = YES;
    //    _genderTxt.userInteractionEnabled = YES;
    //    _reservationDate.userInteractionEnabled = YES;
    //    self.slotId.userInteractionEnabled = YES;
    
}

- (IBAction)printReceipt:(UIButton *)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);

    float y_axis = self.view.frame.size.height - 120;
    NSString * msg = NSLocalizedString(@"currently_this_feature_is_unavailable", nil);
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
}

- (IBAction)cancelBooking:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);

    cancellationConfirmAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cancel Confirmation", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:NSLocalizedString(@"Cancel", nil), nil];
    [cancellationConfirmAlert show];
}
#pragma -mark service delegates

-(void)getBookingDetailsFailure:(NSString *)failureString {
    
    [HUD setHidden:YES];

    float y_axis = self.view.frame.size.height - 120;
    NSString * msg = failureString;
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
}

-(void)getBookingDetailsSuccess:(NSDictionary *)successDictionary {
    
    [HUD setHidden:YES];
    
    if ([successDictionary count]) {
        
        itemDetailsArr = [[NSMutableArray alloc]init];
    
        @try {
            NSDictionary *details = [successDictionary copy];
            orderDetailsInfoDic = [details mutableCopy];
            
            if (![[details valueForKey:ORDER_REFERENCE] isKindOfClass:[NSNull class]]) {
                _bookingIdTxt.text = [details valueForKey:ORDER_REFERENCE];
                orderRef = [details valueForKey:ORDER_REFERENCE];
            }
            
            if([[details allKeys] containsObject:RESERVATION_TYPE_ID] && [[details valueForKey:RESERVATION_TYPE_ID] isKindOfClass:[NSNull class]])
                bookingTypeStr = [details valueForKey:RESERVATION_TYPE_ID];
            
            
            if (![[details valueForKey:MOBILE_NUMBER] isKindOfClass:[NSNull class]]) {
                _mobileNo.text = [details valueForKey:MOBILE_NUMBER];
            }
            if (![[details valueForKey:CUSTOMER_NAME] isKindOfClass:[NSNull class]]) {
                custNameTxt.text = [details valueForKey:CUSTOMER_NAME];
                
            }
            if (![[details valueForKey:@"lastName"] isKindOfClass:[NSNull class]]) {
                lastNameTF.text = [details valueForKey:@"lastName"];
                
            }
            if (![[details valueForKey:CUSTOMER_MAIL] isKindOfClass:[NSNull class]]) {
                _customerEmailTxt.text = [details valueForKey:CUSTOMER_MAIL];
                
            }
            if (![[details valueForKey:RESERVATION_DATE_TIME_STR] isKindOfClass:[NSNull class]]) {
                _reservationDate.text = [details valueForKey:RESERVATION_DATE_TIME_STR];
                
            }
            if (![[details valueForKey:SLOT_ID] isKindOfClass:[NSNull class]]) {
                _slotId.text = [details valueForKey:SLOT_ID];
                
            }
            if (![[details valueForKey:ADULT_PAX] isKindOfClass:[NSNull class]]) {
                _noOfAdultsTxt.text = [[details valueForKey:ADULT_PAX] stringValue];
                
            }
            if (![[details valueForKey:CHILD_PAX] isKindOfClass:[NSNull class]]) {
                _noOfChildsTxt.text = [[details valueForKey:CHILD_PAX] stringValue];
                
            }
            if (![[details valueForKey:RESERVATION_TYPE_ID] isKindOfClass:[NSNull class]]) {
                _reservationModeTxt.text = [details valueForKey:RESERVATION_TYPE_ID];
                
            }
            if (![[details valueForKey:OCCASION_DESC] isKindOfClass:[NSNull class]]) {
                occasionTxt.text = [details valueForKey:OCCASION_DESC];
                
            }
            if (![[details valueForKey:SPECIAL_INSTRUCTIONS] isKindOfClass:[NSNull class]]) {
                _specialInstructionsTxtView.text = [details valueForKey:SPECIAL_INSTRUCTIONS];
                
            }
            _noOfCustTxt.text = [NSString stringWithFormat:@"%d",[_noOfChildsTxt.text intValue]+[_noOfAdultsTxt.text intValue]];
            
            if (![[details valueForKey:CAR_NUMBER] isKindOfClass:[NSNull class]]) {
                _vehicleNo.text = [details valueForKey:CAR_NUMBER];
                
            }
            
            if (![[details valueForKey:CUSTOMER_GENDER] isKindOfClass:[NSNull class]]) {
                
                _genderTxt.text = [details valueForKey:CUSTOMER_GENDER];
                
            }
            
            if (![[details valueForKey:NO_OF_VEG_ADULTS] isKindOfClass:[NSNull class]]) {
                _vegCountTxt.text = [[details valueForKey:NO_OF_VEG_ADULTS] stringValue];
                
            }
            if (![[details valueForKey:NO_OF_NON_VEG_ADULTS] isKindOfClass:[NSNull class]]) {
                _nonvegCountTxt.text = [[details valueForKey:NO_OF_NON_VEG_ADULTS] stringValue];
                
            }
            if (![[details valueForKey:NO_OF_ALCOHOLIC] isKindOfClass:[NSNull class]]) {
                _alcoholCountTxt.text = [[details valueForKey:NO_OF_ALCOHOLIC] stringValue];
                
            }
            if (![[details valueForKey:NO_OF_NON_ALCOHOLIC] isKindOfClass:[NSNull class]]) {
                _nonAlcoholCountTxt.text = [[details valueForKey:NO_OF_NON_ALCOHOLIC] stringValue];
                
            }
            if (![[details valueForKey:NO_OF_NON_VEG_CHILDREN] isKindOfClass:[NSNull class]]) {
                _childrenNonVegCount.text = [[details valueForKey:NO_OF_NON_VEG_CHILDREN] stringValue];
                
            }
            if (![[details valueForKey:NO_OF_VEG_CHILDREN] isKindOfClass:[NSNull class]]) {
                _childrenVegCount.text = [[details valueForKey:NO_OF_VEG_CHILDREN] stringValue];
                
            }
            if (![[details valueForKey:SALES_LOCATION] isKindOfClass:[NSNull class]]) {
                tableNo= [details valueForKey:SALES_LOCATION] ;
                
            }
            //assigning the available workflow states....
            
            statusArr = [[successDictionary valueForKey:kAvailableActivities] copy];
            if ([statusArr count]) {
                workFlowStateStr = [[statusArr objectAtIndex:0] copy];
            }
            
            xposition_f = 780.0f;
            float scrollPos = scrollView.frame.origin.y+30;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
                if (version>=8.0) {
                    xposition_f = 410.0;
                }
                else {
                    xposition_f = 405.0;
                }
            }
            else {
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                    xposition_f = scrollView.frame.size.width+50;
                    yposition_f = 0.0;
                }
            }
            //removing the subviews from the scrollview....
            
            for (UIView *view in workFlowScroll.subviews) {
                
                if ([view isKindOfClass:[UIButton class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            
            for (int i=0; i<[statusArr count]; i++) {
                
                status = [[UIButton alloc] init];
                [status setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];//        [status setBackgroundColor:[UIColor grayColor]];
                [status setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [status setTitle:[statusArr objectAtIndex:i] forState:UIControlStateNormal];
                //        status.titleLabel.textColor = [UIColor blackColor];
                status.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
                status.titleLabel.textAlignment = NSTextAlignmentLeft;
                status.layer.cornerRadius = 10.0f;
                [status addTarget:self action:@selector(updateBookingThroughButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    workFlowScroll.frame = CGRectMake(xposition_f, scrollPos, 180, 400);
                    workFlowScroll.contentSize = CGSizeMake(180, 800);
                    status.frame = CGRectMake(0, yposition_f, 150, 50);
                }
                
                yposition_f = yposition_f+70;
                [workFlowScroll addSubview:status];
                //                [scrollView addSubview:workFlowScroll];
                [self.view addSubview:workFlowScroll];
                scrollView.backgroundColor = [UIColor clearColor];
                
                for (NSDictionary *dic in accessControlActivityArr) {
                    
                    if ([status.titleLabel.text isEqualToString:[dic valueForKey:kAppDocActivity]]) {
                        
                        if ([[dic valueForKey:kActivityWrite] boolValue]) {
                            
                            status.enabled = YES;
                        }
                        else {
                            status.enabled = NO;
                        }
                    }
                }
                if ([status.titleLabel.text isEqualToString:[statusArr objectAtIndex:0]] && status.enabled) {
                    
                    status.enabled = YES;
                }
                else if([status.titleLabel.text caseInsensitiveCompare:@"cancelled"] == NSOrderedSame && status.enabled) {
                    status.enabled = YES;
                }
                else  {
                    status.enabled = NO;
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
    else {
      
        float y_axis = self.view.frame.size.height - 120;
        NSString * msg = @"Failed to get Data";
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
}
#pragma -mark end of service delegates

- (IBAction)isVegetarian:(UIButton *)sender {
    if (sender.tag == 0) {
        _isVegBtn.tag = 1;
        isVeg = TRUE;
        [_isVegBtn setImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
        
    }
    else {
        _isVegBtn.tag = 0;
        isVeg = FALSE;
        [_isVegBtn setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)drinkRequired:(UIButton *)sender {
    if (sender.tag == 0) {
        _drinkReqBtn.tag = 1;
        isDrinkReq = TRUE;
        [_drinkReqBtn setImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
        
    }
    else {
        _drinkReqBtn.tag = 0;
        isDrinkReq = FALSE;
        [_drinkReqBtn setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)selectDate:(UIButton *)sender {
}
-(void)goToHome {
    OmniHomePage *home = [[OmniHomePage alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}




- (IBAction)segmentAction:(UISegmentedControl *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    segment = (UISegmentedControl *)sender;
    NSInteger index = segment.selectedSegmentIndex;
    
    
    //[mainSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    @try {
        switch (index) {
            case 0:
            {
                scrollView.hidden = NO;
                pastOrdersView.hidden = YES;
                billBtn.hidden = NO;
                editBookingBtn.hidden = NO;
                printBtn.hidden = NO;
                cancelBtn.hidden = NO;
                workFlowScroll.hidden = NO;
                _bookingIdTxt.hidden = NO;
                _mobileNo.hidden = NO;
                custNameTxt.hidden = NO;
                _customerEmailTxt.hidden = NO;
                _bookingIdLbl.hidden = NO;
                _mobileNoLbl.hidden = NO;
                _customerEmailLbl.hidden = NO;
                _customerNameLbl.hidden = NO;
                lastNameTF.hidden = NO;
                lastNameLbl.hidden = NO;
        
                [self getOrderDetails];
               break;
            }
            case 1:
            {
                
              //  collectionView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
                
                scrollView.hidden = YES;
                pastOrdersView.hidden = NO;
                past_order_no = 1;
                billBtn.hidden = YES;
                editBookingBtn.hidden = YES;
                printBtn.hidden = YES;
                cancelBtn.hidden = YES;
                workFlowScroll.hidden = YES;
                _bookingIdTxt.hidden = YES;
                _mobileNo.hidden = YES;
                custNameTxt.hidden = YES;
                _customerEmailTxt.hidden = YES;
                _bookingIdLbl.hidden = YES;
                _mobileNoLbl.hidden = YES;
                _customerEmailLbl.hidden = YES;
                _customerNameLbl.hidden = YES;
                lastNameTF.hidden = YES;
                lastNameLbl.hidden = YES;
                
                [self getAllLevels];
                
                break;
            }
                
                
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
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
    labelTxt.font = [UIFont boldSystemFontOfSize:18.0];
    labelTxt.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:0];
    
    UILabel *labelColor = [[UILabel alloc] init];
    labelColor.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt.text]];
    
    
    UILabel *labelTxt1 = [[UILabel alloc] init];
    labelTxt1.backgroundColor = [UIColor clearColor];
    labelTxt1.textColor = [UIColor whiteColor];
    labelTxt1.font = [UIFont boldSystemFontOfSize:18.0];
    labelTxt1.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:1];
    
    UILabel *labelColor1 = [[UILabel alloc] init];
    labelColor1.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt1.text]];
    
    
    UILabel *labelTxt2 = [[UILabel alloc] init];
    labelTxt2.backgroundColor = [UIColor clearColor];
    labelTxt2.textColor = [UIColor whiteColor];
    labelTxt2.font = [UIFont boldSystemFontOfSize:18.0];
    labelTxt2.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:2];
    
    UILabel *labelColor2 = [[UILabel alloc] init];
    labelColor2.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt2.text]];
    
    
    UILabel *labelTxt3 = [[UILabel alloc] init];
    labelTxt3.backgroundColor = [UIColor clearColor];
    labelTxt3.textColor = [UIColor whiteColor];
    labelTxt3.font = [UIFont boldSystemFontOfSize:18.0];
    labelTxt3.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:3];
    
    UILabel *labelColor3 = [[UILabel alloc] init];
    labelColor3.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt3.text]];
    
    // added by roja on 12/02/2019...
    UILabel *labelTxt4 = [[UILabel alloc] init];
    labelTxt4.backgroundColor = [UIColor clearColor];
    labelTxt4.textColor = [UIColor whiteColor];
    labelTxt4.font = [UIFont boldSystemFontOfSize:18.0];
    labelTxt4.text = [[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] allKeys] objectAtIndex:4];
    
    UILabel *labelColor4 = [[UILabel alloc] init];
    labelColor4.backgroundColor = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:labelTxt4.text]];
    
    
    levelTxt = [[UITextField alloc] init];
    levelTxt.borderStyle = UITextBorderStyleRoundedRect;
    levelTxt.textColor = [UIColor blackColor];
    levelTxt.font = [UIFont systemFontOfSize:18.0];
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
    // upto here changed by roja on 12/02/2019..

    
  
    
    // commented by roja on 05/03/2019...
//    [pastOrdersView addSubview:labelTxt];
//    [pastOrdersView addSubview:labelColor];
//    [pastOrdersView addSubview:labelTxt1];
//    [pastOrdersView addSubview:labelColor1];
//    [pastOrdersView addSubview:labelTxt2];
//    [pastOrdersView addSubview:labelColor2];
//    [pastOrdersView addSubview:labelTxt3];
//    [pastOrdersView addSubview:labelColor3];
//    [pastOrdersView addSubview:labelTxt4];
//    [pastOrdersView addSubview:labelColor4];
    
    // upto here commented by roja on 05/03/2019...

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
//        BOOL status1 = [CheckWifi checkWifi];
        if (!isOfflineService) {

            [HUD setHidden:NO];
            NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:presentLocation,@"-1",[RequestHeader getRequestHeader], nil] forKeys:[NSArray arrayWithObjects:@"location",START_INDEX,REQUEST_HEADER, nil]];
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
            NSString * getLevelsJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setOutletServiceDelegate:self];
//            [controller getTheAvailableLevels:getLevelsJsonStr];
            [controller getTheAvailableLevelsWithRestFullService:getLevelsJsonStr];
        }
        
        // commented by roja on 11/01/2019...
        // reason offline work need to work.
//        else {
//
//            offlineService = [[RestBookingServices alloc] init];
//            levelsArr = [offlineService getAllTheLevelsInRest];
//
//            if ([levelsArr count]) {
//                totalOrder_takeaway.text = [NSString stringWithFormat:@"%d",[levelsArr count]];
//                orderStart_takeaway.text = [NSString stringWithFormat:@"%d",past_order_no];
//
//                [self populateTableView:[levelsArr objectAtIndex:0]];
//            }
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
        
        if(tableDetails == nil){
            
            tableDetails = [NSMutableArray new];
            tableStatusArr = [NSMutableArray new];
        }
        else {
            
            if([tableDetails count])
               [tableDetails removeAllObjects];
            if([tableStatusArr count])
                [tableStatusArr removeAllObjects];
        }

        
        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:presentLocation,@"-1",[RequestHeader getRequestHeader],level, nil] forKeys:[NSArray arrayWithObjects:@"location",START_INDEX,REQUEST_HEADER,LEVEL, nil]];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        if (!isOfflineService) {
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setStoreServiceDelegate:self];
            [controller getLayoutDetails:getBookingJsonStr];

        }
        
        // commented by roja on 11/01/2019..
        // reason offline work need to work.
//        else {
//            offlineService = [[RestBookingServices alloc] init];
//           NSMutableDictionary *successDic = [offlineService getTablesInLevel:reqDic];
//            if ([successDic count]) {
//
//                [self getOutletDetailsSuccessResponse:successDic];
//            }
//        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    
}

-(void)loadFirstPage:(id)sender {
    @try {
        
        AudioServicesPlaySystemSound (soundFileObject);
        
        if (sender == firstOrders_takeaway){
            
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
        
        if (sender == lastOrders_takeaway) {
            
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
        if (sender == previousOrders_takeaway){
            
            
            if (past_order_no > 0){
                
                past_order_no = past_order_no-1;
                
                [self populateTableView:[levelsArr objectAtIndex:(past_order_no - 1)]];
                
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
        if (sender == nextOrders_takeaway){
            //previousButton.backgroundColor = [UIColor grayColor];
            previousOrders_takeaway.enabled =  YES;
            
            past_order_no = past_order_no+1;
            
            [self populateTableView:[levelsArr objectAtIndex:(past_order_no - 1)]];
            
            firstOrders_takeaway.enabled = YES;
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
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
        //        banner_but.adjustsImageWhenHighlighted = NO;
        
        UIColor *color = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:[tableStatusArr objectAtIndex:indexPath.row]]];
        
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
        noOfOccupiedChairs.font = [UIFont boldSystemFontOfSize:18.0];
        
        UILabel *noOfAvailChairs = [[UILabel alloc] init];
        noOfAvailChairs.textColor = [UIColor blackColor];
        noOfAvailChairs.textAlignment = NSTextAlignmentCenter;
        noOfAvailChairs.font = [UIFont boldSystemFontOfSize:18.0];

        // added by roja on 05/03/2019...
        UITextField * tableNoTF = [[UITextField alloc] init];
        tableNoTF.textColor = [UIColor blackColor];
        tableNoTF.textAlignment = NSTextAlignmentCenter;
        //        tableNoTF.text = @"T12";
        tableNoTF.font = [UIFont boldSystemFontOfSize:18.0];
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
        startTimeLbl.font = [UIFont systemFontOfSize:14] ;
        
        UILabel * startTimeValueLbl = [[UILabel alloc] init];
        startTimeValueLbl.textColor = [UIColor blackColor];
        startTimeValueLbl.textAlignment = NSTextAlignmentLeft;
        startTimeValueLbl.font = [UIFont systemFontOfSize:14];
        
        UILabel * bookingTimeLbl = [[UILabel alloc] init];
        bookingTimeLbl.textColor = [UIColor blackColor];
        bookingTimeLbl.textAlignment = NSTextAlignmentLeft;
        bookingTimeLbl.text = @"Book Time:";
        bookingTimeLbl.font = [UIFont systemFontOfSize:14] ;
        
        UILabel * bookingTimeValueLbl = [[UILabel alloc] init];
        bookingTimeValueLbl.textColor = [UIColor blackColor];
        bookingTimeValueLbl.textAlignment = NSTextAlignmentLeft;
        bookingTimeValueLbl.font = [UIFont systemFontOfSize:14];

//        NSString * reservedDateTimeStr = [self checkGivenValueIsNullOrNil:[temp valueForKey:@"reservationDateTime"] defaultReturn:@""];
//
//        if([reservedDateTimeStr isEqualToString: @""]){
//            startTimeValueLbl.text = @"-";
//        }
//        else{
//            startTimeValueLbl.text = [reservedDateTimeStr componentsSeparatedByString:@" "][1];
//        }
        
        // upto here added by roja on 05/03/2019...
        // framings...
//        tableLayout.frame = CGRectMake(5, 0, 160, 160);
//        noOfOccupiedChairs.frame = CGRectMake(tableLayout.frame.size.width/2-40, tableLayout.frame.size.height/2, 80, 30);
//        noOfAvailChairs.frame = CGRectMake(tableLayout.frame.size.width-60,20,60, 30);
//        tableNoTF.frame = CGRectMake(8, 8, 65, 25);
//        startTimeLbl.frame = CGRectMake(5, tableLayout.frame.size.height - 30, 65, 20);
//        startTimeValueLbl.frame = CGRectMake(startTimeLbl.frame.origin.x + startTimeLbl.frame.size.width, startTimeLbl.frame.origin.y, tableLayout.frame.size.width - (startTimeLbl.frame.origin.x + startTimeLbl.frame.size.width), startTimeLbl.frame.size.height);
        
        @try {
            if ([tableDetails count] && tableDetails!=nil) {
                
                NSDictionary * temp = [tableDetails objectAtIndex:indexPath.row];
                
                tableNoTF.text = [NSString stringWithFormat:@"%@%@",@"T", [self checkGivenValueIsNullOrNil:[temp valueForKey:TABLE_NUMBER] defaultReturn:@"0"]];
                noOfAvailChairs.text = [temp valueForKey:kNoOfChairs];
//                noOfOccupiedChairs.text = [temp valueForKey:TABLE_NUMBER];

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
        
        
        tableLayout.frame = CGRectMake(0, 0, 135, [[UIScreen mainScreen] bounds].size.height/4-70);
        noOfOccupiedChairs.frame = CGRectMake(tableLayout.frame.size.width/2-40, tableLayout.frame.size.height/2-10, 80, 30);
        noOfAvailChairs.frame = CGRectMake(tableLayout.frame.size.width-60,20,60, 30);
        tableNoTF.frame = CGRectMake(5, 8, 45, 22);// w-65
        bookingTimeLbl.frame = CGRectMake(2, noOfOccupiedChairs.frame.origin.y + noOfOccupiedChairs.frame.size.height+3, 80, 20);
        bookingTimeValueLbl.frame = CGRectMake(bookingTimeLbl.frame.origin.x + bookingTimeLbl.frame.size.width, bookingTimeLbl.frame.origin.y, tableLayout.frame.size.width - (bookingTimeLbl.frame.origin.x + bookingTimeLbl.frame.size.width), bookingTimeLbl.frame.size.height);
        startTimeLbl.frame = CGRectMake(2, tableLayout.frame.size.height - 20, 58, 20);//55
        startTimeValueLbl.frame = CGRectMake(startTimeLbl.frame.origin.x + startTimeLbl.frame.size.width, startTimeLbl.frame.origin.y, tableLayout.frame.size.width - (startTimeLbl.frame.origin.x + startTimeLbl.frame.size.width), startTimeLbl.frame.size.height);

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
        
//        singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//        singletap.numberOfTapsRequired = 1;
//        singletap.numberOfTouchesRequired = 1;
//        singletap.delegate = self;
//        singletap.cancelsTouchesInView = NO;
//        [tableLayout addGestureRecognizer:singletap];
//        [tableLayout setUserInteractionEnabled:YES];

        
        //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        //
        //            if (version>=8.0) {
        //                tableLayout.frame = CGRectMake(5, 0, 30, 30);
        //            }
        //            else {
        //
        //            }
        //        }
        //        else {
        //            tableLayout.frame = CGRectMake(5, 0, 130, 130);
        //            tableNoLbl.frame = CGRectMake(tableLayout.frame.size.width/2-40, tableLayout.frame.size.height/2, 80, 30);
        //            noOfAvailChairs.frame = CGRectMake(tableLayout.frame.size.width-60,20,60, 30);
        //        }
        
        return cell;
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize s;
    // commented by roja on 05/03/2019...
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
    
            NSLog(@"%f",[[UIScreen mainScreen] bounds].size.width/3 );
            
//            s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/4 - 120, [[UIScreen mainScreen] bounds].size.height/4-70);
    
//    s = CGSizeMake(([[UIScreen mainScreen] bounds].size.width/3) - levelsDisplayView.frame.size.width, [[UIScreen mainScreen] bounds].size.height/3-70);
    
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
//
    
    // upto here commented by roja on 05/03/2019...
    return s;
    
}

// 3
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 0);
}

-(void)collectionView:(UICollectionView *)collectionView_ didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    @try {
        
        tablePositionInt = (int)indexPath.row;
        
        
        if ([[statusArr objectAtIndex:0]caseInsensitiveCompare:@"arrived"]==NSOrderedSame ||  [[statusArr objectAtIndex:0]caseInsensitiveCompare:@"waiting"]==NSOrderedSame) {
            
            if ([[tableStatusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"vacant"]==NSOrderedSame) {
                
                //            if (([_noOfAdultsTxt.text intValue]+[_noOfChildsTxt.text intValue])<=[[[tableDetails objectAtIndex:indexPath.row] valueForKey:kNoOfChairs] intValue]) {
                
                confirm = [[UIAlertView alloc] initWithTitle:@"Do you want to allot the table?" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                [confirm show];
                //            }
                //            else {
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NO_OF_PERSONS_EXCEEDS", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //                [alert show];
                //            }
                
                
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Table is not available.Please select a vacant table" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }
        else {
            
            float y_axis = self.view.frame.size.height - 120;
            NSString * msg = @"Table has already been allocated";
            [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
//    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
//    
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, 220)];
//    customView.opaque = NO;
//    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
//    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    customView.layer.borderWidth = 2.0f;
//    [customView setHidden:NO];
//    
//    UILabel *availableChairsLbl = [[UILabel alloc] init];
//    availableChairsLbl.text = @"Allotment Seats";
//    availableChairsLbl.textColor = [UIColor blackColor];
//    availableChairsLbl.font = [UIFont systemFontOfSize:20.0];
//    
//    availableChairsTxt = [[UITextField alloc] init];
//    availableChairsTxt.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
//    [availableChairsTxt setDelegate:self];
//    [availableChairsTxt.layer setBorderWidth:1.0f];
//    availableChairsTxt.layer.cornerRadius = 3;
//    availableChairsTxt.text = [temp valueForKey:kNoOfChairs];
//    availableChairsTxt.layer.borderColor = [UIColor grayColor].CGColor;
//    availableChairsTxt.textAlignment = NSTextAlignmentCenter;
//    
//    allotTblBtn = [[UIButton alloc] init];
//    [allotTblBtn addTarget:self action:@selector(allotTable:) forControlEvents:UIControlEventTouchUpInside];
//    [allotTblBtn setTitle:@"Allot" forState:UIControlStateNormal];
//    allotTblBtn.layer.cornerRadius = 10.0f;
//    [allotTblBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
//    [allotTblBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    allotTblBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
//    
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        availableChairsTxt.frame = CGRectMake(20, 50, 150,40);
//        availableChairsLbl.frame = CGRectMake(20, 10, 200, 40);
//        allotTblBtn.frame = CGRectMake(50, 160, 120, 45);
//        
//    }
//    
//    
//    [customView addSubview:availableChairsLbl];
//    [customView addSubview:availableChairsTxt];
//    [customView addSubview:allotTblBtn];
//    
//    customerInfoPopUp.view = customView;
//    
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
//        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        
////        NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
//       UICollectionViewCell *selectedCell = [collectionView_ cellForItemAtIndexPath:indexPath];
//
//        
//        [popover presentPopoverFromRect:tableLayout.frame inView:selectedCell permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        
//        
//        popOver= popover;
//        
//    }
//    
//    else {
//        
//        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
//        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        // popover.contentViewController.view.alpha = 0.0;
//        [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
//        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver = popover;
//        
//    }
//    
//    UIGraphicsBeginImageContext(customView.frame.size);
//    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
   }

#pragma -mark end of collection view methods
//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    UIView *view = recognizer.view;
    NSLog(@"%d",view.tag);
}
/**
 * @description  select the gender
 * @date         2/11/15
 * @method       selectRadioBtn1
 * @author       Sonali
 * @param        sender of type UIButtin
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (IBAction)selectRadioBtn1:(UIButton *)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ((UIButton *)sender == radioBtn1 ) {
        
        
        gender = @"M";
        radioBtn1.tag = 1;
        [radioBtn1 setImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
        [radioBtn2 setImage:[UIImage imageNamed:@"unchecked2.png"] forState:UIControlStateNormal];
        
    }
    else{
        
        
        gender = @"F";
        radioBtn1.tag = 0;
        [radioBtn1 setImage:[UIImage imageNamed:@"unchecked2.png"] forState:UIControlStateNormal];
        [radioBtn2 setImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
        
        
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

#pragma -mark layout delegates
-(void)getAllLayoutTablesSuccessResponse:(NSDictionary *)successDictionary {
    //getOutletDetailsSuccessResponse:
    @try {
        // added by roja on 07/03/2019...
        
        NSArray *array = [successDictionary valueForKey:TABLES_LIST];

        for (NSDictionary *tableDetailsDic in array) {
            
            NSString * dateTimeStr = @"";
            NSString * tableallocatioDateTime = @"";
            
            int adultPax = 0;
            int childPax = 0;
            int noOfSeatsOccupied = 0;
            
            if( ([tableDetailsDic.allKeys containsObject:@"order"] && ![[tableDetailsDic valueForKey:@"order"]  isKindOfClass: [NSNull class]])){
                
                dateTimeStr =  [self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"reservationDateTime"] defaultReturn:@""]; //  reservationDateTime is for booking time
                
                tableallocatioDateTime = [self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"date"] defaultReturn:@""];
                
                adultPax = [[self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"adultPax"] defaultReturn:@"0"] intValue];
                
                childPax = [[self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"childPax"] defaultReturn:@"0"] intValue];
            }

//            dateTimeStr =  [self checkGivenValueIsNullOrNil:[[dic valueForKey:@"order"] valueForKey:@"reservationDateTime"] defaultReturn:@""];
//            tableallocatioDateTime = [self checkGivenValueIsNullOrNil:[[dic valueForKey:@"order"] valueForKey:@"date"] defaultReturn:@""];
//            adultPax = [[self checkGivenValueIsNullOrNil:[[dic valueForKey:@"order"] valueForKey:@"adultPax"] defaultReturn:@""] intValue];
//            childPax = [[self checkGivenValueIsNullOrNil:[[dic valueForKey:@"order"] valueForKey:@"childPax"] defaultReturn:@""] intValue];

            noOfSeatsOccupied = adultPax + childPax;
            //upto here  added by roja on 07/03/2019...

            [tableDetails addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[tableDetailsDic valueForKey:LEVEL],[tableDetailsDic valueForKey:TABLE_NUMBER],[tableDetailsDic valueForKey:kNoOfChairs],dateTimeStr,tableallocatioDateTime,[NSNumber numberWithInt:noOfSeatsOccupied], nil] forKeys:[NSArray arrayWithObjects:LEVEL,TABLE_NUMBER,kNoOfChairs,@"reservationDateTime",@"startDateTime",@"noOfOccupiedSeats", nil]]];
            
            [tableStatusArr addObject:[self checkGivenValueIsNullOrNil:[tableDetailsDic valueForKey:STATUS] defaultReturn:@""]];
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

        [collectionView setHidden:NO];
        pastOrdersView.userInteractionEnabled = YES;
        collectionView.userInteractionEnabled = YES;
        
        [collectionView reloadData];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    @finally {
        
        [HUD setHidden:YES];
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


-(void)getAllLayoutTablesErrorResponse:(NSString *)failureString {
    
    [HUD setHidden:YES];

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
    NSString * msg = failureString;
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    
    [collectionView reloadData];
    [collectionView setHidden:YES];
}


#pragma -mark getLevels service delegates
-(void)getOutletLevelsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        levelsArr = [[NSMutableArray alloc] init];
        levelsArr = [[successDictionary valueForKey:kAvailableLevels] copy];
        
        if ([levelsArr count]) {
            
            totalOrder_takeaway.text = [[successDictionary objectForKey:@"totalRecords"] stringValue];
            orderStart_takeaway.text = [NSString stringWithFormat:@"%d",past_order_no];
            [self populateTableView:[levelsArr objectAtIndex:0]];
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
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

#pragma -mark alertview delegates
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
   
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView == confirm) {
        
        if (buttonIndex == 0) {
            
            isTableAllocated = YES;
            [self allotTableForBooking:orderRef];
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    else if (alertView == allotTableAlert) {
        if (buttonIndex == 0) {
            
            segment.selectedSegmentIndex = 1;
            [self segmentAction:segment];
        }
    }
   else  if (alertView == success) {
       
       [self getOrderDetails];
       
       if ([workFlowStateStr caseInsensitiveCompare:@"arrived"]==NSOrderedSame) {
          
           segment.selectedSegmentIndex = 1;
           [self segmentAction:segment];
           
       }
       else if(isOfflineService && [workFlowStateStr caseInsensitiveCompare:@"waiting"]==NSOrderedSame) {
           segment.selectedSegmentIndex = 1;
           [self segmentAction:segment];
           
       }
       else if (isTableAllocated) {
           isTableAllocated = FALSE;
           ServiceOrders *bookings = [[ServiceOrders alloc] init];
           [self.navigationController pushViewController:bookings animated:YES];
       }
       else {
          
//           [self getAllLevels];
           ServiceOrders *bookings = [[ServiceOrders alloc] init];
           [self.navigationController pushViewController:bookings animated:YES];
       }

//
    }
   else if (alertView == cancellationConfirmAlert) {
       if (buttonIndex == 0) {
           workFlowStateStr = @"cancelled";
           [self updateBooking:@"cancelled"];
       }
       else {
           [alertView dismissWithClickedButtonIndex:0 animated:YES];
       }
   }
}
/**
 * @description     allocate the selected table for the particular booking
 * @date            16/12/15
 * @method          allotTableForBooking
 * @author          Sonali
 * @param           bookingId
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)allotTableForBooking:(NSString*)bookingId {
    @try {
        
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString* currentdate = [f stringFromDate:today];
        
        NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
        NSMutableArray *temparr = [[NSMutableArray alloc]init];
        
        [orderDetails setObject:orderRef forKey:ORDER_REFERENCE];
        [orderDetails setObject:@"immediate" forKey:ORDER_TYPE];
        [orderDetails setObject:currentdate forKey:Order_Date];
        [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [orderDetails setObject:custNameTxt.text forKey:CUSTOMER_NAME];
        [orderDetails setObject:lastNameTF.text forKey:@"lastName"];
        [orderDetails setObject:self.customerEmailTxt.text forKey:CUSTOMER_MAIL];
        [orderDetails setObject:_slotId.text forKey:SLOT_ID];
        [orderDetails setObject:_reservationModeTxt.text forKey:RESERVATION_TYPE_ID];
        [orderDetails setObject:[NSNumber numberWithBool:isVeg] forKey:@"adultFoodTypeVeg"];
        [orderDetails setObject:[NSNumber numberWithBool:isDrinkReq] forKey:kAlcohol];
        
        [orderDetails setObject:[NSNumber numberWithInt:[self.noOfAdultsTxt.text intValue]] forKey:ADULT_PAX];
        [orderDetails setObject:[NSNumber numberWithInt:[self.noOfChildsTxt.text intValue]] forKey:CHILD_PAX];
        [orderDetails setObject:[occasionsDic valueForKey:occasionTxt.text] forKey:OCCASION_ID];
        [orderDetails setObject:occasionTxt.text forKey:OCCASION_DESC];
        [orderDetails setObject:_reservationDate.text forKey:RESERVATION_DATE_TIME_STR];
        [orderDetails setObject:_specialInstructionsTxtView.text forKey:SPECIAL_INSTRUCTIONS];
        [orderDetails setObject:_mobileNo.text forKey:MOBILE_NUMBER];
        [orderDetails setObject:[NSNumber numberWithInt:[_vegCountTxt.text intValue]] forKey:NO_OF_VEG_ADULTS];
        [orderDetails setObject:[NSNumber numberWithInt:[_nonvegCountTxt.text intValue]] forKey:NO_OF_NON_VEG_ADULTS];
        [orderDetails setObject:[NSNumber numberWithInt:[_childrenVegCount.text intValue]] forKey:NO_OF_VEG_CHILDREN];
        [orderDetails setObject:[NSNumber numberWithInt:[_childrenNonVegCount.text intValue]] forKey:NO_OF_NON_VEG_CHILDREN];
        [orderDetails setObject:[NSNumber numberWithInt:[_alcoholCountTxt.text intValue]] forKey:NO_OF_ALCOHOLIC];
        [orderDetails setObject:[NSNumber numberWithInt:[_nonAlcoholCountTxt.text intValue]] forKey:NO_OF_NON_ALCOHOLIC];

        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:Grand_Total_D_1];
        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:TAX];
        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:SUB_TOTAL];
        
        [orderDetails setObject:presentLocation forKey:STORE_LOCATION];
        [orderDetails setObject:[NSNumber numberWithBool:YES] forKey:kIsTableChange];
        [orderDetails setObject:@"Seated" forKey:STATUS];
        
        [orderDetails setObject:temparr forKey:kItemDetails];
        [orderDetails setObject:[[tableDetails objectAtIndex:tablePositionInt] valueForKey:TABLE_NUMBER] forKey:SALES_LOCATION];

        
        NSDictionary *temp = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",past_order_no],[[tableDetails objectAtIndex:tablePositionInt] valueForKey:TABLE_NUMBER],presentLocation,@"Occupied", nil] forKeys:[NSArray arrayWithObjects:LEVEL,kAllotedTableNo,@"location",STATUS, nil]];
        
        selectedTablesArr = [NSMutableArray arrayWithObject:temp];
        
        [orderDetails setObject:selectedTablesArr forKey:kListOfTables];
        [orderDetails setObject:_genderTxt.text forKey:CUSTOMER_GENDER];
        [orderDetails setObject:_vehicleNo.text forKey:CAR_NUMBER];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * updateBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [HUD setHidden:NO];
        
        if(!isOfflineService) {
            
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setRestaurantBookingServiceDelegate:self];
            [controller updateRestBooking:updateBookingJsonStr];
        }
        
        //commented by roja on 11/01/2019..
        // reason offline work need to be doe.
//        else {
//            offlineService = [[RestBookingServices alloc] init];
//            BOOL allotStatus = FALSE;
//            allotStatus = [offlineService createOrder:orderDetails order_id:orderRef];
//            if (allotStatus) {
//                [HUD setHidden:YES];
//                success = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TableAllocationSuccess", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                [success show];
//            }
//            else {
//                [HUD setHidden:YES];
//
//                UIAlertView    *failure = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TableAllocationFailed", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                [failure show];
//
//            }
//        }

    }
    @catch (NSException *exception) {
       
        NSLog(@"%@",exception);
        
    }
}
-(void)updateBookingThroughButtonClick:(UIButton*)sender {

    
    AudioServicesPlaySystemSound (soundFileObject);

       NSString *status1 = sender.titleLabel.text;
        workFlowStateStr = sender.titleLabel.text;

    if ([workFlowStateStr caseInsensitiveCompare:@"Billed"]==NSOrderedSame) {
        
        //        UIButton *btn = [[UIButton alloc] init];
        //        [self goToBillingPageToGenerateBill:btn]; // generateBill

        [self checkingItemsStatus];
        
    }
    else if([workFlowStateStr caseInsensitiveCompare:@"Waiting"]==NSOrderedSame) {
        if (tableNo==nil || [tableNo isKindOfClass:[NSNull class]] || tableNo.length==0) {
            
           allotTableAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Allocate Table", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [allotTableAlert show];
        }
        else {
            [self updateBooking:status1];
        }
    }
    else {
        [self updateBooking:status1];
    }

}

/**
 * @description
 * @date            02/03/19
 * @method          checkingItemsStatus
 * @author          Roja
 * @param
 * @param
 * @return          void
 * @verified By
 * @verified On
 */
// added by roja on 01/03/2019...
-(void)checkingItemsStatus{
    
    BOOL itemsServed = false;
    
    if (![[orderDetailsInfoDic valueForKey:@"OrderedItems"] isKindOfClass:[NSNull class]] ) {
        
        NSMutableArray * orderedItemsArr = [orderDetailsInfoDic valueForKey:@"OrderedItems"];
        
        if ([orderedItemsArr count]) {
            
            for (NSDictionary * itemDetailsDic in orderedItemsArr) {
                
                NSString * itemStatus = [self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:@"status"] defaultReturn:@""];
                
                if ([itemStatus caseInsensitiveCompare:@"Served"] == NSOrderedSame  ||  [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:kIsManuFacturedItem]  defaultReturn:ZERO_CONSTANT] boolValue]) {
                    itemsServed = true;
                }
                else{
                    break;
                }
            }
            if (itemsServed) {
                
//                UIButton *btn = [[UIButton alloc] init];
 //        [self goToBillingPageToGenerateBill:btn]; // generateBill

                [self goToBillingPageToGenerateBill];
                
            }
            else{
                
                float y_axis = self.view.frame.size.height - 120;
                NSString * msg = @"All the items need to be served before bill.";
                [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
                
            }
        }
        else{
            
            float y_axis = self.view.frame.size.height - 120;
            NSString * msg = @"Please add items from Dine In.";
            [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    }
}



- (IBAction)generateBill:(UIButton *)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    if([[statusArr objectAtIndex:0] caseInsensitiveCompare:@"billed"] == NSOrderedSame) {
        
        [self checkingItemsStatus];
    }
    else {
      
        float y_axis = self.view.frame.size.height - 120;
        NSString * msg = @"Billing cannot be done at this time";
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    
}

-(void)goToBillingPageToGenerateBill{
    
    if(orderRef == nil)
        orderRef = @"";
    if(bookingTypeStr == nil)
        bookingTypeStr = @"";
    
    if(bookingTypeStr != nil)
        if(!bookingTypeStr.length)
            bookingTypeStr = @"Telephone";
    
    BillingHome *billing = [[BillingHome alloc] init];
    billing.salesOrderIdStr = orderRef;
    billing.salesOrderBookingTypeStr = bookingTypeStr;
    billing.isOrderedBill = true;
    
    
    // comment by roja on 11/01/2019..
    // reason Need to work on billing slow...
    //        billing.cartItem = [[NSMutableArray alloc] init];
    //        billing.order_id = orderRef;
    //        billing.order_type = @"immediate";
    //        billing.waiter_name = @"Ramesh";
    //        billing.table = @"table2";
    //        billing.emailTxt = [[UITextField alloc] init];
    //        billing.emailTxt.text = _customerEmailTxt.text;
    //        billing.phoneTxt = [[UITextField alloc] init];
    //        billing.phoneTxt.text = _mobileNo.text;
    //        billing.order_date = _reservationDate.text;
    //        billing.slot = _slotId.text;
    
    // upto here commented by roja on 11/01/2019..
    
    
    //        if ([orderType isEqualToString:@"take_away"]) {
    //
    //            billing.ship_add1 = shipAdd1.text;
    //            billing.ship_add2 = shipAdd2.text;
    //        }
    
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    [self.navigationController pushViewController:billing animated:YES];
    
}

// Don't delete may be used for futher ...

//- (IBAction)generateBill:(UIButton *)sender {
//
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    if([[statusArr objectAtIndex:0] caseInsensitiveCompare:@"billed"] == NSOrderedSame) {
//
//        if(orderRef == nil)
//            orderRef = @"";
//        if(bookingTypeStr == nil)
//            bookingTypeStr = @"";
//
//        if(bookingTypeStr != nil)
//            if(!bookingTypeStr.length)
//                bookingTypeStr = @"Telephone";
//
//        BillingHome *billing = [[BillingHome alloc] init];
//        billing.salesOrderIdStr = orderRef;
//        billing.salesOrderBookingTypeStr = bookingTypeStr;
//        billing.isOrderedBill = true;
//
//
//        // comment by roja on 11/01/2019..
//        // reason Need to work on billing slow...
//        //        billing.cartItem = [[NSMutableArray alloc] init];
//        //        billing.order_id = orderRef;
//        //        billing.order_type = @"immediate";
//        //        billing.waiter_name = @"Ramesh";
//        //        billing.table = @"table2";
//        //        billing.emailTxt = [[UITextField alloc] init];
//        //        billing.emailTxt.text = _customerEmailTxt.text;
//        //        billing.phoneTxt = [[UITextField alloc] init];
//        //        billing.phoneTxt.text = _mobileNo.text;
//        //        billing.order_date = _reservationDate.text;
//        //        billing.slot = _slotId.text;
//
//        // upto here commented by roja on 11/01/2019..
//
//
//        //        if ([orderType isEqualToString:@"take_away"]) {
//        //
//        //            billing.ship_add1 = shipAdd1.text;
//        //            billing.ship_add2 = shipAdd2.text;
//        //        }
//
//
//        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
//
//        [self.navigationController pushViewController:billing animated:YES];
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Billing cannot be done at this time" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//
//}

/**
 * @description     update the booking
 * @date            17/12/15
 * @method          updateBooking
 * @author           Sonali
 * @param           sender
 * @param
 * @return
 * @verified By
 * @verified On
 */
-(void)updateBooking:(NSString*)status1
{
    
    @try {
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString* currentdate = [f stringFromDate:today];
        
        NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
        NSMutableArray *temparr = [[NSMutableArray alloc]init];
        
        [orderDetails setObject:orderRef forKey:ORDER_REFERENCE];
        [orderDetails setObject:@"immediate" forKey:ORDER_TYPE];
        [orderDetails setObject:currentdate forKey:Order_Date];
        [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [orderDetails setObject:custNameTxt.text forKey:CUSTOMER_NAME];
        [orderDetails setObject:lastNameTF.text forKey:@"lastName"];
        [orderDetails setObject:self.customerEmailTxt.text forKey:CUSTOMER_MAIL];
        [orderDetails setObject:_slotId.text forKey:SLOT_ID];
        [orderDetails setObject:_reservationModeTxt.text forKey:RESERVATION_TYPE_ID];
        [orderDetails setObject:[NSNumber numberWithInt:[_vegCountTxt.text intValue]] forKey:NO_OF_VEG_ADULTS];
        [orderDetails setObject:[NSNumber numberWithInt:[_nonvegCountTxt.text intValue]] forKey:NO_OF_NON_VEG_ADULTS];
        [orderDetails setObject:[NSNumber numberWithInt:[_childrenVegCount.text intValue]] forKey:NO_OF_VEG_CHILDREN];
        [orderDetails setObject:[NSNumber numberWithInt:[_childrenNonVegCount.text intValue]] forKey:NO_OF_NON_VEG_CHILDREN];
        [orderDetails setObject:[NSNumber numberWithInt:[_alcoholCountTxt.text intValue]] forKey:NO_OF_ALCOHOLIC];
        [orderDetails setObject:[NSNumber numberWithInt:[_nonAlcoholCountTxt.text intValue]] forKey:NO_OF_NON_ALCOHOLIC];
        
        [orderDetails setObject:[NSNumber numberWithInt:[self.noOfAdultsTxt.text intValue]] forKey:ADULT_PAX];
        [orderDetails setObject:[NSNumber numberWithInt:[self.noOfChildsTxt.text intValue]] forKey:CHILD_PAX];
        [orderDetails setObject:[occasionsDic valueForKey:occasionTxt.text] forKey:OCCASION_ID];
        [orderDetails setObject:occasionTxt.text forKey:OCCASION_DESC];
        [orderDetails setObject:_reservationDate.text forKey:RESERVATION_DATE_TIME_STR];
        [orderDetails setObject:_specialInstructionsTxtView.text forKey:SPECIAL_INSTRUCTIONS];
        [orderDetails setObject:_mobileNo.text forKey:MOBILE_NUMBER];
        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:Grand_Total_D_1];
        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:TAX];
        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:SUB_TOTAL];
        
        [orderDetails setObject:presentLocation forKey:STORE_LOCATION];
        [orderDetails setObject:[NSNumber numberWithBool:NO] forKey:kIsTableChange];
        [orderDetails setObject:status1 forKey:STATUS];
        
        // added by roja on 11/09/2019....
        NSMutableArray * orderedItemsArr = [[NSMutableArray alloc]init];
        
        if ([orderDetailsInfoDic valueForKey:@"OrderedItems"] != nil && [[orderDetailsInfoDic valueForKey:@"OrderedItems"] count]) {
           orderedItemsArr = [orderDetailsInfoDic valueForKey:@"OrderedItems"];
        }
        
        [orderDetails setObject:orderedItemsArr forKey:@"OrderedItems"];  // OrderedItems  ORDERED_ITEMSLIST

//        [orderDetails setObject:temparr forKey:kItemDetails];
        [orderDetails setObject:_genderTxt.text forKey:CUSTOMER_GENDER];
        [orderDetails setObject:_vehicleNo.text forKey:CAR_NUMBER];
        
        if ([orderDetailsInfoDic valueForKey:@"salesLocation"]!=nil && ![[orderDetailsInfoDic valueForKey:@"salesLocation"] isKindOfClass:[NSNull class]]) {
            [orderDetails setObject:[orderDetailsInfoDic valueForKey:@"salesLocation"] forKey:@"salesLocation"];
        }
        
        // commented by roja on 11/01/2019..
        // reason offline work ...
//        if (![tableNo isKindOfClass:[NSNull class]] && tableNo!=nil) {
//            [orderDetails setObject:tableNo forKey:SALES_LOCATION];
//
//            NSString *level = @"";
//            RestBookingServices *services = [[RestBookingServices alloc] init];
//            level = [services getTheLevelInfoOf:tableNo];
//            NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:level,tableNo,presentLocation,status1, nil] forKeys:[NSArray arrayWithObjects:LEVEL,kAllotedTableNo,@"location",STATUS, nil]];
//
//            NSMutableArray  *allocatedTablesArr = [NSMutableArray arrayWithObject:temp];
//
//            [orderDetails setObject:allocatedTablesArr forKey:kListOfTables];
//        }
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * updateBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [HUD setHidden:NO];
        
        if (!isOfflineService) {
            
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setRestaurantBookingServiceDelegate:self];
            [controller updateRestBooking:updateBookingJsonStr];
        }
        
        // commented by roja on 11/01/2019..
        // reason Offline work need to be done.
//        else {
//            offlineService = [[RestBookingServices alloc] init];
//            BOOL updateStatus = FALSE;
//            updateStatus = [offlineService createOrder:orderDetails order_id:orderRef];
//            if (updateStatus) {
//                [HUD setHidden:YES];
//                success = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"BookingUpdationSuccess", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                [success show];
//            }
//            else {
//                [HUD setHidden:YES];
//
//                UIAlertView    *failure = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"BookingUpdationFailed", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                [failure show];
//
//            }
//        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    
    
    //    }
}
#pragma -mark service delegates
-(void)updateBookingSuccess:(NSDictionary *)successDictionary {
    
    [HUD setHidden:YES];
    if(isTableAllocated) {
        
        if(isDirectTableBooking){
            
            float y_axis = self.view.frame.size.height - 120;
            NSString * msg = @"Table Allocated Successfully";
            [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@"SUCCESS"  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        else{
            success = [[UIAlertView alloc] initWithTitle:@"Table Allocated Successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [success show];
        }
    }
    else if (isCancellation) {
        
    }
    else {
        success = [[UIAlertView alloc] initWithTitle:@"Booking Updated Successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [success show];

    }
   
}

-(void)updateBookingFailure:(NSString *)failureString {
    
    [HUD setHidden:YES];
    
    float y_axis = self.view.frame.size.height/2;
    NSString * msg = @"Booking Updation failed";
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    
}


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
            
            
            userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
            
        }
        else{
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
            
            if(isDirectTableBooking){
                ServiceOrders * serviceOrdesPage  = [[ServiceOrders alloc]init];
                [self.navigationController pushViewController:serviceOrdesPage animated:YES];
            }
            else
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

-(void)backAction {

    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
