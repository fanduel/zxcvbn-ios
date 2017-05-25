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
    NSLog([NSString stringWithFormat:@"Password: %@", password]);
    __block NSArray<DBMatch *> *result = [[NSMutableArray alloc] init];
    __block NSMutableArray<NSString *> *substitutedPasswords = [[NSMutableArray alloc] init];
    NSRange range = NSMakeRange(0, password.length);
    [password enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stopPasswordEnumaration) {
        if ([self.substitutionMap isSubstituteCharacter:character]) {
            NSArray<NSString *> *substitutedCharacters = [self.substitutionMap charactersSubstitutedByCharacter:character];
            [substitutedCharacters enumerateObjectsUsingBlock:^(NSString * _Nonnull substitutedCharacter, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *substitutedPassword = [password stringByReplacingCharactersInRange:characterRange withString:substitutedCharacter];
                [substitutedPasswords addObject:substitutedPassword];
            }];
            *stopPasswordEnumaration = YES;
            DBMatch *innerMatch = [self matchesForPassword:substitutedPasswords.firstObject].firstObject;
            DBL33tMatch *l33tMatch;
            if (![innerMatch isKindOfClass:DBL33tMatch.class]) {
                l33tMatch = [[DBL33tMatch alloc] init];
                l33tMatch.substitutions = [[NSMutableDictionary alloc] init];
                l33tMatch.innerMatch = innerMatch;
            } else {
                l33tMatch = (DBL33tMatch *)innerMatch;
            }
            [l33tMatch.substitutions setValue:character forKey:substitutedCharacters.firstObject];
            result = @[l33tMatch];
        }
    }];
    if (substitutedPasswords.count == 0) {
        NSArray<DBMatch *> *innerMatches = [self.matcher matchesForPassword:password];
        result = innerMatches;
    }
    return result;
}

@end
