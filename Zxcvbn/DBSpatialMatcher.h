//
//  DBSpatialMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBAdjacentCharacterMap;
@class DBSpatialMatch;

#import "DBMatching.h"

@interface DBSpatialMatcher : NSObject <DBMatching>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithAdjacentCharacterMap:(DBAdjacentCharacterMap *)characterMap NS_DESIGNATED_INITIALIZER;

- (NSArray<DBSpatialMatch *> *)matchesForPassword:(NSString *)password;

@end
