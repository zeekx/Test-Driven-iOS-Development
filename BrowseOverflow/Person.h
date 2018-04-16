//
//  Person.h
//  BrowseOverflow
//
//  Created by Milo on 2017/11/20.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (copy  , nonatomic) NSString *name;
@property (copy  , nonatomic) NSURL *avatorURL;

- (instancetype)initWithName:(NSString *)name avatorURL:(NSURL *)stringOfURL;
@end
