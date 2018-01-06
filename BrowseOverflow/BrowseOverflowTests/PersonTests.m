//
//  PersonTests.m
//  BrowseOverflowTests
//
//  Created by Milo on 2017/11/20.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase
@property (strong, nonatomic) Person *person;
@property (copy  , nonatomic) NSString *avatorURLString;
@property (copy  , nonatomic) NSURL *avatorURL;
@end

@implementation PersonTests

- (void)setUp {
    [super setUp];
    self.avatorURLString = @"http://source.test.com/avator.png";
    self.avatorURL = [NSURL URLWithString:self.avatorURLString];
    self.person = [[Person alloc] initWithName:@"Milo" avatorURL:self.avatorURL];
}

- (void)tearDown {
    self.person = nil;
    [super tearDown];
}

- (void)testPersonHasAName {
    XCTAssertEqual(self.person.name, @"Milo", @"Person should be named:Milo");
}

- (void)testPersonHasAnAvatorURL {
    XCTAssertEqual(self.person.avatorURL, self.avatorURL,@"Avator URL:%@",self.avatorURLString);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
