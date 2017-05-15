//
//  DBDictionaryMatch.h
//  Zxcvbn
//
//  Created by Steven King on 15/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Zxcvbn/Zxcvbn.h>

@interface DBDictionaryMatch : DBMatch

@property (strong, nonatomic) NSString *matchedWord;
@property (strong, nonatomic) NSString *dictionaryName;
@property (nonatomic, assign) BOOL reversed;
@property (nonatomic, assign) int rank;
@property (nonatomic, assign) float baseEntropy;
@property (nonatomic, assign) float upperCaseEntropy;
@property (nonatomic, assign) BOOL l33t;
@property (strong, nonatomic) NSDictionary *sub;
@property (strong, nonatomic) NSString *subDisplay;
@property (nonatomic, assign) int l33tEntropy;

@end
