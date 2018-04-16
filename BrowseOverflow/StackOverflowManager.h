//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Milo on 2018/1/2.
//  Copyright © 2018年 Tester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"
#import "Topic.h"
#import "QuestionBuilder.h"
#import "Question.h"

extern NSString *const StackOverflowManagerError;

typedef enum : NSInteger {
    StackOverflowManagerErrorCodeUnknown = -1,
    StackOverflowManagerErrorCodeQuestionsSearch,
    StackOverflowManagerErrorCodeQuestionsBody,
} StackOverflowManagerErrorCode;

@protocol StackOverflowManagerDelegate;

@interface StackOverflowManager : NSObject
@property (weak  , nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong, nonatomic) StackOverflowCommunicator *communicator;
@property (strong, nonatomic) QuestionBuilder *questionBuilder;

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)fetchQuestionBodyFailedWithError:(NSError *)error;
- (void)receivedQuestionJSON:(NSString *)JSONNotation;
@end


@protocol StackOverflowManagerDelegate <NSObject>
@required
- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceivedQuestions:(NSArray<Question *> *)questions;
@optional
@end
