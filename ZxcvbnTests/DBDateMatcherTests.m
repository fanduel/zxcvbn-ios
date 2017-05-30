//
//  DBDateMatcherTests.m
//  Zxcvbn
//
//  Created by Steven King on 29/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBDateMatcher.h"

#import "DBDateMatch.h"

@interface DBDateMatcherTests : XCTestCase

@end

@implementation DBDateMatcherTests

- (void)test_matchesForPassword_DateProvidedInFormDDsMMsYYYY_ReturnsMatch {
    [self assertPassword:@"31/12/2000" matchesDateWithYear:2000 month:12 day:31 separator:@"/"];
}

- (void)test_matchesForPassword_DateProvidedInFormMMsDDsYYYY_ReturnsMatch {
    [self assertPassword:@"12/31/2000" matchesDateWithYear:2000 month:12 day:31 separator:@"/"];
}

- (void)test_matchesForPassword_DateProvidedInFormYYYYsMMsDD_ReturnsMatch {
    [self assertPassword:@"2000-12-31" matchesDateWithYear:2000 month:12 day:31 separator:@"-"];
}

- (void)test_matchesForPassword_DateProvidedInFormDDsMMsYY_ReturnsMatch {
    [self assertPassword:@"31/12/00" matchesDateWithYear:2000 month:12 day:31 separator:@"/"];
}

- (void)test_matchesForPassword_DateProvidedInFormMMsDDsYY_ReturnsMatch {
    [self assertPassword:@"12/31/00" matchesDateWithYear:2000 month:12 day:31 separator:@"/"];
}

- (void)test_matchesForPassword_DateProvidedInFormYYsMMsDD_ReturnsMatch {
    [self assertPassword:@"00_12_31" matchesDateWithYear:2000 month:12 day:31 separator:@"_"];
}

- (void)test_matchesForPassword_ValidDateProvidedWithForwardSlashAsSeparator_ReturnsMatch {
    [self assertPassword:@"2000/12/31" matchesDateWithYear:2000 month:12 day:31 separator:@"/"];
}

- (void)test_matchesForPassword_ValidDateProvidedWithBackwardSlashAsSeparator_ReturnsMatch {
    [self assertPassword:@"2000\\12\\31" matchesDateWithYear:2000 month:12 day:31 separator:@"\\"];
}

- (void)test_matchesForPassword_ValidDateProvidedWithUnderscoreAsSeparator_ReturnsMatch {
    [self assertPassword:@"2000_12_31" matchesDateWithYear:2000 month:12 day:31 separator:@"_"];
}

- (void)test_matchesForPassword_ValidDateProvidedWithDashAsSeparator_ReturnsMatch {
    [self assertPassword:@"2000-12-31" matchesDateWithYear:2000 month:12 day:31 separator:@"-"];
}

- (void)test_matchesForPassword_ValidDateProvidedWithPeriodAsSeparator_ReturnsMatch {
    [self assertPassword:@"2000.12.31" matchesDateWithYear:2000 month:12 day:31 separator:@"."];
}

- (void)test_matchesForPassword_ValidDateProvidedWithSpaceAsSeparator_ReturnsMatch {
    [self assertPassword:@"2000 12 31" matchesDateWithYear:2000 month:12 day:31 separator:@" "];
}

