//
//  DBMatcherCacheTests.m
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBMatcherCache.h"

#import "DBFakeMatcher.h"

@interface DBMatcherCacheTests : XCTestCase

@end

@implementation DBMatcherCacheTests

- (void)test_matchesForPassword_MatchesNotPreviouslyCalculatedForPassword_ObtainsMatchesFromProvidedMatcher {
    DBFakeMatcher *mockMatcher = [self createFakeMatcher];
    DBMatcherCache *sut = [self createMatcherCacheWithMatcher:mockMatcher];

    [sut matchesForPassword:@"password"];

    XCTAssertTrue([mockMatcher didCallMatchesForPassword:@"password"]);
}

- (void)test_matchesForPassword_MatchesPreviouslyCalculatedForPassword_DoesNotRepeatedlyObtainMatchesFromProvidedMatcher {
    DBFakeMatcher *mockMatcher = [self createFakeMatcher];
    DBMatcherCache *sut = [self createMatcherCacheWithMatcher:mockMatcher];
    [sut matchesForPassword:@"password"];

    [sut matchesForPassword:@"password"];

    XCTAssertEqual(1, [mockMatcher matchesForPasswordCalledWithPasswords].count);
}

- (void)test_matchesForPassword_TheSamePasswordTwice_ReturnsTheSameMatch {
    DBFakeMatcher *mockMatcher = [self createFakeMatcher];
    DBMatcherCache *sut = [self createMatcherCacheWithMatcher:mockMatcher];

    NSArray<DBMatch *> *firstResult = [sut matchesForPassword:@"password"];
    NSArray<DBMatch *> *secondResult = [sut matchesForPassword:@"password"];

    XCTAssertTrue([firstResult isEqualToArray:secondResult]);
}

- (void)test_matchesForPassword_ReceivesMultiplePasswords_ObtainsEachPasswordOnceFromProvidedMatcher {
    DBFakeMatcher *mockMatcher = [self createFakeMatcher];
    DBMatcherCache *sut = [self createMatcherCacheWithMatcher:mockMatcher];

    [sut matchesForPassword:@"first"];
    [sut matchesForPassword:@"second"];
    [sut matchesForPassword:@"second"];
    [sut matchesForPassword:@"first"];
    [sut matchesForPassword:@"third"];
    [sut matchesForPassword:@"second"];
    [sut matchesForPassword:@"first"];

    XCTAssertEqual(3, [mockMatcher matchesForPasswordCalledWithPasswords].count);
    XCTAssertTrue([[mockMatcher matchesForPasswordCalledWithPasswords] containsObject:@"first"]);
    XCTAssertTrue([[mockMatcher matchesForPasswordCalledWithPasswords] containsObject:@"second"]);
    XCTAssertTrue([[mockMatcher matchesForPasswordCalledWithPasswords] containsObject:@"third"]);
}

- (DBFakeMatcher *)createFakeMatcher {
    return [[DBFakeMatcher alloc] init];
}

- (DBMatcherCache *)createMatcherCacheWithMatcher:(id<DBMatching>)matcher {
    NSCache *cache = [[NSCache alloc] init];
    return [[DBMatcherCache alloc] initWithMatcher:matcher cache:cache];
}

@end
