//
//  Answer.m
//  BrowseOverflow
//
//  Created by Milo on 2017/11/21.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import "Answer.h"

@implementation Answer
- (NSComparisonResult)compare:(Answer *)otherAnswer {
    if (self.accepted && !otherAnswer.accepted) {
        return NSOrderedAscending;
    } else if (!self.accepted && otherAnswer.accepted) {
        return NSOrderedDescending;
    }
    /*
    else if (!self.accepted && !otherAnswer.accepted) {
        return NSOrderedSame;
    }
    */
    
    if (self.score < otherAnswer.score) {
        return NSOrderedDescending;
    } else if (self.score > otherAnswer.score) {
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }
}
@end
