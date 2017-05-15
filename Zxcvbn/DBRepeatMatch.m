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

- (CGFloat)entropy
{
    float cardinality = [DBUtilities calcBruteForceCardinalityForPassword:self.token];
    return lg(cardinality * [self.token length]);
}

@end
