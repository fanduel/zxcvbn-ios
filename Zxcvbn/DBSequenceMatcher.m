//
//  DBSequenceMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBSequenceMatcher.h"

#import "DBSequenceMatch.h"

@interface DBSequenceMatcher ()

@property (nonatomic) NSDictionary<NSString *, NSString *> *sequences;

@end

@implementation DBSequenceMatcher

- (instancetype)initWithSequences:(NSDictionary<NSString *, NSString *> *)sequences {
    if (self = [super init]) {
        self.sequences = sequences;
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    if (password.length < 2) {
        return @[];
    }
    NSMutableArray<DBMatch *> *result = [[NSMutableArray alloc] init];
    [self.sequences enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull name, NSString * _Nonnull sequence, BOOL * _Nonnull stop) {
        NSRange range = NSMakeRange(0, password.length);
        __block NSInteger delta;
        __block NSUInteger previousSequenceIndex;
        __block BOOL isFirstCharacter = YES;
        __block BOOL isSecondCharacter = YES;
        __block BOOL isSequence = YES;
        [password enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable character, NSRange characterRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            if (![sequence containsString:character]) {
                isSequence = NO;
                *stop = YES;
            }
            NSUInteger currentSequenceIndex = [sequence rangeOfString:character].location;
            if (isFirstCharacter) {
                isFirstCharacter = NO;
            } else if (isSecondCharacter) {
                isSecondCharacter = NO;
                delta = currentSequenceIndex - previousSequenceIndex;
                if (delta == 0) {
                    isSequence = NO;
                    *stop = YES;
                }
            } else {
                NSInteger currentDelta = currentSequenceIndex - previousSequenceIndex;
                if (currentDelta != delta) {
                    isSequence = NO;
                    *stop = YES;
                }
            }
            previousSequenceIndex = [sequence rangeOfString:character].location;
        }];
        if (isSequence) {
            DBSequenceMatch *match = [[DBSequenceMatch alloc] init];
            match.token = password;
            match.i = 0;
            match.j = password.length - 1;
            match.sequenceName = name;
            match.sequenceSpace = sequence.length;
            match.ascending = (delta > 0);
            [result addObject:match];
        }
    }];
    return result;
}

@end
