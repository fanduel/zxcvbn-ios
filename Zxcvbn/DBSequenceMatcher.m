//
//  DBSequenceMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBSequenceMatcher.h"

#import "DBMatch.h"

@interface DBSequenceMatcher ()

@property (nonatomic) NSDictionary<NSString *, NSString *> *sequences;

@end

@implementation DBSequenceMatcher

- (instancetype)initWithSequences:(NSDictionary<NSString *, NSString *> *)sequences {
    if (self = [super init]) {
        self.sequences = sequences;
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    if (password.length < 2) {
        return @[];
    }
    NSMutableArray<DBMatch *> *result = [[NSMutableArray alloc] init];
    [self.sequences enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull name, NSString * _Nonnull sequence, BOOL * _Nonnull stop) {
        if ([sequence containsString:password]) {
            [result addObject:[[DBMatch alloc] init]];
        }
    }];
    return result;
}

@end
