//
//  DBL33tDictionary.m
//  Zxcvbn
//
//  Created by Steven King on 23/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBSubstitutionMap.h"

@interface DBSubstitutionMap ()

@property (nonatomic) NSMutableDictionary<NSString *, NSString *> *substitutions;

@end

@implementation DBSubstitutionMap

- (instancetype)initWithSubstitutions:(NSDictionary<NSString *, NSString *> *)substitutions {
    if (self = [super init]) {
        self.substitutions = [[NSMutableDictionary alloc] init];
        [substitutions enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
            [self.substitutions setValue:value forKey:[self keyForCharacter:key]];
        }];
    }
    return self;
}

- (BOOL)isSubstituteCharacter:(nonnull NSString *)character {
    NSString *key = [self keyForCharacter:character];
    return [self.substitutions.allKeys containsObject:key];
}

- (NSArray<NSString *> *)charactersSubstitutedByCharacter:(NSString *)character {
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    NSString *key = [self keyForCharacter:character];
    NSString *substitutedCharacters = [self.substitutions valueForKey:key];
    [substitutedCharacters enumerateSubstringsInRange:NSMakeRange(0, substitutedCharacters.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substitutedCharacter, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [result addObject:substitutedCharacter];
    }];
    return result;
}

- (NSString *)keyForCharacter:(NSString *)character {
    return [NSString stringWithFormat:@"key%@", character];
}

@end
