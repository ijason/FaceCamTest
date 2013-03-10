FaceCamViewer
=====================

**Displays a live camera feed similar to FaceTime.**

![FaceCamViewer Example](http://ijasoneverett.com/assets/img/FaceCamViewer.png)

## Requirements

* AVFoundation.framework
* QuartzCore.framework

## Usage

Copy FaceCamViewer.h and FaceCamViewer.m into your project.

Import `#import "FaceCamViewer.h"` where you want to display the camera feed.

Basic Implementation: 

```smalltalk
FaceCamViewer *viewer = [[FaceCamViewer alloc] initWithDeviceType:IPHONE3x5];
[viewer startFaceCam];
[self.view addSubview:viewer];
```

Implementation with options:

```smalltalk
FaceCamViewer *viewer3 = [[FaceCamViewer alloc] initWithFrame:CGRectMake(190, 290, 120, 160)];
viewer3.cameraType = AVCaptureDevicePositionBack;

AVCaptureSession *session = [[AVCaptureSession alloc] init];
viewer3.session = session; 

viewer3.draggable = YES;

[viewer3 startFaceCam];
[self.view addSubview:viewer3];
```

## Options

initWithDeviceType - sets predetermined camera view frame
* IPHONE3x5
* IPHONE4
* IPAD


cameraType (*Optional*)
* AVCaptureDevicePositionFront (*default*)
* AVCaptureDevicePositionBack


session (*Optional*) - sets AVCaptureSession

draggable (*Optional*) - allows view to be draggable

## Contact

Jason Everett

- https://github.com/ijason
- http://twitter.com/ijayson66

##License
MIT License - fork, modify and use however you want.