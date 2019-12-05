//
//  StockMovementReportViewController.m
//  OmniRetailer
//
//  Created by technolans on 03/03/17.
//
//

#import "StockMovementReportViewController.h"
#import "Global.h"
#import "OmniHomePage.h"



@interface StockMovementReportViewController ()

@end

@implementation StockMovementReportViewController
@synthesize soundFileURLRef,soundFileObject;
@synthesize startOrder,endOrder;






/**
 * @description  it is used to navigate the User to Home Page
 * @date         07/03/2016
 * @method       goHome
 * @author       Prabhu
 * @param        BOOL
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */

- (void) goToHome {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    OmniHomePage * homepage = [[OmniHomePage alloc ]init];
    
    [self.navigationController pushViewController:homepage animated:YES];
    
    
    
}


#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         07/03/2017
 * @method       ViewDidLoad
 * @author       Prabhu
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) CFBridgingRetain(tapSound);
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    self.titleLabel.text = @"Stock Movement";
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    // UIView
    
    
    //creating the skuWiseReportView which will displayed completed Screen.......
    stockMovntView = [[UIView alloc] init];
    stockMovntView.backgroundColor = [UIColor blackColor];
    stockMovntView.layer.borderWidth = 1.0f;
    stockMovntView.layer.cornerRadius = 10.0f;
    stockMovntView.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    
    /** Table Headers Design*/
    
    UILabel *borderLine = [[UILabel alloc] init];
    borderLine.text = @"";
    borderLine.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.bounces =FALSE;
    
   
    ///-------------category View-------------//
    
    category = [[CustomTextField alloc] init];
    category.borderStyle = UITextBorderStyleRoundedRect;
    category.textColor = [UIColor blackColor];
    category.placeholder = @"Category";  //place holder
    category.backgroundColor = [UIColor whiteColor];
    category.autocorrectionType = UITextAutocorrectionTypeNo;
    category.keyboardType = UIKeyboardTypeDefault;
    category.returnKeyType = UIReturnKeyDone;
    category.clearButtonMode = UITextFieldViewModeWhileEditing;
    category.keyboardType = UIKeyboardTypeNumberPad;
    category.delegate = self;
    [category awakeFromNib];
    
    categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryImg = [UIImage imageNamed:@"arrow_1.png"];
    [categoryBtn setBackgroundImage:categoryImg forState:UIControlStateNormal];
   [categoryBtn addTarget:self action:@selector(populateCategory) forControlEvents:UIControlEventTouchDown];
    categoryBtn.tag = 1;
    category.delegate = self;
    

    
    ///--------------Start-Date----------------/////
    
    
    startOrder=[[UITextField alloc]init];
    startOrder.textColor=[UIColor whiteColor];
    startOrder.borderStyle=UITextBorderStyleRoundedRect;
    startOrder.placeholder=@"From";
    startOrder.layer.borderWidth=0.8f;
    startOrder.layer.borderColor=[[UIColor whiteColor]colorWithAlphaComponent:0.4].CGColor;
    startOrder.autocorrectionType=UITextAutocorrectionTypeNo;
    startOrder.attributedPlaceholder = [[NSAttributedString alloc]initWithString:startOrder.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
    startOrder.backgroundColor=[UIColor blackColor];
    startOrder.keyboardType=UIKeyboardTypeDefault;
    startOrder.clearButtonMode=UITextFieldViewModeWhileEditing;
    startOrder.userInteractionEnabled=NO;
    startOrder.delegate=self;
    startOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    startImageDate = [UIImage imageNamed:@"Calandar_Icon.png"];
    [startOrderButton setBackgroundImage:startImageDate forState:UIControlStateNormal];
    [startOrderButton addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    startOrderButton.tag = 2;
    
    ///--------------End-Date----------------/////
    
    endOrder=[[UITextField alloc]init];
    endOrder.textColor=[UIColor whiteColor];
    endOrder.borderStyle=UITextBorderStyleRoundedRect;
    endOrder.placeholder=@"To";
    endOrder.autocorrectionType=UITextAutocorrectionTypeNo;
    endOrder.layer.borderWidth=0.8f;
     endOrder.attributedPlaceholder = [[NSAttributedString alloc]initWithString:endOrder.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
    endOrder.layer.borderColor=[[UIColor whiteColor]colorWithAlphaComponent:0.4].CGColor;
    endOrder.backgroundColor=[UIColor blackColor];
    endOrder.keyboardType=UIKeyboardTypeDefault;
    endOrder.clearButtonMode=UITextFieldViewModeWhileEditing;
    endOrder.userInteractionEnabled=NO;
    endOrder.delegate=self;
    
    
    endOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    endImageDate = [UIImage imageNamed:@"Calandar_Icon.png"];
    [endOrderButton setBackgroundImage:endImageDate forState:UIControlStateNormal];
    [endOrderButton addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    endOrderButton.tag = 4;
    
    
    
    //-----------Generate Report Button------------//
    
    generateReport = [[UIButton alloc] init] ;
    [generateReport setTitle:@"Go" forState:UIControlStateNormal];
    [generateReport addTarget:self action:@selector(goButtonClicked:) forControlEvents:UIControlEventTouchDown];
    generateReport.backgroundColor = [UIColor grayColor];
    generateReport.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    generateReport.layer.cornerRadius = 20.0f;
    

    
    /** Create TableView */
    stockMovntTable = [[UITableView alloc]init];
    stockMovntTable.backgroundColor = [UIColor blackColor];
    stockMovntTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    stockMovntTable.dataSource = self;
    stockMovntTable.delegate = self;
    stockMovntTable.bounces = YES;
    stockMovntTable.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    
    
    //ProgressBar creation...
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];

    
                                //--------labels-------//
    
    //----sno--//
 
    slno=[[UILabel alloc]init];
    slno.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    slno.text = @"SNo";
    slno.textAlignment = NSTextAlignmentCenter;
    slno.textColor = [UIColor whiteColor];
    slno.layer.cornerRadius = 14;
    slno.layer.masksToBounds = YES;
    slno.font = [UIFont boldSystemFontOfSize:18.0];
    
    ///-----------------category-----------------////
    categorys=[[UILabel alloc]init];
    categorys.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    categorys.text = @"Category";
    categorys.textAlignment = NSTextAlignmentCenter;
    categorys.textColor = [UIColor whiteColor];
    categorys.layer.cornerRadius = 14;
    categorys.layer.masksToBounds = YES;
    categorys.font = [UIFont boldSystemFontOfSize:18.0];
    
      //----------itemCode-----------------//
    itemCode=[[UILabel alloc]init];
    itemCode.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    itemCode.text = @"Item Code";
    itemCode.textAlignment = NSTextAlignmentCenter;
    itemCode.textColor = [UIColor whiteColor];
    itemCode.layer.cornerRadius = 14;
    itemCode.layer.masksToBounds = YES;
    itemCode.font = [UIFont boldSystemFontOfSize:18.0];
    
    //---Item Desc --//
    itemdesc=[[UILabel alloc]init];
    itemdesc.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    itemdesc.text = @"Item Description";
    itemdesc.textAlignment = NSTextAlignmentCenter;
    itemdesc.textColor = [UIColor whiteColor];
    itemdesc.layer.cornerRadius = 14;
    itemdesc.layer.masksToBounds = YES;
    itemdesc.font = [UIFont boldSystemFontOfSize:18.0];

    //---OPen Qty --//
    openQty=[[UILabel alloc]init];
    openQty.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    openQty.text = @"Open Qty";
    openQty.textAlignment = NSTextAlignmentCenter;
    openQty.textColor = [UIColor whiteColor];
    openQty.layer.cornerRadius = 14;
    openQty.layer.masksToBounds = YES;
    openQty.font = [UIFont boldSystemFontOfSize:18.0];
    
    //---Close Qty --//
    closeQty=[[UILabel alloc]init];
    closeQty.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    closeQty.text = @"Close Qty";
    closeQty.textAlignment = NSTextAlignmentCenter;
    closeQty.textColor = [UIColor whiteColor];
    closeQty.layer.cornerRadius = 14;
    closeQty.layer.masksToBounds = YES;
    closeQty.font = [UIFont boldSystemFontOfSize:18.0];
    
    //---Inward Qty --//
    inwardQty=[[UILabel alloc]init];
    inwardQty.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    inwardQty.text = @"Inward Qty";
    inwardQty.textAlignment = NSTextAlignmentCenter;
    inwardQty.textColor = [UIColor whiteColor];
    inwardQty.layer.cornerRadius = 14;
    inwardQty.layer.masksToBounds = YES;
    inwardQty.font = [UIFont boldSystemFontOfSize:18.0];
    
    //---Sale Qty --//
    saleQty=[[UILabel alloc]init];
    saleQty.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    saleQty.text = @"Sale Qty";
    saleQty.textAlignment = NSTextAlignmentCenter;
    saleQty.textColor = [UIColor whiteColor];
    saleQty.layer.cornerRadius = 14;
    saleQty.layer.masksToBounds = YES;
    saleQty.font = [UIFont boldSystemFontOfSize:18.0];
    
    //---Sale Value --//
    saleValue=[[UILabel alloc]init];
    saleValue.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    saleValue.text = @"Sale Value";
    saleValue.textAlignment = NSTextAlignmentCenter;
    saleValue.textColor = [UIColor whiteColor];
    saleValue.layer.cornerRadius = 14;
    saleValue.layer.masksToBounds = YES;
    saleValue.font = [UIFont boldSystemFontOfSize:18.0];
    
    //---Write  Off --//
    writeOff=[[UILabel alloc]init];
    writeOff.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    writeOff.text = @"Write Off";
    writeOff.textAlignment = NSTextAlignmentCenter;
    writeOff.textColor = [UIColor whiteColor];
    writeOff.layer.cornerRadius = 14;
    writeOff.layer.masksToBounds = YES;
    writeOff.font = [UIFont boldSystemFontOfSize:18.0];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    
        stockMovntView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
 
        category.frame=CGRectMake(stockMovntView.frame.origin.x+20, stockMovntView.frame.origin.y-50,240, 40);
        
        categoryBtn.frame=CGRectMake((category.frame.origin.x+category.frame.size.width-45), category.frame.origin.y+2, 40, 35);
        
        startOrder.frame = CGRectMake(stockMovntView.frame.origin.x+300,stockMovntView.frame.origin.y-50, 240,40);
        
        startOrderButton.frame = CGRectMake((startOrder.frame.origin.x+startOrder.frame.size.width-45), startOrder.frame.origin.y+2, 40, 35);
        
        endOrder.frame=CGRectMake(stockMovntView.frame.origin.x+550, stockMovntView.frame.origin.y-50, 220,40);
        
        endOrderButton.frame = CGRectMake((endOrder.frame.origin.x+endOrder.frame.size.width-45), endOrder.frame.origin.y+2, 40, 35);
        
        generateReport.frame=CGRectMake(stockMovntView.frame.origin.x+800, stockMovntView.frame.origin.y-50, 100,40);
        
        scrollView.frame = CGRectMake(0, startOrder.frame.origin.y+startOrder.frame.size.height-10, 2300, stockMovntView.frame.size.height);
        
        scrollView.contentSize = CGSizeMake(2735, 650);
        
        slno.frame=CGRectMake(stockMovntView.frame.origin.x+10, stockMovntView.frame.origin.y-20, 60,40);
        
        stockMovntTable.frame = CGRectMake(slno.frame.origin.x,slno.frame.origin.y+slno.frame.size.height,scrollView.frame.size.width-40,scrollView.frame.size.height-200);
        
        categorys.frame=CGRectMake(slno.frame.origin.x+slno.frame.size.width+2, slno.frame.origin.y, 240,40);
        
        itemCode.frame=CGRectMake(categorys.frame.origin.x+categorys.frame.size.width+2, categorys.frame.origin.y, 150,40);
        
        itemdesc.frame=CGRectMake(itemCode.frame.origin.x+itemCode.frame.size.width+2, itemCode.frame.origin.y, 240,40);
        
        openQty.frame=CGRectMake(itemdesc.frame.origin.x+itemdesc.frame.size.width+2, itemdesc.frame.origin.y, 120,40);
        
        closeQty.frame=CGRectMake(openQty.frame.origin.x+openQty.frame.size.width+2, openQty.frame.origin.y, 120,40);
        
        inwardQty.frame=CGRectMake(closeQty.frame.origin.x+closeQty.frame.size.width+2, closeQty.frame.origin.y, 120,40);
        
        saleQty.frame=CGRectMake(inwardQty.frame.origin.x+inwardQty.frame.size.width+2, inwardQty.frame.origin.y, 120,40);
        
        saleValue.frame=CGRectMake(saleQty.frame.origin.x+saleQty.frame.size.width+2, saleQty.frame.origin.y, 120,40);
        
        writeOff.frame=CGRectMake(saleValue.frame.origin.x+saleValue.frame.size.width+2, saleValue.frame.origin.y, 120,40);
    
    }
    
    [self.view addSubview:stockMovntView];
    
    [stockMovntView addSubview:category];
    [stockMovntView addSubview:categoryBtn];
    
    [stockMovntView addSubview:startOrder];
    [stockMovntView addSubview:startOrderButton];
    
    [stockMovntView addSubview:endOrder];
    [stockMovntView addSubview:endOrderButton];
    [stockMovntView addSubview:generateReport];
    
    [stockMovntView addSubview:scrollView];
    
    [scrollView addSubview:slno];
    [scrollView addSubview:categorys];
    [scrollView addSubview:stockMovntTable];
    [scrollView addSubview:itemCode];
    [scrollView addSubview:itemdesc];
    [scrollView addSubview:openQty];
    [scrollView addSubview:closeQty];
    [scrollView addSubview:inwardQty];
    [scrollView addSubview:saleQty];
    [scrollView addSubview:saleValue];
    [scrollView addSubview:writeOff];
    
    
}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidLoad.......
 * @date         07/03/2016
 * @method       viewDidAppear
 * @author       Prabhu
 * @param        BOOL
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    [self getStockMovementDetails];

}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         07/03/2016
 * @method       didReceiveMemoryWarning
 * @author       Prabhu
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}


