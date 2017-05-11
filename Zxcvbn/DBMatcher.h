//
//  DBMatcher.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBMatch;

@interface DBMatcher : NSObject

- (NSArray<DBMatch *> *)omnimatch:(NSString *)password userInputs:(NSArray<NSString *> *)userInputs;

@end
