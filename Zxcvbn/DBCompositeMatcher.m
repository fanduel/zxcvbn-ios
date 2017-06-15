//
//  DBCompositeMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBCompositeMatcher.h"

#import "DBMatch.h"

@interface DBCompositeMatcher ()

@property (nonatomic) NSArray<id<DBMatching>> *matchers;

@end

@implementation DBCompositeMatcher

- (instancetype)initWithMatchers:(NSArray<id<DBMatching>> *)matchers {
    if (self = [super init]) {
        self.matchers = matchers;
    }
    return self;
}

- (DBMatch *)matchForPassword:(NSString *)password {
    return nil;
}

//- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
//    NSMutableArray<DBMatch *> *result = [[NSMutableArray alloc] init];
//    [self.matchers enumerateObjectsUsingBlock:^(id<DBMatching>  _Nonnull matcher, NSUInteger idx, BOOL * _Nonnull stop) {
//        [result addObjectsFromArray:[matcher matchesForPassword:password]];
//    }];
//    return result;
//}

@end
