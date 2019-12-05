//
//  FTPConfigurationView.m
//  OmniRetailer
//
//  Created by Roja on 4/25/19.
//

#import "FTPConfigurationView.h"

#import "DataBaseConnection.h"
#import "sqlite3.h"
//#import <QuartzCore/QuartzCore.h>


//static sqlite3 *database = nil;
//static sqlite3_stmt *insertStmt = nil;
//static sqlite3_stmt *deleteStmt = nil;
//static sqlite3_stmt *selectStmt = nil;


@implementation FTPConfigurationView

@synthesize soundFileURLRef,soundFileObject;
@synthesize hostNumberTF,portNumberTF,userIdTF,passwordTF;



- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
    }
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.requestsManager.delegate = self;
    
//    NSString * hostNumText = NULL;
//    NSString * portNumText = NULL;
//    NSString * userIdText = NULL;
//    NSString * passwordText = NULL;
//
//    //Get data from database
//    // getting the present value's from database ..
//
//    NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
//
//    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
//
//        const char *sqlStatement = "select * from EmailCredentials";
//
//        if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
//
//            while (sqlite3_step(selectStmt) == SQLITE_ROW) {
//
//                hostNumText = @((char *)sqlite3_column_text(selectStmt, 0));
//                portNumText = @((char *)sqlite3_column_text(selectStmt, 1));
//                userIdText = @((char *)sqlite3_column_text(selectStmt, 2));
//                passwordText = @((char *)sqlite3_column_text(selectStmt, 3));
//
//                //[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 3)];
//            }
//            sqlite3_finalize(selectStmt);
//        }
//    }
//
//    selectStmt = nil;
//    sqlite3_close(database);
    
    UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"FTP Configuration";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    
    
    // labels ..
    UILabel * hostNameLbl = [[UILabel alloc] init];
    UILabel * portNumberLbl  = [[UILabel alloc] init];
    UILabel * userIdLbl  = [[UILabel alloc] init];
    UILabel * passwordLbl  = [[UILabel alloc] init];
    
    hostNameLbl.text = @"Host Number";
    portNumberLbl.text = @"Port Number";
    userIdLbl.text = @"User Id";
    passwordLbl.text = @"Password";
    
    hostNameLbl.textColor = [UIColor whiteColor];
    portNumberLbl.textColor = [UIColor whiteColor];
    userIdLbl.textColor = [UIColor whiteColor];
    passwordLbl.textColor = [UIColor whiteColor];

    hostNameLbl.backgroundColor = [UIColor clearColor];
    portNumberLbl.backgroundColor  = [UIColor clearColor];
    userIdLbl.backgroundColor  = [UIColor clearColor];
    passwordLbl.backgroundColor  = [UIColor clearColor];
    
    // TextFields ..
    hostNumberTF = [[UITextField alloc] init];
    portNumberTF = [[UITextField alloc] init];
    userIdTF = [[UITextField alloc] init];
    passwordTF = [[UITextField alloc] init];
    
    hostNumberTF.textColor = [UIColor blackColor];
    portNumberTF.textColor = [UIColor blackColor];
    userIdTF.textColor = [UIColor blackColor];
    passwordTF.textColor = [UIColor blackColor];
    
    hostNumberTF.backgroundColor = [UIColor whiteColor];
    portNumberTF.backgroundColor = [UIColor whiteColor];
    userIdTF.backgroundColor = [UIColor whiteColor];
    passwordTF.backgroundColor = [UIColor whiteColor];
    
    
    hostNumberTF.layer.masksToBounds=YES;
    hostNumberTF.layer.borderColor=[UIColor grayColor].CGColor;
    hostNumberTF.layer.borderWidth= 1.0f;
    
    portNumberTF.layer.masksToBounds=YES;
    portNumberTF.layer.borderColor=[UIColor grayColor].CGColor;
    portNumberTF.layer.borderWidth= 1.0f;
    
    userIdTF.layer.masksToBounds=YES;
    userIdTF.layer.borderColor=[UIColor grayColor].CGColor;
    userIdTF.layer.borderWidth= 1.0f;
    
    passwordTF.layer.masksToBounds=YES;
    passwordTF.layer.borderColor=[UIColor grayColor].CGColor;
    passwordTF.layer.borderWidth= 1.0f;
    
    hostNumberTF.placeholder = @"Host Number";
    portNumberTF.placeholder = @"Port Number";
    userIdTF.placeholder = @"User Id";
    passwordTF.placeholder = @"Password";
    
    passwordTF.secureTextEntry = YES;
   
    hostNumberTF.layer.cornerRadius = 5;
    portNumberTF.layer.cornerRadius = 5;
    userIdTF.layer.cornerRadius = 5;
    passwordTF.layer.cornerRadius = 5;
    
    
