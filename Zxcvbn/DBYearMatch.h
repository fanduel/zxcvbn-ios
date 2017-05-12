//
//  DBYearMatch.h
//  Zxcvbn
//
//  Created by Steven King on 12/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Zxcvbn/Zxcvbn.h>

@interface DBYearMatch : DBMatch

@property (nonatomic, assign) int year;
@property (strong, nonatomic) NSString *separator;

@end
