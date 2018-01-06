//
//  ViewController.h
//  Temperature
//
//  Created by Milo on 2017/11/8.
//  Copyright © 2017年 Tester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UILabel *label;

//- (NSString *)c2f: (NSString *)cInString;
@end

