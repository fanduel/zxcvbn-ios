//
//  DBUtilities.h
//  Zxcvbn
//
//  Created by Steven King on 11/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface DBUtilities : NSObject

+ (NSUInteger)calcBruteForceCardinalityForPassword:(NSString *)password;

+ (NSString *)displayTimeForSeconds:(CGFloat)seconds;

float binom(NSUInteger n, NSUInteger k);

float lg(float n);

NSString* roundToXDigits(float number, int digits);

id get(NSArray *a, int i);

@end
