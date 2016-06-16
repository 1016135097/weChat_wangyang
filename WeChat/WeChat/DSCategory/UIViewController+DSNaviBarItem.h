//
//  UIViewController+DSNaviBarItem.h
//  WeChat
//
//  Created by wangyang on 16/5/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DSNaviBarItem)

- (void)leftBarButtonItemWithTarget:(id)target
                             action:(SEL)selector
                              title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                    HightTitleColor:(UIColor *)hightTitleColor;

- (void)rightBarButtonItemWithTarget:(id)target
                              action:(SEL)selector
                               title:(NSString *)title
                          titleColor:(UIColor *)titleColor
                     HightTitleColor:(UIColor *)hightTitleColor;

- (void)leftBarButtonItemWithTarget:(id)target
                             action:(SEL)selector
                        normalImage:(NSString *)normalImgName
                     highLightImage:(NSString *)highLightImageName;

- (void)rightButtonItemWithTarget:(id)target
                           action:(SEL)selector
                      normalImage:(NSString *)normalImgName
                   highLightImage:(NSString *)highLightImageName;
@end
