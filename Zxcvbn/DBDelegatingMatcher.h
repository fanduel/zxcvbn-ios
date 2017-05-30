//
//  DBDelegatingMatcher.h
//  Zxcvbn
//
//  Created by Steven King on 30/05/2017.
//  Copyright © 2017 Dropbox. All rights reserved.
//

#import <Zxcvbn/Zxcvbn.h>

#import "DBMatching.h"

@interface DBDelegatingMatcher : NSObject <DBMatching>

@end
