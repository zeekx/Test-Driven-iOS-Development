//
//  Answer.h
//  BrowseOverflow
//
//  Created by Milo on 2017/11/21.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Answer : NSObject
@property (strong, nonatomic) Person *person;
@property (assign, nonatomic) float score;
@property (assign, nonatomic, getter=isAccepted) BOOL accepted;
@property (copy  , nonatomic) NSString *text;

- (NSComparisonResult)compare:(Answer *)otherAnswer;
@end
