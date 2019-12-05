//
//  BTListDevItem.m
//  Bluetooth
//
//  Created by Radu on 7/16/12.
//  Copyright (c) 2012 Teksoft. All rights reserved.
//

#import "BTListDevItem.h"

@implementation BTListDevItem
@synthesize name, description, type, btdev;

-(id)initWithName:(NSString *)n description:(NSString *)d type:(NSInteger )u btdev:( BluetoothDevice *)b
 {
	self.name = n;
	self.description = d;
	self.type = u;
    self.btdev = b;
	return self;
}
@end
