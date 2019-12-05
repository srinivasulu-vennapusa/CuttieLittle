//
//  NormalStock.m
//  OmniRetailer
//
//  Created by technolabs on 05/11/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "NormalStock.h"
//#import "SDZSalesService.h"
#import "SalesServiceSvc.h"
//#import "SDZSkuService.h"
#import "SkuServiceSvc.h"
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "StockDetails.h"
//#import "SkuService.h"
#import "RawMaterialServiceSvc.h"

int correspondingIndexToSynTheArrays = 0;
int changeNum14_n = 0;
int changeNum13_n = 0;
int cellcount1_n = 0;
int cellcount_n = 0;

@implementation NormalStock
    @synthesize soundFileURLRef,soundFileObject;

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
    //[stockCellView release];
    
    nameArray_ = nil;
    descArray_ = nil;
    avaiArray_ = nil;
    unitArray_ = nil;
    reorArray_ = nil;
    skuIdArr_ = nil;
    colorArr_ = nil;
    sizeArr_ = nil;
    
    
    
    
    pageNo = 0;
    changeNum14_n = 0;
    cellcount1_n = 0;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) goHomePage {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //[self.navigationController popViewControllerAnimated:YES];
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
    self.title = @"Raw Materials";
    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    version =  [UIDevice currentDevice].systemVersion.floatValue;
    
    NSArray *segmentLabels = @[@"Normal Stocks",@"Critical Stocks"];
    
    mainSegmentedControl = [[UISegmentedControl alloc] initWithItems:segmentLabels];
    
    mainSegmentedControl.tintColor=[UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    //segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    mainSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    mainSegmentedControl.backgroundColor = [UIColor lightGrayColor];
    
    //UIColor *tintcolor=[UIColor colorWithRed:63.0/255.0 green:127.0/255.0 blue:187.0/255.0 alpha:1.0];
    //[[segmentedControl.subviews objectAtIndex:0] setTintColor:tintcolor];
    mainSegmentedControl.selectedSegmentIndex = 0;
    [mainSegmentedControl addTarget:self action:@selector(segmentAction1:) forControlEvents:UIControlEventValueChanged];
    
    // assigning a value to check the bill finished ..
    mainSegmentedControl.tag = 0;
    
    // BackGround color on top of the view ..
    //UILabel *topbar = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 31)] autorelease];
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plain-background-home-send-ecard-leatherholes-color-border-font-2210890" ofType:@"jpg"];
    //UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images2.jpg"]];
    //    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    //
    //    // label header on top of the view...
    //    UILabel *label = [[UILabel alloc] init];
    //    label.text = @"Critical Stock";
    //    label.textColor = [UIColor whiteColor];
    //    label.textColor = [UIColor whiteColor];
    //    label.textAlignment = NSTextAlignmentLeft;
    //    label.backgroundColor = [UIColor clearColor];
    //
    //    // login button on top of the view...
    //    UIButton *backbutton = [[UIButton alloc] init] ;
    //    [backbutton addTarget:self action:@selector(goHomePage) forControlEvents:UIControlEventTouchUpInside];
    //    backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    //    UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
    //    [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
    
    //    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    //    backImage.image = [UIImage imageNamed:@"omni_home_bg.png"];
    //    [self.view addSubview:backImage];
    
    criticalStockView = [[UIView alloc] init];
    criticalStockView.frame = CGRectMake(0.0, 125.0, self.view.frame.size.width, self.view.frame.size.height);
    criticalStockView.backgroundColor = [UIColor clearColor];
    criticalStockView.hidden = YES;
    
    normalStockView = [[UIView alloc] init];
    normalStockView.frame = CGRectMake(0.0, 125.0, self.view.frame.size.width, self.view.frame.size.height);
    normalStockView.backgroundColor = [UIColor clearColor];
    normalStockView.hidden = NO;
    
    /** SearchBarItem*/
    const NSInteger searchBarHeight = 40;
    criticalStockSearchBar = [[UISearchBar alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        criticalStockSearchBar.frame = CGRectMake(0, 0, 768, 60);
    }
    else {
        criticalStockSearchBar.frame = CGRectMake(0, 0, 320, searchBarHeight);
    }
    criticalStockSearchBar.delegate = self;
    criticalStockSearchBar.tintColor=[UIColor grayColor];
    criticalstockTable.tableHeaderView = criticalStockSearchBar;
    [criticalStockView addSubview:criticalStockSearchBar];
    
    normalStockSearchBar = [[UISearchBar alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        normalStockSearchBar.frame = CGRectMake(0, 0, 768, 60);
    }
    else {
        normalStockSearchBar.frame = CGRectMake(0, 0, 320, searchBarHeight);
    }
    normalStockSearchBar.delegate = self;
    normalStockSearchBar.tintColor=[UIColor grayColor];
    normalstockTable.tableHeaderView = normalStockSearchBar;
    [normalStockView addSubview:normalStockSearchBar];
    
    //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddContact:)];
    //    self.navigationItem.rightBarButtonItem = addButton;
    
    normalCopyListOfItems = [[NSMutableArray alloc] init];
    criticalListOfItems = [[NSMutableArray alloc] init];
    
    criticalSearching = NO;
    criticalLetUserSelectRow = YES;
    
    normalSearching = NO;
    normalLetUserSelectRow = YES;
    
    /** Table Creation*/
    criticalstockTable = [[UITableView alloc] init];
    criticalstockTable.dataSource = self;
    criticalstockTable.delegate = self;
    criticalstockTable.backgroundColor = [UIColor clearColor];
    criticalstockTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    /** Table Creation*/
    normalstockTable = [[UITableView alloc] init];
    normalstockTable.dataSource = self;
    normalstockTable.delegate = self;
    normalstockTable.backgroundColor = [UIColor clearColor];
    
    normalstockTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    criticalfirstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [criticalfirstBtn addTarget:self action:@selector(firstButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [criticalfirstBtn setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    criticalfirstBtn.layer.cornerRadius = 3.0f;
    
    criticallastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [criticallastBtn addTarget:self action:@selector(lastButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [criticallastBtn setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    criticallastBtn.layer.cornerRadius = 3.0f;
    
    /** Create PreviousButton */
    criticalpreviousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [criticalpreviousButton addTarget:self
                               action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [criticalpreviousButton setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    //[previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    //previousButton.backgroundColor = [UIColor lightGrayColor];
    criticalpreviousButton.enabled =  NO;
    
    
    /** Create NextButton */
    criticalnextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [criticalnextButton addTarget:self
                           action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [criticalnextButton setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    //[nextButton setTitle:@"Next" forState:UIControlStateNormal];
    //nextButton.backgroundColor = [UIColor grayColor];
    
    
    criticalrecStart1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    criticalrecStart1.text = @"";
    criticalrecStart1.textAlignment = NSTextAlignmentLeft;
    criticalrecStart1.backgroundColor = [UIColor clearColor];
    criticalrecStart1.textColor = [UIColor whiteColor];
    
    //bottom label_2...
    criticallabel11 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    criticallabel11.text = @"-";
    criticallabel11.textAlignment = NSTextAlignmentLeft;
    criticallabel11.backgroundColor = [UIColor clearColor];
    criticallabel11.textColor = [UIColor whiteColor];
    
    //bottom label2...
    criticalrecEnd1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    criticalrecEnd1.text = @"";
    criticalrecEnd1.textAlignment = NSTextAlignmentLeft;
    criticalrecEnd1.backgroundColor = [UIColor clearColor];
    criticalrecEnd1.textColor = [UIColor whiteColor];
    
    //bottom label_3...
    criticallabel22 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    criticallabel22.text = @"of";
    criticallabel22.textAlignment = NSTextAlignmentLeft;
    criticallabel22.backgroundColor = [UIColor clearColor];
    criticallabel22.textColor = [UIColor whiteColor];
    
    //bottom label3...
    criticaltotalRec1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    criticaltotalRec1.textAlignment = NSTextAlignmentLeft;
    criticaltotalRec1.backgroundColor = [UIColor clearColor];
    criticaltotalRec1.textColor = [UIColor whiteColor];
    
    normalfirstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [normalfirstBtn addTarget:self action:@selector(firstButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [normalfirstBtn setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    normalfirstBtn.layer.cornerRadius = 3.0f;
    
    normallastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [normallastBtn addTarget:self action:@selector(lastButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [normallastBtn setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    normallastBtn.layer.cornerRadius = 3.0f;
    
    /** Create PreviousButton */
    normalpreviousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [normalpreviousButton addTarget:self
                             action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [normalpreviousButton setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    //[previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    //previousButton.backgroundColor = [UIColor lightGrayColor];
    normalpreviousButton.enabled =  NO;
    
    
    /** Create NextButton */
    normalnextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [normalnextButton addTarget:self
                         action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [normalnextButton setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    //[nextButton setTitle:@"Next" forState:UIControlStateNormal];
    //nextButton.backgroundColor = [UIColor grayColor];
    
    
    //bottom label1...
    normalrecStart1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    normalrecStart1.text = @"";
    normalrecStart1.textAlignment = NSTextAlignmentLeft;
    normalrecStart1.backgroundColor = [UIColor clearColor];
    normalrecStart1.textColor = [UIColor whiteColor];
    
    //bottom label_2...
    normallabel11 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    normallabel11.text = @"-";
    normallabel11.textAlignment = NSTextAlignmentLeft;
    normallabel11.backgroundColor = [UIColor clearColor];
    normallabel11.textColor = [UIColor whiteColor];
    
    //bottom label2...
    normalrecEnd1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    normalrecEnd1.text = @"";
    normalrecEnd1.textAlignment = NSTextAlignmentLeft;
    normalrecEnd1.backgroundColor = [UIColor clearColor];
    normalrecEnd1.textColor = [UIColor whiteColor];
    
    //bottom label_3...
    normallabel22 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    normallabel22.text = @"of";
    normallabel22.textAlignment = NSTextAlignmentLeft;
    normallabel22.backgroundColor = [UIColor clearColor];
    normallabel22.textColor = [UIColor whiteColor];
    
    //bottom label3...
    normaltotalRec1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    normaltotalRec1.textAlignment = NSTextAlignmentLeft;
    normaltotalRec1.backgroundColor = [UIColor clearColor];
    normaltotalRec1.textColor = [UIColor whiteColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.frame = CGRectMake(10, 0, 200, 45);
        //        backbutton.frame = CGRectMake(710.0, 2.0, 45.0, 45.0);
        criticalstockTable.frame = CGRectMake(0, 60, 778, 780.0);
        
        //        label.font = [UIFont boldSystemFontOfSize:25];
        
        criticalfirstBtn.frame = CGRectMake(80, 845.0, 50, 50);
        criticalfirstBtn.layer.cornerRadius = 25.0f;
        criticalfirstBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        criticallastBtn.frame = CGRectMake(625, 845.0, 50, 50);
        criticallastBtn.layer.cornerRadius = 25.0f;
        criticallastBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        criticalpreviousButton.frame = CGRectMake(220, 845.0, 50, 50);
        criticalpreviousButton.layer.cornerRadius = 22.0f;
        criticalpreviousButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        criticalnextButton.frame = CGRectMake(500, 845.0, 50, 50);
        criticalnextButton.layer.cornerRadius = 22.0f;
        criticalnextButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        criticalrecStart1.frame = CGRectMake(305, 845.0, 80, 50);
        criticallabel11.frame = CGRectMake(338, 845.0, 80, 50);
        criticalrecEnd1.frame = CGRectMake(365, 845.0, 80, 50);
        criticallabel22.frame = CGRectMake(400, 845.0, 80, 50);
        criticaltotalRec1.frame = CGRectMake(435, 845.0, 80, 50);
        
        criticalrecStart1.font = [UIFont systemFontOfSize:25.0];
        criticallabel11.font = [UIFont systemFontOfSize:25.0];
        criticalrecEnd1.font = [UIFont systemFontOfSize:25.0];
        criticallabel22.font = [UIFont systemFontOfSize:25.0];
        criticaltotalRec1.font = [UIFont systemFontOfSize:25.0];
        
        normalstockTable.frame = CGRectMake(0, 60, 778, 780.0);
        
        // label.font = [UIFont boldSystemFontOfSize:25];
        
        normalfirstBtn.frame = CGRectMake(80, 845.0, 50, 50);
        normalfirstBtn.layer.cornerRadius = 25.0f;
        normalfirstBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        normallastBtn.frame = CGRectMake(625, 845.0, 50, 50);
        normallastBtn.layer.cornerRadius = 25.0f;
        normallastBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        normalpreviousButton.frame = CGRectMake(220, 845.0, 50, 50);
        normalpreviousButton.layer.cornerRadius = 22.0f;
        normalpreviousButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        normalnextButton.frame = CGRectMake(500, 845.0, 50, 50);
        normalnextButton.layer.cornerRadius = 22.0f;
        normalnextButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        normalrecStart1.frame = CGRectMake(295, 845.0, 80, 50);
        normallabel11.frame = CGRectMake(338, 845.0, 80, 50);
        normalrecEnd1.frame = CGRectMake(365, 845.0, 80, 50);
        normallabel22.frame = CGRectMake(400, 845.0, 80, 50);
        normaltotalRec1.frame = CGRectMake(435, 845.0, 80, 50);
        
        normalrecStart1.font = [UIFont systemFontOfSize:25.0];
        normallabel11.font = [UIFont systemFontOfSize:25.0];
        normalrecEnd1.font = [UIFont systemFontOfSize:25.0];
        normallabel22.font = [UIFont systemFontOfSize:25.0];
        normaltotalRec1.font = [UIFont systemFontOfSize:25.0];
        
        mainSegmentedControl.frame = CGRectMake(-2, 65, 772, 60);
        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        NSDictionary *attributes = @{UITextAttributeFont: [UIFont boldSystemFontOfSize:18],UITextAttributeTextColor: [UIColor whiteColor]};
        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
    }
    else {
        if (version >= 8.0) {
            criticalstockTable.frame = CGRectMake(0, 60, 320, self.view.frame.size.height-110);
            
            //        label.font = [UIFont boldSystemFontOfSize:17];
            
            criticalfirstBtn.frame = CGRectMake(10, self.view.frame.size.height-45, 40, 40);
            criticalfirstBtn.layer.cornerRadius = 15.0f;
            criticalfirstBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            
            criticallastBtn.frame = CGRectMake(273, self.view.frame.size.height-45, 40, 40);
            criticallastBtn.layer.cornerRadius = 15.0f;
            criticallastBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            criticalpreviousButton.frame = CGRectMake(70, self.view.frame.size.height-45, 40, 40);
            criticalpreviousButton.layer.cornerRadius = 15.0f;
            criticalpreviousButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            criticalnextButton.frame = CGRectMake(210, self.view.frame.size.height-45, 40, 40);
            criticalnextButton.layer.cornerRadius = 15.0f;
            criticalnextButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            criticalrecStart1.frame = CGRectMake(122, self.view.frame.size.height-45, 20, 30);
            criticallabel11.frame = CGRectMake(140, self.view.frame.size.height-45, 20, 30);
            criticalrecEnd1.frame = CGRectMake(148, self.view.frame.size.height-45, 20, 30);
            criticallabel22.frame = CGRectMake(167, self.view.frame.size.height-45, 20, 30);
            criticaltotalRec1.frame = CGRectMake(183, self.view.frame.size.height-45, 20, 30);
            
            criticalrecStart1.font = [UIFont systemFontOfSize:14.0];
            criticallabel11.font = [UIFont systemFontOfSize:14.0];
            criticalrecEnd1.font = [UIFont systemFontOfSize:14.0];
            criticallabel22.font = [UIFont systemFontOfSize:14.0];
            criticaltotalRec1.font = [UIFont systemFontOfSize:14.0];
            
        }
        else{
            criticalstockTable.frame = CGRectMake(0, 40, 320, 330);
            
            //        label.font = [UIFont boldSystemFontOfSize:17];
            
            //            firstBtn.frame = CGRectMake(10, 375, 40, 40);
            //            firstBtn.layer.cornerRadius = 15.0f;
            //            firstBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            //
            //
            //            lastBtn.frame = CGRectMake(273, 375, 40, 40);
            //            lastBtn.layer.cornerRadius = 15.0f;
            //            lastBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            //
            //            previousButton.frame = CGRectMake(70, 375, 40, 40);
            //            previousButton.layer.cornerRadius = 15.0f;
            //            previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            //
            //            nextButton.frame = CGRectMake(210, 375, 40, 40);
            //            nextButton.layer.cornerRadius = 15.0f;
            //            nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            //
            //            recStart1.frame = CGRectMake(122, 375, 20, 30);
            //            label11.frame = CGRectMake(140, 375, 20, 30);
            //            recEnd1.frame = CGRectMake(148, 375, 20, 30);
            //            label22.frame = CGRectMake(167, 375, 20, 30);
            //            totalRec1.frame = CGRectMake(183, 375, 20, 30);
            //
            //            recStart1.font = [UIFont systemFontOfSize:14.0];
            //            label11.font = [UIFont systemFontOfSize:14.0];
            //            recEnd1.font = [UIFont systemFontOfSize:14.0];
            //            label22.font = [UIFont systemFontOfSize:14.0];
            //            totalRec1.font = [UIFont systemFontOfSize:14.0];
            
        }
        
    }
    
    //[topbar addSubview:img];
    //    [self.view addSubview:img];
    //    [self.view addSubview:label];
    //    [self.view addSubview:backbutton];
    [criticalStockView addSubview:criticalstockTable];
    [criticalStockView addSubview:criticalpreviousButton];
    [criticalStockView addSubview:criticalnextButton];
    [criticalStockView addSubview:criticalfirstBtn];
    [criticalStockView addSubview:criticallastBtn];
    [criticalStockView addSubview:criticallabel11];
    [criticalStockView  addSubview:criticallabel22];
    [criticalStockView addSubview:criticaltotalRec1];
    [criticalStockView addSubview:criticalrecStart1];
    [criticalStockView addSubview:criticalrecEnd1];
    //[criticalStockView addSubview:mainSegmentedControl];
    
    [normalStockView addSubview:normalstockTable];
    [normalStockView addSubview:normalpreviousButton];
    [normalStockView addSubview:normalnextButton];
    [normalStockView addSubview:normalfirstBtn];
    [normalStockView addSubview:normallastBtn];
    [normalStockView addSubview:normallabel11];
    [normalStockView addSubview:normallabel22];
    [normalStockView addSubview:normaltotalRec1];
    [normalStockView addSubview:normalrecStart1];
    [normalStockView addSubview:normalrecEnd1];
    [self.view addSubview:mainSegmentedControl];
    
    [self.view addSubview:criticalStockView];
    [self.view addSubview:normalStockView];
    
    // initalize the arrays ..
    nameArray_ = [[NSMutableArray alloc] init];
    descArray_ = [[NSMutableArray alloc] init];
    avaiArray_ = [[NSMutableArray alloc] init];
    unitArray_ = [[NSMutableArray alloc] init];
    reorArray_ = [[NSMutableArray alloc] init];
    skuIdArr_ = [[NSMutableArray alloc] init];
    colorArr_ = [[NSMutableArray alloc] init];
    sizeArr_ = [[NSMutableArray alloc] init];
    
    nameArray1 = [[NSMutableArray alloc] init];
    descArray1 = [[NSMutableArray alloc] init];
    avaiArray1 = [[NSMutableArray alloc] init];
    unitArray1 = [[NSMutableArray alloc] init];
    reorArray1 = [[NSMutableArray alloc] init];
    skuIdArr1 = [[NSMutableArray alloc] init];
    colorArr1 = [[NSMutableArray alloc] init];
    sizeArr1 = [[NSMutableArray alloc] init];
    skuStockId = [[NSMutableArray alloc] init];
    
    [self callRawMaterialsForNormalStock];
    [self callRawMaterialsForCriticalStock];

}

-(void) callRawMaterialsForNormalStock{
    
    RawMaterialServiceSoapBinding *materialBinding = [RawMaterialServiceSvc RawMaterialServiceSoapBinding];
    RawMaterialServiceSvc_getMaterialStockDetailsByStockType *aParams = [[RawMaterialServiceSvc_getMaterialStockDetailsByStockType alloc] init];
//    aParams.pageNumber = [NSString stringWithFormat:@"%d",changeNum13_n];
//    aParams.stockType = @"n";

    NSArray *headerKeys = @[@"userName", @"applicationName",@"password",@"dateTime",@"correlationId"];
    
    NSArray *headerObjects = @[@"",@"",@"",@"",@""];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSArray *loyaltyKeys = @[@"stockType", @"pageNumber",@"requestHeader"];
    
    NSArray *loyaltyObjects = @[@"n",[NSString stringWithFormat:@"%d",changeNum13_n],requestHeaderString];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    aParams.stockType = loyaltyString;
    
    RawMaterialServiceSoapBindingResponse *response = [materialBinding getMaterialStockDetailsByStockTypeUsingParameters:(RawMaterialServiceSvc_getMaterialStockDetailsByStockType *)aParams];
    NSArray *responseBodyParts = response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse class]]) {
            RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse *body = (RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse *)bodyPart;
            printf("\nresponse=%s",(body.return_).UTF8String);
            
            [self getStockDetailsByStockTypeHandler:body.return_];
        }
    }
    
}

-(void) callRawMaterialsForCriticalStock{
    
    RawMaterialServiceSoapBinding *materialBinding = [RawMaterialServiceSvc RawMaterialServiceSoapBinding];
    RawMaterialServiceSvc_getMaterialStockDetailsByStockType *aParams = [[RawMaterialServiceSvc_getMaterialStockDetailsByStockType alloc] init];
    
//    aParams.pageNumber = [NSString stringWithFormat:@"%d",changeNum14_n];
//    aParams.stockType = @"c";
    
    NSArray *headerKeys = @[@"userName", @"applicationName",@"password",@"dateTime",@"correlationId"];
    
    NSArray *headerObjects = @[@"",@"",@"",@"",@""];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSArray *loyaltyKeys = @[@"stockType", @"pageNumber",@"requestHeader"];
    
    NSArray *loyaltyObjects = @[@"c",[NSString stringWithFormat:@"%d",changeNum14_n],requestHeaderString];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    aParams.stockType = loyaltyString;
    
    RawMaterialServiceSoapBindingResponse *response = [materialBinding getMaterialStockDetailsByStockTypeUsingParameters:(RawMaterialServiceSvc_getMaterialStockDetailsByStockType *)aParams];
    NSArray *responseBodyParts = response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse class]]) {
            RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse *body = (RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse *)bodyPart;
            printf("\nresponse=%s",(body.return_).UTF8String);
            
            [self getStockDetailsByStockTypeHandler_:body.return_];
        }
    }
    
}

- (void) segmentAction1: (id) sender  {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    mainSegmentedControl = (UISegmentedControl *)sender;
    NSInteger index = mainSegmentedControl.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            normalStockView.hidden = NO;
            criticalStockView.hidden = YES;
            if (skuIdArr1.count == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Normal Stock Not Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                normalfirstBtn.enabled = NO;
                normallastBtn.enabled = NO;
                normalnextButton.enabled = NO;
                normalpreviousButton.enabled = NO;
                
                normalrecEnd1.text = @"0";
                normalrecStart1.text = @"0";
                normaltotalRec1.text = @"0";
            }
            break;
        case 1:
            normalStockView.hidden = YES;
            criticalStockView.hidden = NO;
            if (skuIdArr_.count == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Critical Stock Not Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                criticalfirstBtn.enabled = NO;
                criticallastBtn.enabled = NO;
                criticalnextButton.enabled = NO;
                criticalpreviousButton.enabled = NO;
                
                criticalrecEnd1.text = @"0";
                criticalrecStart1.text = @"0";
                criticaltotalRec1.text = @"0";
            }
            break;
        default:
            break;
    }
}


 //Handle the response from getStockDetailsByStockType.
- (void) getStockDetailsByStockTypeHandler: (NSString *) value {
    
    [HUD setHidden:YES];
    NSString *totalValue = @"";
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        //NSLog(@"%@", value);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Network error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    // Handle faults
//    if([value isKindOfClass:[SoapFault class]]) {
//        //NSLog(@"%@", value);
//        return;
//    }
    
    
    if (value.length > 0) {
        NSError *e;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [value dataUsingEncoding:NSUTF8StringEncoding]
                                                             options: NSJSONReadingMutableContainers
                                                               error: &e];
        NSArray *temp = JSON[@"record"];
        if (temp.count == 0) {
            totalValue = @"0";
        }else{
            NSDictionary *JSON1 = temp[0];
            totalValue = [NSString stringWithFormat:@"%@",JSON1[@"skuId"]];
        }

        normalrecStart1.text = [NSString stringWithFormat:@"%d",(changeNum13_n * 10) + 1];
        normalrecEnd1.text = [NSString stringWithFormat:@"%d",(normalrecStart1.text).intValue + 9];
        normaltotalRec1.text = [NSString stringWithFormat:@"%@",totalValue];
        
        if (totalValue.intValue <= 10) {
            normalrecEnd1.text = [NSString stringWithFormat:@"%d",(normaltotalRec1.text).intValue];
            normalnextButton.enabled =  NO;
            normalpreviousButton.enabled = NO;
            normalfirstBtn.enabled = NO;
            normallastBtn.enabled = NO;
        }
        else{
            
            if (changeNum13_n == 0) {
                normalpreviousButton.enabled = NO;
                normalfirstBtn.enabled = NO;
                normalnextButton.enabled = YES;
                normallastBtn.enabled = YES;
            }
            else if ((totalValue.intValue - (10 * (changeNum13_n+1))) <= 0) {
                
                normalnextButton.enabled = NO;
                normallastBtn.enabled = NO;
                normalrecEnd1.text = normaltotalRec1.text;
            }
        }
        
        
        //[temp removeObjectAtIndex:0];
        
        cellcount_n = 0;
       
//        NSArray *temp2;
//        for (int i = 0; i < [temp count]; i++) {
//           temp2 = [[temp objectAtIndex:i] componentsSeparatedByString:@"!"];
//            //cellcount = [temp2 count];
//            [temp2 removeObjectAtIndex:0];
            [HUD setHidden:NO];
            
            // Create the service
//            SDZSkuService* service = [SDZSkuService service];
//            service.logging = YES;
        NSArray *temp3 = JSON[@"quantityInHand"];
        NSArray *temp1 = JSON[@"skuId"];;
        NSArray *temp2 = JSON[@"reorderQuantity"];;
        for (int i=0; i<temp3.count; i++) {
            @try {
                NSDictionary *JSON = temp3[i];
                NSDictionary *JSON1 = temp1[i];
                NSDictionary *JSON2 = temp2[i];
                
                [skuIdArr1 addObject:JSON1[@"skuId"]];
                [skuStockId addObject:JSON1[@"skuId"]];
                [avaiArray1 addObject: JSON[@"skuId"]];
                [reorArray1 addObject:JSON2[@"skuId"]];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
        }
                    // Returns NSString*.
        
                    //changed by sonali....
//                    [service getSkuDetailsForStocks:self action:@selector(getSkuDetailsHandler:) skuID: [temp3 objectAtIndex:0]];
            
            for (int i=0; i<skuIdArr1.count; i++) {
                
//                    SkuSoapBinding *service =  [[SkuService SkuSoapBinding] retain];
//                    
//                    SkuService_getSkuDetailsForStocks *parameters = [[SkuService_getSkuDetailsForStocks alloc] init];
//                    
//                    parameters.skuID = [skuIDArray objectAtIndex:i];
//                    
//                    SkuSoapBindingResponse *response;
//                    response = [service getSkuDetailsForStocksUsingParameters:parameters];
//                    
//                    NSArray *responsebody = response.bodyParts;
//                    NSString *result;
//                    for (id bodyPart in responsebody) {
//                        
//                        if ([bodyPart isKindOfClass:[SkuService_getSkuDetailsForStocksResponse class]]) {
//                            
//                            SkuService_getSkuDetailsForStocksResponse *body = (SkuService_getSkuDetailsForStocksResponse *)bodyPart;
//                            result = body.getSkuDetailsForStocksReturn;
//                            [self getSkuDetailsHandler:result];
//                        }
//                    }
                
                RawMaterialServiceSoapBinding *materialBinding = [RawMaterialServiceSvc RawMaterialServiceSoapBinding];
                RawMaterialServiceSvc_getSkuDetailsForMaterialStock *aParams = [[RawMaterialServiceSvc_getSkuDetailsForMaterialStock alloc] init];
                NSArray *headerKeys = @[@"userName", @"applicationName",@"password",@"dateTime",@"correlationId"];
                
                NSArray *headerObjects = @[@"",@"",@"",@"",@""];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
                
                NSError * err;
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
                NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                
                NSArray *loyaltyKeys = @[@"skuId",@"requestHeader"];
                
                NSArray *loyaltyObjects = @[skuIdArr1[i],requestHeaderString];
                NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
                
                NSError * err_;
                NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
                NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
                aParams.skuID = loyaltyString;
                
                RawMaterialServiceSoapBindingResponse *response = [materialBinding getSkuDetailsForMaterialStockUsingParameters:(RawMaterialServiceSvc_getSkuDetailsForMaterialStock *)aParams];
                NSArray *responseBodyParts = response.bodyParts;
                
                for (id bodyPart in responseBodyParts) {
                    if ([bodyPart isKindOfClass:[RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse class]]) {
                        RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse *body = (RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse *)bodyPart;
                        printf("\nresponse=%s",(body.return_).UTF8String);
                        
                        [self getSkuDetailsHandler:body.return_];
                    }
                }

              }
            
//        }
        
//         cellcount = [temp2 count];
    }
    else{
        
        normalfirstBtn.enabled = NO;
        normallastBtn.enabled = NO;
        normalnextButton.enabled = NO;
        normalpreviousButton.enabled = NO;
        normalrecStart1.text  = @"0";
        normalrecEnd1.text  = @"0";
        normaltotalRec1.text  = @"0";
    }
}



// Handle the response from getSkuDetails.

- (void) getSkuDetailsHandler: (NSString *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        //NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
//    if([value isKindOfClass:[SoapFault class]]) {
//        //NSLog(@"%@", value);
//        return;
//    }
    
    if (value.length > 0) {
        NSString* result = (NSString*)value;
        NSError *e;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                             options: NSJSONReadingMutableContainers
                                                               error: &e];
        NSArray *temp = JSON[@"productName"];
        NSArray *temp1 = JSON[@"color"];
        NSArray *temp2 = JSON[@"description"];
        NSArray *temp3 = JSON[@"unitPrice"];
        NSArray *temp4 = JSON[@"quantity"];
        NSArray *temp5 = JSON[@"size"];
        for (int i = 0; i < temp.count; i++) {
            NSDictionary *JSON1 = temp[i];
            NSDictionary *JSON2 = temp1[i];
            NSDictionary *JSON3 = temp2[i];
            NSDictionary *JSON4 = temp3[i];
            NSDictionary *JSON5 = temp4[i];
            NSDictionary *JSON6 = temp5[i];
            [nameArray1 addObject:JSON1[@"skuId"]];
            [descArray1 addObject:JSON3[@"skuId"]];
            [unitArray1 addObject:JSON4[@"skuId"]];
            //            if ([[temp objectAtIndex:4] isEqualToString:@""] || [[temp objectAtIndex:4] isEqualToString:@"-"] || [[temp objectAtIndex:4] caseInsensitiveCompare:@"null"] == NSOrderedSame) {
            //                [colorArr1 addObject:@"NA"];
            //            }
            //            else {
            [colorArr1 addObject:JSON2[@"skuId"]];
            //            }
            //            if ([[temp objectAtIndex:5] isEqualToString:@""] || [[temp objectAtIndex:5] isEqualToString:@"-"] || [[temp objectAtIndex:5] caseInsensitiveCompare:@"null"] == NSOrderedSame) {
            //
            //                [sizeArr1 addObject:@"NA"];
            //            }
            //            else {
            [sizeArr1 addObject:JSON6[@"skuId"]];
            //            }

        }
        

    }
    else{
        
        [HUD setHidden:YES];
        [nameArray1 addObject:@"-"];
        [descArray1 addObject:@"-"];
        [unitArray1 addObject:@"-"];
        [colorArr1 addObject:@"-"];
        [sizeArr1 addObject:@"-"];
        
    }
    if (reorArray1.count == nameArray1.count) {
        
        cellcount_n = reorArray1.count;
        
        [normalstockTable reloadData];
        [HUD setHidden:YES];
        normalnextButton.enabled =  YES;
        normallastBtn.enabled = YES;
        //nextButton.backgroundColor = [UIColor grayColor];
        if ([normalrecEnd1.text isEqualToString:normaltotalRec1.text]) {
            normalnextButton.enabled =  NO;
            normallastBtn.enabled = NO;
            //nextButton.backgroundColor = [UIColor lightGrayColor];
        }
    }
}

//Handle the response from getStockDetailsByStockType.
- (void) getStockDetailsByStockTypeHandler_: (NSString *) value {
    
    [HUD setHidden:YES];
    NSString *totalValue = @"";
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        //NSLog(@"%@", value);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Network error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    // Handle faults
//    if([value isKindOfClass:[SoapFault class]]) {
//        //NSLog(@"%@", value);
//        return;
//    }
    
    
    if (value.length > 0) {
        NSError *e;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [value dataUsingEncoding:NSUTF8StringEncoding]
                                                             options: NSJSONReadingMutableContainers
                                                               error: &e];
        NSArray *temp = JSON[@"record"];
        if (temp.count == 0) {
            totalValue = @"0";
        }else{
            NSDictionary *JSON1 = temp[0];
            totalValue = [NSString stringWithFormat:@"%@",JSON1[@"skuId"]];
        }
        
        
        criticalrecStart1.text = [NSString stringWithFormat:@"%d",(changeNum14_n * 10) + 1];
        criticalrecEnd1.text = [NSString stringWithFormat:@"%d",(criticalrecStart1.text).intValue + 9];
        criticaltotalRec1.text = [NSString stringWithFormat:@"%@",totalValue];
        
        if (totalValue.intValue <= 10) {
            criticalrecEnd1.text = [NSString stringWithFormat:@"%d",(criticaltotalRec1.text).intValue];
            criticalnextButton.enabled =  NO;
            criticalpreviousButton.enabled = NO;
            criticalfirstBtn.enabled = NO;
            criticallastBtn.enabled = NO;
        }
        else{
            
            if (changeNum14_n == 0) {
                criticalpreviousButton.enabled = NO;
                criticalfirstBtn.enabled = NO;
                criticalnextButton.enabled = YES;
                criticallastBtn.enabled = YES;
            }
            else if ((totalValue.intValue - (10 * (changeNum13_n+1))) <= 0) {
                
                criticalnextButton.enabled = NO;
                criticallastBtn.enabled = NO;
                criticalrecEnd1.text = normaltotalRec1.text;
            }
        }
        
        
        //[temp removeObjectAtIndex:0];
        
        cellcount1_n = 0;
        
//        NSArray *temp2;
//        for (int i = 0; i < [temp count]; i++) {
//            temp2 = [[temp objectAtIndex:i] componentsSeparatedByString:@"!"];
//            //cellcount = [temp2 count];
//            [temp2 removeObjectAtIndex:0];
            [HUD setHidden:NO];
            
            // Create the service
            //            SDZSkuService* service = [SDZSkuService service];
            //            service.logging = YES;
            
        NSArray *temp3 = JSON[@"quantityInHand"];
        NSArray *temp1 = JSON[@"skuId"];;
        NSArray *temp2 = JSON[@"reorderQuantity"];;
            for (int i=0; i<temp3.count; i++) {
                @try {
                    NSDictionary *JSON = temp3[i];
                    NSDictionary *JSON1 = temp1[i];
                    NSDictionary *JSON2 = temp2[i];
                    
                    [skuIdArr_ addObject:JSON1[@"skuId"]];
                    [skuStockId addObject:JSON1[@"skuId"]];
                    [avaiArray_ addObject: JSON[@"skuId"]];
                    [reorArray_ addObject:JSON2[@"skuId"]];
                }
                @catch (NSException *exception) {
                    NSLog(@"%@",exception);
                }
            }
            // Returns NSString*.
            
            //changed by sonali....
            //                    [service getSkuDetailsForStocks:self action:@selector(getSkuDetailsHandler:) skuID: [temp3 objectAtIndex:0]];
            
            for (int i=0; i<skuIdArr_.count; i++) {
                
                //                    SkuSoapBinding *service =  [[SkuService SkuSoapBinding] retain];
                //
                //                    SkuService_getSkuDetailsForStocks *parameters = [[SkuService_getSkuDetailsForStocks alloc] init];
                //
                //                    parameters.skuID = [skuIDArray objectAtIndex:i];
                //
                //                    SkuSoapBindingResponse *response;
                //                    response = [service getSkuDetailsForStocksUsingParameters:parameters];
                //
                //                    NSArray *responsebody = response.bodyParts;
                //                    NSString *result;
                //                    for (id bodyPart in responsebody) {
                //
                //                        if ([bodyPart isKindOfClass:[SkuService_getSkuDetailsForStocksResponse class]]) {
                //
                //                            SkuService_getSkuDetailsForStocksResponse *body = (SkuService_getSkuDetailsForStocksResponse *)bodyPart;
                //                            result = body.getSkuDetailsForStocksReturn;
                //                            [self getSkuDetailsHandler:result];
                //                        }
                //                    }
                
                RawMaterialServiceSoapBinding *materialBinding = [RawMaterialServiceSvc RawMaterialServiceSoapBinding];
                RawMaterialServiceSvc_getSkuDetailsForMaterialStock *aParams = [[RawMaterialServiceSvc_getSkuDetailsForMaterialStock alloc] init];
                NSArray *headerKeys = @[@"userName", @"applicationName",@"password",@"dateTime",@"correlationId"];
                
                NSArray *headerObjects = @[@"",@"",@"",@"",@""];
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
                
                NSError * err;
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
                NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                
                NSArray *loyaltyKeys = @[@"skuId",@"requestHeader"];
                
                NSArray *loyaltyObjects = @[skuIdArr_[i],requestHeaderString];
                NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
                
                NSError * err_;
                NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
                NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
                aParams.skuID = loyaltyString;
                
                RawMaterialServiceSoapBindingResponse *response = [materialBinding getSkuDetailsForMaterialStockUsingParameters:(RawMaterialServiceSvc_getSkuDetailsForMaterialStock *)aParams];
                NSArray *responseBodyParts = response.bodyParts;
                
                for (id bodyPart in responseBodyParts) {
                    if ([bodyPart isKindOfClass:[RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse class]]) {
                        RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse *body = (RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse *)bodyPart;
                        printf("\nresponse=%s",(body.return_).UTF8String);
                        
                        [self getSkuDetailsHandler_:body.return_];
                    }
                }
                
            }
            
//        }
        
        //         cellcount = [temp2 count];
    }
    else{
        
        criticalfirstBtn.enabled = NO;
        criticallastBtn.enabled = NO;
        criticalnextButton.enabled = NO;
        criticalpreviousButton.enabled = NO;
        criticalrecStart1.text  = @"0";
        criticalrecEnd1.text  = @"0";
        criticaltotalRec1.text  = @"0";
    }
}



// Handle the response from getSkuDetails.

- (void) getSkuDetailsHandler_: (NSString *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        //NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
//    if([value isKindOfClass:[SoapFault class]]) {
//        //NSLog(@"%@", value);
//        return;
//    }
    
    if (value.length > 0) {
        NSString* result = (NSString*)value;
        NSError *e;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                             options: NSJSONReadingMutableContainers
                                                               error: &e];
        NSArray *temp = JSON[@"productName"];
        NSArray *temp1 = JSON[@"color"];
        NSArray *temp2 = JSON[@"description"];
        NSArray *temp3 = JSON[@"unitPrice"];
        NSArray *temp4 = JSON[@"quantity"];
        NSArray *temp5 = JSON[@"size"];

        for (int i = 0; i < temp.count; i++) {
            NSDictionary *JSON1 = temp[i];
            NSDictionary *JSON2 = temp1[i];
            NSDictionary *JSON3 = temp2[i];
            NSDictionary *JSON4 = temp3[i];
            NSDictionary *JSON5 = temp4[i];
            NSDictionary *JSON6 = temp5[i];
            
            [nameArray_ addObject:JSON1[@"skuId"]];
            [descArray_ addObject:JSON3[@"skuId"]];
            [unitArray_ addObject:JSON4[@"skuId"]];
            //            if ([[temp objectAtIndex:4] isEqualToString:@""] || [[temp objectAtIndex:4] isEqualToString:@"-"] || [[temp objectAtIndex:4] caseInsensitiveCompare:@"null"] == NSOrderedSame) {
            //                [colorArr1 addObject:@"NA"];
            //            }
            //            else {
            [colorArr_ addObject:JSON2[@"skuId"]];
            //            }
            //            if ([[temp objectAtIndex:5] isEqualToString:@""] || [[temp objectAtIndex:5] isEqualToString:@"-"] || [[temp objectAtIndex:5] caseInsensitiveCompare:@"null"] == NSOrderedSame) {
            //
            //                [sizeArr1 addObject:@"NA"];
            //            }
            //            else {
            [sizeArr_ addObject:JSON6[@"skuId"]];
        }
//        [nameArray_ addObject:[temp objectAtIndex:0]];
//        [descArray_ addObject:[temp objectAtIndex:1]];
//        [unitArray_ addObject:[temp objectAtIndex:3]];
//        if ([[temp objectAtIndex:4] isEqualToString:@""] || [[temp objectAtIndex:4] isEqualToString:@"-"] || [[temp objectAtIndex:4] caseInsensitiveCompare:@"null"] == NSOrderedSame) {
//            [colorArr_ addObject:@"NA"];
//        }
//        else {
//            [colorArr_ addObject:[temp objectAtIndex:4]];
//        }
//        if ([[temp objectAtIndex:5] isEqualToString:@""] || [[temp objectAtIndex:5] isEqualToString:@"-"] || [[temp objectAtIndex:5] caseInsensitiveCompare:@"null"] == NSOrderedSame) {
//            
//            [sizeArr_ addObject:@"NA"];
//        }
//        else {
//            [sizeArr_ addObject:[temp objectAtIndex:5]];
//        }
        
        
    }
    else{
        
        [HUD setHidden:YES];
        [nameArray_ addObject:@"-"];
        [descArray_ addObject:@"-"];
        [unitArray_ addObject:@"-"];
        [colorArr_ addObject:@"-"];
        [sizeArr_ addObject:@"-"];
        
    }
    if (reorArray_.count == nameArray_.count) {
        
        cellcount1_n = reorArray_.count;
        
        [criticalstockTable reloadData];
        [HUD setHidden:YES];
        criticalnextButton.enabled =  YES;
        criticallastBtn.enabled = YES;
        //nextButton.backgroundColor = [UIColor grayColor];
        if ([criticalrecEnd1.text isEqualToString:criticaltotalRec1.text]) {
            criticalnextButton.enabled =  NO;
            criticallastBtn.enabled = NO;
            //nextButton.backgroundColor = [UIColor lightGrayColor];
        }
    }
}


// first button pressed...
-(void) firstButtonPressed:(UIButton *) sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender == criticalfirstBtn) {
        [skuIdArr_ removeAllObjects];
        [reorArray_ removeAllObjects];
        [avaiArray_ removeAllObjects];
        [nameArray_ removeAllObjects];
        [sizeArr_ removeAllObjects];
        [descArray_ removeAllObjects];
        [unitArray_ removeAllObjects];
        [colorArr_ removeAllObjects];
        
        changeNum14_n = 0;
        //    cellcount = 10;
        
        //[HUD setHidden:NO];
        [HUD show:YES];
        [self callRawMaterialsForCriticalStock];
    }
    else if (sender == normalfirstBtn){
        [skuIdArr1 removeAllObjects];
        [reorArray1 removeAllObjects];
        [avaiArray1 removeAllObjects];
        [nameArray1 removeAllObjects];
        [sizeArr1 removeAllObjects];
        [descArray1 removeAllObjects];
        [unitArray1 removeAllObjects];
        [colorArr1 removeAllObjects];
        
        changeNum13_n = 0;
        //    cellcount = 10;
        
        //[HUD setHidden:NO];
        [HUD show:YES];
        [self callRawMaterialsForNormalStock];
    }
    
}
// last button pressed....
-(void) lastButtonPressed:(UIButton *) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender == criticallastBtn) {
        [skuIdArr_ removeAllObjects];
        [reorArray_ removeAllObjects];
        [avaiArray_ removeAllObjects];
        [nameArray_ removeAllObjects];
        [sizeArr_ removeAllObjects];
        [descArray_ removeAllObjects];
        [unitArray_ removeAllObjects];
        [colorArr_ removeAllObjects];
        
        //float a = [rec_total.text intValue]/5;
        //float t = ([rec_total.text floatValue]/5);
        
        if ((criticaltotalRec1.text).intValue/10 == ((criticaltotalRec1.text).floatValue/10)) {
            
            changeNum14_n = (criticaltotalRec1.text).intValue/10 - 1;
        }
        else{
            changeNum14_n =(criticaltotalRec1.text).intValue/10;
        }
        //changeID = ([rec_total.text intValue]/5) - 1;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        criticalpreviousButton.enabled = YES;
        
        
        //frstButton.backgroundColor = [UIColor grayColor];
        criticalfirstBtn.enabled = YES;
        
        //[HUD setHidden:NO];
        [HUD show:YES];
        [self callRawMaterialsForCriticalStock];
    }
    else if (sender == normallastBtn){
        [skuIdArr1 removeAllObjects];
        [reorArray1 removeAllObjects];
        [avaiArray1 removeAllObjects];
        [nameArray1 removeAllObjects];
        [sizeArr1 removeAllObjects];
        [descArray1 removeAllObjects];
        [unitArray1 removeAllObjects];
        [colorArr1 removeAllObjects];
        
        if ((normaltotalRec1.text).intValue/10 == ((normaltotalRec1.text).floatValue/10)) {
            
            changeNum13_n = (normaltotalRec1.text).intValue/10 - 1;
        }
        else{
            changeNum13_n =(normaltotalRec1.text).intValue/10;
        }
        //changeID = ([rec_total.text intValue]/5) - 1;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        normalpreviousButton.enabled = YES;
        
        
        //frstButton.backgroundColor = [UIColor grayColor];
        normalfirstBtn.enabled = YES;
        normalnextButton.enabled = NO;
        
        //[HUD setHidden:NO];
        [HUD show:YES];
        [self callRawMaterialsForNormalStock];
    }
    
}
// previousButtonPressed handing...
- (void) previousButtonPressed:(UIButton *) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender == criticalpreviousButton) {
        [skuIdArr_ removeAllObjects];
        [reorArray_ removeAllObjects];
        [avaiArray_ removeAllObjects];
        [nameArray_ removeAllObjects];
        [sizeArr_ removeAllObjects];
        [descArray_ removeAllObjects];
        [unitArray_ removeAllObjects];
        [colorArr_ removeAllObjects];
        
        if (changeNum14_n > 0){
            
            changeNum14_n--;
            
            [self callRawMaterialsForCriticalStock];
            
            if ([criticalrecEnd1.text isEqualToString:criticaltotalRec1.text]) {
                
                criticallastBtn.enabled = NO;
            }
            else {
                criticallastBtn.enabled = YES;
            }
            [HUD setHidden:NO];
            [HUD setHidden:YES];
        }
        else{
            //previousButton.backgroundColor = [UIColor lightGrayColor];
            criticalpreviousButton.enabled =  NO;
            
            //nextButton.backgroundColor = [UIColor grayColor];
            criticalnextButton.enabled =  YES;
        }
        
    }
    else if (sender == normalpreviousButton){
        [skuIdArr1 removeAllObjects];
        [reorArray1 removeAllObjects];
        [avaiArray1 removeAllObjects];
        [nameArray1 removeAllObjects];
        [sizeArr1 removeAllObjects];
        [descArray1 removeAllObjects];
        [unitArray1 removeAllObjects];
        [colorArr1 removeAllObjects];
        
        if (changeNum13_n > 0){
            
            changeNum13_n--;
            //        cellcount = [nameArray count];
            //
            //        //nextButton.backgroundColor = [UIColor grayColor];
            //        nextButton.enabled =  YES;
            //        firstButton.enabled = YES;
            //        lastButton.enabled = YES;
            //        NSLog(@"%@  %@",[recStart text],[recEnd text]);
            //        int start;
            //        int end;
            //        start = [[recStart text] intValue]-10;
            //        end =  [[recEnd text] intValue]-9;
            //        recStart.text = [NSString stringWithFormat:@"%d",start];
            //        recEnd.text = [NSString stringWithFormat:@"%d",end];
            //
            //        if (start == 1) {
            //
            //            firstButton.enabled = NO;
            //            previousButton.enabled = NO;
            //        }
            
            [self callRawMaterialsForNormalStock];
            
            if ([normalrecEnd1.text isEqualToString:normaltotalRec1.text]) {
                
                normallastBtn.enabled = NO;
            }
            else {
                normallastBtn.enabled = YES;
            }
            [HUD setHidden:NO];
            //[normalstockTable reloadData];
            [HUD setHidden:YES];
        }
        else{
            //previousButton.backgroundColor = [UIColor lightGrayColor];
            normalpreviousButton.enabled =  NO;
            
            //nextButton.backgroundColor = [UIColor grayColor];
            normalnextButton.enabled =  YES;
        }
        
    }
    
}

// NextButtonPressed handing...

- (void) nextButtonPressed:(UIButton *) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender == criticalnextButton) {
        //previousButton.backgroundColor = [UIColor grayColor];
        criticalpreviousButton.enabled =  YES;
        
        changeNum14_n++;
        
        [skuIdArr_ removeAllObjects];
        [reorArray_ removeAllObjects];
        [avaiArray_ removeAllObjects];
        [nameArray_ removeAllObjects];
        [sizeArr_ removeAllObjects];
        [descArray_ removeAllObjects];
        [unitArray_ removeAllObjects];
        [colorArr_ removeAllObjects];
        
        
        [HUD setHidden:NO];
        
        criticalnextButton.enabled =  NO;
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        
        // Getting the required from webServices ..
        // Create the service
        [self callRawMaterialsForCriticalStock];
    }
    else if (sender == normalnextButton){
        //previousButton.backgroundColor = [UIColor grayColor];
        normalpreviousButton.enabled =  YES;
        
   changeNum13_n++;
        
        [skuIdArr1 removeAllObjects];
        [reorArray1 removeAllObjects];
        [avaiArray1 removeAllObjects];
        [nameArray1 removeAllObjects];
        [sizeArr1 removeAllObjects];
        [descArray1 removeAllObjects];
        [unitArray1 removeAllObjects];
        [colorArr1 removeAllObjects];
        
        
        
        [HUD setHidden:NO];
        normalnextButton.enabled =  NO;
        normalfirstBtn.enabled = YES;
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        
        // pageNo = changeNum13;
        [self callRawMaterialsForNormalStock];
        
    }
    
}



#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (criticalSearching)
        return criticalListOfItems.count;
    //copyItems
    if (normalSearching) {
        return normalCopyListOfItems.count;
    }
    else if(tableView == criticalstockTable){
        //return [nameArray count];
        return cellcount1_n;
    }
    else{
        return cellcount_n;
    }
}


//heigth for tableviewcell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 150.0;
    }
    else {
        return 150.0;
    }
}

