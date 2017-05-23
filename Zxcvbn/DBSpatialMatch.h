//
//  DBSpatialMatch.h
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Zxcvbn/Zxcvbn.h>

@interface DBSpatialMatch : DBMatch

@property (strong, nonatomic) NSString *graph;
@property (nonatomic, assign) NSUInteger turns;
@property (nonatomic, assign) int shiftedCount;

@end
