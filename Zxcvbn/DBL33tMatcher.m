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

@interface DBSubstitution : NSObject

@property (nonatomic) NSRange range;
@property (nonatomic) NSString *originalCharacter;
@property (nonatomic) NSArray<NSString *> *substituteCharacters;

@end

@implementation DBSubstitution

@end

@interface DBL33tMatcher ()

@property (nonatomic) id<DBMatching> matcher;
@property (nonatomic) DBSubstitutionMap *substitutionMap;
@property (nonatomic) NSMutableArray<DBSubstitution *> *substitutions;

@end

@implementation DBL33tMatcher

- (instancetype)initWithSubstitutionMap:(DBSubstitutionMap *)substitutionMap matcher:(id<DBMatching>)matcher {
    self.substitutionMap = substitutionMap;
    self.matcher = matcher;
    self.substitutions = [[NSMutableArray alloc] init];
    return self;
}

- (DBMatch *)matchForPassword:(NSString *)password {
    NSRange passwordRange = NSMakeRange(0, password.length);
    [password enumerateSubstringsInRange:passwordRange options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stopPasswordEnumaration) {
        if ([self.substitutionMap isSubstituteCharacter:character]) {
            DBSubstitution *substitution = [[DBSubstitution alloc] init];
            substitution.range = characterRange;
            substitution.originalCharacter = character;
            substitution.substituteCharacters = [self.substitutionMap charactersSubstitutedByCharacter:character];
            [self.substitutions addObject:substitution];
        }
    }];
    return [self matchForPassword:password substitutions:self.substitutions];
}

- (DBMatch *)matchForPassword:(NSString *)password substitutions:(NSArray<DBSubstitution *> *)substitutions {
    DBSubstitution *substitution = substitutions.firstObject;
    __block DBMatch *result = [self.matcher matchForPassword:password];
//    if (newResult.guesses < result.guesses) {
//        result = newResult;
//    }
    [substitution.substituteCharacters enumerateObjectsUsingBlock:^(NSString * _Nonnull character, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *newPassword = [password stringByReplacingCharactersInRange:substitution.range withString:character];
        DBMatch *newMatch = [self.matcher matchForPassword:newPassword];
        if (newMatch.guesses < result.guesses) {
            result = newMatch;
        }
        if (substitutions.count)
        NSArray<DBSubstitution *> *newSubstitutions = [substitutions subarrayWithRange:NSMakeRange(1, substitutions.count - 1)];
        DBMatch *nextResult =  [self matchForPassword:newPassword substitutions:newSubstitutions];
        if (nextResult.guesses < result.guesses) {
            result = nextResult;
        }
    }];
    return result;
}

//- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
//    __block DBMatch *result;
//    __block BOOL hasSubstitutedCharacters = NO;
//    NSRange passwordRange = NSMakeRange(0, password.length);
//    [password enumerateSubstringsInRange:passwordRange options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stopPasswordEnumaration) {
//        if ([self.substitutionMap isSubstituteCharacter:character]) {
//            hasSubstitutedCharacters = YES;
//            NSArray<NSString *> *substitutedCharacters = [self.substitutionMap charactersSubstitutedByCharacter:character];
//            [substitutedCharacters enumerateObjectsUsingBlock:^(NSString * _Nonnull substitutedCharacter, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSString *substitutedPassword = [password stringByReplacingCharactersInRange:characterRange withString:substitutedCharacter];
//                __block NSMutableArray<DBMatch *> *nonL33tInnerMatches = [[NSMutableArray alloc] init];
//                DBL33tSubstitution *substitition = [[DBL33tSubstitution alloc] init];
//                substitition.originalCharacrer = character;
//                substitition.substitutedCharacrer = substitutedCharacter;
//                substitition.characterIndex = characterRange.location;
//                NSArray<DBMatch *> *innerMatches = [self matchesForPassword:substitutedPassword];
//                [innerMatches enumerateObjectsUsingBlock:^(DBMatch * _Nonnull innerMatch, NSUInteger idx, BOOL * _Nonnull stop) {
//                    if (![innerMatch isKindOfClass:DBL33tMatch.class]) {
//                        [nonL33tInnerMatches addObject:innerMatch];
//                        return;
//                    }
//                    DBL33tMatch *l33tMatch = (DBL33tMatch *)innerMatch;
//                    l33tMatch.substitutions = [l33tMatch.substitutions arrayByAddingObject:substitition];
//                    result = [result arrayByAddingObject:l33tMatch];
//                }];
//                if (nonL33tInnerMatches.count > 0) {
//                    DBL33tMatch *l33tMatch = [[DBL33tMatch alloc] init];
//                    l33tMatch.substitutions = @[substitition];
//                    l33tMatch.innerMatches = nonL33tInnerMatches;
//                    result = [result arrayByAddingObject:l33tMatch];
//                }
//            }];
//            *stopPasswordEnumaration = YES;
//        }
//    }];
//    if (!hasSubstitutedCharacters) {
//        DBMatch *innerMatch = [self.matcher matchForPassword:password];
//        if (innerMatch.guesses < result.guesses) {
//            result = innerMatch;
//        }
//    }
//    return result;
//}

@end
