//
//  DBSpatialMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBSpatialMatcher.h"

#import "DBSpatialMatch.h"
#import "DBAdjacentCharacterMap.h"

@interface DBSpatialMatcherTests : XCTestCase

@end

@implementation DBSpatialMatcherTests

- (void)test_matchesForPassword_PasswordFollowingSpatialPatternWithThreeOrMoreProvidedToInitializer_ReturnsSingleMatch {
    DBSpatialMatcher *sut = [self createSpatialMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"fgh"];

    XCTAssertEqual(1, result.count);
}

- (void)test_matchesForPassword_PasswordNotFollowingSpatialPatternProvidedToInitializer_ReturnsZeroMatches {
    DBSpatialMatcher *sut = [self createSpatialMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"fghfgh"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_PasswordWithFewerThenThreeCharactersProvidedToInitializer_ReturnsZeroMatches {
    DBSpatialMatcher *sut = [self createSpatialMatcher];

    NSArray<DBMatch *> *result = [sut matchesForPassword:@"fg"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsTokenToProvidedPasswordInReturnedMatch {
    DBSpatialMatcher *sut = [self createSpatialMatcher];

    NSArray<DBMatch *> *matches = [sut matchesForPassword:@"jhgf"];

    DBMatch *result = matches.firstObject;
    XCTAssertEqual(@"jhgf", result.token);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsiToZeroInReturnedMatch {
    DBSpatialMatcher *sut = [self createSpatialMatcher];

    NSArray<DBMatch *> *matches = [sut matchesForPassword:@"ghjh"];

    DBMatch *result = matches.firstObject;
    XCTAssertEqual(0, result.i);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsjToIndexOfLastCharacterOfProvidedPasswordInReturnedMatch {
    DBSpatialMatcher *sut = [self createSpatialMatcher];

    NSArray<DBMatch *> *matches = [sut matchesForPassword:@"ghjhg"];

    DBMatch *result = matches.firstObject;
    XCTAssertEqual(4, result.j);
}

- (void)test_matchesForPassword_PasswordInDictionaryProvidedToInitializer_SetsGraphToNameOfProvidedAdjacencyMapInReturnedMatch {
    DBSpatialMatcher *sut = [self createSpatialMatcher];

    NSArray<DBSpatialMatch *> *matches = [sut matchesForPassword:@"ghjhg"];

    DBSpatialMatch *result = matches.firstObject;
    XCTAssertEqual(@"name", result.graph);
}

- (DBSpatialMatcher *)createSpatialMatcher {
    return [[DBSpatialMatcher alloc] initWithAdjacentCharacterMap:[self createAdjacentCharacterMap]];
}

- (DBAdjacentCharacterMap *)createAdjacentCharacterMap {
    NSDictionary<NSString *, NSDictionary<NSString *, NSNumber *> *> *adjacencyMap = @{
                                                                      @"f" : @{
                                                                              @"r" : @(DBAdjacentCharacterDirectionUp),
                                                                              @"d" : @(DBAdjacentCharacterDirectionLeft),
                                                                              @"g" : @(DBAdjacentCharacterDirectionRight),
                                                                              @"v" : @(DBAdjacentCharacterDirectionDown),
                                                                              },
                                                                      @"g" : @{
                                                                              @"t" : @(DBAdjacentCharacterDirectionUp),
                                                                              @"f" : @(DBAdjacentCharacterDirectionLeft),
                                                                              @"h" : @(DBAdjacentCharacterDirectionRight),
                                                                              @"b" : @(DBAdjacentCharacterDirectionDown),
                                                                              },
                                                                      @"h" : @{
                                                                              @"y" : @(DBAdjacentCharacterDirectionUp),
                                                                              @"g" : @(DBAdjacentCharacterDirectionLeft),
                                                                              @"j" : @(DBAdjacentCharacterDirectionRight),
                                                                              @"n" : @(DBAdjacentCharacterDirectionDown),
                                                                              },
                                                                      @"j" : @{
                                                                              @"u" : @(DBAdjacentCharacterDirectionUp),
                                                                              @"h" : @(DBAdjacentCharacterDirectionLeft),
                                                                              @"k" : @(DBAdjacentCharacterDirectionRight),
                                                                              @"m" : @(DBAdjacentCharacterDirectionDown),
                                                                              },
                                                                      };
    return [[DBAdjacentCharacterMap alloc] initWithName:@"name" dictionary:adjacencyMap];
}

@end
