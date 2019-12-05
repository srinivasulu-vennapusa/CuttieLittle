//
//  FTPConfigurationView.h
//  OmniRetailer
//
//  Created by Roja on 4/25/19.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "GRRequestsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTPConfigurationView : UIView <UITextFieldDelegate,GRRequestsManagerDelegate>{
    
    UITextField * hostNumberTF;
    UITextField * portNumberTF;
    UITextField * userIdTF;
    UITextField * passwordTF;
    
    CFURLRef        soundFileURLRef;
    SystemSoundID    soundFileObject;
}

@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;

@property (nonatomic, strong)UITextField * hostNumberTF;
@property (nonatomic, strong)UITextField * portNumberTF;
@property (nonatomic, strong)UITextField * userIdTF;
@property (nonatomic, strong)UITextField * passwordTF;

@property (nonatomic, strong) GRRequestsManager *requestsManager;


@end

NS_ASSUME_NONNULL_END
