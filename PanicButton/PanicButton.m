//
//  pPanicButton.m
//  PanicButton
//
//  Created by Jarratt Tim on 8/7/12.
//  Copyright 2012 Tim Jarratt. All rights reserved.
//

#import "PanicButton.h"

@class PanicButton;
@implementation PanicButton

@synthesize device;
@synthesize push_count;
@synthesize volume;

- (id)init
{
    self = [super init];
    if (self) {
        self.push_count = 0;
    }
    
    return self;
}

-(BOOL)was_pushed {
    if (device && CFGetTypeID(device) == IOHIDDeviceGetTypeID()) {
        uint8_t data[8];
        CFIndex length = sizeof(data);
        IOReturn ret = IOHIDDeviceGetReport(device, kIOHIDReportTypeFeature, 0, data, &length);
        if (ret == kIOReturnSuccess && data[0]) {
            self.push_count += 1;
            [volume max];
            return YES;
        }
    }
    
    return NO;
}

-(void) handle_action {
    NSLog(@"Doin the needful...");
}

# pragma mark Delegate methods
- (void)speechSynthesizer:(NSSpeechSynthesizer *)synth didFinishSpeaking:(BOOL)finishedSpeaking {
    NSLog(@"returning volume to original level.\n");
    [volume original_volume];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}

@end
