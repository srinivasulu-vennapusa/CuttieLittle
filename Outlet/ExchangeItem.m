//
//  ExchangeItem.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 11/28/14.
//
//

#import "ExchangeItem.h"
#import "SalesServiceSvc.h"
#import "Global.h"
#import "PastBilling.h"
#import "BillingHome.h"
#import "ExchangingBillingHome.h"
#import "OmniHomePage.h"

NSString *billValue1 = @"";
NSMutableArray *exchangedItems;
NSString *totalBillValue1 = @"";
int tagid2 = 0;
NSString *exchangeBillStatus;

@interface ExchangeItem ()

@end

@implementation ExchangeItem

@synthesize presentTextField;

-(id) initWithBillType:(NSString *)typeOfBill exchangingItems:(NSMutableArray *)exchangingItems totalBill:(NSString *)totalBill billStatus:(NSString *)billStatus {
    
    billValue1 = [typeOfBill copy];
    exchangeBillStatus = billStatus;
    totalBill = @"0";
    
    for (int i = 0; i < exchangingItems.count; i++) {
        NSArray *temp = [exchangingItems[i] copy];
        float price = [temp[3] floatValue]/[temp[2] floatValue];
        NSArray *temp1 = @[temp[0],temp[1],temp[2],temp[3],[NSString stringWithFormat:@"%.1f",price],[NSString stringWithFormat:@"%@",@"0"]];
        exchangingItems[i] = temp1;
        
        totalBill = [NSString stringWithFormat:@"%.1f",totalBill.floatValue + [temp[3] floatValue]];
    }
    
    totalBillValue1 = [totalBill copy];
    
    exchangedItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < exchangingItems.count; i++) {
        [exchangedItems addObject:exchangingItems[i]];
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    
        self.navigationController.navigationBarHidden = NO;
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 45.0)];
        titleView.backgroundColor = [UIColor clearColor];
        
        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
        logoView.backgroundColor = [UIColor clearColor];
        logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0, 200.0, 70.0)];
        titleLbl.text = @"Sales Exchange";
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
//            titleLbl.textColor = [UIColor whiteColor];
            titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        }
        
        self.navigationItem.titleView = titleView;
        
        
        self.view.backgroundColor = [UIColor blackColor];
        
        // [self.navigationItem setHidesBackButton:YES];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 35, 35);
        [btn addTarget:self action:@selector(homeButonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *homeBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        self.navigationItem.rightBarButtonItem = homeBtn;
        
        selectedItems = [[NSMutableArray alloc] init];
        off = [UIImage imageNamed:@"checkbox_off_background.png"];
        on  = [UIImage imageNamed:@"checkbox_on_background.png"];
        
        billID = [[UILabel alloc] init];
        billID.text = @"Bill ID";
        billID.font = [UIFont boldSystemFontOfSize:14];
        billID.textColor = [UIColor whiteColor];
        billID.backgroundColor = [UIColor clearColor];
        
        billIDValue = [[UILabel alloc] init];
        billIDValue.text = billValue1;
        billIDValue.font = [UIFont systemFontOfSize:14];
        billIDValue.textColor = [UIColor whiteColor];
        billIDValue.backgroundColor = [UIColor clearColor];
        
        label_1 = [[UILabel alloc] init];
        label_1.text = @"Item";
        label_1.layer.cornerRadius = 14;
        label_1.textAlignment = NSTextAlignmentCenter;
        label_1.layer.masksToBounds = YES;
        label_1.font = [UIFont boldSystemFontOfSize:14.0];
        label_1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        label_1.textColor = [UIColor whiteColor];
        
        label_2 = [[UILabel alloc] init];
        label_2.text = @"Price";
        label_2.layer.cornerRadius = 14;
        label_2.layer.masksToBounds = YES;
        label_2.textAlignment = NSTextAlignmentCenter;
        label_2.font = [UIFont boldSystemFontOfSize:14.0];
        label_2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        label_2.textColor = [UIColor whiteColor];
        
        label_3 = [[UILabel alloc] init];
        label_3.text = @"Avail.";
        label_3.layer.cornerRadius = 14;
        label_3.layer.masksToBounds = YES;
        label_3.textAlignment = NSTextAlignmentCenter;
        label_3.font = [UIFont boldSystemFontOfSize:14.0];
        label_3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        label_3.textColor = [UIColor whiteColor];
        
        label_4 = [[UILabel alloc] init];
        label_4.text = @"Return";
        label_4.layer.cornerRadius = 14;
        label_4.layer.masksToBounds = YES;
        label_4.textAlignment = NSTextAlignmentCenter;
        label_4.font = [UIFont boldSystemFontOfSize:14.0];
        label_4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];;
        label_4.textColor = [UIColor whiteColor];
        
        label_5 = [[UILabel alloc] init];
        label_5.text = @"Cost";
        label_5.layer.cornerRadius = 14;
        label_5.layer.masksToBounds = YES;
        label_5.textAlignment = NSTextAlignmentCenter;
        label_5.font = [UIFont boldSystemFontOfSize:14.0];
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
        total_Bill.font = [UIFont boldSystemFontOfSize:14];
        total_Bill.textColor = [UIColor whiteColor];
        total_Bill.backgroundColor = [UIColor clearColor];
        
        total_Bill_Value = [[UILabel alloc] init];
        total_Bill_Value.text = totalBillValue1;
        total_Bill_Value.font = [UIFont boldSystemFontOfSize:14];
        total_Bill_Value.textColor = [UIColor whiteColor];
        total_Bill_Value.backgroundColor = [UIColor clearColor];
        
        
        exchangingTotalBill = [[UILabel alloc] init];
        exchangingTotalBill.text = @"Exchanging Item Bill";
        exchangingTotalBill.font = [UIFont boldSystemFontOfSize:14];
        exchangingTotalBill.textColor = [UIColor whiteColor];
        exchangingTotalBill.backgroundColor = [UIColor clearColor];
        
        exchangingTotalBillValue = [[UILabel alloc] init];
        exchangingTotalBillValue.text = @"0.0";
        exchangingTotalBillValue.font = [UIFont boldSystemFontOfSize:14];
        exchangingTotalBillValue.textColor = [UIColor whiteColor];
        exchangingTotalBillValue.backgroundColor = [UIColor clearColor];
        
        reason = [[UILabel alloc] init];
        reason.text = @"Reason";
        reason.font = [UIFont boldSystemFontOfSize:14];
        reason.textColor = [UIColor whiteColor];
        reason.backgroundColor = [UIColor clearColor];
        
    reasonTextField = [[UITextView alloc] init];
    // reasonTextField.borderStyle = UITextBorderStyleRoundedRect;
    reasonTextField.textColor = [UIColor whiteColor];
    reasonTextField.font = [UIFont systemFontOfSize:18.0];
    reasonTextField.backgroundColor = [UIColor clearColor];
    // reasonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    reasonTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    reasonTextField.returnKeyType = UIReturnKeyDone;
    reasonTextField.layer.borderWidth = 1.0f;
    reasonTextField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    reasonTextField.delegate = self;
    
        submitButton = [[UIButton alloc] init];
        [submitButton addTarget:self action:@selector(proceedToBilling) forControlEvents:UIControlEventTouchUpInside];
        [submitButton setTitle:@"Proceed" forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        submitButton.layer.cornerRadius = 14;
        submitButton.layer.masksToBounds = YES;
        submitButton.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            billID.frame = CGRectMake(250.0, 5.0, 120.0, 30);
            billIDValue.frame = CGRectMake(400.0, 5.0,180, 30.0);
            billID.font = [UIFont boldSystemFontOfSize:25];
            billIDValue.font = [UIFont boldSystemFontOfSize:25];
            label_1.font = [UIFont boldSystemFontOfSize:25];
            label_1.frame = CGRectMake(10, 50, 140, 55);
            label_2.font = [UIFont boldSystemFontOfSize:25];
            label_2.frame = CGRectMake(154, 50, 140, 55);
            label_3.font = [UIFont boldSystemFontOfSize:25];
            label_3.frame = CGRectMake(296, 50, 140, 55);
            label_4.font = [UIFont boldSystemFontOfSize:25];
            label_4.frame = CGRectMake(438, 50, 140, 55);
            label_5.font = [UIFont boldSystemFontOfSize:25];
            label_5.frame = CGRectMake(580, 50, 120, 55);
            itemTable.frame = CGRectMake(0.0, 120.0, self.view.frame.size.width, 410.0);
            total_Bill.frame = CGRectMake(35.0, 580.0, 120.0, 30.0);
            total_Bill.font = [UIFont boldSystemFontOfSize:25];
            total_Bill_Value.frame = CGRectMake(350.0, 580.0, 120.0, 30.0);
            total_Bill_Value.font = [UIFont boldSystemFontOfSize:25];
            exchangingTotalBill.frame = CGRectMake(35.0, 640.0, 240.0, 40.0);
            exchangingTotalBill.font = [UIFont boldSystemFontOfSize:25];
            exchangingTotalBillValue.frame = CGRectMake(350.0, 640.0, 120.0, 30.0);
            exchangingTotalBillValue.font = [UIFont boldSystemFontOfSize:25];
            reason.frame = CGRectMake(35.0, 700.0, 120.0, 40.0);
            reason.font = [UIFont boldSystemFontOfSize:25];
            reasonTextField.frame = CGRectMake(350.0, 700.0, 280.0, 100.0);
            reasonTextField.font = [UIFont boldSystemFontOfSize:25];
            submitButton.frame = CGRectMake(300.0, 810.0, 200.0, 50.0);
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
            exchangingTotalBill.frame = CGRectMake(15.0, 220.0, 150.0, 40.0);
            exchangingTotalBillValue.frame = CGRectMake(200.0, 225.0, 150.0, 30.0);
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
        [self.view addSubview:exchangingTotalBill];
        [self.view addSubview:exchangingTotalBillValue];
        [self.view addSubview:reason];
        [self.view addSubview:reasonTextField];
        [self.view addSubview:submitButton];
    
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
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
  
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
//    if (textField == reasonTextField) {
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            reason.frame = CGRectMake(35.0, 700.0, 120.0, 40.0);
//            reason.font = [UIFont boldSystemFontOfSize:25];
//            reasonTextField.frame = CGRectMake(350.0, 700.0, 200.0, 50.0);
//            reasonTextField.font = [UIFont boldSystemFontOfSize:25];
//        }
//        else {
//            
//        }
//        
//    }
//    
    return YES;
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    if (textView == reasonTextField) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            reason.frame = CGRectMake(35.0, 700.0, 120.0, 40.0);
            reason.font = [UIFont boldSystemFontOfSize:25];
            reasonTextField.frame = CGRectMake(350.0, 700.0, 280.0, 100.0);
            reasonTextField.font = [UIFont boldSystemFontOfSize:25];
        }
        else {
            
        }
        
    }
    
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
   
    if (textView == reasonTextField) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            reason.frame = CGRectMake(35.0, 520.0, 120.0, 40.0);
            reason.font = [UIFont boldSystemFontOfSize:25];
            reasonTextField.frame = CGRectMake(350.0, 470.0, 280.0, 100.0);
            reasonTextField.font = [UIFont boldSystemFontOfSize:25];
        }
        else {
            
        }
        
    }
    return YES;
}
-(void)proceedToBilling{
    
    for (int i = 0; i < exchangedItems.count; i++) {
        NSArray *temp = exchangedItems[i];
        if ([temp[5]intValue] > 0) {
            [selectedItems addObject:temp];
        }
    }
    
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
        confirmationAlertView.title = @"Do you want to Exchange the selected items";
        [confirmationAlertView addButtonWithTitle:@"YES"];
        [confirmationAlertView addButtonWithTitle:@"NO"];
        [confirmationAlertView show];
        confirmationAlertView.hidden = NO;
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"Do you want to Exchange the selected items"]) {
        if (alertView.numberOfButtons == 2) {
            if (buttonIndex==0) {
                
                self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
                
                NSMutableArray *exchanged_Items = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < selectedItems.count; i++) {
                    NSArray *temp = selectedItems[i];
                    [exchanged_Items addObject:temp];
                }
                
                //changed && commented by Srinivasul on 19/09/2017....
                //reason ---- autorelease, release, -- replicit decelerations are not required in ARC.
                
//                ExchangingBillingHome *bh = [[[ExchangingBillingHome alloc] initWithCreditValue:exchangingTotalBillValue.text oldBillId:billValue1 exchangingItems:exchanged_Items billStatus:exchangeBillStatus] autorelease];
                
//                ExchangingBillingHome *bh = [[ExchangingBillingHome alloc] initWithCreditValue:exchangingTotalBillValue.text oldBillId:billValue1 exchangingItems:exchanged_Items billStatus:exchangeBillStatus];
//
//                [self.navigationController pushViewController:bh animated:YES];

                //upto here on 19/09/2017....
                
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
        
        PastBilling *bh = [[PastBilling alloc] initWithBillType:billValue1];
        bh.isBillSummery = false;

        [self.navigationController pushViewController:bh animated:YES];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return exchangedItems.count;
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
    
    @try {
        
        NSArray *temp3 = exchangedItems[indexPath.row];
        
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
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception.name);
        
    }
   
    cell.backgroundColor = [UIColor clearColor];
    cell.tag = indexPath.row;
    cell.tag = indexPath.row;
    
    return cell;
}

