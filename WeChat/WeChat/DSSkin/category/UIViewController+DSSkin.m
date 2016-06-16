//
//  UIViewController+DSSkin.m
//  WeChat
//
//  Created by wangyang on 16/4/20.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "UIViewController+DSSkin.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation UIViewController (DSSkin)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL swizzViewDidLoad = @selector(swizzViewDidLoad);
        SEL viewDidLoad = @selector(viewDidLoad);
        Method swizzViewDidLoadMethod = class_getInstanceMethod(self, swizzViewDidLoad);
        Method viewDidLoadMethod = class_getInstanceMethod(self, viewDidLoad);
        method_exchangeImplementations(swizzViewDidLoadMethod, viewDidLoadMethod);
    });
}

- (void)swizzViewDidLoad
{
    [self swizzViewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.071 green:0.071 blue:0.071 alpha:1.000]];
    [[UINavigationBar appearance] setTranslucent:YES];
}
@end
