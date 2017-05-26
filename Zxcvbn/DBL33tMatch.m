//
//  DBL33tMatch.m
//  Zxcvbn
//
//  Created by Steven King on 24/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBL33tMatch.h"

@implementation DBL33tSubstitution

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:DBL33tSubstitution.class]) {
        return NO;
    }
    return [self isEqualToL33tSubstitution:(DBL33tSubstitution *)object];
}

- (BOOL)isEqualToL33tSubstitution:(DBL33tSubstitution *)other {
    return [self.originalCharacrer isEqualToString:other.originalCharacrer]
        && [self.substitutedCharacrer isEqualToString:other.substitutedCharacrer]
        && self.characterIndex == other.characterIndex;
}

@end

@implementation DBL33tMatch

@end
