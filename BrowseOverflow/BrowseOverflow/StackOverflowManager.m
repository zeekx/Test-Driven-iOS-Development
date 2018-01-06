//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Milo on 2018/1/2.
//  Copyright © 2018年 Tester. All rights reserved.
//

#import "StackOverflowManager.h"

@implementation StackOverflowManager
- (void)setDelegate:(id<StackOverflowManagerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate  object doesn't conform to the delegate protocol" userInfo: nil] raise];
    }
    _delegate = delegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic {
    [self.communicator searchForQuestionsWithTag:topic.tag];
}
@end
