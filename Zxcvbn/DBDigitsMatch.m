//
//  DBDigitsMatch.m
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBDigitsMatch.h"

#import "DBUtilities.h"

@implementation DBDigitsMatch

- (NSUInteger)guesses {
    return pow(10, self.token.length);
}

@end
