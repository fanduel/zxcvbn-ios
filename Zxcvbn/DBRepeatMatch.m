//
//  DBRepeatMatch.m
//  Zxcvbn
//
//  Created by Steven King on 11/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBRepeatMatch.h"

#import "DBUtilities.h"

@implementation DBRepeatMatch

- (NSUInteger)guesses {
    NSUInteger cardinality = [DBUtilities calcBruteForceCardinalityForPassword:self.token];
    return cardinality * self.token.length;
}

@end
