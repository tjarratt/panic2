//
//  PanicRoom.h
//  PanicButton
//
//  Created by Tim Jarratt on 3/30/13.
//  Copyright (c) 2013 Tim Jarratt. All rights reserved.
//

#import "PanicButton.h"

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <CoreServices/CoreServices.h>

#import <IOKit/hid/IOHIDLib.h>
#import <CoreAudio/CoreAudio.h>
#import <CoreAudioKit/CoreAudioKit.h>

# define vendor_id 0x1130;
# define product_id 0x0202;

@interface PanicRoom : NSObject {
    NSStatusItem *statusItem;
    PanicButton *panic_button;
    SEL action;
}

- (void) startup;
- (void) create_status_bar;
- (void) start_runloop;

// menu actions
- (void) quit_application;
- (void) open_doors;
- (void) nateberg_berg;
- (void) random_string;
- (void) play_barbaric;

// actual implementations
- (void) do_open_doors;
- (void) do_nateberg_berg;
- (void) do_random_string;
- (void) do_play_barbaric;

@end
