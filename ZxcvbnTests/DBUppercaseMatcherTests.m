////
////  DBUppercaseMatcherTests.m
////  Zxcvbn
////
////  Created by Steven King on 30/05/2017.
////  Copyright © 2017 Dropbox. All rights reserved.
////
//
//#import <XCTest/XCTest.h>
//
//#import "DBUppercaseMatcher.h"
//
//#import "DBUppercaseMatch.h"
//#import "DBFakeMatcher.h"
//
//@interface DBUppercaseMatcherTests : XCTestCase
//
//@end
//
//@implementation DBUppercaseMatcherTests
//
//- (void)test_matchesForPassword_PasswordContainsNoUppercaseCharacters_ReturnsInnerMatchesForProvidedPassword {
//    DBMatch *expectedMatch = [[DBMatch alloc] init];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    stubMatcher.matchesForPasswords = @{ @"password" : @[expectedMatch] };
//    DBUppercaseMatcher *sut = [self createUppercaseMatcherWithMatcher:stubMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"password"];
//
//    XCTAssertEqualObjects(expectedMatch, result.firstObject);
//}
//
//- (void)test_matchesForPassword_PasswordContainsUppercaseCharacters_ReturnsSingleMatch {
//    DBMatch *innerMatch = [[DBMatch alloc] init];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
//    DBUppercaseMatcher *sut = [self createUppercaseMatcherWithMatcher:stubMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"Password"];
//
//    XCTAssertEqual(1, result.count);
//}
//
//- (void)test_matchesForPassword_PasswordContainsUppercaseCharacters_SetsValueForTokenOnMatchToProvidedPassword {
//    DBMatch *innerMatch = [[DBMatch alloc] init];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
//    DBUppercaseMatcher *sut = [self createUppercaseMatcherWithMatcher:stubMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pAssword"];
//
//    DBMatch *match = result[0];
//    XCTAssertEqualObjects(@"pAssword", match.token);
//}
//
//- (void)test_matchesForPassword_PasswordContainsUppercaseCharacters_SetsValueForiOnMatchToZero {
//    DBMatch *innerMatch = [[DBMatch alloc] init];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
//    DBUppercaseMatcher *sut = [self createUppercaseMatcherWithMatcher:stubMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"paSsword"];
//
//    DBMatch *match = result[0];
//    XCTAssertEqual(0, match.i);
//}
//
//- (void)test_matchesForPassword_PasswordContainsUppercaseCharacters_SetsValueForjOnMatchToIndexOfLastCharacterOfPassword {
//    DBMatch *innerMatch = [[DBMatch alloc] init];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    stubMatcher.matchesForPasswords = @{ @"password" : @[innerMatch] };
//    DBUppercaseMatcher *sut = [self createUppercaseMatcherWithMatcher:stubMatcher];
//    
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"pasSword"];
//    
//    DBMatch *match = result[0];
//    XCTAssertEqual(7, match.j);
//}
//
//- (void)test_matchesForPassword_PasswordContainsUppercaseCharacters_SetsValueForInnerMatchOnMatchToMatchForLowercasedPassword {
//    NSArray<DBMatch *> *expectedInnerMatches = @[
//                                      [[DBMatch alloc] init],
//                                      [[DBMatch alloc] init]
//                                      ];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    stubMatcher.matchesForPasswords = @{ @"password" : expectedInnerMatches };
//    DBUppercaseMatcher *sut = [self createUppercaseMatcherWithMatcher:stubMatcher];
//    
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passWord"];
//    
//    DBUppercaseMatch *match = (DBUppercaseMatch *)result[0];
//    XCTAssertEqualObjects(expectedInnerMatches, match.innerMatches);
//}
//
//- (void)test_matchesForPassword_PasswordContainsUppercaseCharacters_SetsValueForSubstitutedCharactersOnMatchToUppercaseCharactersInPassword {
//    NSArray<DBMatch *> *innerMatches = @[
//                                                 [[DBMatch alloc] init],
//                                                 [[DBMatch alloc] init]
//                                                 ];
//    DBFakeMatcher *stubMatcher = [self createFakeMatcher];
//    stubMatcher.matchesForPasswords = @{ @"password" : innerMatches };
//    DBUppercaseMatcher *sut = [self createUppercaseMatcherWithMatcher:stubMatcher];
//
//    NSArray<DBMatch *> *result = [sut matchesForPassword:@"passwOrD"];
//
//    DBUppercaseMatch *match = (DBUppercaseMatch *)result[0];
//    NSArray<NSString *> *expectedSubstitutions = @[@"O", @"D"];
//    XCTAssertEqualObjects(expectedSubstitutions, match.substitutedCharacters);
//}
//
//- (DBFakeMatcher *)createFakeMatcher {
//    return [[DBFakeMatcher alloc] init];
//}
//
//- (DBUppercaseMatcher *)createUppercaseMatcherWithMatcher:(id<DBMatching>)matcher {
//    return [[DBUppercaseMatcher alloc] initWithMatcher:matcher];
//}
//
//@end
