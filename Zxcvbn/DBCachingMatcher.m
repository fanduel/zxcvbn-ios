//
//  DBCachingMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 17/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBCachingMatcher.h"

#import "DBMatch.h"

@interface DBCachingMatcher ()

@property (nonatomic) id<DBMatching> matcher;
@property (nonatomic) NSCache *cache;

@end

@implementation DBCachingMatcher

- (instancetype)initWithMatcher:(id<DBMatching>)matcher cache:(NSCache *)cache {
    if (self = [super init]) {
        self.matcher = matcher;
        self.cache = cache;
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    NSArray<DBMatch *> *matches = [self.cache objectForKey:password];
    if (!matches) {
        matches = [self.matcher matchesForPassword:password];
        [self.cache setObject:matches forKey:password];
    }
    return matches;
}

@end
