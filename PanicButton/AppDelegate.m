
//
//  AppController.m
//  PanicButton
//
//  Created by Tim Jarratt in the future.
//  Copyright 2012 General Linear Group. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize menu;

- (void)awakeFromNib
{
    [NSApp activateIgnoringOtherApps:YES];
    
    // Create an NSStatusItem.
    float width = 50.0;
    float height = [[NSStatusBar systemStatusBar] thickness];
    NSRect viewFrame = NSMakeRect(0, 0, width, height);
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:width] retain];
    [statusItem setView:[[[CustomView alloc] initWithFrame:viewFrame controller:self] autorelease]];
    [statusItem setTitle:@"¡Panic!"];
}

- (void)dealloc
{
    [[NSStatusBar systemStatusBar] removeStatusItem:statusItem];
    [super dealloc];
}


- (void)toggleAttachedWindowAtPoint:(NSPoint)pt
{
    // Attach/detach window.
    if (!attachedWindow) {
        attachedWindow = [[MAAttachedWindow alloc] initWithView:view
                                                attachedToPoint:pt
                                                       inWindow:nil
                                                         onSide:MAPositionBottom
                                                     atDistance:5.0];
        [textField setTextColor:[attachedWindow textColor]];
        [textField setStringValue:@"Your text goes here..."];
        [attachedWindow makeKeyAndOrderFront:self];
        [NSApp activateIgnoringOtherApps:YES];

    } else {
        [attachedWindow orderOut:self];
        [attachedWindow release];
        attachedWindow = nil;
    }
}


@end
