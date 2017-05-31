//
//  DBPermutationMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBMatching.h"

@interface DBPermutationMatcher : NSObject <DBMatching>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithMatcher:(id<DBMatching>)matcher NS_DESIGNATED_INITIALIZER;

@end
