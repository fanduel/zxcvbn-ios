//
//  DBDateMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBDateMatcher.h"

#import "DBDateMatch.h"

@interface DBDateMatcher ()

@property (nonatomic) NSRegularExpression *dateWithSeparatorsRegularExpression;
@property (nonatomic) NSString *datePattern;

@end

@implementation DBDateMatcher

- (instancetype)init {
    if (self = [super init]) {
        NSString *oneOrTwoDigits = @"(\\d{1,2})";
        NSString *oneOrTwoOrFourDigits = @"(\\d{1,2}|\\d{4})";
        NSString *separator = @"(\\\\|\\/|\\.|-|_| )";
        NSString *dateWithSeparatorsPattern = [NSString stringWithFormat:@"^%@%@%@%@%@$", oneOrTwoOrFourDigits, separator, oneOrTwoDigits, separator, oneOrTwoOrFourDigits];
        self.dateWithSeparatorsRegularExpression = [NSRegularExpression regularExpressionWithPattern:dateWithSeparatorsPattern options:0 error:nil];
    }
    return self;
}

- (NSArray<DBDateMatch *> *)matchesForPassword:(NSString *)password {
    __block NSMutableArray<DBDateMatch *> *matches = [[NSMutableArray alloc] init];
    NSRange range = NSMakeRange(0, password.length);
    [self.dateWithSeparatorsRegularExpression enumerateMatchesInString:password options:0 range:range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSString *firstSeparator = [password substringWithRange:[result rangeAtIndex:2]];
        NSString *secondSeparator = [password substringWithRange:[result rangeAtIndex:4]];
        if (![firstSeparator isEqualToString:secondSeparator]) {
            return;
        }
        NSInteger first = [[password substringWithRange:[result rangeAtIndex:1]] integerValue];
        NSInteger second = [[password substringWithRange:[result rangeAtIndex:3]] integerValue];
        NSInteger third = [[password substringWithRange:[result rangeAtIndex:5]] integerValue];
        [matches addObjectsFromArray:[self matchesForFirst:first second:second third:third separator:firstSeparator]];
    }];
    return matches;
}

- (NSArray<DBDateMatch *> *)matchesForFirst:(NSInteger)first second:(NSInteger)second third:(NSInteger)third separator:(NSString *)separator {
    NSMutableArray *matches = [[NSMutableArray alloc] init];
    [matches addObjectsFromArray:[self matchesForYear:first month:second day:third separator:separator]];
    [matches addObjectsFromArray:[self matchesForYear:third month:second day:first separator:separator]];
    [matches addObjectsFromArray:[self matchesForYear:third month:first day:second separator:separator]];
    return matches;
}

- (NSArray<DBDateMatch *> *)matchesForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day separator:(NSString *)separator {
    NSInteger expandedYear = [self expandYearValue:year];
    if ([self isValidDayValue:day] && [self isValidMonthValue:month] && [self isValidYearValue:expandedYear]) {
        DBDateMatch *match = [[DBDateMatch alloc] init];
        match.year = expandedYear;
        match.month = month;
        match.day = day;
        match.separator = separator;
        return @[match];
    } else {
        return @[];
    }
}

- (NSInteger)expandYearValue:(NSInteger)value {
    if (value >= 100) {
        return value;
    } else if (value >= 51) {
        return 1900 + value;
    } else {
        return 2000 + value;
    }
}

- (BOOL)isValidDayValue:(NSInteger)value {
    return value >= 1 && value <= 31;
}

- (BOOL)isValidMonthValue:(NSInteger)value {
    return value >= 1 && value <= 12;
}

- (BOOL)isValidYearValue:(NSInteger)value {
    return value >= 1000 && value <= 2050;
}

@end
