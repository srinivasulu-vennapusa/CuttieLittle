//
//  MaterialConsumptionController.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/24/17.
//
//

#import "MaterialConsumptionController.h"
#import "MaterialDetailsController.h"
#import "OmniHomePage.h"







@interface MaterialConsumptionController ()

@end

@implementation MaterialConsumptionController

@synthesize soundFileURLRef,soundFileObject;

int maxRecords = 10;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) CFBridgingRetain(tapSound);
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    
    self.titleLabel.text = @"Material Consumption";

    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    HUD.labelText = @"Please Wait..";
    
//  creation of UIView
    materialConsumptionView  = [[UIView alloc ]init];
    materialConsumptionView.backgroundColor = [UIColor blackColor];
    materialConsumptionView.layer.borderWidth = 2.0f;
    materialConsumptionView.layer.cornerRadius = 8.0f;
    materialConsumptionView.layer.borderColor = [UIColor clearColor].CGColor;
    
//  creation of UITextField
    
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.userInteractionEnabled  = NO;
    startDateTxt.delegate = self;
    startDateTxt.placeholder = NSLocalizedString(@"start_date", nil);
    startDateTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:startDateTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
   
    [startDateTxt awakeFromNib];
    
    
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.userInteractionEnabled = NO;
    endDateTxt.delegate = self;
    endDateTxt.placeholder = NSLocalizedString(@"end_date", nil);
    endDateTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:endDateTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];

    [endDateTxt awakeFromNib];
    
//   creaaatin of UIImage:
    
    UIImage * buttonImage = [UIImage imageNamed:@"Calandar_Icon.png"];

