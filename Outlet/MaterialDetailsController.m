//
//  MaterialDetailsController.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/24/17.
//
//

#import "MaterialDetailsController.h"
#import "OmniHomePage.h"


@interface MaterialDetailsController ()

@end

@implementation MaterialDetailsController

@synthesize soundFileURLRef,soundFileObject;
@synthesize detailsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) CFBridgingRetain(tapSound);
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    
    self.titleLabel.text = @"Material Consumption Details";
    
    
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
    
    
    
    
    //    creation of UIView
    consumptionDetailsView  = [[UIView alloc ]init];
    consumptionDetailsView.backgroundColor = [UIColor blackColor];
    consumptionDetailsView.layer.borderWidth = 2.0f;
    consumptionDetailsView.layer.cornerRadius = 8.0f;
    consumptionDetailsView.layer.borderColor = [UIColor clearColor].CGColor;
    
    
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
    
    
    qtyUnitsLbl = [[UILabel alloc] init];
    qtyUnitsLbl.layer.cornerRadius = 14;
    qtyUnitsLbl.layer.masksToBounds = YES;
    qtyUnitsLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    qtyUnitsLbl.textColor = [UIColor whiteColor];
    qtyUnitsLbl.font = [UIFont boldSystemFontOfSize:18.0];
    qtyUnitsLbl.textAlignment = NSTextAlignmentCenter;
    qtyUnitsLbl.text = @"Qty/Units";
    

    
    openStockLbl = [[UILabel alloc] init];
    openStockLbl.layer.cornerRadius = 14;
    openStockLbl.layer.masksToBounds = YES;
    openStockLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    openStockLbl.textColor = [UIColor whiteColor];
    openStockLbl.font = [UIFont boldSystemFontOfSize:18.0];
    openStockLbl.textAlignment = NSTextAlignmentCenter;
    openStockLbl.text = @"Open Stock";
    
    closedStockLbl = [[UILabel alloc] init];
    closedStockLbl.layer.cornerRadius = 14;
    closedStockLbl.layer.masksToBounds = YES;
    closedStockLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    closedStockLbl.textColor = [UIColor whiteColor];
    closedStockLbl.font = [UIFont boldSystemFontOfSize:18.0];
    closedStockLbl.textAlignment = NSTextAlignmentCenter;
    closedStockLbl.text = @"Closed Stock";
    
    usedStockLbl = [[UILabel alloc] init];
    usedStockLbl.layer.cornerRadius = 14;
    usedStockLbl.layer.masksToBounds = YES;
    usedStockLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    usedStockLbl.textColor = [UIColor whiteColor];
    usedStockLbl.font = [UIFont boldSystemFontOfSize:18.0];
    usedStockLbl.textAlignment = NSTextAlignmentCenter;
    usedStockLbl.text = @"Used Stock";
    
    totalCostLbl = [[UILabel alloc] init];
    totalCostLbl.layer.cornerRadius = 14;
    totalCostLbl.layer.masksToBounds = YES;
    totalCostLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    totalCostLbl.textColor = [UIColor whiteColor];
    totalCostLbl.font = [UIFont boldSystemFontOfSize:18.0];
    totalCostLbl.textAlignment = NSTextAlignmentCenter;
    totalCostLbl.text = @"Total Cost";
    
    
    //consumption details table creation...
    consumptionDetailsTbl = [[UITableView alloc] init];
    consumptionDetailsTbl.backgroundColor  = [UIColor blackColor];
    consumptionDetailsTbl.layer.cornerRadius = 4.0;
    consumptionDetailsTbl.bounces = TRUE;
    consumptionDetailsTbl.userInteractionEnabled  = YES;
    consumptionDetailsTbl.dataSource = self;
    consumptionDetailsTbl.delegate = self;
    consumptionDetailsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [consumptionDetailsView addSubview:itemCodeLbl];
    [consumptionDetailsView addSubview:itemDescLbl];
    [consumptionDetailsView addSubview:uomLbl];
    [consumptionDetailsView addSubview:qtyUnitsLbl];

    [consumptionDetailsView addSubview:openStockLbl];
    [consumptionDetailsView addSubview:closedStockLbl];
    [consumptionDetailsView addSubview:usedStockLbl];
    [consumptionDetailsView addSubview:totalCostLbl];
    
    [consumptionDetailsView addSubview:consumptionDetailsTbl];

    [self.view addSubview:consumptionDetailsView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            
            consumptionDetailsView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            itemCodeLbl.frame = CGRectMake(consumptionDetailsView.frame.origin.x+10 , consumptionDetailsView.frame.origin.y -30, 100, 40);
            
            itemDescLbl.frame = CGRectMake( itemCodeLbl.frame.origin.x + itemCodeLbl.frame.size.width + 2, itemCodeLbl.frame.origin.y, 160,  itemCodeLbl.frame.size.height);
            
            uomLbl.frame = CGRectMake( itemDescLbl.frame.origin.x + itemDescLbl.frame.size.width + 2, itemDescLbl.frame.origin.y, 110,  itemDescLbl.frame.size.height);
            
            
            qtyUnitsLbl.frame = CGRectMake( uomLbl.frame.origin.x + uomLbl.frame.size.width + 2, uomLbl.frame.origin.y, 120,  uomLbl.frame.size.height);
            
            openStockLbl.frame = CGRectMake( qtyUnitsLbl.frame.origin.x + qtyUnitsLbl.frame.size.width + 2, qtyUnitsLbl.frame.origin.y, 120,  qtyUnitsLbl.frame.size.height);
            
            closedStockLbl.frame = CGRectMake( openStockLbl.frame.origin.x + openStockLbl.frame.size.width + 2, openStockLbl.frame.origin.y, 130,  openStockLbl.frame.size.height);
            
            usedStockLbl.frame = CGRectMake( closedStockLbl.frame.origin.x + closedStockLbl.frame.size.width + 2, closedStockLbl.frame.origin.y, 120,  closedStockLbl.frame.size.height);
            
            totalCostLbl.frame = CGRectMake( usedStockLbl.frame.origin.x + usedStockLbl.frame.size.width + 2, usedStockLbl.frame.origin.y, 120,  usedStockLbl.frame.size.height);
            
            consumptionDetailsTbl.frame = CGRectMake( itemCodeLbl.frame.origin.x, itemCodeLbl.frame.origin.y + itemCodeLbl.frame.size.height+10, totalCostLbl.frame.origin.x+totalCostLbl.frame.size.width -(itemCodeLbl.frame.origin.x), consumptionDetailsView.frame.size.height - (itemCodeLbl.frame.origin.y + itemCodeLbl.frame.size.height  +  48));
            
            }
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
        @try {
            
           
       NSLog(@"%@-----Array",detailsArray);
            
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
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
    
    if (tableView == consumptionDetailsTbl) {
        
        if (detailsArray.count) {
            return detailsArray.count;

        }
        else return 2;
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
        if(tableView == consumptionDetailsTbl){
            
            return  55;
            
        }
        else
            return 0;
        
    }
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

           if(tableView == consumptionDetailsTbl) {
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
            
            UILabel * itemCode_Lbl = [[UILabel alloc] init];
            itemCode_Lbl.backgroundColor = [UIColor clearColor];
            itemCode_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemCode_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            itemCode_Lbl.textAlignment = NSTextAlignmentCenter;
            itemCode_Lbl.numberOfLines = 2;
            itemCode_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
               
               
            UILabel * itemDesc_Lbl = [[UILabel alloc] init];
            itemDesc_Lbl.backgroundColor = [UIColor clearColor];
            itemDesc_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemDesc_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            itemDesc_Lbl.textAlignment = NSTextAlignmentCenter;
            itemDesc_Lbl.numberOfLines = 1;
            itemDesc_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            UILabel * uom_Lbl = [[UILabel alloc] init];
            uom_Lbl.backgroundColor = [UIColor clearColor];
            uom_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            uom_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            uom_Lbl.textAlignment = NSTextAlignmentCenter;
            uom_Lbl.numberOfLines = 2;
            uom_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
               
            
            UILabel * qtyUnits_Lbl = [[UILabel alloc] init];
            qtyUnits_Lbl.backgroundColor = [UIColor clearColor];
            qtyUnits_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            qtyUnits_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            qtyUnits_Lbl.textAlignment = NSTextAlignmentCenter;
            qtyUnits_Lbl.numberOfLines = 2;
            qtyUnits_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
               
            
            UILabel * openStock_Lbl = [[UILabel alloc] init];
            openStock_Lbl.backgroundColor = [UIColor clearColor];
            openStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            openStock_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            openStock_Lbl.textAlignment = NSTextAlignmentCenter;
            openStock_Lbl.numberOfLines = 1;
            openStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            UILabel * closedStock_Lbl = [[UILabel alloc] init];
            closedStock_Lbl.backgroundColor = [UIColor clearColor];
            closedStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            closedStock_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            closedStock_Lbl.textAlignment = NSTextAlignmentCenter;
            closedStock_Lbl.numberOfLines = 2;
            closedStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            UILabel * usedStock_Lbl = [[UILabel alloc] init];
            usedStock_Lbl.backgroundColor = [UIColor clearColor];
            usedStock_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            usedStock_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            usedStock_Lbl.textAlignment = NSTextAlignmentCenter;
            usedStock_Lbl.numberOfLines = 2;
            usedStock_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            UILabel * totalCost_Lbl = [[UILabel alloc] init];
            totalCost_Lbl.backgroundColor = [UIColor clearColor];
            totalCost_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            totalCost_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            totalCost_Lbl.textAlignment = NSTextAlignmentCenter;
            totalCost_Lbl.numberOfLines = 2;
            totalCost_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            // creation of line as a separator
            
            
//            UILabel *line = [[UILabel alloc] init];
            //            line_2.textColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
//            line.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
//            
//            
//            line.frame = CGRectMake( 0, hlcell.frame.size.height - 2, consumptionDetailsTbl.frame.size.width, 2);
//            
//            line.text = @"-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
               
               if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                   
                   itemCode_Lbl.frame = CGRectMake( 0, 0, itemCodeLbl.frame.size.width + 1, hlcell.frame.size.height);
                   itemDesc_Lbl.frame = CGRectMake(itemCode_Lbl.frame.origin.x + itemCode_Lbl.frame.size.width, 0, itemDescLbl.frame.size.width + 2,  hlcell.frame.size.height);
                   
                    uom_Lbl.frame = CGRectMake(itemDesc_Lbl.frame.origin.x + itemDesc_Lbl.frame.size.width, 0, uomLbl.frame.size.width + 2,  hlcell.frame.size.height);
                   
                    qtyUnits_Lbl.frame = CGRectMake(uom_Lbl.frame.origin.x + uom_Lbl.frame.size.width, 0, qtyUnitsLbl.frame.size.width + 2,  hlcell.frame.size.height);
                   
                   openStock_Lbl.frame = CGRectMake(qtyUnits_Lbl.frame.origin.x + qtyUnits_Lbl.frame.size.width, 0, openStockLbl.frame.size.width + 2,  hlcell.frame.size.height);
                   
                   closedStock_Lbl.frame = CGRectMake(openStock_Lbl.frame.origin.x + openStock_Lbl.frame.size.width, 0, closedStockLbl.frame.size.width + 2,  hlcell.frame.size.height);
                   
                   usedStock_Lbl.frame = CGRectMake(closedStock_Lbl.frame.origin.x + closedStock_Lbl.frame.size.width, 0, usedStockLbl.frame.size.width + 2,  hlcell.frame.size.height);

                   totalCost_Lbl.frame = CGRectMake(usedStock_Lbl.frame.origin.x + usedStock_Lbl.frame.size.width, 0, totalCostLbl.frame.size.width + 2,  hlcell.frame.size.height);
               
               }
               hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
               
               hlcell.backgroundColor = [UIColor clearColor];
               [hlcell.contentView addSubview:itemCode_Lbl];
               [hlcell.contentView addSubview:itemDesc_Lbl];
               [hlcell.contentView addSubview:uom_Lbl];
               [hlcell.contentView addSubview:qtyUnits_Lbl];
               [hlcell.contentView addSubview:openStock_Lbl];
               [hlcell.contentView addSubview:closedStock_Lbl];
               [hlcell.contentView addSubview:usedStock_Lbl];
               [hlcell.contentView addSubview:totalCost_Lbl];
               
               @try {
                   
                   
                   if (detailsArray.count >= indexPath.row && detailsArray.count) {

                       NSDictionary * dic = detailsArray[indexPath.row];
                       
                       itemCode_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"itemId"] defaultReturn:@"--"];
                       
                       itemDesc_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"itemDescription"] defaultReturn:@"--"];
                       
                       uom_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:@"uom"] defaultReturn:@"--"];
                       
                       qtyUnits_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"quantity"] defaultReturn:@"0.00"] floatValue]];
                       
                       openStock_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"openStock"] defaultReturn:@"0.00"] floatValue]];
                       
                       closedStock_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"closedStock"] defaultReturn:@"0.00"] floatValue]];
                       
                       usedStock_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"usedStock"] defaultReturn:@"0.00"] floatValue]];
                       
                       totalCost_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"cost"] defaultReturn:@"0.00"] floatValue]];
                   }
                   else {
                       
                       itemCode_Lbl.text = @"--";
                       itemDesc_Lbl.text = @"--";
                       uom_Lbl.text = @"--";
                       qtyUnits_Lbl.text = @"--";
                       openStock_Lbl.text = @"--";
                       closedStock_Lbl.text = @"--";
                       usedStock_Lbl.text = @"--";
                       totalCost_Lbl.text = @"--";
                  }
                   
               }
               @catch (NSException *exception) {
                   
               }
               @finally {
                  
               }
               
               return hlcell;
               
        }

    return false;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark superClass methods....

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
