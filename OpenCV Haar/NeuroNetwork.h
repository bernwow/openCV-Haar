//
//  NeuroNetwork.h
//  OpenCV Haar
//
//  Created by Bern on 19.10.17.
//  Copyright © 2017 Bern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NeuroLayer.h"

#define trainingPatterns @[@[@0,@0,@0],@[@0,@0,@1],@[@0,@1,@0],@[@0,@1,@1],@[@1,@0,@0],@[@1,@0,@1],@[@1,@1,@0],@[@1,@1,@1]]
#define expectedResults @[@[@0],@[@1],@[@0],@[@0],@[@1],@[@1],@[@0],@[@1]]

@interface NeuroNetwork : NSObject

@property (nonatomic,strong) NSMutableArray<NeuroLayer*>* layers;
@property int runsCount;
- (void)initNeuroNetwork;
- (NSArray<NSNumber*>*)output:(NSArray<NSNumber*>*)input;
- (void)backwardPropagationMethod:(NSArray<NSNumber*>*)expected;
- (void)updateWeightsAfterLearn;
- (void)train:(NSArray<NSArray<NSNumber*>*>*)inputs expected:(NSArray<NSArray<NSNumber*>*>*)expecteds;
@end
