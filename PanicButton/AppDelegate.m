
//
//  AppController.m
//  PanicButton
//
//  Created by Tim Jarratt in the future.
//  Copyright 2012 General Linear Group. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)awakeFromNib {    
    room = [[PanicRoom alloc] init];
    [room startup];
}

@end
