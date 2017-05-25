//
//  DBL33tMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 23/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBSubstitutionMap;
@class DBL33tMatch;

#import "DBMatching.h"

@interface DBL33tMatcher : NSObject <DBMatching>

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithSubstitutionMap:(nonnull DBSubstitutionMap *)substitutionMap matcher:(nonnull id<DBMatching>)matcher NS_DESIGNATED_INITIALIZER;

@end
