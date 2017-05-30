//
//  DBUserInputsMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBUserInputsMatcher.h"

#import "DBMatch.h"

@interface DBUserInputsMatcherTests : XCTestCase

@end

@implementation DBUserInputsMatcherTests

- (void)test_matchesForPassword_NoUserInputsProvided_ReturnsNoMatches {
    DBUserInputsMatcher *sut = [self createUserInputsMatcher];

    NSArray<DBMatch *> *results = [sut matchesForPassword:@"password"];

    XCTAssertEqual(0, results.count);
}

- (void)test_matchesForPassword_ProvidedUserInputThatMatchesPassword_ReturnsSingleMatch {
    DBUserInputsMatcher *sut = [self createUserInputsMatcherWithUserInputs:@[@"password"]];

    NSArray<DBMatch *> *results = [sut matchesForPassword:@"password"];

    XCTAssertEqual(1, results.count);
}

- (void)test_matchesForPassword_ProvidedUserInputThatMatchesPassword_ReturnsMatchWithValueForTokenSetToPassword {
    DBUserInputsMatcher *sut = [self createUserInputsMatcherWithUserInputs:@[@"password"]];

    NSArray<DBMatch *> *results = [sut matchesForPassword:@"password"];

    DBMatch *match = results[0];
    XCTAssertEqualObjects(@"password", match.token);
}

- (void)test_matchesForPassword_ProvidedUserInputThatMatchesPassword_ReturnsMatchWithValueForiSetToZero {
    DBUserInputsMatcher *sut = [self createUserInputsMatcherWithUserInputs:@[@"password"]];

    NSArray<DBMatch *> *results = [sut matchesForPassword:@"password"];

    DBMatch *match = results[0];
    XCTAssertEqual(0, match.i);
}

- (void)test_matchesForPassword_ProvidedUserInputThatMatchesPassword_ReturnsMatchWithValueForjSetToIndexOfLastCharacterOfPassword {
    DBUserInputsMatcher *sut = [self createUserInputsMatcherWithUserInputs:@[@"password"]];

    NSArray<DBMatch *> *results = [sut matchesForPassword:@"password"];

    DBMatch *match = results[0];
    XCTAssertEqual(7, match.j);
}

- (void)test_matchesForPassword_ProvidedUserInputThatDoesNotMatchPassword_ReturnsNoMatches {
    DBUserInputsMatcher *sut = [self createUserInputsMatcherWithUserInputs:@[@"password"]];

    NSArray<DBMatch *> *results = [sut matchesForPassword:@"something-else"];

    XCTAssertEqual(0, results.count);
}

- (void)test_matchesForPassword_ProvidedMutlipleUserInputs_ReturnsMatchForUserInputMatchingPassword {
    DBUserInputsMatcher *sut = [self createUserInputsMatcherWithUserInputs:@[@"not-a-match", @"something-else", @"password", @"frobnicate"]];

    NSArray<DBMatch *> *results = [sut matchesForPassword:@"password"];

    XCTAssertEqual(1, results.count);
    DBMatch *match = results[0];
    XCTAssertEqual(@"password", match.token);
}

- (DBUserInputsMatcher *)createUserInputsMatcher {
    return [self createUserInputsMatcherWithUserInputs:@[]];
}

- (DBUserInputsMatcher *)createUserInputsMatcherWithUserInputs:(NSArray<NSString *> *)userInputs {
    return [[DBUserInputsMatcher alloc] initWithUserInputs:userInputs];
}

@end
