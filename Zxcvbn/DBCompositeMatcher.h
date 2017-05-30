//
//  DBCompositeMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBMatching.h"

@interface DBCompositeMatcher : NSObject <DBMatching>

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithMatchers:(nonnull NSArray<id<DBMatching>> *)matchers NS_DESIGNATED_INITIALIZER;

@end
