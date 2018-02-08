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

extern NSString *const StackOverflowManagerError;
typedef enum : NSInteger {
    StackOverflowManagerErrorUnknownCode = -1,
    StackOverflowManagerErrorQuestionsSearchCode
} StackOverflowManagerErrorCode;

@protocol StackOverflowManagerDelegate;

@interface StackOverflowManager : NSObject
@property (weak  , nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong, nonatomic) StackOverflowCommunicator *communicator;
@property (strong, nonatomic) QuestionBuilder *questionBuilder;

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)receivedQuestionJSON:(NSString *)JSONNotation;
@end


@protocol StackOverflowManagerDelegate <NSObject>
@required
- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceivedQuestions:(NSArray<Question *> *)questions;
@optional
@end
