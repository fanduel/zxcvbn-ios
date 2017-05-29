//
//  DBSequenceMatch.h
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import "DBMatch.h"

@interface DBSequenceMatch : DBMatch

@property (strong, nonatomic) NSString *sequenceName;
@property (nonatomic, assign) NSUInteger sequenceSpace;
@property (nonatomic, assign) BOOL ascending;

@end
