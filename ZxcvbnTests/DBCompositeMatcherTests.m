//
//  DBCompositeMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBCompositeMatcher.h"

#import "DBMatch.h"
#import "DBFakeMatcher.h"

@interface DBCompositeMatcherTests : XCTestCase

@end

@implementation DBCompositeMatcherTests

- (void)test_matchesForPassword_ProvidedNoMatchers_ReturnsEmptyArray {
    DBCompositeMatcher *sut = [self createCompositeMatcherWithMatchers:@[]];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"password"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_ProvidedMatcher_ReturnsMatchesForPasswordFromMatcher {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    [stubMatcher setMatchesForPasswords:@{ @"password" : @[expectedMatch] }];
    DBCompositeMatcher *sut = [self createCompositeMatcherWithMatchers:@[stubMatcher]];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"password"];

    XCTAssertEqual(1, result.count);
    XCTAssertEqualObjects(expectedMatch, result[0]);
}

- (void)test_matchesForPassword_ProvidedMultipleMatchers_ReturnsMatchesForPasswordFromMatchers {
    DBMatch *expectedFirstMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubFirstMatcher = [self createFakeMatcher];
    [stubFirstMatcher setMatchesForPasswords:@{ @"password" : @[expectedFirstMatch] }];
    DBMatch *rejectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubSecondMatcher = [self createFakeMatcher];
    [stubSecondMatcher setMatchesForPasswords:@{ @"zxcvbn" : @[rejectedMatch] }];
    DBMatch *expectedSecondMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubThirdMatcher = [self createFakeMatcher];
    [stubThirdMatcher setMatchesForPasswords:@{ @"password" : @[expectedSecondMatch] }];
    DBCompositeMatcher *sut = [self createCompositeMatcherWithMatchers:@[stubFirstMatcher, stubSecondMatcher, stubThirdMatcher]];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"password"];

    XCTAssertEqual(2, result.count);
    XCTAssertEqualObjects(expectedFirstMatch, result[0]);
    XCTAssertEqualObjects(expectedSecondMatch, result[1]);
}

- (DBFakeMatcher *)createFakeMatcher {
    return [[DBFakeMatcher alloc] init];
}

- (DBCompositeMatcher *)createCompositeMatcherWithMatchers:(NSArray<id<DBMatching>> *)matchers {
    return [[DBCompositeMatcher alloc] initWithMatchers:matchers];
}

@end
