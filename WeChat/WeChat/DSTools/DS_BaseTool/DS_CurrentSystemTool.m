//
//  DS_CurrentSystemTool.m
//  WeChat
//
//  Created by wangyang on 16/5/15.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_CurrentSystemTool.h"

static NSString *const login = @"isFirstApp";
@implementation DS_CurrentSystemTool
+ (NSString *)currentSysTemLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
#if TARGET_IPHONE_SIMULATOR
    currentLanguage = [currentLanguage substringToIndex:currentLanguage.length - 3];
#else    
#endif
    return currentLanguage;
}

+ (void)saveSetLanguage:(NSString *)language
{
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:AppLanguage];
}

+ (NSString *)readCurrentAppLanguage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage];
}

+ (NSString *)currentSetLanguageKey
{
    NSString *currentLanguage = [DS_CurrentSystemTool readCurrentAppLanguage];
    NSDictionary *dict = [DS_CurrentSystemTool appAllLanguages];
    __block NSString *currentKey = @"";
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:currentLanguage]) {
            currentKey = key;
            *stop = YES;
        }
    }];
    return currentKey;
}

+ (NSDictionary *)appAllLanguages
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DSLocalizable.plist" ofType:nil];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

@end

@implementation DS_AppLoginState
+ (BOOL)isLoginState
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![[userDefaults objectForKey:login] isEqualToString:@"YES"]) {
        [userDefaults setObject:@"YES" forKey:login];
        [userDefaults synchronize];
        return YES;
    }
    return NO;
}

@end
