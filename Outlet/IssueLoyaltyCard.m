//
//  IssueLoyaltyCard.m
//  OmniRetailer
//
//  Created by Roja on 28/11/19.
//

#import "IssueLoyaltyCard.h"

@interface IssueLoyaltyCard ()

@end

@implementation IssueLoyaltyCard

@synthesize soundFileURLRef,soundFileObject;
@synthesize mobileNumberTF, customerIdTF, firstNameTF, lastNameTF, localityTF, customerCategoryTF,addressTF, cityTF, emailTF, currentSchemeTF, basePointsTF, loyaltyCodeTF, submitBtn, cancelBtn, addBtn, loyaltyProgBtn;
@synthesize snoLbl, basePointsLbl, loyaltyNumberLbl, issueDateLbl, expiryDateLbl, statusLbl, actionLbl;
@synthesize mainView,loyaltyCardsTable,scrollView;


/**
* @description
* @date                        29/11/2019
* @method                   viewDidLoad
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    
    self.titleLabel.text = @"Issue Gift Coupon";

    mobileNumberTF.backgroundColor = [UIColor whiteColor];
    mobileNumberTF.borderStyle = UITextBorderStyleRoundedRect;
    
    customerIdTF.backgroundColor = [UIColor whiteColor];
    customerIdTF.borderStyle = UITextBorderStyleRoundedRect;
    
    firstNameTF.backgroundColor = [UIColor whiteColor];
    firstNameTF.borderStyle = UITextBorderStyleRoundedRect;
    
    lastNameTF.backgroundColor = [UIColor whiteColor];
    lastNameTF.borderStyle = UITextBorderStyleRoundedRect;
    
    localityTF.backgroundColor = [UIColor whiteColor];
    localityTF.borderStyle = UITextBorderStyleRoundedRect;
    
    customerCategoryTF.backgroundColor = [UIColor whiteColor];
    customerCategoryTF.borderStyle = UITextBorderStyleRoundedRect;
    
    addressTF.backgroundColor = [UIColor whiteColor];
    addressTF.borderStyle = UITextBorderStyleRoundedRect;
    
    cityTF.backgroundColor = [UIColor whiteColor];
    cityTF.borderStyle = UITextBorderStyleRoundedRect;
    
    emailTF.backgroundColor = [UIColor whiteColor];
    emailTF.borderStyle = UITextBorderStyleRoundedRect;
    
    
    
      

    currentSchemeTF.backgroundColor = [UIColor whiteColor];
    currentSchemeTF.borderStyle = UITextBorderStyleRoundedRect;
    
    basePointsTF.backgroundColor = [UIColor whiteColor];
    basePointsTF.borderStyle = UITextBorderStyleRoundedRect;
    
    loyaltyCodeTF.backgroundColor = [UIColor whiteColor];
    loyaltyCodeTF.borderStyle = UITextBorderStyleRoundedRect;
    [loyaltyCodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     

    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 5.0f;
    
    addBtn.backgroundColor = [UIColor grayColor];
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.cornerRadius = 5.0f;
    
    
    [loyaltyProgBtn setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    
    
    snoLbl.layer.masksToBounds = YES;
    snoLbl.layer.cornerRadius = 5.0f;
    snoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    

    basePointsLbl.layer.masksToBounds = YES;
    basePointsLbl.layer.cornerRadius = 5.0f;
    basePointsLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    loyaltyNumberLbl.layer.masksToBounds = YES;
    loyaltyNumberLbl.layer.cornerRadius = 5.0f;
    loyaltyNumberLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    issueDateLbl.layer.masksToBounds = YES;
    issueDateLbl.layer.cornerRadius = 5.0f;
    issueDateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    expiryDateLbl.layer.masksToBounds = YES;
    expiryDateLbl.layer.cornerRadius = 5.0f;
    expiryDateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    statusLbl.layer.masksToBounds = YES;
    statusLbl.layer.cornerRadius = 5.0f;
    statusLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    actionLbl.layer.masksToBounds = YES;
    actionLbl.layer.cornerRadius = 5.0f;
    actionLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    mainView.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
    
    mobileNumberTF.delegate = self;
    [mobileNumberTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    
    loyaltyCodeDetailsTable = [[UITableView alloc] init];
    loyaltyCodeDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
    loyaltyCodeDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
    loyaltyCodeDetailsTable.layer.cornerRadius = 4.0f;
    loyaltyCodeDetailsTable.layer.borderWidth = 1.0f;
    loyaltyCodeDetailsTable.dataSource = self;
    loyaltyCodeDetailsTable.delegate = self;
    
//    [mainView addSubview:loyaltyCardsTable];
    
    // allocation of selected gift coupon arrary
    selectedLoyaltyCardsArr = [[NSMutableArray alloc]init];
    
    loyaltyCardsTable.dataSource = self;
    loyaltyCardsTable.delegate = self;
    [loyaltyCardsTable setBackgroundColor:[UIColor clearColor]];
}

/**
* @description
* @date                        29/11/2019
* @method                   viewDidAppear
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

    [self getLoyaltyCardDetails];
}



/**
 * @description          Here we are calling 'getLoyaltyCardDetails' to get available LoyaltyCardDetails....
 * @date         29/11/2019
 * @method       getLoyaltyCardDetails
 * @author       Roja
 * @param
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getLoyaltyCardDetails{
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        NSArray * giftLoyaltyKeys = @[@"requestHeader", @"startIndex", MAX_RECORDS];//STATUS @"locations"
        
        NSArray * giftLoyaltyObjects = @[[RequestHeader getRequestHeader], ZERO_CONSTANT, @"10"]; //@"Active" presentLocation
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:giftLoyaltyObjects forKeys:giftLoyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * giftLoyaltyRequestStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceContr = [WebServiceController new];
        webServiceContr.loyaltycardServicesDelegate = self;
        [webServiceContr getAvailableLoyaltyPrograms:giftLoyaltyRequestStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
}


/**
* @description
* @date                        29/11/2019
* @method                   getAvailableLoyaltyProgramsSuccessReponse:
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
- (void)getAvailableLoyaltyProgramsSuccessReponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:sucessDictionary options:0 error:&err_];
        NSString * giftLoyaltyRequestStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        NSLog(@"Loyalty cards : %@",giftLoyaltyRequestStr);
     
        NSArray * loyaltyCardsArray = [self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"loyaltyCardsList"] defaultReturn:@""];

        loyaltyProgramDetailsArr = [[NSMutableArray alloc]init];

        for (NSDictionary * dic in loyaltyCardsArray) {
            
            NSMutableDictionary * tempDic = [[NSMutableDictionary alloc]init];
            
            [tempDic setValue:[dic valueForKey:@"loyaltyProgramName"] forKey:@"loyaltyProgramName"];
            [tempDic setValue:[dic valueForKey:@"status"] forKey:@"status"];
            [tempDic setValue:[dic valueForKey:@"loyaltyProgramNumber"] forKey:@"loyaltyProgramNumber"];
            [tempDic setValue:[dic valueForKey:@"basePoints"] forKey:@"basePoints"];
            [tempDic setValue:[dic valueForKey:@"StartDateStr"] forKey:@"StartDateStr"];
            [tempDic setValue:[dic valueForKey:@"EndDateStr"] forKey:@"EndDateStr"];
            [tempDic setValue:[dic valueForKey:@"loyaltyCardType"] forKey:@"loyaltyCardType"];
            [tempDic setValue:[dic valueForKey:@"rewardConversionRatio"] forKey:@"rewardConversionRatio"];
            [tempDic setValue:[dic valueForKey:@"validityPeriod"] forKey:@"validityPeriod"];
            [tempDic setValue:[dic valueForKey:@"rewardType"] forKey:@"rewardType"];

            [loyaltyProgramDetailsArr addObject:tempDic];
        }
        

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
* @description
* @date                        29/11/2019
* @method                   getAvailableLoyaltyProgramsErrorResponse:
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
- (void)getAvailableLoyaltyProgramsErrorResponse:(NSString *)error{
   
    @try {
           
       } @catch (NSException *exception) {
           
       } @finally {
           [HUD setHidden:YES];
       }
}

/**
 * @description          Here we are calling 'LoyaltyCardsService' to get Gift Coupons By Search Criteria....
 * @date         29/11/2019
 * @method       getLoyaltyCodeDetailsList
 * @author       Roja
 * @param
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLoyaltyCodeDetailsList{
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        NSArray * giftCouponCodeKeys = @[@"requestHeader",@"searchCriteria",@"startIndex",@"loyaltyProgramNumber"];
        
        NSArray * giftCouponCodeObj = @[[RequestHeader getRequestHeader], loyaltyCodeTF.text,ZERO_CONSTANT,loyaltyPromoCodeStr];
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:giftCouponCodeObj forKeys:giftCouponCodeKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * giftCouponCodeRequestStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceContr = [WebServiceController new];
        webServiceContr.loyaltycardServicesDelegate = self;
        [webServiceContr getLoyaltyCardsBySearch:giftCouponCodeRequestStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
}


- (void)getLoyaltycardBySearchCriteriaSuccessReponse:(NSDictionary *)sucessDictionary{
    
    @try {
        loyaltyCodeDetailsArray = [[NSMutableArray alloc]init];

        NSArray * loyaltyCodeArr  = [sucessDictionary valueForKey:@"loyaltyCards"];
        
        for (NSDictionary * loyaltyCodeDic in loyaltyCodeArr) {

            if(![[loyaltyCodeDic valueForKey:@"assignedStatus"] boolValue]){

                NSMutableDictionary * tempDic =  [[NSMutableDictionary alloc] init];

                [tempDic setValue:[self checkGivenValueIsNullOrNil:[loyaltyCodeDic valueForKey:@"loyaltyCardNumber"] defaultReturn:@""] forKey:@"loyaltyCardNumber"];

                [loyaltyCodeDetailsArray addObject:tempDic];

            }

        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [self loyaltyCodeDetailsPopUp];
        [loyaltyCodeDetailsTable reloadData];
    }
}

- (void)getLoyaltycardBySearchCriteriaErrorResponse:(NSString *)error{
    
    @try {
          NSString * errMsg = error;
          
          [self displayAlertMessage:errMsg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"" conentWidth:350 contentHeight:100 isSoundRequired:YES timming:2.0 noOfLines:2];

      } @catch (NSException *exception) {
          
      } @finally {
          [HUD setHidden:YES];
      }
}


#pragma mark Table view methods

// Customize the number of rows in the table view.
/**
 * @description  It is one of the UITableView delegate method used to Customize the number of rows in the table view...
 * @date         29/11/2019
 * @method       tableView:-- numberOfRowsInSection:--
 * @author       roja
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == loyaltyProgramDetailsTable){
        
        return loyaltyProgramDetailsArr.count;
    }
    
    else if(tableView == loyaltyCodeDetailsTable){
        return loyaltyCodeDetailsArray.count;
    }
    else if (tableView == loyaltyCardsTable) {
        
        return selectedLoyaltyCardsArr.count;
        
    }
    
    else{
        return 0;
    }
}

/**
* @description
* @date                        29/11/2019
* @method                   heightForRowAtIndexPath:
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 40;
}


// Customize the appearance of table view cells.
/**
 * @description  It is one of the UITableView delegate method used to Customize the appearance of table view cells.
 * @date         29/11/2019...
 * @method       tableView:--  cellForRowAtIndexPath:--
 * @author       roja
 * @param        UITableView
 * @param        NSIndexPath
 * @return       UITableViewCell
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        cell.frame = CGRectZero;
    }
    
     if(tableView == loyaltyProgramDetailsTable){
        
        @try {
            
            cell.textLabel.textColor= [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            if([loyaltyProgramDetailsArr count] && loyaltyProgramDetailsArr != nil){
                
                NSDictionary * loyaltyCardDetailsDic = loyaltyProgramDetailsArr[indexPath.row];
                cell.textLabel.text = [self checkGivenValueIsNullOrNil:[loyaltyCardDetailsDic valueForKey:@"loyaltyProgramName"] defaultReturn:@"-"];
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
            
        } @finally {
            
        }
    }
    
     else if(tableView == loyaltyCodeDetailsTable){
    
    @try {
        cell.textLabel.textColor= [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        if([loyaltyCodeDetailsArray count] && loyaltyCodeDetailsArray != nil){
            
            NSDictionary * giftCouponCodeDetailsDic = loyaltyCodeDetailsArray[indexPath.row];
            cell.textLabel.text = [self checkGivenValueIsNullOrNil:[giftCouponCodeDetailsDic valueForKey:@"loyaltyCardNumber"] defaultReturn:@"-"];
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    } @finally {
        
    }
}
    
    else if (tableView == loyaltyCardsTable) {
        
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
        
        hlcell.backgroundColor = [UIColor clearColor];
        //        [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
        
        @try {
            UILabel *sno = [[UILabel alloc] init] ;
            sno.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            sno.backgroundColor = [UIColor clearColor];
            sno.textColor = [UIColor whiteColor];
            sno.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
            sno.textAlignment=NSTextAlignmentCenter;
            
            //            sno.layer.borderWidth = 1.5;
            //            sno.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            
            
            UILabel * basePointsLabel = [[UILabel alloc] init] ;
            basePointsLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            basePointsLabel.backgroundColor = [UIColor clearColor];
            basePointsLabel.textColor = [UIColor whiteColor];
            basePointsLabel.textAlignment=NSTextAlignmentCenter;
            
            UILabel *loyaltyNumberValLbl = [[UILabel alloc] init] ;
            loyaltyNumberValLbl.backgroundColor = [UIColor clearColor];
            loyaltyNumberValLbl.textAlignment = NSTextAlignmentCenter;
            //            loyaltyNumberValLbl.numberOfLines = 2;
            loyaltyNumberValLbl.textColor = [UIColor whiteColor];
            loyaltyNumberValLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
            
            UILabel * issuedDateLabel = [[UILabel alloc] init] ;
            issuedDateLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            issuedDateLabel.backgroundColor = [UIColor clearColor];
            issuedDateLabel.textColor = [UIColor whiteColor];
            issuedDateLabel.textAlignment=NSTextAlignmentCenter;
            issuedDateLabel.text = @"-";
            issuedDateLabel.numberOfLines = 2;
            
            UILabel *expiryDateLabel = [[UILabel alloc] init] ;
            expiryDateLabel.backgroundColor = [UIColor clearColor];
            expiryDateLabel.textAlignment = NSTextAlignmentCenter;
            expiryDateLabel.numberOfLines = 2;
            expiryDateLabel.textColor = [UIColor whiteColor];
            expiryDateLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            
            
            UILabel * statusLabel = [[UILabel alloc] init] ;
            statusLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            statusLabel.backgroundColor = [UIColor clearColor];
            statusLabel.textColor = [UIColor whiteColor];
            statusLabel.textAlignment=NSTextAlignmentCenter;
            statusLabel.text = @"-";
            
            
            UIButton *delrowbtn = [[UIButton alloc] init] ;
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            // Setting values from dic
            if ([selectedLoyaltyCardsArr count] && selectedLoyaltyCardsArr != nil) {
                
                NSDictionary * tempDic = selectedLoyaltyCardsArr[indexPath.row];
                
                basePointsLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"basePoints"] defaultReturn:@"0"]];

                loyaltyNumberValLbl.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"loyaltyCardNumber"] defaultReturn:@"0"]];
                
                expiryDateLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"EndDateStr"] defaultReturn:@"-"]]; //expiry date
                issuedDateLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"StartDateStr"] defaultReturn:@"-"]];//issue/createdate
                statusLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"status"] defaultReturn:@"-"]];
            }

            sno.frame = CGRectMake(snoLbl.frame.origin.x, 0, snoLbl.frame.size.width, snoLbl.frame.size.height);
            
            basePointsLabel.frame = CGRectMake(basePointsLbl.frame.origin.x, 0, basePointsLbl.frame.size.width, basePointsLbl.frame.size.height);
            
            loyaltyNumberValLbl.frame = CGRectMake(loyaltyNumberLbl.frame.origin.x, 0, loyaltyNumberLbl.frame.size.width, loyaltyNumberLbl.frame.size.height);
            
            issuedDateLabel.frame = CGRectMake(issueDateLbl.frame.origin.x, 0, issueDateLbl.frame.size.width, issueDateLbl.frame.size.height);
            
            expiryDateLabel.frame = CGRectMake(expiryDateLbl.frame.origin.x, 0, expiryDateLbl.frame.size.width, expiryDateLbl.frame.size.height);
            
            statusLabel.frame = CGRectMake(statusLbl.frame.origin.x, 0, statusLbl.frame.size.width, statusLbl.frame.size.height);
            
            delrowbtn.frame = CGRectMake((actionLbl.frame.origin.x + (actionLbl.frame.size.width/2))-15 , 0, 35, 35);
            
            
            [hlcell.contentView addSubview:sno];
            [hlcell.contentView addSubview:basePointsLabel];
            [hlcell.contentView addSubview:delrowbtn];
            [hlcell.contentView addSubview:loyaltyNumberValLbl];
            [hlcell.contentView addSubview:expiryDateLabel];
            [hlcell.contentView addSubview:statusLabel];
            [hlcell.contentView addSubview:issuedDateLabel];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        @finally {
        }
        return hlcell;
        
    }
    
    return cell;
}



/**
 * @description  It is one of the UITableView delegate method
 * @date         29/11/2019...
 * @method       tableView:--  didSelectRowAtIndexPath:--
 * @author       roja
 * @param        UITableView
 * @param        NSIndexPath
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (tableView == loyaltyProgramDetailsTable){
        
        @try {
            
            
            if([selectedLoyaltyCardsArr count]){
                
                NSString * errMsg = @"Only 1 loyalty card can be issued at a time.";
                
                [self displayAlertMessage:errMsg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"" conentWidth:350 contentHeight:100 isSoundRequired:YES timming:2.0 noOfLines:2];
            }
            
            else {
                
                NSDictionary * loyaltyCardDetailsDic = loyaltyProgramDetailsArr[indexPath.row];
                
                selectedLoyaltyNoPosition = (int)indexPath.row;
                
                currentSchemeTF.text =  [self checkGivenValueIsNullOrNil:[loyaltyCardDetailsDic valueForKey:@"loyaltyProgramName"] defaultReturn:@""];
                
                basePointsTF.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[loyaltyCardDetailsDic valueForKey:@"basePoints"] defaultReturn:@"0.00"] floatValue]];
                
                loyaltyPromoCodeStr = [self checkGivenValueIsNullOrNil:[loyaltyCardDetailsDic valueForKey:@"loyaltyProgramNumber"] defaultReturn:@""];
                
                if ([loyaltyCodeTF.text length] != 0) {
                    loyaltyCodeTF.text = @"";
                }
                
                [loyaltyProgramPopOver dismissPopoverAnimated:YES];
            }
            
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    else if (tableView == loyaltyCodeDetailsTable) {
        
        @try {
            
            NSDictionary * loyaltyCodeDetailsDic = loyaltyCodeDetailsArray[indexPath.row];
            
            loyaltyCodeTF.text =  [self checkGivenValueIsNullOrNil:[loyaltyCodeDetailsDic valueForKey:@"loyaltyCardNumber"] defaultReturn:@""];
            
            [loyaltyCodePopOver dismissPopoverAnimated:YES];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
}






/**
 * @description
 * @date         29/11/2019
 * @method       textFieldDidChange
 * @author       Roja
 * @param
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == mobileNumberTF) {
        
        if ([mobileNumberTF.text length]==10) {

            [self getCustomerDetails];
        }
    }
    
    else if(textField == loyaltyCodeTF){

        if([loyaltyCodeTF.text length] >= 3){
            [self getLoyaltyCodeDetailsList];
        }
    }
    
}



/**
 * @description  It is one of the UITextField delegate method used to hide the keyboard..
 * @date         29/11/2019
 * @method       textFieldShouldReturn
 * @author       roja
 * @param
 * @param        UITextField
 * @return       BOOL
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

/**
* @description
* @date                        29/11/2019
* @method                   textField:  shouldChangeCharactersInRange:
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.frame.origin.x == mobileNumberTF.frame.origin.x){
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
    return true;
}





/**
 * @description  Here we are calling 'customerService' to get Customer Details..
 * @date         29/11/2019
 * @method       getCustomerDetails
 * @author       Roja
 * @param
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getCustomerDetails{
    
    @try{
        [HUD setHidden:NO];
        
        NSArray * customerDetailsKeys = [NSArray arrayWithObjects:@"email",@"mobileNumber",REQUEST_HEADER, nil];
        NSArray *customerDetailsObjects = [NSArray arrayWithObjects:@"",mobileNumberTF.text,[RequestHeader getRequestHeader], nil];
        
        NSDictionary *requestDic = [NSDictionary dictionaryWithObjects:customerDetailsObjects forKeys:customerDetailsKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&err_];
        NSString * RequestString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * controller = [WebServiceController new];
        [controller setCustomerServiceDelegate:self];
        [controller getCustomerDetails:RequestString];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}




/**
 * @description  Here we are handling success response of get customer details
 * @date         29/11/2019
 * @method       getCustomerDetailsSuccessResponse
 * @author       Roja
 * @param
 * @param        NSDictionary
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getCustomerDetailsSuccessResponse:(NSDictionary *)sucessDictionary{

    @try {
        
          emailTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"email"] defaultReturn:@""]];
        
                firstNameTF.text =  [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"name"] defaultReturn:@""]];//
                customerIdTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"customerId"] defaultReturn:@""]];
                lastNameTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"lastName"] defaultReturn:@""]];
                localityTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"locality"] defaultReturn:@""]];
                addressTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"street"] defaultReturn:@""]];
                cityTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"city"] defaultReturn:@""]];
                
        //        if ([[sucessDictionary valueForKey:@"phone"] isKindOfClass:[NSNull class]] || [[sucessDictionary valueForKey:@"phone"] isEqualToString:@""]) { // email may also need to check
        //            if ((mobileNumberTF.text).length >= 10) {
        //                [self provideCustomerRatingfor:NEW_CUSTOMER];
        //                return;
        //            }
        //        }
        //        else{
        //            if ((phNotxt.text).length >= 10) {
        //
        //                if (!([[sucessDictionary valueForKey:@"category"] isKindOfClass:[NSNull class]]) && ![[sucessDictionary valueForKey:@"category"] isEqualToString:@""]) {
        //
        //                    [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@",[sucessDictionary valueForKey:@"category"]]];
        //                    return;
        //                }
        //                else {
        //                    [self provideCustomerRatingfor:EXISTING_CUSTOMER];
        //                    return;
        //                }
        //            }
        //        }
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



/**
 * @description  Here we are handling error response of get customer details
 * @date         29/11/2019
 * @method       getCustomerDetailsErrorResponse
 * @author       Roja
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getCustomerDetailsErrorResponse:(NSString *)errorResponse{
    
      @try {
          [self displayAlertMessage:@"New Customer" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];

      } @catch (NSException *exception) {
          
      } @finally {
          [HUD setHidden:YES];
      }
    
}



/**
* @description
* @date                        29/11/2019
* @method                   addLoyalty:
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
- (IBAction)addLoyalty:(id)sender {
    
    @try {
        
        if ([currentSchemeTF.text length] == 0) {
            
            [self displayAlertMessage:@"Please select any loyalty program" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if ([loyaltyCodeTF.text length] == 0 || [loyaltyCodeTF.text length] != 16) {
            
            [self displayAlertMessage:@"Please enter loyalty code" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else {
            
            if ([loyaltyProgramDetailsArr count]) {
                
                NSMutableDictionary * tempDic = [[NSMutableDictionary alloc]init];
                NSDictionary * selectedLoyaltyCodeDic = [loyaltyProgramDetailsArr objectAtIndex:selectedLoyaltyNoPosition];
                
                BOOL loyaltyCodeExists = false;
                
                for (NSDictionary * existingLoyaltyDic in selectedLoyaltyCardsArr) {

                    if ([[existingLoyaltyDic valueForKey:@"loyaltyCardNumber"] isEqualToString:loyaltyCodeTF.text]) {

                        loyaltyCodeExists = true;
                    }
                }
                if (loyaltyCodeExists) {
                    
                    NSString * errMsg = @"Loyalty number already added";
                    [self displayAlertMessage:errMsg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
                }
                else{
                    
                    [tempDic setValue:[selectedLoyaltyCodeDic valueForKey:@"StartDateStr"] forKey:@"StartDateStr"];
                    [tempDic setValue:[selectedLoyaltyCodeDic valueForKey:@"EndDateStr"] forKey:@"EndDateStr"];
                    [tempDic setValue:[selectedLoyaltyCodeDic valueForKey:@"status"] forKey:@"status"];
                    [tempDic setValue:[selectedLoyaltyCodeDic valueForKey:@"basePoints"] forKey:@"basePoints"];
                    [tempDic setValue:loyaltyCodeTF.text forKey:@"loyaltyCardNumber"];
                    [tempDic setValue:[selectedLoyaltyCodeDic valueForKey:@"loyaltyProgramNumber"] forKey:@"loyaltyProgramNumber"];
                    [tempDic setValue:[selectedLoyaltyCodeDic valueForKey:@"loyaltyProgramName"] forKey:@"loyaltyProgramName"];
                    [tempDic setValue:[selectedLoyaltyCodeDic valueForKey:@"StartDateStr"] forKey:@"validFrom"];
                    [tempDic setValue:[selectedLoyaltyCodeDic valueForKey:@"EndDateStr"] forKey:@"validTo"];

                    
                    [selectedLoyaltyCardsArr addObject:tempDic];
                }
                
                [loyaltyCardsTable reloadData];
                [loyaltyCardsTable setHidden:NO];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        loyaltyCodeTF.text = @"";
        basePointsTF.text = @"";
    }
    
}

/**
* @description
* @date                        29/11/2019
* @method                   submitLoyalty:
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
- (IBAction)submitLoyalty:(id)sender {
    
    @try {
        
        if([mobileNumberTF.text length] != 10){
            
            [mobileNumberTF becomeFirstResponder];
            
            [self displayAlertMessage:@"Please enter valid mobile number" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if([firstNameTF.text length] == 0){
            
            [firstNameTF becomeFirstResponder];
            
            [self displayAlertMessage:@"Please enter your name" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if([emailTF.text length] && ![WebServiceUtility validateEmail:emailTF.text]){
            
            [emailTF becomeFirstResponder];
            [self displayAlertMessage:@"Please enter valid email id" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if([selectedLoyaltyCardsArr count] == 0 || selectedLoyaltyCardsArr == nil){
            
            [self displayAlertMessage:@"Please add atleast one loyalty card" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:100 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else{
            
            AudioServicesPlaySystemSound (soundFileObject);
            
            [HUD show: YES];
            [HUD setHidden:NO];
            [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
            
            NSString * loyaltyCardtypeStr = @"";
            float rewardConversationRatio = 0.0;
            int validityPeriodStr = 0;
            NSString * rewardTypeStr = @"";
            NSString * loyaltyProgNum = @"";

            
            NSDictionary *loyaltyDetailsDic =  [loyaltyProgramDetailsArr objectAtIndex:selectedLoyaltyNoPosition];
            
                loyaltyCardtypeStr = [loyaltyDetailsDic valueForKey:@"loyaltyCardType"];
                rewardConversationRatio = [[loyaltyDetailsDic valueForKey:@"rewardConversionRatio"] floatValue];
                validityPeriodStr = [[loyaltyDetailsDic valueForKey:@"validityPeriod"] intValue];
                rewardTypeStr = [loyaltyDetailsDic valueForKey:@"rewardType"];
                loyaltyProgNum = [loyaltyDetailsDic valueForKey:@"loyaltyProgramNumber"];
            
            
            NSArray * issueVoucherKeys = @[@"requestHeader",@"LoyaltyCardList", @"booleanFlag", @"customerName",@"email", @"idCardType", @"loyaltyCardType", @"loyaltyProgramNumber", @"phoneNum", @"rewardConversionRatio",@"rewardLifeTime", @"rewardType"];
            
            NSArray * issueVoucherObjects = @[[RequestHeader getRequestHeader], selectedLoyaltyCardsArr, [NSNumber numberWithBool:true], firstNameTF.text, emailTF.text, loyaltyCardtypeStr, loyaltyCardtypeStr, loyaltyProgNum, mobileNumberTF.text, [NSNumber numberWithFloat:rewardConversationRatio], [NSNumber numberWithFloat:validityPeriodStr], rewardTypeStr];
            
            
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:issueVoucherObjects forKeys:issueVoucherKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * issueGiftVoucherStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * webServContlr = [[WebServiceController alloc] init];
            webServContlr.loyaltycardServicesDelegate = self;
            [webServContlr issueLoyaltyCard:issueGiftVoucherStr];
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    } @finally {
        
    }
}


- (void)issueLoyaltyCardSuccessReponse:(NSDictionary *)sucessDictionary{
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


- (void)issueLoyaltyCardErrorResponse:(NSString *)error{
    
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
* @description
* @date                        29/11/2019
* @method                   cancelLoyalty:
* @author                     Roja
* @param
* @param
* @return                     void
*
* @modified BY
* @reason
*
* @return
* @verified By
* @verified On
*/
- (IBAction)cancelLoyalty:(id)sender {
    
    @try {
       
       } @catch (NSException *exception) {
           
       } @finally {
           [HUD setHidden:YES];
       }
}




