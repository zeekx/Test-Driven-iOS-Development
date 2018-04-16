//
//  AnswerTests.m
//  BrowseOverflowTests
//
//  Created by Milo on 2017/11/21.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Answer.h"
#import "Person.h"

@interface AnswerTests : XCTestCase
@property (strong, nonatomic) Answer *answer;
@property (strong, nonatomic) Answer *otherAnswer;
@property (copy  , nonatomic) NSString *txt;
@property (copy  , nonatomic) NSString *str;
@property (copy  , nonatomic) NSString *answerName;
@property (assign, nonatomic) float score;
@end

@implementation AnswerTests

- (void)setUp {
    [super setUp];
    self.answer = [[Answer alloc] init];
    self.txt = @"From test.com";
    self.answerName = @"Milo";
    self.str = @"source.test.com/x.png";
    self.score = 42;
    
    self.answer.text = self.txt;
    NSURL *url = [NSURL URLWithString:self.str];
    self.answer.person = [[Person alloc] initWithName:@"Milo" avatorURL:url];
    self.answer.score = 42;
    
    self.otherAnswer = [[Answer alloc] init];
    self.otherAnswer.score = 43;
}

- (void)tearDown {
    self.answer = nil;
    self.otherAnswer = nil;
    [super tearDown];
}

- (void)testAnswerHasSomeText {
    XCTAssertEqual(self.answer.text, self.txt, @"Answer text needs contains some text");
}

- (void)testSomeoneProvideTheAnswer {
    XCTAssertTrue([self.answer.person isKindOfClass:[Person class]]);
}

- (void)testAnswerNotAcceptedByDefault {
    XCTAssertFalse(self.answer.accepted, @"Answer not accepted by default");
}

- (void)testAnswerCanBeAccepted {
    self.answer.accepted = YES;
    XCTAssertNoThrow(self.answer.accepted, @"It's possible to accept an answer");
}

- (void)testAnswerHasScore {
    XCTAssertEqual(self.answer.score, self.score, @"Needs contain a score");
}

- (void)testAcceptAnswerComesBeforeUnaccepted {
    
    self.otherAnswer.score = self.answer.score + 10;
    
    self.answer.accepted = YES;
    self.otherAnswer.accepted = NO;
    
    XCTAssertEqual([self.answer compare:self.otherAnswer], NSOrderedAscending, @"Accepted answer should be first");
    XCTAssertEqual([self.otherAnswer compare:self.answer], NSOrderedDescending, @"Unaccepted answer should be last");
}

- (void)testAnswerWithEqualScoreCompareEqually {
    self.answer.accepted = self.otherAnswer.accepted = YES;
    self.otherAnswer.score = self.answer.score;

    XCTAssertEqual([self.answer compare:self.otherAnswer], NSOrderedSame, @"Both answers of equal rank");
    
    XCTAssertEqual([self.otherAnswer compare:self.answer], NSOrderedSame, @"Both answers of equal rank");
}

- (void)testAnswerWithEqualScoreAndUnAcceptedToCompareEqually {
    self.answer.accepted = self.otherAnswer.accepted = NO;
    self.otherAnswer.score = self.answer.score;
    
    XCTAssertEqual([self.answer compare:self.otherAnswer], NSOrderedSame, @"Both answers of equal rank");
    
    XCTAssertEqual([self.otherAnswer compare:self.answer], NSOrderedSame, @"Both answers of equal rank");
}

- (void)testUnAcceptedHighScoreAnswerBeforeUnAcceptedLowScoreAnswer {
    self.answer.accepted = self.otherAnswer.accepted = NO;
    self.otherAnswer.score = self.answer.score + 10;
    
    XCTAssertEqual([self.answer compare:self.otherAnswer], NSOrderedDescending, @"Low-score unaccepted answer comes last");
    
    XCTAssertEqual([self.otherAnswer compare:self.answer], NSOrderedAscending, @"High-score unaccepted answer comes first");
}


- (void)testLowerScoringComeAfterHigher {
    self.answer.accepted = self.otherAnswer.accepted = YES;
    self.otherAnswer.score = self.answer.score + 10;
    
    XCTAssertEqual([self.answer compare:self.otherAnswer], NSOrderedDescending, @"Higher score comes fisrt");
    
    XCTAssertEqual([self.otherAnswer compare:self.answer], NSOrderedAscending, @"Lower score comes last");
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
