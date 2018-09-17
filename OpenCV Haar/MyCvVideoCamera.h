//
//  MyCvVideoCamera.h
//  OpenCV Haar
//
//  Created by Bern on 19.10.17.
//  Copyright (c) 2017 Bern. All rights reserved.
//

#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

#import <opencv2/highgui/cap_ios.h>

@interface MyCvVideoCamera : CvVideoCamera <CvVideoCameraDelegate>

@end
