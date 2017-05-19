//
//  DBBruteForceMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 19/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBBruteForceMatcher.h"

#import "DBBruteForceMatch.h"

@interface DBBruteForceMatcherTests : XCTestCase

@end

@implementation DBBruteForceMatcherTests

- (void)test_matchesForPassword_ProvidedPassword_ReturnsSingleMatch {
    DBBruteForceMatcher *sut = [self createMatcher];

    NSArray<DBBruteForceMatch *> *result = [sut matchesForPassword:@"avuinmef"];

    XCTAssertEqual(1, result.count);
}

- (void)test_matchesForPassword_ProvidedEmptyPassword_ReturnsZeroResults {
    DBBruteForceMatcher *sut = [self createMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@""];

    XCTAssertNotNil(result);
    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_ProvidedPassword_SetsValueForTokenToProvidedPassword {
    DBBruteForceMatcher *sut = [self createMatcher];

    NSArray<DBBruteForceMatch *> *result = [sut matchesForPassword:@"linjepir"];

    DBBruteForceMatch *match = result.firstObject;
    XCTAssertEqual(@"linjepir", match.token);
}

- (void)test_matchesForPassword_ProvidedPassword_SetsValueForiToZero {
    DBBruteForceMatcher *sut = [self createMatcher];

    NSArray<DBBruteForceMatch *> *result = [sut matchesForPassword:@"bujkwbeg"];

    DBBruteForceMatch *match = result.firstObject;
    XCTAssertEqual(0, match.i);
}

- (void)test_matchesForPassword_ProvidedPassword_SetsValueForjToIndexOfLastCharacterInProvidedPassword {
    DBBruteForceMatcher *sut = [self createMatcher];
    
    NSArray<DBBruteForceMatch *> *result = [sut matchesForPassword:@"pvyqjecvis"];
    
    DBBruteForceMatch *match = result.firstObject;
    XCTAssertEqual(9, match.j);
}

- (void)test_matchesForPassword_ProvidedPassword_SetsValueForCardinalityToValueProvidedToInitializer {
    DBBruteForceMatcher *sut = [[DBBruteForceMatcher alloc] initWithCardinality:26];

    NSArray<DBBruteForceMatch *> *result = [sut matchesForPassword:@"jsudfg"];

    DBBruteForceMatch *match = result.firstObject;
    XCTAssertEqual(26, match.cardinality);
}

- (DBBruteForceMatcher *)createMatcher {
    return [[DBBruteForceMatcher alloc] initWithCardinality:10];
}

@end
