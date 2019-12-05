//
//  KitchenOrderToken.m
//  OmniRetailer
//
//  Created by MACPC on 1/25/16.
//
//

#import "KitchenOrderToken.h"

@interface KitchenOrderToken ()
    
@end

@implementation KitchenOrderToken
@synthesize locationTxt,chefNameTxt,dateTxt,orderTypeTF,statusTF,menuCategoryTF,tableIdTF;
@synthesize sNoLbl,tableNoLbl,categoryLbl,orderTypeLbl,actionLbl,orderStatusLbl,qtyLbl,additionalLbl,itemNameLbl,orderTypeTableLbl;
@synthesize orderItemsTbl,scrollView,searchBtn,clearBtn;
@synthesize S1Lbl,S2Lbl,S3Lbl,soundFileObject,soundFileURLRef;



//@synthesize soundFileURLRef,soundFileObject;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleLabel.text = NSLocalizedString(@"KOT", nil);
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    
//    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
//    self.soundFileURLRef = (__bridge CFURLRef) [tapSound retain];
//    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:20.0 cornerRadius:8.0];
    
//    orderItemsTbl.tableFooterView  = [[UIView alloc] initWithFrame:CGRectZero];
//    [orderItemsTbl setSeparatorStyle:UITableViewCellSelectionStyleNone];
//    [orderItemsTbl setSeparatorColor:[[UIColor grayColor] colorWithAlphaComponent:0.4]];
    
    [orderItemsTbl setSeparatorColor:[[UIColor grayColor] colorWithAlphaComponent:0.4]];
    [orderItemsTbl setDataSource:self];
    [orderItemsTbl setDelegate:self];
    orderItemsTbl.backgroundColor = [UIColor clearColor];
    orderItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    sNoLbl.layer.cornerRadius = 8.0f;
    sNoLbl.clipsToBounds=YES;
    categoryLbl.layer.cornerRadius = 8.0f;
    categoryLbl.clipsToBounds=YES;
    tableNoLbl.layer.cornerRadius = 8.0f;
    tableNoLbl.clipsToBounds=YES;
   

    // added by roja on 01/02/2019.....
    actionLbl.layer.cornerRadius = 8.0f;
    actionLbl.clipsToBounds=YES;
    
    orderStatusLbl.layer.cornerRadius = 8.0f;
    orderStatusLbl.clipsToBounds=YES;
    
    qtyLbl.layer.cornerRadius = 8.0f;
    qtyLbl.clipsToBounds=YES;
    
    additionalLbl.layer.cornerRadius = 8.0f;
    additionalLbl.clipsToBounds=YES;
    
    itemNameLbl.layer.cornerRadius = 8.0f;
    itemNameLbl.clipsToBounds=YES;
    
    orderTypeTableLbl.layer.cornerRadius = 8.0f;
    orderTypeTableLbl.clipsToBounds=YES;
    
    locationTxt.text = presentLocation;
    chefNameTxt.text = firstName;
    
    
    orderTypeListTbl = [[UITableView alloc] init];
    orderTypeListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [orderTypeListTbl setDataSource:self];
    [orderTypeListTbl setDelegate:self];
    [orderTypeListTbl.layer setBorderWidth:1.0f];
    orderTypeListTbl.layer.cornerRadius = 3;
    orderTypeListTbl.layer.borderColor = [UIColor grayColor].CGColor;
    orderTypeListTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    orderStatusListTbl = [[UITableView alloc] init];
    orderStatusListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [orderStatusListTbl setDataSource:self];
    [orderStatusListTbl setDelegate:self];
    [orderStatusListTbl.layer setBorderWidth:1.0f];
    orderStatusListTbl.layer.cornerRadius = 3;
    orderStatusListTbl.layer.borderColor = [UIColor grayColor].CGColor;
    orderStatusListTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    menuCategoryTbl = [[UITableView alloc] init];
    menuCategoryTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [menuCategoryTbl setDataSource:self];
    [menuCategoryTbl setDelegate:self];
    [menuCategoryTbl.layer setBorderWidth:1.0f];
    menuCategoryTbl.layer.cornerRadius = 3;
    menuCategoryTbl.layer.borderColor = [UIColor grayColor].CGColor;
    menuCategoryTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    tableIdListTbl = [[UITableView alloc] init];
    tableIdListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [tableIdListTbl setDataSource:self];
    [tableIdListTbl setDelegate:self];
    [tableIdListTbl.layer setBorderWidth:1.0f];
    tableIdListTbl.layer.cornerRadius = 3;
    tableIdListTbl.layer.borderColor = [UIColor grayColor].CGColor;
    tableIdListTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // upto here added by roja on 01/02/2019

    dateTxt.text = [WebServiceUtility getCurrentDate];
    locationTxt.backgroundColor = [UIColor whiteColor];
    chefNameTxt.backgroundColor = [UIColor whiteColor];
    dateTxt.backgroundColor = [UIColor whiteColor];
    
    orderTypeTF.backgroundColor = [UIColor whiteColor];
    statusTF.backgroundColor = [UIColor whiteColor];
    menuCategoryTF.backgroundColor = [UIColor whiteColor];
    tableIdTF.backgroundColor = [UIColor whiteColor];

    locationTxt.borderStyle = UITextBorderStyleRoundedRect;
    chefNameTxt.borderStyle = UITextBorderStyleRoundedRect;
    dateTxt.borderStyle = UITextBorderStyleRoundedRect;
    orderTypeTF.borderStyle = UITextBorderStyleRoundedRect;
    statusTF.borderStyle = UITextBorderStyleRoundedRect;
    menuCategoryTF.borderStyle = UITextBorderStyleRoundedRect;
    tableIdTF.borderStyle = UITextBorderStyleRoundedRect;
    
    searchBtn.layer.cornerRadius = 10;
    searchBtn.clipsToBounds=YES;
    clearBtn.layer.cornerRadius = 10;
    clearBtn.clipsToBounds=YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
