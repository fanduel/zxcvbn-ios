//
//  DBScorer.m
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import "DBScorer.h"

#import "DBMatcher.h"
#import "DBResult.h"
#import "DBMatch.h"
#import "DBMatchResources.h"
#import "DBUtilities.h"

@interface DBScorer ()

@property (nonatomic, assign) NSUInteger keyboardAverageDegree;
@property (nonatomic, assign) NSUInteger keypadAverageDegree;
@property (nonatomic, assign) NSUInteger keyboardStartingPositions;
@property (nonatomic, assign) NSUInteger keypadStartingPositions;

@end

@implementation DBScorer

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

- (float)calcAverageDegree:(NSDictionary *)graph
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

- (DBResult *)minimumEntropyMatchSequence:(NSString *)password matches:(NSArray *)matches
{
    /* minimum entropy search
     
     takes a list of overlapping matches, returns the non-overlapping sublist with
     minimum entropy. O(nm) dp alg for length-n password with m candidate matches.
     */
    
    float bruteforceCardinality = [DBUtilities calcBruteForceCardinalityForPassword:password]; // e.g. 26 for lowercase
    
    NSMutableArray *upToK = [[NSMutableArray alloc] init]; // minimum entropy up to k.
    NSMutableArray *backpointers = [[NSMutableArray alloc] init]; // for the optimal sequence of matches up to k, holds the final match (match.j == k). null means the sequence ends w/ a brute-force character.
    
    for (int k = 0; k < [password length]; k++) {
        // starting scenario to try and beat: adding a brute-force character to the minimum entropy sequence at k-1.
        [upToK insertObject:[NSNumber numberWithFloat:[get(upToK, k-1) floatValue] + lg(bruteforceCardinality)] atIndex:k];
        [backpointers insertObject:[NSNull null] atIndex:k];
        for (DBMatch *match in matches) {
            NSUInteger i = match.i;
            NSUInteger j = match.j;
            if (j != k) {
                continue;
            }
            // see if best entropy up to i-1 + entropy of this match is less than the current minimum at j.
            float candidateEntropy = [get(upToK, (int)i-1) floatValue] + [self calcEntropy:match];
            if (candidateEntropy < [[upToK objectAtIndex:j] floatValue]) {
                [upToK insertObject:[NSNumber numberWithFloat:candidateEntropy] atIndex:j];
                [backpointers insertObject:match atIndex:j];
            }
        }
    }

    // walk backwards and decode the best sequence
    NSMutableArray *matchSequence = [[NSMutableArray alloc] init];
    NSInteger k = [password length] - 1;
    while (k >= 0) {
        DBMatch *match = [backpointers objectAtIndex:k];
        if (![match isEqual:[NSNull null]]) {
            [matchSequence addObject:match];
            k = match.i - 1;
        } else {
            k -= 1;
        }
    }
    matchSequence = [[NSMutableArray alloc] initWithArray:[[matchSequence reverseObjectEnumerator] allObjects]];

    // fill in the blanks between pattern matches with bruteforce "matches"
    // that way the match sequence fully covers the password: match1.j == match2.i - 1 for every adjacent match1, match2.
    DBMatch* (^makeBruteforceMatch)(NSUInteger i, NSUInteger j) = ^ DBMatch* (NSUInteger i, NSUInteger j) {
        DBMatch *match = [[DBMatch alloc] init];
        match.pattern = @"bruteforce";
        match.i = i;
        match.j = j;
        match.token = [password substringWithRange:NSMakeRange(i, j - i + 1)];
        match.entropy = lg(pow(bruteforceCardinality, j - i + 1));
        match.cardinality = bruteforceCardinality;
        return match;
    };
    k = 0;
    NSMutableArray *matchSequenceCopy = [[NSMutableArray alloc] init];
    for (DBMatch *match in matchSequence) {
        NSUInteger i = match.i;
        NSUInteger j = match.j;
        if (i - k > 0) {
            [matchSequenceCopy addObject:makeBruteforceMatch(k, i-1)];
        }
        k = j + 1;
        [matchSequenceCopy addObject:match];
    }
    if (k < [password length]) {
        [matchSequenceCopy addObject:makeBruteforceMatch(k, [password length] - 1)];
        matchSequence = matchSequenceCopy;
    }

    float minEntropy = 0.0;
    if ([password length] > 0) { // corner case is for an empty password ''
        minEntropy = [[upToK objectAtIndex:[password length] - 1] floatValue];
    }
    float crackTime = [self entropyToCrackTime:minEntropy];

    // final result object
    DBResult *result = [[DBResult alloc] init];
    result.password = password;
    result.entropy = roundToXDigits(minEntropy, 3);
    result.matchSequence = matchSequence;
    result.crackTime = roundToXDigits(crackTime, 3);
    result.crackTimeDisplay = [DBUtilities displayTimeForSeconds:crackTime];
    result.score = [self crackTimeToScore:crackTime];
    return result;
}

