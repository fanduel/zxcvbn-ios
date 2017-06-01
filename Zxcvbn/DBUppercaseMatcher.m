//
//  DBUppercaseMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBUppercaseMatcher.h"

#import "DBUppercaseMatch.h"

@interface DBUppercaseMatcher ()

@property (nonatomic) id<DBMatching> matcher;

@end

@implementation DBUppercaseMatcher

- (instancetype)initWithMatcher:(id<DBMatching>)matcher {
    if (self = [super init]) {
        self.matcher = matcher;
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    if ([password isEqualToString:password.lowercaseString]) {
        return [self.matcher matchesForPassword:password];
    } else {
        DBUppercaseMatch *match = [[DBUppercaseMatch alloc] init];
        match.token = password;
        match.i = 0;
        match.j = password.length - 1;
        match.substitutedCharacters = @[];
        match.innerMatches = [self.matcher matchesForPassword:password.lowercaseString];
        NSRange range = NSMakeRange(0, password.length);
        [password enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            if (character != character.lowercaseString) {
                match.substitutedCharacters = [match.substitutedCharacters arrayByAddingObject:character];
            }
        }];
        return @[match];
    }
}

@end
