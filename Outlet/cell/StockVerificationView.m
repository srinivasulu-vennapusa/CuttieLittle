//
//  StockVerificationView.m
//  OmniRetailer
//
//  Created by Sonali on 7/16/16.
//
//

#import "StockVerificationView.h"



@interface StockVerificationView ()

@end

@implementation StockVerificationView

@synthesize soundFileObject,soundFileURLRef;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) CFBridgingRetain(tapSound);
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    requiredVerifiedRecords = 20;
    stockVerifiedStartIndex = 0;
    
    self.titleLabel.text = @"VERIFIED STOCK DETAILS";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.dimBackground = YES;
    HUD.labelText = @"Please Wait \n Loading..";
    
    [HUD show:YES];
    [HUD setHidden:NO];
    
    salesDetailsView = [[UIScrollView alloc] init];
    salesDetailsView.backgroundColor = [UIColor clearColor];
    salesDetailsView.bounces = FALSE;
    
    salesDetailsTable = [[UITableView alloc] init];
    salesDetailsTable.backgroundColor = [UIColor clearColor];
    salesDetailsTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    //selectedSaleIdTable.layer.borderWidth = 1.0f;
    salesDetailsTable.bounces = TRUE;
    salesDetailsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    salesDetailsTable.hidden = NO;
    salesDetailsTable.dataSource = self;
    salesDetailsTable.delegate = self;
    [salesDetailsTable setContentOffset:CGPointMake(0,100) animated:YES];
    
    salesDetailsArray = [[NSMutableArray alloc] init];
    
    
    label_1 = [[UILabel alloc] init];
    
    label_1.layer.cornerRadius = 14;
    label_1.textAlignment = NSTextAlignmentCenter;
    label_1.layer.masksToBounds = YES;
    label_1.font = [UIFont boldSystemFontOfSize:14.0];
    label_1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_1.textColor = [UIColor whiteColor];
    label_1.text = @"S No";
    
    label_2 = [[UILabel alloc] init];
    label_2.layer.cornerRadius = 14;
    label_2.layer.masksToBounds = YES;
    label_2.textAlignment = NSTextAlignmentCenter;
    label_2.font = [UIFont boldSystemFontOfSize:14.0];
    label_2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_2.textColor = [UIColor whiteColor];
    label_2.text = @"Verification Code";
    
    label_3 = [[UILabel alloc] init];
    label_3.layer.cornerRadius = 14;
    label_3.layer.masksToBounds = YES;
    label_3.textAlignment = NSTextAlignmentCenter;
    label_3.font = [UIFont boldSystemFontOfSize:14.0];
    label_3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_3.textColor = [UIColor whiteColor];
    label_3.text = @"Start Date";
    
    label_4 = [[UILabel alloc] init];
    
    label_4.layer.cornerRadius = 14;
    label_4.layer.masksToBounds = YES;
    label_4.textAlignment = NSTextAlignmentCenter;
    label_4.font = [UIFont boldSystemFontOfSize:14.0];
    label_4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_4.textColor = [UIColor whiteColor];
    label_4.text = @"End Date";
    
    label_5 = [[UILabel alloc] init];
    label_5.layer.cornerRadius = 14;
    label_5.layer.masksToBounds = YES;
    label_5.textAlignment = NSTextAlignmentCenter;
    label_5.font = [UIFont boldSystemFontOfSize:14.0];
    label_5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_5.textColor = [UIColor whiteColor];
    label_5.text = @"Verfied By";
    
    label_6 = [[UILabel alloc] init];
    
    label_6.layer.cornerRadius = 14;
    label_6.layer.masksToBounds = YES;
    label_6.textAlignment = NSTextAlignmentCenter;
    label_6.font = [UIFont boldSystemFontOfSize:14.0];
    label_6.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_6.textColor = [UIColor whiteColor];
    label_6.text = @"Status";
    
    
//    table view Creation for categories;
    
    
    categoriesTbl = [[UITableView alloc] init];
    categoriesTbl.dataSource = self;
    categoriesTbl.delegate = self;
    categoriesTbl.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:1.0f];
    categoriesTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    categoriesTbl.hidden = NO;
    
    
    subcategoriesTbl = [[UITableView alloc] init];
    subcategoriesTbl.dataSource = self;
    subcategoriesTbl.delegate = self;
    subcategoriesTbl.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:1.0f];
    subcategoriesTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    subcategoriesTbl.hidden = NO;
    
    
    
    brandTbl = [[UITableView alloc] init];
    brandTbl.dataSource = self;
    brandTbl.delegate = self;
    brandTbl.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:1.0f];
    brandTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    brandTbl.hidden = NO;
    
    


    
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        salesDetailsView.frame = CGRectMake(0.0, 20, self.view.frame.size.width, self.view.frame.size.height);
//        salesDetailsView.contentSize = CGSizeMake(self.view.frame.size.width + 1200.0,0);
        
        salesDetailsTable.frame = CGRectMake(0, 50.0, 2500.0, 630.0);
        salesDetailsTable.allowsSelection = YES;
        label_1.font = [UIFont boldSystemFontOfSize:18];
        label_1.frame = CGRectMake(10, 5.0, 80.0, 40.0);
        label_2.font = [UIFont boldSystemFontOfSize:18];
        label_2.frame = CGRectMake(label_1.frame.origin.x + label_1.frame.size.width + 10, 5.0, 170.0, 40.0);
        label_3.font = [UIFont boldSystemFontOfSize:18];
        label_3.frame = CGRectMake(label_2.frame.origin.x + label_2.frame.size.width + 10, 5.0, 150.0, 40);
        label_4.font = [UIFont boldSystemFontOfSize:18];
        label_4.frame = CGRectMake(label_3.frame.origin.x + label_3.frame.size.width + 10, 5.0, 150.0, 40.0);
        label_5.font = [UIFont boldSystemFontOfSize:18];
        label_5.frame = CGRectMake(label_4.frame.origin.x + label_4.frame.size.width + 10, 5.0, 150.0, 40);
        label_6.font = [UIFont boldSystemFontOfSize:18];
        label_6.frame = CGRectMake(label_5.frame.origin.x + label_5.frame.size.width + 10, 5.0, 110.0, 40);
        
        [salesDetailsView addSubview:label_1];
        [salesDetailsView addSubview:label_2];
        [salesDetailsView addSubview:label_3];
        [salesDetailsView addSubview:label_4];
        [salesDetailsView addSubview:label_5];
        [salesDetailsView addSubview:label_6];
        [salesDetailsView addSubview:salesDetailsTable];
        [self.view addSubview:salesDetailsView];
    }
    else{
        salesDetailsTable.frame = CGRectMake(0, 45, self.view.frame.size.width + 700.0, 300);
        salesDetailsView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
        salesDetailsView.contentSize = CGSizeMake(self.view.frame.size.width + 700.0, self.view.frame.size.height);
        label_1.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_1.frame = CGRectMake(0, 10.0, 80, 30);
        label_2.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_2.frame = CGRectMake(85, 10.0, 80, 30);
        label_3.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_3.frame = CGRectMake(170.0, 10.0, 100.0, 30);
        label_4.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_4.frame = CGRectMake(275.0, 10.0, 130.0, 30);
        label_5.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_5.frame = CGRectMake(410.0, 10.0, 120.0, 30);
        label_6.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_6.frame = CGRectMake(535.0, 10.0, 120.0, 30);
        [salesDetailsView addSubview:salesDetailsTable];
        [salesDetailsView addSubview:label_1];
        [salesDetailsView addSubview:label_2];
        [salesDetailsView addSubview:label_3];
        [salesDetailsView addSubview:label_4];
        [salesDetailsView addSubview:label_5];
        [salesDetailsView addSubview:label_6];
        [self.view addSubview:salesDetailsView];
    }
    salesDetailsArray = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    [HUD setHidden:NO];
    
    
    @try {
        
        totalRecords = 0;
        requestStartNumber = 0;
        purchaseDetailsArray = [NSMutableArray new];

        [self getVerificationDetails];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
    
}