/**
 * @description  Here we are checkings null values.. if input is Null or nill we will return default.
 * @date         29/11/2019...
 * @method       checkGivenValueIsNullOrNil:--   defaultReturn:--
 * @author       roja
 * @param        NSString
 * @param        id
 * @return       id
 *
 * @modified BY
 * @reason
 *
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



#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         29/11/2019
 * @method       displayAlertMessage
 * @author
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
        
        [self.view addSubview:userAlertMessageLbl];
        fadeOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in displayAlertMessage---------%@",exception);
        NSLog(@"----exception while creating the useralertMesssageLbl------------%@",exception);
        
    }
}

- (IBAction)loyaltyProgramBtnAction:(id)sender {
    
    @try {

        // added by roja on 06/03/2019...
        float loyaltyTblHeight = 0;

        if ([loyaltyProgramDetailsArr count] && loyaltyProgramDetailsArr != nil) {

            loyaltyTblHeight =  [loyaltyProgramDetailsArr count] * 40;

            if ([loyaltyProgramDetailsArr count] >= 3) {

                loyaltyTblHeight = 3 * 40;
            }
        }
        //upto here added by roja on 06/03/2019...

        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);

        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        UIView * displayTblView ;


        if(loyaltyTblHeight == 0){
            
            displayTblView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0, loyaltyTblHeight)];
        }
        else {
            
            displayTblView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, currentSchemeTF.frame.size.width, loyaltyTblHeight)];//

            
            displayTblView.opaque = NO;
            displayTblView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            displayTblView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            displayTblView.layer.borderWidth = 2.0f;
            [displayTblView setHidden:NO];
            
            loyaltyProgramDetailsTable = [[UITableView alloc] init];
            loyaltyProgramDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
            loyaltyProgramDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
            loyaltyProgramDetailsTable.layer.cornerRadius = 4.0f;
            loyaltyProgramDetailsTable.layer.borderWidth = 1.0f;
            loyaltyProgramDetailsTable.dataSource = self;
            loyaltyProgramDetailsTable.delegate = self;
            loyaltyProgramDetailsTable.bounces = FALSE;
            loyaltyProgramDetailsTable.frame = CGRectMake(0.0, 0.0, displayTblView.frame.size.width, displayTblView.frame.size.height);
            
            [displayTblView addSubview:loyaltyProgramDetailsTable];
            customerInfoPopUp.view = displayTblView;
            
            
            customerInfoPopUp.preferredContentSize =  CGSizeMake(displayTblView.frame.size.width, displayTblView.frame.size.height);
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            [popover presentPopoverFromRect:currentSchemeTF.frame inView:mainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            loyaltyProgramPopOver = popover;
            
        }

       


    } @catch (NSException *exception) {

    } @finally {

    }

}




/**
 * @description          Here we are displaying the Pop up view on selection of gift loyalty details button..
 * @date
 * @method       loyaltyCodeDetailsPopUp
 * @author       Roja
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)loyaltyCodeDetailsPopUp{

    float loyaltyCodeTblHeight = 0;

    if ([loyaltyCodeDetailsArray count] && loyaltyCodeDetailsArray != nil) {
        
        loyaltyCodeTblHeight =  [loyaltyCodeDetailsArray count] * 40;
        
        if ([loyaltyCodeDetailsArray count] >= 3) {
            
            loyaltyCodeTblHeight = 3 * 40;
        }
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
//        if(loyaltyCodeTblHeight == 0){
//
//            UIView * couponCodeView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0, loyaltyCodeTblHeight)];
//
//            [self displayAlertMessage:@"No loyalty programs available" horizontialAxis:(self.view.frame.size.width - 350)/2 verticalAxis:(self.view.frame.size.height)/2 msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
//        }
//        else {

        
            UIView * couponCodeView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,  loyaltyCodeTF.frame.size.width, loyaltyCodeTblHeight)];
            couponCodeView.opaque = NO;
            couponCodeView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            couponCodeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            couponCodeView.layer.borderWidth = 2.0f;
            [couponCodeView setHidden:NO];
            
            loyaltyCodeDetailsTable = [[UITableView alloc] init];
            loyaltyCodeDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
            loyaltyCodeDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
            loyaltyCodeDetailsTable.layer.cornerRadius = 4.0f;
            loyaltyCodeDetailsTable.layer.borderWidth = 1.0f;
            loyaltyCodeDetailsTable.dataSource = self;
            loyaltyCodeDetailsTable.delegate = self;
            loyaltyCodeDetailsTable.bounces = FALSE;
            loyaltyCodeDetailsTable.frame = CGRectMake(0.0, 0.0, couponCodeView.frame.size.width, couponCodeView.frame.size.height);
            
            [couponCodeView addSubview:loyaltyCodeDetailsTable];
            customerInfoPopUp.view = couponCodeView;
            
            
            customerInfoPopUp.preferredContentSize =  CGSizeMake(couponCodeView.frame.size.width, couponCodeView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:loyaltyCodeTF.frame inView:mainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            loyaltyCodePopOver = popover;
//        }
        
    }
}



/**
 * @description  removing alertMessage add in the  disPlayAlertMessage method
 * @date         29/11/2019
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
        
        NSLog(@"--------exception in the customerWalOut in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
        
    }
    
}

/**
 * @description  here we are navigating back to home page.......
 * @date         29/11/2019
 * @method       backAction
 * @author       Roja
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

- (void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * @description           In this method we are delete the row on selection of delete(action) button
 * @date         29/11/2019...
 * @method       delRow
 * @author       roja
 * @param
 * @param        UIButton
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)delRow:(UIButton *)sender {
    
    [selectedLoyaltyCardsArr removeObjectAtIndex:sender.tag];
    [loyaltyCardsTable reloadData];
}

@end
