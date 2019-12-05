//
//  EditLoyalty.h
//  OmniRetailer
//
//  Created by Sonali on 6/20/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
//#import "ZBarSDK.h"
#include <AudioToolbox/AudioToolbox.h>
//#import "ZXingWidgetController.h"
#import "CustomTextField.h"
#import "WebServiceController.h"


@interface EditLoyalty : UIViewController<UITextFieldDelegate, MBProgressHUDDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate, LoyaltycardServicesDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UIView *showLoyaltyView;
    UITextField *loyaltyNumtxt;
    
    UILabel *username;
    UILabel *phNo;
    UILabel *email;
    UILabel *idType;
    UILabel *idNoLbl;
    UILabel *validFrom;
    UILabel *validThru;
    UILabel *availPoints;
    UILabel *amount;
    UILabel *label;
    
    CustomTextField *usernameData;
    CustomTextField *phNoData;
    CustomTextField *emailData;
    CustomTextField *idNo;
    CustomTextField *idTypeTxt;
    CustomTextField *validFromData;
    CustomTextField *validThruData;
    CustomTextField *pointsData;
    CustomTextField *amountData;
    
    UIButton *barcodeBtn;
    UIButton *submitBtn;
    
    MBProgressHUD* HUD;
    
    NSCharacterSet *blockedCharacters;
    
    int count;
    
    NSMutableArray *idslist;
    UITableView *idlistTableView;
    
    NSMutableArray *loyalTypeList;
    UITableView *loyaltyTypeTable;
    UIButton *lisbtn;
    UILabel *loyaltyPgm;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
