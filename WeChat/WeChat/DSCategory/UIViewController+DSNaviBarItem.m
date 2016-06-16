//
//  UIViewController+DSNaviBarItem.m
//  WeChat
//
//  Created by wangyang on 16/5/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "UIViewController+DSNaviBarItem.h"
#import <objc/runtime.h>

@implementation UIViewController (DSNaviBarItem)
- (void)leftBarButtonItemWithTarget:(id)target
                             action:(SEL)selector
                              title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                    HightTitleColor:(UIColor *)hightTitleColor
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 80, 44);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = title;
    label.textColor = titleColor;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    UIBarButtonItem *negativeSpaceItem = [[UIBarButtonItem alloc]                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpaceItem.width = -6;
    self.navigationItem.leftBarButtonItems = @[negativeSpaceItem, leftItem];
}

- (void)rightBarButtonItemWithTarget:(id)target
                              action:(SEL)selector
                               title:(NSString *)title
                          titleColor:(UIColor *)titleColor
                     HightTitleColor:(UIColor *)hightTitleColor
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 80, 44);
    label.textAlignment = NSTextAlignmentRight;
    label.text = title;
    label.textColor = titleColor;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    UIBarButtonItem *negativeSpaceItem = [[UIBarButtonItem alloc]                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpaceItem.width = -6;
    self.navigationItem.rightBarButtonItems = @[negativeSpaceItem, rightItem];
}

- (void)leftBarButtonItemWithTarget:(id)target
                             action:(SEL)selector
                        normalImage:(NSString *)normalImgName
                     highLightImage:(NSString *)highLightImageName
{
}

- (void)rightButtonItemWithTarget:(id)target
                           action:(SEL)selector
                      normalImage:(NSString *)normalImgName
                   highLightImage:(NSString *)highLightImageName
{
}

@end

