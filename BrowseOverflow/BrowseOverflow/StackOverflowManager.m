//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Milo on 2018/1/2.
//  Copyright © 2018年 Tester. All rights reserved.
//

#import "StackOverflowManager.h"
#import "QuestionBuilder.h"

NSString *const StackOverflowManagerError = @"StackOverflowManagerError";

@implementation StackOverflowManager
- (void)setDelegate:(id<StackOverflowManagerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object doesn't conform to the delegate protocol" userInfo: nil] raise];
    }
    _delegate = delegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic {
    [self.communicator searchForQuestionsWithTag:topic.tag];
}

- (void)searchingForQuestionsFailedWithError:(nonnull NSError  *)error {
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)tellDelegateAboutQuestionSearchError:(nonnull NSError *)error {
    NSDictionary *userInfo = nil;
    if (error) {
        userInfo = @{NSUnderlyingErrorKey: error};
    }
    NSError *reportError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorQuestionsSearchCode userInfo:userInfo];

    if ([self.delegate respondsToSelector:@selector(fetchingQuestionsFailedWithError:)]) {
        [self.delegate fetchingQuestionsFailedWithError:reportError];
    } else {
        assert(false);
    }
}


- (void)receivedQuestionJSON:(NSString *)JSONNotation {
    NSError *error = nil;
    NSArray<Question *> *questions = [self.questionBuilder questionsFromJSON:JSONNotation error:&error];
    if (questions == nil) {
        [self tellDelegateAboutQuestionSearchError:error];
    } else {
        if ([self.delegate respondsToSelector:@selector(didReceivedQuestions:)]) {
            [self.delegate didReceivedQuestions:questions];
        }
    }
}
@end