-(void)getVerificationDetails {
    
    @try {
        
        [HUD setHidden:NO];
        
        NSDictionary * reqDic = @{REQUEST_HEADER: [RequestHeader getRequestHeader],@"location": presentLocation,@"startIndex": @(requestStartNumber)};
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getCodeJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_VERIFICATION_CODE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,getCodeJsonString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if (![[billingResponse valueForKey:RESPONSE_HEADER]isKindOfClass:[NSNull class]] &&[[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [HUD setHidden:YES];
                     
                     totalRecords = [[billingResponse valueForKey:@"totalRecords"] intValue];
                     
                     [purchaseDetailsArray addObjectsFromArray:[billingResponse valueForKey:@"verificationMasterList"]];
                     
                     [salesDetailsTable reloadData];
                 }
                 else {
                     [HUD setHidden:YES];
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     self.view.userInteractionEnabled = FALSE;
                     
                 }
             }
             else {
                 [HUD setHidden:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:connectionError.localizedDescription message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
                 self.view.userInteractionEnabled = FALSE;
             }
         }];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == salesDetailsTable) {
        return purchaseDetailsArray.count;
    }
    else if (tableView == detailsTbl) {
        if (summaryInfoArr.count)
            
            return summaryInfoArr.count;
        else
            return 2;
        
        
    }
    else if (tableView == categoriesTbl){
        return categoriesArr.count;
        }
    else if (tableView == subcategoriesTbl) {
        return subCategoryArr.count;
    }
    else if (tableView == brandTbl) {
        return brandListArr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 50;
    }
    else {
        return 33; //I put some padding on it.
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == salesDetailsTable) {
       tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       tableView.separatorColor = [UIColor clearColor];
        
        static NSString * CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        if ((cell.contentView).subviews){
            for (UIView *subview in (cell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.frame = CGRectZero;
        }
        cell.backgroundColor = [UIColor blackColor];
    
        
 
        @try {
            NSDictionary *detailsDic = purchaseDetailsArray[indexPath.row];
            
            UILabel *snoLbl = [[UILabel alloc] init];
            snoLbl.font = [UIFont systemFontOfSize:13.0];
            snoLbl.layer.borderWidth = 1.5;
            snoLbl.backgroundColor = [UIColor blackColor];
            snoLbl.textAlignment = NSTextAlignmentCenter;
            snoLbl.numberOfLines = 2;

            snoLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            snoLbl.lineBreakMode = NSLineBreakByWordWrapping;
            snoLbl.textColor = [UIColor whiteColor];
            snoLbl.text = [NSString stringWithFormat:@"%d",  indexPath.row + 1];
            
            UILabel *skuidLbl = [[UILabel alloc] init];
            skuidLbl.font = [UIFont systemFontOfSize:13.0];
            skuidLbl.layer.borderWidth = 1.5;
            skuidLbl.backgroundColor = [UIColor blackColor];
            skuidLbl.textColor = [UIColor whiteColor];
            skuidLbl.textAlignment = NSTextAlignmentCenter;
            skuidLbl.numberOfLines = 2;
            skuidLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            skuidLbl.lineBreakMode = NSLineBreakByWordWrapping;
            skuidLbl.text = [NSString stringWithFormat:@"%@",[detailsDic valueForKey:@"verification_code"]];
            
            UILabel *itemName = [[UILabel alloc] init];
            itemName.font = [UIFont systemFontOfSize:13.0];
            itemName.layer.borderWidth = 1.5;
            itemName.backgroundColor = [UIColor blackColor];
            itemName.textColor = [UIColor whiteColor];
            itemName.textAlignment = NSTextAlignmentCenter;
            itemName.numberOfLines = 2;
            itemName.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            itemName.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"verificationStartDateStr"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"verificationStartDateStr"] == nil) {
                itemName.text = @"--";
            }
            else{
                
                itemName.text = [NSString stringWithFormat:@"%@",[detailsDic valueForKey:@"verificationStartDateStr"]];
            }
            
            UILabel *dateLbl = [[UILabel alloc] init];
            dateLbl.font = [UIFont systemFontOfSize:13.0];
            dateLbl.layer.borderWidth = 1.5;
            dateLbl.backgroundColor = [UIColor blackColor];
            dateLbl.textColor = [UIColor whiteColor];
            dateLbl.textAlignment = NSTextAlignmentCenter;
            dateLbl.numberOfLines = 2;
            dateLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            dateLbl.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"verificationEndDateStr"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"verificationEndDateStr"] == nil) {
                dateLbl.text = @"--";
            }
            else{
                
                dateLbl.text = [NSString stringWithFormat:@"%@",[detailsDic valueForKey:@"verificationEndDateStr"]];
            }
            
            UILabel *bookQtyLbl = [[UILabel alloc] init];
            bookQtyLbl.font = [UIFont systemFontOfSize:13.0];
            bookQtyLbl.layer.borderWidth = 1.5;
            bookQtyLbl.backgroundColor = [UIColor blackColor];
            bookQtyLbl.textColor = [UIColor whiteColor];
            bookQtyLbl.textAlignment = NSTextAlignmentCenter;
            bookQtyLbl.numberOfLines = 2;
            bookQtyLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            bookQtyLbl.textAlignment = NSTextAlignmentCenter;
            bookQtyLbl.text = [NSString stringWithFormat:@"%@",@"--"];
            
            UILabel *verifyQtyLbl = [[UILabel alloc] init];
            verifyQtyLbl.font = [UIFont systemFontOfSize:13.0];
            verifyQtyLbl.layer.borderWidth = 1.5;
            verifyQtyLbl.backgroundColor = [UIColor blackColor];
            verifyQtyLbl.textColor = [UIColor whiteColor];
            verifyQtyLbl.textAlignment = NSTextAlignmentCenter;
            verifyQtyLbl.numberOfLines = 2;
            verifyQtyLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            verifyQtyLbl.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"status"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"status"] == nil) {
                verifyQtyLbl.text = @"--";
            }
            else {
                verifyQtyLbl.text = [detailsDic valueForKey:@"status"];
            }
            
            viewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [viewBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
            [viewBtn addTarget:self action:@selector(showSummaryDetails:) forControlEvents:UIControlEventTouchDown];
            [viewBtn setTitle:@"Summary" forState:UIControlStateNormal];
            viewBtn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            viewBtn.backgroundColor = [UIColor whiteColor];
            [viewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             viewBtn.tag = indexPath.row;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                snoLbl.font = [UIFont systemFontOfSize:20];
                snoLbl.frame = CGRectMake(10, 0, 80.0, 40.0);
                skuidLbl.font = [UIFont systemFontOfSize:20];
                skuidLbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width, 0, 180.0, 40);
                itemName.font = [UIFont systemFontOfSize:20];
                itemName.frame = CGRectMake(skuidLbl.frame.origin.x+skuidLbl.frame.size.width, 0, 160.0, 40);
                dateLbl.font = [UIFont systemFontOfSize:20];
                dateLbl.frame = CGRectMake(itemName.frame.origin.x+itemName.frame.size.width, 0, 160.0, 40);
                bookQtyLbl.font = [UIFont systemFontOfSize:20];
                bookQtyLbl.frame = CGRectMake(dateLbl.frame.origin.x+dateLbl.frame.size.width, 0, 160.0, 40);
                verifyQtyLbl.font = [UIFont systemFontOfSize:20];
                verifyQtyLbl.frame = CGRectMake(bookQtyLbl.frame.origin.x+bookQtyLbl.frame.size.width, 0, 120.0, 40);
                viewBtn.titleLabel.font = [UIFont systemFontOfSize:20];
                viewBtn.frame = CGRectMake(verifyQtyLbl.frame.origin.x+verifyQtyLbl.frame.size.width+40, 0, 100.0, 40);
                
            }
            else {
                snoLbl.frame = CGRectMake(0, 0, 80, 30);
                snoLbl.font = [UIFont systemFontOfSize:12];
                skuidLbl.frame = CGRectMake(85, 0, 80, 30);
                skuidLbl.font = [UIFont systemFontOfSize:12];
                itemName.frame = CGRectMake(170, 0, 100, 30);
                itemName.font = [UIFont systemFontOfSize:12];
                dateLbl.font = [UIFont systemFontOfSize:12];
                dateLbl.frame = CGRectMake(275.0, 0, 130.0, 30);
                bookQtyLbl.font = [UIFont systemFontOfSize:12];
                bookQtyLbl.frame = CGRectMake(410.0, 0, 120.0, 30);
                verifyQtyLbl.font = [UIFont systemFontOfSize:12];
                verifyQtyLbl.frame = CGRectMake(535.0, 0, 120.0, 30);
            }
            //            NSString *str = [NSString stringWithFormat:@"%@#%@#%@#%@#%@#%@",label1.text,label2.text,label3.text,label4.text,label5.text,[tempArrayItems objectAtIndex:(indexPath.row*5)+1]];
            //            [cartItem addObject:str];
            
            [cell.contentView addSubview:snoLbl];
            [cell.contentView addSubview:skuidLbl];
            [cell.contentView addSubview:itemName];
            [cell.contentView addSubview:dateLbl];
            [cell.contentView addSubview:bookQtyLbl];
            [cell.contentView addSubview:verifyQtyLbl];
            [cell.contentView addSubview:viewBtn];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        return cell;
    }
    
    else if (tableView == detailsTbl) {
        static NSString * hlCellID = @"hlCellID";
        
        UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            
            for (UIView * subview in (hlcell.contentView).subviews) {
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
            
            
            
            UILabel * s_no_Lbl = [[UILabel alloc] init];
            s_no_Lbl.backgroundColor = [UIColor clearColor];
            s_no_Lbl.textAlignment = NSTextAlignmentCenter;
            s_no_Lbl.numberOfLines = 2;
            s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
//            s_no_Lbl.layer.borderWidth = 1.5;
//            s_no_Lbl.layer.borderColor = [UIColor blackColor].CGColor;
            
            
            UILabel *category_Lbl = [[UILabel alloc] init];
            category_Lbl.backgroundColor = [UIColor clearColor];
            category_Lbl.textAlignment = NSTextAlignmentCenter;
            category_Lbl.numberOfLines =1;
            category_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
//            category_Lbl.layer.borderWidth = 1.5;
//            category_Lbl.layer.borderColor = [UIColor blackColor].CGColor;
            
            UILabel *skuid_Lbl= [[UILabel alloc] init];
            skuid_Lbl.backgroundColor = [UIColor clearColor];
            skuid_Lbl.textAlignment = NSTextAlignmentCenter;
            skuid_Lbl.numberOfLines = 2;
            skuid_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
//            skuid_Lbl.layer.borderWidth = 1.5;
//            skuid_Lbl.layer.borderColor = [UIColor blackColor].CGColor;

            
            UILabel *date_Lbl = [[UILabel alloc] init];
            date_Lbl.backgroundColor =  [UIColor clearColor];
            date_Lbl.textAlignment = NSTextAlignmentCenter;
            date_Lbl.numberOfLines = 1;
//            date_Lbl.layer.borderWidth = 1.5;
//            date_Lbl.layer.borderColor = [UIColor blackColor].CGColor;

            
            
            UILabel *dumpQty_Lbl = [[UILabel alloc] init];
            dumpQty_Lbl.backgroundColor =  [UIColor clearColor];
            dumpQty_Lbl.textAlignment = NSTextAlignmentCenter;
            dumpQty_Lbl.numberOfLines = 2;
//            dumpQty_Lbl.layer.borderWidth = 1.5;
//            dumpQty_Lbl.layer.borderColor = [UIColor blackColor].CGColor;

            
            
            UILabel *costPrice_Lbl = [[UILabel alloc] init];
            costPrice_Lbl.backgroundColor =  [UIColor clearColor];
            costPrice_Lbl.textAlignment = NSTextAlignmentCenter;
            costPrice_Lbl.numberOfLines = 2;
//            costPrice_Lbl.layer.borderWidth = 1.5;
//            costPrice_Lbl.layer.borderColor = [UIColor blackColor].CGColor;
            
            UILabel *costValue_Lbl = [[UILabel alloc] init];
            costValue_Lbl.backgroundColor =  [UIColor clearColor];
            costValue_Lbl.textAlignment = NSTextAlignmentCenter;
            costValue_Lbl.numberOfLines = 2;
//            costValue_Lbl.layer.borderWidth = 1.5;
//            costValue_Lbl.layer.borderColor = [UIColor blackColor].CGColor;

            
            UILabel *salePrice_Lbl = [[UILabel alloc] init];
            salePrice_Lbl.backgroundColor =  [UIColor clearColor];
            salePrice_Lbl.textAlignment = NSTextAlignmentCenter;
            salePrice_Lbl.numberOfLines = 2;
//            salePrice_Lbl.layer.borderWidth = 1.5;
//            salePrice_Lbl.layer.borderColor = [UIColor blackColor].CGColor;
            
            UILabel * saleValue_Lbl = [[UILabel alloc] init];
            saleValue_Lbl.backgroundColor =  [UIColor clearColor];
            saleValue_Lbl.textAlignment = NSTextAlignmentCenter;
            saleValue_Lbl.numberOfLines = 2;
//          saleValue_Lbl.layer.borderWidth = 1.0;
//          saleValue_Lbl.layer.borderColor = [UIColor blackColor].CGColor;
            
            s_no_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            category_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            skuid_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            date_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            dumpQty_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            costPrice_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            costValue_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            salePrice_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            saleValue_Lbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
            
            CAGradientLayer *layer_1 = [CAGradientLayer layer];
            layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [s_no_Lbl.layer addSublayer:layer_1];
            
            CAGradientLayer *layer_2 = [CAGradientLayer layer];
            layer_2.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [category_Lbl.layer addSublayer:layer_2];
            
            CAGradientLayer *layer_3 = [CAGradientLayer layer];
            layer_3.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [skuid_Lbl.layer addSublayer:layer_3];
            
            CAGradientLayer *layer_4 = [CAGradientLayer layer];
            layer_4.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [date_Lbl.layer addSublayer:layer_4];
            
            CAGradientLayer *layer_5 = [CAGradientLayer layer];
            layer_5.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [dumpQty_Lbl.layer addSublayer:layer_5];
            
            CAGradientLayer *layer_6 = [CAGradientLayer layer];
            layer_6.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [costPrice_Lbl.layer addSublayer:layer_6];
            
            CAGradientLayer *layer_7 = [CAGradientLayer layer];
            layer_7.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [costValue_Lbl.layer addSublayer:layer_7];
            
            CAGradientLayer *layer_8 = [CAGradientLayer layer];
            layer_8.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [salePrice_Lbl.layer addSublayer:layer_8];
            
            CAGradientLayer *layer_9 = [CAGradientLayer layer];
            layer_9.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
            [saleValue_Lbl.layer addSublayer:layer_9];
            
            //setting frame....
            s_no_Lbl.frame = CGRectMake( 0, 0, snoLabel.frame.size.width + 1, hlcell.frame.size.height);
            category_Lbl.frame = CGRectMake(s_no_Lbl.frame.origin.x + s_no_Lbl.frame.size.width, 0, categoryLabel.frame.size.width + 2,  hlcell.frame.size.height);
            
            skuid_Lbl.frame = CGRectMake( category_Lbl.frame.origin.x + category_Lbl.frame.size.width, 0, skuidLabel.frame.size.width + 2,  hlcell.frame.size.height);
            
            date_Lbl.frame = CGRectMake( skuid_Lbl.frame.origin.x + skuid_Lbl.frame.size.width, 0, dateLabel.frame.size.width + 2,  hlcell.frame.size.height);
            
            dumpQty_Lbl.frame = CGRectMake( date_Lbl.frame.origin.x + date_Lbl.frame.size.width, 0, dumpQtyLbl.frame.size.width + 2,  hlcell.frame.size.height);
            
            costPrice_Lbl.frame = CGRectMake( dumpQty_Lbl.frame.origin.x + dumpQty_Lbl.frame.size.width, 0, costPriceLbl.frame.size.width + 2,  hlcell.frame.size.height);
            
            costValue_Lbl.frame = CGRectMake( costPrice_Lbl.frame.origin.x + costPrice_Lbl.frame.size.width, 0, costValLbl.frame.size.width + 2,  hlcell.frame.size.height);
            
            salePrice_Lbl.frame = CGRectMake( costValue_Lbl.frame.origin.x + costValue_Lbl.frame.size.width, 0, salePriceLbl.frame.size.width + 2,  hlcell.frame.size.height);
            
            
            saleValue_Lbl.frame = CGRectMake( salePrice_Lbl.frame.origin.x + salePrice_Lbl.frame.size.width, 0, saleValueLbl.frame.size.width + 2,  hlcell.frame.size.height);
            
            layer_1.frame = CGRectMake( 0, hlcell.frame.size.height - 2, s_no_Lbl.frame.size.width - 1,   2);
            layer_2.frame = CGRectMake( 1, hlcell.frame.size.height - 2, category_Lbl.frame.size.width - 2,   2);
            layer_3.frame = CGRectMake( 1, hlcell.frame.size.height - 2, skuid_Lbl.frame.size.width - 2,   2);
            layer_4.frame = CGRectMake( 1, hlcell.frame.size.height - 2, date_Lbl.frame.size.width - 2,   2);
            layer_5.frame = CGRectMake( 1, hlcell.frame.size.height - 2, dumpQty_Lbl.frame.size.width - 2,   2);
            layer_6.frame = CGRectMake( 1, hlcell.frame.size.height - 2, costPrice_Lbl.frame.size.width - 2,   2);
            layer_7.frame = CGRectMake( 1, hlcell.frame.size.height - 2, costValue_Lbl.frame.size.width,   2);
            layer_8.frame = CGRectMake( 0, hlcell.frame.size.height - 2, salePrice_Lbl.frame.size.width,   2);
            layer_9.frame = CGRectMake( 0, hlcell.frame.size.height - 2, saleValue_Lbl.frame.size.width,   2);

            
            [hlcell.contentView addSubview:s_no_Lbl];
            [hlcell.contentView addSubview:category_Lbl];
            [hlcell.contentView addSubview:skuid_Lbl];
            [hlcell.contentView addSubview:date_Lbl];
            [hlcell.contentView addSubview:dumpQty_Lbl];
            [hlcell.contentView addSubview:costPrice_Lbl];
            
            [hlcell.contentView addSubview:costValue_Lbl];
            [hlcell.contentView addSubview:salePrice_Lbl];
            [hlcell.contentView addSubview:saleValue_Lbl];
            
            // setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
             [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:18.0 cornerRadius:0.0];
            }
            else {
                
            }
            // setting frame and font..........
            
            @try {
                
                if (summaryInfoArr.count >= indexPath.row && summaryInfoArr.count ) {
                    NSDictionary * dic = summaryInfoArr[indexPath.row];
                    
                    s_no_Lbl.text = [NSString stringWithFormat:@"%li", (indexPath.row + 1)];
                    
                    category_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:kproductCategory] defaultReturn:@"--"]; // productCategory
                    
                    skuid_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_ID] defaultReturn:@"--"];//sku_id
                    
                    if([dic.allKeys containsObject:kCreatedDateStr] && ![[dic valueForKey:kCreatedDateStr] isKindOfClass:[NSNull class]] ){
                        date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:kCreatedDateStr] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];
                    }
                    
                    dumpQty_Lbl.text = [NSString stringWithFormat:@"%li",[[dic valueForKey:kStock_loss] integerValue]];
                    
                    [self checkGivenValueIsNullOrNil:[dic valueForKey:SKU_ID] defaultReturn:@"--"];
                    
                    costPrice_Lbl.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kSkuCostPrice] floatValue]];
                    
                    costValue_Lbl.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kCostPriceValue] floatValue]];
                    
                    salePrice_Lbl.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kSkuSalePrice] floatValue]];
                    
                    saleValue_Lbl.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kSalePriceValue] floatValue]];
                }
                
                else {
                    
                    s_no_Lbl.text = @"--";
                    category_Lbl.text = @"--";
                    skuid_Lbl.text = @"--";
                    date_Lbl.text = @"--";
                    dumpQty_Lbl.text = @"--";
                    costPrice_Lbl.text = @"--";
                    costValue_Lbl.text = @"--";
                    salePrice_Lbl.text = @"--";
                    saleValue_Lbl.text = @"--";
                    
                    
                }
                
            } @catch (NSException * exception) {
              
                NSLog(@"----exception in cellForRowAtIndexPath while populating data-----%@",exception);
                
            }
            @finally{
                
            }
        }
        
        @catch (NSException *exception) {
            
            NSLog(@"----exception in cellForRowAtIndexPath-----%@",exception);
            
        }
        @finally{
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
            
        }
    }
    
    else if (tableView == categoriesTbl) {
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
                
                hlcell.textLabel.text = categoriesArr[indexPath.row];
                hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
                hlcell.textLabel.textColor = [UIColor blackColor];
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return hlcell;
                
            }
            @catch (NSException *exception) {
                
            }
            
        }
  
    else if (tableView == subcategoriesTbl) {
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
            
            hlcell.textLabel.text = subCategoryArr[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:kLabelFont size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
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
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        // cell background color...
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [catPopOver dismissPopoverAnimated:YES];
        
        if (tableView == salesDetailsTable) {
            
            

                    NSDictionary * detailsDic = purchaseDetailsArray[indexPath.row];
 
                    VerifiedStockReceipts *stockDetails = [[VerifiedStockReceipts alloc] init];
                    stockDetails.verficationCodeStr = [detailsDic valueForKey:@"verification_code"];
                    [self.navigationController pushViewController:stockDetails animated:YES];
           
        }
        
        else if (tableView == categoriesTbl) {
            
            
            @try {
                
                categoryTxt.text = categoriesArr[indexPath.row];
                
                 subCategoryArr =  [[categoryAndSubcategoryInfoDic valueForKey:categoriesArr[indexPath.row]] mutableCopy];
                

                
                
                [self getStockVerificationSummary];
            }
            @catch (NSException * exception) {
                
            }
        }
        
        else if (tableView == subcategoriesTbl) {
            
            @try {
                
                
                subCatTxt.text = subCategoryArr[indexPath.row];

                [self getStockVerificationSummary];

                
            }
            @catch (NSException *exception) {
                
            }
        }
        else if (tableView == brandTbl) {
            
            brandTxt.text = [brandListArr[indexPath.row] valueForKey:@"bDescription"];
            [self getStockVerificationSummary];

        }

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    @try {
        
        
        if(tableView == salesDetailsTable){
            
            @try {
                
                if((indexPath.row == (purchaseDetailsArray.count - 1))  && (purchaseDetailsArray.count < totalRecords) && (purchaseDetailsArray.count> requestStartNumber)){
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    requestStartNumber = requestStartNumber + 10;
                    [self getVerificationDetails];
                }
                
            } @catch (NSException *exception) {
                NSLog(@"--exception in servicecall-----%@",exception);
                [HUD setHidden:YES];
            }
        }
    } @catch (NSException * exception) {
        
    }
}

#pragma mark Stock Verification Details:

//getStockVericationSummaryDetails:

-(void)getStockVerificationSummary   {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        summaryInfoArr = [NSMutableArray new];
        
        NSString * categorystr = @"";
        NSString * subCat = @"";
        NSString * brandStr = @"";
        NSString * modelStr = @"";
        NSString * startDteStr = @"";
        NSString * endDateStr = @"";

        if (categoryTxt!= nil) {
            categorystr = categoryTxt.text;
        }
        if (subCatTxt!= nil) {
            subCat = subCatTxt.text;
        }
        
        if (brandTxt!= nil) {
            brandStr = brandTxt.text;
        }
       
        if (modelTxt!= nil) {
            modelStr = modelTxt.text;
        }
        
        
        if((startDateTxt!= nil) && ((startDateTxt.text).length >1 )){
            startDteStr = [NSString stringWithFormat:@"%@%@", startDateTxt.text,@" 00:00:00"];

        }
        
        if((endDateTxt!= nil) && ((endDateTxt.text).length >1 )){
            
            endDateStr = [NSString stringWithFormat:@"%@%@", endDateTxt.text,@" 00:00:00"];

        }
        
        NSArray * keys = @[REQUEST_HEADER,LOCATION,kStartDateStr,kEndDateStr,kProductCategory,kSubCategory,kBrand,MODEL,@"verification_code"];
        NSArray * objects = @[[RequestHeader getRequestHeader],presentLocation,startDteStr,endDateStr,categorystr,subCat,brandStr,modelStr,verificationCodeStr];
        
        ///upto here on 07/03/2017....

        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSLog(@"%@",dictionary);
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * getProductsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductsJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockVerificationDelegate = self;
        [webServiceController getStockVericationSummaryDetails:getProductsJsonString];
        
    }
    @catch (NSException * exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        
    }
    
}


