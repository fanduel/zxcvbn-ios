//
//  DBSpatialMatch.m
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBSpatialMatch.h"

#import "DBUtilities.h"
#import "DBMatchResources.h"

@interface DBSpatialMatch ()

@property (nonatomic, assign) NSUInteger keyboardAverageDegree;
@property (nonatomic, assign) NSUInteger keypadAverageDegree;
@property (nonatomic, assign) NSUInteger keyboardStartingPositions;
@property (nonatomic, assign) NSUInteger keypadStartingPositions;

@end

@implementation DBSpatialMatch

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary<NSString *, NSDictionary<NSString *, NSArray<NSString *> *> *> *graphs = [DBMatchResources sharedDBMatcherResources].graphs;
        
        self.keyboardAverageDegree = [self calcAverageDegree:[graphs objectForKey:@"qwerty"]];
        self.keypadAverageDegree = [self calcAverageDegree:[graphs objectForKey:@"keypad"]]; // slightly different for keypad/mac keypad, but close enough
        
        self.keyboardStartingPositions = [[graphs objectForKey:@"qwerty"] count];
        self.keypadStartingPositions = [[graphs objectForKey:@"keypad"] count];
    }
    return self;
}

- (CGFloat)calcAverageDegree:(NSDictionary *)graph
{
    // on qwerty, 'g' has degree 6, being adjacent to 'ftyhbv'. '\' has degree 1.
    // this calculates the average over all keys.
    float average = 0.0;
    for (NSString *key in [graph allKeys]) {
        NSMutableArray *neighbors = [[NSMutableArray alloc] init];
        for (NSString *n in (NSArray *)[graph objectForKey:key]) {
            if (n != (id)[NSNull null]) {
                [neighbors addObject:n];
            }
        }
        average += [neighbors count];
    }
    average /= [graph count];
    return average;
}

- (NSUInteger)guesses
{
    NSUInteger s;
    NSUInteger d;
    if ([@[@"qwerty", @"dvorak"] containsObject:self.graph]) {
        s = self.keyboardStartingPositions;
        d = self.keyboardAverageDegree;
    } else {
        s = self.keypadStartingPositions;
        d = self.keypadAverageDegree;
    }
    int possibilities = 0;
    NSUInteger L = [self.token length];
    int t = self.turns;
    // estimate the number of possible patterns w/ length L or less with t turns or less.
    for (int i = 2; i <= L; i++) {
        int possibleTurns = MIN(t, i - 1);
        for (int j = 1; j <= possibleTurns; j++) {
            possibilities += binom(i - 1, j - 1) * s * pow(d, j);
        }
    }
    // add extra entropy for shifted keys. (% instead of 5, A instead of a.)
    // math is similar to extra entropy from uppercase letters in dictionary matches.
    if (self.shiftedCount) {
        int S = self.shiftedCount;
        NSUInteger U = [self.token length] - self.shiftedCount; // unshifted count
        NSUInteger shiftPossibilities = 0;
        if (S == 0 || U == 0) {
            shiftPossibilities = 2;
        } else {
            for (int i = 0; i <= MIN(S, U); i++) {
                shiftPossibilities += binom(S + U, i);
            }
        }
        possibilities *= shiftPossibilities;
    }
    return possibilities;
}

@end
