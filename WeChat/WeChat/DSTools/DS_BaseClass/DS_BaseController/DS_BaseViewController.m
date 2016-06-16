//
//  DS_BaseViewController.m
//  WeChat
//
//  Created by wangyang on 16/5/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_BaseViewController.h"

@interface DS_BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DS_BaseViewController

#pragma mark - life cricle
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (self.navigationController.viewControllers.count == 1) {
//        return NO;
//    } else {
//        return YES;
//    }
//}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
