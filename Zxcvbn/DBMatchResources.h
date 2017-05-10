//
//  DBMatchResources.h
//  Zxcvbn
//
//  Created by Steven King on 10/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSArray* (^MatcherBlock)(NSString *password);

@interface DBMatchResources : NSObject

@property (nonatomic, strong) NSArray<MatcherBlock> *dictionaryMatchers;
@property (nonatomic, strong) NSDictionary<NSString *, NSDictionary<NSString *, NSArray<NSString *> *> *> *graphs;

+ (DBMatchResources *)sharedDBMatcherResources;

@end
