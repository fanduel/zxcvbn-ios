////
////  DBPermutationMatcherTests.m
////  Zxcvbn
////
////  Created by Steven King on 30/05/2017.
////  Copyright © 2017 Dropbox. All rights reserved.
////
//
//#import <XCTest/XCTest.h>
//
//#import "DBPermutationMatcher.h"
//
//#import "DBFakeMatcher.h"
//#import "DBPermutationMatch.h"
//
//@interface DBPermutationMatcherTests : XCTestCase
//
//@end
//
//@implementation DBPermutationMatcherTests
//
//- (void)test_matchesForPassword_ProvidedZeroCharacterPassword_ReturnsZeroMatches {
//    DBMatch *rejectedMatch = [[DBMatch alloc] init];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    [stubMatcher setMatchesForPasswords:@{ @"" : @[rejectedMatch] }];
//    DBPermutationMatcher *sut = [self createPermutationMatcherWithMatcher:stubMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@""];
//
//    XCTAssertEqual(0, result.count);
//}
//
//- (void)test_matchesForPassword_ProvidedOneCharacterPassword_ReturnsMatchesForPasswordFromProvidedMatcher {
//    DBMatch *expectedMatch = [[DBMatch alloc] init];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    [stubMatcher setMatchesForPasswords:@{ @"p" : @[expectedMatch] }];
//    DBPermutationMatcher *sut = [self createPermutationMatcherWithMatcher:stubMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"p"];
//
//    XCTAssertEqual(1, result.count);
//    XCTAssertEqual(expectedMatch, result[0]);
//}
//
//- (void)test_matchesForPassword_ProvidedTwoCharacterPassword_ReturnsPermutationMatchPlusMatchesForPasswordFromProvidedMatcher {
//    DBPermutationMatcher *sut = [self createPermutationMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pa"];
//
//    XCTAssertEqual(2, result.count);
//    XCTAssertTrue([result[0] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertEqual(@"pa", result[1].token);
//}
//
//- (void)test_matchesForPassword_ProvidedTwoCharacterPassword_PermutationMatchContainsCorrectFragmentMatches {
//    DBPermutationMatcher *sut = [self createPermutationMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pa"];
//
//    DBPermutationMatch *match = (DBPermutationMatch *)result[0];
//    [self assertFragmentMatches:match.fragmentMatches containsMatchesWithTokens:@[@"p", @"a"]];
//}
//
//- (void)test_matchesForPassword_ProvidedThreeCharacterPassword_ReturnsThreePermutationMatchsPlusMatchesForPasswordFromProvidedMatcher {
//    DBPermutationMatcher *sut = [self createPermutationMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pas"];
//
//    XCTAssertEqual(4, result.count);
//    XCTAssertTrue([result[0] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertTrue([result[1] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertTrue([result[2] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertEqual(@"pas", result[3].token);
//}
//
//- (void)test_matchesForPassword_ProvidedThreeCharacterPassword_FirstPermutationMatchContainsCorrectFragmentMatches {
//    DBPermutationMatcher *sut = [self createPermutationMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pas"];
//
//    DBPermutationMatch *match = (DBPermutationMatch *)result[0];
//    [self assertFragmentMatches:match.fragmentMatches containsMatchesWithTokens:@[@"p", @"a", @"s"]];
//}
//
//- (void)test_matchesForPassword_ProvidedThreeCharacterPassword_SecondPermutationMatchContainsCorrectFragmentMatches {
//    DBPermutationMatcher *sut = [self createPermutationMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pas"];
//
//    DBPermutationMatch *match = (DBPermutationMatch *)result[1];
//    [self assertFragmentMatches:match.fragmentMatches containsMatchesWithTokens:@[@"p", @"as"]];
//}
//
//- (void)test_matchesForPassword_ProvidedThreeCharacterPassword_ThirdPermutationMatchContainsCorrectFragmentMatches {
//    DBPermutationMatcher *sut = [self createPermutationMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pas"];
//
//    DBPermutationMatch *match = (DBPermutationMatch *)result[2];
//    [self assertFragmentMatches:match.fragmentMatches containsMatchesWithTokens:@[@"pa", @"s"]];
//}
//
//- (void)test_matchesForPassword_ProvidedFourCharacterPassword_ReturnsSevenPermutationMatchsPlusMatchesForPasswordFromProvidedMatcher {
//    DBPermutationMatcher *sut = [self createPermutationMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pass"];
//
//    XCTAssertEqual(8, result.count);
//    XCTAssertTrue([result[0] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertTrue([result[1] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertTrue([result[2] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertTrue([result[3] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertTrue([result[4] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertTrue([result[5] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertTrue([result[6] isKindOfClass:DBPermutationMatch.class]);
//    XCTAssertEqual(@"pass", result[7].token);
//}
//
//- (void)test_matchesForPassword_ProvidedFourCharacterPassword_AllPermutationMatchesContainsCorrectFragmentMatches {
//    DBPermutationMatcher *sut = [self createPermutationMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pass"];
//
//    [self assertFragmentMatches:[(DBPermutationMatch *)result[0] fragmentMatches] containsMatchesWithTokens:@[@"p", @"a", @"s", @"s"]];
//    [self assertFragmentMatches:[(DBPermutationMatch *)result[1] fragmentMatches] containsMatchesWithTokens:@[@"p", @"a", @"ss"]];
//    [self assertFragmentMatches:[(DBPermutationMatch *)result[2] fragmentMatches] containsMatchesWithTokens:@[@"p", @"as", @"s"]];
//    [self assertFragmentMatches:[(DBPermutationMatch *)result[3] fragmentMatches] containsMatchesWithTokens:@[@"p", @"ass"]];
//    [self assertFragmentMatches:[(DBPermutationMatch *)result[4] fragmentMatches] containsMatchesWithTokens:@[@"pa", @"s", @"s"]];
//    [self assertFragmentMatches:[(DBPermutationMatch *)result[5] fragmentMatches] containsMatchesWithTokens:@[@"pa", @"ss"]];
//    [self assertFragmentMatches:[(DBPermutationMatch *)result[6] fragmentMatches] containsMatchesWithTokens:@[@"pas", @"s"]];
//}
//
//- (void)assertFragmentMatches:(NSArray<NSArray<DBMatch *> *> *)fragmentMatches containsMatchesWithTokens:(NSArray<NSString *> *)tokens {
//    XCTAssertEqual(tokens.count, fragmentMatches.count);
//    [tokens enumerateObjectsUsingBlock:^(NSString * _Nonnull token, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSArray<DBMatch *> *fragmentMatch = fragmentMatches[idx];
//        DBMatch *firstMatch = fragmentMatch[0];
//        XCTAssertEqualObjects(token, firstMatch.token);
//    }];
//}
//
//- (DBFakeMatcher *)createFakeMatcher {
//    return [[DBFakeMatcher alloc] init];
//}
//
//- (DBPermutationMatcher *)createPermutationMatcher {
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    [stubMatcher setMatchesForPasswords:@{
//                                          @"p"    : @[[[DBMatch alloc] initWithToken:@"p"]],
//                                          @"a"    : @[[[DBMatch alloc] initWithToken:@"a"]],
//                                          @"s"    : @[[[DBMatch alloc] initWithToken:@"s"]],
//                                          @"pa"   : @[[[DBMatch alloc] initWithToken:@"pa"]],
//                                          @"as"   : @[[[DBMatch alloc] initWithToken:@"as"]],
//                                          @"ss"   : @[[[DBMatch alloc] initWithToken:@"ss"]],
//                                          @"pas"  : @[[[DBMatch alloc] initWithToken:@"pas"]],
//                                          @"ass"  : @[[[DBMatch alloc] initWithToken:@"ass"]],
//                                          @"pass" : @[[[DBMatch alloc] initWithToken:@"pass"]]
//                                          }];
//    return [[DBPermutationMatcher alloc] initWithMatcher:stubMatcher];
//}
//
//- (DBPermutationMatcher *)createPermutationMatcherWithMatcher:(id<DBMatching>)matcher {
//    return [[DBPermutationMatcher alloc] initWithMatcher:matcher];
//}
//
//@end
