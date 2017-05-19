//
//  DBBruteForceMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 19/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBBruteForceMatcher.h"

#import "DBBruteForceMatch.h"

@interface DBBruteForceMatcherTests : XCTestCase

@end

@implementation DBBruteForceMatcherTests

- (void)test_matchesForPassword_ProvidedPassword_ReturnsSingleMatch {
    DBBruteForceMatcher *sut = [[DBBruteForceMatcher alloc] init];

    NSArray<DBBruteForceMatch *> *result = [sut matchesForPassword:@"avuinmef"];

    XCTAssertEqual(1, result.count);
}


@end