-(void)getStockVerificationDetailsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        for (NSDictionary * summaryDic in [successDictionary valueForKey:@"itemsList"] ) {
            
            [summaryInfoArr addObject:summaryDic];
            
      }
    
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
        [detailsTbl reloadData];
    }
    
}


-(void)getStockVerificationDetailsErrorResponse:(NSString *)errorResponse {
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:errorResponse delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [HUD setHidden:YES];
        
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];

    }
    
}


#pragma mark getCategories :

-(void)getCategories {
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        categoriesArr = [NSMutableArray new];
        subCategoryArr = [NSMutableArray new];
        
        
        NSArray *keys = @[@"requestHeader",@"startIndex",@"categoryName",@"slNo",@"flag"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",@"",[NSNumber numberWithBool:true],@""];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * categoriesJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getProductCategory:categoriesJsonString];
        //        OutletMasterDelegate
        
    }
    @catch (NSException *exception) {
        
    }
    
}


-(void)getCategorySuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        
        categoryAndSubcategoryInfoDic = [NSMutableDictionary new];
        
        for(NSDictionary *dic in [sucessDictionary valueForKey:@"categories"]){
            
            [categoriesArr addObject:[dic valueForKey:@"categoryDescription"]];
            
            
            NSMutableArray *subArr =  [NSMutableArray new];
            for(NSDictionary *locDic in [dic valueForKey:@"subCategories"]){
                
                
                [subArr addObject:[locDic valueForKey:@"subcategoryDescription"]];
            }
            if(!subArr.count)
                [ subArr addObject:@"--No Sub Categories--"];
            
            categoryAndSubcategoryInfoDic[[dic valueForKey:@"categoryDescription"]] = subArr;
         }
    }
    @catch (NSException *exception) {
        
     }
    @finally {
        [HUD setHidden: YES];
    }
    
}
-(void)getCategoryErrorResponse:(NSString*)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Categories Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        
        WebServiceController * webServiceController = [WebServiceController new];
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Products  Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    [HUD setHidden:YES];
}


