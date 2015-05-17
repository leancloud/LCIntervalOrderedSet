//
//  LCIntervalOrderedSet.m
//  LCIntervalOrderedSet
//
//  Created by Tang Tianyong on 5/16/15.
//  Copyright (c) 2015 LeanCloud. All rights reserved.
//

#import "LCIntervalOrderedSet.h"
#import "LCIntervalEndpoint.h"

@interface LCIntervalOrderedSet ()

@property (strong) NSMutableArray *sortedIntervals;

@end

@implementation LCIntervalOrderedSet

- (instancetype)init {
    self = [super init];

    if (self) {
        _sortedIntervals = [NSMutableArray array];
    }

    return self;
}

- (instancetype)initWithIntervals:(NSArray *)intervals {
    self = [super init];

    if (self) {
        for (LCInterval *interval in intervals) {
            [self unionInterval:interval];
        }
    }

    return self;
}

- (NSMutableArray *)allEndpoints {
    NSMutableArray *endpoints = [NSMutableArray array];

    for (LCInterval *interval in self.sortedIntervals) {
        if (![interval empty]) {
            [endpoints addObjectsFromArray:[interval endpoints]];
        }
    }

    return endpoints;
}

- (LCInterval *)intervalFromEndpoints:(NSArray *)endpoints {
    LCIntervalEndpoint *le = [endpoints firstObject];
    LCIntervalEndpoint *re = [endpoints lastObject];

    return LCIntervalMake(le.value, re.value, le.open, re.open);
}

- (NSMutableArray *)sortedIntervalsFromEndpoints:(NSArray *)endpoints {
    NSInteger lc = 0, rc = 0, start = 0, idx = 0;
    NSMutableArray *intervals = [NSMutableArray array];

    for (LCIntervalEndpoint *endpoint in endpoints) {
        switch (endpoint.side) {
            case LCIntervalEndpointSideLeft:  lc += 1; break;
            case LCIntervalEndpointSideRight: rc += 1; break;
            default: break;
        }

        if (lc == rc) {
            [intervals addObject:[self intervalFromEndpoints:@[endpoints[start], endpoint]]];
        }

        if (lc <= rc) {
            start = idx + 1;
            lc = rc = 0;
        }

        idx += 1;
    }

    return intervals;
}

- (void)minusInterval:(LCInterval *)interval {
    if (!interval || [interval empty])
        return;

    NSMutableArray *allEndpoints = [self allEndpoints];

    NSArray *endpoints = [interval endpoints];

    [allEndpoints addObjectsFromArray:endpoints];
    [allEndpoints sortUsingSelector:@selector(compare:)];

    LCIntervalEndpoint *le = [endpoints firstObject];
    LCIntervalEndpoint *re = [endpoints lastObject];

    [allEndpoints insertObject:[le oppositeEndpoint]
                       atIndex:[allEndpoints indexOfObject:le]];

    [allEndpoints insertObject:[re oppositeEndpoint]
                       atIndex:[allEndpoints indexOfObject:re] + 1];

    NSUInteger start = [allEndpoints indexOfObject:le];
    NSUInteger end   = [allEndpoints indexOfObject:re];

    [allEndpoints removeObjectsInRange:NSMakeRange(start, end - start + 1)];

    NSMutableArray *sortedIntervals = [self sortedIntervalsFromEndpoints:allEndpoints];

    self.sortedIntervals = sortedIntervals;
}

- (void)unionInterval:(LCInterval *)interval {
    if (!interval || [interval empty])
        return;

    NSMutableArray *allEndpoints = [self allEndpoints];

    [allEndpoints addObjectsFromArray:[interval endpoints]];
    [allEndpoints sortUsingSelector:@selector(compare:)];

    NSMutableArray *sortedIntervals = [self sortedIntervalsFromEndpoints:allEndpoints];

    self.sortedIntervals = sortedIntervals;
}

- (BOOL)containInterval:(LCInterval *)interval {
    for (LCInterval *subInterval in self.sortedIntervals) {
        if ([subInterval contain:interval]) {
            return YES;
        }
    }

    return NO;
}

- (NSArray *)intervals {
    return [self.sortedIntervals copy];
}

@end