//modified by sonali.....

// Customize the appearance of table view cells.
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"TableView";
    
    CellView_Stock *cell = (CellView_Stock *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
    
    if(cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CellView_Stock" owner:self options:nil];
        cell = stockCellView;
    }
    cell.backgroundColor = [UIColor blackColor];
    if(criticalSearching)
    {
        
        int x = [criticalListOfItems[indexPath.row] intValue];
        
        NSString *rownum = [NSString stringWithFormat:@"%d. ", indexPath.row + 1];
        
        NSString *itemNameString = [NSString stringWithFormat:@"%@%@", rownum, nameArray_[x]];
        
        //        [cell setItemProperties:itemNameString _itemDesc:[descArray objectAtIndex:x] _itemAvail:[unitArray objectAtIndex:x] _itemprice:[[avaiArray objectAtIndex:x] floatValue]/1000.0 _itemReorder:[reorArray objectAtIndex:x]];
        [cell setItemProperties:itemNameString _itemDesc:descArray_[x] _itemAvail:unitArray_[x] _itemprice:[avaiArray_[x] floatValue]/1000.0 _itemReorder:reorArray_[x]_color:colorArr_[x] _size:sizeArr_[x]];
    }
    else if(normalSearching)
    {
        
        int x = [normalCopyListOfItems[indexPath.row] intValue];
        
        NSString *rownum = [NSString stringWithFormat:@"%d. ", indexPath.row + 1];
        
        NSString *itemNameString = [NSString stringWithFormat:@"%@%@", rownum, nameArray1[x]];
        
        [cell setItemProperties:itemNameString _itemDesc:descArray1[x] _itemAvail:unitArray1[x] _itemprice:[avaiArray1[x] floatValue]/1000.0 _itemReorder:reorArray1[x]_color:colorArr1[x] _size:sizeArr1[x]];
    }
    else if(tableView == criticalstockTable) {
        
        NSString *rownum1 = [NSString stringWithFormat:@"%d. ", indexPath.row + 1 + (changeNum14_n*10)];
        // NSString *rownum = [NSString stringWithFormat:@"%d ", indexPath.row + 1 + (changeNum14*10)];
        
        NSString *itemNameString = [NSString stringWithFormat:@"%@%@", rownum1, nameArray_[indexPath.row]];
        
        //        [cell setItemProperties:itemNameString _itemDesc:[descArray objectAtIndex:[rownum intValue]-1] _itemAvail:[unitArray objectAtIndex:[rownum intValue]-1] _itemprice:[[avaiArray objectAtIndex:[rownum intValue]-1] floatValue]/1000.0 _itemReorder:[reorArray objectAtIndex:[rownum intValue]-1]];
        
        [cell setItemProperties:itemNameString _itemDesc:descArray_[indexPath.row] _itemAvail:unitArray_[indexPath.row] _itemprice:[avaiArray_[indexPath.row] floatValue]/1000.0 _itemReorder:reorArray_[indexPath.row]_color:colorArr_[indexPath.row] _size:sizeArr_[indexPath.row]];
        
        criticalstockTable.scrollEnabled = YES;
        criticalstockTable.allowsSelection = YES;
    }
    else if (tableView == normalstockTable){
        NSString *rownum1 = [NSString stringWithFormat:@"%d. ", indexPath.row + 1 + (changeNum13_n*10)];
        // NSString *rownum = [NSString stringWithFormat:@"%d ", indexPath.row + 1 + (changeNum13*10)];
        NSString *itemNameString = [NSString stringWithFormat:@"%@%@", rownum1, nameArray1[indexPath.row]];
        
        //        [cell setItemProperties:itemNameString _itemDesc:[descArray objectAtIndex:[rownum intValue]-1] _itemAvail:[unitArray objectAtIndex:[rownum intValue]-1] _itemprice:[[avaiArray objectAtIndex:[rownum intValue]-1] floatValue]/1000.0 _itemReorder:[reorArray objectAtIndex:[rownum intValue]-1]_color:[colorArray objectAtIndex:[rownum intValue]-1] _size:[sizeArray objectAtIndex:[rownum intValue]-1]];
        [cell setItemProperties:itemNameString _itemDesc:descArray1[indexPath.row] _itemAvail:unitArray1[indexPath.row] _itemprice:[avaiArray1[indexPath.row] floatValue]/1000.0 _itemReorder:reorArray1[indexPath.row]_color:colorArr1[indexPath.row] _size:sizeArr1[indexPath.row]];
        
        normalstockTable.scrollEnabled = YES;
        normalstockTable.allowsSelection = YES;
    }
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor blackColor];
    }
    else{
        cell.contentView.backgroundColor = [UIColor blackColor];
    }
    
    return cell;
    
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [cell setBackgroundColor:[UIColor clearColor]];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    // cell background color...
    
    //NSString *rownum = [NSString stringWithFormat:@"%d ", indexPath.row + 1 + (changeNum13_n*10)];
    
    //NSLog(@"%@",[skuStockId objectAtIndex:[rownum intValue]-1]);
    
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
//    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
//    
//    StockDetails *bh = [[[StockDetails alloc] initWithSkuId:[skuStockId objectAtIndex:[rownum intValue]-1]] autorelease];
//    [self.navigationController pushViewController:bh animated:YES];

    
}


