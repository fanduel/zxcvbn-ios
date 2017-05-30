//
//  DBDelegatingMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBDelegatingMatcher.h"

#import "DBFakeMatcher.h"
#import "DBMatch.h"

@interface DBDelegatingMatcherTests : XCTestCase

@end

@implementation DBDelegatingMatcherTests

- (void)test_matchesForPassword_DelegateNotSet_ReturnsNoMatches {
    DBDelegatingMatcher *sut = [self createDelegatingMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"password"];

    XCTAssertNotNil(result);
    XCTAssertEqual(0, result.count);
}


- (void)test_matchesForPassword_DelegateIsSet_ReturnsMatchesForPasswordFromDelegate {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    [stubMatcher setMatchesForAnyPassword:@[expectedMatch]];
    DBDelegatingMatcher *sut = [self createDelegatingMatcher];
    sut.delegate = stubMatcher;

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"password"];

    XCTAssertEqual(1, result.count);
    XCTAssertEqual(expectedMatch, result[0]);
}

- (DBFakeMatcher *)createFakeMatcher {
    return [[DBFakeMatcher alloc] init];
}

- (DBDelegatingMatcher *)createDelegatingMatcher {
    return [[DBDelegatingMatcher alloc] init];
}

@end
