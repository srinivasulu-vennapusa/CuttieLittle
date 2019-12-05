//
//  ServiceConfigView.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "ServiceConfigView.h"
//#import "OmniRetailerViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "DataBaseConnection.h"
#import "sqlite3.h"
#import "Global.h"

//added by Srinivasulu on 20/10/2017....

#import "WebServiceConstants.h"
#import "CheckWifi.h"

//upto here on 10/10/2017....

static sqlite3 *database = nil;
static sqlite3_stmt *insertStmt = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *selectStmt = nil;
//UIView *transparentView;


@implementation ServiceConfigView

@synthesize domainTxt, portTxt;
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
    
    NSString *domainText = NULL;
    NSString *portNumber = NULL;
    //NSString *userId = NULL;
    //NSString *password = NULL;
    
    //Get data from database
    // getting the present value's from database ..
    
    NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
    
    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        
        const char *sqlStatement = "select * from ServiceCredentials";
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
            while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                
                domainText = @((char *)sqlite3_column_text(selectStmt, 0));
                portNumber = @((char *)sqlite3_column_text(selectStmt, 1));
                //userId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 2)];
                // password = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 3)];
            }
            sqlite3_finalize(selectStmt);
        }
    }
    
    selectStmt = nil;
    sqlite3_close(database);
    
    //    transparentView = [[UIView alloc] initWithFrame:frame];
    //    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    
    UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"Server Configuration";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    
    // labels ..
    
    UILabel *domain = [[UILabel alloc] init];
    UILabel *port   = [[UILabel alloc] init];
    //UILabel *user   = [[UILabel alloc] init];
    //UILabel *pswd   = [[UILabel alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        headerimg.frame = CGRectMake(0, 0, 660, 80);
        title.frame = CGRectMake(200, 15, 400, 50);
        title.font = [UIFont boldSystemFontOfSize:30];
        
        domain.font = [UIFont systemFontOfSize:30];
        port.font = [UIFont systemFontOfSize:30];
        // user.font = [UIFont systemFontOfSize:30];
        //pswd.font = [UIFont systemFontOfSize:30];
        
        domain.frame = CGRectMake(40, 160, 200, 60);
        port.frame = CGRectMake(40, 260, 200, 60);
        //user.frame = CGRectMake(40, 360, 200, 60);
        //pswd.frame = CGRectMake(40, 460, 200, 60);
        
    } else {
        
        headerimg.frame = CGRectMake(0, 0, 280, 40);
        title.frame = CGRectMake(60, 6, 200, 30);
        title.font = [UIFont boldSystemFontOfSize:16];
        
        domain.frame = CGRectMake(10, 60, 100, 30);
        port.frame = CGRectMake(10, 115, 100, 30);
        //user.frame = CGRectMake(10, 175, 100, 30);
        //pswd.frame = CGRectMake(10, 235, 100, 30);
    }
    
    domain.text = @"Domain";
    port.text   = @"Port Number";
    domain.textColor = [UIColor whiteColor];
    port.textColor = [UIColor whiteColor];
    // user.text   = @"User ID";
    // pswd.text   = @"Password";
    
    domain.backgroundColor = [UIColor clearColor];
    port.backgroundColor   = [UIColor clearColor];
    //user.backgroundColor   = [UIColor clearColor];
    //pswd.backgroundColor   = [UIColor clearColor];
    
    [self addSubview:headerimg];
    [self addSubview:title];
    [self addSubview:domain];
    [self addSubview:port];
    //[self addSubview:user];
    //[self addSubview:pswd];
    
    //[user   release];
    //[pswd   release];
    
    // TextFields ..
    self.domainTxt = [[UITextField alloc] init];
    domainTxt.borderStyle = UITextBorderStyleRoundedRect;
    
    self.portTxt   = [[UITextField alloc] init];
    portTxt.borderStyle = UITextBorderStyleRoundedRect;
    
    //added by Srinivasulu on 01/09/2018....
    
    serviceProtocolTxt = [[UITextField alloc] init];
    serviceProtocolTxt.borderStyle = UITextBorderStyleRoundedRect;
    serviceProtocolTxt.layer.masksToBounds=YES;
    serviceProtocolTxt.text = serviceURLTypeStr;
    serviceProtocolTxt.text = serviceProtocolTxt.text.uppercaseString;
    serviceProtocolTxt.layer.borderColor=[UIColor grayColor].CGColor;
    serviceProtocolTxt.layer.borderWidth= 1.0f;
    serviceProtocolTxt.delegate = self;
    serviceProtocolTxt.backgroundColor = [UIColor whiteColor];

    
    UIImage *  availiableSuppliersListImage = [UIImage imageNamed:@"arrow.png"];

    UIButton * changeServiceCallTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeServiceCallTypeBtn setBackgroundImage:availiableSuppliersListImage forState:UIControlStateNormal];
    changeServiceCallTypeBtn.userInteractionEnabled = NO;
    changeServiceCallTypeBtn.hidden = NO;

    //upto here on 01/09/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        domainTxt.font = [UIFont systemFontOfSize:30];
        portTxt.font = [UIFont systemFontOfSize:30];
        //usrTxt.font = [UIFont systemFontOfSize:30];
        //pswTxt.font = [UIFont systemFontOfSize:30];
        
        domainTxt.frame = CGRectMake(250, 160, 350, 60);
        portTxt.frame = CGRectMake(250, 260, 350, 60);
        //usrTxt.frame = CGRectMake(250, 360, 350, 60);
        //pswTxt.frame = CGRectMake(250, 460, 350, 60);
        
        
        //added by Srinivasulu on 01/09/2018....
        
        serviceProtocolTxt.font = [UIFont systemFontOfSize:30];
