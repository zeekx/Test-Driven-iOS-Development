//
//  QuestionTests.m
//  BrowseOverflowTests
//
//  Created by Milo on 2017/11/20.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "Answer.h"

@interface QuestionTests : XCTestCase
@property (strong, nonatomic) Question *question;
@property (strong, nonatomic) Answer *answer;
@property (strong, nonatomic) Answer *highScoreAnswer;
@property (strong, nonatomic) Answer *lowScoreAnswer;
@end

@implementation QuestionTests

- (void)setUp {
    [super setUp];
    self.question = [[Question alloc] init];
    self.question.date = [NSDate date];
    self.question.title = @"iPhone";
    self.question.score = 40;
    
    self.answer = [Answer new];
    self.answer.accepted = YES;
    self.answer.score = 1;
    [self.question addAnswer:self.answer];

    self.lowScoreAnswer = [Answer new];
    self.lowScoreAnswer.score = -1;
    [self.question addAnswer:self.lowScoreAnswer];

    
    self.highScoreAnswer = [Answer new];
    self.highScoreAnswer.score = 2;
    [self.question addAnswer:self.highScoreAnswer];

}

- (void)tearDown {
    self.question = nil;
    self.answer = nil;
    self.highScoreAnswer = nil;
    self.lowScoreAnswer = nil;
    [super tearDown];
}

- (void)testQuestionHasDate {
    XCTAssertTrue([self.question.date isKindOfClass:[NSDate class]],@".date should be a kind of NSDate.class");
}

- (void)testQuestionHasATitle {
    XCTAssertEqual(self.question.title, @"iPhone",@"Question should has a title:iPhone");
}

- (void)testQuestionHasAScore {
    XCTAssertEqual(self.question.score, 40, @"Question should has a score:40");
}

- (void)testQuestionCanHaveAnswerAdded {
    XCTAssertNoThrow([self.question addAnswer:[Answer new]], @"Must be able to add an answer");
}

- (void)testAcceptedAnswerIsFirst {
    XCTAssertTrue([self.question answers].firstObject.isAccepted, @"Accepted answer comes fist");
}

- (void)testHighScoreAnswerBeforeLow {
    NSInteger indexOfHighScoreAnswer = [self.question.answers indexOfObject:self.highScoreAnswer];
    NSInteger indexOfLowScoreAnswer = [self.question.answers indexOfObject:self.lowScoreAnswer];
    XCTAssertTrue(indexOfHighScoreAnswer < indexOfLowScoreAnswer, @"High-score answer before low-score answer");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
