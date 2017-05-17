//
//  DBYearMatch.m
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBYearMatch.h"

#import "DBUtilities.h"

@implementation DBYearMatch

static int kNumYears = 119; // years match against 1900 - 2019

- (NSUInteger)guesses {
    return kNumYears;
}

@end
