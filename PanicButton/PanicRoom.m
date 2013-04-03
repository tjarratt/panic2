//
//  PanicRoom.m
//  PanicButton
//
//  Created by Tim Jarratt on 3/30/13.
//  Copyright (c) 2013 Tim Jarratt. All rights reserved.
//

#import "PanicRoom.h"

@implementation PanicRoom

#pragma mark - Lifecycle
- (void) startup {
    [self create_status_bar];
    [self start_runloop];
}

- (void) dealloc {
    [[NSStatusBar systemStatusBar] removeStatusItem:statusItem];
    [super dealloc];
}

#pragma mark - NSStatusItem Menu
- (void) create_status_bar {
    float width = 50.0;
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:width] retain];
    [statusItem setHighlightMode:YES];
    
    NSMenu *menu = [[NSMenu alloc] init];
    
    NSMenuItem *actions_item = [[NSMenuItem alloc] initWithTitle:@"Actions" action:nil keyEquivalent:@""];
    NSMenuItem *quit_item = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quit_application) keyEquivalent:@""];
    
    NSMenuItem *open_door_item = [[NSMenuItem alloc] initWithTitle:@"Open Doors" action:@selector(open_doors) keyEquivalent:@""];
    NSMenuItem *nateberg_item = [[NSMenuItem alloc] initWithTitle:@"Nateberg-Berg" action:@selector(nateberg_berg) keyEquivalent:@""];
    NSMenuItem *speak_random_string_item = [[NSMenuItem alloc] initWithTitle:@"Random String" action:@selector(random_string) keyEquivalent:@""];
    NSMenuItem *play_sound_item = [[NSMenuItem alloc] initWithTitle:@"Play Sound" action:nil keyEquivalent:@""];
    
    NSMenuItem *barbaric_sound = [[NSMenuItem alloc] initWithTitle:@"Barbaric" action:@selector(play_barbaric) keyEquivalent:@""];
    NSMenu *sounds_submenu = [[NSMenu alloc] init];
    [sounds_submenu addItem: barbaric_sound];
    [play_sound_item setSubmenu:sounds_submenu];
    
    NSMenu *actions_menu = [[NSMenu alloc] init];
    [actions_menu addItem: open_door_item];
    [actions_menu addItem: nateberg_item];
    [actions_menu addItem: speak_random_string_item];
    [actions_menu addItem: play_sound_item];
    
    [actions_item setSubmenu:actions_menu];
    
    [menu addItem:actions_item];
    [menu addItem:quit_item];
    
    [statusItem setTitle:@"Panic!"];
    [statusItem setMenu:menu];
}

#pragma mark - RunLoop
- (void)start_runloop {
    NSLog(@"starting runloop");
        
    IOHIDManagerRef manager = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
    if (!CFGetTypeID(manager) == IOHIDManagerGetTypeID()) {
        NSLog(@"couldn't get a IO HID manager ref");
        return;
    }
    
    CFMutableDictionaryRef dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (!dict) {
        return NSLog(@"Couldn't create device dict");
    }
    
    int vendorID = vendor_id;
    int productID = product_id;
    CFNumberRef vendorRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &vendorID);
    CFNumberRef productRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &productID);
    
    if (vendorRef && productRef) {
        CFDictionaryAddValue(dict, CFSTR(kIOHIDVendorIDKey), vendorRef);
        CFDictionaryAddValue(dict, CFSTR(kIOHIDProductIDKey), productRef);
    }
    IOHIDManagerSetDeviceMatching(manager, dict);
    
    CFRelease(vendorRef);
    CFRelease(productRef);
    CFRelease(dict);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        IOHIDManagerRegisterDeviceMatchingCallback(manager, deviceMatchingCallback, NULL);
        IOHIDManagerScheduleWithRunLoop(manager, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
        IOReturn ret = IOHIDManagerOpen(manager, kIOHIDOptionsTypeNone);
        if (ret == kIOReturnSuccess) {
            CFRunLoopRun();
        }
        CFRelease(manager);
    });
    
    NSLog(@"started cf runloop");
    CFRunLoopRun();
}

#pragma mark - Device Usage
static void timerCallback(CFRunLoopTimerRef timer, void *info) {
    PanicButton *button = (PanicButton *) info;
    if ([button was_pushed]) {
        NSLog(@"¿SUCCESS!");
        [button handle_action];
    }
}

#pragma mark - Device Lifecycle
static void deviceRemovedCallback(void *context, IOReturn result, void *sender) {
    NSLog(@"device removed callback");
    CFRunLoopTimerRef timer = (CFRunLoopTimerRef)context;
    if (timer && CFGetTypeID(timer) == CFRunLoopTimerGetTypeID()) {
        CFRunLoopTimerContext ctx;
        bzero(&ctx, sizeof(ctx));
        CFRunLoopTimerGetContext(timer, &ctx);
        if (ctx.info) {
            CFRelease(ctx.info);
        }
        CFRunLoopRemoveTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes);
        timer = NULL;
    }
}

static void deviceMatchingCallback(void *context, IOReturn result, void *sender, IOHIDDeviceRef device) {
    NSLog(@"device matching callback: %p", device);
    PanicButton *button = [[PanicButton alloc] init];
    button.device = device;
    button.volume = [[VolumeKnob alloc] init];
    
    CFRunLoopTimerContext ctx;
    bzero(&ctx, sizeof(ctx));
    ctx.info = (void *) CFRetain(button);
    CFRunLoopTimerRef timer = CFRunLoopTimerCreate(kCFAllocatorDefault, 0, 0.1, 0, 0, timerCallback, &ctx);
    
    if (timer) {
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes);
        IOHIDDeviceRegisterRemovalCallback(device, deviceRemovedCallback, timer);
        CFRelease(timer);
    }
    
}

- (void) quit_application {
    NSLog(@"Quit!");
    exit(0);
}

@end
