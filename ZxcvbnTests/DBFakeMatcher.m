//
//  DBFakeMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 24/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBFakeMatcher.h"

@interface DBFakeMatcher ()

@property (nonnull, nonatomic, readwrite) NSArray<NSString *> *matchesForPasswordCalledWithPasswords;

@end

@implementation DBFakeMatcher

- (instancetype)init {
    if (self = [super init]) {
        self.matchesForPasswordCalledWithPasswords = [[NSArray alloc] init];
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    self.matchesForPasswordCalledWithPasswords = [self.matchesForPasswordCalledWithPasswords arrayByAddingObject:password];
    if (self.matchesForPasswords && self.matchesForPasswords[password]) {
        return self.matchesForPasswords[password];
    } else if (self.matchesForAnyPassword) {
        return self.matchesForAnyPassword;
    } else {
        return @[];
    }
}

- (BOOL)didCallMatchesForPassword:(NSString *)password {
    return [self.matchesForPasswordCalledWithPasswords containsObject:password];
}

@end
