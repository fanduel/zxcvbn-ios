//
//  DBMatching.h
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBMatch;

@protocol DBMatching

- (nonnull NSArray<DBMatch *> *)matchesForPassword:(nonnull NSString *)password;

@end
