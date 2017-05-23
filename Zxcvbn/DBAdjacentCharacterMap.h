//
//  DBAdjacentCharacterMap.h
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBAdjacentCharacterMap : NSObject

@property (nonatomic, readonly, nonnull) NSString *name;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithName:(nonnull NSString *)name dictionary:(nonnull NSDictionary<NSString *, NSArray<NSString *> *> *)adjacentCharacters NS_DESIGNATED_INITIALIZER;

- (BOOL)containsMapForCharacter:(unichar)character;

- (nonnull NSCharacterSet *)adjacentCharactersForCharacter:(unichar)character;

@end
