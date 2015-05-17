//
//  LCIntervalEndpoint.m
//  LCIntervalOrderedSet
//
//  Created by Tang Tianyong on 5/17/15.
//  Copyright (c) 2015 LeanCloud. All rights reserved.
//

#import "LCIntervalEndpoint.h"

@implementation LCIntervalEndpoint

- (int)orderWeight {
    if (self.open) {
        if (self.side == LCIntervalEndpointSideLeft) {
            return 3;
        } else {
            return 2;
        }
    } else {
        if (self.side == LCIntervalEndpointSideLeft) {
            return 1;
        } else {
            return 4;
        }
    }
}

- (NSComparisonResult)compare:(LCIntervalEndpoint *)other {
    if (self.value < other.value) {
        return NSOrderedAscending;
    } else if (self.value > other.value) {
        return NSOrderedDescending;
    } else {
        int a = [self orderWeight];
        int b = [other orderWeight];

        if (a < b) {
            return NSOrderedAscending;
        } else if (a > b) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }
}

- (instancetype)oppositeEndpoint {
    LCIntervalEndpointSide side = (
        self.side == LCIntervalEndpointSideLeft ?
        LCIntervalEndpointSideRight :
        LCIntervalEndpointSideLeft
    );

    return LCIntervalEndpointMake(self.value, side, !self.open);
}

@end
