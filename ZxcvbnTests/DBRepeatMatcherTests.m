//
//  DBRepeatMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 18/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBRepeatMatcher.h"

#import "DBFakeMatcher.h"
#import "DBRepeatMatch.h"

@interface DBRepeatMatcherTests : XCTestCase

@end

@implementation DBRepeatMatcherTests

- (void)test_matchesForPassword_NoRepeatsInPassword_ReturnsMatchesFromProvidedMatcher {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"password" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"password"];

    XCTAssertEqual(1, result.count);
    XCTAssertEqualObjects(expectedMatch, result[0]);
}

- (void)test_matchesForPassword_PhraseRepeatedInPassword_ReturnsOneRepeatMatch {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"pass" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passpass"];

    XCTAssertEqual(1, result.count);
    XCTAssertTrue([result[0] isKindOfClass:DBRepeatMatch.class]);
}

- (void)test_matchesForPassword_PhraseRepeatedInPassword_ReturnsRepeatMatchWithTokenSetToValueOfPassword {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"pass" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passpass"];

    DBMatch *match = result[0];
    XCTAssertEqual(@"passpass", match.token);
}

- (void)test_matchesForPassword_PhraseRepeatedInPassword_ReturnsRepeatMatchWithiSetToZero {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"pass" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];
    
    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passpass"];
    
    DBMatch *match = result[0];
    XCTAssertEqual(0, match.i);
}

- (void)test_matchesForPassword_PhraseRepeatedInPassword_ReturnsRepeatMatchWithjSetToIndexOfLastCharacterInPassword {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"pass" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];
    
    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passpass"];
    
    DBMatch *match = result[0];
    XCTAssertEqual(7, match.j);
}

- (void)test_matchesForPassword_PhraseRepeatedInPassword_ReturnsRepeatMatchWithRepeatedTokenSetToRepeatedStringInPassword {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"pass" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passpass"];

    DBRepeatMatch *match = (DBRepeatMatch *)result[0];
    XCTAssertEqualObjects(@"pass", match.repeatedToken);
}

- (void)test_matchesForPassword_PhraseRepeatedInPassword_ReturnsRepeatMatchWithRepeatCountSetToNumberOfRepetitionsInPassword {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"pass" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];
    
    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passpass"];
    
    DBRepeatMatch *match = (DBRepeatMatch *)result[0];
    XCTAssertEqual(2, match.repeatCount);
}

- (void)test_matchesForPassword_PhraseRepeatedInPassword_ReturnsRepeatMatchWithInnerMatchesSetToMatchesForProvidedMatcher {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"pass" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passpass"];

    DBRepeatMatch *match = (DBRepeatMatch *)result[0];
    XCTAssertEqualObjects(@[expectedMatch], match.innerMatches);
}

- (void)test_matchesForPassword_PhraseWithRepeatCountOfThreeInPassword_ReturnsOneRepeatMatchWithCorrectRepeatParameters {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"paspaspas" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"paspaspas"];

    XCTAssertEqual(1, result.count);
    DBRepeatMatch *match = (DBRepeatMatch *)result[0];
    XCTAssertTrue([match isKindOfClass:DBRepeatMatch.class]);
    XCTAssertEqualObjects(@"pas", match.repeatedToken);
    XCTAssertEqual(3, match.repeatCount);
}

- (void)test_matchesForPassword_PhraseWithRepeatCountOfFourInPassword_ReturnsOneRepeatMatchWithCorrectRepeatParameters {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"pa" : @[expectedMatch] };
    DBRepeatMatcher *sut = [self createRepeatMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"papapapa"];

    XCTAssertEqual(1, result.count);
    DBRepeatMatch *match = (DBRepeatMatch *)result[0];
    XCTAssertTrue([match isKindOfClass:DBRepeatMatch.class]);
    XCTAssertEqualObjects(@"pa", match.repeatedToken);
    XCTAssertEqualObjects(@[expectedMatch], match.innerMatches);
    XCTAssertEqual(4, match.repeatCount);
}

- (DBFakeMatcher *)createFakeMatcher {
    return [[DBFakeMatcher alloc] init];
}

- (DBRepeatMatcher *)createRepeatMatcherWithMatcher:(id<DBMatching>)matcher {
    return [[DBRepeatMatcher alloc] initWithMatcher:matcher];
}

@end
