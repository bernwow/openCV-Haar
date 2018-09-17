//
//  NeuroLayer.h
//  OpenCV Haar
//
//  Created by Bern on 19.10.17.
//  Copyright © 2017 Bern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Neuron.h"
@interface NeuroLayer : NSObject

@property (nonatomic, strong) NeuroLayer* previousLayer;
@property (nonatomic, strong) NSArray<Neuron*>* neurons;
@property (nonatomic, strong) NSArray<NSNumber*>* layerOutputCache;

- (NSArray<NSNumber *> *)layerOutput:(NSArray<NSNumber *> *) inputs;
- (void)initWith:(NSArray<Neuron*>*)neurons previousLayer:(NeuroLayer*)previousLayer;
- (void)calculateDeltasForOutputLayer:(NSArray<NSNumber *> *) expected;
- (void)calculateDeltasForHiddenLayer:(NeuroLayer *) nextLayer;
@end
