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

@protocol StackOverflowManagerDelegate;

@interface StackOverflowManager : NSObject
@property (weak  , nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong, nonatomic) StackOverflowCommunicator *communicator;


- (void)fetchQuestionsOnTopic:(Topic *)topic;
@end


@protocol StackOverflowManagerDelegate <NSObject>
@optional
@end
