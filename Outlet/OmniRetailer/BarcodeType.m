//
//  BarcodeType.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 16/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "BarcodeType.h"
#import <QuartzCore/QuartzCore.h>

@implementation BarcodeType

@synthesize barcodeTable, listofBarcodesArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       // self.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:182.0/255.0 blue:218.0/255.0 alpha:1.0];
       // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images9.jpg"]];
        
      
        
        self.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        // self.barcodeTable = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width,self.frame.size.height - 50) style:UITableViewStylePlain];

        
        UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"Barcode Configuration";
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor whiteColor];
 
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            self.barcodeTable = [[UITableView alloc]init];
            self.barcodeTable.frame = CGRectMake(70,120,530,510);
            
            headerimg.frame = CGRectMake(0, 0, 668, 80);
            title.frame = CGRectMake(200, 15, 400, 50);
            title.font = [UIFont boldSystemFontOfSize:30];
            
        }
        else{
            self.barcodeTable = [[UITableView alloc] initWithFrame:CGRectMake(20,50,220,250)];
            self.barcodeTable.layer.cornerRadius = 5.0f;
            
            headerimg.frame = CGRectMake(0, 0, 280, 40);
            title.frame = CGRectMake(50, 3, 200, 30);
            title.font = [UIFont boldSystemFontOfSize:15];
        }
        
        
        [self addSubview:headerimg];
        [self addSubview:title];
        
        //self.barcodeTable.backgroundColor = [UIColor whiteColor];
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images9.jpg"]];

        (self.barcodeTable).dataSource = self;
        (self.barcodeTable).delegate = self;
        
        // tell it to scroll to its current position, it will stop scrolling
        self.barcodeTable.bounces = FALSE;

        self.barcodeTable.layer.borderWidth = 1.0f;
        self.barcodeTable.layer.borderColor = [UIColor blackColor].CGColor;
        
        [self addSubview:self.barcodeTable];
        
        
        self.listofBarcodesArray = [[NSMutableArray alloc] init] ;
        [self.listofBarcodesArray addObject:@"UPC"];
        [self.listofBarcodesArray addObject:@"EAN"];
        [self.listofBarcodesArray addObject:@"Code 39"];
        [self.listofBarcodesArray addObject:@"ISBN"];
        [self.listofBarcodesArray addObject:@"UPC - A"];
        [self.listofBarcodesArray addObject:@"EAN 18"];
        
    }
    
    // button to submit the barcode type View ..
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(closeBarcodeView:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.tag = 0;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.cornerRadius = 3.0f;
    
    
    // button to cancel the barcode view ..
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(closeBarcodeView:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1;
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.cornerRadius = 3.0f;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
      
        submitBtn.frame = CGRectMake(50, 630, 275, 60);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        submitBtn.layer.cornerRadius = 25.0f;
        
        cancelBtn.frame = CGRectMake(335, 630, 275, 60);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelBtn.layer.cornerRadius = 25.0f;
    }
    else{
        
        submitBtn.frame = CGRectMake(10, 310, 115, 30);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        submitBtn.layer.cornerRadius = 15.0f;
        
        cancelBtn.frame = CGRectMake(130, 310, 115, 30);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cancelBtn.layer.cornerRadius = 15.0f;
    }

    [self addSubview:submitBtn];
    [self addSubview:cancelBtn];
    
    
     return self;
    
}


- (void) closeBarcodeView:(id) sender {
    
    if ([sender tag] == 0) {
        
        NSIndexPath *selectedIndexPath = barcodeTable.indexPathForSelectedRow;
        if (selectedIndexPath) {
            
            (self.superview.subviews)[0].alpha = 1.0f;
            [(self.superview.subviews)[0] setEnabled:YES];
            
            [self removeFromSuperview];

            
        }
        else {
        
        }
        
    }
    else {
        
        (self.superview.subviews)[0].alpha = 1.0f;
        [(self.superview.subviews)[0] setEnabled:YES];
        
        [self removeFromSuperview];
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/





#pragma mark Table view methods

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    //section text as a label
    UILabel *lbl = [[UILabel alloc] init];
    lbl.textAlignment = NSTextAlignmentCenter; 
    
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         
         lbl.font = [UIFont boldSystemFontOfSize:25];
     }
     else{
         lbl.font = [UIFont boldSystemFontOfSize:16];
     }
    lbl.text = @" Select The Barcode";
    lbl.backgroundColor = [UIColor lightGrayColor];  
    
    return lbl;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 50.0;
    }
    else{
        return 30.0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 70.0;
    }
    else{
        return 30.0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return listofBarcodesArray.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.backgroundColor = [UIColor whiteColor];
    //tableView.backgroundColor = [UIColor colorWithRed:145.0/255.0 green:182.0/255.0 blue:218.0/255.0 alpha:1.0];
    //tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images9.jpg"]];
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
            
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    if(hlcell == nil) {
        hlcell =  [[UITableViewCell alloc] 
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
        hlcell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    hlcell.textLabel.text = listofBarcodesArray[indexPath.row];
    
    hlcell.textLabel.textColor = [UIColor blackColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    else{
        hlcell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    }
        
    
    return hlcell;
    
}


@end
