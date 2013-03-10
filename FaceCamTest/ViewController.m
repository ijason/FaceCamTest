//
//  ViewController.m
//  FaceCamTest
//
//  Created by JASON EVERETT on 3/5/13.
//  Copyright (c) 2013 JASON EVERETT. All rights reserved.
//

#import "ViewController.h"
#import "FaceCamViewer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Basic Usage
    FaceCamViewer *viewer = [[FaceCamViewer alloc] initWithDeviceType:IPHONE3x5];
    [viewer startFaceCam];
    [self.view addSubview:viewer];
    
    //Usage with options
    /*
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    FaceCamViewer *viewer3 = [[FaceCamViewer alloc] initWithFrame:CGRectMake(190, 290, 120, 160)];
    //viewer3.cameraType = AVCaptureDevicePositionBack; //Optional.  Set to AVCaptureDevicePositionFront by default.
    //viewer3.session = session; //Optional
    viewer3.draggable = YES;
    [viewer3 startFaceCam];
    [self.view addSubview:viewer3];
    */ 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
