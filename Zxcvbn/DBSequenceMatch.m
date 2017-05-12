//
//  DBSequenceMatch.m
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBSequenceMatch.h"

#import "DBUtilities.h"

@implementation DBSequenceMatch

- (CGFloat)entropy
{
    NSString *firstChr = [self.token substringToIndex:1];
    float baseEntropy = 0;
    if ([@[@"a", @"1"] containsObject:firstChr]) {
        baseEntropy = 1;
    } else {
        unichar chr = [firstChr characterAtIndex:0];
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:chr]) {
            baseEntropy = lg(10); // digits
        } else if ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:chr]) {
            baseEntropy = lg(26); // lower
        } else {
            baseEntropy = lg(26) + 1; // extra bit for uppercase
        }
    }
    if (!self.ascending) {
        baseEntropy += 1; // extra bit for descending instead of ascending
    }
    return baseEntropy + lg([self.token length]);
}

@end
