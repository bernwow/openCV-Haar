//
//  Neuron.m
//  OpenCV Haar
//
//  Created by Bern on 17.10.17.
//  Copyright © 2017 Bern. All rights reserved.
//

#import "Neuron.h"

@implementation Neuron

- (double)sigmoidFunction:(double)x{
    double y = 1.0 / (1.0 + exp(-x));

    return y;
}

- (double)activationFunction:(double)x { 
    return [self sigmoidFunction:x];
}

- (double)derivativeActivationFunction:(double)x {
    double y = [self sigmoidFunction:x] * (1 - [self sigmoidFunction:x]);
    
    return y;
}

- (double)neuronOutput:(NSArray<NSNumber*>*)input {
    double result = 0.0;
    for (int i = 0; i < self.weights.count; i++) {
        double value = input[i].doubleValue * self.weights[i].doubleValue;

        result += value;
    }
    return  [self activationFunction:result];
}

- (void)initNeuron:(NSArray<NSNumber*>*)weights {
    self.weights = weights;
}

@end