#pragma mark Details view


-(void)showSummaryDetails:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
           NSDictionary * detailsDic = purchaseDetailsArray[sender.tag];
        
        
            verificationCodeStr = [[detailsDic valueForKey:@"verification_code"] copy];
            
       
           [self getStockVerificationSummary];
    
        
        PopOverViewController  * detailsInfoPop = [[PopOverViewController alloc] init];
        
        detailsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 890, 550)];
        detailsView.opaque = NO;
        detailsView.backgroundColor = [UIColor blackColor];
        detailsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        detailsView.layer.borderWidth = 2.5f;
        detailsView.tag = sender;
        detailsView.layer.cornerRadius  = 2.0f;
        [detailsView setHidden:NO];
        
        headerLbl = [[UILabel alloc] init];
        headerLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
        headerLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:24.0f];
        headerLbl.text = @"Summary";
        headerLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        headerLbl.textAlignment = NSTextAlignmentCenter;
        
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerLbl.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        bottomBorder.opacity = 5.0f;
        [headerLbl.layer addSublayer:bottomBorder];
        
        UILabel *zoneLbl = [[UILabel alloc] init];
        zoneLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        zoneLbl.textAlignment = NSTextAlignmentLeft;
        zoneLbl.font = [UIFont boldSystemFontOfSize:16.0];
        zoneLbl.text  = @"Zone";
        
        UILabel *zoneVal = [[UILabel alloc] init];
        zoneVal.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        zoneVal.font = [UIFont boldSystemFontOfSize:16.0];
        zoneVal.text  = zone;
        zoneVal.textAlignment = NSTextAlignmentLeft;
        
        
        UILabel * categoryLbl = [[UILabel alloc] init];
        categoryLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        categoryLbl.font = [UIFont boldSystemFontOfSize:16.0];
        categoryLbl.text  = @"Category";
        categoryLbl.textAlignment = NSTextAlignmentLeft;
        
        categoryTxt = [[UITextField alloc] init];
        categoryTxt.borderStyle = UITextBorderStyleRoundedRect;
        categoryTxt.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        categoryTxt.layer.borderWidth = 1.0f;
        categoryTxt.backgroundColor = [UIColor clearColor];
        categoryTxt.delegate = self;
        categoryTxt.textAlignment = NSTextAlignmentLeft;
        [categoryTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        categoryTxt.userInteractionEnabled = NO;
        categoryTxt.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
        categoryTxt.placeholder = NSLocalizedString(@" Category", nil);
        categoryTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:categoryTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        
        
        UIImage *catImg  = [UIImage imageNamed:@"arrow_1.png"];
        
        UIButton * categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [categoryBtn setBackgroundImage:catImg forState:UIControlStateNormal];
        [categoryBtn addTarget:self
                        action:@selector(showCategoriesList:) forControlEvents:UIControlEventTouchDown];
        
        
        UILabel * brandLbl = [[UILabel alloc] init];
        brandLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        brandLbl.textAlignment = NSTextAlignmentLeft;
        brandLbl.font = [UIFont boldSystemFontOfSize:16.0];
        brandLbl.text  = @"Brand";
        
        brandTxt = [[UITextField alloc] init];
        brandTxt.borderStyle = UITextBorderStyleRoundedRect;
        brandTxt.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        brandTxt.layer.borderWidth = 1.0f;
        brandTxt.backgroundColor = [UIColor clearColor];
        brandTxt.returnKeyType = UIReturnKeyDone;
        brandTxt.delegate = self;
        brandTxt.textAlignment = NSTextAlignmentLeft;
        brandTxt.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
        brandTxt.userInteractionEnabled = NO;
        [brandTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        brandTxt.placeholder = NSLocalizedString(@" Brand", nil);
        brandTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:brandTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        
        UIButton * brandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [brandBtn setBackgroundImage:catImg forState:UIControlStateNormal];
        [brandBtn addTarget:self
                     action:@selector(showBrandList:) forControlEvents:UIControlEventTouchDown];
        
        
        UILabel *startDteLbl = [[UILabel alloc] init];
        startDteLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        startDteLbl.textAlignment = NSTextAlignmentLeft;
        startDteLbl.font = [UIFont boldSystemFontOfSize:16.0];
        startDteLbl.text  = @"Start Date";
        
        startDateTxt = [[UITextField alloc] init];
        
        endDateTxt = [[UITextField alloc] init];

        
        startDateTxt.borderStyle = UITextBorderStyleRoundedRect;
        startDateTxt.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        startDateTxt.layer.borderWidth = 1.0f;
        startDateTxt.backgroundColor = [UIColor clearColor];
        startDateTxt.returnKeyType = UIReturnKeyDone;
        startDateTxt.delegate = self;
        startDateTxt.textAlignment = NSTextAlignmentLeft;
        startDateTxt.userInteractionEnabled = NO;
        [startDateTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        startDateTxt.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;

        startDateTxt.placeholder = NSLocalizedString(@" Start Date", nil);
        startDateTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:startDateTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        UIImage * calendarImg = [UIImage imageNamed:@"Calandar_Icon.png"];
        
        UIButton *showStartDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [showStartDateBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
        [showStartDateBtn addTarget:self
                             action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
        showStartDateBtn.tag = 2;
        
        
        UILabel *locationLbl = [[UILabel alloc] init];
        locationLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        locationLbl.textAlignment = NSTextAlignmentLeft;
        locationLbl.font = [UIFont boldSystemFontOfSize:16.0];
        locationLbl.text  = @"Location";
        
        UILabel *locationVal = [[UILabel alloc] init];
        locationVal.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        locationVal.textAlignment = NSTextAlignmentLeft;
        locationVal.font = [UIFont boldSystemFontOfSize:16.0];
        locationVal.text  = presentLocation;
        
        UILabel *subCatLbl = [[UILabel alloc] init];
        subCatLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        subCatLbl.textAlignment = NSTextAlignmentLeft;
        subCatLbl.font = [UIFont boldSystemFontOfSize:16.0];
        subCatLbl.text  = @"Sub Category";
        
        
        subCatTxt = [[UITextField alloc] init];
        subCatTxt.borderStyle = UITextBorderStyleRoundedRect;
        subCatTxt.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        subCatTxt.layer.borderWidth = 1.0f;
        subCatTxt.backgroundColor = [UIColor clearColor];
        subCatTxt.returnKeyType = UIReturnKeyDone;
        subCatTxt.delegate = self;
        subCatTxt.textAlignment = NSTextAlignmentLeft;
        subCatTxt.userInteractionEnabled = NO;
        [subCatTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        subCatTxt.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;

        subCatTxt.placeholder = NSLocalizedString(@" Sub Category", nil);
        subCatTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:subCatTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        UIButton * subCatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [subCatBtn setBackgroundImage:catImg forState:UIControlStateNormal];
        [subCatBtn addTarget:self
                      action:@selector(showSubCategoriesList:) forControlEvents:UIControlEventTouchDown];
        
        
        
        
        
        UILabel *modelLbl = [[UILabel alloc] init];
        modelLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        modelLbl.textAlignment = NSTextAlignmentLeft;
        modelLbl.font = [UIFont boldSystemFontOfSize:16.0];
        modelLbl.text  = @"Model";
        
        modelTxt = [[UITextField alloc] init];
        modelTxt.borderStyle = UITextBorderStyleRoundedRect;
        modelTxt.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        modelTxt.layer.borderWidth = 1.0f;
        modelTxt.backgroundColor = [UIColor clearColor];
        modelTxt.returnKeyType = UIReturnKeyDone;
        modelTxt.delegate = self;
        modelTxt.textAlignment = NSTextAlignmentLeft;
        modelTxt.userInteractionEnabled = NO;
        modelTxt.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;

        [modelTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        modelTxt.placeholder = NSLocalizedString(@"Model", nil);
        modelTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:modelTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];

        
        
        UIButton * modelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [modelBtn setBackgroundImage:catImg forState:UIControlStateNormal];
        [modelBtn addTarget:self
                     action:@selector(showModelList:) forControlEvents:UIControlEventTouchDown];
//
        
        
        
        UILabel * endDateLbl = [[UILabel alloc] init];
        endDateLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        endDateLbl.textAlignment = NSTextAlignmentLeft;
        endDateLbl.font = [UIFont boldSystemFontOfSize:16.0];
        endDateLbl.text  = @"End Date";
        
        
        endDateTxt.borderStyle = UITextBorderStyleRoundedRect;
        endDateTxt.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        endDateTxt.layer.borderWidth = 1.0f;
        endDateTxt.backgroundColor = [UIColor clearColor];
        endDateTxt.returnKeyType = UIReturnKeyDone;
        endDateTxt.delegate = self;
        endDateTxt.textAlignment = NSTextAlignmentLeft;
        endDateTxt.userInteractionEnabled = NO;
        [endDateTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        endDateTxt.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;

        endDateTxt.placeholder = NSLocalizedString(@"End Date", nil);
        endDateTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:endDateTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];

        
        UIButton *endDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [endDteBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
        [endDteBtn addTarget:self
                      action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
        
        //    header Section for Labels:
        
        
        snoLabel =  [[UILabel alloc]init];
        snoLabel.layer.cornerRadius = 14;
        snoLabel.layer.masksToBounds = YES;
        snoLabel.textAlignment = NSTextAlignmentCenter;
        snoLabel.font = [UIFont boldSystemFontOfSize:16.0];
        snoLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        snoLabel.textColor = [UIColor whiteColor];
        snoLabel.text = @"Sno";
        
        
        categoryLabel =  [[UILabel alloc]init];
        categoryLabel.layer.cornerRadius = 14;
        categoryLabel.layer.masksToBounds = YES;
        categoryLabel.textAlignment = NSTextAlignmentCenter;
        categoryLabel.font = [UIFont boldSystemFontOfSize:16.0];
        categoryLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        categoryLabel.textColor = [UIColor whiteColor];
        categoryLabel.text = @"Category";
        
        skuidLabel =  [[UILabel alloc]init];
        skuidLabel.layer.cornerRadius = 14;
        skuidLabel.layer.masksToBounds = YES;
        skuidLabel.textAlignment = NSTextAlignmentCenter;
        skuidLabel.font = [UIFont boldSystemFontOfSize:16.0];
        skuidLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        skuidLabel.textColor = [UIColor whiteColor];
        skuidLabel.text = @"SKU ID";
        
        dateLabel =  [[UILabel alloc]init];
        dateLabel.layer.cornerRadius = 14;
        dateLabel.layer.masksToBounds = YES;
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont boldSystemFontOfSize:16.0];
        dateLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.text = @"Date";
        
        
        dumpQtyLbl =  [[UILabel alloc]init];
        dumpQtyLbl.layer.cornerRadius = 14;
        dumpQtyLbl.layer.masksToBounds = YES;
        dumpQtyLbl.textAlignment = NSTextAlignmentCenter;
        dumpQtyLbl.font = [UIFont boldSystemFontOfSize:16.0];
        dumpQtyLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        dumpQtyLbl.textColor = [UIColor whiteColor];
        dumpQtyLbl.text = @"Dump Qty";
        
        costPriceLbl =  [[UILabel alloc]init];
        costPriceLbl.layer.cornerRadius = 14;
        costPriceLbl.layer.masksToBounds = YES;
        costPriceLbl.textAlignment = NSTextAlignmentCenter;
        costPriceLbl.font = [UIFont boldSystemFontOfSize:16.0];
        costPriceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        costPriceLbl.textColor = [UIColor whiteColor];
        costPriceLbl.text = @"Cost Price";
        
        costValLbl =  [[UILabel alloc]init];
        costValLbl.layer.cornerRadius = 14;
        costValLbl.layer.masksToBounds = YES;
        costValLbl.textAlignment = NSTextAlignmentCenter;
        costValLbl.font = [UIFont boldSystemFontOfSize:16.0];
        costValLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        costValLbl.textColor = [UIColor whiteColor];
        costValLbl.text = @"Cost Value";
        
        salePriceLbl =  [[UILabel alloc]init];
        
        salePriceLbl.layer.cornerRadius = 14;
        salePriceLbl.layer.masksToBounds = YES;
        salePriceLbl.textAlignment = NSTextAlignmentCenter;
        salePriceLbl.font = [UIFont boldSystemFontOfSize:16.0];
        salePriceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        salePriceLbl.textColor = [UIColor whiteColor];
        salePriceLbl.text = @"Sale Price";
        
        saleValueLbl =  [[UILabel alloc]init];
        saleValueLbl.layer.cornerRadius = 14;
        saleValueLbl.layer.masksToBounds = YES;
        saleValueLbl.textAlignment = NSTextAlignmentCenter;
        saleValueLbl.font = [UIFont boldSystemFontOfSize:16.0];
        saleValueLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        saleValueLbl.textColor = [UIColor whiteColor];
        saleValueLbl.text = @"Sale Value";
        
        detailsTbl = [[UITableView alloc] init];
        detailsTbl.dataSource = self;
        detailsTbl.delegate = self;
        detailsTbl.backgroundColor = [UIColor blackColor];
        detailsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        detailsTbl.hidden = NO;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            
            headerLbl.frame = CGRectMake(0, 0, detailsView.frame.size.width, 45);

            
            
            zoneLbl.frame = CGRectMake(10, headerLbl.frame.origin.y+headerLbl.frame.size.height+20, 140, 40);
            zoneVal.frame = CGRectMake(zoneLbl.frame.origin.x+zoneLbl.frame.size.width-40, zoneLbl.frame.origin.y, zoneLbl.frame.size.width, 40);
            
            categoryLbl.frame =  CGRectMake(zoneVal.frame.origin.x+ zoneVal.frame.size.width, zoneLbl.frame.origin.y, zoneVal.frame.size.width, 40);
            categoryTxt.frame =  CGRectMake(categoryLbl.frame.origin.x+ categoryLbl.frame.size.width, zoneLbl.frame.origin.y, 200, 40);
            
            categoryBtn.frame = CGRectMake((categoryTxt.frame.origin.x+categoryTxt.frame.size.width-45), categoryTxt.frame.origin.y-8, 50, 55);
            
            
            brandLbl.frame =  CGRectMake(categoryTxt.frame.origin.x+ categoryTxt.frame.size.width+15, zoneLbl.frame.origin.y, categoryLbl.frame.size.width, 40);
            brandTxt.frame =  CGRectMake(brandLbl.frame.origin.x+ brandLbl.frame.size.width-70, zoneLbl.frame.origin.y, 200, 40);
            
            brandBtn.frame = CGRectMake((brandTxt.frame.origin.x+brandTxt.frame.size.width-45), brandTxt.frame.origin.y-8, 50, 55);
            
            locationLbl.frame = CGRectMake(zoneLbl.frame.origin.x,zoneLbl.frame.origin.y+zoneLbl.frame.size.height+10, zoneLbl.frame.size.width, 40);
            
            locationVal.frame = CGRectMake(zoneVal.frame.origin.x, locationLbl.frame.origin.y, zoneLbl.frame.size.width, 40);
            
            subCatLbl.frame = CGRectMake(categoryLbl.frame.origin.x, locationLbl.frame.origin.y, zoneLbl.frame.size.width, 40);
            
            subCatTxt.frame = CGRectMake(categoryTxt.frame.origin.x, subCatLbl.frame.origin.y,200, 40);
            
            subCatBtn.frame = CGRectMake((subCatTxt.frame.origin.x+subCatTxt.frame.size.width-45), subCatTxt.frame.origin.y-8, 50, 55);
            
            
            modelLbl.frame = CGRectMake(brandLbl.frame.origin.x, locationLbl.frame.origin.y, zoneLbl.frame.size.width, 40);
            
            modelTxt.frame = CGRectMake(brandTxt.frame.origin.x, locationLbl.frame.origin.y, 200,40);
            
            modelBtn.frame = CGRectMake((modelTxt.frame.origin.x+modelTxt.frame.size.width-45), modelTxt.frame.origin.y-8, 50, 55);
            
            //        column 3
            
            startDteLbl.frame =  CGRectMake(subCatLbl.frame.origin.x, locationLbl.frame.origin.y+locationLbl.frame.size.height+10, zoneLbl.frame.size.width, 40);
            startDateTxt.frame =  CGRectMake(subCatTxt.frame.origin.x, startDteLbl.frame.origin.y, 200, 40);
            
            showStartDateBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-45), startDateTxt.frame.origin.y+2, 40, 35);
            
            endDateLbl.frame = CGRectMake(modelLbl.frame.origin.x, startDteLbl.frame.origin.y, zoneLbl.frame.size.width, 40);
            //
            endDateTxt.frame = CGRectMake(modelTxt.frame.origin.x, startDateTxt.frame.origin.y,200, 40);
            
            endDteBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-45), endDateTxt.frame.origin.y+2, 40, 35);
            
                 
            //  Section Header Frame
            
            snoLabel.frame = CGRectMake(zoneLbl.frame.origin.x-5, startDteLbl.frame.origin.y+startDteLbl.frame.size.height+30, 70, 40);
            
            categoryLabel.frame = CGRectMake(snoLabel.frame.origin.x + snoLabel.frame.size.width + 2 , snoLabel.frame.origin.y ,100  , snoLabel.frame.size.height);
            
            skuidLabel.frame = CGRectMake( categoryLabel.frame.origin.x + categoryLabel.frame.size.width + 2 , categoryLabel.frame.origin.y ,110, categoryLabel.frame.size.height);
            
            dateLabel.frame = CGRectMake( skuidLabel.frame.origin.x + skuidLabel.frame.size.width + 2 , skuidLabel.frame.origin.y ,120  , skuidLabel.frame.size.height);
            
            dumpQtyLbl.frame = CGRectMake( dateLabel.frame.origin.x + dateLabel.frame.size.width + 2 , dateLabel.frame.origin.y ,90  , dateLabel.frame.size.height);
            
            costPriceLbl.frame = CGRectMake( dumpQtyLbl.frame.origin.x + dumpQtyLbl.frame.size.width + 2 , dumpQtyLbl.frame.origin.y ,90  , dumpQtyLbl.frame.size.height);
            
            costValLbl.frame = CGRectMake( costPriceLbl.frame.origin.x + costPriceLbl.frame.size.width + 2 , costPriceLbl.frame.origin.y ,90  , costPriceLbl.frame.size.height);
            
            salePriceLbl.frame = CGRectMake( costValLbl.frame.origin.x + costValLbl.frame.size.width + 2 , costValLbl.frame.origin.y ,90  , costValLbl.frame.size.height);
            
            saleValueLbl.frame = CGRectMake( salePriceLbl.frame.origin.x + salePriceLbl.frame.size.width + 2 , salePriceLbl.frame.origin.y ,95  , salePriceLbl.frame.size.height);
            
            
            detailsTbl.frame = CGRectMake(snoLabel.frame.origin.x, snoLabel.frame.origin.y +  snoLabel.frame.size.height, detailsView.frame.size.width, 250);
        }
        else {
        
        }
        
        
        [detailsView addSubview:headerLbl];
        [detailsView addSubview:zoneLbl];
        [detailsView addSubview:zoneVal];
        
        [detailsView addSubview:categoryLbl];
        [detailsView addSubview:categoryTxt];
        [detailsView addSubview:categoryBtn];
        
        [detailsView addSubview:brandLbl];
        [detailsView addSubview:brandTxt];
        [detailsView addSubview:brandBtn];
        
        [detailsView addSubview:locationLbl];
        [detailsView addSubview:locationVal];
        
        
        [detailsView addSubview:startDteLbl];
        [detailsView addSubview:startDateTxt];
        [detailsView addSubview: showStartDateBtn];
        
        [detailsView addSubview:subCatLbl];
        [detailsView addSubview:subCatTxt];
        [detailsView addSubview:subCatBtn];
        
        [detailsView addSubview:modelLbl];
        [detailsView addSubview:modelTxt];
        [detailsView addSubview:modelBtn];
        
        [detailsView addSubview:endDateLbl];
        [detailsView addSubview:endDateTxt];
        [detailsView addSubview:endDteBtn];
        
        [detailsView addSubview:snoLabel];
        [detailsView addSubview:categoryLabel];
        [detailsView addSubview:skuidLabel];
        [detailsView addSubview:dateLabel];
        [detailsView addSubview:dumpQtyLbl];
        [detailsView addSubview:costPriceLbl];
        [detailsView addSubview:costValLbl];
        [detailsView addSubview:salePriceLbl];
        [detailsView addSubview:saleValueLbl];
        
        [detailsView addSubview:detailsTbl];
        [detailsView addSubview:HUD];
        
        
        detailsInfoPop.view = detailsView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            detailsInfoPop.preferredContentSize =  CGSizeMake(detailsView.frame.size.width, detailsView.frame.size.height);
            
            NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:sender.tag inSection:0];
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:detailsInfoPop];
            [popover presentPopoverFromRect:viewBtn.frame inView:[salesDetailsTable cellForRowAtIndexPath:selectedRow] permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
            detailsViewPopOver= popover;
        }
        
        else {
            
            detailsInfoPop.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:detailsInfoPop];
            // popover.contentViewController.view.alpha = 0.0;
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            detailsViewPopOver = popover;
            
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
 
        
    }
    
}

