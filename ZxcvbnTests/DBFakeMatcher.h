//
//  DBFakeMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 24/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBMatching.h"

@interface DBFakeMatcher : NSObject <DBMatching>

@property (nullable, nonatomic) NSDictionary<NSString *, NSArray<DBMatch *> *> *matchesForPasswords;
@property (nullable, nonatomic) NSArray<DBMatch *> *matchesForAnyPassword;
@property (nullable, nonatomic, readonly) NSString *passwordSpy;

@end
