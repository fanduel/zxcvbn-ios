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
    __block NSArray<DBMatch *> *result = [[NSMutableArray alloc] init];
    __block BOOL hasSubstitutedCharacters = NO;
    NSRange passwordRange = NSMakeRange(0, password.length);
    [password enumerateSubstringsInRange:passwordRange options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stopPasswordEnumaration) {
        if ([self.substitutionMap isSubstituteCharacter:character]) {
            hasSubstitutedCharacters = YES;
            NSArray<NSString *> *substitutedCharacters = [self.substitutionMap charactersSubstitutedByCharacter:character];
            [substitutedCharacters enumerateObjectsUsingBlock:^(NSString * _Nonnull substitutedCharacter, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *substitutedPassword = [password stringByReplacingCharactersInRange:characterRange withString:substitutedCharacter];
                __block NSMutableArray<DBMatch *> *nonL33tInnerMatches = [[NSMutableArray alloc] init];
                DBL33tSubstitution *substitition = [[DBL33tSubstitution alloc] init];
                substitition.originalCharacrer = character;
                substitition.substitutedCharacrer = substitutedCharacter;
                substitition.characterIndex = characterRange.location;
                NSArray<DBMatch *> *innerMatches = [self matchesForPassword:substitutedPassword];
                [innerMatches enumerateObjectsUsingBlock:^(DBMatch * _Nonnull innerMatch, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (![innerMatch isKindOfClass:DBL33tMatch.class]) {
                        [nonL33tInnerMatches addObject:innerMatch];
                        return;
                    }
                    DBL33tMatch *l33tMatch = (DBL33tMatch *)innerMatch;
                    l33tMatch.substitutions = [l33tMatch.substitutions arrayByAddingObject:substitition];
                    result = [result arrayByAddingObject:l33tMatch];
                }];
                if (nonL33tInnerMatches.count > 0) {
                    DBL33tMatch *l33tMatch = [[DBL33tMatch alloc] init];
                    l33tMatch.substitutions = @[substitition];
                    l33tMatch.innerMatches = nonL33tInnerMatches;
                    result = [result arrayByAddingObject:l33tMatch];
                }
            }];
            *stopPasswordEnumaration = YES;
        }
    }];
    if (!hasSubstitutedCharacters) {
        NSArray<DBMatch *> *innerMatches = [self.matcher matchesForPassword:password];
        result = innerMatches;
    }
    return result;
}

@end
