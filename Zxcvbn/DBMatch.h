//
//  DBMatch.h
//  Zxcvbn
//
//  Created by Steven King on 10/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBMatch : NSObject

@property (nonatomic, assign) NSString *pattern;
@property (strong, nonatomic) NSString *token;
@property (nonatomic, assign) NSUInteger i;
@property (nonatomic, assign) NSUInteger j;
@property (nonatomic, assign) float entropy;
@property (nonatomic, assign) int cardinality;

// Dictionary
@property (strong, nonatomic) NSString *matchedWord;
@property (strong, nonatomic) NSString *dictionaryName;
@property (nonatomic, assign) int rank;
@property (nonatomic, assign) float baseEntropy;
@property (nonatomic, assign) float upperCaseEntropy;

// l33t
@property (nonatomic, assign) BOOL l33t;
@property (strong, nonatomic) NSDictionary *sub;
@property (strong, nonatomic) NSString *subDisplay;
@property (nonatomic, assign) int l33tEntropy;

// Spatial
@property (strong, nonatomic) NSString *graph;
@property (nonatomic, assign) int turns;
@property (nonatomic, assign) int shiftedCount;

// Repeat
@property (strong, nonatomic) NSString *repeatedChar;

// Sequence
@property (strong, nonatomic) NSString *sequenceName;
@property (nonatomic, assign) int sequenceSpace;
@property (nonatomic, assign) BOOL ascending;

// Date
@property (nonatomic, assign) int day;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int year;
@property (strong, nonatomic) NSString *separator;

@end
