
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
    float width = 50.0;
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:width] retain];
    [statusItem setHighlightMode:YES];
    
    NSMenu *menu = [[NSMenu alloc] init];

    NSMenuItem *actions_item = [[NSMenuItem alloc] initWithTitle:@"Actions" action:nil keyEquivalent:@""];
    NSMenuItem *quit_item = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quit_application:) keyEquivalent:@""];
    
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
    
    [NSApp activateIgnoringOtherApps:YES];
}

- (void)dealloc {
    [[NSStatusBar systemStatusBar] removeStatusItem:statusItem];
    [super dealloc];
}

#pragma mark - menu actions
- (void) open_doors {
    printf("open all them doors\n");
}

- (void) nateberg_berg {
    printf("BERG IT\n");
}

- (void) random_string {
    printf("rand-um string\n");
}

- (void) play_barbaric {
    printf("bar-barrrrric\n");
}

- (void) quit_application {
    printf("quit!\n");
}

@end
