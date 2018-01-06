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

@interface MockStackOverflowManagerDelegate : NSObject <StackOverflowManagerDelegate>
@end
@implementation MockStackOverflowManagerDelegate
@end

@interface MockStackOverflowCommunicator : StackOverflowCommunicator
@property (nonatomic, readonly) BOOL wasAskedToFetchQuestions;
@end
@interface MockStackOverflowCommunicator ()
@property (nonatomic, readwrite) BOOL wasAskedToFetchQuestions;
@end
@implementation MockStackOverflowCommunicator
- (void)searchForQuestionsWithTag:(NSString *)tag {
    self.wasAskedToFetchQuestions = true;
}

@end



@interface QuestionCreationTests : XCTestCase
@property (strong, nonatomic) StackOverflowManager *manager;
@end


@implementation QuestionCreationTests

- (void)setUp {
    [super setUp];
    self.manager = [StackOverflowManager new];
}

- (void)tearDown {
    [super tearDown];
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
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
