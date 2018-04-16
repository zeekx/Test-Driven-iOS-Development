//
//  Topic.m
//  BrowseOverflow
//
//  Created by Milo on 2017/11/16.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import "Topic.h"

@interface Topic ()
@property (strong, nonatomic) NSMutableArray<Question *> *mutableArray;
@end

@implementation Topic
-(instancetype)initWithName:(NSString *)name {
    return [self initWithName:name tag:0];
}

-(instancetype)initWithName:(NSString *)name tag:(NSString *)tag {
    self = [super init];
    if (self) {
        self.name = name;
        self.tag = tag;
    }
    return self;
}

- (NSArray *)recentQuestions {
    return self.mutableArray;
}

- (NSArray<Question *> *)sortQuestionFromNewToOld:(NSArray<Question *> *)array {
    NSArray *sortArray = [array sortedArrayUsingComparator:^NSComparisonResult(Question *  _Nonnull obj1, Question *  _Nonnull obj2) {
        return [obj2.date compare:obj1.date];
    }];
    return sortArray;
}

- (void)addQuestion:(Question *)question {
    [self.mutableArray addObject:question];
    NSArray *array = [self sortQuestionFromNewToOld:self.mutableArray];
    if (array.count > 20) {
        array = [array subarrayWithRange:NSMakeRange(0, 20)];
    }
    self.mutableArray = [NSMutableArray arrayWithArray:array];
}

#pragma mark - Lazy
- (NSMutableArray<Question *> *)mutableArray {
    if (_mutableArray == nil) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}
@end
