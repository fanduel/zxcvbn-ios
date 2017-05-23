//
//  DBAdjacentCharacterMap.m
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBAdjacentCharacterMap.h"

@interface DBAdjacentCharacterMap ()

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic) NSDictionary<NSString *, NSDictionary<NSString *, NSNumber *> *> *adjacentCharacters;

@end

@implementation DBAdjacentCharacterMap

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary<NSString *, NSDictionary<NSString *, NSNumber *> *> *)adjacentCharacters {
    if (self = [super init]) {
        self.name = name;
        self.adjacentCharacters = adjacentCharacters;
    }
    return self;
}

- (BOOL)containsMapForCharacter:(unichar)character {
    return [self.adjacentCharacters.allKeys containsObject:[NSString stringWithCharacters:&character length:1]];
}

- (BOOL)isCharacter:(unichar)first adjacentToCharacter:(unichar)second {
    NSArray<NSString *> *stringWithCharacters = [[self.adjacentCharacters valueForKey:[NSString stringWithCharacters:&first length:1]] allKeys];
    return [stringWithCharacters containsObject:[NSString stringWithCharacters:&second length:1]];
}

- (DBAdjacentCharacterDirection)directionFromCharacter:(unichar)first toCharacter:(unichar)second {
    NSDictionary<NSString *, NSNumber *> *directions = [self.adjacentCharacters valueForKey:[NSString stringWithCharacters:&first length:1]];
    return (DBAdjacentCharacterDirection)[directions valueForKey:[NSString stringWithCharacters:&second length:1] ].unsignedIntegerValue;
}

@end
