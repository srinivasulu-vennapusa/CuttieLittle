//
//  ReturnItem.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 11/26/14.
//
//

#import "ReturnItem.h"
#import "SalesServiceSvc.h"
#import "PastBilling.h"
#import "Global.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

@interface ReturnItem ()

@end

NSString *billValue = @"";
NSMutableArray *returnedItems;
NSString *totalBillValue = @"0";
NSString *pastBillStatus = @"";
NSString *dealsValue = @"";
NSString *subtotalValue = @"";

int tagid1 = 0;
@implementation ReturnItem

@synthesize presentTextField;

-(id) initWithBillType:(NSString *)typeOfBill returningItems:(NSMutableArray *)returningItems totalBill:(NSString *)totalBill billStatus:(NSString *)billStatus deals:(NSString *)deals1 subtotal:(NSString *)subtotal {
    
    billValue = [typeOfBill copy];
    pastBillStatus = [billStatus copy];
    
    totalBill = @"0";
    
    for (int i = 0; i < returningItems.count; i++) {
        
        NSArray *temp = [returningItems[i] copy];
        float price = [temp[3] floatValue]/[temp[2] floatValue];
        NSArray *temp1 = @[temp[0],temp[1],temp[2],temp[3],[NSString stringWithFormat:@"%.1f",price],[NSString stringWithFormat:@"%@",@"0"]];
        returningItems[i] = temp1;
        totalBill = [NSString stringWithFormat:@"%.1f",totalBill.floatValue + [temp[3] floatValue]];
    }
    
    totalBillValue = [totalBill copy];
    subtotalValue = [totalBill copy];
    dealsValue = [deals1 copy];
    
    returnedItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < returningItems.count; i++) {
        [returnedItems addObject:returningItems[i]];
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
    
    [logoView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *sinleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToHome)];
    [logoView addGestureRecognizer:sinleTap];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0, 200.0, 70.0)];
    titleLbl.text = @"Sales Return";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(80.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(115.0, -12.0, 150.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
//        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    }
    
    self.navigationItem.titleView = titleView;

    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn addTarget:self action:@selector(homeButonClicked:) forControlEvents:UIControlEventTouchUpInside];
   // UIBarButtonItem *homeBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
   // self.navigationItem.rightBarButtonItem = homeBtn;
    
    
    selectedItems = [[NSMutableArray alloc] init];
    off = [UIImage imageNamed:@"checkbox_off_background.png"];
    on  = [UIImage imageNamed:@"checkbox_on_background.png"];
    
    billID = [[UILabel alloc] init];
    billID.text = @"Bill ID";
    billID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0];
    billID.textColor = [UIColor whiteColor];
    billID.backgroundColor = [UIColor clearColor];
    
    billIDValue = [[UILabel alloc] init];
    billIDValue.text = billValue;
    billIDValue.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0];
    billIDValue.textColor = [UIColor whiteColor];
    billIDValue.backgroundColor = [UIColor clearColor];
    
    label_1 = [[UILabel alloc] init];
    label_1.text = @"Item";
    label_1.layer.cornerRadius = 14;
    label_1.textAlignment = NSTextAlignmentCenter;
    label_1.layer.masksToBounds = YES;
    label_1.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    label_1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_1.textColor = [UIColor whiteColor];
    
    label_2 = [[UILabel alloc] init];
    label_2.text = @"Price";
    label_2.layer.cornerRadius = 14;
    label_2.layer.masksToBounds = YES;
    label_2.textAlignment = NSTextAlignmentCenter;
    label_2.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    label_2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_2.textColor = [UIColor whiteColor];
    
    label_3 = [[UILabel alloc] init];
    label_3.text = @"Avail.";
    label_3.layer.cornerRadius = 14;
    label_3.layer.masksToBounds = YES;
    label_3.textAlignment = NSTextAlignmentCenter;
    label_3.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    label_3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_3.textColor = [UIColor whiteColor];
    
    label_4 = [[UILabel alloc] init];
    label_4.text = @"Return";
    label_4.layer.cornerRadius = 14;
    label_4.layer.masksToBounds = YES;
    label_4.textAlignment = NSTextAlignmentCenter;
    label_4.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    label_4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];;
    label_4.textColor = [UIColor whiteColor];
    
    label_5 = [[UILabel alloc] init];
    label_5.text = @"Cost";
    label_5.layer.cornerRadius = 14;
    label_5.layer.masksToBounds = YES;
    label_5.textAlignment = NSTextAlignmentCenter;
    label_5.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    label_5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_5.textColor = [UIColor whiteColor];
    
    itemTable = [[UITableView alloc] init];
    itemTable.backgroundColor = [UIColor clearColor];
    itemTable.layer.borderColor = [UIColor grayColor].CGColor;
    itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    itemTable.bounces = TRUE;
    itemTable.dataSource = self;
    itemTable.delegate = self;
    
    total_Bill = [[UILabel alloc] init];
    total_Bill.text = @"Total Bill";
    total_Bill.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    total_Bill.textColor = [UIColor whiteColor];
    total_Bill.backgroundColor = [UIColor clearColor];
    
    total_Bill_Value = [[UILabel alloc] init];
    total_Bill_Value.text = totalBillValue;
    total_Bill_Value.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    total_Bill_Value.textColor = [UIColor whiteColor];
    total_Bill_Value.backgroundColor = [UIColor clearColor];
    
    deals = [[UILabel alloc] init];
    deals.text = @"Deals/Offers";
    deals.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    deals.textColor = [UIColor whiteColor];
    deals.backgroundColor = [UIColor clearColor];
    
    deals_value = [[UILabel alloc] init];
    deals_value.text = dealsValue;
    deals_value.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    deals_value.textColor = [UIColor whiteColor];
    deals_value.backgroundColor = [UIColor clearColor];
    
    subtotal = [[UILabel alloc] init];
    subtotal.text = @"Subtotal";
    subtotal.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    subtotal.textColor = [UIColor whiteColor];
    subtotal.backgroundColor = [UIColor clearColor];
    
    subtotal_value = [[UILabel alloc] init];
    subtotal_value.text = subtotalValue;
    subtotal_value.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    subtotal_value.textColor = [UIColor whiteColor];
    subtotal_value.backgroundColor = [UIColor clearColor];
    
    
    
    
    returningTotalBill = [[UILabel alloc] init];
    returningTotalBill.text = @"Returning Item Bill";
    returningTotalBill.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    returningTotalBill.textColor = [UIColor whiteColor];
    returningTotalBill.backgroundColor = [UIColor clearColor];
    
    returningTotalBillValue = [[UILabel alloc] init];
    returningTotalBillValue.text = @"0.0";
    returningTotalBillValue.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    returningTotalBillValue.textColor = [UIColor whiteColor];
    returningTotalBillValue.backgroundColor = [UIColor clearColor];
    
    reason = [[UILabel alloc] init];
    reason.text = @"Reason";
    reason.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    reason.textColor = [UIColor whiteColor];
    reason.backgroundColor = [UIColor clearColor];
    
    reasonTextField = [[UITextView alloc] init];
    // reasonTextField.borderStyle = UITextBorderStyleRoundedRect;
    reasonTextField.textColor = [UIColor whiteColor];
    reasonTextField.font = [UIFont fontWithName:@"ArialRoundedMT" size:25.0];
    reasonTextField.backgroundColor = [UIColor clearColor];
    // reasonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    reasonTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    reasonTextField.returnKeyType = UIReturnKeyDone;
    reasonTextField.layer.borderWidth = 1.0f;
    reasonTextField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    reasonTextField.delegate = self;
    
    submitButton = [[UIButton alloc] init];
    [submitButton addTarget:self action:@selector(addReturnItems) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 14;
    submitButton.layer.masksToBounds = YES;
    submitButton.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        billID.frame = CGRectMake(250.0, 5.0, 120.0, 30);
        billIDValue.frame = CGRectMake(400.0, 5.0, 250, 30.0);
        billID.font = [UIFont boldSystemFontOfSize:25];
        billIDValue.font = [UIFont boldSystemFontOfSize:22];
        label_1.font = [UIFont systemFontOfSize:25.0];
        label_1.frame = CGRectMake(10, 50, 140, 55);
        label_2.font = [UIFont systemFontOfSize:25.0];
        label_2.frame = CGRectMake(154, 50, 140, 55);
        label_3.font = [UIFont systemFontOfSize:25.0];
        label_3.frame = CGRectMake(296, 50, 140, 55);
        label_4.font = [UIFont systemFontOfSize:25.0];
        label_4.frame = CGRectMake(438, 50, 140, 55);
        label_5.font = [UIFont systemFontOfSize:25.0];
        label_5.frame = CGRectMake(580, 50, 120, 55);
        itemTable.frame = CGRectMake(0.0, 120.0, self.view.frame.size.width, 250);
        
        deals.frame = CGRectMake(35.0, 360, 180, 30.0);
        deals.font = [UIFont systemFontOfSize:25.0];
        deals_value.frame = CGRectMake(550,360, 120.0, 30.0);
        deals_value.font = [UIFont systemFontOfSize:25.0];
        
        subtotal.frame = CGRectMake(35.0, 430, 120.0, 30.0);
        subtotal.font = [UIFont systemFontOfSize:25.0];
        subtotal_value.frame = CGRectMake(550,430, 120.0, 30.0);
        subtotal_value.font = [UIFont systemFontOfSize:25.0];
        
        total_Bill.frame = CGRectMake(35.0, 500, 120.0, 30.0);
        total_Bill.font = [UIFont systemFontOfSize:25.0];
        total_Bill_Value.frame = CGRectMake(550,500, 120.0, 30.0);
        total_Bill_Value.font = [UIFont systemFontOfSize:25.0];
        
        returningTotalBill.frame = CGRectMake(35.0, 570, 240.0, 40.0);
        returningTotalBill.font = [UIFont systemFontOfSize:25.0];
        returningTotalBillValue.frame = CGRectMake(550,570, 120.0, 30.0);
        returningTotalBillValue.font =[UIFont systemFontOfSize:25.0];
        reason.frame = CGRectMake(35.0, 620, 120.0, 40.0);
        reason.font = [UIFont systemFontOfSize:25.0];
        reasonTextField.frame = CGRectMake(60, 670, 550, 170);
        reasonTextField.font = [UIFont systemFontOfSize:25.0];
       // reasonTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Enter your reason" attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        submitButton.frame = CGRectMake(300.0, 860, 200.0, 50.0);
        submitButton.titleLabel.font = [UIFont systemFontOfSize:25.0];
    }
    else {
        btn.frame = CGRectMake(0, 0, 30, 30);
        billID.frame = CGRectMake(15.0, 5.0, 120.0, 30);
        billIDValue.frame = CGRectMake(150.0, 5.0, 120.0, 30.0);
        label_1.frame = CGRectMake(5, 40.0, 58, 30);
        label_2.frame = CGRectMake(64, 40.0, 58, 30);
        label_3.frame = CGRectMake(123, 40.0, 58, 30);
        label_4.frame = CGRectMake(181, 40.0, 58, 30);
        label_5.frame = CGRectMake(240, 40.0, 50, 30);
        itemTable.frame = CGRectMake(0.0, 75.0, 320.0, 100.0);
        total_Bill.frame = CGRectMake(15.0, 190.0, 120.0, 30.0);
        total_Bill_Value.frame = CGRectMake(200.0, 190.0, 120.0, 30.0);
        returningTotalBill.frame = CGRectMake(15.0, 220.0, 150.0, 40.0);
        returningTotalBillValue.frame = CGRectMake(200.0, 225.0, 150.0, 30.0);
        reason.frame = CGRectMake(15.0, 260.0, 120.0, 40.0);
        reasonTextField.frame = CGRectMake(150, 265.0, 150.0, 30.0);
        submitButton.frame = CGRectMake(90.0, 310.0, 150.0, 40.0);
    }
    
    [self.view addSubview:billID];
    [self.view addSubview:billIDValue];
    [self.view addSubview:label_1];
    [self.view addSubview:label_2];
    [self.view addSubview:label_3];
    [self.view addSubview:label_4];
    [self.view addSubview:label_5];
    [self.view addSubview:itemTable];
    [self.view addSubview:total_Bill];
    [self.view addSubview:total_Bill_Value];
    [self.view addSubview:returningTotalBill];
    [self.view addSubview:deals];
    [self.view addSubview:deals_value];
    [self.view addSubview:subtotal];
    [self.view addSubview:subtotal_value];

    [self.view addSubview:returningTotalBillValue];
    [self.view addSubview:reason];
    [self.view addSubview:reasonTextField];
    [self.view addSubview:submitButton];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"Please Wait...";
    [HUD setHidden:NO];
    [HUD show:YES];
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
-(void)addReturnItems{
    
    for (int i = 0; i < returnedItems.count; i++) {
        NSArray *temp = returnedItems[i];
        if ([temp[5]intValue] > 0) {
            [selectedItems addObject:temp];
        }
    }
    
    
    /*  [temp3 setValue:qtyFeild.text forKey:RETURN_QUANTITY];
     
     [tempReturnItems replaceObjectAtIndex:returnTagId withObject:temp3];
     */
    
    NSString *value = [reasonTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (selectedItems.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please select atlease one item to continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (value.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please fill the reason to continue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        UIAlertView *confirmationAlertView  = [[UIAlertView alloc] init];
        confirmationAlertView.delegate = self;
        confirmationAlertView.title = @"Do you want to return the selected items";
        [confirmationAlertView addButtonWithTitle:@"YES"];
        [confirmationAlertView addButtonWithTitle:@"NO"];
        [confirmationAlertView show];
        confirmationAlertView.hidden = NO;
        
    }
}

// Commented by roja on 17/10/2019.. // reason :- alertView: method contains SOAP Service call .. so taken new method with same name(alertView:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if ([alertView.title isEqualToString:@"Do you want to return the selected items"]) {
//        if (alertView.numberOfButtons == 2) {
//            if (buttonIndex==0) {
//
//                HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//                [self.navigationController.view addSubview:HUD];
//                // Regiser for HUD callbacks so we can remove it from the window at the right time
//                HUD.delegate = self;
//                HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
//                HUD.mode = MBProgressHUDModeCustomView;
//                HUD.labelText = @"Please Wait...";
//                [HUD setHidden:NO];
//                [HUD show:YES];
//
//                NSDate *today = [NSDate date];
//                NSDateFormatter *f = [[NSDateFormatter alloc] init];
//                f.dateFormat = @"yyyy/MM/dd HH:mm:ss";
//                NSString* currentdate = [f stringFromDate:today];
//
//                //commented by Srinivasulu on 20/07/2017....
//
////                UIDevice *myDevice = [UIDevice currentDevice];
////                NSString *deviceUDID = [[myDevice identifierForVendor] UUIDString];
//
//                //upto here on 20/07/2017....
//
//                SalesServiceSvcSoapBinding *custBindng =  [SalesServiceSvc SalesServiceSvcSoapBinding];
//                SalesServiceSvc_returningItem *aParameters = [[SalesServiceSvc_returningItem alloc] init];
//
//                //                NSError * err_;
//                //                NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//                //                NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//                NSMutableArray *cost = [[NSMutableArray alloc] init];
//                NSMutableArray *item_name = [[NSMutableArray alloc] init];
//                NSMutableArray *price = [[NSMutableArray alloc] init];
//                NSMutableArray *quantity = [[NSMutableArray alloc] init];
//                NSMutableArray *reason1 = [[NSMutableArray alloc] init];
//                NSMutableArray *sku_id = [[NSMutableArray alloc] init];
//
//                for (int i = 0; i < selectedItems.count; i++) {
//
//                    NSArray *temp = selectedItems[i];
//                    [cost addObject:temp[3]];
//                    [item_name addObject:temp[1]];
//                    [price addObject:temp[4]];
//                    [quantity addObject:temp[5]];
//                    [reason1 addObject:reasonTextField.text];
//                    [sku_id addObject:temp[0]];
//                }
//
//                NSString *return_status;
//
//                NSArray *keys = @[@"bill_id", @"cost",@"counter_id",@"date_and_time",@"item_name",@"price",@"quantity",@"reason",@"sku_id",@"status"];
//                if (!([pastBillStatus rangeOfString:@"TA" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
//
//                    return_status = @"TA-Returned";
//                }
//                else if (!([pastBillStatus rangeOfString:@"HD-PP" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
//
//                    return_status = @"HD-PP-Returned";
//                }
//                else {
//                    return_status = @"HD-COD-Returned";
//                }
//
//                //changed by Srinivasulu on 20/07/2017....
//
////                NSArray *objects = [NSArray arrayWithObjects:billValue,cost,deviceUDID,currentdate,item_name,price,quantity,reason1,sku_id,return_status,nil];
//                NSArray *objects = @[billValue,cost,deviceId,currentdate,item_name,price,quantity,reason1,sku_id,return_status];
//
//
//                //upot here on 20/07/2017...
//
//                NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//                NSError * err;
//                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//                NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//                NSArray *headerKeys1 = @[@"requestHeader", @"returningItemDetails"];
//
//                NSArray *headerObjects1 = @[[RequestHeader getRequestHeader],createBillingJsonString];
//                NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjects:headerObjects1 forKeys:headerKeys1];
//
//                NSError * err1;
//                NSData * jsonData1 = [NSJSONSerialization dataWithJSONObject:dictionary1 options:0 error:&err1];
//                NSString * jsonString = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
//                aParameters.returning_item_details = jsonString;
//                @try {
//
//                    SalesServiceSvcSoapBindingResponse *response = [custBindng returningItemUsingParameters:(SalesServiceSvc_returningItem *)aParameters];
//                    NSArray *responseBodyParts = response.bodyParts;
//                    for (id bodyPart in responseBodyParts) {
//                        if ([bodyPart isKindOfClass:[SalesServiceSvc_returningItemResponse class]]) {
//                            SalesServiceSvc_returningItemResponse *body = (SalesServiceSvc_returningItemResponse *)bodyPart;
//                            printf("\nresponse=%s",(body.return_).UTF8String);
//                            NSError *e;
//
//                            NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                                  options: NSJSONReadingMutableContainers
//                                                                                    error: &e];
//
//                            [HUD hide:YES afterDelay:0.5];
//
//                            //                        if ([[JSON1 objectForKey:@"returnedItemStatus"] isEqualToString:@"Failed to save details"]) {
//                            //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Process failed \n try after some time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                            //                            [alert show];
//                            //                            [alert release];
//                            //                        }
//                            //                        else if ([[JSON1 objectForKey:@"returnedItemStatus"] isEqualToString:@"Invalid Item"]){
//                            //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Selected item is invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                            //                            [alert show];
//                            //                            [alert release];
//                            //                        }
//                            //                        else if ([[JSON1 objectForKey:@"returnedItemStatus"] isEqualToString:@"Incorrect Data"]){
//                            //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Process failed \n try after some time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                            //                            [alert show];
//                            //                            [alert release];
//                            //                        }
//                            NSDictionary *response = [JSON1 valueForKey:@"responseHeader"];
//                            if ([[response valueForKey:@"responseCode"] isEqualToString:@"0"]) {
//
//                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[JSON1 valueForKey:@"returnedItemStatus"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                                [alert show];
//                                // [alert release];
//                                //                            billTypeStatus = TRUE;
//
//                                //                            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
//                                //                            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
//                                //
//                                //                            PastBilling *bh = [[[PastBilling alloc] initWithBillType:billValue] autorelease];
//                                //                            [self.navigationController pushViewController:bh animated:YES];
//                            }
//                        }
//                    }
//                }
//                @catch (NSException *exception) {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//
//                }
//                @finally {
//                    [HUD setHidden:YES];
//
//                }
//
//
//            }
//            else{
//                alertView.hidden = YES;
//            }
//        }
//    }
//    else if ([alertView.title isEqualToString:@"Success"]){
//        billTypeStatus = TRUE;
//
//        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
//
//        PastBilling *bh = [[PastBilling alloc] initWithBillType:billValue];
//        bh.isBillSummery = false;
//        [self.navigationController pushViewController:bh animated:YES];
//    }
//}






//alertView: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([alertView.title isEqualToString:@"Do you want to return the selected items"]) {
        
        if (alertView.numberOfButtons == 2) {
            
            if (buttonIndex==0) {
                
//                HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//                [self.navigationController.view addSubview:HUD];
//                // Regiser for HUD callbacks so we can remove it from the window at the right time
//                HUD.delegate = self;
//                HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
//                HUD.mode = MBProgressHUDModeCustomView;
//                HUD.labelText = @"Please Wait...";
                
                [HUD show:YES];
                [HUD setHidden:NO];
                
                NSDate *today = [NSDate date];
                NSDateFormatter *f = [[NSDateFormatter alloc] init];
                f.dateFormat = @"yyyy/MM/dd HH:mm:ss";
                NSString* currentdate = [f stringFromDate:today];
                
                
                NSMutableArray *cost = [[NSMutableArray alloc] init];
                NSMutableArray *item_name = [[NSMutableArray alloc] init];
                NSMutableArray *price = [[NSMutableArray alloc] init];
                NSMutableArray *quantity = [[NSMutableArray alloc] init];
                NSMutableArray *reason1 = [[NSMutableArray alloc] init];
                NSMutableArray *sku_id = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < selectedItems.count; i++) {
                    
                    NSArray *temp = selectedItems[i];
                    [cost addObject:temp[3]];
                    [item_name addObject:temp[1]];
                    [price addObject:temp[4]];
                    [quantity addObject:temp[5]];
                    [reason1 addObject:reasonTextField.text];
                    [sku_id addObject:temp[0]];
                }
                
                NSString *return_status;
                
                NSArray *keys = @[@"bill_id", @"cost",@"counter_id",@"date_and_time",@"item_name",@"price",@"quantity",@"reason",@"sku_id",@"status"];
                if (!([pastBillStatus rangeOfString:@"TA" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
                    
                    return_status = @"TA-Returned";
                }
                else if (!([pastBillStatus rangeOfString:@"HD-PP" options:NSCaseInsensitiveSearch].location == NSNotFound)) {
                    
                    return_status = @"HD-PP-Returned";
                }
                else {
                    return_status = @"HD-COD-Returned";
                }
                
                //changed by Srinivasulu on 20/07/2017....
                
                //                NSArray *objects = [NSArray arrayWithObjects:billValue,cost,deviceUDID,currentdate,item_name,price,quantity,reason1,sku_id,return_status,nil];
                NSArray *objects = @[billValue,cost,deviceId,currentdate,item_name,price,quantity,reason1,sku_id,return_status];
                
                
                //upot here on 20/07/2017...
                
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                
                NSError * err;
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
                NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                NSArray *headerKeys1 = @[@"requestHeader", @"returningItemDetails"];
                
                NSArray *headerObjects1 = @[[RequestHeader getRequestHeader],createBillingJsonString];
                NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjects:headerObjects1 forKeys:headerKeys1];
                
                NSError * err1;
                NSData * jsonData1 = [NSJSONSerialization dataWithJSONObject:dictionary1 options:0 error:&err1];
                NSString * jsonString = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
                
                WebServiceController * services =  [[WebServiceController alloc] init];
                services.salesServiceDelegate = self;
                [services getReturningItem:jsonString];
                
            }
            else{
                alertView.hidden = YES;
            }
        }
    }
    else if ([alertView.title isEqualToString:@"Success"]){
        billTypeStatus = TRUE;
        
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
        
        PastBilling *bh = [[PastBilling alloc] initWithBillType:billValue];
        bh.isBillSummery = false;
        [self.navigationController pushViewController:bh animated:YES];
    }
}