-(void)showCategoriesList:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if(categoriesArr == nil ||  categoriesArr.count == 0){
            [HUD setHidden:NO];
            [self getCategories];
            
        }
        
        
        if(categoriesArr.count){
            float tableHeight = categoriesArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = categoriesArr.count * 33;
            
            if(categoriesArr.count > 5)
                tableHeight = (tableHeight/categoriesArr.count) * 5;
            
            
            [self showPopUpForTables:categoriesTbl  popUpWidth:categoryTxt.frame.size.width popUpHeight:tableHeight presentPopUpAt:categoryTxt  showViewIn:detailsView];
            
            
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in the detailsView in showBrandList:----%@",exception);
        
        NSLog(@"------exception while creating the popUp in normalStockView------%@",exception);
        
    }
}


-(void)showSubCategoriesList:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        
        if(subCategoryArr == nil ||  subCategoryArr.count == 0){
            [HUD setHidden:NO];
            [self getCategories];
            
        }
        
        
        if(subCategoryArr.count){
            float tableHeight = subCategoryArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = subCategoryArr.count * 33;
            
            if(subCategoryArr.count > 5)
                tableHeight = (tableHeight/subCategoryArr.count) * 5;
            
            
            [self showPopUpForTables:subcategoriesTbl  popUpWidth:subCatTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:subCatTxt  showViewIn:detailsView];
            
            
            
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"------exception while creating the popUp in detailsView------%@",exception);
    }
}

