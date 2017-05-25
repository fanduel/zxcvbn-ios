//
//  DBL33tMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 23/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBL33tMatcher.h"

#import "DBSubstitutionMap.h"
#import "DBL33tMatch.h"

@interface DBL33tMatcher ()

@property (nonatomic) id<DBMatching> matcher;
@property (nonatomic) DBSubstitutionMap *substitutionMap;

@end

@implementation DBL33tMatcher

- (instancetype)initWithSubstitutionMap:(DBSubstitutionMap *)substitutionMap matcher:(id<DBMatching>)matcher {
    self.substitutionMap = substitutionMap;
    self.matcher = matcher;
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    __block NSString *innerPassword = password;
    NSRange range = NSMakeRange(0, password.length);
    [password enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([self.substitutionMap isSubstituteCharacter:character]) {
            NSString *substitutedCharacter = [[self.substitutionMap charactersSubstitutedByCharacter:character] firstObject];
            innerPassword = [innerPassword stringByReplacingCharactersInRange:characterRange withString:substitutedCharacter];
        }
    }];
    NSArray<DBMatch *> *innerMatches = [self.matcher matchesForPassword:innerPassword];
    if ([innerPassword isEqualToString:password]) {
        return innerMatches;
    } else {
        DBL33tMatch *result = [[DBL33tMatch alloc] init];
        result.innerMatch = innerMatches.firstObject;
        return @[result];
    }
}

@end