#pragma mark -
#pragma mark Search Bar

- (void)updateSearchString:(NSString*)aSearchString tableType:(NSString *)tableType
{
    if ([tableType isEqualToString:@"critical"]) {
        criticalSearchString = [[NSString alloc]initWithString:aSearchString];
        [criticalstockTable reloadData];
        [criticalStockSearchBar resignFirstResponder];
    }
    else if ([tableType isEqualToString:@"normal"]){
        normalSearchString = [[NSString alloc]initWithString:aSearchString];
        [normalstockTable reloadData];
        [normalStockSearchBar resignFirstResponder];
    }
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBarItem
{
    if (searchBarItem == criticalStockSearchBar) {
        [searchBarItem setShowsCancelButton:YES animated:YES];
        criticalstockTable.allowsSelection = NO;
        criticalstockTable.scrollEnabled = NO;
    }
    else if (searchBarItem == normalStockSearchBar){
        [searchBarItem setShowsCancelButton:YES animated:YES];
        normalstockTable.allowsSelection = NO;
        normalstockTable.scrollEnabled = NO;
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBarItem
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (searchBarItem == criticalStockSearchBar) {
        [searchBarItem setShowsCancelButton:NO animated:YES];
        [searchBarItem resignFirstResponder];
        criticalstockTable.allowsSelection = YES;
        criticalstockTable.scrollEnabled = YES;
        searchBarItem.text=@"";
        [self updateSearchString:criticalStockSearchBar.text tableType:@"critical"];
    }
    else if (searchBarItem == normalStockSearchBar){
        [searchBarItem setShowsCancelButton:NO animated:YES];
        [searchBarItem resignFirstResponder];
        normalstockTable.allowsSelection = YES;
        normalstockTable.scrollEnabled = YES;
        searchBarItem.text=@"";
        [self updateSearchString:normalStockSearchBar.text tableType:@"normal"];
    }
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
    //Remove all objects first.
    
    [criticalListOfItems removeAllObjects];
    [normalCopyListOfItems removeAllObjects];
    
    if (theSearchBar == criticalStockSearchBar) {
        if(searchText.length > 0) {
            criticalSearching = YES;
            criticalLetUserSelectRow = YES;
            criticalstockTable.scrollEnabled = YES;
            [self searchTableView:@"critical"];
        }
        else {
            
            criticalSearching = NO;
            criticalLetUserSelectRow = NO;
            criticalstockTable.scrollEnabled = NO;
        }
        if (criticalListOfItems.count <= 10) {
            criticallastBtn.enabled = NO;
            criticalnextButton.enabled = NO;
            if (criticalListOfItems.count == 0){
                criticallastBtn.enabled = YES;
                criticalnextButton.enabled = YES;
            }
        }

        [criticalstockTable reloadData];
    }
    else if (theSearchBar == normalStockSearchBar){
        if(searchText.length > 0) {
            normalSearching = YES;
            normalLetUserSelectRow = YES;
            normalstockTable.scrollEnabled = YES;
            [self searchTableView:@"normal"];
        }
        else {
            
            normalSearching = NO;
            normalLetUserSelectRow = NO;
            normalstockTable.scrollEnabled = NO;
        }
        if (normalCopyListOfItems.count <= 10) {
            normallastBtn.enabled = NO;
            normalnextButton.enabled = NO;
            if (normalCopyListOfItems.count == 0){
                normallastBtn.enabled = YES;
                normalnextButton.enabled = YES;
            }
        }

        
        [normalstockTable reloadData];
    }
    
}


//SearcBarButtonClick
- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    if (theSearchBar == criticalStockSearchBar) {
        criticalstockTable.allowsSelection = YES;
        criticalstockTable.scrollEnabled = YES;
        [self updateSearchString:criticalStockSearchBar.text tableType:@"critical"];
        [self searchTableView:@"critical"];
    }
    else if (theSearchBar == normalStockSearchBar){
        normalstockTable.allowsSelection = YES;
        normalstockTable.scrollEnabled = YES;
        [self updateSearchString:normalStockSearchBar.text tableType:@"normal"];
        [self searchTableView:@"normal"];
    }
}


//Displayt SearchView
- (void) searchTableView:(NSString *)tableType {
    
    if ([tableType isEqualToString:@"critical"]) {
        NSString *searchText = criticalStockSearchBar.text;
        
        for (int j = 0; j < 5; j++) {
            
            for ( int i=0; i<nameArray_.count; i++ ){
                
                if (![criticalListOfItems containsObject:@(i)]) {
                    
                    NSString * tryString;
                    if (j == 0) {
                        tryString = [nameArray_[i] description];
                    }
                    else if (j == 1) {
                        tryString = [descArray_[i] description];
                    }
                    else if (j == 2) {
                        tryString = [avaiArray_[i] description];
                    }
                    else if (j == 3) {
                        tryString = [unitArray_[i] description];
                    }
                    else {
                        tryString = [reorArray_[i] description];
                    }
                    
                    if ([tryString rangeOfString:searchText options:NSCaseInsensitiveSearch].location == NSNotFound) {
                        // no match
                    } else {
                        //match found
                        [criticalListOfItems addObject:@(i)];
                    }
                }
                
            }// end for loop
            
        }
        if (criticalListOfItems.count == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Matching Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    else if ([tableType isEqualToString:@"normal"]){
        NSString *searchText = normalStockSearchBar.text;
        
        for (int j = 0; j < 5; j++) {
            
            for ( int i=0; i<nameArray1.count; i++ ){
                
                if (![normalCopyListOfItems containsObject:@(i)]) {
                    
                    NSString * tryString;
                    if (j == 0) {
                        tryString = [nameArray1[i] description];
                    }
                    else if (j == 1) {
                        tryString = [descArray1[i] description];
                    }
                    else if (j == 2) {
                        tryString = [avaiArray1[i] description];
                    }
                    else if (j == 3) {
                        tryString = [unitArray1[i] description];
                    }
                    else {
                        tryString = [reorArray1[i] description];
                    }
                    
                    if ([tryString rangeOfString:searchText options:NSCaseInsensitiveSearch].location == NSNotFound) {
                        // no match
                    } else {
                        //match found
                        [normalCopyListOfItems addObject:@(i)];
                    }
                }
                
            }// end for loop
            
        }
        if (normalCopyListOfItems.count == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Matching Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
