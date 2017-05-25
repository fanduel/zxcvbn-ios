//
//  DBL33tMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 23/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBL33tMatcher.h"

#import "DBSubstitutionMap.h"
#import "DBFakeMatcher.h"
#import "DBMatch.h"
#import "DBL33tMatch.h"

@interface DBL33tMatcherTests : XCTestCase

@end

@implementation DBL33tMatcherTests

- (void)test_matchesForPassword_NoL33tSubstitutions_ReturnsValueFromProvidedMatcher {
    DBMatch *expectedMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForAnyPassword = @[expectedMatch];
    DBL33tMatcher *sut = [self createL33tMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"password"];

    XCTAssertEqualObjects(expectedMatch, result.firstObject);
}

- (void)test_matchesForPassword_SingleL33tSubstitution_ProvidesPasswordWithoutL33tSubstitutionToMatcher {
    DBMatch *innerMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
    DBL33tMatcher *sut = [self createL33tMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"p@ssword"];

    XCTAssertEqualObjects(innerMatch, ((DBL33tMatch *)result.firstObject).innerMatch);
}

- (DBFakeMatcher *)createFakeMatcher {
    return [[DBFakeMatcher alloc] init];
}

- (DBL33tMatcher *)createL33tMatcherWithMatcher:(id<DBMatching>)matcher {
    return [[DBL33tMatcher alloc] initWithSubstitutionMap:[self createSubstitutionMap] matcher:matcher];
}

- (DBSubstitutionMap *)createSubstitutionMap {
    return [[DBSubstitutionMap alloc] initWithSubstitutions:@{
                                                              @"@" : @"a"
                                                              }];
}
@end
