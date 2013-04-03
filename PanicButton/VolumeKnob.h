//
//  VolumeKnob.h
//  PanicButton
//
//  Created by Jarratt Tim on 8/7/12.
//  Copyright 2012 Tim Jarratt. All rights reserved.
//
#import <CoreServices/CoreServices.h>
#import <CoreAudio/CoreAudio.h>
#import <CoreAudioKit/CoreAudioKit.h>

@interface VolumeKnob : NSObject
{
    AudioHardwarePropertyID default_device;
    Float32 base_volume;
}

-(void) find_default_device;
-(OSStatus) max;
-(OSStatus) original_volume;

@end

