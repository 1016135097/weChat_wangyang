//
//  UINavigationItem+DSNaviBarItem.h
//  WeChat
//
//  Created by wangyang on 16/5/21.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (DSNaviBarItem)

+ (UIBarButtonItem *)leftBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                           title:(NSString *)title
                                 nomalTitleColor:(UIColor *)nomalTitleColor;

+ (UIBarButtonItem *)leftBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                           title:(NSString *)title
                                 nomalTitleColor:(UIColor *)nomalTitleColor
                               unclickTitleColor:(UIColor *)unClickTitleColor;


+ (UIBarButtonItem *)leftBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                     normalImage:(NSString *)normalImgName
                                  highLightImage:(NSString *)highLightImageName;

+ (UIBarButtonItem *)rightBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                           title:(NSString *)title
                                 nomalTitleColor:(UIColor *)nomalTitleColor;

+ (UIBarButtonItem *)rightBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                           title:(NSString *)title
                                 nomalTitleColor:(UIColor *)nomalTitleColor
                               unclickTitleColor:(UIColor *)unClickTitleColor;


+ (UIBarButtonItem *)rightBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                     normalImage:(NSString *)normalImgName
                                  highLightImage:(NSString *)highLightImageName;

@end
