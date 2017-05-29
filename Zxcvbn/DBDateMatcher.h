//
//  DBDateMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBDateMatch;

#import "DBMatching.h"

@interface DBDateMatcher : NSObject <DBMatching>

- (nonnull NSArray<DBDateMatch *> *)matchesForPassword:(nonnull NSString *)password;

@end
