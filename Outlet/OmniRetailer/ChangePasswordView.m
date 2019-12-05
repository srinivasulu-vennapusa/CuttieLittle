//
//  ChangePasswordView.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "ChangePasswordView.h"

#import <QuartzCore/QuartzCore.h>
//#import "SDZLoginService.h"
#import "LoginServiceSvc.h"
#import "Global.h"
#import "MemberServiceSvc.h"
#import "memberServicesSvc.h"
#import "RequestHeader.h"


@implementation ChangePasswordView

@synthesize currentPswdTxt, PswdTxt, confPswdTxt;
@synthesize soundFileURLRef,soundFileObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
       
    }

    HUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    // labels ..
    
    UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"Change Password";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];

    UILabel *curpswd   = [[UILabel alloc] init];
    UILabel *newpswd   = [[UILabel alloc] init];
    UILabel *conpswd   = [[UILabel alloc] init];
    
    curpswd.text   = @"Current Password";
    newpswd.text   = @"New Password";
    conpswd.text   = @"Confirm Password";
    
    curpswd.textColor = [UIColor whiteColor];
    newpswd.textColor = [UIColor whiteColor];
    conpswd.textColor = [UIColor whiteColor];
    
    curpswd.backgroundColor   = [UIColor clearColor];
    newpswd.backgroundColor   = [UIColor clearColor];
    conpswd.backgroundColor   = [UIColor clearColor];
    
    // TextFields ..
    self.currentPswdTxt = [[UITextField alloc] init];
    self.PswdTxt     = [[UITextField alloc] init];
    self.confPswdTxt    = [[UITextField alloc] init];
    
    currentPswdTxt.layer.masksToBounds=YES;
    currentPswdTxt.layer.borderColor=[UIColor grayColor].CGColor;
    currentPswdTxt.layer.borderWidth= 1.0f;
    currentPswdTxt.secureTextEntry = TRUE;
    
    PswdTxt.layer.masksToBounds=YES;
    PswdTxt.layer.borderColor=[UIColor grayColor].CGColor;
    PswdTxt.layer.borderWidth= 1.0f;
    PswdTxt.secureTextEntry = TRUE;
    
    confPswdTxt.layer.masksToBounds=YES;
    confPswdTxt.layer.borderColor=[UIColor grayColor].CGColor;
    confPswdTxt.layer.borderWidth= 1.0f;
    confPswdTxt.secureTextEntry = TRUE;

    self.currentPswdTxt.backgroundColor = [UIColor whiteColor];
    self.PswdTxt.backgroundColor = [UIColor whiteColor];
    self.confPswdTxt.backgroundColor = [UIColor whiteColor];
    
    self.currentPswdTxt.layer.cornerRadius = 5;
    self.PswdTxt.layer.cornerRadius = 5;
    self.confPswdTxt.layer.cornerRadius = 5;
    
    currentPswdTxt.delegate = self;
    PswdTxt.delegate = self;
    confPswdTxt.delegate = self;
    
    // button to Ok and save the mail credentials ..
    UIButton *submitBtn = [[UIButton alloc] init] ;
    [submitBtn addTarget:self action:@selector(closeChangePasswordView:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.tag = 0;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.cornerRadius = 3.0f;
    
    // button to cancel with out saving the changes ..
    UIButton *cancelBtn = [[UIButton alloc] init] ;
    [cancelBtn addTarget:self action:@selector(closeChangePasswordView:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.cornerRadius = 3.0f;
 
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)  {
        
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont boldSystemFontOfSize:30.0f];
        title.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:30];
        headerimg.frame = CGRectMake(0, 0, 668, 80);
        title.frame = CGRectMake(230, 15, 400, 50);
        
        curpswd.font = [UIFont systemFontOfSize:25];
        curpswd.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        curpswd.frame = CGRectMake(40, 140, 250, 50);
        newpswd.font = [UIFont systemFontOfSize:25];
        newpswd.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        newpswd.frame = CGRectMake(40, 240, 250, 50);
        conpswd.font = [UIFont systemFontOfSize:25];
        conpswd.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        conpswd.frame = CGRectMake(40, 340, 250, 50);
        currentPswdTxt.font = [UIFont systemFontOfSize:25];
        currentPswdTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        currentPswdTxt.frame = CGRectMake(270, 140, 330, 60);
        PswdTxt.font = [UIFont systemFontOfSize:25];
        PswdTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        PswdTxt.frame = CGRectMake(270, 240, 330, 60);
        confPswdTxt.font = [UIFont systemFontOfSize:25];
        confPswdTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        confPswdTxt.frame = CGRectMake(270, 340, 330, 60);

        submitBtn.frame = CGRectMake(50, 440, 275, 60);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        submitBtn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        submitBtn.layer.cornerRadius = 25.0f;
        
        cancelBtn.frame = CGRectMake(335, 440, 275, 60);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelBtn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        cancelBtn.layer.cornerRadius = 25.0f;
    }
    else {

        title.font = [UIFont boldSystemFontOfSize:15.0f];
        headerimg.frame = CGRectMake(0, 0, 280, 38);
        title.frame = CGRectMake(60, 5, 200, 30);
        title.font = [UIFont boldSystemFontOfSize:15];

        curpswd.frame = CGRectMake(5, 50, 150, 30);
        curpswd.font = [UIFont systemFontOfSize:15];
        
        newpswd.frame = CGRectMake(5, 110, 150, 30);
        newpswd.font = [UIFont systemFontOfSize:15];
        
        conpswd.frame = CGRectMake(5, 170, 150, 30);
        conpswd.font = [UIFont systemFontOfSize:15];
        
        currentPswdTxt.frame = CGRectMake(130, 50, 120, 30);
        PswdTxt.frame = CGRectMake(130, 110, 120, 30);
        confPswdTxt.frame = CGRectMake(130, 170, 120, 30);
        
        submitBtn.frame = CGRectMake(10, 220, 115, 30);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        submitBtn.layer.cornerRadius = 15.0f;
        
        cancelBtn.frame = CGRectMake(132, 220, 120, 30);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cancelBtn.layer.cornerRadius = 15.0f;
    }
    
    
    currentPswdTxt.delegate = self;
    PswdTxt.delegate = self;
    confPswdTxt.delegate = self;
    
    [self addSubview:headerimg];
    [self addSubview:title];
    [self addSubview:curpswd];
    [self addSubview:newpswd];
    [self addSubview:conpswd];
    [self addSubview:self.currentPswdTxt];
    [self addSubview:self.PswdTxt];
    [self addSubview:self.confPswdTxt];
    [self addSubview:submitBtn];
    [self addSubview:cancelBtn];
    
    return self;
}


