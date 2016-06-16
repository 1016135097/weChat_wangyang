//
//  UIImage+DSImage.m
//  WeChat
//
//  Created by wangyang on 16/6/2.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "UIImage+DSImage.h"

@implementation UIImage (DSImage)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
