//
//  TopicTests.m
//  BrowseOverflowTests
//
//  Created by Milo on 2017/11/16.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"
#import "Question.h"


@interface TopicTests : XCTestCase
@property (nonatomic, strong) Topic *topic;
@end

@implementation TopicTests

- (void)setUp {
    [super setUp];
    self.topic = [[Topic alloc] initWithName:@"Tester" tag:@"t-tag"];
}

- (void)tearDown {
    self.topic = nil;
    [super tearDown];
}

- (void)testThatTopicExist {
    Topic *newTopic = [[Topic alloc] init];
    XCTAssertNotNil(newTopic);
}

- (void)testForInitiallyEmptyQuestionList {
    XCTAssertTrue(self.topic.recentQuestions.count == 0, @"No questions added yet, count should be ZERO");
}

- (void)testAddingAQuestionToList {
    Question *q = [[Question alloc] init];
    [self.topic addQuestion:q];
    XCTAssertTrue(self.topic.recentQuestions.count == 1, @"Top.question count should be 1");
}

- (void)testThatTopicCanBeNamed {
    XCTAssertEqual(self.topic.name, @"Tester",@"Topic.name should be Tester");
}

- (void)testThatTopicHasTag {
    XCTAssertEqual(self.topic.tag, @"t-tag");
}

- (void)testQuestionAreListedChronologically {
    Question *q1 = [[Question alloc] init];
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc] init];
    q2.date = [NSDate distantFuture];
    
    [self.topic addQuestion:q1];
    [self.topic addQuestion:q2];
    
    NSArray *questions = [self.topic recentQuestions];
    Question *listedFirst = questions.firstObject;
    Question *listedSecond = [questions objectAtIndex:1];
    
    XCTAssertTrue([listedFirst.date compare:listedSecond.date] != NSOrderedAscending, @"The later question should appear first in the list.");
}

- (void)testQuestionAreListedChronologically2 {
    Question *q1 = [[Question alloc] init];
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc] init];
    q2.date = [NSDate distantFuture];
    
    [self.topic addQuestion:q2];
    [self.topic addQuestion:q1];
    
    NSArray *questions = [self.topic recentQuestions];
    Question *listedFirst = questions.firstObject;
    Question *listedSecond = [questions objectAtIndex:1];
    
    XCTAssertTrue([listedFirst.date compare:listedSecond.date] != NSOrderedAscending, @"The later question should appear first in the list.");
}

- (void)testLimitOf20Questions {
    Question *q = [[Question alloc] init];
    for (NSUInteger index = 0; index < 25; index++) {
        [self.topic addQuestion:q];
    }
    XCTAssertTrue(self.topic.recentQuestions.count < 21,@"The number of topic should be less or equal 20");
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