- (void) updatingItems:(UIButton *)sender{
    
    //Play Audio for button touch....
    //AudioServicesPlaySystemSound (soundFileObject);
    NSArray *temp3 = exchangedItems[sender.tag];
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
    else {
        
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
    
    tagid2 = sender.tag;
    
}


// okButtonPressed handler for quantity changed..
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
    
    NSArray *temp3 = exchangedItems[tagid2];
    
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
    else if([qtyFeild.text isEqualToString:@"0"]){
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        //        [alert release];
        //
        //        qtyFeild.text = nil;
        
        
        NSArray *temp = @[temp3[0],temp3[1],temp3[2], [NSString stringWithFormat:@"%.1f", [temp3[2] intValue] * [temp3[4] floatValue]],temp3[4],[NSString stringWithFormat:@"%@",qtyFeild.text]];
        
        exchangedItems[tagid2] = temp;
        
        float returningBill = 0.0;
        
        for (int i = 0; i < exchangedItems.count; i++) {
            NSArray *temp = exchangedItems[i];
            if ([temp[5]intValue] > 0) {
                returningBill = returningBill + [temp[3] floatValue];
            }
            
        }
        exchangingTotalBillValue.text = [NSString stringWithFormat:@"%.1f",returningBill];
        
        qtyChangeDisplyView.hidden = YES;
        
        [itemTable reloadData];
        //    }
        
    }
    else{
        
        NSArray *temp = @[temp3[0],temp3[1],temp3[2], [NSString stringWithFormat:@"%.1f", (qtyFeild.text).intValue * [temp3[4] floatValue]],temp3[4],[NSString stringWithFormat:@"%@",qtyFeild.text]];
        
        exchangedItems[tagid2] = temp;
        
        float returningBill = 0.0;
        
        for (int i = 0; i < exchangedItems.count; i++) {
            NSArray *temp = exchangedItems[i];
            if ([temp[5]intValue] > 0) {
                returningBill = returningBill + [temp[3] floatValue];
            }
            
        }
        exchangingTotalBillValue.text = [NSString stringWithFormat:@"%.1f",returningBill];
        
        qtyChangeDisplyView.hidden = YES;
        
        [itemTable reloadData];
        //    }
        
    }
}


