//
//  DBMatch.h
//  Zxcvbn
//
//  Created by Steven King on 10/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface DBMatch : NSObject

@property (nonatomic, assign) NSString *pattern;
@property (strong, nonatomic) NSString *token;
@property (nonatomic, assign) NSUInteger i;
@property (nonatomic, assign) NSUInteger j;
@property (nonatomic, assign) CGFloat entropy;
@property (nonatomic, assign) NSUInteger guesses;
@property (nonatomic, assign) CGFloat guessesLog10;
@property (nonatomic, assign) NSInteger cardinality;

@end