- (void)test_matchesForPassword_ValueForDayInDateWithSeparatorIsTooLarge_ReturnsEmptyArray {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"32/12/2000"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_ValueForDayInDateWithSeparatorIsTooSmall_ReturnsEmptyArray {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"00/12/2000"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_ValueForMonthInDateWithSeparatorIsTooLarge_ReturnsEmptyArray {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"31/13/2000"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_ValueForMonthInDateWithSeparatorIsTooSmall_ReturnsEmptyArray {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"31/00/2000"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_FourDigitValueForYearInDateWithSeparatorIsTooLarge_ReturnsEmptyArray {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"31/12/2051"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_FourDigitValueForYearInDateWithSeparatorIsTooSmall_ReturnsEmptyArray {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"31/12/0999"];

    XCTAssertEqual(0, result.count);
}

- (void)test_matchesForPassword_TwoDigitValueForYearInDateWithSeparatorIsGreaterThan50_ReturnsMatchWithYearIn1900s {
    [self assertPassword:@"31/12/51" matchesDateWithYear:1951 month:12 day:31 separator:@"/"];
}

- (void)test_matchesForPassword_TwoDigitValueForYearInDateWithSeparatorIsLessThan51_ReturnsMatchWithYearIn2000s {
    [self assertPassword:@"31/12/50" matchesDateWithYear:2050 month:12 day:31 separator:@"/"];
}

- (void)test_matchesForPassword_TwoDigitValueForYearInDateWithSeparatorWithSingleUniqueMatch_ReturnsSingleMatch {
    [self assertPassword:@"12/12/12" matchesDateWithYear:2012 month:12 day:12 separator:@"/"];
}

- (void)test_matchesForPassword_DateWithSeparatorWithMultiplePossibleMatches_ReturnsAllMatches {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"11/12/13"];

    XCTAssertEqual(3, result.count);
    [self assertMatch:result[0] matchesDateWithYear:2011 month:12 day:13 separator:@"/"];
    [self assertMatch:result[1] matchesDateWithYear:2013 month:12 day:11 separator:@"/"];
    [self assertMatch:result[2] matchesDateWithYear:2013 month:11 day:12 separator:@"/"];
}

- (void)test_matchesForPassword_DateWithoutSeparatorWithFourDigits_ReturnsAllMatches {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"1234"];

    XCTAssertEqual(3, result.count);
    [self assertMatch:result[0] matchesDateWithYear:2034 month:2 day:1 separator:@""];
    [self assertMatch:result[1] matchesDateWithYear:2034 month:1 day:2 separator:@""];
    [self assertMatch:result[2] matchesDateWithYear:2012 month:3 day:4 separator:@""];
}

- (void)test_matchesForPassword_DateWithoutSeparatorWithFiveDigits_ReturnsAllMatches {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"11221"];

    XCTAssertEqual(5, result.count);
    [self assertMatch:result[0] matchesDateWithYear:2021 month:12 day:1 separator:@""];
    [self assertMatch:result[1] matchesDateWithYear:2021 month:1 day:12 separator:@""];
    [self assertMatch:result[2] matchesDateWithYear:2011 month:2 day:21 separator:@""];
    [self assertMatch:result[3] matchesDateWithYear:2021 month:2 day:11 separator:@""];
    [self assertMatch:result[4] matchesDateWithYear:2021 month:11 day:2 separator:@""];
}

- (void)test_matchesForPassword_DateWithoutSeparatorWithSixDigitsAndThreeUniqueMatches_ReturnsThreeMatches {
    DBDateMatcher *sut = [self createDateMatcher];
    
    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"121212"];
    
    XCTAssertEqual(3, result.count);
    [self assertMatch:result[0] matchesDateWithYear:1212 month:2 day:1 separator:@""];
    [self assertMatch:result[1] matchesDateWithYear:1212 month:1 day:2 separator:@""];
    [self assertMatch:result[2] matchesDateWithYear:2012 month:12 day:12 separator:@""];
}

- (void)test_matchesForPassword_DateWithoutSeparatorWithSixDigitsAndSixUniqueMatches_ReturnsSixMatches {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"121011"];

    XCTAssertEqual(6, result.count);
    [self assertMatch:result[0] matchesDateWithYear:1011 month:2 day:1 separator:@""];
    [self assertMatch:result[1] matchesDateWithYear:1011 month:1 day:2 separator:@""];
    [self assertMatch:result[2] matchesDateWithYear:2012 month:10 day:11 separator:@""];
    [self assertMatch:result[3] matchesDateWithYear:2011 month:10 day:12 separator:@""];
    [self assertMatch:result[4] matchesDateWithYear:2011 month:12 day:10 separator:@""];
    [self assertMatch:result[5] matchesDateWithYear:1210 month:1 day:1 separator:@""];
}

- (void)test_matchesForPassword_DateWithoutSeparatorWithSevenDigits_ReturnsAllMatches {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"1121112"];

    XCTAssertEqual(6, result.count);
    [self assertMatch:result[0] matchesDateWithYear:1112 month:12 day:1 separator:@""];
    [self assertMatch:result[1] matchesDateWithYear:1112 month:1 day:12 separator:@""];
    [self assertMatch:result[2] matchesDateWithYear:1112 month:2 day:11 separator:@""];
    [self assertMatch:result[3] matchesDateWithYear:1112 month:11 day:2 separator:@""];
    [self assertMatch:result[4] matchesDateWithYear:1121 month:1 day:12 separator:@""];
    [self assertMatch:result[5] matchesDateWithYear:1121 month:11 day:2 separator:@""];
}

- (void)test_matchesForPassword_DateWithoutSeparatorWithEightDigits_ReturnsAllMatches {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:@"10111213"];

    XCTAssertEqual(3, result.count);
    [self assertMatch:result[0] matchesDateWithYear:1213 month:11 day:10 separator:@""];
    [self assertMatch:result[1] matchesDateWithYear:1213 month:10 day:11 separator:@""];
    [self assertMatch:result[2] matchesDateWithYear:1011 month:12 day:13 separator:@""];
}

- (void)assertPassword:(NSString *)password matchesDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day separator:(NSString *)separator {
    DBDateMatcher *sut = [self createDateMatcher];

    NSArray<DBDateMatch *> *result = [sut matchesForPassword:password];

    XCTAssertEqual(1, result.count);
    [self assertMatch:result[0] matchesDateWithYear:year month:month day:day separator:separator];
}

- (void)assertMatch:(DBDateMatch *)match matchesDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day separator:(NSString *)separator {
    XCTAssertEqual(year, match.year);
    XCTAssertEqual(month, match.month);
    XCTAssertEqual(day, match.day);
    XCTAssertEqualObjects(separator, match.separator);
}

- (DBDateMatcher *)createDateMatcher {
    return [[DBDateMatcher alloc] init];
}

@end
