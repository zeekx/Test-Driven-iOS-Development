//
//  ViewController.m
//  Temperature
//
//  Created by Milo on 2017/11/8.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma TextField Delegate
// called when 'return' key pressed. return NO to

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.label.text = [self c2f:textField.text];
    return YES;
}

- (NSString *)c2f: (NSString *)cInString {
    double c = [cInString doubleValue];
    double f = c * (9.0/5.0) + 32.0;
    return [NSString stringWithFormat:@"%.2f", f];
}
@end
