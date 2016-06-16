//
//  UIViewController+DSPushViewController.m
//  WeChat
//
//  Created by wangyang on 16/5/12.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "UIViewController+DSPushViewController.h"
#import "AppDelegate.h"
#import "DSTabBar.h"

@interface UIViewController ()
@end

@implementation UIViewController (DSPushViewController)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL swizzViewWillAppear = @selector(swizzViewWillAppear:);
        SEL viewWillAppear = @selector(viewWillAppear:);
        Method swizzViewWillAppearMethod = class_getInstanceMethod(self, swizzViewWillAppear);
        Method viewWillAppearMethod = class_getInstanceMethod(self, viewWillAppear);
        method_exchangeImplementations(swizzViewWillAppearMethod, viewWillAppearMethod);
    });
}

- (void)swizzViewWillAppear:(BOOL)animated
{
    [self swizzViewWillAppear:animated];
    if (self.navigationController.viewControllers.count>1) {
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)pushMyViewController:(UIViewController *)viewController animated:(BOOL)animated index:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self captureScreen]];
    AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
    UINavigationController *oldNav = tabBarController.viewControllers[tabBarController.selectedIndex];
    UINavigationController *nav = tabBarController.viewControllers[index];
    tabBarController.selectedIndex = index;
    UIViewController *rootViewController = [nav.viewControllers firstObject];
    imageView.frame = (CGRect){CGPointMake(0, -64),UISCREENSIZE};
    [rootViewController.view addSubview:imageView];
    imageView.tag = 1000;
    [oldNav popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:KSELECTEDITEMNOTI object:@(index)];
    [nav pushViewController:viewController animated:animated];
}

- (UIImage *)captureScreen
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
