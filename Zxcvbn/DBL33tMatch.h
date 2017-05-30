//
//  DBL33tMatch.h
//  Zxcvbn
//
//  Created by Steven King on 24/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBMatch.h"

@interface DBL33tSubstitution : NSObject

@property (nonatomic) NSString *substitutedCharacrer;
@property (nonatomic) NSString *originalCharacrer;
@property (assign) NSUInteger characterIndex;

@end

@interface DBL33tMatch : DBMatch

@property (nonatomic) NSArray<DBMatch *> *innerMatches;
@property (nonatomic) NSArray<DBL33tSubstitution *> *substitutions;
@end
