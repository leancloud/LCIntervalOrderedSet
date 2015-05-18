//
//  LCIntervalTests.m
//  LCIntervalOrderedSet
//
//  Created by Tang Tianyong on 5/17/15.
//  Copyright (c) 2015 LeanCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LCIntervalOrderedSet.h"

@interface LCIntervalTests : XCTestCase

@end

@implementation LCIntervalTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUnionTwoSiblingIntervals_1 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(2, 3, NO, NO)];
    [orderedSet unionInterval:LCIntervalMake(3, 4, YES, YES)];

    NSArray *result = @[LCIntervalMake(2, 4, NO, YES)];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];

    XCTAssert(OK, @"Pass");
}

- (void)testUnionTwoSiblingIntervals_2 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(2, 3, NO, YES)];
    [orderedSet unionInterval:LCIntervalMake(3, 4, NO, YES)];

    NSArray *result = @[LCIntervalMake(2, 4, NO, YES)];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];

    XCTAssert(OK, @"Pass");
}

- (void)testUnionTwoSiblingIntervals_3 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(2, 3, NO, YES)];
    [orderedSet unionInterval:LCIntervalMake(3, 4, YES, YES)];

    NSArray *result = @[
        LCIntervalMake(2, 3, NO, YES),
        LCIntervalMake(3, 4, YES, YES)
    ];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];

    XCTAssert(OK, @"Pass");
}

- (void)testUnionTwoEqualIntervals_1 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(2, 3, NO, YES)];
    [orderedSet unionInterval:LCIntervalMake(2, 3, NO, YES)];

    NSArray *result = @[LCIntervalMake(2, 3, NO, YES)];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];
    
    XCTAssert(OK, @"Pass");
}

- (void)testUnionTwoEqualIntervals_2 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(2, 3, YES, YES)];
    [orderedSet unionInterval:LCIntervalMake(2, 3, YES, YES)];

    NSArray *result = @[LCIntervalMake(2, 3, YES, YES)];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];

    XCTAssert(OK, @"Pass");
}

- (void)testUnionTwoEqualIntervals_3 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(2, 3, NO, NO)];
    [orderedSet unionInterval:LCIntervalMake(2, 3, NO, NO)];

    NSArray *result = @[LCIntervalMake(2, 3, NO, NO)];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];

    XCTAssert(OK, @"Pass");
}

- (void)testUnionTwoContainedIntervals_1 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(2, 5, NO, YES)];
    [orderedSet unionInterval:LCIntervalMake(3, 4, YES, YES)];

    NSArray *result = @[LCIntervalMake(2, 5, NO, YES)];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];
    
    XCTAssert(OK, @"Pass");
}

- (void)testMinusIntervals_1 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(2, 5, NO, YES)];
    [orderedSet minusInterval:LCIntervalMake(3, 4, YES, YES)];

    NSArray *result = @[
        LCIntervalMake(2, 3, NO, NO),
        LCIntervalMake(4, 5, NO, YES)
    ];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];

    XCTAssert(OK, @"Pass");
}

- (void)testMinusIntervals_2 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(1, 5, NO, YES)];
    [orderedSet minusInterval:LCIntervalMake(2, 2, NO, NO)];
    [orderedSet minusInterval:LCIntervalMake(3, 3, NO, NO)];
    [orderedSet minusInterval:LCIntervalMake(4, 4, NO, NO)];
    [orderedSet minusInterval:LCIntervalMake(2, 2, NO, NO)];

    NSArray *result = @[
        LCIntervalMake(1, 2, NO, YES),
        LCIntervalMake(2, 3, YES, YES),
        LCIntervalMake(3, 4, YES, YES),
        LCIntervalMake(4, 5, YES, YES)
    ];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];
    
    XCTAssert(OK, @"Pass");
}

- (void)testMinusIntervals_3 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet minusInterval:LCIntervalMake(3, 4, YES, YES)];

    NSArray *result = @[];

    BOOL OK = [[orderedSet intervals] isEqualToArray:result];

    XCTAssert(OK, @"Pass");
}

- (void)testMinusIntervals_4 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(0, 0, NO, NO)];
    [orderedSet unionInterval:LCIntervalMake(1431081013310, 1431445421462, NO, NO)];
    [orderedSet unionInterval:LCIntervalMake(1431484896980, 1431747522850, NO, NO)];
    [orderedSet minusInterval:LCIntervalMake(0, 0, NO, NO)];

    NSArray *result = [orderedSet intervals];

    BOOL OK = [result isEqualToArray:@[
        LCIntervalMake(1431081013310, 1431445421462, NO, NO),
        LCIntervalMake(1431484896980, 1431747522850, NO, NO)
    ]];

    XCTAssert(OK, @"Pass");
}

- (void)testMinusIntervals_5 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    [orderedSet unionInterval:LCIntervalMake(0, 0, NO, NO)];
    [orderedSet unionInterval:LCIntervalMake(3, 6, NO, NO)];
    [orderedSet unionInterval:LCIntervalMake(20, 30, NO, NO)];
    [orderedSet minusInterval:LCIntervalMake(5, 24, NO, NO)];

    NSArray *result = [orderedSet intervals];

    BOOL OK = [result isEqualToArray:@[
        LCIntervalMake(0, 0, NO, NO),
        LCIntervalMake(3, 5, NO, YES),
        LCIntervalMake(24, 30, YES, NO)
    ]];

    XCTAssert(OK, @"Pass");
}

- (void)testArchivement_1 {
    LCInterval *interval = LCIntervalMake(1, 2, NO, NO);

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:interval];

    LCInterval *newInterval = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    BOOL OK = [interval isEqual:newInterval];

    XCTAssert(OK, @"Pass");
}

- (void)testArchivement_2 {
    NSArray *intervals = @[LCIntervalMake(1, 2, NO, NO)];

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:intervals];

    NSArray *newIntervals = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    BOOL OK = [intervals isEqualToArray:newIntervals];

    XCTAssert(OK, @"Pass");
}

- (void)testContain_1 {
    LCInterval *interval1 = LCIntervalMake(2, 5, YES, YES);
    LCInterval *interval2 = LCIntervalMake(2, 5, YES, YES);

    BOOL OK = [interval1 contain:interval2];

    XCTAssert(OK, @"Pass");
}

- (void)testContain_2 {
    LCInterval *interval1 = LCIntervalMake(2, 5, NO, YES);
    LCInterval *interval2 = LCIntervalMake(2, 5, NO, YES);

    BOOL OK = [interval1 contain:interval2];

    XCTAssert(OK, @"Pass");
}

- (void)testContain_3 {
    LCInterval *interval1 = LCIntervalMake(2, 5, YES, YES);
    LCInterval *interval2 = LCIntervalMake(2, 5, NO, YES);

    BOOL notOK = [interval1 contain:interval2];

    XCTAssertFalse(notOK, @"Pass");
}

- (void)testContain_4 {
    LCIntervalOrderedSet *orderedSet = [[LCIntervalOrderedSet alloc] init];

    LCInterval *interval1 = LCIntervalMake(2, 5, NO, YES);

    [orderedSet unionInterval:interval1];

    LCInterval *interval2 = LCIntervalMake(2, 5, NO, YES);

    BOOL OK = [interval1 contain:interval2];

    XCTAssert(OK, @"Pass");
}

@end
