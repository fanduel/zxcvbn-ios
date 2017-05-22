//
//  DBDictionaryMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBDictionaryMatcher.h"

#import "DBDictionaryMatch.h"
#import "DBRankedDictionary.h"

@interface DBDictionaryMatcher ()

@property (nonatomic) DBRankedDictionary *rankedDictionary;

@end

@implementation DBDictionaryMatcher

- (instancetype)initWithRankedDictionary:(DBRankedDictionary *)dictionary {
    if (self = [super init]) {
        self.rankedDictionary = dictionary;
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    if ([self.rankedDictionary containsWord:password]) {
        DBDictionaryMatch *match = [[DBDictionaryMatch alloc] init];
        match.token = password;
        match.i = 0;
        match.j = password.length - 1;
        match.dictionaryName = self.rankedDictionary.name;
        match.rank = [self.rankedDictionary rankForWord:password];
        return @[match];
    } else {
        return @[];
    }
}

@end