//        portTxt.frame = CGRectMake(250, 260, (portTxt.frame.size.width - 20)/2, 60);
//        serviceProtocolTxt.frame = CGRectMake(portTxt.frame.origin.x + portTxt.frame.size.width + 10, portTxt.frame.origin.y, portTxt.frame.size.width, portTxt.frame.size.height);

        
        serviceProtocolTxt.frame = CGRectMake(250, 260, (portTxt.frame.size.width - 20)/2, 60);
        portTxt.frame = CGRectMake(serviceProtocolTxt.frame.origin.x + serviceProtocolTxt.frame.size.width + 10, serviceProtocolTxt.frame.origin.y, serviceProtocolTxt.frame.size.width, serviceProtocolTxt.frame.size.height);
        

        changeServiceCallTypeBtn.frame = CGRectMake( serviceProtocolTxt.frame.origin.x + serviceProtocolTxt.frame.size.width - serviceProtocolTxt.frame.size.height, serviceProtocolTxt.frame.origin.y - 0, serviceProtocolTxt.frame.size.height,  serviceProtocolTxt.frame.size.height);

        //upto here on 01/09/2018....
    }
    else {
        domainTxt.frame = CGRectMake(110, 60, 150, 30);
        portTxt.frame = CGRectMake(110, 115, 150, 30);
        //usrTxt.frame = CGRectMake(110, 175, 150, 30);
        //pswTxt.frame = CGRectMake(110, 235, 150, 30);
    }
    
    domainTxt.layer.masksToBounds=YES;
    domainTxt.text = @"";//@"161.202.13.98";//@"103.230.86.130"//@"161.202.13.107"
    domainTxt.layer.borderColor=[UIColor grayColor].CGColor;
    domainTxt.layer.borderWidth= 1.0f;
    
    
    portTxt.layer.masksToBounds=YES;
    portTxt.text = @"";
    portTxt.layer.borderColor=[UIColor grayColor].CGColor;
    portTxt.layer.borderWidth= 1.0f;
    
    
    originalDomain = domainTxt.text;
    originalPortNumber = portTxt.text;
    
    //usrTxt.layer.masksToBounds=YES;
    //usrTxt.layer.borderColor=[UIColor grayColor].CGColor;
    //usrTxt.layer.borderWidth= 1.0f;
    
    // pswTxt.layer.masksToBounds=YES;
    // pswTxt.layer.borderColor=[UIColor grayColor].CGColor;
    //pswTxt.layer.borderWidth= 1.0f;
    //pswTxt.secureTextEntry = TRUE;
    
    domainTxt.returnKeyType = UIReturnKeyDone;
    portTxt.returnKeyType = UIReturnKeyDone;
    //usrTxt.returnKeyType = UIReturnKeyDone;
    //pswTxt.returnKeyType = UIReturnKeyDone;
    
    domainTxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    domainTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    
    domainTxt.keyboardType = UIKeyboardTypeNumberPad;
    portTxt.keyboardType = UIKeyboardTypeNumberPad;
    
    [domainTxt becomeFirstResponder];
    
    self.domainTxt.backgroundColor = [UIColor whiteColor];
    self.portTxt.backgroundColor = [UIColor whiteColor];
    //self.usrTxt.backgroundColor = [UIColor whiteColor];
    //self.pswTxt.backgroundColor = [UIColor whiteColor];
    
    //    self.domainTxt.layer.cornerRadius = 5;
    //    self.portTxt.layer.cornerRadius = 5;
    //self.usrTxt.layer.cornerRadius = 5;
    //self.pswTxt.layer.cornerRadius = 5;
    
    
    if (domainText != NULL || portNumber != NULL) {
        domainTxt.text = domainText;
        portTxt.text = portNumber;
        //usrTxt.text = userId;
        //pswTxt.text = password;
    }
    else{
        
        //changed by Srinivasulu on 20/10/2017....
        
        domainTxt.text = IP_ADDRESS;
        portTxt.text = IP_PORT_NUMBER;
        
        //upto here on 10/10/2017....
    }
    
    [self addSubview:self.domainTxt];
    [self addSubview:self.portTxt];
    //[self addSubview:self.usrTxt];
    //[self addSubview:self.pswTxt];

    domainTxt.delegate = self;
    portTxt.delegate = self;
    //usrTxt.delegate = self;
    //pswTxt.delegate = self;
    
    
    // button to Ok and save the mail credentials ..
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(closeServiceConfigView:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.tag = 0;
    submitBtn.backgroundColor = [UIColor grayColor];
    
    
    // button to cancel with out saving the changes ..
    UIButton *cancelBtn = [[UIButton alloc] init] ;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 3.0f;
    [cancelBtn addTarget:self action:@selector(closeServiceConfigView:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1;
    cancelBtn.backgroundColor = [UIColor grayColor];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        submitBtn.frame = CGRectMake(30, 380, 290, 60);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        cancelBtn.frame = CGRectMake(335, 380, 290, 60);
        cancelBtn.layer.cornerRadius = 25.0f;
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    }
    else {
        submitBtn.frame = CGRectMake(15, 190, 120, 32);
        submitBtn.layer.cornerRadius = 15.0f;
        
        cancelBtn.frame = CGRectMake(145, 190, 120, 32);
        cancelBtn.layer.cornerRadius = 15.0f;
    }
    
    [self addSubview:submitBtn];
    [self addSubview:cancelBtn];
    
    
    [self addSubview:serviceProtocolTxt];
    [self addSubview:changeServiceCallTypeBtn];
    return self;
}


- (void) closeServiceConfigView:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([sender tag] == 0) {
        
        NSString * value1 = [domainTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString * value2 = [portTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        isWifiSelectionChanged = FALSE;
        
        CheckWifi *wifi = [[CheckWifi alloc] init];
        BOOL status = [wifi checkWifi];
        
        
        // Store the Values in Database After Validating ..
        if (value1.length==0 || value2.length==0){
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Correction" message:@"Please Enter Details in All Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [ip show];
        }
        else if (!status) {
            
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"please_enable_wifi_mobile_data", nil) message:nil delegate:self cancelButtonTitle: NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [ip show];
        }
        else {
            
            //added by Srinivasulu on 20/10/2017....
            
            @try {
              
                
                if(testHUD == nil){
                    testHUD = [[MBProgressHUD alloc] initWithView:self];
                    [self addSubview:testHUD];
                    // Regiser for HUD callbacks so we can remove it from the window at the right time
                    testHUD.delegate = self;
                    testHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
                    testHUD.mode = MBProgressHUDModeCustomView;
                    testHUD.dimBackground = YES;
                    //    [testHUD show:NO];
                    //    [testHUD setHidden:YES];
                }
                
                testHUD.labelText = NSLocalizedString(@"checking_configurations", nil);
                [testHUD show:YES];
                [testHUD setHidden:NO];
                
                
                NSUserDefaults * defaults = [[NSUserDefaults alloc] init];
       
                NSString *  urlTypeStr = [NSString stringWithFormat:@"%@%@",serviceProtocolTxt.text.lowercaseString,@"://"];
                NSURL * sampleUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@%@",urlTypeStr,value1,@":",value2,@"/OmniRetailerServices/"]];
                NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:sampleUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                

                //checking URL through synchronous request....
                
                //                BOOL isSSLRequest = false;
                //                NSError * connectionError = nil;
                //                NSURLResponse * response = nil;
                //                NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request   delegate:self];
                //
                //                NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
                //
                //                NSString * responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //
                //                Boolean isValidURL = false;
                //
                //                NSString * errorMsgHeader = NSLocalizedString(@"invalid_ip_address", nil);
                //                NSString * errorMsg = NSLocalizedString(@"please_enter_valid_ip_address", nil);
                //
                //                // check for an error. If there is a network error, you should handle it here.
                //                if(!connectionError && responseString != nil)
                //                {
                //                    if(![responseString containsString:BAD_REQUEST_RESPONSE])
                //                        isValidURL = true;
                //                    else{
                //                        errorMsgHeader = NSLocalizedString(@"alert_message", nil);
                //                    }
                //                }
                //                else{
                //
                //                    errorMsgHeader = NSLocalizedString(@"alert_message", nil);
                //                    errorMsg = connectionError.localizedDescription;
                //                }
                //
                //                if(isValidURL){
                //                    if([serviceProtocolTxt.text caseInsensitiveCompare:HTTPS] == NSOrderedSame)
                //                        isSSLRequest = true;
                //
                //                    serviceURLTypeStr = serviceProtocolTxt.text;
                //                    [defaults setObject:@(isSSLRequest)  forKey:IS_URL_SSL];
                //                }
                //                else{
                //                    if(!errorMsg.length)
                //                        errorMsg = NSLocalizedString(@"please_enter_valid_ip_address", nil);
                //
                //                    UIAlertView * ip = [[UIAlertView alloc] initWithTitle:errorMsgHeader message:errorMsg delegate:self cancelButtonTitle: NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                //                    [ip show];
                //                    return;
                //                    //it is written just to remove the warning....
                //                    NSLog(@"--%@",connection);
                //                }
                
                //checking URL through Asynchronous request....
                NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request   delegate:self];

                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response,
                                                           NSData *data, NSError *connectionError)
                 {
                     Boolean isValidURL = false;
                     BOOL isSSLRequest = false;
                     
                     NSString * errorMsgHeader = NSLocalizedString(@"invalid_ip_address", nil);
                     NSString * errorMsg = NSLocalizedString(@"please_enter_valid_ip_address", nil);
                     
                     if (data.length > 0 && connectionError == nil)
                     {
                         
                         NSString * responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                         
                         if(!connectionError && responseString != nil)
                         {
                             if(![responseString containsString:BAD_REQUEST_RESPONSE])
                                 isValidURL = true;
                             else{
                                 errorMsgHeader = NSLocalizedString(@"alert_message", nil);
                             }
                         }
                     }
                     else {
                         errorMsgHeader = NSLocalizedString(@"alert_message", nil);
                         errorMsg = connectionError.localizedDescription;
                     }
                     
                     
                     if(isValidURL){
                         if([serviceProtocolTxt.text caseInsensitiveCompare:HTTPS] == NSOrderedSame)
                             isSSLRequest = true;
                         
                         serviceURLTypeStr = serviceProtocolTxt.text;
                         [defaults setObject:@(isSSLRequest)  forKey:IS_URL_SSL];
                         
                         
                         NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
                         
                         // delete all rows when u r inserting new things..
                         if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
                             
                             if (deleteStmt == nil) {
                                 const char *sqlStatement = "delete from ServiceCredentials";
                                 
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
                                 const char *sqlStatement = "insert into ServiceCredentials(domain, portnumber) Values(?, ?)";
                                 
                                 if(sqlite3_prepare_v2(database, sqlStatement, -1, &insertStmt, NULL) == SQLITE_OK) {
                                     
                                     sqlite3_bind_text(insertStmt, 1, (domainTxt.text).UTF8String, -1, SQLITE_TRANSIENT);
                                     sqlite3_bind_int(insertStmt,  2, (portTxt.text).intValue);
                                     //sqlite3_bind_text(insertStmt, 3, [usrTxt.text UTF8String], -1, SQLITE_TRANSIENT);
                                     //sqlite3_bind_text(insertStmt, 4, [pswTxt.text UTF8String], -1, SQLITE_TRANSIENT);
                                     
                                     host_name = [domainTxt.text copy];
                                     port_no = [portTxt.text copy];
                                     if(SQLITE_DONE != sqlite3_step(insertStmt))
                                         NSAssert1(0, @"Error While Inserting. '%s'",sqlite3_errmsg(database));
                                     
                                     sqlite3_reset(insertStmt);
                                 }
                             }
                             sqlite3_finalize(insertStmt);
                             insertStmt = nil;
                             // void* sqlite3_commit_hook( database, commit_callback, void* udp );
                             // sqlite3_commit_hook(database, nil, nil);
                         }
                         sqlite3_close(database);
                         
                         if(StatusView == nil){
                             StatusView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                             StatusView.opaque = NO;
                             // StatusView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7f];
                             StatusView.backgroundColor = [UIColor blackColor];
                             StatusView.layer.cornerRadius = 15;
                             StatusView.layer.borderWidth = 2.0f;
                             StatusView.layer.borderColor = [UIColor whiteColor].CGColor;
                         }
                         
                         StatusView.hidden = NO;
                         
                         // button to cancel with out saving the changes ..
                         UIButton *cancelBtn = [[UIButton alloc] init] ;
                         [cancelBtn setTitle:@"OK" forState:UIControlStateNormal];
                         cancelBtn.layer.cornerRadius = 3.0f;
                         cancelBtn.tag = 1;
                         //cancelBtn.backgroundColor = [UIColor grayColor];
                         cancelBtn.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:0.8];
                         
                         
                         UILabel *created = [[UILabel alloc] init] ;
                         created.text = @"Successfully Configured";
                         created.backgroundColor = [UIColor clearColor];
                         created.textAlignment = NSTextAlignmentCenter;
                         created.textColor = [UIColor whiteColor];
                         
                         
                         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                             StatusView.frame = CGRectMake(20, 25, 620, 450);
                             created.frame = CGRectMake(100, 80, 450, 100);
                             created.font = [UIFont systemFontOfSize:30];
                             
                             cancelBtn.frame = CGRectMake(170, 200, 320, 60);
                             cancelBtn.layer.cornerRadius = 25.0f;
                             cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
                             
                             
                         }
                         else {
                             StatusView.frame = CGRectMake(10, 10, 260, 230);
                             created.frame = CGRectMake(20, 110, 220, 20);
                             
                             cancelBtn.frame = CGRectMake(10, 150, 240, 32);
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
                     else{
                         [testHUD setHidden:YES];
                         if(!errorMsg.length)
                             errorMsg = NSLocalizedString(@"please_enter_valid_ip_address", nil);
                         
                         UIAlertView * ip = [[UIAlertView alloc] initWithTitle:errorMsgHeader message:errorMsg delegate:self cancelButtonTitle: NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                         [ip show];
                         return;
                     }
                     [testHUD setHidden:YES];
                 }];
            } @catch (NSException *exception) {
                [testHUD setHidden:YES];
            }
        }
    }
    else {
        
        self.hidden = YES;
    }
}


- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if(! StatusView.hidden ){
    StatusView.hidden = YES;
    
//    (self.superview.subviews)[0].alpha = 1.0f;
//    [(self.superview.subviews)[0] setEnabled:YES];
//    [self removeFromSuperview];
        self.hidden = YES;
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //    if (textField == usrTxt || textField == pswTxt) {
    //        self.frame = CGRectMake(self.frame.origin.x, -60, self.frame.size.width, self.frame.size.height);
    //    }
    if (textField == domainTxt || textField == portTxt) {
        self.frame = CGRectMake(self.frame.origin.x, 40, self.frame.size.width, self.frame.size.height);
        return YES;
        
    }
    else if(textField == serviceProtocolTxt){
        
        [self showListServiceURLOptions:textField];
        return NO;
    }
    else
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [domainTxt resignFirstResponder];
    [portTxt resignFirstResponder];
    //[usrTxt resignFirstResponder];
    //[pswTxt resignFirstResponder];
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}


//added by Srinivasulu on 30/08/2018.. reason inorder to access the https service call also....
-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {

    if ([[challenge protectionSpace] authenticationMethod] == NSURLAuthenticationMethodServerTrust) {

        [[challenge sender] useCredential:[NSURLCredential credentialForTrust:[[challenge protectionSpace] serverTrust]] forAuthenticationChallenge:challenge];
    }
}