/**
 * @description  it is used to give the modification when the date Button is pressed
 * @date         07/03/2016
 * @method       DateButtonPressed
 * @author       Prabhu
 * @param        BOOL
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */


-(IBAction)DateButtonPressed:(UIButton*) sender {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [catPopOver dismissPopoverAnimated:YES];
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    
    pickView = [[UIView alloc] init];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(15, startOrder.frame.origin.y+startOrder.frame.size.height, 320, 320);
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
    
    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
    pickButton.frame = CGRectMake(110, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        if (sender.tag == 2) {
            [popover presentPopoverFromRect:startOrder.frame inView:stockMovntView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            pickButton.tag = 2;
            
        } else {
            
            [popover presentPopoverFromRect:endOrder.frame inView:stockMovntView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
   
        }
        catPopOver = popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        catPopOver = popover;
        
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

// handle getDate method for pick date from calendar.
-(IBAction)getDate:(UIButton* )sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate *existingDateString;
      
        if(sender.tag == 2){
            
            if ((startOrder.text).length != 0 && ( ![startOrder.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startOrder.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startOrder.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            startOrder.text = dateString;
            
        }
        else{
            
            if ((endOrder.text).length != 0 && ( ![endOrder.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endOrder.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endOrder.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"closed_date_should_not_be_earlier_than_created_date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            
            endOrder.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
        
    }
}

#pragma -mark start of UITableViewDelegateMethods

/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date         07/03/2017
 * @method       showCompleteStockMovementInfo: numberOfRowsInSection:
 * @author       Prabhu
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 *
 * @modified BY
 * @reason
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (tableView == stockMovntTable) {
        return stockMovementArr.count;
    }
    
    else if(tableView == categoriesTbl){
        
        return  categoriesArr.count;
    }
  
    else return 0;
}



/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         07/03/2017
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Prabhu
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == stockMovntTable) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 50;
        }
        
        else{
            
            return 45;
        }
    }
    else if(tableView == categoriesTbl) {
        
        return 45;
    }
    
    
    else return 0;
}


/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         07/03/2017
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Prabhu
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 * @return       UITableViewCell
 *
 * @modified BY 
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try
    {
        
        if (tableView == stockMovntTable) {
            
            static NSString *hlCellID = @"hlCellID";
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorColor = [UIColor clearColor];
            
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
            
            NSDictionary *summaryDic = stockMovementArr[indexPath.row];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (!isOfflineService) {
                    
                    UILabel *sno = [[UILabel alloc] init] ;
                    sno.text = [NSString stringWithFormat:@"%d",(indexPath.row +1)] ;
                    sno.font = [UIFont systemFontOfSize:20.0f];
                    sno.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    sno.layer.cornerRadius = 20.0f;
                    sno.layer.masksToBounds = YES;
                    sno.textAlignment = NSTextAlignmentCenter;
                    sno.frame = CGRectMake(0, 0, slno.frame.size.width, hlcell.frame.size.height);
                    
                    UILabel *categoryS = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"category"] isKindOfClass:[NSNull class]]) {
                        categoryS.text = [NSString stringWithFormat:@"%@",[summaryDic valueForKey:@"category"]];
                    }
                    else {
                        categoryS.text = @"--";
                    }
                    
                    categoryS.font = [UIFont systemFontOfSize:20.0f];
                    categoryS.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    categoryS.layer.cornerRadius = 20.0f;
                    categoryS.layer.masksToBounds = YES;
                    categoryS.textAlignment = NSTextAlignmentLeft;
                    categoryS.frame = CGRectMake(sno.frame.origin.x + sno.frame.size.width, 0, categorys.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    UILabel *itemCodes = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"skuId"] isKindOfClass:[NSNull class]]) {
                        itemCodes.text = [NSString stringWithFormat:@"%@",[summaryDic valueForKey:@"skuId"]];
                    }
                    else {
                        itemCodes.text = @"--";
                    }
                    
                    itemCodes.font = [UIFont systemFontOfSize:20.0f];
                    itemCodes.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    itemCodes.layer.cornerRadius = 20.0f;
                    itemCodes.layer.masksToBounds = YES;
                    itemCodes.textAlignment = NSTextAlignmentCenter;
                    itemCodes.frame = CGRectMake(categoryS.frame.origin.x + categoryS.frame.size.width, 0, itemCode.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    
                    UILabel *itemDescription = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"itemDescription"] isKindOfClass:[NSNull class]]) {
                        itemDescription.text = [NSString stringWithFormat:@"%@",[summaryDic valueForKey:@"itemDescription"]];
                    }
                    else {
                        itemDescription.text = @"--";
                    }
                    itemDescription.font = [UIFont systemFontOfSize:20.0f];
                    itemDescription.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    itemDescription.layer.cornerRadius = 20.0f;
                    itemDescription.layer.masksToBounds = YES;
                    itemDescription.textAlignment = NSTextAlignmentLeft;
                    itemDescription.frame = CGRectMake(itemCodes.frame.origin.x + itemCodes.frame.size.width, 0, itemdesc.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    UILabel *openQuantity = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"openQty"] isKindOfClass:[NSNull class]]) {
                        openQuantity.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"openQty"]floatValue]];
                    }
                    else {
                        openQuantity.text = @"--";
                    }
                    
                    openQuantity.font = [UIFont systemFontOfSize:20.0f];
                    openQuantity.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    openQuantity.layer.cornerRadius = 20.0f;
                    openQuantity.layer.masksToBounds = YES;
                    openQuantity.textAlignment = NSTextAlignmentCenter;
                    openQuantity.frame = CGRectMake(itemDescription.frame.origin.x + itemDescription.frame.size.width, 0, openQty.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    
                    UILabel *closedQty = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"closeQty"] isKindOfClass:[NSNull class]]) {
                        closedQty.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"closeQty"]floatValue]];
                    }
                    else {
                        closedQty.text = @"--";
                    }
                    
                    closedQty.font = [UIFont systemFontOfSize:20.0f];
                    closedQty.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    closedQty.layer.cornerRadius = 20.0f;
                    closedQty.layer.masksToBounds = YES;
                    closedQty.textAlignment = NSTextAlignmentCenter;
                    closedQty.frame = CGRectMake(openQuantity.frame.origin.x + openQuantity.frame.size.width, 0, closeQty.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    
                    
                    UILabel *inwardQuantity = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"inwardQty"] isKindOfClass:[NSNull class]]) {
                        inwardQuantity.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"inwardQty"]floatValue]];
                    }
                    else {
                        inwardQuantity.text = @"--";
                    }
                    
                    inwardQuantity.font = [UIFont systemFontOfSize:20.0f];
                    inwardQuantity.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    inwardQuantity.layer.cornerRadius = 20.0f;
                    inwardQuantity.layer.masksToBounds = YES;
                    inwardQuantity.textAlignment = NSTextAlignmentCenter;
                    inwardQuantity.frame = CGRectMake(closedQty.frame.origin.x + closedQty.frame.size.width, 0, inwardQty.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    
                    UILabel *salesQty = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"saleQty"] isKindOfClass:[NSNull class]]) {
                        salesQty.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"saleQty"]floatValue]];
                    }
                    else {
                        salesQty.text = @"--";
                    }
                    
                    salesQty.font = [UIFont systemFontOfSize:20.0f];
                    salesQty.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    salesQty.layer.cornerRadius = 20.0f;
                    salesQty.layer.masksToBounds = YES;
                    salesQty.textAlignment = NSTextAlignmentCenter;
                    salesQty.frame = CGRectMake(inwardQuantity.frame.origin.x + inwardQuantity.frame.size.width, 0, saleQty.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    
                    UILabel *salesValues = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"saleValue"] isKindOfClass:[NSNull class]]) {
                        salesValues.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"saleValue"]floatValue]];
                    }
                    else {
                        salesValues.text = @"--";
                    }
                    
                    salesValues.font = [UIFont systemFontOfSize:20.0f];
                    salesValues.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    salesValues.layer.cornerRadius = 20.0f;
                    salesValues.layer.masksToBounds = YES;
                    salesValues.textAlignment = NSTextAlignmentCenter;
                    salesValues.frame = CGRectMake(salesQty.frame.origin.x + salesQty.frame.size.width, 0, saleValue.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    
                    UILabel *writeOffs = [[UILabel alloc] init];
                    if (![[summaryDic valueForKey:@"writeOffQty"] isKindOfClass:[NSNull class]]) {
                        writeOffs.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"writeOffQty"]floatValue]];
                    }
                    else {
                        writeOffs.text = @"--";
                    }
                    
                    writeOffs.font = [UIFont systemFontOfSize:20.0f];
                    writeOffs.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    writeOffs.layer.cornerRadius = 20.0f;
                    writeOffs.layer.masksToBounds = YES;
                    writeOffs.textAlignment = NSTextAlignmentCenter;
                    writeOffs.frame = CGRectMake(salesValues.frame.origin.x + salesValues.frame.size.width, 0, writeOff.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    
                    
                    [hlcell.contentView addSubview:sno];
                    [hlcell.contentView addSubview:categoryS];
                    [hlcell.contentView addSubview:itemCodes];
                    [hlcell.contentView addSubview:itemDescription];
                    [hlcell.contentView addSubview:openQuantity];
                    [hlcell.contentView addSubview:closedQty];
                    [hlcell.contentView addSubview:inwardQuantity];
                    [hlcell.contentView addSubview:salesQty];
                    [hlcell.contentView addSubview:salesValues];
                    [hlcell.contentView addSubview:writeOffs];
                    
                }
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
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
                
                hlcell.textLabel.text = categoriesArr[indexPath.row];
                hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
                hlcell.textLabel.textColor = [UIColor blackColor];
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return hlcell;
                
            }
            @catch (NSException *exception) {
                
            }
            
        }
        
        else return false;
    }
    
    
    @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         07/03/2017
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Prabhu
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 * @return       UITableViewCell
 *
 * @modified BY
 * @reason
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor clearColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if  (tableView == categoriesTbl) {
        
        
        [catPopOver dismissPopoverAnimated:YES];
        
        category.text = categoriesArr[indexPath.row];
        
        [categoriesTbl setHidden:YES];
       // selectCounter.enabled = YES;
        reportStartIndex = 0;
        stockMovementArr = [NSMutableArray new];
        [self getStockMovementDetails];
    }
    else
    {
        tableView = stockMovntTable;
    }
    
}


