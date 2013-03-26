//
//  AppDelegate.h
//  PanicButton
//
//  Created by Tim Jarratt on 3/22/13.
//  Copyright (c) 2013 Tim Jarratt. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CustomView.h"
#import "MAAttachedWindow.h"

@class MAAttachedWindow;
@interface AppDelegate : NSObject {
    NSStatusItem *statusItem;
    MAAttachedWindow *attachedWindow;
    
    IBOutlet NSView *view;
    IBOutlet NSTextField *textField;
    IBOutlet NSMenu *menu;
}

@property NSMenu* menu;

- (void)toggleAttachedWindowAtPoint:(NSPoint)pt;

@end
