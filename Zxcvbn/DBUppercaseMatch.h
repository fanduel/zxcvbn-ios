//
//  DBUppercaseMatch.h
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBMatch.h"

@interface DBUppercaseMatch : DBMatch

@property (nonatomic) NSArray<DBMatch *> *innerMatches;

@end
