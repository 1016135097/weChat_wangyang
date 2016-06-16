//
//  DS_UserTool.h
//  WeChat
//
//  Created by wangyang on 16/5/30.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DS_UserModel;
@interface DS_UserTool : NSObject
+ (instancetype)shareInstance;
@property (nonatomic,strong,readonly)DS_UserModel *userModel;

/**
 * 修改头像
 */
+ (BOOL)modifyHeadICon:(NSString *)icon;

/**
 * 修改名字
 */
+ (BOOL)modifyUserName:(NSString *)userName;

/**
 * 修改地址
 */
+ (BOOL)modifyAddress:(NSString *)address;

/**
 * 修改性别
 */
+ (BOOL)modifySex:(NSString *)sex;

/**
 * 修改地区
 */
+ (BOOL)modifyArea:(NSString *)area;

/**
 * 修改签名
 */
+ (BOOL)modifySignature:(NSString *)signature;


@end
