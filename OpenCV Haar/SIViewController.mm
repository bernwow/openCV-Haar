//
//  SIViewController.m
//  OpenCV Haar
//
//  Created by Bern on 19.10.17.
//  Copyright (c) 2017 Bern. All rights reserved.
//

#import "SIViewController.h"

#import "NeuroNetwork.h"

using namespace cv;

@interface SIViewController () {
    MyCvVideoCamera *videoCamera;
    NeuroNetwork *network;
}

@property (strong, nonatomic) NSString *cascadeFile;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SIViewController

cv::CascadeClassifier cascade;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cascadeFile = @"haarcascade_smile.xml";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    network = [[NeuroNetwork alloc] init];
    [network initNeuroNetwork];

    for (int i = 0; i<500; i++) {
        [network train:trainingPatterns expected:expectedResults];
    }
    NSString *smilesCascadePath = [[NSBundle mainBundle] pathForResource:_cascadeFile ofType:@"xml"];
    
    if (!cascade.load([smilesCascadePath UTF8String])) {
         NSLog(@"Could not load face cascade: %@", smilesCascadePath);
    }

    
    videoCamera = [[MyCvVideoCamera alloc] initWithParentView:self.view];
    videoCamera.delegate = self;
    videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    videoCamera.defaultFPS = 30;
    
    [videoCamera start];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

vector<cv::Rect> detectAndDisplay( Mat frame )
{
    BOOL smileFound = false;
    vector<cv::Rect> smiles;
    Mat frame_gray;
    
    cvtColor(frame, frame_gray, CV_BGRA2GRAY);
    equalizeHist(frame_gray, frame_gray);
    
    cascade.detectMultiScale(frame_gray, smiles, 1.1, 2, 0 | CV_HAAR_FIND_BIGGEST_OBJECT, cv::Size(100, 100));

    for(unsigned int i = 0; i < smiles.size(); ++i) {
        rectangle(frame, cv::Point(smiles[i].x, smiles[i].y),
                  cv::Point(smiles[i].x + smiles[i].width, smiles[i].y + smiles[i].height),
                  cv::Scalar(0,255,255));
        smileFound = true;
    }
    
    return smiles;
}


#ifdef __cplusplus

-(void)processImage:(cv::Mat &)image {
    vector<cv::Rect> vector = detectAndDisplay(image);
    for (unsigned int i = 0; i < vector.size(); ++i) {
        NSLog(@"%ld",vector.size());
    }
}

#endif




@end