//closeChangePasswordView method Commented  by roja on 17/10/2019.. (changes are done in same method name which is available next to this method)
// At the time of converting SOAP call's to REST

//- (void) closeChangePasswordView:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    if ([sender tag] == 0) {
//
//        //commented by Srinivasulu on 19/09/2017....
//        //reason -- currentDevice() is not available. So, error raised in ARC....
//
////        UIDevice * myDevice = [UIDevice currentDevice];
////        NSString * deviceUDID = [myDevice uniqueIdentifier];
//
//        //upto here on 19/09/2017....
//
//
//
//
//        NSString *value1 = [currentPswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        NSString *value2 = [PswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        NSString *value3 = [confPswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//        // Store the Values in Database After Validating ..
//        if (value1.length==0 || value2.length==0 || value3.length==0){
//            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Provide Details in All Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [ip show];
//        }
//        else if (![value1 isEqualToString:userPassword]){
//            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Current password Incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [ip show];
//        }
//        else if (value2.length < 8 && value3.length < 8){
//            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Password Too short" message:@"Min. password length is 8 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [ip show];
//        }
//        else if (![value2 isEqualToString:value3]){
//            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Password Mis-Match" message:@"New & Confirm Password must be same" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [ip show];
//        }
//        else {
//
//            HUD.dimBackground = YES;
//            HUD.labelText = @"Updating Password ..";
//
//            // Show the HUD
//            [HUD show:YES];
//            [HUD setHidden:NO];
//
//            //            SDZLoginService* service = [SDZLoginService service];
//            //            service.logging = YES;
//            //
//            //            [service updateMemberDetails:self action:@selector(updateMemberDetailsHandler:) userID:user_name password:value3 imei:deviceUDID];
//
//
//            NSArray *loyaltyKeys = @[@"uid", @"eid",@"password",@"newPassword",@"requestHeader"];
//
//            NSArray *loyaltyObjects = @[custID,mail_,currentPswdTxt.text,PswdTxt.text,[RequestHeader getRequestHeader]];
//            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//
//
//            MemberServiceSoapBinding *service = [MemberServiceSvc MemberServiceSoapBinding];
//
//            MemberServiceSvc_changePassword *aparams = [[MemberServiceSvc_changePassword alloc] init];
//            aparams.arg0 = loyaltyString;
//
//            MemberServiceSoapBindingResponse *response = [service changePasswordUsingParameters:aparams];
//
//            NSArray *responseBodyparts = response.bodyParts;
//
//            for (id bodyPart in responseBodyparts) {
//                if ([bodyPart isKindOfClass:[MemberServiceSvc_changePasswordResponse class]]) {
//                    MemberServiceSvc_changePasswordResponse *body = (MemberServiceSvc_changePasswordResponse *)bodyPart;
//                    NSLog(@"\nresponse=%@",body.return_);
//                    [self updateMemberDetailsHandler:body.return_];
//                }
//            }
//        }
//
//
//        //        else {
//        //
//        //            NSString *value2 = [PswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        //            NSString *value3 = [confPswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        //
//        //            if ([value2 length]==0 || [value3 length]==0){
//        //
//        //                UIAlertView *ip = [[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Provide Details in All Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
//        //                [ip show];
//        //            }
//        //            else if ([value2 length] < 8 && [value3 length] < 8){
//        //
//        //                UIAlertView *ip = [[[UIAlertView alloc] initWithTitle:@"Password Too short" message:@"Min. password length is 8 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
//        //                [ip show];
//        //            }
//        //            else if (![value2 isEqualToString:value3]){
//        //
//        //                UIAlertView *ip = [[[UIAlertView alloc] initWithTitle:@"Password Mis-Match" message:@"New & Confirm Password must be same" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
//        //                [ip show];
//        //            }
//        //
//        //            else {
//        //
//        //                NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
//        //                NSArray *str = [time componentsSeparatedByString:@" "];
//        //                NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
//        //
//        //                NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
//        //
//        //                NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"Store Mobile APP",mail_,@"-",date, nil];
//        //                NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
//        //                NSMutableDictionary *reqDic = [[NSMutableDictionary alloc] init];
//        //                [reqDic setObject:dictionary forKey:@"requestHeader"];
//        //                [reqDic setObject:mail_ forKey:@"emailId"];
//        //                [reqDic setObject:PswdTxt.text forKey:@"password"];
//        //
//        //                NSError * err_;
//        //                NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err_];
//        //                NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//        //
//        //                LoginServiceSoapBinding *login = [[LoginServiceSvc LoginServiceSoapBinding] retain];
//        //                login.logXMLInOut = YES;
//        //                LoginServiceSvc_resetPassword *reset = [[LoginServiceSvc_resetPassword alloc]init];
//        //                reset.passwordDetails = loyaltyString;
//        //
//        //                @try {
//        //
//        //                    [currentPswdTxt resignFirstResponder];
//        //                    [PswdTxt resignFirstResponder];
//        //
//        //                    LoginServiceSoapBindingResponse *response = [login resetPasswordUsingParameters:reset];
//        //
//        //                    NSArray *responseBodyparts = response.bodyParts;
//        //
//        //                    for (id bodyPart in responseBodyparts) {
//        //                        if ([bodyPart isKindOfClass:[LoginServiceSvc_resetPasswordResponse class]]) {
//        //                            LoginServiceSvc_resetPasswordResponse *body = (LoginServiceSvc_resetPasswordResponse *)bodyPart;
//        //                            NSLog(@"\nresponse=%@",body.return_);
//        //
//        //                            NSError *e;
//        //                           NSDictionary   *JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//        //
//        //                                                                     options: NSJSONReadingMutableContainers
//        //                                                                       error: &e] copy];
//        //                            NSDictionary *responseDic = [JSON1 valueForKey:@"responseHeader"];
//        //
//        //                            if ([[responseDic valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseDic valueForKey:@"responseMessage"] isEqualToString:@"Your Password is changed"] && [[JSON1 valueForKey:@"status"] boolValue] == TRUE) {
//        //
//        //                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Password reset successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        //                                [alert show];
//        //                            }
//        //                            else {
//        //
//        //                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to reset the password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        //                                [alert show];
//        //
//        //                            }
//        //
//        //                        }
//        //                    }
//        //                }
//        //                @catch (NSException *exception) {
//        //
//        //                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to reset the password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        //                    [alert show];
//        //
//        //                }
//        //
//        //            }
//        //
//        //
//        //        }
//    }
//    else {
//
//        (self.superview.subviews)[0].alpha = 1.0f;
//        [(self.superview.subviews)[0] setEnabled:YES];
//
//        [self removeFromSuperview];
//    }
//
//}