// cancelButtonPressed handler quantity changed view cancel..
- (void)QtyCancelButtonPressed:(id)sender {
    
    
    //Play Audio for button touch....
    //AudioServicesPlaySystemSound (soundFileObject);
    
    qtyChangeDisplyView.hidden = YES;
    itemTable.userInteractionEnabled = TRUE;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField1 {
    
    presentTextField = textField1;
    
}

-(void)doneWithNumberPad{
    
    [qty1 resignFirstResponder];
    
    if (presentTextField != nil) {
        [presentTextField resignFirstResponder];
    }
    
}

- (void) checkmark:(id)sender {
    
    //Play Audio for button touch....
    // AudioServicesPlaySystemSound (soundFileObject);
    
    off = [UIImage imageNamed:@"checkbox_off_background.png"];
    on  = [UIImage imageNamed:@"checkbox_on_background.png"];
    
    NSString *temp = [NSString stringWithFormat:@"%d",[sender tag]];
    
    
    if(![selectedItems containsObject:temp]) {
        //
        [sender setImage:on forState:UIControlStateNormal];
        [selectedItems addObject:temp];
    }
    else {
        [sender setImage:off forState:UIControlStateNormal];
        [selectedItems removeObject:temp];
    }
    
}

-(void)homeButonClicked:(id)sender {
    
    OmniHomePage *home = [[OmniHomePage alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
