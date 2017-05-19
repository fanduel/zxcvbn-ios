//
//  DBBruteForceMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 19/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBBruteForceMatch;

#import "DBMatching.h"

@interface DBBruteForceMatcher : NSObject <DBMatching>

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithCardinality:(NSUInteger)cardinality NS_DESIGNATED_INITIALIZER;

- (nonnull NSArray<DBBruteForceMatch *> *)matchesForPassword:(nonnull NSString *)password;

@end
