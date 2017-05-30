//
//  DBUppercaseMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBUppercaseMatcher.h"

#import "DBUppercaseMatch.h"

@interface DBUppercaseMatcher ()

@property (nonatomic) id<DBMatching> matcher;

@end

@implementation DBUppercaseMatcher

- (instancetype)initWithMatcher:(id<DBMatching>)matcher {
    if (self = [super init]) {
        self.matcher = matcher;
    }
    return self;
}

- (NSArray<DBMatch *> *)matchesForPassword:(NSString *)password {
    if ([password isEqualToString:password.lowercaseString]) {
        return [self.matcher matchesForPassword:password];
    } else {
        DBUppercaseMatch *match = [[DBUppercaseMatch alloc] init];
        match.token = password;
        match.i = 0;
        match.j = password.length - 1;
        match.innerMatches = [self.matcher matchesForPassword:password.lowercaseString];
        return @[match];
    }
}

@end
