//
//  DBYearMatch.m
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBDateMatch.h"

#import "DBUtilities.h"

@implementation DBDateMatch

static int kNumYears = 119; // years match against 1900 - 2019
static int kNumMonths = 12;
static int kNumDays = 31;

- (NSUInteger)guesses {
    NSUInteger result = 1;
    if (self.year < 100) {
        result = kNumDays * kNumMonths * 100; // two-digit year
    } else {
        result = kNumDays * kNumMonths * kNumYears; // four-digit year
    }
    if ([self.separator length]) {
        result *= 4; // add two bits for separator selection [/,-,.,etc]
    }
    return result;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:DBDateMatch.class]) {
        return NO;
    }
    return [self isEqualToDBDateMatch:(DBDateMatch *)object];
}

- (BOOL)isEqualToDBDateMatch:(DBDateMatch *)other {
    return self.year == other.year
        && self.month == other.month
        && self.day == other.day
        && [self.separator isEqualToString:other.separator];
}

@end
