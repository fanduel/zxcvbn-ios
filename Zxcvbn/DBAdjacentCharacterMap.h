//
//  DBAdjacentCharacterMap.h
//  Zxcvbn
//
//  Created by Steven King on 22/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBAdjacentCharacterMap : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary<NSString *, NSArray<NSString *> *> *)adjacentCharacters NS_DESIGNATED_INITIALIZER;

- (BOOL)containsMapForCharacter:(unichar)character;

- (nonnull NSCharacterSet *)adjacentCharactersForCharacter:(unichar)character;

@end
