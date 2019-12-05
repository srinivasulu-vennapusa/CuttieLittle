//
//  Configuration.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 11/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "Configuration.h"

#import <QuartzCore/QuartzCore.h>

#include "BarcodeType.h"
#include "MailView.h"
#include "SmsProviderView.h"
#include "PaymentView.h"
#include "ServiceConfigView.h"
#include "PrinterConfigView.h"
#include "ChangePasswordView.h"
#include "FTPConfigurationView.h"

@implementation Configuration


@synthesize soundFileURLRef,soundFileObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    listofConfigArray  = nil;
    imagesforListArray = nil;
    barcodeView        = nil;
    mailView           = nil;
    smsView            = nil;
    paymentView        = nil;
    serviceConfigView  = nil;
    printerConfigView  = nil;
    changePasswordView = nil;
    
}

- (void) goBack {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //[self.navigationController popViewControllerAnimated:YES];
//    [UIView  transitionWithView:self.navigationController.view duration:0.8  options:UIViewAnimationOptionTransitionFlipFromTop
//                     animations:^(void) {
//                         BOOL oldState = [UIView areAnimationsEnabled];
//                         [UIView setAnimationsEnabled:NO];
//                         [self.navigationController popViewControllerAnimated:YES];
//                         [UIView setAnimationsEnabled:oldState];
//                     }
//                     completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    self.navigationController.navigationBarHidden = NO;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0, 200.0, 70.0)];
    titleLbl.text = @"Configuration";
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
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    }
    
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    
    self.view.backgroundColor = [UIColor blackColor];
    
//    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.frame];
//    backImage.image = [UIImage imageNamed:@"omni_home_bg.png"];
//    [self.view addSubview:backImage];
    
    configTable = [[UITableView alloc] init];
    configTable.backgroundColor = [UIColor blackColor];
    configTable.dataSource = self;
    configTable.delegate = self;
    configTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // tell it to scroll to its current position, it will stop scrolling
    configTable.bounces = FALSE;
    
    [self.view addSubview:configTable];
    
    
   
//    UIButton *backbutton = [[UIButton alloc] init] ;
//    [backbutton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
//    [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
//    [self.view addSubview:backbutton];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        (self.navigationController.navigationBar).barTintColor = [UIColor lightGrayColor];
        self.view.backgroundColor = [UIColor blackColor];
        configTable.frame = CGRectMake(0,50, 778,720);
//        backbutton.frame = CGRectMake(720.0, 25, 40.0, 40.0);
    }
    else {
        self.view.backgroundColor = [UIColor blackColor];
        configTable.frame = CGRectMake(0,0, 320,380);
//        backbutton.frame = CGRectMake(285.0, 2.0, 27.0, 27.0);
    }
    
    
    listofConfigArray = [[NSMutableArray alloc] init];
    imagesforListArray  = [[NSMutableArray alloc] init];
    
    //Add items
    // [listOfItems addObject:@""];
    //[listofConfigArray addObject:@"Barcode Type"];
    [listofConfigArray addObject:@"Mail Configuration"];
    [listofConfigArray addObject:@"SMS Gateway"];
    [listofConfigArray addObject:@"Printer Configuration"];
    [listofConfigArray addObject:@"Change Password"];
    [listofConfigArray addObject:@"FTP Configuration"];
    
    //[imagesforListArray addObject:@"scan_icon.png"];
    [imagesforListArray addObject:@"email_bill@2x.png"];
    [imagesforListArray addObject:@"SMSGateway.png"];
    [imagesforListArray addObject:@"save_bill@2x.png"];
    [imagesforListArray addObject:@"ChangePswd.png"];
    [imagesforListArray addObject:@"ChangePswd.png"];

}


//Table HeaderImage for Cancel view settting....
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//       // UIView* headerView = [[[UIView alloc] init] autorelease];
//       // headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    
//    
//        //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"images2" ofType:@"jpg"];
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"PNG"];
//        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
//    
//        
//        UILabel *label1 = [[UILabel alloc] init] ;
//        label1.backgroundColor = [UIColor clearColor];
//        label1.text = @"Configuration";
//        label1.textColor = [UIColor whiteColor];
//            
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            headerView.frame = CGRectMake(0.0, 0.0, 300.0, 58.0);
//            label1.frame = CGRectMake(20, 5, 200, 35);
//            label1.font = [UIFont boldSystemFontOfSize:25.0];
//        }
//        else {
//            headerView.frame = CGRectMake(0.0, 0.0, 320.0, 69.0);
//            label1.frame = CGRectMake(5, 1, 150, 30);
//            label1.font = [UIFont boldSystemFontOfSize:16.0];
//        }
//        [headerView addSubview:label1];
//        return headerView;
//  
//}

