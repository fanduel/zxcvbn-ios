//
//  DBFakeMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 24/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBFakeMatcher.h"

@implementation DBFakeMatcher

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    NSArray<DBMatch *> *result;
    if (self.matchesForPasswords && self.matchesForPasswords[password]) {
        return self.matchesForPasswords[password];
    } else if (self.matchesForAnyPassword) {
        return self.matchesForAnyPassword;
    } else {
        return @[];
    }
}

@end
