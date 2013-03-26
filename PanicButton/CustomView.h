//
//  CustomView.h
//  PanicButton
//
//  Created by Tim Jarratt on 2/5/13.
//  Copyright (c) 2013 Tim Jarratt. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@class AppDelegate;
@interface CustomView : NSView <NSMenuDelegate> {
    __weak AppDelegate *controller;
    BOOL clicked;
}

-(id)initWithFrame:(NSRect)frame controller:(AppDelegate *)room;

@end
