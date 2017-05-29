//
//  DBSequenceMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 29/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBSequenceMatcher.h"

#import "DBSequenceMatch.h"

@interface DBSequenceMatcherTests : XCTestCase

@end

@implementation DBSequenceMatcherTests

- (void)test_matchesForPassword_PasswordMatchesProvidedSequence_ReturnsMatch {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"34567"];

    XCTAssertEqual(1, result.count);
}

- (void)test_matchesForPassword_PasswordDoesNotMatchProvidedSequence_ReturnsEmptyArray {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"ABC123abc"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_PasswordContainsOneCharacter_ReturnsEmptyArray {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"0"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_PasswordIsSequenceThatSkipsCharacters_ReturnsMatch {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"8642"];

    XCTAssertEqual(1, result.count);
}

- (void)test_matchesForPassword_PasswordMatchesProvidedSequence_SetsTokenToPasswordOnReturnedMatch {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"ghij"];

    DBMatch *match = result[0];
    XCTAssertEqual(@"ghij", match.token);
}

- (void)test_matchesForPassword_PasswordMatchesProvidedSequence_SetsiToZeroOnReturnedMatch {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"ghij"];

    DBMatch *match = result[0];
    XCTAssertEqual(0, match.i);
}

- (void)test_matchesForPassword_PasswordMatchesProvidedSequence_SetsjToIndexOfLastCharacterOfPasswordOnReturnedMatch {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"DEFGH"];

    DBMatch *match = result[0];
    XCTAssertEqual(4, match.j);
}

- (void)test_matchesForPassword_PasswordMatchesProvidedSequence_SetsSequenceNameToNameOfMatchedSequenceOnReturnedMatch {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBSequenceMatch *> *result = [sut matchesForPassword:@"GHIJK"];

    DBSequenceMatch *match = result[0];
    XCTAssertEqual(@"upper", match.sequenceName);
}

- (void)test_matchesForPassword_PasswordMatchesProvidedSequence_SetsAscendingToTrueForAscendingSequenceOnReturnedMatch {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBSequenceMatch *> *result = [sut matchesForPassword:@"adgj"];

    DBSequenceMatch *match = result[0];
    XCTAssertTrue(match.ascending);
}

- (void)test_matchesForPassword_PasswordMatchesProvidedSequence_SetsAscendingToFalseForDescendingSequenceOnReturnedMatch {
    DBSequenceMatcher *sut = [self createSequenceMatcher];

    NSArray<DBSequenceMatch *> *result = [sut matchesForPassword:@"wusqom"];

    DBSequenceMatch *match = result[0];
    XCTAssertFalse(match.ascending);
}

- (DBSequenceMatcher *)createSequenceMatcher {
    return [[DBSequenceMatcher alloc] initWithSequences:@{
                                                          @"digits" : @"01234567890",
                                                          @"lower" : @"abcdefghijklmnopqrstuvwxyz",
                                                          @"upper" : @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                                          }];
}

@end
