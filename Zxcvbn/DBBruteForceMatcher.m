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

@end

@implementation DBBruteForceMatcher

- (NSArray<DBBruteForceMatch *> *)matchesForPassword:(NSString *)password {
    DBBruteForceMatch *match = [[DBBruteForceMatch alloc] init];
    return [NSArray arrayWithObject:match];
}

@end
