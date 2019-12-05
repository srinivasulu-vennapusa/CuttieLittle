//
//  MailView.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 16/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "MailView.h"

#import <QuartzCore/QuartzCore.h>
#import "DataBaseConnection.h"
#import "sqlite3.h"


static sqlite3 *database = nil;
static sqlite3_stmt *insertStmt = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *selectStmt = nil;

@implementation MailView

@synthesize mailTxt, pswdTxt, hostTxt;
@synthesize soundFileURLRef,soundFileObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         self.backgroundColor = [UIColor blackColor];
    }
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    NSString *emailText = NULL;
    NSString *password = NULL;
    NSString *mailHost = NULL;
   // NSString *portNumber = NULL;
    
    //Get data from database
    // getting the present value's from database ..

    NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
    
    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        
        const char *sqlStatement = "select * from EmailCredentials";
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {  
            while (sqlite3_step(selectStmt) == SQLITE_ROW) {  
                
                emailText = @((char *)sqlite3_column_text(selectStmt, 0));
                password = @((char *)sqlite3_column_text(selectStmt, 1));  
                mailHost = @((char *)sqlite3_column_text(selectStmt, 2));
                //portNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 3)]; 
            }
            sqlite3_finalize(selectStmt); 
        }
    }     
    
    selectStmt = nil;
    sqlite3_close(database);
    
    
    UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    UILabel *title = [[UILabel alloc] init];
    title.text = @"Mail Configuration";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];

    
    // labels ..
    UILabel *email = [[UILabel alloc] init];
    UILabel *pswd  = [[UILabel alloc] init];
    UILabel *host  = [[UILabel alloc] init];
    //UILabel *port  = [[UILabel alloc] init];
    
    email.text = @"Email";
    pswd.text  = @"Password";
    host.text  = @"Mail host";
    email.textColor = [UIColor whiteColor];
    pswd.textColor = [UIColor whiteColor];
    host.textColor = [UIColor whiteColor];
    //port.text  = @"Port number";
    
    email.backgroundColor = [UIColor clearColor];
    pswd.backgroundColor  = [UIColor clearColor];
    host.backgroundColor  = [UIColor clearColor];
    //port.backgroundColor  = [UIColor clearColor];
    
    // TextFields ..
    self.mailTxt = [[UITextField alloc] init];
    self.pswdTxt = [[UITextField alloc] init];
    self.hostTxt = [[UITextField alloc] init];
    //self.portTxt = [[UITextField alloc] init];
    
    mailTxt.layer.masksToBounds=YES;
    mailTxt.layer.borderColor=[UIColor grayColor].CGColor;
    mailTxt.layer.borderWidth= 1.0f;
    
    pswdTxt.layer.masksToBounds=YES;
    pswdTxt.layer.borderColor=[UIColor grayColor].CGColor;
    pswdTxt.layer.borderWidth= 1.0f;
    
    hostTxt.layer.masksToBounds=YES;
    hostTxt.layer.borderColor=[UIColor grayColor].CGColor;
    hostTxt.layer.borderWidth= 1.0f;
    
    //portTxt.layer.masksToBounds=YES;
    //portTxt.layer.borderColor=[UIColor grayColor].CGColor;
    //portTxt.layer.borderWidth= 1.0f;
    
    pswdTxt.secureTextEntry = YES;
    
    self.mailTxt.backgroundColor = [UIColor whiteColor];
    self.pswdTxt.backgroundColor = [UIColor whiteColor];
    self.hostTxt.backgroundColor = [UIColor whiteColor];
    //self.portTxt.backgroundColor = [UIColor whiteColor];
    
    self.mailTxt.layer.cornerRadius = 5;
    self.pswdTxt.layer.cornerRadius = 5;
    self.hostTxt.layer.cornerRadius = 5;
   // self.portTxt.layer.cornerRadius = 5;
    
    if (emailText != NULL || password != NULL || mailHost != NULL) {
        mailTxt.text = emailText;
        pswdTxt.text = password;
        hostTxt.text = mailHost;
       // portTxt.text = portNumber;
    }
    
    mailTxt.delegate = self;
    pswdTxt.delegate = self;
    hostTxt.delegate = self;
    //portTxt.delegate = self;
    
    // button to Ok and save the mail credentials ..
    UIButton *submitBtn = [[UIButton alloc] init] ;
    [submitBtn addTarget:self action:@selector(closeMailView:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.tag = 0;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.cornerRadius = 3.0f;
    
    // button to cancel with out saving the changes ..
    UIButton *cancelBtn = [[UIButton alloc] init] ;
    [cancelBtn addTarget:self action:@selector(closeMailView:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.cornerRadius = 3.0f;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        headerimg.frame = CGRectMake(0, 0, 668, 80);
        title.frame = CGRectMake(200, 15, 400, 50);
        title.font = [UIFont boldSystemFontOfSize:30];

        
        email.font = [UIFont systemFontOfSize:30];
        email.frame = CGRectMake(40, 130, 200, 50);
        pswd.font = [UIFont systemFontOfSize:30];
        pswd.frame = CGRectMake(40, 230, 200, 50);
        host.font = [UIFont systemFontOfSize:30];
        host.frame = CGRectMake(40, 340, 200, 50);
       //port.font = [UIFont systemFontOfSize:30];
        //port.frame = CGRectMake(40, 450, 200, 50);
        
        self.mailTxt.font = [UIFont systemFontOfSize:25];
        self.mailTxt.frame = CGRectMake(250, 130, 350, 60);
        self.pswdTxt.font = [UIFont systemFontOfSize:25];
        self.pswdTxt.frame = CGRectMake(250, 230, 350, 60);
        self.hostTxt.font = [UIFont systemFontOfSize:25];
        self.hostTxt.frame = CGRectMake(250, 340, 350, 60);
        //self.portTxt.font = [UIFont systemFontOfSize:25];
       // self.portTxt.frame = CGRectMake(250, 450, 350, 60);
        
        submitBtn.frame = CGRectMake(50, 490, 275, 60);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        submitBtn.layer.cornerRadius = 25.0f;
        
        cancelBtn.frame = CGRectMake(335, 490, 275, 60);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelBtn.layer.cornerRadius = 25.0f;
    }
    else {
        
        
        headerimg.frame = CGRectMake(0, 0, 280, 38);
        title.frame = CGRectMake(60, 5, 200, 30);
        title.font = [UIFont boldSystemFontOfSize:15];

        
        email.frame = CGRectMake(10, 50, 100, 30);
        pswd.frame = CGRectMake(10, 110, 100, 30);
        host.frame = CGRectMake(10, 170, 100, 30);
        //port.frame = CGRectMake(10, 230, 100, 30);
        
        self.mailTxt.frame = CGRectMake(110, 50, 130, 30);
        self.pswdTxt.frame = CGRectMake(110, 110, 130, 30);
        self.hostTxt.frame = CGRectMake(110, 170, 130, 30);
        //self.portTxt.frame = CGRectMake(110, 230, 130, 30);
        
        submitBtn.frame = CGRectMake(10, 235, 115, 30);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        submitBtn.layer.cornerRadius = 15.0f;
        
        cancelBtn.frame = CGRectMake(132, 235, 120, 30);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cancelBtn.layer.cornerRadius = 15.0f;
    }
    
    [self addSubview:headerimg];
    [self addSubview:title];
    [self addSubview:email];
    [self addSubview:pswd];
    [self addSubview:host];
    //[self addSubview:port];
    
    //[port  release];
    
    [self addSubview:self.mailTxt];
    [self addSubview:self.pswdTxt];
    [self addSubview:self.hostTxt];
    //[self addSubview:self.portTxt];
    [self addSubview:submitBtn];
    [self addSubview:cancelBtn];
    
    return self;
    
}


- (void) closeMailView:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([sender tag] == 0) {
        
        
        NSString *value1 = [mailTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *value2 = [pswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // Store the Values in Database After Validating ..
        if (value1.length==0 || value2.length==0){
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Correction" message:@"Please Enter Details in All Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] ;
            [ip show];
        }
        else {
            
            NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
            
            // delete all rows when u r inserting new things..
            if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
                
                if (deleteStmt == nil) {
                    const char *sqlStatement = "delete from EmailCredentials";
                    
                    if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                        
                        if(SQLITE_DONE != sqlite3_step(deleteStmt)) 
                            NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                        
                        sqlite3_reset(deleteStmt);
                    }
                    
                }
                
            }
            deleteStmt = nil;
            
            
            // inserting ftp details into database
            
            if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
                
                if (insertStmt == nil) {        
                    const char *sqlStatement = "insert into EmailCredentials(Email, Password, Host) Values(?, ?, ?)";
                    
                    if(sqlite3_prepare_v2(database, sqlStatement, -1, &insertStmt, NULL) == SQLITE_OK) {
                        
                        sqlite3_bind_text(insertStmt, 1, (mailTxt.text).UTF8String, -1, SQLITE_TRANSIENT);
                        sqlite3_bind_text(insertStmt, 2, (pswdTxt.text).UTF8String, -1, SQLITE_TRANSIENT);
                        sqlite3_bind_text(insertStmt, 3, (hostTxt.text).UTF8String, -1, SQLITE_TRANSIENT);
                        
                        //sqlite3_bind_int(insertStmt, 4, [portTxt.text intValue]);
                        
                        if(SQLITE_DONE != sqlite3_step(insertStmt)) 
                            NSAssert1(0, @"Error While Inserting. '%s'",sqlite3_errmsg(database));
                        
                        sqlite3_reset(insertStmt);    
                        
                    }
                    
                }
                insertStmt = nil;
            }
            sqlite3_close(database);
            
            StatusView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
            StatusView.opaque = NO;
            StatusView.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:0.8];
            StatusView.layer.cornerRadius = 15;
            
            UILabel *created = [[UILabel alloc] init] ;
            created.text = @"ACCOUNT VERIFIED"; 
            created.backgroundColor = [UIColor clearColor];
            created.textAlignment = NSTextAlignmentCenter;
            
            // button to cancel with out saving the changes ..
            UIButton *cancelBtn = [[UIButton alloc] init] ;
            [cancelBtn setTitle:@"OK" forState:UIControlStateNormal];
            cancelBtn.layer.cornerRadius = 3.0f;
            cancelBtn.tag = 1;
            //cancelBtn.backgroundColor = [UIColor grayColor];
            cancelBtn.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:0.8];
            
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)  {
                StatusView.frame = CGRectMake(20, 20, 628, 560);
                created.font = [UIFont systemFontOfSize:30];
                created.frame = CGRectMake(100, 120, 450, 100);
                
                cancelBtn.frame = CGRectMake(170, 230, 320, 60);
                cancelBtn.layer.cornerRadius = 25.0f;
                cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];

            }
            else {
                StatusView.frame = CGRectMake(10, 10, 240, 260);
                created.frame = CGRectMake(10, 110, 200, 20);
                created.font = [UIFont systemFontOfSize:15];
                
                cancelBtn.frame = CGRectMake(10, 150, 220, 32);
                cancelBtn.layer.cornerRadius = 15.0f;
                cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            }
            
            [StatusView addSubview:created];
            [StatusView addSubview:cancelBtn];
            [self addSubview:StatusView];

            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            tapGesture.numberOfTapsRequired = 1;
            tapGesture.cancelsTouchesInView = NO; 
            [self addGestureRecognizer:tapGesture];
        }
        
    }
    else {
        
        (self.superview.subviews)[0].alpha = 1.0f;
        [(self.superview.subviews)[0] setEnabled:YES];
        
        [self removeFromSuperview];

    }    
        
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
    
    if (textField == hostTxt) {
        self.frame = CGRectMake(self.frame.origin.x, -60, self.frame.size.width, self.frame.size.height);
    }
    else if (textField == mailTxt || textField == pswdTxt) {
        self.frame = CGRectMake(self.frame.origin.x, 40, self.frame.size.width, self.frame.size.height);
    }
    
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [mailTxt resignFirstResponder];
    [pswdTxt resignFirstResponder];
    [hostTxt resignFirstResponder];
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}



@end
