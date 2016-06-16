//
//  DSGlobal.h
//  WeChat
//
//  Created by wangyang on 15/11/3.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#ifndef DSGlobal_h
#define DSGlobal_h


#endif /* DSGlobal_h */
#import "DS_mainHeader.h"

//current device screen size、width and height
#define UISCREENSIZE [UIScreen mainScreen].bounds.size
#define UISCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREENHEIGHT [UIScreen mainScreen].bounds.size.height

//color set
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//debug:print log ,release:not print log
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

//expiration reminder
#define DS_DEPRECATED(instead) NS_DEPRECATED(2_0,2_0,2_0,2_0,instead)

//block self define
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf)__strong strongSelf = weakSelf;

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define DSTEXTFONT(float) [UIFont systemFontOfSize:float]

// set app Language
#define AppLanguage @"appLanguage"
#define DS_CustomLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]




