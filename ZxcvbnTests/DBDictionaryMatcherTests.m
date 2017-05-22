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

- (DBDictionaryMatcher *)createDictionaryMatcher {
    return [[DBDictionaryMatcher alloc] initWithRankedDictionary:[self createRankedDictionary]];
}

- (DBRankedDictionary *)createRankedDictionary {
    return [[DBRankedDictionary alloc] initWithName:@"dictionary" orderedWords:@[@"apple", @"banana", @"cherry", @"durian"]];
}

@end
