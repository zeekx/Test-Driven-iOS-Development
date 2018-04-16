//
//  Question.h
//  BrowseOverflow
//
//  Created by Milo on 2017/11/20.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@class Answer;

@interface Question : JSONModel
@property (strong, nonatomic) NSDate *date;
@property (copy  , nonatomic) NSString *title;
@property (assign, nonatomic) float score;
@property (copy  , nonatomic) NSString *question_timeline_url;
@property (copy  , nonatomic) NSString *question_comments_url;
@property (copy  , nonatomic) NSString *question_answers_url;
@property (copy  , nonatomic) NSString *body;
@property (assign, nonatomic) NSInteger identifier;

- (void)addAnswer:(Answer *)answer;
- (NSArray<Answer *> *)answers;
@end
