//
//  DBRepeatMatch.h
//  Zxcvbn
//
//  Created by Steven King on 11/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Zxcvbn/Zxcvbn.h>

@interface DBRepeatMatch : DBMatch

@property (strong, nonatomic) NSString *repeatedChar;

@end