//    orderStatusListArr = [NSMutableArray arrayWithObjects:@"All",@"Ordered",@"getting prepepared",@"ready from kitchen",@"served", nil]; //@"Ordered",@"Confirmed"

    //    orderTypeListArr = [NSMutableArray arrayWithObjects:@"All",@"Table",@"Take Away",nil];
    orderTypeTF.placeholder = @"Table/Take Away";
    orderTypeListArr = [NSMutableArray arrayWithObjects:@"Table",@"Take Away",nil];

    statusTF.text = @"";
    orderStatusStr = @"";
    orderTypeRefString = @"Table";
    menuCategoryStr = @"";
    tableIdStr = @"";
    orderTypeTF.text = @"Table";
//    orderType = @"Table";
    
    
    NSDate * today = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];  //HH:mm:ss
    NSString* currentdate = [dateFormatter stringFromDate:today];
    
    dateTxt.text = currentdate;
//    orderDateStr = currentdate;
    
    dateTxt.tag = 0;

    // commented by roja any of the method can be used...
//    [self getallLayoutTableDetails:@"1"];
    
    [self getAllAvailableTables];
    [self callingGetItemDetails];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)getAllAvailableTables{
    
    @try {
        [HUD setHidden:NO];
        
        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:presentLocation,[RequestHeader getRequestHeader], nil] forKeys:[NSArray arrayWithObjects:@"location",REQUEST_HEADER, nil]];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getAvailableTablesStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *controller = [[WebServiceController alloc] init];
        [controller setStoreServiceDelegate:self];
        [controller getAvailableTables:getAvailableTablesStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"Exception %@",exception);
    }
}


-(void)getAvailableTablesSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        tableIdArrList = [[NSMutableArray alloc] init];
        
        [tableIdArrList addObject:@"All"];
        for(NSDictionary * locDic in [successDictionary valueForKey:@"layout"]){
            
            [tableIdArrList addObject:[locDic valueForKey:@"tableNumber"]];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {

        [HUD setHidden:YES];
    }
}


-(void)getAvailableTablesErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        NSLog(@"get All Layout table Failure Response--- %@",errorResponse);
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}




-(void)getallLayoutTableDetails:(NSString*)level {
    
    @try {
        [HUD setHidden:NO];
        
        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:presentLocation,@"-1",[RequestHeader getRequestHeader],level, nil] forKeys:[NSArray arrayWithObjects:@"location",START_INDEX,REQUEST_HEADER,@"level", nil]];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *controller = [[WebServiceController alloc] init];
        [controller setStoreServiceDelegate:self];
        [controller getLayoutDetails:getBookingJsonStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"Exception %@",exception);
    }
}

-(void)getAllLayoutTablesSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        tableIdArrList = [[NSMutableArray alloc] init];
        
        [tableIdArrList addObject:@"All"];
        for(NSDictionary * locDic in [successDictionary valueForKey:@"tablesList"]){
            
            [tableIdArrList addObject:[locDic valueForKey:@"tableNumber"]];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


-(void)getAllLayoutTablesErrorResponse:(NSString *)failureString {
    
    @try {
        
        [HUD setHidden:YES];
        
        NSLog(@"get All Layout table Failure Response--- %@",failureString);
        
    } @catch (NSException *exception) {
        
    } @finally {
    }
}

- (IBAction)searchBtnAction:(id)sender {
    
    //    orderType = orderTypeTF.text;
    [self callingGetItemDetails];
}

//-(void)getItemDetailsInKOT:(NSString *)requestString;

-(void)callingGetItemDetails{
    
    @try {
        [HUD setHidden:NO];
        [HUD setLabelText:@"please wait.."];
        orderItemsArr = [[NSMutableArray alloc] init];
        
        NSString * itemStatusStr = orderStatusStr;  //statusTF.text
        NSString * orderTypeStr = orderTypeRefString; // orderTypeTF.text
        NSString * menuCategoryNameStr = menuCategoryStr;
        NSString * tableIdRefStr = tableIdStr;
        
        //        itemStatusStr = @"";
        //        orderTypeStr = @"";
        
        NSArray *keys = [NSArray arrayWithObjects:REQUEST_HEADER,@"store_location",@"status",@"order_type",@"orderDateStr",@"maxRecords",@"startIndex", nil];
        NSArray *objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader],presentLocation,itemStatusStr,orderTypeStr,dateTxt.text,@"20",ZERO_CONSTANT, nil];// maxRecords Dic used after pagenation functionality....
        
        keys = [NSArray arrayWithObjects:REQUEST_HEADER,@"store_location",@"status",@"order_type",@"orderDateStr",@"startIndex",@"category",@"tableNum", nil];
        objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader],presentLocation,itemStatusStr,orderTypeStr,dateTxt.text,@"-1",menuCategoryNameStr,tableIdRefStr, nil];
        //orderStatus,orderType,orderDateStr
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err];
        NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *controller = [[WebServiceController alloc] init];
        [controller setKotServiceDelegate:self];
        [controller getItemDetailsInKOT:getBookingJsonStr];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
    }
}




-(void)getItemsDetailsInKOTSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        for(NSDictionary * locDic in [successDictionary valueForKey:@"orderedItemsList"])
            [orderItemsArr addObject:locDic];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [orderItemsTbl reloadData];
    }
}


-(void)getItemsDetailsInKOTFailureResponse:(NSString *)failureString{
    
    @try {
        float y_axis = self.view.frame.size.height - 200;
        NSString * mesg = @"No Records Founds";
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [orderItemsTbl reloadData];
    }
}


- (IBAction)viewReport:(UIButton *)sender {
    
    float y_axis = self.view.frame.size.height/2;
    NSString * msg = NSLocalizedString(@"currently_this_feature_is_unavailable", nil);
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
}

- (IBAction)refreshOrders:(UIButton *)sender {
    
    [self callingGetItemDetails];
}

- (IBAction)viewReviews:(UIButton *)sender {
    
    float y_axis = self.view.frame.size.height/2;
    NSString * msg = NSLocalizedString(@"currently_this_feature_is_unavailable", nil);
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];

}
- (IBAction)closeView:(UIButton *)sender {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:NO];
}

#pragma -mark tableview delegates

/**
 * @description     It is one of dataSource method of TableView used to set no of sectios in a table.
 * @date            01/02/2019
 * @method          tableView:--  numberOfRowsInSection:--
 * @author          Roja
 * @param           UITableView
 * @param           NSInteger
 * @return          (NSInteger)
 * @verified By
 * @verified On
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    if(tableView == orderItemsTbl){
        
        return  1;
    }
    else
    return 1;
}

/**
 * @description     It is one of dataSource method of TableView used to set no of the rows in a table.
 * @date            01/02/2019
 * @method          tableView:--  numberOfRowsInSection:--
 * @author          Roja
 * @param           UITableView
 * @param           NSInteger
 * @return          (NSInteger)
 * @verified By
 * @verified On
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == orderItemsTbl){
        int cellsCount = 0;
        @try {
            if([orderItemsArr count])
            cellsCount = (int)[orderItemsArr count];
        } @catch (NSException *exception) {
            
        }
        return cellsCount;
    }
    else if(tableView == orderTypeListTbl){
        return [orderTypeListArr count];
    }
    else if(tableView == orderStatusListTbl){
        return [orderStatusListArr count];
    }
    else if(tableView == menuCategoryTbl){
        return [menuCategoryNamesArr count];
    }
    else if(tableView == tableIdListTbl){
        return [tableIdArrList count];
    }
    else
        return 0;
}


/**
 * @description     It is one of delegate method of TableView used to set height of the  table cell.
 * @date            01/02/2019
 * @method          tableView:--  heightForRowAtIndexPath:--
 * @author          Roja
 * @param           UITableView
 * @param           NSIndexPath
 * @return          (CGFloat)
 * @verified By
 * @verified On
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 40.0;
    }
    return 40.0;
    
}

/**
 * @description     It is one of datasource method of TableView used to set the data for a particular cell.
 * @date            01/02/2019
 * @method          tableView:--  cellForRowAtIndexPath:--
 * @author          Roja
 * @param           UITableView
 * @param           NSIndexPath
 * @return          UITableViewCell
 * @verified By
 * @verified On
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == orderItemsTbl) {
        
        tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];

        static NSString * MyIdentifier = @"MyIdentifier";
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil){
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
//            }
//            else {
//                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
//            }
        }
        
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        [hlcell setBackgroundColor:[UIColor blackColor]];
        
        
        UILabel * localSnoLbl;
        UILabel * localTableNoLbl;
        UILabel * localCategoryLbl;
        
        // added by roja on 01/02/2019...
        UILabel * orderTypeLbl;
        UILabel * itemNameValueLbl;
        UILabel * additionalValueLbl;
        UILabel * qtyValueLbl;
        UILabel * statusValueLbl;
        UILabel * actionValueLbl;
        UIButton * changeStatusBtn;

        localSnoLbl = [[UILabel alloc] init];
        localSnoLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        localSnoLbl.backgroundColor = [UIColor blackColor];
        localSnoLbl.textAlignment = NSTextAlignmentCenter;
        localSnoLbl.numberOfLines = 2;
        localSnoLbl.lineBreakMode = NSLineBreakByWordWrapping;
        localSnoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        localSnoLbl.layer.borderWidth = 1.5;
//        localSnoLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        
        localTableNoLbl = [[UILabel alloc] init];
        localTableNoLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        localTableNoLbl.backgroundColor = [UIColor blackColor];
        localTableNoLbl.textAlignment = NSTextAlignmentCenter;
        localTableNoLbl.numberOfLines = 2;
        localTableNoLbl.lineBreakMode = NSLineBreakByWordWrapping;
        localTableNoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        localTableNoLbl.layer.borderWidth = 1.5;
//        localTableNoLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

        localCategoryLbl = [[UILabel alloc] init];
        localCategoryLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        localCategoryLbl.backgroundColor = [UIColor blackColor];
        localCategoryLbl.textAlignment = NSTextAlignmentCenter;
        localCategoryLbl.numberOfLines = 2;
        localCategoryLbl.lineBreakMode = NSLineBreakByWordWrapping;
        localCategoryLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        localCategoryLbl.layer.borderWidth = 1.5;
//        localCategoryLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

        // added by roja on 01/02/2019...
        orderTypeLbl = [[UILabel alloc] init];
        orderTypeLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        orderTypeLbl.backgroundColor = [UIColor blackColor];
        orderTypeLbl.textAlignment = NSTextAlignmentCenter;
        orderTypeLbl.numberOfLines = 2;
        orderTypeLbl.lineBreakMode = NSLineBreakByWordWrapping;
        orderTypeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        orderTypeLbl.layer.borderWidth = 1.5;
//        orderTypeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        
        itemNameValueLbl = [[UILabel alloc] init];
        itemNameValueLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        itemNameValueLbl.backgroundColor = [UIColor blackColor];
        itemNameValueLbl.textAlignment = NSTextAlignmentCenter;
        itemNameValueLbl.numberOfLines = 2;
        itemNameValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
        itemNameValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        itemNameValueLbl.layer.borderWidth = 1.5;
//        itemNameValueLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
      
        additionalValueLbl = [[UILabel alloc] init];
        additionalValueLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        additionalValueLbl.backgroundColor = [UIColor blackColor];
        additionalValueLbl.textAlignment = NSTextAlignmentCenter;
        additionalValueLbl.numberOfLines = 2;
        additionalValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
        additionalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        additionalValueLbl.layer.borderWidth = 1.5;
//        additionalValueLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

        qtyValueLbl = [[UILabel alloc] init];
        qtyValueLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        qtyValueLbl.backgroundColor = [UIColor blackColor];
        qtyValueLbl.textAlignment = NSTextAlignmentCenter;
        qtyValueLbl.numberOfLines = 2;
        qtyValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
        qtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        qtyValueLbl.layer.borderWidth = 1.5;
//        qtyValueLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

        statusValueLbl = [[UILabel alloc] init];
        statusValueLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        statusValueLbl.backgroundColor = [UIColor blackColor];
        statusValueLbl.textAlignment = NSTextAlignmentCenter;
        statusValueLbl.numberOfLines = 2;
        statusValueLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        statusValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        statusValueLbl.layer.borderWidth = 1.5;
//        statusValueLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

        actionValueLbl = [[UILabel alloc] init];
        actionValueLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        actionValueLbl.backgroundColor = [UIColor blackColor];
        actionValueLbl.textAlignment = NSTextAlignmentCenter;
        actionValueLbl.numberOfLines = 2;
        actionValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
        actionValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
//        actionValueLbl.layer.borderWidth = 1.5;
//        actionValueLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

        changeStatusBtn = [[UIButton alloc] init] ;
        changeStatusBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        changeStatusBtn.layer.borderWidth = 1.5;
        changeStatusBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        changeStatusBtn.frame = CGRectMake(176, 0, 58, 34);
        changeStatusBtn.backgroundColor = [UIColor blackColor];
        changeStatusBtn.titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        changeStatusBtn.userInteractionEnabled = YES;
        
        
        [hlcell.contentView addSubview:localSnoLbl];
        [hlcell.contentView addSubview:localTableNoLbl];
        [hlcell.contentView addSubview:localCategoryLbl];
        [hlcell.contentView addSubview:orderTypeLbl];
        [hlcell.contentView addSubview:itemNameValueLbl];
        [hlcell.contentView addSubview:additionalValueLbl];
        [hlcell.contentView addSubview:qtyValueLbl];
        [hlcell.contentView addSubview:statusValueLbl];
        [hlcell.contentView addSubview:actionValueLbl];
        [hlcell.contentView addSubview:changeStatusBtn];

//        float gapWidth = tableNoLbl.frame.origin.x - (sNoLbl.frame.origin.x + sNoLbl.frame.size.width);
        
        localSnoLbl.frame = CGRectMake( 0, 0, sNoLbl.frame.size.width, 40);
        
        orderTypeLbl.frame = CGRectMake( localSnoLbl.frame.origin.x + localSnoLbl.frame.size.width + 0.5, 0, orderTypeTableLbl.frame.size.width, localSnoLbl.frame.size.height);

        localTableNoLbl.frame = CGRectMake( orderTypeLbl.frame.origin.x + orderTypeLbl.frame.size.width + 0.5, 0, tableNoLbl.frame.size.width, localSnoLbl.frame.size.height);

        localCategoryLbl.frame = CGRectMake( localTableNoLbl.frame.origin.x + localTableNoLbl.frame.size.width + 0.5, 0, categoryLbl.frame.size.width , localSnoLbl.frame.size.height);

        itemNameValueLbl.frame = CGRectMake( localCategoryLbl.frame.origin.x + localCategoryLbl.frame.size.width + 0.5, 0, itemNameLbl.frame.size.width, localSnoLbl.frame.size.height);

        additionalValueLbl.frame = CGRectMake( itemNameValueLbl.frame.origin.x + itemNameValueLbl.frame.size.width + 0.5, 0, additionalLbl.frame.size.width, localSnoLbl.frame.size.height);

        qtyValueLbl.frame = CGRectMake( additionalValueLbl.frame.origin.x + additionalValueLbl.frame.size.width + 0.5, 0, qtyLbl.frame.size.width, localSnoLbl.frame.size.height);
        
        statusValueLbl.frame = CGRectMake( qtyValueLbl.frame.origin.x + qtyValueLbl.frame.size.width + 0.5, 0, orderStatusLbl.frame.size.width, localSnoLbl.frame.size.height);
        
        actionValueLbl.frame = CGRectMake( statusValueLbl.frame.origin.x + statusValueLbl.frame.size.width + 0.5, 0, actionLbl.frame.size.width, localSnoLbl.frame.size.height);
      
        changeStatusBtn.frame = CGRectMake( actionValueLbl.frame.origin.x + actionValueLbl.frame.size.width/2 - (actionValueLbl.frame.size.height - 4)/2, 2, actionValueLbl.frame.size.height - 4, actionValueLbl.frame.size.height - 4);
        changeStatusBtn.layer.cornerRadius = changeStatusBtn.frame.size.height/2;

        
        @try {
          
            NSDictionary * tempItemDic = [orderItemsArr objectAtIndex:indexPath.row];
            
            localSnoLbl.text = [NSString stringWithFormat:@"%i", (1 + (int)indexPath.row)];
            localTableNoLbl.text = [self checkGivenValueIsNullOrNil:[tempItemDic valueForKey:@"tableNumber"] defaultReturn:@"0"];
            localCategoryLbl.text = [self checkGivenValueIsNullOrNil:[tempItemDic valueForKey:ITEM_CATEGORY] defaultReturn:@"--"];
            orderTypeLbl.text = [self checkGivenValueIsNullOrNil:orderTypeTF.text defaultReturn:@""]; //@"orderType"
            itemNameValueLbl.text = [self checkGivenValueIsNullOrNil:[tempItemDic valueForKey:@"item_name"] defaultReturn:@"--"];
            additionalValueLbl.text = [self checkGivenValueIsNullOrNil:[tempItemDic valueForKey:@""] defaultReturn:@"--"];
            qtyValueLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[tempItemDic valueForKey:@"ordered_quantity"] defaultReturn:@"0.00"] floatValue]];
            statusValueLbl.text = [self checkGivenValueIsNullOrNil:[tempItemDic valueForKey:@"status"] defaultReturn:@"--"];
            
            actionValueLbl.text = [self checkGivenValueIsNullOrNil:[tempItemDic valueForKey:@""] defaultReturn:@""];
            
            NSString * itemStatusStr = @"";

            itemStatusStr = [self checkGivenValueIsNullOrNil:[tempItemDic valueForKey:@"status"] defaultReturn:@""];

            changeStatusBtn.tag = indexPath.row;
            
            if ([itemStatusStr caseInsensitiveCompare:@"Ready From Kitchen"]==NSOrderedSame) {//ready from kitchen
                
                [changeStatusBtn setBackgroundColor:[UIColor greenColor]];
                
                //                [changeStatusBtn addTarget:self action:@selector(updateItemStatusToServed:) forControlEvents:UIControlEventTouchUpInside];
                // commented by roja on 15/02/2019...
                // Reason "ready from kitchen" status should not update..
                //                [changeStatusBtn addTarget:self action:@selector(updateItemGettingReddyStatus:) forControlEvents:UIControlEventTouchUpInside];
            }
           else if ([itemStatusStr caseInsensitiveCompare:@"Getting Prepared"]==NSOrderedSame) {//getting prepepared
                
//                [changeStatusBtn addTarget:self action:@selector(updateItemGettingReddyFromKitchenStatus:) forControlEvents:UIControlEventTouchUpInside];
                [changeStatusBtn addTarget:self action:@selector(updateItemGettingReddyStatus:) forControlEvents:UIControlEventTouchUpInside];
                [changeStatusBtn setBackgroundColor:[UIColor orangeColor]];
            }
            else if (([itemStatusStr caseInsensitiveCompare:ORDERED ]==NSOrderedSame)) { // @"confirmed"

                [changeStatusBtn addTarget:self action:@selector(updateItemGettingReddyStatus:) forControlEvents:UIControlEventTouchUpInside];
                [changeStatusBtn setBackgroundColor:[UIColor blueColor]];
            }
            else if (([itemStatusStr caseInsensitiveCompare:@"Served"]==NSOrderedSame) || !itemStatusStr.length) {
                
                [changeStatusBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:252.0/255.0 blue:72.0/255.0 alpha:1.0]];
            }
//            else if (([itemStatusStr caseInsensitiveCompare:@"ordered"]==NSOrderedSame) || !itemStatusStr.length) {
//
//                [changeStatusBtn setBackgroundColor:[UIColor clearColor]];
//            }

        } @catch (NSException *exception) {
            
        }
        
        return hlcell;
    }
    
    else if (tableView == orderTypeListTbl) {
        
        tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
        static NSString * MyIdentifier = @"MyIdentifier1";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil){
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            }
        }
        
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[orderTypeListArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;

    }
    else if(tableView == orderStatusListTbl){
        
        tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
        
        static NSString * MyIdentifier = @"MyIdentifier2";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil){
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[orderStatusListArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
    else if (tableView == tableIdListTbl) {
        
        tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
        
        static NSString * MyIdentifier = @"MyIdentifier1";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil){
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            }
        }
        
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[tableIdArrList objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
        
    }
    else if(tableView == menuCategoryTbl){
        
        tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
        
        static NSString * MyIdentifier = @"MyIdentifier2";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil){
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            }
        }
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[menuCategoryNamesArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == orderTypeListTbl) {
        
        orderTypeTF.text = [orderTypeListArr objectAtIndex:indexPath.row];
        orderTypeRefString = orderTypeTF.text;
        
//        if (indexPath.row == 0) {
//            orderTypeRefString = @"";
//        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
//        [orderItemsTbl reloadData];
    }
    else if(tableView == orderStatusListTbl){
        
        statusTF.text = [orderStatusListArr objectAtIndex:indexPath.row];
        orderStatusStr = statusTF.text;

        if (indexPath.row == 0) {
            orderStatusStr = @"";
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
//        [orderItemsTbl reloadData];
    }
    else if(tableView == tableIdListTbl){
        
        tableIdTF.text = [tableIdArrList objectAtIndex:indexPath.row];
        tableIdStr = tableIdTF.text;
        
        if (indexPath.row == 0) {
            tableIdStr = @"";
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        //        [orderItemsTbl reloadData];
    }
    else if(tableView == menuCategoryTbl){
        
        menuCategoryTF.text = [menuCategoryNamesArr objectAtIndex:indexPath.row];
        menuCategoryStr = menuCategoryTF.text;
        
        if (indexPath.row == 0) {
            menuCategoryStr = @"";
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma -mark end of table delegates

-(void)goToHome
{
    OmniHomePage *home = [[OmniHomePage alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}


#pragma -mark methods used in
-(void)updateItemStatusToServed:(UIButton *)sender{
    
    @try {
        AudioServicesPlaySystemSound (soundFileObject);

        NSDictionary *   selectedItemDic = [orderItemsArr objectAtIndex:sender.tag];
        
        NSString * tableNumStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"tableNumber"] defaultReturn:@"0"];
        NSString * statusStr = @"Served";
        NSString * orderTypeStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:orderTypeTF.text] defaultReturn:orderTypeTF.text];
        NSString * orderRefStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"order_ref"] defaultReturn:@"0"];
        NSString * itemIdStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"skuId"] defaultReturn:@"0"];
        NSString * skuIdStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"skuId"] defaultReturn:@"0"];
        NSString * pluCodeStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"pluCode"] defaultReturn:@"0"];
        
        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],presentLocation,tableNumStr,statusStr,orderTypeStr,orderRefStr,itemIdStr,skuIdStr,pluCodeStr, nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,@"store_location",@"tableNum",@"status",@"order_type",@"order_ref",@"item_id",@"skuId",@"pluCode", nil]];
        
        
        [self callingUpdateItemStatus:reqDic];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)updateItemGettingReddyFromKitchenStatus:(UIButton *)sender{

    @try {
        AudioServicesPlaySystemSound (soundFileObject);

        NSDictionary *   selectedItemDic = [orderItemsArr objectAtIndex:sender.tag];

        NSString * tableNumStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"tableNumber"] defaultReturn:@"0"];
        NSString * statusStr = @"ready from kitchen";
        NSString * orderTypeStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:orderTypeTF.text] defaultReturn:orderTypeTF.text];
        NSString * orderRefStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"order_ref"] defaultReturn:@"0"];
        NSString * itemIdStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"skuId"] defaultReturn:@"0"];
        NSString * skuIdStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"skuId"] defaultReturn:@"0"];
        NSString * pluCodeStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"pluCode"] defaultReturn:@"0"];

        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],presentLocation,tableNumStr,statusStr,orderTypeStr,orderRefStr,itemIdStr,skuIdStr,pluCodeStr, nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,@"store_location",@"tableNum",@"status",@"order_type",@"order_ref",@"item_id",@"skuId",@"pluCode", nil]];

        
        [self callingUpdateItemStatus:reqDic];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)updateItemGettingReddyStatus:(UIButton *)sender {
    
    @try {
        AudioServicesPlaySystemSound (soundFileObject);

        NSDictionary *   selectedItemDic = [orderItemsArr objectAtIndex:sender.tag];
        
        
        NSString * tableNumStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"tableNumber"] defaultReturn:@"0"];
        NSString * statusStr = @"Getting Prepared";
        statusStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"status"] defaultReturn:@"Ordered"];
        NSString * orderTypeStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:orderTypeTF.text] defaultReturn:orderTypeTF.text];
        NSString * orderRefStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"order_ref"] defaultReturn:@"0"];
        NSString * itemIdStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"skuId"] defaultReturn:@"0"];
        NSString * skuIdStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"skuId"] defaultReturn:@"0"];
        NSString * pluCodeStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"pluCode"] defaultReturn:@"0"];
        
        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],presentLocation,tableNumStr,statusStr,orderTypeStr,orderRefStr,itemIdStr,skuIdStr,pluCodeStr, nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,@"store_location",@"tableNum",@"status",@"order_type",@"order_ref",@"item_id",@"skuId",@"pluCode", nil]];
        
        [self callingUpdateItemStatus:reqDic];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)callingUpdateItemStatus:(NSDictionary *)itemDic{
    
    @try {
        [HUD setHidden:NO];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:itemDic options:0 error:&err];
        NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *controller = [[WebServiceController alloc] init];
        [controller setKotServiceDelegate:self];
        [controller updateKotStatus:getBookingJsonStr];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
    }
}

-(void)updateKotStatusSuccessResponse:(NSDictionary*)successDictionary{
    @try {

        [self callingGetItemDetails];

    } @catch (NSException *exception) {
        
    } @finally {
        
//        [HUD setHidden:YES];
    }
}
-(void)updateKotStatusFailureResponse:(NSString *)failureString{
    @try {
//        [HUD setHidden:YES];
     
        float y_axis = self.view.frame.size.height - 120;
        NSString * msg = failureString;
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        [self callingGetItemDetails];

    } @catch (NSException *exception) {
        
    } @finally {
        
//        [HUD setHidden:YES];
    }
}

//- (void)dealloc {
//    [_S1 release];
//    [_S2 release];
//    [_S3 release];
//    [super dealloc];
//}



- (IBAction)orderTypeListAction:(id)sender {

    AudioServicesPlaySystemSound(soundFileObject);

    PopOverViewController  * orderTakeAwayPopOverVC = [[PopOverViewController alloc] init];
    
    float tableHeight = 0;
    if([orderTypeListArr count] && [orderTypeListArr count]<3){
        
        tableHeight = [orderTypeListArr count] * 40;
    }
    else{
        tableHeight = 3 * 40;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHeight)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];

    orderTypeListTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);

    [customView addSubview:orderTypeListTbl];

    orderTakeAwayPopOverVC.view = customView;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        orderTakeAwayPopOverVC.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);

        orderTakeAwayPopOverVC.modalPresentationStyle = UIModalPresentationPopover;

        presentationPopOverController = [orderTakeAwayPopOverVC popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;

        presentationPopOverController.sourceView = self.view;
        presentationPopOverController.sourceRect = orderTypeTF.frame;
        [self presentViewController:orderTakeAwayPopOverVC animated:YES completion:nil];
    }

    else {

    }

    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];

    [orderTypeListTbl reloadData];
}




- (IBAction)menuCategoryPopUpBtnAction:(id)sender {
    
    @try {
        AudioServicesPlaySystemSound(soundFileObject);

        [self callMenuDetails];
        
        if ([menuCategoryNamesArr count] && menuCategoryNamesArr != nil) {
            
            float tableHeight = 0;
            if([menuCategoryNamesArr count] && [menuCategoryNamesArr count]<3){
                
                tableHeight = [menuCategoryNamesArr count] * 40;
            }
            else{
                tableHeight = 3 * 40;
            }
            
            PopOverViewController  * menuCategoryPopOverVC = [[PopOverViewController alloc] init];

            UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHeight)];
            customView.opaque = NO;
            customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            customView.layer.borderWidth = 2.0f;
            [customView setHidden:NO];
            
            menuCategoryTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
            [customView addSubview:menuCategoryTbl];
            
            menuCategoryPopOverVC.view = customView;
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                menuCategoryPopOverVC.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
                
                menuCategoryPopOverVC.modalPresentationStyle = UIModalPresentationPopover;
                
                presentationPopOverController = [menuCategoryPopOverVC popoverPresentationController];
                presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
                
                presentationPopOverController.sourceView = self.view;//
                presentationPopOverController.sourceRect = menuCategoryTF.frame;
                [self presentViewController:menuCategoryPopOverVC animated:YES completion:nil];
            }
            else {
                
            }
            
            UIGraphicsBeginImageContext(customView.frame.size);
            [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            customView.backgroundColor = [UIColor colorWithPatternImage:image];
            
            [menuCategoryTbl reloadData];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}




- (IBAction)statusListAction:(id)sender {
    
    @try {
        
        [self callingWorkFlowStatusDetails];

        if ([orderStatusListArr count] && orderStatusListArr != nil) {
            
            PopOverViewController  * orderStatusPopOverVC = [[PopOverViewController alloc] init];
            
            float tableHeight = 0;
            if([orderStatusListArr count] && [orderStatusListArr count]<3){
                
                tableHeight = [orderStatusListArr count] * 40;
            }
            else{
                tableHeight = 3 * 40;
            }
            
            UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHeight)];
            customView.opaque = NO;
            customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            customView.layer.borderWidth = 2.0f;
            [customView setHidden:NO];
            
            orderStatusListTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
            [customView addSubview:orderStatusListTbl];
            
            orderStatusPopOverVC.view = customView;
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                orderStatusPopOverVC.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
                
                orderStatusPopOverVC.modalPresentationStyle = UIModalPresentationPopover;
                
                presentationPopOverController = [orderStatusPopOverVC popoverPresentationController];
                presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
                
                presentationPopOverController.sourceView = self.view;//
                presentationPopOverController.sourceRect = statusTF.frame;
                [self presentViewController:orderStatusPopOverVC animated:YES completion:nil];
            }
            
            else {
                
            }
            
            UIGraphicsBeginImageContext(customView.frame.size);
            [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            customView.backgroundColor = [UIColor colorWithPatternImage:image];
            
            [orderStatusListTbl reloadData];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}



/**
 * @description  Clearing the All Data in searchTheProducts to get All The Records...
 * @date         31/03/2019
 * @method       clearBtnAction
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (IBAction)clearBtnAction:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        statusTF.text = @"";
        menuCategoryTF.text = @"";
        tableIdTF.text = @"";
        orderStatusStr = @"";
        menuCategoryStr = @"";
        tableIdStr = @"";
        
//        dateTxt.text   = @"";
//        orderTypeTF.text    = @"";
//        orderTypeRefString = @"";

        [self callingGetItemDetails];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}

- (IBAction)selectedDateButton:(id)sender {
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
        
        pickView.frame = CGRectMake( 15, dateTxt.frame.origin.y + dateTxt.frame.size.height, 320, 320);
        
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
        
        
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(populateDateToTextField:) forControlEvents:UIControlEventTouchUpInside];
        
//        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];

        
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
    
        
//        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        customerInfoPopUp.view = customView;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
            
            presentationPopOverController = [customerInfoPopUp popoverPresentationController];
            presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
            
            presentationPopOverController.sourceView = self.view;
            presentationPopOverController.sourceRect = dateTxt.frame;
            [self presentViewController:customerInfoPopUp animated:YES completion:nil];
            
        }
        
        else {
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

- (IBAction)populateTableIdList:(id)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    if ([tableIdArrList count] && tableIdArrList != nil) {
        
        PopOverViewController  * orderTakeAwayPopOverVC = [[PopOverViewController alloc] init];
        
        float tableHeight = 0;
        if([tableIdArrList count] && [tableIdArrList count]<3){
            
            tableHeight = [tableIdArrList count] * 40;
        }
        else{
            tableHeight = 3 * 40;
        }
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableIdTF.frame.size.width, tableHeight)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        tableIdListTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
        [customView addSubview:tableIdListTbl];
        
        orderTakeAwayPopOverVC.view = customView;
        
        orderTakeAwayPopOverVC.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        orderTakeAwayPopOverVC.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [orderTakeAwayPopOverVC popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        presentationPopOverController.sourceView = self.view;
        presentationPopOverController.sourceRect = tableIdTF.frame;
        [self presentViewController:orderTakeAwayPopOverVC animated:YES completion:nil];
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        [tableIdListTbl reloadData];
    }
    else{
        
        float y_axis = self.view.frame.size.height - 200;
        NSString * mesg = @"No data found";
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    
   
}


-(void)populateDateToTextField:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
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
            
            [self displayAlertMessage:NSLocalizedString(@"selected date should be less than current date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
            
        }
        
        dateTxt.text = dateString;

        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


-(void)clearDate:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        dateTxt.text = @"";
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in newOrderView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}


- (id)checkGivenValueIsNullOrNil:(id)inputValue defaultReturn:(NSString *)returnString{
    
    @try {
        if ([inputValue isKindOfClass:[NSNull class]] || inputValue == nil) {
            return returnString;
        }
        else {
            return inputValue;
        }
    } @catch (NSException *exception) {
        return @"--";
    }
}


-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines {
    
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


-(void)removeAlertMessages {
    @try {
        
        if(userAlertMessageLbl.tag == 4){
//            [self backAction];
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


-(void)callingWorkFlowStatusDetails{
    
    @try {
        [HUD setHidden:NO];
        [HUD setLabelText:@"please wait.."];
        
        NSArray *keys = [NSArray arrayWithObjects:REQUEST_HEADER,@"businessFlow",@"startIndex",@"serialNum",@"inventoryFlag",@"actionFlag", nil];
        
        NSArray *objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader], @"KOT",@"-1",ZERO_CONSTANT,ZERO_CONSTANT,ZERO_CONSTANT, nil]; // Booking Order
        
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


- (void)getWorkFlowsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        orderStatusListArr = [[NSMutableArray alloc]init];
        
        if ([successDictionary valueForKey:@"workFlowList"]) {
            
            [orderStatusListArr addObject:@"All"];
            
            for (NSDictionary *workFlowDic in [successDictionary valueForKey:@"workFlowList"]) {
                
                [orderStatusListArr addObject:[workFlowDic valueForKey:@"statusName"]];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
    
}


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




-(void)callMenuDetails{
    
    @try {
        
        [HUD setHidden:NO];
//        [HUD setLabelText:NSLocalizedString(@"getting_menu_details",nil)];
        
        NSMutableDictionary * menuDeatilsRequestDic = [[NSMutableDictionary alloc]init];
        
        [menuDeatilsRequestDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [menuDeatilsRequestDic setValue:presentLocation forKey:OUTLET_NAME];
        [menuDeatilsRequestDic setValue:presentLocation forKey:OUTLET_LOCATION];
        [menuDeatilsRequestDic setValue:ZERO_CONSTANT forKey:START_INDEX];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:menuDeatilsRequestDic options:0 error:&err];
        NSString * customerPurchasesRequestString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * serviceController = [WebServiceController new];
        serviceController.menuServiceDelegate = self;
        [serviceController getMenuDetailsInfo:customerPurchasesRequestString];
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}

-(void)callMenuCategoriesDetailsInfo:(NSString *)menuNameStr{
    
    @try {
        
        [HUD setHidden:NO];
      //  [HUD setLabelText:NSLocalizedString(@"getting_menu_details",nil)];
        
        NSMutableDictionary * menuDeatilsRequestDic = [[NSMutableDictionary alloc]init];
        
        [menuDeatilsRequestDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [menuDeatilsRequestDic setValue:presentLocation forKey:OUTLET_NAME];
        [menuDeatilsRequestDic setValue:presentLocation forKey:OUTLET_LOCATION];
        [menuDeatilsRequestDic setValue:menuNameStr forKey:MENU_NAME];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:menuDeatilsRequestDic options:0 error:&err];
        NSString * customerPurchasesRequestString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * serviceController = [WebServiceController new];
        serviceController.menuServiceDelegate = self;
        [serviceController getMenuCategoryDetailsInfo:customerPurchasesRequestString];
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}

-(void)getMenuDetailsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        NSMutableArray * menuNamesArr = [NSMutableArray new];
        
        for(NSDictionary * dic in [successDictionary valueForKey:MENU_CATEGORIES]){
            
            [menuNamesArr addObject:[dic valueForKey:MENU_NAME]];
        }
        if(menuNamesArr.count){
            
            //            [menuCategoriesDic setValue:menuNamesArr forKey:MENU_NAME];
            //            for(NSString * str in menuNamesArr)
            //                [self callMenuCategoriesDetailsInfo:str];
            [self callMenuCategoriesDetailsInfo:menuNamesArr[0]];
        }
        else{
            [HUD setHidden:YES];
        }
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
    } @finally {
        
    }
}
-(void)getMenuDeatilsErrorResponse:(NSString *)errorResponse{
    
    @try {
        float y_axis = self.view.frame.size.height/2;
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

-(void)getMenuCategoryDetailsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        menuCategoryNamesArr = [NSMutableArray new];
        [menuCategoryNamesArr addObject:ALL];
        
        for(NSDictionary * dic in [successDictionary valueForKey:MENU_CATEGORY_DETAILS]){
            [menuCategoryNamesArr addObject:[dic valueForKey:CATEGORY_NAME]];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

-(void)getMenuCategoryDeatilsErrorResponse:(NSString *)errorResponse{
    @try {
        
        float y_axis = self.view.frame.size.height/2;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}



@end
