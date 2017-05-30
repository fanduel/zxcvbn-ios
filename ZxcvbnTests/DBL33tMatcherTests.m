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
    NSArray<DBMatch *> *expectedInnerMatches = @[
                                                 [[DBMatch alloc] init],
                                                 [[DBMatch alloc] init]
                                                 ];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"password" : expectedInnerMatches };
    DBL33tMatcher *sut = [self createL33tMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"p@ssword"];

    DBL33tMatch *match = (DBL33tMatch *)result.firstObject;
    XCTAssertEqualObjects(expectedInnerMatches, match.innerMatches);
}

- (void)test_matchesForPassword_SingleL33tSubstitutions_SetsCorrectNumberOfSubstitutionsOnMatch {
    DBMatch *innerMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
    DBL33tMatcher *sut = [self createL33tMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"p@ssw0rd"];

    DBL33tMatch *match = (DBL33tMatch *)result.firstObject;
    XCTAssertEqual(2, match.substitutions.count);
}

- (void)test_matchesForPassword_SingleL33tSubstitution_SetsCorrectOriginalCharacterOnSubstitution {
    DBMatch *innerMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
    DBL33tMatcher *sut = [self createL33tMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passw0rd"];

    DBL33tMatch *match = (DBL33tMatch *)result.firstObject;
    DBL33tSubstitution *substitution = (DBL33tSubstitution *)match.substitutions.firstObject;
    XCTAssertEqualObjects(@"0", substitution.originalCharacrer);
}

- (void)test_matchesForPassword_SingleL33tSubstitution_SetsCorrectSubstitutedCharacterOnSubstitution {
    DBMatch *innerMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
    DBL33tMatcher *sut = [self createL33tMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passw0rd"];

    DBL33tMatch *match = (DBL33tMatch *)result.firstObject;
    DBL33tSubstitution *substitution = (DBL33tSubstitution *)match.substitutions.firstObject;
    XCTAssertEqualObjects(@"o", substitution.substitutedCharacrer);
}

- (void)test_matchesForPassword_SingleL33tSubstitution_SetsCorrectCharacterIndexOnSubstitution {
    DBMatch *innerMatch = [[DBMatch alloc] init];
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
    DBL33tMatcher *sut = [self createL33tMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passw0rd"];

    DBL33tMatch *match = (DBL33tMatch *)result.firstObject;
    DBL33tSubstitution *substitution = (DBL33tSubstitution *)match.substitutions.firstObject;
    XCTAssertEqual(5, substitution.characterIndex);
}

- (void)test_matchesForPassword_MultipleL33tSubstitutions_ReturnsMatchForEachPossiblePasswordWithoutL33tSubstitutions {
    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
    stubMatcher.matchesForPasswords = @{
                                        @"lol" : @[[self createMatchForPassword:@"lol"]],
                                        @"lot" : @[[self createMatchForPassword:@"lot"]],
                                        @"tot" : @[[self createMatchForPassword:@"tot"]]
                                         };
    DBL33tMatcher *sut = [self createL33tMatcherWithMatcher:stubMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"7o7"];

    XCTAssertEqual(3, result.count);
}

- (DBFakeMatcher *)createFakeMatcher {
    return [[DBFakeMatcher alloc] init];
}

- (DBL33tMatcher *)createL33tMatcherWithMatcher:(id<DBMatching>)matcher {
    return [[DBL33tMatcher alloc] initWithSubstitutionMap:[self createSubstitutionMap] matcher:matcher];
}

- (DBSubstitutionMap *)createSubstitutionMap {
    return [[DBSubstitutionMap alloc] initWithSubstitutions:@{
                                                              @"@" : @"a",
                                                              @"0" : @"o",
                                                              @"7" : @"lt"
                                                              }];
}

- (DBMatch *)createMatchForPassword:(NSString *)password {
    DBMatch *match = [[DBMatch alloc] init];
    match.token = password;
    match.i = 0;
    match.j = password.length - 1;
    return match;
}
@end