/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         07/03/2017
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Prabhu
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 * @return       UITableViewCell
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    @try {
        
        if(tableView == stockMovntTable){
            
            @try {
                
                if ((indexPath.row == (stockMovementArr.count -1)) && (stockMovementArr.count < totalNumberOfStockMovement ) && (stockMovementArr.count> reportStartIndex )) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    reportStartIndex = reportStartIndex + 10;
                    [self getStockMovementDetails];
                    
                }
                
            } @catch (NSException *exception) {
                [HUD setHidden:YES];
                
                NSLog(@"-----------exception in servicecall-------------%@",exception);
            }
        }
    } @catch (NSException *exception) {
        
    }
}

#pragma  -mark  start of service calls for the StockMovement


/**
 * @description  here we are calling stockMovement.......
 * @date         07/03/2017
 * @method       getStockMovementDetails
 * @author       Prabhu
 * @param        NSString,NSArray
 * @param
 * @return
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */


-(void) getStockMovementDetails{
    
    @try {
        
        if(stockMovementArr == nil)
        stockMovementArr = [NSMutableArray new];
        
        NSString * startDteStr = startOrder.text;
        
        if((startOrder.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startOrder.text,@" 00:00:00"];
        
        NSString *endDteStr  = endOrder.text;
        
        if ((endOrder.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endOrder.text,@" 00:00:00"];
        }
        
        NSArray *headerKeys_ = @[REQUEST_HEADER,ITEM_PRICE,END_DATE,MAX_RECORDS,SALE_PRICE,START_DATE,kStartIndex,kStoreLocation,@"totalBomCost"];
        
        NSArray *headerObjects_ = @[[RequestHeader getRequestHeader],@0,endDteStr,@"10",@0,startDteStr,[NSString stringWithFormat:@"%d",reportStartIndex],presentLocation,@0] ;
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockMovementDelegate = self;
        [webServiceController getStockMovementDetails:quoteRequestJsonString];
        

    } @catch (NSException *exception) {

        [HUD setHidden:YES];
    
    } @finally {
        
    }
    }


#pragma -mark start of handling service call reponses

/**
 * @description  here we are handling the Success resposne received from services.......
 * @date         07/03/2017
 * @method       getStockRequestsSuccessResponse:
 * @author       Prabhu
 * @param        NSDictionary
 * @param
 * @return
 *
 * @modified BY  
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */


-(void) getStockMovementSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        totalNumberOfStockMovement = [successDictionary valueForKey:@"totalRecords"];
        
        for(NSDictionary *dic in [successDictionary valueForKey:@"stockMovementList"]){
            
            [stockMovementArr addObject:dic];
     
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [stockMovntTable reloadData];
        HUD.hidden=YES;

    }
    
}


