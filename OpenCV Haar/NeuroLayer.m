//
//  NeuroLayer.m
//  OpenCV Haar
//
//  Created by Bern on 19.10.17.
//  Copyright © 2017 Bern. All rights reserved.
//

#import "NeuroLayer.h"

@implementation NeuroLayer

- (NSArray<NSNumber *> *)layerOutput:(NSArray<NSNumber *> *) inputs{
    if (!self.previousLayer) {
        self.layerOutputCache = inputs;
        return inputs;
    } else {
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        for (Neuron* neuron in self.neurons) {
            [resultArray addObject:@([neuron neuronOutput:inputs])];
        }
        self.layerOutputCache = resultArray;
        return resultArray;
    }
    
    return @[@0];
}

- (void)initWith:(NSArray<Neuron *> *)neurons previousLayer:(NeuroLayer*)previousLayer{
    self.previousLayer = previousLayer;
    self.neurons = neurons;
}

- (void)calculateDeltasForOutputLayer:(NSArray<NSNumber *> *)expected {
    for (int i=0; i<self.neurons.count; i++) {
        self.neurons[i].delta = [self.neurons[i] derivativeActivationFunction:self.neurons[i].inputCache] * (expected[i].doubleValue - self.layerOutputCache[i].doubleValue);
    }
}

- (void)calculateDeltasForHiddenLayer:(NeuroLayer *)nextLayer { 
    for (int i=0; i<self.neurons.count; i++) {
        Neuron *neuron = self.neurons[i];
        double sumOfWeightsXDeltas = 0;
        for (Neuron* nextLayerNeuron in nextLayer.neurons) {
            sumOfWeightsXDeltas += [nextLayerNeuron delta] * nextLayerNeuron.weights[i].doubleValue;
        }
        neuron.delta = [neuron derivativeActivationFunction:neuron.inputCache] * sumOfWeightsXDeltas;
    }
}

@end
