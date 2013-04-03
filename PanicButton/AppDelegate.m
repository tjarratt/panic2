
//
//  AppController.m
//  PanicButton
//
//  Created by Tim Jarratt in the future.
//  Copyright 2012 General Linear Group. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - lifecycle
- (void)awakeFromNib {
    [NSApp activateIgnoringOtherApps:YES];
    PanicRoom *room = [[PanicRoom alloc] init];
    [room startup];
}

@end
