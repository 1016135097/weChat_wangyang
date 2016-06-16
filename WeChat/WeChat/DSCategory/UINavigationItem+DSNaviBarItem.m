//
//  UINavigationItem+DSNaviBarItem.m
//  WeChat
//
//  Created by wangyang on 16/5/21.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "UINavigationItem+DSNaviBarItem.h"

@implementation UINavigationItem (DSNaviBarItem)
+ (UIBarButtonItem *)leftBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                           title:(NSString *)title
                                 nomalTitleColor:(UIColor *)nomalTitleColor
{
   return [UINavigationItem leftBarButtonItemWithTarget:target action:selector title:title nomalTitleColor:nomalTitleColor unclickTitleColor:nil];
}

+ (UIBarButtonItem *)leftBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                           title:(NSString *)title
                                 nomalTitleColor:(UIColor *)nomalTitleColor
                               unclickTitleColor:(UIColor *)unClickTitleColor
{
    NSAssert((!unClickTitleColor && nomalTitleColor)||(unClickTitleColor && !nomalTitleColor), @"nomalTitleColor and unClickTitleColor al");
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 80, 44);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = DS_CustomLocalizedString(title,nil);
    if (nomalTitleColor) {
        label.textColor = nomalTitleColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
        [label addGestureRecognizer:tap];
    }else{
        label.textColor = unClickTitleColor;
    }
    label.userInteractionEnabled = YES;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    return leftItem;
}

+ (UIBarButtonItem *)leftBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                     normalImage:(NSString *)normalImgName
                                  highLightImage:(NSString *)highLightImageName
{
    if (!normalImgName && !highLightImageName) {
        return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:target action:selector];
    }
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = CGRectMake(0, 0, 22, 44);
    img.image = [UIImage imageNamed:normalImgName];
    img.highlightedImage = [UIImage imageNamed:highLightImageName];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [img addGestureRecognizer:tap];
    img.userInteractionEnabled = YES;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:img];
    return leftItem;
}

+ (UIBarButtonItem *)rightBarButtonItemWithTarget:(id)target
                                           action:(SEL)selector
                                            title:(NSString *)title
                                  nomalTitleColor:(UIColor *)nomalTitleColor
{
    return [UINavigationItem rightBarButtonItemWithTarget:target action:selector title:title nomalTitleColor:nomalTitleColor unclickTitleColor:nil];
}

+ (UIBarButtonItem *)rightBarButtonItemWithTarget:(id)target
                                           action:(SEL)selector
                                            title:(NSString *)title
                                  nomalTitleColor:(UIColor *)nomalTitleColor
                                unclickTitleColor:(UIColor *)unClickTitleColor
{
    UILabel *rightlabel = [[UILabel alloc] init];
    rightlabel.textColor = UIColorFromRGB(0x3f6847);
    rightlabel.frame = CGRectMake(0, 0, 80, 44);
    rightlabel.textAlignment = NSTextAlignmentRight;
    rightlabel.text = DS_CustomLocalizedString(title,nil);
    rightlabel.userInteractionEnabled = YES;
    if (nomalTitleColor) {
        UITapGestureRecognizer *righttap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
        [rightlabel addGestureRecognizer:righttap];
        rightlabel.textColor = nomalTitleColor;
    }else {
        rightlabel.textColor = unClickTitleColor;
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightlabel];
    return rightItem;
}


+ (UIBarButtonItem *)rightBarButtonItemWithTarget:(id)target
                                           action:(SEL)selector
                                      normalImage:(NSString *)normalImgName
                                   highLightImage:(NSString *)highLightImageName
{
    if (!normalImgName && !highLightImageName) {
        return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:target action:selector];
    }
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = CGRectMake(0, 0, 22, 44);
    img.image = [UIImage imageNamed:normalImgName];
    img.highlightedImage = [UIImage imageNamed:highLightImageName];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [img addGestureRecognizer:tap];
    img.userInteractionEnabled = YES;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:img];
    return leftItem;
}
@end
