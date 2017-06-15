//
//  DBRepeatMatcher.m
//  Zxcvbn
//
//  Created by Steven King on 16/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBRepeatMatcher.h"

#import "DBRepeatMatch.h"

@interface DBRepeatMatcher ()

@property (nonatomic) id<DBMatching> matcher;

@end

@implementation DBRepeatMatcher

- (instancetype)initWithMatcher:(id<DBMatching>)matcher {
    if (self = [super init]) {
        self.matcher = matcher;
    }
    return self;
}

- (DBMatch *)matchForPassword:(NSString *)password {
    for (NSUInteger fragmentLength = 1; fragmentLength <= password.length / 2; fragmentLength++) {
        if (password.length % fragmentLength != 0) {
            continue;
        }
        BOOL isRepeating = YES;
        NSString *firstFragment = [password substringToIndex:fragmentLength];
        for (NSUInteger fragmentIndex = fragmentLength; fragmentIndex < password.length; fragmentIndex += fragmentLength) {
            NSRange fragmentRange = NSMakeRange(fragmentIndex, fragmentLength);
            NSString *secondFragment = [password substringWithRange:fragmentRange];
            if (![firstFragment isEqualToString:secondFragment]) {
                isRepeating = NO;
                break;
            }
        }
        if (isRepeating) {
            DBRepeatMatch *match = [[DBRepeatMatch alloc] init];
            match.token = password;
            match.i = 0;
            match.j = password.length - 1;
            match.repeatedToken = firstFragment;
            match.repeatCount = password.length / fragmentLength;
            match.innerMatch = [self.matcher matchForPassword:firstFragment];
            return match;
        }
    }
    return [self.matcher matchForPassword:password];
}

@end
