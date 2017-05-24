//
//  DBL33tDictionary.h
//  Zxcvbn
//
//  Created by Steven King on 23/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBSubstitutionMap : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithSubstitutions:(nonnull NSDictionary<NSString *, NSString *> *)substitutions NS_DESIGNATED_INITIALIZER;

- (BOOL)isSubstituteCharacter:(nonnull NSString *)character;

- (nonnull NSArray<NSString *> *)charactersSubstitutedByCharacter:(nonnull NSString *)character;

@end
