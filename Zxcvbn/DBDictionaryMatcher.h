//
//  DBDictionaryMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBRankedDictionary;
@class DBDictionaryMatch;

#import "DBMatching.h"

@interface DBDictionaryMatcher : NSObject <DBMatching>

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithRankedDictionary:(nonnull DBRankedDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

- (nonnull NSArray<DBDictionaryMatch *> *)matchesForPassword:(nonnull NSString *)password;

@end