#pragma -mark reuseable methods used in this page....

/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         10/05/2017
 * @method       showPopUpForTables:-- popUpWidth:-- popUpHeight:-- presentPopUpAt:-- showViewIn:-- permittedArrowDirections:--
 * @author       Srinivasulu
 * @param        UITableView
 * @param        float
 * @param        float
 * @param        id
 * @param        id
 * @param        permittedArrowDirections
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections{
    
    @try {
        
        //        if ( [catPopOver isPopoverVisible] && (tableName.frame.size.height > height) ){
        //            catPopOver.popoverContentSize =  CGSizeMake(width, height);
        
        if ( popOver.popoverVisible && (tableName.frame.size.height > height) ){
            popOver.popoverContentSize =  CGSizeMake(width, height);
            
            [tableName reloadData];
            return;
            
        }
        
        //        if([catPopOver isPopoverVisible])
        //            [catPopOver dismissPopoverAnimated:YES];
        
        if(popOver.popoverVisible)
            [popOver dismissPopoverAnimated:YES];
        
        
        UITextView *textView = displayFrame;
        
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
            
            UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            popover.backgroundColor = [UIColor whiteColor];
            [popover presentPopoverFromRect:textView.frame inView:view permittedArrowDirections:arrowDirections animated:YES];
            popOver = popover;
        }
        
        else {
            
            //            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            // popover.contentViewController.view.alpha = 0.0;
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            //            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            //            catPopOver = popover;
            popOver = popover;
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

/**
 * @description  here we are froming and dispalying the display EditPrice reasons....
 * @date         21/08/2017....
 * @method       showListOfEditReasons:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @param
 * @param
 * @param
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)showListServiceURLOptions:(UITextField *)sender{
    
    @try {
        
        
        
        if(protocolListArr == nil ||  protocolListTbl == nil){
            
            if(protocolListArr == nil)
                protocolListArr = [NSArray arrayWithObjects:HTTP,HTTPS, nil];
            
            
            //editPriceReasonTbl table creation....
            protocolListTbl = [[UITableView alloc] init];
            protocolListTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            protocolListTbl.dataSource = self;
            protocolListTbl.delegate = self;
            (protocolListTbl.layer).borderWidth = 1.0f;
            protocolListTbl.layer.cornerRadius = 3;
            protocolListTbl.layer.borderColor = [UIColor grayColor].CGColor;
        }
        
        float tableHeight = protocolListArr.count * 60;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = protocolListArr.count * 33;
        
        if(protocolListArr.count > 5)
            tableHeight = (tableHeight/protocolListArr.count) * 5;
        
        [self showPopUpForTables:protocolListTbl  popUpWidth:serviceProtocolTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:serviceProtocolTxt  showViewIn:self permittedArrowDirections:UIPopoverArrowDirectionUp];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


#pragma -mark start of UITableViewDelegateMethods

/**
 * @description  This method will be executed after the numbersection executed..
 * @date         01/09/2018
 * @method       numberOfRowsInSection
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == protocolListTbl){
        
        return  protocolListArr.count;
    }
    else
        return 0;
    
}

/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 *
 * @return       CGFloat
 *
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == protocolListTbl){
        
        return 60;
    }
    else
        return 0;
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         26/09/2016
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @return       UITableViewCell
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section and populating the data into labels && creation of labels also....
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == protocolListTbl) {
        
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
        
        @try {
            hlcell.textLabel.numberOfLines = 1;
            
            hlcell.textLabel.text = protocolListArr[indexPath.row];
            hlcell.textLabel.text = hlcell.textLabel.text.uppercaseString;
            hlcell.textLabel.textAlignment = NSTextAlignmentCenter;
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
            hlcell.textLabel.font =  [UIFont systemFontOfSize:30];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    else
        return nil;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //dismissing teh catPopOver.......
    [popOver dismissPopoverAnimated:YES];
    
    if (tableView == protocolListTbl) {
        
        @try {
            
            serviceProtocolTxt.text = protocolListArr[indexPath.row];
            serviceProtocolTxt.tag = indexPath.row;
            serviceProtocolTxt.text = serviceProtocolTxt.text.uppercaseString;
        }
        @catch (NSException *exception) {
            
        }
    }
}


@end
