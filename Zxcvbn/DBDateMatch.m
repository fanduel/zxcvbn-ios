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

@end
