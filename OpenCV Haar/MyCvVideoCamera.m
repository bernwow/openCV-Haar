//
//  MyCvVideoCamera.m
//  OpenCV Haar
//
//  Created by Bern on 19.10.17.
//  Copyright (c) 2017 Bern. All rights reserved.
//

#import "MyCvVideoCamera.h"

@implementation MyCvVideoCamera

- (void)updateOrientation;
{
    self->customPreviewLayer.bounds = CGRectMake(0, 0, self.parentView.frame.size.width, self.parentView.frame.size.width * 11 / 9);
    [self layoutPreviewLayer];
}

- (void)layoutPreviewLayer;
{
    if (self.parentView != nil)
    {
        CALayer* layer = self->customPreviewLayer;
        CGRect bounds = self->customPreviewLayer.bounds;
        int rotation_angle = 0;

        layer.position = CGPointMake(self.parentView.frame.size.width/2., self.parentView.frame.size.width * 11 / 9 / 2.0 + 20);
        layer.affineTransform = CGAffineTransformMakeRotation( DEGREES_RADIANS(rotation_angle) );
        layer.bounds = bounds;
    }
}

@end
