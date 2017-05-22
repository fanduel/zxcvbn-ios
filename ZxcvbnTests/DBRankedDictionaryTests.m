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

- (DBRankedDictionary *)createRankedDictionaryWithName:(NSString *)name {
    return [[DBRankedDictionary alloc] initWithName:name];
}

@end
