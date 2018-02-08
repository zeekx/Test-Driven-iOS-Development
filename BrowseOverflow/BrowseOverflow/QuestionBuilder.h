//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Milo on 2018/2/6.
//  Copyright © 2018年 Tester. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;

@interface QuestionBuilder : NSObject
@property (copy , nonatomic) NSString *JSON;
@property (copy , nonatomic) NSArray<Question *> *arrayToReturn;
@property (copy , nonatomic) NSError *errroToSet;

-(NSArray<Question *> *)questionsFromJSON:(NSString *)JSONNotation error:(NSError * *)error;
@end
