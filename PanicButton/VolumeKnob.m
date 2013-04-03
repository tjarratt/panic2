//
//  VolumeKnob.m
//  PanicButton
//
//  Created by Jarratt Tim on 8/7/12.
//  Copyright 2012 Tim Jarratt. All rights reserved.
//

#import "VolumeKnob.h"

@implementation VolumeKnob

- (id)init
{
    self = [super init];
    if (self) {
        [self find_default_device];
    }
    
    return self;
}

- (void)find_default_device {
    // AudioHardwareGetProperty is deprecated, use AudioObjectGetPropertyData
    AudioDeviceID device;
    UInt32 size = sizeof(AudioDeviceID);
    AudioHardwareGetProperty(kAudioHardwarePropertyDefaultOutputDevice, &size, &device);
    
    NSLog(@"found an output device: %u\n", device);
    default_device = device;
}

- (OSStatus) max {
    if (!default_device) {
        [self find_default_device];
    }
    
    Float32 volume = (Float32)0.66;
    UInt32 size = sizeof(Float32);
    AudioObjectPropertyAddress address = {
        kAudioDevicePropertyVolumeScalar,
        kAudioDevicePropertyScopeOutput,
        1
    };
    
    // stash off current volume level
    Float32 original_volume;
    AudioObjectGetPropertyData(default_device, &address, sizeof(Float32), NULL, &size, &original_volume);
    base_volume = original_volume;
    
    return AudioObjectSetPropertyData(default_device, &address, 0, NULL, size, &volume);
}

- (OSStatus) original_volume {
    UInt32 size = sizeof(Float32);
    AudioObjectPropertyAddress addr = {
        kAudioDevicePropertyVolumeScalar,
        kAudioDevicePropertyScopeOutput,
        1
    };
    
    return AudioObjectSetPropertyData(default_device, &addr, 0, NULL, size, &base_volume);
}

@end
