//
//  DBAdjacentCharacterMapTests.m
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBAdjacentCharacterMap.h"

@interface DBAdjacentCharacterMapTests : XCTestCase

@end

@implementation DBAdjacentCharacterMapTests

- (void)test_name_Always_ReturnsValueProvidedToInitializer {
    DBAdjacentCharacterMap *sut = [self createAdjacentCharacterMapWithName:@"fghj"];

    NSString *result = sut.name;

    XCTAssertEqual(@"fghj", result);
}

- (void)test_containsMapForCharacter_CharacterMapInProvidedDictionary_ReturnsYES {
    DBAdjacentCharacterMap *sut = [self createAdjacentCharacterMap];

    BOOL result = [sut containsMapForCharacter:'f'];

    XCTAssertTrue(result);
}

- (void)test_containsMapForCharacter_CharacterMapNotInProvidedDictionary_ReturnsNO {
    DBAdjacentCharacterMap *sut = [self createAdjacentCharacterMap];

    BOOL result = [sut containsMapForCharacter:'a'];

    XCTAssertFalse(result);
}

- (void)test_isCharacterAdjacentToCharacter_ProvidedCharactersAreAdjacent_ReturnsYES {
    DBAdjacentCharacterMap *sut = [self createAdjacentCharacterMap];

    BOOL result = [sut isCharacter:'f' adjacentToCharacter:'d'];

    XCTAssertTrue(result);
}

- (void)test_isCharacterAdjacentToCharacter_ProvidedCharactersAreNotAdjacent_ReturnsNO {
    DBAdjacentCharacterMap *sut = [self createAdjacentCharacterMap];

    BOOL result = [sut isCharacter:'f' adjacentToCharacter:'h'];

    XCTAssertFalse(result);
}

- (DBAdjacentCharacterMap *)createAdjacentCharacterMapWithName:(NSString *)name {
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
    return [[DBAdjacentCharacterMap alloc] initWithName:(NSString *)name dictionary:adjacencyMap];
}

- (DBAdjacentCharacterMap *)createAdjacentCharacterMap {
    return [self createAdjacentCharacterMapWithName:@"name"];
}

@end
