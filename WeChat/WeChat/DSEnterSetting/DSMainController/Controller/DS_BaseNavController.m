//
//  DS_BaseNavController.m
//  WeChat
//
//  Created by wangyang on 16/5/12.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_BaseNavController.h"
#import "AppDelegate.h"
#import "DSTabBar.h"
#import "DSFindController.h"

@interface DS_BaseNavController ()

@end

@implementation DS_BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count > 1) {
            [[self.viewControllers firstObject].view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.tag == 1000) {
                    [obj removeFromSuperview];
                    obj = nil;
                    * stop = YES;
                }
            }];
    }
    return [super popViewControllerAnimated:animated];
}

@end
