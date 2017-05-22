//
//  DBAdjacentCharacterMap.m
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBAdjacentCharacterMap.h"

@interface DBAdjacentCharacterMap ()

@property (nonatomic) NSDictionary<NSString *,NSString *> *adjacentCharacters;

@end

@implementation DBAdjacentCharacterMap

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *> *)adjacentCharacters {
    if (self = [super init]) {
        self.adjacentCharacters = adjacentCharacters;
    }
    return self;
}

- (BOOL)containsMapForCharacter:(unichar)character {
    return [self.adjacentCharacters.allKeys containsObject:[NSString stringWithCharacters:&character length:1]];
}

- (NSCharacterSet *)adjacentCharactersForCharacter:(unichar)character {
    NSString *stringWithCharacters = [self.adjacentCharacters valueForKey:[NSString stringWithCharacters:&character length:1]];
    return [NSCharacterSet characterSetWithCharactersInString:stringWithCharacters];
}

@end
