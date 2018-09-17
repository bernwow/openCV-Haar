//
//  NeuroNetwork.m
//  OpenCV Haar
//
//  Created by Bern on 19.10.17.
//  Copyright © 2017 Bern. All rights reserved.
//

#import "NeuroNetwork.h"

#define networkConfig @[@3,@4,@1];
#define learningRate 0.5

@implementation NeuroNetwork

- (void)initNeuroNetwork { 
    self.layers = [[NSMutableArray alloc] init];
    NSArray<NSNumber*> *netConf = networkConfig;
    for (int i=0; i<netConf.count; i++) {
        NeuroLayer *layer = [[NeuroLayer alloc] init];
        NSMutableArray *neurons = [[NSMutableArray alloc] init];
        for (int j = 0; j<netConf[i].doubleValue; j++) {
            Neuron *neuron = [[Neuron alloc] init];
            NSMutableArray *neuronWeights = [[NSMutableArray alloc] init];
            long previousLayerOutputs = 0;
            if (i == 0) {
                previousLayerOutputs = 1;
            } else {
                previousLayerOutputs = self.layers[i-1].neurons.count;
            }
            for (int q = 0; q < previousLayerOutputs; q++) {
                [neuronWeights addObject:[NSNumber numberWithDouble:arc4random() * 1.0 / (INT_MAX * 1.0)]];
            }
            [neuron initNeuron:neuronWeights];
            [neurons addObject:neuron];
        }
        NeuroLayer *previousLayer;
        if (i > 0) {
            previousLayer = self.layers[i-1];
        }
        [layer initWith:neurons previousLayer:previousLayer];
        [self.layers addObject:layer];
    }
}

- (NSArray<NSNumber*>*)output:(NSArray<NSNumber*>*)input {
    NSArray<NSNumber*>* newInput = input;
    for (NeuroLayer* layer in self.layers) {
        newInput = [layer layerOutput:newInput];
    }
    return newInput;
}

- (void)backwardPropagationMethod:(NSArray<NSNumber*>*)expected {
    [self.layers.lastObject calculateDeltasForOutputLayer:expected];
    for (long i = self.layers.count - 2; i >= 0; i--) {
        [self.layers[i] calculateDeltasForHiddenLayer:self.layers[i + 1]];
    }
}

- (void)updateWeightsAfterLearn {
    for (NeuroLayer *layer in self.layers) {
        for (Neuron *neuron in layer.neurons) {
            for (int w = 0; w < neuron.weights.count; w++) {
                double difference = layer.previousLayer.layerOutputCache[w].doubleValue * neuron.delta;
                NSNumber *newWeight = @(neuron.weights[w].doubleValue + (learningRate * difference));
                [neuron.weights replaceObjectAtIndex:w withObject:newWeight];
            }
        }
    }
}

- (void)train:(NSArray<NSArray<NSNumber*>*>*)inputs expected:(NSArray<NSArray<NSNumber*>*>*)expecteds {
    double averageLoss = 0;
    for (int i = 0; i < inputs.count; i++) {
        double meanSquaredError = 0;
        NSArray<NSNumber*> *expectedOutputs = expecteds[i];
        NSArray<NSNumber*> *currentOutputs = [self output:inputs[i]];
                
        NSMutableArray<NSNumber*> *diffrencesBetweenCurrentAndExpected = [[NSMutableArray alloc] init];
        for (int j = 0; j < expectedOutputs.count; j++) {

            meanSquaredError += sqrt((currentOutputs[j].doubleValue - expectedOutputs[j].doubleValue) * (currentOutputs[j].doubleValue - expectedOutputs[j].doubleValue));
            [diffrencesBetweenCurrentAndExpected addObject:@( currentOutputs[j].doubleValue - expectedOutputs[j].doubleValue )];
        }
        averageLoss += meanSquaredError / inputs.count;
        [self backwardPropagationMethod:expectedOutputs];
        [self updateWeightsAfterLearn];
    }
    NSLog(@"%d)Training loss %f",self.runsCount,averageLoss);
    self.runsCount += 1;
}

@end