//    if (hostNumText != NULL || portNumText != NULL || userIdText != NULL || passwordText != NULL) {
//        hostNumberTF.text = hostNumText;
//        portNumberTF.text = portNumText;
//        userIdTF.text = userIdText;
//        passwordTF.text = passwordText;
//    }
    
    hostNumberTF.delegate = self;
    portNumberTF.delegate = self;
    userIdTF.delegate = self;
    passwordTF.delegate = self;
    
    // button to Ok and save the mail credentials ..
    UIButton *submitBtn = [[UIButton alloc] init] ;
    [submitBtn addTarget:self action:@selector(submitFTPConfigurationDetails:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.tag = 0;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.cornerRadius = 3.0f;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    submitBtn.layer.cornerRadius = 25.0f;
    
    // button to cancel with out saving the changes ..
    UIButton *cancelBtn = [[UIButton alloc] init] ;
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    cancelBtn.layer.cornerRadius = 25.0f;
    
   
    
    hostNameLbl.font = [UIFont systemFontOfSize:30];
    portNumberLbl.font = [UIFont systemFontOfSize:30];
    userIdLbl.font = [UIFont systemFontOfSize:30];
    passwordLbl.font = [UIFont systemFontOfSize:30];
    
    hostNumberTF.font = [UIFont systemFontOfSize:25];
    portNumberTF.font = [UIFont systemFontOfSize:25];
    userIdTF.font = [UIFont systemFontOfSize:25];
    passwordTF.font = [UIFont systemFontOfSize:25];
    
    headerimg.frame = CGRectMake(0, 0, 668, 80);
    title.frame = CGRectMake(200, 15, 400, 50);
    title.font = [UIFont boldSystemFontOfSize:30];
    
    hostNameLbl.frame = CGRectMake(10, 80, 648, 40);
    hostNumberTF.frame = CGRectMake(hostNameLbl.frame.origin.x, hostNameLbl.frame.origin.y + hostNameLbl.frame.size.height, hostNameLbl.frame.size.width, 40);

    portNumberLbl.frame = CGRectMake(hostNameLbl.frame.origin.x, hostNumberTF.frame.origin.y + hostNumberTF.frame.size.height + 5, hostNameLbl.frame.size.width, hostNameLbl.frame.size.height);
    portNumberTF.frame = CGRectMake(hostNumberTF.frame.origin.x, portNumberLbl.frame.origin.y + portNumberLbl.frame.size.height, hostNumberTF.frame.size.width, hostNumberTF.frame.size.height);

    userIdLbl.frame = CGRectMake(hostNameLbl.frame.origin.x, portNumberTF.frame.origin.y + portNumberTF.frame.size.height + 5, hostNameLbl.frame.size.width, hostNameLbl.frame.size.height);
    userIdTF.frame = CGRectMake(hostNumberTF.frame.origin.x, userIdLbl.frame.origin.y + userIdLbl.frame.size.height, hostNumberTF.frame.size.width, hostNumberTF.frame.size.height);

    passwordLbl.frame = CGRectMake(hostNameLbl.frame.origin.x, userIdTF.frame.origin.y + userIdTF.frame.size.height + 5, hostNameLbl.frame.size.width, hostNameLbl.frame.size.height);
    passwordTF.frame = CGRectMake(hostNumberTF.frame.origin.x, passwordLbl.frame.origin.y + passwordLbl.frame.size.height, hostNumberTF.frame.size.width, hostNumberTF.frame.size.height);

    submitBtn.frame = CGRectMake(100, passwordTF.frame.origin.y +  passwordTF.frame.size.height + 20, 200, 50);
   
    cancelBtn.frame = CGRectMake(submitBtn.frame.origin.x + submitBtn.frame.size.width + 20, submitBtn.frame.origin.y, 200, 50);
    
    
    [self addSubview:headerimg];
    [self addSubview:title];
    [self addSubview:hostNameLbl];
    [self addSubview:portNumberLbl];
    [self addSubview:userIdLbl];
    [self addSubview:passwordLbl];
    
    [self addSubview:hostNumberTF];
    [self addSubview:portNumberTF];
    [self addSubview:userIdTF];
    [self addSubview:passwordTF];
    [self addSubview:submitBtn];
    [self addSubview:cancelBtn];
    
    portNumberTF.backgroundColor = [UIColor whiteColor];
    return self;
}


-(void)submitFTPConfigurationDetails:(UIButton *)sender{
    
    self.requestsManager = [[GRRequestsManager alloc] initWithHostname:hostNumberTF.text
                                                                  user:userIdTF.text
                                                              password:passwordTF.text];
    
    [self.requestsManager startProcessingRequests];
}


-(void)cancelBtnAction:(UIButton *)sender{
    
    [self removeFromSuperview];

}


@end
