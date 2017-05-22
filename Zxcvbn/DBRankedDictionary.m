//
//  DBRankedDictionary.m
//  Zxcvbn
//
//  Created by Steven King on 18/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBRankedDictionary.h"

@interface DBRankedDictionary ()

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic) NSArray<NSString *> *words;

@end

@implementation DBRankedDictionary

- (instancetype)initWithName:(NSString *)name orderedWords:(NSArray<NSString *> *)words {
    if (self = [super init]) {
        self.name = name;
        self.words = words;
    }
    return self;
}

- (BOOL)containsWord:(NSString *)word {
    return [self.words containsObject:word];
}

@end