- (float)entropyToCrackTime:(float)entropy
{
    /*
     threat model -- stolen hash catastrophe scenario

     assumes:
     * passwords are stored as salted hashes, different random salt per user.
        (making rainbow attacks infeasable.)
     * hashes and salts were stolen. attacker is guessing passwords at max rate.
     * attacker has several CPUs at their disposal.

     * for a hash function like bcrypt/scrypt/PBKDF2, 10ms per guess is a safe lower bound.
     * (usually a guess would take longer -- this assumes fast hardware and a small work factor.)
     * adjust for your site accordingly if you use another hash function, possibly by
     * several orders of magnitude!
     */

    float singleGuess = .010;
    float numAttackers = 100; // number of cores guessing in parallel.

    float secondsPerGuess = singleGuess / numAttackers;

    return .5 * pow(2, entropy) * secondsPerGuess; // average, not total
}

- (int)crackTimeToScore:(float)seconds
{
    if (seconds < pow(10, 2)) {
        return 0;
    }
    if (seconds < pow(10, 4)) {
        return 1;
    }
    if (seconds < pow(10, 6)) {
        return 2;
    }
    if (seconds < pow(10, 8)) {
        return 3;
    }
    return 4;
}

#pragma mark - entropy calcs -- one function per match pattern

- (float)calcEntropy:(DBMatch *)match
{
    if (match.entropy > 0) {
        // a match's entropy doesn't change. cache it.
        return match.entropy;
    }

    if ([match.pattern isEqualToString:@"year"]) {
        match.entropy = [self yearEntropy:match];
    } else if ([match.pattern isEqualToString:@"date"]) {
        match.entropy = [self dateEntropy:match];
    } else if ([match.pattern isEqualToString:@"spatial"]) {
        match.entropy = [self spatialEntropy:match];
    } else if ([match.pattern isEqualToString:@"dictionary"]) {
        match.entropy = [self dictionaryEntropy:match];
    }

    return match.entropy;
}

static int kNumYears = 119; // years match against 1900 - 2019
static int kNumMonths = 12;
static int kNumDays = 31;

- (float)yearEntropy:(DBMatch *)match
{
    return lg(kNumYears);
}

- (float)dateEntropy:(DBMatch *)match
{
    float entropy = 0.0;
    if (match.year < 100) {
        entropy = lg(kNumDays * kNumMonths * 100); // two-digit year
    } else {
        entropy = lg(kNumDays * kNumMonths * kNumYears); // four-digit year
    }
    if ([match.separator length]) {
        entropy += 2; // add two bits for separator selection [/,-,.,etc]
    }
    return entropy;
}

