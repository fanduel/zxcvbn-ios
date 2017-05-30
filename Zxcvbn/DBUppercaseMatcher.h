//
//  DBUppercaseMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBUppercaseMatch;

#import "DBMatching.h"

@interface DBUppercaseMatcher : NSObject <DBMatching>

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithMatcher:(nonnull id<DBMatching>)matcher NS_DESIGNATED_INITIALIZER;

@end
