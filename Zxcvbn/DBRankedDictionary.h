//
//  DBRankedDictionary.h
//  Zxcvbn
//
//  Created by Steven King on 18/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBRankedDictionary : NSObject

@property (nonatomic, readonly, nonnull) NSString *name;

- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithName:(nonnull NSString *)name orderedWords:(nonnull NSArray<NSString *> *)words NS_DESIGNATED_INITIALIZER;

- (BOOL)containsWord:(nonnull NSString *)word;

- (NSUInteger)rankForWord:(nonnull NSString *)word;

@end
