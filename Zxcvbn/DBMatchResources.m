//
//  DBMatchResources.m
//  Zxcvbn
//
//  Created by Steven King on 10/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBMatchResources.h"

#import "DBResult.h"
#import "DBMatch.h"

@implementation DBMatchResources

+ (DBMatchResources *)sharedDBMatcherResources
{
    // singleton containing adjacency graphs and frequency graphs
    static DBMatchResources *sharedMatcher = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedMatcher = [[self alloc] init];
    });
    
    return sharedMatcher;
}

- (id)init
{
    self = [super init];
    
    if (self != nil) {
        _dictionaryMatchers = [self loadFrequencyLists];
        _graphs = [self loadAdjacencyGraphs];
    }
    
    return self;
}

- (NSArray *)loadFrequencyLists
{
    NSMutableArray *dictionaryMatchers = [[NSMutableArray alloc] init];
    
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"frequency_lists" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error == nil) {
        for (NSString *dictName in (NSDictionary *)json) {
            
            NSArray *wordList = [(NSDictionary *)json objectForKey:dictName];
            NSMutableDictionary *rankedDict = [self buildRankedDict:wordList];
            
            [dictionaryMatchers addObject:[self buildDictMatcher:dictName rankedDict:rankedDict]];
        }
    } else {
        NSLog(@"Error parsing frequency lists: %@", error);
    }
    
    return dictionaryMatchers;
}

- (NSDictionary *)loadAdjacencyGraphs
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"adjacency_graphs" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error == nil) {
        return (NSDictionary *)json;
    } else {
        NSLog(@"Error parsing adjacency graphs: %@", error);
    }
    
    return nil;
}


- (NSMutableDictionary<NSString *, NSNumber *> *)buildRankedDict:(NSArray *)unrankedList
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    int i = 1; // rank starts at 1, not 0
    
    for (NSString *word in unrankedList) {
        [result setObject:[NSNumber numberWithInt:i] forKey:word];
        i++;
    }
    
    return result;
}

- (MatcherBlock)buildDictMatcher:(NSString *)dictName rankedDict:(NSMutableDictionary *)rankedDict
{
    __typeof__(self) __weak weakSelf = self;
    MatcherBlock block = ^ NSArray* (NSString *password) {
        
        NSMutableArray *matches = [weakSelf dictionaryMatch:password rankedDict:rankedDict];
        
        for (DBMatch *match in matches) {
            match.dictionaryName = dictName;
        }
        
        return matches;
    };
    
    return block;
}

#pragma mark - dictionary match (common passwords, english, last names, etc)

- (NSMutableArray *)dictionaryMatch:(NSString *)password rankedDict:(NSMutableDictionary *)rankedDict
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSUInteger length = [password length];
    NSString *passwordLower = [password lowercaseString];
    
    for (int i = 0; i < length; i++) {
        for (int j = i; j < length; j++) {
            NSString *word = [passwordLower substringWithRange:NSMakeRange(i, j - i + 1)];
            NSNumber *rank = [rankedDict objectForKey:word];
            
            if (rank != nil) {
                DBMatch *match = [[DBMatch alloc] init];
                match.pattern = @"dictionary";
                match.i = i;
                match.j = j;
                match.token = [password substringWithRange:NSMakeRange(i, j - i + 1)];
                match.matchedWord = word;
                match.rank = [rank intValue];
                [result addObject:match];
            }
        }
    }
    
    return result;
}

@end
