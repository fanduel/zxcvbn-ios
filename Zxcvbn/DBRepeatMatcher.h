//
//  DBRepeatMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBMatching.h"

@interface DBRepeatMatcher : NSObject <DBMatching>

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithMatcher:(nonnull id<DBMatching>)matcher NS_DESIGNATED_INITIALIZER;

@end
