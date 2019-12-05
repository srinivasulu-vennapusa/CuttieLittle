//
//  BarcodeType.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 16/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BarcodeType : UIView <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView* barcodeTable;
    
    NSMutableArray* listofBarcodesArray;
    
}

@property (nonatomic, strong) UITableView *barcodeTable;
@property (nonatomic, strong) NSMutableArray *listofBarcodesArray;



- (void) closeBarcodeView:(id) sender ;

@end

