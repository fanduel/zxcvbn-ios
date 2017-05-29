//
//  DBSequenceMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBMatching.h"

@interface DBSequenceMatcher : NSObject <DBMatching>

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithSequences:(nonnull NSDictionary<NSString *, NSString *> *)sequences NS_DESIGNATED_INITIALIZER;

@end
