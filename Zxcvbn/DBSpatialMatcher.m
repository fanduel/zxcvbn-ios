//
//  DBSpatialMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBSpatialMatcher.h"

#import "DBSpatialMatch.h"
#import "DBAdjacentCharacterMap.h"

@interface DBSpatialMatcher ()

@property (nonatomic) DBAdjacentCharacterMap *characterMap;

@end

@implementation DBSpatialMatcher

- (instancetype)initWithAdjacentCharacterMap:(DBAdjacentCharacterMap *)characterMap {
    if (self = [super init]) {
        self.characterMap = characterMap;
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    if (password.length < 3) {
        return @[];
    }
    unichar previousCharacter = [password characterAtIndex:0];
    DBAdjacentCharacterDirection previousDirection = DBAdjacentCharacterDirectionNone;
    NSUInteger turns = 0;
    for (NSUInteger i = 1; i < password.length; i++) {
        unichar character = [password characterAtIndex:i];
        if (![self.characterMap containsMapForCharacter:previousCharacter]) {
            return @[];
        } else if (![self.characterMap isCharacter:previousCharacter adjacentToCharacter:character]) {
            return @[];
        } else {
            DBAdjacentCharacterDirection direction = [self.characterMap directionFromCharacter:previousCharacter toCharacter:character];
            if (previousDirection != direction) {
                turns++;
            }
            previousCharacter = character;
            previousDirection = direction;
        }
    }
    DBSpatialMatch *match = [[DBSpatialMatch alloc] init];
    match.token = password;
    match.i = 0;
    match.j = password.length - 1;
    match.graph = self.characterMap.name;
    match.turns = turns;
    return @[match];
}

@end
