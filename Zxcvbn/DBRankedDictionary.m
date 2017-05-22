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

@end

@implementation DBRankedDictionary

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

@end
