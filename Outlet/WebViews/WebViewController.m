//
//  WebViewController.m
//  BrowserExample
//
//  Created by Satya Siva Saradhi on 27/08/2009.
//  Copyright 2009 __techolabssoftware.com__. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController
@synthesize soundFileURLRef,soundFileObject;
#pragma mark init Methods


-(id)initWithURL:(NSURL *)url {
    return [self initWithURL:url andTitle:nil];
}

- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string {
    
    if( self == [super init] ) {
        theURL = url;
        theTitle = string;
    }
    return self;
}

#pragma mark UIViewController Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) CFBridgingRetain(tapSound);
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    self.title = theTitle;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    
    webView = [[UIWebView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        (self.navigationController.navigationBar).barTintColor = [UIColor lightGrayColor];
        webView.frame = CGRectMake(0, 0, 768, 960);
    } else {
        webView.frame = CGRectMake(0, 0, 320, 430);
    }
    
    webView.delegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:theTitle ofType:@"html"]isDirectory:NO]]];
    
    
    [webView setUserInteractionEnabled:YES];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    
    
    // a label on top of the view ..
    //    UILabel *topbar = [[[UILabel alloc] init] autorelease];
    //    topbar.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:121.0/255.0 blue:220.0/255.0 alpha:1.0];
    //    topbar.text = @" Omni Retailer";
    //    topbar.font = [UIFont boldSystemFontOfSize:17];
    //    topbar.textColor = [UIColor whiteColor];
    //    topbar.textAlignment = NSTextAlignmentLeft;
    //
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        topbar.frame = CGRectMake(0, 0, 768, 60);
    //    } else {
    //        topbar.frame = CGRectMake(0, 0, 320, 30);
    //    }
    //
    //    [self.view addSubview:topbar];
    //
    //    UIButton *backbutton = [[[UIButton alloc] init] autorelease];
    //    [backbutton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    //    UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
    //    [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
    //
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        backbutton.frame = CGRectMake(710, 10, 40, 40);
    //    } else {
    //        backbutton.frame = CGRectMake(285.0, 2.0, 27.0, 27.0);
    //    }
    //
    //    [self.view addSubview:backbutton];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    webView.delegate = nil;
    [webView stopLoading];
}

- (void)viewDidUnload {
    
    
}



#pragma mark Instance Methods

- (void) back:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)wv {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)wv {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *errorString = error.localizedDescription;
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
    
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [errorView show];
    
    //commented by Srinivasulu on 19/09/2017....
    //reason is in ARC no need to mention it explicily....
    //    [errorView autorelease];
    
    //upto here on 19/09/2017....
}

#pragma mark UIAlertViewDelegate Methods

- (void)didPresentAlertView:(UIAlertView *)alertView {
    [self dismissModalViewControllerAnimated:YES];    
    
}



@end
