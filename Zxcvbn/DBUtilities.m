//
//  DBUtilities.m
//  Zxcvbn
//
//  Created by Steven King on 11/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBUtilities.h"

@implementation DBUtilities

+ (CGFloat)calcBruteForceCardinalityForPassword:(NSString *)password
{
    int digits = 0;
    int upper = 0;
    int lower = 0;
    int symbols = 0;
    
    for (int i = 0; i < [password length]; i++) {
        unichar chr = [password characterAtIndex:i];
        
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:chr]) {
            digits = 10;
        } else if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:chr]) {
            upper = 26;
        } else if ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:chr]) {
            lower = 26;
        } else {
            symbols = 33;
        }
    }
    
    return digits + upper + lower + symbols;
}

+ (NSString *)displayTimeForSeconds:(CGFloat)seconds
{
    int minute = 60;
    int hour = minute * 60;
    int day = hour * 24;
    int month = day * 31;
    int year = month * 12;
    int century = year * 100;
    if (seconds < minute)
        return @"instant";
    if (seconds < hour)
        return [NSString stringWithFormat:@"%d minutes", 1 + (int)ceil(seconds / minute)];
    if (seconds < day)
        return [NSString stringWithFormat:@"%d hours", 1 + (int)ceil(seconds / hour)];
    if (seconds < month)
        return [NSString stringWithFormat:@"%d days", 1 + (int)ceil(seconds / day)];
    if (seconds < year)
        return [NSString stringWithFormat:@"%d months", 1 + (int)ceil(seconds / month)];
    if (seconds < century)
        return [NSString stringWithFormat:@"%d years", 1 + (int)ceil(seconds / year)];
    return @"centuries";
}

float binom(NSUInteger n, NSUInteger k)
{
    // Returns binomial coefficient (n choose k).
    // http://blog.plover.com/math/choose.html
    if (k > n) { return 0; }
    if (k == 0) { return 1; }
    float result = 1;
    for (int denom = 1; denom <= k; denom++) {
        result *= n;
        result /= denom;
        n -= 1;
    }
    return result;
}

float lg(float n)
{
    return log2f(n);
}

NSString* roundToXDigits(float number, int digits)
{
    //return round(number * pow(10, digits)) / pow(10, digits);
    return [NSString stringWithFormat:@"%.*f", digits, number];
}

id get(NSArray *a, int i)
{
    if (i < 0 || i >= [a count]) {
        return 0;
    }
    return [a objectAtIndex:i];
}

@end
