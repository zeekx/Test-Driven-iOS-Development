//
//  StackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Milo on 2018/1/2.
//  Copyright © 2018年 Tester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject


- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)searchForQuestionBodyWithQuestionID:(NSInteger)identifier;
@end