-(void)showBrandList:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        
        //     if (![catPopOver isPopoverVisible]){
        if(brandListArr == nil ||  brandListArr.count == 0){
            [HUD setHidden:NO];
            [self callingBrandList];
            
        }
        
        if(brandListArr.count){
            float tableHeight = brandListArr.count * 50;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = brandListArr.count * 33;
            
            if(brandListArr.count > 5)
                tableHeight = (tableHeight/brandListArr.count) * 5;
            
            [self showPopUpForTables:brandTbl  popUpWidth:brandTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:brandTxt  showViewIn:detailsView];
            
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"------exception while creating the popUp in normalStockView------%@",exception);
        
    }
}


-(void)showModelList:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"This feature is not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}






/**
 * @description  here we are showing the calenderView.......
 * @date         01/03/2017
 * @method       showCalenderInPopUp
 * @author       Srinivasulu
 * @param        UIButton
 * @param
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
            
            pickView.frame = CGRectMake( 15, startDateTxt.frame.origin.y+startDateTxt.frame.size.height, 320, 320);
            
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
        
        UIButton  * pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventTouchUpInside];
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        //added by Bhargav on 02/02/2017....
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];

        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake(pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3),pickButton.frame.origin.y, pickButton.frame.size.width,pickButton.frame.size.height);
        
        //upto here on 02/02/2017....
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:startDateTxt.frame inView:detailsView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:detailsView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver = popover;
            
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
        
        NSLog(@"----exception in the DetailsView in showCalenderInPopUp:----%@",exception);
        NSLog(@"------exception while creating the popUp in detailsView---%@",exception);
        
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
    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(  sender.tag == 2){
            if((startDateTxt.text).length)
                callServices = true;
            
            startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                callServices = true;
            
            endDateTxt.text = @"";
        }
        
        if(callServices){
            [HUD setHidden:NO];

            [self getStockVerificationSummary];
        }

        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in DetailsView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
    
}



/**
 * @description  here we are showing the calender in popUp view.......
 * @date         26/09/2016
 * @method       showCalenderInPopUp:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)displayDate:(UIButton *)sender{
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
        
        NSDate *existingDateString;
        
        /*z;
         UITextField *endDateTxt;*/
        
        if(sender.tag == 2){
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDateTxt.text = @"";
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Start date should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            startDateTxt.text = dateString;
            
        }
        else{
            
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDateTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"End date should not be earlier than start date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            endDateTxt.text = dateString;
            
        }
        
        @try {
            
            if ((startDateTxt.text).length !=0 && (endDateTxt.text).length != 0 ) {
                
                NSString * str1 = startDateTxt.text;
                NSString * str2 = endDateTxt.text;
                
                
                if(str1.length > 1)
                    str1 = [NSString stringWithFormat:@"%@%@", startDateTxt.text,@" 00:00:00"];
                
                if(str2.length > 1)
                    str2 = [NSString stringWithFormat:@"%@%@", endDateTxt.text,@" 00:00:00"];
                [self getStockVerificationSummary];
            }
            
        }
        @catch (NSException *exception) {
            
        }

        
        
        
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
        
        
        
    }
    
    
}



#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         17/01/2016
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

#pragma -mark reusableMethods.......
/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         21/09/2016
 * @method       showPopUpForTables:-- popUpWidth:-- popUpHeight:-- presentPopUpAt:-- showViewIn:--
 * @author       Srinivasulu
 * @param        UITableView
 * @param        float
 * @param        float
 * @param        id
 * @param        id
 * @return
 * @verified By
 * @verified On
 *
 */

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
        
        
        UITextField *textView = displayFrame;
        
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







-(void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}


@end


//    if (![[custInfo objectForKey:@"category"] isKindOfClass:[NSNull class]]&& [[custInfo objectForKey:@"category"] length] > 0) {
//        custTypeVal.text  = [custInfo objectForKey:@"category"];
//    }
//    else {
//        custTypeVal.text  = @"--";
//
//    }




//        String parseJS eval
//        {
//            "location":"KHARGHAR",
//            "requestHeader":{},
//            "startDateStr":"27/01/2017 15:03:58",
//            "endDateStr":"31/01/2017 15:03:58",
//            "zoneId":"",
//            "status":"",
//            "brand":"",
//            "model":"",
//            "department":"",
//            "productcategory":"",
//            "subcategory":""
//        }



