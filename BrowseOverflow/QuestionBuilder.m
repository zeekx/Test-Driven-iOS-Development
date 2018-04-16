//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by Milo on 2018/2/6.
//  Copyright © 2018年 Tester. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import <JSONModel/JSONModel.h>

NSString *const QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";

@implementation QuestionBuilder
-(NSArray<Question *> *)questionsFromJSON:(nonnull NSString *)JSONNotation error:(NSError * *)error {
    NSParameterAssert(JSONNotation != nil);
    NSData *jsonData = [JSONNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&localError];
    if ([NSJSONSerialization isValidJSONObject:obj] && [obj isKindOfClass:NSDictionary.class]) {
        NSDictionary *dict = obj;
        NSArray *questions = [dict objectForKey:@"questions"];
        if (questions) {
            return questions;//[Question arrayOfDictionariesFromModels:[dict objectForKey:@"questions"]];
        } else {
            if (error != NULL) {
                *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderErrorCodeMissingData userInfo:nil];
            }
        }
    } else {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderErrorCodeInvalidJSON userInfo:nil];
        }
    }

    return nil;
}
@end
