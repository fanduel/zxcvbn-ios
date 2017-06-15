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

- (DBMatch *)matchForPassword:(NSString *)password {
    DBMatch *match = [self.cache objectForKey:password];
    if (!match) {
        match = [self.matcher matchForPassword:password];
        if (match) {
            [self.cache setObject:match forKey:password];
        } else {
            [self.cache setObject:[NSNull null] forKey:password];
        }
        
    } else if ([match isKindOfClass:NSNull.class]) {
        return nil;
    }   
    return match;
}

@end
