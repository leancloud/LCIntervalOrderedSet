//
//  LCInterval.m
//  LCIntervalOrderedSet
//
//  Created by Tang Tianyong on 5/17/15.
//  Copyright (c) 2015 LeanCloud. All rights reserved.
//

#import "LCInterval.h"
#import "LCIntervalEndpoint.h"

#define LC_KEY_LVALUE @"lvalue"
#define LC_KEY_RVALUE @"rvalue"
#define LC_KEY_LOPEN  @"lopen"
#define LC_KEY_ROPEN  @"ropen"

@implementation LCInterval

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeDouble:_lvalue forKey:LC_KEY_LVALUE];
    [encoder encodeDouble:_rvalue forKey:LC_KEY_RVALUE];
    [encoder encodeBool:_lopen forKey:LC_KEY_LOPEN];
    [encoder encodeBool:_ropen forKey:LC_KEY_ROPEN];
}

- (id)initWithCoder:(NSCoder *)decoder {
    double lvalue = [decoder decodeDoubleForKey:LC_KEY_LVALUE];
    double rvalue = [decoder decodeDoubleForKey:LC_KEY_RVALUE];
    BOOL   lopen  = [decoder decodeBoolForKey:LC_KEY_LOPEN];
    BOOL   ropen  = [decoder decodeBoolForKey:LC_KEY_ROPEN];

    return LCIntervalMake(lvalue, rvalue, lopen, ropen);
}

- (NSArray *)endpoints {
    return @[
        [self leftEndpoint],
        [self rightEndpoint]
    ];
}

- (LCIntervalEndpoint *)leftEndpoint {
    return LCIntervalEndpointMake(self.lvalue, LCIntervalEndpointSideLeft,  self.lopen);
}

- (LCIntervalEndpoint *)rightEndpoint {
    return LCIntervalEndpointMake(self.rvalue, LCIntervalEndpointSideRight, self.ropen);
}

- (BOOL)empty {
    if (self.lvalue < self.rvalue) {
        return NO;
    } else if (self.lvalue == self.rvalue) {
        if (!self.lopen && !self.ropen) {
            return NO;
        }
    }

    return YES;
}

- (BOOL)contain:(LCInterval *)other {
    if (self.lvalue <= other.lvalue && self.rvalue >= other.lvalue) {
        if ((self.lvalue < other.lvalue || !(self.lopen && !other.lopen)) &&
            (self.rvalue < other.rvalue || !(self.ropen && !other.ropen))) {
            return YES;
        }
    }

    return NO;
}

- (BOOL)isEqual:(LCInterval *)other {
    return (
        self.lvalue == other.lvalue &&
        self.rvalue == other.rvalue &&
        self.lopen == other.lopen &&
        self.ropen == other.ropen
    );
}

@end
