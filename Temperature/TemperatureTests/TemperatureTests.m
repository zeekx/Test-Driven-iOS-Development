//
//  TemperatureTests.m
//  TemperatureTests
//
//  Created by Milo on 2017/11/8.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface TemperatureTests : XCTestCase

@property (nonatomic, strong) ViewController *vc;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
@end

@implementation TemperatureTests

- (void)setUp {
    [super setUp];
    ViewController *vc = [[ViewController alloc] init]; //Lazy nib 文件
    vc.textField = [[UITextField alloc] init];
    vc.label = [[UILabel alloc] init];
    self.vc = vc;
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

#if false
- (void)testThatMinus40CelsiusIsMinus40Fahrenheit {
    self.textField.text = @"-40";
    XCTAssertEqual([[self.vc c2f:self.textField.text] doubleValue],-40.0);}

- (void)testThatMinus100CelsiusIsMinus212Fahrenheit {
    self.textField.text = @"100";
    XCTAssertEqual([[self.vc c2f:self.textField.text] doubleValue], 212.0);
}
#else
- (void)testThatMinus40CelsiusIsMinus40Fahrenheit {
    self.vc.textField.text = @"-40";
    [self.vc textFieldShouldReturn:self.vc.textField];
    XCTAssertEqual([self.vc.label.text doubleValue],-40.0);
    
}

- (void)testThatMinus100CelsiusIsMinus212Fahrenheit {
    self.vc.textField.text = @"100";
    [self.vc textFieldShouldReturn:self.vc.textField];
    XCTAssertEqual([self.vc.label.text doubleValue],212);
}
#endif

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
