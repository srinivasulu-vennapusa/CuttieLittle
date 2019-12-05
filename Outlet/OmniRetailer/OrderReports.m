//
//  SalesReports.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
//#import "SDZOrderService.h"
//#import "OrderServiceSvc.h"

#import "OrderReports.h"
#import "OrderServiceSvc.h"

static NSArray* item2 =nil;
int changeId = 0;
UIButton *pickButton;
//NSString *searchCriteriaValue = @"";

@implementation OrderReports

@synthesize fromOrder,toOrder,orderBy,amount;
@synthesize soundFileURLRef,soundFileObject;

UILabel *rec_Start;
UILabel *rec_End;
UILabel *rec_total;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    
    changeId = 0;
    //[HUD release];
    
    dateString =nil;
    //[fromOrderButton release];
    //[toOrderButton release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void) goHomePage {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
   // [self.navigationController popViewControllerAnimated:YES];
    [UIView  transitionWithView:self.navigationController.view duration:0.8  options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^(void) {
                         BOOL oldState = [UIView areAnimationsEnabled];
                         [UIView setAnimationsEnabled:NO];
                         [self.navigationController popViewControllerAnimated:YES];
                         [UIView setAnimationsEnabled:oldState];
                     }
                     completion:nil];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];

    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0, 200.0, 70.0)];
    titleLbl.text = @"Order Reports";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(20.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(55.0, -12.0, 150.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    }
    
    self.navigationItem.titleView = titleView;

    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
//    // BackGround color on top of the view ..
//    UILabel *topbar = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 31)] autorelease];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plain-background-home-send-ecard-leatherholes-color-border-font-2210890" ofType:@"jpg"]; 
//    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
//    img.frame = CGRectMake(0, 0, 320, 31);
//    [topbar addSubview:img];
//    [self.view addSubview:topbar];
    
    //UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images2.jpg"]];
//    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
//    
//    // label header on top of the view...
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"Order Reports";
//    label.textColor = [UIColor whiteColor];
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentLeft;
//    label.backgroundColor = [UIColor clearColor];
//    
//    
//    // login button on top of the view...
//    UIButton *backbutton = [[UIButton alloc] init] ;
//    [backbutton addTarget:self action:@selector(goHomePage) forControlEvents:UIControlEventTouchUpInside];
//    UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
//    [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
    
    
    
    /** TextFiels Design*/
    
    fromOrder = [[UITextField alloc] init];
    fromOrder.borderStyle = UITextBorderStyleRoundedRect;
    fromOrder.textColor = [UIColor blackColor]; 
    fromOrder.placeholder = @"from";  //place holder
    fromOrder.backgroundColor = [UIColor whiteColor]; 
    fromOrder.autocorrectionType = UITextAutocorrectionTypeNo;
    fromOrder.keyboardType = UIKeyboardTypeDefault;  
    fromOrder.returnKeyType = UIReturnKeyDone;  
    fromOrder.clearButtonMode = UITextFieldViewModeWhileEditing;
    fromOrder.userInteractionEnabled = NO;
    fromOrder.delegate = self;
    
    
    fromOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [fromOrderButton setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [fromOrderButton addTarget:self 
                      action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    fromOrderButton.tag = 1;
    fromOrder.delegate = self;
    
    
    toOrder = [[UITextField alloc] init];
    toOrder.borderStyle = UITextBorderStyleRoundedRect;
    toOrder.textColor = [UIColor blackColor]; 
    toOrder.placeholder = @"to";  //place holder
    toOrder.text = @"";
    toOrder.backgroundColor = [UIColor whiteColor]; 
    toOrder.autocorrectionType = UITextAutocorrectionTypeNo;
    toOrder.keyboardType = UIKeyboardTypeDefault;  
    toOrder.returnKeyType = UIReturnKeyDone;  
    toOrder.clearButtonMode = UITextFieldViewModeWhileEditing;
    toOrder.userInteractionEnabled = NO;
    toOrder.delegate = self;
    
    toOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD1 = [UIImage imageNamed:@"combo.png"];
    [toOrderButton setBackgroundImage:buttonImageDD1 forState:UIControlStateNormal];
    [toOrderButton addTarget:self 
                    action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    fromOrderButton.tag = 1;
    fromOrder.delegate = self;
    
    
    orderBy = [[UITextField alloc] init];
    orderBy.borderStyle = UITextBorderStyleRoundedRect;
    orderBy.textColor = [UIColor blackColor]; 
    orderBy.placeholder = @"order by";  //place holder
    orderBy.backgroundColor = [UIColor whiteColor]; 
    orderBy.autocorrectionType = UITextAutocorrectionTypeNo;
    orderBy.keyboardType = UIKeyboardTypeDefault;  
    orderBy.returnKeyType = UIReturnKeyDone;  
    orderBy.clearButtonMode = UITextFieldViewModeWhileEditing;
    orderBy.delegate = self;
    
    
    amount = [[UITextField alloc] init];
    amount.borderStyle = UITextBorderStyleRoundedRect;
    amount.textColor = [UIColor blackColor]; 
    amount.placeholder = @"Amount";  //place holder
    amount.backgroundColor = [UIColor whiteColor]; 
    amount.autocorrectionType = UITextAutocorrectionTypeNo;
 //   amount.keyboardType = UIKeyboardTypeDefault;  
    amount.returnKeyType = UIReturnKeyDone;  
    amount.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar1 sizeToFit]; 
    amount.inputAccessoryView = numberToolbar1;
    amount.keyboardType = UIKeyboardTypeNumberPad;
    amount.delegate = self;

    
    /** Design of Go Button*/
    
    goButton = [UIButton buttonWithType:UIButtonTypeCustom];
     [goButton addTarget:self action:@selector(gobuttonPressed:) forControlEvents:UIControlEventTouchDown]; 
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor grayColor];
    
    
    // taglabel initialization..
    tag = [[UILabel alloc] init];
    
    
    /** UIScrollView Design */ 
    scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = FALSE;


    
    /** Table Headers Design*/
    
    UILabel *order = [[UILabel alloc] init];
    order.backgroundColor = [UIColor clearColor];
    order.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    order.text = @"Order ID";
    order.textAlignment = NSTextAlignmentCenter;
    order.textColor = [UIColor whiteColor];
    

    
    
    
    //UILabel *orderby = [[UILabel alloc] init];
    //orderBy.frame = CGRectMake(80, 10, 79, 40);
    UILabel *orderby = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 200, 60)];
    orderby.backgroundColor = [UIColor clearColor];
    orderby.text = @"Order By";
    orderby.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    orderby.textAlignment = NSTextAlignmentCenter;
    orderby.font = [UIFont boldSystemFontOfSize:13];
    orderby.textColor = [UIColor whiteColor];
    
    
    
    UILabel *dueDate = [[UILabel alloc] init];
    dueDate.backgroundColor = [UIColor clearColor];
    dueDate.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    dueDate.text = @"Due Date";
    dueDate.textAlignment = NSTextAlignmentCenter;
    dueDate.font = [UIFont boldSystemFontOfSize:13];
    dueDate.textColor = [UIColor whiteColor];
    

    
    
    UILabel *time = [[UILabel alloc] init];
    time.frame = CGRectMake(240, 10, 79, 40);
    time.backgroundColor = [UIColor clearColor];
    time.text = @"Time";
    time.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    time.textAlignment = NSTextAlignmentCenter;
    time.font = [UIFont boldSystemFontOfSize:13];
    time.textColor = [UIColor whiteColor];
    

    

    UILabel *orderEmailId = [[UILabel alloc] init];
    orderEmailId.backgroundColor = [UIColor clearColor];
    orderEmailId.text = @"Order \nEmail ID";
    orderEmailId.frame = CGRectMake(320, 10, 80, 40);
    orderEmailId.numberOfLines = 2;
    orderEmailId.lineBreakMode = NSLineBreakByWordWrapping;
    orderEmailId.textAlignment = NSTextAlignmentLeft;
    orderEmailId.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    orderEmailId.textAlignment = NSTextAlignmentCenter;
    orderEmailId.font = [UIFont boldSystemFontOfSize:13];
    orderEmailId.textColor = [UIColor whiteColor];
    
    
    
    UILabel *orderPhNum = [[UILabel alloc] init];
    orderPhNum.backgroundColor = [UIColor clearColor];
    orderPhNum.text = @"Order \nPhNumber";
    orderPhNum.frame = CGRectMake(401, 10, 80, 40);
    orderPhNum.numberOfLines = 3;
    orderPhNum.lineBreakMode = NSLineBreakByWordWrapping;
    orderPhNum.textAlignment = NSTextAlignmentLeft;
    orderPhNum.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    orderPhNum.textAlignment = NSTextAlignmentCenter;
    orderPhNum.font = [UIFont boldSystemFontOfSize:13];
    orderPhNum.textColor = [UIColor whiteColor];
    
    
    
    UILabel *address = [[UILabel alloc] init];
    address.backgroundColor = [UIColor clearColor];
    address.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    address.text = @"Adress";
    address.textAlignment = NSTextAlignmentCenter;
    address.font = [UIFont boldSystemFontOfSize:13];
    address.textColor = [UIColor whiteColor];
    
    
    
    UILabel *orderAmount = [[UILabel alloc] init];
    orderAmount.backgroundColor = [UIColor clearColor];
    orderAmount.text = @"Order \nAmount";
    orderAmount.numberOfLines = 2;
    orderAmount.lineBreakMode = NSLineBreakByWordWrapping;
    orderAmount.textAlignment = NSTextAlignmentLeft;
    orderAmount.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    orderAmount.textAlignment = NSTextAlignmentCenter;
    orderAmount.font = [UIFont boldSystemFontOfSize:13];
    orderAmount.textColor = [UIColor whiteColor];
    
    
    
   searchCriterialable = [[UILabel alloc] init];
   searchCriterialable.text = @" # # # ";
    

