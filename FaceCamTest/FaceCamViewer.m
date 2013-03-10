//
//  FaceCamViewer.m
//
//  Created by JASON EVERETT on 3/5/13.
//  Copyright (c) 2013 JASON EVERETT. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "FaceCamViewer.h"

@implementation FaceCamViewer

@synthesize cameraType, session, draggable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (id)initWithDeviceType:(DeviceType)type
{
    CGRect frame;
    switch (type)
    {
        case 0:
            frame = CGRectMake(190, 300, 120, 150);
            break;
        case 1:
            frame = CGRectMake(190, 380, 120, 160);
            break;
        case 2:
            frame = CGRectMake(190, 290, 120, 160);
            break;
        default:
            frame = CGRectMake(190, 300, 120, 150);
            break;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}


-(void)setDefaults {
    [self setBackgroundColor:[UIColor blackColor]];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.cameraType = AVCaptureDevicePositionFront;
    self.draggable = NO;
}

-(void)startFaceCam {
    AVCaptureDevice *device = [self CameraIfAvailable];
    
    if (device) {
        if (!session) {
            session = [[AVCaptureSession alloc] init];
        }
        session.sessionPreset = AVCaptureSessionPresetMedium;
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (!input) {
            // Handle the error appropriately.
            NSLog(@"ERROR: trying to open camera: %@", error);
        } else {
            if ([session canAddInput:input]) {
                [session addInput:input];
                
                AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
                
                captureVideoPreviewLayer.frame = self.bounds;
                captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                
                [self.layer addSublayer:captureVideoPreviewLayer];
                
                [session startRunning];
            } else {
                NSLog(@"Couldn't add input");
            }
        }
    } else {
        NSLog(@"Camera not available");
    }
}

-(AVCaptureDevice *)CameraIfAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == self.cameraType)
        {
            captureDevice = device;
            break;
        }
    }
    
    //just in case
    if (!captureDevice) {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return captureDevice;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *aTouch = [touches anyObject];
    offset = [aTouch locationInView: self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.draggable) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.superview];
        [UIView beginAnimations:@"Dragging" context:nil];
        self.frame = CGRectMake(location.x-offset.x, location.y-offset.y, self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
    }
}

@end
