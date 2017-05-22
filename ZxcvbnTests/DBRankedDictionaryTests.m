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
    NSString *name = @"big words";
    DBRankedDictionary *sut = [self createRankedDictionaryWithName:name];
    
    NSString *result = sut.name;
    
    XCTAssertEqual(name, result);
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

- (DBRankedDictionary *)createRankedDictionaryWithName:(NSString *)name {
    return [[DBRankedDictionary alloc] initWithName:name orderedWords:@[]];
}

- (DBRankedDictionary *)createRankedDictionaryWithOrderedWords:(NSArray<NSString *> *)words {
    return [[DBRankedDictionary alloc] initWithName:@"name" orderedWords:words];
}

@end
