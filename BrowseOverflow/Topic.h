//
//  Topic.h
//  BrowseOverflow
//
//  Created by Milo on 2017/11/16.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"


@interface Topic : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tag;

- (instancetype)initWithName:(NSString *)name tag:(NSString *)tag;

- (void)addQuestion:(Question *)question;
- (NSArray *)recentQuestions;
@end
