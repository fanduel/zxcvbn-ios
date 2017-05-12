//
//  DBYearMatch.h
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Zxcvbn/Zxcvbn.h>

@interface DBDateMatch : DBMatch

@property (nonatomic, assign) int day;
@property (nonatomic, assign) int month;

@end
