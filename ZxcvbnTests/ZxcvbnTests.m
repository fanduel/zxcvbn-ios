//
//  ZxcvbnTests.m
//  ZxcvbnTests
//
//  Created by Leah Culver on 2/9/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Zxcvbn.h"
#import "DBDictionaryMatch.h"

@interface ZxcvbnTests : XCTestCase

@end

@implementation ZxcvbnTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testScore0Password
{
    
    DBZxcvbn *zxcvbn = [[DBZxcvbn alloc] init];
    DBResult *result = [zxcvbn passwordStrength:@"password" userInputs:nil];
    
    XCTAssertTrue([@"dictionary" isEqualToString:[(DBDictionaryMatch *)result.matchSequence[0] pattern]]);
    XCTAssertTrue([@"passwords" isEqualToString:[(DBDictionaryMatch *)result.matchSequence[0] dictionaryName]]);
    
    XCTAssertEqual(result.score, 0);

}

- (void)testScore1Password
{
    
    DBZxcvbn *zxcvbn = [[DBZxcvbn alloc] init];
    DBResult *result = [zxcvbn passwordStrength:@"easy password2" userInputs:nil];
    
    XCTAssertEqual(result.score, 1);
    
}

- (void)testStrongPassword
{
    
    DBZxcvbn *zxcvbn = [[DBZxcvbn alloc] init];
    DBResult *result = [zxcvbn passwordStrength:@"dkgit dldig394595 &&(3" userInputs:nil];
    
    XCTAssertEqual(result.score, 4);
    
}

@end
