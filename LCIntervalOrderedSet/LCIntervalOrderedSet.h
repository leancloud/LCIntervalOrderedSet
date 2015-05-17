//
//  LCIntervalOrderedSet.h
//  LCIntervalOrderedSet
//
//  Created by Tang Tianyong on 5/16/15.
//  Copyright (c) 2015 LeanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCInterval.h"

@interface LCIntervalOrderedSet : NSObject

- (instancetype)initWithIntervals:(NSArray *)intervals;

/*!
 * Minus an interval from current union intervals
 * For example:
 *     [2, 5] + (5, 7) + (7, 9] = [2, 7) + (7, 9]
 */
- (void)minusInterval:(LCInterval *)interval;

/*!
 * Union an interval into current union intervals
 * For example:
 *     [2, 9] - [4, 6] = [2, 4) + (6, 9]
 */
- (void)unionInterval:(LCInterval *)interval;

- (NSArray *)intervals;

@end
