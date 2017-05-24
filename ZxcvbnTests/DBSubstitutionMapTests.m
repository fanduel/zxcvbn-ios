//
//  DBL33tDictionary.m
//  Zxcvbn
//
//  Created by Steven King on 23/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBSubstitutionMap.h"

@interface DBSubstitutionMapTests : XCTestCase

@end

@implementation DBSubstitutionMapTests

- (void)test_isSubstituteCharacter_SubstitutionsForCharacterProvidedToInitializer_ReturnsYES {
    DBSubstitutionMap *sut = [self createSubstitutionMap];
    
    BOOL result = [sut isSubstituteCharacter:@"@"];
    
    XCTAssertTrue(result);
}
- (void)test_isSubstituteCharacter_SubstitutionsForCharacterNotProvidedToInitializer_ReturnsNO {
    DBSubstitutionMap *sut = [self createSubstitutionMap];
    
    BOOL result = [sut isSubstituteCharacter:@"*"];
    
    XCTAssertFalse(result);
}

- (DBSubstitutionMap *)createSubstitutionMap {
    return [[DBSubstitutionMap alloc] initWithSubstitutions:@{
                                                              @"@" : @"a",
                                                              @"1" : @"lt"
                                                              }];
}

@end
