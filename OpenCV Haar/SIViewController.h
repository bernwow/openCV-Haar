//
//  SIViewController.h
//  OpenCV Haar
//
//  Created by Bern on 19.10.17.
//  Copyright (c) 2017 Bern. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

#import <opencv2/objdetect/objdetect.hpp>
#import <opencv2/highgui/cap_ios.h>

#import "MyCvVideoCamera.h"

@interface SIViewController : UIViewController <CvVideoCameraDelegate>

@end
