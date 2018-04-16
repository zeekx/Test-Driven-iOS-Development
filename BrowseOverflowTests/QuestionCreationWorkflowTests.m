//
//  QuestionCreationTests.m
//  BrowseOverflowTests
//
//  Created by Milo on 2018/1/2.
//  Copyright © 2018年 Tester. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowManager.h"
#import "Topic.h"
#import "QuestionBuilder.h"

@interface MockQuestionBuilder: QuestionBuilder
@property(strong, nonatomic) Question *questionToFill;
@end
@implementation MockQuestionBuilder
-(NSArray<Question *> *)questionsFromJSON:(NSString *)JSONNotation error:(NSError * *)error {
    self.JSON = JSONNotation;
    *error = self.errroToSet;
    return self.arrayToReturn;
}
@end

@interface MockStackOverflowManagerDelegate : NSObject <StackOverflowManagerDelegate>
@property (strong, nonatomic) NSError *fetchError;
@property (strong, nonatomic) NSArray<Question *> *receivedQuestions;
- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceivedQuestions:(NSArray<Question *> *)questions;
@end

@implementation MockStackOverflowManagerDelegate

- (void)didReceivedQuestions:(NSArray<Question *> *)questions {
    self.receivedQuestions = questions;
}

- (void)fetchingQuestionsFailedWithError:(NSError *)error {
    self.fetchError = error;
}

@end

@interface MockStackOverflowCommunicator : StackOverflowCommunicator
@property (nonatomic, assign) BOOL wasAskedToFetchQuestions;
@property (nonatomic, assign) BOOL wasAskedToFetchQuestionBody;
@end


@implementation MockStackOverflowCommunicator
- (void)searchForQuestionsWithTag:(NSString *)tag {
    self.wasAskedToFetchQuestions = true;
}

- (void)searchForQuestionBodyWithQuestionID:(NSInteger)identifier {
    self.wasAskedToFetchQuestionBody = true;
}
@end



@interface QuestionCreationWorkflowTests : XCTestCase
@property (strong, nonatomic) StackOverflowManager *manager;
@property (strong, nonatomic) MockStackOverflowManagerDelegate *delegate;
@property (strong, nonatomic) NSError *underlyingError;
@property (strong, nonatomic) MockQuestionBuilder *questionBuilder;
@property (strong, nonatomic) NSArray<Question *> *questionArray;
@property (strong, nonatomic) Question *questionToFetch;
@property (strong, nonatomic) MockStackOverflowCommunicator *communicator;
@end


@implementation QuestionCreationWorkflowTests

- (void)setUp {
    [super setUp];
    self.manager = [StackOverflowManager new];
    self.delegate = [MockStackOverflowManagerDelegate new];
    self.questionBuilder = [MockQuestionBuilder new];
    self.manager.delegate = self.delegate;
    self.manager.questionBuilder = self.questionBuilder;
    self.underlyingError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorCodeQuestionsSearch userInfo:nil];
    
    self.questionToFetch = [Question new];
    self.questionToFetch.identifier = 1234;
    self.questionArray = [NSArray arrayWithObject:self.questionToFetch];
    self.communicator = [MockStackOverflowCommunicator new];
    self.manager.communicator = self.communicator;
}

- (void)tearDown {
    [super tearDown];
    self.underlyingError = nil;
    self.delegate = nil;
    self.manager = nil;
    self.communicator = nil;
}
- (void)testManagerPassedRetrievedQuestionBodyToQuestionBuilder {
    [self.manager receivedQuestionJSON:@"Fake"];
    XCTAssertEqual(self.manager.questionBuilder.JSON, @"Fake", @"Successfully-retrieved data should be passed to the builder");
}

- (void)testManagerPassesQuestionItWasSentToQuestionBuilderForFillingIn {
    [self.manager fetchBodyForQuestion:self.questionToFetch];
    [self.manager receivedQuestionJSON:@"Fake"];
    XCTAssertEqual(self.questionBuilder.questionToFill, self.questionToFetch, @"The question should have been passed to the builder");
}

- (void)testAskingForQuestionBodyMeansRequestingData {
    [self.manager fetchBodyForQuestion:self.questionToFetch];
    XCTAssertTrue([self.communicator wasAskedToFetchQuestionBody], @"The communicator should need to retrieve data for the question body");
}

- (void)testNonConformingObjectCannotBeDelegate {
    XCTAssertThrows(self.manager.delegate = (id<StackOverflowManagerDelegate>)[NSNull null], @"NSNull shoud not be used as the delegate as doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate {
    id<StackOverflowManagerDelegate> delegate = [MockStackOverflowManagerDelegate new];
    XCTAssertNoThrow(self.manager.delegate = delegate, @"Object conforming to the delegate protocol shoud be used as the delegate");
}

- (void)testManagerAcceptsNilAsDelegate {
    XCTAssertNoThrow(self.manager.delegate = nil, @"It should be acceptable to use nil as an object's delegate");
}

- (void)testAskingForQuestionMeansRequestingData {
    MockStackOverflowCommunicator *communicator = [MockStackOverflowCommunicator new];
    self.manager.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iPhone"];
    [self.manager fetchQuestionsOnTopic:topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator shoud need to fetch data");
}


- (void)testErrorReturnedToDelegateIsNotErrorNotifedByCommuniator {
    [self.manager searchingForQuestionsFailedWithError:self.underlyingError];
    XCTAssertFalse(self.underlyingError == [self.delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {
    [self.manager searchingForQuestionsFailedWithError:self.underlyingError];
    XCTAssertEqual(self.underlyingError, [[[self.delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"The underlying error should be available to client code.");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder {
    [self tellDelegateAboutQuestionSearchError:nil];
    XCTAssertEqual(self.manager.questionBuilder.JSON, @"Fake JSON", @"Downloaded JSON is sent to the builder");
    self.manager.questionBuilder = nil;
}

- (void)tellDelegateAboutQuestionSearchError:(NSError *)error {
    self.manager.questionBuilder.arrayToReturn = nil;
    self.manager.questionBuilder.errroToSet = error;
    NSString *const jsonString = @"Fake JSON";
    [self.manager receivedQuestionJSON:jsonString];
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails {
    [self tellDelegateAboutQuestionSearchError:self.underlyingError];
    XCTAssertNotNil([[[self.delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey],
                    @"The delegate should have found out about the error");
    self.manager.questionBuilder = nil;
}

- (void)testDelegateNotifiedOfFailureToFetchQuestion {
    [self.manager fetchQuestionBodyFailedWithError:self.underlyingError];
    XCTAssertNotNil([[[self.delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"Delegate shoud found out the error");
}


- (void)testDelegateNotToldAboutErrorWhenQuestionsReceived {
    self.questionBuilder.arrayToReturn = self.questionArray;
    [self.manager receivedQuestionJSON:@"Fake JSON"];
    XCTAssertNil([self.delegate fetchError], @"No error should be received on success");
}

- (void)testEmptyArrayIsPassedToDelegate {
    NSArray<Question *> *array = [NSArray array];
    self.manager.questionBuilder.arrayToReturn = array;
    [self.manager receivedQuestionJSON:@"Fake JSON"];
    XCTAssertEqual(array, [self.delegate receivedQuestions], @"Returning an empty array isn't an ERROR");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
