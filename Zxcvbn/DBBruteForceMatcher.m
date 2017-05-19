//
//  DBBruteForceMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 19/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBBruteForceMatcher.h"

#import "DBBruteForceMatch.h"

@interface DBBruteForceMatcher ()

@property (nonatomic, assign) NSUInteger cardinality;

@end

@implementation DBBruteForceMatcher

- (instancetype)initWithCardinality:(NSUInteger)cardinality {
    if (self = [super init]) {
        self.cardinality = cardinality;
    }
    return self;
}

- (NSArray<DBBruteForceMatch *> *)matchesForPassword:(NSString *)password {
    if (password.length == 0) {
        return [NSArray array];
    }
    DBBruteForceMatch *match = [[DBBruteForceMatch alloc] init];
    match.token = password;
    match.i = 0;
    match.j = password.length - 1;
    match.cardinality = self.cardinality;
    return [NSArray arrayWithObject:match];
}

@end
