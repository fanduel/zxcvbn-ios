//
//  DBAdjacentCharacterMap.h
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DBAdjacentCharacterDirectionUp,
    DBAdjacentCharacterDirectionLeft,
    DBAdjacentCharacterDirectionRight,
    DBAdjacentCharacterDirectionDown
} DBAdjacentCharacterDirection;

@interface DBAdjacentCharacterMap : NSObject

@property (nonatomic, readonly, nonnull) NSString *name;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithName:(nonnull NSString *)name dictionary:(nonnull NSDictionary<NSString *, NSDictionary<NSString *, NSNumber *> *> *)adjacentCharacters NS_DESIGNATED_INITIALIZER;

- (BOOL)containsMapForCharacter:(unichar)character;

- (BOOL)isCharacter:(unichar)first adjacentToCharacter:(unichar)second;

- (DBAdjacentCharacterDirection)directionFromCharacter:(unichar)first toCharacter:(unichar)second;

@end
