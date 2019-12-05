//
//  KitchenOrderToken.h
//  OmniRetailer
//
//  Created by MACPC on 1/25/16.
//
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "WebServiceUtility.h"
#import "OmniHomePage.h"
#import "WebServiceController.h"
#include <AudioToolbox/AudioToolbox.h>

@interface KitchenOrderToken : CustomNavigationController <UITableViewDelegate,UITableViewDataSource,OutletServiceDelegate,MBProgressHUDDelegate,KOTServiceDelegate,StoreServiceDelegate,RolesServiceDelegate,MenuServiceDelegate>
{
    UIInterfaceOrientation currentOrientation;
    MBProgressHUD *HUD;

    NSMutableArray * orderItemsArr; // Items table array
//    NSMutableArray * tablesInfoList; //
    
    UITableView * orderStatusListTbl;
    NSMutableArray *orderStatusListArr;
    
    
    NSMutableArray *orderTypeListArr; // for popover
    UITableView * orderTypeListTbl; // for popover
    UITableView * tableIdListTbl; // for popover

    UIPopoverPresentationController * presentationPopOverController;
    
    
    NSString *orderStatusStr;
    NSString * orderTypeRefString;
    NSString * tableIdStr;

//    NSString *orderType;
//    NSString *orderDateStr;
 
//    UIButton *goButton;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    
    // Used To display the Alert messages
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    UITableView * menuCategoryTbl;
    NSMutableArray * menuCategoryNamesArr;
    NSString * menuCategoryStr;
    NSMutableArray * tableIdArrList; 

}




@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


   

@property (retain, nonatomic) IBOutlet UITextField *locationTxt;
@property (retain, nonatomic) IBOutlet UITextField *dateTxt;

@property (retain, nonatomic) IBOutlet UITextField *chefNameTxt;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *sNoLbl;
@property (retain, nonatomic) IBOutlet UILabel *tableNoLbl;
@property (retain, nonatomic) IBOutlet UILabel *categoryLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeTableLbl;

@property (weak, nonatomic) IBOutlet UILabel *itemNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *additionalLbl;
@property (weak, nonatomic) IBOutlet UILabel *qtyLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLbl;
@property (weak, nonatomic) IBOutlet UILabel *actionLbl;


@property (retain, nonatomic) IBOutlet UITableView *orderItemsTbl;


- (IBAction)viewReport:(UIButton *)sender;
- (IBAction)refreshOrders:(UIButton *)sender;
- (IBAction)viewReviews:(UIButton *)sender;

- (IBAction)closeView:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel *S1Lbl;
@property (retain, nonatomic) IBOutlet UILabel *S2Lbl;
@property (retain, nonatomic) IBOutlet UILabel *S3Lbl;

//@property (readwrite)    CFURLRef        soundFileURLRef;
//@property (readonly)    SystemSoundID    soundFileObject;


@property (weak, nonatomic) IBOutlet UILabel *orderTypeLbl;
@property (weak, nonatomic) IBOutlet UITextField *orderTypeTF;
@property (weak, nonatomic) IBOutlet UIButton *orderTypeListBtn;
- (IBAction)orderTypeListAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UITextField *statusTF;

@property (weak, nonatomic) IBOutlet UITextField *menuCategoryTF;

- (IBAction)menuCategoryPopUpBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tableIdTF;


@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

- (IBAction)statusListAction:(id)sender;

- (IBAction)searchBtnAction:(id)sender;

- (IBAction)clearBtnAction:(id)sender;

- (IBAction)selectedDateButton:(id)sender;


- (IBAction)populateTableIdList:(id)sender;


@end