// added by Roja on 17/10/2019….
- (void)getReturningItemSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[successDictionary valueForKey:@"returnedItemStatus"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019….
- (void)getReturningItemErrorResponse:(NSString *)errorResponse{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return returnedItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 60.0;
    }
    else{
        return 35.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    off = [UIImage imageNamed:@"checkbox_off_background.png"];
    on  = [UIImage imageNamed:@"checkbox_on_background.png"];
    
    if ((cell.contentView).subviews){
        for (UIView *subview in (cell.contentView).subviews) {
            [subview removeFromSuperview];
        }
    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.frame = CGRectZero;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSArray *temp3 = returnedItems[indexPath.row];
    
    UILabel*label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:13.0];
    label1.layer.borderWidth = 1.5;
    label1.backgroundColor = [UIColor clearColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.numberOfLines = 2;
    label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
    label1.lineBreakMode = NSLineBreakByWordWrapping;
    label1.text = temp3[1];
    label1.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:13.0];
    label2.layer.borderWidth = 1.5;
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.numberOfLines = 2;
    label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
    label2.lineBreakMode = NSLineBreakByWordWrapping;
    label2.text = temp3[4];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.font = [UIFont systemFontOfSize:13.0];
    label3.layer.borderWidth = 1.5;
    label3.backgroundColor = [UIColor clearColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.numberOfLines = 2;
    label3.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
    label2.textAlignment = NSTextAlignmentCenter;
    label3.text = temp3[2];
    label3.textColor = [UIColor whiteColor];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.font = [UIFont systemFontOfSize:13.0];
    label4.layer.borderWidth = 1.5;
    label4.backgroundColor = [UIColor clearColor];
    label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
    label4.textAlignment = NSTextAlignmentCenter;
    label4.text = temp3[5];
    label4.textColor = [UIColor whiteColor];
    
    //    qty1 = [[[UITextField alloc] init] autorelease];
    //    qty1.textAlignment = NSTextAlignmentCenter;
    //    qty1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
    //    qty1.layer.borderWidth = 1.5;
    //    qty1.font = [UIFont systemFontOfSize:13.0];
    //    qty1.frame = CGRectMake(176, 0, 58, 34);
    //    qty1.backgroundColor = [UIColor whiteColor];
    //    qty1.text = [temp3 objectAtIndex:2];
    //    [qty1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidBegin];
    //    qty1.tag = indexPath.row;
    //    qty1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    qty1.adjustsFontSizeToFitWidth = YES;
    //    qty1.userInteractionEnabled = YES;
    //    qty1.delegate = self;
    //    [qty1 resignFirstResponder];
    
    UILabel *label5 = [[UILabel alloc] init];
    label5.font = [UIFont systemFontOfSize:13.0];
    label5.layer.borderWidth = 1.5;
    label5.backgroundColor = [UIColor clearColor];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.numberOfLines = 2;
    label5.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
    label5.textAlignment = NSTextAlignmentCenter;
    label5.text = temp3[3];
    label5.textColor = [UIColor whiteColor];
    //            NSString *str1 = [NSString stringWithFormat:@"%d",[[tempArrayItems objectAtIndex:(indexPath.row*5)+4] intValue]*[[tempArrayItems objectAtIndex:(indexPath.row*5)+3] intValue]];
    //            label5.text = str1;
    
    UIButton *editButton = [[UIButton alloc] init];
    [editButton setImage:[UIImage imageNamed:@"edit_button.png"] forState:UIControlStateNormal];
    editButton.backgroundColor = [UIColor clearColor];
    editButton.tag = indexPath.row;
    [editButton addTarget:self action:@selector(updatingItems:) forControlEvents:UIControlEventTouchUpInside];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        label1.font = [UIFont systemFontOfSize:25.0];
        label1.frame = CGRectMake(10, 0, 144, 56);
        label2.font = [UIFont systemFontOfSize:25.0];
        label2.frame = CGRectMake(154, 0, 144, 56);
        label3.font = [UIFont systemFontOfSize:25.0];
        label3.frame = CGRectMake(296, 0, 144, 56);
        label4.font = [UIFont systemFontOfSize:25.0];
        label4.frame = CGRectMake(438, 0, 144, 56);
        label5.font = [UIFont systemFontOfSize:25.0];
        label5.frame = CGRectMake(580, 0, 124, 56);
        editButton.frame = CGRectMake(710.0, 0, 50, 50);
    }
    else {
        label1.frame = CGRectMake(5, 0, 58, 30);
        label2.frame = CGRectMake(63, 0, 58, 30);
        label3.frame = CGRectMake(122, 0, 58, 30);
        label4.frame = CGRectMake(181, 0, 58, 30);
        label5.frame = CGRectMake(239, 0, 50, 30);
        editButton.frame = CGRectMake(290.0, 0, 30.0, 30.0);
    }
    
    //            NSString *str = [NSString stringWithFormat:@"%@#%@#%@#%@#%@#%@",label1.text,label2.text,label3.text,label4.text,label5.text,[tempArrayItems objectAtIndex:(indexPath.row*5)+1]];
    //            [cartItem addObject:str];
    
    [cell.contentView addSubview:label1];
    [cell.contentView addSubview:label2];
    [cell.contentView addSubview:label3];
    [cell.contentView addSubview:label4];
    [cell.contentView addSubview:label5];
    [cell.contentView addSubview:editButton];
    cell.backgroundColor = [UIColor clearColor];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void) updatingItems:(UIButton *)sender{
    
    //Play Audio for button touch....
    //AudioServicesPlaySystemSound (soundFileObject);
    NSArray *temp3 = returnedItems[sender.tag];
    //[textField resignFirstResponder];
    itemTable.userInteractionEnabled = FALSE;
    
    qtyChangeDisplyView = [[UIView alloc]init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        qtyChangeDisplyView.frame = CGRectMake(200, 300, 375, 300);
    }
    else{
        qtyChangeDisplyView.frame = CGRectMake(75, 68, 175, 200);
    }
    qtyChangeDisplyView.layer.borderWidth = 1.0;
    qtyChangeDisplyView.layer.cornerRadius = 10.0;
    qtyChangeDisplyView.layer.masksToBounds = YES;
    qtyChangeDisplyView.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    //        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index29" ofType:@"jpg"];
    //        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //
    //            img.frame = CGRectMake(0, 0, 375, 300);
    //        }
    //        else{
    //            img.frame = CGRectMake(0, 0, 175, 200);
    //        }
    //        [qtyChangeDisplyView addSubview:img];
    qtyChangeDisplyView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [self.view addSubview:qtyChangeDisplyView];
    
    UIImageView *img  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    // a label on top of the view ..
    UILabel *topbar = [[UILabel alloc] init];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor clearColor];
    topbar.textAlignment = NSTextAlignmentCenter;
    topbar.font = [UIFont boldSystemFontOfSize:17];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *availQty = [[UILabel alloc] init];
    availQty.text = @"Available Qty :";
    availQty.font = [UIFont boldSystemFontOfSize:14];
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    [qtyChangeDisplyView addSubview:availQty];
    
    UILabel *unitPrice = [[UILabel alloc] init];
    unitPrice.text = @"Unit Price       :";
    unitPrice.font = [UIFont boldSystemFontOfSize:14];
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    UILabel *availQtyData = [[UILabel alloc] init];
    availQtyData.text = temp3[2];
    availQtyData.font = [UIFont boldSystemFontOfSize:14];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    [qtyChangeDisplyView addSubview:availQtyData];
    
    UILabel *unitPriceData = [[UILabel alloc] init];
    unitPriceData.text = temp3[4];
    unitPriceData.font = [UIFont boldSystemFontOfSize:14];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    qtyFeild = [[UITextField alloc] init];
    qtyFeild.borderStyle = UITextBorderStyleRoundedRect;
    qtyFeild.textColor = [UIColor blackColor];
    qtyFeild.placeholder = @"Enter Qty";
    //NumberKeyBoard hidden....
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar1 sizeToFit];
    qtyFeild.keyboardType = UIKeyboardTypeNumberPad;
    qtyFeild.inputAccessoryView = numberToolbar1;
    //qtyFeild.text = textField.text;
    qtyFeild.font = [UIFont systemFontOfSize:17.0];
    qtyFeild.backgroundColor = [UIColor whiteColor];
    qtyFeild.autocorrectionType = UITextAutocorrectionTypeNo;
    //qtyFeild.keyboardType = UIKeyboardTypeDefault;
    qtyFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    qtyFeild.returnKeyType = UIReturnKeyDone;
    qtyFeild.delegate = self;
    
    /** ok Button for qtyChangeDisplyView....*/
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    okButton.backgroundColor = [UIColor grayColor];
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(QtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        img.frame = CGRectMake(0, 0, 375, 50);
        topbar.frame = CGRectMake(80, 5, 375, 40);
        topbar.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQty.frame = CGRectMake(10,60,200,40);
        availQty.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPrice.frame = CGRectMake(10,110,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQtyData.frame = CGRectMake(200,60,250,40);
        availQtyData.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPriceData.frame = CGRectMake(200,110,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:25];
        
        
        qtyFeild.frame = CGRectMake(110, 165, 150, 50);
        qtyFeild.font = [UIFont systemFontOfSize:25.0];
        
        
        okButton.frame = CGRectMake(60, 220, 80, 50);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        //            qtyCancelButton.frame = CGRectMake(250, 220, 80, 50);
        //            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        okButton.frame = CGRectMake(20, 235, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(190, 235, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
        
    }
    else{
        
        img.frame = CGRectMake(0, 0, 175, 32);
        topbar.frame = CGRectMake(0, 0, 175, 30);
        topbar.font = [UIFont boldSystemFontOfSize:17];
        
        availQty.frame = CGRectMake(10,40,100,30);
        availQty.font = [UIFont boldSystemFontOfSize:14];
        
        unitPrice.frame = CGRectMake(10,70,100,30);
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        
        availQtyData.frame = CGRectMake(115,40,60,30);
        availQtyData.font = [UIFont boldSystemFontOfSize:14];
        
        unitPriceData.frame = CGRectMake(115,70,60,30);
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        
        qtyFeild.frame = CGRectMake(36, 107, 100, 30);
        qtyFeild.font = [UIFont systemFontOfSize:17.0];
        
        okButton.frame = CGRectMake(10, 150, 75, 30);
        okButton.layer.cornerRadius = 14.0f;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        qtyCancelButton.frame = CGRectMake(90, 150, 75, 30);
        qtyCancelButton.layer.cornerRadius = 14.0f;
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    [qtyChangeDisplyView addSubview:img];
    [qtyChangeDisplyView addSubview:topbar];
    [qtyChangeDisplyView addSubview:availQty];
    [qtyChangeDisplyView addSubview:unitPrice];
    [qtyChangeDisplyView addSubview:availQtyData];
    [qtyChangeDisplyView addSubview:unitPriceData];
    [qtyChangeDisplyView addSubview:qtyFeild];
    [qtyChangeDisplyView addSubview:okButton];
    [qtyChangeDisplyView addSubview:qtyCancelButton];
    
    tagid1 = sender.tag;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
   if (textField == qtyFeild) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        
    }
    return YES;
    
}// okButtonPressed handler for quantity changed..
- (void)okButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    //AudioServicesPlaySystemSound (soundFileObject);
    
    itemTable.userInteractionEnabled = TRUE;
    NSString *value = [qtyFeild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:qtyFeild.text];
    int qty = value.intValue;
    
    @try {
       
        NSArray *temp3 = returnedItems[tagid1];
        
        if (qty > [temp3[2] intValue]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Available Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            qtyFeild.text = nil;
        }
        else if(value.length == 0 || !isNumber){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            qtyFeild.text = NO;
        }
        else if((qtyFeild.text).intValue == 0){
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //        [alert show];
            //        [alert release];
            //
            //        qtyFeild.text = nil;
            NSArray *temp = @[temp3[0],temp3[1],temp3[2], [NSString stringWithFormat:@"%.1f", [temp3[2] intValue] * [temp3[4] floatValue]],temp3[4],[NSString stringWithFormat:@"%@",qtyFeild.text]];
            
            returnedItems[tagid1] = temp;
            
            float returningBill = 0.0;
            
            for (int i = 0; i < returnedItems.count; i++) {
                NSArray *temp = returnedItems[i];
                if ([temp[5]intValue] > 0) {
                    returningBill = returningBill + [temp[3] floatValue];
                }
                
            }
            returningTotalBillValue.text = [NSString stringWithFormat:@"%.1f",returningBill];
            
            qtyChangeDisplyView.hidden = YES;
            
            [itemTable reloadData];
            
        }
        else{
            
            NSArray *temp = @[temp3[0],temp3[1],temp3[2], [NSString stringWithFormat:@"%.1f", (qtyFeild.text).intValue * [temp3[4] floatValue]],temp3[4],[NSString stringWithFormat:@"%@",qtyFeild.text]];
            
            returnedItems[tagid1] = temp;
            
            float returningBill = 0.0;
            
            for (int i = 0; i < returnedItems.count; i++) {
                NSArray *temp = returnedItems[i];
                if ([temp[5]intValue] > 0) {
                    returningBill = returningBill + [temp[3] floatValue];
                }
                
            }
            returningTotalBillValue.text = [NSString stringWithFormat:@"%.1f",returningBill];
            
            qtyChangeDisplyView.hidden = YES;
            
            [itemTable reloadData];
            //    }
            
        }
    }
    @catch (NSException *exception) {
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to update the quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    

    
}