//   creation of UIButton:
    
    UIButton * showStartDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showStartDateBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [showStartDateBtn addTarget:self
                         action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    showStartDateBtn.tag = 2;
    
    
    UIButton *showEndDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showEndDateBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [showEndDateBtn addTarget:self
                       action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    showEndDateBtn.tag = 4;
    
//   creation of GO Buttton:
    
    goButton = [[UIButton alloc] init] ;
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    goButton.tag = 2;
    
//    creation of Lables:
    
    snoLbl = [[UILabel alloc] init];
    snoLbl.layer.cornerRadius = 14;
    snoLbl.layer.masksToBounds = YES;
    snoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    snoLbl.textColor = [UIColor whiteColor];
    snoLbl.font = [UIFont boldSystemFontOfSize:18.0];
    snoLbl.textAlignment = NSTextAlignmentCenter;
    snoLbl.text = @"SNo";
    
    itemCodeLbl = [[UILabel alloc] init];
    itemCodeLbl.layer.cornerRadius = 14;
    itemCodeLbl.layer.masksToBounds = YES;
    itemCodeLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    itemCodeLbl.textColor = [UIColor whiteColor];
    itemCodeLbl.font = [UIFont boldSystemFontOfSize:18.0];
    itemCodeLbl.textAlignment = NSTextAlignmentCenter;
    itemCodeLbl.text = @"Item Code";
    
    itemDescLbl = [[UILabel alloc] init];
    itemDescLbl.layer.cornerRadius = 14;
    itemDescLbl.layer.masksToBounds = YES;
    itemDescLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    itemDescLbl.textColor = [UIColor whiteColor];
    itemDescLbl.font = [UIFont boldSystemFontOfSize:18.0];
    itemDescLbl.textAlignment = NSTextAlignmentCenter;
    itemDescLbl.text = @"Desc";

    uomLbl = [[UILabel alloc] init];
    uomLbl.layer.cornerRadius = 14;
    uomLbl.layer.masksToBounds = YES;
    uomLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    uomLbl.textColor = [UIColor whiteColor];
    uomLbl.font = [UIFont boldSystemFontOfSize:18.0];
    uomLbl.textAlignment = NSTextAlignmentCenter;
    uomLbl.text = @"Uom";
    
    CategoryLbl = [[UILabel alloc] init];
    CategoryLbl.layer.cornerRadius = 14;
    CategoryLbl.layer.masksToBounds = YES;
    CategoryLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    CategoryLbl.textColor = [UIColor whiteColor];
    CategoryLbl.font = [UIFont boldSystemFontOfSize:18.0];
    CategoryLbl.textAlignment = NSTextAlignmentCenter;
    CategoryLbl.text = @"Category";
    
    unitPriceLbl = [[UILabel alloc] init];
    unitPriceLbl.layer.cornerRadius = 14;
    unitPriceLbl.layer.masksToBounds = YES;
    unitPriceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    unitPriceLbl.textColor = [UIColor whiteColor];
    unitPriceLbl.font = [UIFont boldSystemFontOfSize:18.0];
    unitPriceLbl.textAlignment = NSTextAlignmentCenter;
    unitPriceLbl.text =@"Unit Price";

    soldQtyLbl= [[UILabel alloc] init];
    soldQtyLbl.layer.cornerRadius = 14;
    soldQtyLbl.layer.masksToBounds = YES;
    soldQtyLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    soldQtyLbl.textColor = [UIColor whiteColor];
    soldQtyLbl.font = [UIFont boldSystemFontOfSize:18.0];
    soldQtyLbl.textAlignment = NSTextAlignmentCenter;
    soldQtyLbl.text = @"Sold Qty";
    
    totalSaleLbl= [[UILabel alloc] init];
    totalSaleLbl.layer.cornerRadius = 14;
    totalSaleLbl.layer.masksToBounds = YES;
    totalSaleLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    totalSaleLbl.textColor = [UIColor whiteColor];
    totalSaleLbl.font = [UIFont boldSystemFontOfSize:18.0];
    totalSaleLbl.textAlignment = NSTextAlignmentCenter;
    totalSaleLbl.text = @"Total Sale";
    
    actionLbl= [[UILabel alloc] init];
    actionLbl.layer.cornerRadius = 14;
    actionLbl.layer.masksToBounds = YES;
    actionLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    actionLbl.textColor = [UIColor whiteColor];
    actionLbl.font = [UIFont boldSystemFontOfSize:18.0];
    actionLbl.textAlignment = NSTextAlignmentCenter;
    actionLbl.text = @"Action";
    
    //consumptionTbl creation...
    consumptionTbl = [[UITableView alloc] init];
    consumptionTbl.backgroundColor  = [UIColor blackColor];
    consumptionTbl.layer.cornerRadius = 4.0;
    consumptionTbl.bounces = TRUE;
    consumptionTbl.dataSource = self;
    consumptionTbl.delegate = self;
    consumptionTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            materialConsumptionView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            startDateTxt.frame = CGRectMake(materialConsumptionView.frame.origin.x+10, materialConsumptionView.frame.origin.y-40, 220, 40);
            
            endDateTxt.frame = CGRectMake(startDateTxt.frame.origin.x+startDateTxt.frame.size.width+30, startDateTxt.frame.origin.y, 220, 40);
            
            goButton.frame  = CGRectMake(endDateTxt.frame.origin.x+endDateTxt.frame.size.width+20,endDateTxt.frame
                                         .origin.y,80, 40);
            
            showStartDateBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-45), startDateTxt.frame.origin.y+2, 40, 35);
            
            showEndDateBtn.frame = CGRectMake((endDateTxt.frame.origin.x+ endDateTxt.frame.size.width-45), endDateTxt.frame.origin.y+2, 40, 35);
            
            snoLbl.frame = CGRectMake( startDateTxt.frame.origin.x,startDateTxt.frame.origin.y + startDateTxt.frame.size.height + 30, 70, 40);
            
            itemCodeLbl.frame = CGRectMake( snoLbl.frame.origin.x + snoLbl.frame.size.width + 2, snoLbl.frame.origin.y, 100,  snoLbl.frame.size.height);
            
            itemDescLbl.frame = CGRectMake( itemCodeLbl.frame.origin.x + itemCodeLbl.frame.size.width + 2, itemCodeLbl.frame.origin.y, 150,  itemCodeLbl.frame.size.height);
            
            uomLbl.frame = CGRectMake( itemDescLbl.frame.origin.x + itemDescLbl.frame.size.width + 2, itemDescLbl.frame.origin.y, 90,  itemDescLbl.frame.size.height);
            
            CategoryLbl.frame = CGRectMake( uomLbl.frame.origin.x + uomLbl.frame.size.width + 2, uomLbl.frame.origin.y, 140,  uomLbl.frame.size.height);
            
            unitPriceLbl.frame = CGRectMake( CategoryLbl.frame.origin.x + CategoryLbl.frame.size.width + 2, CategoryLbl.frame.origin.y, 100,  CategoryLbl.frame.size.height);
            
            soldQtyLbl.frame = CGRectMake( unitPriceLbl.frame.origin.x + unitPriceLbl.frame.size.width + 2, unitPriceLbl.frame.origin.y, 100,  unitPriceLbl.frame.size.height);
            
            totalSaleLbl.frame = CGRectMake( soldQtyLbl.frame.origin.x + soldQtyLbl.frame.size.width + 2, soldQtyLbl.frame.origin.y, 100,  soldQtyLbl.frame.size.height);
            
            actionLbl.frame = CGRectMake( totalSaleLbl.frame.origin.x + totalSaleLbl.frame.size.width + 2, totalSaleLbl.frame.origin.y, 130,  totalSaleLbl.frame.size.height);
            
            consumptionTbl.frame = CGRectMake(startDateTxt.frame.origin.x, snoLbl.frame.origin.y + snoLbl.frame.size.height+10, actionLbl.frame.origin.x+actionLbl.frame.size.width -(snoLbl.frame.origin.x),materialConsumptionView.frame.size.height - (snoLbl.frame.origin.y + snoLbl.frame.size.height +48));
            
            NSLog(@"%f----height",consumptionTbl.frame.size.height);
         
        }
    }
    
    
    [self.view addSubview:materialConsumptionView];

    [materialConsumptionView addSubview:startDateTxt];
    [materialConsumptionView addSubview:endDateTxt];
    [materialConsumptionView addSubview:showStartDateBtn];
    [materialConsumptionView addSubview:showEndDateBtn];
    
    [materialConsumptionView addSubview:goButton];
    
    [materialConsumptionView addSubview:snoLbl];
    [materialConsumptionView addSubview:itemCodeLbl];
    [materialConsumptionView addSubview:itemDescLbl];
    [materialConsumptionView addSubview:uomLbl];
    [materialConsumptionView addSubview:CategoryLbl];
    [materialConsumptionView addSubview:unitPriceLbl];
    [materialConsumptionView addSubview:soldQtyLbl];
    [materialConsumptionView addSubview:totalSaleLbl];
    [materialConsumptionView addSubview:actionLbl];
    
    [materialConsumptionView addSubview:consumptionTbl];
    

}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidLoad.......
 * @date         21/09/2016
 * @method       viewDidAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return
 * @modified BY
 * @reason
 * * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [HUD setHidden:NO];
    
    @try {
        
        startIndexInt = 0;
        materialConsumptionArr = [NSMutableArray new];
 
        [self getMaterialConsumption];
        
        
    } @catch (NSException *exception) {
        NSLog(@"----exception while calling service call------------%@",exception);
    } @finally {
        
    }
}



