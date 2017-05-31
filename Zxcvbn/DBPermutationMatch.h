//
//  DBPermutationMatch.h
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Zxcvbn/Zxcvbn.h>

@interface DBPermutationMatch : DBMatch

@property (nonatomic) NSArray<NSArray<DBMatch *> *> *fragmentMatches;

@end
