//
//  QImageView.h
//  Sample
//
//  Created by Satya Siva Saradhi on 04/07/12.
//  Copyright 2012 technolabssoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QImageView : UIImageView
{

    
    CGPoint lastPoint;
}
@property(nonatomic,assign) BOOL signatureDrawn;
-(NSData*) renderImageData;
-(void)clear;
@end