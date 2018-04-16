//
//  QuestionBuilderTests.m
//  BrowseOverflowTests
//
//  Created by Milo on 2018/2/8.
//  Copyright © 2018年 Tester. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"

@interface QuestionBuilderTests : XCTestCase
@property (strong, nonatomic) QuestionBuilder *builder;
@property (copy  , nonatomic) NSString *json;
@property (strong, nonatomic) Question *question;
@end

@implementation QuestionBuilderTests

- (void)setUp {
    [super setUp];
    self.builder = [QuestionBuilder new];
    self.json = @"{\"total\":1,\"page\":1,\"pagesize\":30,\"questions\":[{\"tags\":[\"iphone\",\"security\",\"keychain\"],\"answer_count\":1,\"accepted_answer_id\":3231900,\"favorite_count\":1,\"question_timeline_url\":\"question/2817980/timeline\",\"question_comments_url\":\"question/2817980/comments\",\"question_answers_url\":\"question/2817980/answer\",\"question_id\":2817980,\"owner\":{\"user_id\":23743,\"user_type\":\"registered\",\"display_name\":\"Graham Lee\",\"reputation\":13459,\"email_hash\":\"56329sldjfsdf9dfkl\"},\"creation_date\":12342375,\"last_activty_date\":11434353,\"up_vote_count\":5,\"down_vote_count\":2,\"view_count\":465,\"score\":2,\"community_owned\":false,\"title\":\"Why does keychain Services return the wrong keychain content?\",\"body\":\"I've been trying to use persistent keychain interface references.\"}]}";
    self.question = [self.builder questionsFromJSON:self.json error:NULL].firstObject;
}

- (void)tearDown {
    self.builder = nil;
    [super tearDown];
}

- (void)testThatNilIsNotAnAcceptableParamet {
    XCTAssertThrows([self.builder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled eslewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON {
    XCTAssertNil([self.builder questionsFromJSON:@"" error:NULL], @"This parameter should not be parseable");
}

- (void)testErrorSetWhenStringIsNotJSON {
    NSError *e = nil;
    [self.builder questionsFromJSON:@"" error:&e];
    XCTAssertNotNil(e, @"An Error occured, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash {
    XCTAssertNoThrow([self.builder questionsFromJSON:@"" error:NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)testRealJSONWithoutQuestionArrayIsError {
    NSString *jsonString = @"{\"noquestions\":true}";
    XCTAssertNil([self.builder questionsFromJSON:jsonString error:NULL], @"No question to parse in this JSON");
}

- (void)testRealJSONWithoutQuestionReturnsMissingDataError {
    NSString *jsonString = @"{\"noquestions\":true}";
    NSError *error = nil;
    [self.builder questionsFromJSON:jsonString error:&error];
    XCTAssertEqual(error.code, QuestionBuilderErrorCodeMissingData, @"This case should not be an invalid JSON error");
}

- (void)testJSONWith1QuestionReturn1QuestionObject {
    NSError *error = nil;
    NSArray<Question *> *questions = [self.builder questionsFromJSON:self.json error:&error];
    XCTAssertTrue(questions.count == 1, @"The builder should have created a question");
}

- (void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON {
}

- (void)testQuestionCreatedFromEmptyObjectIsStillValidObject {
    NSString *empty = @"{\"questions\":[{}]}";
    NSArray *questions = [self.builder questionsFromJSON:empty error:NULL];
    XCTAssertTrue(questions.count == 1, @"QuestionBuilder must handle partial input");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
