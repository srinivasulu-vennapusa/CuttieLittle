//
//  StockMovementReportViewController.h
//  OmniRetailer
//
//  Created by technolans on 03/03/17.
//
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "WebServiceController.h"

@interface StockMovementReportViewController : CustomNavigationController<UITextFieldDelegate,UINavigationControllerDelegate,MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource,GetStockMovementDelegate,OutletMasterDelegate,CustomerWalkOutDelegate >

{
    
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    float version;
    
    
    UIView *stockMovntView;
      MBProgressHUD *HUD;
   // UIView *scrollView;
    
    UITextField *category;
    UIButton *categoryBtn;
    UIImage *categoryImg;
    
    UITextField *startOrder;
    UIButton *startOrderButton;
    UIImage *startImageDate;
    
    
    UITextField *endOrder;
    UIButton *endOrderButton;
    UIImage *endImageDate;
    
    
    
    UIPopoverController *catPopOver;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    UIButton *selectCounter;
    
    UIButton *generateReport;
    
    
    UILabel *slno;
    UILabel *categorys;
    UILabel *itemCode;
    UILabel *itemdesc;
    UILabel *openQty;
    UILabel *closeQty;
    UILabel *inwardQty;
    UILabel *saleQty;
    UILabel *saleValue;
    UILabel *writeOff;
    UIScrollView *scrollView;
    UITableView *stockMovntTable;
    
  
    int reportStartIndex;
    int totalNumberOfStockMovement;
    NSMutableArray *item;
  
    int totalRecordsInt;
    NSMutableArray *stockMovementArr;
    
    
    UITableView * categoriesTbl;
    NSMutableArray * categoriesArr;
    
    NSMutableDictionary *categoryAndSubcategoryInfoDic;

    
    
    
    
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,strong)UITextField *startOrder;
@property(nonatomic,strong)UITextField *endOrder;


@end
