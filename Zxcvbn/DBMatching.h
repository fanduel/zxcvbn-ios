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

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password;

@end
