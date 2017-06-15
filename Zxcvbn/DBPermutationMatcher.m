//
//  DBPermutationMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBPermutationMatcher.h"

#import "DBPermutationMatch.h"

@interface DBPermutationMatcher ()

@property (nonatomic) id<DBMatching> matcher;

@end

@implementation DBPermutationMatcher

- (instancetype)initWithMatcher:(id<DBMatching>)matcher {
    if (self = [super init]) {
        self.matcher = matcher;
    }
    return self;
}

- (DBMatch *)matchForPassword:(NSString *)password {
    return nil;
}

//- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
//    if (password.length == 1) {
//        return [self.matcher matchesForPassword:password];
//    } else if (password.length == 2) {
//        __block DBPermutationMatch *permutationMatch = [[DBPermutationMatch alloc] init];
//        permutationMatch.fragmentMatches = @[];
//        NSRange range = NSMakeRange(0, password.length);
//        [password enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
//            permutationMatch.fragmentMatches = [permutationMatch.fragmentMatches arrayByAddingObject:[self.matcher matchesForPassword:character]];
//        }];
//        return [@[permutationMatch] arrayByAddingObjectsFromArray:[self.matcher matchesForPassword:password]];
//    } else if (password.length == 3) {
//        __block NSMutableArray<DBMatch *> *result = [[NSMutableArray alloc] init];
//        NSRange range = NSMakeRange(0, password.length);
//        [password enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
//            NSUInteger splitIndex = characterRange.location + characterRange.length;
//            NSString *firstPasswordFragment = [password substringToIndex:splitIndex];
//            NSString *secondPasswordFragment = [password substringFromIndex:splitIndex];
//            NSArray<DBMatch *> *firstFragmentMatches = [self.matcher matchesForPassword:firstPasswordFragment];
//            NSArray<DBMatch *> *secondFragmentMatches = [self matchesForPassword:secondPasswordFragment];
//            NSMutableArray<DBMatch *> *nonPermutationMatches = [[NSMutableArray alloc] init];
//            [secondFragmentMatches enumerateObjectsUsingBlock:^(DBMatch * _Nonnull match, NSUInteger idx, BOOL * _Nonnull stop) {
//                DBPermutationMatch *permutationMatch;
//                if ([match isKindOfClass:DBPermutationMatch.class]) {
//                    permutationMatch = (DBPermutationMatch *)match;
//                    NSMutableArray<NSArray<DBMatch *> *> *fragmentMatches = [[NSMutableArray alloc] init];
//                    [fragmentMatches addObject:firstFragmentMatches];
//                    [fragmentMatches addObjectsFromArray:permutationMatch.fragmentMatches];
//                    permutationMatch.fragmentMatches = fragmentMatches;
//                    [result addObject:permutationMatch];
//                } else {
//                    [nonPermutationMatches addObject:match];
//                }
//            }];
//            if (nonPermutationMatches.count > 0) {
//                DBPermutationMatch *permutationMatch = [[DBPermutationMatch alloc] init];
//                NSMutableArray<NSArray<DBMatch *> *> *fragmentMatches = [[NSMutableArray alloc] init];
//                [fragmentMatches addObject:firstFragmentMatches];
//                [fragmentMatches addObject:nonPermutationMatches];
//                permutationMatch.fragmentMatches = fragmentMatches;
//                [result addObject:permutationMatch];
//            }
//        }];
//        NSArray<DBMatch *> *passwordMatches = [self.matcher matchesForPassword:password];
//        [result addObjectsFromArray:passwordMatches];
//        return result;
//    }
//    return @[];
//}

@end
