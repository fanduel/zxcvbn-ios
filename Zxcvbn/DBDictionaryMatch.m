//
//  DBDictionaryMatch.m
//  Zxcvbn
//
//  Created by Steven King on 15/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBDictionaryMatch.h"

#import "DBUtilities.h"

@implementation DBDictionaryMatch

- (CGFloat)entropy {
    self.baseEntropy = lg(self.rank); // keep these as properties for display purposes
    self.upperCaseEntropy = [self extraUppercaseEntropy];
    self.l33tEntropy = [self extraL33tEntropy];
    return self.baseEntropy + self.upperCaseEntropy + self.l33tEntropy;
}

- (NSUInteger)guesses {
    return self.rank * self.extraUppercaseGuesses * self.extraL33tGuesses * (self.reversed ? 2 : 1);
}

- (float)extraUppercaseEntropy
{
    return self.extraUppercaseGuesses <= 1 ? 0.0 : lg(self.extraUppercaseGuesses);
}

- (NSUInteger)extraUppercaseGuesses
{
    NSString *word = self.token;
    if ([word rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location == NSNotFound) {
        return 1; // all lower
    }
    
    // a capitalized word is the most common capitalization scheme,
    // so it only doubles the search space (uncapitalized + capitalized): 1 extra bit of entropy.
    // allcaps and end-capitalized are common enough too, underestimate as 1 extra bit to be safe.
    NSString *startUpper = @"^[A-Z][^A-Z]+$";
    NSString *endUpper = @"^[^A-Z]+[A-Z]$";
    NSString *allUpper = @"^[A-Z]+$";
    for (NSString *regex in @[startUpper, endUpper, allUpper]) {
        if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:word]) {
            return 2;
        }
    }
    
    // otherwise calculate the number of ways to capitalize U+L uppercase+lowercase letters with U uppercase letters or less.
    // or, if there's more uppercase than lower (for e.g. PASSwORD), the number of ways to lowercase U+L letters with L lowercase letters or less.
    int uppercaseLength = 0;
    int lowercaseLength = 0;
    for (int i = 0; i < [word length]; i++) {
        unichar chr = [word characterAtIndex:i];
        if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:chr]) {
            uppercaseLength++;
        } else if ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:chr]) {
            lowercaseLength++;
        }
    }
    
    NSUInteger possibilities = 0;
    for (int i = 0; i <= MIN(uppercaseLength, lowercaseLength); i++) {
        possibilities += (NSUInteger)binom(uppercaseLength + lowercaseLength, i);
    }
    return possibilities;
}

- (CGFloat)extraL33tEntropy {
    // corner: return 1 bit for single-letter subs, like 4pple -> apple, instead of 0.
    return self.extraL33tGuesses <= 1 ? 1.0 : lg(self.extraL33tGuesses);
}

- (NSUInteger)extraL33tGuesses
{
    if (!self.l33t) {
        return 1;
    }
    
    int possibilities = 0;
    
    for (NSString *subbed in [self.sub allKeys]) {
        NSString *unsubbed = [self.sub objectForKey:subbed];
        NSUInteger subLength = [[self.token componentsSeparatedByString:subbed] count] - 1;
        NSUInteger unsubLength = [[self.token componentsSeparatedByString:unsubbed] count] - 1;
        for (int i = 0; i <= MIN(unsubLength, subLength); i++) {
            possibilities += binom(unsubLength + subLength, i);
        }
    }
    return possibilities;
}
@end
