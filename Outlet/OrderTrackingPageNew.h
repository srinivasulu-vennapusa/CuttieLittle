//
//  OrderTrackingPageNew.h
//  OmniRetailer
//
//  Created by Technolabs on 05/12/19.
//

#import "CustomNavigationController.h"
#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "RequestHeader.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface OrderTrackingPageNew : CustomNavigationController <MBProgressHUDDelegate, OutletOrderServiceDelegate, UITableViewDelegate,UITableViewDataSource, MKMapViewDelegate>

{
    MBProgressHUD * HUD;
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    NSMutableArray * orderItemListArray;
    
    
    NSArray* routes;
    BOOL isUpdatingRoutes;

}


@property (strong,nonatomic)NSString * orderId;





@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *billIdValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderIdValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *customerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumberLbl;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UITableView *itemsListTableView;
@property (weak, nonatomic) IBOutlet UILabel *sNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *skuLbl;
@property (weak, nonatomic) IBOutlet UILabel *itemLbl;
@property (weak, nonatomic) IBOutlet UILabel *uomLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *qtyLbl;
@property (weak, nonatomic) IBOutlet UILabel *discLbl;
@property (weak, nonatomic) IBOutlet UILabel *costLbl;

//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;


@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;


@end




NS_ASSUME_NONNULL_END
