//
//  Person.m
//  BrowseOverflow
//
//  Created by Milo on 2017/11/20.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithName:(NSString *)name avatorURL:(NSURL *)stringOfURL {
    self = [super init];
    if (self) {
        self.name = name;
        self.avatorURL = stringOfURL;
    }
    return self;
}
@end
