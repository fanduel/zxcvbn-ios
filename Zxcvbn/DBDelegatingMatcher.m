//
//  DBDelegatingMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBDelegatingMatcher.h"

@implementation DBDelegatingMatcher

- (DBMatch *)matchForPassword:(NSString *)password {
    return nil;
}

//- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
//    if (self.delegate) {
//        return [self.delegate matchesForPassword:password];
//    } else {
//        return @[];
//    }
//}

@end