//#pragma mark Table view methods
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{


//    return @"Configuration";   
//}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 0.0;
    }
    else {
        return 0.0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 110.0;
    }
    else {
        return 50.0;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return listofConfigArray.count;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.backgroundColor = [UIColor clearColor];
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    static NSString *CellIdentifier = @"Cell";
    ConfigCellView *cell = (ConfigCellView *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ConfigCellView" owner:self options:nil];
        cell = configCell;
    }
    cell.backgroundColor = [UIColor blackColor];
//    cell.contentView.backgroundColor = [UIColor clearColor];
    //cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [cell LabelText:listofConfigArray[indexPath.row]];
    [cell ProductImage:imagesforListArray[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    
    
    
    //configTable.alpha = 0.5f;
    //configTable.userInteractionEnabled = NO;
    
//    if (indexPath.row == 0) {   // barcode View ..
//        
//        barcodeView = [[BarcodeType alloc] init];
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            barcodeView.frame = CGRectMake(50, 170, 668, 750);
//        } else {
//            barcodeView.frame = CGRectMake(30, 40, 260, 350);
//        }
//        
//        [self.view addSubview:barcodeView];
//        
//        barcodeView.layer.borderWidth = 2.0f;
//        barcodeView.layer.cornerRadius = 15;
//        barcodeView.layer.borderColor = [UIColor blackColor].CGColor;
//        barcodeView.clipsToBounds = YES;
//        
//    }
//    else 
    if (indexPath.row == 0) {  // mail View ..
        
        mailView = [[MailView alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            mailView.frame = CGRectMake(50, 140, 668, 600);
        } else {
            if (version >= 8.0) {
                mailView.frame = CGRectMake(30, 150, 260, 280);
            }
            else{
                mailView.frame = CGRectMake(30, 40, 260, 280);
            }        }
        
        
        [self.view addSubview:mailView];
        
        mailView.layer.borderWidth = 3.0f;
        mailView.layer.cornerRadius = 15;
        mailView.layer.borderColor = [UIColor whiteColor].CGColor;
        mailView.clipsToBounds = YES;
        
    }
    else if (indexPath.row == 1) {  // sms View ..
        
//        smsView = [[SmsProviderView alloc] init];
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            smsView.frame = CGRectMake(50, 60, 668, 900);
//        } else {
//            if (version >= 8.0) {
//                smsView.frame = CGRectMake(20, 80, 280, 400);
//            }
//            else{
//                smsView.frame = CGRectMake(20, 10, 280, 400);
//            }
//        }
//        
//        [self.view addSubview:smsView];
//        
//        smsView.layer.borderWidth = 3.0f;
//        smsView.layer.cornerRadius= 15;
//        smsView.layer.borderColor = [UIColor whiteColor].CGColor;
//        smsView.clipsToBounds = YES;
        
    }
    else if (indexPath.row == 2) {  // PrinterConfig View ..
        
        printerConfigView = [[PrinterConfigView alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            printerConfigView.frame = CGRectMake(50, 180, 668, 500);
        } else {
            if (version >= 8.0) {
                printerConfigView.frame = CGRectMake(30, 150, 260, 220);
            }
            else{
                printerConfigView.frame = CGRectMake(30, 40, 260, 220);
            }
        }
        
        [self.view addSubview:printerConfigView];
        
        printerConfigView.layer.borderWidth = 3.0f;
        printerConfigView.layer.cornerRadius= 15;
        printerConfigView.layer.borderColor = [UIColor whiteColor].CGColor;
        printerConfigView.clipsToBounds = YES;
        
    }
    else if (indexPath.row == 3) {  // Change Password View ..
        
        changePasswordView = [[ChangePasswordView alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            changePasswordView.frame = CGRectMake(50, 180, 668, 540);
        } else {
            if (version >= 8.0) {
                changePasswordView.frame = CGRectMake(30, 150, 260, 260);
            }else{
                changePasswordView.frame = CGRectMake(30, 40, 260, 260);
            }
        }
        
        [self.view addSubview:changePasswordView];
        
        changePasswordView.layer.borderWidth = 3.0f;
        changePasswordView.layer.cornerRadius= 15;
        changePasswordView.layer.borderColor = [UIColor whiteColor].CGColor;
        changePasswordView.clipsToBounds = YES;
        
    }
    
    else if (indexPath.row == 4) {  // FTP(File Transfer Protocol)
        
        // Allocation and initialization for FTPConfigurationView class to instance of that class
        ftpConfigurationView = [[FTPConfigurationView alloc] init];
        
        ftpConfigurationView.frame = CGRectMake((self.view.frame.size.width-668)/2, 180, 668, 540);
        
        [self.view addSubview:ftpConfigurationView];
        
        ftpConfigurationView.layer.borderWidth = 3.0f;
        ftpConfigurationView.layer.cornerRadius= 15;
        ftpConfigurationView.layer.borderColor = [UIColor whiteColor].CGColor;
        ftpConfigurationView.clipsToBounds = YES;
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
