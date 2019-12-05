//
//  ReturningCompletedBillItems.m
//  OmniRetailer
//
//  Created by apple on 29/01/18.
//

#import "ReturningCompletedBillItems.h"

@interface ReturningCompletedBillItems ()

@end

@implementation ReturningCompletedBillItems
@synthesize soundFileURLRef,soundFileObject;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         27/01/2018....
 * @method       ViewDidLoad
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By
 * @reason
 *2
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //setting the background colour of the self.view....
    self.view.backgroundColor = [UIColor blackColor];
    
    //reading os version of the build installed device and storing....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD setLabelText:NSLocalizedString(@"HUD_LABEL", nil)];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    
    
    searchItemsTxt = [[CustomTextField alloc] init];
    searchItemsTxt.placeholder = NSLocalizedString(@"search_items_here", nil);
    searchItemsTxt.delegate = self;
    [searchItemsTxt awakeFromNib];
    
    searchItemsTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemsTxt.textColor = [UIColor blackColor];
    searchItemsTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemsTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [searchItemsTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImage * buttonImageDD2;
    UIButton * barcodeBtn;
    UISwitch * isSearch;
    
    buttonImageDD2 = [UIImage imageNamed:@"searchImage.png"];

    searchBarcodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBarcodeBtn setBackgroundImage:buttonImageDD2 forState:UIControlStateNormal];
    [searchBarcodeBtn addTarget:self
                         action:@selector(searchBarcode:) forControlEvents:UIControlEventTouchDown];
    searchBarcodeBtn.tag = 1;
    searchBarcodeBtn.hidden = YES;
    
    isSearch = [[UISwitch alloc] init];
    [isSearch addTarget:self action:@selector(changeSwitchAction:) forControlEvents:UIControlEventValueChanged];
    isSearch.onTintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    isSearch.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [isSearch setOn:YES];
    
    
    // Scanner Button for barcode scannig ..
    barcodeBtn  = [[UIButton alloc] init];
    [barcodeBtn setImage:[UIImage imageNamed:@"scan_icon.png"] forState:UIControlStateNormal];
    [barcodeBtn addTarget:self action:@selector(openBarcode) forControlEvents:UIControlEventTouchUpInside];
    barcodeBtn.tag = 1;
    barcodeBtn.enabled = FALSE;
    
    
    custmerPhNum = [[CustomTextField alloc] init];
    custmerPhNum.delegate = self;
    custmerPhNum.borderStyle = UITextBorderStyleRoundedRect;
    custmerPhNum.textColor = [UIColor blackColor];
    custmerPhNum.font = [UIFont systemFontOfSize:12.0];
    custmerPhNum.autocorrectionType = UITextAutocorrectionTypeNo;
    custmerPhNum.keyboardType = UIKeyboardTypeNumberPad;
    custmerPhNum.placeholder = @"Customer Mobile";
    custmerPhNum.backgroundColor = [UIColor whiteColor];
    custmerPhNum.layer.borderColor = [UIColor grayColor].CGColor;
    custmerPhNum.text = @"";
    [custmerPhNum addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton * customerInfoEnable;
    customerInfoEnable = [[UIButton alloc] init];
    [customerInfoEnable addTarget:self action:@selector(customerInfoClicked:) forControlEvents:UIControlEventTouchUpInside];
    [customerInfoEnable setBackgroundImage:[UIImage imageNamed:@"MB__info.png"] forState:UIControlStateNormal];
    
    
    [self.view addSubview:searchItemsTxt];
    [self.view addSubview:searchBarcodeBtn];
    [self.view addSubview:isSearch];
    [self.view addSubview:barcodeBtn];
    [self.view addSubview:custmerPhNum];

    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {}
        
        
        searchItemsTxt.frame = CGRectMake( 5,  155, self.view.frame.size.width/1.5, 40);
//        isSearch.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
    }
    else{
        
        
    }
    
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidLoad.......
 * @date         30/01/2018....
 * @method       viewDidAppear
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated{
    
    //calling super class viewDidAppear....
    [super viewDidAppear:YES];
    
    
    
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidAppear.......
 * @date         30/01/2018....
 * @method       viewWillAppear
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void) viewWillAppear:(BOOL)animated {
    
    //calling the superClass method.......
    [super viewWillAppear:YES];
    
    
}

#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         30/01/2018....
 * @method       didReceiveMemoryWarning
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark Start of TextFieldDelegates.......


/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date         10/09/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    @try {
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return  YES;
    
    
}


/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    @try {
        
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the createNewReuqestForQuotation in textFieldDidBeginEditing:----");
        NSLog(@"------exception while moving the self.view------%@",exception);
        
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         06/09/2016
 * @method       textField:  shouldChangeCharactersInRange:  replacementString:
 * @author       Srinivasulu
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    @try {
        
        return  YES;
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the createNewPurchaseOrder in shouldChangeCharactersInRange:----");
        NSLog(@"------exception while return the number of character's------%@",exception);
        return  YES;
        
    }
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         10/09/2016
 * @method       textFieldDidChange:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    @try {
        
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the createNewPurchaseOrder in textFieldDidChange:----");
        NSLog(@"------exception while changing the qunatity || service Call------%@",exception);
        
    } @finally {
        
    }
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing....
 * @date         29/05/2016
 * @method       textFieldDidEndEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    @try {
        
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the createNewPurchaseOrder in textFieldDidChange:----");
        NSLog(@"------exception while return the number of character's------%@",exception);
        
    }
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma -mark start of UITextViewDelegates methods

/**
 * @description  it is an textViewDelegate method it will be executed when user interaction........
 * @date         16/09/2016
 * @method       textViewShouldBeginEditing;
 * @author       Srinivasulu
 * @param        UITextView
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return  YES;
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    @try {
        
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the createNewReuqestForQuotation in textFieldDidBeginEditing:----");
        NSLog(@"------exception while moving the self.view------%@",exception);
        
    }
    
    
}

/**
 * @description  it is an textViewDelegate method it will be executed when user interaction........
 * @date         16/09/2016
 * @method       textViewShouldBeginEditing;
 * @author       Srinivasulu
 * @param        UITextView
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    @try {
        [self keyboardWillHide];
        offSetViewTo = 0;
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma -mark reusableMethods.......

#pragma -mark keyboard notification methods

/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       keyboardWillShow
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillShow {
    // Animate the current view out of the way
    @try {
        [self setViewMovedUp:YES];
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  called when keyboard is dismissed
 * @date         04/06/2016
 * @method       keyboardWillHide
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillHide {
    @try {
        [self setViewMovedUp:NO];
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  method to move the view up/down whenever the keyboard is shown/dismissed
 * @date         04/06/2016
 * @method       setViewMovedUp
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)setViewMovedUp:(BOOL)movedUp
{
    @try {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3]; // if you want to slide up the view
        
        CGRect rect = self.view.frame;
        
        //    CGRect rect = scrollView.frame;
        
        if (movedUp)
        {
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            rect.origin.y = (rect.origin.y -(rect.origin.y + offSetViewTo));
        }
        else
        {
            // revert back to the normal state.
            rect.origin.y +=  offSetViewTo;
        }
        self.view.frame = rect;
        //   scrollView.frame = rect;
        
        [UIView commitAnimations];
        
        /* offSetViewTo = 80;
         [self keyboardWillShow];*/
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
    
}
@end
