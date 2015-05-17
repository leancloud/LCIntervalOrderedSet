//
//  LCInterval.h
//  LCIntervalOrderedSet
//
//  Created by Tang Tianyong on 5/17/15.
//  Copyright (c) 2015 LeanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCInterval;

@interface LCInterval : NSObject <NSCoding>

@property (assign) double lvalue;
@property (assign) double rvalue;
@property (assign) BOOL   lopen;
@property (assign) BOOL   ropen;

@property (readonly) NSArray *endpoints;
@property (readonly) BOOL empty;

- (BOOL)isEqual:(LCInterval *)other;

@end

NS_INLINE
LCInterval *LCIntervalMake(double lvalue, double rvalue, BOOL lopen, BOOL ropen)
{
    LCInterval *interval = [[LCInterval alloc] init];

    interval.lvalue = lvalue;
    interval.rvalue = rvalue;
    interval.lopen  = lopen;
    interval.ropen  = ropen;

    return interval;
}
