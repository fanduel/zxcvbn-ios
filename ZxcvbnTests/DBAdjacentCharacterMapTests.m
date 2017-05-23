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
    DBAdjacentCharacterMap *sut = [self createAdjacentCharacterMapWithName:@"fji"];

    NSString *result = sut.name;

    XCTAssertEqual(@"fji", result);
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

- (void)test_adjacentCharactersForCharacter_CharacterMapInProvidedDictionary_ReturnsCharacterSetOfAdjacentCharacters {
    DBAdjacentCharacterMap *sut = [self createAdjacentCharacterMap];

    NSCharacterSet *result = [sut adjacentCharactersForCharacter:'j'];

    NSCharacterSet *expectedCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"uhkm"];
    XCTAssertEqualObjects(expectedCharacterSet, result);
}

- (DBAdjacentCharacterMap *)createAdjacentCharacterMapWithName:(NSString *)name {
    NSDictionary<NSString *, NSArray<NSString *> *> *adjacencyMap = @{
                                                                      @"f" : @"rdgv",
                                                                      @"j" : @"uhkm",
                                                                      @"l" : @"ok;."
                                                                      };
    return [[DBAdjacentCharacterMap alloc] initWithName:(NSString *)name dictionary:adjacencyMap];
}

- (DBAdjacentCharacterMap *)createAdjacentCharacterMap {
    return [self createAdjacentCharacterMapWithName:@"name"];
}

@end
