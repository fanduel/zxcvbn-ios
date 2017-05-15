//
//  DBMatcher.h
//  Zxcvbn
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBMatcher : NSObject

@property (nonatomic, assign) NSUInteger keyboardAverageDegree;
@property (nonatomic, assign) NSUInteger keypadAverageDegree;
@property (nonatomic, assign) NSUInteger keyboardStartingPositions;
@property (nonatomic, assign) NSUInteger keypadStartingPositions;

- (NSArray *)omnimatch:(NSString *)password userInputs:(NSArray *)userInputs;

@end
