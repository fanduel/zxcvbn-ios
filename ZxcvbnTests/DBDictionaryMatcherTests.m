//
//  DBDictionaryMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBDictionaryMatcher.h"

#import "DBRankedDictionary.h"
#import "DBDictionaryMatch.h"

@interface DBDictionaryMatcherTests : XCTestCase

@end

@implementation DBDictionaryMatcherTests

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_ReturnsSingleMatch {
    DBDictionaryMatcher *sut = [self createDictionaryMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"banana"];

    XCTAssertEqual(1, result.count);
}

- (void)test_matchesForPassword_PasswordNotInDictionaryProvidedToInitializer_ReturnsZeroMatches {
    DBDictionaryMatcher *sut = [self createDictionaryMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"elderberry"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsTokenToProvidedPasswordInReturnedMatch {
    DBDictionaryMatcher *sut = [self createDictionaryMatcher];

    NSArray<DBMatch *> *matches = [sut matchesForPassword:@"durian"];

    DBMatch *result = matches.firstObject;
    XCTAssertEqual(@"durian", result.token);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsiToZeroInReturnedMatch {
    DBDictionaryMatcher *sut = [self createDictionaryMatcher];

    NSArray<DBMatch *> *matches = [sut matchesForPassword:@"apple"];

    DBMatch *result = matches.firstObject;
    XCTAssertEqual(0, result.i);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsjToIndexOfLastCharacterOfProvidedPasswordInReturnedMatch {
    DBDictionaryMatcher *sut = [self createDictionaryMatcher];

    NSArray<DBMatch *> *matches = [sut matchesForPassword:@"banana"];

    DBMatch *result = matches.firstObject;
    XCTAssertEqual(5, result.j);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsDictionaryNameToNameOfProvidedDictionary {
    DBDictionaryMatcher *sut = [self createDictionaryMatcher];

    NSArray<DBDictionaryMatch *> *matches = [sut matchesForPassword:@"cherry"];

    DBDictionaryMatch *result = matches.firstObject;
    XCTAssertEqual(@"fruit", result.dictionaryName);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsRankToRankOfWordFromProvidedDictionary {
    DBDictionaryMatcher *sut = [self createDictionaryMatcher];

    NSArray<DBDictionaryMatch *> *matches = [sut matchesForPassword:@"durian"];

    DBDictionaryMatch *result = matches.firstObject;
    XCTAssertEqual(4, result.rank);
}

- (DBDictionaryMatcher *)createDictionaryMatcher {
    return [[DBDictionaryMatcher alloc] initWithRankedDictionary:[self createRankedDictionary]];
}

- (DBRankedDictionary *)createRankedDictionary {
    return [[DBRankedDictionary alloc] initWithName:@"fruit" orderedWords:@[@"apple", @"banana", @"cherry", @"durian"]];
}

@end
