//
//  DBCachingMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 17/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBMatching.h"

@interface DBCachingMatcher : NSObject <DBMatching>

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithMatcher:(nonnull id<DBMatching>)matcher cache:(NSCache *)cache NS_DESIGNATED_INITIALIZER;

@end