/**
 * @description  here we are handling the Error resposne received from services.......
 * @date         07/03/2017
 * @method       getStockMovementErrorResponse:
 * @author       Prabhu
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */


-(void) getStockMovementErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Products Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [stockMovntTable reloadData];
        
    }
}

#pragma -mark getting the service after clicking Go button

/**
 * @description  here we are giving the Functionality for GO Button.......
 * @date         07/03/2017
 * @method       goButtonClicked
 * @author       Prabhu
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */



-(void)goButtonClicked:(UIButton *)sender {
    
    @try {
        [HUD setHidden:NO];
        reportStartIndex = 0;
        stockMovementArr = [NSMutableArray new];
        [self getStockMovementDetails];
        
 
    } @catch (NSException *exception) {
    
    } @finally {
        
    }
}

#pragma  -mark  start of service calls for Category


/**
 * @description  here we are calling category.......
 * @date         07/03/2017
 * @method       getCategories
 * @author       Prabhu
 * @param        NSDictionary,NSString,NSArray
 * @param
 * @return
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getCategories {
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        categoriesArr = [NSMutableArray new];
        
        NSArray *keys = @[@"requestHeader",@"startIndex",@"categoryName",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",@"",[NSNumber numberWithBool:true]];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * categoriesJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getProductCategory:categoriesJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    
}


#pragma -mark start of handling service call reponses

/**
 * @description  here we are handling the Success resposne from Category services.......
 * @date         07/03/2017
 * @method       getCategorySuccessResponse:
 * @author       Prabhu
 * @param        NSDictionary
 * @param
 * @return
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */

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


#pragma -mark start of handling service call reponses

/**
 * @description  here we are handling the Error resposne received from Category services.......
 * @date         07/03/2017
 * @method       getCategoryErrorResponse
 * @author       Prabhu
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getCategoryErrorResponse:(NSString*)error {
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Categories Found" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [HUD setHidden:YES];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}




#pragma -mark start of handling the Category POP UP

/**
 * @description  here we are handling the Category popup by receiving the resposne from Category services.......
 * @date         07/03/2017
 * @method       populateCategory
 * @author       Prabhu
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)populateCategory {
    
    @try {
        
        [self getCategories];
        
        AudioServicesPlaySystemSound(soundFileObject);
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, category.frame.size.width,200)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        categoriesTbl = [[UITableView alloc] init];
        categoriesTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        categoriesTbl.dataSource = self;
        categoriesTbl.delegate = self;
        (categoriesTbl.layer).borderWidth = 1.0f;
        categoriesTbl.layer.cornerRadius = 3;
        categoriesTbl.layer.borderColor = [UIColor grayColor].CGColor;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            categoriesTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
    
        }
        
        
        [customView addSubview:categoriesTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:category.frame inView:stockMovntView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(200.0, 500.0);
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
        
        [categoriesTbl reloadData];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

@end
