//
//  DS_CurrentSystemTool.h
//  WeChat
//
//  Created by wangyang on 16/5/15.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSUInteger,DS_CurrentSystemLanguage){
//    DS_CurrentSystemLanguageEn,
//    DS_CurrentSystemLanguageZh_Hans
//};

@interface DS_CurrentSystemTool : NSObject

+ (NSString *)currentSysTemLanguage;
+ (void)saveSetLanguage:(NSString *)language;
+ (NSString *)readCurrentAppLanguage;
+ (NSString *)currentSetLanguageKey;
+ (NSDictionary *)appAllLanguages;


@end

@interface DS_AppLoginState : NSObject

+ (BOOL)isLoginState;

@end