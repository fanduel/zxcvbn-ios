//
//  DBMatch.m
//  Zxcvbn
//
//  Created by Steven King on 10/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBMatch.h"

@implementation DBMatch

- (CGFloat)guessesLog10 {
    return self.guesses <= 1 ? 0.0 : log10f(self.guesses);
}

@end
