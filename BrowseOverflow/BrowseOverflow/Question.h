//
//  Question.h
//  BrowseOverflow
//
//  Created by Milo on 2017/11/20.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Answer;

@interface Question : NSObject
@property (strong, nonatomic) NSDate *date;
@property (copy  , nonatomic) NSString *title;
@property (assign, nonatomic) float score;

- (void)addAnswer:(Answer *)answer;
- (NSArray<Answer *> *)answers;
@end