// cancelButtonPressed handler quantity changed view cancel..
- (void)QtyCancelButtonPressed:(id)sender {
    
    
    //Play Audio for button touch....
    //AudioServicesPlaySystemSound (soundFileObject);
    
    qtyChangeDisplyView.hidden = YES;
    itemTable.userInteractionEnabled = TRUE;
}

-(void)doneWithNumberPad{
    
    [qty1 resignFirstResponder];
    
    if (presentTextField != nil) {
        [presentTextField resignFirstResponder];
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField1 {
    
    presentTextField = textField1;
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
//    if (textView == reasonTextField) {
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            reason.frame = CGRectMake(35.0, 700.0, 120.0, 40.0);
//            reason.font = [UIFont boldSystemFontOfSize:25];
//            reasonTextField.frame = CGRectMake(350.0, 700.0, 280.0, 100.0);
//            reasonTextField.font = [UIFont boldSystemFontOfSize:25];
//        }
//        else {
//            
//        }
//        
//    }
    
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
//    if (textView == reasonTextField) {
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            reason.frame = CGRectMake(35.0, 520.0, 120.0, 40.0);
//            reason.font = [UIFont boldSystemFontOfSize:25];
//            reasonTextField.frame = CGRectMake(350.0, 470.0, 280.0, 100.0);
//            reasonTextField.font = [UIFont boldSystemFontOfSize:25];
//        }
//        else {
//            
//        }
//        
//    }
    return YES;
}
- (void) checkmark:(id)sender {
    
    //Play Audio for button touch....
    // AudioServicesPlaySystemSound (soundFileObject);
    
    off = [UIImage imageNamed:@"checkbox_off_background.png"];
    on  = [UIImage imageNamed:@"checkbox_on_background.png"];
    
    NSString *temp = [NSString stringWithFormat:@"%d",[sender tag]];
    NSLog(@"%d",qty1.tag);
    
    if(![selectedItems containsObject:temp]) {
        //
        qty1.userInteractionEnabled = NO;
        [sender setImage:on forState:UIControlStateNormal];
        [selectedItems addObject:temp];
    }
    else {
        qty1.userInteractionEnabled = YES;
        [sender setImage:off forState:UIControlStateNormal];
        [selectedItems removeObject:temp];
    }
    
    totalBillValue = @"";
    for (int i = 0; i < selectedItems.count; i++) {
        NSArray *temp = returnedItems[[selectedItems[i] integerValue]];
        totalBillValue = [NSString stringWithFormat:@"%.1f",totalBillValue.floatValue + ([temp[2] intValue]*[temp[4] floatValue])];
    }
    total_Bill_Value.text = totalBillValue;
}
-(void)goToHome {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}
-(void)homeButonClicked:(id)sender {
    
    OmniHomePage *home = [[OmniHomePage alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}
@end
