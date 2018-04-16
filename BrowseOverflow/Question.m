//
//  Question.m
//  BrowseOverflow
//
//  Created by Milo on 2017/11/20.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import "Question.h"
#import "Answer.h"
//#import <JSONModel/JSONModel.h>

@interface Question()
//@property (strong, nonatomic) NSObject *obj;
@property (strong, nonatomic) NSMutableSet<Answer *> *answer;
@end

@implementation Question

- (instancetype)init {
    self = [super init];
    if (self) {
        self.answer = [NSMutableSet set];
//        self.obj = [JSONModel new];
    }
    return self;
}
- (void)addAnswer:(nonnull Answer *)answer {
    [self.answer addObject:answer];
}

- (NSArray<Answer *> *)answers {
    return [[self.answer allObjects] sortedArrayUsingSelector:@selector(compare:)];
}
@end
