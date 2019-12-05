//
//  WebViewController.h
//  BrowserExample
//
//  Created by Satya Siva Saradhi on 27/08/2009.
//  Copyright 2009 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate,UINavigationControllerDelegate> {
	
    NSURL *theURL;
	NSString *theTitle;
	UIWebView *webView;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

- (id)initWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string;

@end