- (float)spatialEntropy:(DBMatch *)match
{
    NSUInteger s;
    NSUInteger d;
    if ([@[@"qwerty", @"dvorak"] containsObject:match.graph]) {
        s = self.keyboardStartingPositions;
        d = self.keyboardAverageDegree;
    } else {
        s = self.keypadStartingPositions;
        d = self.keypadAverageDegree;
    }
    int possibilities = 0;
    NSUInteger L = [match.token length];
    int t = match.turns;
    // estimate the number of possible patterns w/ length L or less with t turns or less.
    for (int i = 2; i <= L; i++) {
        int possibleTurns = MIN(t, i - 1);
        for (int j = 1; j <= possibleTurns; j++) {
            possibilities += binom(i - 1, j - 1) * s * pow(d, j);
        }
    }
    float entropy = lg(possibilities);
    // add extra entropy for shifted keys. (% instead of 5, A instead of a.)
    // math is similar to extra entropy from uppercase letters in dictionary matches.
    if (match.shiftedCount) {
        int S = match.shiftedCount;
        NSUInteger U = [match.token length] - match.shiftedCount; // unshifted count
        NSUInteger possibilities = 0;
        for (int i = 0; i <= MIN(S, U); i++) {
            possibilities += binom(S + U, i);
        }
        entropy += log2f(possibilities);
    }
    return entropy;
}

- (float)dictionaryEntropy:(DBMatch *)match
{
    match.baseEntropy = lg(match.rank); // keep these as properties for display purposes
    match.upperCaseEntropy = [self extraUppercaseEntropy:match];
    match.l33tEntropy = [self extraL33tEntropy:match];
    return match.baseEntropy + match.upperCaseEntropy + match.l33tEntropy;
}

- (float)extraUppercaseEntropy:(DBMatch *)match
{
    NSString *word = match.token;
    if ([word rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location == NSNotFound) {
        return 0; // all lower
    }

    // a capitalized word is the most common capitalization scheme,
    // so it only doubles the search space (uncapitalized + capitalized): 1 extra bit of entropy.
    // allcaps and end-capitalized are common enough too, underestimate as 1 extra bit to be safe.
    NSString *startUpper = @"^[A-Z][^A-Z]+$";
    NSString *endUpper = @"^[^A-Z]+[A-Z]$";
    NSString *allUpper = @"^[A-Z]+$";
    for (NSString *regex in @[startUpper, endUpper, allUpper]) {
        if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:word]) {
            return 1;
        }
    }

    // otherwise calculate the number of ways to capitalize U+L uppercase+lowercase letters with U uppercase letters or less.
    // or, if there's more uppercase than lower (for e.g. PASSwORD), the number of ways to lowercase U+L letters with L lowercase letters or less.
    int uppercaseLength = 0;
    int lowercaseLength = 0;
    for (int i = 0; i < [word length]; i++) {
        unichar chr = [word characterAtIndex:i];
        if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:chr]) {
            uppercaseLength++;
        } else if ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:chr]) {
            lowercaseLength++;
        }
    }

    float possibilities = 0.0;
    for (int i = 0; i <= MIN(uppercaseLength, lowercaseLength); i++) {
        possibilities += binom(uppercaseLength + lowercaseLength, i);
    }
    return lg(possibilities);
}

- (int)extraL33tEntropy:(DBMatch *)match
{
    if (!match.l33t) {
        return 0;
    }

    int possibilities = 0;

    for (NSString *subbed in [match.sub allKeys]) {
        NSString *unsubbed = [match.sub objectForKey:subbed];
        NSUInteger subLength = [[match.token componentsSeparatedByString:subbed] count] - 1;
        NSUInteger unsubLength = [[match.token componentsSeparatedByString:unsubbed] count] - 1;
        for (int i = 0; i <= MIN(unsubLength, subLength); i++) {
            possibilities += binom(unsubLength + subLength, i);
        }
    }

    // corner: return 1 bit for single-letter subs, like 4pple -> apple, instead of 0.
    return possibilities <= 1 ? 1 : lg(possibilities);
}

@end
