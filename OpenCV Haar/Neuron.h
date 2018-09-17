//
//  Neuron.h
//  OpenCV Haar
//
//  Created by Bern on 17.10.17.
//  Copyright © 2017 Bern. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Neuron : NSObject

@property (nonatomic, strong) NSMutableArray<NSNumber*>* weights;
@property double delta;
@property double inputCache;
@property double learningRate;

- (double)activationFunction:(double)x;
- (double)derivativeActivationFunction:(double)x;

- (double)neuronOutput:(NSArray<NSNumber*>*)input;

- (void)initNeuron:(NSArray<NSNumber*>*)weights;

@end
