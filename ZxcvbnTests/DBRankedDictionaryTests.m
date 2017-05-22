//
//  DBRankedDictionaryTests.m
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBRankedDictionary.h"

@interface DBRankedDictionaryTests : XCTestCase

@end

@implementation DBRankedDictionaryTests

- (void)test_name_Always_ReturnsValueProvidedToInitializer {
    DBRankedDictionary *sut = [self createRankedDictionaryWithName:@"big words"];
    
    NSString *result = sut.name;
    
    XCTAssertEqual(@"big words", result);
}

- (void)test_containsWord_WordProvidedToInitializer_ReturnsYES {
    NSString *word = @"frobnicator";
    DBRankedDictionary *sut = [self createRankedDictionaryWithOrderedWords:@[word]];

    BOOL result = [sut containsWord:word];

    XCTAssertTrue(result);
}

- (void)test_containsWord_WordNotProvidedToInitializer_ReturnsNO {
    NSString *word = @"frobnicator";
    DBRankedDictionary *sut = [self createRankedDictionaryWithOrderedWords:@[word]];

    BOOL result = [sut containsWord:@"tessellation"];

    XCTAssertFalse(result);
}

- (void)test_rankForWord_WordAtIndexInArrayOfProvidedWords_ReturnsValueEqualToIndexPlusOne {
    NSArray<NSString *> *words = @[@"giblets", @"velodrome", @"reprobate"];
    DBRankedDictionary *sut = [self createRankedDictionaryWithOrderedWords:words];
    
    NSUInteger result = [sut rankForWord:@"velodrome"];
    
    XCTAssertEqual(2, result);
}

- (DBRankedDictionary *)createRankedDictionaryWithName:(NSString *)name {
    return [[DBRankedDictionary alloc] initWithName:name orderedWords:@[]];
}

- (DBRankedDictionary *)createRankedDictionaryWithOrderedWords:(NSArray<NSString *> *)words {
    return [[DBRankedDictionary alloc] initWithName:@"name" orderedWords:words];
}

@end