// Below method is latest one added by roja on 17/10/2019...
// At the time of converting SOAP call's to REST (In this method i removed Soap call relatd code and added rest service call code)
- (void) closeChangePasswordView:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([sender tag] == 0) {
        
        //commented by Srinivasulu on 19/09/2017....
        //reason -- currentDevice() is not available. So, error raised in ARC....
        
        //        UIDevice * myDevice = [UIDevice currentDevice];
        //        NSString * deviceUDID = [myDevice uniqueIdentifier];
        
        //upto here on 19/09/2017....
        
        
        NSString *value1 = [currentPswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *value2 = [PswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *value3 = [confPswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // Store the Values in Database After Validating ..
        if (value1.length==0 || value2.length==0 || value3.length==0){
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Provide Details in All Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [ip show];
        }
        else if (![value1 isEqualToString:userPassword]){
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Current password Incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [ip show];
        }
        else if (value2.length < 8 && value3.length < 8){
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Password Too short" message:@"Min. password length is 8 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [ip show];
        }
        else if (![value2 isEqualToString:value3]){
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Password Mis-Match" message:@"New & Confirm Password must be same" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [ip show];
        }
        else {
            
            HUD.dimBackground = YES;
            HUD.labelText = @"Updating Password ..";
            
            // Show the HUD
            [HUD show:YES];
            [HUD setHidden:NO];
            
            //            SDZLoginService* service = [SDZLoginService service];
            //            service.logging = YES;
            //
            //            [service updateMemberDetails:self action:@selector(updateMemberDetailsHandler:) userID:user_name password:value3 imei:deviceUDID];
            
            
            NSArray *loyaltyKeys = @[@"uid", @"eid",@"password",@"newPassword",@"requestHeader"];
            
            NSArray *loyaltyObjects = @[custID,mail_,currentPswdTxt.text,PswdTxt.text,[RequestHeader getRequestHeader]];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.memberServiceDelegate = self;
            [services changePassword:loyaltyString];
        }
        
    }
    else {
        
        (self.superview.subviews)[0].alpha = 1.0f;
        [(self.superview.subviews)[0] setEnabled:YES];
        
        [self removeFromSuperview];
    }
    
}


//  added by roja on 17/10/2019...
// below method is to handle the success reponse of change password services,...
- (void)changePasswordSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        NSLog(@"\nresponse=%@",successDictionary);
        
//    [self updateMemberDetailsHandler:successDictionary]; // no need to call, bcoz we are handling here itself...
        
        UIAlertView *check = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Password Successfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [check show];

    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

// added by roja on 17/10/2019...
// below method is to handle the error reponse of change password services,...
- (void)changePasswordErrorResponse:(NSString *)errorResponse{
    
    @try {
        NSLog(@"\nErrorResponse=%@",errorResponse);
        UIAlertView *check = [[UIAlertView alloc] initWithTitle:@"Failed" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [check show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



- (void) updateMemberDetailsHandler: (BOOL) value {
    
    [HUD setHidden:YES];
    
//    if([value isKindOfClass:[NSError class]]) {
//        //NSLog(@"%@", value);
//        UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:@"Unable to connect" message:@"Time Out or Domain Error\nCheck the configuration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [timeOut show];
//        [timeOut release];
//        return;
//    }
    
    // Handle faults
//    if([value isKindOfClass:[SoapFault class]]) {
//        //NSLog(@"%@", value);
//        UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:@"Unable to connect" message:@"Server is not Responding \nCheck the configuration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [timeOut show];
//        [timeOut release];
//        return;
//    }
    
    // Do something with the NSString* result
    //NSString* result = (NSString*)value;
    
    if (value) {
        
        UIAlertView *check = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Password Successfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [check show];
    }
    else {
        UIAlertView *check = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Please check \nUserID or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [check show];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == confPswdTxt) {
        self.frame = CGRectMake(self.frame.origin.x, -20, self.frame.size.width, self.frame.size.height);
    }
    else{
        
        self.frame = CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height);
    }
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [currentPswdTxt resignFirstResponder];
    [PswdTxt  resignFirstResponder];
    [confPswdTxt  resignFirstResponder];
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



@end
