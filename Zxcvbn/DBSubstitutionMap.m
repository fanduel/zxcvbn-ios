//
//  DBL33tDictionary.m
//  Zxcvbn
//
//  Created by Steven King on 23/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBSubstitutionMap.h"

@interface DBSubstitutionMap ()

@property (nonatomic) NSDictionary<NSString *, NSString *> *substitutions;

@end

@implementation DBSubstitutionMap

- (instancetype)initWithSubstitutions:(NSDictionary<NSString *, NSString *> *)substitutions {
    if (self = [super init]) {
        self.substitutions = substitutions;
    }
    return self;
}

- (BOOL)isSubstituteCharacter:(nonnull NSString *)character {
    return [self.substitutions.allKeys containsObject:character];
}

- (NSArray<NSString *> *)charactersSubstitutedByCharacter:(NSString *)character {
    NSMutableArray<NSString *> *result = [[NSMutableArray alloc] init];
    NSString *substitutions = [self.substitutions valueForKey:character];
    [substitutions enumerateSubstringsInRange:NSMakeRange(0, substitutions.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [result addObject:substring];
    }];
    return result;
}

@end
