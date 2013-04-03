//
//  pPanicButton.h
//  PanicButton
//
//  Created by Jarratt Tim on 8/7/12.
//  Copyright 2012 Tim Jarratt. All rights reserved.
//
#import "VolumeKnob.h"
#import <IOKit/hid/IOHIDLib.h>

@interface PanicButton : NSObject <NSSpeechSynthesizerDelegate> {
    IOHIDDeviceRef device;
    NSInteger push_count;
    
    VolumeKnob *volume;
}

@property (retain) VolumeKnob *volume;
@property IOHIDDeviceRef device;
@property NSInteger push_count;

- (void) speechSynthesizer: (NSSpeechSynthesizer *)synth didFinishSpeaking:(BOOL)finishedSpeaking;
- (BOOL) was_pushed;
- (void) handle_action;

@end