/**
 * @description  getting the details of material consumption.......
 * @date         01/03/2017
 * @method       getMaterialConsumption
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getMaterialConsumption {
    
    @try {
        
        [HUD setHidden:NO];
        
        NSLog(@"---getMaterialList---%d",startIndexInt);
        
        if( materialConsumptionArr == nil && startIndexInt == 0){
            
            maxRecords = 0;
            
            materialConsumptionArr = [NSMutableArray new];
        }
        else if(startIndexInt == 0 &&  materialConsumptionArr.count ){
            
            [materialConsumptionArr removeAllObjects];
        }
        
        NSMutableDictionary * consumptionDic = [[NSMutableDictionary alloc] init];
        
        NSString * startDteStr = startDateTxt.text;
        
        if((startDateTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDateTxt.text,@" 00:00:00"];
        
        NSString *endDteStr  = endDateTxt.text;
        
        if ((endDateTxt.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        }
        
        
        [consumptionDic setValue:[NSString stringWithFormat:@"%d",startIndexInt] forKey:kStartIndex];
        [consumptionDic setValue:[NSString stringWithFormat:@"%d",maxRecords] forKey:MAX_RECORDS];
        [consumptionDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [consumptionDic setValue:@0 forKey:kTotalBomCost];
        [consumptionDic setValue:@0 forKey:ITEM_PRICE];
        [consumptionDic setValue:@0 forKey:SALE_PRICE];
        [consumptionDic setValue:presentLocation forKey:kStoreLocation];
        [consumptionDic setValue:startDteStr forKey:kStartDateStr];
        [consumptionDic setValue:endDteStr forKey:kEndDateStr];

        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:consumptionDic options:0 error:&err];
        NSString * getConsumptionJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getConsumptionJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.bomMasterSvcDelegate = self;
        [webServiceController getMaterialConsumption:getConsumptionJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(void)getMaterialConsumptionSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        BornChildsArr  = [NSMutableArray new];
        
        for (NSDictionary * consumptionDic in [successDictionary valueForKey:@"bomSummaryList"]) {
            
            [materialConsumptionArr addObject:consumptionDic];
            
            NSMutableArray * bornChildArr = [NSMutableArray new];
            
            for (NSDictionary *locDic  in [consumptionDic valueForKey:@"bomChilds" ]) {
                [bornChildArr addObject:locDic];
            }
            
            [BornChildsArr addObject:bornChildArr];
            
            NSLog(@"%@",BornChildsArr);
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    @finally {
        
        [consumptionTbl reloadData];
        [HUD setHidden:YES];
    }
    
    
}


-(void)getMaterialConsumptionErrorResponse:(NSString *)errorResponse {
    @try {
        
        
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark displaying calendar:
/**
 * @description  here we are showing the calenderView.......
 * @date         01/03/2017
 * @method       showCalenderInPopUp
 * @author       Bhargav
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:materialConsumptionView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:materialConsumptionView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            //  customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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
        
        NSLog(@"----exception in the taxReportsView in showCalenderInPopUp:----%@",exception);
        
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
            if((startDateTxt.text).length)
                //                callServices = true;
                
                
                startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                //                callServices = true;
                
                endDateTxt.text = @"";
        }
        
        //       if(callServices){
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
        
        NSDate *existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if(  sender.tag == 2){
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDateTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Closed date should not be earlier than start date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            endDateTxt.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
        
        
        
    }
    
}


//checking the validations according to the date selection

-(void)goButtonPressesd:(UIButton *)sender {
    NSLog(@"responsePrinted");
    
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        [HUD setHidden:NO];
        goButton.tag = 4;
        startIndexInt = 0;
        
        
        [self getMaterialConsumption];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


#pragma mark  Navigation Methods

-(void)detailsNavigation:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);

    @try {
        
    //Play Audio for button touch....
        
        MaterialDetailsController * detailsController = [[MaterialDetailsController alloc] init];
        detailsController.detailsArray = BornChildsArr[sender.tag];
        [self.navigationController pushViewController:detailsController animated:YES];
        
    
       
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        
    }
    
}




#pragma -mark start of UITableViewDelegateMethods

/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date         26/09/2016
 * @method       showCompleteStockRequestInfo: numberOfRowsInSection:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger

 * @return
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == consumptionTbl) {
        return materialConsumptionArr.count;
    }
    
    else return 0;
    
 }

/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if(tableView == consumptionTbl){
            
            return  55;
            
        }
        
    }
    else {
        return 45;
    }
    return  0;
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         26/09/2016
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 * @return       UITableViewCell
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section and populating the data into labels....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @try {
        if(tableView == consumptionTbl) {
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
            
            UILabel * sno_Lbl = [[UILabel alloc] init];
            sno_Lbl.backgroundColor = [UIColor clearColor];
            sno_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            sno_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            sno_Lbl.textAlignment = NSTextAlignmentCenter;
            sno_Lbl.numberOfLines = 2;
            sno_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
           
            UILabel * itemCode_Lbl = [[UILabel alloc] init];
            itemCode_Lbl.backgroundColor = [UIColor clearColor];
            itemCode_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemCode_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            itemCode_Lbl.textAlignment = NSTextAlignmentCenter;
            itemCode_Lbl.numberOfLines = 1;
            itemCode_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
 
            UILabel * desc_Lbl = [[UILabel alloc] init];
            desc_Lbl.backgroundColor = [UIColor clearColor];
            desc_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            desc_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            desc_Lbl.textAlignment = NSTextAlignmentCenter;
            desc_Lbl.numberOfLines = 1;
            desc_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            UILabel * uom_Lbl = [[UILabel alloc] init];
            uom_Lbl.backgroundColor = [UIColor clearColor];
            uom_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            uom_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            uom_Lbl.textAlignment = NSTextAlignmentCenter;
            uom_Lbl.numberOfLines = 2;
            uom_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            UILabel * category_Lbl = [[UILabel alloc] init];
            category_Lbl.backgroundColor = [UIColor clearColor];
            category_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            category_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            category_Lbl.textAlignment = NSTextAlignmentCenter;
            category_Lbl.numberOfLines = 1;
            category_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            UILabel * unitPrice_Lbl = [[UILabel alloc] init];
            unitPrice_Lbl.backgroundColor = [UIColor clearColor];
            unitPrice_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            unitPrice_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            unitPrice_Lbl.textAlignment = NSTextAlignmentCenter;
            unitPrice_Lbl.numberOfLines = 2;
            unitPrice_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            UILabel * soldQty_Lbl = [[UILabel alloc] init];
            soldQty_Lbl.backgroundColor = [UIColor clearColor];
            soldQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            soldQty_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            soldQty_Lbl.textAlignment = NSTextAlignmentCenter;
            soldQty_Lbl.numberOfLines = 2;
            soldQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            UILabel * totalSale_Lbl = [[UILabel alloc] init];
            totalSale_Lbl.backgroundColor = [UIColor clearColor];
            totalSale_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            totalSale_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            totalSale_Lbl.textAlignment = NSTextAlignmentCenter;
            totalSale_Lbl.numberOfLines = 2;
            totalSale_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            viewChildBtn = [[UIButton alloc] init];
            viewChildBtn.backgroundColor = [UIColor blackColor];
            viewChildBtn.userInteractionEnabled = YES;
            viewChildBtn.tag = indexPath.row;
            [viewChildBtn addTarget:self action:@selector(detailsNavigation:) forControlEvents:UIControlEventTouchUpInside];
            [viewChildBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
            viewChildBtn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];

            [viewChildBtn setTitle:NSLocalizedString(@"Details", nil) forState:UIControlStateNormal];
            viewChildBtn.tag = indexPath.row;
            
// creation of line(UILabel) as a separator
            
            
//            UILabel *line = [[UILabel alloc] init];
//            //            line_2.textColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
//            line.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
//            
//            
//            line.frame = CGRectMake( 0, hlcell.frame.size.height - 2, consumptionTbl.frame.size.width, 2);
//            
//            line.text = @"-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";

            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

                sno_Lbl.frame = CGRectMake( 0, 0, snoLbl.frame.size.width + 1, hlcell.frame.size.height);
                itemCode_Lbl.frame = CGRectMake(sno_Lbl.frame.origin.x + sno_Lbl.frame.size.width, 0, itemCodeLbl.frame.size.width + 2,  hlcell.frame.size.height);
                
                desc_Lbl.frame = CGRectMake(itemCode_Lbl.frame.origin.x + itemCode_Lbl.frame.size.width, 0, itemDescLbl.frame.size.width + 2,  hlcell.frame.size.height);
                
                uom_Lbl.frame = CGRectMake(desc_Lbl.frame.origin.x + desc_Lbl.frame.size.width, 0, uomLbl.frame.size.width + 2,  hlcell.frame.size.height);
                
                category_Lbl.frame = CGRectMake(uom_Lbl.frame.origin.x + uom_Lbl.frame.size.width, 0, CategoryLbl.frame.size.width + 2,  hlcell.frame.size.height);
                
                unitPrice_Lbl.frame = CGRectMake(category_Lbl.frame.origin.x + category_Lbl.frame.size.width, 0, unitPriceLbl.frame.size.width + 2,  hlcell.frame.size.height);

                 soldQty_Lbl.frame = CGRectMake(unitPrice_Lbl.frame.origin.x + unitPrice_Lbl.frame.size.width, 0, soldQtyLbl.frame.size.width + 2,  hlcell.frame.size.height);
                
                 totalSale_Lbl.frame = CGRectMake(soldQty_Lbl.frame.origin.x + soldQty_Lbl.frame.size.width, 0, totalSaleLbl.frame.size.width + 2,  hlcell.frame.size.height);
      
                viewChildBtn.frame = CGRectMake(totalSale_Lbl.frame.origin.x + totalSale_Lbl.frame.size.width, 0, actionLbl.frame.size.width + 2,  hlcell.frame.size.height);
            }
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;

            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:sno_Lbl];
            [hlcell.contentView addSubview:itemCode_Lbl];
            [hlcell.contentView addSubview:desc_Lbl];
            [hlcell.contentView addSubview:uom_Lbl];
            [hlcell.contentView addSubview:category_Lbl];
            [hlcell.contentView addSubview:unitPrice_Lbl];
            [hlcell.contentView addSubview:soldQty_Lbl];
            [hlcell.contentView addSubview:totalSale_Lbl];
            [hlcell.contentView addSubview:viewChildBtn];

            @try {
                
                NSDictionary * dic = materialConsumptionArr[indexPath.row];
                
                sno_Lbl.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
                
                itemCode_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"itemId"] defaultReturn:@"--"];
                desc_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"itemDescription"] defaultReturn:@"--"];
                uom_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"uom"] defaultReturn:@"--"];
                category_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"category"] defaultReturn:@"--"];
                
                unitPrice_Lbl.text = [NSString stringWithFormat:@"%d",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"unitPrice"] defaultReturn:@"0.00"] integerValue]];

                unitPrice_Lbl.text = [NSString stringWithFormat:@"%d",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"unitPrice"] defaultReturn:@"0"] integerValue]];
                
                soldQty_Lbl.text = [NSString stringWithFormat:@"%d",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"usedStock"] defaultReturn:@"0"] integerValue]];

                totalSale_Lbl.text = [NSString stringWithFormat:@"%d",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"totalCost"] defaultReturn:@"0"] integerValue]];
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
        return hlcell;
        }

    }
    @catch (NSException *exception) {
    
    }
    @finally {
        
    }
    
    
    
    
    
   
    return false;
}



/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         26/09/2016
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @param
 * @return       void

 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView ==consumptionTbl ){

        @try {
            
            MaterialDetailsController * detailsController = [[MaterialDetailsController alloc] init];
            detailsController.detailsArray = BornChildsArr[indexPath.row];
            [self.navigationController pushViewController:detailsController animated:YES];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }

}



//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    @try {
//        
//        if(tableView == consumptionTbl){
//            
//            @try {
//                
//                if ((indexPath.row == ([counterIdArr count ]-1)) && ([counterIdArr count] < totalRecordsInt ) && ([BornChildsArr count]> reportStartIndex )) {
//                    
//                    [HUD show:YES];
//                    [HUD setHidden:NO];
//                    reportStartIndex = reportStartIndex + 10;
//                    [self callingSkuServiceforRecords];
//                    
//                }
//                
//            } @catch (NSException *exception) {
//                NSLog(@"-----------exception in servicecall-------------%@",exception);
//                [HUD setHidden:YES];
//            }
//        }
//    } @catch (NSException *exception) {
//        
//    }
//}


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

#pragma - mark superClass methods....

/**
 * @description  in this method  we are navigation currentClass to OmniHomePage...
 * @date         06/10/2016
 * @method       goToHome
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)goToHome {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        OmniHomePage *homePage = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:homePage animated:YES];
    } @catch (NSException *exception) {
        NSLog(@"-----exception in goToHome() of RequestForQuotation----------%@",exception);
    }
}

/**
 * @description  it will be executed then the user clicked the back action......
 * @date         10/09/2016
 * @method       backAction
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)backAction {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
        NSLog(@"-----exception in goToHome() of RequestForQuotation----------%@",exception);
        
        
    }
}





@end

//        categoryAndSubcategoryInfoDic = [NSMutableDictionary new];
//
//        for(NSDictionary *dic in [sucessDictionary valueForKey:@"categories"]){
//
//            [categoriesArr addObject:[dic valueForKey:@"categoryDescription"]];
//
//
//            NSMutableArray *subArr =  [NSMutableArray new];
//            for(NSDictionary *locDic in [dic valueForKey:@"subCategories"]){
//
//
//                [subArr addObject:[locDic valueForKey:@"subcategoryDescription"]];
//            }
//            if(![subArr count])
//                [ subArr addObject:@"--No Sub Categories--"];
//
//            [categoryAndSubcategoryInfoDic setObject:subArr  forKey:[dic valueForKey:@"bomRef"]];
//
//        }
//