//    /** Create PreviousButton */
//    UIButton *previousButton = [[UIButton alloc] init];
//    [previousButton addTarget:self 
//        action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchDown];
//    [previousButton setTitle:@"Previous" forState:UIControlStateNormal];
//    previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
//    previousButton.layer.cornerRadius = 3.0f;
//    previousButton.backgroundColor = [UIColor grayColor];
//    [previousButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    /** Create NextButton */
//    UIButton *nextButton = [[UIButton alloc] init];
//    [nextButton addTarget:self 
//          action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
//    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
//    nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
//    nextButton.layer.cornerRadius = 3.0f;
//    nextButton.backgroundColor = [UIColor grayColor];
//    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    /** Create PreviousButton */
    frstButton = [[UIButton alloc] init];
    [frstButton addTarget:self action:@selector(firstButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [frstButton setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    //[frstButton setTitle:@"First" forState:UIControlStateNormal];
    frstButton.layer.cornerRadius = 3.0f;
    frstButton.enabled = NO;
    
    /** Create NextButton */
    lastButton = [[UIButton alloc] init];
    [lastButton addTarget:self action:@selector(lastButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [lastButton setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    //[lastButton setTitle:@"Last" forState:UIControlStateNormal];
    lastButton.layer.cornerRadius = 3.0f;
    
    
    /** Create PreviousButton */
    previousButton = [[UIButton alloc] init];
    [previousButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [previousButton setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    //[previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    previousButton.layer.cornerRadius = 3.0f;
    previousButton.enabled = NO;
    
    /** Create NextButton */
    nextButton = [[UIButton alloc] init];
    [nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [nextButton setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    //[nextButton setTitle:@"Next" forState:UIControlStateNormal];
    nextButton.layer.cornerRadius = 3.0f;
    
    
    
    //bottom label1...
    rec_Start = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    rec_Start.text = @"";
    rec_Start.textAlignment = NSTextAlignmentLeft;
    rec_Start.backgroundColor = [UIColor clearColor];
    rec_Start.textColor = [UIColor whiteColor];
    
    //bottom label_2...
    label_2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label_2.text = @"-";
    label_2.textAlignment = NSTextAlignmentLeft;
    label_2.backgroundColor = [UIColor clearColor];
    label_2.textColor = [UIColor whiteColor];
    
    //bottom label2...
    rec_End = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    rec_End.text = @"";
    rec_End.textAlignment = NSTextAlignmentLeft;
    rec_End.backgroundColor = [UIColor clearColor];
    rec_End.textColor = [UIColor whiteColor];
    
    //bottom label_3...
    label_3 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label_3.text = @"of";
    label_3.textAlignment = NSTextAlignmentLeft;
    label_3.backgroundColor = [UIColor clearColor];
    label_3.textColor = [UIColor whiteColor];
    
    //bottom label3...
    rec_total = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    rec_total.textAlignment = NSTextAlignmentLeft;
    rec_total.backgroundColor = [UIColor clearColor];
    rec_total.textColor = [UIColor whiteColor];
    
    
    /** Create TableView */
    
    orderTableView = [[UITableView alloc]init];
    orderTableView.backgroundColor = [UIColor clearColor];
    orderTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    orderTableView.dataSource = self;
    orderTableView.delegate = self;
    orderTableView.bounces = FALSE;
    
    //item = [[NSMutableArray alloc] init];
    
    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        //         img.frame = CGRectMake(0, 0, 768, 50);
        //         label.frame = CGRectMake(5, 5, 300, 50);
        //         label.font = [UIFont boldSystemFontOfSize:25];
        //
        //         backbutton.frame = CGRectMake(720.0, 3.0, 40.0, 40.0);
        //         backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        fromOrder.frame = CGRectMake(5, 80, 330, 50);
        fromOrder.font = [UIFont systemFontOfSize:25.0];
        fromOrderButton.frame = CGRectMake(295, 75, 50, 65);
        
        toOrder.frame = CGRectMake(350, 80, 330, 50);
        toOrder.font = [UIFont systemFontOfSize:25.0];
        toOrderButton.frame = CGRectMake(640, 75, 50, 65);
        
        
        orderBy.frame = CGRectMake(5, 140, 330, 50);
        orderBy.font = [UIFont systemFontOfSize:25.0];
        
        amount.frame = CGRectMake(350, 140, 330, 50);
        amount.font = [UIFont systemFontOfSize:25.0];
        
        goButton.frame = CGRectMake(685, 140, 70, 50);
        goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        goButton.layer.cornerRadius = 20.f;
        
        
        scrollView.frame = CGRectMake(0, 150, 2000, 800);
        scrollView.contentSize = CGSizeMake(2800, 500);
        
        
        
        order.frame = CGRectMake(0, 0, 200, 60);
        order.font = [UIFont boldSystemFontOfSize:25];
        
        orderby.frame = CGRectMake(201, 0, 200, 60);
        orderby.font = [UIFont boldSystemFontOfSize:25];
        
        dueDate.frame = CGRectMake(402, 0, 200, 60);
        dueDate.font = [UIFont boldSystemFontOfSize:25];
        
        time.frame = CGRectMake(603, 0, 200, 60);
        time.font = [UIFont boldSystemFontOfSize:25];
        
        orderEmailId.frame = CGRectMake(804, 0, 200, 60);
        orderEmailId.font = [UIFont boldSystemFontOfSize:25];
        
        orderPhNum.frame = CGRectMake(1005, 0, 200, 60);
        orderPhNum.font = [UIFont boldSystemFontOfSize:25];
        
        address.frame = CGRectMake(1206, 0, 200, 60);
        address.font = [UIFont boldSystemFontOfSize:25];
        
        orderAmount.frame = CGRectMake(1407, 0, 200, 60);
        orderAmount.font = [UIFont boldSystemFontOfSize:25];
        
        orderTableView.frame = CGRectMake(0, 60, 2000, 800);
        orderTableView.backgroundColor = [UIColor clearColor];
        
        //         previousButton.frame = CGRectMake(30, 940, 350, 50);
        //         previousButton.layer.cornerRadius = 22.0f;
        //         previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        //         [self.view addSubview:previousButton];
        //
        //         nextButton.frame = CGRectMake(390, 940, 350, 50);
        //         nextButton.layer.cornerRadius = 22.0f;
        //         nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        //         [self.view addSubview:nextButton];
        
        frstButton.frame = CGRectMake(80, 960, 50, 50);
        frstButton.layer.cornerRadius = 25.0f;
        frstButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        previousButton.frame = CGRectMake(210, 960, 50, 50);
        previousButton.layer.cornerRadius = 25.0f;
        previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        nextButton.frame = CGRectMake(485, 960, 50, 50);
        nextButton.layer.cornerRadius = 25.0f;
        nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        lastButton.frame = CGRectMake(615, 960, 50, 50);
        lastButton.layer.cornerRadius = 25.0f;
        lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        rec_Start.frame = CGRectMake(295, 960, 30, 50);
        label_2.frame = CGRectMake(338, 960, 30, 50);
        rec_End.frame = CGRectMake(365, 960, 30, 50);
        label_3.frame = CGRectMake(400, 960, 30, 50);
        rec_total.frame = CGRectMake(435, 960, 30, 50);
        
        rec_Start.font = [UIFont systemFontOfSize:25.0];
        label_2.font = [UIFont systemFontOfSize:25.0];
        rec_End.font = [UIFont systemFontOfSize:25.0];
        label_3.font = [UIFont systemFontOfSize:25.0];
        rec_total.font = [UIFont systemFontOfSize:25.0];
        
    }
     else{
         
//         img.frame = CGRectMake(0, 0, 320, 31);
//         label.frame = CGRectMake(3, 1, 140, 30);
//         label.font = [UIFont boldSystemFontOfSize:17];
//         
//         backbutton.frame = CGRectMake(285.0, 2.0, 27.0, 27.0);
//         backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
         
         fromOrder.frame = CGRectMake(6, 5, 130, 30);
         fromOrder.font = [UIFont systemFontOfSize:15.0]; 
         fromOrderButton.frame = CGRectMake(117, 4, 22, 37);
         
         toOrder.frame = CGRectMake(138, 5, 130, 30);
         toOrder.font = [UIFont systemFontOfSize:15.0]; 
         toOrderButton.frame = CGRectMake(250, 4, 22, 37);
         
         orderBy.frame = CGRectMake(6, 41, 130, 30);
         orderBy.font = [UIFont systemFontOfSize:14.0]; 
         
         amount.frame = CGRectMake(138, 41, 130, 30);
         amount.font = [UIFont systemFontOfSize:15.0]; 
         
         goButton.frame = CGRectMake(270, 42, 48, 29);
         goButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
         goButton.layer.cornerRadius = 14.f;
        
         

         frstButton.frame = CGRectMake(10, 370, 40, 40);
         frstButton.layer.cornerRadius = 15.0f;
         frstButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
         
         
         lastButton.frame = CGRectMake(273, 370, 40, 40);
         lastButton.layer.cornerRadius = 15.0f;
         lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
         
         
         previousButton.frame = CGRectMake(70, 370, 40, 40);
         previousButton.layer.cornerRadius = 15.0f;
         previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
         
         
         nextButton.frame = CGRectMake(210, 370, 40, 40);
         nextButton.layer.cornerRadius = 15.0f;
         nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
         
         
         rec_Start.frame = CGRectMake(122, 375, 20, 30);
         label_2.frame = CGRectMake(140, 375, 20, 30);
         rec_End.frame = CGRectMake(148, 375, 20, 30);
         label_3.frame = CGRectMake(167, 375, 20, 30);
         rec_total.frame = CGRectMake(183, 375, 20, 30);
         
         rec_Start.font = [UIFont systemFontOfSize:14.0];
         label_2.font = [UIFont systemFontOfSize:14.0];
         rec_End.font = [UIFont systemFontOfSize:14.0];
         label_3.font = [UIFont systemFontOfSize:14.0];
         rec_total.font = [UIFont systemFontOfSize:14.0];
         
         scrollView.frame = CGRectMake(0, 65, 330, 304);
         scrollView.contentSize = CGSizeMake(650, 300);

         order.frame = CGRectMake(0, 10, 79, 40);
         orderby.frame = CGRectMake(80, 10, 79, 40);
         orderby.font = [UIFont boldSystemFontOfSize:13];
         dueDate.frame = CGRectMake(160, 10, 79, 40);
         time.frame = CGRectMake(240, 10, 79, 40);
         orderEmailId.frame = CGRectMake(320, 10, 80, 40);
         orderPhNum.frame = CGRectMake(401, 10, 80, 40);
         address.frame = CGRectMake(482, 10, 80, 40);
         orderAmount.frame = CGRectMake(563, 10, 80, 40);

         orderTableView.frame = CGRectMake(0, 50, 640, 370); 
 
     }
    
    [self.view addSubview: scrollView];
//    [self.view addSubview:img];
//    [self.view addSubview:label];
//    [self.view addSubview:backbutton];
    
    [self.view addSubview:fromOrder];
    [self.view addSubview:fromOrderButton];
    [self.view addSubview:toOrder];
    [self.view addSubview:toOrderButton];
    
    [self.view addSubview:orderBy];
    [self.view addSubview:amount];
    
    [self.view addSubview:goButton]; 
    
    [self.view addSubview:previousButton];
    [self.view addSubview:nextButton];
    
    [self.view addSubview:rec_Start];
    [self.view addSubview:label_2];
    [self.view addSubview:rec_End];
    [self.view addSubview:label_3];
    [self.view addSubview:rec_total];
    
    [self.view addSubview:frstButton];
    [self.view addSubview:lastButton];
    
    [scrollView addSubview:order];
    [scrollView addSubview:orderby];
    [scrollView addSubview:dueDate];
    [scrollView addSubview:time];
    [scrollView addSubview:orderEmailId];
    [scrollView addSubview:orderPhNum];
    [scrollView addSubview:address];
    [scrollView addSubview:orderAmount];
    
    [scrollView addSubview:orderTableView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    
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
    
    
    // Calling the webservices to get the present orders ..
    [self callingOrderServiceforRecords];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    
    if ([textField.text isEqualToString:orderBy.text]) {
        
        return YES; 
    } 
    else{
        
        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
    }
}


//Number pad close...
-(void)doneWithNumberPad{
    
    [amount resignFirstResponder];
}


//callingSalesServiceforRecords method handler...
-(void) callingOrderServiceforRecords{
    
    // Calling Webservices . .    
//    OrderServiceSoapBinding *orderBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
//    OrderServiceSvc_searchOrdersReportWithPagination *aParameters =  [[OrderServiceSvc_searchOrdersReportWithPagination alloc] init];
//    
//    aParameters.searchCriteria = searchCriterialable.text;
//    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeId];
//    
//    
//    OrderServiceSoapBindingResponse *response = [orderBindng searchOrdersReportWithPaginationUsingParameters:(OrderServiceSvc_searchOrdersReportWithPagination *) aParameters];
//    
//    NSArray *responseBodyParts = response.bodyParts;
//    //NSMutableArray *saleRecordsArray; 
//    NSArray *temp;
//    NSArray *temp1;
//    //NSArray *temp2;
//    item = [[NSMutableArray alloc] init];
//    [item removeAllObjects];
//    
//    for (id bodyPart in responseBodyParts) {
//        if ([bodyPart isKindOfClass:[OrderServiceSvc_searchOrdersReportWithPaginationResponse class]]) {
//            OrderServiceSvc_searchOrdersReportWithPaginationResponse *body = (OrderServiceSvc_searchOrdersReportWithPaginationResponse *)bodyPart;
//            printf("\nresponse=%s",[body.return_ UTF8String]);
//            
//            // removing hud ..
//            [HUD hide:YES afterDelay:0.5];
//            
//            if (![[body return_] isEqualToString:NULL]) {
//                
//                temp = [body.return_ componentsSeparatedByString:@"@!"];
//                
//                NSLog(@" %@",[temp objectAtIndex:0]);
//                NSLog(@" %@",[temp objectAtIndex:1]);
//                
//                if ([[temp objectAtIndex:0] intValue] > 0) {
//                    
//                    rec_Start.text = [NSString stringWithFormat:@"%d",(changeId * 5) + 1];
//                    rec_End.text = [NSString stringWithFormat:@"%d",[rec_Start.text intValue] + 4];
//                    rec_total.text = [temp objectAtIndex:0];
//                    label_2.text = @"-";
//                    label_3.text = @"of";
//                    
//                    if ([[temp objectAtIndex:0] intValue] <= 5) {
//                        
//                        //previousButton.backgroundColor = [UIColor lightGrayColor];
//                        previousButton.enabled = NO;
//                        
//                        //frstButton.backgroundColor = [UIColor lightGrayColor];
//                        frstButton.enabled = NO;
//                        
//                        nextButton.enabled = NO;
//                        //nextButton.backgroundColor = [UIColor lightGrayColor];
//                        
//                        lastButton.enabled = NO;
//                        //lastButton.backgroundColor = [UIColor lightGrayColor];
//                        
//                        rec_End.text = rec_total.text;
//                        
//                    }
//                    else{
//                        
//                        if (changeId == 0){
//                            //previousButton.backgroundColor = [UIColor lightGrayColor];
//                            previousButton.enabled = NO;
//                            
//                            
//                            //frstButton.backgroundColor = [UIColor lightGrayColor];
//                            frstButton.enabled = NO;
//                            
//                        }
//                        if (([[temp objectAtIndex:0] intValue] - (5*(changeId+1))) <= 0){
//                            
//                            nextButton.enabled = NO;
//                            //nextButton.backgroundColor = [UIColor lightGrayColor];
//                            
//                            lastButton.enabled = NO;
//                           // lastButton.backgroundColor = [UIColor lightGrayColor];
//                            
//                            rec_End.text = rec_total.text;
//                            
//                        }
//                        else{
//                            nextButton.enabled = YES;
//                            //nextButton.backgroundColor = [UIColor grayColor];
//                            
//                            lastButton.enabled = YES;
//                            //lastButton.backgroundColor = [UIColor grayColor];
//                        }                    
//                    }
//                    
//                    temp1 = [[temp objectAtIndex:1] componentsSeparatedByString:@"!"];
//                    for (int i=0 ;i<[temp1 count] ; i++) {
//                        [item addObject:[temp1 objectAtIndex:i]];
//                    }
//                    NSLog(@" %@",item);
//                    [orderTableView reloadData];
//                }
//                else{
//                    
//                    item = nil;
//                    [orderTableView reloadData];
//                    
//                    rec_Start.text = @"";
//                    label_2.text = @"";
//                    rec_End.text = @"";
//                    label_3.text = @"";
//                    rec_total.text = @"";
//                    
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Records Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//                    [alert release];
//                }
//            }
//            else{
//                
//                //changeID--; 
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Records Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//                [alert release];
//                
//                
//            }
//        } 
//    }
    rec_Start.text = @"0";
    rec_End.text = @"0";
    rec_total.text = @"0";
    nextButton.enabled = NO;
    lastButton.enabled = NO;
    [HUD hide:YES afterDelay:0.5];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Records Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



///// Handle the response from searchOrdersReportWithPagination.
//
//- (void) searchOrdersReportWithPaginationHandler: (id) value {
//    
//    // Handle errors
//    if([value isKindOfClass:[NSError class]]) {
//        //NSLog(@"%@", value);
//        return;
//    }
//    
//    // Handle faults
//    if([value isKindOfClass:[SoapFault class]]) {
//        //NSLog(@"%@", value);
//        return;
//    }                
//    
//    [HUD setHidden:YES];
//    
//    // Do something with the NSString* result
//    NSString* result = (NSString*)value;
//
//    NSArray *items = [[NSArray alloc] init];
//    if ([result length] > 1) {
//        
//        items = [result componentsSeparatedByString:@"!"]; 
//        
//        [item removeAllObjects];
//        [item addObjectsFromArray:items];
//        [item removeObjectAtIndex:0];
//        
//        [orderTableView reloadData];
//    }
//    else{
//        
//        changeId--;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Records Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//    }
//    
//    
//}


// GobuttonPressed handler...

- (void) gobuttonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [orderBy resignFirstResponder];
    [amount resignFirstResponder];
    
    searchCriterialable.text = @" # # ";

    NSString *fromOrderValue = [fromOrder.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //NSString *toOrderValue = [toOrder.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *orderByValue = [orderBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *amountValue = [amount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if ([toOrder.text isEqualToString:@""]) {
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy/MM/dd";
        toOrder.text = [formatter stringFromDate:date];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    NSString *selectedDate = fromOrder.text; //Dynamic Date
    NSDate *dateString1 = [dateFormatter dateFromString:selectedDate];
    
    NSString *selectedDate1 = toOrder.text; //Dynamic Date
    NSDate *dateString11 = [dateFormatter dateFromString:selectedDate1];
    
    
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    NSString* curDate = [formatter stringFromDate:date];
    NSDate *dateString2 = [dateFormatter dateFromString:curDate];
    
    
    NSComparisonResult result1 = [dateString1 compare:dateString2];
    NSComparisonResult result2 = [dateString11 compare:dateString2];
    NSComparisonResult result3 = [dateString11 compare:dateString1];
    
    
    if(result1 == NSOrderedDescending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"From Date should be less than to current date" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(result2 == NSOrderedDescending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"To Date should be less than to current date" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(result3 == NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"From Date should be less than or equal to To date" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(fromOrderValue.length != 0){

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy/MM/dd";
        
        NSString *tempDate1 = fromOrder.text; //Dynamic Date
        NSString *tempDate2 = toOrder.text; //Dynamic Date
        NSDate *dateString1 = [dateFormatter dateFromString:tempDate1];
        NSDate *dateString2 = [dateFormatter dateFromString:tempDate2];
        
        if (dateString1 != NULL && dateString2 != NULL) {
            
            if (orderByValue.length != 0 && amountValue.length != 0){
                
                searchCriterialable.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", fromOrder.text,@"#", toOrder.text,@"#",orderBy.text,@"#",amount.text];
            }
            else if(orderByValue.length != 0){
                
                searchCriterialable.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", fromOrder.text,@"#", toOrder.text,@"#",orderBy.text,@"#",@" "];
            }
            else if(amountValue.length != 0){
                
                searchCriterialable.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", fromOrder.text,@"#", toOrder.text,@"#",@" ",@"#",amount.text];
            }
            else{
                
                searchCriterialable.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", fromOrder.text,@"#",toOrder.text,@"#",@" ",@"#",@" "];
            }
            
//            [HUD setHidden:NO];
//            // Create the servic
//            SDZOrderService* service = [SDZOrderService service];
//            service.logging = YES;
//            
//            // Returns NSString*. 
//            [service searchOrdersReportWithPagination:self action:@selector(searchOrdersReportWithPaginationHandler:) searchCriteria: searchCriterialable.text pageNumber:[NSString stringWithFormat:@"%d",changeId]];
            
            
            //[HUD setHidden:NO];
            [HUD show:YES];
            
            if (!changeId == 0){
                changeId = 0;
            }
            
            [self callingOrderServiceforRecords];
            
            //fromOrder.text = nil;
            //toOrder.text = nil;
            //orderBy.text = nil;
            //amount.text = nil;
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Enter Valid DateFormat" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }  
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Date Field" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


//// previousButtonPressed handing...
//
//- (void) previousButtonPressed:(id) sender {
//   
//    if (changeId > 0){
//        
//    changeId--; 
//     
//    [HUD setHidden:NO];
//        
//    SDZOrderService* service = [SDZOrderService service];
//    service.logging = YES;
//    
//    // Returns NSString*. 
//    [service searchOrdersReportWithPagination:self action:@selector(searchOrdersReportWithPaginationHandler:) searchCriteria: searchCriterialable.text pageNumber:[NSString stringWithFormat:@"%d",changeId]];
//    }
//    
//}
//
//
//// NextButtonPressed handing...
//
//- (void) nextButtonPressed:(id) sender { 
//   
//    changeId++;  
//   
//    [HUD setHidden:NO];
//    
//    SDZOrderService* service = [SDZOrderService service];
//    service.logging = YES;
//    
//    // Returns NSString*. 
//    [service searchOrdersReportWithPagination:self action:@selector(searchOrdersReportWithPaginationHandler:) searchCriteria: searchCriterialable.text pageNumber:[NSString stringWithFormat:@"%d",changeId]]; 
//}

//previousButtonPressed handler...
- (void) previousButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (changeId > 0) {
        
        changeId--; 
        // [HUD setHidden:NO];
        [HUD show:YES];
    }
    [self callingOrderServiceforRecords];
}


//nextButtonPressed handler...
- (void) nextButtonPressed:(id) sender { 
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    changeId++;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousButton.enabled = YES;
    
    
    //frstButton.backgroundColor = [UIColor grayColor];
    frstButton.enabled = YES;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    [self callingOrderServiceforRecords];
}


//FirstButtonPressed handler...
- (void) firstButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    changeId = 0;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    [self callingOrderServiceforRecords];
}


//LastButtonPressed handler...
- (void) lastButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //float a = [rec_total.text intValue]/5;
    //float t = ([rec_total.text floatValue]/5);
    
    if ((rec_total.text).intValue/5 == ((rec_total.text).floatValue/5)) {
        
        changeId = (rec_total.text).intValue/5 - 1;
    }
    else{
        changeId =(rec_total.text).intValue/5;
    }
    //changeID = ([rec_total.text intValue]/5) - 1;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousButton.enabled = YES;
    
    
    //frstButton.backgroundColor = [UIColor grayColor];
    frstButton.enabled = YES;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    [self callingOrderServiceforRecords];
}






/** DateButtonPressed handle....
 To create picker frame and set the date inside the dueData textfield.
 */ 
-(IBAction) DateButtonPressed:(id) sender{
    
    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//    
//    NSString *tagstring = [NSString stringWithFormat:@"%d", [sender tag]];
//    tag.text = tagstring;
//    
//    //pickerview creation....
//    pickView = [[UIView alloc] init];
//    
//     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//         
//         pickView.frame = CGRectMake(200, 7, 320, 460);
//     }
//     else{
//         pickView.frame = CGRectMake(0, 0, 320, 460);
//     }
//    
//    pickView.backgroundColor = [UIColor clearColor];
//    
//    //pickerframe creation...
//    CGRect pickerFrame = CGRectMake(0,110,0,0);
//    myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
//    
//    //Current Date...
//    NSDate *now = [NSDate date];    
//    [myPicker setDate:now animated:YES];    
//    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [pickButton setImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
//    
//    
//    pickButton.frame = CGRectMake(105, 327, 120, 35);
//    pickButton.backgroundColor = [UIColor clearColor];
//    pickButton.layer.masksToBounds = YES;
//    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
//    //[pickButton setTitle:@"OK" forState:UIControlStateNormal];
//    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
//    pickButton.layer.borderWidth = 0.5f;
//    pickButton.layer.cornerRadius = 12;
//    //pickButton.layer.masksToBounds = YES;
//    [pickView addSubview:myPicker];
//    [pickView addSubview:pickButton];
//    [self.view addSubview:pickView];
//    
//    [pickView release];
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        NSString *tagstring = [NSString stringWithFormat:@"%d", [sender tag]];
        tag.text = tagstring;
    
    
    if ((UIButton *)sender == fromOrderButton) {
        toOrderButton.enabled = NO;
        goButton.enabled = NO;
    }
    else if ((UIButton *)sender == toOrderButton){
        fromOrderButton.enabled = NO;
        goButton.enabled = NO;
    }
    
        //pickerview creation....
        pickView = [[UIView alloc] init];
        
        if ([tagstring isEqualToString:@"1"]) {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                pickView.frame = CGRectMake(10, 132, 320, 320);
            }
            else{
                pickView.frame = CGRectMake(0, 0, 320, 460);
            }
        }
        else {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                pickView.frame = CGRectMake(350, 132, 320, 320);
            }
            else{
                pickView.frame = CGRectMake(0, 0, 320, 460);
            }
            
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
        
        pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
        pickButton.frame = CGRectMake(105, 269, 100, 45);
        pickButton.backgroundColor = [UIColor clearColor];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
        pickButton.layer.borderColor = [UIColor blackColor].CGColor;
        pickButton.layer.borderWidth = 0.5f;
        pickButton.layer.cornerRadius = 12;
        //pickButton.layer.masksToBounds = YES;
        [pickView addSubview:myPicker];
        [pickView addSubview:pickButton];
        [self.view addSubview:pickView];
        
   
}


// handle getDate method for pick date from calendar.
-(IBAction)getDate:(id)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    fromOrderButton.enabled = YES;
    toOrderButton.enabled = YES;
    goButton.enabled = YES;
    
    //Date Formate Setting...
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    sdayFormat.dateFormat = @"yyyy/MM/dd";
    dateString = [sdayFormat stringFromDate:myPicker.date];    
    
    if ([tag.text isEqualToString:@"1"]) {
        
        fromOrder.text = dateString;
    }
    else{
        toOrder.text = dateString;
    }
    [pickView removeFromSuperview];
    
}



// Hidden TextFields...
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [fromOrder resignFirstResponder];
    [toOrder resignFirstResponder];
    [orderBy resignFirstResponder];  
    [amount resignFirstResponder]; 
    return YES;
}


/** Table Implementation */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return item.count;
    
}

//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 80.0;
    }
    else{
         return 54.0;
    }
}

// Customize the appearance of table view cells.
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
    
    if (item.count > 0) {
        
        item2 = [item[indexPath.row] componentsSeparatedByString:@"#"];
    
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
     
            item2 = [item[indexPath.row] componentsSeparatedByString:@"#"];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 150.0, 50)];
            label1.text = item2[0];
            label1.font = [UIFont systemFontOfSize:25.0f];
            label1.textColor = [UIColor whiteColor];
            label1.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
            label1.layer.cornerRadius = 20.0f;
            label1.layer.masksToBounds = YES;
            label1.textAlignment = NSTextAlignmentCenter;
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(200, 8, 200, 50)];
            label2.text = item2[1];
            label2.font = [UIFont systemFontOfSize:25.0f];
            label2.backgroundColor = [UIColor clearColor];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(400, 8, 200, 50)];
            label3.text = item2[2];
            label3.font = [UIFont systemFontOfSize:25.0f];
            label3.backgroundColor = [UIColor clearColor];
            label3.textAlignment = NSTextAlignmentCenter;
            label3.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(600, 8, 200, 50)];
            label4.text = item2[3];
            label4.font = [UIFont systemFontOfSize:25.0f];
            label4.backgroundColor = [UIColor clearColor];
            label4.textAlignment = NSTextAlignmentCenter;
            label4.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(800, 8, 200, 50)];
            label5.text = item2[4];
            label5.font = [UIFont systemFontOfSize:25.0f];
            label5.backgroundColor = [UIColor clearColor];
            label5.textAlignment = NSTextAlignmentCenter;
            label5.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(1000, 8, 200, 50)];
            label6.text = item2[5];
            label6.font = [UIFont systemFontOfSize:25.0f];
            label6.backgroundColor = [UIColor clearColor];
            label6.textAlignment = NSTextAlignmentCenter;
            label6.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(1200, 8, 200, 50)];
            label7.text = item2[6];
            label7.font = [UIFont systemFontOfSize:25.0f];
            label7.backgroundColor = [UIColor clearColor];
            label7.textAlignment = NSTextAlignmentCenter;
            label7.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(1455, 0, 200, 50)];
            label8.text = item2[7];
            label8.font = [UIFont systemFontOfSize:25.0f];
            label8.backgroundColor = [UIColor clearColor];
            label8.textAlignment = NSTextAlignmentLeft;
            label8.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            [cell.contentView addSubview:label1];
            [cell.contentView addSubview:label2];
            [cell.contentView addSubview:label3];
            [cell.contentView addSubview:label4];
            [cell.contentView addSubview:label5];
            [cell.contentView addSubview:label6];
            [cell.contentView addSubview:label7];
            [cell.contentView addSubview:label8];
        }
        else{
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(2, 5, 80, 30)];
            label1.text = item2[0];
            label1.font = [UIFont systemFontOfSize:13.0f];
            label1.textColor = [UIColor whiteColor];
            label1.backgroundColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            label1.layer.cornerRadius = 20.0f;
            label1.layer.masksToBounds = YES;
            label1.textAlignment = NSTextAlignmentCenter;
            
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 95, 30)];
            label2.text = item2[1];
            label2.font = [UIFont systemFontOfSize:13.0f];
            label2.backgroundColor = [UIColor clearColor];
            label2.textAlignment = NSTextAlignmentCenter;
            
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(158, 5, 80, 30)];
            label3.text = item2[2];
            label3.font = [UIFont systemFontOfSize:13.0f];
            label3.backgroundColor = [UIColor clearColor];
            label3.textAlignment = NSTextAlignmentCenter;
            
            
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(237, 5, 80, 30)];
            label4.text = item2[3];
            label4.font = [UIFont systemFontOfSize:13.0f];
            label4.backgroundColor = [UIColor clearColor];
            label4.textAlignment = NSTextAlignmentCenter;
            
            
            UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(323, 5, 80, 30)];
            label5.text = item2[4];
            label5.font = [UIFont systemFontOfSize:13.0f];
            label5.backgroundColor = [UIColor clearColor];
            label5.textAlignment = NSTextAlignmentCenter;
            
            
            UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(402, 5, 80, 30)];
            label6.text = item2[5];
            label6.font = [UIFont systemFontOfSize:13.0f];
            label6.backgroundColor = [UIColor clearColor];
            label6.textAlignment = NSTextAlignmentCenter;
            
            
            UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(496, 5, 80, 30)];
            label7.text = item2[6];
            label7.font = [UIFont systemFontOfSize:13.0f];
            label7.backgroundColor = [UIColor clearColor];
            label7.textAlignment = NSTextAlignmentCenter;
            
            
            UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(580, 5, 80, 30)];
            label8.text = item2[7];
            label8.font = [UIFont systemFontOfSize:13.0f];
            label8.backgroundColor = [UIColor clearColor];
            label8.textAlignment = NSTextAlignmentLeft;
            
            label2.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            label3.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            label4.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            label5.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            label6.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            label7.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            label8.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            [cell.contentView addSubview:label1];
            [cell.contentView addSubview:label2];
            [cell.contentView addSubview:label3];
            [cell.contentView addSubview:label4];
            [cell.contentView addSubview:label5];
            [cell.contentView addSubview:label6];
            [cell.contentView addSubview:label7];
            [cell.contentView addSubview:label8];
        }

    }
    
    cell.tag = indexPath.row;
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor blackColor];
    }
    else{
        cell.contentView.backgroundColor = [UIColor blackColor];
    }
    cell.backgroundColor = [UIColor blackColor];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
