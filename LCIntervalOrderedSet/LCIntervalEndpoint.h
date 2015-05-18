//
//  LCIntervalEndpoint.h
//  LCIntervalOrderedSet
//
//  Created by Tang Tianyong on 5/17/15.
//  Copyright (c) 2015 LeanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LCIntervalEndpointSide) {
    LCIntervalEndpointSideLeft,
    LCIntervalEndpointSideRight
};

@interface LCIntervalEndpoint : NSObject

@property (assign) double value;
@property (assign) LCIntervalEndpointSide side;
@property (assign) BOOL open;

- (BOOL)isEqual:(LCIntervalEndpoint *)other;

- (instancetype)oppositeEndpoint;

@end

NS_INLINE
LCIntervalEndpoint *LCIntervalEndpointMake(double value, LCIntervalEndpointSide side, BOOL open)
{
    LCIntervalEndpoint *endpoint = [[LCIntervalEndpoint alloc] init];

    endpoint.value = value;
    endpoint.side  = side;
    endpoint.open  = open;

    return endpoint;
}
