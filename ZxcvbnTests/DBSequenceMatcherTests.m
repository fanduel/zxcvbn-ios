//
//  DBSequenceMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 29/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBSequenceMatcher.h"

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

- (DBSequenceMatcher *)createSequenceMatcher {
    return [[DBSequenceMatcher alloc] initWithSequences:@{
                                                          @"digits" : @"01234567890",
                                                          @"lower" : @"abcdefghijklmnopqrstuvwxyz",
                                                          @"upper" : @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                                          }];
}

@end
