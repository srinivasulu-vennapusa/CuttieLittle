//
//  MaterialDetailsController.h
//  OmniRetailer
//
//  Created by Bhargav on 2/24/17.
//
//

#import "CustomNavigationController.h"
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "RequestHeader.h"
#import "CustomTextField.h"
#import <QuartzCore/QuartzCore.h>

@interface MaterialDetailsController : CustomNavigationController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate> {
    
    //to get the device version.......
    float version;
    
    
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    
//   creation Of UIView:
    
    
    UIView * consumptionDetailsView;
    
    
//    header Section:
    
    
    UILabel * itemCodeLbl;
    UILabel * itemDescLbl;
    UILabel * uomLbl;
    UILabel * qtyUnitsLbl;
    UILabel * openStockLbl;
    UILabel * closedStockLbl;
    UILabel * usedStockLbl;
    UILabel * totalCostLbl;
    
    
//    creation of UITable view
    
    UITableView  * consumptionDetailsTbl;
   
    
    
    
}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic,strong) NSMutableArray * detailsArray;




@end
