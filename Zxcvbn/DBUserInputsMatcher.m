//
//  DBDictionaryMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBUserInputsMatcher.h"

#import "DBMatch.h"

@interface DBUserInputsMatcher ()

@property (nonatomic) NSArray<NSString *> *userInputs;

@end

@implementation DBUserInputsMatcher

- (instancetype)initWithUserInputs:(NSArray<NSString *> *)userInputs {
    if (self = [super init]) {
        self.userInputs = userInputs;
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    __block NSMutableArray<DBMatch *> *results = [[NSMutableArray alloc] init];
    [self.userInputs enumerateObjectsUsingBlock:^(NSString * _Nonnull userInput, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![userInput isEqualToString:password]) {
            return;
        }
        DBMatch *match = [[DBMatch alloc] init];
        match.token = password;
        match.i = 0;
        match.j = password.length - 1;
        [results addObject:match];
    }];
    return results;
}

@end
