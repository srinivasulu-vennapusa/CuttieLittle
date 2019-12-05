//
//  SmsProviderView.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "SmsProviderView.h"

#import <QuartzCore/QuartzCore.h>
#import "DataBaseConnection.h"
#import "sqlite3.h"

static sqlite3 *database = nil;
static sqlite3_stmt *insertStmt = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *selectStmt = nil;

@implementation SmsProviderView

@synthesize smsProviderTable, listofProvidersArray;
@synthesize usrTxt, pswTxt, providerType;
@synthesize soundFileURLRef,soundFileObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    providerlabel = [[UILabel alloc] init];
    
    if (self) {
        // Initialization code
        
         self.backgroundColor = [UIColor blackColor];
               
        // creating table for a list view of service providers ..
        
        //self.smsProviderTable = [[UITableView alloc]initWithFrame:CGRectMake(10,65, self.frame.size.width - 20,self.frame.size.height - 200) style:UITableViewStylePlain];
        
        self.smsProviderTable = [[UITableView alloc]init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            self.smsProviderTable.frame = CGRectMake(30,100,600,530);
        }
        else{
            self.smsProviderTable.frame = CGRectMake(10,45,260,220);
        }
        
        self.smsProviderTable.backgroundColor = [UIColor blackColor];
        
        self.smsProviderTable.layer.cornerRadius = 15;
        self.smsProviderTable.layer.borderWidth = 1.0f;
        
        (self.smsProviderTable).dataSource = self;
        (self.smsProviderTable).delegate = self;
        
        [self addSubview:self.smsProviderTable];
        
        
        // array to store service providers list ..
        self.listofProvidersArray = [[NSMutableArray alloc] init];
        [self.listofProvidersArray addObject:@"SIM Card"];
        [self.listofProvidersArray addObject:@"ubaid"];
        [self.listofProvidersArray addObject:@"way2sms"];
        [self.listofProvidersArray addObject:@"160by2"];
        [self.listofProvidersArray addObject:@"indiarocks"];
        [self.listofProvidersArray addObject:@"site2sms"];
        [self.listofProvidersArray addObject:@"fullonsms"];
        
    }
    
    
    //Get data from database
    // getting the present value's from database ..
    NSString *userName = NULL;
    NSString *password = NULL;
    NSString *provder_type = NULL;
    
    NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
    
    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        
        const char *sqlStatement = "select * from SMSCredentials";
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {  
            while (sqlite3_step(selectStmt) == SQLITE_ROW) {  
                
                userName = @((char *)sqlite3_column_text(selectStmt, 0));
                password = @((char *)sqlite3_column_text(selectStmt, 1)); 
                provder_type = @((char *)sqlite3_column_text(selectStmt, 2));
            }
            sqlite3_finalize(selectStmt); 
        }
    }     
    
    selectStmt = nil;
    sqlite3_close(database);
 
    providerlabel.text = provder_type;
    
    UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"SMS Configuration";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
 
    
     // labels ..
    
   // UILabel *label = [[UILabel alloc] init];
    UILabel *usr   = [[UILabel alloc] init]; 
    UILabel *pwd   = [[UILabel alloc] init];
    
    
   // label.text = @"SELECT PROVIDER";
    usr.text   = @"User ID";
    pwd.text   = @"Password";
    
    usr.textColor = [UIColor whiteColor];
    pwd.textColor = [UIColor whiteColor];
    
    //label.backgroundColor = [UIColor clearColor];
    usr.backgroundColor   = [UIColor clearColor];
    pwd.backgroundColor   = [UIColor clearColor];

    
    // Text fields for username, password and providerType..
    
    self.usrTxt = [[UITextField alloc] init];
    self.pswTxt = [[UITextField alloc] init];
    //self.providerType = [[UITextField alloc] init];
    
    
    usrTxt.layer.masksToBounds=YES;
    usrTxt.layer.borderColor=[UIColor grayColor].CGColor;
    usrTxt.layer.borderWidth= 1.0f;
    
    pswTxt.layer.masksToBounds=YES;
    pswTxt.layer.borderColor=[UIColor grayColor].CGColor;
    pswTxt.layer.borderWidth= 1.0f;
    
    self.usrTxt.backgroundColor = [UIColor whiteColor];
    self.pswTxt.backgroundColor = [UIColor whiteColor];
    
    
    if (userName != NULL || password != NULL) {
        usrTxt.text = userName;
        pswTxt.text = password;
    }
    
    self.usrTxt.layer.cornerRadius = 5;
    self.pswTxt.layer.cornerRadius = 5;
    
    
    
    usrTxt.delegate = self;
    pswTxt.delegate = self;
    
    pswTxt.secureTextEntry = YES;
    
    // button to submit the sms details ..
    UIButton *submitBtn = [[UIButton alloc] init] ;
    [submitBtn addTarget:self action:@selector(closeSMSView:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.tag = 0;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.cornerRadius = 3.0f;
    
    
    // button to cancel the with out saving ..
    UIButton *cancelBtn = [[UIButton alloc] init] ;
    [cancelBtn addTarget:self action:@selector(closeSMSView:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.cornerRadius = 3.0f;
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        headerimg.frame = CGRectMake(0, 0, 668, 80);
        title.frame = CGRectMake(200, 15, 400, 50);
        title.font = [UIFont boldSystemFontOfSize:30];
        

        //label.frame = CGRectMake(180, 40, 400, 30);
        //label.font = [UIFont boldSystemFontOfSize:28];
        
        usr.frame = CGRectMake(30, 650, 150, 50);
        usr.font = [UIFont boldSystemFontOfSize:25];
        
        pwd.frame = CGRectMake(30, 720, 250, 50);
        pwd.font = [UIFont boldSystemFontOfSize:25];
        
        self.usrTxt.frame = CGRectMake(170, 650, 460, 60);
        self.usrTxt.font = [UIFont boldSystemFontOfSize:25];
        
        self.pswTxt.frame = CGRectMake(170, 720, 460, 60);
        self.pswTxt.font = [UIFont boldSystemFontOfSize:25];

        
        submitBtn.frame = CGRectMake(50, 810, 275, 60);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        submitBtn.layer.cornerRadius = 25.0f;
        
        cancelBtn.frame = CGRectMake(335, 810, 275, 60);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelBtn.layer.cornerRadius = 25.0f;
        
    }
    else{
        
        headerimg.frame = CGRectMake(0, 0, 280, 38);
        title.frame = CGRectMake(60, 5, 200, 30);
        title.font = [UIFont boldSystemFontOfSize:15];

        
        //label.frame = CGRectMake(50, 10, 250, 30);
        usr.frame = CGRectMake(10, 275, 100, 30);
        pwd.frame = CGRectMake(10, 315, 100, 30);

        self.usrTxt.frame = CGRectMake(110, 275, 150, 30);
        self.pswTxt.frame = CGRectMake(110, 315, 150, 30);
        
        submitBtn.frame = CGRectMake(10, 360, 115, 30);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        submitBtn.layer.cornerRadius = 15.0f;
        
        cancelBtn.frame = CGRectMake(132, 360, 120, 30);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cancelBtn.layer.cornerRadius = 15.0f;
    }
    
    
    [self addSubview:headerimg];
    [self addSubview:title];
    
    //[self addSubview:label];
    [self addSubview:usr];
    [self addSubview:pwd];
    [self addSubview:self.usrTxt];
    [self addSubview:self.pswTxt];
    [self addSubview:submitBtn];
    [self addSubview:cancelBtn];
    
   // [label release];
    
    return self;
}


- (void) closeSMSView:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([sender tag] == 0) {
        
        NSString *value1 = [usrTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *value2 = [pswTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *value3 = [providerlabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        
        // Store the Values in Database After Validating ..
        
        if(value3.length!=0){
            
            if([value3 isEqualToString:@"SIM Card"]){
                
                usrTxt.text = @"";
                pswTxt.text = @"";
                [self storeSmsConfigurationData];
                
            }else{
             
                if (value1.length==0 || value2.length==0){
                    UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please provide UserName & Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [ip show];
                }
                else{
                    
                    [self storeSmsConfigurationData];
                }
            } 
        }
        else{
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Select atlease one SMS Provider" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [ip show];
        }
    }
    else {
        
        (self.superview.subviews)[0].alpha = 1.0f;
        [(self.superview.subviews)[0] setEnabled:YES];
        
        [self removeFromSuperview];
    }    
}



-(void) storeSmsConfigurationData{

    NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
    
    // delete all rows when u r inserting new things..
    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        
        if (deleteStmt == nil) {
            const char *sqlStatement = "delete from SMSCredentials";
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                
                if(SQLITE_DONE != sqlite3_step(deleteStmt))
                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                sqlite3_reset(deleteStmt);
            }
            
        }
        
    }
    deleteStmt = nil;
    
    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        
        if (insertStmt == nil) {
            const char *sqlStatement = "insert into SMSCredentials(username, password, providertype)Values (?, ?, ?)";
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &insertStmt, NULL) == SQLITE_OK) {
                
                sqlite3_bind_text(insertStmt, 1, (usrTxt.text).UTF8String, -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(insertStmt, 2, (pswTxt.text).UTF8String, -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(insertStmt, 3, (providerlabel.text).UTF8String, -1, SQLITE_TRANSIENT);
                
                if(SQLITE_DONE != sqlite3_step(insertStmt))
                    NSAssert1(0, @"Error While Inserting. '%s'",sqlite3_errmsg(database));
                
                sqlite3_reset(insertStmt);
                
            }
        }
        insertStmt = nil;
    }
    sqlite3_close(database);
    
    StatusView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    StatusView.opaque = NO;
    StatusView.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:0.8];
    StatusView.layer.cornerRadius = 15;
    
    UILabel *created = [[UILabel alloc] init] ;
    created.text = @"Successfully Configured";
    created.backgroundColor = [UIColor clearColor];
    created.textAlignment = NSTextAlignmentCenter;
    
    
    // button to cancel with out saving the changes ..
    UIButton *cancelBtn = [[UIButton alloc] init] ;
    [cancelBtn setTitle:@"OK" forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.tag = 1;
    //cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:0.8];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGesture];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        StatusView.frame = CGRectMake(20, 20, 628, 860);
        created.font = [UIFont systemFontOfSize:30];
        created.frame = CGRectMake(100, 280, 450, 100);
        
        cancelBtn.frame = CGRectMake(170, 400, 320, 60);
        cancelBtn.layer.cornerRadius = 25.0f;
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
    }
    else{
        
        StatusView.frame = CGRectMake(10, 10, 280, 380);
        created.frame = CGRectMake(20, 160, 220, 20);
        created.font = [UIFont systemFontOfSize:15];
        
        cancelBtn.frame = CGRectMake(10, 200, 240, 32);
        cancelBtn.layer.cornerRadius = 15.0f;
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    [StatusView addSubview:created];
    [StatusView addSubview:cancelBtn];
    [self addSubview:StatusView];

}


- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    StatusView.hidden = YES;
    
    (self.superview.subviews)[0].alpha = 1.0f;
    [(self.superview.subviews)[0] setEnabled:YES];
    
    [self removeFromSuperview];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == usrTxt || textField == pswTxt) {
        self.frame = CGRectMake(self.frame.origin.x, -140, self.frame.size.width, self.frame.size.height);
    }

    
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    
   //self.usrTxt = nil;
   // self.pswTxt = nil;
    providerlabel.text = nil;

    
    //[providerType release];

    self.smsProviderTable;
    
}

#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 70.0;
    }
    else{
        return 30.0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return listofProvidersArray.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.backgroundColor = [UIColor blackColor];
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    if(hlcell == nil) {
        hlcell =  [[UITableViewCell alloc] 
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
        hlcell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    hlcell.textLabel.text = listofProvidersArray[indexPath.row];
   
    if ([listofProvidersArray[indexPath.row] isEqualToString: providerlabel.text]) {
        
        [smsProviderTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] animated:NO scrollPosition:0]; 
    }
    
    hlcell.textLabel.textColor = [UIColor whiteColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        hlcell.textLabel.font = [UIFont fontWithName: @"Arial" size: 25.0];
    }
    else{
        hlcell.textLabel.font = [UIFont fontWithName: @"Arial" size: 14.0];
    }
    hlcell.backgroundColor = [UIColor blackColor];
    return hlcell;
}

// Customize the DidSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    providerlabel.text =  listofProvidersArray[indexPath.row];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [usrTxt resignFirstResponder];
    [pswTxt  resignFirstResponder];
    
    return YES;
}

@end
