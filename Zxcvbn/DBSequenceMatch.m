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


- (NSUInteger)guesses
{
    NSString *firstChr = [self.token substringToIndex:1];
    NSUInteger baseGuesses;
    if ([@[@"a", @"A", @"z", @"Z", @"0", @"1", @"9"] containsObject:firstChr]) {
        baseGuesses = 4;
    } else {
        unichar chr = [firstChr characterAtIndex:0];
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:chr]) {
            baseGuesses = 10; // digits
        } else {
            baseGuesses = 26; // lower
        }
    }
    if (!self.ascending) {
        baseGuesses *= 2; // extra bit for descending instead of ascending
    }
    return baseGuesses * self.token.length;
}

- (CGFloat)entropy
{
    return lg(self.guesses);
}

@end
